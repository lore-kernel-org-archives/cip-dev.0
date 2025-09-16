Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A07CAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 13:45:45 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.20474.1758030336220819377
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 06:45:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=os9NuLJW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20250916134532622fb33162000207f3-vrmnqs@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250916134532622fb33162000207f3
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Sep 2025 15:45:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=vdCtOPQ8yB+MGKRcXwXqwI8CSJhxmz4dGEXvDDXIBRg=;
 b=os9NuLJW35wQFAt2WL9TjcAiLbqVEtCcDsgYAfeJOupyQgD3X1QOyreZcVZBnWXvC5yBm5
 r2buQFU3z1fQphPJZiyQuklMKKyUGrtwrm5eaUxn8Khck7w2sH/Pv5Gn3FRXk7OxnTndT6yr
 ZRnvSNOs4gSbkb7sXFt5YibmXPnAA9IYUvDJ2i0FlXyyw1w46wQ3r+DI/ACMlNt2TL4XttW8
 ud5TKjhrdZFMNSd4w1z8vRQyHtFX2P3XmRBWjiqEHNGRBcuiRWwlcOVe0t9ZMWBmRwFIRQPH
 ubz1MmwFdsz9D5fhayjjmymP4GAtcKhLlRLsyFgrE+yItY/sncwAhDlA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Ensure coreutils are installed
Date: Tue, 16 Sep 2025 15:45:07 +0200
Message-ID: <20250916134524.1778500-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 13:45:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20057

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This should avoid the following error:

2025-09-16 13:03:48 - INFO     - | /bin/bash: line 25: file_size: command not found
2025-09-16 13:03:48 - INFO     - | /bin/bash: line 26: [: : integer expression expected

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index c18aaa9..64ae58a 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -53,7 +53,7 @@ IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
     if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
     else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
 
-IMAGER_INSTALL:swu += "cpio"
+IMAGER_INSTALL:swu += "cpio coreutils"
 IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 
-- 
2.50.1


