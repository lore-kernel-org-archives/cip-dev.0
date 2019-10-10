From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Thu, 10 Oct 2019 00:32:35 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 0/2] Backport CAN-FD support for
 RZ/G2E
In-Reply-To: <1570637984-22632-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570637984-22632-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <OSAPR01MB3234A6368249CEF67DD8EBE592940@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Fabrizio,

> -----Original Message-----
> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: Thursday, October 10, 2019 1:20 AM
> To: cip-dev at lists.cip-project.org
> Cc: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel at denx.de; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Subject: [cip-dev][PATCH 4.19.y-cip 0/2] Backport CAN-FD support for
> RZ/G2E
> 
> Dear All,
> 
> this series backports what's required for supporting CAN-FD on the RZ/G2E.
> 
> Thanks,
> Fab
> 
> Fabrizio Castro (2):
>   dt-bindings: can: rcar_canfd: document r8a774c0 support
>   arm64: dts: renesas: r8a774c0: Add CANFD support
> 
>  .../devicetree/bindings/net/can/rcar_canfd.txt     | 15
> +++++++------
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 25
> ++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 7 deletions(-)

Applied, thanks.

This patch is being tested.
https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/87780640

Best regards,
  Nobuhiro


> 
> --
> 2.7.4
