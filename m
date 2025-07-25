Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B33C83F26
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 08:41:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.14778.1753432860561749571
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Jul 2025 01:41:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=bznHdqQx;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1753432858;x=1754642458;bh=pkqb
	A/S4F7ZTx+aH6YlicrWUHzGwsycxO0V2KhNr1N4=;b=bznHdqQx2t/LiWdZk16fn7Knase9uIgdI7
	Aoci/FVaiFmw1cXAE++FVOTIrnSew0+43FjInQD1GZQ2/HDi7H75gQO1jOPqLvhMbTsamGT2usIIO
	hUOUas+nqLnf/ZPqWP/zg7lozu5FVEBLUQKVaO6He5MhfcaPrCMvli241qw9djJ/chPLJRRq6sM0w
	L2UEbrigYLCtdOL2ljpvTCV/Aovsn8tsXy236CQCojI9TS6hwDTP90pyof/7F2S9G9x+3uE9R52ed
	loFiDfsLUb4jidiG/OqAadeFlR8JYEV4b3Z41Tfa+JAdL9t8Ac2c/M7Lem3kQjZ9sG56JPGr+mY6A
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 56P8ev5k3879679; Fri, 25 Jul 2025 17:40:58 +0900
X-Iguazu-Qid: 2rWhyCKR9GUvAdM7k5
X-Iguazu-QSIG: v=2; s=0; t=1753432857; q=2rWhyCKR9GUvAdM7k5; m=ECvCryZaqffe3X3l4CDg/4017uqG+mtNCETJ4M5HOiQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 56P8euLa860610
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:40:57 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v3 2/2] Kconfig: Add config NO_KERNEL for kernel selection
Date: Fri, 25 Jul 2025 17:40:49 +0900
X-TSB-HOP2: ON
Message-Id: <1753432849-18257-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Jul 2025 08:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19592

This adds config NO_KERNEL not to install the kernel select.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

---
v3:
  - Add description for help.

 Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Kconfig b/Kconfig
index e078892..6ad0d67 100644
--- a/Kconfig
+++ b/Kconfig
@@ -114,6 +114,12 @@ config KERNEL_6_12
 	bool "Kernel 6.12.x-cip"
 	depends on !TARGET_IWG20D
 
+config NO_KERNEL
+	bool "Do not install kernel to image"
+	help
+          This does not build the kernel or install it on rootfs.
+          This can be used when creating images for kernel testing.
+
 endchoice
 
 config KAS_INCLUDE_KERNEL
@@ -123,6 +129,7 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/5.10.yml" if KERNEL_5_10
 	default "kas/opt/6.1.yml" if KERNEL_6_1
 	default "kas/opt/6.12.yml" if KERNEL_6_12
+	default "kas/opt/no_kernel.yml" if NO_KERNEL
 
 config KERNEL_HEAD
 	bool "Head of selected CIP kernel branch"
-- 
2.45.2



