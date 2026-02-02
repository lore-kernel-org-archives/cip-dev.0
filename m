Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2923E73172
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51895.1770037072080368655
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=OuOPoB3Q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202602021257509cebd3791f0002072c-b3ptun@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202602021257509cebd3791f0002072c
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=lEZoQ29HP1RPOw5a76J18A1hgp32SI/CnyzjCV3mR7w=;
 b=OuOPoB3Qqmg4pRXyVz1W1nMVgeyqm15ElCnmgioVOypYM0zKYrGhmuuS3oW+SLdlV4YBfS
 Xymgzv1wi8Ea1Umgm7dOag2RnQb6VaJ4LaDloco7dm32WmhcSKDaA2mR+Ix6WBKiavELEnzI
 ID5JiHojywxrASmpISdYr9AaBUCknnqKLLiHUUoR6f4IW+HMvISYPg8GM1+79V0lhGB5RNO3
 nZHe4K9zGYBzI9QbT89WScn3DHh9+9bPG0LITVP874L5r7J4AG/at/b+PE4p8Onon/JaOUht
 MVJfENPSKydBc3bgwus6tVx2uOqIkv+RxpZ/GNFEqWdozg+Ew5/CoTQg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 9/9] ci: Add BeagleV-Fire build target
Date: Mon,  2 Feb 2026 13:57:48 +0100
Message-ID: <f0275526b3a388773700b895e06e6a58f1cc934d.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21800

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index db8d642e..602c5034 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,6 +164,13 @@ build:qemu-riscv64:
     target: qemu-riscv64
     use_rt: disable
 
+build:beaglev-fire:
+  extends:
+    - .build_base
+  variables:
+    target: beaglev-fire
+    use_rt: enable
+
 # test images
 build:x86-uefi-test:
   extends:
-- 
2.51.0


