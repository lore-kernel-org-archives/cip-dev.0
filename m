Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D931C433F5
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 18:26:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.1498.1664994365303390531
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Oct 2022 11:26:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C7B4D1C0017; Wed,  5 Oct 2022 20:26:03 +0200 (CEST)
Date: Wed, 5 Oct 2022 20:26:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, chris.paterson2@renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: Realtime support for 5.10 on RISC-V -- not there
Message-ID: <20221005182603.GB16437@duo.ucw.cz>
References: <20220902095754.GA18026@duo.ucw.cz>
 <19ae27fc-592e-e3a7-09ce-c258e2e42970@siemens.com>
 <d6824d9f-6416-6d78-545e-a9b425cc1b20@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <d6824d9f-6416-6d78-545e-a9b425cc1b20@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 18:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9652


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I do not think we can or want to support realtime on RISC-V at the
> >> moment.
> >=20
> > In fact, we couldn't realistically commit to such a non-existing feature
> > /wrt long-term support.
> >=20
> > If there is interest in enabling this, we can start a development effort
> > in upstream. But if that could then be backportable only to the next CIP
> > kernel, would even be open.
> >=20
>=20
> http://lists.infradead.org/pipermail/linux-riscv/2022-August/018823.html
>=20
> Maybe there is a chance to have this in 6.1-rt so that 6.1-cip-rt can
> pick it up.

Yes, that can happen. Plus, the patches are surprisingly small, so
maybe -stable-rt tree picks them up even if they miss 6.1.

OTOH maybe if would be good to have feedback "is someone using -rt on
riscv, and if so, on what hardware"?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYz3MOwAKCRAw5/Bqldv6
8lYqAJ41wShbfY4254DLOAvhZwlZ8ZhHDgCgovv3B8UkIEXL4sEDeUxzHA1e3vI=
=zfgQ
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

