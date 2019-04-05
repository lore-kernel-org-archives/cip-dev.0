From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  5 Apr 2019 08:54:56 +0100
Subject: [cip-dev] [PATCH 4.19.y] arm64: renesas: Enable GPIOLIB to allow
	GPIO driver selection
Message-ID: <1554450896-62824-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

The R-Car GPIO driver cannot be enabled when Renesas SoC's ARCH configs
(ARCH_RENESAS, ARCH_R8A7795, ARCH_R8A7796 and ARCH_R8A77965) are enabled
only.

As GPIOs are a critical resource for proper operation on Renesas
platforms, this patch selects GPIOLIB, just like is done for other SoC
vendors, and on Renesas arm32 SoCs.

Reported-by: Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Improve patch description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

(cherry picked from commit 9374eee32b666c92cf821a98eb3aeaa0bf4d5dd5)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index e13c9ff..a6f9b64 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -178,6 +178,7 @@ config ARCH_SYNQUACER
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
 	select ARCH_SHMOBILE
+	select GPIOLIB
 	select PINCTRL
 	select PM
 	select PM_GENERIC_DOMAINS
-- 
2.7.4
