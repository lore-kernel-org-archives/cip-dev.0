From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 10 Apr 2018 17:48:07 +0000
Subject: [cip-dev] [RFC/PATCH] dmaengine: ensure dmaengine helpers check
 valid callback
In-Reply-To: <1523380835.2654.192.camel@codethink.co.uk>
References: <1520527545-4515-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1523380835.2654.192.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17701668EE155C036E26483CC0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> Subject: Re: [cip-dev][RFC/PATCH] dmaengine: ensure dmaengine helpers check valid callback
>
> On Thu, 2018-03-08 at 16:45 +0000, Fabrizio Castro wrote:
> > From: Vinod Koul <vinod.koul@intel.com>
> >
> > dmaengine has various device callbacks and exposes helper
> > functions to invoke these. These helpers should check if channel,
> > device and callback is valid or not before invoking them.
> >
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > (cherry picked from commit 757d12e5849be549076901b0d33c60d5f360269c)
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Jianming Qiao <jianming.qiao@bp.renesas.com>
> > ---
> > Hello Ben,
> >
> > we have stumbled upon a problem, and discovered there was this fix
> > upstream we would like to backport.
> >
> > Do you think this should go through v4.4 LTS first or are you happy
> > to take it?
>
> I can apply it now, but if the bug affects 4.4 LTS or other stable
> branches without CIP's extra backports then you should also send it to
> stable at vger.kernel.org.

thank you for the info, I'll check and send an email to stable at vger.kernel.org
if needed.

Thanks,
Fab

>
> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
