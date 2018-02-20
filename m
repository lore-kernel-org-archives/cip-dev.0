From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 20 Feb 2018 09:21:46 +0000
Subject: [cip-dev] [PATCH 0/3] Add RTC support to iwg20d
In-Reply-To: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR06MB07028F631235BA42342E216BB7CF0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: 19 February 2018 18:46
> To: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Subject: [cip-dev][PATCH 0/3] Add RTC support to iwg20d
> 
> This patch series aims at adding RTC support to the iwg20d board from iWave.
> The commits from this series backport board specific DT support and
> defconfig support.
> 
> Biju Das (3):
>   ARM: dts: iwg20d-q7: Add RTC support
>   ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig
>   ARM: multi_v7_defconfig: Enable BQ32000 RTC driver

Series looks okay to me.

Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>


> 
>  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig     |  1 +
>  arch/arm/configs/shmobile_defconfig     |  1 +
>  3 files changed, 20 insertions(+)
> 
> --
> 2.7.4
