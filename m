Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C0EC44536
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 16:16:53 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15386.1769012209000932658
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 08:16:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=clara.kowalsky@siemens.com header.s=fm1 header.b=ZXmuuael;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1047747-202601211616450aa15cbf7300020750-wzni40@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202601211616450aa15cbf7300020750
        for <cip-dev@lists.cip-project.org>;
        Wed, 21 Jan 2026 17:16:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=a0T/RVo6wEjhtna5ooA99nO8rqrLctLg3/oploXHi64=;
 b=ZXmuuaelGZLWOAT/eGmF14DhWNA2oINz4baadf7JvPQtPLd9+E8YojvjT+6xxMTtz1Usck
 IzcSPUT646PQ0y/ogsrgafCMe+yoJfUANzNbvcXrg3pNUTK0AiT0HK/jGn9c86H8j2KFUp/S
 /yhb0qkQpX8qXzjlxVpgmA7CC60oinRPhMQk06Fl52bql0wbxq/4p3JmMDuaZdu7HkYLwCfR
 erOUAgdUT/g3ipzYHpjbkhCcn1JFk9/1GlSx5pzu5cO8j3L/5dygbqegbEih0GNlIOt4A2JC
 IFUZD8nGlPEy4ZfewNlGYvZ52KloJzAwjaDZz+JX7N5RneUcRLqkUx7w==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] fix(linux-cip-head): catch network access error during commit retrieval
Date: Wed, 21 Jan 2026 17:16:34 +0100
Message-ID: <20260121161634.2385379-1-clara.kowalsky@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 16:16:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21690

For offline builds (BB_NO_NETWORK="1"), the linux-cip*-head recipes
cannot fetch their commit hash. This catches the error and falls back to
an empty string for the commit hash.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 recipes-kernel/linux/linux-cip-head.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-head.inc b/recipes-kernel/linux/linux-cip-head.inc
index df604db..94163f2 100644
--- a/recipes-kernel/linux/linux-cip-head.inc
+++ b/recipes-kernel/linux/linux-cip-head.inc
@@ -14,7 +14,7 @@ require linux-cip-common.inc
 def get_commit(d):
     try:
         return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
-    except bb.fetch2.FetchError:
+    except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess):
         return ""
 
 KERNEL_MAJOR_MINOR := "${@d.getVar('PV').split('-')[0]}"
-- 
2.52.0


