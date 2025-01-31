Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2B4C02190
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 15:26:02 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.21721.1738337157476519664
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 07:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=OuuUNzwz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20250131152554378cd7791c192b318f-vmkyrw@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250131152554378cd7791c192b318f
        for <cip-dev@lists.cip-project.org>;
        Fri, 31 Jan 2025 16:25:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=q1zWE6tQZEt1WfmdLU6EFPAps4Wd+/Sgb61nB+1kGQs=;
 b=OuuUNzwz1alzZeiMEYyDqNcLqU7lN9n4oSqTVgHz4HRwtGCuBZOPsxvEpcVa8pzTLMBp0g
 ecB9ui3vkbC7YAQ/PQORfkMwQ7FBw/O0Z3gcR4Uj85lfE1qiSaSfKzpNCyx/oo4VPHhvnPZh
 8GBTPsmittUgqU6lgkbXPuZSbmwspyVuXc3WSg/HmoVw0SXZRJsTqzM0FjYQJUdVd9BecI+R
 QJRnlaedguQIZBZSRxx12u5KjDltBzFgBw/Xtj0dbK0vJ9nsKQrbHW/49rgUv35A8FU1UDzE
 ztHi1QLKjBlHynTXiM0EulrHf4sqGgri8T8a7SlAhK8OHDdt4duAeW7g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 1/4] build x86-uefi with secure boot
Date: Fri, 31 Jan 2025 16:25:29 +0100
Message-ID: <20250131152553.270393-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
References: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 15:26:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17721

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d4bd283..c44cf8e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -241,6 +241,15 @@ build:qemu-amd64-secure-boot-encrypt:
     deploy: disable
     encrypt: enable
 
+build:x86-uefi-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: x86-uefi
+    extension: security
+    use_rt: disable
+    targz: disable
+
 build:qemu-amd64-swupdate:
   extends:
     - .build_base
-- 
2.47.0


