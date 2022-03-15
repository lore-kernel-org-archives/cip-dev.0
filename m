Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A5C433EF
	for <webhook@archiver.kernel.org>; Tue, 15 Mar 2022 19:04:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.15467.1647371088884662278
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Mar 2022 12:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9398B1C0BA4; Tue, 15 Mar 2022 20:04:44 +0100 (CET)
Date: Tue, 15 Mar 2022 20:04:44 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: Starting 4.4 backports
Message-ID: <20220315190444.GA1580@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Mar 2022 19:04:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7742


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So... I have some scripts, and I went through 4.9.299... I guess I
could try to update linux-4.4.y tree with patches from 4.9.299.

I would not mind someone looking at notes I've made so far. They are
at:

https://gitlab.com/cip-project/cip-kernel/lts-commit-list/-/blob/master/v4.=
4.org

There are some notes at begining of file explaining what different
values of the first field are. Most important now is number -- it
means that the patch looks "not worth the effort dealing with", and I
plan to simply ignore it.

Comments? Is it okay to go ahead?

Should I do that directly on linux-4.4.y-cip branch?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYjDjTAAKCRAw5/Bqldv6
8llzAJ9orhRc62AU2Sy9IP2T8aGL+IVIswCgoOee4I/cECYCQEa2onjIt1LfWgg=
=qWVN
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

