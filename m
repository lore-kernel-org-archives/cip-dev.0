Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF42C7EE2A
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 15:38:08 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.1464.1683041883871308870
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 08:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=hSlDSeI9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202305021538022996717724c8542760-yvnwm7@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202305021538022996717724c8542760
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 May 2023 17:38:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uvP8jQTC2dAgxB+xy4LPqpMlNs8B8YSPKnqc3O6Iwe8=;
 b=hSlDSeI992PZjgjqAmNd8Jn4LBvm+2uYeZvmhnY8QUz2cCZnU6HIf8gXh9QjzDJraGEXj7
 qVp+ZHdjiH00iGEnvtAIbHVFf/2OvpRMLtoVCzYn9DEyCRyf+PY57eWmVF4mL5aTD/iC2xhd
 TFXXYzIuaVtEstn9WjdJifEnAKXns=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 4/7] initramfs-crypt-hook: Add libcryptsetup-token-systemd-tpm2.so
Date: Tue,  2 May 2023 17:37:56 +0200
Message-Id: <20230502153759.1284906-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
References: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 15:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11386

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


