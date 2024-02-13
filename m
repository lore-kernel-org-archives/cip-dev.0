Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC1C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 12:51:04 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.7092.1707813077960981603
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Feb 2024 00:31:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=ItoVct9I;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1321639-20240213083109bcd0fcc730302e8d3f-n06rsr@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240213083109bcd0fcc730302e8d3f
        for <cip-dev@lists.cip-project.org>;
        Tue, 13 Feb 2024 09:31:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=m/kIckuw+6XrI90Xf/ccYd0TuTcU5BoIf7EsldIhfi8=;
 b=ItoVct9I3uvN16vFCAYfSQCGskPjN/6nKO2a0Qg7dtd2cc6zKh1913I+FTNE7qQq3CMSGH
 eqJNNUEOXtqJlJSlvdySTErJeakqjxUIkUZAZrXrJDAhs25PFmTxJWZfysFD6lxZQTrGuwxQ
 H1HIYeBpltU5zVO4alDtdxKXqry9Q=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstroff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] refactor: use change-dir to split rootfs parts
Date: Tue, 13 Feb 2024 09:30:58 +0100
Message-Id: <20240213083058.424760-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 12:51:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14937

This patch refactors the WKS script w.r.t how the rootfs is distributed
across multiple partitions. Previously we used rootfs-dir with a full
rootfs paths plus the sub directory. However, this is not ideal, as the
relation to the rootfs folder is lost and also the new rootfs dir is
technically not a rootfs. While this aparently did not create any issues
in CIP, we still believe it is semantically incorrect.

This patch switches that over to the WIC option --change-directory that
is provided exactly for this use-case and only deploys a subdirectory
without loosing the rootfs relation with the permissions pseudo dir.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---

Changes since v1:
- rebased onto next

 wic/bbb-efibootguard.wks.in                   | 4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
 wic/x86-efibootguard.wks.in                   | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index b9c8f3f..b4a3ec4 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
+part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
 
 bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index aa704f5..4e43178 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
+part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
 
 bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index b16da0b..a5d94dd 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
-part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
+part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 22e23b4..291b97c 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
-part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
+part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 7fe68d9..2f9d4f4 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
+part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
 
 bootloader --ptable gpt
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 19ca1e0..83b1d6e 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
+part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
 
 bootloader --ptable gpt
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index 43bb782..f33bb7e 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
+part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.39.2


