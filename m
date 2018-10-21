From: sz.lin@moxa.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Sun, 21 Oct 2018 15:49:13 +0800
Subject: [cip-dev] [PATCH 1/2] ARM: dts: r8a7745: Add PMU device node
In-Reply-To: <1539599008-8382-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<1539599008-8382-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <CAFk6z8PO4U+9Tkh3P_v7VSp8nV8tPQk7kX8+26WHZZeDQL3QdQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

>
> [Backport to CIP]

I suggest to address what you've modified from the upstream patch, it
would be helpful for maintainer's review task.

For example: [Context changes]

Just my two cents.

> Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7745.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
> index 69b383c..54b556b 100644
> --- a/arch/arm/boot/dts/r8a7745.dtsi
> +++ b/arch/arm/boot/dts/r8a7745.dtsi
> @@ -93,6 +93,13 @@
>                 };
>         };
>
> +       pmu {
> +               compatible = "arm,cortex-a7-pmu";
> +               interrupts-extended = <&gic GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&gic GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-affinity = <&cpu0>, <&cpu1>;
> +       };
> +
>         soc {
>                 compatible = "simple-bus";
>                 interrupt-parent = <&gic>;
> --
> 2.7.4
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
