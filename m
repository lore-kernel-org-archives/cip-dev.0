Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E4C3DA4A
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2484.1740563969796677223
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 01:59:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=OWJU1FPJ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCB2210382F1E;
	Wed, 26 Feb 2025 10:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740563967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZKMzHSvCRLoZ8jfxDRhG2Yaxu0iWINbUtPlGp4Yz2E=;
	b=OWJU1FPJqQcSb7IeEtiTmxbuKdwTH43BxzqQkjQPnh3/IMUEnRBCMcSgWeu2Sl4lEyRJMz
	2vU0pl27U+HbCj4nRPyC1zn3UG93JIm73Rs9b/QjhVZzU7vVsUIfMDht7yKV61WBCMLxkA
	woqTnkwt7gxQ+tuh2RXcZq6fdRd6oAlCCI7NQyxZ1VMJc2gN8fcVBAbFrUYEUjw5KpI+2K
	6Qz7c8hxfx73NQglcEiApd4xDITJt3+gkqZS1GxG7U2AL5k2wA/gZrGGBbjxub6YKp1hQb
	6tR5wSstZn/9uUR3S/L4ChfUoSt2iq9pRhUPLzj6savMcckQg6fR0HSDnY9I6A==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH 2/5] initramfs-crypt-hook: fix inconsistent whitespace
Date: Wed, 26 Feb 2025 10:59:18 +0100
Message-ID: <20250226095921.168962-3-ch@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226095921.168962-1-ch@denx.de>
References: <20250226095921.168962-1-ch@denx.de>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 09:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17920

Signed-off-by: Claudius Heine <ch@denx.de>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-compl=
ete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 54b8a6e..f1aa0d7 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -262,7 +262,7 @@ for partition_set in $partition_sets; do
 		;;
 		*)
 			panic "Unknown value ${partition_format}. Cannot create a encrypted p=
artition !"
-		 ;;
+		;;
 	esac
=20
 	finalize_tpm2_encryption "$part_device"
--=20
2.39.5


