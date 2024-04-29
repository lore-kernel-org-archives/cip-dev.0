Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA737C04FFE
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 11:43:47 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.13812.1714368278410897326
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Apr 2024 22:24:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.rakesh@siemens.com header.s=fm1 header.b=FppkPLbD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1325885-202404290524351f528c623cb4d218ce-o7iaxj@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202404290524351f528c623cb4d218ce
        for <cip-dev@lists.cip-project.org>;
        Mon, 29 Apr 2024 07:24:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kumar.rakesh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BMurxbn73d7q4lJMUI8UZTWHXe0B/5DDUA5olc/5KRI=;
 b=FppkPLbDNTgYmz0hRlM6luWcB6dKzrNZheT7TAmmWwkg8Bd/Zr0eFrF4RVf/fGqZH5S5pc
 xpGBBoNd/mBN3InrygkIN0aVaBO3BvknOBFDXSDR7Xx0lQhqqT8aDi1NHGof10Pl2nJq6tp3
 u7is8Ol79BhNJw3tHP28dpj4ft7YA=;
From: Rakesh Kumar <kumar.rakesh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Rakesh Kumar <kumar.rakesh@siemens.com>
Subject: [PATCH v1] update ISAR to latest version
Date: Mon, 29 Apr 2024 10:54:17 +0530
Message-Id: <20240429052417.736212-1-kumar.rakesh@siemens.com>
In-Reply-To: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
References: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325885:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 11:43:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15774

One of the changes is DEBIAN_PROVIDES, which is required to
resolve the duplicate Provides problem in secure-boot-secrets
to ensure that the build process completes successfully.

Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 2c3c8b0..b098dc0 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
+    commit: 55833bb33a04fc93eec1c325ee72c298b5bbb802
     layers:
       meta:
 
-- 
2.39.2


