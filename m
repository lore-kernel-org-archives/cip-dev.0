Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22254C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:35:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45324.1782912901096795147
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 06:35:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=frra=e3=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30202439FD;
	Wed,  1 Jul 2026 13:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4061F00A3A;
	Wed,  1 Jul 2026 13:34:58 +0000 (UTC)
Message-ID: <22407076-5811-4184-9c33-8278d7538488@tuxon.dev>
Date: Wed, 1 Jul 2026 16:34:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
 "pavel@nabladev.com" <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
 <ajBolVke5ENiZ9n2@duo.ucw.cz>
 <TY7PR01MB148180CBA9D53CA9256F7189CCDE62@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB113465DBF7530E6B918E49F3486E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113465DBF7530E6B918E49F3486E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 13:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23370

Hi, all,

On 6/17/26 09:03, Biju Das wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=
 Behalf Of Nobuhiro Iwamatsu via
>> lists.cip-project.org
>> Sent: 16 June 2026 00:51
>> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB su=
pport
>>
>> Hi all,
>>
>>> -----Original Message-----
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> O=
n
>>> Behalf Of Pavel Machek via lists.cip-project.org
>>> Sent: Tuesday, June 16, 2026 6:03 AM
>>> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>> Cc: pavel@nabladev.com; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=
=E6=B4=8B =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=
=EF=BC=B0=EF=BC=B4)
>>> <nobuhiro.iwamatsu.x90@mail.toshiba>;
>>> cip-dev@lists.cip-project.org
>>> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB
>>> support
>>>
>>> On Mon 2026-06-15 12:05:03, Claudiu Beznea wrote:
>>>> Hi,
>>>>
>>>> On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
>>>>> Hi!
>>>>>
>>>>>> Thanks for your patch.
>>>>>> I reviewed this and other series, these seems to be fine.
>>>>>> I can apply this if tests are OK and there are no other comments.
>>>>>>     Reviewed-by: Nobuhiro Iwamatsu
>>>>>> <nobuhiro.iwamatsu.x90@mail.toshiba>
>>>>>
>>>>> I'm looking into it. As this modifies generic code, I suggest we
>>>>> are cautious here.
>>>> Please let me know if you want me to limit that code to RZ/G3S SoC o=
nly.
>>>
>>> I'm still reviewing the series, sorry for delay.
>>>
>>> My first preffered option would be explanation why this is okay on
>>> 5.10: (Will it change behaviour on non-renesas boards? How sure we ar=
e
>>> the behaviour change will not break something, or slow things down
>>> significantly?)
>>>
>>> +++ b/drivers/usb/host/ehci-platform.c
>>> @@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(=
struct device *dev)
>>>          if (pdata->power_suspend)
>>>                  pdata->power_suspend(pdev);
>>>
>>> +       ret =3D reset_control_assert(priv->rsts);
>>> +       if (ret) {
>>> +               if (pdata->power_on)
>>> +                       pdata->power_on(pdev);
>>> +
>>> +               ehci_resume(hcd, false);
>>> +
>>> +               if (priv->quirk_poll)
>>> +                       quirk_poll_init(priv);
>>> +       }
>>> +
>>>
>>> If we can't have the explanation, limiting to renesas boards would be=
 fine next option.
>>
>> This concern was also discussed when the original patch was posted.
>>     https://lkml.org/lkml/2025/11/7/557
>>
>> If we are only addressing specific SoCs, I think we need to fix it in =
Upstream first.
>=20
> Some discussion related to this thread, and it expects
>=20
> https://lore.kernel.org/all/b417865397822176e83bca6b9d8094fe92ff2451.ca=
mel@pengutronix.de/

The patches proposed in this series tried to drop the restore code in cas=
e the=20
reset_control_assert() fails. This is the code that intended to be droppe=
d:

+       if (ret) {
+               if (pdata->power_on)
+                       pdata->power_on(pdev);
+
+               ehci_resume(hcd, false);
+
+               if (priv->quirk_poll)
+                       quirk_poll_init(priv);
+       }

The assumption that the core suspend/resume code handles it. The assumpti=
on was=20
wrong. Quoting the Alan Stern (the ohci/ehci drivers maintainer):

"When recovering from a failed suspend transition, the kernel resumes
only the devices that did suspend correctly.  The code that handles this
is in drivers/base/power/main.c, and it's rather intricate and difficult
to follow.

In short, dpm_resume() invokes the resume callback only for devices that
are on dpm_suspended_list.  Devices are added to this list by
dpm_suspend(), and if the suspend callback fails they are supposed to be
removed from the list.

However, I don't see any place in device_suspend() where an error causes
the device to be moved from dpm_suspended_list back to
dpm_prepared_list.  Maybe this is a bug and needs to be fixed.  Or maybe
I have misunderstood something."

And Biju agreed with it in the next thread:=20
https://lore.kernel.org/all/TY3PR01MB11346364790DE1F0D2441536786A5A@TY3PR=
01MB11346.jpnprd01.prod.outlook.com/


>=20
> and a patch for fixing assert failure in error path.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/drivers/clk/renesas/rzg2l-cpg.c?h=3Dnext-20260616&id=3D0b0201f259e115=
8a875c5fd01adf318ae5d32352

This patch ensure the reset control driver leaves the reset line in the=20
de-asserted state in case the assert for it fails. It doesn't mean with w=
e can=20
drop the recovery code:

+       if (ret) {
+               if (pdata->power_on)
+                       pdata->power_on(pdev);
+
+               ehci_resume(hcd, false);
+
+               if (priv->quirk_poll)
+                       quirk_poll_init(priv);
+       }

just, it ensure the reset controller driver leaves the reset line in the =
proper=20
state in case an assert fails.

That patch is not yet backported to any of the 5.10, 6.1, 6.12. If you pr=
efer, I=20
can add it to this series (and the corresponding 6.1, 5.10 ones).

Thank you,
Claudiu

