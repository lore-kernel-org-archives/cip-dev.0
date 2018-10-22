From: SZ.Lin@moxa.com (=?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Mon, 22 Oct 2018 06:53:00 +0000
Subject: [cip-dev] [PATCH 1/2] ARM: dts: r8a7745: Add PMU device node
In-Reply-To: <TYAPR01MB228592DD5EB80669EC6830E0B7FB0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<1539599008-8382-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<CAFk6z8PO4U+9Tkh3P_v7VSp8nV8tPQk7kX8+26WHZZeDQL3QdQ@mail.gmail.com>
	<CAGDrK-YLgH5N7_aUjP5o-tDZ7qwi9hdz880ZZRaLcYciWt9Dhw@mail.gmail.com>
	<TYAPR01MB228592DD5EB80669EC6830E0B7FB0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <HK0PR01MB2979D1B26EEAA6A190587E32E2F40@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> Me too, however for the patches in this series the changes are actually identical to the
> upstream commits.
> 
> The intention of [Backport to CIP] was just to split the signed-off tags between upstream
> and backport committers, as we moved the cherry-picked commit ID to the top of the
> patch.

According to the guide of submitting patches [1] - "the line between the last Signed-off-by header and yours, indicating
the nature of your changes", I think it is unnecessary to add this comment in this case. Furthermore, it doesn't need to split
signed-off tags between upstream and backport committers in stable kernel [2].

Nevertheless, we can define our policy here if we decided to add this line for each CIP patches.

[1] https://www.kernel.org/doc/html/v4.18/process/submitting-patches.html
[2] https://lkml.org/lkml/2018/10/16/595

SZ

> 
> Kind regards, Chris
> 
> > Patryk, could you please post with changes?
> >
> > > Just my two cents.
> >
> > Best regards,
> >   Nobuhiro
> >
> > >
> > > > Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
> > > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > > > ---
> > > >  arch/arm/boot/dts/r8a7745.dtsi | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/r8a7745.dtsi
> > > > b/arch/arm/boot/dts/r8a7745.dtsi index 69b383c..54b556b 100644
> > > > --- a/arch/arm/boot/dts/r8a7745.dtsi
> > > > +++ b/arch/arm/boot/dts/r8a7745.dtsi
> > > > @@ -93,6 +93,13 @@
> > > >                 };
> > > >         };
> > > >
> > > > +       pmu {
> > > > +               compatible = "arm,cortex-a7-pmu";
> > > > +               interrupts-extended = <&gic GIC_SPI 82
> > IRQ_TYPE_LEVEL_HIGH>,
> > > > +                                     <&gic GIC_SPI 83
> IRQ_TYPE_LEVEL_HIGH>;
> > > > +               interrupt-affinity = <&cpu0>, <&cpu1>;
> > > > +       };
> > > > +
> > > >         soc {
> > > >                 compatible = "simple-bus";
> > > >                 interrupt-parent = <&gic>;
> > > > --
> > > > 2.7.4
> > > >
> > > > _______________________________________________
> > > > cip-dev mailing list
> > > > cip-dev at lists.cip-project.org
> > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > _______________________________________________
> > > cip-dev mailing list
> > > cip-dev at lists.cip-project.org
> > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
