Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B39C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 13:15:46 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.16631.1706615835342378714
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 03:57:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Yoibo9Co;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-20240130115712234792cdb52ee9538a-jy9yup@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240130115712234792cdb52ee9538a
        for <cip-dev@lists.cip-project.org>;
        Tue, 30 Jan 2024 12:57:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Dad1M6XeQZK/SdqtXV/nLDGGSLg5y/sJ7LTRgJ9TH4E=;
 b=Yoibo9CohlNPwTW1AhtRBQWu9hNLlhQDdZQSvRYOr8XtO4GbMdteKuOWrOsVRry1WfpOyz
 WoCuwBb/xmNHELt7RB9WdhZWt1s6cz2sPH6IK5zD8iZrZUUD78NqFuX+XjN9IwZGAx0tgNek
 hoRzlP/2gJDfAcJEh8I7jDCyhunyU=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC 0/2] Deploy swupdate images with empty var partition
Date: Tue, 30 Jan 2024 12:56:46 +0100
Message-Id: <20240130115648.311177-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 13:15:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14497

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
- The dpkg database is copied to /usr/share/cip/var/lib/dpkg and a symlink
  is created on /var/lib/dpkg (using tmpdirs.d). By that, dpkg -l can still
  be used to query the installed packages and their versions. This feature
  is bookworm only due to the required debhelper-compat 13.

Note: This series needs to be applied on top of "refactor: use change-dir
to split rootfs parts"

References:

- https://lists.debian.org/debian-policy/2023/06/msg00016.html
- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1039979
- https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/75
- https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/50

Best regards,
Felix

Felix Moessbauer (2):
  copy and symlink dpkg db to ro-rootfs
  swupdate images: initially deploy empty var part

 classes/read-only-rootfs.bbclass              | 10 +++++++
 .../cip-read-only-rootfs_0.1.bb               | 26 +++++++++++++++++++
 .../files/cip-read-only-rootfs.tmpfiles       |  1 +
 .../cip-read-only-rootfs/files/control        | 11 ++++++++
 wic/bbb-efibootguard.wks.in                   |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |  2 +-
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  2 +-
 wic/qemu-arm64-efibootguard.wks.in            |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in          |  2 +-
 wic/x86-efibootguard.wks.in                   |  2 +-
 11 files changed, 55 insertions(+), 7 deletions(-)
 create mode 100644 recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
 create mode 100644 recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
 create mode 100644 recipes-core/cip-read-only-rootfs/files/control

-- 
2.39.2


