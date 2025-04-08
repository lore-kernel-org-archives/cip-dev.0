Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0852C36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 04:08:40 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.4893.1744140450443482775
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Apr 2025 12:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gokhan.cetin@siemens.com header.s=fm2 header.b=TV8/KkVT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1328731-20250408192726f46ff9ed5367ea6053-krt2sz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250408192726f46ff9ed5367ea6053
        for <cip-dev@lists.cip-project.org>;
        Tue, 08 Apr 2025 21:27:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gokhan.cetin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wHCOV7JS0MHcW2qYW6UunCY6JRrZ9bsdfF1aqXngSXE=;
 b=TV8/KkVTVfJiIMQ9H8rCfW8WOHZwyk3Je/X2InPSInVJsaE9f0vFPw8JiENFVkRl+2OQPP
 5smsNEiOGPXvQ6bF9ZbEwL5nUaTpqpwkDfR+gixvAef7ajB92andkQYu39IKu1sUTWcbtzSl
 8IOElUSmarqP+graiLbjjWwaWLa5WJljZIstVb1yrY2B6Sv9xne+N9kODwh8rzZm5S4U/lMc
 MlAbjw8fL3gLy9crHCwdxb60ZbrsmOQIYE1x+mYI47RoplxkpTf0v1R7V1A/ZMOO45MMj5Co
 lvrvAJLGYXtCWyRJi0kdBqzO4w5hqcrjAMxnNk16wLTwM/nHRIFHrUDQ==;
From: Gokhan Cetin <gokhan.cetin@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: gokhan.cetin@siemens.com,
	quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com
Subject: [isar-cip-core][PATCH] swupdate.bbclass: fix forgotten whitespace in assignment
Date: Tue,  8 Apr 2025 21:27:18 +0200
Message-Id: <20250408192718.1530180-1-gokhan.cetin@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328731:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Apr 2025 04:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18495

Fixes `file_size: command not found` error in do_image_swu.

Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 61e4fe1..b0b05d5 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -251,7 +251,7 @@ IMAGE_CMD:swu() {
             # check if swu_files are less than 4GBytes.
             # This avoids the limit of cpio
             for swu_file in $swu_files; do
-                file_size =$(stat -c %s "$swu_file")
+                file_size=$(stat -c %s "$swu_file")
                 if [ "$file_size" -ge 4294967295 ] ; then
                     echo "The size of '$swu_file': '$file_size' is greater" \
                           "than the limit of the swu format of 4294967295" \
-- 
2.39.2


