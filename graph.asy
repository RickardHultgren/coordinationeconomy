// Coordination System Physics Model — Option A (rigorous):
// X = L, Y = C, Z = R
// Derived quantities are encoded visually (no axis bending):
//   A = L*C  (shown as point on LC-plane)
//   F = A/R  (line thickness + arrow size)
//   H = F^2*R = A^2/R (color intensity)
// Compile (headless-safe):  asy -f pdf -render=0 coordination_model.asy

settings.tex="none";

import three;

size(16cm);
currentprojection = perspective(7,6,4);
currentlight = light(gray(0.45), background=rgb(0.05,0.05,0.06));

// ---------- STYLE ----------
real S = 5;

pen glasspen   = rgb(0.70,0.80,0.90) + opacity(0.10);
pen edgepen    = rgb(0.80,0.85,0.90) + opacity(0.18) + linewidth(0.8);

pen axisGreen = rgb(0.25,1.00,0.25) + linewidth(4.8);
pen axisYellow = rgb(1.00,0.75,0.25) + linewidth(1.6);
pen axisCyan   = rgb(0.00,0.90,0.90) + linewidth(1.6);

pen noteCyan   = rgb(0.00,0.90,0.90);
pen noteAmber  = rgb(1.00,0.55,0.12);
pen noteRed    = rgb(0.90,0.10,0.10);

pen sparkY     = rgb(1.00,0.75,0.25) + linewidth(6);
pen sparkO     = rgb(1.00,0.55,0.12) + linewidth(7);
pen raypen     = rgb(1.00,0.90,0.20) + opacity(0.35) + linewidth(1.0);

void lab(string s, triple p, triple off=(0,0,0), pen pe=currentpen){
  label(s, p+off, pe);
}

real clamp01(real x){ return max(0,min(1,x)); }

// ---------- GLASS WALLS ----------
surface XY = surface((0,0,0)--(S,0,0)--(S,S,0)--(0,S,0)--cycle);
surface XZ = surface((0,0,0)--(S,0,0)--(S,0,S)--(0,0,S)--cycle);
surface YZ = surface((0,0,0)--(0,S,0)--(0,S,S)--(0,0,S)--cycle);

draw(XY, glasspen); draw(XZ, glasspen); draw(YZ, glasspen);

draw((0,0,0)--(S,0,0)--(S,S,0)--(0,S,0)--cycle, edgepen);
draw((0,0,0)--(S,0,0)--(S,0,S)--(0,0,S)--cycle, edgepen);
draw((0,0,0)--(0,S,0)--(0,S,S)--(0,0,S)--cycle, edgepen);

// ---------- AXES ----------
draw((0,0,0)--(S,0,0), axisYellow); // L
draw((0,0,0)--(0,S,0), axisYellow); // C
draw((0,0,0)--(0,0,S), axisCyan);   // R

lab("Expectancy (L)", (0.11*S,-1,0), (0.55,0.00,0.00), axisGreen);
lab("Expectancy (C)", (-1,0.11*S,0), (0.00,0.55,0.00), axisGreen);

lab("Legitimacy (L)", (0.45*S,-1,0), (0.55,0.00,0.00), axisYellow);
lab("Capability (C)", (-1,0.33*S,0), (0.00,0.55,0.00), axisYellow);
lab("Resistance of Complexity (R)", (0,0,S), (0.00,0.00,0.70), axisCyan);

lab("Insignificance", (4,-0.5,0), (0.00,-0.35,0.00), noteCyan);
lab("Risk", (0,4.2,0), (-0.60,0.00,0.00), noteCyan);


// ---------- EXAMPLE VALUES ----------
real L = 4.0;
real C = 3.0;
real A_val = L*C; // A = 12

triple Lspark = (L,0,0);
triple Cspark = (0,C,0);

dot(Lspark, sparkY);
dot(Cspark, sparkY);
lab("L=4", Lspark, (0.00,0.35,0.00), axisYellow);
lab("C=3", Cspark, (0.35,0.00,0.00), axisYellow);




// --- Expectancey X ---
triple Xmiddle = (0.33*S,0,0);

draw((0,0,0)--Xmiddle, raypen);

// end part: cyan
pen rayCyan = axisCyan + opacity(1) + linewidth(1.4);
draw((0,0,0)--Xmiddle, axisGreen);



// --- Expectancey Y ---
triple Ymiddle = (0,0.33*S,0);

draw((0,0,0)--Ymiddle, raypen);

// end part: cyan
pen rayCyan = axisCyan + opacity(1) + linewidth(1.4);
draw((0,0,0)--Ymiddle, axisGreen);













// --- Two-tone ray from L=4 point to X-axis end (cyan at the axis end) ---
triple Xend = (S,0,0);

draw(Lspark--Xend, raypen);

// end part: cyan
pen rayCyan = axisCyan + opacity(1) + linewidth(1.4);
draw(Lspark--Xend, rayCyan);



// --- Two-tone ray from C=3 point to Y-axis end (cyan at the axis end) ---
triple Yend = (0,S,0);

draw(Cspark--Yend, raypen);

// end part: cyan
pen rayCyan = axisCyan + opacity(1) + linewidth(1.4);
draw(Cspark--Yend, rayCyan);




// Agency point on LC-plane
triple A = (L,C,0);
dot(A, sparkO);
draw(Lspark--A, raypen);
draw(Cspark--A, raypen);
lab("Agency Potential", A, (0.35,0.25,0.00), noteAmber);
//lab("A = L*C = 12", (0.9,0.9,0.0), (0,0,0), noteAmber);
lab("A = L*C = 12", (.9S,.75S,0.0), (0,0,0), noteAmber);

// ---------- FLOW/HEAT ALONG R AT FIXED (L,C) ----------
real Rmin = 0.8;   // avoid singularity at R=0
real Rmax = 4.6;
int samples = 140;



// ---------- SPATIAL ANCHORS (make placement unambiguous) ----------

// 1) A faint “spine” showing the line is at fixed (L,C) and varies only with R (Z)
//pen spine = rgb(0.0,0.9,0.9) + opacity(0.25) + linewidth(1.1);
//pen spine = rgb(0.0,0.9,0.9) + opacity(0.12) + linewidth(0.9);
pen spine = gray(0.75) + opacity(0.18) + linewidth(0.7);
draw((L,C,0)--(L,C,S), spine);
lab("Flow/Heat line at fixed (L=4, C=3)", (L,C,S), (0.45,0.25,0.0), noteCyan);

// 2) Projection guides at key R values
pen guide = rgb(0.85,0.9,1.0) + opacity(0.22) + linewidth(0.9);
pen guideD = guide + dotted;

real[] marks = {Rmin, 1.0, 2.0, Rmax};

for(int k=0; k<marks.length; ++k){
  real r = marks[k];
  triple P = (L,C,r);

  // drop to LC-plane (z=0)
  draw(P--(L,C,0), guideD);

  // project to L-R plane (y=0)
  draw(P--(L,0,r), guideD);

  // project to C-R plane (x=0)
  draw(P--(0,C,r), guideD);

  // small marker so the intersection is readable
  dot(P, rgb(0.9,0.9,0.9) + opacity(0.35) + linewidth(3));
}


real Flow(real r){ return A_val/r; }           // F = A/R
real Heat(real r){ return (A_val*A_val)/r; }   // H = A^2/R

real Fmax = Flow(Rmin);
real Fmin = Flow(Rmax);

real Hmax = Heat(Rmin);
real Hmin = Heat(Rmax);

// Robust power function for Asymptote (no pow())
real powr(real x, real g){
  x = max(0, x);
  if(x == 0) return 0;
  return exp(g*log(x));
}

real warp(real t, real g){
  return powr(clamp01(t), g);
}

// Color from heat (deep red -> orange-hot)
pen heatColor(real h){
  real t = clamp01((h - Hmin)/(Hmax - Hmin));
  real rr = (1-t)*0.70 + t*1.00;
  real gg = (1-t)*0.08 + t*0.30;
  real bb = (1-t)*0.08 + t*0.02;
  return rgb(rr,gg,bb);
}


// Visual mappings (make F decrease obvious)
real wMin = 0.6;   // thinner minimum
real wMax = 9.0;   // thicker maximum (stronger contrast)
real gammaW = 1.8; // nonlinear emphasis

real aMin = 0.18;
real aMax = 0.85;  // slightly larger arrows too



real thickness(real f){
  real t = (f - Fmin)/(Fmax - Fmin);
  t = warp(t, gammaW);
  return wMin + (wMax - wMin)*t;
}

real arrowsz(real f){
  real t = (f - Fmin)/(Fmax - Fmin);
  t = warp(t, 1.3); // milder warp for arrows
  return aMin + (aMax - aMin)*t;
}

// Draw “flow line” segments with thickness=F and color=H
for(int i=0; i<samples-1; ++i){
  real r1 = Rmin + i*(Rmax-Rmin)/(samples-1);
  real r2 = Rmin + (i+1)*(Rmax-Rmin)/(samples-1);

  real rm = (r1+r2)/2;
  real f  = Flow(rm);
  real h  = Heat(rm);

  pen p = heatColor(h) + linewidth(thickness(f));
  draw((L,C,r1)--(L,C,r2), p);
}

// Direction arrows (size scales with flow)
int narrows = 6;
for(int j=0; j<narrows; ++j){
  real r = Rmin + (j+0.6)*(Rmax-Rmin)/narrows;
  real f = Flow(r);
  real h = Heat(r);

  pen apen = heatColor(h) + linewidth(1.2);
  real sarr = arrowsz(f);

  draw((L,C,r-0.28)--(L,C,r+0.28), apen, Arrow3(size=sarr));
}

// Explicit flow labels to remove ambiguity
real[] rMarks = {1.0, 2.0, 4.0};
for(int k=0; k<rMarks.length; ++k){
  real r = rMarks[k];
  real f = Flow(r);
  triple P = (L,C,r);
  dot(P, rgb(1,1,1) + opacity(0.25) + linewidth(3));
  //lab("F="+format("%0.1f", f), P, (0.35,0.20,0.05), noteRed);
}


// ---------- FLOW BARS (make F decrease with R obvious) ----------
// Bars extend in +X direction from the spine (L,C,R) with length proportional to Flow.
// This is the most readable encoding while keeping axes pure.

//real barMax = 1.6;  // maximum bar length in scene units (tune)
//real[] barR = {1.0, 2.0, 4.0};

//for(int k=0; k<barR.length; ++k){
//  real r = barR[k];
//  real f = Flow(r);
//  real h = Heat(r);

  // normalize flow for bar length
//  real tF = clamp01((f - Fmin)/(Fmax - Fmin));
  // emphasize contrast (same gamma idea, but on length which is readable)
//  tF = warp(tF, 1.6);

//  real len = barMax * tF;

//  triple P = (L, C, r);
//  triple Q = (L + len, C, r);  // bar goes along +X

//  pen bp = heatColor(h) + linewidth(2.0);
//  draw(P--Q, bp, Arrow3(size=0.35 + 0.35*tF));

  // label directly on the bar
//  lab("F="+format("%0.1f", f), Q, (0.10,0.15,0.00), noteRed);
//}

// ---------- FORMULAS + LEGEND ----------
lab("F = A / R", (1.6,1.8,0.0), (0,0,0), noteRed);
lab("H = F^2 * R = A^2 / R", (0.9,1.8,2.0), (0,0,0), rgb(1.00,0.25,0.05));

//lab("Encoding:", (0.9,2.4,0.0), (0,0,0), noteCyan);
//lab("Thickness = Flow F", (0.9,2.75,0.0), (0,0,0), noteCyan);
//lab("Color = Heat H", (0.9,3.10,0.0), (0,0,0), noteCyan);
//lab("Arrow size = Flow F", (0.9,3.45,0.0), (0,0,0), noteCyan);

// Mark Rmin (singularity avoidance)
triple Prmin = (L,C,Rmin);
dot(Prmin, rgb(0.85,0.2,0.2) + linewidth(4));
//lab("Rmin=0.8 (avoid R=0)", Prmin, (0.55,-0.15,0.10), noteRed);

// Worked point: R=2
real R_ex = 3.5;
real F_ex = Flow(R_ex);
real H_ex = Heat(R_ex);

triple Pex = (L,C,R_ex);
dot(Pex, rgb(1.00,0.55,0.12) + linewidth(5));
//lab("R=2 => F=6, H=72", Pex, (0.55,0.20,0.15), noteAmber);

// Also mark R=1 (F=A)
real R_one = 1.0;
triple P1 = (L,C,R_one);
dot(P1, rgb(0.95,0.30,0.20) + linewidth(4));
lab("R=1 => F=A=12", P1, (-.45,0.8,0.10), noteRed);
