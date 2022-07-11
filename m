Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1932CCA485
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:04 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.185.1657568462101678157
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Cf3LJXvF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-20220711194059ab44f7f1a1d53bb797-9ckxkl@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220711194059ab44f7f1a1d53bb797
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:40:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bANYapUr7al37NScZ2xmo6ZgKKM+V9iQn3Iz074S0Ic=;
 b=Cf3LJXvFfioG5u/TLcGPbOa2zGEvd9cmzxVZHFrCpK7nxJPrVdIQWOfi3HwTvsO9Hdy8DQ
 +ie10WM1cp38ziBwW26DV3U5PbHbugeUSTH03DB4Ce9LxianTXMLOa8PsDOQFUUjGoNrurDW
 O4wDC8Y410yEv1pkBkgodcmuzizhg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 1/7] linux-cip: Update cip-kernel-config
 revision
Date: Mon, 11 Jul 2022 21:40:52 +0200
Message-Id: 
 <a79b741d3b14c0d3bdef713676c7b3bd1e861d11.1657568458.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1657568458.git.jan.kiszka@siemens.com>
References: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8742

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed to use qemu-arm with UEFI secure boot / swupdate and also for
qemu-arm on 4.4 kernels

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index c12a60f..b612efa 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "a8d04df6595344091eee2b242c3a0f5e108f966c"
+SRCREV_cip-kernel-config ?= "6509d11f52b7df71b8b2228c1bccd7913e4a33b8"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.35.3


