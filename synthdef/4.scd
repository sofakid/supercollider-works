(
s.reboot;s.meter;
)
(
~barry = Array.new;
~folder = PathName.new("~/Producing/march15th-2016/rh/1/");
)
(
~folder.entries.do({
	arg path;
	~barry = ~barry.add(Buffer.read(s, path.fullPath));
});
)
(
SynthDef.new(\pbuf,{
	arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=10.0, lpf=2000, hpf=1000;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
	sig = [sig, sig] * amp;
  sig = LPF.ar(sig, freq: lpf);
  sig = HPF.ar(sig, freq: hpf);
	Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.5, 1.0, 1.0);
	Out.ar(out, sig);
}).add;
)
(g = Group.new;)
(~reverbBus = Bus.audio(s, 2);)
(~reverbBus2 = Bus.audio(s, 4);)
(r = Synth.new(\reverb, [\in, ~reverbBus, \out, 0],g);)
(s = Synth.new(\reverb, [\in, ~reverbBus2, \out, 0],g);)

(x = Synth.new(\pbuf, [\buf, ~barry[0], \rate, 0.80, \loop, 1, \out, ~reverbBus, \lpf, 1000, \hpf, 60, \amp, 0.7 ],g);)
(y = Synth.new(\pbuf, [\buf, ~barry[3], \rate, 1.25, \loop, 1, \out, ~reverbBus2, \lpf, 6000, \hpf, 800, \amp, 0.8],g);)
(z = Synth.new(\pbuf, [\buf, ~barry[1], \rate, 1.8, \loop, 1, \out, ~reverbBus, \lpf, 2000, \hpf, 200, \amp, 0.8],g);)
(z.set(\rate, 1.4);)
(x.set(\rate, 0.82);)
(y.release(10);)
(z.set(\rate, 1.0);)
(x.set(\rate, 0.7);)
(a = Synth.new(\pbuf, [\buf, ~barry[2], \rate, 2.0, \loop, 1, \out, ~reverbBus2, \lpf, 3500, \hpf, 150, \amp, 1.0],g);)
(y = Synth.new(\pbuf, [\buf, ~barry[3], \rate, 1.05, \loop, 1, \out, ~reverbBus2, \lpf, 6000, \hpf, 3000, \amp, 0.8],g);)
(x.release(10);)
(z.set(\rate, 0.8);)
(a.set(\rate, 0.8);)
(y.set(\rate, 1.2);)
(z.release(20);)
(y.release(10);)
(a.release(20);)
(g.free;)
