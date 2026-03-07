import torch
import torch.nn as nn

class BoothMultiplyLayer(nn.Module):
    def __init__(self, bits=8):
        super(BoothMultiplyLayer, self).__init__()
        self.bits = bits
        self.mask = (1 << bits) - 1

    def booth_op(self, m, q):
        # Hardware simulation logic
        a = torch.zeros_like(m)
        q_prev = torch.zeros_like(m)
        
        for _ in range(self.bits):
            last_bit_q = q & 1
            
            # Decision Logic
            sub_mask = (last_bit_q == 1) & (q_prev == 0)
            add_mask = (last_bit_q == 0) & (q_prev == 1)
            
            a[sub_mask] = (a[sub_mask] - m[sub_mask]) & self.mask
            a[add_mask] = (a[add_mask] + m[add_mask]) & self.mask
            
            # Arithmetic Right Shift
            q_prev = q & 1
            q = (q >> 1) | ((a & 1) << (self.bits - 1))
            a = (a >> 1) | (a & (1 << (self.bits - 1))) # Preserve sign bit
            
        result = (a << self.bits) | q
        # Convert back to signed integer
        is_negative = (result & (1 << (2 * self.bits - 1))) != 0
        result[is_negative] -= (1 << (2 * self.bits))
        return result

    def forward(self, input_tensor, weight_tensor):
        # Convert inputs to integers for the algorithm
        m = input_tensor.to(torch.int32)
        q = weight_tensor.to(torch.int32)
        return self.booth_op(m, q)
