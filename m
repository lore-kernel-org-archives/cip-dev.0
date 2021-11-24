Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC08C4332F
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 11:43:06 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.5081.1637754184758395280
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 03:43:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AOBh2l8030329
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 12:43:02 +0100
Received: from [167.87.0.79] ([167.87.0.79])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOBh1RW002833;
	Wed, 24 Nov 2021 12:43:01 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC v3 5/9] Create an read-only rootfs
 with dm-verity
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20211123145747.101549-1-Quirin.Gylstorff@siemens.com>
 <20211123145747.101549-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2b8fd335-cae2-7d6c-65a7-87dfb48406bc@siemens.com>
Date: Wed, 24 Nov 2021 12:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211123145747.101549-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 11:43:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6991

On 23.11.21 15:57, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This root file system supports SWUpdate and secure boot.
> We need a writable /tmp and /var for a boot without error messages.
> 
> The mount  point for /tmp is created during the systemd target
> local-fs according to [1].
> 
> Before `Remount Root and Kernel File Systems.` the tmp of the initrd
> is used.
> 
> [1]: https://www.freedesktop.org/software/systemd/man/systemd.special.html
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig                                       |  3 +-
>  classes/secure-swupdate-img.bbclass           | 32 +++++++++++++++++++
>  kas/opt/ebg-secure-boot-base.yml              |  2 ++
>  kas/opt/ebg-secure-boot-snakeoil.yml          | 13 +++++++-
>  kas/opt/ebg-snakeoil-swu.yml                  | 16 ----------
>  .../images/cip-core-image-read-only.bb        | 20 ++++++++++++
>  recipes-core/tmp-fs/files/postinst            |  3 ++
>  recipes-core/tmp-fs/files/tmp.mount.tmpl      | 11 +++++++
>  recipes-core/tmp-fs/tmp-fs_0.1.bb             | 26 +++++++++++++++
>  wic/qemu-amd64-efibootguard-secureboot.wks    | 11 -------
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 13 ++++++++
>  11 files changed, 120 insertions(+), 30 deletions(-)
>  create mode 100644 classes/secure-swupdate-img.bbclass
>  delete mode 100644 kas/opt/ebg-snakeoil-swu.yml
>  create mode 100644 recipes-core/images/cip-core-image-read-only.bb
>  create mode 100755 recipes-core/tmp-fs/files/postinst
>  create mode 100644 recipes-core/tmp-fs/files/tmp.mount.tmpl
>  create mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
>  delete mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks
>  create mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks.in
> 
> diff --git a/Kconfig b/Kconfig
> index 8421f1b..e97cb03 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -141,7 +141,6 @@ config IMAGE_SECURE_BOOT
>  config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	string
>  	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
> -	default "kas/opt/ebg-secure-boot-snakeoil.yml" if !IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
> -	default "kas/opt/ebg-snakeoil-swu.yml" if IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
> +	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
>  

The user can still configure IMAGE_SECURE_BOOT && !IMAGE_SWUPDATE. If
the former implies the latter, it should also select it.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

