Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A141C77B7D
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 10:16:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.13562.1684404998626603916
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 May 2023 03:16:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E3ADF1C0E56; Thu, 18 May 2023 12:16:34 +0200 (CEST)
Date: Thu, 18 May 2023 12:16:34 +0200
From: Pavel Machek <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: gitlab -- problems with testing
Message-ID: <ZGX7AqhOPIkUnJD/@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sxqfy/AI4sAystoV"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 10:16:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11512


--sxqfy/AI4sAystoV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I attempted to test 5.10-cip-rt candidate, and something is not right there:

Waiting for pod gitlab/runner-gmpa8j7y-project-2678032-concurrent-4vpl2c to=
 be running, status is Pending
13	ContainersNotInitialized: "containers with incomplete status: [init-perm=
issions]"
14	ContainersNotReady: "containers with unready status: [build helper]"
15	ContainersNotReady: "containers with unready status: [build helper]"
16WARNING: Failed to pull image with policy "": image pull failed: rpc erro=
r: code =3D NotFound desc =3D failed to pull and unpack image "registry.git=
lab.com/cip-project/cip-testing/linux-cip-ci:test-v4": failed to resolve re=
ference "registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4":=
 registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4: not found
18ERROR: Job failed: prepare environment: waiting for pod running:
pulling image
"registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4":
image pull failed: rpc error: code =3D NotFound desc =3D failed to pull
and unpack image
"registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4":
failed to resolve reference
"registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4":
registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4: not
found. Check
https://docs.gitlab.com/runner/shells/index.html#shell-profile-loading
for more information

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/4308049055

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/871381622

Any ideas?

Thanks,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sxqfy/AI4sAystoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGX7AgAKCRAw5/Bqldv6
8t/ZAJ4ni7tpGIEyUS7izioiAhn80/G7IwCgtpCOcFiS8MCIVtdFRe3+UdKeJik=
=nYcj
-----END PGP SIGNATURE-----

--sxqfy/AI4sAystoV--

