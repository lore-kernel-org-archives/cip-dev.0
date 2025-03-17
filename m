Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E06FC28B28
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 11:21:19 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.49927.1742210466881891814
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 04:21:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=TJBli3yu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202503171121035f4509210a2f0d881d-bz7gwi@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202503171121035f4509210a2f0d881d
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Mar 2025 12:21:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ggiB7uj5ZRf/AxyydxoPYsSlO38g6pSGYeGgmDFrfeA=;
 b=TJBli3yuAmIno4zVMUHlP/tViAK4h6GbVA0f5wq2T4mkdzLh7QEMx1khT8WK9Y9VCYIowM
 jzDs/5WziN/3hcNHghNz0Yf9k0XCp/BkOY0TwroA1uIc5Zai2Y6YDVF7ulYLGW//XzeQl2FZ
 8ywTXA5XxLH1IaSA7SdwRjVMTIA+PQB3qSWYSiL9VYrrsovMIQQCkvQC1gDUGVKhcL0x/Ly8
 K+R0WZoJOYje/xS0beDQMjjibeByp2C21BRnIswCKqXuzakkEXiZd6boOpNKDpmjSKQImJLj
 TjXKqa8OXJRqRrplJygLthXmaP1uagTYfc9z55FeSIJ+C6iP1r76CA3A==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] Add documentation to provide project specific signing methods
Date: Mon, 17 Mar 2025 12:14:33 +0100
Message-ID: <20250317112102.609922-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 11:21:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18229

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This documents the preferred way to replace the signing scripts
provided by cip-core with project specific variants.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

As we had the discussion how to unify our signing scripts this document
provides a overview of the current state of artifact signing in
isar-cip-core.

It is currently a separate document to have all the information for easy
access in one place. I am open to split it up and add the specific parts
to doc/README.secureboot.md and doc/README.swupdate.md.

If I missed something please let me know

Quirin

 doc/README.certificates.md | 93 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 doc/README.certificates.md

diff --git a/doc/README.certificates.md b/doc/README.certificates.md
new file mode 100644
index 0000000..7283cf7
--- /dev/null
+++ b/doc/README.certificates.md
@@ -0,0 +1,93 @@
+# Certificate handling in isar-cip-core
+
+This document describes how to replace the certificates or certificate handlers
+in isar-cip-core.
+
+In isar-cip-core provides the infrastructure to sign:
+ - efi binaries
+   - efibootguard binary
+   - unified kernel image
+ - update binary for SWUPDATE
+
+isar-cip-core uses the Debian snakeoil keys as to provide an example and during
+testing.
+
+
+## Signing an update binary(*.swu)
+
+An swu contains an signed sw-description file with the name sw-description.sig. This file is
+created during the swu image build process by calling a script call `/usr/bin/sign-swu`.
+The script is called by class classes/swupdate.bbclass. The script has the following
+call signature:
+
+```
+sign-swu <unsigned efi binary> <signed efi binary>
+```
+
+The default implementation of isar-cip-core is `recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb`.
+
+To validate a signed *.swu the image needs to contain the public part of the certificate which
+is stored in the recipe `recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb`
+
+## Signing an EFI binary
+
+EFI binaries are signed with the script `/usr/bin/sign_secure_image.sh`.
+The script is called by the wic plugins scripts/lib/wic/plugins/source/efibootguard-boot.py
+and scripts/lib/wic/plugins/source/efibootguard-efi.py. The script has the following
+call signature:
+```
+sign_secure_image <unsigned efi binary> <signed efi binary>
+```
+
+# Replace signing scripts
+
+The preferred way to add your own signer is to use
+the overload the necessary recipes with `PREFERRED_PROVIDER`.
+
+## SWUPDATE update binaries (*.swu)
+
+To use a project specific signing script, e.g. when using a HSM,
+add the following lines to the build configuration (kas file or in the
+conf directory).
+
+```
+PREFERRED_PROVIDER_swupdate-signer = "<swu signing package>"
+```
+
+The project specific public certifcate can be replaced by
+setting:
+```
+PREFERRED_PROVIDER_swupdate-certificates = "<swu certificate>"
+```
+
+### Content of the swu signing package
+
+The efi siging package needs to provide an script at the
+location  `/usr/bin/sign-swu` with the call signature:
+
+```
+sign-swu <unsigned file name> <signature file name>
+```
+
+## efi binaries
+
+To use a project specific own signing script, e.g. when using a HSM,
+add the following lines to the build configuration (kas file or in the
+conf directory).
+
+```
+PREFERRED_PROVIDER_ebg-secure-boot-signer = "<efi signing package>"
+```
+
+Alternativly the an own file name can be used by modifing the signwith parameter
+of the boot partitions and bootloader partition as described in [README.secureboot.md](./doc/README.secureboot.md#wic)
+
+### Content of the efi signing package
+
+The efi siging package needs to provide an script at the
+location  `/usr/bin/sign_secure_image.sh` with the call signature:
+
+```
+sign_secure_image <unsigned efi binary> <signed efi binary>
+```
+
-- 
2.47.0


