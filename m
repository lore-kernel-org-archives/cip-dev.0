From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 05 Jul 2018 21:42:42 +0100
Subject: [cip-dev] [PATCH 12/86] ARM: dts: r8a7745: Add clocks
In-Reply-To: <1530283167-14050-13-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530283167-14050-13-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530823362.21552.1.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2018-06-29 at 15:38 +0100, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> Declare all core clocks and DIV6 clocks, as well as all MSTP clocks.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
> ?arch/arm/boot/dts/r8a7745.dtsi | 432 +++++++++++++++++++++++++++++++++++++++++
> ?1 file changed, 432 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
> index 281ab59..5c50fd3 100644
> --- a/arch/arm/boot/dts/r8a7745.dtsi
> +++ b/arch/arm/boot/dts/r8a7745.dtsi
[...]
> +			mstp2_clks: mstp2_clks at e6150138 {
> +				compatible = "renesas,r8a7743-mstp-clocks",
> +					?????"renesas,cpg-mstp-clocks";
> > 
[...]

This and the following 9 device nodes have compatible =
"renesas,r8a7743-mstp-clocks" which should presumably be
"renesas,r8a7745-mstp-clocks".

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
