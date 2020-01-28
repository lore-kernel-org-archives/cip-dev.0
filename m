From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Tue, 28 Jan 2020 01:35:02 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 0/8] Renesas RZ/G2N extend
	peripheral support
In-Reply-To: <1580135157-14117-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580135157-14117-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <OSAPR01MB36672E4211520E4E8749471B920A0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Lad,

> -----Original Message-----
> From: Lad Prabhakar [mailto:prabhakar.mahadev-lad.rj at bp.renesas.com]
> Sent: Monday, January 27, 2020 11:26 PM
> To: cip-dev at lists.cip-project.org; iwamatsu nobuhiro(?? ?? ???
> ?????) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>
> Subject: [PATCH 4.19.y-cip 0/8] Renesas RZ/G2N extend peripheral support
> 
> This patch series adds support for following peripherals supported by
> RZ/G2N, along with adding support for HiHope RZ/G2N sub board
> 1: DMAC
> 2: SCIF/HSCIF
> 3: GPIO controller
> 4: Ethernet controller
> 
> Biju Das (8):
>   dt-bindings: dmaengine: rcar-dmac: Document R8A774B1 bindings
>   arm64: dts: renesas: r8a774b1: Add SYS-DMAC device nodes
>   arm64: dts: renesas: r8a774b1: Add SCIF and HSCIF nodes
>   dt-bindings: gpio: rcar: Add DT binding for r8a774b1
>   arm64: dts: renesas: r8a774b1: Add GPIO device nodes
>   dt-bindings: net: ravb: Add support for r8a774b1 SoC
>   arm64: dts: renesas: r8a774b1: Add Ethernet AVB node
>   arm64: dts: renesas: Add HiHope RZ/G2N sub board support
> 
>  .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
>  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
>  .../devicetree/bindings/net/renesas,ravb.txt       |   1 +
>  arch/arm64/boot/dts/renesas/Makefile               |   1 +
>  .../boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts  |  15 +
>  arch/arm64/boot/dts/renesas/r8a774b1.dtsi          | 381
> ++++++++++++++++++++-
>  6 files changed, 389 insertions(+), 11 deletions(-)  create mode 100644
> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
> 

I reviewd this series, I have no objection to this.
I will apply this if there is no objection from other member.

Best regards,
  Nobuhio.
