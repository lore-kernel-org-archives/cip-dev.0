Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E79C4332F
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 11:16:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.8798.1666351008549033283
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Oct 2022 04:16:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 29LBGkWb021445; Fri, 21 Oct 2022 20:16:47 +0900
X-Iguazu-Qid: 34tMJXdtWeTrRNwsoE
X-Iguazu-QSIG: v=2; s=0; t=1666351006; q=34tMJXdtWeTrRNwsoE; m=Ub5xC+YohJuUF3HEkAnzBwqMwmbuxXrtmcIHJwq1GZ8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 29LBGjwd038042
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 21 Oct 2022 20:16:46 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] doc/README.secureboot.md : Add method to check secure boot status in arm arch.
Date: Fri, 21 Oct 2022 16:46:41 +0530
X-TSB-HOP2: ON
Message-Id: <20221021111641.27627-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Oct 2022 11:16:43.0333 (UTC) FILETIME=[997DEF50:01D8E53E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Oct 2022 11:16:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9802

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

The dmesg will not show secure boot status for arm64 or armhf
architectures.
Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 doc/README.secureboot.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 26d8c87..714331f 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -217,6 +217,10 @@ After boot check the dmesg for secure boot status like below:
 root@demo:~# dmesg | grep Secure
 [    0.008368] Secure boot enabled
 ```
+In case of arm64 or armhf architectures, the secure boot status can be found in bootloader logs like below:
+```
+EFI stub: UEFI Secure Boot is enabled.
+```
 ## Example: Update the image
 
 For updating the image, the following steps are necessary:
-- 
2.20.1



