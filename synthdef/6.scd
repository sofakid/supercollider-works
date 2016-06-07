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
)

(a = Synth.new(\pbufm, [\buf, ~barry[0], \out, 0, \amp, 0.7]);)
(b = Synth.new(\pbufm, [\buf, ~barry[0], \rate, 0.5, \out, 0, \amp, 0.8]);)
(a.set(\rate, 0.8);)
(a.set(\rate, 0.4);)
(c = Synth.new(\pbufm, [\buf, ~barry[1], \rate, 1.2, \out, 0, \amp, 1.1]);)
(b.set(\rate, 0.6);)
(a.set(\rate, 0.8);)
(c.set(\rate, 1.8);)
(b.set(\rate, 0.4);)
(c.set(\rate, 1.775);)
(a.set(\rate, 22.8);)
(a.set(\rate, 45.6);)
(a.set(\rate, 3.2);)
(a.set(\rate, 1.6);)
(a.set(\rate, 0.4);)
(c.set(\rate, 1.8);)
(c.release(20);)
(a.release(20);)
(b.release(20);)
