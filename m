Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A5CDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 13:41:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43444.1782135677832306319
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 06:41:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=fijv=es=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C24F601F3;
	Mon, 22 Jun 2026 13:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8091F000E9;
	Mon, 22 Jun 2026 13:41:15 +0000 (UTC)
Message-ID: <66c961dc-ebdb-4691-a86f-c7f39209f839@tuxon.dev>
Date: Mon, 22 Jun 2026 16:41:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
 <ajBolVke5ENiZ9n2@duo.ucw.cz> <18B987A3256F1E3A.267903@lists.cip-project.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <18B987A3256F1E3A.267903@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 13:41:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23248

Hi,

Gentle ping on this topic.

Thank you,
Claudiu

On 6/16/26 13:04, claudiu beznea via lists.cip-project.org wrote:
> Hi, Pavel,
>=20
> On 6/16/26 00:03, Pavel Machek wrote:
>> On Mon 2026-06-15 12:05:03, Claudiu Beznea wrote:
>>> Hi,
>>>
>>> On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
>>>> Hi!
>>>>
>>>>> Thanks for your patch.
>>>>> I reviewed this and other series, these seems to be fine.
>>>>> I can apply this if tests are OK and there are no other comments.
>>>>> =C2=A0=C2=A0=C2=A0 Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamats=
u.x90@mail.toshiba>
>>>>
>>>> I'm looking into it. As this modifies generic code, I suggest we are
>>>> cautious here.
>>> Please let me know if you want me to limit that code to RZ/G3S SoC on=
ly.
>>
>> I'm still reviewing the series, sorry for delay.
>>
>> My first preffered option would be explanation why this is okay on
>> 5.10: (Will it change behaviour on non-renesas boards? How sure we are
>> the behaviour change will not break something, or slow things down
>> significantly?)
>=20
> It is code in the common path, so, yes, theoretically the behavior is c=
hanged.=20
> Only the IPs that don't have resets will not be affected.
>=20
> The same resets are touched on probe and remove, this being a not that =
strong=20
> argument for which I consider we might need this not only for RZ/G3S.
>=20
> However, I am open to adjust it to make it work only for RZ/G3S. Please=
 let me=20
> know and I'll proceed as such.
>=20
>>
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(s=
truct=20
>> device *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pdata->power_susp=
end)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pdata->power_suspend(pdev);
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D reset_control_assert(pri=
v->rsts);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (pdata->power_on)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata->po=
wer_on(pdev);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ehci_resume(hcd, false);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (priv->quirk_poll)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirk_pol=
l_init(priv);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>>
>> If we can't have the explanation, limiting to renesas boards would be
>> fine next option.
>=20
> Before posting to upstream, I've checked this restore path here by not =
calling=20
> the reset_control_assert() and letting the execution go to pdata->power=
_on(),=20
> ehci_resume(), quirk_poll_init().
>=20
> Please let me know and I'll limit this only to Renesas boards.
>=20
> Thank you,
> Claudiu
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23154): https://lists.cip-project.org/g/cip-dev/mes=
sage/23154
> Mute This Topic: https://lists.cip-project.org/mt/119752781/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [claudiu.bez=
nea@tuxon.dev]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


