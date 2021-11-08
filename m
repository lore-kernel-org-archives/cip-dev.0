Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3DC433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 15:18:41 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.46400.1636384719911905486
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Nov 2021 07:18:40 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1A8FIbPO012608
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Nov 2021 16:18:37 +0100
Received: from [167.87.33.94] ([167.87.33.94])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1A8FIa1s011714;
	Mon, 8 Nov 2021 16:18:37 +0100
Subject: Re: [isar-cip-core] [PATCH] Kconfig: correct the name of image format
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20211108104905.2745110-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <86b396ca-c8a9-a722-3643-e7d69609ee1c@siemens.com>
Date: Mon, 8 Nov 2021 16:18:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108104905.2745110-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Nov 2021 15:18:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6869

On 08.11.21 11:49, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update the exact image format name in kconfig menu.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 13c3315..8421f1b 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -110,8 +110,8 @@ endchoice
>  
>  config KAS_INCLUDE_IMAGE_FORMAT
>  	string
> -	default "kas/opt/targz.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
> -	default "kas/opt/wic-targz.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
> +	default "kas/opt/targz-img.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
> +	default "kas/opt/wic-targz-img.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
>  
>  config IMAGE_SECURITY
>  	bool "Security extensions"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

