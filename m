From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 15 Mar 2018 14:33:37 +0000
Subject: [cip-dev] [PATCH 09/15] serial: sh-sci: Add pin initialization
 for SCIFA/SCIFB
In-Reply-To: <1520871976.23626.79.camel@codethink.co.uk>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520247731-25239-10-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520871976.23626.79.camel@codethink.co.uk>
Message-ID: <TYXPR01MB1775A455092699B98F41D92DC0D00@TYXPR01MB1775.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> Subject: Re: [cip-dev][PATCH 09/15] serial: sh-sci: Add pin initialization for SCIFA/SCIFB
>
> [This sender failed our fraud detection checks and may not be who they appear to be. Learn about spoofing at
> http://aka.ms/LearnAboutSpoofing]
>
> On Mon, 2018-03-05 at 11:02 +0000, Fabrizio Castro wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Before, the driver relied on initialization by the boot loader, or by
> > implicit reset state.
> >
> > Note that unlike on (H)SCIF, the RTS/CTS bits exist only if dedicated
> > RTS/CTS pins are available, which depends on the SoC and UART instance.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > (cherry picked from commit e9d7a45a039913497a57887d85f5decfda4679f0)
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> [...]
>
> Shouldn't we also take:
>
> 5f76895e4c71 serial: sh-sci: Fix late enablement of AUTORTS
> cfa6eb239154 serial: sh-sci: Fix (AUTO)RTS in sci_init_pins()

I had a quick look at those patches before submitting the series, and it looks
like the second patch comes with a little bit of baggage (more backporting),
and I wasn't sure where to draw the line.
If you feel like those fixes are necessary I'll backport them, just let me know.

Thanks,
Fab

>
> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
