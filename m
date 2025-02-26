Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B448BC021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2482.1740563968515040482
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 01:59:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=Egyrg8Y6;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB24E10382F1A;
	Wed, 26 Feb 2025 10:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740563966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+xzEjT5emgbheG9IELoItqRXrqdYmW7em51Rx8N+vc=;
	b=Egyrg8Y6+hIWdwsE4XNRjKzdbrnnlW+oHFgQi7KPNGEZEnvem+OxRqmDO3/ITK/FECa6Hi
	eWTN0gabr4hk8+jJe15PGKFgoKFGjr6blxLFtUYulHRwhwC8Gp9eYwfOzjgplLGqxCsYDv
	JPBKi29mUqfNwTRo+fzfttlAMM39MuKbYoHYmDEtmvsOGkZ6Ykl6M/cq53JN/dAI7ccqI4
	P2gn84tH4G7r0oofkIxWyPJNhDVwyzmVNUqZO0R5yJzsIoAqOLcswnWXrpbita8wzVrYrT
	CoeBNmonOY4eNSFRz64TvRQR3HNipajlZP8W2CSkX/0ZHw4FGiNDU7Wu3eSRHA==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH 1/5] initramfs-crypt-hook: make sure that mount path exists
Date: Wed, 26 Feb 2025 10:59:17 +0100
Message-ID: <20250226095921.168962-2-ch@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226095921.168962-1-ch@denx.de>
References: <20250226095921.168962-1-ch@denx.de>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 09:59:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17919

In case the mount path does not exist, try to create it instead of
failing.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 .../initramfs-crypt-hook/files/local-bottom-complete             | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-co=
mplete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-comple=
te
index b991cb4..80553d1 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -41,6 +41,7 @@ mount_partition() {
 	partition_mountpoint=3D$2
 	[ "$debug" =3D "y" ] && echo "mount device: '$partition_dev_path' to '$=
partition_mountpoint'"
 	if ! mountpoint -q "${partition_mountpoint}"; then
+		mkdir -p "${partition_mountpoint}"
 		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev=
_path}" \
 			 "${partition_mountpoint}"; then
 			panic "Can't mount partition '${partition_dev_path}'!"
--=20
2.39.5


