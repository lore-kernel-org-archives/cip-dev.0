From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:55 +0100
Subject: [cip-dev] [PATCH 54/86] ARM: Add definition for monitor mode
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-55-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

<asm/ptrace.h> provides *_MODE definitions for the various processor
modes, but monitor mode was missing.

Add MON_MODE to avoid code using the hardcoded value.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit c5d43be52e0c7380f985585ef72dac1a6a89b59d)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/include/uapi/asm/ptrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 5af0ed1..70ff6bf 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -53,6 +53,7 @@
 #endif
 #define FIQ_MODE	0x00000011
 #define IRQ_MODE	0x00000012
+#define MON_MODE	0x00000016
 #define ABT_MODE	0x00000017
 #define HYP_MODE	0x0000001a
 #define UND_MODE	0x0000001b
-- 
2.7.4
