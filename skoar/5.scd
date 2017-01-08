(s.reboot;)

(
SynthDef("bass", {
  arg freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.15, detune = 1.005, preamp = 4;
  var sig, env;
  env = Env.adsr(0.01, 0.3, 0.4, 0.1);
  freq = Lag.kr(freq, slideTime);
  sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort;
  sig = sig * amp * EnvGen.kr(env, gate, doneAction: 2);
  sig = LPF.ar(sig, ffreq);
  Out.ar(0, sig ! 2)
}).add;
SynthDef(\kick, {
  arg out = 0, freq = 50, mod_freq = 5, mod_index = 5, sustain = 0.4, amp = 0.8, beater_noise_level = 0.025;
  var pitch_contour, drum_osc, drum_lpf, drum_env;
  var beater_source, beater_hpf, beater_lpf, lpf_cutoff_contour, beater_env;
  var kick_mix;
  sustain = 0.4;
  freq = 50;
  pitch_contour = Line.kr(freq * 2, freq, 0.02);
  drum_osc = PMOsc.ar(
    pitch_contour,
    mod_freq,
    mod_index/1.3,
    mul: 1,
    add: 0
  );
  drum_lpf = LPF.ar(in: drum_osc, freq: 1000, mul: 1, add: 0);
  drum_env = drum_lpf * EnvGen.ar(Env.perc(0.005, sustain), 1.0, doneAction: 2);
  beater_source = WhiteNoise.ar(beater_noise_level);
  beater_hpf = HPF.ar(in: beater_source, freq: 500, mul: 1, add: 0);
  lpf_cutoff_contour = Line.kr(6000, 500, 0.03);
  beater_lpf = LPF.ar(in: beater_hpf, freq: lpf_cutoff_contour, mul: 1, add: 0);
  beater_env = beater_lpf * EnvGen.ar(Env.perc, 1.0, doneAction: 2);
  kick_mix = Mix.new([drum_env, beater_env]) * 2 * amp;
  Out.ar(out, [kick_mix, kick_mix])
}).add;
SynthDef("trianglewavebells",{
  arg out = 0, pan = 0.0, freq = 440, amp = 1.0, gate = 1, att = 0.01, dec = 0.1, sus = 1, rel = 0.5, lforate = 10, lfowidth = 0.0, cutoff = 100, rq = 0.5;
  var osc1, osc2, vibrato, filter, env;
  vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
  osc1 = Saw.ar(freq * (1.0 + (lfowidth * vibrato)), 0.75);
  osc2 = Mix(LFTri.ar((freq.cpsmidi + [11.9, 12.1]).midicps));
  filter = RHPF.ar((osc1 + (osc2 * 0.5)) * 0.5, cutoff, rq);
  env = EnvGen.ar(envelope: Env.adsr(att, dec, sus, rel, amp), gate: gate, doneAction: 2);
  Out.ar(out, Pan2.ar(filter * env, pan));}).add;
SynthDef("blips", {arg out = 0, freq = 25, numharm = 10, att = 0.01, rel = 1, amp = 0.1, pan = 0.5;
  var snd, env;
  env = Env.perc(att, rel, amp).kr(doneAction: 2);
  snd = LeakDC.ar(Mix(Blip.ar([freq, freq*1.01], numharm, env)));
  Out.ar(out, Pan2.ar(snd, pan));
}).add;)

(x = "
74 => )

.bass    instrument:@bass               o~~  mp
.bass2   instrument:@bass               o~~  mp
.kick    instrument:@kick               o~~  pp
.tri     instrument:@trianglewavebells  o~   pp
.tri2    instrument:@trianglewavebells  o~~  pp
.blips   instrument:@blips              ~o   pp

key:        <A, @pentatonic>

.bass       {: {: _c# ]] _d ]] :} :: 40 times :}
.bass2      {: {: b ]] :: 20 times :} {: a ]] :: 20 times :} :}
.tri        {: {: b ]] :: 20 times :} {: a ]] :: 20 times :} :}
.tri2       {: {: b ]] :: 20 times :} {: a ]] :: 20 times :} :}
.blips      {: {: b ]]] a ]]] }  :: 5 times :} {: b ]]] _a ]]] :: 5 times :} :: 2 times :}
.bass2      {: {: a ]] :: 20 times :} {: f# ]] :: 20 times :} :}
.bass       {: {: e ]] :: 20 times :} {: g ]] :: 20 times :} :}
.tri  o/    {: {: a ]] :: 20 times :} {: f# ]] :: 20 times :} :}
.tri2  oo/  {: {: a ]] :: 20 times :} {: f# ]] :: 20 times :} :}
.blips      {: {: b ]]. _a ]]] }  :: 5 times :} {: _b ]]] a ]]. :: 5 times :} :: 2 times :}
.bass2   o/ {: {: _f# ]] :: 20 times :} {: c ]] :: 20 times :} :}
.tri     o/ {: {: d ]] :: 20 times :} {: e ]] :: 20 times :} :}
.tri2    o/ {: {: d ]] :: 20 times :} {: e ]] :: 20 times :} :}
.kick       {: {: ]] ]] oo/ ]]  :: 20 times :}  {: ] oo/ ]] ]]]  :: 10 times :} :}

68 => )
key:        <E, @pentatonic>

.bass       {: {: c# ]] d ]] :} :: 40 times :}
.bass2      {: {: _b ]] :: 20 times :} {: a ]] :: 20 times :} :}
.tri        {: {: _b ]] :: 20 times :} {: _a ]] :: 20 times :} :}
.tri2       {: {: _b ]] :: 20 times :} {: _a ]] :: 20 times :} :}
.blips      {: {: _b ]]] a ]]] }  :: 5 times :} {: b ]]] _a ]]] :: 5 times :} :: 2 times :}
.bass2      {: {: a ]] :: 20 times :} {: _f# ]] :: 20 times :} :}
.bass       {: {: _e ]] :: 20 times :} {: g ]] :: 20 times :} :}
.tri     o/ {: {: a ]] :: 20 times :} {: _f# ]] :: 20 times :} :}
.tri2   oo/ {: {: _a ]] :: 20 times :} {: f# ]] :: 20 times :} :}
.blips      {: {: b ]]. a ]]] }  :: 5 times :} {: _b ]]] a ]]] :: 5 times :} :: 2 times :}
.bass2   o/ {: {: _f# ]] :: 20 times :} {: c ]] :: 20 times :} :}
.tri     o/ {: {: d ]] :: 20 times :} {: e ]] :: 20 times :} :}
.tri2    o/ {: {: d ]] :: 20 times :} {: e ]] :: 20 times :} :}
.kick       {: {: ]]] ] oo/ ]]]  :: 20 times :}  {: ] oo/ ]]] ]]]  :: 10 times :} :}

".skoar.play;)
