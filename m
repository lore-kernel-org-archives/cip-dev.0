Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48505C4167D
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 19:46:09 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web08.2031.1651693567185709945
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 12:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=UZH11osk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-20220504194605d278e04d13c6bd2b52-acgcap@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20220504194605d278e04d13c6bd2b52
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 May 2022 21:46:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PU24+oZ5hM49YyftqyoCFn1TOGIsCUT61/HLyZcfWno=;
 b=UZH11oskJA7S4ydejdZSwIXPoN7JKRAivdsFsrnSS0DfLoIBhXzr0wURpNIGb2IOjnKb+1
 QK6NoY0ZiNrxuZ9BLmSPx12x9PZ5inispP7tjoKX2Enxlm9HEEEEDuTW6G/q4Czhops/VCKt
 wU6k8G2BGkB6ZtfyEbbAN6kPHEEgY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 10/12] u-boot-qemu-arm64: Add recipe for
 customized version based on 2022.04
Date: Wed,  4 May 2022 21:45:58 +0200
Message-Id: 
 <7b1860e3dbd4d5f2de5ec2b9a8acf6ed4fd3da31.1651693560.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651693560.git.jan.kiszka@siemens.com>
References: <cover.1651693560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 19:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8246

From: Jan Kiszka <jan.kiszka@siemens.com>

This will be used for booting via UEFI, both in open and locked-down
secure mode. The secure mode variations can be selected by adding
"secureboot" to OVERRIDES.

One extra patch is needed to add support for long-living certificates.
It is pending upstream.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...-rtc_mktime-and-mktime64-Y2038-ready.patch | 107 ++++++++++++++++++
 recipes-bsp/u-boot/files/rules                |  40 +++++++
 recipes-bsp/u-boot/files/secure-boot.cfg      |   6 +
 .../u-boot/u-boot-qemu-arm64_2022.04.bb       |  50 ++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
 create mode 100755 recipes-bsp/u-boot/files/rules
 create mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb

diff --git a/recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch b/recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
new file mode 100644
index 0000000..b2ff705
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
@@ -0,0 +1,107 @@
+From 8b990a06685678abd8dbc8be86c27bf3e94e3694 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sun, 24 Apr 2022 11:24:54 +0200
+Subject: [PATCH] lib/date: Make rtc_mktime and mktime64 Y2038-ready
+
+We currently overflow due to wrong types used internally in rtc_mktime,
+on all platforms, and we return a too small type on 32-bit.
+
+One consumer that directly benefits from this is mktime64. Many others
+may still store the result in a wrong type.
+
+While at it, drop the redundant cast of mon in rtc_mktime (obsoleted by
+714209832db1).
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ include/linux/time.h |  3 ---
+ include/rtc.h        |  8 +++++---
+ lib/date.c           | 13 +++++--------
+ 3 files changed, 10 insertions(+), 14 deletions(-)
+
+diff --git a/include/linux/time.h b/include/linux/time.h
+index 702dd276aea..14ff5b6f481 100644
+--- a/include/linux/time.h
++++ b/include/linux/time.h
+@@ -152,9 +152,6 @@ _DEFUN (ctime_r, (tim_p, result),
+     return asctime_r (localtime_r (tim_p, &tm), result);
+ }
+ 
+-/* for compatibility with linux code */
+-typedef __s64 time64_t;
+-
+ #ifdef CONFIG_LIB_DATE
+ time64_t mktime64(const unsigned int year, const unsigned int mon,
+ 		  const unsigned int day, const unsigned int hour,
+diff --git a/include/rtc.h b/include/rtc.h
+index 6c7fcadd488..10104e3bf5a 100644
+--- a/include/rtc.h
++++ b/include/rtc.h
+@@ -16,6 +16,8 @@
+ #include <bcd.h>
+ #include <rtc_def.h>
+ 
++typedef int64_t time64_t;
++
+ #ifdef CONFIG_DM_RTC
+ 
+ struct udevice;
+@@ -301,7 +303,7 @@ int rtc_calc_weekday(struct rtc_time *time);
+ void rtc_to_tm(u64 time_t, struct rtc_time *time);
+ 
+ /**
+- * rtc_mktime() - Convert a broken-out time into a time_t value
++ * rtc_mktime() - Convert a broken-out time into a time64_t value
+  *
+  * The following fields need to be valid for this function to work:
+  *	tm_sec, tm_min, tm_hour, tm_mday, tm_mon, tm_year
+@@ -309,9 +311,9 @@ void rtc_to_tm(u64 time_t, struct rtc_time *time);
+  * Note that tm_wday and tm_yday are ignored.
+  *
+  * @time:	Broken-out time to convert
+- * Return: corresponding time_t value, seconds since 1970-01-01 00:00:00
++ * Return: corresponding time64_t value, seconds since 1970-01-01 00:00:00
+  */
+-unsigned long rtc_mktime(const struct rtc_time *time);
++time64_t rtc_mktime(const struct rtc_time *time);
+ 
+ /**
+  * rtc_month_days() - The number of days in the month
+diff --git a/lib/date.c b/lib/date.c
+index c589d9ed3a2..e3d22459cd0 100644
+--- a/lib/date.c
++++ b/lib/date.c
+@@ -71,19 +71,16 @@ int rtc_calc_weekday(struct rtc_time *tm)
+  * -year / 100 + year / 400 terms, and add 10.]
+  *
+  * This algorithm was first published by Gauss (I think).
+- *
+- * WARNING: this function will overflow on 2106-02-07 06:28:16 on
+- * machines where long is 32-bit! (However, as time_t is signed, we
+- * will already get problems at other places on 2038-01-19 03:14:08)
+  */
+-unsigned long rtc_mktime(const struct rtc_time *tm)
++time64_t rtc_mktime(const struct rtc_time *tm)
+ {
+ 	int mon = tm->tm_mon;
+ 	int year = tm->tm_year;
+-	int days, hours;
++	unsigned long days;
++	time64_t hours;
+ 
+ 	mon -= 2;
+-	if (0 >= (int)mon) {	/* 1..12 -> 11, 12, 1..10 */
++	if (0 >= mon) {		/* 1..12 -> 11, 12, 1..10 */
+ 		mon += 12;	/* Puts Feb last since it has leap day */
+ 		year -= 1;
+ 	}
+@@ -109,5 +106,5 @@ time64_t mktime64(const unsigned int year, const unsigned int mon,
+ 	time.tm_min = min;
+ 	time.tm_sec = sec;
+ 
+-	return (time64_t)rtc_mktime((const struct rtc_time *)&time);
++	return rtc_mktime((const struct rtc_time *)&time);
+ }
+-- 
+2.34.1
+
diff --git a/recipes-bsp/u-boot/files/rules b/recipes-bsp/u-boot/files/rules
new file mode 100755
index 0000000..36e1e1b
--- /dev/null
+++ b/recipes-bsp/u-boot/files/rules
@@ -0,0 +1,40 @@
+#!/usr/bin/make -f
+#
+# Copyright (c) Siemens AG, 2018-2022
+#
+# SPDX-License-Identifier: MIT
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
+SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
+endif
+
+override_dh_auto_build:
+	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
+		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out secure-boot.der -outform der; \
+		rm -f secure-boot.esl; \
+		efisiglist -a -c secure-boot.der -o secure-boot.esl; \
+		rm -f ubootefi.var; \
+		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
+		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
+		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \
+	fi
+	$(MAKE) $(PARALLEL_MAKE) $(U_BOOT_CONFIG)
+	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_BIN}
+	$(MAKE) -n u-boot-initial-env >/dev/null 2>&1; if [ $$? -ne 2 ]; then \
+		$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env; \
+	else \
+		./scripts/get_default_envs.sh >u-boot-initial-env; \
+	fi
+	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
+
+override_dh_auto_install:
+	mv tools/env/lib.a tools/env/libubootenv.a
+
+override_dh_auto_test:
+
+override_dh_strip:
+	dh_strip -X libubootenv.a
+
+%:
+	dh $@ --parallel
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
new file mode 100644
index 0000000..a1b9931
--- /dev/null
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -0,0 +1,6 @@
+### Secure boot config
+CONFIG_BOOTDELAY=-2
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="setenv scan_dev_for_boot 'if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/bootaa64.efi; then load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/bootaa64.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
+CONFIG_EFI_VARIABLES_PRESEED=y
+CONFIG_EFI_SECURE_BOOT=y
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
new file mode 100644
index 0000000..e462258
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
@@ -0,0 +1,50 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-bsp/u-boot/u-boot-custom.inc
+
+SRC_URI += " \
+    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
+    file://0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch \
+    file://rules"
+SRC_URI[sha256sum] = "68e065413926778e276ec3abd28bb32fa82abaa4a6898d570c1f48fbdb08bcd0"
+
+SRC_URI_append_secureboot = " \
+    file://secure-boot.cfg"
+
+S = "${WORKDIR}/u-boot-${PV}"
+
+DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:arm64"
+
+DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
+    openssl, pesign, secure-boot-secrets, python3-openssl:native"
+DEPENDS_append_secureboot = " secure-boot-secrets"
+
+U_BOOT_CONFIG = "qemu_arm64_defconfig"
+U_BOOT_BIN = "u-boot.bin"
+
+do_prepare_build_append() {
+    cp ${WORKDIR}/rules ${S}/debian/rules
+}
+
+do_prepare_build_append_secureboot() {
+    sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
+}
+
+do_deploy[dirs] = "${DEPLOY_DIR_IMAGE}"
+do_deploy() {
+    dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
+        > "${DEPLOY_DIR_IMAGE}/firmware.bin"
+}
+
+addtask deploy after do_dpkg_build before do_deploy_deb
-- 
2.34.1


