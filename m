Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA7CAC5AA
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 06:00:36 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.4681.1758780027789414557
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 23:00:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=m0Cvvu4L;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250925060025803f63085500020762-a_u8nl@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250925060025803f63085500020762
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Sep 2025 08:00:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1pc26AHnIBv7oSdy/XfkNJRNMrxr5p+CoWFLqstdx6c=;
 b=m0Cvvu4LpMHjCLa/s+xHdQqnj/SCbJx0pDewzfldJz7MNUU5jsJhzlrcR8DGK/5zMXPQN7
 UGlOIE7YKwb6zJsd9AozDsPUQmkC3+m10W5Cdf8qaa1sZGOJCUiXU3F3edyx78eQOSEoXePP
 tiFzowKLeN6ja5V9NfgxGHxBYfigyGDiUI8IyuMdtWlFoJsQQ5BzJ7xg1w6AgQjz8GPkdktC
 OopocUN45XHwPrF24gQyYcjC/WkRNNHpGWwGBdQnY77+255Qh/kWJ/L5qE9lkezjuemT1YBi
 UUC6JfPJsZVg4EnGK+ncmZgB/ile12wZGFFVww2EFX3cuTmZQYDQiecA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v8 8/8] ci: Add factory-reset to qemu-amd64
Date: Thu, 25 Sep 2025 07:59:20 +0200
Message-ID: <20250925060009.1711605-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
References: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 06:00:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20122

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7ddb97c..ed151fa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -26,6 +26,7 @@ variables:
   swupdate_version: default
   test_function: swupdate
   separate_home_partition: disable
+  factory_reset: disable
   no_kernel: disable
 
 stages:
@@ -66,6 +67,7 @@ default:
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
+    - if [ "${factory_reset}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/factory-reset.yml"; fi
     - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
     - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
@@ -269,6 +271,7 @@ build:qemu-amd64-swupdate:
     use_rt: disable
     targz: disable
     deploy: disable
+    factory_reset: enable
 
 # bullseye images
 build:iwg20m-bullseye:
-- 
2.51.0


