Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C71C83F17
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:00:50 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.60275.1753963248828956026
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=GufJIM5c;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202507311200442e6bb228e6e18165a4-se9t_v@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202507311200442e6bb228e6e18165a4
        for <cip-dev@lists.cip-project.org>;
        Thu, 31 Jul 2025 14:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5EeyCH6FYL/P/Iu+GJEwxmMf7Qtdv+aB64+Uf1vLlJc=;
 b=GufJIM5cV1eq3b520/42oZ+B2LigXKgxvnV86mYLPsXCR46HEJmb9/wztoSaC6v0vhCXDy
 yCSh/jS4QgstSPefhj/UiVeKbGkZg8qxgCuHMeBQgjensAyf77wwrVtFxsyX0yFGrvFMppam
 sUAC1hQQPkoSE7FuY+jmQ/kK0hs+a+gDUZkZKdiZdqWTdidW01cwionPnJb395jtzeAr5OaR
 3UadmlX8JnvqXK4siLgsYBvqLIxYflYqpqCATqmjtXLUV4hCLiajxHc2FGmcz3qRLTYwIgyq
 tmsHfkcw9FBeGhHwfWyG/vYoFoDUUBoFFNDPTQsERszf1V7fAAnmP6rA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 4/7] encrypt-data.yml: Add factory-reset information to encrypt-data
Date: Thu, 31 Jul 2025 13:58:43 +0200
Message-ID: <20250731120043.333345-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 12:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19644

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/encrypt-data.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
index 3de76ab..4292d4c 100644
--- a/kas/opt/encrypt-data.yml
+++ b/kas/opt/encrypt-data.yml
@@ -15,3 +15,6 @@ header:
 local_conf_header:
   initramfs-option-encrypt-partitions: |
     OVERRIDES .= ":encrypt-partitions"
+  initramfs-factory-reset: |
+    INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE = "/dev/disk/by-partlabel/BOOT0"
+
-- 
2.50.1


