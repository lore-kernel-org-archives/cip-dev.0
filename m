Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39DCC3527D
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 17:48:47 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.1388.1650384423098007920
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Apr 2022 09:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=lnl42Rn6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20220419160659546a7bcc4de80798fd-i95jz2@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220419160659546a7bcc4de80798fd
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Apr 2022 18:06:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2ax1jSfGeeMMxmJEvzbSryTXt6SXx0zVud+APQnImaE=;
 b=lnl42Rn6zyEe3xagXaPEny1wjrLUpD6St9GhEeER8TgoFMf+XmrAZUJfA0Hcfa6Ul09eq7
 5Z03q0M4lTfYkT5xlOmmSDENdL9IyHVU5vAyV1rbeG8E4Fv6UEQN+5uCgFCSrzz6YFKYB0dC
 584/xzOPid9cCe4JfQuBvoRAkNLWg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 0/5] Read-only rootfs for non-secure swupdate /
 cleanups / fixes
Date: Tue, 19 Apr 2022 18:06:53 +0200
Message-Id: <cover.1650384418.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Apr 2022 17:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8110

Unifies secure and non-secure swupdate variants further by using a
read-only rootfs in both cases. See patchs for more details.

Applies on top of "SWUpdate & EFI Boot Guard refactorings".

Jan

Jan Kiszka (5):
  squashfs-img: Cosmetic cleanups
  verity-img: Inherit the source image type class directly
  swupdate: Make rootfs read-only also in non-secure setup
  Restrict OVMF to qemu-amd64 machine
  wic: Drop redundant / misleading --ondisk sda parameters

 classes/secure-wic-swu-img.bbclass            |  9 +-----
 classes/squashfs-img.bbclass                  | 12 ++++----
 classes/verity-img.bbclass                    | 10 +++++--
 classes/wic-swu-img.bbclass                   | 23 ++++++++++++++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  7 ++---
 kas/opt/efibootguard.yml                      | 12 ++++----
 kas/opt/swupdate.yml                          |  2 +-
 recipes-core/images/read-only.inc             | 30 -------------------
 wic/ebg-signed-bootloader.inc                 |  2 +-
 wic/ebg-sysparts.inc                          |  6 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 12 ++++----
 wic/qemu-amd64-efibootguard.wks               |  6 ----
 wic/qemu-amd64-efibootguard.wks.in            |  1 +
 wic/simatic-ipc227e-efibootguard.wks          |  7 -----
 wic/simatic-ipc227e-efibootguard.wks.in       |  1 +
 wic/simatic-ipc227e.wks                       |  4 +--
 wic/swupdate-partition.inc                    |  2 --
 wic/x86-efibootguard.wks.in                   | 13 ++++++++
 18 files changed, 74 insertions(+), 85 deletions(-)
 delete mode 100644 recipes-core/images/read-only.inc
 delete mode 100644 wic/qemu-amd64-efibootguard.wks
 create mode 120000 wic/qemu-amd64-efibootguard.wks.in
 delete mode 100644 wic/simatic-ipc227e-efibootguard.wks
 create mode 120000 wic/simatic-ipc227e-efibootguard.wks.in
 delete mode 100644 wic/swupdate-partition.inc
 create mode 100644 wic/x86-efibootguard.wks.in

-- 
2.34.1


