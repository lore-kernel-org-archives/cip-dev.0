Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AEAD43345
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.69036.1730977085414743745
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=c8sN7K3k;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-2024110710580313cfb6480d11cf5258-cneosp@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024110710580313cfb6480d11cf5258
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9R07GYmtbTHfstw0JOMoDbmMvFff8zDyHcks29Nf8RY=;
 b=c8sN7K3kF48/+hUJA26cfM0Rsxu/UHM5nUA0Yq/Ck2wRhroVhiOxdviYBf1RNnh/G6uZX2
 9wOHAOHqySf8cGPKYO/7U9xGqXYpMWm1m5qyefhwXjLN+phTeWlQLo9/YKppGH2/ElJpZhKq
 S1YxmKoecJxVTPX6hmeT4Vxz9kT2iUv5LLkrp7i/sGC8grIrq6/2tQmHEslrWsQc7ZedNuX2
 fGTUBF1cCDpTx/tQC/3hS+cOMppq832OJULrLgHHMC3eFqJFpOhV0JkQYzidwP+6796OLA0F
 NrxsM91caW65+dlo1lExg/6fFFiCrLZgcf9AjOQvr5wDQBdD2iUYpWyw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 6/9] read-only-rootfs: Do not install tmp-fs with trixie anymore
Date: Thu,  7 Nov 2024 11:57:54 +0100
Message-ID: <2a89d970944b690200e71386ebacab882543c8a9.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17211

From: Jan Kiszka <jan.kiszka@siemens.com>

Debian trixie gained tmpfs-based tmp by default, thus no longer needs
our manual activation via the tmp-fs recipe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/read-only-rootfs.bbclass | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index fa56b2eb..9ebcadc2 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -15,7 +15,10 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
 do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 
 IMAGE_INSTALL += "home-fs"
-IMAGE_INSTALL += "tmp-fs"
+
+IMAGE_INSTALL:append:buster   = " tmp-fs"
+IMAGE_INSTALL:append:bullseye = " tmp-fs"
+IMAGE_INSTALL:append:bookworm = " tmp-fs"
 
 # For pre bookworm images, empty /var is not usable
 IMAGE_INSTALL:append = " immutable-rootfs"
-- 
2.43.0


