(
s.reboot;
s.meter;
)
(
~barry = Array.new;
~folder = PathName.new("~/producing/duplicates/48/wav/");
)
(
~folder.entries.do({
arg path;
~barry = ~barry.add(Buffer.read(s, path.fullPath));
});
)
(
SynthDef.new(\playb,{
	arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, att=10, gate=1, lpf=1000, hpf=100;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
	sig = sig * amp;
	sig = LPF.ar(sig, freq: lpf);
	sig = HPF.ar(sig, freq: hpf);
	Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
)
(g = Group.new;)
(x = Synth.new(\playb, [\buf, ~barry[1], \da, 0, \rate, 0.4, \start, s.sampleRate/4, \loop, 1, \amp, 2, \out, 0, \lpf, 1500, \hpf, 150], g);)
(y = Synth.new(\playb, [\buf, ~barry[1], \da, 0, \rate, 0.5, \loop, 1, \out, 0, \att, 1, \lpf, 3000, \hpf, 50], g);)
(z = Synth.new(\playb, [\buf, ~barry[1], \da, 0, \rate, 0.8, \start, s.sampleRate/8, \loop, 1,\att,1, \amp, 1, \out, 0, \lpf, 2000, \hpf, 40], g);)
(a = Synth.new(\playb, [\buf, ~barry[0], \da, 0, \rate, 0.2, \loop, 1, \amp, 2, \out, 0, \lpf, 3000, \hpf, 50], g);)
(b = Synth.new(\playb, [\buf, ~barry[0], \da, 0, \rate, 0.4, \start, s.sampleRate/2, \loop, 1, \amp, 1, \out, 0, \lpf, 5000, \hpf, 40], g);)
(c = Synth.new(\playb, [\buf, ~barry[1], \da, 0, \loop, 1, \out, 0, \att, 1, \lpf, 800, \hpf, 350], g);)

(x.set(\rate, 0.6);)
(y.set(\rate, 0.3);)
(z.set(\rate, 0.6);)
(a.set(\rate, 0.3);)
(a.set(\rate, 0.225);)
(a.set(\rate, 0.2);)
(a.set(\rate, 0.3);)
(a.set(\rate, 0.225);)
(a.set(\rate, 0.2);)
(b.set(\rate, 0.4);)
(c.set(\rate, 0.5);)
(c.set(\rate, 0.9);)
(x.release(1);)
(y.release(5);)
(z.release(5);)
(b.release(10);)
(c.release(10);)
(a.release(10);)

(g.free;)