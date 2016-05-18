(s.reboot; s.meter;)

(
  ~barry = Array.new;
  ~barry2 = Array.new;
  ~barry3 = Array.new;
  ~barry4 = Array.new;
  ~barry5 = Array.new;
  ~barry6 = Array.new;
  ~folder = PathName.new("~/Producing/duplicates/48/wav/");
  ~folder2 = PathName.new("~/Producing/feb22-2016/n/");
  ~folder3 = PathName.new("~/Producing/march7th-2016/ubuntu/1/");
  ~folder4 = PathName.new("~/Producing/march15th-2016/rh/1/");
  ~folder5 = PathName.new("~/Producing/April5th-2016/samples/");
)

(
  ~folder.entries.do({
    arg path;
    ~barry = ~barry.add(Buffer.read(s, path.fullPath));
  });
  ~folder2.entries.do({
    arg path;
    ~barry2 = ~barry2.add(Buffer.read(s, path.fullPath));
  });
  ~folder3.entries.do({
    arg path;
    ~barry3 = ~barry3.add(Buffer.read(s, path.fullPath));
  });
  ~folder4.entries.do({
    arg path;
    ~barry4 = ~barry4.add(Buffer.read(s, path.fullPath));
  });
  ~folder5.entries.do({
    arg path;
    ~barry5 = ~barry5.add(Buffer.read(s, path.fullPath));
  });
  ~folder5.entries.do({
    arg path;
    ~barry6 = ~barry6.add(Buffer.read(s, path.fullPath));
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
///////////////////////////////////////////// 3
 SynthDef.new(\pbuf3,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=10.0, lpf=2000, hpf=1000;
 var sig;
  sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  sig = [sig, sig] * amp;
  sig = LPF.ar(sig, freq: lpf);
  sig = HPF.ar(sig, freq: hpf);
  Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
 SynthDef.new(\pbufmono3,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=10.0, lpf=2000, hpf=1000;
  var sig;
  sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  sig = [sig, sig] * amp;
  sig = LPF.ar(sig, freq: lpf);
  sig = HPF.ar(sig, freq: hpf);
  Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
 SynthDef.new(\pgrain3, {
  arg amp=1, mamp=1, out=0, buf, dur=1, rate=1, trig, cpos, att=10.0, gate=1, lpf=2000, hpf=1000;
  var sig;
  sig = TGrains.ar(2, Impulse.ar(trig), buf, rate, centerPos: cpos,dur: dur, pan: 0, amp: amp, interp: 2 );
  sig = LPF.ar(sig, freq: lpf);
  sig = HPF.ar(sig, freq: hpf);
  sig = sig * EnvGen.kr(Env.asr(attackTime:att, curve:1), gate, doneAction: 2);
  Out.ar(out, sig * mamp);
 }).add;
///////////////////////////////////////////////////////////// 4
 SynthDef.new(\pbuf4,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=10.0, lpf=2000, hpf=1000;
  var sig;
  sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  sig = [sig, sig] * amp;
  sig = LPF.ar(sig, freq: lpf);
  sig = HPF.ar(sig, freq: hpf);
  Out.ar(out, sig * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
///////////////////////////////////////////////////////////// 5
SynthDef.new(\pbuf5,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=1, rate=1, da=2, gate=1, att=10.0, room=1, mix=1, damp=1;
  var sig;
  sig = FreeVerb.ar(PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da), mix, room, damp);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
 SynthDef.new(\pbufm5,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=1, rate=1, da=2, gate=1, att=10.0, room=1, mix=1, damp=1;
  var sig;
  sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  sig = Pan2.ar(sig, 0, 1);
  sig = FreeVerb.ar(sig, mix, room, damp);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
///////////////////////////////////////////////////////////// 6
 SynthDef.new(\pbuf6,{
  arg amp=1, out=0, buf, t_trig=1, start=0, loop=1, rate=1, da=2, gate=1, att=10.0, room=1, mix=1, damp=1;
  var sig;
  sig = FreeVerb.ar(PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da), mix, room, damp);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
 SynthDef.new(\pbufm6,{
   arg amp=1, out=0, buf, t_trig=1, start=0, loop=1, rate=1, da=2, gate=1, att=10.0, room=1, mix=1, damp=1;
   var sig;
   sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
   sig = Pan2.ar(sig, 0, 1);
   sig = FreeVerb.ar(sig, mix, room, damp);
   Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
 SynthDef.new(\pbufmnr6,{
 arg amp=1, out=0, buf, t_trig=1, start=0, loop=0, rate=1, da=2, gate=1, att=3;
  var sig;
  sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
  sig = Pan2.ar(sig, 0, 1);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
 }).add;
)

(g = Group.new;)
(~reverbBus = Bus.audio(s, 2);)
(~reverbBus2 = Bus.audio(s, 4);)
(r = Synth.new(\reverb, [\in, ~reverbBus],g);)
(h = Synth.new(\reverb, [\in, ~reverbBus2],g);)

// 1

(x = Synth.new(\pbuf, [\buf, ~barry[1], \da, 0, \rate, 0.4, \start, s.sampleRate/4, \loop, 1, \amp, 2, \lpf, 1500, \hpf, 150], g);)
(y = Synth.new(\pbuf, [\buf, ~barry[1], \da, 0, \rate, 0.5, \loop, 1, \att, 1, \lpf, 3000, \hpf, 50], g);)
(z = Synth.new(\pbuf, [\buf, ~barry[1], \da, 0, \rate, 0.8, \start, s.sampleRate/8, \loop, 1,\att,1, \amp, 1, \lpf, 2000, \hpf, 40], g);)
(a = Synth.new(\pbuf, [\buf, ~barry[0], \da, 0, \rate, 0.2, \loop, 1, \amp, 2, \lpf, 3000, \hpf, 50], g);)
(b = Synth.new(\pbuf, [\buf, ~barry[0], \da, 0, \rate, 0.4, \start, s.sampleRate/2, \loop, 1, \amp, 1, \lpf, 5000, \hpf, 40], g);)
(c = Synth.new(\pbuf, [\buf, ~barry[1], \da, 0, \loop, 1, \att, 1, \lpf, 800, \hpf, 350], g);)
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

// 2

(x = Synth.new(\pbuf, [\buf, ~barry2[2], \rate, 0.4, \loop, 1, \out, ~reverbBus, \lpf, 4000, \hpf, 100, \amp, 0.8 ],g);)
(y = Synth.new(\pbufmono, [\buf, ~barry2[5], \rate, 0.5, \loop, 1, \out, ~reverbBus2, \lpf, 2000, \hpf, 50, \amp, 0.93],g);)
(x.release(10);)
(x = Synth.new(\pbuf, [\buf, ~barry2[2], \rate, 0.3, \loop, 1, \out, ~reverbBus, \lpf, 3000, \hpf, 100, \amp, 0.8],g);)
(y.release(10);)
(y = Synth.new(\pbufmono, [\buf, ~barry2[5], \rate, 0.3, \loop, 1, \out, ~reverbBus2, \lpf,2000, \hpf, 30, \amp, 0.93],g);)
(x.release(10);)
(x = Synth.new(\pbuf, [\buf, ~barry2[2], \rate, 0.27, \loop, 1, \out, ~reverbBus, \lpf, 4000, \hpf, 80, \amp, 0.8],g);)
(x.release(10);)
(x = Synth.new(\pbuf, [\buf, ~barry2[2], \rate, 0.2, \loop, 1, \out, ~reverbBus, \lpf, 3500,\hpf, 100, \amp, 0.8  ],g);)
(z = Synth.new(\pgrain, [\buf, ~barry2[6], \dur, 25, \rate, 0.8, \trig, 0.165, \cpos, 1222, \out, ~reverbBus, \amp, 0.9], g);)
(y.release(10);)
(x.release(10);)
(z.release(20);)

// 3

(x = Synth.new(\pbufmono3, [\buf, ~barry3[2], \rate, 0.45, \loop, 1, \out, ~reverbBus, \lpf, 2000, \hpf, 80, \amp, 0.8 ],g); )
(y = Synth.new(\pbufmono3, [\buf, ~barry3[1], \rate, 0.85, \loop, 1, \out, ~reverbBus2, \lpf, 2000, \hpf, 200, \amp, 1.70],g);)
(x.set(\rate, 0.60);)
(y.set(\rate, 0.75);)
(y.set(\rate, 0.650);)
(b = Synth.new(\pbuf3, [\buf, ~barry3[5], \rate, 0.85, \loop, 1, \lpf, 19000, \hpf, 3000, \amp, 0.15],g);)
(y.release(10);)
(z = Synth.new(\pgrain3, [\buf, ~barry3[3], \dur, 10, \rate, 1.5, \trig, 0.075, \cpos, 0222, \out, ~reverbBus2, \mamp, 6.0], g);)
(x.set(\rate, 0.65); z.set(\rate, 1.4, \trig, 0.065); b.set(\loop, 0);)
(z.release(1);)
(x.set(\rate, 0.40);)
(z = Synth.new(\pgrain3, [\buf, ~barry3[3], \dur, 10, \rate, 6.5, \trig, 0.045, \cpos, 0222, \out, ~reverbBus2, \mamp, 3.0], g);)
(b = Synth.new(\pbuf3, [\buf, ~barry3[5], \rate, 1.00, \loop, 1, \out, ~reverbBus2, \lpf, 19000, \hpf, 3000, \amp, 0.15],g);)
(z.set(\rate, 28, \mamp, 2.85);)
(z.set(\rate, 38);)
(z.set(\rate, 0.5, \amp, 7, \mamp, 8, \trig, 1.08, \lpf, 500);)
(b.set(\loop, 0);)
(x.release(10);)
(z.release(25);)

// 4

(x = Synth.new(\pbuf4, [\buf, ~barry4[0], \rate, 0.80, \loop, 1, \out, ~reverbBus, \lpf, 1000, \hpf, 60, \amp, 0.7 ],g);)
(y = Synth.new(\pbuf4, [\buf, ~barry4[3], \rate, 1.25, \loop, 1, \out, ~reverbBus2, \lpf, 6000, \hpf, 800, \amp, 0.8],g);)
(z = Synth.new(\pbuf4, [\buf, ~barry4[1], \rate, 1.8, \loop, 1, \out, ~reverbBus, \lpf, 2000, \hpf, 200, \amp, 0.8],g);)
(z.set(\rate, 1.4);)
(x.set(\rate, 0.82);)
(y.release(10);)
(z.set(\rate, 1.0);)
(x.set(\rate, 0.7);)
(a = Synth.new(\pbuf4, [\buf, ~barry4[2], \rate, 2.0, \loop, 1, \out, ~reverbBus2, \lpf, 3500, \hpf, 150, \amp, 1.0],g);)
(y = Synth.new(\pbuf4, [\buf, ~barry4[3], \rate, 1.05, \loop, 1, \out, ~reverbBus2, \lpf, 6000, \hpf, 3000, \amp, 0.8],g);)
(x.release(10);)
(z.set(\rate, 0.8);)
(a.set(\rate, 0.8);)
(y.set(\rate, 1.2);)
(z.release(20);)
(y.release(10);)
(a.release(20);)

// 5

(a = Synth.new(\pbufm5, [\buf, ~barry5[0], \amp, 0.7]);)
(b = Synth.new(\pbufm5, [\buf, ~barry5[0], \rate, 0.5, \amp, 0.8]);)
(a.set(\rate, 0.8);)
(a.set(\rate, 0.4);)
(c = Synth.new(\pbufm5, [\buf, ~barry5[1], \rate, 1.2, \amp, 1.1]);)
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

// 6
(a = Synth.new(\pbuf6, [\buf, ~barry6[3], \rate, 0.7, \amp, 1.2]);)
(b = Synth.new(\pbufm6, [\buf, ~barry6[4], \amp, 0.7]);)
(c = Synth.new(\pbufmnr6, [\buf, ~barry6[5]]);)
(a.set(\rate, 0.5);)
(b.set(\rate, 0.8);)
(c = Synth.new(\pbufmnr6, [\buf, ~barry6[5], \rate, 0.5]);)
(a.release(20);)
(b.release(20);)
