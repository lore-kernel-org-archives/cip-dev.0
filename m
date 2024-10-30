Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D15BD5CCA1
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.13031.1730289112374603917
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=cOuJ/1iU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-2024103011514845d440c439d7561268-_w352j@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024103011514845d440c439d7561268
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Oct 2024 12:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pK4kW9n2z4bSx5ictR4RWHtfPhit6l7yJqd490jd7ds=;
 b=cOuJ/1iUaopZXqbzXsqBS5TdOyGx7OUXmkrtKIUU8Yr4aX2PbceM7AuWlIdoodKAJ1AnGw
 uwcunXPPwaoYMAkp2iyexjcO9CumzuETJ3IS7fo/tqb3iyalXX1rf6jq67PAaS99vOCqmvuj
 48ojru9FLA77fGNonIuJN8kyh/lBub8TY3fTUA0ZZUduJWYC02M5KYkjNiuy/p4aJczRSlql
 UopSAqzm/DOvRu6wuG1Fj29u9IVaZW3kBWdfUgTCuuAX0R+9THFk2GKAzICPS3jDMhlSY+6O
 NNTEE5NJ/BhGUXcUzhjGfZKjdbjbB3wqWokJmMPK8Y0y4ezgIzZFd/TA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/6] initramfs-crypt-hook: Prepare for EROFS as alternative
Date: Wed, 30 Oct 2024 12:51:43 +0100
Message-ID: <06b38b36d50fde5940935c0de3bf0b83a6b72579.1730289107.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730289107.git.jan.kiszka@siemens.com>
References: <cover.1730289107.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:52:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17117

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


