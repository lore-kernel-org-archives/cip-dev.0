Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71CC43217
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 17:17:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.704.1649955387750096849
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Apr 2022 09:56:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D9EAA1C0B93; Thu, 14 Apr 2022 18:56:22 +0200 (CEST)
Date: Thu, 14 Apr 2022 18:56:18 +0200
From: Pavel Machek <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: zynqmp board has problems with 4.19 testing
Message-ID: <20220414165618.GA8670@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 17:17:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8097


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It seems that zynqmp has problems:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/233699=
3733

Job #663506: Submitted
67Health: Unknown
68Device Type: zynqmp-zcu102
69Device: None
70Test: smc
71URL: https://lava.ciplatform.org/scheduler/job/663506
72=20
74ERROR: Job failed: execution took longer than 2h0m0s seconds

https://lava.ciplatform.org/scheduler/job/663506
Invalid job definition:
extra keys not allowed @
data['actions[2]']['test']['definition']['definitions'][0]['timeout']

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYlhSMgAKCRAw5/Bqldv6
8prCAKCHiuSNbClkAHqMnZE698NQh92HHgCfQqHO2heSDhM2id2cDNsC2YOyXE0=
=CmSH
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

