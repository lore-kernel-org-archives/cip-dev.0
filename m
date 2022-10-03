Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA0C433F5
	for <webhook@archiver.kernel.org>; Mon,  3 Oct 2022 18:55:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1522.1664823314206809829
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Oct 2022 11:55:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 735BE1C0036; Mon,  3 Oct 2022 20:55:11 +0200 (CEST)
Date: Mon, 3 Oct 2022 20:55:10 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Status of RISC-V in Debian
Message-ID: <20221003185510.GA9636@duo.ucw.cz>
References: <2e7cceaf-1b0c-e62d-1910-bf8dbe25c864@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <2e7cceaf-1b0c-e62d-1910-bf8dbe25c864@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Oct 2022 18:55:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9616


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> worth to read (also those of previous months):
>=20
> https://lists.debian.org/debian-riscv/2022/09/msg00012.html
>=20
> In a nutshell, build hardware is a key bottleneck right now. The
> preferred SiFive Unmatched was discontinued so that only personal stocks
> can help at this point. If anyone has an idea how to support here,
> please share.

There are rumors that powerful x86 with qemu should outperform SiFive,
that could be one option.

Other one would be this, but I'm not sure when it will be ready:

https://download.intel.com/newsroom/2022/manufacturing/Intel-RISC-V-Fact-Sh=
eet.pdf

Best regards,
									Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzswDgAKCRAw5/Bqldv6
8jPFAJ9mAjsK5Qa3qH+zlWgrPEiPXorsbQCfTI/QRkrIuF5PYYabZ3xl7JG2xfg=
=rIq3
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

