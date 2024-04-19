Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFEDC0650F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:20:49 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.15349.1713514840452703432
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=IcSd1A4u;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240419082037c8b3410f675fc04f3f-vl2tnd@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240419082037c8b3410f675fc04f3f
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 10:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=uMP41WQOn00Hy5xIgFdc5MQs+8fWyFCCIjztCS3bxII=;
 b=IcSd1A4uq3EOI9xVFdwCBDDpH1Z4rJf68+pUgVryby8bNLI8QBI0pSNSnVmlV6sVHhwAvp
 SPM++6evT91xWUyKRcV5auE/Lhnut28ohWbpmDFzY2awTO6fhiMQM1Kz1VZp+8PWL/kV/1xa
 fUDJNzNa45eRrr6w6b1KmO2uWGZXY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: johnxw@amazon.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/7] Add option to encrypt the rootfs
Date: Fri, 19 Apr 2024 10:20:10 +0200
Message-ID: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15645

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the option to encrypt both root file system partions(systema
and systemb). The encrypted partition can be updated with SWUpdate.

Currently an update will lead to a reencryption of the update partition as
the underlying device(/dev/sdaX) is written instead of the device mapper
partition.

Changes from https://lists.cip-project.org/g/cip-dev/message/15512:
 - add partition labels for a/b partitions
 - use a/b rootfs configuration instead seperate wks file


Quirin Gylstorff (7):
  wic/*: Add part-labels to system partition
  initramfs: allow empty mountpoint for crypt hooks
  fix: disk formatting
  initramfs-crypt: Only resize partition if ext* formatted
  use luks2 to identify encrypted partition
  Kconfig: Add option to encrypt the rootfs
  README: Add rootfs encryption

 Kconfig                                       | 20 ++++++++++++++--
 doc/README.tpm2.encryption.md                 | 12 +++++++++-
 kas/opt/encrypt-rootfs.yml                    | 22 +++++++++++++++++
 .../files/encrypt_partition.script            | 24 ++++++++++++++-----
 .../files/mount_crypt_partitions.script       |  4 +++-
 wic/bbb-efibootguard.wks.in                   |  4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          |  4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
 wic/x86-efibootguard.wks.in                   |  4 ++--
 12 files changed, 86 insertions(+), 24 deletions(-)
 create mode 100644 kas/opt/encrypt-rootfs.yml

-- 
2.43.0


