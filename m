Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC08CA0EE5
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 13:56:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.101460.1755093385198503130
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 06:56:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 57DDuNbb1960539; Wed, 13 Aug 2025 22:56:23 +0900
X-Iguazu-Qid: 2rWhiV7hVlpo0oQULY
X-Iguazu-QSIG: v=2; s=0; t=1755093383; q=2rWhiV7hVlpo0oQULY; m=62Fg+57/QNWZid4qK+6S05TCWJad/tTH7wybexdROO0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 57DDuMtx1699295
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 22:56:23 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 3/5] README.swupdate.md: Modify readme for kernel binary delta update support.
Date: Wed, 13 Aug 2025 19:16:28 +0530
X-TSB-HOP2: ON
Message-Id: <20250813134630.3943194-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Aug 2025 13:56:17.0801 (UTC) FILETIME=[0A8F0F90:01DC0C5A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 13:56:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19731

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 5308a50..b68b5b7 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -408,16 +408,19 @@ host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu
 ```
 The image is built with the RT kernel just so that there are some differences between the two images used. The above image will be used as the base image to which the update is applied.
 
-## Delta Software Update using rdiff_image handler
+## Delta Software Update using rdiff (rdiff_image & rdiff_file handlers)
 
-Creating an delta update file for rdiff_image handler requires a reference artifact (against which the delta is computed). In this case, the image built in the previous section can be used as the reference artifact. By default the `DELTA_UPDATE_TYPE` is set to `rdiff` and `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULLNAME}.squashfs` (or ${IMAGE_FULLNAME}.verity in the case of Secure boot enabled image). The values of `DELTA_UPDATE_TYPE` and `DELTA_RDIFF_REF_IMAGE` can be changed in the `delta-update.yml` file.
+**Note**: Only `rdiff` supports delta kernel binary update using `rdiff_file` handler.
+
+Creating an delta update file for rdiff_image (rootfs) and rdiff_file (kernel)  handlers requires a reference artifacts (against which the delta is computed). In this case, the image and kernel built in the previous section can be used as the reference artifacts. By default the `DELTA_UPDATE_TYPE` is set to `rdiff`, `DELTA_RDIFF_REF_IMAGE` is set to the name `${IMAGE_FULLNAME}.squashfs` (or ${IMAGE_FULLNAME}.verity in the case of Secure boot enabled image) and `DELTA_RDIFF_REF_KERNEL_IMAGE` is set to the name `linux.efi`. The values of `DELTA_UPDATE_TYPE`, `DELTA_RDIFF_REF_IMAGE` and `DELTA_RDIFF_REF_KERNEL_IMAGE` can be changed in the `delta-update.yml` file.
 
 The build system looks for the reference artifact in a directory named `previous-image` in the build directory used for the build process.
 
-Copy the reference artifact to the mentioned directory with the following commands:
+Copy the reference artifacts to the mentioned directory with the following commands:
 ```
 mkdir -p build-v2/previous-image
 cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bookworm-qemu-amd64.squashfs build-v2/previous-image
+cp build/tmp/deploy/images/qemu-amd64/linux.efi build-v2/previous-image
 ```
 Build the second image with `build-v2` as the build directory with the following command:
 ```
-- 
2.39.5



