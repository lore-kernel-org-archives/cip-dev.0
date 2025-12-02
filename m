Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9DDD11700
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4094.1764667288768008651
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=qcAVZMSY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20251202092120c061bf4bee00020730-wl6bwm@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251202092120c061bf4bee00020730
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=J2kfV1s87tmt5YXyN1KiO2ndE2RxYtK25vCZZi6S82Q=;
 b=qcAVZMSY92w+1+gSogJJUNU2Y9ulZblkTof+v3PAjp4fKwrahXebjuSgCGhA+vewXLVOJV
 yjuURVHuiCTWTqAPNrznlPx75Faxa+Cawuvbk+15xavYvh6A2iSRlrtamZwkl7rG9T8RTVCO
 s62Cm72D4WyPsizsHZu8M5LMQpA2mLhEXwLwJyTcQSies7qTsG9S6H1kwvW1qLiBvns4jp3E
 a9DWMndniWch52Er6QA3bA4M1CzBrBtOxmlYnuVAq5o+zPgYTQu5Gv6PGfta/tPt9WukFr08
 /tYuZ6246aES3bsvWX6WNxLym1Mh/GU2nzEyYWymR8PyAeEjM58kls+A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 01/14] tests: Avoid hard-coding distribution in M-COM test
Date: Tue,  2 Dec 2025 10:21:06 +0100
Message-ID: <10b9eb8a4ecd25045ad1a75def3c9885c9841b5e.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20787

From: Jan Kiszka <jan.kiszka@siemens.com>

Suggested-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/templates/swupdate-test-action-M-COM.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
index 02b0b036..56ff1061 100644
--- a/tests/templates/swupdate-test-action-M-COM.yml
+++ b/tests/templates/swupdate-test-action-M-COM.yml
@@ -11,7 +11,7 @@
           description: "Test software update"
         run:
           steps:
-            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-bookworm-x86-uefi.swu --output test.swu
+            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-x86-uefi.swu --output test.swu
             - if swupdate -i test.swu; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
       from: inline
       name: sample-test-1
-- 
2.51.0


