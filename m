Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C14CDB46F
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 11:05:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18213.1782212744295552085
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 04:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65NB5gwE165398; Tue, 23 Jun 2026 20:05:42 +0900
X-Iguazu-Qid: 2yAbPsFEuWZ6Dukvdz
X-Iguazu-QSIG: v=2; s=0; t=1782212742; q=2yAbPsFEuWZ6Dukvdz; m=WfsXDBCrMWkeWh+zaLIwVFuqvQ0pSbW90gkE+c0GEUM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gl2Kx69lzz1xnZ; Tue, 23 Jun 2026 20:05:41 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v4 1/3] Add the default kernel verions in cip-core-common.inc with extra weak
Date: Tue, 23 Jun 2026 16:22:32 +0530
X-TSB-HOP2: ON
Message-Id: <20260623105234.972121-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2026 11:05:38.0941 (UTC) FILETIME=[396E82D0:01DD0300]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 11:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23267

The distro specific conf files (e.g conf/distro/debian-trixie.conf)
override this option to set the kernel versions specific to the distros.
The default kernel versions will be used if not mentioned in the distro
specific conf files.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 conf/distro/cip-core-common.inc  | 3 +++
 conf/distro/cip-core-trixie.conf | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 0b45636..8a1db61 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -18,6 +18,9 @@ CIP_IMAGE_OPTIONS ?= ""
 IMAGER_BUILD_DEPS:append:bullseye = " dosfstools-native"
 IMAGER_BUILD_DEPS:append:bookworm = " dosfstools-native"
 
+PREFERRED_VERSION_linux-cip ??= "6.12.%"
+PREFERRED_VERSION_linux-cip-rt ??= "6.12.%"
+
 PREFERRED_VERSION_linux-cip-native ?= "${PREFERRED_VERSION_linux-cip}"
 PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
 
diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index b133bbb..79a05fa 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -11,6 +11,3 @@
 
 require conf/distro/debian-trixie.conf
 require cip-core-common.inc
-
-PREFERRED_VERSION_linux-cip ?= "6.12.%"
-PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
-- 
2.39.5



