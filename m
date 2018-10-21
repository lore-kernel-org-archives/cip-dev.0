From: sz.lin@moxa.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Sun, 21 Oct 2018 15:50:20 +0800
Subject: [cip-dev] [PATCH 2/2] ARM: dts: r8a7743: Add PMU device node
In-Reply-To: <1539599008-8382-3-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<1539599008-8382-3-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <CAFk6z8PbY4a1ziWb0SqzjSmV1vPAUKkw4hUX-hp-qN6MPxbvEQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> [Backport to CIP]

Ditto.

> Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7743.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
> index c78de96..264c8e0 100644
> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -76,6 +76,13 @@
>                 };
>         };
>
> +       pmu {
> +               compatible = "arm,cortex-a15-pmu";
> +               interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
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
