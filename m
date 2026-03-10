Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E4AFCC9BC
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33058.1773117033458008257
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62A4UVvc3654704; Tue, 10 Mar 2026 13:30:31 +0900
X-Iguazu-Qid: 2rWgk9kdw2602nrXcd
X-Iguazu-QSIG: v=2; s=0; t=1773117031; q=2rWgk9kdw2602nrXcd; m=PqWnAbE41m3iF3dH6DxdoPSQIEYtGC8ryImUfCnylCc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXR3Zq4z4vys; Tue, 10 Mar 2026 13:30:31 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 4/7] SWUpdate: Use the backported package for trixie
Date: Tue, 10 Mar 2026 00:45:51 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:24.0140 (UTC) FILETIME=[9CEF4CC0:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22220

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Onboarding function requires atleast SWUpdate 2025.05, but this version
is only available via backports in trixie

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 conf/distro/cip-core-trixie.conf              |  3 +++
 conf/distro/debian-trixie-backports.list      |  1 +
 conf/distro/preferences.trixie-backports.conf | 11 +++++++++++
 3 files changed, 15 insertions(+)
 create mode 100644 conf/distro/debian-trixie-backports.list
 create mode 100644 conf/distro/preferences.trixie-backports.conf

diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index b133bbb..ad859f1 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -14,3 +14,6 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "6.12.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
+
+DISTRO_APT_SOURCES:append:wfx-onboard = " conf/distro/debian-trixie-backports.list"
+DISTRO_APT_PREFERENCES:append:wfx-onboard = " conf/distro/preferences.trixie-backports.conf"
diff --git a/conf/distro/debian-trixie-backports.list b/conf/distro/debian-trixie-backports.list
new file mode 100644
index 0000000..197bd47
--- /dev/null
+++ b/conf/distro/debian-trixie-backports.list
@@ -0,0 +1 @@
+deb http://deb.debian.org/debian trixie-backports main contrib non-free
diff --git a/conf/distro/preferences.trixie-backports.conf b/conf/distro/preferences.trixie-backports.conf
new file mode 100644
index 0000000..1a7ccdb
--- /dev/null
+++ b/conf/distro/preferences.trixie-backports.conf
@@ -0,0 +1,11 @@
+Package: swupdate
+Pin: release n=trixie-backports
+Pin-Priority: 801
+
+Package: libswupdate0.1
+Pin: release n=trixie-backports
+Pin-Priority: 801
+
+Package: libswupdate-dev
+Pin: release n=trixie-backports
+Pin-Priority: 801
-- 
2.39.5



