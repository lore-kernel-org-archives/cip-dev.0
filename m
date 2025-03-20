Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2CC36003
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 07:43:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2368.1742456599880498928
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 00:43:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PNKqKj0z;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E53C101E91CA;
	Thu, 20 Mar 2025 08:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742456597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lwZUcWaRI9VcFH+Dxz8xRj7tvU3MJFZcgCEnE+aTzXU=;
	b=PNKqKj0zihmiGrjtcptmwXyroEl4sqj/dYrML3UMGgquw3L40GSt1WQqhXZXEOt2zF7ZHO
	PsBmukRsCf4/q4GuJ58NCersemWIlXV2efnPGHjX1NmRYcWUfPv+4XzKhbFmgYfyl94ql1
	PShgDAJ9jFjmTGECuaHxoJBKcLuJHxdY2DGJ6HB4MzjdblXCgmu66MCH0RUxW1VAjJO3H7
	wMR+WpJAaIUWcUSOmAuczHCTGHVM0o/3bcqbBBd6ByeHEWUh4fYpusS2fg0FIqqcBAyZLX
	/RnIS/KGICbfHFX2TN5mo1fSm4uJZ3IIyth3cOFCAYnNd9t1GWBrI1zxQlMVGQ==
From: Claudius Heine <ch@denx.de>
Subject: [PATCH v6 0/4] initramfs-crypt-hook patch
Date: Thu, 20 Mar 2025 08:43:04 +0100
Message-Id: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjH22cC/43OvQ7CIBSG4VsxzB4DB+iPk/dhHAicCjGWBkijM
 b13qYO66fgtz/c+WKYUKLP95sESzSGHONbRbDfMejOeCYKrmyFHzSXXEMZQkrkOGWy6TwV8jBe
 YTLGeMiD01irDsbVdb1hFpkRDuL0Ojqe6hxSvUHwi880qIXmr5A47gaKTIMD6g6PxtnO0Kj7kE
 tP9VTmr1fo7aFbAQYmW9wJJYyPe7poz6y9MyJ+YrthgG3TKoHHYf7BlWZ4B0+EtTQEAAA==
X-Change-ID: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Alexander <alexander.heinisch@siemens.com>, Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 07:43:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18283

Hi,

here is v6 of my patchset.

I fixed the issue I found in the last patchset, now the `format-if-empty` process is a bit more power-fail save.

But I suppose that if the luks header could not be written fully, and the `luks` fs type is not detected, it might still cause issues, but I am not sure I can prevent that effectively.

Kind regards,
Claudius

---
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
 .../initramfs-crypt-hook_0.7.bb                    |  12 +-
 3 files changed, 146 insertions(+), 18 deletions(-)
---
base-commit: f5661b18b9721eee984ffc3b75169b40508469cb
change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a

Best regards,
-- 
Claudius Heine <ch@denx.de>


