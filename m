Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCD6C636D4
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 02:36:21 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.10213.1676278677156386564
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 00:57:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=FsFidV2x;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-2023021308575420a06ffbd60bbcc32b-jyf8yx@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023021308575420a06ffbd60bbcc32b
        for <cip-dev@lists.cip-project.org>;
        Mon, 13 Feb 2023 09:57:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=M8E7yi2zSlZ4ASUnGttSvflyAAlHw3Ok3WQP8biywwo=;
 b=FsFidV2xusY7pKqH8NDl3mDzueAkD7u44Oi9uaja4eQLlG7dWAjMPBMEerC0ZgJ1K8uLmL
 pIFU0p53g7vhiKHYvqtPg5Hs8pM7hbGEPoanZgFlJnSkQ1Ax0WJ9hosRuwNqsg8Yv2l3miOd
 Tnf2DzKejouPp5FdERIkTiU9YEm/Q=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] ebg: install for correct distro-arch
Date: Mon, 13 Feb 2023 08:57:39 +0000
Message-Id: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 02:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10691

The efibootguard package is architecture specific (similar to the
systemd-boot package). Hence, install it for the distro-arch, not for
the host arch to make cross-imaging work.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-core/images/efibootguard.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index 26026dc..b3fe911 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -11,7 +11,7 @@
 
 IMAGE_INSTALL:append = " efibootguard"
 
-WIC_IMAGER_INSTALL:append = " efibootguard"
+WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
 IMAGE_FSTYPES += "wic"
-- 
2.34.1


