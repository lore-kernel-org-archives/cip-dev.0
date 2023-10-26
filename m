Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291AAC25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 08:30:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.195386.1698309005509626541
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Oct 2023 01:30:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 39Q8U2UV1433795; Thu, 26 Oct 2023 17:30:03 +0900
X-Iguazu-Qid: 2yAb1dkSj71HGUuu14
X-Iguazu-QSIG: v=2; s=0; t=1698309002; q=2yAb1dkSj71HGUuu14; m=B4YfYmBZMAHaOaZkiQHg1BKqKMzHMlOanCuq8f/xchM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 39Q8U1CG4088073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 17:30:01 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 3/3] swupdate.bbclass: Use root privileges when creating swu file
Date: Thu, 26 Oct 2023 13:59:59 +0530
X-TSB-HOP2: ON
Message-Id: <20231026082959.16939-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
References: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Oct 2023 08:29:58.0013 (UTC) FILETIME=[9AB2C2D0:01DA07E6]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 08:30:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13460

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Getting Permission denied error while creating swu file, it also causing
the reproducible build failure

```
sw-description
sw-description.sig
touch: cannot touch 'linux.efi': Permission denied
linux.efi
cip-core-image-cip-core-bookworm-qemu-amd64.squashfs
266496 blocks
DEBUG: Shell function do_image_swu finished
```

Modified to run swu file creation with root privileges.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 3cf17a2..38c2e0a 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -106,7 +106,7 @@ IMAGE_CMD:swu() {
     # Prepare for signing
     export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
 
-    imager_run -p -d ${PP_WORK} <<'EOIMAGER'
+    imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
         # Fill in file check sums
         for file in ${SWU_ADDITIONAL_FILES}; do
             sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/swu/"$file | cut -f 1 -d " "):g" \
-- 
2.20.1



