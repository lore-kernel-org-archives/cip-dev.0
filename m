Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81233D41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 06:26:42 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42433.1765779992285417708
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 22:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=IYgIev8j;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-2025121506262911dce3ee8500020794-0tlscq@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025121506262911dce3ee8500020794
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 07:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kyjWf1kKB/8ATh27/+pfgk2KVT8EIVMLq378ie2aWKE=;
 b=IYgIev8j4t4t+haazgdpXcXtXrqJ3yIm0oaxiMa+4d+6urNjOiZZ+3sZWrdFesoh6OYboe
 lLnZMQHDVUpxMQWGVruwO2CGi6ID5xNpI6yB6dZ0E0p9KddDuDj2zSFquX1We6U2xaQYmnTT
 GwetxgXGykvgJDJ/L4AzWTo3/JZyzWV6EyDq9e4rDeiRyxtJ5e1ZUrfkSFhR6UnW18E/U0b5
 idaz/ZesL8WlZSBUxItHMzE8MC6+QjW3EHb1I8W11+dHymScwA1u6V4ZmWzRgyb/IRszg+M/
 buAAXwJfWJuYJkn4djVmmnTFbBwc6vE0DrF3n6V485scSnDyK6zYEiEQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/4] linux-cip: Update to 5.10.247-cip67 and 6.1.159-cip49
Date: Mon, 15 Dec 2025 07:26:24 +0100
Message-ID: <146a34ded2cd6ce82bb79d1b8a70c66e873b0c77.1765779987.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765779987.git.jan.kiszka@siemens.com>
References: <cover.1765779987.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 06:26:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21027

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_5.10.246-cip66.bb => linux-cip_5.10.247-cip67.bb} | 2 +-
 .../{linux-cip_6.1.157-cip48.bb => linux-cip_6.1.159-cip49.bb}  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_5.10.246-cip66.bb => linux-cip_5.10.247-cip67.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.157-cip48.bb => linux-cip_6.1.159-cip49.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip_5.10.246-cip66.bb b/recipes-kernel/linux/linux-cip_5.10.247-cip67.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.246-cip66.bb
rename to recipes-kernel/linux/linux-cip_5.10.247-cip67.bb
index 7e02ce32..872af231 100644
--- a/recipes-kernel/linux/linux-cip_5.10.246-cip66.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.247-cip67.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "776dc35c07830ef54756328b47c72b81f4af58117a9321683eb788be6dc82258"
+SRC_URI[sha256sum] = "04e1a12d68bbc64079d6c3aabc833844e91932cdfb1a91154c24711469c63a60"
diff --git a/recipes-kernel/linux/linux-cip_6.1.157-cip48.bb b/recipes-kernel/linux/linux-cip_6.1.159-cip49.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.157-cip48.bb
rename to recipes-kernel/linux/linux-cip_6.1.159-cip49.bb
index 185d56ed..1b0b0f75 100644
--- a/recipes-kernel/linux/linux-cip_6.1.157-cip48.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.159-cip49.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7d4cf60253c1a57745d1dfd56c92a4a7e2d71ba71f1d3f488d5c37c435fea141"
+SRC_URI[sha256sum] = "7e968abceb8c949d2b7e8cf3885293dc18f367da5d95d466105851fbbc77a41e"
-- 
2.51.0


