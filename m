Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0FCCEBF97
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 17:15:24 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14788.1763399721800263599
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 09:15:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=gD3tnZcr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2025111717151897d46ba033000207df-yzeduk@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025111717151897d46ba033000207df
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Nov 2025 18:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9j45WNmSzQyjmSGfZE5a54b/iF3y0zHVkiCQweOA/NE=;
 b=gD3tnZcrKW1vqYCPjU5nEEX2T2RflUmeAizyeQ0ZnTNmwcM4svC3CnP8yjI74H0FwZa4FC
 aGLMefFydGdA4yxUDkLFwm9dlm5QR6E6hEII9YoimyeL1oJs6eJGnnPfbF0VYXJ6fafoLCj7
 rWimvvYD2Kt5TNd/oilWbVOep3xo5+uVC6GxIplJ947cLtlFUG7HngBGnFxJIXNi1lgRagEc
 HFkAm1oA8QUzLGDkT/kFEscSFynkpR70q2kKeYUWqq48sH89VW1VNPfnJNHIvmvzdh/0ovBL
 7HjMPT/d5KOarpyvHQxo1L6vb/1pgqg/lG87YsBeDIQjphXDTPO6euVA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [isar-cip-core][PATCH 6/6] ti-am62px-sk: Switch wks files to gpt-hybrid
Date: Mon, 17 Nov 2025 18:15:17 +0100
Message-ID: <26364d9ae51ed0f8039cc96bca1497ae7fcb749c.1763399717.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763399717.git.jan.kiszka@siemens.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 17:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20599

From: Jan Kiszka <jan.kiszka@siemens.com>

Isar will deprecate the boot-hybrid plugin because native wic supports
this now as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in | 4 ++--
 wic/ti-am62px-sk-efibootguard.wks.in            | 4 ++--
 wic/ti-am62px-sk.wks                            | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
index 52fcb091..fb21cd05 100644
--- a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -8,7 +8,7 @@
 #
 
 # Boot partition containing Bootloader binaries
-part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE --mbr
 
 include ebg-signed-sysparts.inc
 
@@ -20,4 +20,4 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
 ${WIC_HOME_PARTITION}
 
-bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
+bootloader --ptable gpt-hybrid --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efibootguard.wks.in
index 100f303b..b6976ee8 100644
--- a/wic/ti-am62px-sk-efibootguard.wks.in
+++ b/wic/ti-am62px-sk-efibootguard.wks.in
@@ -8,7 +8,7 @@
 #
 
 # Boot partition containing Bootloader binaries
-part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE --mbr
 
 include ebg-sysparts.inc
 
@@ -20,4 +20,4 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9 --exclude-path boot/
 ${WIC_HOME_PARTITION}
 
-bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
+bootloader --ptable gpt-hybrid --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
index 40214a8f..0d5f114c 100644
--- a/wic/ti-am62px-sk.wks
+++ b/wic/ti-am62px-sk.wks
@@ -7,9 +7,9 @@
 # SPDX-License-Identifier: MIT
 #
 
-part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE --mbr
 part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
 
 part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
 
-bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw"
+bootloader --ptable gpt-hybrid --timeout=0 --append "rootwait rw"
-- 
2.51.0


