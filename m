Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD011CEBF61
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 17:15:24 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14787.1763399721800018916
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 09:15:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=S0pd8eWM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20251117171517eb3fa2617800020751-ghtwfn@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251117171517eb3fa2617800020751
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Nov 2025 18:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=R5cV5WEdwtbAc8xprUi+Xe1sJWQ0PK2tPI+MD5imQDM=;
 b=S0pd8eWMiy+wikFX52GXkPmFMGBJDdPwrSedpdcakvDmB4QkIj3plcJFfww3zvF7CtgkFb
 LhgsaBrc3jIBkzW+mccF9cD3YrgBGvZcqeh9XhyINIbUIPQmWutMI/+FtoM+KleXchSbT/fa
 LbDroai4p9al53Gn8skm1H7Es+eNV6nZvA9zqEN/laCgN//r3EYP3tvG0x4ay2CFH3W3YCOj
 B13hRX9MLyR9EMht3QXQ8KpfJZmv06JKUOXcVAQ57UNN7LaFFM/yG802T89AG6WZfjoeumNa
 n64S+Zld5F8IbA+WyNUUYmD85tx3q4x0ZuqpaEApmXynFBwP33Ehjmag==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [isar-cip-core][PATCH 0/6] Switch to cip_merged_defconfig, clean up ti-am62px-sk recipes
Date: Mon, 17 Nov 2025 18:15:11 +0100
Message-ID: <cover.1763399717.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 17:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20600

This first of all switches all boards to the cip_merged_defconfig. There
is a slight risk to regress as not all boards could have been tested so
far. Please support this!

Test status:
 - qemus - ok
 - bbb - ok
 - iwg20m - does not boot from isar-cip-core, even before the change
 - hihope-rzg2m - boots but takes longer [1]
 - ti-am62px-dk - untested

The series closes with two clean-up patches for the ti-am62px-sk. Both
are build-tested only.

Jan

[1] https://lore.kernel.org/cip-dev/21c328a5-ab4e-4678-adf2-cf34fa341869@siemens.com/

Jan Kiszka (6):
  linux-cip: Add lz4 as build dependency when using cip-kernel-config
  arm: Switch to cip_merged_defconfig
  arm64: Switch to cip_merged_defconfig
  linux-cip: Refactor KERNEL_DEFCONFIG initialization
  u-boot-ti-am62px-sk: Drop redundant or unused DEBIAN_BUILD_DEPENDS
  ti-am62px-sk: Switch wks files to gpt-hybrid

 conf/machine/bbb.conf                             |  3 +--
 conf/machine/hihope-rzg2m.conf                    |  3 +--
 conf/machine/iwg20m.conf                          |  1 -
 conf/machine/qemu-amd64.conf                      |  1 -
 conf/machine/qemu-arm.conf                        |  3 +--
 conf/machine/qemu-arm64.conf                      |  1 -
 conf/machine/qemu-riscv64.conf                    |  2 --
 conf/machine/ti-am62px-sk.conf                    |  1 -
 conf/machine/x86-uefi.conf                        |  1 -
 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb |  1 -
 recipes-kernel/linux/cip-kernel-config.inc        | 12 ++++++++++--
 recipes-kernel/linux/linux-cip-common.inc         |  3 ---
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in   |  4 ++--
 wic/ti-am62px-sk-efibootguard.wks.in              |  4 ++--
 wic/ti-am62px-sk.wks                              |  4 ++--
 15 files changed, 19 insertions(+), 25 deletions(-)

-- 
2.51.0


