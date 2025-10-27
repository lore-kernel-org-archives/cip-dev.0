Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2816CCF9EE
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:01 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.26590.1761549712395200915
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=jsbLiguv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20251027072149bbfdd714ec00020798-dzp0nc@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251027072149bbfdd714ec00020798
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=XgLAvZf7NRzUGqblHktImj08G6+/9UZ5rI4ZywT2LgQ=;
 b=jsbLiguvTSplJ5D7uAQGYh5pHyr3SCbaFj8BskDz6z7V6fvoRtGOAFlh+gTUBXw5JqqEWw
 RgIoQl3M8iDSyvu0s5zyqGsKQCBfq1FkWi49zHvnHrmHKKzitJz48hl6U5vSnDgkQhwWOUnp
 /hCRpLprMLpqQNi9G7ALpwgZuLRs+7r67YdPXSRfrA17KY3haNFoHDiGWEoQPaOoHr8Yupf7
 YVLzFCsrQPO1M7PBvXeOhiKAtEU4H+wfwQ7pluY4HXL30o130ABPIlBbwEztTZIdzPoWpHlT
 R0NpD065dvgk90/oIacUKVv75tVV6iqQIYxYE3X0v+r1T90AF2dWbt7w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 02/19] Update isar revision
Date: Mon, 27 Oct 2025 08:21:31 +0100
Message-ID: <799156e2b52a09cd5652c81136a84c8e2ea9caff.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20234

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed for the upcoming OP-TEE-based firmware integration.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index d76d6d94..19e634d7 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: d63a1cbae6f737aa843d00d8812547fe7b87104a
+    commit: fd711088bc7eb84fb040c0fad5059e79a765bc89
     layers:
       meta:
 
-- 
2.51.0


