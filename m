Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C13C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 12:42:25 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.10738.1742301743126798379
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 05:42:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=EUFG0qzo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20250318124220f8f3edf9e1d318c197-ihgfsx@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250318124220f8f3edf9e1d318c197
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Mar 2025 13:42:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=bXIW4evSm/2tncBUJcq2Ah3l6Kw4x1qtlNVI4UXLKP4=;
 b=EUFG0qzoDJI4Yh49lBKiDqQRBo4aly3wUJAAbkYh8M9V79GhL7c38RP6zpgmdHJ6o1lvqA
 TYWwNZPVfnG9eXlV6qjTHSF2pkjoZcILwgeuLlA9gtpq6j2Jn56dtym2eoXWB3mbCuzxD/0X
 OfUN7HxlfUR52K3sXT8KltZPuhDdyVXB/PL9LLIDWlww43AtHeiU6I98eATIaeAre4QHhf3a
 cESuoMEQbZlA5majAgRJ8eV3iL2CCe+u7kTcOMYI671j27lPbV0o2lmzNVg1J2weqPDOJ8mU
 1GBqLi7E5mFLqTocWXZZCYeNwhXqF5K0Iy1ICCL7IAAmc4S36Lpi+4gw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2] Add documentation to provide project specific signing methods
Date: Tue, 18 Mar 2025 13:40:34 +0100
Message-ID: <20250318124218.2193306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 12:42:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18239

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This documents the preferred way to replace the signing scripts
provided by isar-cip-core with project specific variants.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - fix typos
 - rename to README.signing.md
 - Add sentence for the default implementation of sign_secure_image.sh
   and the used certificates.
 - Add sentence about certificate providers.

As we had the discussion how to unify our signing scripts this document
provides a overview of the current state of artifact signing in
isar-cip-core.

It is currently a separate document to have all the information for easy
access in one place. I am open to split it up and add the specific parts
to doc/README.secureboot.md and doc/README.swupdate.md.

If I missed something please let me know

Quirin
 doc/README.signing.md | 91 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 doc/README.signing.md

diff --git a/doc/README.signing.md b/doc/README.signing.md
new file mode 100644
index 0000000..327d981
--- /dev/null
+++ b/doc/README.signing.md
@@ -0,0 +1,91 @@
+# Handling of signing processes in isar-cip-core
+
+This document describes how to replace the signing scripts
+in isar-cip-core.
+
+In isar-cip-core provides the infrastructure to sign:
+ - EFI binaries
+   - efibootguard binary
+   - unified kernel image
+ - update binary for SWUpdate
+
+isar-cip-core uses the Debian snake-oil keys as to provide an example and during
+testing.
+
+
+## Signing an update binary(*.swu)
+
+A swu contains the signature of the `sw-description` file with the name `sw-description.sig`.
+This `sw-description.sig` file is created during the swu image build process by calling
+a script call `/usr/bin/sign-swu`. The script is called by class classes/swupdate.bbclass.
+The script has the following call signature:
+
+`sign-swu <unsigned file name> <signature file name>`
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
+
+```
+sign_secure_image <unsigned efi binary> <signed efi binary>
+```
+
+The default implementation of isar-cip-core is `recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb`.
+The certificates used by that script are provided by the package
+`recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb`.
+
+# Replace signing scripts
+
+The preferred way to add your own signer is to use
+the overload the necessary recipes with `PREFERRED_PROVIDER`.
+
+## SWUpdate update binaries (*.swu)
+
+To use a project specific signing script, e.g. when using a HSM,
+add the following lines to the build configuration (kas file or in the
+conf directory).
+
+`PREFERRED_PROVIDER_swupdate-signer = "<swu signing package>"`
+
+The project specific public certificate can be replaced by
+setting:
+`PREFERRED_PROVIDER_swupdate-certificates = "<swu certificate>"`
+
+### Content of the swu signing package
+
+The swu signing package needs to provide an script at the
+location `/usr/bin/sign-swu` with the call signature:
+
+`sign-swu <unsigned file name> <signature file name>`
+
+The package can provide additional files necessary for the signing process
+or a separate package can be used.
+
+## EFI binaries
+
+To use a project specific own signing script, e.g. by using an HSM,
+add the following lines to the build configuration (kas file or in the
+`conf` directory).
+
+`PREFERRED_PROVIDER_ebg-secure-boot-signer = "<efi signing package>"`
+
+Alternatively an own file name can be used by modifying the signwith parameter
+of the boot partitions and bootloader partition as described in [README.secureboot.md](./doc/README.secureboot.md#wic)
+
+### Content of the efi signing package
+
+The efi signing package needs to provide an script at the
+location `/usr/bin/sign_secure_image.sh` with the call signature:
+
+`sign_secure_image <unsigned efi binary> <signed efi binary>`
+
+The package can provide additional files necessary for the signing process
+or a separate package can be used.
-- 
2.47.0


