Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967DC433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:28:00 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.14281.1636716479085040850
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:27:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACBRrZ4003305
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:27:53 +0100
Received: from [167.87.32.54] ([167.87.32.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBRqAO009639;
	Fri, 12 Nov 2021 12:27:53 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate.inc: Remove unnecessary
 defaults from getVar
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211112110712.160124-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2117fa7d-2793-571f-a9b8-ce35e49a1eb3@siemens.com>
Date: Fri, 12 Nov 2021 12:27:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112110712.160124-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:28:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6879

On 12.11.21 12:07, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Also 'TRUE' is not a valid value.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/swupdate/swupdate.inc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index 191aa2b..7812ae7 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -26,12 +26,12 @@ def get_bootloader_build_profile(d):
>  SWUPDATE_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
>  
>  def get_bootloader_dependencies(d):
> -    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
>      if bootloader == "efibootguard":
>          return "efibootguard-dev"
>      if bootloader == "u-boot":
> -        if d.getVar("U_BOOT_CONFIG_PACKAGE", True) == "1":
> -            return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE", TRUE))
> +        if d.getVar("U_BOOT_CONFIG_PACKAGE") == "1":
> +            return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE"))
>          else:
>              return "libubootenv"
>      return ""
> @@ -48,7 +48,7 @@ dpkg_runbuild_prepend() {
>  }
>  
>  python do_check_bootloader () {
> -    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
>      if not bootloader in ["efibootguard", "u-boot"]:
>          bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
>  }
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

