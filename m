Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE78CC433FE
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 20:12:55 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.770.1635883970129608308
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Nov 2021 13:12:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1A2KCkX0008726
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Nov 2021 21:12:47 +0100
Received: from [139.22.43.93] ([139.22.43.93])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1A2KCkJ2002883;
	Tue, 2 Nov 2021 21:12:46 +0100
Subject: Re: [isar-cip-dev] [PATCH] recipes-core/swupdate: Update the SRC_URI
 and SWUPDATE_BUILD_PROFILES append for buster
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <af7d7e65-12b2-2e1a-7ad2-d692a737d0ea@siemens.com>
 <20211102104134.648307-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b002cef7-401c-71e4-eb19-42be16735118@siemens.com>
Date: Tue, 2 Nov 2021 21:12:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102104134.648307-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Nov 2021 20:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6853

On 02.11.21 11:41, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> When we build the swupdate debian package for buster some build
> dependency packages are not available in stable buster repo, hence we created a
> patch in cip-core upstream for buster build, here we hardcoded the distro
> for buster build hence it is building fine in cip-core not the downstream layer,
> added the OVERRIDES for BASE_DISTRO_CODENAME to select the particular base distro.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  recipes-core/swupdate/swupdate.inc                     | 2 ++
>  recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 8 ++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index a469587..191aa2b 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -13,6 +13,8 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
>  LICENSE = "GPL-2.0"
>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>  
> +OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
> +
>  def get_bootloader_build_profile(d):
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
>      if bootloader == "efibootguard":
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index a451b55..e62230f 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -35,14 +35,14 @@ SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>  # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>  
>  # modify for debian buster build
> -SRC_URI_append_cip-core-buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
> +SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>  
>  # disable documentation due to missing packages in debian buster
>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_cip-core-buster = " nodoc \
> -                                                   pkg.swupdate.nocreatefs \
> -                                                   pkg.swupdate.nowebserver "
> +SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
> +                                          pkg.swupdate.nocreatefs \
> +                                          pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other
>  # compression formats.
>  GBP_EXTRA_OPTIONS += "--git-compression=xz"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

