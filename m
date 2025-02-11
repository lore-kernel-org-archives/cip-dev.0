Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC1C0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 08:51:38 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.7770.1739263889187091525
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 00:51:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=d1O8ekmk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202502110851269bc47028823d9db890-w8cgbw@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202502110851269bc47028823d9db890
        for <cip-dev@lists.cip-project.org>;
        Tue, 11 Feb 2025 09:51:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=9C1MjNDdCYAT3xdRZmGxr28PQZ12l9awOO1jGOgVO1k=;
 b=d1O8ekmk937j9ZWvfzj+TNfilAOP5Pd0UfppSRWQr3y07jPcTjWyE7BCZbICZqtsAKF/QR
 /us7U4pDLIN56tGlgMhWc60UFnDRKWhh9xAzuKNyrzskeFtNsrkoEoxnAyUNQq9mcbqeLrH8
 L94b+jCFcGaLpQpNhGoj1lCQBYEE5aZp7ddyFyvHaIvC/0rA/k0Nudh26JVOT+Z+d2kII1Ln
 fNZ73XyiM8/UfUQpaYUSmGPl4cRAbfdF4bSmo9yzx0sj9gcrDtoE/B58RcpfOp1li56brmqP
 C1zU21DwbCsQ9kGF/SZddDBsfes7nwyWQfeAsnRMrU7ogjhNglXKPstA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	ludwig.nussel@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/4] Make /home partition optional
Date: Tue, 11 Feb 2025 09:49:07 +0100
Message-ID: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 08:51:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17806

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This proposal would move /home to the /var/home and provided an symbolic
link to /home. All home directories created during user generation are
stored in /usr/share and are copied via systemd.tmpfiles to the correct
partition.

This allows to delete all content of the /home directory if necessary.

This move could interfere with existing installation and is therefore
optional in isar-cip-core.

Does somebody know of downstream layers which directly is the WKS files
from isar-cip-core?

Quirin Gylstorff (4):
  read-only-rootfs: Make IMMUTABLE_DATA_DIR configurable
  read-only-rootfs: add home partition with a variable
  add move-homedir-var package
  Move content of home to IMMUTABLE_DATA_DIR

 classes/read-only-rootfs.bbclass              | 16 ++++++++++++-
 kas/opt/home-to-var.yml                       | 21 ++++++++++++++++
 .../files/immutable-rootfs.tmpfiles           |  2 --
 .../files/immutable-rootfs.tmpfiles.tmpl      |  2 ++
 .../immutable-rootfs/immutable-rootfs_0.1.bb  |  6 ++++-
 .../files/move-homedir-var.tmpfiles.tmpl      |  3 +++
 recipes-core/move-homedir-var/files/postinst  | 20 ++++++++++++++++
 .../move-homedir-var/move-homedir-var_0.1.bb  | 24 +++++++++++++++++++
 wic/bbb-efibootguard.wks.in                   |  4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          |  5 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
 wic/x86-uefi-efibootguard-secureboot.wks.in   |  4 ++--
 wic/x86-uefi-efibootguard.wks.in              |  5 ++--
 15 files changed, 104 insertions(+), 20 deletions(-)
 create mode 100644 kas/opt/home-to-var.yml
 delete mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
 create mode 100644 recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
 create mode 100644 recipes-core/move-homedir-var/files/postinst
 create mode 100644 recipes-core/move-homedir-var/move-homedir-var_0.1.bb

-- 
2.47.0


