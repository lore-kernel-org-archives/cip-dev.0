Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314EBCA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:52:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.35378.1756979555297029623
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FPmXCDHT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2025090409523316d19760c100020787-6urqn9@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025090409523316d19760c100020787
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Sep 2025 11:52:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZrILUv7mI7al/cU3yqMV/64JLrpUgqgxyVYyYjL2dBM=;
 b=FPmXCDHTsnIP1iFe4oGf3aFin+UXQElguRQvhJrItkPtiohmi2P6PjyXDLBtthlVXHei7a
 TXGyQh/jbNlIx0G5U+fAcJMsg51AU53u0b3mBxbmwjSdlU7w3BG2ruvZvs6ouaWk0LLe/iSc
 ahs4FsopfwrIuRl4kidQbaW1rzg8gHeXAWr0nFHTD6NQI+PA5luqIVCGg5TEEj6zU6zfPNx8
 NfEL1V3UYZfKIL6gbWtOvqH0az92RgubCmyKDCF5UdtC8e8s1MZzJzKwFkYxKM5FvhbbKc1m
 SSlKC1h9t5yXIGY9H+V0I5oq+8ZdwRuQKomQiYiwaes6egbwFt6pefxg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v5 7/7] Add Readme for factory-reset
Date: Thu,  4 Sep 2025 11:39:30 +0200
Message-ID: <20250904095231.2039819-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 09:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20010

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.factory-reset.md | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 doc/README.factory-reset.md

diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
new file mode 100644
index 0000000..f3e2560
--- /dev/null
+++ b/doc/README.factory-reset.md
@@ -0,0 +1,25 @@
+# Enable Factory-reset
+
+To enable the factory-reset functionality to following two elements need to be installed:
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
+The factory-reset works be writing, by executing `set-factory-reset.sh --create`, a marker into the persistent storage.
+The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
+The disk will try to detect the previous used filesystem and will format with the same type.
+
+### Disk encryption
+
+The factory reset will remove the previous used disk encryption keys from the TPM before formatting the selected hard drives.
+The removal of the TPM keys can be deactivated by setting the variable `INITRAMFS_FACTORY_RESET_CLEAR_TPM` to `0`.
+As the factory-reset is executed before the disks are unlocked in the initramfs the filesystem type must be provided with the
+variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`.
+
-- 
2.50.1


