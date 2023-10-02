Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2EFE7849A
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 11:21:10 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.79167.1696245668953155160
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Oct 2023 04:21:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FiM2+5Re;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20231002112105168ba4acae976f40f7-t4ptlb@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231002112105168ba4acae976f40f7
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Oct 2023 13:21:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=IbdkuPAX4/+N3h1kGd1iZGSPSZBOOqY4J54Tc9O3LkE=;
 b=FiM2+5ReOh8NzpblwMbQ+UX0Vsm5b+Qf/iM+BCWV74okPR0kzE1FH590GufcbRFjVpgvAg
 wwOyer5AagzwzVxt2e72UBBvBwsPIagqy9Ild7FleeBtMltJwKn6GxqYEkfiFBrbaFUEqrSn
 TvvaN7e4hA6rMcxtOMk7MPTGXx1H4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [PATCH] initramfs-crypt-hook: Load necessary crypto modules for intel platforms
Date: Mon,  2 Oct 2023 13:21:05 +0200
Message-Id: <20231002112105.2929311-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Oct 2023 11:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13256

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To support the encryption on intel platforms with add the crypto module
'aesni-intel' to the hooks of clevis and systemd.

If the modules are not available(not build or compiled in) the build
will succeed.

Reported-by: Sari Sercan <sari.sercan@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook   | 3 +++
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index 23dce93..37b373c 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -34,6 +34,9 @@ manual_add_modules tpm_crb
 manual_add_modules dm_mod
 manual_add_modules dm_crypt
 
+# add crypto modules for debian upstream kernel
+manual_add_modules aesni-intel
+
 copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
 copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index 08ea631..0a39da6 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -31,6 +31,9 @@ manual_add_modules tpm_crb
 manual_add_modules dm_mod
 manual_add_modules dm_crypt
 
+# add crypto modules for debian upstream kernel
+manual_add_modules aesni-intel
+
 copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
 copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
-- 
2.40.1


