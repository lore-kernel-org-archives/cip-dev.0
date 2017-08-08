From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 10:50:28 +0100
Subject: [cip-dev] [PATCH 14/14] ARM: multi_v7_defconfig: Enable r8a774[35]
	SoCs
In-Reply-To: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502185828-45443-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Enable recently added r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 0a2cd376019d5bfe8ddcf96a525c8dbd9b295e28)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index cd7b198..f1ba3fb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -80,6 +80,8 @@ CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7743=y
+CONFIG_ARCH_R8A7745=y
 CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
-- 
1.9.1
