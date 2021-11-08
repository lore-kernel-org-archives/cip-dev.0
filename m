Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F38C433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 13:59:10 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.45238.1636379948517689937
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Nov 2021 05:59:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1A8Dx5qE002436
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 8 Nov 2021 14:59:06 +0100
Received: from [167.87.33.94] ([167.87.33.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1A8Dx5CY021528;
	Mon, 8 Nov 2021 14:59:05 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: add cross and
 nocheck to build profile
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211108134534.1866031-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9c8524dd-bb91-45ff-d6dd-1d519fd035a5@siemens.com>
Date: Mon, 8 Nov 2021 14:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108134534.1866031-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Nov 2021 13:59:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6867

On 08.11.21 14:45, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> During cross compiling for arm the builds fails
> with the following message:
> 
> ```
> strip -N main -o /home/builder/swupdate/git/core/built-in.o.tmp /home/builder/swupdate/git/core/built-in.o
> strip: Unable to recognise the format of the input file `/home/builder/swupdate/git/core/built-in.o'
> make[3]: *** [/home/builder/swupdate/git/test/Makefile:71: test/test_json.lnk] Error 1
> m
> ```
> 
> Add cross and nocheck to SWUPDATE_BUILD_PROFILES to avoid
> the build error.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - Fix commit message
> 
> recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index e62230f..7a0fb9b 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -28,6 +28,8 @@ SRC_URI += "file://0001-debian-Add-option-to-build-with-efibootguard.patch \
>  # deactivate signing and encryption for simple a/b rootfs update
>  SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>  
> +# add cross build and deactivate testing for arm based builds
> +SWUPDATE_BUILD_PROFILES += "cross nocheck"
>  # If the luahandler shall be embedded into the swupdate binary
>  # include the following lines.
>  # DEPENDS += "swupdate-handlers"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

