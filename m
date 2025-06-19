Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A88DC7115B
	for <webhook@archiver.kernel.org>; Thu, 19 Jun 2025 08:15:33 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9632.1750320927844977287
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 01:15:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FnQOuUz3;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 999F110298359
	for <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 10:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750320925; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=/Jr6mJ6jdqXn9v0PBeLu+sjaJjPvN7LOf6ZKdfHv0LA=;
	b=FnQOuUz3gAXUi/n0bvnkLWsHzPSOVNyrNiKlu0jZ21H3KqZKSJf0CytexZgqIGud2GYPz7
	fqTF26UjyvvP58SL0HePXVhk80YBtYGaf0FiJHnYVHy81PKh/AKXNk8xpbuPsesM4XmgEI
	crFQgBKYwxTgh0hklexg96PIJ9bohD9R7hRQnr0RUTU813jpScHQxcGPxfA4fuOuq8nP5l
	W/gN/kc15UG0ichSFP0QkKrGDR70FyR0OBkb8jUOV+hX8G/nNK2xwhvqUBncTjpq5bWXFg
	EZrfmniOcgfyu+NyEGvM+vusPruIqQJaF6892s84+mUq0nq66cUZ27iu4OAvvw==
Date: Thu, 19 Jun 2025 10:15:19 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Testing 6.15, bbb target has problems?
Message-ID: <aFPHFz1WFVhMj76+@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1aVas6DfBMEDpPar"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 08:15:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19138


--1aVas6DfBMEDpPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.15.X is out, it would be nice to start testing it.

Plus, I see bbb failures way too often. Any idea what is going on
there or how to debug that:

One example is here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
874747536
https://lava.ciplatform.org/scheduler/job/1282821


[    3.556545] Sending DHCP requests .
[    3.567340] mmc0: new high speed SDHC card at address 0007
[    3.579884] mmcblk0: mmc0:0007 SD4GB 3.71 GiB=20
[    3.590452]  mmcblk0: p1
[    3.600982] mmc1: new high speed MMC card at address 0001
[    3.607395] mmcblk1: mmc1:0001 MMC02G 1.79 GiB=20
[    3.615388] mmcblk1boot0: mmc1:0001 MMC02G 1.00 MiB=20
[    3.622199] mmcblk1boot1: mmc1:0001 MMC02G 1.00 MiB=20
[    3.628670] mmcblk1rpmb: mmc1:0001 MMC02G 128 KiB, chardev (236:0)
[    6.136382] ..... timed out!
[   86.523950] IP-Config: Retrying forever (NFS root)...
[   86.529327] cpsw-switch 4a100000.switch: starting ndev. mode:
dual_mac

seems like a network problem.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1aVas6DfBMEDpPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFPHFwAKCRAw5/Bqldv6
8ofpAJwMrWLsYH86rVn5dZXR82CGttIi+gCgipGaOdv6oPlzXAKfuQ/s4YgiYUU=
=8GF7
-----END PGP SIGNATURE-----

--1aVas6DfBMEDpPar--

