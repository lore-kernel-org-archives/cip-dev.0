Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A907C531DC
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 16:31:18 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.537.1724430039181167398
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Aug 2024 09:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=IRthxNh+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1326448-202408231620369ed9c17927ae70b7d7-gau_yu@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202408231620369ed9c17927ae70b7d7
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 Aug 2024 18:20:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1cxmR+kSxqtyWHT2tbTDAydVxsgbUtVoF143DncbJi0=;
 b=IRthxNh+q2reY/6dRaMsNuiW9Few3QVccJOGI8cLpQhtlVhOo3RR6NdADLfnrcuf2EjVkK
 FHX52mXuqbHiMcfctzrr4ylqknnmtv7tzolK7V72eKee47zZwzcxm3rt7BiTSn3Omx4jt6o4
 Su9lZ4Z5B53kZoTu4Cpu9H9sYDZsqcgz1AkcPtJtQIO3r0nKpywDGSfccrXKNNLLikm/BPYN
 lcfMPFTcAdP7V3GNxLT65POUfgGFupBQ/KxOnV5t/foJgxNRwIIoXXzq0QC12g1o2QWUEH3D
 Jn7qYsQOFZ3tjDMaycd1m6y2TjiUKZgKOWOsfFrRQDUNOqLAtpJkEOuA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH] Fixing dependency of package expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building with disk encryption enabled.
Date: Fri, 23 Aug 2024 18:19:06 +0200
Message-ID: <20240823161906.1168642-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Aug 2024 16:31:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16809

From: Alexander Heinisch <alexander.heinisch@siemens.com>

When building with disk encryption enabled (kas/opt/encrypt-*.yml) the initramfs encrypts
the specified disks if it detects unencrypted disks.
In case of a fresh installation this happens during first boot of the device.
Unfortunately, expand-on-first-boot (kas/opt/expand-on-first-boot.yml) is executed
after the initramfs already encrypted the data partition (in case of *-efibootguard-*.wks.in /var).
Checking if the disk to expand is encrypted got already handled by https://github.com/ilbers/isar/commit/c44c088cd224e44a401410c860bd625f28950ac3
but dependencies are not automatically set for the package.
Since expand-on-first-boot is hosted in isar and
disk encryption features are enabled with encrypt-partitions override in isar-cip-core,
we extended (.bbappend) on said recipe by adding needed dependencies if this override is set.

While the dependency for cryptsetup is obvious, the other dependencies are not!
Here is why:

From cryptsetup 2.4.0 release notes:
"
  Cryptsetup 2.4 adds the possibility to implement token handlers
  in external libraries (possibly provided by other projects).
  ...
  As of cryptsetup 2.4.0 release systemd project already merged upstream
  native cryptsetup token handler for its systemd-tpm2 LUKS2 token
  released originally in systemd-v248. The token can be created using
  systemd-cryptenroll utility and devices may be manipulated either by
  systemd-cryptsetup cli or by cryptsetup for actions listed above.
"
("actions above" include `resize` - see https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/docs/v2.4.0-ReleaseNotes)
Proof: https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/lib/luks2/luks2_token.c#L170

For the disk encryption method we use a token `systemd-tpm2` is added to the luks header.
Thus, `cryptsetup resize` uses libcryptsetup-token-systemd-tpm2.so to handle this token
which comes with package `systemd`.

Following source gives the dependencies on libs: https://github.com/systemd/systemd/blob/a3f17a8f88f7332d0bef67a2d523c41f23f164b6/src/shared/tpm2-util.c#L114
libtss2-esys.so.0 -> in package libtss2-esys-3.0.2-0 (available for bullseye, bookworm)
libtss2-rc.so.0 -> in package libtss2-rc0 (available for bullseye, bookworm)
libtss2-mu.so.0 -> in package libtss2-mu0 (available for bullseye, bookworm)

(for buster it seems required libs are packaged in libtss2-esys0 - I did not verify that! - but,
 since they are used as alternatives in the initramfs-crypt-hook, I am pretty confident,
 nothing too bad will happen at this stage)

Note: For bullseye-backports and bookworm package systemd already suggests: libtss2-esys-3.0.2-0, libtss2-rc0 and libtss2-mu0
(For sid packages: libtss2-rc0t64 and libtss2-tcti-device0 are suggested.)

Thus, I decided to go with packages libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0 and libtss2-esys0 as a (legacy?) fallback for buster.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../expand-on-first-boot_%.bbappend              | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend

diff --git a/recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend b/recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend
new file mode 100644
index 0000000..6736fce
--- /dev/null
+++ b/recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DEBIAN_DEPENDS:append:encrypt-partitions = ", cryptsetup, \
+                                            libtss2-esys-3.0.2-0 | libtss2-esys0, \
+                                            libtss2-rc0 | libtss2-esys0, \
+                                            libtss2-mu0 | libtss2-esys0 \
+                                           "
\ No newline at end of file
-- 
2.43.0


