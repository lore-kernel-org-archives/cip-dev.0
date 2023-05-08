Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51DCC77B7F
	for <webhook@archiver.kernel.org>; Mon,  8 May 2023 15:40:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.111086.1683560438952917111
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 May 2023 08:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 348Fealj014315; Tue, 9 May 2023 00:40:37 +0900
X-Iguazu-Qid: 2wHHaIQrAK6NM1U8iO
X-Iguazu-QSIG: v=2; s=0; t=1683560436; q=2wHHaIQrAK6NM1U8iO; m=JFt2Wcb0ETo1kZPpB7sAxOyaHT4bDelh4hAU2ddpBp0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 348FeZwH038896
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 9 May 2023 00:40:36 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] image_uuid.bbclass: create /etc/osrelease file before do_rootfs_finalize
Date: Mon,  8 May 2023 21:10:30 +0530
X-TSB-HOP2: ON
Message-Id: <20230508154031.26473-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 May 2023 15:40:33.0603 (UTC) FILETIME=[6D45B130:01D981C3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 May 2023 15:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11416

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

reproducible build with swupdate target is getting failed due to the
`/etc/osrelease` file timestamp is not constant across builds, it is due
to the file is generated after `do_rootfs_finalize` task and the
timestamps of the files are made constant in this task and so move the
task `do_generate_image_uuid` prior to `do_rootfs_finalize`.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 classes/image_uuid.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 2bd530f..9ffe14d 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -54,4 +54,4 @@ do_generate_image_uuid() {
     echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
         > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
 }
-addtask generate_image_uuid before do_image after do_rootfs
+addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_postprocess
-- 
2.20.1



