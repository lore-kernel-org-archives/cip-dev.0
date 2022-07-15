X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3828.1657870760365428455
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:39:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800"; 
   d="scan'208";a="127957724"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:39:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EDD7E421BAF6;
	Fri, 15 Jul 2022 16:39:22 +0900 (JST)
From: "Biju Das" <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RESEND 5.10.y-cip 02/13] units: Add SI metric prefix definitions
Date: Fri, 15 Jul 2022 08:39:05 +0100
Message-Id: <20220715073916.2321319-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 26471d4a6cf8d5d0bd0fb55c7169de7d67cc703a upstream.

Sometimes it's useful to have well-defined SI metric prefix to be used
to self-describe the formulas or equations.

List most popular ones in the units.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/linux/units.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 5c115c809507..4a25e0cc8fb3 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,26 @@
 
 #include <linux/math.h>
 
+/* Metric prefixes in accordance with Système international (d'unités) */
+#define PETA	1000000000000000ULL
+#define TERA	1000000000000ULL
+#define GIGA	1000000000UL
+#define MEGA	1000000UL
+#define KILO	1000UL
+#define HECTO	100UL
+#define DECA	10UL
+#define DECI	10UL
+#define CENTI	100UL
+#define MILLI	1000UL
+#define MICRO	1000000UL
+#define NANO	1000000000UL
+#define PICO	1000000000000ULL
+#define FEMTO	1000000000000000ULL
+
+#define MILLIWATT_PER_WATT	1000L
+#define MICROWATT_PER_MILLIWATT	1000L
+#define MICROWATT_PER_WATT	1000000L
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
 static inline long milli_kelvin_to_millicelsius(long t)
-- 
2.25.1


