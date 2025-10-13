// js/visualizer.js
// Exports: Visualizer.drawQuantum(state, canvasId)
export const Visualizer = {
  drawQuantum(state, canvasId) {
    const canvas = (typeof canvasId === 'string') ? document.getElementById(canvasId) : canvasId;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    const w = canvas.width = canvas.clientWidth * devicePixelRatio;
    const h = canvas.height = canvas.clientHeight * devicePixelRatio;
    ctx.clearRect(0,0,w,h);

    // get numeric probabilities (state is complex pair)
    const p0 = (state[0].re*state[0].re + state[0].im*state[0].im);
    const p1 = (state[1].re*state[1].re + state[1].im*state[1].im);

    // draw probabilities as bars
    const margin = 24 * devicePixelRatio;
    const barW = (w - margin*2);
    const barH = 28 * devicePixelRatio;
    ctx.fillStyle = 'rgba(255,255,255,0.06)';
    ctx.fillRect(margin, margin, barW, barH);
    ctx.fillStyle = 'rgba(123,211,137,0.95)';
    ctx.fillRect(margin, margin, barW * p0, barH);
    ctx.fillStyle = 'rgba(97,160,255,0.95)';
    ctx.fillRect(margin, margin + barH + (8*devicePixelRatio), barW * p1, barH);

    ctx.fillStyle = 'rgba(255,255,255,0.8)';
    ctx.font = `${12 * devicePixelRatio}px sans-serif`;
    ctx.fillText(`|0> ${(p0*100).toFixed(1)}%`, margin + 6*devicePixelRatio, margin + 18*devicePixelRatio);
    ctx.fillText(`|1> ${(p1*100).toFixed(1)}%`, margin + 6*devicePixelRatio, margin + barH + (8*devicePixelRatio) + 18*devicePixelRatio);

    // draw a simple Bloch-like circle (project only real parts for simplicity)
    const cx = w/2, cy = h - (80 * devicePixelRatio);
    const radius = Math.min(w, h) * 0.12;
    ctx.beginPath();
    ctx.arc(cx, cy, radius, 0, Math.PI*2);
    ctx.fillStyle = 'rgba(255,255,255,0.02)';
    ctx.fill();
    ctx.lineWidth = 1 * devicePixelRatio;
    ctx.strokeStyle = 'rgba(255,255,255,0.06)';
    ctx.stroke();

    // compute a vector from amplitudes (project to 2D)
    // use real parts as x,y
    const x = state[0].re - state[1].re;
    const y = state[0].im - state[1].im;
    const len = Math.sqrt(x*x + y*y) || 1;
    const vx = cx + (x/len) * radius;
    const vy = cy + (y/len) * radius;

    // draw vector
    ctx.beginPath();
    ctx.moveTo(cx, cy);
    ctx.lineTo(vx, vy);
    ctx.strokeStyle = 'rgba(123,211,137,0.95)';
    ctx.lineWidth = 2 * devicePixelRatio;
    ctx.stroke();

    // draw arrow head
    ctx.beginPath();
    ctx.arc(vx, vy, 4*devicePixelRatio, 0, Math.PI*2);
    ctx.fillStyle = 'rgba(123,211,137,0.95)';
    ctx.fill();
  }
};
