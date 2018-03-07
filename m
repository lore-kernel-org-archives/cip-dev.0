From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 07 Mar 2018 17:42:42 +0000
Subject: [cip-dev] [PATCH 0/3] Add RTC support to iwg20d
In-Reply-To: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520444562.23626.43.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2018-02-19 at 18:45 +0000, Fabrizio Castro wrote:
> This patch series aims at adding RTC support to the iwg20d
> board from iWave.
> The commits from this series backport board specific DT
> support and defconfig support.

Applied.  Sorry for the delay.

Ben

> Biju Das (3):
> ? ARM: dts: iwg20d-q7: Add RTC support
> ? ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig
> ? ARM: multi_v7_defconfig: Enable BQ32000 RTC driver
> 
> ?arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
> ?arch/arm/configs/multi_v7_defconfig?????|??1 +
> ?arch/arm/configs/shmobile_defconfig?????|??1 +
> ?3 files changed, 20 insertions(+)
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
