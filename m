From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 15 Mar 2018 16:07:08 +0000
Subject: [cip-dev] [PATCH 6/7] ARM: dts: r8a7743: Add USB-DMAC device
	nodes
In-Reply-To: <1521067650.23626.110.camel@codethink.co.uk>
References: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520336087-12870-7-git-send-email-fabrizio.castro@bp.renesas.com>
	<1521067650.23626.110.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17708DE86986BEB8D5702986C0D00@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> Subject: Re: [cip-dev][PATCH 6/7] ARM: dts: r8a7743: Add USB-DMAC device nodes
>
> [This sender failed our fraud detection checks and may not be who they appear to be. Learn about spoofing at
> http://aka.ms/LearnAboutSpoofing]
>
> On Tue, 2018-03-06 at 11:34 +0000, Fabrizio Castro wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > (cherry picked from commit 310861003a0d59cb410538bcdf73a218157a111d)
> > (modified clocks and power-domains properties, removed resets property)
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7743.dtsi | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
> > index 1237746..db00959 100644
> > --- a/arch/arm/boot/dts/r8a7743.dtsi
> > +++ b/arch/arm/boot/dts/r8a7743.dtsi
> > @@ -309,6 +309,30 @@
> >                       dma-channels = <15>;
> >               };
> >
> > +             usb_dmac0: dma-controller at e65a0000 {
> > +                     compatible = "renesas,usb-dmac";
> [...]
>
> Why no "renesas,r8a7743-usb-dmac" compatible string?

It's down to the dt-bindings, commit 0b2eed49875ec3605b7a71bdf05adc8c1cbd49fc
introduces SoC specific support, this would trigger changes to the corresponding SoC
specific DT touched by such a change, and as usual, where do we draw the line with
the backporting? Would you rather I used "renesas,r8a7743-usb-dmac" instead?

Thanks,
Fab

>
> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
