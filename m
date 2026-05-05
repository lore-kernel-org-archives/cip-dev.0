Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEEFCD3430
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 08:49:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34569.1777970970302346850
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 01:49:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ux3v=dc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B7BE60128;
	Tue,  5 May 2026 08:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAA4C2BCC7;
	Tue,  5 May 2026 08:49:26 +0000 (UTC)
Message-ID: <f81033c2-3432-4275-b5a7-78c61c31502a@tuxon.dev>
Date: Tue, 5 May 2026 11:49:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: pavel@nabladev.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
 cip-dev@lists.cip-project.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Sasha Levin <sashal@kernel.org>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <afhkX2Ys2BG1gnqy@duo.ucw.cz>
 <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
Content-Language: en-US
In-Reply-To: <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 08:49:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22882



On 5/5/26 11:40, Claudiu Beznea wrote:
> Hi, all,
>=20
> On 5/4/26 12:18, Pavel Machek via lists.cip-project.org wrote:
>> Hi!
>>
>>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>>
>>> This fixes an issue caused by the use of msleep during spinlock.
>>> In the original commit, msleep was changed to mdelay, but this fix wa=
s not
>>> carried over during the backport to 5.10.y tree.
>>
>> Doing this as a quick fix is probably okay, but this should not be
>> final version.
>>
>> You are right that msleep inside spinlock will blow up immediately:
>>
>>> ```
>>> [=C2=A0=C2=A0 62.677594] BUG: scheduling while atomic: kworker/1:2/12=
6/0x00000002
>>> [=C2=A0=C2=A0 62.683957] Modules linked in:
>>
>> But mdelay for 20 msec inside irqsave spinlock is borderline
>> unacceptable, too.
>>
>> I believe we'll need Renesas to analyze/fix this properly after the
>> CVE emergency is done.
>>
>> This fix is good for now, but better fix is needed.
>>
>> Claudiu, are you right person for this, or should we cc someone else?
>=20
> I'm going to investigate and come with a better approach for this.

On a second thought, the proper fix would have to go to upstream first. T=
o fix=20
the problem currently seen, could we integrate this patch as is?

Thank you,
Claudiu

