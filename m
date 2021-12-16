Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC6C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:10:28 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.10283.1639660227265683001
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:10:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1BGDAOLE024229
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Dec 2021 14:10:24 +0100
Received: from [167.87.32.230] ([167.87.32.230])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1BGDAN4Z029415;
	Thu, 16 Dec 2021 14:10:23 +0100
Message-ID: <abb479a0-ece9-f2ec-d6ed-58ce88a1df7a@siemens.com>
Date: Thu, 16 Dec 2021 14:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [cip-dev] [isar-cip-core][PATCH 2/2] swupdate: Drop conditional
 includes for buster
Content-Language: en-US
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
References: <20211216130450.3402865-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216130450.3402865-3-Vijaikumar_Kanagarajan@mentor.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <20211216130450.3402865-3-Vijaikumar_Kanagarajan@mentor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:10:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7151

Hi,

On 12/16/21 14:04, Kanagarajan, Vijaikumar via lists.cip-project.org wrote:
> Stretch in now dropped. The conditional includes for buster is now not
> needed. Those includes are applicable to buster as well as bullseye.
> 
> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
> ---
>   .../swupdate/swupdate_2021.04-1+debian-gbp.bb  | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index a4d67fe..826982a 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -23,7 +23,8 @@ SRC_URI += "file://0001-debian-Add-option-to-build-with-efibootguard.patch \
>               file://0005-debian-rules-Add-option-to-disable-fs-creation.patch \
>               file://0006-debian-rules-Add-option-to-disable-webserver.patch \
>               file://0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
> -            file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch"
> +            file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch \
> +            file://0009-debian-prepare-build-for-isar-debian-buster.patch"

The patch 0009-debian-prepare-build-for-isar-debian-buster.patch should 
not be applied to bullseye as it can have an impact on the functionality 
of SWUpdate.

Quirin
>   
>   # Patch for dm-verity based images - can be removed with next SWUpdate release
>   SRC_URI += "file://0001-debian-patches-add-patches-for-dm-verity.patch"
> @@ -41,15 +42,12 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>   # GBP_DEPENDS += "swupdate-handlers"
>   # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>   
> -# modify for debian buster build
> -SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
> -
> -# disable documentation due to missing packages in debian buster
> -# disable create filesystem due to missing symbols in debian buster
> -# disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
> -                                          pkg.swupdate.nocreatefs \
> -                                          pkg.swupdate.nowebserver "
> +# disable documentation due to missing packages
> +# disable create filesystem due to missing symbols
> +# disable webserver due to missing symbols
> +SWUPDATE_BUILD_PROFILES_append = " nodoc \
> +                                   pkg.swupdate.nocreatefs \
> +                                   pkg.swupdate.nowebserver "
>   # In debian buster the git-compression defaults to gz and does not detect other
>   # compression formats.
>   GBP_EXTRA_OPTIONS += "--git-compression=xz"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7150): https://lists.cip-project.org/g/cip-dev/message/7150
> Mute This Topic: https://lists.cip-project.org/mt/87766371/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


