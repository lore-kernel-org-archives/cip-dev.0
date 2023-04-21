Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35EEC7EE20
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 15:05:52 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.14925.1682089549350150163
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 08:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Knq5Ghn/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230421150546ce978195dba27b2301-bzuwrw@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230421150546ce978195dba27b2301
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 17:05:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nExB4QJMvGK2fZ49zPdFBt51ApdAutJ3n+6MZsmiilg=;
 b=Knq5Ghn/fKjPfZUoba7tx4QzJR2g+JOyZ2Fz0RsygywdQUmiL9+W6vMQlQOJrbOWNU6gyE
 7RP4xQGMlg+Sz6dGkgkEg5t8OhLBUo6RQby8/sHPfYDNpqR5EZ5vmv+zoVEWg6ZsiyTyyiu1
 R/H6OeyfpeKwqzS/eS1OHcvcheqwk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 3/4] linux: Add missing kernel option for LUKS2 encrpyted partitions
Date: Fri, 21 Apr 2023 17:05:44 +0200
Message-Id: <20230421150545.4073324-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
References: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 15:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11322

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

cryptsetup uses the user api of `CONFIG_CRYPTO_USER_API_SKCIPHER`
to generate the keys.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/buster-crypt.cfg | 2 ++
 recipes-kernel/linux/linux-cip-common.inc   | 1 +
 2 files changed, 3 insertions(+)
 create mode 100644 recipes-kernel/linux/files/buster-crypt.cfg

diff --git a/recipes-kernel/linux/files/buster-crypt.cfg b/recipes-kernel/linux/files/buster-crypt.cfg
new file mode 100644
index 0000000..e3ca518
--- /dev/null
+++ b/recipes-kernel/linux/files/buster-crypt.cfg
@@ -0,0 +1,2 @@
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 2d878a1..577d4db 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -24,5 +24,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     }"
 
 SRCREV_cip-kernel-config ?= "0188d9a54615767c00b77116146409edfa35497c"
+SRC_URI:encrypt-partitions:buster:append = " file://buster-crypt.cfg"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.39.2


