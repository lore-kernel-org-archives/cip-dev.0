From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 15 Mar 2018 14:16:36 +0000
Subject: [cip-dev] [PATCH 12/15] ARM: dts: iwg20d-q7: Rework DT
 architecture
In-Reply-To: <1520444946.23626.45.camel@codethink.co.uk>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520247731-25239-13-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520444842.23626.44.camel@codethink.co.uk>
	<1520444946.23626.45.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17709A914340EEB0EBD4380DC0D00@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 07 March 2018 17:49
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [cip-dev][PATCH 12/15] ARM: dts: iwg20d-q7: Rework DT architecture
>
> On Wed, 2018-03-07 at 17:47 +0000, Ben Hutchings wrote:
> > On Mon, 2018-03-05 at 11:02 +0000, Fabrizio Castro wrote:
> > > Since the same carrier board may host RZ/G1M and RZ/G1N based
> > > Systems on Module, the DT architecture for iwg20d-q7 needs
> > > better decoupling. This patch provides:
> > > * iwg20d-q7-common.dtsi - its purpose is to define the carrier
> > >   board definitions, and its content is basically the same
> > >   as the previous version of r8a7743-iwg20d-q7.dts, only it
> > >   has no reference to the SoM .dtsi, and that's why the
> > >   filename doesn't mention the SoC name any more.
> > > * r8a7743-iwg20d-q7.dts - its new purpose is to put together
> > >   the SoM .dtsi (r8a7743-iwg20m.dtsi) and the carrier board
> > >   .dtsi defined by this very patch, along with "model" and
> > >   "compatible" properties.
> > > The final DT architecture to describe the board is now:
> > > r8a7743-iwg20d-q7.dts           # Carrier Board + SoM
> > > ??? r8a7743-iwg20m.dtsi         # SoM
> > > ?   ??? r8a7743.dtsi            # SoC
> > > ??? iwg20d-q7-common.dtsi       # Carrier Board
> > > and maximizes the reuse of the definitions for the carrier board
> > > and for the SoM.
> >
> > I got a conflict at this point.  It looks like this series has to be
> > applied on top of the SDHI changes, which you posted later!  Please be
> > explicit about any such ordering dependencies.
>
> My mistake, you posted the SDHI changes earlier but they got reordered
> in my mailbox.

Ah ok

> Still, please let me know if any patch series you send depends on any other
> patch series that I haven't yet applied.

sorry I'll be more careful

Thanks,
Fab

>
> Ben.
>
> >
> > Ben.
> >
> > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > (cherry picked from commit 4f0b2563c4c0c67fc5b5e2369d5f62f91abc42e7)
> > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > ---
> > >  arch/arm/boot/dts/iwg20d-q7-common.dtsi | 108
> > > ++++++++++++++++++++++++++++++++
> > >  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 100 +---------------------
> > > -------
> > >  2 files changed, 110 insertions(+), 98 deletions(-)
> > >  create mode 100644 arch/arm/boot/dts/iwg20d-q7-common.dtsi
> > >
> > > diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> > > b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> > > new file mode 100644
> > > index 0000000..1a0bb24
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> > > @@ -0,0 +1,108 @@
> > > +/*
> > > + * Device Tree Source for the iWave-RZ/G1M/G1N Qseven carrier board
> > > + *
> > > + * Copyright (C) 2017 Renesas Electronics Corp.
> > > + *
> > > + * This file is licensed under the terms of the GNU General Public
> > > License
> > > + * version 2.  This program is licensed "as is" without any warranty
> > > of any
> > > + * kind, whether express or implied.
> > > + */
> > > +
> > > +/ {
> > > > > +aliases {
> > > > > +serial0 = &scif0;
> > > > > +ethernet0 = &avb;
> > > > > +};
> > > +
> > > > > +vcc_sdhi1: regulator-vcc-sdhi1 {
> > > > > +compatible = "regulator-fixed";
> > > +
> > > > > +regulator-name = "SDHI1 Vcc";
> > > > > +regulator-min-microvolt = <3300000>;
> > > > > +regulator-max-microvolt = <3300000>;
> > > +
> > > > > +gpio = <&gpio1 16 GPIO_ACTIVE_LOW>;
> > > > > +};
> > > +
> > > > > +vccq_sdhi1: regulator-vccq-sdhi1 {
> > > > > +compatible = "regulator-gpio";
> > > +
> > > > > +regulator-name = "SDHI1 VccQ";
> > > > > +regulator-min-microvolt = <1800000>;
> > > > > +regulator-max-microvolt = <3300000>;
> > > +
> > > > > +gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
> > > > > +gpios-states = <1>;
> > > > > +states = <3300000 1
> > > > > +  1800000 0>;
> > > > > +};
> > > +};
> > > +
> > > +&avb {
> > > > > +pinctrl-0 = <&avb_pins>;
> > > > > +pinctrl-names = "default";
> > > +
> > > > > +phy-handle = <&phy3>;
> > > > > +phy-mode = "gmii";
> > > > > +renesas,no-ether-link;
> > > > > +status = "okay";
> > > +
> > > > > > > +phy3: ethernet-phy at 3 {
> > > > > +reg = <3>;
> > > > > +micrel,led-mode = <1>;
> > > > > +};
> > > +};
> > > +
> > > +&i2c2 {
> > > > > +pinctrl-0 = <&i2c2_pins>;
> > > > > +pinctrl-names = "default";
> > > +
> > > > > +status = "okay";
> > > > > +clock-frequency = <400000>;
> > > +
> > > > > +rtc at 68 {
> > > > > +compatible = "bq32000";
> > > > > +reg = <0x68>;
> > > > > +};
> > > +};
> > > +
> > > +&pfc {
> > > > > +avb_pins: avb {
> > > > > +groups = "avb_mdio", "avb_gmii";
> > > > > +function = "avb";
> > > > > +};
> > > +
> > > > > +i2c2_pins: i2c2 {
> > > > > +groups = "i2c2";
> > > > > +function = "i2c2";
> > > > > +};
> > > +
> > > > > +scif0_pins: scif0 {
> > > > > +groups = "scif0_data_d";
> > > > > +function = "scif0";
> > > > > +};
> > > +
> > > > > +sdhi1_pins: sd1 {
> > > > > +groups = "sdhi1_data4", "sdhi1_ctrl";
> > > > > +function = "sdhi1";
> > > > > +power-source = <3300>;
> > > > > +};
> > > +};
> > > +
> > > +&scif0 {
> > > > > +pinctrl-0 = <&scif0_pins>;
> > > > > +pinctrl-names = "default";
> > > +
> > > > > +status = "okay";
> > > +};
> > > +
> > > +&sdhi1 {
> > > > > +pinctrl-0 = <&sdhi1_pins>;
> > > > > +pinctrl-names = "default";
> > > +
> > > > > +vmmc-supply = <&vcc_sdhi1>;
> > > > > +vqmmc-supply = <&vccq_sdhi1>;
> > > > > +cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
> > > > > +wp-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
> > > > > +status = "okay";
> > > +};
> > > diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > > b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > > index 0bd9754..6aa6b74 100644
> > > --- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > > +++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > - * Device Tree Source for the iWave-RZG1M Qseven carrier board
> > > + * Device Tree Source for the iWave-RZ/G1M Qseven board
> > >   *
> > >   * Copyright (C) 2017 Renesas Electronics Corp.
> > >   *
> > > @@ -10,105 +10,9 @@
> > >
> > >  /dts-v1/;
> > >  #include "r8a7743-iwg20m.dtsi"
> > > +#include "iwg20d-q7-common.dtsi"
> > >
> > >  / {
> > > > >  model = "iWave Systems RainboW-G20D-Qseven board based on
> > > RZ/G1M";
> > > > >  compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
> > > -
> > > > > -aliases {
> > > > > -serial0 = &scif0;
> > > > > -ethernet0 = &avb;
> > > > > -};
> > > -
> > > > > -vcc_sdhi1: regulator-vcc-sdhi1 {
> > > > > -compatible = "regulator-fixed";
> > > -
> > > > > -regulator-name = "SDHI1 Vcc";
> > > > > -regulator-min-microvolt = <3300000>;
> > > > > -regulator-max-microvolt = <3300000>;
> > > -
> > > > > -gpio = <&gpio1 16 GPIO_ACTIVE_LOW>;
> > > > > -};
> > > -
> > > > > -vccq_sdhi1: regulator-vccq-sdhi1 {
> > > > > -compatible = "regulator-gpio";
> > > -
> > > > > -regulator-name = "SDHI1 VccQ";
> > > > > -regulator-min-microvolt = <1800000>;
> > > > > -regulator-max-microvolt = <3300000>;
> > > -
> > > > > -gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
> > > > > -gpios-states = <1>;
> > > > > -states = <3300000 1
> > > > > -  1800000 0>;
> > > > > -};
> > > -};
> > > -
> > > -&pfc {
> > > > > -i2c2_pins: i2c2 {
> > > > > -groups = "i2c2";
> > > > > -function = "i2c2";
> > > > > -};
> > > -
> > > > > -scif0_pins: scif0 {
> > > > > -groups = "scif0_data_d";
> > > > > -function = "scif0";
> > > > > -};
> > > -
> > > > > -avb_pins: avb {
> > > > > -groups = "avb_mdio", "avb_gmii";
> > > > > -function = "avb";
> > > > > -};
> > > -
> > > > > -sdhi1_pins: sd1 {
> > > > > -groups = "sdhi1_data4", "sdhi1_ctrl";
> > > > > -function = "sdhi1";
> > > > > -power-source = <3300>;
> > > > > -};
> > > -};
> > > -
> > > -&scif0 {
> > > > > -pinctrl-0 = <&scif0_pins>;
> > > > > -pinctrl-names = "default";
> > > -
> > > > > -status = "okay";
> > > -};
> > > -
> > > -&avb {
> > > > > -pinctrl-0 = <&avb_pins>;
> > > > > -pinctrl-names = "default";
> > > -
> > > > > -phy-handle = <&phy3>;
> > > > > -phy-mode = "gmii";
> > > > > -renesas,no-ether-link;
> > > > > -status = "okay";
> > > -
> > > > > > > -phy3: ethernet-phy at 3 {
> > > > > -reg = <3>;
> > > > > -micrel,led-mode = <1>;
> > > > > -};
> > > -};
> > > -
> > > -&sdhi1 {
> > > > > -pinctrl-0 = <&sdhi1_pins>;
> > > > > -pinctrl-names = "default";
> > > -
> > > > > -vmmc-supply = <&vcc_sdhi1>;
> > > > > -vqmmc-supply = <&vccq_sdhi1>;
> > > > > -cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
> > > > > -wp-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
> > > > > -status = "okay";
> > > -};
> > > -
> > > -&i2c2 {
> > > > > -pinctrl-0 = <&i2c2_pins>;
> > > > > -pinctrl-names = "default";
> > > -
> > > > > -status = "okay";
> > > > > -clock-frequency = <400000>;
> > > -
> > > > > -rtc at 68 {
> > > > > -compatible = "bq32000";
> > > > > -reg = <0x68>;
> > > > > -};
> > >  };
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
