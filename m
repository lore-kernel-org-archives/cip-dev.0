Return-Path: <SRS0=jMcC=AK=lists.cip-project.org=bounce+64572+4847+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6920C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 08:14:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E77C23355
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 08:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="s6bFouBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E77C23355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4847+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NCKbYY4521723xKOSBBLCtYq; Mon, 29 Jun 2020 01:14:08 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.14071.1593418447459910014
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 01:14:08 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 05T8E4xO012953
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 10:14:05 +0200
X-Received: from [167.87.50.192] ([167.87.50.192])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05T8E4ZJ011210;
	Mon, 29 Jun 2020 10:14:04 +0200
Subject: Re: [cip-dev] [isar-cip-core RFC 6/7] swupdate: Add luahandler for secureboot
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
 <20200625141015.31719-7-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <7e9f03be-1cc3-48be-98bf-c0b8b1692c7a@siemens.com>
Date: Mon, 29 Jun 2020 10:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625141015.31719-7-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cSVCrdJNhHvDwh0tn0Q5WKVrx4520388AA=
Content-Type: multipart/mixed; boundary="oumK8frlxQLPbSDoa8Zk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593418448;
 bh=OEc9ph2b1+DsgDzWMcQCQJAilqmaZ+27smRBRXCMftA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=s6bFouBSLtSOXKtf6jVjx33vskKKCmJZSGYJLg4IbdXUyJ0rt5nbAYg00jzK4d0IuhQ
 bis46bKYip84rhgOACpytsTGfVI+7VXNPvHaVMrvk6seBQSWF4h69uX/2+Fxcna/z3qVU
 5muMDgCpsQVDVI+1te/mifnsdvB/ZcENOt0=

--oumK8frlxQLPbSDoa8Zk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 25.06.20 16:10, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   recipes-core/swupdate/files/swupdate_handlers.lua | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/swupdate/files/swupdate_handlers.lua b/recipes-core/swupdate/files/swupdate_handlers.lua
> index c9b9962..f2ecc54 100644
> --- a/recipes-core/swupdate/files/swupdate_handlers.lua
> +++ b/recipes-core/swupdate/files/swupdate_handlers.lua
> @@ -311,8 +311,12 @@ function handler_roundrobin(image)
>           if rootparam and rootdevice then break end
>       end
>       if not rootdevice then
> -      swupdate.error("Cannot determine current root device.")
> -      return 1
> +        -- Use findmnt to get the rootdev
> +      rootdevice = io.popen('findmnt -nl / -o PARTUUID'):read("*l")
> +      if not rootdevice then
> +        swupdate.error("Cannot determine current root device.")
> +        return 1
> +      end
>       end
>       swupdate.info(string.format("Current root device is: %s", rootdevice))
>   
> 

Seems not really specific to secure-boot, rather related to the 
initramfs-based rootfs selection. But is that one actually using 
PARTUUID in the end? Or rather device paths?

Anyway, I'm not against merging this. It should just be correctly 
labeled. Or maybe even merged into the swupdate patch from the first series.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--oumK8frlxQLPbSDoa8Zk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4847): https://lists.cip-project.org/g/cip-dev/message=
/4847
Mute This Topic: https://lists.cip-project.org/mt/75103454/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--oumK8frlxQLPbSDoa8Zk--
