Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D81DC433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 11:56:27 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.6322.1654257383605433043
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jun 2022 04:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=QxdB1Dv8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-51332-2022060311562012b0cfefd3dcc2e792-nysnku@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 2022060311562012b0cfefd3dcc2e792
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Jun 2022 13:56:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y6QfgOT1/yP4Ri9wCkZMHVjJ18ULvfxJD+R+ktml88k=;
 b=QxdB1Dv8SXPSQypI6F9URA7dKMPe1Zb6/0V47Y0tNmcF5jNWzi/x5WCDvaSpjYvaJrCgLw
 mK+o08arpiqhcinPo+nnhdMZR02RHyvC0tjBOrv8co28nxLV5GUcYtN67hGPqTmNAPU1lbpS
 YjX2qlaMUqwZWoIhuGQaZXWBeNqio=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 4/4] scripts/deploy-cip-core: Adapt to
 new image names
Date: Fri,  3 Jun 2022 13:56:18 +0200
Message-Id: <20220603115618.985568-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 11:56:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8487

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The identifier img was delete from the image name.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy-cip-core.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index cf8f45d..203ab1d 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -28,12 +28,12 @@ fi
 BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
 S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 
-if [ -f $BASE_PATH.wic.img ] ; then
-	echo "Compressing $BASE_FILENAME.wic.img..."
-	xz -9 -k $BASE_PATH.wic.img
+if [ -f $BASE_PATH.wic ] ; then
+	echo "Compressing $BASE_FILENAME.wic..."
+	xz -9 -k $BASE_PATH.wic
 
 	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read $BASE_PATH.wic.img.xz ${S3_TARGET}
+	aws s3 cp --no-progress --acl public-read $BASE_PATH.wic.xz ${S3_TARGET}
 fi
 
 if [ -f $BASE_PATH.tar.gz ]; then
-- 
2.35.1


