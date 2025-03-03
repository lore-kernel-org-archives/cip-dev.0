Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF34FC282D4
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 11:23:54 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.50855.1741001026225927689
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 03:23:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=To9qyCJv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2025030311234316d0c0db6d92383862-th8gcz@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025030311234316d0c0db6d92383862
        for <cip-dev@lists.cip-project.org>;
        Mon, 03 Mar 2025 12:23:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=0IBHMBY1T+MXUfKOA1RCey26JK4PjCQp+tx8NxJrYQU=;
 b=To9qyCJvlZszT5e4t00+e+kIHc/ndbv04+rZBYMIGj7BuyQYKTq8ueXupo6wyiqPtj3DlM
 M6ubXFnBrJygKCPtpmLY9kaS8yB27QlMZDh7hrCWH+q9skOVdCvamgvPh+aXVaMopwIu5lW6
 HhwbEIBfo0Ot1JrHT0eZpYq3pMhO20jJma6ilwAmGVP1lOLvnMnEUde6ZuOUjkfI9M3KSE5B
 XIvqhwVXjv/J++oRAxP2BLGYEr5X7mv844TOm0s/nd3E8JnJOCLB4jGOc9DWYMVWHK9Tlnw6
 6XZ59PUDSH8q8j0H2wOfR0Ce4q6fGp2yDxUz0r2KR+WSzEBw9GHF+5cg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	ludwig.nussel@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4] Make /home partition optional
Date: Mon,  3 Mar 2025 12:21:44 +0100
Message-ID: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 11:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17998

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series would move /home to the /var/home and provided an symbolic
link to /home. All home directories created during user generation are
stored in /usr/share and are copied via systemd.tmpfiles to the correct
partition.

This allows to delete all content of the /home directory if necessary.

This move could interfere with existing installation and is therefore
optional in isar-cip-core.

Changes v2:
 - make move of /home to /var opt-out
 - fix recipes versions
 - fix comments and typos
 - use WIC_HOME_PARTITION instead of HOME_PARTITION_CMD
 - remove postinst from move-homedir-var

Quirin Gylstorff (4):
  read-only-rootfs: Make IMMUTABLE_DATA_DIR configurable
  read-only-rootfs: add home partition with a variable
  add move-homedir-var package
  Move content of home to IMMUTABLE_DATA_DIR

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
 16 files changed, 90 insertions(+), 22 deletions(-)
 create mode 100644 kas/opt/separate-home-partition.yml
 delete mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
 rename recipes-core/immutable-rootfs/{immutable-rootfs_0.1.bb => immutable-rootfs_0.2.bb} (73%)
 create mode 100644 recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
 create mode 100644 recipes-core/move-homedir-var/move-homedir-var_0.1.bb
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (98%)

-- 
2.47.0


