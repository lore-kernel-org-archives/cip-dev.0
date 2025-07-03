Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CC1C77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 12:42:36 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.21566.1751546551384743606
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jul 2025 05:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dXY421KE;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 709A510380104;
	Thu,  3 Jul 2025 14:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751546548; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=nSdo76fDugUS4yk6zlxeUOp2EuSDcw47NtRc+cgNZfk=;
	b=dXY421KEMzriqBeyrl9AsHIx9TAzhCt/amXBryS3W1PYUkeMbJctXNv1h2wpGAezB8UIqH
	Aa2ma2v7jf0iWAJ3JMhr68Y2MxC1xdveh7wStMewSEKvB3PKbM2TKEEawt1jkcD9CMpekr
	wOcBUf02tvrCTmO3DDAY2I72rRwfWEII3K1ZwE2m3Kbmb0w+AS9sm34zo4mQkZci7SynLm
	JV0gB1nhKwin5G4eQj5UVSKnlgw3+B/QduFroB8ymi/Som7osex5NIdwMV1bbvmXUhc30b
	bEfGGgBnbZzq37BCf30PtiQdSELc2qPOfFjZi3gmnBTunLQcIwyxaxKfxEMbBA==
Date: Thu, 3 Jul 2025 14:42:23 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip100-rt56
Message-ID: <aGZ6rwKP8eUFD9WE@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BKDOEiX0Z6BGp4n5"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 12:42:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19327


--BKDOEiX0Z6BGp4n5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BKDOEiX0Z6BGp4n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGZ6rwAKCRAw5/Bqldv6
8vADAJ447S/jzJFxURZIl2CBTVhJvQnkFwCgoVcERMm5oYksWjD7iKjP+qhx0rU=
=ntQM
-----END PGP SIGNATURE-----

--BKDOEiX0Z6BGp4n5--

