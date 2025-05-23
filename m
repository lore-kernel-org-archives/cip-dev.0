Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA6C54ED0
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 14:48:01 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.49812.1748011672267367717
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 07:47:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=awqQxCyR;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20250523144748fabd774f8abe759f3b-fzgwvw@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250523144748fabd774f8abe759f3b
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 16:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HCWI88/aeB6+cDMg7KPpzI1oZ2xdBcpCWoVgookRSTA=;
 b=awqQxCyRi2aVym1x4RcaHD7Yk+kElvvKB9vpRg86m/iV4Dm7ofnaegWEaSt23F6UlOyQMP
 JvQU0AgBjVigaI5Biisgbay8SRHeG7LuywEkqZyd2v5o/J0Yqq78x4ulpJsXI9VlEWnj1Ld4
 WTJjlUOcwwLqFuiFxwOdNNhZM4aEHhe5q9OOjOU4u2e2PWMr8G0T8jOoNdhMN9XkhHWGq66Y
 kS0SlNoWHF4CzAdy4Ujpf4Wi+HRTlKv3SpYM8vdwDpJa1bL05S8UYEEpx0yVnXgFTsia7Unh
 F8Tf3e0bS+orX4lXG3XcXJy+wyZgzj8bYouYopwQQMy00vExzq0JE/Xg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Subject: [isar-cip-core][PATCH v2 4/5] scripts/update-linux-cip.sh: Address shellcheck findings
Date: Fri, 23 May 2025 16:47:46 +0200
Message-ID: <17f31310620f49ed9076e489e3204678189e1c6d.1748011667.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1748011667.git.jan.kiszka@siemens.com>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 14:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18947

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/update-linux-cip.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index 8e3647e4..6dead448 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -1,6 +1,6 @@
-#!/bin/sh
+#!/bin/bash
 REPO_ROOT=$(git rev-parse --show-toplevel)
-pushd ${REPO_ROOT}/recipes-kernel/linux >/dev/null
+pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
 
 for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 	rm -f sha256sums.asc
@@ -14,16 +14,16 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 	VERSION=${LAST_ENTRY/*linux-cip-/}
 	VERSION=${VERSION/.tar.xz/}
 	RECIPE_FILE=linux-cip_${VERSION}.bb
-	if [ ! -f ${RECIPE_FILE} ]; then
+	if [ ! -f "${RECIPE_FILE}" ]; then
 		echo "Updating recipe to ${VERSION}"
-		git mv linux-cip_${MAJOR_VERSION}.*.bb ${RECIPE_FILE}
+		git mv linux-cip_"${MAJOR_VERSION}".*.bb "${RECIPE_FILE}"
 		SHASUM=${LAST_ENTRY/ */}
-		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
-		git add ${RECIPE_FILE}
+		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'"${SHASUM}"'"'/ "${RECIPE_FILE}"
+		git add "${RECIPE_FILE}"
 		if [ "${MAJOR_VERSION}" == "6.12" ]; then
-			git rm linux-cip-rt_${MAJOR_VERSION}.*.bb
-			ln -s ${RECIPE_FILE} linux-cip-rt_${VERSION}.bb
-			git add linux-cip-rt_${VERSION}.bb
+			git rm linux-cip-rt_"${MAJOR_VERSION}".*.bb
+			ln -s "${RECIPE_FILE}" "linux-cip-rt_${VERSION}.bb"
+			git add "linux-cip-rt_${VERSION}.bb"
 		fi
 	fi
 
@@ -34,13 +34,13 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 		RECIPE_FILE=linux-cip-rt_${VERSION}.bb
 		if [ ! -f "${RECIPE_FILE}" ]; then
 			echo "Updating recipe to ${VERSION}"
-			git mv linux-cip-rt_${MAJOR_VERSION}.*.bb ${RECIPE_FILE}
+			git mv linux-cip-rt_"${MAJOR_VERSION}".*.bb "${RECIPE_FILE}"
 			SHASUM=${LAST_ENTRY/ */}
-			sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
-			git add ${RECIPE_FILE}
+			sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'"${SHASUM}"'"'/ "${RECIPE_FILE}"
+			git add "${RECIPE_FILE}"
 		fi
 	fi
 done
 
 rm -f sha256sums.asc
-popd >/dev/null
+popd >/dev/null || exit 1
-- 
2.43.0


