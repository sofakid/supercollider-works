(
s.reboot;s.meter;
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

(Ndef(\x, {
  FreeVerb.ar(HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[2], BufRateScale.kr(~barry[2]) * 0.4, 1, 0, 1, doneAction: 2), freq: 4000), freq: 100) * 0.8 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2), 0.5, 1.0, 1.0)
}).play();)

(Ndef(\y, {
  FreeVerb.ar(HPF.ar(LPF.ar(PlayBuf.ar(1, ~barry[5], BufRateScale.kr(~barry[5]) * 0.5, 1, 0, 1, doneAction: 2), freq: 2000), freq: 50) * 0.97 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2), 0.5, 1.0, 1.0)
}).play(0, 2);)

(
Ndef(\x).fadeTime = 10;
Ndef(\x).release;
)

(Ndef(\x, {
  FreeVerb.ar(HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[2], BufRateScale.kr(~barry[2]) * 0.3, 1, 0, 1, doneAction: 2), freq: 3000), freq: 100) * 0.8 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2), 0.5, 1.0, 1.0)
}).play();)

(
Ndef(\y).fadeTime = 10;
Ndef(\y).release;
)

(Ndef(\y, {
  FreeVerb.ar(HPF.ar(LPF.ar(PlayBuf.ar(1, ~barry[5], BufRateScale.kr(~barry[5]) * 0.3, 1, 0, 1, doneAction: 2), freq: 2000), freq: 30) * 0.97 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2), 0.5, 1.0, 1.0)
}).play(0, 2);)

(
Ndef(\x).fadeTime = 10;
Ndef(\x).release;
)

(Ndef(\x, {
  FreeVerb.ar(HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[2], BufRateScale.kr(~barry[2]) * 0.27, 1, 0, 1, doneAction: 2), freq: 4000), freq: 80) * 0.8 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2), 0.5, 1.0, 1.0)
}).play();)

(
Ndef(\x).fadeTime = 10;
Ndef(\x).release;
)

(Ndef(\x, {
  FreeVerb.ar(HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[2], BufRateScale.kr(~barry[2]) * 0.2, 1, 0, 1, doneAction: 2), freq: 3500), freq: 100) * 0.8 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2), 0.5, 1.0, 1.0)
}).play();)

(Ndef(\z, {
  FreeVerb.ar(HPF.ar(LPF.ar(TGrains.ar(2, Impulse.ar(0.165), ~barry[6], 0.8, centerPos: 1222, dur: 25, pan: 0, amp: 0.9, interp: 1 ), freq: 2500), freq: 1000) * EnvGen.kr(Env.asr(attackTime: 10, curve:1, releaseTime: 20), 1, doneAction: 2), 0.5, 1.0, 1.0)
}).play();)

(
Ndef(\y).fadeTime = 10;
Ndef(\y).release;
)

(
Ndef(\x).fadeTime = 10;
Ndef(\x).release;
)

(
Ndef(\z).fadeTime = 20;
Ndef(\z).release;
)
