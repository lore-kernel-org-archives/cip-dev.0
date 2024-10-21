Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F554D17126
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 18:54:59 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.397.1729536892254869766
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 11:54:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=U1DfVDuX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1326448-2024102118544811cdb12775e89f37b4-t9al5j@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024102118544811cdb12775e89f37b4
        for <cip-dev@lists.cip-project.org>;
        Mon, 21 Oct 2024 20:54:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lKjm4VkpG9pMK0XIi2nIc2BLmdceMlEP9dwYG7hZSRg=;
 b=U1DfVDuX3GkQSYWgbHKOWueeGGErKzLI2enPz2W50Djq+uUXqZ+Y2YrLiozIc1fQWUCsko
 kqV7baCeIWA1amvEMBfKgUmHnScUbZ8RL9QT0n/hF4GKQMq412/kbcYH7W7nggTPxbAIlpLq
 oHtettZu3F/0JY19rjpoJoersTOqOu3chA+TqqjN2LYTlcYF3gyFavyOxQdLY5egB/6Xzhzq
 /sMixJTHtb8v9owv3GCtPoXHFCE+vfoDMoJKmVii8b0zZVf7tKQ5B5UmPWCl8AoZgad9X87N
 i6+UPr4yhvMRClNKbMZU5EQnIDl3Cyx46PSq2VkpFjatzRFM6nrE3XfA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/2]  Fixing dependency of package expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building with disk encryption enabled.
Date: Mon, 21 Oct 2024 20:53:57 +0200
Message-ID: <20241021185359.927395-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 18:54:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17059

From: Alexander Heinisch <alexander.heinisch@siemens.com>

To fix the dependencies between `expand-on-first-boot` and the `initramfs-crypt-hook`
we introduced a new variable `ADDITIONAL_DISK_ENCRYPTION_PACKAGES` to extend the 
dependencies of package expand-on-first-boot_%.bb. 

See: https://groups.google.com/g/isar-users/c/0mc0AGyP3yY

The patch got applied to next on the upstream repo and the isar-cip-core next branch already contains that fix (https://github.com/ilbers/isar/commit/8b30a4f86cb3ea3369bff3884141872c3a7d9979).

This patch series adds definitions for `ADDITIONAL_DISK_ENCRYPTION_PACKAGES` and reuses it in the crypt hook.

This patch series got tested on bookworm based builds.
Unfortunately, for disks encrypted using clevis (bullseye and buster), I'm afraid, there won't be an improvement!

Alexander Heinisch (2):
  Fixing dependency of package expand-on-first-boot on cryptsetup and
    tss2 (tpm2) libraries when building with disk encryption enabled.
    (for bookworm)
  Reuse var ADDITIONAL_DISK_ENCRYPTION_PACKAGES in package
    initramfs-crypt-hook.

 conf/distro/cip-core-common.inc                    | 13 +++++++++++++
 .../initramfs-crypt-hook_0.2.bb                    | 14 ++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.43.0


