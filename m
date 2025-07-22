Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEC7C83F27
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 10:16:02 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web10.8910.1753179359274412078
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jul 2025 03:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=aTOeK3MW;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: s-adivi@ti.com)
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56MAFwRc1473317;
	Tue, 22 Jul 2025 05:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753179358;
	bh=mbV2TVNdJjSTniSwOhAUBIrQKYSvrjrCCc/e1Km4/6k=;
	h=From:To:Subject:Date;
	b=aTOeK3MW6AHFqJWaM5nMdZsKc5eW6cGD/BPKYD3iRcOGGBPcd38l0Hp7hFv8BsFMl
	 cWm8SrxbQkbXA68BsKFdCM052uQoeXC7bBaYtAzf/wETZEaIy9gMje60PW1bl0Y8wL
	 fQdFJJb1gg4bGkbiRzyqgrp6iD40RO1NxekWk8nE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56MAFwfW956150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 22 Jul 2025 05:15:58 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 05:15:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 05:15:58 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56MAFuXU868688;
	Tue, 22 Jul 2025 05:15:56 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
        <jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/4] Add support for TI AM62Px Platform
Date: Tue, 22 Jul 2025 15:45:47 +0530
Message-ID: <20250722101551.1727649-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Jul 2025 10:16:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19571

This patch series enables support for TI AM62Px SK Platform.

This series depends on the following.
1. cip-kernel-config merge-reqest:
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/134
2. kernel patch to add microsoft,ftpm node:
https://lists.cip-project.org/g/cip-dev/message/19570

Sai Sree Kartheek Adivi (4):
  Add support for TI AM62Px SK platform
  ti-am62px-sk: Enable SWUpdate support
  ti-am62px-sk: Add support for secureboot
  ti-am62px-sk: enable data encryption

 Kconfig                                       | 14 +++--
 conf/machine/ti-am62px-sk.conf                | 32 +++++++++++
 kas/board/ti-am62px-sk.yml                    | 13 +++++
 .../optee-client/optee-client-ti-k3_4.6.0.bb  | 16 ++++++
 .../files/0001-add-enum-to-ta-flags.patch     | 27 +++++++++
 .../optee-ftpm-ti-k3_0~231017+git.bb          | 33 +++++++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb | 12 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb  | 27 +++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc | 29 ++++++++++
 .../trusted-firmware-a-ti-k3_2.13.bb          | 18 ++++++
 .../files/0001-Add-tpm-node-in-uboot.patch    | 30 ++++++++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 31 +++++++++++
 recipes-bsp/u-boot/files/rpmb-setup.cfg       | 12 ++++
 recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 47 ++++++++++++++++
 recipes-bsp/u-boot/u-boot-common-2025.01.inc  | 33 +++++++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.01.bb     | 55 +++++++++++++++++++
 .../images/cip-core-image-security.bb         | 13 +++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |  7 +++
 .../initramfs-ti-k3-kernel-modules-hook.bb    | 27 +++++++++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 19 +++++++
 wic/ti-am62px-sk-efibootguard.wks.in          | 19 +++++++
 wic/ti-am62px-sk.wks                          | 11 ++++
 22 files changed, 521 insertions(+), 4 deletions(-)
 create mode 100644 conf/machine/ti-am62px-sk.conf
 create mode 100644 kas/board/ti-am62px-sk.yml
 create mode 100644 recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
 create mode 100644 recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
 create mode 100644 recipes-bsp/u-boot/files/0001-Add-tpm-node-in-uboot.patch
 create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
 create mode 100644 recipes-bsp/u-boot/files/rpmb-setup.cfg
 create mode 100644 recipes-bsp/u-boot/files/rules-ti-am62px-sk
 create mode 100644 recipes-bsp/u-boot/u-boot-common-2025.01.inc
 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
 create mode 100644 recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
 create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in
 create mode 100644 wic/ti-am62px-sk.wks

-- 
2.34.1


