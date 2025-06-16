Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA0DC71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 09:30:33 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.26453.1750066227769587849
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 02:30:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=daSxwSNi;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 748F5103972B5;
	Mon, 16 Jun 2025 11:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750066225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=oD1pqDI5U9luj9XajkjfqwFPHKTUeuXDmQTv4ClV5Wk=;
	b=daSxwSNizL+OvdIzPHUv1vobiO3JulVefLnDHSJffL9S6RfIPV9aYdyeM2tsrH8h9yVMN/
	kqcKzvhyQ9TRXX6MgPxPSltdjOREi4hant4fhrba8KFYepocuOvhVuNy4g72wckMe8wgt4
	zLkmmV7J9D/vVKbj6QLY0Xfb+KGwbyY4K3AtaPXPB0tWXhAyEhy/E/DEzRB52yod9uUBMn
	lnLzDxrWVX9k7S3t6AVin9tPPOPmm8eig3/1bGvKzx2ZcW4Oxy2Vnst6USrQnD80dKfJdZ
	Z/e5Ga5B35OrdqhViY0NB6iHp8fiY3TjZtwuI/5Oiqzmx2x3az3OyJ0PKIh4NA==
From: Claudius Heine <ch@denx.de>
Subject: [PATCH v7 0/4] initramfs-crypt-hook patch
Date: Mon, 16 Jun 2025 11:30:10 +0200
Message-Id: <20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLkT2gC/43OQW7DIBCF4atErDsRMwbbdNV7VF0gGAqqYiywr
 ESR716cReuu0uXbfO+/i8olcRWvp7sovKaa8tTG8HISLtrpkyH5tgVJ0rKTGtKUlmIvoYIrt3m
 BmPMXzHZxkSsQGOeUlTS40VjRkLlwSNfHwftH26HkCyyxsD2yCjs5qO5MIxKOHSC4+OZ5up497
 0pMdcnl9qhc1W79O2hVIEHhIA0Sa+rxx91zVn3AsHuK6YYF15NXlqwn8xfrDxjJp1jfMA4oHaK
 z3qhfbNu2byVkNwqaAQAA
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
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 09:30:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19098

Hi,

here is v7 of my patchset.

I readded `tpm2_createpolicy` for clevis.

Kind regards,
Claudius

---
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

 doc/README.tpm2.encryption.md                      |  25 +++-
 .../initramfs-crypt-hook/files/local-top-complete  | 127 +++++++++++++++++++--
 .../initramfs-crypt-hook_0.7.bb                    |  13 ++-
 3 files changed, 147 insertions(+), 18 deletions(-)
---
base-commit: 8f93ab805738001fc33dd1f918c6e7f73a90e744
change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a

Best regards,
-- 
Claudius Heine <ch@denx.de>


