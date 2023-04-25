Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9456C77B76
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 10:48:47 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.75830.1682419721591155533
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Apr 2023 03:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Cu7Wf55b;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2023042510483857af348406d77f487a-mqslsu@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023042510483857af348406d77f487a
        for <cip-dev@lists.cip-project.org>;
        Tue, 25 Apr 2023 12:48:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=W8Z+TQ3yOt87nb5sqlCgemWV3rHfIneQRsU0PhU1RNU=;
 b=Cu7Wf55bLzdJIO7ImmslO7el2o+PORANzKnY5WZ2ZdTJeqZQKBQgD9Wnb1+lzKcxpN4CWk
 YJoAo+F7Zei7SzWpPpxFEanEAiZYoxkGqXzx3ZZQscAvXSdHGO/YPe0PoTcIXtoejMEMDiGh
 qt6xeRGPs7OqOPdA4D/S2QqyKTA5g=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 6/6] .gitlabci: Enable encryption for on buster
Date: Tue, 25 Apr 2023 12:48:35 +0200
Message-Id: <20230425104835.655946-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
References: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 10:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11346

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


