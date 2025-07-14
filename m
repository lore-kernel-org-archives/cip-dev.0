Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52E2C83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.74854.1752487713503831357
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: KSWGZJXpQlyaZOvTNnbfdw==
X-CSE-MsgGUID: zzlRSJztRgiNxuWUnw4xQQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6976E41D45A9;
	Mon, 14 Jul 2025 19:08:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 13/57] lib/string_helpers: Split out string_choices.h
Date: Mon, 14 Jul 2025 11:06:54 +0100
Message-ID: <20250714100802.80035-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19441

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit fca76071bab2304b379c35674d3b9e36a82e364a upstream.

Some users may only need the string choice APIs. Split
the respective header, i.e. string_choices.h. Include
it in the string_helpers.h for backward compatibility.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 MAINTAINERS                    |  3 +++
 include/linux/string_choices.h | 32 ++++++++++++++++++++++++++++++++
 include/linux/string_helpers.h | 26 +-------------------------
 3 files changed, 36 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/string_choices.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e6128048da93..bb9565bbc2e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8633,6 +8633,9 @@ F:	drivers/input/touchscreen/resistive-adc-touch.c
 GENERIC STRING LIBRARY
 R:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
+F:	include/linux/string.h
+F:	include/linux/string_choices.h
+F:	include/linux/string_helpers.h
 F:	lib/string.c
 F:	lib/string_helpers.c
 F:	lib/test_string.c
diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
new file mode 100644
index 000000000000..b7e7b9fd098c
--- /dev/null
+++ b/include/linux/string_choices.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_STRING_CHOICES_H_
+#define _LINUX_STRING_CHOICES_H_
+
+#include <linux/types.h>
+
+static inline const char *str_enable_disable(bool v)
+{
+	return v ? "enable" : "disable";
+}
+
+static inline const char *str_enabled_disabled(bool v)
+{
+	return v ? "enabled" : "disabled";
+}
+
+static inline const char *str_read_write(bool v)
+{
+	return v ? "read" : "write";
+}
+
+static inline const char *str_on_off(bool v)
+{
+	return v ? "on" : "off";
+}
+
+static inline const char *str_yes_no(bool v)
+{
+	return v ? "yes" : "no";
+}
+
+#endif
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 8530c7328269..df9e5387a922 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -4,6 +4,7 @@
 
 #include <linux/bits.h>
 #include <linux/ctype.h>
+#include <linux/string_choices.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -108,29 +109,4 @@ void kfree_strarray(char **array, size_t n);
 
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n);
 
-static inline const char *str_yes_no(bool v)
-{
-	return v ? "yes" : "no";
-}
-
-static inline const char *str_on_off(bool v)
-{
-	return v ? "on" : "off";
-}
-
-static inline const char *str_enable_disable(bool v)
-{
-	return v ? "enable" : "disable";
-}
-
-static inline const char *str_enabled_disabled(bool v)
-{
-	return v ? "enabled" : "disabled";
-}
-
-static inline const char *str_read_write(bool v)
-{
-	return v ? "read" : "write";
-}
-
 #endif
-- 
2.43.0


