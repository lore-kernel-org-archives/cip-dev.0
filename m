Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA38D1170C
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:39 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4097.1764667289522317525
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=IEluNOfI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-202512020921219a8a0970890002072f-1uxgql@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202512020921219a8a0970890002072f
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=qL234tnSyZS6YYYUR9uK2AwroqjOaQi0KhH3K/tynpc=;
 b=IEluNOfIV/sY76vwq8rSvzelqgPlvq6rpak5quaefePJ1iIEcXcm+9TDcn2C4Xy2o9iwBV
 2YIlfjI7u0X+3FqUaFSXl3N5r2MRIDl33r8PeQEWH85QLoQY9VSJR3CdBKtiTKKYuUMi2YoI
 Ob2JCpwv94UqOuFC30oGAtL/ZZufQp5z3eSfnaI1i6vcCYMVRnJvtL2Ya2LIYTjwOLy26ijR
 A/kBYXrLSEHvZgon9DUcLbzq0qZkeoyYBKcfMJsmrnsLDdeidfKxvG+9O61/4rCq9Rp0WHp5
 SXgu4P4TFOSi7CXX6ruLlm9MPoz0nH76zGf+2Dq082qXRQ3Uijscyt2A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 07/14] ci: Clean up no-kernel deployment
Date: Tue,  2 Dec 2025 10:21:12 +0100
Message-ID: <3065c2e020edc2e4383f52ca776d560286dcaa55.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20790

From: Jan Kiszka <jan.kiszka@siemens.com>

No-kernel only make sense for a tarball with a raw rootfs. Drop any
other, unused logic.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/deploy-cip-core.sh | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index e6a7dc7c..5b2615be 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -38,20 +38,11 @@ if [ -n "${RB_BUILD_NUM}" ]; then
 fi
 
 if [ "${NO_KERNEL}" = "enable" ]; then
-	__BASE_PATH=${BASE_PATH}
-	BASE_PATH="${BASE_PATH}-nokernel"
-
-	echo "Rename from ${BASE_FILENAME}.* to ${BASE_FILENAME}-nokernel.*"
-
-	if [ -f "${__BASE_PATH}.tar.gz" ]; then
-		mv "${__BASE_PATH}.tar.gz" "${BASE_PATH}.tar.gz"
-	fi
-	if [ -f "${__BASE_PATH}.swu" ]; then
-		mv "${__BASE_PATH}.swu" "${BASE_PATH}.swu"
-	fi
-	if [ -f "${__BASE_PATH}.wic" ]; then
-		mv "${__BASE_PATH}.wic" "${BASE_PATH}.wic"
+	if [ -f "${BASE_PATH}.tar.gz" ]; then
+		echo "Rename from ${BASE_FILENAME}.tar.gz to ${BASE_FILENAME}-nokernel.tar.gz"
+		mv "${BASE_PATH}.tar.gz" "${BASE_PATH}-nokernel.tar.gz"
 	fi
+	BASE_PATH="${BASE_PATH}-nokernel"
 fi
 
 if [ -f "${BASE_PATH}.wic" ]; then
-- 
2.51.0


