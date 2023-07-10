Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E8EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 09:19:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.35457.1688980781546468968
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 02:19:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C6C721C0E59; Mon, 10 Jul 2023 11:19:33 +0200 (CEST)
Date: Mon, 10 Jul 2023 11:19:33 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: 5.10.186-cip
Message-ID: <ZKvNJdCGzb/C/JPn@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PwFDtl+VAoD4QGhq"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 09:19:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12290


--PwFDtl+VAoD4QGhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Could I ask for 5.10.186-cip? It would be useful to do -rt release.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PwFDtl+VAoD4QGhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKvNJQAKCRAw5/Bqldv6
8sVlAJ4zgjF7mZFwO32xaRIgR0IxHuezUQCgm/1J5uAxY96OmadQa8PrzY78yBU=
=9suz
-----END PGP SIGNATURE-----

--PwFDtl+VAoD4QGhq--

