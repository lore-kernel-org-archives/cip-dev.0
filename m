Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F217C3065B
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 06:28:08 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.1306.1719642479023995760
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 23:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=MRdu7ndg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202406290627553eb960a91289b57d56-2htoy_@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202406290627553eb960a91289b57d56
        for <cip-dev@lists.cip-project.org>;
        Sat, 29 Jun 2024 08:27:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Zw4wy+xZyKnLi1KFTVlgewzqMn5Jkg2I1O7E+sLHruk=;
 b=MRdu7ndgZ846jz8Im919Q85mGHDFNnhfMDPOVEUy7gbVcgMeOu+SgdDPhROmn0xzEQVMCP
 yfZ7IkEtY9KgrbhlXrdpNvwhDbmZ3+8ZcKjP4Vi9sEMpxgE78B+08w73uXfGZ5zFjo7zPPR4
 /Cf6RNu/U5fImeSOghpj+Z2aQvyRk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH 1/4] ci: submit_lava: Fix reporting of submission errors
Date: Sat, 29 Jun 2024 08:27:51 +0200
Message-ID: <7e065a7e100711d195149556390ad2eb276b57bb.1719642474.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1719642474.git.jan.kiszka@siemens.com>
References: <cover.1719642474.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 29 Jun 2024 06:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16349

From: Jan Kiszka <jan.kiszka@siemens.com>

Errors are collected in the global ERROR variable. Lower-case error is
just a local variable in check_status.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 4b1b6711..2464c291 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -146,7 +146,7 @@ submit_job() {
 		echo "Submitting $1 to LAVA master..."
 		# Catch error that occurs if invalid yaml file is submitted
 		# shellcheck disable=2086
-		ret=$(lavacli $LAVACLI_ARGS jobs submit "$1") || error=true
+		ret=$(lavacli $LAVACLI_ARGS jobs submit "$1") || ERROR=true
 
 		if [[ $ret != [0-9]* ]]
 		then
-- 
2.43.0


