Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E8C6FD1F
	for <webhook@archiver.kernel.org>; Sat, 30 Mar 2024 17:53:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2397.1711821183536689615
 for <cip-dev@lists.cip-project.org>;
 Sat, 30 Mar 2024 10:53:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DE0E61C006B; Sat, 30 Mar 2024 18:53:00 +0100 (CET)
Date: Sat, 30 Mar 2024 18:53:00 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: 6.1.83, 5.10.214 would be useful -cip releases
Message-ID: <ZghRfAeHw2i7rdjF@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xtYFDWc/8zzLOmL1"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 30 Mar 2024 17:53:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15480


--xtYFDWc/8zzLOmL1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1 and 5.10 -rts should be released soon... There is 6.1.83-rt and
5.10.214-rt is in the pipeline, if we could get matching -cip
releases, that would be useful for me.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xtYFDWc/8zzLOmL1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZghRfAAKCRAw5/Bqldv6
8t1WAJ9uWobX+ZK9VXIW/N2MsTyHY4a3oQCeMid9jEqA26Ga+nvnsSDDv1R0gnA=
=058T
-----END PGP SIGNATURE-----

--xtYFDWc/8zzLOmL1--

