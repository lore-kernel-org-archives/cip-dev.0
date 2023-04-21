Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8003DC77B71
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 14:23:42 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.13236.1682087017614627427
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 07:23:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=V4WQZcxy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230421142335c8bd60b47f3b1d38a0-wmtkx_@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230421142335c8bd60b47f3b1d38a0
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 16:23:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UAcXrfuP+KEae714gAoxxn/bItuUBHUbGzaNR+oZJsQ=;
 b=V4WQZcxyYsOOgFULG0H6o6mnQoc6sWM19ZwXQZb2QXFYDJKPv+0Ju99f+dvBbXq8Xah67/
 j6240Wx4+SNMtJQP6lNL5rx6F1C8NENQp822QzcQmPqSI6+YQCrArFBs7gNPfPpy5eFlYZGV
 kQrM/iXkpy/LLwHAUU+JScL0tgKg4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 3/4] linux: Add missing kernel option for LUKS2 encrpyted partitions
Date: Fri, 21 Apr 2023 16:23:32 +0200
Message-Id: <20230421142333.3906250-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230421142333.3906250-1-Quirin.Gylstorff@siemens.com>
References: <20230421142333.3906250-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 14:23:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11319

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
index 2d878a1..bcd6ee5 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -24,5 +24,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     }"
 
 SRCREV_cip-kernel-config ?= "0188d9a54615767c00b77116146409edfa35497c"
+SRC_URI:buster:append = "file://buster-crypt.cfg"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.39.2


