Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C68C19F2D
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 10:41:07 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.10232.1660041664194529107
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Aug 2022 03:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=I0QZEVRC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-51332-20220809104101e513c9cb5d7f4958d7-o_d0yk@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20220809104101e513c9cb5d7f4958d7
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Aug 2022 12:41:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=jmgX4e/NBfh5aKGlBSrHVS6LDgTf4JSHQ7PmWMYb4hg=;
 b=I0QZEVRCz/7SajcC9KLy/wKPHkLHLQr4HmdbC/MgCJVVQ0Ly5s1hdLbuZ6scaYaiPXnsa5
 YiliXOyn9srQHszG/G6TIKZIbtBCgH8AJ2Tqg6VV/NGFIUURoIQCrMllIrAD07F/VLkWEeX1
 J/wxUIfK6uSOlaMCnreEgG2iKB7gw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 0/3] clean up kas/opt
Date: Tue,  9 Aug 2022 12:40:57 +0200
Message-Id: <20220809104100.469265-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Aug 2022 10:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9143

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Remove the kas option for efibootguard as it cannot build a image.
Move the package installation for swupdate to the include.

Changes V2:
 - Readd WICVARS(KERNEL_IMAGE INITRD_IMAGE DTB_FILES)
 - Fix setting WKS_FILE for ebg_swu

Changes V3:
 - Fix assignment of WKS_FILE
   - use weak assignment in conf/distro/cip-core-common.inc

Changes V4:
 - Move `firmware-binaries` to kas/opt/ebg-swu
 - kas/opt/ebg-secure-boot-snakeoil now depends on ebg-swu
 - add DEBIAN_CONFLICTS between initramfs-verity-hook and initramfs-abrootfs-hook
   as the system stucks in a reboot loop if both are installed.

Quirin Gylstorff (3):
  kas: Remove efibootguard.yml
  kas/opt/swupdate: Move the package installation to swupdate.inc
  initramfs-*-hook: Add DEBIAN_CONFLICTS

 conf/distro/cip-core-common.inc               |  2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml          | 11 ++----
 kas/opt/ebg-swu.yml                           | 17 ++++++--
 kas/opt/efibootguard.yml                      | 39 -------------------
 kas/opt/swupdate.yml                          |  4 --
 recipes-core/images/efibootguard.inc          | 19 +++++++++
 recipes-core/images/swupdate.inc              |  3 ++
 .../initramfs-abrootfs-hook_0.1.bb            |  1 +
 .../initramfs-verity-hook_0.1.bb              |  1 +
 9 files changed, 42 insertions(+), 55 deletions(-)
 delete mode 100644 kas/opt/efibootguard.yml
 create mode 100644 recipes-core/images/efibootguard.inc

-- 
2.35.1


