From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Fri, 26 Apr 2019 10:34:54 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
References: <TYAPR01MB2495C0F184E13F7CEB083670D9560@TYAPR01MB2495.jpnprd01.prod.outlook.com>
	<20190402064536.4g5pmetmd6vzzvo7@MD1ZFJVC.ad001.siemens.net>
Message-ID: <TYAPR01MB2495BCF41A8836204789CADED93E0@TYAPR01MB2495.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Christian,

Sorry for my late reply.
I was a little busy with work unrelated to CIP.

I tried Lua handler and I was able to understand it a little.
I referred to the following example.
<https://github.com/andi8086/meta-iot2000/blob/iot2000-ebg-swu/meta-iot2000-example/recipes-support/swupdate/swupdate/swupdate_handlers.lua>

I made "sw-description" and "swupdate_handlers.lua" for BBB.
They are working fine for now.
BTW, I needed to patch "0001-Fix-Lua-handler-issue.patch" to SWUpdate.

I think I'm ready, so I'd like to have a meeting with you.
However, Japan has consecutive national holidays from tomorrow to May 6th.
Could you please wait until the holidays end?
After the holidays, I'll let you know my several convenient time for the meeting.

Best regards,
Suzuki

> -----Original Message-----
> From: suzuki akihiro(???? ???? ????????????????)
> Sent: Tuesday, April 02, 2019 5:14 PM
> To: Christian Storm <christian.storm@siemens.com>; cip-dev at lists.cip-project.org
> Subject: RE: [cip-dev] CIP IRC weekly meeting today
> 
> Hi Christian,
> 
> > > > OK, then I'd propose having a meeting about this so that I can explain how this
> > > > variant works and how we make use of it. When do you think you'll come to this
> > > > point so that a meeting makes sense?
> > >
> > > Thank you for your proposal.
> > > Just in case, please let me make sure the meaning of your proposal.
> > >
> > > Which one did you mean?
> > >
> > >   (A) In a meeting, you will tell me about how to use Lua handler for the A/B update.
> > >   (B) I should have a meeting after I implemented the A/B update by using Lua handler.
> > >
> > > If you meant (A), I'd like some time, 1 or 2 weeks, to try Lua before the meeting
> > > because I haven't used it.
> > >
> > > If you meant (B), I will have a meeting after implementing it,
> > > but maybe the implementation (and tests) will take at least 1 month.
> >
> > I meant (A) to spare you (re)exploring the path I went :)
> > I'd like to show off some features you may find useful along the way as
> > well. Just let me know when you're ready and I'll setup the metting
> > then.
> 
> OK, I see. Thanks a lot!
> I'll let you know when I'm ready.
> 
> Best regards,
> Suzuki
> 
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Christian
> > Storm
> > Sent: Tuesday, April 02, 2019 3:46 PM
> > To: cip-dev at lists.cip-project.org
> > Subject: Re: [cip-dev] CIP IRC weekly meeting today
> >
> > Hi Suzuki,
> >
> > > > > > Ah, OK. This is the "official" in the sense of exemplary implemented way
> > > > > > how to do round-robin A/B firmware update. That said, this is in my very
> > > > > > personal opinion a bit too involved and spread out over too many places.
> > > > > > That was also one reason I brought forward the Lua handler feature that
> > > > > > allows you to implement a handler in Lua. Lua handlers are feature-wise
> > > > > > on par with C handlers by now, i.e., they are equally powerful. So, you
> > > > > > can write a Lua handler that does the target partition round-robin
> > > > > > calculation, flashing, and updating of the bootloader environment in one
> > > > > > place. The sw-description becomes simpler as well since you don't need
> > > > > > to specify the A/B layout there but instead the Lua handler will take
> > > > > > care of this.
> > > > > That makes sense.
> > > > > I thought that the A/B update way adopted by meta-swupdate-boards was
> > > > > a little difficult to understand and not very flexible.
> > > > > I would like to use Lua handler to implement the flexible A/B update
> > > > > which can be used in various situations.
> > > >
> > > > OK, then I'd propose having a meeting about this so that I can explain how this
> > > > variant works and how we make use of it. When do you think you'll come to this
> > > > point so that a meeting makes sense?
> > >
> > > Thank you for your proposal.
> > > Just in case, please let me make sure the meaning of your proposal.
> > >
> > > Which one did you mean?
> > >
> > >   (A) In a meeting, you will tell me about how to use Lua handler for the A/B update.
> > >   (B) I should have a meeting after I implemented the A/B update by using Lua handler.
> > >
> > > If you meant (A), I'd like some time, 1 or 2 weeks, to try Lua before the meeting
> > > because I haven't used it.
> > >
> > > If you meant (B), I will have a meeting after implementing it,
> > > but maybe the implementation (and tests) will take at least 1 month.
> >
> > I meant (A) to spare you (re)exploring the path I went :)
> > I'd like to show off some features you may find useful along the way as
> > well. Just let me know when you're ready and I'll setup the metting
> > then.
> >
> >
> > Kind regards,
> >    Christian
> >
> > --
> > Dr. Christian Storm
> > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > Otto-Hahn-Ring 6, 81739 M??nchen, Germany
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sw-description
Type: application/octet-stream
Size: 201 bytes
Desc: sw-description
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190426/2734cf4a/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: swupdate_handlers.lua
Type: application/octet-stream
Size: 2294 bytes
Desc: swupdate_handlers.lua
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190426/2734cf4a/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Fix-Lua-handler-issue.patch
Type: application/octet-stream
Size: 1478 bytes
Desc: 0001-Fix-Lua-handler-issue.patch
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190426/2734cf4a/attachment-0002.obj>
