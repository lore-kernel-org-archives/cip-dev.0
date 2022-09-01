Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD201ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 13:49:23 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web12.12327.1662040155782829968
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 06:49:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=F6f1Cg98;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-2022090113491212f22093be49cc44d8-gkv2pe@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2022090113491212f22093be49cc44d8
        for <cip-dev@lists.cip-project.org>;
        Thu, 01 Sep 2022 15:49:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=G3PtPjXvIAFl/LGjKXAb81k6tL5CK+Vjig8c0qudimE=;
 b=F6f1Cg98OmfBgEki6lh3R34pNBBRhJ9SfW3KhFUgBmJOv2q78IvUyLDBLof7JSwdcvDPrA
 ne+BQL4p7y0QwAZPz8aIqv6k7ok2d5hq1CaaExbQW5G/LExqbwchE3JFUVj/MCnlGzoG3kji
 gaHIrewQpPp7DP/wD7lZErxW6hC0c=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/3] ci: Switch qemu-amd64-secure-boot-buster
 to 5.10 kernel
Date: Thu,  1 Sep 2022 15:49:10 +0200
Message-Id: 
 <df5588b1ff78482bedecdfa4c67a1668d5dee481.1662040151.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1662040151.git.jan.kiszka@siemens.com>
References: <cover.1662040151.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 13:49:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9421

From: Jan Kiszka <jan.kiszka@siemens.com>

Since 05dd963af058, 4.19 and older are no longer supported for SWUpdate
and secure boot setups. Adjust the configuration accordingly, also
because it is now failing to build this invalid combination.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 41af3e9..477ec63 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -278,6 +278,7 @@ build:qemu-amd64-secure-boot-buster:
   extends:
     - .build_base
   variables:
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/5.10.yml"
     release: buster
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
-- 
2.35.3


