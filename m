Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09589C3DA49
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 10:07:01 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.40839.1721729211884805854
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jul 2024 03:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=EIfrK+Ku;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1324425-2024072310064828fbdff4a10b4fca01-iglnqa@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024072310064828fbdff4a10b4fca01
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Jul 2024 12:06:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BGyQaHuguU/HJmaiI1Zv1oU0iYTH+odFabbUGTVt27A=;
 b=EIfrK+KuaFWX0dgC8c8SbQjZ/qr8feATbN25/JmaG2rxLHQyOgXvyR5g36rZAXZOJJP2JD
 U0MzYEQDd7HfHWLi5K3asIfxHlkiSFjpDEPJSBBr5qxmr9PkK6hXMd15UnpFZoXERysbPyIO
 8HQaYZeObdGna0Y5s/JId//43fuvk=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core] [PATCH v2] classes/squashfs.bbclass: exclude boot dir for efibootguard bootloader
Date: Tue, 23 Jul 2024 15:36:31 +0530
Message-Id: <20240723100631.75683-1-srinuvasan.a@siemens.com>
In-Reply-To: <284ef2098da5aaeff02a565c4316fff854add437.camel@siemens.com>
References: <284ef2098da5aaeff02a565c4316fff854add437.camel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jul 2024 10:07:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16596

From: srinuvasan <srinuvasan.a@siemens.com>

efibootguard based bootloader boot the system using linux.efi (UKI) and it has
the necessary boot files to boot the system, hence we added boot dir as the exclude dir
in squashfs root file system to remove the contents from the boot dir.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 classes/squashfs.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index b39be0c..2582ce2 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -23,6 +23,7 @@ def get_free_mem():
 IMAGER_INSTALL:squashfs += "squashfs-tools"
 
 SQUASHFS_EXCLUDE_DIRS ?= ""
+SQUASHFS_EXCLUDE_DIRS_EFI ?= "boot"
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
 SQUASHFS_CREATION_ARGS ?= ""
 
@@ -31,6 +32,8 @@ SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
 SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
 
 python __anonymous() {
+    if (d.getVar('SWUPDATE_BOOTLOADER') == 'efibootguard'):
+        d.setVar('SQUASHFS_EXCLUDE_DIRS', '${SQUASHFS_EXCLUDE_DIRS_EFI}')
     exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
         return
-- 
2.39.2


