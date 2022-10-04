Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C966DC4167B
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.13162.1664902103537838386
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SFh4nhDM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20221004164821973439d2e681757306-lj7zmn@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20221004164821973439d2e681757306
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NKfgz0U7i645MEy7ODAVizDcnw+Jm7bJ/ulM1LQtea4=;
 b=SFh4nhDMy50pX/7Iu0rlgFlMbjjoXvAVat0q+l3LmIGrJri8MBJHPR2exmKnVSu4dmsg1v
 TSdE+zqpYQG0+FF8TrHyUadUq/GTgCBJBKioxuZA9ffEPtiE04viYvnmmZEoMkxxokb9yi6y
 pdSHRmH8LLz+iG28M9qBO7OP+wXvM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 09/12] deploy-cip-core: Use multi-threaded
 compression
Date: Tue,  4 Oct 2022 18:48:15 +0200
Message-Id: 
 <08ca2d8f2f589ff3cbea3be8352379ebbad660a1.1664902098.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9634

From: Jan Kiszka <jan.kiszka@siemens.com>

Should accelerate this step a bit.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/deploy-cip-core.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 1eb93d59..ab984686 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -30,7 +30,7 @@ S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 
 if [ -f $BASE_PATH.wic ] ; then
 	echo "Compressing $BASE_FILENAME.wic..."
-	xz -9 -k $BASE_PATH.wic
+	xz -9 -k -T0 $BASE_PATH.wic
 
 	echo "Uploading artifacts..."
 	aws s3 cp --no-progress --acl public-read $BASE_PATH.wic.xz ${S3_TARGET}
-- 
2.35.3


