Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363DC48BF8
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 14:09:01 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.41280.1708349342817673237
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 05:29:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=AuVorYbN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-2024021913285937ec6e52321cd60167-apjukl@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024021913285937ec6e52321cd60167
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Feb 2024 14:28:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1JoWu9PAiCN2hVoKg+PdDxoQT6oYCUhpMdUHWU+3Y14=;
 b=AuVorYbNMGB1moO6WmByh+k/LYng/TQ1kkLJv/eCg7aicOvpla7tdWlp7YtrQF3TuC3/qt
 Z0frsfZo24SA+UqnqYCyNBaAk0MfA4EwLe+qtVDdhxr1hUKP/QbmbVrSBWt33enp5p2ce7aC
 yd1d/bopRQreRiP+0vuqIsXnyWplA=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC v4 0/3] Deploy swupdate images with empty var partition
Date: Mon, 19 Feb 2024 14:28:47 +0100
Message-Id: <20240219132850.68686-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 14:09:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15040

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

Changes since v3:

- add missing ISAR update patch

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

Felix Moessbauer (3):
  update ISAR to latest next for dh-compat improvements
  swupdate images: initially deploy empty var part
  copy and symlink dpkg db to ro-rootfs

 classes/read-only-rootfs.bbclass              | 10 ++++++++
 kas-cip.yml                                   |  3 ++-
 .../files/immutable-rootfs.tmpfiles           |  1 +
 .../immutable-rootfs/immutable-rootfs_0.1.bb  | 23 +++++++++++++++++++
 wic/bbb-efibootguard.wks.in                   |  4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          |  4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
 wic/x86-efibootguard.wks.in                   |  4 ++--
 11 files changed, 50 insertions(+), 15 deletions(-)
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb

-- 
2.39.2


