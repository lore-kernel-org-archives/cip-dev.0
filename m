Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6DCCA483
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:04 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.156.1657568461912458968
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=MDjOJ+jj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202207111940598ed32efeb12933542c-qisxc3@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202207111940598ed32efeb12933542c
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:40:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=65MAAOt6CmNSgVHU9SqCiFC905MiXXRqQc0Fyaiejjk=;
 b=MDjOJ+jjnee0vmt8dTb/0k5jJBXfgERkJbbV27MAUILa76zUOKSyv1i03l39qiwvpFukob
 eGG+xegu/VuMai6jyTvNFiP7U/2qaIoCAa8cDoVcbiQLjHN+OmNNC0sAAH2KMpeMinXX00Xz
 nQZXXqFMRI1/yaRYWoNhybyQPw7uA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 0/7] SWUpdate/secure boot for ARM,
 related recipe updates
Date: Mon, 11 Jul 2022 21:40:51 +0200
Message-Id: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8743

Finally, this enables also 32-bit ARM for UEFI-based SWUpdate and secure
boot, analogously to ARM64. We need to update EFI Boot Guard to 0.12 and
also bump the cip-kernel-config revision for this. U-Boot is updated to
fix a security bug in its hash validation code for signed UEFI binaries.

One special patch is needed for the efibootguard plugin: mcopy from
buster does not work properly with recursive copying, and that breaks
the boot partition setup.

Jan

Jan Kiszka (7):
  linux-cip: Update cip-kernel-config revision
  efibootguard: Do not rely on mcopy to perform recursive copies
  efibootguard: Update to release 0.12
  u-boot-qemu-arm64: Update to 2022.07
  u-boot-qemu-arm64: Generalize the recipe
  Add support for ARM-based swupdate/secure boot image
  ci: Add qemu-arm target for secure boot with swupdate

 .gitlab-ci.yml                                |  12 ++
 Kconfig                                       |   4 +-
 conf/machine/qemu-arm.conf                    |   5 +
 conf/machine/qemu-arm64.conf                  |   2 +
 kas/opt/efibootguard.yml                      |   1 +
 ...bootguard_0.11.bb => efibootguard_0.12.bb} |   5 +-
 ...efile-Drop-nostdinc-for-EFI-binaries.patch |  28 -----
 ...-rtc_mktime-and-mktime64-Y2038-ready.patch | 107 ------------------
 recipes-bsp/u-boot/files/secure-boot.cfg      |   6 -
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |   6 +
 .../u-boot/u-boot-qemu-arm64_2022.07.bb       |  16 +++
 recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb |  16 +++
 ...rm64_2022.04.bb => u-boot-qemu-common.inc} |  11 +-
 recipes-kernel/linux/linux-cip-common.inc     |   2 +-
 .../wic/plugins/source/efibootguard-boot.py   |   1 +
 .../wic/plugins/source/efibootguard-efi.py    |   7 +-
 start-qemu.sh                                 |   4 +-
 wic/qemu-arm-efibootguard-secureboot.wks.in   |   1 +
 wic/qemu-arm-efibootguard.wks.in              |   1 +
 19 files changed, 80 insertions(+), 155 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.11.bb => efibootguard_0.12.bb} (85%)
 delete mode 100644 recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch
 delete mode 100644 recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
 delete mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg
 create mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
 rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2022.04.bb => u-boot-qemu-common.inc} (77%)
 create mode 120000 wic/qemu-arm-efibootguard-secureboot.wks.in
 create mode 120000 wic/qemu-arm-efibootguard.wks.in

-- 
2.35.3


