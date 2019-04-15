From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Apr 2019 09:41:06 +0000
Subject: [cip-dev] [PATCH 4.19.y] dt-bindings: irqchip: renesas-irqc:
 Document r8a774c0 support
In-Reply-To: <OSBPR01MB2103453B17B90C046BF65C95B82B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1553849497-24475-1-git-send-email-biju.das@bp.renesas.com>
	<OSBPR01MB2103453B17B90C046BF65C95B82B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB2103ED58F3CED164B076BF17B82B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Sorry for the spam . This patch is present in 4.19.y-cip branch

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-4.19.y-cip&id=eef44be632086621457a233e3844977ac86853a0

regards,
Biju

> -----Original Message-----
> From: Biju Das
> Sent: 15 April 2019 10:37
> To: Biju Das <biju.das@bp.renesas.com>; cip-dev at lists.cip-project.org; Pavel
> Machek <pavel@denx.de>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: RE: [PATCH 4.19.y] dt-bindings: irqchip: renesas-irqc: Document
> r8a774c0 support
> 
> Hi Pavel,
> 
> I am not seeing  this patch on 4.19.y-cip? Is this patch ok to you?
> 
> Regards,
> Biju
> 
> > -----Original Message-----
> > From: Biju Das <biju.das@bp.renesas.com>
> > Sent: 29 March 2019 08:52
> > To: cip-dev at lists.cip-project.org
> > Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> > <biju.das@bp.renesas.com>; Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com>
> > Subject: [PATCH 4.19.y] dt-bindings: irqchip: renesas-irqc: Document
> > r8a774c0 support
> >
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Document RZ/G2E (R8A774C0) SoC bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com> (cherry picked from
> > commit 24105bf4d10485143f8e26337cda8bcb7f6e6da5)
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >
> > Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.tx
> > t |
> > 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-
> > controller/renesas,irqc.txt
> > b/Documentation/devicetree/bindings/interrupt-
> > controller/renesas,irqc.txt
> > index a046ed3..c974b83 100644
> > --- a/Documentation/devicetree/bindings/interrupt-
> > controller/renesas,irqc.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,i
> > +++ rq
> > +++ c.txt
> > @@ -14,6 +14,7 @@ Required properties:
> >      - "renesas,irqc-r8a7793" (R-Car M2-N)
> >      - "renesas,irqc-r8a7794" (R-Car E2)
> >      - "renesas,intc-ex-r8a774a1" (RZ/G2M)
> > +    - "renesas,intc-ex-r8a774c0" (RZ/G2E)
> >      - "renesas,intc-ex-r8a7795" (R-Car H3)
> >      - "renesas,intc-ex-r8a7796" (R-Car M3-W)
> >      - "renesas,intc-ex-r8a77965" (R-Car M3-N)
> > --
> > 2.7.4
