Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB989CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 09:03:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.125517.1781514201175516086
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 02:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=78qu=el=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1827B6008A;
	Mon, 15 Jun 2026 09:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983BC1F000E9;
	Mon, 15 Jun 2026 09:03:18 +0000 (UTC)
Message-ID: <b449bbfa-b9d9-4595-87d4-b0600fe92be3@tuxon.dev>
Date: Mon, 15 Jun 2026 12:03:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
 "pavel@nabladev.com" <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
 <20260611104532.2532863-22-claudiu.beznea@tuxon.dev>
 <TY3PR01MB113463A4C767A966DE71DE7CC86192@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5dd61d89-971a-4a8a-a95d-c3d9723f6566@tuxon.dev>
 <18B9314B608D99FF.312216@lists.cip-project.org>
 <TY3PR01MB113469BEC5232D3C9713D21D286E62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113469BEC5232D3C9713D21D286E62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 09:03:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23138



On 6/15/26 11:25, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Biju Das via lists.cip-
>> project.org
>> Sent: 15 June 2026 08:42
>> To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; nobuhiro.iwamatsu.x90@mail.toshiba; pavel@nabladev.com
>> Cc: cip-dev@lists.cip-project.org
>> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding attributes
>>
>>>>
>>>> On mainline while adding RZ/G3L USB2.0 host support, I used to get
>>>> WARN_ON for regulator enable count during PHY unbind/bind and is
>>>> fixed by[1]
>>>
>>> Is not about the harmless WARN_ON() but failures that lead to system crashes.
>>
>> Looks it is 6.1 and 5.10 related as I do not see a patch related to this in 6.12
> 
> Since on bind/unbind in mainline works fine, it could be that we are missing some patch
> On 5.10 and 6.1
> 
> I will avoid restricting bind/unbind on these devices on 6.1 and 5.10.

I failed to find a fix patch to backport for this and I expect to be something 
core specific.

Thank you,
Claudiu



