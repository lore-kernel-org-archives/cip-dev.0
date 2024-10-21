Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A031DD17127
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 18:54:59 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.397.1729536892254869766
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 11:54:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=f53yWo0s;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1326448-202410211854550dbc8e68048b48f61c-sho9v9@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202410211854550dbc8e68048b48f61c
        for <cip-dev@lists.cip-project.org>;
        Mon, 21 Oct 2024 20:54:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=U3ALJdvbIH3LmrQLPZjfCYwjhFvUOiAdwyqkwn3jxvI=;
 b=f53yWo0s+A3roKvGerZExRyvqW9MPnvdE7Z7Es5HzmSrKl0Alu8p+plQvbacIRumYtCP3N
 QiCJftZRMD2hz1Z8NxUh21WW9F+LqDpt1jiNhK6+36rAyhRKOE40g34KPNm2aSlddAe0Q9JO
 YxC+mA3CDDYd3o+6EltI79YL9MBYY84r8ytU3a5NQW6NAw3+pApexyllKSEWJcJ/13FYgbCe
 MlwGUem2yUXgUctqy159rVoSi/5LsXpf0YxnGsH7J5+zQ5qU9tiF/7p1qyGakT+jPidskeXe
 MLCdpka09I3q+yreWL0eDQYOc0h2VuMlVUU2jFBmiHMxlFJ3o7Q/G0Og==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building with disk encryption enabled. (for bookworm)
Date: Mon, 21 Oct 2024 20:53:58 +0200
Message-ID: <20241021185359.927395-2-alexander.heinisch@siemens.com>
In-Reply-To: <20241021185359.927395-1-alexander.heinisch@siemens.com>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 18:54:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17060

From: Alexander Heinisch <alexander.heinisch@siemens.com>

To fix dependencies of packages (in this specific case expand-on-first-boot in upstream isar)
we specified additional package dependencies used for disk encryption.
When building with disk encryption enabled (kas/opt/encrypt-*.yml) the initramfs encrypts
the specified disks if it detects unencrypted disks.
In case of a fresh installation this happens during first boot of the device.
Unfortunately, expand-on-first-boot (kas/opt/expand-on-first-boot.yml) is executed
after the initramfs already encrypted the data partition (in case of *-efibootguard-*.wks.in /var).

Checking if the disk to expand is encrypted got already handled by
https://github.com/ilbers/isar/commit/c44c088cd224e44a401410c860bd625f28950ac3
but dependencies are not automatically set for the package.
Since expand-on-first-boot is hosted in isar and disk encryption features are enabled with
encrypt-partitions override in isar-cip-core, we extended the recipe in isar
(see: https://github.com/ilbers/isar/commit/8b30a4f86cb3ea3369bff3884141872c3a7d9979) to
enable downstream to set additional dependencies accordingly.

While the dependency for cryptsetup is obvious, the other dependencies are not!
Here is why:

- bookworm (systemd as cryptbackend):

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
  libtss2-esys.so.0 -> in package libtss2-esys-3.0.2-0
  libtss2-rc.so.0 -> in package libtss2-rc0
  libtss2-mu.so.0 -> in package libtss2-mu0

- bullseye, buster (clevis as cryptbackend)
  Since we are using clevis as cryptbackend the luks header resolves to "clevis" instead of "systemd-tpm2"
  Thus, cryptsetup resolves the library to be used to libcryptsetup-token-clevis.

  Unfortunately, I could not find such library anywhere! - Therefore, expand on first boot and similar,
  still won't work for current disk encryption implementations for buster and bullseye.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 conf/distro/cip-core-common.inc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 4bd4b84..7006713 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -23,3 +23,16 @@ PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
 
 PREFERRED_VERSION_linux-cip-rt-native ?= "${PREFERRED_VERSION_linux-cip-rt}"
 PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip-rt}"
+
+ADDITIONAL_DISK_ENCRYPTION_PACKAGES ?= ""
+ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions ?= "\
+    cryptsetup, \
+    libtss2-esys-3.0.2-0, \
+    libtss2-rc0, \
+    libtss2-mu0 \
+    "
+
+ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions:buster ?= "\
+    cryptsetup, \
+    libtss2-esys0 \
+    "
-- 
2.43.0


