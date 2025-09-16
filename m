Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BEBCAC598
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 12:10:05 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.17887.1758024598694612231
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 05:09:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=slCRBpuC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2025091612095447e6c67b10000207e4-cdtzfr@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025091612095447e6c67b10000207e4
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Sep 2025 14:09:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=M04ri59Mxp6M16DE+/0unOrBjZ68if7ja36IM14qdAU=;
 b=slCRBpuCfPmR10yd/gRUaMXcTFioprXzx4KCsLJAGWBaT6nLUZG7tLAZe6oFKSv6TsLEwN
 yFqFJGQxbUoo//YP0Bx+5AN1DpVBs6TB4+7YOd41fybwcQpHgXconB+ccqrQuIcfHcznAObU
 PS21wklR0+AhC+30N0vQ0gITYJs1mizM3zta+LlH35RSGYEihNEE8kE/O5vhf3TRlIxX3E7p
 cFQfIesRJEd5JLzganVlqZY5BMGxG62/fu70PEOB08d2Yz/vV0ublyAGU6iHkyxcWuba+gG+
 B7aM2sNVdaZBuSPxDK33Pl8B/nBGp6jpJ6u1O6dGIIS6PNIEbhFhNYXQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] erofs: Set UUID and SOURCE_DATE_EPOCH with empty exclude dir
Date: Tue, 16 Sep 2025 14:09:29 +0200
Message-ID: <20250916120952.1771209-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 12:10:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20056

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

if EROFS_EXCLUDE_DIR is empty then SOURCE_DATE and UUID are not
set. These variables should not be depend on EROFS_EXCLUDE_DIR
as the are necessary for reproducible erofs builds.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/erofs.bbclass | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
index 2743bd1..debf097 100644
--- a/classes/erofs.bbclass
+++ b/classes/erofs.bbclass
@@ -17,21 +17,20 @@ EROFS_CREATION_ARGS ?= "-z lz4hc,12"
 
 python __anonymous() {
     exclude_directories = d.getVar('EROFS_EXCLUDE_DIRS').split()
-    if len(exclude_directories) == 0:
-        return
     args = ""
-    # Use regex to exclude only content of the directory.
-    # This allows to use the directory as a mount point.
-    for dir in exclude_directories:
-        args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
-    d.appendVar('EROFS_CREATION_ARGS', args)
+    if len(exclude_directories) > 0:
+        # Use regex to exclude only content of the directory.
+        # This allows to use the directory as a mount point.
+        for dir in exclude_directories:
+            args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
+        d.appendVar('EROFS_CREATION_ARGS', args)
 
     import uuid
 
     sde_time = int(d.getVar('SOURCE_DATE_EPOCH'))
     erofs_uuid = uuid.UUID(int=sde_time)
 
-    args = "-U " + str(erofs_uuid)
+    args = " -U " + str(erofs_uuid)
     d.appendVar('EROFS_CREATION_ARGS', args)
 }
 
-- 
2.50.1


