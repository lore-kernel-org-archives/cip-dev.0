Return-Path: <SRS0=Hk8p=HD=lists.cip-project.org=bounce+64572+6157+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39ECC433DB
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:24:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8477D64DAF
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8477D64DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6157+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mzDlYY4521723xaUbKPV8u8l; Mon, 01 Feb 2021 08:24:30 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.36592.1612196668078232741
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Feb 2021 08:24:29 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 111GOQSe032305
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 1 Feb 2021 17:24:26 +0100
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.15.10])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 111GOPdk017026;
	Mon, 1 Feb 2021 17:24:26 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/2] secure-boot: Move image-uuid to own file
Date: Mon,  1 Feb 2021 17:24:25 +0100
Message-Id: <20210201162425.31726-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210201162425.31726-1-Quirin.Gylstorff@siemens.com>
References: <20210201162425.31726-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PrVohYzUnBKLimg7KwSxDITUx4520388AA=
Content-Type: multipart/mixed; boundary="YKkxZ33ORslvCElgNWRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612196670;
 bh=fdGYIUy52cLxIGM0fTdlxIUMO8LBhOfM1bRx4txzFmA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Rfbnxj4U/8w10izen7Hxcm3WDx30XXEdvw4a7b5Wory43n0E676uaz6WjhAzIjn+/xm
 y2tzzTcDJ5nqB/t6g3p06xLenLgVK8fgOfEsBfePo2FhO9w3x7i6cOaQkEECPtsgtplGL
 7FSkK/mp8Z+xJhcA1jMQiMlkYWPZxT6KKSg=

--YKkxZ33ORslvCElgNWRr
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

/etc/os-release is controlled by the Debian Package base-files
and will be silently overwritten if the package updates the file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/image_uuid.bbclass                                  | 4 +---
 .../initramfs-config/files/initramfs.image_uuid.hook        | 6 +++---
 .../initramfs-config/files/secure-boot-debian-local-patch   | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 2813ed9..a0ab202 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -22,9 +22,7 @@ IMAGE_UUID ?= "${@generate_image_uuid(d)}"
 do_generate_image_uuid[vardeps] += "IMAGE_UUID"
 do_generate_image_uuid[depends] = "buildchroot-target:do_build"
 do_generate_image_uuid() {
-    sudo sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
-    echo "IMAGE_UUID=\"${IMAGE_UUID}\"" | \
-        sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
+    sudo sh -c 'echo "IMAGE_UUID=\"${IMAGE_UUID}\"" > "${IMAGE_ROOTFS}/etc/secureboot-image-uuid"'
     image_do_mounts
 
     # update initramfs to add uuid
diff --git a/recipes-support/initramfs-config/files/initramfs.image_uuid.hook b/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
index 910ce84..bf39abb 100644
--- a/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
+++ b/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
@@ -22,12 +22,12 @@ esac
 . /usr/share/initramfs-tools/scripts/functions
 . /usr/share/initramfs-tools/hook-functions
 
-if [ ! -e /etc/os-release ]; then
-	echo "Warning: couldn't find /etc/os-release!"
+if [ ! -e /etc/secureboot-image-uuid ]; then
+	echo "Warning: couldn't find /etc/secureboot-image-uuid!"
 	exit 0
 fi
 
-IMAGE_UUID=$(sed -n 's/^IMAGE_UUID="\(.*\)"/\1/p' /etc/os-release)
+IMAGE_UUID=$(sed -n 's/^IMAGE_UUID="\(.*\)"/\1/p' /etc/secureboot-image-uuid)
 echo "${IMAGE_UUID}" > "${DESTDIR}/conf/image_uuid"
 
 exit 0
\ No newline at end of file
diff --git a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
index cd2d271..82d325a 100644
--- a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
+++ b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
@@ -58,8 +58,8 @@
 +			# Mount root
 +			# shellcheck disable=SC2086
 +			if mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
-+				if [ -e "${rootmnt?}"/etc/os-release ]; then
-+				image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/os-release | tr -d '"' )
++				if [ -e "${rootmnt?}"/etc/secureboot-image-uuid ]; then
++				image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/secureboot-image-uuid | tr -d '"' )
 +					if [ "${INITRAMFS_IMAGE_UUID}" = "${image_uuid}" ]; then
 +						return 0
 +					fi
-- 
2.20.1


--YKkxZ33ORslvCElgNWRr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6157): https://lists.cip-project.org/g/cip-dev/message=
/6157
Mute This Topic: https://lists.cip-project.org/mt/80289768/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YKkxZ33ORslvCElgNWRr--
