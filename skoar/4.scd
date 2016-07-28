("
{! pbuf<t_trig:1, start:0, loop:1, freq:1, da:2, gate:1, att:1.0, room:1, mix:1, damp:1, testparam:1, barry> !!

sig: aFreeVerb<aPlayBuf<2, !barry.at<0>, kBufRateScale<!barry.at<0>> * !testparam, !t_trig, !start, !loop, doneAction: !da>, !mix, !room, !damp>

!sig * kEnvGen<@Env.asr<attackTime:!att, curve: 1>, !gate, doneAction:2>

!}

!pbuf<!barry<0>>
(0:10)

".skoar.play
)

("
{! pbuf<t_trig:1, start:0, loop:1, freq:1, da:2, gate:1, att:1.0, room:1, mix:1, damp:1, testparam:1, barry> !!

sig: aFreeVerb<aPlayBuf<2, !barry.at<0>, kBufRateScale<!barry.at<0>> * !testparam, !t_trig, !start, !loop, doneAction: !da>, !mix, !room, !damp>

!sig * kEnvGen<@Env.asr<attackTime:!att, curve: 1>, !gate, doneAction:2>


!}
barry: @Array.new

folder: @PathName.new<'~/Producing/duplicates/48/wav/'>

!folder.entries.do<{! <path> !! barry: !barry.add<@Buffer.read<@Server.internal, !path.fullPath>> !}>

!pbuf<!barry<0>>
(0:10)

".skoar.play
)
