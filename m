Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D7DC10F15
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 12:10:00 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.12697.1714037189834229125
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 02:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.rakesh@siemens.com header.s=fm1 header.b=FfbWBPIZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1325885-202404250926262bed9db7c9f0353edb-dbihe5@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202404250926262bed9db7c9f0353edb
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 11:26:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kumar.rakesh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=yO5q8O4CD0JDH8P6lDjseCoocquvFDmHr0WcWEJiWHA=;
 b=FfbWBPIZhLNRECFoBiOkUQZhqY0z+9vX5D7HlFzTgYKcQLkRHSJqoK/PGJD2MLq4X0+CFP
 KyHbKfzy5V74hgs7eIQzv4q836Ir6cBAqc3oN2VrnhifSGBYprIdVAl/9AW30vpQgLJX9eOP
 zF4/yc2M7dE6asK+EztElFQ3uZkFo=;
From: Rakesh Kumar <kumar.rakesh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>
Subject: [isar-cip-core] [PATCH] update ISAR to latest version
Date: Thu, 25 Apr 2024 14:56:08 +0530
Message-Id: <20240425092608.685136-1-kumar.rakesh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325885:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 12:10:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15764

Update the isar to get the latest changes into cip-core.
One of the changes is DEBIAN_PROVIDES, which is required to
resolve the duplicate Provides problem in secure-boot-secrets
to ensure that the build process completes successfully.

Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 2c3c8b0..8a83951 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
+    commit: 3327e66994e1a487eb1b609902c12f383faa3b3a
     layers:
       meta:
 
-- 
2.39.2


