Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D416F33A92
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 14:22:29 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70216.1772806939301389460
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 06:22:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=UqNDjVTw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1330684-202603061422163196147427000207b0-vgsjbf@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202603061422163196147427000207b0
        for <cip-dev@lists.cip-project.org>;
        Fri, 06 Mar 2026 15:22:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=MF1UKAgSRfoCjHw5yQW8WiEaRamkS4wQ5qIZ/z3HLpc=;
 b=UqNDjVTw8/vDyhVjozBFK9K+ZnN3+jkNuSn7XSCdomlHQu9WZTLJk4MWoL0rFctXsZC1UK
 hqPK7kxNmFApOQcrxSWkzC95gTZ9R3aoQgaA9xYf7yyK7FzMOQgRHAdRm59eLOCiZs/sGrgJ
 zm4QV3ihugQ/wjLUM+96ko2edsC7F1t1r8leJvrkYV2rgHy1uFi7BadoDF+K48upf88W0yS6
 7r82OSv0SSNuQb+NMQBv93OCACU2POpacUP9EuH/5he1giM9Cvuw0e0FI2pr6ehOiZPfw4zO
 P/VqvOsI2CA2PgShj2VMLqjlJVJwetbFiPk36NzZmuhTswjmf1wx5v6A==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Cc: quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/2] wic: Wipe LUKS2 header of rootfs-B on bmaptool copy
Date: Fri,  6 Mar 2026 15:22:11 +0100
Message-ID: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 14:22:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22102

From: Alexander Heinisch <alexander.heinisch@siemens.com>

To copy images `bmaptool copy` uses a bmap file that maps regions
that actually hold data. That means empty regions / holes in the file
are skipped by the tool and thus those regions on the disk do not
change. - That's actually the feature why bmaptools exists.

When reinstalling an image configured to use A/B-rootfs and disk encryption
that way, this results in a LUKS2 header created for rootfs-B during
disk encryption setup of the previous installation to remain on the target.

The problem was introduced in 63eef2b4fb5feb393f97cecc4f432688403ded5d
by not copying the rootfs to rootfs-B in the target image, which is actually fine,
but needs special treatment in case of encryption.

Based on discussions in V1 we decided to generalize the fix to apply to filesystem
headers in an A/B setup without disc-encryption as well.

Detailed bug analysis is contained in the commit message of the second patch of this series.

Results:
$ diff build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bookworm-qemu-amd64.wic.bmap build/tmp/deploy/images/qemu-amd64.previous/cip-core-image-cip-core-bookworm-qemu-amd64.wic.bmap
34,35c34,35
<     <!-- Count of mapped blocks: 201.3 MiB or 7.1%   -->
<     <MappedBlocksCount> 51525  </MappedBlocksCount>
---
>     <!-- Count of mapped blocks: 196.3 MiB or 6.9%   -->
>     <MappedBlocksCount> 50245  </MappedBlocksCount>
42c42
<     <BmapFileChecksum> 342e6fd7e54d934a6a5391be5ece8876fac877987c8c7ebc555521c26d24c27a </BmapFileChecksum>
---
>     <BmapFileChecksum> 8c364ad4cb66847195f15a1f65b695f393d375c6a59a7edf3a24de88bb3b0295 </BmapFileChecksum>
53d52
<         <Range chksum="c036cbb7553a909f8b8877d4461924307f27ecb66cff928eeeafd569c3887e29"> 332032-333311 </Range>

We see the mapping file contains an additional 5MB region (of zeroes)


Following commands allow for an (additional) quick test of the patch:

1. Initial Setup:

```
bmaptool copy build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.wic /dev/<your-target-dev>
hexdump -n 40 /dev/<your-target-dev>p5
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0000020 0000 0000 0000 0000
0000028
```

2. Some modification to the rootfs-B partition:

```
$ dd if=/dev/random of=/dev/<your-target-dev>p5 bs=1k count=1
$ hexdump -n 40 /dev/<your-target-dev>p5
0000000 fe36 6a22 775a 442b 76b3 7ac2 fb49 68f0
0000010 43a9 92a3 d2eb 4b6a dc0b 4c89 5ad9 cfcd
0000020 8f5d 5f1b 72cf e5f7
0000028
```

3. (Re)installation of the image:

```
$ bmaptool copy build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.wic /dev/<your-target-dev>
$ hexdump -n 40 /dev/<your-target-dev>p5
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0000020 0000 0000 0000 0000
0000028
```

---

Changes in V2:

- Fixed missleading parts in commit message
- Generalized the fix to wipe filesystem headers in A/B rootfs setups without disk encryption as well


Alexander Heinisch (2):
  wic: Added support to set sourceparams for empty root-B partition.
  wic: Wipe rootfs-B headers on bmaptool copy

 kas/opt/swupdate.yml                            | 14 ++++++++++++++
 wic/bbb-efibootguard.wks.in                     |  2 +-
 wic/beaglev-fire-efibootguard.wks.in            |  2 +-
 wic/de0-nano-soc-efibootguard.wks.in            |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in            |  2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in   |  2 +-
 wic/qemu-arm64-efibootguard.wks.in              |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in            |  2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in |  2 +-
 wic/ti-am62px-sk-efibootguard.wks.in            |  2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in     |  2 +-
 wic/x86-uefi-efibootguard.wks.in                |  2 +-
 12 files changed, 25 insertions(+), 11 deletions(-)

--
2.47.3


