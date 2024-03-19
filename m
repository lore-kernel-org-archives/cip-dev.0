Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6867FC6FD1F
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:20:41 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.23522.1710872430978093614
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=AhpVidVr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240319182027b3f01b84840743b76c-kkilzf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240319182027b3f01b84840743b76c
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Mar 2024 19:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ylqa/fhr5GwLaXIH86ICgnQ27MC2BZStMj+84AzDSHI=;
 b=AhpVidVr+yrVo6Ug68PS7savOtcgWZu4LbZ4GmKzQEKS30yXOwsLseppsdvcH/zT0uaTIw
 M1crOVH2BxOkvmuY6WQqpf+fNL87cFKO0iNT1Bpnye4IvmRJSGq/5DV3FcSY/27KabjGf+mk
 ex2ITxF29AzFt+uz5ngl25Nb6tDZo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][RFC 0/8] Rework disk encryption
Date: Tue, 19 Mar 2024 19:18:24 +0100
Message-ID: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:20:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15365

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset is a cleanup of the initramfs-crypt-hook:
 - Aligns the systemd and clevis implementation
 - Adds some checks for TPM parameter
 - Remove the dependency in the overlay
 - Adds an example to encrypt the rootfs

Quirin Gylstorff (8):
  initramfs-crypt-hook: Allow switching between clevis and systemd
  initramfs-crypt-hook: Align systemd encryption and clevis encryption
  initramfs-crypt-hook: move the mounting of encrypted disks in a
    seperate function
  initramfs-crypt-hook: Check if the TPM device fulfills the given
    requirements
  initramfs-crypt-hook: add flag to make encryption optional
  initramfs-crypt-hook: add e2fsck to avoid resize error
  initramfs-crypt-hook: split encryption and mounting
  Add example to encrypt the rootfs

 kas/opt/encrypt_rootfs.yml                    | 24 ++++++++
 .../files/encrypt_partition.clevis.script     | 42 +++++++------
 .../files/encrypt_partition.env.tmpl          |  4 +-
 .../files/encrypt_partition.systemd.hook      |  4 +-
 .../files/encrypt_partition.systemd.script    | 55 ++++++++++-------
 .../files/mount_crypt_partitions.script       | 61 +++++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb               | 28 +++++++--
 .../files/overlay.script.tmpl                 |  2 +-
 wic/x86_64-encryption.wks.in                  | 18 ++++++
 9 files changed, 189 insertions(+), 49 deletions(-)
 create mode 100644 kas/opt/encrypt_rootfs.yml
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
 create mode 100644 wic/x86_64-encryption.wks.in

-- 
2.43.0


