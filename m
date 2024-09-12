Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC31EEB58A
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 10:07:21 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.44698.1726135633814819386
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 03:07:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=dsWMAY0v;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202409121007118d36ceed428781d2a3-oacfkg@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202409121007118d36ceed428781d2a3
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Sep 2024 12:07:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tx07v4cInwgYmUJV02sK0TXWqX28jeuekqQ53scv5OU=;
 b=dsWMAY0vAs92zksMCwe2wBUdfIW8cDqDSlyBZ+8n6ao4bTJhgQUMItkcZ9SS5lonxN3mIB
 4i9oNS+zVsHrXyWNDIdgn9uV44MzwVL6M9Z/De95oIpJi6SxMnDbwVLcSODYQ0rYIfm9tuPA
 gAEmNYnB+3yz9sx2M/K5OUhCn/rqKG8fqxzqJaA02hOV+LZz/6T/dn9RxLtRBov+TpJIV4m+
 LKEf+NeUFsi6wNJXFg2YoPgJtj709814V9wwXDeMeZw3pa5HI6fUU540dFqS6ZjZvOS/xJJH
 +6ay1SySq/6M60VQl0pw0AKV5kX1XIYFDTmI3rmx0iMHZ9olCgKIHYsg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/3] Add check for sign-swu executable
Date: Thu, 12 Sep 2024 12:06:41 +0200
Message-ID: <20240912100710.3183806-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
References: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 10:07:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16893

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This ensure a clear error message in case of missing packages.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 06418e5..642fd79 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -233,6 +233,10 @@ IMAGE_CMD:swu() {
             cpio_files="${SWU_DESCRIPTION_FILE}"
 
             if [ -n "$sign" ]; then
+                if [ ! -x /usr/bin/sign-swu ]; then
+                    echo "Could not find the executable '/usr/bin/sign-swu'" 1>&2
+                    exit 1
+                fi
                 signature_file="${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"
                 if ! /usr/bin/sign-swu "${SWU_DESCRIPTION_FILE}" "$signature_file" > /dev/null 2>&1 || \
                         [ ! -f "$signature_file" ]; then
-- 
2.45.2


