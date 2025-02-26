Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A2C021BC
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2481.1740563967837756437
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 01:59:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=hHYSQNWK;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7292C10382D2E;
	Wed, 26 Feb 2025 10:59:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740563965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bGFNhyJlEjJI+L5HXVFr6gY0I98VHT3Bg+x9HYm1q6w=;
	b=hHYSQNWKOppIHCLEeCdkJKqYIb4bJ6QQRmmGa24sivNunQrmetmd9gvyxh/vX4MiL0N5JA
	/AJw1k2KIpXZ5z4TMeg5tSgFjfeUlHiSSu84w0iEE/RNXhwb74IZmTLSyHTQJr8098/nte
	1lQuByXSaBzb+JO88vtyWo/17L7yIS3zjbDElw6+5F3y5upKAeHaBHCUx5GcsHvNsvYmGv
	kLBLXS3lNXrWCcuis52p9i3a7KSOspmk4HpAKEKspcA8ihoSSh4N0bimFrTzPkZlMMF4AF
	Cct6FpZ/DBDk7OvVMRpKQYHm7xYqfNR/kjJtY0H8Sqlfc4CzyRr2nIi1VJx0AQ==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH 0/5] Initramfs-crypt-hook patches, encryption on update
Date: Wed, 26 Feb 2025 10:59:16 +0100
Message-ID: <20250226095921.168962-1-ch@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 09:59:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17918

Hi,

I have a couple patches for initramfs-crypt-hook scripts. The first
three are general fixes/cleanup patches and the last two are about
enabling support for encryption via and update, while not touching the
fallback system.

I also have a patch that makes the 'reencrypt' continue, if the power
fails while it happens, but to do that, the initramfs needs to know the
temporary password that was used after a reboot, which currently does
not work with the random temporary passwords used here. My current
solution is to use a static temporary password for the reencryption
process. Any ideas?

kind regards,
Claudius

Claudius Heine (5):
  initramfs-crypt-hook: make sure that mount path exists
  initramfs-crypt-hook: fix inconsistent whitespace
  initramfs-crypt-hook: use real device path in luksFormat case
  initramfs-crypt-hook: implement 'noencrypt' option
  initramfs-crypt-hook: add 'format-if-empty' feature

 doc/README.tpm2.encryption.md                 |  4 +-
 .../files/local-bottom-complete               |  1 +
 .../files/local-top-complete                  | 49 ++++++++++++++++---
 .../initramfs-crypt-hook_0.6.bb               |  2 +-
 4 files changed, 47 insertions(+), 9 deletions(-)

--=20
2.39.5


