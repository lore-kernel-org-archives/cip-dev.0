Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEDFC54E55
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 07:45:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.18217.1709797555596097576
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 23:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4277jrnJ2670744; Thu, 7 Mar 2024 16:45:53 +0900
X-Iguazu-Qid: 2yAawbgn0wgfftke5F
X-Iguazu-QSIG: v=2; s=0; t=1709797552; q=2yAawbgn0wgfftke5F; m=v1aFdulxRbpHqMWFKfRBERZwGrZOmTOaOxMh9F+ezyw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 4277jpXR1313310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Mar 2024 16:45:52 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v1 1/6] conf: Use bookworm backports for enabling delta handler in swupdate
Date: Thu,  7 Mar 2024 13:16:07 +0530
X-TSB-HOP2: ON
Message-Id: <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 07:45:48.0462 (UTC) FILETIME=[78621CE0:01DA7063]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 07:45:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15252

Delta handler requires zchunk > 1.3, but the required version is only
available in bookworm backports

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 conf/distro/cip-core-bookworm.conf                   |  3 +++
 conf/distro/debian-bookworm-backports.list           |  1 +
 .../preferences.swupdate-bookworm-backports.conf     | 12 ++++++++++++
 3 files changed, 16 insertions(+)
 create mode 100644 conf/distro/debian-bookworm-backports.list
 create mode 100644 conf/distro/preferences.swupdate-bookworm-backports.conf

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index 9bcf559..e0a4f7f 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -12,6 +12,9 @@
 require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
+DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bookworm-backports.list"
+DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bookworm-backports.conf"
+
 PREFERRED_VERSION_swupdate ?= "2023.05%"
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/conf/distro/debian-bookworm-backports.list b/conf/distro/debian-bookworm-backports.list
new file mode 100644
index 0000000..c4873b4
--- /dev/null
+++ b/conf/distro/debian-bookworm-backports.list
@@ -0,0 +1 @@
+deb http://deb.debian.org/debian bookworm-backports main contrib non-free
diff --git a/conf/distro/preferences.swupdate-bookworm-backports.conf b/conf/distro/preferences.swupdate-bookworm-backports.conf
new file mode 100644
index 0000000..b6efffc
--- /dev/null
+++ b/conf/distro/preferences.swupdate-bookworm-backports.conf
@@ -0,0 +1,12 @@
+Package: libzck-dev
+Pin: release n=bookworm-backports
+Pin-Priority: 801
+
+Package: libzck1
+Pin: release n=bookworm-backports
+Pin-Priority: 801
+
+Package: zchunk
+Pin: release n=bookworm-backports
+Pin-Priority: 801
+
-- 
2.39.2



