(
s.reboot;s.meter;
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
Ndef(\xr, {0.4});
Ndef(\yr, {0.5});
Ndef(\zr, {0.8});
Ndef(\ar, {0.2});
Ndef(\br, {0.4});
Ndef(\cr, {1});
)

(Ndef(\x, {
  HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[1], BufRateScale.kr(~barry[1]) * Ndef.ar(\xr), 1, s.sampleRate/4, 1, doneAction: 0), freq: 1500), freq: 150)
  * 2 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 1), 1, doneAction:2);
}).play;)

(Ndef(\y, {
  HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[1], BufRateScale.kr(~barry[1]) * Ndef.ar(\yr), 1, 0, 1, doneAction: 0), freq: 3000), freq: 50)
  * EnvGen.kr(Env.asr(attackTime: 1, curve: 1, releaseTime: 5), 1, doneAction:2);
}).play;)

(Ndef(\z, {
  HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[1], BufRateScale.kr(~barry[1]) * Ndef.ar(\zr), 1, s.sampleRate/8, 1, doneAction: 0), freq: 2000), freq: 40)
  * EnvGen.kr(Env.asr(attackTime: 1, curve: 1, releaseTime: 5), 1, doneAction:2);
}).play;)

(Ndef(\a, {
  HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[0], BufRateScale.kr(~barry[0]) * Ndef.ar(\ar), 1, 0, 1, doneAction: 0), freq: 3000), freq: 50)
  * 2 * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2);
}).play;)

(Ndef(\b, {
  HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[0], BufRateScale.kr(~barry[0]) * Ndef.ar(\br), 1, s.sampleRate/2, 1, doneAction: 0), freq: 5000), freq: 40)
  * EnvGen.kr(Env.asr(attackTime: 10, curve: 1, releaseTime: 10), 1, doneAction:2);
}).play;)

(Ndef(\c, {
  HPF.ar(LPF.ar(PlayBuf.ar(2, ~barry[1], BufRateScale.kr(~barry[1]) * Ndef.ar(\cr), 1, 0, 1, doneAction: 0), freq: 800), freq: 350)
  * EnvGen.kr(Env.asr(attackTime: 1, curve: 1, releaseTime: 10), 1, doneAction:2);
}).play;)

(Ndef(\xr, {0.6});)
(Ndef(\yr, {0.3});)
(Ndef(\zr, {0.6});)
(Ndef(\ar, {0.3});)
(Ndef(\ar, {0.225});)
(Ndef(\ar, {0.2});)
(Ndef(\ar, {0.3});)
(Ndef(\ar, {0.225});)
(Ndef(\ar, {0.2});)
(Ndef(\br, {0.4});)
(Ndef(\cr, {0.5});)
(Ndef(\cr, {0.9});)

(
Ndef(\x).fadeTime = 1;
Ndef(\y).fadeTime = 5;
Ndef(\z).fadeTime = 5;
Ndef(\b).fadeTime = 10;
Ndef(\c).fadeTime = 10;
Ndef(\a).fadeTime = 10;
)

(Ndef(\x).release;)
(Ndef(\y).release;)
(Ndef(\z).release;)
(Ndef(\b).release;)
(Ndef(\c).release;)
(Ndef(\a).release;)
