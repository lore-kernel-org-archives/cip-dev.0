Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF3DC48BCD
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:08 +0000 (UTC)
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net
 [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.6457.1649858062045545442
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 06:54:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=NcfVbzpG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220413135417b0e3b35a99ea583876-9inna_@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id
 20220413135417b0e3b35a99ea583876
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 15:54:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mmT0+ngA7lTGXBEEWG+jYORBQN1PjV2paRabBh9HaOE=;
 b=NcfVbzpGYFWJh2MdDRV67GrRQ5GYpQgzkYR+HyL9J6LjYhHY4dhpKoDeovmNzqdu90T9tl
 emlMikOSZwMkB2CXb2T4/PefefDc/fILvoqRO0mW/+3O8vUGBEjG/9Zr+8UH8BftZj1GWPFL
 A17GOhi6sp8DVjesk6Cl3aqnlYuMc=;
Message-ID: <f7b6752a-521e-b1dc-a366-acdde99862b9@siemens.com>
Date: Wed, 13 Apr 2022 15:54:16 +0200
MIME-Version: 1.0
Subject: Re: [isar-cip-core][PATCH 00/19] SWUpdate & EFI Boot Guard
 refactorings
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8073



On 4/13/22 09:16, Jan Kiszka wrote:
> Several refactorings, simplifications and fixes of the SWUpdate and EFI
> Boot Guard integration. This primarily aims at the unification of both
> variants.
> 
> For that, this switches to unified kernel images also in the non-secure
> mode. This allows to share configuration files between both as well.
> 
> Furthermore, the device selection in sw-description is abstracted from
> the concrete medium, making it easier for downstream to place images on
> either internal or external media without adjusting device paths.
> 
> Finally, the watchdog support in QEMU is fixed and enabled so that we
> can run update and failure sequences completely.
> 
> Jan

I tested it once and it looks good to me.

Quirin

> 
> Jan Kiszka (19):
>    start-qemu.sh: Add ssh access to guest from localhost
>    swupdate: Simplify secure-swupdate-img class
>    swupdate: Drop no longer used SOURCE_IMAGE_FILE
>    swupdate: Rename secure-swupdate-img class
>    Drop initramfs-abrootfs-secureboot references
>    Rename initramfs-abrootfs-secureboot to initramfs-abrootfs-hook
>    swupdate: Switch to unified kernel image by default
>    swupdate: Drop PN from TEMPLATE_VARS
>    efibootguard: Avoid rename linux.efi when signing it
>    Unify configuration of secure vs. non-secure SWUpdate
>    cip-core-image: Do not include swupdate.inc unless it is used
>    cip-core-image: Make image-uuid an image option
>    swupdate: Add patch to fix EBG bootloader_env_get
>    swupdate: Switch to bootenv_rrmap+kernelfile for device selection
>    customizations: Enable systemd watchdog
>    linux-cip: Update cip-kernel-config
>    start-qemu.sh: Ensure that iTCO watchdog timeout triggers reset
>    doc: Update README.swupdate
>    doc: README.secureboot polishing
> 
>   ...img.bbclass => secure-wic-swu-img.bbclass} |   6 +-
>   classes/wic-swu-img.bbclass                   |   2 -
>   doc/README.secureboot.md                      |  16 +-
>   doc/README.swupdate.md                        | 166 ++++++++++--------
>   kas/opt/ebg-secure-boot-base.yml              |  21 ---
>   kas/opt/ebg-secure-boot-snakeoil.yml          |  10 +-
>   kas/opt/ebg-swu.yml                           |   7 +
>   kas/opt/swupdate.yml                          |   3 +
>   recipes-core/customizations/common.inc        |   6 +-
>   .../customizations/files/99-watchdog.conf     |   3 +
>   recipes-core/images/cip-core-image.bb         |   6 +-
>   .../files/secure-boot/sw-description.tmpl     |  35 ----
>   recipes-core/images/files/sw-description.tmpl |  20 +--
>   recipes-core/images/image-uuid.inc            |  12 ++
>   recipes-core/images/read-only.inc             |   1 -
>   recipes-core/images/secureboot.inc            |  21 ---
>   recipes-core/images/swupdate.inc              |   4 +-
>   .../swupdate.handler.efibootguard.ini         |  16 --
>   .../files/swupdate.handler.efibootguard.ini   |  20 +--
>   ...onfig-Make-image-encryption-optional.patch |   8 +-
>   .../0002-debian-rules-Add-CONFIG_MTD.patch    |   6 +-
>   ...es-Add-option-to-disable-fs-creation.patch |   8 +-
>   ...ules-Add-option-to-disable-webserver.patch |   8 +-
>   ...Make-CONFIG_HW_COMPATIBILTY-optional.patch |   8 +-
>   ...ules-Add-Embedded-Lua-handler-option.patch |   6 +-
>   ...-SWUpdate-USB-service-and-Udev-rules.patch |  10 +-
>   ...option-to-disable-CONFIG_HASH_VERIFY.patch |   6 +-
>   ...ch-to-fix-bootloader_env_get-for-EBG.patch |  66 +++++++
>   ...repare-build-for-isar-debian-buster.patch} |  10 +-
>   .../swupdate/swupdate_2021.11-1+debian-gbp.bb |   5 +-
>   .../files/debian-local-patch                  |   0
>   .../files/initramfs.image_uuid.hook           |   0
>   .../files/initramfs.lsblk.hook                |   0
>   .../initramfs-abrootfs-hook}/files/postinst   |   2 +-
>   .../initramfs-abrootfs-hook_0.1.bb            |   8 +-
>   recipes-kernel/linux/linux-cip-common.inc     |   2 +-
>   .../wic/plugins/source/efibootguard-boot.py   |  30 ++--
>   start-qemu.sh                                 |   3 +-
>   wic/ebg-sysparts.inc                          |   4 +-
>   wic/qemu-amd64-efibootguard-secureboot.wks.in |   4 +-
>   40 files changed, 277 insertions(+), 292 deletions(-)
>   rename classes/{secure-swupdate-img.bbclass => secure-wic-swu-img.bbclass} (82%)
>   delete mode 100644 kas/opt/ebg-secure-boot-base.yml
>   create mode 100644 recipes-core/customizations/files/99-watchdog.conf
>   delete mode 100644 recipes-core/images/files/secure-boot/sw-description.tmpl
>   create mode 100644 recipes-core/images/image-uuid.inc
>   delete mode 100644 recipes-core/images/secureboot.inc
>   delete mode 100644 recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
>   create mode 100644 recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
>   rename recipes-core/swupdate/files/{0009-debian-prepare-build-for-isar-debian-buster.patch => 0010-debian-prepare-build-for-isar-debian-buster.patch} (92%)
>   rename recipes-support/initramfs-config/files/secure-boot-debian-local-patch => recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch (100%)
>   rename {recipes-support/initramfs-config => recipes-initramfs/initramfs-abrootfs-hook}/files/initramfs.image_uuid.hook (100%)
>   rename {recipes-support/initramfs-config => recipes-initramfs/initramfs-abrootfs-hook}/files/initramfs.lsblk.hook (100%)
>   rename {recipes-support/initramfs-config => recipes-initramfs/initramfs-abrootfs-hook}/files/postinst (73%)
>   rename recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb => recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb (74%)
> 





