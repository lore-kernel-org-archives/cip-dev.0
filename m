Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C36AC021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 13:07:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.21186.1741093671087712021
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 05:07:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=bMu7H5jj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEF9010382C18;
	Tue,  4 Mar 2025 14:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741093669; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=xTWWjZ2nr7YtKzrLe3yzizWebzrzf8BCHpDVFnTw190=;
	b=bMu7H5jjr9EPd1EKRUqYVzuNQn8RlB8beJX9pSSAqRZPCFho2XFrJDz86OsRIktAJjlx80
	VRF4TfVfRAKyE9KpOOUpXI5zKxKrwo3RgShwCy4PlR8ktzBSsArifL35ukFF9nHXUkblvU
	tD882AluN4CIhmbh51G9QITq8ocgZiTdnLecq5+wZjrHSjGIHaZdaeXZC1fC8JJAKiYi5h
	MOPw/YHzvMOKck8SCl2P1SP22jt2gl3h8htGf6sG0Gxlmk7TPjrVN2DamQnNRQdMkWM1fG
	M3QeiInR2r4Lg3XZ5GRfrRxCWwzIr81jh0bGViNzqQlTKCOwKSbBVuFR6t8oPA==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH v3 0/4] initramfs-crypt-hook patch
Date: Tue,  4 Mar 2025 14:07:39 +0100
Message-ID: <20250304130743.2812183-1-ch@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 13:07:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18015

Hi,

here is v3 of my patchset, I rebased this on the current next branch and
fixed the review issues.

regards,
Claudius

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

Claudius Heine (4):
  initramfs-crypt-hook: make sure that mount path exists
  initramfs-crypt-hook: implement 'noencrypt' option
  initramfs-crypt-hook: add 'format-if-empty' feature
  initramfs-crypt-hook: add re-encryption recovery

 doc/README.tpm2.encryption.md                 | 23 +++++-
 .../files/local-bottom-complete               |  1 +
 .../files/local-top-complete                  | 73 ++++++++++++++++---
 .../initramfs-crypt-hook_0.6.bb               |  5 +-
 4 files changed, 87 insertions(+), 15 deletions(-)

--=20
2.47.2


