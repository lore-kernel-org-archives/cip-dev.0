Return-Path: <SRS0=hWLL=PC=lists.cip-project.org=bounce+64572+6826+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD1C43217
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 09:49:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C83A610A0
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 09:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C83A610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZI54YY4521723xblqXwGuK5P; Thu, 14 Oct 2021 02:49:18 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.7257.1634204957331568491
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Oct 2021 02:49:18 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 19E9nEfF026574
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Oct 2021 11:49:15 +0200
X-Received: from [167.87.37.165] ([167.87.37.165])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 19E9nE2S004128;
	Thu, 14 Oct 2021 11:49:14 +0200
Subject: Re: [cip-dev] [isar-cip-dev] [PATCH] Update efibootguard to latest one
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan_a@mentor.com>
References: <20211014092737.3911919-1-Srinuvasan_A@mentor.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <a1dab3d1-9b9b-1fba-d8df-90ca63e5c23e@siemens.com>
Date: Thu, 14 Oct 2021 11:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014092737.3911919-1-Srinuvasan_A@mentor.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8nCEgCLA02XOPja56mpdZwOjx4520388AA=
Content-Type: multipart/mixed; boundary="AtxbES4VoK8AhLZ3znWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634204958;
 bh=PunXupeVHYW2A9CGEj6TalpYibodtsIbrj3OyD+8Quk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EzTFeALfYPyH7+bk2Qdy+an8k6Xc9d/rI+gJ+LknuI0wcikGyOunkPFupBagBmFpuMM
 DfIPjF4+6RZ8h3K0F5N2w6f49sCOTzcGzC0JbQ7FgISgxgE0e0e5Enqwk8qxAXkun0p12
 gGPHALinO89mVxaVXv3M7kk/Q0wCiTP1BaM=
Message-ID: <20211014094914.xhDD6sMCXBmc_7Qux3tEV0H1DdivUDfaEB9F0FVHmHo@z>

--AtxbES4VoK8AhLZ3znWp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



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
> 
> 






--AtxbES4VoK8AhLZ3znWp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6826): https://lists.cip-project.org/g/cip-dev/message/=
6826
Mute This Topic: https://lists.cip-project.org/mt/86308311/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AtxbES4VoK8AhLZ3znWp--
