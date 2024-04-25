Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C6C3DA40
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 11:51:30 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.14902.1714045884067676612
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 04:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FMs+6s08;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202404251151204fd473d927a63495cd-2hu05u@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202404251151204fd473d927a63495cd
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 13:51:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=S/xCKVthzI7XqVD66eX4xWoYF2koPpFNkBY9z1B+ceE=;
 b=FMs+6s081jGjbZ9Zy9dPf3Uu4SqWj1mCtyMaR0AFmDC5qMTKa40HioGRGx83gnwN7M0+lP
 KmhasMwmsxhpyD+cQZ9GYLFZJLNtu/WQDbnE0F/4uTdCePtfboSpOdeCFfbYq89E9Haa5U4G
 7GrtxcdJR6JCii1iF6u2QNSqNHJvw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/9]  Add option to encrypt the rootfs
Date: Thu, 25 Apr 2024 13:50:28 +0200
Message-ID: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15755

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the option to encrypt both root file system partitions.
The encrypted partition can be updated with SWUpdate.

The disk encryption is indepented of the selected boot method and
could also be used to encrypt a single writable root file system.

To simplify the handling of the swupdate the encrypted partition use
the uuid as the device mapper name.


If all partitions are encrypted the partition layout looks similar to
this:

```
root@demo:~# lsblk
NAME                                     MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda                                        8:0    0   5.4G  0 disk
├─sda1                                     8:1    0  16.1M  0 part
├─sda2                                     8:2    0    42M  0 part
├─sda3                                     8:3    0    42M  0 part
├─sda4                                     8:4    0     1G  0 part
│ └─fedcba98-7654-3210-cafe-5e0710000001 252:0    0  1008M  0 crypt
├─sda5                                     8:5    0     1G  0 part
│ └─fedcba98-7654-3210-cafe-5e0710000002 252:1    0  1008M  0 crypt
│   └─verityroot                         252:4    0 115.3M  1 crypt /
├─sda6                                     8:6    0   1.3G  0 part
│ └─encrypted_home                       252:2    0   1.3G  0 crypt /home
└─sda7                                     8:7    0     2G  0 part
  └─encrypted_var                        252:3    0     2G  0 crypt /var
```

Changes v3:
 - Update the encrypted partition instead of the underling device
 - Use uuids instead of labels for the partitions.
 - Allow uuids and absolute path to select the partition to be
   encrypted.
 - Add Readme for partition selection.

Changes v2:
 - Rewrite commit messages
 - Rename kas/opt/encrypt-partitions.yml to kas/opt/encrypt-data.yml
 - Rename kas/opt/encrypt-rootfs.yml to kas/opt/encrypt-all.yml
 - Fix assignment of CRYPT_PARTITIONS

Changes from https://lists.cip-project.org/g/cip-dev/message/15512:
 - add partition labels for a/b partitions
 - use a/b rootfs configuration instead seperate wks file

Quirin Gylstorff (9):
  wic/*: Add part-labels to system partition
  initramfs: allow empty mountpoint for crypt hooks
  initramfs-crypt: Only resize partition if ext* formatted
  fix: use luks2 to identify encrypted partition
  Rename encrypt-partitions to encrypt-data
  Kconfig: Add option to encrypt the rootfs
  crypt-hook: Extend partition selection
  README: Add rootfs encryption
  README.swupdate: Add section about partition selection

 .gitlab-ci.yml                                |  2 +-
 Kconfig                                       | 22 +++++++--
 doc/README.swupdate.md                        | 19 +++++++
 doc/README.tpm2.encryption.md                 | 18 +++++--
 kas/opt/encrypt-all.yml                       | 23 +++++++++
 ...ncrypt-partitions.yml => encrypt-data.yml} |  0
 kas/opt/security.yml                          |  2 +-
 .../files/encrypt_partition.clevis.hook       |  2 +
 .../files/encrypt_partition.script            | 49 ++++++++++++++-----
 .../files/encrypt_partition.systemd.hook      |  2 +
 .../files/mount_crypt_partitions.script       | 24 +++++++--
 .../initramfs-crypt-hook_0.2.bb               |  3 +-
 wic/bbb-efibootguard.wks.in                   |  4 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |  4 +-
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
 wic/qemu-arm64-efibootguard.wks.in            |  4 +-
 wic/qemu-riscv64-efibootguard.wks.in          |  4 +-
 wic/x86-efibootguard.wks.in                   |  4 +-
 19 files changed, 154 insertions(+), 40 deletions(-)
 create mode 100644 kas/opt/encrypt-all.yml
 rename kas/opt/{encrypt-partitions.yml => encrypt-data.yml} (100%)

-- 
2.43.0


