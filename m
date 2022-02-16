Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1502C433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 10:19:44 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.10212.1645006783449075359
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 02:19:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2319B1C0B78; Wed, 16 Feb 2022 11:19:38 +0100 (CET)
Date: Wed, 16 Feb 2022 11:19:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: kernelci results for v4.4.302-cip68
Message-ID: <20220216101937.GB30022@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 10:19:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7614


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to understand how to work with kernelci. I thought I'd
start with understanding 4.4.302 results, so I went to examine some.

a) qemu failing

I got to
https://storage.kernelci.org/cip/linux-4.4.y-cip/v4.4.302-cip68/arm64/defco=
nfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.ht=
ml

  171 22:36:34.473034  qemu-system-aarch64: Property '.mte' not found
      175 22:36:34.476041  boot-image-retry failed: 1 of 1
    attempts. 'Connection closed'
      177 22:36:34.476572  end: 2 boot-image-retry (duration 00:00:01)
    [common]
      190 22:36:34.590951  InfrastructureError: The Infrastructure is
    not working correctly. Please report this error to LAVA admins.

This one does not look like kernel problem.

b) fuloong2e

Newer builds fail (v4.4.302-cip68) while older ones did not
(v4.4.266-cip56), example board is fuloong2e. Error is:

cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=98-mh=
ard-float=E2=80=99
cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=98-mh=
ard-float=E2=80=99

This well might be build infrastructure problem, and I don't think we
care too much. What should be done there?

c) We have ton of "test execution failed", such as
https://linux.kernelci.org/test/case/id/61e26bcc0c981e7374ef6770/
=2E Unfortunately clicking on "job log", txt or html, gives me 404 page.

Can you take a look at
https://linux.kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel/v4.4.=
302-cip68/
and point me to any kernel problems I should debug shown there?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIMz7kACgkQMOfwapXb+vJMAwCfdW5PNpz01VXARXwkU1wz3NLs
AvYAn2EN6LQn3f9LUenMLM9Vb8nn7PoH
=5XQb
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

