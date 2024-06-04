Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E004C25B7E
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 10:29:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.18193.1717496984930588091
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 03:29:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5D4491C0082; Tue,  4 Jun 2024 12:29:42 +0200 (CEST)
Date: Tue, 4 Jun 2024 12:29:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Claudius Heine <ch@denx.de>,
	Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: 6.1 plans (rt, ethernet merge) was Re: Siemens targets timing out?
Message-ID: <Zl7slaoXqCXjwf8I@duo.ucw.cz>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
 <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
 <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
 <7dd2c3fc-7c37-4b1a-a996-3f600278cee5@denx.de>
 <Zl2X8iYxb0r/2rTk@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ARF0AdaNTPTJoIxq"
Content-Disposition: inline
In-Reply-To: <Zl2X8iYxb0r/2rTk@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 10:29:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16103


--ARF0AdaNTPTJoIxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > https://lava.ciplatform.org/scheduler/worker/lab-cip-denx
> >=20
> > I had the bright idea to restart the server and update it beforehand la=
st
> > week, I now had to fix the boot issues, but it seems like
> > docker-compose/docker now complains:
> >=20
> > ```
> > docker-compose client version 1.22 is too old. Minimum supported API ve=
rsion
> > is 1.24, please upgrade your client to a newer version
> > ```
> >=20
> > It seems now that there is `docker-compose-plugin` package from the doc=
ker
> > repos, which does not supply a `docker-compose` binary to the PATH. Ins=
tead
> > now it is used via `docker compose`...
> >=20
> > So either patching all `docker-compose` calls to `docker compose`, addi=
ng
> > `/usr/libexec/docker/cli-plugins/` to the search path, or creating a sy=
mlink
> > for it.
> >=20
> > I will probably try to patch the `docker-compose` calls to `docker
> > compose`.
>=20
> Thank you. Can you ping me when I should re-try the tests?

Ok, not sure what to do here.

So, 6.1-rt is due, and we have v6.1.91-cip21, v6.1.91-rt31,
v6.1.91-rt31 and gitlab testing is broken.

I guess Renesas Ethernet patches should not break Siemens boards, so I
propose to apply them. Then I can ask for or do 6.1.92-cip release, to
sync versions, and finally 6.1.92-cip-rt.

If anyone is uncomfortable with the plan, let me know.

Iwamatsu-san, do you want to do 6.1.92-cip or can I do that?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ARF0AdaNTPTJoIxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZl7slQAKCRAw5/Bqldv6
8og4AJ0fc8ZpSPLTuP1DD1Gjkt4p+T9yEgCcDGP/ynIB1sOBhwJhajtACIHg8OM=
=file
-----END PGP SIGNATURE-----

--ARF0AdaNTPTJoIxq--

