Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C941AC282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 09:35:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.48207.1742204121837502280
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 02:35:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: /rJ8eE3oRs2BVSG6vAp73A==
X-CSE-MsgGUID: j0UbrFDiRDiMF9oA1QWmFw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2025 18:35:21 +0900
Received: from [10.226.93.170] (unknown [10.226.93.170])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C3A664237F02;
	Mon, 17 Mar 2025 18:35:19 +0900 (JST)
Message-ID: <e38f2f2f-e51a-4c4d-95b5-f9f952e5fd09@bp.renesas.com>
Date: Mon, 17 Mar 2025 09:35:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Mailing list inventing addresses for people
Content-Language: en-GB
To: Pavel Machek <pavel@denx.de>, Michael Adler <michael.adler@siemens.com>
Cc: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@kernel.org>
References: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
 <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
 <whqvkav5o3ofm2kubxknu4mpctdtce76jiplvg7aemtn2d3q4g@f7ehpky3zjqp>
 <Z9LkCoI8fcTIPlvq@duo.ucw.cz>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <Z9LkCoI8fcTIPlvq@duo.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fMQFdkq9p1Q35QrBuoZ6uq0E"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 09:35:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18224

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fMQFdkq9p1Q35QrBuoZ6uq0E
Content-Type: multipart/mixed; boundary="------------WzeVMZ0FIw1dnqtgzRks6EX9";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Michael Adler <michael.adler@siemens.com>
Cc: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@kernel.org>
Message-ID: <e38f2f2f-e51a-4c4d-95b5-f9f952e5fd09@bp.renesas.com>
Subject: Re: [cip-dev] Mailing list inventing addresses for people
References: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
 <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
 <whqvkav5o3ofm2kubxknu4mpctdtce76jiplvg7aemtn2d3q4g@f7ehpky3zjqp>
 <Z9LkCoI8fcTIPlvq@duo.ucw.cz>
In-Reply-To: <Z9LkCoI8fcTIPlvq@duo.ucw.cz>

--------------WzeVMZ0FIw1dnqtgzRks6EX9
Content-Type: multipart/mixed; boundary="------------T8fQf0BiXgjLjhXzjpefrZNp"

--------------T8fQf0BiXgjLjhXzjpefrZNp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13/03/2025 13:56, Pavel Machek wrote:
> Hi!
>=20
>> maybe it depends on the mail client what is actually being shown to th=
e user.
>> For example, I see the following mail headers (and my mail client igno=
res the Resent-From header):
>>
>> ...
>> From: "Pavel Machek via lists.cip-project.org" <pavel=3Ddenx.de@lists.=
cip-project.org>
>> Resent-From: pavel@denx.de
>> ...
>>
>> Do you mean that with "invented address"?
>=20
> Well -- this one is not my email address: pavel=3Ddenx.de@lists.cip-pro=
ject.org=20
>=20
> This one is: pavel@denx.de
>=20
> I don't want people to bookmark pavel=3Ddenx.de@lists.cip-project.org ,=

> for example.
>=20
> We talked about it on IRC: http://ircbot.wl.linuxfoundation.org/meeting=
s/cip/2025/03/cip.2025-03-13-13.01.log.html
>=20
> The mangled address + reply-to to the list means that it is impossible
> to send direct reply to the user, which we agreed is "not
> optimal". From the irc discussion it looked like address mangling is
> now common feature due to DMARC/DKIM.

I don't tend to notice these as I fetch messages from lore.kernel.org
where there is no mangling.

These mangled email addresses seem to be creeping into commits though -
compare the email on lore [1] with the commit [2]. The email has:

    From: Paul Barker <paul.barker.ct@bp.renesas.com>

But the commit now has:

    Author: Paul Barker via lists.cip-project.org <paul.barker.ct=3Dbp.re=
nesas.com@lists.cip-project.org>

I think we should be careful with these.

Thanks,
   =20
[1]: https://lore.kernel.org/cip-dev/20250221164929.357460-1-paul.barker.=
ct@bp.renesas.com/
[2]: https://web.git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.gi=
t/commit/?id=3D19f5c3971881ce892731b500299be665703586b4

--=20
Paul Barker
--------------T8fQf0BiXgjLjhXzjpefrZNp
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------T8fQf0BiXgjLjhXzjpefrZNp--

--------------WzeVMZ0FIw1dnqtgzRks6EX9--

--------------fMQFdkq9p1Q35QrBuoZ6uq0E
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ9fs1gUDAAAAAAAKCRDbaV4Vf/JGvbC5
AQCImH0Z6NnC90aN+zTbouXEMFo1q8jyT+dWeyS1b121XwEArlUdQybeTog3c3W3iJZZIRoTHnks
n56a/3gOhunK5A4=
=CwVT
-----END PGP SIGNATURE-----

--------------fMQFdkq9p1Q35QrBuoZ6uq0E--

