Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D116CC3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 14:22:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.69491.1722522122808802812
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Aug 2024 07:22:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,254,1716217200"; 
   d="asc'?scan'208";a="218339496"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Aug 2024 23:22:01 +0900
Received: from [10.226.93.36] (unknown [10.226.93.36])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 03074435CEC6;
	Thu,  1 Aug 2024 23:21:58 +0900 (JST)
Message-ID: <ac9dbdc6-ef2f-453a-bc0a-94db12e95414@bp.renesas.com>
Date: Thu, 1 Aug 2024 15:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y cip 0/8] Backport ravb driver performance
 improvements
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
 <ZqntqGYravYHauM1@duo.ucw.cz>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <ZqntqGYravYHauM1@duo.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Npz8R0OYS0Qz0t6rRSiCG3B7"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Aug 2024 14:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16705

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Npz8R0OYS0Qz0t6rRSiCG3B7
Content-Type: multipart/mixed; boundary="------------px8VFoFoACKeong8TYc7NQen";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <ac9dbdc6-ef2f-453a-bc0a-94db12e95414@bp.renesas.com>
Subject: Re: [PATCH 6.1.y cip 0/8] Backport ravb driver performance
 improvements
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
 <ZqntqGYravYHauM1@duo.ucw.cz>
In-Reply-To: <ZqntqGYravYHauM1@duo.ucw.cz>

--------------px8VFoFoACKeong8TYc7NQen
Content-Type: multipart/mixed; boundary="------------OWgNyJhqZXk0ZXer1QdJKW6L"

--------------OWgNyJhqZXk0ZXer1QdJKW6L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 31/07/2024 08:54, Pavel Machek wrote:
> Hi!
>=20
>> This series includes the performance improvements present in Linux
>> v6.11-rc1 along with dependencies.
>=20
> That's a bit aggressive timing, is it? -rc1 does not really get much
> testing.

Hi Pavel,

Please feel free to delay merging these patches for a couple of rc
cycles if you need to.

>=20
> Please avoid blank lines in the signoff area.
>=20
>>   RZ/Five:
>>     * 19% increase in TCP TX bandwidth
>>     * 225% increase in TCP RX bandwidth
>>     * >10,000% increase in UDP RX bandwidth
>>         (UDP RX bandwidth was <100kbps and unstable with v6.1.101-cip2=
5
>>          so it's difficult to get an exact figure here)
>>     * 6% loss in UDP TX bandwidth
>>
>> Small losses in UDP TX bandwidth are considered acceptable to achieve
>> the above improvements in other test cases. If UDP TX bandwidth must b=
e
>> maximised for a particular use case, NAPI threaded mode can be disable=
d
>> at runtime via sysfs writes.
>=20
> And this wories me. One of the configurations works so badly that
> tests don't even finish. You automatically select "right"
> configurations in some cases, but that can't be complete fix. It would
> be good to find out what is going on there, and fix not-threaded so
> that it works well enough to finish tests.

These changes were submitted to the mainline kernel after extensive
investigation and testing, they represent the best configuration that
could be found.

The UDP RX results were obtained using `iperf3 -c <server> -b0 -u -R`,
where the remote server has a 1Gbps network connection and generates
over 80k packets/second. In the default configuration this leads to a
very high IRQ & softirq load, on the RZ/Five this load is enough to
starve all other processes of CPU time and cause the test to crash.

Both SW IRQ coalescing and NAPI threaded mode are needed to avoid the
test crash on the RZ/Five, neither of these alone resolves the issue.

Thanks,

--=20
Paul Barker
--------------OWgNyJhqZXk0ZXer1QdJKW6L
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------OWgNyJhqZXk0ZXer1QdJKW6L--

--------------px8VFoFoACKeong8TYc7NQen--

--------------Npz8R0OYS0Qz0t6rRSiCG3B7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZquaBQUDAAAAAAAKCRDbaV4Vf/JGvfwK
AP9hl9H4UKnPi/mKAJtHOWEEWxKT+Yu7JOsXIqBGZ1+JAgEAk3uR8WGgNyoGcqS8tW5JlSpGHLop
6ziF1xc0N62k/g4=
=K5EQ
-----END PGP SIGNATURE-----

--------------Npz8R0OYS0Qz0t6rRSiCG3B7--

