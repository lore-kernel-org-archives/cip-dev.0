Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976ACC433EF
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:04 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web09.159.1657568462960130908
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=bHE60Wd5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-20220711194100175e825e80f349cc38-xrqhug@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20220711194100175e825e80f349cc38
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:41:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uA4R1JbI+t41l9E6UMJKC3Zl+Uh6CDKCRPRPKckg33U=;
 b=bHE60Wd5P4q9RUZRES2Ksx9dJp2oB43+9BHNz3wgtyxPHXyouSaOj/SeaoOMYmazGqjNkd
 SLiFjXbmy++6FjKuEd7HWIP/JQqaur9JDRbvRROLjzSVeHhiqS+2OuL/8EBfnyE0PF3zl+jD
 uWRFQqMuwqgAeKq5f4gqd73mBqRwM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 4/7] u-boot-qemu-arm64: Update to 2022.07
Date: Mon, 11 Jul 2022 21:40:55 +0200
Message-Id: 
 <e1a5f23cc2ba70d7cca4d59534126b890a432e49.1657568458.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1657568458.git.jan.kiszka@siemens.com>
References: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8745

From: Jan Kiszka <jan.kiszka@siemens.com>

This is required because of a critical fix in that release to actually
validate hashes of UEFI signatures. And it allows to drop our patch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...-rtc_mktime-and-mktime64-Y2038-ready.patch | 107 ------------------
 ...022.04.bb => u-boot-qemu-arm64_2022.07.bb} |   3 +-
 2 files changed, 1 insertion(+), 109 deletions(-)
 delete mode 100644 recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
 rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2022.04.bb => u-boot-qemu-arm64_2022.07.bb} (87%)

diff --git a/recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch b/recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
deleted file mode 100644
index b2ff705..0000000
--- a/recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
+++ /dev/null
@@ -1,107 +0,0 @@
-From 8b990a06685678abd8dbc8be86c27bf3e94e3694 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Sun, 24 Apr 2022 11:24:54 +0200
-Subject: [PATCH] lib/date: Make rtc_mktime and mktime64 Y2038-ready
-
-We currently overflow due to wrong types used internally in rtc_mktime,
-on all platforms, and we return a too small type on 32-bit.
-
-One consumer that directly benefits from this is mktime64. Many others
-may still store the result in a wrong type.
-
-While at it, drop the redundant cast of mon in rtc_mktime (obsoleted by
-714209832db1).
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- include/linux/time.h |  3 ---
- include/rtc.h        |  8 +++++---
- lib/date.c           | 13 +++++--------
- 3 files changed, 10 insertions(+), 14 deletions(-)
-
-diff --git a/include/linux/time.h b/include/linux/time.h
-index 702dd276aea..14ff5b6f481 100644
---- a/include/linux/time.h
-+++ b/include/linux/time.h
-@@ -152,9 +152,6 @@ _DEFUN (ctime_r, (tim_p, result),
-     return asctime_r (localtime_r (tim_p, &tm), result);
- }
- 
--/* for compatibility with linux code */
--typedef __s64 time64_t;
--
- #ifdef CONFIG_LIB_DATE
- time64_t mktime64(const unsigned int year, const unsigned int mon,
- 		  const unsigned int day, const unsigned int hour,
-diff --git a/include/rtc.h b/include/rtc.h
-index 6c7fcadd488..10104e3bf5a 100644
---- a/include/rtc.h
-+++ b/include/rtc.h
-@@ -16,6 +16,8 @@
- #include <bcd.h>
- #include <rtc_def.h>
- 
-+typedef int64_t time64_t;
-+
- #ifdef CONFIG_DM_RTC
- 
- struct udevice;
-@@ -301,7 +303,7 @@ int rtc_calc_weekday(struct rtc_time *time);
- void rtc_to_tm(u64 time_t, struct rtc_time *time);
- 
- /**
-- * rtc_mktime() - Convert a broken-out time into a time_t value
-+ * rtc_mktime() - Convert a broken-out time into a time64_t value
-  *
-  * The following fields need to be valid for this function to work:
-  *	tm_sec, tm_min, tm_hour, tm_mday, tm_mon, tm_year
-@@ -309,9 +311,9 @@ void rtc_to_tm(u64 time_t, struct rtc_time *time);
-  * Note that tm_wday and tm_yday are ignored.
-  *
-  * @time:	Broken-out time to convert
-- * Return: corresponding time_t value, seconds since 1970-01-01 00:00:00
-+ * Return: corresponding time64_t value, seconds since 1970-01-01 00:00:00
-  */
--unsigned long rtc_mktime(const struct rtc_time *time);
-+time64_t rtc_mktime(const struct rtc_time *time);
- 
- /**
-  * rtc_month_days() - The number of days in the month
-diff --git a/lib/date.c b/lib/date.c
-index c589d9ed3a2..e3d22459cd0 100644
---- a/lib/date.c
-+++ b/lib/date.c
-@@ -71,19 +71,16 @@ int rtc_calc_weekday(struct rtc_time *tm)
-  * -year / 100 + year / 400 terms, and add 10.]
-  *
-  * This algorithm was first published by Gauss (I think).
-- *
-- * WARNING: this function will overflow on 2106-02-07 06:28:16 on
-- * machines where long is 32-bit! (However, as time_t is signed, we
-- * will already get problems at other places on 2038-01-19 03:14:08)
-  */
--unsigned long rtc_mktime(const struct rtc_time *tm)
-+time64_t rtc_mktime(const struct rtc_time *tm)
- {
- 	int mon = tm->tm_mon;
- 	int year = tm->tm_year;
--	int days, hours;
-+	unsigned long days;
-+	time64_t hours;
- 
- 	mon -= 2;
--	if (0 >= (int)mon) {	/* 1..12 -> 11, 12, 1..10 */
-+	if (0 >= mon) {		/* 1..12 -> 11, 12, 1..10 */
- 		mon += 12;	/* Puts Feb last since it has leap day */
- 		year -= 1;
- 	}
-@@ -109,5 +106,5 @@ time64_t mktime64(const unsigned int year, const unsigned int mon,
- 	time.tm_min = min;
- 	time.tm_sec = sec;
- 
--	return (time64_t)rtc_mktime((const struct rtc_time *)&time);
-+	return rtc_mktime((const struct rtc_time *)&time);
- }
--- 
-2.34.1
-
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
similarity index 87%
rename from recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
index b026dd6..465be40 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
@@ -13,9 +13,8 @@ require recipes-bsp/u-boot/u-boot-custom.inc
 
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
-    file://0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch \
     file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "68e065413926778e276ec3abd28bb32fa82abaa4a6898d570c1f48fbdb08bcd0"
+SRC_URI[sha256sum] = "92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e"
 
 SRC_URI_append_secureboot = " \
     file://secure-boot.cfg"
-- 
2.35.3


