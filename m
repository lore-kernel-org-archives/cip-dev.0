Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C827ECA0EE0
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 10:14:20 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.97901.1755080050996232576
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 03:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Y7eceRWK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202508131014066c4b44b26cad566ce4-0izxob@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202508131014066c4b44b26cad566ce4
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Aug 2025 12:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=oNFcrfTCxmmqEtKPFC7eftAqib0GFMgtGK8tSf+ACcE=;
 b=Y7eceRWKEEWmRXHyVR/tyXBJGDBPYFrmp95cWdQSvKJr4BYCyr/KLJBR8KbvOZvubl3hB7
 q57W2QAYyD7GI2efEGoBtdzGB3Ni45DEgoCFbMP9Q+Ck5Zi9T5kTxDQF6VGQfa1RPS00hlsq
 x1K0yW45iU5QbMkyvwMNJibFIkinAir78YGl6II3JeA+8Q/CUj4pwzOZYsxLNlDMT9ErnypO
 TTDcxSHBlBDT+1bZIFvydiOkttDz3bC/Ys5vcLXTkqsp1wCN1vQTiKk1DStIyI2yhBvxj5ae
 SfXTLnXIACb7uDZ1Xh8rWSKQAjAIkNSW9AVHkAOufu2lSzmaJE+OCowg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [PATCH 1/3] README: Add links to the additional documentation
Date: Wed, 13 Aug 2025 12:13:00 +0200
Message-ID: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 10:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19724

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

We have some important documents in the doc folder.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index b2eb9d0..fa1c437 100644
--- a/README.md
+++ b/README.md
@@ -52,6 +52,14 @@ or via bmap-tools
 
     bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-buster-bbb.wic /dev/<medium-device>
 
+## Documentation
+
+The following topics are in a separate READMEs:
+ - [Secureboot](./doc/README.secureboot.md)
+ - [Update process with SWUpdate](./doc/README.swupdate.md)
+ - [Update and Secure boot signing](./doc/README.signing.md)
+ - [Encryption with TPM2](./doc/README.tpm2.encryption.md)
+ - [Release policy](./doc/README_version-release-policy.md)
 
 ## Community Resources
 
@@ -73,7 +81,7 @@ Continuous integration:
 
 Please see [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution process.
 
- 
+
 ## License
 
 Unless otherwise stated in the respective file, files in this layer are
-- 
2.50.1


