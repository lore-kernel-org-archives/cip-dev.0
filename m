From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:59 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 14/23] math64: New
	DIV64_U64_ROUND_CLOSEST helper
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit cb8be119d21d8a0affc3598a928dd0baf5da238f upstream.

Provide DIV64_U64_ROUND_CLOSEST helper which performs division rounded to
the closest integer using an unsigned 64bit dividend and divisor.

This will be used in a follow-up patch to allow calculation of clock
divisors with high frequency parents in the R-Car Gen3 CPG MSSR driver
where overflow occurs if either the dividend or divisor is 32bit.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 include/linux/math64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index bb2c84a..65bef21 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -284,4 +284,17 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
+/**
+ * DIV64_U64_ROUND_CLOSEST - unsigned 64bit divide with 64bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 64bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 64bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
+
 #endif /* _LINUX_MATH64_H */
-- 
2.7.4
