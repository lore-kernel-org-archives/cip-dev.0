Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8BD1D472
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:02 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8640.1767885416528865130
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 07:16:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=El3fTSn1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20260108151653369c0033c5000207c6-uh2pu_@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260108151653369c0033c5000207c6
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Jan 2026 16:16:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=R9oo4clOKs6axuHET44oziMaRLYcpmbBh0fdUhD2w2g=;
 b=El3fTSn1ZC0GK2aht0xtbwNr2ksJl+aN86aAscmNEnQ/HlUO6ogB0/OaFptbVJBPLYvfB+
 B+mQsRxQd1oIJdYzP64eyxkGgsh+S3s3K5IyhuRqHI/8jq0iOZa5bjfwXccyZtGDlkVEwRy4
 cu5gKk+M5GjrY9UOSdrNpnMAmc/YJL+ydtXJY0H5Rr22hZUchLzpR4eUmMnAtqKx2MLkH8MY
 dg1ntwoZV9o2hpN/a8HVw3D9MJuKvVHFDwzayBYn8AeOMLMQym8VLf6LCHne9TajWP95H0CP
 qmBy6muPPCrD5l4oroRUVOnnYV0ILUZLhgXft03U1uzPGUgBO9SIqzug==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	benedikt.niedermayr@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 0/7]  Simplify the use of isar-cip-core in downstream layers
Date: Thu,  8 Jan 2026 16:16:07 +0100
Message-ID: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 15:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21481

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The goal is to document and simplify the necessary steps to create
a A/B Root file system which can be update with SWUpdate.

Changes v3:
 - Rename README.usage.md to README.layer-integration.md
 - update Copyright date
 - use swupdate-ab-rootfs.inc instead of swupdate-ab-rootfs.bbclass
   as this file contains isar-cip-core specific defaults

Changes v2:
 - remove outdated information from documentation
 - remove unnecessary default assignment of variable
 - Add patch to rename recipe-core/images/swupdate.inc to clarify the
   intended use


Quirin Gylstorff (7):
  kas: move initramfs-tool specific recipes to cip-core-initramfs
  Move RO_ROOTFS Options to swupdate.inc
  Default SWUPDATE_BOOTLOADER to efibootguard
  Move efibootguard to swupdate-efibootguard.inc
  Add swupdate-config to swupdate.inc
  Add documentation how to integrate isar-cip-core
  rename recipes-core/images/swupdate.inc to swupdate-ab-rootfs.inc

 classes-recipe/efibootguard.bbclass           | 64 ++---------------
 doc/README.layer-integration.md               | 51 ++++++++++++++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  5 +-
 kas/opt/ebg-swu.yml                           |  7 +-
 kas/opt/swupdate.yml                          | 10 +--
 recipes-core/customizations/common.inc        |  4 +-
 recipes-core/images/efibootguard.inc          | 13 +---
 recipes-core/images/swupdate-ab-rootfs.inc    | 61 ++++++++++++++++
 recipes-core/images/swupdate-efibootguard.inc | 70 +++++++++++++++++++
 recipes-core/images/swupdate.inc              | 47 +------------
 .../swupdate-handler-roundrobin_0.1.bb        |  3 +-
 .../cip-core-initramfs/cip-core-initramfs.bb  |  9 ++-
 12 files changed, 204 insertions(+), 140 deletions(-)
 create mode 100644 doc/README.layer-integration.md
 mode change 100644 => 120000 recipes-core/images/efibootguard.inc
 create mode 100644 recipes-core/images/swupdate-ab-rootfs.inc
 create mode 100644 recipes-core/images/swupdate-efibootguard.inc
 mode change 100644 => 120000 recipes-core/images/swupdate.inc

-- 
2.51.2


