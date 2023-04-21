Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF83FC77B76
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 15:05:52 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.14926.1682089549392415472
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 08:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Oxm9Zlk/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20230421150547067585b14b6c529ba2-wbnml9@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230421150547067585b14b6c529ba2
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 17:05:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uvP8jQTC2dAgxB+xy4LPqpMlNs8B8YSPKnqc3O6Iwe8=;
 b=Oxm9Zlk/bcCswfU7sx0ywpNdtL9/1zFOw/3IP2GzphSckNCsOSYKFgdWX1UFFjKtDRMWNG
 cAqT4e7IMoL6qP/guGtv1crLrW2Z5o3WoMVpBK628cF7WbZx3auI/VhMk+kk+p74o7eA0EYV
 Cza4696zhVSufe5P/HYWxWLgqMWas=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 4/4] initramfs-crypt-hook: Add libcryptsetup-token-systemd-tpm2.so
Date: Fri, 21 Apr 2023 17:05:45 +0200
Message-Id: <20230421150545.4073324-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
References: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 15:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11323

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the boot of bookworm with encrypted partitions.
With systemd (251.5-2) the libcryptsetup library are used see
https://salsa.debian.org/systemd-team/systemd/-/blob/debian/master/debian/changelog#L258

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index a535736..4f7263b 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -42,6 +42,7 @@ copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
 copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
 
+copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
 if [ -x cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
 fi
-- 
2.39.2


