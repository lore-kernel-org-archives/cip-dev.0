Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE8BC433EF
	for <webhook@archiver.kernel.org>; Fri, 29 Oct 2021 15:08:59 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.6642.1635520138212682903
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Oct 2021 08:08:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 19TF8tNx028649
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Oct 2021 17:08:55 +0200
Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19TF8tVB031468;
	Fri, 29 Oct 2021 17:08:55 +0200
Subject: Re: [isar-cip-dev] [PATCH] recipes-core/swupdate: Update the SRC_URI
 and SWUPDATE_BUILD_PROFILES append for buster
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <f1d37383-5262-910f-4791-f42a8f16cb66@siemens.com>
 <20211029053940.625034-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <af7d7e65-12b2-2e1a-7ad2-d692a737d0ea@siemens.com>
Date: Fri, 29 Oct 2021 17:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029053940.625034-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Oct 2021 15:08:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6850

On 29.10.21 07:39, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> When we build the swupdate debian package for buster some build
> dependency packages are not available in stable buster repo, hence we created a
> patch in cip-core upstream for buster build, here we hardcoded the distro
> for buster build hence it is building fine in cip-core not the
> downstream layer, added the "BASE_DISTRO_CODENAME" variable to pick the proper base distro.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index a451b55..e6526ba 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -35,14 +35,14 @@ SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>  # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>  
>  # modify for debian buster build
> -SRC_URI_append_cip-core-buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
> +SRC_URI_append_${BASE_DISTRO_CODENAME} = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>  
>  # disable documentation due to missing packages in debian buster
>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_cip-core-buster = " nodoc \
> -                                                   pkg.swupdate.nocreatefs \
> -                                                   pkg.swupdate.nowebserver "
> +SWUPDATE_BUILD_PROFILES_append_${BASE_DISTRO_CODENAME} = " nodoc \
> +                                                           pkg.swupdate.nocreatefs \
> +                                                           pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other
>  # compression formats.
>  GBP_EXTRA_OPTIONS += "--git-compression=xz"
> 

Please have a look at the bitbake manual, how overrides work
(https://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html#conditional-syntax-overrides).
And test whether your code is behaving as expected, also for non-buster
images.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

