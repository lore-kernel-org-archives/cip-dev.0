Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906A7C83F11
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 10:43:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.10397.1693219422256616966
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Aug 2023 03:43:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 37SAhd8D1952235; Mon, 28 Aug 2023 19:43:40 +0900
X-Iguazu-Qid: 2rWgoVec2A2abtgvhq
X-Iguazu-QSIG: v=2; s=0; t=1693219419; q=2rWgoVec2A2abtgvhq; m=WSoIbwCsVuj2Bg0F5x3EGeD1ju00F25gpenGIavjONU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 37SAhcag1530531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Aug 2023 19:43:39 +0900
From: tho1.nguyendat@toshiba.co.jp
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: tho1.nguyendat@toshiba.co.jp, kazuhiro3.hayashi@toshiba.co.jp
Subject: [PATCH 3/3] u-boot: Add EFI secure boot dependency
Date: Mon, 28 Aug 2023 17:43:15 +0700
X-TSB-HOP2: ON
Message-Id: <20230828104315.466393-4-tho1.nguyendat@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
References: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 10:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12884

From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>

CONFIG_EFI_SECURE_BOOT depends on CONFIG_FIT_SIGNATURE.
Enable CONFIG_FIT_SIGNATURE to make sure CONFIG_EFI_SECURE_BOOT enabled

Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
---
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
index 956dcbf..6111007 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -4,3 +4,4 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv scan_dev_for_boot 'if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
 CONFIG_EFI_VARIABLES_PRESEED=y
 CONFIG_EFI_SECURE_BOOT=y
+CONFIG_FIT_SIGNATURE=y
-- 
2.39.2



