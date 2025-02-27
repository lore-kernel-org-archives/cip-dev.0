Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1480C19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:30:49 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11648.1740666643053330789
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:30:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=TxdQi4de;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 109B310382D2E;
	Thu, 27 Feb 2025 15:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740666641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xcM55cemm1RjPDqcX3YGvlCuYBIYoYgQBdH3lCRkmOo=;
	b=TxdQi4deIl+9zTiRXkpJQTzljuAZD41lS07T0z96A4LeiMTVge/myoJYPrWQLFypt3m7P+
	Di1hDXAJ8SlyZpUxf7Hx2nGd92EAqPbF4Qas4SgQCUTAmZOKT49Djz+8QCw9wEXHSLyGaa
	lhZ8DwnxUQn4Mbpyfrhqsx1kVfGqFgtHZwWPOclpwCVpU0Ixwv0TWEHG6plaqkfhROUSqE
	zySiPbO3nEm865pnO0wUBpM7v8n/ZXjO4towWummW2VhFUPD5+p4ufdbymSzOjLAxIt47p
	jIGdBpVeSytz4/lD8yDPSGNqXSU0NznhUHNB3os5rD0VXciGUruMf/q9XV+hPQ==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH v2 0/4] initramfs-crypt-hook patch
Date: Thu, 27 Feb 2025 15:30:18 +0100
Message-ID: <20250227143022.323950-1-ch@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:30:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17941

Hi,

this is the second version of the patchset.

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

 doc/README.tpm2.encryption.md                 |  4 +-
 .../files/local-bottom-complete               |  1 +
 .../files/local-top-complete                  | 73 ++++++++++++++++---
 .../initramfs-crypt-hook_0.6.bb               |  5 +-
 4 files changed, 68 insertions(+), 15 deletions(-)

--=20
2.47.2


