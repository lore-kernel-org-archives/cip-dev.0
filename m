Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C730D767D1
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:33:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14145.1766140433256703657
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 02:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Ypm8tRuM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20251219103350bb8c0fd64500020765-8bf8tt@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251219103350bb8c0fd64500020765
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Dec 2025 11:33:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=B+uIjz9tin0xPFITnFjLSKVEGjNVxKov4LP3njaxU2U=;
 b=Ypm8tRuMHk/k5Eoe3cW6AOh4pVIfNqPjMx7jmiGAizpgrPeEk4gEnwTYE2eswakgfjiZUR
 vvqXhgatOwY0EqJlGY98kIM4R0T8x4QfYstovsOW/ckhOvll3596LYjeNc5MeMlsHwgrkiEz
 2iTCmPnGgDotoKqpC+uXCR5SAgRd73cujs1CUjN/7iYLEFco9n0pFr3weYCHNbjzN0wmkimS
 gmULkShtTD7HvNvit2pLHCH4nfb0g2YtipQ7dsk7vYap/Lv2IuVHZdrSXBRBImbS4+4A2rin
 /nWSqNb2udFKBe7/jPxrrY4xIj002ZG5eC/V6Lc0IkTzQXO+xc/kEN5Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/6] Simplify the use of
Date: Fri, 19 Dec 2025 11:31:20 +0100
Message-ID: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21167

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The goal is to document and simplify the necessary steps to create
a A/B Root file system which can be update with SWUpdate.

Quirin Gylstorff (6):
  kas: move initramfs-tool specific recipes to cip-core-initramfs
  Move RO_ROOTFS Options to swupdate.inc
  Default SWUPDATE_BOOTLOADER to efibootguard
  Move efibootguard to swupdate-efibootguard.inc
  Add swupdate-config to swupdate.inc
  Add documentation how to integrate isar-cip-core

 classes-recipe/efibootguard.bbclass           | 64 ++---------------
 doc/README.usage.md                           | 55 +++++++++++++++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  3 -
 kas/opt/ebg-swu.yml                           |  5 --
 kas/opt/swupdate.yml                          |  6 --
 recipes-core/customizations/common.inc        |  2 -
 recipes-core/images/efibootguard.inc          | 13 +---
 recipes-core/images/swupdate-efibootguard.inc | 70 +++++++++++++++++++
 recipes-core/images/swupdate.inc              | 16 +++++
 .../swupdate-handler-roundrobin_0.1.bb        |  1 +
 .../cip-core-initramfs/cip-core-initramfs.bb  |  7 ++
 11 files changed, 155 insertions(+), 87 deletions(-)
 create mode 100644 doc/README.usage.md
 mode change 100644 => 120000 recipes-core/images/efibootguard.inc
 create mode 100644 recipes-core/images/swupdate-efibootguard.inc

-- 
2.51.2


