From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 23 Aug 2017 07:36:51 +0000
Subject: [cip-dev] [PATCH 01/14] ARM: dts: r8a7743: initial SoC device
	tree
In-Reply-To: <1503425253.2047.148.camel@codethink.co.uk>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
	<1502185828-45443-2-git-send-email-biju.das@bp.renesas.com>
	<1503425253.2047.148.camel@codethink.co.uk>
Message-ID: <KL1PR06MB1702CBCF9CD3050E0102A78AB8850@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 22 August 2017 19:08
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev at lists.cip-
> project.org
> Subject: Re: [PATCH 01/14] ARM: dts: r8a7743: initial SoC device tree
>
> On Tue, 2017-08-08 at 10:50 +0100, Biju Das wrote:
> > The  initial r8A7743 SoC device tree including CPU0, GIC and timer.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>
> I compared this to the upstream version (commit
> 34e8d993a68ae459ad98c27afc07647e439deacc) and I roughly understand why
> the clocks are described differently, but can you explain why there's no soc
> node?

Thanks for the comments.

RZ/G1M(r8a7743) and R-Car M2(r8a7791) are almost identical. To make consistant
with other R-Car Gen2 dtsi patches on 4.4 kernel version, I have dropped the soc node.

Do you see any issues with this approach?

> Ben.
>
> > ---
> >  arch/arm/boot/dts/r8a7743.dtsi | 56
> > ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/r8a7743.dtsi
> >
> > diff --git a/arch/arm/boot/dts/r8a7743.dtsi
> > b/arch/arm/boot/dts/r8a7743.dtsi new file mode 100644 index
> > 0000000..8575a2f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r8a7743.dtsi
> > @@ -0,0 +1,56 @@
> > +/*
> > + * Device Tree Source for the r8a7743 SoC
> > + *
> > + * Copyright (C) 2017 Renesas Electronics Corp.
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > +License
> > + * version 2.  This program is licensed "as is" without any warranty
> > +of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +compatible = "renesas,r8a7743";
> > +interrupt-parent = <&gic>;
> > +#address-cells = <2>;
> > +#size-cells = <2>;
> > +
> > +cpus {
> > +#address-cells = <1>;
> > +#size-cells = <0>;
> > +
> > +cpu0: cpu at 0 {
> > +device_type = "cpu";
> > +compatible = "arm,cortex-a15";
> > +reg = <0>;
> > +clock-frequency = <1500000000>;
> > +};
> > +};
> > +
> > +gic: interrupt-controller at f1001000 {
> > +compatible = "arm,gic-400";
> > +#interrupt-cells = <3>;
> > +#address-cells = <0>;
> > +interrupt-controller;
> > +reg = <0 0xf1001000 0 0x1000>,
> > +      <0 0xf1002000 0 0x1000>,
> > +      <0 0xf1004000 0 0x2000>,
> > +      <0 0xf1006000 0 0x2000>;
> > +interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) |
> > +   IRQ_TYPE_LEVEL_HIGH)>;
> > +};
> > +
> > +timer {
> > +compatible = "arm,armv7-timer";
> > +interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(2) |
> > +    IRQ_TYPE_LEVEL_LOW)>,
> > +     <1 14 (GIC_CPU_MASK_SIMPLE(2) |
> > +    IRQ_TYPE_LEVEL_LOW)>,
> > +     <1 11 (GIC_CPU_MASK_SIMPLE(2) |
> > +    IRQ_TYPE_LEVEL_LOW)>,
> > +     <1 10 (GIC_CPU_MASK_SIMPLE(2) |
> > +    IRQ_TYPE_LEVEL_LOW)>;
> > +};
> > +};
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
