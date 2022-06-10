Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356CACCA47D
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 11:33:09 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.25995.1654860786978184907
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jun 2022 04:33:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=jej0bfl7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-2022061011330474d8026303a85fb8f4-ad7ef2@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2022061011330474d8026303a85fb8f4
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jun 2022 13:33:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tEB7ylnPxTwor2lItmmOMbu/GUiLt9s/nlo9wrVHjSs=;
 b=jej0bfl78Yqx1Ih5u7pzvEdUzFOQpXokaLWy7aJWAuBRxOxorxDQDRXb/vcl1DeJ8v+3gX
 gfxePp9QZFVQAkwZKNftI4/g7xA6NrTvtQm/3ej3IHLfoHU4XJy2bZAHAh/CDuSie2dt1JXD
 uhC4z8sIkLzzfHxn3fJH0y1va9nPM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v3 3/5] start-qemu.sh: adapt to new
 image names
Date: Fri, 10 Jun 2022 13:33:00 +0200
Message-Id: <20220610113302.1225351-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220610113302.1225351-1-Quirin.Gylstorff@siemens.com>
References: <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
 <20220610113302.1225351-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 11:33:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8531

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 80c0cd7..f066209 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -134,13 +134,13 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 					-global isa-fdc.driveA= \
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 					-drive if=pflash,format=raw,file=${ovmf_vars} \
-					-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 					${QEMU_COMMON_OPTIONS} "$@"
 			else
 				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
 
 				${QEMU_PATH}${QEMU} \
-					-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 					${QEMU_COMMON_OPTIONS} "$@"
 			fi
@@ -149,7 +149,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			u_boot_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-arm64/firmware.bin}
 
 			${QEMU_PATH}${QEMU} \
-				-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 				-bios ${u_boot_bin} \
 				${QEMU_COMMON_OPTIONS} "$@"
 			;;
@@ -159,7 +159,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			;;
 	esac
 else
-		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
+		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4)
 
 		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinu* | tail -1)
 		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
-- 
2.35.1


