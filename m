Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B3ECD98CE
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 05:01:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.147129.1781586061332093310
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 22:01:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 65G50xpK2398289; Tue, 16 Jun 2026 14:00:59 +0900
X-Iguazu-Qid: 2rWh2r9tKWXjxtc1cn
X-Iguazu-QSIG: v=2; s=0; t=1781586058; q=2rWh2r9tKWXjxtc1cn; m=f2S1P8NABkze7m4ojGN2N/WfyXQWhofaHvlixXFDeVg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfZZL49pDz1xnp; Tue, 16 Jun 2026 14:00:58 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 2/2] Add packages for Debian sid version
Date: Tue, 16 Jun 2026 10:17:57 +0530
X-TSB-HOP2: ON
Message-Id: <20260616044758.3560272-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260616044758.3560272-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260616044758.3560272-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2026 05:00:53.0659 (UTC) FILETIME=[1BE53EB0:01DCFD4D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 05:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23145

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb           | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 3cb0520..2c3c331 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -38,9 +38,11 @@ DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
 DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
+DEBIAN_DEPENDS:append:sid = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
 
 DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
 DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
+DEBIAN_DEPENDS:append:systemd:sid = ", systemd-cryptsetup"
 DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
 
 HOOK_ADD_MODULES = " \
-- 
2.39.5



