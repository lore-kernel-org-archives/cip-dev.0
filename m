From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 10 Apr 2019 00:33:15 +0000
Subject: [cip-dev] [PATCH 01/10] dt-bindings: arm: Add si-linux
	cat87[45]	boards
In-Reply-To: <1553185339-26890-2-git-send-email-biju.das@bp.renesas.com>
References: <1553185339-26890-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <TYAPR01MB418959737BE35AE5E733FBFE922E0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, all.

> This patch adds board cat874 (powered by the RZ/G2E) and board
> cat875 (that sits on top of cat874). Both boards are made by Silicon Linux.
> 
> backported from commit 1a69a73c9b006ae72 ("dt-bindings: arm: renesas:
> Add si-linux cat87[45] boards")


I applied this series, thanks.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> Sent: Friday, March 22, 2019 1:22 AM
> To: cip-dev at lists.cip-project.org
> Cc: Biju Das <biju.das@bp.renesas.com>
> Subject: [cip-dev] [PATCH 01/10] dt-bindings: arm: Add si-linux cat87[45]
> boards
> 
> This patch adds board cat874 (powered by the RZ/G2E) and board
> cat875 (that sits on top of cat874). Both boards are made by Silicon Linux.
> 
> backported from commit 1a69a73c9b006ae72 ("dt-bindings: arm: renesas:
> Add si-linux cat87[45] boards")
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt
> b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 7b1e257..1556460 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -131,6 +131,10 @@ Boards:
>      compatible = "renesas,salvator-xs", "renesas,r8a7796"
>    - Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
>      compatible = "renesas,salvator-xs", "renesas,r8a77965"
> +  - Silicon Linux RZ/G2E 96board platform (CAT874)
> +    compatible = "si-linux,cat874", "renesas,r8a774c0"
> +  - Silicon Linux sub board for CAT874 (CAT875)
> +    compatible = "si-linux,cat875", "si-linux,cat874",
> "renesas,r8a774c0"
>    - SILK (RTP0RC7794LCB00011S)
>      compatible = "renesas,silk", "renesas,r8a7794"
>    - SK-RZG1E (YR8A77450S000BE)
