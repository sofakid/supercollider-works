(
s.reboot;s.meter;
)
(
    g = Group.new;
)
(
~barry = Array.new;
~folder = PathName.new("~/producing/feb22-2016/n/");
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
    arg amp=1, out=0, buf, dur=1, rate=1, trig, cpos, att=10.0, gate=1, lpf=2000, hpf=1000;
    var sig;
    sig = TGrains.ar(2, Impulse.ar(trig), buf, rate, centerPos: cpos,dur: dur, pan: 0, amp: amp, interp: 1 );
    sig = LPF.ar(sig, freq: lpf);
    sig = HPF.ar(sig, freq: hpf);
    Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve:1), gate, doneAction: 2));
}).add;
SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.5, 1.0, 1.0);
	Out.ar(0, sig);
}).add;
)
(~reverbBus = Bus.audio(s, 2);)
(~reverbBus2 = Bus.audio(s, 4);)
(r = Synth.new(\reverb, [\in, ~reverbBus],g);)
(s = Synth.new(\reverb, [\in, ~reverbBus2],g);)

(x = Synth.new(\pbuf, [\buf, ~barry[2], \rate, 0.4, \loop, 1, \out, ~reverbBus, \lpf, 4000, \hpf, 100, \amp, 0.8 ],g); )
(y = Synth.new(\pbufmono, [\buf, ~barry[5], \rate, 0.5, \loop, 1, \out, ~reverbBus2, \lpf, 2000, \hpf, 50, \amp, 0.93],g);)
(x.release(10);)
(x = Synth.new(\pbuf, [\buf, ~barry[2], \rate, 0.3, \loop, 1, \out, ~reverbBus, \lpf, 3000, \hpf, 100, \amp, 0.8],g); )
(y.release(10);)
(y = Synth.new(\pbufmono, [\buf, ~barry[5], \rate, 0.3, \loop, 1, \out, ~reverbBus2, \lpf,2000, \hpf, 30, \amp, 0.93],g);)
(x.release(10);)
(x = Synth.new(\pbuf, [\buf, ~barry[2], \rate, 0.27, \loop, 1, \out, ~reverbBus, \lpf, 4000, \hpf, 80, \amp, 0.8],g); )
(x.release(10);)
(x = Synth.new(\pbuf, [\buf, ~barry[2], \rate, 0.2, \loop, 1, \out, ~reverbBus, \lpf, 3500,\hpf, 100, \amp, 0.8  ],g); )
(z = Synth.new(\pgrain, [\buf, ~barry[6], \dur, 25, \rate, 0.8, \trig, 0.165, \cpos, 1222, \out, ~reverbBus, \amp, 0.9], g);)
(y.release(10);)
(x.release(10);)
(z.release(20);)


(
~barry[0]; //stereo
~barry[1]; //stereo
~barry[2]; //stereo
~barry[3]; //mono
~barry[4]; //mono
~barry[5]; //mono
~barry[6]; //mono
~barry[7]; //mono
~barry[8]; //mono
~barry[9]; //mono
~barry[10]; //stereo
~barry[11]; //stereo
)
