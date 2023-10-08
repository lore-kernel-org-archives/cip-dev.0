Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F90E95A67
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 14:26:10 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.32151.1696735007271705088
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Oct 2023 20:16:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=VxGRq28w;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-72506-20231008031644497980d5c2c298f6f9-wcjsxx@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231008031644497980d5c2c298f6f9
        for <cip-dev@lists.cip-project.org>;
        Sun, 08 Oct 2023 05:16:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aThWi5GSoWzTJNHDXMNoJkRhRTPAWJuvwAKuxX86Tzs=;
 b=VxGRq28wGuPL4JSeboDRe9fyvuOfG/L6qjkNG5omRBY3NrehKntJwo9ngS5u2cFSTe5+wt
 kpzdyVBVGPtzrkfHjdR5Zf7YUMRFWu7TtNp+LfxBS7ajlquIc13Vy0eV8vtGoRyYZcBbhrSQ
 dBoEOHbdJfAiwfhQLYs8NryroXXKM=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 3/4] avoid use of sudo when creating squashfs
Date: Sun,  8 Oct 2023 11:15:28 +0800
Message-Id: <20231008031529.1338834-4-felix.moessbauer@siemens.com>
In-Reply-To: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 14:26:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13307

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/squashfs.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index bf72133..f57af7e 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -51,7 +51,7 @@ python __anonymous() {
 IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
 IMAGE_CMD:squashfs[vardepsexclude] += "SQUASHFS_CREATION_LIMITS"
 IMAGE_CMD:squashfs() {
-    ${SUDO_CHROOT} /bin/mksquashfs \
+    imager_run -p -d ${PP_WORK} -- /bin/mksquashfs \
         '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
         -noappend ${SQUASHFS_CREATION_LIMITS} ${SQUASHFS_CREATION_ARGS}
 }
-- 
2.39.2


