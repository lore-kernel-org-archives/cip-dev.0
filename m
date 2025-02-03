Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C658C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 15:52:30 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.90886.1738597946599228036
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 07:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=c8tLZ6wh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20250203155222dd3813df3cfa96e1fa-lil3si@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250203155222dd3813df3cfa96e1fa
        for <cip-dev@lists.cip-project.org>;
        Mon, 03 Feb 2025 16:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=9UX5+Gp26NxsLRfbengIuk2MiBctLd7RV9YU3Fd1IO0=;
 b=c8tLZ6whZk9PcITSc1MOHIf8ynQwXzRZ25VSZsWMaD7tzu4ZXWhogDGh2M7H1B1u/as96n
 TOoLgEZx9aJOiA0YnmPXbDro2hFgmMCFL2zIr5DouQCPUk0pVjH76WslvJx+ZpBKXLALeMVe
 bcCktXUnA50H7DnDU5YUgh6Zckaxy0yaIBDncfmEmMsUSpctgh5rqDVMOqgdZ0PBraQ5L3HO
 koWEmJpDPrxUC6TAr5P305owSPFnWHb52nITvrrgvMKXE4v2Z5eqV3vvTJq7qSClDnW4RgCH
 Y4uiC1rUZ7WE9m+gl01MIwRne3OukHlz5gTb9CmmnoSXygZc6+rm6V3w==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-crypt-hook: allow to run before mounting all overlays
Date: Mon,  3 Feb 2025 09:47:00 +0100
Message-ID: <20250203155221.342136-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 15:52:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17730

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The overlay hook does not work with encrypted partitions
therefore it must run after the crypt mount script.

The crypt mount script run last to mount all encrypted partitions
which are not mount by other scripts.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/local-bottom-complete        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
index f47219b..b991cb4 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -12,10 +12,14 @@
 prereqs()
 {
 	# Make sure that this script is run last in local-top
+	# but before overlay
+	# This script mounts all encrypted partition, which are
+	# not mounted previously
 	local req
 	for req in "${0%/*}"/*; do
 		script="${req##*/}"
-		if [ "$script" != "${0##*/}" ]; then
+		if [ "$script" != "${0##*/}" ] &&
+			[ "$script" != "overlay" ] ; then
 			printf '%s\n' "$script"
 		fi
 	done
-- 
2.47.0


