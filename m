Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7BACAC5A7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 11:53:42 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.14950.1758628411444663352
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 04:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=s2XE4sxF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2025092311532996a25eb9080002070d-mnuhpg@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025092311532996a25eb9080002070d
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 13:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=QqRebwSjSXd6HX7XMDBETeZ6npAmlkFQ4YdxmTOy2kk=;
 b=s2XE4sxF43SuhWTp4io3OspJryEXSlpjgX0SBBHrvbgq2aTgFFju9wVmKElO5GLDEFV4tC
 VDSY/slezrQ5JUW+rAAa2tCQuybDuce80jYYh1VJ1dG7zUt6EOFQd7nDZB1jlV56HaaQuSmM
 1KRQP3tGSmAekOdULhhZl+zk8mhRTtavFR+Ws4kR1ErgcBh2QNhbnhpQoR5l4fMZCyZPqceC
 92FeawKeMxQORP+yLeQ3B/JGEdNkPxV8xo1mRharR9CRH/wJPbw4oUkF1Zn/IwKLxMvF2tXS
 aZ3DmtDNhK2UXz1myKv47R7N1egxe0Hsvt0RY3+NicsJkvAsh7hZHgpQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v7 6/7] Add README for factory-reset
Date: Tue, 23 Sep 2025 13:52:57 +0200
Message-ID: <20250923115319.335608-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
References: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 11:53:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20109

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md                   |  3 ++-
 doc/README.factory-reset.md | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 doc/README.factory-reset.md

diff --git a/README.md b/README.md
index fa1c437..435d037 100644
--- a/README.md
+++ b/README.md
@@ -54,11 +54,12 @@ or via bmap-tools
 
 ## Documentation
 
-The following topics are in a separate READMEs:
+The following topics are in separate READMEs:
  - [Secureboot](./doc/README.secureboot.md)
  - [Update process with SWUpdate](./doc/README.swupdate.md)
  - [Update and Secure boot signing](./doc/README.signing.md)
  - [Encryption with TPM2](./doc/README.tpm2.encryption.md)
+ - [Factory-reset](./doc/README.factory-reset.md)
  - [Release policy](./doc/README_version-release-policy.md)
 
 ## Community Resources
diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
new file mode 100644
index 0000000..729912b
--- /dev/null
+++ b/doc/README.factory-reset.md
@@ -0,0 +1,29 @@
+# Enable Factory-reset
+
+To enable the factory-reset functionality the following two elements need to be installed:
+ - initramfs-factory-reset-hook which executes the factory-reset
+  ```
+  INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
+  ```
+- factory-reset-helper which provides the helper scripts to set the factory-reset marker
+  ```
+  IMAGE_INSTALL += "factory-reset-helper"
+  ```
+
+## Technical details
+
+The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).
+The marker on disk is intended for devices which do not provide the facilities to set EFI variables.
+The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
+The initramfs-hook will try to detect the previous used file system and will format the partition with the detected type.
+
+### Disk encryption
+[clevis](https://github.com/latchset/clevis/blob/2ad7027b7182b8f46404f8ec0735a83738f7ca7f/src/pins/tpm2/clevis-encrypt-tpm2#L192C8-L192C26)
+and [systemd](https://github.com/systemd/systemd/blob/114ad16c4dcac136fb7646866f8a95ee5631ee51/src/shared/tpm2-util.c#L5281)
+use the primary key of TPM. To ensure that the key is not reused the factory-reset deletes the primary key from the TPM
+before formatting the selected hard drives with a new LUKS container.
+
+The removal of the TPM keys can be deactivated by setting the variable `INITRAMFS_FACTORY_RESET_CLEAR_TPM` to `0`.
+As the factory-reset is executed before the disks are unlocked in the initramfs, the file system type must be provided with the
+variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
+marker.
-- 
2.50.1


