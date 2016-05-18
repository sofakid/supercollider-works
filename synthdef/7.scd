(
s.reboot; s.meter;
)

(
~barry = Array.new;
~folder = PathName.new("~/Producing/April5th-2016/samples/");
)
(
~folder.entries.do({
arg path;
~barry = ~barry.add(Buffer.read(s, path.fullPath));
});
)

(
SynthDef.new(\pbuf,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=1, rate=1, da=2, gate=1, att=10.0, room=1, mix=1, damp=1;
  var sig;
  sig = FreeVerb.ar(PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da), mix, room, damp);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
SynthDef.new(\pbufm,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=1, rate=1, da=2, gate=1, att=10.0, room=1, mix=1, damp=1;
  var sig;
  sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  sig = Pan2.ar(sig, 0, 1);
  sig = FreeVerb.ar(sig, mix, room, damp);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
SynthDef.new(\pbufmnr,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=3;
  var sig;
  sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  sig = Pan2.ar(sig, 0, 1);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
)

(a = Synth.new(\pbuf, [\buf, ~barry[3], \rate, 0.7, \out, 0, \amp, 1.2]);)
(b = Synth.new(\pbufm, [\buf, ~barry[4], \out, 0, \amp, 0.7]);)
(c = Synth.new(\pbufmnr, [\buf, ~barry[5], \out, 0]);)
(a.set(\rate, 0.5);)
(b.set(\rate, 0.8);)
(c = Synth.new(\pbufmnr, [\buf, ~barry[5], \rate, 0.5, \out, 0]);)
(a.release(20);)
(b.release(20);)
