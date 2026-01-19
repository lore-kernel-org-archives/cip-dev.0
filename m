Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ACDD4A5EB
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 06:18:38 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30056.1768803515710407627
 for <cip-dev@lists.cip-project.org>;
 Sun, 18 Jan 2026 22:18:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=QlWq1pR6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1324425-20260119061832c329fe44c80002073c-m0obh3@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260119061832c329fe44c80002073c
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Jan 2026 07:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=OG/fV+p8p/a9OIycSnRbE8XlhnJftmZXaQAIacj15a0=;
 b=QlWq1pR63sVmIiyI4N7LL2Nhkq3MhJbkCHIK5RHJRNonXduxbKPHJAKwrtccfNAJX3maWS
 NVPlip3rl16ffWnHqwzdu6ckaeiiPdso2yWDWfVt/mnMcd1/GqmTaSoXJZAqfvvm5uwE1Wy3
 lStsRqOvE9Ds2mqOy0M+zVN2DKT/gVS0TaQGUmaTstJR6M0hFii0gknQRWJXGNzBO4SyP/RL
 ByrfpGDciWXjhgj5geGQZYFzc4HrnIVCV13qqFhK0fxw0NRFDyiZhtQD6/24enPlujSG3Pbt
 PImN+KuEajFAQFRXx6pgSDtPGaEnW7CLRy5m/Nq8QGtWdkaXm2AFINng==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] Update Isar revision
Date: Mon, 19 Jan 2026 11:48:50 +0530
Message-Id: <20260119061851.120592-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 06:18:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21643

From: srinuvasan <srinuvasan.a@siemens.com>

This revision brings the few installer fixes, fixes the build of
linux-libc-dev-*-cross packages, adds support for reproducible source
tarball generation, and includes a few minor fixes.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 kas-cip.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index aa9f3b4..a3e9b24 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2025
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: d364cfa643d1d61d768b5235b9783ca083a564ab
+    commit: 33ca03c711e34d38d303ca38c1259cb6c5fe55ef
     layers:
       meta:
 
-- 
2.39.5


