Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8597C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 09:17:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.16800.1752830218706672461
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 02:16:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IEXShX7U;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC6BB10397286;
	Fri, 18 Jul 2025 11:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752830216; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=vkz+QI3tibQ0evOjFHkECJpiTG70BY3x+gk7eSTBU3M=;
	b=IEXShX7UV2D+8R+SJ+7ahHujQFksd01p8RIlB+WbO/GFgUwyl0d4D02Y4YzaNpgn1dTUwe
	3D+18im7b1UxZvUNeEkOXwf22YJpelKzpbshLctpimIwWeJM2gXIdm4lTKd2YF5DGW7Bol
	stLB2BrKvAP+WrA9XlPzb7vivTwqy6D5JKhHIS7I1FvLAAAWX7SdkNb8/MzkwPvSXABNeb
	/Mnt4vzJmnuVfodkSlkorrCxi4G2oM97TuWs8uPm4Jaopx2/oEcOG3drflmEuX8f5Mlevl
	BQD+qiqlWM05GIfekNgw1cNktcTbxAYLJ/evGcpipqnegaTbWtX6xUQCTTXQjA==
Date: Fri, 18 Jul 2025 11:16:51 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.239-cip62-rt27 (rt133)
Message-ID: <aHoRA2iXVv8j3OvI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qD3Lz1/HgfMc78tw"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 09:17:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19557


--qD3Lz1/HgfMc78tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

While doing this, I noticed localversion-cip-rt was set wrongly in
previous release. Sorry about that.

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qD3Lz1/HgfMc78tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHoRAwAKCRAw5/Bqldv6
8i7QAJ9c+T2c5SGUdRfw35oem79RRi/wLgCfT6KGcDZq24JeiPCtt0l0rY+nYbg=
=YOQw
-----END PGP SIGNATURE-----

--qD3Lz1/HgfMc78tw--

