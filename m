Return-Path: <SRS0=hsiR=J3=lists.cip-project.org=bounce+64572+6405+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E01BC433B4
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:40:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D048161480
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 12:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D048161480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6405+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qOUrYY4521723xRrrod4Q5hk; Fri, 30 Apr 2021 05:40:16 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.10877.1619786415432342836
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Apr 2021 05:40:16 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13UCeD3C016107
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 30 Apr 2021 14:40:13 +0200
X-Received: from [167.87.0.247] ([167.87.0.247])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13UCWnwT004936;
	Fri, 30 Apr 2021 14:32:50 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-config: add prefix to variables
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210430122020.13407-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <1feede08-14ba-4960-e5c4-9dd717dcd48c@siemens.com>
Date: Fri, 30 Apr 2021 14:32:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210430122020.13407-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: i3Gbv7PJdFkv13HjAkRUoy2sx4520388AA=
Content-Type: multipart/mixed; boundary="kNQsyMfvezJga43A0yIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619786416;
 bh=ybLh3451LY0H2hcLex35RngQLUWO3FRqPM+eI5a0Alk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=O80hIx2OSnKKdY5g2eh4L2gE7PXqYRtwrFbDuWzmYIVuoYxvTLFeGi1WqaDVDVuFT5Y
 Og3yTa2nWvvuEvvwx+x/HGQvpa1z/mjF9+SVoK3Mrr8MMKCiepIXaqBUSm/+mxl54HPKF
 Lhyd4k+kocW3DVCjP+4Pds9IVBGZ0eANQrs=

--kNQsyMfvezJga43A0yIk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 30.04.21 14:20, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The variables U_BOOT and BOOTLOADER are only used for swupdate
> mark add the prefix SWUPDATE to indicate the intended usage.

Does not fully parse to me. Do you mean

"The variables U_BOOT and BOOTLOADER are only used for swupdate.
Add the prefix SWUPDATE to indicate the intended usage."

?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate-config.bbclass | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
> index 9909113..8ec1104 100644
> --- a/classes/swupdate-config.bbclass
> +++ b/classes/swupdate-config.bbclass
> @@ -45,19 +45,23 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
>  
>  KFEATURE_DEPS[ubi] = "mtd"
>  
> +
> +SWUPDATE_BOOTLOADER ?= "${BOOTLOADER}"

This doesn't make sense. There is no generic variable "BOOTLOADER" in Isar.

> +SWUPDATE_U_BOOT ?= "${U_BOOT}"

That one as well. What is "U_BOOT"?

>  USE_U_BOOT_CONFIG ?= "true"
> +
>  KFEATURE_u-boot = ""
>  KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
>  KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config' \
>                                            if d.getVar("USE_U_BOOT_CONFIG", True) == "true" \
>                                            else 'libubootenv0.1'}"
> -KFEATURE_u-boot[DEPENDS] = "${U_BOOT} libubootenv"
> +KFEATURE_u-boot[DEPENDS] = "${SWUPDATE_U_BOOT} libubootenv"
>  KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
>  
>  SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
>  
>  def get_bootloader_featureset(d):
> -    bootloader = d.getVar("BOOTLOADER", True) or ""
> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
>      if bootloader == "efibootguard":
>          return "efibootguard"
>      if bootloader == "u-boot":
> @@ -68,11 +72,11 @@ SWUPDATE_KFEATURES ??= ""
>  KFEATURES = "${SWUPDATE_KFEATURES}"
>  KFEATURES += "${@get_bootloader_featureset(d)}"
>  
> -# Astonishingly, as an anonymous python function, BOOTLOADER is always None
> +# Astonishingly, as an anonymous python function, SWUPDATE_BOOTLOADER is always None
>  # one time before it gets set. So the following must be a task.
>  python do_check_bootloader () {
> -    bootloader = d.getVar("BOOTLOADER", True) or "None"
> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
>      if not bootloader in ["efibootguard", "u-boot"]:
> -        bb.warn("swupdate: BOOTLOADER set to incompatible value: " + bootloader)
> +        bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
>  }
>  addtask check_bootloader before do_fetch
> 

Please also clean up kas/opt/ebg-swu.yml, switching to the SWUPDATE
prefixed var name.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--kNQsyMfvezJga43A0yIk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6405): https://lists.cip-project.org/g/cip-dev/message=
/6405
Mute This Topic: https://lists.cip-project.org/mt/82479643/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kNQsyMfvezJga43A0yIk--
