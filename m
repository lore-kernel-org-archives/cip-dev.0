Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE4FCD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 07:54:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40437.1781164453729123636
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 00:54:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0F5F3445F8;
	Thu, 11 Jun 2026 07:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A051F00893;
	Thu, 11 Jun 2026 07:54:11 +0000 (UTC)
Message-ID: <e7d3fbb7-4b06-4e7d-b0b4-323534343f31@tuxon.dev>
Date: Thu, 11 Jun 2026 10:54:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 07:54:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23060

Hi, Nobuhiro,

On 6/11/26 08:46, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi Claudiu,
> 
> Thanks for your patch.
> I reviewed this and other series, these seems to be fine.
> I can apply this if tests are OK and there are no other comments.
>    Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> 
> BTW, it seems your patches hasn't been posted to cip-dev ML yet. (Maybe because the email address is at kernel.org?)
> Could you check it?

It may be, it's the first time I'm using this kernel.org email to send patches 
to cip-dev. Could you please let me know where should I check?

I can re-post using the previously good email address. Would you like me to 
proceed like this?

Thank you,
Claudiu


