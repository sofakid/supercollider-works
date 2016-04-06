(
s.reboot;s.meter;
)
(
~barry = Array.new;
~folder = PathName.new("~/Producing/march7th-2016/ubuntu/1/");
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
SynthDef.new(\pbufmono,{
	arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=10.0, lpf=2000, hpf=1000;
	var sig;
	sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
	sig = [sig, sig] * amp;
  sig = LPF.ar(sig, freq: lpf);
  sig = HPF.ar(sig, freq: hpf);
	Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
SynthDef.new(\pgrain, {
  arg amp=1, mamp=1, out=0, buf, dur=1, rate=1, trig, cpos, att=10.0, gate=1, lpf=2000, hpf=1000;
  var sig;
  sig = TGrains.ar(2, Impulse.ar(trig), buf, rate, centerPos: cpos,dur: dur, pan: 0, amp: amp, interp: 2 );
  sig = LPF.ar(sig, freq: lpf);
  sig = HPF.ar(sig, freq: hpf);
  sig = sig * EnvGen.kr(Env.asr(attackTime:att, curve:1), gate, doneAction: 2);
  Out.ar(out, sig * mamp);
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
(~reverbBus2 = Bus.audio(s, 4);)
(g = Group.new;)
(r = Synth.new(\reverb, [\in, ~reverbBus, \out, 0],g);)
(s = Synth.new(\reverb, [\in, ~reverbBus2, \out, 0],g);)

(x = Synth.new(\pbufmono, [\buf, ~barry[2], \rate, 0.45, \loop, 1, \out, ~reverbBus, \lpf, 2000, \hpf, 80, \amp, 0.8 ],g); )
(y = Synth.new(\pbufmono, [\buf, ~barry[1], \rate, 0.85, \loop, 1, \out, ~reverbBus2, \lpf, 2000, \hpf, 200, \amp, 1.70],g);)
(x.set(\rate, 0.60);)
(y.set(\rate, 0.75);)
(y.set(\rate, 0.650);)
(b = Synth.new(\pbuf, [\buf, ~barry[5], \rate, 0.85, \loop, 1, \out, 0, \lpf, 19000, \hpf, 3000, \amp, 0.15],g);)
(y.release(10);)
(z = Synth.new(\pgrain, [\buf, ~barry[3], \dur, 10, \rate, 1.5, \trig, 0.075, \cpos, 0222, \out, ~reverbBus2, \mamp, 6.0], g);)
(x.set(\rate, 0.65); z.set(\rate, 1.4, \trig, 0.065); b.set(\loop, 0);)
(z.release(1);)
(x.set(\rate, 0.40);)
(z = Synth.new(\pgrain, [\buf, ~barry[3], \dur, 10, \rate, 6.5, \trig, 0.045, \cpos, 0222, \out, ~reverbBus2, \mamp, 3.0], g);)
(b = Synth.new(\pbuf, [\buf, ~barry[5], \rate, 1.00, \loop, 1, \out, ~reverbBus2, \lpf, 19000, \hpf, 3000, \amp, 0.15],g);)
(z.set(\rate, 28, \mamp, 2.85);)
(z.set(\rate, 38);)
(z.set(\rate, 0.5, \amp, 7, \mamp, 8, \trig, 1.08, \lpf, 500);)
(b.set(\loop, 0);)
(x.release(10);)
(z.release(25);)

(g.free;)