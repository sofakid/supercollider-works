(
s.reboot; s.meter;
)

(
~barry = Array.new;
~folder = PathName.new("/Users/paullucas/Producing/march29th-2016/phrases/mic/chops/ok/sc/s/");
)
(
~folder.entries.do({
arg path;
~barry = ~barry.add(Buffer.read(s, path.fullPath));
});
)

(
SynthDef.new(\pbuf,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=10.0;
  var sig;
  sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
SynthDef.new(\pbufm,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=10.0;
  var sig;
  sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
SynthDef.new(\reverb, {
  arg in, out=0;
  var sig;
  sig = In.ar(in, 2);
  sig = FreeVerb.ar(sig, 0.5, 1.0, 1.0);
  Out.ar(out, sig);
}).add;
)

(~reverbBus = Bus.audio(s, 2);)
(r = Synth.new(\reverb, [\in, ~reverbBus, \out, 0]);)

(j = Synth.new(\pbuf, [\buf, ~barry[5], \rate, 0.5, \loop, 1, \out, 0, \amp, 1.0, \att, 0.1]);)
(a = Synth.new(\pbuf, [\buf, ~barry[0], \rate, 1.0, \loop, 1, \out, 0, \amp, 0.9]);)
(b = Synth.new(\pbuf, [\buf, ~barry[1], \rate, 1.0, \loop, 1, \out, 0, \amp, 0.9]);)
(c = Synth.new(\pbuf, [\buf, ~barry[2], \rate, -0.75, \loop, 1, \out, ~reverbBus, \amp, 1.0, \att, 20]);)
(d = Synth.new(\pbuf, [\buf, ~barry[2], \rate, 0.85, \loop, 1, \out, ~reverbBus, \amp, 1.0]);)
(e = Synth.new(\pbuf, [\buf, ~barry[2], \rate, 0.6, \loop, 1, \out, ~reverbBus, \amp, 1.0]);)
(f = Synth.new(\pbuf, [\buf, ~barry[1], \rate, 60.0, \loop, 1, \out, 0, \amp, 0.8]);)
(g = Synth.new(\pbuf, [\buf, ~barry[3], \rate, 0.15, \loop, 1, \out, 0, \amp, 0.9]);)
(h = Synth.new(\pbuf, [\buf, ~barry[3], \rate, 0.3, \loop, 1, \out, 0, \amp, 0.9]);)
(f.release(10);)
(f = Synth.new(\pbuf, [\buf, ~barry[1], \rate, 60.0, \loop, 1, \out, 0, \amp, 0.85]);)
(f.release(15);)
(a.release(20);)
(c.release(20);)
(b.release(20);)
(i = Synth.new(\pbufm, [\buf, ~barry[4], \rate, 1, \loop, 0, \out, 0, \amp, 0.9]);)
(d.release(20);e.release(20);)
(h.release; g.release;)
(j.release;)
(i.release(10);)
