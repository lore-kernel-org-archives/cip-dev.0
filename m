Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2489C531FC
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 10:51:24 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16608.1784890281572780186
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 03:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=BQO+Vkhn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2026072410511873b06454d700020758-jgrieq@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026072410511873b06454d700020758
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 12:51:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=jC6kbSTR+9Ox3Sc5tT6bTWbehrGrZT6ZHvxE1GaczhA=;
 b=BQO+VkhnNGXMVwA71nzusw9LKIghuOO1NH8y+GehUph8QxEyA2sHdHRzeT32H+Y0mIGnAx
 6ETOuZk+SV20AWGNK5D0HnKhMln5UUwp7SvOytvoVYLJ7e80f5GzYjKAJvxMKOA/rUOnWrLK
 cwypJigzO5UF/22tIZdNzTO9IPQX2HzcEpVUeWQNQaUHFhvrTUyjiQLTTUA5qx5YkYijWZzi
 4w77yeO0IdVS437LWBmnNFTqPc/gcejBwaS8Zxga+9TORtoQhsZ1VZ+5eeY40qS4zy9HjkhG
 24dB60vbRc9Cv/FxxgnmazdF7J9AxSZTYQpEl1MjMG5UgWavsi+21bMQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 2/4] update Isar to contain rootless changes
Date: Fri, 24 Jul 2026 12:51:06 +0200
Message-ID: <20260724105116.3575045-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 10:51:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23731

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 6badc7d..cbccf63 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 3c645ee8dcd3d2161b93a3b2f9808fe1829850e7
+    commit: ea319eb835aea545f23266ba15358bad029a56a0
     layers:
       meta:
 
-- 
2.53.0


