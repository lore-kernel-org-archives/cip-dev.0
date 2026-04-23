Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96869F589A3
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 12:06:44 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17814.1776945994972266832
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 05:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: +pG+WE+sQNSadY+5ZgYQ3g==
X-CSE-MsgGUID: bZT71SNERq+Dtye5PYNqHQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Apr 2026 21:06:42 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A11C8419B45D;
	Thu, 23 Apr 2026 21:06:41 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 5.10.y-cip v2 07/10] math64: New DIV_U64_ROUND_CLOSEST helper
Date: Thu, 23 Apr 2026 08:06:27 -0400
Message-ID: <20260423120630.1487798-8-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423120630.1487798-1-chris.brandt@renesas.com>
References: <20260423120630.1487798-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 12:06:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22800

From: Pali Rohár <pali@kernel.org>

commit 2c861b73a23b1237bdd054b6023bb27f6747c2b9 upstream.

Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
division rounded to the closest integer using unsigned 64bit
dividend and unsigned 32bit divisor.

Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/r/20220219152818.4319-2-kabel@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 include/linux/math64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 66deb1fdc2ef..1cc61d748e1f 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -281,6 +281,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
 	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
 
+/*
+ * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
+
 /*
  * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
  * @dividend: signed 64bit dividend
-- 
2.52.0


