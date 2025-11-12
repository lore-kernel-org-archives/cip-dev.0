Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D35CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:12:53 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7867.1762931570428535639
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=YWnVX9+G;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20251112071247b1bf82dfd000020705-cdgnoc@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251112071247b1bf82dfd000020705
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Nov 2025 08:12:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=NeTFrvFoEHRXF897v3gM0SmcRZ0guwdqKtl6+mSUOU4=;
 b=YWnVX9+GLGSplyGMDL75FSygrQ+joXSMDwjqO3tcQHU4i5w7cENO0GkWG08QMAjk1MPqYY
 INp0xxJsgBqpQocQUnsEd7mbXorfbWb1rFBYNzBdilCqG4qdFHGFnaliSaeV04nEdp/DZZMO
 mRcFalqvmEJ3JuX8wHie6DzHto0Glep1ATH0ceme5rsqXJMDb93N3DaIFa6HGB+nlFcTq+DR
 5L0BCGVs3VSLUi/gKXl8VxEJ6yRPNcY4+shKzQsxVGdhkseXR6C+5DXjKzfuBi2/+4OTNBWt
 qgJMBlVOcDTJYDh2mEvFckee+KQWkKem9z44edJjcqRZ50WQAKgRBBIw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/5] Small recipe improvements for u-boot and opensbi
Date: Wed, 12 Nov 2025 08:12:41 +0100
Message-ID: <cover.1762931566.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:12:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20505

Already shareable bits while testing a RISC-V board with isar-cip-core.

Jan

Jan Kiszka (5):
  u-boot: Set COMPATIBLE_MACHINE to drop PREFERRED_PROVIDER_u-boot-*
  u-boot: Add U_BOOT_EXTRA_BUILDARGS to rules.tmpl
  opensbi: Refactor opensbi.inc
  Update isar revision
  opensbi-qemu-riscv64: Use the new class

 conf/machine/bbb.conf                         |  1 -
 conf/machine/qemu-arm.conf                    |  2 --
 conf/machine/qemu-arm64.conf                  |  2 --
 conf/machine/qemu-riscv64.conf                |  2 --
 kas-cip.yml                                   |  2 +-
 recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 -------
 .../opensbi/opensbi-qemu-riscv64_1.7.bb       | 16 ++++++++--
 recipes-bsp/opensbi/opensbi.inc               | 32 -------------------
 ...bi-qemu-riscv64_1.7.bb => opensbi_1.7.inc} |  7 ++--
 recipes-bsp/u-boot/files/rules.tmpl           |  2 +-
 recipes-bsp/u-boot/u-boot-bbb_2025.07.bb      |  4 ++-
 .../u-boot/u-boot-qemu-arm64_2025.07.bb       |  4 ++-
 recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb |  4 ++-
 .../u-boot/u-boot-qemu-riscv64_2025.07.bb     |  4 ++-
 14 files changed, 31 insertions(+), 63 deletions(-)
 delete mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
 delete mode 100644 recipes-bsp/opensbi/opensbi.inc
 copy recipes-bsp/opensbi/{opensbi-qemu-riscv64_1.7.bb => opensbi_1.7.inc} (50%)

-- 
2.51.0


