Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147CDC87FD3
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 05:22:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.18264.1754457758239551483
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 22:22:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=DtU4FBIh;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1754457756;x=1755667356;bh=ulD8
	MRlJghfT7X5aWTnU2/1+3/YbQHzxMQPiPW2Wze4=;b=DtU4FBIhdrH7sBGZtuQkLYWX+4WahOk32/
	US/ZgkIHlCCmDUE9mEb8SrvuNx8OA2ktJPXlUZw3mbxETDzwbrMvhcPs17HFawD+OVCfBut4pbkhP
	B+V8qj4AJ6KJ08uULdYC2jiyhRdTZD8hgIV94YaLQnoDAsUb68yrTujpHcj5Gu2BFwyXF/8deyzRc
	xR1TnLOUJ8PDxoCkLYg8hPhHFcfH9MFuht7qeDQ9QvZM2VEdkDmZoI5gAMHLax+j6SJ9UgNnF5ifo
	zrt0QBz/uxP1Ot75a9KjeaP8tGwktGEGCSdVr0PE3voxGBr0WCM1Mmsjp7FB3JKJjCwSMi5Iy7Bog
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5765MZEo3449931; Wed, 6 Aug 2025 14:22:36 +0900
X-Iguazu-Qid: 2rWh5b6vJTXc56Lu4K
X-Iguazu-QSIG: v=2; s=0; t=1754457755; q=2rWh5b6vJTXc56Lu4K; m=bRNtmoJOzylGREysP4Mt7oWq9ENJBrwoFYIdRBtdCeo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 5765MXaE1143126
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 14:22:34 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v4 2/2] Kconfig: Add config NO_KERNEL for kernel selection
Date: Wed,  6 Aug 2025 14:22:22 +0900
X-TSB-HOP2: ON
Message-Id: <1754457742-4006-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 05:22:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19679

This adds config NO_KERNEL not to install the kernel select.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

---

v4:
  - Update description for help.
v3:
  - Add description for help.

 Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Kconfig b/Kconfig
index e078892..3196b91 100644
--- a/Kconfig
+++ b/Kconfig
@@ -114,6 +114,13 @@ config KERNEL_6_12
 	bool "Kernel 6.12.x-cip"
 	depends on !TARGET_IWG20D
 
+config NO_KERNEL
+	bool "Do not install kernel to image"
+	help
+	  This does not build the kernel or install it on rootfs.
+	  This can be used when creating images for testing kernels that are
+	  built separately, e.g. via KernleCI.
+
 endchoice
 
 config KAS_INCLUDE_KERNEL
@@ -123,6 +130,7 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/5.10.yml" if KERNEL_5_10
 	default "kas/opt/6.1.yml" if KERNEL_6_1
 	default "kas/opt/6.12.yml" if KERNEL_6_12
+	default "kas/opt/no_kernel.yml" if NO_KERNEL
 
 config KERNEL_HEAD
 	bool "Head of selected CIP kernel branch"
-- 
2.50.0



