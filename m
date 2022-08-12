Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61343C25B0F
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 09:51:25 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.8859.1660297876150477407
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 02:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=jiymF45v;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220812095113318cd615d0b8f7006a-lgsnqv@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220812095113318cd615d0b8f7006a
        for <cip-dev@lists.cip-project.org>;
        Fri, 12 Aug 2022 11:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=hdR+y0sDTUBs6+4tj+hEhyxHbL5pGRFr6d7CEofnDjM=;
 b=jiymF45vQehcgdtlKQlY89vftQVYh8s7tMpp6HyPLBuXU29JqzatKRQz2dWrOtZQJmIMxJ
 Ky6B0xPFyhNaWXznFWPIbXqJNVxHnE/2uzVpYFWt8O7ln+KL/XDeG7Ks07Bo6BhofRZHkfsm
 mN27ZOerwqfp4+dZUZJYjUHBcJxDY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 0/3] clean up kas/opt
Date: Fri, 12 Aug 2022 11:51:09 +0200
Message-Id: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 09:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9170

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

Changes V5:
 - Fix set WKS_FILE in case by using default instead of weak assignment
 - reoder patches
 - rebase onto 29d3546 origin/next


Quirin Gylstorff (3):
  initramfs-*-hook: Add DEBIAN_CONFLICTS
  kas/opt/swupdate: Move the package installation to swupdate.inc
  kas: Remove efibootguard.yml

 kas/opt/ebg-secure-boot-snakeoil.yml          | 11 ++----
 kas/opt/ebg-swu.yml                           | 18 +++++++--
 kas/opt/efibootguard.yml                      | 39 -------------------
 kas/opt/swupdate.yml                          |  4 --
 recipes-core/images/efibootguard.inc          | 18 +++++++++
 recipes-core/images/swupdate.inc              |  3 ++
 .../initramfs-abrootfs-hook_0.1.bb            |  1 +
 .../initramfs-verity-hook_0.1.bb              |  1 +
 8 files changed, 41 insertions(+), 54 deletions(-)
 delete mode 100644 kas/opt/efibootguard.yml
 create mode 100644 recipes-core/images/efibootguard.inc

-- 
2.35.1


