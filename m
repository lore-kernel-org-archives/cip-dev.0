Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114AC433EF
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 09:31:02 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.73646.1638264660986577315
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 01:31:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AU9UwIA015139
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 10:30:58 +0100
Received: from md2dvrtc.fritz.box ([167.87.34.248])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AU9UuEp020034;
	Tue, 30 Nov 2021 10:30:58 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 8/9] kas: Patch isar for correct
 permissions in var and home
Date: Tue, 30 Nov 2021 10:30:55 +0100
Message-Id: <20211130093056.324717-9-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130093056.324717-1-Quirin.Gylstorff@siemens.com>
References: <20211130093056.324717-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 09:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7037

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Get patch from isar mailing list[1].

[1]: https://groups.google.com/g/isar-users/c/wlanc7f7UnQ

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml                                   |  4 +++
 ...when-splitting-rootfs-folders-across.patch | 35 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch

diff --git a/kas-cip.yml b/kas-cip.yml
index dc56729..8226954 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -25,6 +25,10 @@ repos:
     refspec: ceb7e21154fc4862f704bb5c7739e87a26db6eb3
     layers:
       meta:
+    patches:
+      fix-pseudo:
+        repo: cip-core
+        path: patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch b/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
new file mode 100644
index 0000000..34704f0
--- /dev/null
+++ b/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
@@ -0,0 +1,35 @@
+From 34b37fccd5e454d29d6d4d002d48a9619782b1bb Mon Sep 17 00:00:00 2001
+From: Felix Moessbauer <felix.moessbauer@siemens.com>
+Date: Wed, 3 Nov 2021 13:53:00 +0100
+Subject: [PATCH] Fix permissions when splitting rootfs folders across
+ partitions.
+
+This patches ensures that the file database containing the file and
+folder usernames and permissions is always located relative to the
+source and not to the appended rootfs-dir.
+
+Prior to this patch, the database was not found when using
+-rootfs-dir in the WIC script, leading to erronous file
+permissions and ownership.
+
+Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
+---
+ scripts/lib/wic/plugins/source/rootfs.py | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/scripts/lib/wic/plugins/source/rootfs.py b/scripts/lib/wic/plugins/source/rootfs.py
+index 96d940a9..5ab771e5 100644
+--- a/scripts/lib/wic/plugins/source/rootfs.py
++++ b/scripts/lib/wic/plugins/source/rootfs.py
+@@ -95,7 +95,7 @@ class RootfsPlugin(SourcePlugin):
+ 
+         part.rootfs_dir = cls.__get_rootfs_dir(rootfs_dir)
+         part.has_fstab = os.path.exists(os.path.join(part.rootfs_dir, "etc/fstab"))
+-        pseudo_dir = os.path.join(part.rootfs_dir, "../pseudo")
++        pseudo_dir = os.path.join(krootfs_dir['ROOTFS_DIR'], "../pseudo")
+         if not os.path.lexists(pseudo_dir):
+             logger.warn("%s folder does not exist. "
+                         "Usernames and permissions will be invalid " % pseudo_dir)
+-- 
+2.30.2
+
-- 
2.30.2


