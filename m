Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C16DC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 09:49:19 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.7257.1634204957331568491
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Oct 2021 02:49:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 19E9nEfF026574
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Oct 2021 11:49:15 +0200
Received: from [167.87.37.165] ([167.87.37.165])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 19E9nE2S004128;
	Thu, 14 Oct 2021 11:49:14 +0200
Subject: Re: [cip-dev] [isar-cip-dev] [PATCH] Update efibootguard to latest
 one
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan_a@mentor.com>
References: <20211014092737.3911919-1-Srinuvasan_A@mentor.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <a1dab3d1-9b9b-1fba-d8df-90ca63e5c23e@siemens.com>
Date: Thu, 14 Oct 2021 11:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014092737.3911919-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 09:49:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6826



On 10/14/21 11:27 AM, Srinuvasan A via lists.cip-project.org wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update efibootguard to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>   recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> index ebd848d..4e7b9b2 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
> @@ -22,7 +22,7 @@ SRC_URI = "git://github.com/siemens/efibootguard.git;branch=master;protocol=http
>   
>   S = "${WORKDIR}/git"
>   
> -SRCREV = "ac1685aea75fb3e3d16c0c0e4f8261a2edb63536"
> +SRCREV = "66d78b8d96e80caaf20007f08b5ca720de628d49"


Why do you need to update to a non released version of efibootguard?

Until now we used only tag version in this recipe.

Quirin
>   
>   PROVIDES = "${PN}"
>   PROVIDES += "${PN}-dev"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6825): https://lists.cip-project.org/g/cip-dev/message/6825
> Mute This Topic: https://lists.cip-project.org/mt/86308311/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 






