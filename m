Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B415BC433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Oct 2021 09:28:09 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.7005.1633339688406911247
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 02:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1949S5SM001203
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 11:28:05 +0200
Received: from [167.87.3.213] ([167.87.3.213])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1949S44A001065;
	Mon, 4 Oct 2021 11:28:04 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] kas/opt/swupdate: Change
 assignment of IMAGE_TYPE and WKS_FILE
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
 <20210928184947.AYjduU9bTolWO5fGM5sHK1KwOFt_xWwyNQv5uQOgPvk@z>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5da61997-9b25-d965-9d5b-0f148c8f4e5b@siemens.com>
Date: Mon, 4 Oct 2021 11:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928184947.AYjduU9bTolWO5fGM5sHK1KwOFt_xWwyNQv5uQOgPvk@z>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Oct 2021 09:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6771

On 28.09.21 20:49, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Replace the default assignment to ensure the generation of the
> swu file. As stated in [1]: If multiple `?=` assignments are used
> the first of those assignments ends up getting used.
> 
> This fixes [2].
> 
> [1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
> [2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/swupdate.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 7d86ad5..3cc02a3 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -19,5 +19,5 @@ local_conf_header:
>      IMAGE_INSTALL_append = " swupdate"
>  
>    wic-swu: |
> -    IMAGE_TYPE ?= "wic-swu-img"
> -    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> +    IMAGE_TYPE = "wic-swu-img"
> +    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

