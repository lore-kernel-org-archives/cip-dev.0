Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAD5C282DC
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:28:12 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.10444.1741170491000831801
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 02:28:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=eMxKVyuA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2025030510280791d90a632620810c02-tvxbqs@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025030510280791d90a632620810c02
        for <cip-dev@lists.cip-project.org>;
        Wed, 05 Mar 2025 11:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=XwqRxT3a24TznFxBEDtxARmEY0xNKo/wey9a7K7gwPw=;
 b=eMxKVyuA+muWhbhAQG33Lw73GXucf6tOTRzMw3aBXdfvPuS7ZCiKfvh6Boq65Nfg/J7wbH
 gcBqb3WmkHS5kT/o9DSb3iF5PN7X6E/uYaEZ6ko+DqI9cIWzexQRl1TbH4XWyn5OtOAVtSa1
 mr9Ly4ujqbBU6WEQ7zT8UqW9+12OscOhB76fdchUQDyi6ksKmszsMVOLB2R8Jnapc4X8oE+t
 +aMNMhVQc5tl3dIcIVkDeq9/QovUj7XOYHDT65UcOwAkuVBnsTQhUOdBUYIEa0jTMz6Igk8u
 TcgjNum6Mn8Q05ngE/G5C1pg2Mp3X7e8toXj1OiHlhhDl9sMA0zITWxg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 0/6] Make /home partition optional
Date: Wed,  5 Mar 2025 11:27:39 +0100
Message-ID: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 10:28:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18036

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series would move /home to the /var/home and provided an symbolic
link to /home. All home directories created during user generation are
stored in /usr/share and are copied via systemd.tmpfiles to the correct
partition.

This allows to delete all content of the /home directory if necessary.

This move could interfere with existing installation and is therefore
optional in isar-cip-core.

Changes v3:
 - add Kconfig entry
 - Add ci variable
 - fix description in kas file
 - reworded commit message

Changes v2:
 - make move of /home to /var opt-out
 - fix recipes versions
 - fix comments and typos
 - use WIC_HOME_PARTITION instead of HOME_PARTITION_CMD
 - remove postinst from move-homedir-var


Quirin Gylstorff (6):
  read-only-rootfs: Make IMMUTABLE_DATA_DIR configurable
  read-only-rootfs: add home partition with a variable
  add move-homedir-var package
  Move content of home to IMMUTABLE_DATA_DIR
  Add Kconfig option for separate home partition
  add ci variable for separate home partition

 .gitlab-ci.yml                                |  3 +++
 Kconfig                                       | 10 ++++++++
 classes/read-only-rootfs.bbclass              | 22 ++++++++++++++++--
 kas/opt/encrypt-all.yml                       |  2 +-
 kas/opt/separate-home-partition.yml           | 21 +++++++++++++++++
 .../files/immutable-rootfs.tmpfiles           |  2 --
 .../files/immutable-rootfs.tmpfiles.tmpl      |  2 ++
 ...-rootfs_0.1.bb => immutable-rootfs_0.2.bb} |  6 ++++-
 .../files/move-homedir-var.tmpfiles.tmpl      |  3 +++
 .../move-homedir-var/move-homedir-var_0.1.bb  | 23 +++++++++++++++++++
 ...ook_0.6.bb => initramfs-crypt-hook_0.7.bb} |  2 +-
 wic/bbb-efibootguard.wks.in                   |  4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          |  5 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
 wic/x86-uefi-efibootguard-secureboot.wks.in   |  4 ++--
 wic/x86-uefi-efibootguard.wks.in              |  4 ++--
 18 files changed, 103 insertions(+), 22 deletions(-)
 create mode 100644 kas/opt/separate-home-partition.yml
 delete mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
 rename recipes-core/immutable-rootfs/{immutable-rootfs_0.1.bb => immutable-rootfs_0.2.bb} (73%)
 create mode 100644 recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
 create mode 100644 recipes-core/move-homedir-var/move-homedir-var_0.1.bb
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (98%)

-- 
2.47.0


