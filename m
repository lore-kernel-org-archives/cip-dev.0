Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E47C47DDF
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 13:15:46 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.16634.1706615835591534326
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 03:57:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Pp6sF3R9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1321639-20240130115713a912580a496df7102b-lix8jq@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240130115713a912580a496df7102b
        for <cip-dev@lists.cip-project.org>;
        Tue, 30 Jan 2024 12:57:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9J7z+PeGMQsgZhgGanY+EEtbsD4fFPed9o6Ro3EiNd8=;
 b=Pp6sF3R9lCm0zH5ReOHxgCVmNLHDJNcS54RCzZ5F57tLSe1yN8fE3CkYLknlWS1kV7Sp1+
 xUiiEFrRbXY7zputlvMcinF7O+OKDkgTW2KVbTTCvKv+jQlukE9CULvR5Vmm5AsmAOLBYvLE
 C+TsaUHM4OLHSSoWunornZvZQONb8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC 2/2] swupdate images: initially deploy empty var part
Date: Tue, 30 Jan 2024 12:56:48 +0100
Message-Id: <20240130115648.311177-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240130115648.311177-1-felix.moessbauer@siemens.com>
References: <20240130115648.311177-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 13:15:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14498

Previously to this patch, the /var partition is only populated on the
initial image deployment. Further updates via swupdate do not update the
data on the partition. This is problematic, as issues w.r.t. missing
directories or packages that do not support this scheme are only
detected in the field or during update testing.

To avoid these late failures, we now always deploy an empty /var
partition. By that, potential issues can be spotted without the need to
run an update.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 wic/bbb-efibootguard.wks.in                   | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in          | 2 +-
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 2 +-
 wic/qemu-arm64-efibootguard.wks.in            | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in          | 2 +-
 wic/x86-efibootguard.wks.in                   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index 6c62846..e9c04b9 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -16,6 +16,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index a9742cc..9227a71 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 # home and var are extra partitions
 
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index f6d3243..ef40d70 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 9baaa47..01f395d 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index e96853e..942c3e1 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 24e9acd..6934977 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index 60897be..6382ff7 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 # home and var are extra partitions
 
 part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.39.2


