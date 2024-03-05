Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B117C54E55
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 09:07:43 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.18060.1709629657163427447
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 01:07:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=qYxxwgTe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20240305090733682a3b02db74ae308b-aiksgm@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240305090733682a3b02db74ae308b
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 10:07:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LHyEOvPE2nzeJqa+rBgagwDYqpnejA6BSX4VJFf1lHg=;
 b=qYxxwgTejJgJSo6P0hI22bn+3E0aOJltTMsEX9PAqd8iB5Kte9ex4j2fgF/bsEE+aBuHWb
 W8WA3TxOXrXQvgFEFQvqjy2uIqOBzGuNIiYMGY9Y6ZgzSYLUfva7Sj/O+RylkHe2ikU3zUCE
 ljdPDLJ7M939Y62mP5iNS699e2J6c=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/4] linux-cip: Update to 4.19.306-cip107-rt35 and 6.1.80-cip16[-rt9]
Date: Tue,  5 Mar 2024 10:07:30 +0100
Message-Id: <6453e697f873d88abf526eb96441516c4e076ca8.1709629653.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1709629653.git.jan.kiszka@siemens.com>
References: <cover.1709629653.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 09:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15209

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....299-cip105-rt34.bb => linux-cip-rt_4.19.306-cip107-rt35.bb} | 2 +-
 ...-rt_6.1.75-cip14-rt8.bb => linux-cip-rt_6.1.80-cip16-rt9.bb} | 2 +-
 .../{linux-cip_6.1.75-cip14.bb => linux-cip_6.1.80-cip16.bb}    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.299-cip105-rt34.bb => linux-cip-rt_4.19.306-cip107-rt35.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.75-cip14-rt8.bb => linux-cip-rt_6.1.80-cip16-rt9.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.75-cip14.bb => linux-cip_6.1.80-cip16.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.299-cip105-rt34.bb b/recipes-kernel/linux/linux-cip-rt_4.19.306-cip107-rt35.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.299-cip105-rt34.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.306-cip107-rt35.bb
index b5924013..cc95e0e0 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.299-cip105-rt34.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.306-cip107-rt35.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "cbbaf945457a045fa5adafcc9206ffab26139d5ea9f21fb2f57f33923aaa24e1"
+SRC_URI[sha256sum] = "91feddff1eeb7cefe7099d3c2c5333d14287080885e82d396420226421f85711"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb b/recipes-kernel/linux/linux-cip-rt_6.1.80-cip16-rt9.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.80-cip16-rt9.bb
index fd451452..3b690741 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.80-cip16-rt9.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5b03796de85dd71b0fc1c67ee0fb5071dae10f22c85ca7c502b5b21f141d16c3"
+SRC_URI[sha256sum] = "384369dbdd689831e69899c8c584feef6677382c1448a2e9195523c0594ba761"
diff --git a/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb b/recipes-kernel/linux/linux-cip_6.1.80-cip16.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
rename to recipes-kernel/linux/linux-cip_6.1.80-cip16.bb
index 4fdc6069..10058ac2 100644
--- a/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.80-cip16.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "a820699d7342d8ad8a8f580da90e03ee4db37e9d5dac4cf8d14015ab3bae5f62"
+SRC_URI[sha256sum] = "70c9e7ea89951450885f33f8056f484e1197ec39ebe2b6d49fb9357bec4247a8"
-- 
2.35.3


