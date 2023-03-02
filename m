Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CEC7EE36
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 20:31:01 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.5532.1677789060014002899
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 12:31:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=b2xsW6OP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20230302203056edc49861d50a9caa4b-9mnyvx@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230302203056edc49861d50a9caa4b
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 21:30:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n/PATM8WHtASMOcmYVCQa8Vg8M8klsAQdpNThe4TzjU=;
 b=b2xsW6OPo6Hh0HaED5TXCxgFOun2CBU8v0vM9TJbElUbyWOZE7jzZGH5mg1BZ2PKyiLlq2
 OHUrcbqporxb+6WHUFZksVeW9dwUm8Sh2EXmJUOh1nrQghd5sw5KHtgh9cis6nt5qs0RF4lD
 FlPEOvcdRh/9iHdCkkKroDJs9qCCc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/5] swupdate: Avoid open-coding IMAGE_FULLNAME
Date: Thu,  2 Mar 2023 21:30:50 +0100
Message-Id: <4b6435e74e0d9d396ff75e9a834715f4a3011f7f.1677789054.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1677789054.git.jan.kiszka@siemens.com>
References: <cover.1677789054.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 20:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10890

From: Jan Kiszka <jan.kiszka@siemens.com>

This will break if IMAGE_FULLNAME is not PN-DISTRO-MACHINE, e.g. when
enabling kas/ops/test.yml.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 9fcaf3c2..064d0ad5 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -15,7 +15,7 @@ SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 SWU_COMPRESSION_TYPE ?= "zlib"
 SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
 
-SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
+SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
 SWU_SIGNED ?= ""
-- 
2.35.3


