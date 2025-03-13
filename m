Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A81C2BA1B
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 12:36:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.13603.1741869405656317048
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 05:36:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UhIIhPVY;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 573D51020E4ED;
	Thu, 13 Mar 2025 13:36:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741869403; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fGrxE+aYVP7CSqQXk2tO2o9ZwBGKDxpA6b9Wov7EIGA=;
	b=UhIIhPVYqFNDU2l0faJn/vq5UGzaTZGF6xPSJTkWBax6F8db60NCASMV2QP+DU5Ze5lmNS
	UgDg6eiF2cVXKaNRN1mpI73r7Fl912B03NFAc/sotvBAlWEFJqutbwmNagba4/pRQHugLa
	qG1TM9QVYT+g/wNyWQU1XWsbbCvVfqYQNw24obrcju9PukzEL4rOzvvYV9owFs06tjgLuj
	96XXl+Co4xfcFr8QCcZciSXzbU9mnUqh/fkcn2iQ7I11pfBM/bYfyVC33nQlcNJRWU/Djv
	XjZQDczqm1LEjUdDu06AMvPCKEBA0KuzcpNEcvYRE/QBmzxQKxz57VQtwCIEtQ==
From: Claudius Heine <ch@denx.de>
Subject: [PATCH v5 0/4] initramfs-crypt-hook patch
Date: Thu, 13 Mar 2025 13:35:40 +0100
Message-Id: <20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzR0mcC/43OvQ6DIBiF4VtpmPsZfqt26n00DgQ/C2kEA8Roj
 PdedGg6dnyX55yNJIwOE7lfNhJxdskFX0JdL8RY7V8Iri9NOOWKCqrAeZejHocEJq5TBhvCGya
 djcUEHFpjpKa8Nk2rSUGmiINbzoFnV3qIYYRsI+pfVjJBaykq3jDOGgEMjH306Jeqx0OxLuUQ1
 /PlLA/r70OzBAqS1bRlHBW/sa/b7fv+AZf43fEAAQAA
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
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 12:36:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18190

Hi,

here is v5 of my patchset.

I tested this on Debian bookworm (12).

This creates a different password for every partition, since that was
how it was done before, but maybe it would make sense to have the same
initial password for every partition.

It might happen that the fallback system needs to continue the
re-encryption process, and using different password means that the
fallback system as well as the update system needs to process the
re-encryptions in the same order.

What do you think?

---
Changes in v2:
 - Added more descriptive commit message
 - Added more descriptive documentation about noencrypt option
 - Fixed typos in documentation
 - removed unecessary setting of /conf/param.conf in initramfs-crypt-hook
 - added re-encryption recovery patch

Changes in v3:
 - Rebase on current next
 - Extended `noencrypt` documentation
 - support clevis tokens for re-encryption recovery

Changes in v4:
 - improve documentation and commit messages
 - reorder commits, to put re-encryption recovery up front
 - extract static temporary encryption key patch into its own
 - switch from lsblk to blkid

Changes in v5:
- Switch to use TPM2 protected password instead of static initial
  password for encryption
- Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de

---
Claudius Heine (4):
      initramfs-crypt-hook: store initial encryption key in TPM2
      initramfs-crypt-hook: add re-encryption recovery
      initramfs-crypt-hook: implement 'noencrypt' option
      initramfs-crypt-hook: add 'format-if-empty' feature

 doc/README.tpm2.encryption.md                      |  25 ++++-
 .../initramfs-crypt-hook/files/local-top-complete  | 123 +++++++++++++++++++--
 .../initramfs-crypt-hook_0.7.bb                    |  12 +-
 3 files changed, 142 insertions(+), 18 deletions(-)
---
base-commit: ddc2f2500b8984aceef9cf4b884e69e52d515567
change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a

Best regards,
-- 
Claudius Heine <ch@denx.de>


