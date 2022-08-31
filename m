Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B3C54EE9
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 07:31:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web12.22582.1661931086517310959
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 00:31:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=kyQiC+ZA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220831073123e6e046ad431373c821-nrc6k1@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220831073123e6e046ad431373c821
        for <cip-dev@lists.cip-project.org>;
        Wed, 31 Aug 2022 09:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=IxaxJhky59O070V+ibpzdXIZOQDTzbHDwDb7Yj/kwCc=;
 b=kyQiC+ZA9SdUuX3YPbTpQIxE75Yg09lYjEROo04ZaB0DLb+ab+uM8vvXm3mBDu0doiR9p/
 w9emj5Z3XLe0Nla+6RRzQcPAAzz9ywj6GZI07oRmqYfWgQMAoQtOK0LVDcLrkHCEd1+WTIWB
 yawzhP0AN3fNd2upQe4pQrvoHaQ40=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	quirin.gylstorff@siemens.com,
	Shivanand.Kunijadar@toshiba-tsip.com
Subject: [isar-cip-core][PATCH 0/6] Enable SWUpdate support for bbb,
 update Isar
Date: Wed, 31 Aug 2022 09:31:15 +0200
Message-Id: <cover.1661931081.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 07:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9331

This primarily enables A/B rootfs SWUpdate for the BeagleBone Black, but
also updates the Isar revision and fixes an accidental host-side
dependency of the SWUpdate build.

Does anyone know how to make secure boot work with the BBB? Enabling the
software path should be just about building the needed config, but then
we still lack first-stage firmware validation by the hardware.

Next, it would be good to enable also a physical arm64 reference board
for SWUpdate. Any suggestions?

Jan


CC: dinesh.kumar@toshiba-tsip.com
CC: kazuhiro3.hayashi@toshiba.co.jp
CC: quirin.gylstorff@siemens.com
CC: Shivanand.Kunijadar@toshiba-tsip.com

Jan Kiszka (6):
  swupdate: Use cpio from buildchroot
  Update Isar revision
  linux-cip: Update cip-kernel-config revision
  u-boot-bbb: Switch BeagleBone Black to self-built U-Boot
  swupdate: Drop u-boot-script from EFI Boot Guard images
  Enable BeagleBone Black images with A/B SWUpdate support

 Kconfig                                       |  2 +-
 classes/swupdate.bbclass                      | 53 ++++++++++---------
 conf/machine/bbb.conf                         |  8 ++-
 ...ernel-Check-if-CONFIG_MODULES-is-set.patch | 33 ------------
 kas-cip.yml                                   |  6 +--
 kas/opt/ebg-swu.yml                           |  1 +
 recipes-bsp/u-boot/u-boot-bbb_2022.07.bb      | 22 ++++++++
 ...boot-qemu-common.inc => u-boot-common.inc} | 11 ----
 recipes-bsp/u-boot/u-boot-qemu-common.inc     | 26 +--------
 recipes-kernel/linux/linux-cip-common.inc     |  2 +-
 wic/bbb-efibootguard.wks.in                   | 21 ++++++++
 wic/bbb.wks                                   |  4 +-
 12 files changed, 84 insertions(+), 105 deletions(-)
 delete mode 100644 isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
 create mode 100644 recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
 copy recipes-bsp/u-boot/{u-boot-qemu-common.inc => u-boot-common.inc} (75%)
 create mode 100644 wic/bbb-efibootguard.wks.in

-- 
2.35.3


