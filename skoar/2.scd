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
)


(x = "
180 => )

.bass   instrument:@bass       o~~  mp
.bass2   instrument:@bass      o~~  mp o/
.kick   instrument:@kick       o~~  pp o/

{! razzle<x> !!
   key:       <!x, @minorPentatonic>
   .bass  o/ {: {: _g ]] _a# ]] a ]] f ]] :: 2 times :} {: _g ]] _a# ]] a ]] g ]] :: 2 times :} :: 2 times :}
   .bass2 o/ {: {: _g ]] _a# ]] a ]] f ]] :: 2 times :} {: _g ]] _a# ]] a ]] g ]] :: 2 times :} :: 2 times :}
!}

{! dazzle !!
   .kick  {: {: ]] ]] ]] ]] :: 4 times :} :: 2 times :}
!}

<G, F, D#, B, D#, A, C#, F, D#, B, A C#>.{: !razzle<$> !dazzle :}

!razzle<C#>

.kick  {: {: ]] ]] ]]] ]]] ]]] ]] ]]] ]]] ]]] :: 4 times :} :: 3 times :}

".skoar.play;
)


// @minorPentatonic only makes sense if you are using numbers as noats.
// noats themselves are relative to root note.
//
// underneath, numbers are scale degrees, using the 'degree' symbol for patterns.
// noats, use the 'note' symbol in the pattern, and won't use the scale,
// it will use the key though, so the root note affects noats..
// noats assume C scale..

(x = "
180 => )

.bass   aSaw * aLFNoise2     o~~  mp
.bass2   instrument:@bass      o~~  mp o/
.kick   instrument:@kick       o~~  pp o/

{! razzle<x> !!

          key: <!x, @minorPentatonic>
   .bass  o/ {: {: _g ]] _a# ]] a ]] f ]] :: 2 times :} {: _g ]] _a# ]] a ]] g ]] :: 2 times :} :: 2 times :}
   .bass2 o/ {: {: _g ]] _a# ]] a ]] f ]] :: 2 times :} {: _g ]] _a# ]] a ]] g ]] :: 2 times :} :: 2 times :}
!}

{! dazzle !!
   .kick  {: {: ]] ]] ]] ]] :: 4 times :} :: 2 times :}
!}

<G, F, D#, B, D#, A, C#, F, D#, B, A C#>.{: !razzle<$> !dazzle :}

!razzle<C#>

.kick  {: {: ]] ]] ]]] ]]] ]]] ]] ]]] ]]] ]]] :: 4 times :} :: 3 times :}

".skoar.play;
)



// see in this one we just do key: !x rather than key: <!x, @minorPentatonic>
(x = "
180 => )

.bass   aLFTri * aSaw                o~~  mp
.bass2   aLFTri * aLFNoise2         o~~  mp o/
.kick   instrument:@kick       o~~  piano o/

{! wizzle !! _g ]] _a# ]] a ]] f ]] !}
{! wozzle !! _g ]] _a# ]] a ]] g ]] !}


{! frazzle<wizzle, wozzle> !!
   {: {: !wizzle :: 2 times :} {: !wozzle :: 2 times :} :: 2 times :}
!}

{! razzle<x> !!
   key:       !x
   .bass  o/ !frazzle
   .bass2 o/ !frazzle
!}

{! dazzle !!
   .kick  {: {: ]] ]] ]] ]] :: 4 times :} :: 2 times :}
!}

<G, F, D#, B, D#, A, C#, F, D#, B, A C#>.{: !razzle<$> !dazzle :}

!razzle<C#>

.kick  {: {: ]] ]] ]]] ]]] ]]] ]] ]]] ]]] ]]] :: 4 times :} :: 3 times :}

".skoar.play;
)



// this one doesn't work, but should.
// the numbers aren't being treated as noatworthy,
// the fairy is failing in wizzle and wozzle.
(x = "
180 => )

.bass   instrument:@bass                o~~  mp
.bass2   instrument:@bass         o~~  mp o/
.kick   instrument:@kick       o~~  piano o/

{! wizzle !! 0 ]]] ooo/ 1 ]]] ooo/ 5 ]]] ooo/ 4 ]]] ooo/ !}
{! wozzle !! 0 ]]] ooo/ 1 ]]] ooo/ 5 ]]] 4 ]]] 3 ]]] ooo/ !}


{! frazzle !!
   {: {: !wizzle :: 2 times :} {: !wozzle :: 2 times :} :: 2 times :}
!}

{! razzle<x> !!
   key:       <!x, @minorPentatonic>
   .bass  o/ !frazzle
   .bass2 o/ !frazzle
!}

{! dazzle !!
   .kick  {: {: ]] ]] ]] ]] :: 4 times :} :: 2 times :}
!}

<G, F, D#, B, D#, A, C#, F, D#, B, A C#>.{: !razzle<$> !dazzle :}

!razzle<C#>

.kick  {: {: ]] ]] ]]] ]]] ]]] ]] ]]] ]]] ]]] :: 4 times :} :: 3 times :}

".skoar.play;
)


