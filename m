Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CACBC3065A
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 06:28:08 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.1269.1719642478712463894
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 23:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=RNRyEf2g;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-202406290627556cb801f76cc09110f3-xjg2he@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202406290627556cb801f76cc09110f3
        for <cip-dev@lists.cip-project.org>;
        Sat, 29 Jun 2024 08:27:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jq/wsnUs3V6RTCKp+Z+5qb229bxOvjmIEn/PIsK7vcY=;
 b=RNRyEf2gImaGS9aE/+tBv0CmznqDsZhD++KSruNkkHkV8T+bCeBLTaypuvnAfD2Py1sOtp
 gk1f6dyh/UkMM8QxZXd9UjUEkeYeam9LRhMTrSY3tEzlPaeJTI//swM6LC0By4KeSG0vRgu3
 5YgBqBkesN1vaGcdxFSftImP0TD/c=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH 2/4] ci: submit_lava: Fix access to LAVA API
Date: Sat, 29 Jun 2024 08:27:52 +0200
Message-ID: <1249955f41818451dc5674d510f611fdc2c64fd7.1719642474.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16346

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to provide the token in order to retrieve job results.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 2464c291..48c5d3c1 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -9,7 +9,7 @@ set -e
 ################################################################################
 LAVA_TEMPLATES="tests/templates"
 LAVA_JOBS_URL="https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/scheduler/job"
-LAVA_API_URL="https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/api/v0.2"
+LAVA_API_URL="https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/api/v0.2"
 LAVACLI_ARGS="--uri https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/RPC2"
 SQUAD_GROUP="cip-core"
 SQUAD_WATCH_JOBS_URL="${CIP_SQUAD_URL}/api/watchjob"
-- 
2.43.0


