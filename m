Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEB4C4321E
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 17:48:47 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web12.1032.1650383363731792039
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Apr 2022 08:49:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=EbPVjyy/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-51332-2022041915492023db702371e0df5de0-2sjazf@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2022041915492023db702371e0df5de0
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Apr 2022 17:49:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=kPSym9GcIBQkLIS3tRNfATZ4ao/RddnKX11qB36hj3I=;
 b=EbPVjyy/37x2X7ryW4mwRrAfbk0Cky/hhbt30ZEf/UcuVC2MMNPFOZ73CCxxmpTFl8C5ru
 L/RJFNbH0zSD9MANEaJph12he4f5uy6AeUBseXYyZi21NMIaLmREaGF5CwP42zmOPCWq660i
 WyKAPXJ5/HNfVXcXbTL28c+rQUl58=;
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] Bullseye: Fix journalctl on read-only
Date: Tue, 19 Apr 2022 17:49:18 +0200
Message-Id: <20220419154918.223283-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Apr 2022 17:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8105

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If an image with a read-only partition and etc overlay
is build journalctl does not display the system log in
Debian Bullseye.

The log is available with the command `journalctl --merged'.

The root cause is overwriting the  mount point for /etc/machine-id
by the etc-overlay. This leads to the usage of multiple machine-ids
and journalctl does not match the current used journal file to
the machine.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml                                   |  4 ++
 ...stproc-extension-Remove-etc-machine-.patch | 37 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch

diff --git a/kas-cip.yml b/kas-cip.yml
index fce176b..2c2b7d7 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -29,6 +29,10 @@ repos:
       fix-pseudo:
         repo: cip-core
         path: patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
+      fix-machine-id:
+        repo: cip-core
+        path: patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch
+
 
 bblayers_conf_header:
   standard: |
diff --git a/patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch b/patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch
new file mode 100644
index 0000000..95b49ae
--- /dev/null
+++ b/patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch
@@ -0,0 +1,37 @@
+From 6e72a422c52f9995f5ee3acca293b92a7c0194d9 Mon Sep 17 00:00:00 2001
+From: kas <kas@example.com>
+Date: Tue, 19 Apr 2022 14:52:54 +0000
+Subject: [PATCH] classes/image-postproc-extension: Remove /etc/machine-id
+
+In a read-only system the machine id should be deleted or 
+set to `unitialized\n`[1]. 
+
+Systemd will generate a new machine-id during the first boot. 
+In the case of a read-only root file system Systemd generates a mount point with 
+the machine id. If an overlay for /etc is used this creates a mount conflict. 
+To avoid the conflict between the overlay filesystem and systemd /etc/machine-id 
+mount point deleted the file /etc/machine-id.
+
+[1]: https://systemd.io/BUILDING_IMAGES/
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ meta/classes/image-postproc-extension.bbclass | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/meta/classes/image-postproc-extension.bbclass b/meta/classes/image-postproc-extension.bbclass
+index ca520273..0c412c0d 100644
+--- a/meta/classes/image-postproc-extension.bbclass
++++ b/meta/classes/image-postproc-extension.bbclass
+@@ -57,7 +57,7 @@ ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_machine_id"
+ image_postprocess_machine_id() {
+     # systemd(1) takes care of recreating the machine-id on first boot
+     sudo rm -f '${IMAGE_ROOTFS}/var/lib/dbus/machine-id'
+-    sudo install -m 644 '/dev/null' '${IMAGE_ROOTFS}/etc/machine-id'
++    sudo rm -f '${IMAGE_ROOTFS}/etc/machine-id'
+ }
+ 
+ ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_sshd_key_regen"
+-- 
+2.35.1
+
-- 
2.35.1


