Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCC8C83F17
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.56251.1751879784137003235
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=lGJZeQI2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-2025070709162014b0e72dee87a5d935-p8ntg1@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2025070709162014b0e72dee87a5d935
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=suVE57xUpEDEzlTr5agKPbqIW7jgc1oZc/EuW5Jc1s8=;
 b=lGJZeQI21gdc7x5YCqIWDJP7gCQuWIYof459ZPL1m1IgAZk8nUMsjoKhURdGcLPxc8e3US
 YxZdk/p0t9fCimT1PocmFSkZmXSfbZ8m0oZzjpRnbt+buCsGqUkJBtDmWTB9Yw+INg5zp+17
 aXIC+s49CmyYmseTPbD1shVrVq0e732nNUQ3uzLpiYAYq+qyav4w8j1QHnh+U+VNJv7ooX4y
 qGtnuatVwSWCBS7mcPaDKVWT51zIs/EsSnLpdxrFHYIafQ4CmiLsMDn4e9QU3sMJLdcO/gLw
 +UXzErTnZYXDAs1xCB43D2JGi475+ZBbnMq7NOo17J7juJGeeXRVesRQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 0/8] initramfs-crypt-hook patch
Date: Mon,  7 Jul 2025 11:16:12 +0200
Message-ID: <cover.1751879779.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19377

As Claudius left denx, I took over this series and addressed remaining
issues.

Changes in v9:
- stub-out initial key persistence on buster (tpm2-tools 3.x)
- replace open-coded random key with pwgen
- Link to v9: https://lore.kernel.org/cip-dev/20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de/

Changes in v8:
- Rebased on next
- Added documentation about the power fail scenarios and the LUKS header
  example.
- Link to v7: https://lore.kernel.org/r/20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de

Changes in v7:
- readded tpm2_createpolicy for clevis
- Link to v6: https://lore.kernel.org/r/20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de

Changes in v6:
- luks formatting of format-if-empty will now be redone when if it is a
  luks partition without a TPM2 token, this makes it a bit more
  power-fail save
- Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de

Changes in v5:
- Switch to use TPM2 protected password instead of static initial
  password for encryption
- Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de

Changes in v4:
 - improve documentation and commit messages
 - reorder commits, to put re-encryption recovery up front
 - extract static temporary encryption key patch into its own
 - switch from lsblk to blkid

Changes in v3:
 - Rebase on current next
 - Extended 'noencrypt' documentation
 - support clevis tokens for re-encryption recovery

Changes in v2:
 - Added more descriptive commit message
 - Added more descriptive documentation about noencrypt option
 - Fixed typos in documentation
 - removed unnecessary setting of /conf/param.conf in initramfs-crypt-hook
 - added re-encryption recovery patch

Claudius Heine (4):
  initramfs-crypt-hook: store initial encryption key in TPM2
  initramfs-crypt-hook: add re-encryption recovery
  initramfs-crypt-hook: implement 'noencrypt' option
  initramfs-crypt-hook: add 'format-if-empty' feature

Jan Kiszka (4):
  initramfs-crypt-hook: Use pwgen instead of openssl for initial
    passphrase
  initramfs-crypt-hook: Drop redundant copy-execs for
    systemd-cryptenroll
  initramfs-crypt-hook: Only use resource-managed TPM instances
  initramfs-crypt-hook: Factor out tpm2_functions script

 doc/README.tpm2.encryption.md                 |  57 ++++++++--
 .../initramfs-crypt-hook/files/hook           |   3 +-
 .../files/local-top-complete                  | 103 +++++++++++++-----
 .../initramfs-crypt-hook/files/tpm2_functions |  66 +++++++++++
 .../files/tpm2_functions.buster               |  24 ++++
 ...ook_0.8.bb => initramfs-crypt-hook_0.9.bb} |  22 ++--
 6 files changed, 229 insertions(+), 46 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions.buster
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} (85%)

-- 
2.43.0


