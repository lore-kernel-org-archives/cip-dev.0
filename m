Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E61CD98C5
	for <webhook@archiver.kernel.org>; Sun, 14 Jun 2026 14:57:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.110641.1781449065937734675
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Jun 2026 07:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=Bqk9xZvl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1324425-2026061414574320198b0dfa000207b9-64_wtg@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026061414574320198b0dfa000207b9
        for <cip-dev@lists.cip-project.org>;
        Sun, 14 Jun 2026 16:57:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MxlMtpo74St+uPigyI3+TG/5DvLoByUrsOgpz1pnalg=;
 b=Bqk9xZvlBtyWZqS0jNi+PAZGmj5qvaDJftbISV5UkNDO//0mnXQAfXjgVsQgwgRPEtgBHm
 3AakTIyCiFDvefvxG5PadiolKOfuGZ4R7L+gHCfkN28WxW73r+cEZ0jGTHAFj+ifeKdtii6x
 DLI/breNzmIzRyKCtD4LVNc/lzcM4jeJ6sxihIM/Er6QCYfXOFCC9Otuk4W7RjdvVl3xJbSS
 imyLgaVBBTQFPJWrf6FEQySwO/L/9zA50F2sPg6pCEvJ5CPJ9RDr5GUalq84dWI0cDncLdPu
 SV1+sKLTCV9INHLt+W4uvyVaui5y/GaqSpYYjIZ2ixBXf0DDXPyVMJSg==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core] [PATCH 2/2] Update Isar revision
Date: Thu, 11 Jun 2026 02:57:46 +0530
Message-Id: <20260610212746.22275-2-srinuvasan.a@siemens.com>
In-Reply-To: <20260610212746.22275-1-srinuvasan.a@siemens.com>
References: <20260610212746.22275-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Jun 2026 14:57:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23134

From: srinuvasan <srinuvasan.a@siemens.com>

This revision introduces Rust recipe support, various
testsuite improvements, installer-related fixes, and
adds support for the Debian Forky release.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 4d47ea9..38d1d62 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 22ee5352eab6c38ac395da60895d09bacfe7b201
+    commit: 8893ec3ac0e7d64951da008404df0cbda9aece37
     layers:
       meta:
 
-- 
2.39.5


