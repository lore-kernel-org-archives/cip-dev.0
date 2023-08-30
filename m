Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77924C83F18
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 04:41:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.7006.1693370482003039612
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 21:41:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 37U4fK803197270; Wed, 30 Aug 2023 13:41:20 +0900
X-Iguazu-Qid: 2rWgJRkMVnDRxnCCsl
X-Iguazu-QSIG: v=2; s=0; t=1693370479; q=2rWgJRkMVnDRxnCCsl; m=k/J2nY7ce+ustnGnItc/xHIEi79PvdDS9ZkaRYPuJaY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 37U4fIuM505392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 30 Aug 2023 13:41:19 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/3] deploy-cip-core.sh: Workaround to search for swupdate initrd image name
Date: Wed, 30 Aug 2023 10:11:14 +0530
X-TSB-HOP2: ON
Message-Id: <20230830044115.1112349-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Aug 2023 04:41:16.0103 (UTC) FILETIME=[3641B570:01D9DAFC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 04:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12905

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Since the security image is now included with swupdate feature, deployment
of initrd image will fail in CI due to name mismatch. So this workaround
will search for initrd image name as defined in read-only-rootfs.bbclass

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index eaa8974..868e28e 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -46,9 +46,16 @@ KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
 if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
 	KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
 fi
+
+INITRD_IMAGE="${BASE_PATH}-initrd.img"
+# swupdate image initrd search workaround
+if [ -f "build/tmp/deployimages/$TARGET/cip-core-initramfs-cip-core-$RELEASE-$TARGET.initrd.img" ]; then
+	INITRD_IMAGE=build/tmp/deploy/images/$TARGET/cip-core-initramfs-cip-core-$RELEASE-$TARGET.initrd.img
+fi
+
 # shellcheck disable=SC2086
 aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
-aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
+aws s3 cp --no-progress --acl public-read "${INITRD_IMAGE}" "${S3_TARGET}"
 
 if [ "$DTB" != "none" ]; then
 	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
-- 
2.30.2



