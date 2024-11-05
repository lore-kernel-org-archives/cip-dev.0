Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F86D3176F
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 17:54:43 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.26672.1730829277182609161
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 09:54:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=dWAxj321;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20241105175434a1701d86b72b4218a0-umny59@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20241105175434a1701d86b72b4218a0
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Nov 2024 18:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pK4kW9n2z4bSx5ictR4RWHtfPhit6l7yJqd490jd7ds=;
 b=dWAxj321HADhspo4UVtk5ifUZ2+S80nz14U6mBodiA+LBFAmVOFIVr9PTxCwyXB2F4vgYW
 ZRRS231n0aPGGLJ0AoeqtnNfEoNXKhntI3rd8KM+rGqbe6Jc90x+L5JBhWnEcf9Cnq0Ii/SH
 TtKaqn8elAp6XvWorG4/hgrRxNklJTtpn8f4p+EaAUiM3Scnz9KAaraE2yRcS6LlhymOMkwp
 dnhYfBppb+eKtH3zxJ3gTjM7849Lnx6XH2f/IcgBjA8BktT2Ar4smQQSOmvAiSeyPzg3pmaa
 mnKlt5Wc8QYV2AuXmTW+InI8r5JOFggAGzQM/PYOu5+IK0kupadF1Fuw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 2/6] initramfs-crypt-hook: Prepare for EROFS as alternative
Date: Tue,  5 Nov 2024 18:54:29 +0100
Message-ID: <3514590b5e5431fd289011dbbec155c92e92e3f9.1730829273.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730829273.git.jan.kiszka@siemens.com>
References: <cover.1730829273.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 17:54:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17179

From: Jan Kiszka <jan.kiszka@siemens.com>

Naturally, expansion does not make sense for it as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
 ...{initramfs-crypt-hook_0.2.bb => initramfs-crypt-hook_0.3.bb} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.2.bb => initramfs-crypt-hook_0.3.bb} (100%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index ff4c1353..2cd6798d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -82,7 +82,7 @@ EOF
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
 		;;
-	squashfs|swap|"")
+	squashfs|swap|erofs|"")
 		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
 		;;
 	*)
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.3.bb
similarity index 100%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.3.bb
-- 
2.43.0


