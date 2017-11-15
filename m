From: trung.huynh.uw@rvc.renesas.com (Trung. Huynh)
Date: Wed, 15 Nov 2017 10:21:02 +0000
Subject: [cip-dev] B@D run on Renesas board - issue
In-Reply-To: <014601d356a5$9a4349d0$cec9dd70$@toshiba.co.jp>
References: <d06c1efd762e425b9fdbc5c263747828@RVC-EX13-M02.rvc.renesas.com>
	<87k1z7nyad.fsf@ctlt579.codethink.co.uk>
	<014601d356a5$9a4349d0$cec9dd70$@toshiba.co.jp>
Message-ID: <8a55899a02944c42911a1d0ec002d703@RVC-EX13-M02.rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel, Robert,

We got into test section already, but have no idea why it attempts to execute the thing non-exist at all:
# /lava-237/bin/lava-test-runner /lava-237/0
as you can see our error log in attachment.
I also take example log over here https://gitlab.com/snippets/1679749
to see that it can create a directory by mkdir /lava-1

Could you please tell us what does it make scene? How can we fix it?
Thank you.

P/S: healthcheck script same as Binh-san attached to you before

Best Regards,
Trung

-----Original Message-----
From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp] 
Sent: Monday, November 6, 2017 9:19 AM
To: 'Robert Marshall' <robert.marshall@codethink.co.uk>; Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>
Cc: O365-Toru Oishi <toru.oishi.zj@renesas.com>; 'Chris Paterson' <Chris.Paterson2@renesas.com>; Trung. Huynh <trung.huynh.uw@rvc.renesas.com>; cip-dev at lists.cip-project.org
Subject: RE: B at D run on Renesas board - issue

Hello Binh-san,

> -----Original Message-----
> From: Robert Marshall [mailto:robert.marshall at codethink.co.uk]
> Sent: Saturday, November 04, 2017 1:05 AM
> To: Binh Thanh. Nguyen
> Cc: Daniel Sangorrin; O365-Toru Oishi; Chris Paterson; Trung. Huynh; 
> cip-dev at lists.cip-project.org
> Subject: Re: B at D run on Renesas board - issue
> 
> "Binh Thanh. Nguyen" <binh.nguyen.uw@rvc.renesas.com> writes:
> 
> > Hello Daniel, Robert,
> >
> > We are facing an issue when trying to run healthcheck using B at D on Renesas board.
> > I would like to attach the log and the healthcheck script (we 
> > modified the healthcheck from Daniel)
> >
> > The boot action was passed, but after that, look like LAVA cannot 
> > send command to Board, only send "#" (it supposed to be "uname").
> > I wonder if you met same issue before?
> > And if possible, please give us any hints you may have for debugging this issue!
> >
> > Best regards,
> > Binh Nguyen
> 
> Thanh
> 
> Sorry for the delay in responding!
> 
> That test is missing a deploy section (all commented out) are you 
> trying to make the test too minimal? LAVA tends to swallow output if 
> it is what is expected.
> 
> Robert

As Robert said, please do not comment out the deploy section. LAVA does not just deploy the binaries as they are, it also copies some scripts (LAVA Test shell) into the ramdisk (or network filesystem).
# LAVA does not use scp (or a serial protocol) to copy them into the target

For deploying you need a PDU (remote power switch). If you don't have one you need to buy one and then add the corresponding commands. 
# Note: I use an IP Power 9258 remote PDU.
# Note: do not think you can get around without a PDU*

Thanks,
Daniel

*There are ways to do it but they have limitations https://validation.linaro.org/static/docs/v2/dispatcher-design.html#primary-connection





-------------- next part --------------
A non-text attachment was scrubbed...
Name: Capture.jpg
Type: image/jpeg
Size: 132077 bytes
Desc: Capture.jpg
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20171115/0251a3ad/attachment-0001.jpg>
