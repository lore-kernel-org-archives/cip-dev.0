Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E36CA0FFD
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 11:07:24 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.18178.1756379236735299020
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Aug 2025 04:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SZlArh5Z;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202508281107146a4a060ae90002074f-7fnmcf@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202508281107146a4a060ae90002074f
        for <cip-dev@lists.cip-project.org>;
        Thu, 28 Aug 2025 13:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aAh8lgB6VbZ+fcD/N7OUUT3zlSv8WossyPyfAu2V81s=;
 b=SZlArh5ZTOAPILud6xK3znjUNzVVuKyaAGC9MnNqw7gxkS5CpVvteUYqOybjyIEY3uoUZL
 kB/0wmllGm2iJ03PVK3uM+/Lle8PBHEgZ/FP3fdH7rzu4ci0baR9QuJ8MTmCAUD469S/vi/M
 rt10rcFqHymtWLkM6bgwK3j8y8QgyYaIiWNcUVPoN5wEfB+n5IOO9c2kvneUHNDrDd1zy05s
 +eRPmbVSuvhOeOnlgYwzdL6ZCwF99xeMYeb2WTvfWDyM44vh9ZZubUYuCPITVF+1Rzobpy88
 uJP7ftgxECzv2QLsyORlNBhxbi8MZYh90IENP25AZllOfJoYpbqqZtjw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 7/7] Add Readme for factory-reset
Date: Thu, 28 Aug 2025 13:06:54 +0200
Message-ID: <20250828110712.392641-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Aug 2025 11:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19984

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.factory-reset.md | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 doc/README.factory-reset.md

diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
new file mode 100644
index 0000000..1390190
--- /dev/null
+++ b/doc/README.factory-reset.md
@@ -0,0 +1,22 @@
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
+The factory-reset works be writing, by executing `set-factory-reset.sh --create`, a marker into the persistent storage. The initramfs reads this marker and formats the hard-drives provided by
+the variable `INITRAMFS_FACTORY_RESET_DEVICES`. The disk will try to detect the previous used file
+system and will format with the same type.
+
+### Disk encryption
+
+The factory reset will remove the previous used disk encryption keys from the TPM before formatting the selected hard drives. As the factory-reset is executed before the disks are unlocked in the initramfs the filesystem type must be provided with the
+variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`.
-- 
2.50.1


