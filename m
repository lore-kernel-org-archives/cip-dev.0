Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE0CDB47C
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 07:49:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15798.1782200993518937609
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 00:49:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65N7npws3447876; Tue, 23 Jun 2026 16:49:51 +0900
X-Iguazu-Qid: 2yAb6z3jLoL9NMl5D6
X-Iguazu-QSIG: v=2; s=0; t=1782200991; q=2yAb6z3jLoL9NMl5D6; m=8TV9MuRpeTdRWz8HiVCNP4uIRJrtaRDdvUUQcte/lHk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gkxzz37BlzyPQ; Tue, 23 Jun 2026 16:49:51 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v3 2/4] Add the default kernel verions in cip-core-common.inc with extra weak
Date: Tue, 23 Jun 2026 13:06:39 +0530
X-TSB-HOP2: ON
Message-Id: <20260623073642.964019-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260623073642.964019-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260623073642.964019-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2026 07:49:47.0074 (UTC) FILETIME=[DCC5EA20:01DD02E4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 07:49:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23260

The distro specific conf files (e.g conf/distro/debian-trixie.conf)
override this option to set the kernel versions specific to the distros.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 conf/distro/cip-core-common.inc | 3 +++
 1 file changed, 3 insertions(+)

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
 
-- 
2.39.5



