Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1378DE77188
	for <webhook@archiver.kernel.org>; Tue, 14 Jan 2025 12:27:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.43393.1736857655778969180
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jan 2025 04:27:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ThSwCJKh;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48022101C8558;
	Tue, 14 Jan 2025 13:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1736857653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=M80StxoRXbEmBadJt9kBGD5TLLK9CPv6D4bAp76Gu2w=;
	b=ThSwCJKhtfnZFCRttZB/bbF5T2EnqdxfMqZ9rXi+Pd3FE7gWSQBkI/lkXIPF8peP6sr2Ww
	6QiRp48+uE2a7DsKS+15cTKNTDmVVhAQPhKG+qDcUabB+WNx4n6N5NqMmDeJD4BOZlho5p
	Hl+X+aJHiMTORUcesAA1XvHEIkznjHb7D/yuI83Zv8SLCn4+ZpVIbfsx5y84GqoRAJ7bZC
	Qdxrpsk027zfI0zRgSJU8b6mqzoTMLS4S7X9FJwCtUIU/VG12Hc0qxrwwtKdGAzeeCzchI
	e/HTSAkCN4t/Kp4hThOSVKqcPAEZsVF1HgN5Rf21VJuDncM+8E+SJma2O31khw==
Date: Tue, 14 Jan 2025 13:27:30 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip116-rt40 (rt140)
Message-ID: <Z4ZYMtObh3qVJtEZ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z+Cfo1GcsjGMUzlC"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jan 2025 12:27:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17537


--Z+Cfo1GcsjGMUzlC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Z+Cfo1GcsjGMUzlC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ4ZYMgAKCRAw5/Bqldv6
8tscAJ48G0IsKug3kgXT74rRNxqu/XzWgQCcCl8AmkN8O2ZU7+nFOZz0APNoxvo=
=8lyW
-----END PGP SIGNATURE-----

--Z+Cfo1GcsjGMUzlC--

