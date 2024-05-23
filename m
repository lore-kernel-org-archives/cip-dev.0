Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB712C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 12:03:40 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.13680.1716465810588826565
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 05:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bkNAKGrg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240523120327db3e86881a7c5b213d-ud8cbp@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240523120327db3e86881a7c5b213d
        for <cip-dev@lists.cip-project.org>;
        Thu, 23 May 2024 14:03:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=YcB6cWbUitS+g2nJtcaqotcPuJcKmJqnv339GPLNL1c=;
 b=bkNAKGrgATQ7Jo1k1XMHta6U3n+d2ry13DJKIEeuBDsDpHve3kM+52sGw3fBnnHG9ocuO6
 U6g4QVc9Oal3QQTJe4y1vs/jZn1vAmJc5vBScorvZvU9Wp0fsilqYDUt/PF3CC/E7b8heZDH
 YC+0Io5kkOmKie02orzDQhuE1bUik=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] fix: Add missing mountpoint to crypthook
Date: Thu, 23 May 2024 14:03:18 +0200
Message-ID: <20240523120326.1702505-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 12:03:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15934

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The crypthook requires `/usr/bin/mountpoint` to avoid the error:

 "mountpoint: not found"

 This was not found because other hooks already add the binary to
 the initramfs.

Reported-by: Wang, John <johnxw@amazon.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook     | 1 +
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index 0644eab..4e62ef7 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -73,6 +73,7 @@ copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
 copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
 copy_exec /usr/lib/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/*/libgcc_s.so.1 "
 copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
+copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mountpoint"
 
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index 19e0fe4..be8c117 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -53,6 +53,7 @@ copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrr
 copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
 copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
 copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
+copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mountpoint"
 
 copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-- 
2.43.0


