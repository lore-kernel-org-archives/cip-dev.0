Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90292C021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2409.1740563970878594479
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 01:59:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=aOg376R0;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 344DF10382D2E;
	Wed, 26 Feb 2025 10:59:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740563969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6Ayz7HfW8PkAGpgVd5BwPGF739Jsaq2VfEeaKksXwE=;
	b=aOg376R0xzEzWtjoduScnReswvi5TaG5MYWGMiu/Uqg+WecYfu689SU20f2zC+PoBDA0SG
	tEY3lwSmu9IqtHxYU86jPMe1uwtCc6C3PoNV9HFPyt+t2/dMefPj/PPlyE0eS1tSqGygeb
	miNFFDDZ2xqlME1D0LuGdxtfV+kNdVJT3TY6lOiAQqXBspfrw6tWHb0wabl2DUV10xsOhY
	4QrsmMSsgdFCiDZ3SORQ1K7OZG/W0NXbbqdSfb5+R5VR8EIQoilln0k1pURd6HKmFgyFJA
	r+v7WK/OceUdbjDeSvSDm75aHvXKSeGm/0hX5VQ+7/XQt0I0G/iG7TG7YEmL7A==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH 3/5] initramfs-crypt-hook: use real device path in luksFormat case
Date: Wed, 26 Feb 2025 10:59:19 +0100
Message-ID: <20250226095921.168962-4-ch@denx.de>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17921

In the 'format' case the `$partition` variable is used instead of
`$part_device`, which is likely an error, because all other cases use
`$part_device`.

`$part_device` is the real path to the block device, while `$partition`
is the 'name' of the partition in the `$PARITIONS` variable, as defined
in the recipe.

This fixes an inconsistency, it shouldn't be a bug here, but could
result in bugs when this script is adapted in product layers, etc.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-compl=
ete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index f1aa0d7..b907ea7 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -254,7 +254,7 @@ for partition_set in $partition_sets; do
 		"format")
 			log_begin_msg "Encryption of ${part_device}"
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
-				 --type luks2 "$partition" < "$tmp_key"
+				 --type luks2 "$part_device" < "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_a=
lgorithm" "$pcr_bank_hash_type"
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			eval "${create_file_system_cmd} ${decrypted_part}"
--=20
2.39.5


