Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E3ECCA482
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 10:08:20 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web08.10866.1654596491767718293
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=AXlp+IvU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-202206071008086061b83f8a5e86e088-ij6rja@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202206071008086061b83f8a5e86e088
        for <cip-dev@lists.cip-project.org>;
        Tue, 07 Jun 2022 12:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tEB7ylnPxTwor2lItmmOMbu/GUiLt9s/nlo9wrVHjSs=;
 b=AXlp+IvUxar+XNsloGIcAlp6z4fTkU6oQNJQ3sZWGriu4JSFRt4Jp4N08BsprWyr7ysLe2
 uQk8ENEqqakpooQ6QvgOFBOVlhZfpVaqEksnLVxf9tuiRtkuG95hKLlfOBKONb5XGen061HD
 PnThore9f2yWscdmsNnh8m0mInxO0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 2/4] start-qemu.sh: adapt to new
 image names
Date: Tue,  7 Jun 2022 12:08:04 +0200
Message-Id: <20220607100806.133889-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 10:08:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8503

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


