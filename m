Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DEEC433F5
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 09:57:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9731.1636019863570925137
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Nov 2021 02:57:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E96221C0BB4; Thu,  4 Nov 2021 10:57:38 +0100 (CET)
Date: Thu, 4 Nov 2021 10:57:23 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE Entries in this week
Message-ID: <20211104095723.GA2592@amd>
References: 
 <CAODzB9rc8Y_kUnMfYebK_sHt5tOSvf+qr0pgYkZy+N0zqudu4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9rc8Y_kUnMfYebK_sHt5tOSvf+qr0pgYkZy+N0zqudu4g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Nov 2021 09:57:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6860


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2021-34981: Bluetooth CMTP Module Double Free Privilege Escalation
> Vulnerability
>=20
> This CVE is fixed in 5.14-rc1.
>=20
> Fixed status
>=20
> mainline: [3cfdf8fcaafa62a4123f92eb0f4a72650da3a479]
> stable/4.19: [f8be26b9950710fe50fb45358df5bd01ad18efb7]
> stable/4.9: [77c559407276ed4a8854dafc4a5efc8608e51906]
> stable/5.10: [1b364f8ede200e79e25df0df588fcedc322518fb]
> stable/5.4: [fe201316ac36c48fc3cb2891dfdc8ab68058734d]

This seems to be fixed in stable/4.4, too, as
61a811e8f5229264b822361f8b23d7638fd8c914. And cip-kernel-sec says so,
good.

> CVE-2021-43267: tipc: fix size validations for the MSG_CRYPTO type
>=20
> This vulnerability was introduced since 5.1-rc1 so before 5.10 kernels
> aren't affected by this issue.
> The mainline and stable kernels have been fixed.

AFAICT the vulnerability was introduced by 1ef6f7c9390f in
5.9-rc3. But that does not change anything for us.

> * Updated CVEs
>=20
> CVE-2021-3772: Invalid chunks may be used to remotely remove existing
> associations
>=20
> This bug is in SCTP stack that attacker may be able to send packet
> with spoofed IP address if attacker knows IP address and port number
> being used.

AFAICT it is more of "if attacker can send packets with spoofed IP
addresses, he can...". Many of our configs use SCTP.

> CVE-2021-42327: drm/amdgpu: fix out of bounds write
>=20
> The parse_write_buffer_into_params() was introduced since 5.9 so
> before 5.9 kernels aren't affected by this vulnerability.
>=20
> This CVE was fixed by 5afa7898ab7a ("drm/amdgpu: fix out of bounds
> write"), however next commit 3f4e54bd312d ("drm/amdgpu: Fix even more
> out of bound writes from debugfs") said that amdgpu_dm_debugfs.c
> contains same issues so it'd be nice to apply 3f4e54bd312d
> ("drm/amdgpu: Fix even more out of bound writes from debugfs") too.

This looks quite easy to fix, OTOH CIP configs do not use amdgpu and
it is not too serious in the fist place.

> CVE-2021-20322: new DNS Cache Poisoning Attack based on ICMP fragment
> needed packets replies
>=20
> Update stable/5.4 and stable/4.19 fixed revisions.
> It seems like stable/4.4 and stable/4.9 need backport following patches.
> - 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()")
> - a00df2caffed ("ipv6: make exception cache less predictible")
> - 6457378fe796 ("ipv4: use siphash instead of Jenkins in
> fnhe_hashfun()")

It would not be bad to understand the problem in the first place. Yes,
I guess different hashes have different qualities, but...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGDroMACgkQMOfwapXb+vLYKACgiXxPYHE8Boyp4sx5cxHybNeh
uSIAoISNpHuZipg7LYGOHtonAKw+22xF
=/jxO
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

