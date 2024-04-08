Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DAAC67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 12:45:42 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.105511.1712580339848346950
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 05:45:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RHKycsIX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202404081245367bc7e993c1865b0000-uonnzr@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202404081245367bc7e993c1865b0000
        for <cip-dev@lists.cip-project.org>;
        Mon, 08 Apr 2024 14:45:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=sIGF8k3sbRasGxPTSMvk8uSiCQRQcvnxU+4EImf21o8=;
 b=RHKycsIXPXoTA3tCJJgR+E2WkuqIo+GWb30qK2o+lGa7ai82FuIXn+m63f5LZ7ZLfh/osL
 bmjBSWYfyYTYTB5+ac9RqDn2QjR+AcMfWh146S3Cqkg7sG1ya+b0OmjPY//SBEsiYsnHQgQ0
 hHSm6ZEEbeLxWjpbLV0E8inFvUfLE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] layer.conf: Move SOURCE_EPOCH to kas-cip.yml
Date: Mon,  8 Apr 2024 14:44:59 +0200
Message-ID: <20240408124535.300693-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 12:45:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15500

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows downstream layers to overwrite the SOURCE_DATE_EPOCH with
there own implementation.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Was there an reason for the 'Immediate variable expansion' `:=`?
In the shell the variable is expanded correctly.

 conf/layer.conf | 1 -
 kas-cip.yml     | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 82b4084..6198e1b 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -25,4 +25,3 @@ LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
 
 IMAGE_CLASSES += "squashfs verity swupdate"
 
-SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
diff --git a/kas-cip.yml b/kas-cip.yml
index d10161f..737cfa0 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -41,6 +41,8 @@ local_conf_header:
     USERS += "root"
     USER_root[password] = "root"
     USER_root[flags] = "clear-text-password"
+  source_epoch: |
+    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
 
 env:
   DISTRO_APT_PREMIRRORS: ""
-- 
2.43.0


