Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE40C43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 07:25:37 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web09.24160.1654845929334288512
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jun 2022 00:25:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=ltSd+kck;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-51332-202206100725255fd98cbe12c6b79d6c-_pzcee@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202206100725255fd98cbe12c6b79d6c
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jun 2022 09:25:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dP5MjiM7XaIp2WSvzrXEebq8yJFh+L8QYNdqoaBwy+w=;
 b=ltSd+kckuA+OEH7Ac2Qe2Y8dLFw6zU9zKh2cMjwwIZSLBZ8vQcWSUbg/zDjxjBR1hmYi+Y
 FSEte7s46IXdSSpcKg7gahqIeQ+RcWc8bMfQBswWRvdaPpiavsX1sgTsrhYlL9j9Pq9WifW7
 x/9Ew9+mbaw0+8/7RKw0wuF1XoE9Y=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/2] .gitlabci: add qemu-arm64
 secureboot and swupdate
Date: Fri, 10 Jun 2022 09:25:23 +0200
Message-Id: <20220610072524.910925-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
References: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 07:25:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8526

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8545a66..23ab1cb 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -218,6 +218,29 @@ build:qemu-amd64-swupdate:
     targz: disable
     deploy: disable
 
+# secure boot images arm64
+build:qemu-arm64-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    targz: disable
+    deploy: disable
+
+build:qemu-arm64-swupdate:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extension: ebg-swu
+    use_rt: disable
+    wic_targz: disable
+    targz: disable
+    deploy: disable
+
 # bullseye images
 build:simatic-ipc227e-bullseye:
   extends:
-- 
2.35.1


