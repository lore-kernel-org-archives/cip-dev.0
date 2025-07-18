Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D20CC83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:10:42 +0000 (UTC)
Received: from smtp.priv.miraclelinux.com (smtp.priv.miraclelinux.com [202.210.215.66])
 by mx.groups.io with SMTP id smtpd.web10.17491.1752833431754365502
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: miraclelinux.com, ip: 202.210.215.66, mailfrom: hirotaka.motai@miraclelinux.com)
Received: from 120i.miraclelinux.com (21A0120i.priv.miraclelinux.com [10.2.0.233])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 2447C140072;
	Fri, 18 Jul 2025 19:10:30 +0900 (JST)
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/5] Add zyncmp-zcu102 board support
Date: Fri, 18 Jul 2025 19:09:03 +0900
Message-ID: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19558

This series adds support for the Zynq MP ZCU102 into isar-cip-core.

- Kernel and rootfs version notes

This board is started to suport by the 6.1-cip kernel with Debian 12.

- U-boot notes

The U-boot shipped with the board is used and is out-of-scope in
isar-cip-core support. I used TFTP and NFS to boot over the network.
The user needs to setup some u-boot environment variables as described in
doc/boards/README.zynqmp-zcu102.md


Hirotaka Motai (5):
  zynqmp-zcu102: Add board support
  zynqmp-zcu102: add setting for kernel image and dtb
  zynqmp-zcu102: add wic
  zynqmp-zcu102: add kas yml
  zynqmp-zcu102: add README.zynqmp-zcu102

 Kconfig                            |  5 ++++
 conf/machine/zynqmp-zcu102.conf    | 24 +++++++++++++++
 doc/boards/README.zynqmp-zcu102.md | 48 ++++++++++++++++++++++++++++++
 kas/board/zynqmp-zcu102.yml        | 16 ++++++++++
 wic/zynqmp-zcu102.wks.in           | 22 ++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 conf/machine/zynqmp-zcu102.conf
 create mode 100644 doc/boards/README.zynqmp-zcu102.md
 create mode 100644 kas/board/zynqmp-zcu102.yml
 create mode 100644 wic/zynqmp-zcu102.wks.in

--=20
2.47.2


