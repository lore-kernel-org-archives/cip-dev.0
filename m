From: nobuhiro.iwamatsu@miraclelinux.com (=?UTF-8?B?5bKp5p2+5L+h5rSL?=)
Date: Sun, 21 Oct 2018 17:05:50 +0900
Subject: [cip-dev] [PATCH 1/2] ARM: dts: r8a7745: Add PMU device node
In-Reply-To: <CAFk6z8PO4U+9Tkh3P_v7VSp8nV8tPQk7kX8+26WHZZeDQL3QdQ@mail.gmail.com>
References: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<1539599008-8382-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<CAFk6z8PO4U+9Tkh3P_v7VSp8nV8tPQk7kX8+26WHZZeDQL3QdQ@mail.gmail.com>
Message-ID: <CAGDrK-YLgH5N7_aUjP5o-tDZ7qwi9hdz880ZZRaLcYciWt9Dhw@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

2018?10?21?(?) 16:49 SZ Lin (???) <sz.lin@moxa.com>:
>
> Hi,
>
> >
> > [Backport to CIP]
>
> I suggest to address what you've modified from the upstream patch, it
> would be helpful for maintainer's review task.
>
> For example: [Context changes]
>

I think so, too.
Patryk, could you please post with changes?

> Just my two cents.

Best regards,
  Nobuhiro

>
> > Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7745.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
> > index 69b383c..54b556b 100644
> > --- a/arch/arm/boot/dts/r8a7745.dtsi
> > +++ b/arch/arm/boot/dts/r8a7745.dtsi
> > @@ -93,6 +93,13 @@
> >                 };
> >         };
> >
> > +       pmu {
> > +               compatible = "arm,cortex-a7-pmu";
> > +               interrupts-extended = <&gic GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <&gic GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-affinity = <&cpu0>, <&cpu1>;
> > +       };
> > +
> >         soc {
> >                 compatible = "simple-bus";
> >                 interrupt-parent = <&gic>;
> > --
> > 2.7.4
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
