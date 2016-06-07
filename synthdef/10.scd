(
s.reboot; s.meter;
)

(
~barry = Array.new;
~folder = PathName.new("~/Producing/may21st-2016/piano/c-chop/sc");
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

(x = Synth.new(\pbuf, [\buf, ~barry[1], \rate, 1.0, \amp, 0.9]);)
(y = Synth.new(\pgrain, [\buf, ~barry[0], \rate, 0.6, \dur, 16, \trig, 0.0625, \cpos, 100, \att, 10, \amp, 1.0, \hpf, 70, \lpf, 400, \room, 0.9, \mix, 0.8]);)
(z = Synth.new(\sin, [\freq1, 82, \freq2, 80, \amp, 0.25]);)
(a = Synth.new(\sin, [\freq1, 1082, \freq2, 1080, \amp, 0.1]);)
(b = Synth.new(\sin, [\freq1, 482, \freq2, 480, \amp, 0.1]);)
(c = Synth.new(\sin, [\freq1, 322, \freq2, 310, \amp, 0.1]);)
(a.set(\freq1, 366, \freq2, 364);)
(b.set(\freq1, 200, \freq2, 210);)
(b.set(\freq1, 100, \freq2, 110);)
(z.release(10))
(x.set(\loop, 0))
(c.release(10))
(b.release(10))
(a.release(10))
(y.release(10))
