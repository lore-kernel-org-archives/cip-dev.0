Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5330C83F17
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 08:24:38 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 by mx.groups.io with SMTP id smtpd.web11.56733.1753950270139539815
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 01:24:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=fGexLOQI;
 spf=pass (domain: ti.com, ip: 198.47.19.245, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V8OTvF2959472;
	Thu, 31 Jul 2025 03:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753950269;
	bh=2ePLd0CxZ2wSRkLP1vMJV9P6X4yHdWBA2d2fQUw7VX0=;
	h=From:To:CC:Subject:Date;
	b=fGexLOQITVcPRXdjsQNk5ozp0UUFLn9XW3hBMhLVNZYNZxb9hzWRfLMp+Y01IAMGQ
	 k91TBPiPPsD4CxJBJapitFo38mqVmUlPMce+eF+q5KyVDJKmggpevvqv1yZpewcz/3
	 o+LPKA3CteIJ+pexm9clopbyghUeVnEOBDW78X1c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V8OTQC4085634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 03:24:29 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:24:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:24:29 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V8OQxZ2604023;
	Thu, 31 Jul 2025 03:24:27 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>
CC: <vigneshr@ti.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4] Add support for TI AM62Px Platform
Date: Thu, 31 Jul 2025 13:54:17 +0530
Message-ID: <20250731082421.292376-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 08:24:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19633

This patch series enables support for TI AM62Px SK Platform.

This series depends on cip-kernel-config merge-request [1] that adds
arm64/ti_defconfig.

[1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/134

Changes from v1 to v2:
- Remove initramfs-ti-k3-kernel-modules-hook. All the necessary modules
  are already built-in.
- Update u-boot patch to enable KASLR with upstream version.
- Add custom rules-ti.tmpl for both optee-os and u-boot.
- Update u-boot recipe to add additional TEMPLATE_VARS used in
  rules-ti.tmpl
- Remove u-boot patch to add microsoft-ftpm node to devicetree.
- The series no longer depends on kernel patch to add microsoft-ftpm
  node.

Sai Sree Kartheek Adivi (4):
  Add support for TI AM62Px SK platform
  ti-am62px-sk: Enable SWUpdate support
  ti-am62px-sk: Add support for secureboot
  ti-am62px-sk: enable data encryption

 Kconfig                                       | 14 ++--
 conf/machine/ti-am62px-sk.conf                | 32 +++++++++
 kas/board/ti-am62px-sk.yml                    | 13 ++++
 .../optee-client/optee-client-ti-k3_4.6.0.bb  | 16 +++++
 .../files/0001-add-enum-to-ta-flags.patch     | 27 ++++++++
 .../optee-ftpm-ti-k3_0~231017+git.bb          | 33 +++++++++
 recipes-bsp/optee-os/files/rules-ti.tmpl      | 21 ++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb | 12 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb  | 38 ++++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc | 29 ++++++++
 .../trusted-firmware-a-ti-k3_2.13.bb          | 18 +++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++
 recipes-bsp/u-boot/files/rpmb-setup.cfg       | 12 ++++
 recipes-bsp/u-boot/files/rules-ti.tmpl        | 47 +++++++++++++
 recipes-bsp/u-boot/u-boot-common-2025.01.inc  | 33 +++++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.01.bb     | 69 +++++++++++++++++++
 .../images/cip-core-image-security.bb         | 13 ++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |  5 ++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 19 +++++
 wic/ti-am62px-sk-efibootguard.wks.in          | 19 +++++
 wic/ti-am62px-sk.wks                          | 11 +++
 21 files changed, 515 insertions(+), 4 deletions(-)
 create mode 100644 conf/machine/ti-am62px-sk.conf
 create mode 100644 kas/board/ti-am62px-sk.yml
 create mode 100644 recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
 create mode 100644 recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
 create mode 100755 recipes-bsp/optee-os/files/rules-ti.tmpl
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
 create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
 create mode 100644 recipes-bsp/u-boot/files/rpmb-setup.cfg
 create mode 100755 recipes-bsp/u-boot/files/rules-ti.tmpl
 create mode 100644 recipes-bsp/u-boot/u-boot-common-2025.01.inc
 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
 create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in
 create mode 100644 wic/ti-am62px-sk.wks

-- 
2.34.1


