Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48222C433EF
	for <webhook@archiver.kernel.org>; Thu, 28 Oct 2021 13:46:24 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.13229.1635428783079739666
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Oct 2021 06:46:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 19SDkILM026111
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Oct 2021 15:46:19 +0200
Received: from [167.87.0.189] ([167.87.0.189])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19SDkIM9013854;
	Thu, 28 Oct 2021 15:46:18 +0200
Subject: Re: [isar-cip-dev] [PATCH] recipes-core/swupdate: Update the SRC_URI
 and SWUPDATE_BUILD_PROFILES append for buster
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20211028111544.603217-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f1d37383-5262-910f-4791-f42a8f16cb66@siemens.com>
Date: Thu, 28 Oct 2021 15:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028111544.603217-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Oct 2021 13:46:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6846

On 28.10.21 13:15, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> When we build the swupdate debian package for buster some build
> dependency packages are not available in stable buster, hence we created a
> patch in cip-core upstream for buster build, here we hardcoded the distro
> for buster build hence it is building fine in cip-core not the
> downstream layer, added the "DISTRO" variable to pick the proper distro name.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index a451b55..f8298f0 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -35,14 +35,14 @@ SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>  # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>  
>  # modify for debian buster build
> -SRC_URI_append_cip-core-buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
> +SRC_URI_append_${DISTRO} = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"

This makes no sense. DISTRO is in OVERRIDES, so this will always match.
And that would also not make sense for a patch that is for buster only.

You likely want to match on BASE_DISTRO_CODENAME. That means expanding
OVERRIDES accordingly.

Jan

>  
>  # disable documentation due to missing packages in debian buster
>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_cip-core-buster = " nodoc \
> -                                                   pkg.swupdate.nocreatefs \
> -                                                   pkg.swupdate.nowebserver "
> +SWUPDATE_BUILD_PROFILES_append_${DISTRO} = " nodoc \
> +                                             pkg.swupdate.nocreatefs \
> +                                             pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other
>  # compression formats.
>  GBP_EXTRA_OPTIONS += "--git-compression=xz"
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

