Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56939CD3427
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 14:43:01 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41207.1777992174305227660
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 07:42:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=LUCLMQed;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20260505144251bf80d372d4000207e6-d523qi@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260505144251bf80d372d4000207e6
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 16:42:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=JJCYERavljG1Oj4ypRUZbOHMq02fw8kdlZede7pzmE0=;
 b=LUCLMQed/dga2vVg/NUwkIBPYM9O6rW9xFBnNKtEFbaPhIeD8StrStUksf6AEO9ec8ApgF
 Ntx1Yz74vcDMeWagn0N56HYyD1ceDhs/wZ76Im70JaUMROpVwmcuB33g0UFEa1jsMM2x+Qt1
 vRvGZyt2fzqvt7IKkPZh7QpsfSSYdc6NKxiPSQfQycUOhHMSWfT0KfXC4R6sn5msKdMjcVh3
 yErbd+r2wmUAWAGOR1vjJQL+4jyJKxl+c5spy4Leg5Lqf4Ec07SXAto/09XCF2D9U30e1fdJ
 UbIsA3C0hlqtlzqpkFM+MoG1J+cTw9OXhEpQy+ZG3xAFaHC/flWdrgnA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] scripts/submit_lava.sh: Add an timeout of 10 seconds to the SQUAD call
Date: Tue,  5 May 2026 16:41:47 +0200
Message-ID: <20260505144249.1325545-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 14:43:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22884

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This should avoid test which wait for ~1h until the SQUAD server
answers, e.g. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/14202652537#L199.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/submit_lava.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 9645455..958a4e9 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -258,7 +258,7 @@ submit_squad_watch_job(){
 
 	local ENV="${SQUAD_PROJECT}_${TARGET}"
 	local squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${SQUAD_PROJECT}/${COMMIT_REF}/${ENV}"
-	ret=$(curl -s \
+	ret=$(curl --max-time 10 --silent \
 		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
 		--form backend="$SQUAD_LAVA_BACKEND" \
 		--form testjob_id="$1" \
-- 
2.53.0


