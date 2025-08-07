Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0CC87FD3
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 02:46:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.41785.1754534757081188147
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 19:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=mVw+0Mu7;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1754534754;x=1755744354;bh=WwSf
	idsN3j8xvfJ38hJeDkXSIJ2MysCI8i04h/HDQBs=;b=mVw+0Mu7w9XpbTAFpakA5nkxbygXzQSeW5
	Hc0IJ5ecnCLaNdnn5Iw5x7E+FFer2QQ2cJF4Rc+sT2SPif30NSGhBAwhIUxi3t+w5azZPhbYgRvS7
	jmDgXFTTj78hWXIW27oRwm2qgEPmeWzLfY6kTUqFPftk4BcHLTXAzssZgaA9BuCyYAT9gsr7BJtr1
	q53Da7jWHONnALfRVwn4XA6nklPYKDpUAf2X1CctnqfEHipdEX46idwFzTSqkUICm/3CBOcMEZZI/
	lFpIdm08ah6JV2v7m3Xd1SY6xR2DRc59gKzw7I7jOIP8X02SjWISON9OiDysF9qgJKthvXWPL69lQ
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5772jsq21386366; Thu, 7 Aug 2025 11:45:54 +0900
X-Iguazu-Qid: 2yAbyr8UsoVBL3w0bG
X-Iguazu-QSIG: v=2; s=0; t=1754534753; q=2yAbyr8UsoVBL3w0bG; m=VWPKpOnxnoqLXFqQzAVNixPVYaKKDbdq38SuPY9+Zx4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 5772jq1a3493567
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 11:45:53 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v5 2/3] Kconfig: Add config NO_KERNEL for kernel selection
Date: Thu,  7 Aug 2025 11:45:48 +0900
X-TSB-HOP2: ON
Message-Id: <1754534749-19754-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1754534749-19754-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1754534749-19754-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 02:46:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19701

This adds config NO_KERNEL not to install the kernel select.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---

v5:
  - No update
v4:
  - Update description for help.
v3:
  - Add description for help.
v2:
  - No update

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



