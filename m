Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDC7C64EC7
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:14 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.921.1676356067529871206
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 22:27:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=m2lIldpg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-72506-202302140627441bb14a86da930a58fa-blfluy@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202302140627441bb14a86da930a58fa
        for <cip-dev@lists.cip-project.org>;
        Tue, 14 Feb 2023 07:27:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5rM4FjNgMRNiw/SYtaeQiEVRTl/cWMGpzxd31+sRtIY=;
 b=m2lIldpgLMS4LpmLZhUFN/+Y3Qquw2Da8EADDQPdCQ9toWmDllpojGZrhnJFLpKLBe945o
 oQvTaUFTh7+OgDTw5NBNs3k0R4A9PnxzogobnBZkfqfL6jE4sfS/s1T28825VEhNoBraxk6i
 ONavRASZI/jHJonw1xsUV2F0Gw04E=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/3] Add swupdate support for riscv64
Date: Tue, 14 Feb 2023 06:27:27 +0000
Message-Id: <20230214062730.1636598-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 12:14:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10696

Changes since v1:

- rebased onto next
- ebg: fix changelog version (no <orig-version>)
- add swupdate support for qemu-riscv64

Please note: The EBG support in cip-core needs a major rework to be in
sync with the upstream debian package names. Currently, sid cannot be
updated to a more recent revision, as this breaks the build (multiple
packages with different names provide the same binary).

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (3):
  fix efibootguard for riscv64
  wic(ebg): add support for riscv64
  add swupdate support for qemu-riscv64

 Kconfig                                       |  2 +-
 recipes-bsp/efibootguard/efibootguard_0.13.bb |  3 ++
 ...01-add-machine-type-name-for-riscv64.patch | 39 +++++++++++++++++++
 .../wic/plugins/source/efibootguard-boot.py   |  6 ++-
 .../wic/plugins/source/efibootguard-efi.py    |  6 ++-
 wic/qemu-riscv64-efibootguard.wks.in          | 13 +++++++
 6 files changed, 64 insertions(+), 5 deletions(-)
 create mode 100644 recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
 create mode 100644 wic/qemu-riscv64-efibootguard.wks.in

-- 
2.34.1


