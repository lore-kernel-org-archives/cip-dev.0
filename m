Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18804EB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 10:18:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8034.1686737928701048530
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jun 2023 03:18:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2CA2E1C0D23; Wed, 14 Jun 2023 12:18:47 +0200 (CEST)
Date: Wed, 14 Jun 2023 12:18:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 6/7] serial: 8250_em: Add
 serial8250_em_{reg_update(),out_helper()}
Message-ID: <ZImUBg3er1tsqZzz@duo.ucw.cz>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
 <20230613132339.150671-7-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y6zi7aUR0NNfDtZZ"
Content-Disposition: inline
In-Reply-To: <20230613132339.150671-7-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 10:18:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12006


--Y6zi7aUR0NNfDtZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As per RZ/V2M hardware manual(Rev.1.30 Jun, 2022), UART IP has a
> restriction as mentioned below.
>=20
> 40.6.1 Point for Caution when Changing the Register Settings:
>=20
> When changing the settings of the following registers, a PRESETn master
> reset or FIFO reset + SW reset (FCR[2],FCR[1], HCR0[7]) must be input to
> re-initialize them.
>=20
> Target Registers: FCR, LCR, MCR, DLL, DLM, HCR0.

So how does this work? AFAIU looking at the previous patch, FCR is
write only, you get IIR register when you try to read it.

> +static void serial8250_em_reg_update(struct uart_port *p, int off, int v=
alue)
> +{
> +	unsigned int ier, fcr, lcr, mcr, hcr0;
> +
> +	ier =3D serial8250_em_serial_in(p, UART_IER);
> +	fcr =3D serial8250_em_serial_in(p, UART_FCR_EM);

So here you read IIR...

> +	serial8250_em_serial_out_helper(p, UART_FCR_EM, fcr);

=2E..and write it back to fcr?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Y6zi7aUR0NNfDtZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZImUBgAKCRAw5/Bqldv6
8tI2AJ92emXr/fgg5E1DiYiSIjgJOUAGCgCfTqraURMNvcxaCbswNcTXlHwZZ9k=
=KRkl
-----END PGP SIGNATURE-----

--Y6zi7aUR0NNfDtZZ--

