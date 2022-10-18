Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4990C4332F
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 07:27:08 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.4121.1666078016056004862
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Oct 2022 00:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=V6VtFwIY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20221018072653ab8db5abba81df8908-a5kpcn@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20221018072653ab8db5abba81df8908
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Oct 2022 09:26:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Q1XjzSkA+n1nbay/4Fm+85SjzRUszTpowus6lElMruM=;
 b=V6VtFwIYRgikEZG5UvqNS4+2dtRlPHGYbUdoDLX56iEb4FjA5dRLre5pJrxuyKGhWk1/g1
 ijZ8qLy9fo53x3I0eDYcNz6u6eb5bv+6zrsHwp8Yve4GRhCExbH6Q33hsX4HUHmJeR2uM2Ve
 QTWcs/95eAaNAuc02VEa400abmbgE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: ubely@ilbers.de,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] tmp_fs: Correct option generation
Date: Tue, 18 Oct 2022 09:26:52 +0200
Message-Id: <20221018072652.10944-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <124d9128-63b4-d0ef-5cf9-7931a017e0c6@siemens.com>
References: <124d9128-63b4-d0ef-5cf9-7931a017e0c6@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Oct 2022 07:27:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9769

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes issues https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/44.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/tmp-fs/tmp-fs_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/tmp-fs/tmp-fs_0.1.bb b/recipes-core/tmp-fs/tmp-fs_0.1.bb
index 3ec20c7..b86b0fb 100644
--- a/recipes-core/tmp-fs/tmp-fs_0.1.bb
+++ b/recipes-core/tmp-fs/tmp-fs_0.1.bb
@@ -15,7 +15,7 @@ SRC_URI = "file://postinst \
 
 TMP_FS_SIZE ?= "500M"
 TMP_FS_MODE ?= "755"
-TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_SIZE},mode=${TMP_MODE}"
+TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_FS_SIZE},mode=${TMP_FS_MODE}"
 
 TEMPLATE_FILES = "tmp.mount.tmpl"
 TEMPLATE_VARS += "TMP_FS_OPTIONS"
-- 
2.35.1


