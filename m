Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FEBC02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 16:23:24 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.16464.1737735793414843852
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 08:23:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=bx6dQkNn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20250124162309c0cec00ef78ae4770b-ltkjef@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250124162309c0cec00ef78ae4770b
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 17:23:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=89P3ryuWY1MqCnHxCULPfoY/Tx9I3oMaaNE4UDDTGGI=;
 b=bx6dQkNn4w3O19SLH8Y4vThhlpffypDDW2qFC12+vvbanu/qQNSBnI7cjUWu9CNnU0Vrfs
 CfziCt3QW0YAd8iskCwkZhNI1qUdnHRrlmQTZfxzT4GSFx2htvOPcfYvqm5TFksfJYurXhCF
 w2n1Ig32KVh8u3cK/FqiyNeLSYTSFq3lQstBWXCqfRkxcAIhzBBwsjku5WXDPLPd2opGF/63
 95+LMBAtE/CZACnIt02/CYVnRlHKdaL3yzfLiI9IaKw3QhnPPLvzTVNYrg0vXjEBj6Vu+xwK
 B5g66bMIRdbM/M2sHEFUp0Ar0ROPiEcK+G0jw4JD87aYIQTP+FOB+haQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Add check if a swu file is greater than 4GB
Date: Fri, 24 Jan 2025 17:22:50 +0100
Message-ID: <20250124162308.250651-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 16:23:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17660

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

4GB is the size limit of a file in a cpio archive. cpio prints
the following message but returns zero in that case.

```
value file size 10 out of allowed range 0..4294967295
```

The sum of files in the archive can be greater than 4GB.

This fixes Issue #125.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 3243f67..05291ee 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -247,7 +247,17 @@ IMAGE_CMD:swu() {
                 fi
                 cpio_files="$cpio_files $signature_file"
             fi
-
+            # check if swu_files are less than 4GBytes.
+            # This avoids the limit of cpio
+            for swu_file in $swu_files; do
+                file_size =$(stat -c %s "$swu_file")
+                if [ "$file_size" -ge 4294967295 ] ; then
+                    echo "The size of '$swu_file': '$file_size' is greater" \
+                          "than the limit of the swu format of 4294967295" \
+                          "Bytes per file" 1>&2
+                    exit 1
+                fi
+            done
             # sw-description must be first file in *.swu
             for cpio_file in $cpio_files $swu_files; do
                 if [ -f "$cpio_file" ]; then
-- 
2.47.0


