From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 31 Jan 2018 11:15:46 +0000
Subject: [cip-dev] [PATCH 01/10] ARM: shmobile: Add pm support for r8a7743
In-Reply-To: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
References: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517397355-23341-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Adding pm support for r8a7743 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 6815781..94a2759 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -82,6 +82,9 @@ void __init rcar_gen2_pm_init(void)
 	} else if (of_machine_is_compatible("renesas,r8a7791")) {
 		boot_vector_addr = RAM;
 		syscier = 0x00111003;
+	} else if (of_machine_is_compatible("renesas,r8a7743")) {
+		boot_vector_addr = RAM;
+		syscier = 0x00101003;
 	}
 
 	/* RAM for jump stub, because BAR requires 256KB aligned address */
-- 
2.7.4
