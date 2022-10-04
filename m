Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EA0C38A05
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.13319.1664902101900182118
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=LeuZ6x/S;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20221004164819ba6c2a0acc627d2a64-owov17@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20221004164819ba6c2a0acc627d2a64
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=8R73OnyC6Rn2HGSMAGVnTCvAEEuldeAQ2VGMq3Bq3jw=;
 b=LeuZ6x/SVpk96Gt/BELwfY34wzHSuRZjasrYhC1ir6CoRRYTcQDBrGIupanuHjeASis+bc
 CIDX6+fbl7asbvUqZmMbhznpDO7ck+0WCOltHIrAq2lvJ0oYXlLmbmlLEG2q67NiufeMQjV+
 85zl+CXq6whNMPTZahpRWbQIbgQFc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 00/12] Add qemu-riscv64 target, refactorings,
 kernel updates, CI fix
Date: Tue,  4 Oct 2022 18:48:06 +0200
Message-Id: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9625

CIP has decided to add RISC-V 64-bit as architecture to the support
scope of kernel 5.10-cip. This implies adding a new reference target,
qemu-riscv64, for which this series adds support to isar-cip-core.

As we know, only Debian bookworm may introduce riscv64 as official port,
so we need to go with sid ports for now, using snapshot.debian.org with
a fixed date as "stable" baseline. Please be patient during the first
download, it can easily take more than half an hour, but Isar is caching
the results for any later rebuild. And as I do not trust that even this
works reliably, I'm refraining from adding the new target to CI for now.

And this works around current CI issues with deb.debian.org downloads
when running in a AWS environment by allows to set DISTRO_APT_PREMIRRORS
at gitlab project level.

Jan

Jan Kiszka (12):
  ci: Allow to set per-project DISTRO_APT_PREMIRRORS
  Kconfig: Introduce hidden ARCH configs
  Kconfig: Hide kernel 4.4 for arm64 targets
  start-qemu: Rework usage output
  Bump kas header version to 12
  kas: Drop defaults from bblayers_conf_header
  linux-cip: Update to 4.19.259-cip82, 5.10.145-cip17 and
    5.10.145-cip17-rt7
  Update Isar revision
  deploy-cip-core: Use multi-threaded compression
  Add qemu-riscv64 target
  customizations: Mask hvc0 console under qemu-riscv64
  start-qemu: Add support for RISC-V

 .gitlab-ci.yml                                |  1 +
 Kconfig                                       | 45 +++++++++++++++++++
 .../distro/cip-core-sid-ports.conf            |  7 +--
 conf/distro/debian-sid-ports.list             |  2 +
 conf/distro/debian-sid.list                   |  2 +
 .../machine/qemu-riscv64.conf                 |  6 +--
 doc/README.secureboot.md                      |  2 +-
 kas-cip.yml                                   |  9 ++--
 kas/board/bbb.yml                             |  2 +-
 kas/board/hihope-rzg2m.yml                    |  2 +-
 kas/board/iwg20m.yml                          |  2 +-
 kas/board/qemu-amd64.yml                      |  2 +-
 kas/board/qemu-arm.yml                        |  2 +-
 kas/board/qemu-arm64.yml                      |  2 +-
 .../buster.yml => board/qemu-riscv64.yml}     |  7 +--
 kas/board/simatic-ipc227e.yml                 |  2 +-
 kas/opt/4.19.yml                              |  2 +-
 kas/opt/4.4.yml                               |  2 +-
 kas/opt/5.10.yml                              |  2 +-
 kas/opt/bullseye.yml                          |  2 +-
 kas/opt/buster.yml                            |  2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml          |  2 +-
 kas/opt/ebg-swu.yml                           |  2 +-
 kas/opt/kernel-panic.yml                      |  2 +-
 kas/opt/kernelci.yml                          |  2 +-
 kas/opt/rt.yml                                |  2 +-
 kas/opt/security.yml                          |  2 +-
 kas/opt/{buster.yml => sid-ports.yml}         |  4 +-
 kas/opt/swupdate.yml                          |  2 +-
 kas/opt/targz-img.yml                         |  2 +-
 kas/opt/test.yml                              |  2 +-
 kas/opt/wic-targz-img.yml                     |  2 +-
 recipes-core/customizations/customizations.bb |  8 ++++
 ....bb => linux-cip-rt_5.10.145-cip17-rt7.bb} |  2 +-
 ...7-cip81.bb => linux-cip_4.19.259-cip82.bb} |  2 +-
 ...0-cip16.bb => linux-cip_5.10.145-cip17.bb} |  2 +-
 scripts/deploy-cip-core.sh                    |  2 +-
 start-qemu.sh                                 | 29 +++++++++---
 38 files changed, 125 insertions(+), 49 deletions(-)
 copy kas/opt/buster.yml => conf/distro/cip-core-sid-ports.conf (50%)
 create mode 100644 conf/distro/debian-sid-ports.list
 create mode 100644 conf/distro/debian-sid.list
 copy kas/opt/buster.yml => conf/machine/qemu-riscv64.conf (65%)
 copy kas/{opt/buster.yml => board/qemu-riscv64.yml} (55%)
 copy kas/opt/{buster.yml => sid-ports.yml} (79%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.140-cip16-rt6.bb => linux-cip-rt_5.10.145-cip17-rt7.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.257-cip81.bb => linux-cip_4.19.259-cip82.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.140-cip16.bb => linux-cip_5.10.145-cip17.bb} (72%)

-- 
2.35.3


