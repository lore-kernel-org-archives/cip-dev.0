Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0311C77B7D
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 14:01:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.18225.1683727188332976559
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 06:59:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=TZIVk0yU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-72506-2023051013594561ab1060eec7b4b286-xsyssl@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023051013594561ab1060eec7b4b286
        for <cip-dev@lists.cip-project.org>;
        Wed, 10 May 2023 15:59:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3AbD06Pup8uBNFkix2se2hEvcWN+4igVlQJ8rEZcssA=;
 b=TZIVk0yUoh0nTA3XxVXWOvrTFVoEWFARud9XVR8gnyAISTQPQIYoWsi3n0cHPJwgzleHcJ
 +p66jTpxw5c3YnlFaTe3gyrTZkih5ttbog2Ap71P1UNQBOZBmHLlJBI/QlCkkHuP5WzTYr53
 WU925Nqp7OmMBCLfCnjLJqDBH5Fz8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] use cdn debian mirror for backports as well
Date: Wed, 10 May 2023 21:59:13 +0800
Message-Id: <20230510135913.854211-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 14:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11432

This patch replaces the location specific ftp.us.debian.org repository
mirror by the deb.debian.org version which is served via a CDN. This is
also needed to enable location-specific overrides of backports using
DISTRO_APT_PREMIRRORS. These usually only override
deb.debian.org, by which the packages from backports significantly
slowed down the build.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/distro/debian-bullseye-backports.list | 2 +-
 conf/distro/debian-buster-backports.list   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
index 3a55e4c..f1461ab 100644
--- a/conf/distro/debian-bullseye-backports.list
+++ b/conf/distro/debian-bullseye-backports.list
@@ -1 +1 @@
-deb http://ftp.us.debian.org/debian bullseye-backports main contrib non-free
+deb http://deb.debian.org/debian bullseye-backports main contrib non-free
diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
index f2dd104..e333156 100644
--- a/conf/distro/debian-buster-backports.list
+++ b/conf/distro/debian-buster-backports.list
@@ -1 +1 @@
-deb http://ftp.us.debian.org/debian buster-backports main contrib non-free
+deb http://deb.debian.org/debian buster-backports main contrib non-free
-- 
2.39.2


