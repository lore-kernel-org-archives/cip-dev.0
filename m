Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A816C7EE32
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 09:09:41 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4062.1750928979869675898
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 02:09:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bcEdWzJR;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0B2810397286;
	Thu, 26 Jun 2025 11:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750928977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=d+CLoxqdz8u2GT5Duc8TW7uN5vG0GFibvldyqfGdND0=;
	b=bcEdWzJR8Y42zPZwaoHCslYbcZGDNWdWCA9gnA1mlMrTb1MVkSsdztWB/a5foE+xb623+1
	UPJhgWpH9gn4mUaK/giGriNgpPKibYQ6wJd14Jbnzbz8MGfbbrpVOot51cqz1uB/8k6two
	R/7qpb2TG+lsIWP7RCQBbPvVvrvirpC4w8tiDHlOHgrFLP3sy9qZn7FBvlPrcVwZeg7AYF
	pQ1xrxCdl5f7b6ut2d5bMBDTcepXp30KXS2MvvclvIclWtpRrson2kRR20Rg6Tlo6eYuj4
	sfEZNbEeYCk/S+H01ZnBct6gGPtpU2f1aZ1d124kd9NFyk98vktzwoz40HVjWg==
From: Claudius Heine <ch@denx.de>
Subject: [PATCH v8 0/4] initramfs-crypt-hook patch
Date: Thu, 26 Jun 2025 11:09:23 +0200
Message-Id: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEMOXWgC/43OQW7DIBCF4atErDsRM8bYdNV7VF2QAQqqYltgW
 Yki3704i8ZZpcu3+d5/E8Xn5It4P9xE9ksqaRzq6N8OgqMdvj0kV7cgSa1sZAtpSHO251CA83W
 aIY7jD0x25ugLEBhmZSV13BsrKjJlH9LlfvD5VXfI4xnmmL3dswob2anmSD0S9g0gcPxwfrgcn
 d+UmMo85uu9clGb9e+gRYEEhZ00SL4ljX/ulrO0Owybl1hbscCanLJkHZlnTO8wki8xXTEfUDI
 iW2fUM9Y9MI36JdZVrCfHxkl3OnF4YOu6/gLhFxtt5wEAAA==
X-Change-ID: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Heinisch Alexander <alexander.heinisch@siemens.com>, 
 Cetin Gokhan <gokhan.cetin@siemens.com>, Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 09:09:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19239

Hi,

here is v8 of my patchset.

Kind regards,
Claudius

---
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
 - Extended `noencrypt` documentation
 - support clevis tokens for re-encryption recovery

Changes in v2:
 - Added more descriptive commit message
 - Added more descriptive documentation about noencrypt option
 - Fixed typos in documentation
 - removed unnecessary setting of /conf/param.conf in initramfs-crypt-hook
 - added re-encryption recovery patch

---
Claudius Heine (4):
      initramfs-crypt-hook: store initial encryption key in TPM2
      initramfs-crypt-hook: add re-encryption recovery
      initramfs-crypt-hook: implement 'noencrypt' option
      initramfs-crypt-hook: add 'format-if-empty' feature

 doc/README.tpm2.encryption.md                      |  57 +++++++--
 .../initramfs-crypt-hook/files/local-top-complete  | 127 +++++++++++++++++++--
 ...ypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} |  13 ++-
 3 files changed, 171 insertions(+), 26 deletions(-)
---
base-commit: cad5026bc860a2eefb828e03a9205ed8803cd958
change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a

Best regards,
-- 
Claudius Heine <ch@denx.de>


