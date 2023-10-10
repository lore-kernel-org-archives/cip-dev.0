Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F284CD68F8
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 07:51:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.85928.1696924271535339286
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 00:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 39A7p8pm1303313; Tue, 10 Oct 2023 16:51:09 +0900
X-Iguazu-Qid: 2yAbn6s0GPUY6hIetq
X-Iguazu-QSIG: v=2; s=0; t=1696924268; q=2yAbn6s0GPUY6hIetq; m=I64oU0mSt+Zjv9OCzgUAtfPl7uL4mOeT1myBMzHbNf0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 39A7p7fQ1967994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 16:51:08 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 2/2] simatic-ipc227e: conf: Add WKS_FILE as x86_64-generic.wks
Date: Tue, 10 Oct 2023 16:50:14 +0900
X-TSB-HOP2: ON
Message-Id: <20231010075014.3761016-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010075014.3761016-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20231010075014.3761016-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 07:51:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13339

wic/simatic-ipc227e.wks has been changed to wic/x86_64-generic.wks. This
is set in the WKS_FILE variable.
This file format is different from conf/distro/cip-core-common.inc, so we need
to set WKS_FILE as x86_64-generic.wks in simatic-ipc227e.conf.
Add WKS_FILE to simatic-ipc227e.conf.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 conf/machine/simatic-ipc227e.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index a624fcd..8bb3e80 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -9,6 +9,7 @@
 DISTRO_ARCH = "amd64"
 
 IMAGE_FSTYPES ?= "wic"
+WKS_FILE ?= "x86_64-generic.wks"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
-- 
2.42.0



