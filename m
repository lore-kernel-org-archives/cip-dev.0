Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BE2C636D6
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 08:25:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.6291.1675412721391428816
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 00:25:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=beUUVTAv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20230203082518427d34143c9cc8f095-qrkmar@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230203082518427d34143c9cc8f095
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Feb 2023 09:25:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Uh7GfV4qULPRH0KXcT85v1CFk83RDbIRS1qbUb/LtB4=;
 b=beUUVTAvZQiqDRWMWgxpG+QRucTwFVNYEbXRNT3GX1DAuRyvA4ex/sWJSortPrDYmb/3Ne
 7pDjp9hf2CmcRMuh3JEEpQXGxgJTwPv6qCb8N7uOjP1EH9x3cSfi+IU+1oGK/632rLQEPnrd
 kBhvOdENQBdsxJXCcntH1YvTY/W/c=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/2] conf/distro: Use cip prefix and snapshot postfix for sid lists
Date: Fri,  3 Feb 2023 09:25:15 +0100
Message-Id: <20230203082516.27690-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230203082516.27690-1-Quirin.Gylstorff@siemens.com>
References: <20230203082516.27690-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 08:25:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10581

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is done to avoid infecting other layers with the snapshot version.

Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-sid-ports.conf                             | 2 ++
 ...debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} | 0
 2 files changed, 2 insertions(+)
 rename conf/distro/{debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} (100%)

diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
index 0b369bb..963b52c 100644
--- a/conf/distro/cip-core-sid-ports.conf
+++ b/conf/distro/cip-core-sid-ports.conf
@@ -14,3 +14,5 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
+
+DISTRO_APT_SOURCES = "conf/distro/cip-debian-${BASE_DISTRO_CODENAME}-ports-snapshot.list"
diff --git a/conf/distro/debian-sid-ports.list b/conf/distro/cip-debian-sid-ports-snapshot.list
similarity index 100%
rename from conf/distro/debian-sid-ports.list
rename to conf/distro/cip-debian-sid-ports-snapshot.list
-- 
2.39.1


