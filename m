Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A4FF885A
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 08:40:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34481.1777970423982132254
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 01:40:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ux3v=dc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 17A9160128;
	Tue,  5 May 2026 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EABC2BCB4;
	Tue,  5 May 2026 08:40:20 +0000 (UTC)
Message-ID: <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
Date: Tue, 5 May 2026 11:40:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
To: pavel@nabladev.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
 cip-dev@lists.cip-project.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Sasha Levin <sashal@kernel.org>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <afhkX2Ys2BG1gnqy@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <afhkX2Ys2BG1gnqy@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 08:40:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22881

Hi, all,

On 5/4/26 12:18, Pavel Machek via lists.cip-project.org wrote:
> Hi!
> 
>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>
>> This fixes an issue caused by the use of msleep during spinlock.
>> In the original commit, msleep was changed to mdelay, but this fix was not
>> carried over during the backport to 5.10.y tree.
> 
> Doing this as a quick fix is probably okay, but this should not be
> final version.
> 
> You are right that msleep inside spinlock will blow up immediately:
> 
>> ```
>> [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
>> [   62.683957] Modules linked in:
> 
> But mdelay for 20 msec inside irqsave spinlock is borderline
> unacceptable, too.
> 
> I believe we'll need Renesas to analyze/fix this properly after the
> CVE emergency is done.
> 
> This fix is good for now, but better fix is needed.
> 
> Claudiu, are you right person for this, or should we cc someone else?

I'm going to investigate and come with a better approach for this.

Thank you and apologies for any inconveniences,
Claudiu


