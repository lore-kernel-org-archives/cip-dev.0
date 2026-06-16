Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020EACD98D2
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 05:01:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.147526.1781586061065769280
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 22:01:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 65G50w4b747430; Tue, 16 Jun 2026 14:00:58 +0900
X-Iguazu-Qid: 2rWhEh6OXrsOAuxLsw
X-Iguazu-QSIG: v=2; s=0; t=1781586058; q=2rWhEh6OXrsOAuxLsw; m=3UGn7XZSoGUl4HZWQqsEBpT03PSkxj6KZDHrBPmVnnw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfZZK5YyYz1xnl; Tue, 16 Jun 2026 14:00:57 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 1/2] Enable Debian Sid support
Date: Tue, 16 Jun 2026 10:17:56 +0530
X-TSB-HOP2: ON
Message-Id: <20260616044758.3560272-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260616044758.3560272-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260616044758.3560272-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2026 05:00:53.0581 (UTC) FILETIME=[1BD957D0:01DCFD4D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 05:01:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23146

This patch enables to build the images based on the Debian sid version.
It helps to fix the issues in advance for the newer version.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 Kconfig       | 4 ++++
 start-qemu.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Kconfig b/Kconfig
index bd2b7ce..44f2337 100644
--- a/Kconfig
+++ b/Kconfig
@@ -239,6 +239,9 @@ config DEBIAN_BOOKWORM
 config DEBIAN_TRIXIE
 	bool "trixie (13)"
 
+config DEBIAN_SID
+	bool "Sid (Unstable)"
+
 endchoice
 
 config KAS_INCLUDE_DEBIAN
@@ -247,6 +250,7 @@ config KAS_INCLUDE_DEBIAN
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
 	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
+	default "kas/opt/sid.yml" if DEBIAN_SID
 
 comment "Image features"
 
diff --git a/start-qemu.sh b/start-qemu.sh
index 7ccbefe..d12fa23 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -45,6 +45,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
 		DISTRO_RELEASE="bookworm"
 	elif grep -s -q "DEBIAN_TRIXIE: true" .config.yaml; then
 		DISTRO_RELEASE="trixie"
+	elif grep -s -q "DEBIAN_SID: true" .config.yaml; then
+		DISTRO_RELEASE="sid"
 	else
 		echo "No supported Debian release configured"
 		exit 1
-- 
2.39.5



