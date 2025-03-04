Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF5C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 09:47:34 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.18481.1741081646416993482
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 01:47:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: laggWvr1RaW5cHmDY5WdHw==
X-CSE-MsgGUID: 8tT9RyzqQ22s4jWBK6vTSw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Mar 2025 18:47:24 +0900
Received: from [10.226.93.7] (unknown [10.226.93.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9262540446B6;
	Tue,  4 Mar 2025 18:47:23 +0900 (JST)
Message-ID: <69b929e7-36c8-4705-8fa7-708395bbd5b1@bp.renesas.com>
Date: Tue, 4 Mar 2025 09:47:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN & IPv6
 support
To: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
 <TY7PR01MB14818285CED4A08E1A8690D2092C92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <Z8V3nYpwV72TnVZy@duo.ucw.cz>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <Z8V3nYpwV72TnVZy@duo.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L0Nuib7XgCGDk0Danv1zGY7Z"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 09:47:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18012

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------L0Nuib7XgCGDk0Danv1zGY7Z
Content-Type: multipart/mixed; boundary="------------mu5T4qNOuNXkIDoar6h20Wcu";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org
Message-ID: <69b929e7-36c8-4705-8fa7-708395bbd5b1@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN & IPv6
 support
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
 <TY7PR01MB14818285CED4A08E1A8690D2092C92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <Z8V3nYpwV72TnVZy@duo.ucw.cz>
In-Reply-To: <Z8V3nYpwV72TnVZy@duo.ucw.cz>

--------------mu5T4qNOuNXkIDoar6h20Wcu
Content-Type: multipart/mixed; boundary="------------10Gu9UitQuwNr9zq8NVPXLdB"

--------------10Gu9UitQuwNr9zq8NVPXLdB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2025 09:34, Pavel Machek wrote:
> Hi!
>=20
>>> This patch series backports recent ravb driver improvements to CIP 6.=
1.y.
>>>
>>> Paul Barker (12):
>>>   net: ravb: Fix maximum TX frame size for GbEth devices
>>>   net: ravb: Fix R-Car RX frame size limit
>>>   net: ravb: Factor out checksum offload enable bits
>>>   net: ravb: Disable IP header RX checksum offloading
>>>   net: ravb: Drop IP protocol check from RX csum verification
>>>   net: ravb: Combine if conditions in RX csum validation
>>>   net: ravb: Simplify types in RX csum validation
>>>   net: ravb: Disable IP header TX checksum offloading
>>>   net: ravb: Simplify UDP TX checksum offload
>>>   net: ravb: Enable IPv6 RX checksum offloading for GbEth
>>>   net: ravb: Enable IPv6 TX checksum offload for GbEth
>>>   net: ravb: Add VLAN checksum support
>>>
>>>  drivers/net/ethernet/renesas/ravb.h      |   7 ++
>>>  drivers/net/ethernet/renesas/ravb_main.c | 120
>>> +++++++++++++----------
>>>  2 files changed, 77 insertions(+), 50 deletions(-)
>>>
>>
>> I reviewed this series and 5.10.y, looks good to me.
>> I can apply this series, if there are no other comments.
>>
>> Test:
>>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1696=
481092
>>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1696=
483186
>>
>> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> I reviewed them, too, and code looks ok to me. I'm just wondering what
> the gain is here, AFAICT there are only very minor performance
> tweaks (is it even measurable?). What is the reason for having these?

Hi Pavel,

Performance gain from enabling checksum offload can be significant,
especially on the SoCs with a single CPU core such as RZ/G2UL and
RZ/Five. For example, we've seen up to 40% improvement in bandwidth in
TCP RX testing on RZ/G2UL.

>=20
> Plus, I don't believe they are all in 6.12. I believe we'll be able to
> simply cherry-pick them from mainline, but if not, we'll need your
> help.
>=20
> Best regards,
> 								Pavel

We're planning to review 6.12 status in the near future and see what
needs backporting for CIP.

Thanks,

--=20
Paul Barker
--------------10Gu9UitQuwNr9zq8NVPXLdB
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------10Gu9UitQuwNr9zq8NVPXLdB--

--------------mu5T4qNOuNXkIDoar6h20Wcu--

--------------L0Nuib7XgCGDk0Danv1zGY7Z
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ8bMKgUDAAAAAAAKCRDbaV4Vf/JGvTAp
AP94i7OoU42y4KoBrIptpywn19mde8dmcKGTIdpCdOFbeQEAj5ViwAmEdIQu0ptT9OZCNO8hlsRv
QQvqlyZv46oibwg=
=IDMh
-----END PGP SIGNATURE-----

--------------L0Nuib7XgCGDk0Danv1zGY7Z--

