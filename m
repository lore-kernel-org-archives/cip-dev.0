Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8546C4321E
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web12.13161.1664902103326776206
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=HCVo9Ob9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20221004164821b4b1045d07e2b5542b-_thb5f@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20221004164821b4b1045d07e2b5542b
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Qy4hvZzTqb35U3nTmNCuZ/YZRw0ZT5hXTrCFrI2gq3E=;
 b=HCVo9Ob9NWVInGZ64eeZevwT02a5dhPyIhObpq6CX6xX4xQZ08f6FFGK0FAeHQJuAXHIYU
 gQ7YWdb3QrW35PMlYNc6lx96TWTGnSvFft4PiH5zFC84HhGXiYRAseWPlbQIvXQWLjNPImxb
 IHMfmAD631Y9aMyDIz39zrhcZBq4s=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 07/12] linux-cip: Update to 4.19.259-cip82,
 5.10.145-cip17 and 5.10.145-cip17-rt7
Date: Tue,  4 Oct 2022 18:48:13 +0200
Message-Id: 
 <6a93151acb220ad2c618395eb42722fdd6a75a46.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9633

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...5.10.140-cip16-rt6.bb => linux-cip-rt_5.10.145-cip17-rt7.bb} | 2 +-
 ...{linux-cip_4.19.257-cip81.bb => linux-cip_4.19.259-cip82.bb} | 2 +-
 ...{linux-cip_5.10.140-cip16.bb => linux-cip_5.10.145-cip17.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.140-cip16-rt6.bb => linux-cip-rt_5.10.145-cip17-rt7.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.257-cip81.bb => linux-cip_4.19.259-cip82.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.140-cip16.bb => linux-cip_5.10.145-cip17.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.140-cip16-rt6.bb b/recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.140-cip16-rt6.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb
index fc895db1..0cb2a1dd 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.140-cip16-rt6.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "a59d2994a826c0a1a62e8631f482c6caa98faf87355d7b47868ce7ce17c2e9ce"
+SRC_URI[sha256sum] = "a5598f7f673b3ef819d6ed24f08d539eecb6febd11673a1d4752a1c05d4ee289"
diff --git a/recipes-kernel/linux/linux-cip_4.19.257-cip81.bb b/recipes-kernel/linux/linux-cip_4.19.259-cip82.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.257-cip81.bb
rename to recipes-kernel/linux/linux-cip_4.19.259-cip82.bb
index 10676722..d728e2bf 100644
--- a/recipes-kernel/linux/linux-cip_4.19.257-cip81.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.259-cip82.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "9337fca3b8f981bd26884a3fd1035296ce5db8b458c776b73114e3e476423737"
+SRC_URI[sha256sum] = "b29e7d90959b29c67a0afa4432937fcc51138b519d33f24ff2ce976fbd958ffd"
diff --git a/recipes-kernel/linux/linux-cip_5.10.140-cip16.bb b/recipes-kernel/linux/linux-cip_5.10.145-cip17.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.140-cip16.bb
rename to recipes-kernel/linux/linux-cip_5.10.145-cip17.bb
index 9ed9ea6c..b4bf6b7b 100644
--- a/recipes-kernel/linux/linux-cip_5.10.140-cip16.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.145-cip17.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "0bc556457854220e82e6e4f738ddccf92875817f28a0d0643d005fa9038935d0"
+SRC_URI[sha256sum] = "4594c147bdc493c7c286688542bbe65e550fb7bd58e0649ec587a2fe893ec0ee"
-- 
2.35.3


