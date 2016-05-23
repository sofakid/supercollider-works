(
s.reboot; s.meter;
)

(
~barry = Array.new;
~folder = PathName.new("~/Producing/may21st-2016/chops/");
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
  SynthDef.new(\pgrain, {
    arg amp=1, out=0, buf, dur=1, rate=1, trig, cpos, att=10.0, gate=1, hpf=1000, lpf=2000, mix=1, room=1, damp=1;
    var sig;
    sig = TGrains.ar(2, Impulse.ar(trig), buf, rate, centerPos: cpos,dur: dur, pan: 0, amp: amp, interp: 1 );
    sig = LPF.ar(sig, freq: lpf);
    sig = HPF.ar(sig, freq: hpf);
    sig = FreeVerb.ar(sig, mix, room, damp);
    Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve:1), gate, doneAction: 2));
  }).add;
  SynthDef.new(\sin, {
    arg freq1=440, freq2=460, amp=0.4, out=0, att=10, gate=1;       
    var sig;
    sig = SinOsc.ar([freq1, freq2]) * amp;
    Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve:1), gate, doneAction: 2));
  }).add;
)

(x = Synth.new(\pbuf, [\buf, ~barry[3], \rate, 0.4, \amp, 0.875]);)
(y = Synth.new(\pbuf, [\buf, ~barry[1], \rate, 3.0, \att, 40, \amp, 0.7]);)
(y.release(20))
(z = Synth.new(\pgrain, [\buf, ~barry[2], \rate, 0.8, \dur, 8, \trig, 0.125, \cpos, 100, \att, 10, \amp, 1.3, \hpf, 70, \lpf, 4000, \room, 0.9, \mix, 0.8]);)
(y = Synth.new(\pbuf, [\buf, ~barry[1], \rate, 6.0, \att, 40, \amp, 0.7]);)
(y.release(20))
(x.set(\rate, 0.25))
(z.set(\rate, 0.4, \lpf, 2000, \hpf, 50))
(a = Synth.new(\pbuf, [\buf, ~barry[4], \rate, 2, \amp, 0.875]);)
(x.release(40))
(a.set(\rate, 1))
(z.release(20))
(b = Synth.new(\sin, [\freq1, 60, \freq2, 50]);)
(c = Synth.new(\sin, [\freq1, 1600, \freq2, 1800, \amp, 0.085]);)
(a.set(\rate, 0.5))
(c.release(20))
(a.set(\rate, 0.35))
(a.release(40))
(b.release(20))
