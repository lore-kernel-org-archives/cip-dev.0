Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E215ECD98DA
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 09:05:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.125624.1781514306745158427
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 02:05:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=78qu=el=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EBA3B42B70;
	Mon, 15 Jun 2026 09:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A381F000E9;
	Mon, 15 Jun 2026 09:05:04 +0000 (UTC)
Message-ID: <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
Date: Mon, 15 Jun 2026 12:05:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
To: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aisi82Eui1N1svgC@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 09:05:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23139

Hi,

On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
> Hi!
> 
>> Thanks for your patch.
>> I reviewed this and other series, these seems to be fine.
>> I can apply this if tests are OK and there are no other comments.
>>    Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> 
> I'm looking into it. As this modifies generic code, I suggest we are
> cautious here.
Please let me know if you want me to limit that code to RZ/G3S SoC only.

Thank you,
Claudiu

