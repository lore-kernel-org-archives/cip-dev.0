From: nobuhiro.iwamatsu@miraclelinux.com (=?UTF-8?B?5bKp5p2+5L+h5rSL?=)
Date: Fri, 12 Oct 2018 19:33:11 +0900
Subject: [cip-dev] [PATCH] ARM: dts: r8a77(43|9[013]): Add missing OPP
 properties for CPUs
In-Reply-To: <1539290403-5450-1-git-send-email-chris.paterson2@renesas.com>
References: <1539290403-5450-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAGDrK-bsm0PzrkMaWL=75XKLXwiDb4Hs1nkctYfQFThkwwXZdA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Chris.

Thanks for update and resend patch.

2018?10?12?(?) 5:40 Chris Paterson <chris.paterson2@renesas.com>:
>
> From: Viresh Kumar <viresh.kumar@linaro.org>
>
> commit 8199e49ff1f654bbe8bed90fd6710bc097a89d02 upstream.
>
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
>
> Add such missing properties.
>
> Fix other missing properties (like, clock latency, voltage tolerance,
> etc) as well to make it all work.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> [Backport to CIP: dropped changes to r8a779[013] SoCs dtsi]
> Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

LGTM. I've applied this, thanks.

Best regards,
  Nobuhiro
> ---
> Resending this patch to test patchwork (and because it needs reviewing).
> ---
>  arch/arm/boot/dts/r8a7743.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
> index c78de96bfc29e47a..f41e3a5cdf9c053d 100644
> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -66,7 +66,16 @@
>                         reg = <1>;
>                         clock-frequency = <1500000000>;
>                         clocks = <&cpg_clocks R8A7743_CLK_Z>;
> +                       clock-latency = <300000>; /* 300 us */
>                         next-level-cache = <&L2_CA15>;
> +
> +                       /* kHz - uV - OPPs unknown yet */
> +                       operating-points = <1500000 1000000>,
> +                                          <1312500 1000000>,
> +                                          <1125000 1000000>,
> +                                          < 937500 1000000>,
> +                                          < 750000 1000000>,
> +                                          < 375000 1000000>;
>                 };
>
>                 L2_CA15: cache-controller-0 {
> --
> 1.9.1
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
