Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F183C433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 10:50:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.4184.1664535052382576984
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Sep 2022 03:50:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5E03C1C0017; Fri, 30 Sep 2022 12:50:49 +0200 (CEST)
Date: Fri, 30 Sep 2022 12:50:48 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org,
	alice.ferrazzi@miraclelinux.com
Subject: gitlab test failures -- job failed ... pods not found
Message-ID: <20220930105048.GA19081@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 10:50:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9578


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have test failures all over the place:

-----------------
44Creating test job
45-----------------
46Version: Image_ctj_zynqmp_defconfig_5.10.145-cip17-rt7_411cd76b5
47Arch: arm64
48Config: ctj_zynqmp_defconfig
49Device: zynqmp-zcu102
50Kernel: Image
51DTB: zynqmp-zcu102-rev1.0.dtb
52Modules: N/A
53Test: smc
54------------------
55Uploading binaries
56------------------
58
Uploading artifacts for failed job
00:00
60
Cleaning up project directory and file based variables
00:00
62ERROR: Job failed (system failure): pods
"runner-bwzp7ahx-project-2678032-concurrent-0pstk2" not found

Initially everything failed, so I resubmitted everything, then three
succeeded but no more luck with resubmitting.

Example is
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3109431179,
I'm trying to test 5.10-rt release candidate
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/654967302
=2E

Any ideas?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzbKCAAKCRAw5/Bqldv6
8jcZAJ9Pz7kmO81W078zKuqnJOttDj95iwCcCkKMMfUesgbPQtmW1vd418BlbSc=
=nu/D
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

