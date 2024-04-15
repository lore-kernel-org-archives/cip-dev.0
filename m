Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30996C04FFE
	for <webhook@archiver.kernel.org>; Mon, 15 Apr 2024 10:45:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.17938.1713177935186818887
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Apr 2024 03:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 43FAjXcx3293501; Mon, 15 Apr 2024 19:45:33 +0900
X-Iguazu-Qid: 2yAamVQ9TxupoPiotw
X-Iguazu-QSIG: v=2; s=0; t=1713177932; q=2yAamVQ9TxupoPiotw; m=GQQX31/JmlDQ9pzvUnhmDM1WhN2uNFwEetkD1g2Tgv0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 43FAjWFO2474511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Apr 2024 19:45:32 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v3 3/3] doc/README.swupdate.md: Update steps to test Delta software Update
Date: Mon, 15 Apr 2024 16:16:10 +0530
X-TSB-HOP2: ON
Message-Id: <20240415104610.3073497-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415104610.3073497-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240415104610.3073497-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Apr 2024 10:45:29.0016 (UTC) FILETIME=[08345B80:01DA8F22]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Apr 2024 10:45:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15560

This change includes steps to verify Delta Software Update with
rdiff_image and delta handler

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b7e13f7..c3bd3b4 100644
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
+The above image will be used as the base image to which the update is applied.
+
+## Delta Software Update using rdiff_image handler
+
+Creating an delta update file for rdiff_image handler requires a reference artifact (against which the delta is computed). In this case, the image built in the previous section can be used as the reference artifact. By default the `DELTA_UPDATE_TYPE` is set to `rdiff` and `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULLNAME}.squashfs` (or ${IMAGE_FULLNAME}.verity in the case of Secure boot enabled image). The values of `DELTA_UPDATE_TYPE` and `DELTA_RDIFF_REF_IMAGE` can be changed in the `swupdate.yml` file.
+
+The build system looks for the reference artifact in a directory named `previous-image` in the build directory used for the build process.
+
+Copy the reference artifact to the mentioned directory with the following commands:
+```
+mkdir -p build-v2/previous-image
+cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bookworm-qemu-amd64.squashfs build-v2/previous-image
+```
+Build the second image with `build-v2` as the build directory with the following command:
+```
+KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+```
+Now start the first image. Run the following commands:
+```
+host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+Copy `cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+```
+host$ cd build-v2/tmp/deploy/images/qemu-amd64/
+host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu root@localhost:
+```
+
+## Delta Software Update using delta handler
+
+Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution (use `sid.yml` file as part of the build command).
+For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` in `swupdate.yml` file.
+
+Build the second image with the modification as shown above with the following command:
+```
+KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/sid.yml
+```
+Now start the first image. Run the following commands:
+```
+host$ DISTRO_RELEASE=sid SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+Copy `cip-core-image-cip-core-sid-qemu-amd64-delta.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+```
+host$ cd build-v2/tmp/deploy/images/qemu-amd64/
+host$ scp -P 22222 ./cip-core-image-cip-core-sid-qemu-amd64-delta.swu root@localhost:
+```
+The `cip-core-image-cip-core-sid-qemu-amd64.zck` file must be hosted in a http server.
+
+### Delta Software Update Verification
+
+Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
+
 # Building and testing the CIP Core image for BBB
 
 Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
-- 
2.39.2



