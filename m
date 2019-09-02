From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Mon, 2 Sep 2019 05:22:32 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 0/5] Add HopeRun RZ/G2[M]
	main/sub	boards
In-Reply-To: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
References: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <OSAPR01MB3234F017F51F5BE39407601392BE0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Biju,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> Sent: Friday, August 30, 2019 4:32 PM
> To: cip-dev at lists.cip-project.org
> Cc: Biju Das <biju.das@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.19.y-cip 0/5] Add HopeRun RZ/G2[M] main/sub
> boards
> 
> This patch series add support for HopeRun RZ/G2[M] main/sub boards.
> 
> This patch series is based on linux-4.19.y-cip and all the patches in
> this series are cherry-picked from linux rc tree.
> 
> This patch series depend upon
> https://patchwork.kernel.org/project/cip-dev/list/?series=166545
> 
> 
> Biju Das (5):
>   dt-bindings: arm: renesas: Add HopeRun RZ/G2[M] boards
>   dt-bindings: Add vendor prefix for HopeRun
>   arm64: dts: renesas: Add HiHope RZ/G2M main board support
>   arm64: dts: renesas: hihope-common: Add pincontrol support to
>     scif2/scif clock
>   arm64: dts: renesas: Add HiHope RZ/G2M sub board support

Applied to my local repo on series of "Add basic RZ/G2M SoC support".

Best regards,
  Nobuhiro

> 
>  Documentation/devicetree/bindings/arm/shmobile.txt |  5 ++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  arch/arm64/boot/dts/renesas/Makefile               |  2 +
>  arch/arm64/boot/dts/renesas/hihope-common.dtsi     | 53
> +++++++++++++++++++++
>  arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    | 55
> ++++++++++++++++++++++
>  .../boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts  | 15 ++++++
>  .../boot/dts/renesas/r8a774a1-hihope-rzg2m.dts     | 26 ++++++++++
>  7 files changed, 157 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/hihope-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
>  create mode 100644
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
>  create mode 100644
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
> 
> --
> 2.7.4
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
