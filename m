Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FE8C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:58:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5776.1686049100277489105
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:58:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B5AAF1C0CAF; Tue,  6 Jun 2023 12:58:17 +0200 (CEST)
Date: Tue, 6 Jun 2023 12:58:17 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] v6.1-cip: state of forward porting
Message-ID: <ZH8RSUqIcbd35Dmx@duo.ucw.cz>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
 <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
 <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qnn2gDQSNTEbHVr9"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:58:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11868


--qnn2gDQSNTEbHVr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for the 6.1 porting.

I forward ported serial/sh-sci patches, up to "tty: serial: sh-sci:
Add RZ/G2L SCIFA DMA rx support". The last one can not be picked from
the mainline, I guess I could pick it from 5.10.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qnn2gDQSNTEbHVr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH8RSQAKCRAw5/Bqldv6
8pSSAJ4pFtOcUum2HaxhKEjfEPOxQlOnAQCfX7ZngvYOrkoLo9nrJDsLIurbjVY=
=CWF+
-----END PGP SIGNATURE-----

--qnn2gDQSNTEbHVr9--

