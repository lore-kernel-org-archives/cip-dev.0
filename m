From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 14 Mar 2018 22:47:30 +0000
Subject: [cip-dev] [PATCH 6/7] ARM: dts: r8a7743: Add USB-DMAC device
 nodes
In-Reply-To: <1520336087-12870-7-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520336087-12870-7-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1521067650.23626.110.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2018-03-06 at 11:34 +0000, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> (cherry picked from commit 310861003a0d59cb410538bcdf73a218157a111d)
> (modified clocks and power-domains properties, removed resets property)
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
> ?arch/arm/boot/dts/r8a7743.dtsi | 24 ++++++++++++++++++++++++
> ?1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
> index 1237746..db00959 100644
> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -309,6 +309,30 @@
> ?			dma-channels = <15>;
> ?		};
> ?
> +		usb_dmac0: dma-controller at e65a0000 {
> +			compatible = "renesas,usb-dmac";
[...]

Why no "renesas,r8a7743-usb-dmac" compatible string?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
