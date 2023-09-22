Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B9DCD4F4F
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 10:13:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.18001.1695377569017967358
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Sep 2023 03:12:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38MACksb1359312; Fri, 22 Sep 2023 19:12:47 +0900
X-Iguazu-Qid: 2rWgyA9op8mDmjM2yH
X-Iguazu-QSIG: v=2; s=0; t=1695377566; q=2rWgyA9op8mDmjM2yH; m=u9kaJzm9M0VCMfZGnCoA5gCt1r/BqdC0RwXORUKNc8g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 38MACjTm210543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 Sep 2023 19:12:46 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] dosfstools: Add recipe to build it locally
Date: Fri, 22 Sep 2023 15:42:45 +0530
X-TSB-HOP2: ON
Message-Id: <20230922101245.3219-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Sep 2023 10:12:44.0373 (UTC) FILETIME=[54172050:01D9ED3D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 10:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13207

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

mkdosfs doesn't generate fat file-systems reproducibly, due to the
reason that the utility mkfs.fat is not honoring the variable
SOURCE_DATE_EPOCH and including build time stamps in the file system
headers, this issue has been fixed in upstream master branch but not
release yet, so building it locally with the patch.

This local build can be dropped when this patch[1] is available in
Debian releases, this ticket [2] monitors for creating release with
this patch.

[1] https://github.com/dosfstools/dosfstools/commit/8da7bc93315cb0c32ad868f17808468b81fa76ec
[2] https://github.com/dosfstools/dosfstools/issues/179

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/reproducible.yml                      |   1 +
 .../dosfstools/dosfstools_4.2-1.bb            |  17 ++
 ...ream-fix-for-honoring-SOURCE_DATE_EP.patch | 189 ++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 recipes-devtools/dosfstools/dosfstools_4.2-1.bb
 create mode 100644 recipes-devtools/dosfstools/files/0001-patches-Add-upstream-fix-for-honoring-SOURCE_DATE_EP.patch

diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index 9b56b28..fada232 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -15,3 +15,4 @@ local_conf_header:
   reproducible-builds: |
     SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
     WIC_DEPLOY_PARTITIONS = "1"
+    IMAGER_BUILD_DEPS += "dosfstools"
diff --git a/recipes-devtools/dosfstools/dosfstools_4.2-1.bb b/recipes-devtools/dosfstools/dosfstools_4.2-1.bb
new file mode 100644
index 0000000..009d99d
--- /dev/null
+++ b/recipes-devtools/dosfstools/dosfstools_4.2-1.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2023
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-gbp
+
+SRC_URI = "git://salsa.debian.org/debian/dosfstools.git;protocol=https;branch=master"
+SRC_URI += "file://0001-patches-Add-upstream-fix-for-honoring-SOURCE_DATE_EP.patch"
+SRCREV = "f59f4850586e88c945a922f5f9cc48b5da6c54fa"
+
+# this is a host tool
+PACKAGE_ARCH = "${HOST_ARCH}"
+
diff --git a/recipes-devtools/dosfstools/files/0001-patches-Add-upstream-fix-for-honoring-SOURCE_DATE_EP.patch b/recipes-devtools/dosfstools/files/0001-patches-Add-upstream-fix-for-honoring-SOURCE_DATE_EP.patch
new file mode 100644
index 0000000..30d6e2a
--- /dev/null
+++ b/recipes-devtools/dosfstools/files/0001-patches-Add-upstream-fix-for-honoring-SOURCE_DATE_EP.patch
@@ -0,0 +1,189 @@
+From dec30e5750511558f6c6b5134b51a67162174c05 Mon Sep 17 00:00:00 2001
+From: venkata pyla <venkata.pyla@toshiba-tsip.com>
+Date: Fri, 22 Sep 2023 14:11:47 +0530
+Subject: [PATCH] patches: Add upstream fix for honoring SOURCE_DATE_EPOCH
+
+Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
+---
+ ...Honor-the-SOURCE_DATE_EPOCH-variable.patch | 160 ++++++++++++++++++
+ debian/patches/series                         |   1 +
+ 2 files changed, 161 insertions(+)
+ create mode 100644 debian/patches/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch
+ create mode 100644 debian/patches/series
+
+diff --git a/debian/patches/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch b/debian/patches/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch
+new file mode 100644
+index 0000000..30c2132
+--- /dev/null
++++ b/debian/patches/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch
+@@ -0,0 +1,160 @@
++From 8da7bc93315cb0c32ad868f17808468b81fa76ec Mon Sep 17 00:00:00 2001
++From: =?UTF-8?q?Bj=C3=B8rn=20Forsman?= <bjorn.forsman@gmail.com>
++Date: Wed, 5 Dec 2018 19:52:51 +0100
++Subject: [PATCH] Honor the SOURCE_DATE_EPOCH variable
++MIME-Version: 1.0
++Content-Type: text/plain; charset=UTF-8
++Content-Transfer-Encoding: 8bit
++
++Implement the SOURCE_DATE_EPOCH specification[1] for reproducible
++builds. If SOURCE_DATE_EPOCH is set, use it as timestamp instead of the
++current time.
++
++[1] https://reproducible-builds.org/specs/source-date-epoch/
++
++Signed-off-by: Bjørn Forsman <bjorn.forsman@gmail.com>
++---
++ src/boot.c     | 23 +++++++++++++++++++++--
++ src/common.c   | 18 ++++++++++++++++--
++ src/mkfs.fat.c | 19 ++++++++++++++++---
++ 3 files changed, 53 insertions(+), 7 deletions(-)
++
++diff --git a/src/boot.c b/src/boot.c
++index 4de450d..8f78e1c 100644
++--- a/src/boot.c
+++++ b/src/boot.c
++@@ -33,6 +33,8 @@
++ #include <stdlib.h>
++ #include <sys/types.h>
++ #include <time.h>
+++#include <errno.h>
+++#include <ctype.h>
++ 
++ #include "common.h"
++ #include "fsck.fat.h"
++@@ -672,6 +674,7 @@ void write_volume_label(DOS_FS * fs, char *label)
++ {
++     time_t now;
++     struct tm *mtime;
+++    char *source_date_epoch = NULL;
++     off_t offset;
++     int created;
++     DIR_ENT de;
++@@ -687,8 +690,24 @@ void write_volume_label(DOS_FS * fs, char *label)
++     if (de.name[0] == 0xe5)
++ 	de.name[0] = 0x05;
++ 
++-    now = time(NULL);
++-    mtime = (now != (time_t)-1) ? localtime(&now) : NULL;
+++    source_date_epoch = getenv("SOURCE_DATE_EPOCH");
+++    if (source_date_epoch) {
+++        char *tmp = NULL;
+++        long long conversion = 0;
+++        errno = 0;
+++        conversion = strtoll(source_date_epoch, &tmp, 10);
+++        now = conversion;
+++        if (!isdigit((unsigned char)*source_date_epoch) || *tmp != '\0'
+++                || errno != 0 || (long long)now != conversion) {
+++            die("SOURCE_DATE_EPOCH is too big or contains non-digits: \"%s\"",
+++                source_date_epoch);
+++        }
+++        mtime = gmtime(&now);
+++    } else {
+++        now = time(NULL);
+++        mtime = (now != (time_t)-1) ? localtime(&now) : NULL;
+++    }
+++
++     if (mtime && mtime->tm_year >= 80 && mtime->tm_year <= 207) {
++ 	de.time = htole16((unsigned short)((mtime->tm_sec >> 1) +
++ 					   (mtime->tm_min << 5) +
++diff --git a/src/common.c b/src/common.c
++index 6a2e396..4f1afcb 100644
++--- a/src/common.c
+++++ b/src/common.c
++@@ -30,6 +30,7 @@
++ #include <string.h>
++ #include <stdarg.h>
++ #include <errno.h>
+++#include <ctype.h>
++ #include <wctype.h>
++ #include <termios.h>
++ #include <sys/time.h>
++@@ -298,8 +299,21 @@ void check_atari(void)
++ uint32_t generate_volume_id(void)
++ {
++     struct timeval now;
++-
++-    if (gettimeofday(&now, NULL) != 0 || now.tv_sec == (time_t)-1 || now.tv_sec < 0) {
+++    char *source_date_epoch = NULL;
+++
+++    source_date_epoch = getenv("SOURCE_DATE_EPOCH");
+++    if (source_date_epoch) {
+++        char *tmp = NULL;
+++        long long conversion = 0;
+++        errno = 0;
+++        conversion = strtoll(source_date_epoch, &tmp, 10);
+++        if (!isdigit((unsigned char)*source_date_epoch) || *tmp != '\0'
+++                || errno != 0) {
+++            die("SOURCE_DATE_EPOCH is too big or contains non-digits: \"%s\"",
+++                source_date_epoch);
+++        }
+++        return (uint32_t)conversion;
+++    } else if (gettimeofday(&now, NULL) != 0 || now.tv_sec == (time_t)-1 || now.tv_sec < 0) {
++         srand(getpid());
++         /* rand() returns int from [0,RAND_MAX], therefore only 31 bits */
++         return (((uint32_t)(rand() & 0xFFFF)) << 16) | ((uint32_t)(rand() & 0xFFFF));
++diff --git a/src/mkfs.fat.c b/src/mkfs.fat.c
++index 37fc8ff..1948635 100644
++--- a/src/mkfs.fat.c
+++++ b/src/mkfs.fat.c
++@@ -1074,7 +1074,7 @@ static void setup_tables(void)
++         }
++ 
++         /* If is not available then generate random 32 bit disk signature */
++-        if (invariant)
+++        if (invariant || getenv("SOURCE_DATE_EPOCH"))
++             disk_sig = volume_id;
++         else if (!disk_sig)
++             disk_sig = generate_volume_id();
++@@ -1287,7 +1287,7 @@ static void setup_tables(void)
++ 	    de->name[0] = 0x05;
++ 	de->attr = ATTR_VOLUME;
++ 	if (create_time != (time_t)-1) {
++-	    if (!invariant)
+++	    if (!invariant && !getenv("SOURCE_DATE_EPOCH"))
++ 		ctime = localtime(&create_time);
++ 	    else
++ 		ctime = gmtime(&create_time);
++@@ -1477,6 +1477,7 @@ int main(int argc, char **argv)
++     int blocks_specified = 0;
++     struct timeval create_timeval;
++     long long conversion;
+++    char *source_date_epoch = NULL;
++ 
++     enum {OPT_HELP=1000, OPT_INVARIANT, OPT_MBR, OPT_VARIANT, OPT_CODEPAGE, OPT_OFFSET};
++     const struct option long_options[] = {
++@@ -1497,8 +1498,20 @@ int main(int argc, char **argv)
++ 	    program_name = p + 1;
++     }
++ 
++-    if (gettimeofday(&create_timeval, NULL) == 0 && create_timeval.tv_sec != (time_t)-1)
+++    source_date_epoch = getenv("SOURCE_DATE_EPOCH");
+++    if (source_date_epoch) {
+++        errno = 0;
+++        conversion = strtoll(source_date_epoch, &tmp, 10);
+++        create_time = conversion;
+++        if (!isdigit((unsigned char)*source_date_epoch) || *tmp != '\0'
+++                || errno != 0 || (long long)create_time != conversion) {
+++            die("SOURCE_DATE_EPOCH is too big or contains non-digits: \"%s\"",
+++                source_date_epoch);
+++        }
+++    } else if (gettimeofday(&create_timeval, NULL) == 0 && create_timeval.tv_sec != (time_t)-1) {
++         create_time = create_timeval.tv_sec;
+++    }
+++
++     volume_id = generate_volume_id();
++     check_atari();
++ 
++-- 
++2.39.2
++
+diff --git a/debian/patches/series b/debian/patches/series
+new file mode 100644
+index 0000000..f52817f
+--- /dev/null
++++ b/debian/patches/series
+@@ -0,0 +1 @@
++0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch
+-- 
+2.39.2
+
-- 
2.20.1



