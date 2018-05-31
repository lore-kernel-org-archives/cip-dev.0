From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 31 May 2018 08:49:32 +0000
Subject: [cip-dev] [PATCH v2 07/11] ARM: dts: r8a7743: Add thermal
	device to DT
In-Reply-To: <1527705846.2289.31.camel@codethink.co.uk>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
	<1527701767-41785-8-git-send-email-biju.das@bp.renesas.com>
	<1527705846.2289.31.camel@codethink.co.uk>
Message-ID: <OSBPR01MB21032DB52F1AA9CB7D55B3CBB8630@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Thanks for the feedback.

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 30 May 2018 19:44
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; cip-dev at lists.cip-project.org
> Subject: Re: [PATCH v2 07/11] ARM: dts: r8a7743: Add thermal device to DT
>
> On Wed, 2018-05-30 at 18:36 +0100, Biju Das wrote:
> > This patch instantiates the thermal sensor module with thermal-zone
> > support.
>
> The thermal-zones node this adds was later moved by commit b9db3affbcdc
> ("ARM: dts: r8a7743: move timer and thermal-zones nodes out of bus").
> Do you think that is worth applying too?

I believe this patch is to fix the "make dtbs W=1" warnings which is not triggered with 4.4 kernel.
Other than thermal-zones, we also need to move timer nodes  out of bus.
There is another patch in upstream which is for sorting nodes.
I think we can combine this 2 patches at later stage.
What is your thoughts on this?

[>] regards,
Biju

> > This patch is based on the commit cac68a56e34b
> > ("ARM: dts: r8a7791: enable to use thermal-zone") by Kuninori Morimoto.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au> (cherry
> > picked from commit 6c76b4f7d89e89f0ae405dfc7a64c6d2b5d02813)
> > (updated clocks and power-domains property.removed resets property)
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> [...]
>



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
