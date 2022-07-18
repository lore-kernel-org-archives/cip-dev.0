X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.24995.1658136276019201360
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:24:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800"; 
   d="scan'208";a="126498833"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jul 2022 18:24:35 +0900
Received: from biju-VirtualBox.ree.adwin.renesas.com (unknown [10.226.36.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ACE804006193;
	Mon, 18 Jul 2022 18:24:33 +0900 (JST)
From: "Biju Das" <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH v2 5.10.y-cip 01/12] units: Add SI metric prefix definitions
Date: Mon, 18 Jul 2022 10:24:19 +0100
Message-Id: <20220718092430.382889-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
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
index aaf716364ec3..3457179f7116 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,26 @@
 
 #include <linux/kernel.h>
 
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


