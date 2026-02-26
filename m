Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600EFD8FD3
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 16:08:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73664.1772122123090818818
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 08:08:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=LL+ieX8O;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1330684-20260226160839e7ad6d2491000207b6-wm01gf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260226160839e7ad6d2491000207b6
        for <cip-dev@lists.cip-project.org>;
        Thu, 26 Feb 2026 17:08:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XcKIvHdYMIeeZF2UWgs1ia1wkOcMKoC65nApWoaBgTE=;
 b=LL+ieX8O034EontB9L+W+WOBeAs1HRVQ5rlq0Xyhupkj7wnOfJulgHWQgSSFx9ryX27TYy
 rbosNWn6wwRMHy1vlWcYtZpY5ksedoJ38NbWrBZWcYk0z/EBrvoDo/oEPgCxOpYXcvegsG59
 lxZhxCnqbSVfVFvDbi9X6Dj2g/8E8S84e9p+R05mQP95tTTp8ADa327AUPxfX6DX7S5tj5It
 HM713rhuulCeDRmwy2R95qoxuk1ANPXJpRe+OUhSP1mUkUM9W3ruz6BHH1+Q4B0brQk0sthb
 ilJOvrwWcWs4hAP9csOmNl38LtjYr5wnYunAFCWpS2NofM7wTXyAJNXA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] wic: Wipe LUKS2 header of rootfs-B on bmaptool copy
Date: Thu, 26 Feb 2026 17:08:35 +0100
Message-ID: <20260226160837.1107096-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 16:08:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21995

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


Alexander Heinisch (2):
  wic: Added support to set sourceparams for empty root-B partition.
  wic: Wipe LUKS2 header of rootfs-B on bmaptool copy

 kas/opt/encrypt-all.yml                         | 7 +++++++
 wic/bbb-efibootguard.wks.in                     | 2 +-
 wic/beaglev-fire-efibootguard.wks.in            | 2 +-
 wic/de0-nano-soc-efibootguard.wks.in            | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in            | 2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in   | 2 +-
 wic/qemu-arm64-efibootguard.wks.in              | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in            | 2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in | 2 +-
 wic/ti-am62px-sk-efibootguard.wks.in            | 2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in     | 2 +-
 wic/x86-uefi-efibootguard.wks.in                | 2 +-
 12 files changed, 18 insertions(+), 11 deletions(-)

--
2.47.3


