Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50930C7EE2A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 07:35:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.25349.1685604902249713153
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 00:35:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 3517YxtW025089; Thu, 1 Jun 2023 16:35:00 +0900
X-Iguazu-Qid: 2wHHJG9eOH6A4CHFEh
X-Iguazu-QSIG: v=2; s=0; t=1685604899; q=2wHHJG9eOH6A4CHFEh; m=zkyEFW1zBTs3KKdNS9WSzehAuFWuUT6pO5FYfWWatmc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 3517Yw0f031652
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 16:34:59 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/3] kas/opt/ext4-targz-img: option file to create ext4 and tar ball images
Date: Thu,  1 Jun 2023 13:04:52 +0530
X-TSB-HOP2: ON
Message-Id: <20230601073454.1896-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2023 07:34:55.0696 (UTC) FILETIME=[8FA3ED00:01D9945B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 07:35:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11717

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This option file helps to create tarball and ext4 images for the rootfs
and which can be used in reproducible build checks.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/ext4-targz-img.yml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 kas/opt/ext4-targz-img.yml

diff --git a/kas/opt/ext4-targz-img.yml b/kas/opt/ext4-targz-img.yml
new file mode 100644
index 0000000..98ceb5e
--- /dev/null
+++ b/kas/opt/ext4-targz-img.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 12
+
+# reproduicble check uses ext4 and tar ball images
+
+local_conf_header:
+  image-type: |
+    IMAGE_FSTYPES = "ext4 tar.gz"
-- 
2.20.1



