Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E0C77B7E
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 15:38:08 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.1535.1683041885277495506
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 08:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=X/Ioi/yL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20230502153802d8ff01de2e1f56ac45-qyzd1f@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230502153802d8ff01de2e1f56ac45
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 May 2023 17:38:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=W8Z+TQ3yOt87nb5sqlCgemWV3rHfIneQRsU0PhU1RNU=;
 b=X/Ioi/yLw6U5GqPf1JsgF7pIuL7tdzAQIp4XDxKAgIuVh7PF6/AW6RzXUGQ9CLeW/qd0Xh
 Ty78vR/2H9DMZLxvbg4Bp3eiEetEtJlXL/A+NDvCWu6GkzF56HB1peSekaESx5GscvtF91De
 2BjBeg13hl0AQiMOeNImEvhdYVGjI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 6/7] .gitlabci: Enable encryption for on buster
Date: Tue,  2 May 2023 17:37:58 +0200
Message-Id: <20230502153759.1284906-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
References: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 15:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11388

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Ensures the build of the buster encryption.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 09b6338..bd400cf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -313,6 +313,7 @@ build:qemu-amd64-secure-boot-buster:
     use_rt: disable
     wic_targz: disable
     deploy: disable
+    encrypt: enable
 
 # riscv64 (sid-ports)
 build:qemu-riscv64:
-- 
2.39.2


