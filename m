Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C6C1B0FF
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:30:49 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11649.1740666644430691816
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:30:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=AZ4kd4VM;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6644410382F1A;
	Thu, 27 Feb 2025 15:30:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740666642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgZYliBAkeADOjOHyzGWqeuOgVeufj5+wQZjZF2fIIg=;
	b=AZ4kd4VMQ6EIpLLkE9tKyISsCStGAg35Pq0UeGo9PQGlHtel77cZndLG+iV3r0aaQpBCOj
	hVlt9G42ojhAUfcoWE7ebdSEHoYeMbP0uad9ygcIux1S+25mNStSWB7TSAEOzQhq3PQF7G
	tOyjuI3WzND6SAf9vck5Vh564qs18vrwpvapta90YSbLPcplJ/J3qmDlmMCGZs/xgO7hcC
	3lLNbrg9KkpaAnY2JPePhQdOjMtDJhzgGYFpZV2G05EWzMggJgJ39AmRZb9k9nwfEFUc0J
	SK34OorRfQhbkORiD7zEaSMAdxW+3RWh2lkjeQIDGvhGynMA82piJpK8/KrX4w==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH v2 1/4] initramfs-crypt-hook: make sure that mount path exists
Date: Thu, 27 Feb 2025 15:30:19 +0100
Message-ID: <20250227143022.323950-2-ch@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227143022.323950-1-ch@denx.de>
References: <20250227143022.323950-1-ch@denx.de>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:30:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17942

Wherever or not the mount directory (and their parents) gets created
seem to be inconsistent; mentioning a missing mount point in the
`/etc/fstab` might cause the boot to fail, while using systemd `.mount`
units will just create the mount point.

Wic creates missing mount points that where mentioned in the `.wks`
file; so moving from such a setup to letting `initramfs-crypt-hook`
mount the file system at boot inside the ramdisk, the mount would
suddenly fail.

Therefore creating the mount point for your, if it doesn't exists seem to
provide a smoother transition.

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
2.47.2


