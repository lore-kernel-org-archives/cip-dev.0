Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2F0CD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 10:04:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.150635.1781604262098945253
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 03:04:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=bli6=em=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57F504031C;
	Tue, 16 Jun 2026 10:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2106A1F000E9;
	Tue, 16 Jun 2026 10:04:19 +0000 (UTC)
Message-ID: <0aad54eb-38bf-4506-8d44-ea5d89d76a16@tuxon.dev>
Date: Tue, 16 Jun 2026 13:04:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
 <ajBolVke5ENiZ9n2@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ajBolVke5ENiZ9n2@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 10:04:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23154

Hi, Pavel,

On 6/16/26 00:03, Pavel Machek wrote:
> On Mon 2026-06-15 12:05:03, Claudiu Beznea wrote:
>> Hi,
>>
>> On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
>>> Hi!
>>>
>>>> Thanks for your patch.
>>>> I reviewed this and other series, these seems to be fine.
>>>> I can apply this if tests are OK and there are no other comments.
>>>>     Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>>>
>>> I'm looking into it. As this modifies generic code, I suggest we are
>>> cautious here.
>> Please let me know if you want me to limit that code to RZ/G3S SoC only.
> 
> I'm still reviewing the series, sorry for delay.
> 
> My first preffered option would be explanation why this is okay on
> 5.10: (Will it change behaviour on non-renesas boards? How sure we are
> the behaviour change will not break something, or slow things down
> significantly?)

It is code in the common path, so, yes, theoretically the behavior is changed. 
Only the IPs that don't have resets will not be affected.

The same resets are touched on probe and remove, this being a not that strong 
argument for which I consider we might need this not only for RZ/G3S.

However, I am open to adjust it to make it work only for RZ/G3S. Please let me 
know and I'll proceed as such.

> 
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(struct device *dev)
>          if (pdata->power_suspend)
>                  pdata->power_suspend(pdev);
> 
> +       ret = reset_control_assert(priv->rsts);
> +       if (ret) {
> +               if (pdata->power_on)
> +                       pdata->power_on(pdev);
> +
> +               ehci_resume(hcd, false);
> +
> +               if (priv->quirk_poll)
> +                       quirk_poll_init(priv);
> +       }
> +
> 
> If we can't have the explanation, limiting to renesas boards would be
> fine next option.

Before posting to upstream, I've checked this restore path here by not calling 
the reset_control_assert() and letting the execution go to pdata->power_on(), 
ehci_resume(), quirk_poll_init().

Please let me know and I'll limit this only to Renesas boards.

Thank you,
Claudiu

