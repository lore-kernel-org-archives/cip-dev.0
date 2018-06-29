From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:02 +0100
Subject: [cip-dev] [PATCH 01/86] ARM: shmobile: rcar-gen2: Correct arch
	timer frequency on RZ/G1E
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

According to the datasheet, the frequency of the ARM architecture timer
on RZ/G1E depends on the frequency of the ZS clock, just like on R-Car
E2 and V2H.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit cd66fa4e0203fed9d8af6e1596ff8a68ede7fb1d)
(removed r8a7792 soc)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3911716..549a66f 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -58,7 +58,8 @@ void __init rcar_gen2_timer_init(void)
 	int extal_mhz = 0;
 	u32 freq;
 
-	if (of_machine_is_compatible("renesas,r8a7794")) {
+	if (of_machine_is_compatible("renesas,r8a7745") ||
+	    of_machine_is_compatible("renesas,r8a7794")) {
 		freq = 260000000 / 8;	/* ZS / 8 */
 		/* CNTVOFF has to be initialized either from non-secure
 		 * Hypervisor mode or secure Monitor mode with SCR.NS==1.
-- 
2.7.4
