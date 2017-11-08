From: binh.nguyen.uw@rvc.renesas.com (Binh Thanh. Nguyen)
Date: Wed, 8 Nov 2017 07:26:29 +0000
Subject: [cip-dev] B@D run on Renesas board - issue
In-Reply-To: <014601d356a5$9a4349d0$cec9dd70$@toshiba.co.jp>
References: <d06c1efd762e425b9fdbc5c263747828@RVC-EX13-M02.rvc.renesas.com>
	<87k1z7nyad.fsf@ctlt579.codethink.co.uk>
	<014601d356a5$9a4349d0$cec9dd70$@toshiba.co.jp>
Message-ID: <6877e93fc5e444439fbe2bbf763f2b47@RVC-EX13-M02.rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel, Robert,

> Subject: RE: B at D run on Renesas board - issue
> 
> Hello Binh-san,
> 
> > -----Original Message-----
> > From: Robert Marshall [mailto:robert.marshall at codethink.co.uk]
> > Sent: Saturday, November 04, 2017 1:05 AM
> > To: Binh Thanh. Nguyen
> > Cc: Daniel Sangorrin; O365-Toru Oishi; Chris Paterson; Trung. Huynh;
> > cip-dev at lists.cip-project.org
> > Subject: Re: B at D run on Renesas board - issue
> >
> > "Binh Thanh. Nguyen" <binh.nguyen.uw@rvc.renesas.com> writes:
> >
> > > Hello Daniel, Robert,
> > >
> > > We are facing an issue when trying to run healthcheck using B at D on
> Renesas board.
> > > I would like to attach the log and the healthcheck script (we
> > > modified the healthcheck from Daniel)
> > >
> > > The boot action was passed, but after that, look like LAVA cannot
> > > send command to Board, only send "#" (it supposed to be "uname").
> > > I wonder if you met same issue before?
> > > And if possible, please give us any hints you may have for debugging this
> issue!
> > >
> > > Best regards,
> > > Binh Nguyen
> >
> > Thanh
> >
> > Sorry for the delay in responding!
> >
> > That test is missing a deploy section (all commented out) are you
> > trying to make the test too minimal? LAVA tends to swallow output if
> > it is what is expected.
> >
> > Robert
> 
> As Robert said, please do not comment out the deploy section. LAVA does not
> just deploy the binaries as they are, it also copies some scripts (LAVA Test
> shell) into the ramdisk (or network filesystem).
> # LAVA does not use scp (or a serial protocol) to copy them into the target
> 
> For deploying you need a PDU (remote power switch). If you don't have one
> you need to buy one and then add the corresponding commands.
> # Note: I use an IP Power 9258 remote PDU.
> # Note: do not think you can get around without a PDU*

Thank you for your feedback.
We are now purchasing the PDU.

> 
> Thanks,
> Daniel
> 
> *There are ways to do it but they have limitations
> https://validation.linaro.org/static/docs/v2/dispatcher-design.html#primary-
> connection
> 
> 
> 
> 

Best regards,
Binh Nguyen
