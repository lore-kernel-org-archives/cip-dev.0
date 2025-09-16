Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D709CAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 16:09:27 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.2582.1758038961981549118
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 09:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=kWzmllWT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202509161609176c63ef61f20002077d-tw2p3o@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202509161609176c63ef61f20002077d
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Sep 2025 18:09:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=yD4L8f2npQoMKnoi95Tg5NrmX3WOsncIIdTcuH2e4Z8=;
 b=kWzmllWTMs78T4KiVbuw8x8GD+wYxX+h9ZmxQpmXQsMeQja6/oEGkNbI7HM1x0cqIbsIAC
 OaRuRvND2iydinPEgiZDjmfzPzei6LbzMCpNS39xLF3BO3+4J2h0v6s+bYs5LnRsLaRJ6JJ6
 t0ghCWPUmDTdpQwPUNLjx2KplcNk+v0JJmIVEXWZm7i4riY5h1Z89H6mfaw/zoZ2KaPL0QDc
 IYUCNq3eEuWvE69QZXz4pON2KnNVLlWJoj9zkEzSyG7rK4BeLq3CgfIN9aDrQ6tnrEQ8NS9n
 Zjg69gvby1dWWHrizzHzfHXYz21Ckr9iSc3+DBoGyYkSA53uwsi5IOoQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] erofs: Set UUID and SOURCE_DATE_EPOCH with empty exclude dir
Date: Tue, 16 Sep 2025 18:08:46 +0200
Message-ID: <20250916160909.1797500-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 16:09:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20064

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

if EROFS_EXCLUDE_DIR is empty then SOURCE_DATE and UUID are not
set. These variables should not be depend on EROFS_EXCLUDE_DIR
as the are necessary for reproducible erofs builds.

Also add a space to setting the uuid string. This avoids
the mangle of EROFS_CREATION_ARGS in case EROFS_EXCLUDE_DIRS
is empty.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - append EROFS_CREATION_ARGS only once
 - add info about space before uuid to message

 classes/erofs.bbclass | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
index 2743bd1..0b928d1 100644
--- a/classes/erofs.bbclass
+++ b/classes/erofs.bbclass
@@ -17,21 +17,19 @@ EROFS_CREATION_ARGS ?= "-z lz4hc,12"
 
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
 
     import uuid
 
     sde_time = int(d.getVar('SOURCE_DATE_EPOCH'))
     erofs_uuid = uuid.UUID(int=sde_time)
 
-    args = "-U " + str(erofs_uuid)
+    args += " -U " + str(erofs_uuid)
     d.appendVar('EROFS_CREATION_ARGS', args)
 }
 
-- 
2.50.1


