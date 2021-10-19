Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2DC433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 08:33:23 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.7034.1634632386614969892
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Oct 2021 01:33:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 19J8X4Sq032372
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Oct 2021 10:33:04 +0200
Received: from [167.87.73.119] ([167.87.73.119])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19J8X3fw021008;
	Tue, 19 Oct 2021 10:33:03 +0200
Subject: Re: [isar-cip-dev] [PATCH] Update efibootguard to latest release 0.9
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20211018111946.4192167-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <97eef0c5-e565-770d-2187-8b125ec95586@siemens.com>
Date: Tue, 19 Oct 2021 10:33:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018111946.4192167-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Oct 2021 08:33:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6831

On 18.10.21 13:19, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Uprevision the latest revision and tag.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  ...fibootguard_0.8-git+isar.bb => efibootguard_0.9-git+isar.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.8-git+isar.bb => efibootguard_0.9-git+isar.bb} (95%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
> similarity index 95%
> rename from recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
> index ebd848d..2817e5b 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
> @@ -22,7 +22,7 @@ SRC_URI = "git://github.com/siemens/efibootguard.git;branch=master;protocol=http
>  
>  S = "${WORKDIR}/git"
>  
> -SRCREV = "ac1685aea75fb3e3d16c0c0e4f8261a2edb63536"
> +SRCREV = "c01324d0da202727eb0744c0f67a78f9c9b65c46"
>  
>  PROVIDES = "${PN}"
>  PROVIDES += "${PN}-dev"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

