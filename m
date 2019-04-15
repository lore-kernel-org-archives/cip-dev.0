From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Apr 2019 09:36:53 +0000
Subject: [cip-dev] [PATCH 4.19.y] dt-bindings: irqchip: renesas-irqc:
 Document r8a774c0 support
In-Reply-To: <1553849497-24475-1-git-send-email-biju.das@bp.renesas.com>
References: <1553849497-24475-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <OSBPR01MB2103453B17B90C046BF65C95B82B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

I am not seeing  this patch on 4.19.y-cip? Is this patch ok to you?

Regards,
Biju

> -----Original Message-----
> From: Biju Das <biju.das@bp.renesas.com>
> Sent: 29 March 2019 08:52
> To: cip-dev at lists.cip-project.org
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: [PATCH 4.19.y] dt-bindings: irqchip: renesas-irqc: Document
> r8a774c0 support
> 
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com> (cherry picked from
> commit 24105bf4d10485143f8e26337cda8bcb7f6e6da5)
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt |
> 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-
> controller/renesas,irqc.txt
> index a046ed3..c974b83 100644
> --- a/Documentation/devicetree/bindings/interrupt-
> controller/renesas,irqc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irq
> +++ c.txt
> @@ -14,6 +14,7 @@ Required properties:
>      - "renesas,irqc-r8a7793" (R-Car M2-N)
>      - "renesas,irqc-r8a7794" (R-Car E2)
>      - "renesas,intc-ex-r8a774a1" (RZ/G2M)
> +    - "renesas,intc-ex-r8a774c0" (RZ/G2E)
>      - "renesas,intc-ex-r8a7795" (R-Car H3)
>      - "renesas,intc-ex-r8a7796" (R-Car M3-W)
>      - "renesas,intc-ex-r8a77965" (R-Car M3-N)
> --
> 2.7.4
