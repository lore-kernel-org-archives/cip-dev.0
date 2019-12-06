From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Sat, 7 Dec 2019 06:48:27 +0900
Subject: [cip-dev] [PATCH 4.4.y-cip 00/12] Add
	CAN/IRQC/THERMAL/VIN/Audio support
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191206214827.i4y7wc565piblhy7@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Biju,

On Fri, Dec 06, 2019 at 12:12:16PM +0000, Biju Das wrote:
> This patch series add CAN/IRQC/THERMAL/VIN/Audio support for iWave iwg20d platform based on RZ/G1N.
> 
> This patch series is based on linux-4.4.y-cip and all the patches in this series are cherry-picked from linux rc tree.
> 
> 
> Biju Das (11):
>   dt-bindings: can: rcar_can: Add r8a7744 support
>   ARM: dts: r8a7744: Add CAN support
>   dt-bindings: irqchip: renesas-irqc: Document r8a7744 support
>   ARM: dts: r8a7744: Add IRQC support
>   dt-bindings: thermal: rcar: Add device tree support for r8a7744
>   ARM: dts: r8a7744: Add thermal device to DT
>   media: dt-bindings: media: rcar_vin: add device tree support for
>     r8a7744
>   ARM: dts: r8a7744: add VIN dt support
>   ASoC: rsnd: Add r8a7744 support
>   ARM: dts: r8a7744: Add audio support
>   ARM: dts: r8a7744-iwg20d-q7-dbcm-ca: Add device tree for camera DB
> 
> Kuninori Morimoto (1):
>   thermal: trip_point_temp_store() calls thermal_zone_device_update()
> 
>  .../bindings/interrupt-controller/renesas,irqc.txt |   1 +
>  .../devicetree/bindings/media/rcar_vin.txt         |   1 +
>  .../devicetree/bindings/net/can/rcar_can.txt       |   1 +
>  .../devicetree/bindings/sound/renesas,rsnd.txt     |   1 +
>  .../devicetree/bindings/thermal/rcar-thermal.txt   |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts    |  17 ++
>  arch/arm/boot/dts/r8a7744.dtsi                     | 334 ++++++++++++++++++++-
>  drivers/thermal/thermal_core.c                     |   6 +-
>  9 files changed, 352 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
> 

Looks good to me. I will apply if there is no other opinion.

Best regards,
  Nobuhiro
