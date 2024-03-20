Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A963ECD11DD
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 10:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.40305.1710930715197145078
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 03:31:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 42KAVrUf1398294; Wed, 20 Mar 2024 19:31:54 +0900
X-Iguazu-Qid: 2yAacku13V7Qm92dvM
X-Iguazu-QSIG: v=2; s=0; t=1710930713; q=2yAacku13V7Qm92dvM; m=nATAD/1hZWC1FXMK72CfM/FKHfmBGHdB1pfWcErzUO8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 42KAVrhp744680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Mar 2024 19:31:53 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v2 4/4] doc/README.swupdate.md: Update steps to test Delta software Update
Date: Wed, 20 Mar 2024 16:02:29 +0530
X-TSB-HOP2: ON
Message-Id: <20240320103229.1078738-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2024 10:31:46.0818 (UTC) FILETIME=[CF656620:01DA7AB1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 10:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15382

This change includes steps to verify Delta Software Update with
rdiff_image and delta handler

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b7e13f7..3862649 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -360,6 +360,65 @@ user variables:
 
 ```
 
+# Building and testing the CIP Core image for Delta Software Update
+
+Set up `kas-container` as described in the [top-level README](../README.md), and then proceed with the following steps.
+
+First build an image using the following command:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
+```
+
+## Delta Software Update using rdiff_image handler
+
+Creating an delta update file for rdiff_image handler requires a reference image (against which the delta is computed). In this case, the image built in the previous section can be used as the reference image artifact. By default the `DELTA_UPDATE_TYPE` is set to `rdiff` and `DELTA_RDIFF_REF_IMAGE` is set to the path `image-v1/<artifact-name>.squashfs` (or <artifact-name>.verity in the case of Secure boot enabled image).
+Copy the reference artifact to the mentioned directory in project folder.
+
+Custom artifact path can be set in `DELTA_RDIFF_REF_IMAGE` manually by adding the variable in the `swupdate.yml` file.
+
+Build the image with the modification as shown above with the following command:
+```
+KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+```
+Now start the first image (which does not contain the packages vim and nano), run the following commands:
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
+## Delta Software Update using delta handler
+
+Currently zchunk based delta updates are supported only in Sid images.
+For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` im `swupdate.yml` file.
+
+Build the image with the modification as shown above with the following command:
+```
+KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+```
+Now start the first image (which does not contain the packages vim and nano), run the following commands:
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
+
+
 # Building and testing the CIP Core image for BBB
 
 Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
-- 
2.39.2



