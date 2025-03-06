Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD6C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 17:27:34 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.19891.1741282045913879652
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 09:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=EAkZNFQR;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 719E8103D49CE
	for <cip-dev@lists.cip-project.org>; Thu,  6 Mar 2025 18:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741282043; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=ZYDwAqcaM/kFHrTjO47aAVWsRVs8urbrVpZ2nyHkhLs=;
	b=EAkZNFQRvhon2Uku80VdMpBoDDwkm1HSWLZlXbUSP/mqerg4IdIRDSAdsCjfrLA9tisKtk
	E0hIjecNWNnl0S1Vr0if5r8h4VOUpdS3X3lOvVt7ev1BIAr9hFocIA+e6GJznqjMUCuIC7
	aCy+c8Clos61nsqaqOP9AUz9PaW+m4UpaGdvbKEhKHH0N4Z4y7xhQSJ5Fv1u+GYayByzew
	1j5AvmZMl66ANrThLqddSY3cxC21SZKnffsb0yFJOa83Ey9JBlVASsVkWhyuB4M/EcKARa
	VAKNATQXBe1cPS5joFqUY+i4fSd3XKPE4+CSwFdV/8OOqXOPq+MCyd/URq/tNg==
Date: Thu, 6 Mar 2025 18:27:20 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Branching off 6.12 tree
Message-ID: <Z8na+IsVvCZq0nqc@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fhh3clFPstlVb8Wp"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 17:27:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18061


--Fhh3clFPstlVb8Wp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

As discussed on the IRC meeting, we should be preparing 6.12-cip
branch.

There will be other reminders, but please submit configs for
6.12. Which will also help with next step:

Also we should decide which boards will be official for 6.12 and
update
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cip=
referencehardware
page according to that.

We can start 6.12-cip branch. I propose we start it from 6.12.18,
which should be released in a few days.

=46rom that point on, we'll need patches for older kernels to be
submitted for 6.12, too. At some point we should start reviewing 6.12
patches, too, but maybe we can postpone that to the time when
6.12-cip1 is released.

We'll need adjustments to the testing, and to the review scripts. We
should not need 6.12-cip-rt branch this time, as most of -rt patches
is merged in 6.12. (There are still -rt arm32 patches, but I believe
they are small enough to simply merge them into -cip if required).

Comments welcome.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Fhh3clFPstlVb8Wp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ8na+AAKCRAw5/Bqldv6
8mkAAJ9K0BgZiHNhs6lLCw74Ff7oHIzGIwCeMA2u7cWjpxPmTHWyqRUqz4+qZcA=
=372o
-----END PGP SIGNATURE-----

--Fhh3clFPstlVb8Wp--

