Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CFC3ABA2
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 12:55:24 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.7776.1726491322395483798
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 05:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=jVB926LN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202409161255193c550b504ac9899e7a-7n8mfj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202409161255193c550b504ac9899e7a
        for <cip-dev@lists.cip-project.org>;
        Mon, 16 Sep 2024 14:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tx07v4cInwgYmUJV02sK0TXWqX28jeuekqQ53scv5OU=;
 b=jVB926LNsrxnQFnkY17/r3MHEtRCVObLqrW3lrQhfT+9L7vXSxlrANHI6m/oGnacIVPqSQ
 o7mEySZi7CDQECPjgKtHXRMS6FcNR/yEPAnYG96iIFV+i2cBgcVplsBIy8reROWswmTjrdl3
 kRotnOFRak5UFiVmTvUSCTNsXVW0eLWW1sjv1xJqFVhqWqbWoh72jSEolDXXM0sah5hXXABV
 w7hQaYacEwgZXvzQLvBJNCpCERKsMJh+lS8e7CeE0UuiO5z+za2A4D+Lgs69QraqA7+CyVQd
 1KL32ng2j8KWwzt00OYhgPVUIxJzMYRsS/taiQu35G1lnCeLxfBsZEnQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 2/3] Add check for sign-swu executable
Date: Mon, 16 Sep 2024 14:54:54 +0200
Message-ID: <20240916125518.614224-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
References: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Sep 2024 12:55:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16904

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


