Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84500D2069E
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 05:44:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.16789.1729057469067483105
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Oct 2024 22:44:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=cYNYcwty;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1729057466;x=1730267066;bh=FWiNFzit3Xd1fasoOyYoP8tbl7yO8xHuA7zvtOIMh84=;b=cYN
	YcwtyqXmogQqXPCcf0LhJTdIU9x/UvsXAIWoHTOTEJWlE+lrEi35XZioddTZT16B3VTwLtE8WDjE+
	VKdz7cn28ohbPRra9KHeW54bP1jHJOWTiXzmswn/CbLl/amzpuU5Ujyv1leGHbdF2Fj3NJtkZVkFL
	uJoty12flsLitwIEGzZdNrDl2jj0NSe9JJDZZHKc988cNNBqNKfy4geKiyO3EuPDUKFcZUF6OfiqZ
	DkSSId3wJGn2slCt1XcR5VpXxOL5cYkHU+vzagI/huT+N/zAG2lQbD46Ecij4+BnFI4BgdSMzWv/1
	Jkec96In2DZMOkSUS6xOi7d5qhVI9Ig==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 49G5iPj63139133; Wed, 16 Oct 2024 14:44:26 +0900
X-Iguazu-Qid: 2yAaKAjYsqpPJsVvgh
X-Iguazu-QSIG: v=2; s=0; t=1729057465; q=2yAaKAjYsqpPJsVvgh; m=JKVQV0D8++F55O4Lxeq6Z/14WtSVqxmBVWmFmVOsV68=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 49G5iONh2515632
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:44:24 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] Kconfig: Update default kernel version to 6.1.y
Date: Wed, 16 Oct 2024 14:44:10 +0900
X-TSB-HOP2: ON
Message-Id: <1729057450-4949-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Oct 2024 05:44:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17044

The default Debian version is bookworm in Kconfig, so we should also set
the default kernel to the same version used by bookworm.
This updates default kernel version to 6.1.y in Kconfig.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index a70ce22..8062cdb 100644
--- a/Kconfig
+++ b/Kconfig
@@ -84,7 +84,7 @@ comment "Kernel options"
 
 choice
 	prompt "CIP kernel version"
-	default KERNEL_5_10
+	default KERNEL_6_1
 
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
-- 
2.45.2



