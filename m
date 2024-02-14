Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4189CC48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 14:06:52 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.41656.1707917964385933321
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 05:39:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=a+Z4J3Nx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1321639-2024021413392184bd13f4e08c1a8c2e-2wx9qh@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024021413392184bd13f4e08c1a8c2e
        for <cip-dev@lists.cip-project.org>;
        Wed, 14 Feb 2024 14:39:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=84XdZ9RGOoJdhR1DHCNJVw0OpuEApjj2oHlbMoH4wmA=;
 b=a+Z4J3NxXrq5awxc1s8HqrY3s6HBg3PyaE9HSj311V3THC2NekDd9Zoou6faIuxQeyPB77
 T8nhcBZxKXXb0muluCYWMF+sI7UHhVb95NQ7d0Ss4+3SjsQkDLTmeJ5jdIyEiLDPVYIH2A72
 0IPP98FrMPu0IMpWwREOSIg8BJK7A=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC v2 1/2] swupdate images: initially deploy empty var part
Date: Wed, 14 Feb 2024 14:39:06 +0100
Message-Id: <20240214133907.999657-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240214133907.999657-1-felix.moessbauer@siemens.com>
References: <20240214133907.999657-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 14:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14970

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
 wic/bbb-efibootguard.wks.in                   | 4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
 wic/x86-efibootguard.wks.in                   | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index b4a3ec4..e9c04b9 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index 4e43178..9227a71 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index a5d94dd..ef40d70 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
-part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 291b97c..01f395d 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
-part /var  --source rootfs --change-directory=var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 2f9d4f4..942c3e1 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 83b1d6e..6934977 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
 
 # home and var are extra partitions
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index f33bb7e..6382ff7 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # home and var are extra partitions
 
-part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
-part /var --source rootfs --change-directory=var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
+part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.39.2


