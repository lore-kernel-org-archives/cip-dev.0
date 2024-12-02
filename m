Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA1D78321
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:49 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.175583.1733151104576398153
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=AVhc1zOq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20241202145142159da9b6dffca64234-vitnlb@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241202145142159da9b6dffca64234
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LAa4MCIky4Gxx9rB2f0z01/HxNXI2dpmdZ9v28J2seg=;
 b=AVhc1zOqtTDZ2lP7rq9tKkOA3OBi52yoenJy5dtp0gdNB3r5PoM7wEWP4md81IEOfXVyWu
 uEv1Cf3PSPVmUP4qvGu/8OGkyCA1EZTIXjQc51fzIwcuOrBjMflDftlgGT7MDlZgVXc5cyWf
 AnXtkQPXdDhC5hzCZuqYOKIwzroIsFLuQZadRkRWWFZS4xWtMoLw1cnS1j4kJAvXvdTDUwWU
 N9hEX95XYP4Aq/vgh+RfjHxQnK1sFh98uBlrOqsmINUjeLptt41NKlcEHs7ZczvvPMjvMMc6
 3LEvwoFd0C2z/wDVyNSQkqdfYMEAU7xDYlfkD97lFFfrN/ziwc+syjPg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	=?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian.blaese@siemens-healthineers.com>
Subject: [isar-cip-core][PATCH 10/10] initramfs-crypt-hook: invalidate PCR7 after unlocking partitions
Date: Mon,  2 Dec 2024 15:51:13 +0100
Message-ID: <cc43a620895a8ddcf6745c7eb4564344ecdf74af.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17319

From: Jan Kiszka <jan.kiszka@siemens.com>

This avoids that the running Linux can still access the partition keys
and possibly leak them. In the future, we may better address that by
measure boot.

Suggested-by: Fabian Bläse <fabian.blaese@siemens-healthineers.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete              | 3 +++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb           | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 834dea22..4bcb4277 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -258,6 +258,9 @@ for partition_set in $partition_sets; do
 	finalize_tpm2_encryption "$part_device"
 done
 
+# invalidate PCR7 to lock access to the disk keys
+tpm2_pcrextend 7:sha1=1111111111111111111111111111111111111111,sha256=1111111111111111111111111111111111111111111111111111111111111111
+
 if [ -n "$watchdog_pid" ]; then
 	kill "$watchdog_pid"
 fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
index 71ee44db..2145a6e5 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
@@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
 HOOK_COPY_EXECS = " \
     openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
     e2fsck resize2fs cryptsetup \
-    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
+    tpm2_pcrread tpm2_pcrextend tpm2_testparms tpm2_flushcontext \
     /usr/lib/*/libgcc_s.so.1"
 
 HOOK_COPY_EXECS:append:clevis = " \
-- 
2.43.0


