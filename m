From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Thu, 5 Sep 2019 09:39:10 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/22] Add
	Watchdog/CMT/TMU/Thermal	support
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <OSAPR01MB32349D8EB527BD07833ABC3E92BB0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Biju,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> Sent: Tuesday, September 3, 2019 12:58 AM
> To: cip-dev at lists.cip-project.org
> Cc: Biju Das <biju.das@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.19.y-cip 00/22] Add
> Watchdog/CMT/TMU/Thermal support
> 
> This patch series add Watchdog/CMT/TMU/Thermal support for hihope RZ/G2M
> platform.
> 
> This patch series is based on linux-4.19.y-cip and all the patches in
> this series are cherry-picked from linux rc tree.
> 
> This patch series is depend on the below patch series
> https://patchwork.kernel.org/project/cip-dev/list/?series=167529
> 
> 
> Biju Das (5):
>   arm64: dts: renesas: hihope-common: Add RWDT support
>   arm64: dts: renesas: r8a774a1: Add CPU topology on r8a774a1 SoC
>   arm64: dts: renesas: r8a774a1: Add CPU capacity-dmips-mhz
>   arm64: dts: renesas: r8a774a1: Create thermal zone to support IPA
>   arm64: dts: renesas: r8a774a1: Add dynamic power coefficient
> 
> Fabrizio Castro (5):
>   watchdog: renesas_wdt: Fix typos
>   arm64: dts: renesas: r8a774a1: Add CMT device nodes
>   clk: renesas: r8a774a1: Add TMU clock
>   arm64: dts: renesas: r8a774a1: Add TMU device nodes
>   arm64: dts: renesas: r8a774a1: Add operating points
> 
> Hoan Nguyen An (2):
>   watchdog: renesas_wdt: Use 'dev' instead of dereferencing it
>     repeatedly
>   thermal: rcar_gen3_thermal: Fix init value of IRQCTL register
> 
> Jiada Wang (2):
>   thermal: rcar_gen3_thermal: fix interrupt type
>   thermal: rcar_gen3_thermal: Fix to show correct trip points number
> 
> Marek Vasut (1):
>   thermal: rcar_gen3_thermal: Register hwmon sysfs interface
> 
> Wolfram Sang (3):
>   watchdog: renesas_wdt: stop when unregistering
>   watchdog: renesas_wdt: don't keep timer value during suspend/resume
>   watchdog: renesas_wdt: drop superfluous glob pattern
> 
> Yoshihiro Kaneko (3):
>   thermal: rcar_gen3_thermal: Update value of Tj_1
>   thermal: rcar_gen3_thermal: Update calculation formula of IRQTEMP
>   thermal: rcar_gen3_thermal: Update temperature conversion method
> 
> Yoshihiro Shimoda (1):
>   watchdog: renesas_wdt: Add a few cycles delay

Applied, thanks.

Best regards,
  Nobuhiro
