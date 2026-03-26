Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC80110A62FD
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 14:41:43 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49989.1774536093513308248
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 07:41:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=UAqGkuP6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20260326144130bbaf893053000207ec-sbu9ds@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260326144130bbaf893053000207ec
        for <cip-dev@lists.cip-project.org>;
        Thu, 26 Mar 2026 15:41:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=OzJ0YSbe7idauViOTX0RsAognidslOg0Brg82SWKlt0=;
 b=UAqGkuP6BUB5nYsPerTKWKFQ+4+PzTz8ghqOZFTMiAX4gglpXl9H6IwffnZr6vtpkyZuKw
 jIfbD6JEwSIlEWecHAcpZpCv7vDVw04meHKzUJhKQBwOacemnUcr6VOMVe/M8DErsmTlbh8z
 vEmCPeMnkNi4YZu3o8DfoGQIQY9vc9UigZMYzLT+sPDtuUaXFAmp20B9+TEThSYOUF0Lbo1L
 tpQ7fDXg6NKlHuYuH1c0PqejwMbq1cdD5O4mfp1ocL9sfLt1Rv/db4KGZur/YLu2oRiVjAG4
 VBu32879cBKiBJnuBYd6NhnizwCSbRdedOwedht88C32/S6kMKbN+BSQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] chore: run swupdate in all tests with loglevel 5
Date: Thu, 26 Mar 2026 15:41:09 +0100
Message-ID: <20260326144129.853123-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 14:41:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22584

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to debug test errors.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/templates/swupdate-test-action-M-COM.yml | 2 +-
 tests/templates/swupdate_template.yml          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
index 69c9cb7..f86c4fa 100644
--- a/tests/templates/swupdate-test-action-M-COM.yml
+++ b/tests/templates/swupdate-test-action-M-COM.yml
@@ -15,7 +15,7 @@
         run:
           steps:
             - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-x86-uefi.swu --output test.swu
-            - if swupdate -i test.swu; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
+            - if swupdate -l 5 -i test.swu; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
       from: inline
       name: sample-test-1
       path: inline/sample-test.yaml
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index 9a3366b..d62d312 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -73,7 +73,7 @@ actions:
           description: "Test software update"
         run:
           steps:
-            - if swupdate -d "-u #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
+            - if swupdate -l 5 -d "-u #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
       from: inline
       name: sample-test-1
       path: inline/sample-test.yaml
-- 
2.53.0


