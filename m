Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28995C433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 17:44:22 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.291.1633542260593144428
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 10:44:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 196HiHr0016801
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Oct 2021 19:44:17 +0200
Received: from [167.87.72.94] ([167.87.72.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 196HiHNX005411;
	Wed, 6 Oct 2021 19:44:17 +0200
Subject: Re: [isar-cip-dev] [PATCH] Uprevision the ISAR to latest one
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20211006101422.1976005-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cea9be82-1809-0ea8-55d7-7074c4e7e55f@siemens.com>
Date: Wed, 6 Oct 2021 19:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006101422.1976005-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Oct 2021 17:44:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6795

On 06.10.21 12:14, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update to latest ISAR.
> 
> When we build the images with efibootguard wic plugin it is expecting
> the KERNEL_IMAGE and INITRD_IMAGE variable, but it is removed in
> Upstream ISAR due to cleanup the unused variables.
> 
> Ref: https://github.com/ilbers/isar/commit/6fa0197ac36a86b2ae5c27f5b7804dd9a46d3c0b
> 
> But those variables we used in downstream layer with efibootguard wic
> plugin hence added required WIC variables in efibootguard.yml to genereate successful wic images.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  kas-cip.yml              | 2 +-
>  kas/opt/efibootguard.yml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 8522957..4eadaa7 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: 03124cca669f50b682336a0bdf4ede5a4238e144
> +    refspec: 9b31dae3284127d4aed4b9331af1b1c3c31152f5
>      layers:
>        meta:
>  
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> index 705a76d..580c315 100644
> --- a/kas/opt/efibootguard.yml
> +++ b/kas/opt/efibootguard.yml
> @@ -22,7 +22,7 @@ local_conf_header:
>  
>    efibootguard-wic: |
>      WDOG_TIMEOUT ?= "60"
> -    WICVARS += "WDOG_TIMEOUT"
> +    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
>      IMAGE_TYPE ?= "wic-img"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>  
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

