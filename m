Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF21C77B75
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 11:57:29 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.47345.1684324647682189953
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 04:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=kqkRC1zP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2023051711572425b5e49d31f96558fb-rla4ey@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023051711572425b5e49d31f96558fb
        for <cip-dev@lists.cip-project.org>;
        Wed, 17 May 2023 13:57:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=SQ5MhrNuXX6nfhHsIB+oR17FHiFDvenrg4yVTrRo2B0=;
 b=kqkRC1zP6d35FXev78AV0VqqLfOzrtmB15TX5wafUDt2fGqoFItct3z2ojUvBIeREB4AqG
 IILexkDS+9piqU4+QAqaYKGZLDGPYzTz7dhLh+e/IGVWmfaJGE8G3DGIXJEwMlThdsCtSTI1
 fr9Qf4yV/ELRH0TkOWYkoq4uKUovE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-crypt-hook: Fix Error Messages in case of missing binaries
Date: Wed, 17 May 2023 13:57:22 +0200
Message-Id: <20230517115722.1415937-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 11:57:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11490

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This prints the error message correctly to the log file instead of only
printing "(ERROR):"

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook    | 2 +-
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index a034d5d..23dce93 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -23,7 +23,7 @@ if [ -f /etc/os-release ]; then
     . /etc/os-release
 fi
 hook_error() {
-    echo "(ERROR): $2" >&2
+    echo "(ERROR): $1" >&2
     exit 1
 }
 
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index 077f43a..e3a296f 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -20,7 +20,7 @@ esac
 . /usr/share/initramfs-tools/hook-functions
 
 hook_error() {
-    echo "(ERROR): $2" >&2
+    echo "(ERROR): $1" >&2
     exit 1
 }
 
-- 
2.39.2


