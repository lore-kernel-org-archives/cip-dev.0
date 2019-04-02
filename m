From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Tue, 2 Apr 2019 08:14:13 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <20190402064536.4g5pmetmd6vzzvo7@MD1ZFJVC.ad001.siemens.net>
References: <TYAPR01MB2495C0F184E13F7CEB083670D9560@TYAPR01MB2495.jpnprd01.prod.outlook.com>
	<20190402064536.4g5pmetmd6vzzvo7@MD1ZFJVC.ad001.siemens.net>
Message-ID: <TYAPR01MB24950FA7691CCEA76E7B9CF2D9560@TYAPR01MB2495.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Christian,

> > > OK, then I'd propose having a meeting about this so that I can explain how this
> > > variant works and how we make use of it. When do you think you'll come to this
> > > point so that a meeting makes sense?
> >
> > Thank you for your proposal.
> > Just in case, please let me make sure the meaning of your proposal.
> >
> > Which one did you mean?
> >
> >   (A) In a meeting, you will tell me about how to use Lua handler for the A/B update.
> >   (B) I should have a meeting after I implemented the A/B update by using Lua handler.
> >
> > If you meant (A), I'd like some time, 1 or 2 weeks, to try Lua before the meeting
> > because I haven't used it.
> >
> > If you meant (B), I will have a meeting after implementing it,
> > but maybe the implementation (and tests) will take at least 1 month.
> 
> I meant (A) to spare you (re)exploring the path I went :)
> I'd like to show off some features you may find useful along the way as
> well. Just let me know when you're ready and I'll setup the metting
> then.

OK, I see. Thanks a lot!
I'll let you know when I'm ready.

Best regards,
Suzuki


> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Christian
> Storm
> Sent: Tuesday, April 02, 2019 3:46 PM
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] CIP IRC weekly meeting today
> 
> Hi Suzuki,
> 
> > > > > Ah, OK. This is the "official" in the sense of exemplary implemented way
> > > > > how to do round-robin A/B firmware update. That said, this is in my very
> > > > > personal opinion a bit too involved and spread out over too many places.
> > > > > That was also one reason I brought forward the Lua handler feature that
> > > > > allows you to implement a handler in Lua. Lua handlers are feature-wise
> > > > > on par with C handlers by now, i.e., they are equally powerful. So, you
> > > > > can write a Lua handler that does the target partition round-robin
> > > > > calculation, flashing, and updating of the bootloader environment in one
> > > > > place. The sw-description becomes simpler as well since you don't need
> > > > > to specify the A/B layout there but instead the Lua handler will take
> > > > > care of this.
> > > > That makes sense.
> > > > I thought that the A/B update way adopted by meta-swupdate-boards was
> > > > a little difficult to understand and not very flexible.
> > > > I would like to use Lua handler to implement the flexible A/B update
> > > > which can be used in various situations.
> > >
> > > OK, then I'd propose having a meeting about this so that I can explain how this
> > > variant works and how we make use of it. When do you think you'll come to this
> > > point so that a meeting makes sense?
> >
> > Thank you for your proposal.
> > Just in case, please let me make sure the meaning of your proposal.
> >
> > Which one did you mean?
> >
> >   (A) In a meeting, you will tell me about how to use Lua handler for the A/B update.
> >   (B) I should have a meeting after I implemented the A/B update by using Lua handler.
> >
> > If you meant (A), I'd like some time, 1 or 2 weeks, to try Lua before the meeting
> > because I haven't used it.
> >
> > If you meant (B), I will have a meeting after implementing it,
> > but maybe the implementation (and tests) will take at least 1 month.
> 
> I meant (A) to spare you (re)exploring the path I went :)
> I'd like to show off some features you may find useful along the way as
> well. Just let me know when you're ready and I'll setup the metting
> then.
> 
> 
> Kind regards,
>    Christian
> 
> --
> Dr. Christian Storm
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Otto-Hahn-Ring 6, 81739 M?nchen, Germany
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
