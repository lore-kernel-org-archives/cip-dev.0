Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B87C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 07:19:57 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web11.124601.1680679188374805712
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 00:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="1657675"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 04 Apr 2023 23:19:47 -0800
IronPort-SDR: qyWmk98yAd2rFZ6InSo5ux++gjrmhBT6F4BPQnChPiC1pDd8KozGBfQ4pzUuy75YKG89TrFE30
 wAe/XhIJKIln4gqZJwjtriqzclopBJmOYczCd3c/RZJf6pd8uTYTwn4m7Ioej5U9E94AI1F//6
 1dQhXk+Dm2abnGj4JZtc5Ox/KOFUlYRfz/tAb1879IX7HKfNmedaHXaV3aF3fNR6NdZjKTtnCi
 8C3XXU4JzLa7sbKOwCl+fpE/14VbJu1tS4DVnHyBRUY8kY7c08pK6l9YViX4CMGIKwO1oASls+
 81c=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core][PATCH] scripts/deploy-cip-core.sh: fix style issues
Date: Wed, 5 Apr 2023 12:49:27 +0530
Message-ID: <20230405071927.600015-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 07:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11175

From: Srinuvasan A <srinuvasan_a@mentor.com>

Align same coding style with other scripts.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 scripts/deploy-cip-core.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index ab98468..b185a84 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -17,8 +17,8 @@ DTB=$4
 REF=$5
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
-if [ "${EXTENSION}" != "none" ] ; then
-	if [ "${EXTENSION}" = "security" ] ; then
+if [ "${EXTENSION}" != "none" ]; then
+	if [ "${EXTENSION}" = "security" ]; then
 		BASE_FILENAME=cip-core-image-$EXTENSION-cip-core-$RELEASE-$TARGET
 	else
 		BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
@@ -28,7 +28,7 @@ fi
 BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
 S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 
-if [ -f $BASE_PATH.wic ] ; then
+if [ -f $BASE_PATH.wic ]; then
 	echo "Compressing $BASE_FILENAME.wic..."
 	xz -9 -k -T0 $BASE_PATH.wic
 
-- 
2.34.1


