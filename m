Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B68DC433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 10:08:20 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web12.10623.1654596491769100680
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=Jo1FHFja;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-51332-202206071008092d2e8071a551d9df6e-em2qyd@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202206071008092d2e8071a551d9df6e
        for <cip-dev@lists.cip-project.org>;
        Tue, 07 Jun 2022 12:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y6QfgOT1/yP4Ri9wCkZMHVjJ18ULvfxJD+R+ktml88k=;
 b=Jo1FHFjaXP7wy5GCdRdnE97M1kP9RZ6GXsORV4hMmqbOvuA8w/IsuN4MAdgQ+SX+WejHjK
 j57Wn68J1QZ61V2or5JZpJ9Dyd/w6ohsR8LN5zJ9golrjs+BkI51sVm0ruEjmZb8mVZgF70O
 9pDyd494vh/M7H+jARwqPHfsZTolI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 4/4] scripts/deploy-cip-core: Adapt
 to new image names
Date: Tue,  7 Jun 2022 12:08:06 +0200
Message-Id: <20220607100806.133889-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 10:08:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8506

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


