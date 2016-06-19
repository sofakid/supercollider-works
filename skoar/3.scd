(s.reboot)

(
SynthDef("trianglewavebells",{
  arg out = 0, pan = 0.0, freq = 440, amp = 1.0, gate = 1, att = 0.01, dec = 0.1, sus = 1, rel = 0.5, lforate = 10, lfowidth = 0.0, cutoff = 100, rq = 0.5;
  var osc1, osc2, vibrato, filter, env;
  vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
  osc1 = Saw.ar(freq * (1.0 + (lfowidth * vibrato)), 0.75);
  osc2 = Mix(LFTri.ar((freq.cpsmidi + [11.9, 12.1]).midicps));
  filter = RHPF.ar((osc1 + (osc2 * 0.5)) * 0.5, cutoff, rq);
  env = EnvGen.ar(envelope: Env.adsr(att, dec, sus, rel, amp), gate: gate, doneAction: 2);
  Out.ar(out, Pan2.ar(filter * env, pan));
}).add;
SynthDef("blips", {arg out = 0, freq = 25, numharm = 10, att = 0.01, rel = 1, amp = 0.1, pan = 0.5;
  var snd, env;
  env = Env.perc(att, rel, amp).kr(doneAction: 2);
  snd = LeakDC.ar(Mix(Blip.ar([freq, freq*1.01], numharm, env)));
  Out.ar(out, Pan2.ar(snd, pan));
}).add;
SynthDef("bass", { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.15, detune = 1.005, preamp = 4|
  var sig, env;
  env = Env.adsr(0.01, 0.3, 0.4, 0.1);
  freq = Lag.kr(freq, slideTime);
  sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort;
  sig = sig * amp * EnvGen.kr(env, gate, doneAction: 2);
  sig = LPF.ar(sig, ffreq);
  Out.ar(0, sig ! 2)
}).add;
)

(x = "
100 => )

.triangle   instrument:@trianglewavebells o~~ mp
.blips      instrument:@blips o~~~ mf
.bass       instrument:@bass o~~~ mf

key: <C, @major>

.triangle   {: _g ] _g ] _a ) _g ) c ) _b )) _g ] _g ] _a ) _g ) d ) c )) _g ] _g ] g ) e ) c ) _b ) _a ) f ] f ] e ) c ) d ) c )) :}
.blips      {: _g ] _g ] _a ) _g ) c ) _b )) _g ] _g ] _a ) _g ) d ) c )) _g ] _g ] g ) e ) c ) _b ) _a ) f ] f ] e ) c ) d ) c )) :}
.bass       {: _g ] _g ] _a ) _g ) c ) _b )) _g ] _g ] _a ) _g ) d ) c )) _g ] _g ] g ) e ) c ) _b ) _a ) f ] f ] e ) c ) d ) c )) :}

".skoar.play;
)

// Happy Birthday Lucas!
