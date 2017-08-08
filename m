From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 10:50:27 +0100
Subject: [cip-dev] [PATCH 13/14] ARM: shmobile: defconfig: Enable r8a774[35]
	SoCs
In-Reply-To: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502185828-45443-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Enable recently added r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit d234e29dae04b224a63e39bc29938fa77819b3f1)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3aef019..fb8094a 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,6 +14,8 @@ CONFIG_ARCH_EMEV2=y
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
