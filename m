Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82063ECE57E
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:23:23 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.50637.1725880993047816682
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ftutU1lT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024090911231012af5f9cd700fd8457-hjiv6x@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024090911231012af5f9cd700fd8457
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Sep 2024 13:23:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4O0pwurYfHkAfv9MlJ1f5/Q0BZHl2LaiJ4pBRaRLGBY=;
 b=ftutU1lTPuKH414HSsti6sQhrgm1Ggj2spSikP9SKWFKYbtVBgmaVH36AzPhOmBcP4JfbW
 P7Zk31s++/eyuluaa/oe4LVdMeyT2wsYL9f9WNnY54g5gEXBpQA3BNQvw/74jouQLA+MF6OP
 VV4ZJKnW+s+dbLOQwRyOrV+Za9s2GWL7vxQZGMYl/NpP7qbvUlpFfEw5Llvbswrq+qOj4u5k
 zhTMNaZdEuIp1TBSnu7Vi8+oF2ZayEA1hquPkKlIeDxdBpuXqAeC/6hrQMn0VzGrRH202IhH
 vdraFl541qXPxLIpWSDbdMCNGTe8/YUKTTZaSjWpVnQ3GWgbDMBzELow==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 2/3] Add check for sign-swu executable
Date: Mon,  9 Sep 2024 13:21:39 +0200
Message-ID: <20240909112309.1028531-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:23:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16870

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This es ensure a clear error message in case of missing packages.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 06418e5..f1af1ff 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -233,6 +233,10 @@ IMAGE_CMD:swu() {
             cpio_files="${SWU_DESCRIPTION_FILE}"
 
             if [ -n "$sign" ]; then
+                if [ -x /usr/bin/sign-swu ]; then
+                    echo "Could not find the executable '/usr/bin/sign-swu'" 1>&2
+                    exit 1
+                fi
                 signature_file="${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"
                 if ! /usr/bin/sign-swu "${SWU_DESCRIPTION_FILE}" "$signature_file" > /dev/null 2>&1 || \
                         [ ! -f "$signature_file" ]; then
-- 
2.45.2


