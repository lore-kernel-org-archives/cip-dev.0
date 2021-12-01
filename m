Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4397C433EF
	for <webhook@archiver.kernel.org>; Wed,  1 Dec 2021 11:54:22 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.90402.1638359661318568613
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Dec 2021 03:54:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1B1BsIcZ015274
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 1 Dec 2021 12:54:19 +0100
Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1B1BsIpF030143;
	Wed, 1 Dec 2021 12:54:18 +0100
Subject: Re: [cip-dev][isar-cip-core][RESEND PATCH 0/9] Read-only root file
 system with dm-verity
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f488d79d-b493-e950-9926-ab1d44055d02@siemens.com>
Date: Wed, 1 Dec 2021 12:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Dec 2021 11:54:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7052

On 30.11.21 12:47, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> *This patch series adds support for a read-only squashfs based root filesystem
> wit SWUpdate support and secureboot.
> 
> The build is somewhat complex as we need the output of dm-verity to generate
> the initramfs. The build is split in the following steps
> 1. Build the root file system
> 2. Generate a squashfs image - this can also be replace by another image format(e.g. ext4)
> 3. Build from the image the dm-verity partition and add it to the end of the image
> 4. Add the resulting verity environment to the initrd
> 5. Build the signed efi tool chain.
> 
> This series needs SWUpdate 2021.11. The necessary changes are currently backported.
> 
> Changes in RFC V2:
>  - rebase onto orgin/next
>  - adapt Kconfig to new ebg-secure-boot-snakeoil.yml by deleting unnecessary options
>  - Cleanup to support different file-systems for verity-img
>    - tested with ext4 and squashfs
>  - simplified kernel patching
>    - prepend not necessary
>    - added flag to enable/disable
>  - whitespaces for readability
>  - integrated into ebg-secure-boot-snakeoil
>  - make behavior on corruption configurable during build time.
>    - default is restart on corruption
>  - add ISAR patch for correct permissions
> 
> Changes in RFC V3:
>  - Configurable size of /tmp
>  - remove unnecessary overlay-parse-etc.service
>  - convert etc-sysusers to drop in configuration of systemd-sysusers.service
>  - extend commit messages
> 
> Changes in Patch:
>  - rebased onto origin/next 2550c34a03ae3c035a1593585f2d8e545c83140d
>  - initrd verity warning message
>  - Kconfig: secure-boot element selects also swupdate
>             as the secureboot kas option contains swupdate
>  - fixed ci build
> 
> Quirin Gylstorff (9):
>   Add new class to create a squashfs based root file system
>   Add verity-img.bbclass for dm-verity based rootfs
>   linux-cip-common: Increase revision kernel config
>   Create a initrd with support for dm-verity
>   Create an read-only rootfs with dm-verity
>   Create systemd mount units for a etc overlay
>   Mount writable home partition
>   kas: Patch isar for correct permissions in var and home
>   swupdate: Backport patches from SWUpdate Master
> 
>  .gitlab-ci.yml                                |  11 -
>  Kconfig                                       |   4 +-
>  classes/secure-swupdate-img.bbclass           |  32 +++
>  classes/squashfs-img.bbclass                  |  41 ++++
>  classes/verity-img.bbclass                    |  73 +++++++
>  kas-cip.yml                                   |   4 +
>  kas/opt/ebg-secure-boot-snakeoil.yml          |  12 +-
>  ...when-splitting-rootfs-folders-across.patch |  35 ++++
>  .../etc-overlay-fs/etc-overlay-fs_0.1.bb      |  32 +++
>  .../etc-overlay-fs/files/etc-hostname.service |  14 ++
>  .../files/etc-sshd-regen-keys.conf            |   7 +
>  .../etc-overlay-fs/files/etc-sysusers.conf    |   4 +
>  recipes-core/etc-overlay-fs/files/etc.mount   |  13 ++
>  recipes-core/etc-overlay-fs/files/postinst    |   4 +
>  recipes-core/home-fs/files/home.mount         |  12 ++
>  recipes-core/home-fs/files/postinst           |   3 +
>  recipes-core/home-fs/home-fs_0.1.bb           |  20 ++
>  .../images/cip-core-image-read-only.bb        |  22 ++
>  ...an-patches-add-patches-for-dm-verity.patch | 191 ++++++++++++++++++
>  .../swupdate/swupdate_2021.04-1+debian-gbp.bb |   5 +
>  recipes-core/tmp-fs/files/postinst            |   3 +
>  recipes-core/tmp-fs/files/tmp.mount.tmpl      |  11 +
>  recipes-core/tmp-fs/tmp-fs_0.1.bb             |  26 +++
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  10 +-
>  .../files/verity.conf-hook                    |   1 +
>  .../initramfs-verity-hook/files/verity.hook   |  23 +++
>  .../files/verity.script.tmpl                  |  70 +++++++
>  .../initramfs-verity-hook_0.1.bb              |  51 +++++
>  recipes-kernel/linux/linux-cip-common.inc     |   2 +-
>  start-qemu.sh                                 |   4 +
>  wic/qemu-amd64-efibootguard-secureboot.wks    |  11 -
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  15 ++
>  32 files changed, 735 insertions(+), 31 deletions(-)
>  create mode 100644 classes/secure-swupdate-img.bbclass
>  create mode 100644 classes/squashfs-img.bbclass
>  create mode 100644 classes/verity-img.bbclass
>  create mode 100644 patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
>  create mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
>  create mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
>  create mode 100644 recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
>  create mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.conf
>  create mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
>  create mode 100755 recipes-core/etc-overlay-fs/files/postinst
>  create mode 100644 recipes-core/home-fs/files/home.mount
>  create mode 100755 recipes-core/home-fs/files/postinst
>  create mode 100644 recipes-core/home-fs/home-fs_0.1.bb
>  create mode 100644 recipes-core/images/cip-core-image-read-only.bb
>  create mode 100644 recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch
>  create mode 100755 recipes-core/tmp-fs/files/postinst
>  create mode 100644 recipes-core/tmp-fs/files/tmp.mount.tmpl
>  create mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
>  rename kas/opt/ebg-snakeoil-swu.yml => recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb (61%)
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.hook
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>  delete mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks
>  create mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks.in
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

