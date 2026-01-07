Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C472CFD62E
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:27:25 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5662.1767792443620165482
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:27:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=D6nP/EEE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202601071327162048e53fde000207bd-w8_omr@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202601071327162048e53fde000207bd
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Jan 2026 14:27:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=73j3EWVtd+JUo3cIJ4X8cTiTgf6IBTQyWhvfMbx1S+A=;
 b=D6nP/EEE3Wg9rY12K7e0Bhj4JXlpCiALOsbdqczb1ykn+d17uEuiiVX43LpadQWNTs0+L2
 nrS9cknV5uJ6FLnwA5n8mg5M98HGdydnqqXoAGVAk3bkzZtEdZUceqRVW4EeyNmpM9fVi4nm
 rvoUvcQ1nywzlvHu2hMzZE+oOqSFpsdr2YM7W53QANa3ux1W7ePjhOm/avbwjzX7iSlfCV9N
 aGaJEvjdcz7pdbjq+sQZ/YIxkQljqwu22DTe7xjjh+68pPEwtc1/uyV8hqirXP2YHMNqHSVg
 8bvQFhNtzY0qTMDyrapHdnKw8Ma96Nc7aJnRMaM5qdxi51F0Vd0OVLBg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/7] Simplify the use of isar-cip-core in downstream layers
Date: Wed,  7 Jan 2026 14:26:23 +0100
Message-ID: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21403

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The goal is to document and simplify the necessary steps to create
a A/B Root file system which can be update with SWUpdate.

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
 classes-recipe/swupdate-ab-rootfs.bbclass     | 52 ++++++++++++++
 doc/README.usage.md                           | 51 ++++++++++++++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  3 -
 kas/opt/ebg-swu.yml                           |  5 --
 kas/opt/swupdate.yml                          |  8 +--
 recipes-core/customizations/common.inc        |  2 -
 recipes-core/images/efibootguard.inc          | 13 +---
 recipes-core/images/swupdate-efibootguard.inc | 70 +++++++++++++++++++
 recipes-core/images/swupdate.inc              | 47 +------------
 .../swupdate-handler-roundrobin_0.1.bb        |  1 +
 .../cip-core-initramfs/cip-core-initramfs.bb  |  7 ++
 12 files changed, 189 insertions(+), 134 deletions(-)
 create mode 100644 classes-recipe/swupdate-ab-rootfs.bbclass
 create mode 100644 doc/README.usage.md
 mode change 100644 => 120000 recipes-core/images/efibootguard.inc
 create mode 100644 recipes-core/images/swupdate-efibootguard.inc
 mode change 100644 => 120000 recipes-core/images/swupdate.inc

-- 
2.51.2


