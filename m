Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E73C48BF8
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 14:08:51 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.39712.1708344550247537238
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 04:09:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=NeThSpca;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1321639-202402191209064e6fb4f7d8f752addb-s_bfym@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202402191209064e6fb4f7d8f752addb
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Feb 2024 13:09:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=w596x4tIC8DmYwxe+iAABP4cICUlcsP6JhhDvUZgcB8=;
 b=NeThSpcaCXmHJQTTm54u01CR07Y6ct382+Q5En5f/XiIQ6vz+qJJsDebLu5NKAnWmTLiED
 uo7JeSjEU0dmesv4RPOJnwcXNybnFAWvV1VqSTHWXBbC3D/ynUJtK77sIlyXDotN21h/vyoT
 sV77pNGxiN3n7YBmH9S21mbJJe0t8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC v3 0/2] Deploy swupdate images with empty var partition
Date: Mon, 19 Feb 2024 13:08:56 +0100
Message-Id: <20240219120858.59136-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 14:08:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15037

This patch series prepares and switches the rootfs configuration to be
deployed with an empty /var partition. For now, I send this as an RFC,
as this needs to be tested by a broader audience.

A couple notes about the implementation:

- the /var partition is deployed as empty file system
  (and not included in the squashfs)
- no warnings are issued on files / dirs that are pre-populated in /var.
  It has been tested if this is possible, but unfortunately many packages
  use both tmpdirs.d as well as postinstall scripts to create the files.
  This might be the result of a transition phase, but makes it impossible
  to detect potential issues. Also the tmpdirs.d configuration does not
  necessarily come from the same package as the dir creation in postinst.
- The dpkg database is copied to /usr/share/immutable-data/var/lib/dpkg
  and a symlink is created on /var/lib/dpkg (using tmpdirs.d). By that,
  dpkg -l can still be used to query the installed packages and their
  versions. This feature is bookworm only due to the required
  debhelper-compat 13.

Note: This series needs to be applied on top of "refactor: use change-dir
to split rootfs parts"

Changes since v2:

- rebased onto next
- updated ISAR to get better debhelper-compat support
- updated immutable-rootfs to use ISAR debhelper-compat infrastructure

Changes since v1:

- rebase onto next
- copy immutable dpkg-db to /usr/share/immutable-data instead of .../cip

References:

- https://lists.debian.org/debian-policy/2023/06/msg00016.html
- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1039979
- https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/75
- https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/50

Best regards,
Felix

Felix Moessbauer (2):
  swupdate images: initially deploy empty var part
  copy and symlink dpkg db to ro-rootfs

 classes/read-only-rootfs.bbclass              | 10 ++++++++
 .../files/immutable-rootfs.tmpfiles           |  1 +
 .../immutable-rootfs/immutable-rootfs_0.1.bb  | 23 +++++++++++++++++++
 wic/bbb-efibootguard.wks.in                   |  4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          |  4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
 wic/x86-efibootguard.wks.in                   |  4 ++--
 10 files changed, 48 insertions(+), 14 deletions(-)
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb

-- 
2.39.2


