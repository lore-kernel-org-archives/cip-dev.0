Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDBF3C9A7
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 15:56:34 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23607.1771948584010904329
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 07:56:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=E+Xf4RHi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202602241556218a7334c8cd0002071f-fkffrq@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202602241556218a7334c8cd0002071f
        for <cip-dev@lists.cip-project.org>;
        Tue, 24 Feb 2026 16:56:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=TQMat7SMCfmBgAUH/iaS59NVNqMswpjHuVNNvkjM2ZQ=;
 b=E+Xf4RHit6+0QatsXYVJzcbtfU0npkXfBkXlAZ4o/iUg/XGBFkzJ/c1nVK+G9ywMhml/XS
 NK3N7FktLRBRM8hkVXiugUVlCnfkLlZVFeOxxjDcVD2jAodHMACqLz+HRaD1VuIbXerALt2O
 SW2L+omxSIrJotc94h3/rzDbcDhgtrsZm09nMa4R79WTdQC/ZKqtoBFCdMnn88iALY+pRYAS
 vzkJ/oVQlWUWOmH9Q6Or3TiO/vIhWj7mtaJgXpFjRH6sQPuULC/iKm7zewT47fm8CbwYWytw
 2uKxqlbyoow6PDxGuLIMJwTMgH+UrYevmvynwtGQ6Ml9CCPY87UYHs7Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] Add bmap file to speed up mtda tests
Date: Tue, 24 Feb 2026 16:55:43 +0100
Message-ID: <20260224155620.1794845-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 15:56:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21924

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The mtda device can use the bmaptool to write the disk image under test.
This allows to skip writing empty parts of the partition and increase
the deployment speed.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy-cip-core.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 623c216..3ff6b70 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -62,6 +62,7 @@ if [ -f "${BASE_PATH}.wic" ]; then
 		echo "Compressing $BASE_FILENAME.wic..."
 		xz -9 -k -T0 "${BASE_PATH}.wic"
 		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.bmap" "${S3_TARGET}"
 
 		if [ -f "build/tmp/deploy/images/$TARGET/firmware.bin" ]; then
 			aws s3 cp --no-progress --acl public-read "build/tmp/deploy/images/$TARGET/firmware.bin" "${S3_TARGET}"
-- 
2.52.0


