import torch
import torch.nn as nn

class AWDLSTMModel(nn.Module):
    def __init__(self, vocab_size, emb_dim, hidden_dim, n_layers):
        super().__init__()
        self.embedding = nn.Embedding(vocab_size, emb_dim)
        # num_layers stacks multiple LSTMs automatically
        self.lstm = nn.LSTM(emb_dim, hidden_dim, num_layers=n_layers)
        self.linear = nn.Linear(hidden_dim, vocab_size)

    def forward(self, x, hidden=None):
        # x shape: (seq_len, batch)
        emb = self.embedding(x)
        
        # 'output' contains the hidden state h_t for EVERY timestep 
        # but only for the LAST layer in the stack.
        # 'h_n' contains the LAST timestep hidden state for EVERY layer.
        output, (h_n, c_n) = self.lstm(emb, hidden)
        
        # We return 'output' because AR and TAR require the full 
        # sequence of hidden states from the final layer.
        decoded = self.linear(output)
        return decoded, output, (h_n, c_n)

# Example usage:
# model_output, final_layer_h_seq, _ = model(input_data)
# loss = awd_loss(model_output, targets, final_layer_h_seq)
