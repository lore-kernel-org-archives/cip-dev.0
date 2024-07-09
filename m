Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64943C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 11:15:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.10566.1720523717495866938
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jul 2024 04:15:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,194,1716217200"; 
   d="asc'?scan'208";a="210799635"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jul 2024 20:15:15 +0900
Received: from [10.226.92.66] (unknown [10.226.92.66])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BB4D2400BBF8;
	Tue,  9 Jul 2024 20:15:13 +0900 (JST)
Message-ID: <2c78b6b0-164d-4cfc-8475-5933984b07c6@bp.renesas.com>
Date: Tue, 9 Jul 2024 12:15:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX
 checksum handling
To: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: paul.barker.ct@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org
References: <20240708183832.33446-1-paul.barker.ct@bp.renesas.com>
 <20240708183832.33446-2-paul.barker.ct@bp.renesas.com>
 <OS0PR01MB63885D918692983EA4B890AD92DB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <Zo0QbuzfgIl4U2pn@duo.ucw.cz>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <Zo0QbuzfgIl4U2pn@duo.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------X0d4NFVFBi5mtZ8BuUUkTZze"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jul 2024 11:15:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16440

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------X0d4NFVFBi5mtZ8BuUUkTZze
Content-Type: multipart/mixed; boundary="------------90YSZOwX0yKcJtg7uXwTXqUE";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: paul.barker.ct@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org
Message-ID: <2c78b6b0-164d-4cfc-8475-5933984b07c6@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX
 checksum handling
References: <20240708183832.33446-1-paul.barker.ct@bp.renesas.com>
 <20240708183832.33446-2-paul.barker.ct@bp.renesas.com>
 <OS0PR01MB63885D918692983EA4B890AD92DB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <Zo0QbuzfgIl4U2pn@duo.ucw.cz>
In-Reply-To: <Zo0QbuzfgIl4U2pn@duo.ucw.cz>

--------------90YSZOwX0yKcJtg7uXwTXqUE
Content-Type: multipart/mixed; boundary="------------HMhlQmjVwOlqBVVDsXlkjmGd"

--------------HMhlQmjVwOlqBVVDsXlkjmGd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2024 11:26, Pavel Machek wrote:
> Hi!
>=20
>>> This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with t=
he
>>> wrong skb for a packet which spans multiple descriptors. To fix this,=
 use the
>>> correct skb.
>>>
>>> Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth=
")
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>
>>> [backported to 6.1.y-cip]
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>  drivers/net/ethernet/renesas/ravb_main.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>> Thanks for this patch. Looks good to me.
>> I can apppy this series, if there are no other comments.
>>
>> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Looks good to me, too.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>

Hi Pavel,

The cover letter and patch did not make it onto the mailing list, I got
an autoresponse saying 'This message has been flagged as spam.'

I will resend the patch, with the Reviewed-by tags included.

Thanks,

--=20
Paul Barker
--------------HMhlQmjVwOlqBVVDsXlkjmGd
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------HMhlQmjVwOlqBVVDsXlkjmGd--

--------------90YSZOwX0yKcJtg7uXwTXqUE--

--------------X0d4NFVFBi5mtZ8BuUUkTZze
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZo0bwAUDAAAAAAAKCRDbaV4Vf/JGvT3h
AP9mDNvcNwRqovY3/MEGtmbNEhll0zjWMyOpvnP6LtncAgD/fgIaAkwH6SXfaYF0VqdH3wWY5AOM
CnWqOpTWZJ6onAw=
=Vg9D
-----END PGP SIGNATURE-----

--------------X0d4NFVFBi5mtZ8BuUUkTZze--

