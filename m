Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61647C48BF6
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 07:46:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.18100.1709797557826109324
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 23:45:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4277ju2a829478; Thu, 7 Mar 2024 16:45:56 +0900
X-Iguazu-Qid: 2rWgQ8FBVOzxzEuOOG
X-Iguazu-QSIG: v=2; s=0; t=1709797556; q=2rWgQ8FBVOzxzEuOOG; m=YjPJFeuQBsRfmA/oU26LR3ZMAawmO0Uqnvw+1nhDWHk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 4277jsYU1092844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Mar 2024 16:45:55 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v1 6/6] doc/README.swupdate.md: Update steps to test Delta software Update
Date: Thu,  7 Mar 2024 13:16:12 +0530
X-TSB-HOP2: ON
Message-Id: <20240307074612.1996609-7-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 07:45:48.0884 (UTC) FILETIME=[78A28140:01DA7063]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 07:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15258

This change includes steps to verify Delta Software Update with
rdiff_image and delta handler

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index cf1bcfb..4003243 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -324,6 +324,101 @@ user variables:
 
 
 ```
+# Building and testing the CIP Core image for Delta Software Update
+
+Set up `kas-container` as described in the [top-level README](../README.md), and then proceed with the following steps.
+
+First build an image using the following command:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
+```
+Currently, Delta Software Update is supported only for root file system.
+Now, to verify a delta update, build an image with some modifications to the root file system (ex: Add additional packages).
+For this example, add the packages vim and nano (since the packages are not already included in the base image) to the image. This can be done by modifying the `recipes-core/images/cip-core-image.bb` file as shown below.
+```
+diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
+index 0ec7220..f61ce23 100644
+--- a/recipes-core/images/cip-core-image.bb
++++ b/recipes-core/images/cip-core-image.bb
+@@ -14,6 +14,7 @@ inherit image
+ ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
+ DESCRIPTION = "CIP Core image"
+
++IMAGE_PREINSTALL += "vim nano"
+ IMAGE_INSTALL += "customizations"
+
+ CIP_IMAGE_OPTIONS ?= ""
+```
+## Delta Software Update using rdiff_image handler
+
+Creating a delta update file for rdiff_image handler requires a reference image (against which the delta is computed). In this case, the image built in the previous section can be used as the reference image.
+Copy the reference image to the project directory. And set the variable `DELTA_RDIFF_REF_IMAGE` with the path to the reference image and set the variable `DELTA_UPDATE_TYPE` to `rdiff`.
+
+```
+header:
+  version: 14
+
+local_conf_header:
+  delta-update: |
+    IMAGE_CLASSES:append = " delta_update"
+    DELTA_UPDATE_TYPE = "rdiff"
+    DELTA_ZCK_URL = ""
+    DELTA_RDIFF_REF_IMAGE = "path/to/image/from/project/root/directory.wic"
+
+```
+Run the below command to build the image with the modification as shown above and with the root file system modification as described in previous section.
+```
+KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
+```
+Run the below command to start first image
+```
+host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+Copy `cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu` file from `image2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+```
+host$ cd image2/tmp/deploy/images/qemu-amd64/
+host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu root@localhost:
+```
+
+### Delta Software Update Verification
+
+Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
+
+Since our target was to update the root file system by adding a few packages (vim and nano in this example), Check if the packages are available after the update by running either the `vim` command or `nano` command.
+
+## Delta Software Update using delta handler
+
+For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the variable `DELTA_UPDATE_TYPE` to `zchunk`.
+```
+header:
+  version: 14
+
+local_conf_header:
+  delta-update: |
+    IMAGE_CLASSES:append = " delta_update"
+    DELTA_UPDATE_TYPE = "zchunk"
+    DELTA_ZCK_URL = "<zck file url>"
+    DELTA_RDIFF_REF_IMAGE = ""
+
+```
+Run the below command to build the image with the modification as shown above and with the root file system modification as described in previous section.
+```
+KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
+```
+Run the below command to start first image
+```
+host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+Copy `cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu` file from `image2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+```
+host$ cd image2/tmp/deploy/images/qemu-amd64/
+host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu root@localhost:
+```
+The `cip-core-image-cip-core-bookworm-qemu-amd64.zck` file must be hosted in a server.
+
+### Delta Software Update Verification
+
+Follow the steps mentioned in the section [Delta Software Update Verification](#delta-software-update-verification) for verification.
 
 # Building and testing the CIP Core image for BBB
 
-- 
2.39.2



