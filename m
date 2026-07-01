Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E419C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:17:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44885.1782911815353628820
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 06:16:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=frra=e3=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 294356001D;
	Wed,  1 Jul 2026 13:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02701F000E9;
	Wed,  1 Jul 2026 13:16:52 +0000 (UTC)
Message-ID: <2fe75c6b-9ab7-453d-8042-a56d55cbf3f5@tuxon.dev>
Date: Wed, 1 Jul 2026 16:16:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
 <ajBolVke5ENiZ9n2@duo.ucw.cz>
 <TY7PR01MB148180CBA9D53CA9256F7189CCDE62@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY7PR01MB148180CBA9D53CA9256F7189CCDE62@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 13:17:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23369

Hi, all,

Apologies for the late reply.

On 6/16/26 02:50, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi all,
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=
 Behalf Of Pavel Machek via lists.cip-project.org
>> Sent: Tuesday, June 16, 2026 6:03 AM
>> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Cc: pavel@nabladev.com; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=
=E6=B4=8B =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=
=EF=BC=B0=EF=BC=B4) <nobuhiro.iwamatsu.x90@mail.toshiba>;
>> cip-dev@lists.cip-project.org
>> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB su=
pport
>>
>> On Mon 2026-06-15 12:05:03, Claudiu Beznea wrote:
>>> Hi,
>>>
>>> On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
>>>> Hi!
>>>>
>>>>> Thanks for your patch.
>>>>> I reviewed this and other series, these seems to be fine.
>>>>> I can apply this if tests are OK and there are no other comments.
>>>>>     Reviewed-by: Nobuhiro Iwamatsu
>>>>> <nobuhiro.iwamatsu.x90@mail.toshiba>
>>>>
>>>> I'm looking into it. As this modifies generic code, I suggest we are
>>>> cautious here.
>>> Please let me know if you want me to limit that code to RZ/G3S SoC on=
ly.
>>
>> I'm still reviewing the series, sorry for delay.
>>
>> My first preffered option would be explanation why this is okay on
>> 5.10: (Will it change behaviour on non-renesas boards? How sure we are=
 the behaviour change will not break something,
>> or slow things down
>> significantly?)
>>
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(s=
truct device *dev)
>>          if (pdata->power_suspend)
>>                  pdata->power_suspend(pdev);
>>
>> +       ret =3D reset_control_assert(priv->rsts);
>> +       if (ret) {
>> +               if (pdata->power_on)
>> +                       pdata->power_on(pdev);
>> +
>> +               ehci_resume(hcd, false);
>> +
>> +               if (priv->quirk_poll)
>> +                       quirk_poll_init(priv);
>> +       }
>> +
>>
>> If we can't have the explanation, limiting to renesas boards would be =
fine next option.
>=20
> This concern was also discussed when the original patch was posted.
>     https://lkml.org/lkml/2025/11/7/557
>=20
> If we are only addressing specific SoCs, I think we need to fix it in U=
pstream first.

The upstream discussion was about the code that tries to restore the USB =
state=20
in case the reset_control_assert() fails.

+       if (ret) {
+               if (pdata->power_on)
+                       pdata->power_on(pdev);
+
+               ehci_resume(hcd, false);
+
+               if (priv->quirk_poll)
+                       quirk_poll_init(priv);
+       }

In the end the ohci/ehci platform driver maintainer agreed with the solut=
ion=20
presented in this patch.

Could you please let me know what would you consider it should be fixed u=
pstream?

Regarding the reset_control_assert()/reset_control_deassert() on the=20
suspend/resume path, for the Renesas RZ/G3S SoC we need it as the SoC sup=
ports a=20
suspend mode where power to the USB devices is turned off. On resume we n=
eed to=20
re-configure the USB along with enabling the clocks and de-asserting the =
resets.

Thank you,
Claudiu

