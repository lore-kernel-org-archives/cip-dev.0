Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F837C433FE
	for <webhook@archiver.kernel.org>; Mon,  4 Oct 2021 13:44:41 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.9507.1633355079911581361
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 06:44:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 194DiaPa028909
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 15:44:37 +0200
Received: from [167.87.3.213] ([167.87.3.213])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194Diaco010822;
	Mon, 4 Oct 2021 15:44:36 +0200
Subject: Re: [PATCH v2] kas/opt/swupdate: Change assignment of IMAGE_TYPE and
 WKS_FILE
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
References: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
 <20211004132713.1827767-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dedb4f99-d18f-de18-53c9-170f2fea471e@siemens.com>
Date: Mon, 4 Oct 2021 15:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004132713.1827767-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Oct 2021 13:44:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6777

On 04.10.21 15:27, Q. Gylstorff wrote:
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
>  kas/opt/swupdate.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 7d86ad5..bd0f6e4 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -19,5 +19,5 @@ local_conf_header:
>      IMAGE_INSTALL_append = " swupdate"
>  
>    wic-swu: |
> -    IMAGE_TYPE ?= "wic-swu-img"
> +    IMAGE_TYPE = "wic-swu-img"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> 

Thanks, replaced v1 with this in next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

