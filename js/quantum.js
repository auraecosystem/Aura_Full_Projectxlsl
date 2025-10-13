// js/quantum.js
// Simple qubit math using small complex objects {re,im}
// Exports: H, X, Z, qubitZero, qubitOne, applyGate, measure, stateInfo

function complex(re, im=0){ return {re: re, im: im}; }
function add(a,b){ return {re: a.re + b.re, im: a.im + b.im}; }
function mul(a,b){ return { re: a.re*b.re - a.im*b.im, im: a.re*b.im + a.im*b.re }; }
function scale(a, k){ return { re: a.re*k, im: a.im*k }; }
function conj(a){ return { re: a.re, im: -a.im }; }
function mag2(a){ return a.re*a.re + a.im*a.im; }

const invSqrt2 = 1/Math.sqrt(2);

// gates as 2x2 matrices of complex numbers
export const H = [
  [complex(invSqrt2), complex(invSqrt2)],
  [complex(invSqrt2), complex(-invSqrt2)]
];
export const X = [
  [complex(0), complex(1)],
  [complex(1), complex(0)]
];
export const Z = [
  [complex(1), complex(0)],
  [complex(0), complex(-1)]
];

export function qubitZero(){ return [complex(1), complex(0)]; }
export function qubitOne(){ return [complex(0), complex(1)]; }

export function applyGate(gate, qubit) {
  const a = add(mul(gate[0][0], qubit[0]), mul(gate[0][1], qubit[1]));
  const b = add(mul(gate[1][0], qubit[0]), mul(gate[1][1], qubit[1]));
  // normalize just in case
  const total = Math.sqrt(mag2(a) + mag2(b)) || 1;
  return [scale(a, 1/total), scale(b, 1/total)];
}

export function measure(qubit) {
  const p0 = mag2(qubit[0]);
  const rnd = Math.random();
  return (rnd < p0) ? 0 : 1;
}

export function stateInfo(qubit) {
  const p0 = mag2(qubit[0]), p1 = mag2(qubit[1]);
  const a0 = `${qubit[0].re.toFixed(3)}${qubit[0].im ? ('+'+qubit[0].im.toFixed(3)+'i') : ''}`;
  const a1 = `${qubit[1].re.toFixed(3)}${qubit[1].im ? ('+'+qubit[1].im.toFixed(3)+'i') : ''}`;
  return {
    p0, p1,
    text: `|0>: ${a0} (p=${(p0*100).toFixed(1)}%), |1>: ${a1} (p=${(p1*100).toFixed(1)}%)`
  };
}
