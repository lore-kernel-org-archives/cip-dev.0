Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DA0C5321E
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 12:51:47 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.209512.1724071903151277071
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 05:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LGn4W6mk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240819125140f257bd7b368744d8b6-lzjo3c@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240819125140f257bd7b368744d8b6
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Aug 2024 14:51:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tfSSSpAFlwaZKu3aIIiz6epoXtlatz81SVTszJjkXsM=;
 b=LGn4W6mkVDi53/xi4wIAC6k6BH/bJAmxWKppjlg10pBZVvHnyRMdBBhX5DVzQeFhpE9JQh
 MVeZec++COAhXBGfkEQ3ABQ84yaBK/AARnoxfSL9uNjMQRS+c41CuQClVAf+NSs1uRnVUjpi
 9AhhaqDo7YRH2SbU3+Bpc0h9SHsaEAlVf6ZihQQGgkFWX9+fYcXWeA6Q11v80lcNaWevOGP1
 Vsqf0pXHb3ikdgjo4uhfhvrEebDNJVLcHQv8LQTCrn7bnE62+n3e4tE61BeRW+NWY+YK4YHt
 nZMCX9TxVWp9hwP2bAQH7BKeGGiO1PrPJ3pkIMHp8y3McLF97mYwqqow==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	Sai.Sathujoda@toshiba-tsip.com,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/2] fix: Check return code value of e2fsck
Date: Mon, 19 Aug 2024 14:51:25 +0200
Message-ID: <20240819125138.1543399-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240819125138.1543399-1-Quirin.Gylstorff@siemens.com>
References: <20240819125138.1543399-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 12:51:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16802

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

e2fsck returns a 1 in case of a recoverable file system error.
In that case we execute erroneously the recovery script and mke2fs
ask if the filesystem should be overwritten.

The issue was introduced with:

8644fb1 initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE

This fixes issue https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/113

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.script.tmpl        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index c655a4f..72d1396 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -40,7 +40,11 @@ partition_fstype=$(get_fstype "${ovl_partition_device}")
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 	case $partition_fstype in
 	ext*)
-		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script" ]; then
+		e2fsck -p -f "$ovl_partition_device"
+		fsck_ret="$?"
+		# e2fsck returns a 1 in case of repairing the file system
+		# https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
+		if [ "$fsck_ret" -gt "1" ]  && [ -x "$ovl_recovery_script" ]; then
 			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
 		fi
 		;;
-- 
2.43.0


