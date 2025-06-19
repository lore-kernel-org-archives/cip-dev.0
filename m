Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D25CC7115E
	for <webhook@archiver.kernel.org>; Thu, 19 Jun 2025 09:01:23 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.10496.1750323680517794466
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 02:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hdB9QRLv;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FC2C10298359
	for <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 11:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750323674;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=BSheZx4TpJdG2EFm5vp59y+XmSyBxAxZc0UR0x0mny0=;
	b=hdB9QRLvgSw4tu0a4kWlRZyOBdQpuda4cYG9KFEN3Y8YdUtLZrVa1j0h7qyFs48nlxVaTq
	nqjmXi+F2G7xgwgHfHlBzmnkrkqh2D7MOk+2vfxcFpTQk4/LdnVaI9/UJYPwAw7hiOZZd7
	X/lY+ldQJh4fq/6fT6B04dbFOLbfm+L+gUK+CcyRVP+s3eOv49piP1+QHkNq2T0JF6mitv
	XUBI2wKDbFJc9lryvvaMUV5XdOmHud/nzG3bh18QvUotD4j311ic6F0+CKIEzTqmuYSwW7
	e2oiBuln4pekARf6N2gfH2GSU2VsvBwNaxDdX9Cpi1rI7Ts5vTHJ6CHFRFp89Q==
Date: Thu, 19 Jun 2025 11:01:05 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Testing 6.15, bbb target has problems?
Message-ID: <aFPR0THrbjSZ5m8B@duo.ucw.cz>
References: <184A639C5862A401.23068@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBxMxVncxFbBLmPV"
Content-Disposition: inline
In-Reply-To: <184A639C5862A401.23068@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 09:01:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19139


--GBxMxVncxFbBLmPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> 6.15.X is out, it would be nice to start testing it.
>=20
> Plus, I see bbb failures way too often. Any idea what is going on
> there or how to debug that:
>=20
> One example is here:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/1874747536
> https://lava.ciplatform.org/scheduler/job/1282821
>=20
>=20
> [    3.556545] Sending DHCP requests .
> [    3.567340] mmc0: new high speed SDHC card at address 0007
> [    3.579884] mmcblk0: mmc0:0007 SD4GB 3.71 GiB=20
> [    3.590452]  mmcblk0: p1
> [    3.600982] mmc1: new high speed MMC card at address 0001
> [    3.607395] mmcblk1: mmc1:0001 MMC02G 1.79 GiB=20
> [    3.615388] mmcblk1boot0: mmc1:0001 MMC02G 1.00 MiB=20
> [    3.622199] mmcblk1boot1: mmc1:0001 MMC02G 1.00 MiB=20
> [    3.628670] mmcblk1rpmb: mmc1:0001 MMC02G 128 KiB, chardev (236:0)
> [    6.136382] ..... timed out!
> [   86.523950] IP-Config: Retrying forever (NFS root)...
> [   86.529327] cpsw-switch 4a100000.switch: starting ndev. mode:
> dual_mac
>=20
> seems like a network problem.

Another example is here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
875019823

I can retry, but it can take more than one retry to get it to pass.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GBxMxVncxFbBLmPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFPR0QAKCRAw5/Bqldv6
8kvTAJ4kFOYdPPJoP1IKvgS1rswtyAxMgwCeMnrUoLjz+YXnr6HJA27o89XKNu0=
=ECTV
-----END PGP SIGNATURE-----

--GBxMxVncxFbBLmPV--

