Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B6CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 08:01:21 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.17469.1758096070427488548
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 01:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hRRF3zPo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20250917080107a44527aae400020719-hr4wzl@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250917080107a44527aae400020719
        for <cip-dev@lists.cip-project.org>;
        Wed, 17 Sep 2025 10:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=r+ZzSerVo6BTSJ8NidYY1Zg+4iZ7IfNpMZYgpA51Sz4=;
 b=hRRF3zPo1ri6DjwCa+4RM5jTyyQFbdtHutUmf/5hjzqnE/ICH0cuxqE2JVRp7UUXZpC+qe
 6YRFD/hW5zdEctg+RQjGUoa4QrILLRl53fRNrl8dLtyJ3hiO9FDR3gtmc+R3TnPQVKZu+2xH
 q8cfXxw0l+rwRGr5hVbKjGEa3kK8P8QDF85VOa1imGNcKOnfa3cOy3i/ng6JnZYFY1DmnRq7
 bEHjwcMabhadJmG/y+r76TVJamwB9v3qUnbIIVpswllou4tXlsNkFsW0u7dR649yzHdnsP6x
 q8jmtt3gHaW1YCKI6T0St6YjByGBz3vt19MlFiA0s/Wu4HHOXt+nJ9pA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/3] ci: Do not attach cve-checks to scheduled pipelines
Date: Wed, 17 Sep 2025 10:01:04 +0200
Message-ID: <6e6aeb37c31118c2b7c4c5c74093f347d903f6d2.1758096066.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758096066.git.jan.kiszka@siemens.com>
References: <cover.1758096066.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 08:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20068

From: Jan Kiszka <jan.kiszka@siemens.com>

This one is only relevant for regular isar-cip-core image builds.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7f0f4503..d951e160 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -663,7 +663,10 @@ cve-checks:
     - large
   script:
     - scripts/run-cve-checks.sh
-  when: manual
+  rules:
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
+      when: never
+    - when: manual
   allow_failure: true
   artifacts:
     expire_in: 1 day
-- 
2.51.0


