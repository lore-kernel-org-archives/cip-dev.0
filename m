Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BDC3527C
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 17:48:47 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.1359.1650384422681603508
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Apr 2022 09:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=JbdbyHOM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-202204191606594a4761e40c4cd589eb-exsw5j@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202204191606594a4761e40c4cd589eb
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Apr 2022 18:06:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yqBq9e6JOX38D37d2PaWqVpW+iF6pD87DmcgfoLvJjI=;
 b=JbdbyHOM4fjzMnHJl7NEwvz2AAZaHfpd5MVhuVGRPVsbhiLAwvIP/FoaYDpPfVYNRfUs00
 5VO+nFTjW6bFPWpDJUqH/RqwiqvdY38M+iF7D8UNVawF+taIrhAhPmfG8arzwDlMb0kOiGX0
 mSyvAG0/a82vjIkn6ATHXrkOi/BoE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 1/5] squashfs-img: Cosmetic cleanups
Date: Tue, 19 Apr 2022 18:06:54 +0200
Message-Id: 
 <f8bf883a040a9b1b50eee89177b6a5b69ee88b0c.1650384418.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650384418.git.jan.kiszka@siemens.com>
References: <cover.1650384418.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Apr 2022 17:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8107

From: Jan Kiszka <jan.kiszka@siemens.com>

SQUASHFS_EXCLUDE_DIRS is given a default value in this class, so the
'or ""' is redundant. Furthermore, remove the unneeded space from the
SQUASHFS_CREATION_ARGS default assignment as well as misleading comment
in front of its anonymous constructor function.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/squashfs-img.bbclass | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/classes/squashfs-img.bbclass b/classes/squashfs-img.bbclass
index 0fcfca5..04bb67c 100644
--- a/classes/squashfs-img.bbclass
+++ b/classes/squashfs-img.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -15,14 +15,14 @@ IMAGER_INSTALL += "squashfs-tools"
 
 SQUASHFS_EXCLUDE_DIRS ?= ""
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
-SQUASHFS_CREATION_ARGS ?= " "
-# Generate squashfs filesystem image
+SQUASHFS_CREATION_ARGS ?= ""
+
 python __anonymous() {
-    exclude_directories = (d.getVar('SQUASHFS_EXCLUDE_DIRS') or "").split()
+    exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
         return
-    # use wildcard to exclude only content of the the directory
-    # this allows to use the directory as a mount point
+    # Use wildcard to exclude only content of the directory.
+    # This allows to use the directory as a mount point.
     args = " -wildcards"
     for dir in exclude_directories:
         args += " -e {dir}/* ".format(dir=dir)
-- 
2.34.1


