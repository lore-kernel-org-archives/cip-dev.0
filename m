Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F6EC35FF3
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 08:04:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.16107.1742544245310876500
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 01:04:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=jxAb+1Co;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=1742544242;x=1743753842;bh=73Qo
	LbWpi/na84jzFeIQA/X4FgFT7/2hMkDaKXxYoGw=;b=jxAb+1Co8gVCMCmTYdrwOQgI+G9CX2RCY6
	F+mhxuviN1vSKThCnOaSu/HeU27x4XqtM2QG5DHDw9fBk1Hm/Bi5FjUw5Pvk58HyoZbGLU7FQOmMU
	QO+CFLEUWLRiqJwp9vs8BhrdqXKqiqtS0esvF+blSsv55LZ4PwBbo896jnFNlAeDdR+ay9ShrYcAc
	04mRY1fVNITYa/vnwuHLyhuoUtFCUYCXqpdLwak8cNBVtXk9ZZuHyPz/Y/B4mw77cqmupxqBmA2HK
	5VLuU1hp653K9ELd6+3ztiN8nAGW6WY0nvXJrISRmqwU+6ji5+cLG+K9g7HxqjY7Tt5068G5XscJQ
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 52L842DX636536; Fri, 21 Mar 2025 17:04:02 +0900
X-Iguazu-Qid: 2rWhqikydrpzNTDv7d
X-Iguazu-QSIG: v=2; s=0; t=1742544241; q=2rWhqikydrpzNTDv7d; m=y+mVOlfQxlL4yuJtLdLo/hPSUhRyiTd6P636rairiIc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 52L840pI1524738
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 17:04:01 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v2 2/2] Kconfig: Add config NO_KERNEL for kernel selection
Date: Fri, 21 Mar 2025 17:03:50 +0900
X-TSB-HOP2: ON
Message-Id: <1742544230-24109-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1742544230-24109-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1742544230-24109-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 08:04:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18303

This adds config NO_KERNEL not to install the kernel select.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index a726d26..1dad538 100644
--- a/Kconfig
+++ b/Kconfig
@@ -100,6 +100,9 @@ config KERNEL_5_10
 config KERNEL_6_1
 	bool "Kernel 6.1.x-cip"
 
+config NO_KERNEL
+	bool "Do not install kernel to image"
+
 endchoice
 
 config KAS_INCLUDE_KERNEL
@@ -108,6 +111,7 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/4.19.yml" if KERNEL_4_19
 	default "kas/opt/5.10.yml" if KERNEL_5_10
 	default "kas/opt/6.1.yml" if KERNEL_6_1
+	default "kas/opt/no_kernel.yml" if NO_KERNEL
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
-- 
2.45.2



