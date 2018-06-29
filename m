From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:59 +0100
Subject: [cip-dev] [PATCH 58/86] ARM: shmobile: Add pm support for r8a7745
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-59-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds pm support for r8a7745 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 94a2759..f1bee67 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -85,6 +85,9 @@ void __init rcar_gen2_pm_init(void)
 	} else if (of_machine_is_compatible("renesas,r8a7743")) {
 		boot_vector_addr = RAM;
 		syscier = 0x00101003;
+	} else if (of_machine_is_compatible("renesas,r8a7745")) {
+		boot_vector_addr = RAM;
+		syscier = 0x00300060;
 	}
 
 	/* RAM for jump stub, because BAR requires 256KB aligned address */
-- 
2.7.4
