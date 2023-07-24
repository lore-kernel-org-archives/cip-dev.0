Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7FFC001B0
	for <webhook@archiver.kernel.org>; Mon, 24 Jul 2023 08:16:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.43049.1690186567235330144
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Jul 2023 01:16:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6BF411C0A92; Mon, 24 Jul 2023 10:16:02 +0200 (CEST)
Date: Mon, 24 Jul 2023 10:16:01 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: Everything suddenly failing in testing
Message-ID: <ZL4zQQoBG2BeeLup@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hhQ5/rDoEtAK8QxK"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Jul 2023 08:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12500


--hhQ5/rDoEtAK8QxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Any ideas what is going on there?

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/941697672

Waiting for pod gitlab/runner-w81kcwt7-project-2678032-concurrent-09dzpq to=
 be running, status is Pending
123	ContainersNotReady: "containers with unready status: [build helper]"
124	ContainersNotReady: "containers with unready status: [build helper]"
125WARNING: Failed to pull image with policy "": image pull failed: Back-of=
f pulling image "registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:b=
uild-bullseye-v4"
127ERROR: Job failed: prepare environment: waiting for pod running: pulling=
 image "registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-bull=
seye-v4": image pull failed: Back-off pulling image "registry.gitlab.com/ci=
p-project/cip-testing/linux-cip-ci:build-bullseye-v4". Check https://docs.g=
itlab.com/runner/shells/index.html#shell-profile-loading for more informati=
on


Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hhQ5/rDoEtAK8QxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZL4zQQAKCRAw5/Bqldv6
8rjeAKC4vW291ZAwKK7jQOqsYXi10PUA1ACgs696qOqalzS5tLIja6pGjTOlPMs=
=23Ju
-----END PGP SIGNATURE-----

--hhQ5/rDoEtAK8QxK--

