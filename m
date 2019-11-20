From: pavel@denx.de (Pavel Machek)
Date: Wed, 20 Nov 2019 15:36:02 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 08/17] ARM: dts: r8a7744: Add SMP
	support
In-Reply-To: <1574175222-52858-9-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
 <1574175222-52858-9-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191120143601.GA4940@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit f1546da8a5c8862d1e66835affcfaf9a0c123abc upstream.
> 
> Add DT node for the Advanced Power Management Unit (APMU), add the
> second CPU core, and use "renesas,apmu" as "enable-method".
> 
> Also add cpu1 phandle node to the PMU interrupt-affinity property.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> [biju: removed resets property. Updated power-domains and clocks properties]
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r8a7744.dtsi | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)


> +			clocks = <&cpg_clocks R8A7744_CLK_Z>;
> +			clock-latency = <300000>; /* 300 us */
> +			power-domains = <&cpg_clocks>;
> +			next-level-cache = <&L2_CA15>;
> +
> +			/* kHz - uV - OPPs unknown yet */
> +			operating-points = <1500000 1000000>,
> +					   <1312500 1000000>,
> +					   <1125000 1000000>,
> +					   < 937500 1000000>,
> +					   < 750000 1000000>,
> +					   < 375000 1000000>;
> +		};

Does this mean this is working progress and voltages will be lowered
for lower frequencies as testing proceeds?

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191120/c5ee694c/attachment.sig>
