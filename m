Return-Path: <SRS0=98Ov=HD=lists.cip-project.org=bounce+64572+6155+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D3C433DB
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:14:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A2A64E2B
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A2A64E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6155+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XNURYY4521723xn5FcpjbxDR; Mon, 01 Feb 2021 08:14:40 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.36548.1612196079496018741
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Feb 2021 08:14:40 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 111GEaFM016075
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 1 Feb 2021 17:14:36 +0100
X-Received: from [167.87.73.192] ([167.87.73.192])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 111GEZQg021016;
	Mon, 1 Feb 2021 17:14:36 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] Use u-boot-config instead of tools
To: cip-dev@lists.cip-project.org,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>,
        florian.bezdeka@siemens.com
References: <20210201123330.20610-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <331bc97a-cd0b-85d8-200b-af17bdb9aad9@siemens.com>
Date: Mon, 1 Feb 2021 17:14:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201123330.20610-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VxWZo8CVbFK75ce1CYKcGexyx4520388AA=
Content-Type: multipart/mixed; boundary="1sFWyonGVTDw3rizkxgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612196080;
 bh=grTrNcGPI3AZgymJk/we5SApZUUbUsTOruQ8Fkq5Fus=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=vmhxkH9R/FiJl40bmHP9z32z6Oq9d56w40/M6rypkVhgJNPdkO0Ar2SYPHDamBrlohs
 KLAGPu+pP0OktEhWOJ42PSrI+6Stf30T+sYJagUjSyyJCz+p3l1HCnElxMJTwP4V4jMkG
 M5/LH5JCvHDB2bmkIvdB78HYgXPTydNKZuI=

--1sFWyonGVTDw3rizkxgi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 01.02.21 13:33, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Swupdate requires libubootenv0.1 and u-boot-config to access the u-boot
> environment. u-boot-config adds the configuration files.
> 
> Add the flag `USE_U_BOOT_CONFIG` to deactivate the addition of
> 'u-boot-${MACHINE}-config.' If the image uses an upstream u-boot binary
> (e.g. [1]) remove the package by setting `USE_U_BOOT_CONFIG` to `false`.
> 
> [1]: https://packages.debian.org/buster/u-boot-omap
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate-config.bbclass   | 8 +++++---
>  recipes-core/swupdate/swupdate.bb | 2 --
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
> index dd0317f..9909113 100644
> --- a/classes/swupdate-config.bbclass
> +++ b/classes/swupdate-config.bbclass
> @@ -45,10 +45,13 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
>  
>  KFEATURE_DEPS[ubi] = "mtd"
>  
> +USE_U_BOOT_CONFIG ?= "true"
>  KFEATURE_u-boot = ""
>  KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
> -KFEATURE_u-boot[DEBIAN_DEPENDS] = "libubootenv-tool, u-boot-tools"
> -KFEATURE_u-boot[DEPENDS] = "${U_BOOT}"
> +KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
> +                                          if d.getVar("USE_U_BOOT_CONFIG", True) == "true" \
> +                                          else 'libubootenv0.1'}"
> +KFEATURE_u-boot[DEPENDS] = "${U_BOOT} libubootenv"
>  KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
>  
>  SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
> @@ -73,4 +76,3 @@ python do_check_bootloader () {
>          bb.warn("swupdate: BOOTLOADER set to incompatible value: " + bootloader)
>  }
>  addtask check_bootloader before do_fetch
> -
> diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
> index b4d64fe..526c72f 100644
> --- a/recipes-core/swupdate/swupdate.bb
> +++ b/recipes-core/swupdate/swupdate.bb
> @@ -24,8 +24,6 @@ SRC_URI += "file://debian \
>              file://${DEFCONFIG} \
>              file://${PN}.cfg"
>  
> -DEPENDS += "libubootenv"
> -
>  DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
>  
>  inherit dpkg
> 
> 
> 

Applied, thanks.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--1sFWyonGVTDw3rizkxgi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6155): https://lists.cip-project.org/g/cip-dev/message=
/6155
Mute This Topic: https://lists.cip-project.org/mt/80283340/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1sFWyonGVTDw3rizkxgi--
