Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB0CDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 07:49:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15799.1782200994235802130
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 00:49:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65N7nquw3788587; Tue, 23 Jun 2026 16:49:52 +0900
X-Iguazu-Qid: 2yAbcyMlSkpUZKa1sh
X-Iguazu-QSIG: v=2; s=0; t=1782200992; q=2yAbcyMlSkpUZKa1sh; m=IUqByO9vXYrWJtjCV7auoGR2HGTkAVP5Zzs4KwHnmOI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gky002JqMzyPZ; Tue, 23 Jun 2026 16:49:52 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v3 3/4] Add crypt library packages for Debian sid version
Date: Tue, 23 Jun 2026 13:06:40 +0530
X-TSB-HOP2: ON
Message-Id: <20260623073642.964019-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260623073642.964019-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260623073642.964019-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2026 07:49:47.0152 (UTC) FILETIME=[DCD1D100:01DD02E4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 07:49:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23261

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb           | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 3cb0520..9132ad3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -38,9 +38,11 @@ DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
 DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
+DEBIAN_DEPENDS:append:sid   = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
 
 DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
 DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
+DEBIAN_DEPENDS:append:systemd:sid   = ", systemd-cryptsetup"
 DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
 
 HOOK_ADD_MODULES = " \
-- 
2.39.5



