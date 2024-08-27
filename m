Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC517C54734
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 12:54:22 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.76975.1724763258237439454
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 05:54:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,180,1719846000"; 
   d="scan'208";a="216724300"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Aug 2024 21:54:16 +0900
Received: from [10.226.93.135] (unknown [10.226.93.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E4D0F4007202;
	Tue, 27 Aug 2024 21:54:14 +0900 (JST)
Message-ID: <0bced308-a420-4664-8b21-bf24dae17664@bp.renesas.com>
Date: Tue, 27 Aug 2024 13:54:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y cip 0/8] Backport ravb driver performance
 improvements
Content-Language: en-GB
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
 <ZqntqGYravYHauM1@duo.ucw.cz>
 <ac9dbdc6-ef2f-453a-bc0a-94db12e95414@bp.renesas.com>
 <Zqvmmy93WNzvezGB@duo.ucw.cz>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <Zqvmmy93WNzvezGB@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 12:54:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16815

On 01/08/2024 20:48, Pavel Machek wrote:
> Hi!
> 
>>>> This series includes the performance improvements present in Linux
>>>> v6.11-rc1 along with dependencies.
>>>
>>> That's a bit aggressive timing, is it? -rc1 does not really get much
>>> testing.
>>
>> Hi Pavel,
>>
>> Please feel free to delay merging these patches for a couple of rc
>> cycles if you need to.
> 
> I'm getting:
> 
> drivers/net/ethernet/renesas/ravb_main.c: In function 'ravb_rx_gbeth':
> 2534
> drivers/net/ethernet/renesas/ravb_main.c:869:33: error: implicit declaration of function 'skb_mark_for_recycle' [-Werror=implicit-function-declaration]
> 2535
>   869 |                                 skb_mark_for_recycle(skb);
> 2536
>       |                                 ^~~~~~~~~~~~~~~~~~~~
> 2537
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/7484664109
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1397249930
> 
> When attempting to test this. Fix is probably as simple as:
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 2a48ffc08464f..25a15cda707a0 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -31,6 +31,7 @@
>  #include <linux/sys_soc.h>
>  #include <linux/reset.h>
>  #include <linux/math64.h>
> +#include <linux/skbuff.h>
>  #include <net/ip.h>
>  #include <net/page_pool.h>

Hi Pavel,

I've left this for a while, to my knowledge no issues have been reported
with these changes in the v6.11-rc series so far.

The issue above is not due to a missing include, it's due to the
skb_mark_for_recycle() function only being defined when CONFIG_PAGE_POOL
is enabled. I'll open a merge request to enable that in the relevant
configs in cip-kernel-config. Once that is merged, we can proceed with
this backport.

Thanks,

-- 
Paul Barker

