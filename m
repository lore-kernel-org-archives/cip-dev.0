Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80228C001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 09:17:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.103546.1692004640782022923
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 02:17:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37E9HIi7358923; Mon, 14 Aug 2023 18:17:18 +0900
X-Iguazu-Qid: 2rWhoCDaOEH4Ac5Lwi
X-Iguazu-QSIG: v=2; s=0; t=1692004638; q=2rWhoCDaOEH4Ac5Lwi; m=A5doaexF4d9M4bidAivEMTz7Ta52mKZ7m9xKZJrabxc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 37E9HGBh2519726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Aug 2023 18:17:17 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/4] kas/opt/reproducible.yml: Enable extracting individual partition files
Date: Mon, 14 Aug 2023 14:47:11 +0530
X-TSB-HOP2: ON
Message-Id: <20230814091714.9400-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
References: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2023 09:17:13.0995 (UTC) FILETIME=[1CEB85B0:01D9CE90]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 09:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12629

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Reproducible checks are done till now on the contents of the image like
rootfs, vmlinux, initrd and other swupdate artifacts, but not the
file system images that were finally copied into.

file system images will have additional header information like label, uuid
and other data that should be verified against reproducibility.

So, allow reproducible builds to extract individual partition files that
are formatted with respective file systems and had contents, compare them
to check they are reproducibly created.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/reproducible.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index e071c3d..9b56b28 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -14,3 +14,4 @@ header:
 local_conf_header:
   reproducible-builds: |
     SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
+    WIC_DEPLOY_PARTITIONS = "1"
-- 
2.20.1



