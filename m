From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 5 Oct 2017 20:37:21 +0000
Subject: [cip-dev] [PATCH 00/15] Add GPIO,
 EthernetAVB and MMC support for iWave G20D-Q7 board
In-Reply-To: <1507135114.26687.18.camel@codethink.co.uk>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
	<1507135114.26687.18.camel@codethink.co.uk>
Message-ID: <TY1PR06MB0702F2BD4E4A11A9C2E4714CB7700@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 04 October 2017 17:39
> 
> On Fri, 2017-09-29 at 18:28 +0100, Chris Paterson wrote:
> > This patch series adds support for a number of interfaces to the iWave
> > iwg20d-q7 (CIP reference) board which is based on the Renesas r8a7743
> SoC.
> >
> > Support is added for GPIO, EthernetAVB and MMC. In addition there is a
> > patch to add low-level debug support.
> >
> > This series completes the basic platform support for the Renesas CIP
> > reference platform allowing users to get the platform up and running.
> >
> > This patch series applies cleanly to and is tested on linux-4.4.y-cip
> 1e2ef7cc8.
> 
> This all looks good.  I've applied these patches locally and will push out soon.

Thank you!

> 
> I booted it on my board and confirm that Ethernet and eMMC are now
> working. 

Thanks for checking, it's good to know that you've got the h/w up and running.

> However, I had to enable EXT4_FS because shmobile_defconfig
> doesn't.  That seems like an (upstream) bug.

Yep. shmobile_defconfig omits EXT4_FS. I keep meaning to ask why...
 
Kind regards, Chris

> 
> Ben.
> 
> >
> >
> > Biju Das (7):
> >   ARM: dts: iwg20d-q7: Add pinctl support for scif0
> >   gpio: rcar: Add R8A7743 (RZ/G1M) support
> >   ARM: dts: r8a7743: Add GPIO support
> >   dt-bindings: net: ravb : Add support for r8a7743 SoC
> >   ARM: shmobile: defconfig: Enable Ethernet AVB
> >   ARM: dts: r8a7743: Add Ethernet AVB support
> >   ARM: dts: iwg20d-q7: Add Ethernet AVB support
> >
> > Chris Paterson (4):
> >   dt-bindings: mmc: sh_mmcif: Document r8a7743 DT bindings
> >   ARM: dts: r8a7743: Add MMCIF0 support
> >   ARM: dts: iwg20m: Add MMCIF0 support
> >   ARM: debug-ll: Add support for r8a7743
> >
> > Geert Uytterhoeven (2):
> >   pinctrl: sh-pfc: r8a7791: Add missing mmc_data8_b pin group
> >   ARM: dts: iwg20m: Correct indentation of mmcif0 properties
> >
> > Sergei Shtylyov (1):
> >   ARM: dts: r8a7743: add PFC support
> >
> > Simon Horman (1):
> >   ravb: add fallback compatibility strings
> >
> >  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
> >  .../devicetree/bindings/mmc/renesas,mmcif.txt      |   1 +
> >  .../devicetree/bindings/net/renesas,ravb.txt       |  20 ++-
> >  arch/arm/Kconfig.debug                             |   8 +-
> >  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |  31 +++++
> >  arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  26 ++++
> >  arch/arm/boot/dts/r8a7743.dtsi                     | 146
> ++++++++++++++++++++-
> >  arch/arm/configs/shmobile_defconfig                |   1 +
> >  drivers/gpio/gpio-rcar.c                           |   4 +
> >  drivers/net/ethernet/renesas/ravb_main.c           |   2 +
> >  drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |  15 ++-
> >  11 files changed, 245 insertions(+), 10 deletions(-)
> >
> 
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
> 
