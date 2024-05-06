Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03CBC25B4F
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 15:41:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.24123.1715010074953585717
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 08:41:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 446FfDGV578892; Tue, 7 May 2024 00:41:13 +0900
X-Iguazu-Qid: 2yAbLYkr5Wfu7LfRaq
X-Iguazu-QSIG: v=2; s=0; t=1715010072; q=2yAbLYkr5Wfu7LfRaq; m=+fA8MawfQKmB1gpzbnP5vAqqB9QnNRnSa5ZNUtATQj0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 446FfCAQ3040993
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 00:41:12 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v5 3/4] doc/README.swupdate.md: Update steps to test Delta software Update
Date: Mon,  6 May 2024 21:11:28 +0530
X-TSB-HOP2: ON
Message-Id: <20240506154130.840349-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506154130.840349-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240506154130.840349-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 May 2024 15:41:07.0847 (UTC) FILETIME=[D00BE970:01DA9FCB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 15:41:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15843

This change includes steps to verify Delta Software Update with
rdiff_image and delta handler

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b7e13f7..4c97ad7 100644
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
+Creating an delta update file for rdiff_image handler requires a reference artifact (against which the delta is computed). In this case, the image built in the previous section can be used as the reference artifact. By default the `DELTA_UPDATE_TYPE` is set to `rdiff` and `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULLNAME}.squashfs` (or ${IMAGE_FULLNAME}.verity in the case of Secure boot enabled image). The values of `DELTA_UPDATE_TYPE` and `DELTA_RDIFF_REF_IMAGE` can be changed in the `delta-update.yml` file.
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
+KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
+```
+Now start the first image. Run the following commands:
+```
+host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+Copy `cip-core-image-cip-core-bookworm-qemu-amd64.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+```
+host$ cd build-v2/tmp/deploy/images/qemu-amd64/
+host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64.swu root@localhost:
+```
+
+## Delta Software Update using zchunk handler
+
+Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution (use `sid.yml` file as part of the build command).
+For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` in `delta-update.yml` file.
+
+Build the second image with the modification as shown above with the following command:
+```
+KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/sid.yml:kas/opt/delta-update.yml
+```
+Now start the first image. Run the following commands:
+```
+host$ DISTRO_RELEASE=sid SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+Copy `cip-core-image-cip-core-sid-qemu-amd64.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+```
+host$ cd build-v2/tmp/deploy/images/qemu-amd64/
+host$ scp -P 22222 ./cip-core-image-cip-core-sid-qemu-amd64.swu root@localhost:
+```
+The `cip-core-image-cip-core-sid-qemu-amd64.zck` file must be hosted in a http server.
+
+## Delta Software Update Verification
+
+Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
+
 # Building and testing the CIP Core image for BBB
 
 Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
-- 
2.39.2



