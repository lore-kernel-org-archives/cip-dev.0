Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1945C282E3
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 12:00:32 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.11598.1741176026270937000
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 04:00:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=f2dz8kYa;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3346310382C18;
	Wed,  5 Mar 2025 13:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741176024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=W2K5CNfcmrdLb9iyr4Qsm2asLgwrAQsTt20B97SLWXc=;
	b=f2dz8kYacrq2oZ9mLXUxKLWj5MfIxoKuN1XdAU2w+XkjOWfycvRgGwX27ORp8z7tFFZ3Ew
	bCPHLN+KLaavrlc+ZtqxBxp8lRcby5KbfdMq6REJri+/2CzrIYL0XRBKSLjDtfvt2yEjyP
	N+MvcMuwHUYu4V8ZttS376Z6zcDsDEV/XifL1nIpvWty5PHBoBkjDh7OdPkLpu5TQlx4MO
	yTgXmv6Wh+hzapPV2FUF0/f0dxavkWL9GiGQh/zxdpeSpD6c4VrODo9VXLaP9wrO92gQb9
	Wm6hvXlEdYStdqHk7Z4FKcth7oPgqVLtSNcnx+pGQNCpMuOymAdIL5tUIJEiiA==
From: Claudius Heine <ch@denx.de>
Subject: [PATCH v4 0/5] initramfs-crypt-hook patch
Date: Wed, 05 Mar 2025 13:00:18 +0100
Message-Id: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANM8yGcC/03NTQqDMBBA4atI1h3Jn6hd9R6lixAnzVBMZBKKR
 bx7Q1ddfpv3DlGQCYu4dodgfFOhnBrspRM+uvREoKVZaKkHaeQAlKiyW0MBz5+tQsz5BZurPmI
 BDbP31kk9+ml2okU2xkD7b3B/NAfOK9TI6P6zVhk5WtPrSWk1GVDg423BtPcLivP8Am/HjimmA
 AAA
X-Change-ID: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 12:00:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18041

Hi,

here is v4 of my patchset.

Changes from v3:
 - improve documentation and commit messages
 - reorder commits, to put re-encryption recovery up front
 - extract static temporary encryption key patch into its own
 - switch from lsblk to blkid

Changes from v2:
 - Rebase on current next
 - Extended `noencrypt` documentation
 - support clevis tokens for re-encryption recovery

Changes from v1:
 - Added more descriptive commit message
 - Added more descriptive documentation about noencrypt option
 - Fixed typos in documentation
 - removed unecessary setting of /conf/param.conf in initramfs-crypt-hook
 - added re-encryption recovery patch

---
Claudius Heine (5):
      initramfs-crypt-hook: make sure that mount path exists
      initramfs-crypt-hook: use static temporary encryption key
      initramfs-crypt-hook: add re-encryption recovery
      initramfs-crypt-hook: implement 'noencrypt' option
      initramfs-crypt-hook: add 'format-if-empty' feature

 doc/README.tpm2.encryption.md                      | 25 +++++++-
 .../files/local-bottom-complete                    |  1 +
 .../initramfs-crypt-hook/files/local-top-complete  | 73 ++++++++++++++++++----
 .../initramfs-crypt-hook_0.6.bb                    |  5 +-
 4 files changed, 89 insertions(+), 15 deletions(-)
---
base-commit: 6f702e8af81ca12b9f4b37a0b853f987c35a1405
change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a

Best regards,
-- 
Claudius Heine <ch@denx.de>


