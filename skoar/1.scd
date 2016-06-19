(s.reboot;)

(
~barry = Array.new;
~folder = PathName.new("~/Producing/duplicates/48/wav/");
)

(
~folder.entries.do({
  arg path;
  ~barry = ~barry.add(Buffer.read(s, path.fullPath));
});
)

(
SynthDef.new(\pbuf,{
  arg amp=1, out=0, t_trig=1, start=0, loop=1, freq=1, da=2, gate=1, att=1.0, room=1, mix=1, damp=1;
  var sig;
  freq = freq.explin(1, 22000, 0, 2);
  sig = FreeVerb.ar(PlayBuf.ar(2, ~barry[0], BufRateScale.kr(~barry[0]) * freq, t_trig, start, loop, doneAction: da), mix, room, damp);
  Out.ar(out, sig * amp * EnvGen.kr(Env.asr(attackTime:att, curve: 1), gate, doneAction:2));
}).add;
)

(x = "
80 => )

.sampler   @pbuf => @instrument
.sampler2  @pbuf => @instrument
.sampler   [#####] => @amp
.sampler2  [#### ] => @amp

.sampler   <-40, -42, -44, -46, -48, -48>.{: (0:10) :}
.sampler2  <-12, -14, -16, -19, -21, -49>.{: (0:10) :}

.sampler   <-48, -50>.{: (0:30) :}
.sampler2  <-49, -51>.{: (0:30) :}

".skoar.play;
)
