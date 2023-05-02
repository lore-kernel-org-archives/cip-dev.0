Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72746C7EE2F
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 15:38:08 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.1466.1683041883943133690
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 08:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LvGLUcB7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230502153801ed96cb530afe6c22c6-tnc7mc@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230502153801ed96cb530afe6c22c6
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 May 2023 17:38:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=GZBYDY0BzNZoXj7iR9WLtOBjsHbZZwx3NOQHBM6ashQ=;
 b=LvGLUcB74aVLHAHXhOT286pgCtO9jCwgyO7slfBJwrWZgeer3m0pLyaCKuLSfvoDr1fr+V
 yrn0XZ/3hyawiB5sXJXR7l9sYJvxR9uVEhX672jVs2bgnv9Mjti8+E8yrU8qm9OOqZkmmW0/
 blY3Yms5NhOVGJfPHG7Xi05TYE6UM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 3/7] linux: Add missing kernel option for LUKS2 encrpyted partitions on buster
Date: Tue,  2 May 2023 17:37:55 +0200
Message-Id: <20230502153759.1284906-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
References: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 15:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11387

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

cryptsetup uses the user api of `CONFIG_CRYPTO_USER_API_SKCIPHER`
to generate the keys.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 2d878a1..a700d30 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -23,6 +23,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "0188d9a54615767c00b77116146409edfa35497c"
+SRCREV_cip-kernel-config ?= "d1efa37258380c7f4f39a8dee1bdb4d85f1c0199"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.39.2


