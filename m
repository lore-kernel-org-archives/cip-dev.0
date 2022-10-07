Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0099DC433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 10:15:44 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2883.1665137733779605887
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 03:15:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7D19B1C0026; Fri,  7 Oct 2022 12:15:30 +0200 (CEST)
Date: Fri, 7 Oct 2022 12:15:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Michael Adler <michael.adler@siemens.com>
Cc: Pavel Machek <pavel@denx.de>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] gitlab test failures -- job failed ... pods not found
Message-ID: <20221007101529.GA25429@duo.ucw.cz>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
 <20221006115033.GB21855@duo.ucw.cz>
 <20221007065754.fysie7e4j2bvrvck@backstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20221007065754.fysie7e4j2bvrvck@backstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 10:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9676


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Still there, I'd say:
> >=20
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3123103311
>=20
> Ok, I have restored our previous cluster (v9). Please try again and tell =
me if the problem still persists. If it does,
> then I'd blame Gitlab I/O otherwise it could be a regression somewhere in=
 the K8s stack - in that case, our best bet
> might be to sit it out.

It may be a bit better.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/660868595

Still see bbb failure, but that's different one:

https://lava.ciplatform.org/scheduler/job/756260

Thanks,
									Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYz/8QQAKCRAw5/Bqldv6
8l+6AKCfkN0IrgvNhNc0jpSosYTJHUALggCgtAC2+/hW5w/0tbk1KNdRDNwUy3o=
=my62
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

