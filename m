Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E49C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 12:47:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.14582.1740746825870076704
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 04:47:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=eNryQvHH;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=1740746824;x=1741956424;bh=CJeE
	T8w6f0f9cUWRHyIwYhkPc9bU8Kx2pjGieHHiYB0=;b=eNryQvHHLWlMYrmdmPbLkQm92CQTFDJY1T
	edBOKOwIivOGsoVO5rYlw5kAeYbsI8VG4Ia4L+jnXauZycSnTygis1l6OyAfRKLPMA4BmjCWxd3/u
	gtTFsnzXSgtTZXnVb5jK7QskOOcNIN19Dk5F9R77uzYxcW+/2MzUtXVzR+bZsjom/KiTGeH+bVeud
	OHgdohbkgPrieS4y4hZPj9TeSa1lM5BXmRDN9Fq+WnpNtJPpo0OuFwhJG7kR3qNP5KuqILhOVzZLu
	L5cWO7ZZY0V0WlNbxXG/yullExDDhh2hsixd/+CfNFoPkmsS7azPalqkUcAh2b8BQ8WF11+jWdLDA
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51SCl3NP110765; Fri, 28 Feb 2025 21:47:04 +0900
X-Iguazu-Qid: 2rWhWAeBk23tTwH3wm
X-Iguazu-QSIG: v=2; s=0; t=1740746823; q=2rWhWAeBk23tTwH3wm; m=XP3PKunonTvG0z7J1jgnkngOXCck3onikz7F8BG4CKg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 51SCl1rP3245964
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:47:02 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 2/2] Kconfig: Add config NO_KERNEL for kernel selection
Date: Fri, 28 Feb 2025 21:46:46 +0900
X-TSB-HOP2: ON
Message-Id: <1740746806-6557-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 12:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17985

This adds config NO_KERNEL not to install the kernel select.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index 3c246fa..cfa4d11 100644
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



