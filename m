From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 30 May 2018 15:58:11 +0000
Subject: [cip-dev] [PATCH 4/7] ARM: dts: iwg20d-q7-dbcm-ca: Add HDMI
 video output
In-Reply-To: <1527695157.2289.13.camel@codethink.co.uk>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1526383197-5913-5-git-send-email-fabrizio.castro@bp.renesas.com>
	<1527695157.2289.13.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17707FC1E86F96878998CA8EC06C0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

Thank you for your feedback.

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 30 May 2018 16:46
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [cip-dev][PATCH 4/7] ARM: dts: iwg20d-q7-dbcm-ca: Add HDMI video output
>
> On Tue, 2018-05-15 at 12:19 +0100, Fabrizio Castro wrote:
> > Although there is a HDMI connector on the q7 carrier board it is not
> > connected to the RZ/G1M SoC. One must use the HDMI connector on the
> > camera daughter board.
> >
> > This patch adds support for this connector.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > (cherry picked from commit 55cce0a07678e5fe21c7f81cc437653b485a712c)
> > (taken out interrupt support)
>
> Why is that?  Is it a limitation of the GPIO driver in 4.4?

>From the cover letter this patch belongs to:
" I had to take out interrupt (hotplug) support from the hdmi DT node as
it looks like commit 9183e45db7774716d056319c237a4185baba19c7 introduced
"connector" data field with struct adv7511, but drm_connector_init was
left behind, and as such connector.dev is NULL, and that causes issues
to function adv7511_hpd_work, preventing HDMI hotplug from working
properly.

While investigating HDMI hotplugging, I have found out that when using
a GPIO purely as an interrupt source the corresponding GPIO module
clock is not enabled, therefore this series backports the fix for this.
I yet have to check if this fix is any good to 4.4 LTS, I'll send it to
stable at vger.kernel.org in case it works for 4.4 LTS too."

I have dropped the fix for the gpio driver from this series (patches 6 and 7), and I have reworked it to make it suitable for 4.4 stable, and I have sent it to Greg (he has taken it already).
You were in copy in the email to Greg, I guess you will get to it at some point later today.
We are going to leave HDMI hotplugging disabled for now as the HDMI transmitter driver needs proper fixing, and we don't have time for this just now.

Thanks,
Fab

>
> Ben.
>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> [...]
>
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
> We respect your privacy.   See https://www.codethink.co.uk/privacy.html



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
