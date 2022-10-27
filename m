Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C246BECAAA1
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 19:26:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1659.1666898765975832653
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Oct 2022 12:26:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 87F471C09E5; Thu, 27 Oct 2022 21:26:04 +0200 (CEST)
Date: Thu, 27 Oct 2022 21:26:04 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	cip-dev@lists.cip-project.org,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: Still random failures at gitlab
Message-ID: <20221027192604.GB11819@duo.ucw.cz>
References: <20221020160844.GA19694@duo.ucw.cz>
 <TYCPR01MB10588638D4BFDFF15F7CB9E98B7319@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221027192440.GA11819@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20221027192440.GA11819@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 19:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9882


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm still getting random failures at gitlab. Is the info below enough
> / can I retry the tests now to get real results?
>=20
> Thanks and best regards,
> 									Pavel

4.9 testing has different failure mode:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/6=
79070249

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/323899=
9016

Running with gitlab-runner 15.4.0 (43b2dc3d)
2  on 1665142213-cip-project-small-v9-project-gitlab-runner-85dctt8xr Uf_Ms=
YPS
3  feature flags: FF_KUBERNETES_HONOR_ENTRYPOINT:true
4
Resolving secrets
00:00
6
Preparing the "kubernetes" executor
00:00
7Using Kubernetes namespace: gitlab
8Using Kubernetes executor with image registry.gitlab.com/cip-project/cip-t=
esting/linux-cip-ci:test-v3 ...
9Using attach strategy to execute scripts...
11
Preparing environment
00:06
12Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-8tdl4w =
to be running, status is Pending
13	ContainersNotInitialized: "containers with incomplete status: [init-perm=
issions]"
14	ContainersNotReady: "containers with unready status: [build helper]"
15	ContainersNotReady: "containers with unready status: [build helper]"
16Waiting for pod gitlab/runner-ufmsyps-project-14394223-concurrent-8tdl4w =
to be running, status is Pending
17	ContainersNotReady: "containers with unready status: [build helper]"
18	ContainersNotReady: "containers with unready status: [build helper]"
19Running on runner-ufmsyps-project-14394223-concurrent-8tdl4w via 16651422=
13-cip-project-small-v9-project-gitlab-runner-85dctt8xr...
21
Getting source from Git repository
00:01
22Skipping Git repository setup
23Skipping Git checkout
24Skipping Git submodules setup
26
Downloading artifacts
01:32
27Downloading artifacts for build:arm_cip_bbb_defconfig (3238998979)...
28ERROR: Downloading artifacts from coordinator... error couldn't execute G=
ET against https://gitlab.com/api/v4/jobs/3238998979/artifacts?direct_downl=
oad=3Dtrue: Get "https://gitlab.com/api/v4/jobs/3238998979/artifacts?direct=
_download=3Dtrue": dial tcp: i/o timeout  id=3D3238998979 token=3DBszELFyL
29WARNING: Retrying...                                error=3Dinvalid argum=
ent
30ERROR: Downloading artifacts from coordinator... error couldn't execute G=
ET against https://gitlab.com/api/v4/jobs/3238998979/artifacts?: Get "https=
://gitlab.com/api/v4/jobs/3238998979/artifacts?": dial tcp: i/o timeout  id=
=3D3238998979 token=3DBszELFyL
31WARNING: Retrying...                                error=3Dinvalid argum=
ent
32ERROR: Downloading artifacts from coordinator... error couldn't execute G=
ET against https://gitlab.com/api/v4/jobs/3238998979/artifacts?: Get "https=
://gitlab.com/api/v4/jobs/3238998979/artifacts?": dial tcp: i/o timeout  id=
=3D3238998979 token=3DBszELFyL
33FATAL: invalid argument                           =20
35
Uploading artifacts for failed job
00:00
36Uploading artifacts...
37WARNING: output: no matching files. Ensure that the artifact path is rela=
tive to the working directory=20
38ERROR: No files to upload                         =20
40
Cleaning up project directory and file based variables
00:01
42ERROR: Job failed: command terminated with exit code 1





--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1rbTAAKCRAw5/Bqldv6
8nvJAJ97PYHFnC0qhrOJWD4MUMVeN9fkyQCguZRzRmwjsXzwGKWWGoeVx+dt4XY=
=EWlp
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

