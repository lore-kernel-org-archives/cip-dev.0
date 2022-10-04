Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7004C43217
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web08.13101.1664902102812122600
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Gl8FUHt0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-20221004164820eed4f3204a1a40508d-cofgjf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20221004164820eed4f3204a1a40508d
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=KsEorT5UI6XaKUNexi/qrkqRfT45b7TjN2yJ2FskiI4=;
 b=Gl8FUHt01H0MoKYobEVZGSfn6f8x35RUfr0Jk+003E6nNZ9jJ2+iTO7OASPzf0dSMpVpg+
 6jCJs/bWBUpXOIs49nosYYmrflenWww9JV2MVe/64amyKyhrA+9dINpxYZcyum7dtvURe88r
 bFm3kkJzry0X4EOn9gAiYFck4SnKU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 06/12] kas: Drop defaults from
 bblayers_conf_header
Date: Tue,  4 Oct 2022 18:48:12 +0200
Message-Id: 
 <5c26edf44010157edd7f9ea62691a0950e87d88c.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9630

From: Jan Kiszka <jan.kiszka@siemens.com>

Already set by kas since revision 11.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 6b9d5a23..6efdce98 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -29,8 +29,6 @@ repos:
 bblayers_conf_header:
   standard: |
     LCONF_VERSION = "6"
-    BBPATH = "${TOPDIR}"
-    BBFILES ?= ""
 
 local_conf_header:
   standard: |
-- 
2.35.3


