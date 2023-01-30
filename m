Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941DC61DA4
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 15:02:18 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.43226.1675090929210528076
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 07:02:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=oz47+E09;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2023013015020777cfa7159d3b645df2-du6tgd@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023013015020777cfa7159d3b645df2
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jan 2023 16:02:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ON/7djrmdLIMcy0vZwiLadMEN4Sl+GY7vlt+X7VBjS0=;
 b=oz47+E09eJ+YxsuOdvSdeFF40Z8gM7R2zrFgOxESNDfHIdGqGxFGSUX1yg0htArF2hZXKj
 RMdinJBkg/uexsI7SViEqsK8lbLYgCwERj3krKfomoB0KdAxFzRXeptqnUosm1Vz1EcT4lyC
 znkDLAWNpMGo07HDBV4Zu8VFrBYOE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 3/5] wic/x86-efibootguard: add partition to encrypted
Date: Mon, 30 Jan 2023 16:02:02 +0100
Message-Id: <20230130150204.697758-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 15:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10513

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This extra partition will store the encrypted file system

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 1 +
 wic/x86-efibootguard.wks.in                   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 5c41116..44f9c77 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -6,5 +6,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
 part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
+part /crypt --label crypt-data --align 1024 --fstype=ext4 --size 2G
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk panic=5"
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index b635a8b..bad6ff5 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -9,5 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
 part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
+part /crypt --label crypt-data --align 1024 --fstype=ext4 --size 2G
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
-- 
2.39.0


