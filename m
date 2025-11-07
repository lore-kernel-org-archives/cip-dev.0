Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE9CCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 08:50:38 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7176.1762505436402266495
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 00:50:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Yl25x9ij;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF988103D145E;
	Fri,  7 Nov 2025 09:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762505433; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=ymND6drXMv4QkDUfFLnHi5QLWO8QficHONl+3+WPYmk=;
	b=Yl25x9ijE0EFJAtEACqf/GvtiTeWIJEC8oUUFcl9y0WflqbZJKszeTcmsCXg8T09MPwy4D
	30i2hz11UKrEvy7vRAkeY1+ug9lZrfR56m4fvy04guVRlu/e0UVVkUzS2Qc3Bhs0bpCZlx
	F0rolNhu/otpQXDsgs0H32NNDwUXuykk13JdPZM2Uy4MAdkMHj0gUfDWoA2UBw8odIsF0m
	FbedjYuhQC0IgH3HJsUgnXJXMGgI/nLXM4ffUuZ0FWhitnVzt4Qk29gj0Vt3EFrGW95PS9
	PwPiJmbnVKgfVuXuBRmWXjeqwkwn4ePQ9ekfsOIS7XwSsYcLrGSSTlABLqx+pQ==
Date: Fri, 7 Nov 2025 09:50:28 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v5.10.246-cip66
Message-ID: <aQ2y1JFqdN0OpvTK@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UN3RtKAiUtTEnQd3"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 08:50:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20466


--UN3RtKAiUtTEnQd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UN3RtKAiUtTEnQd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQ2y1AAKCRAw5/Bqldv6
8uaeAJ9VXa7z9nE8IdoG+xmxyuexIGaNBgCeKOkYedN/bRIZ298HxNWVPdNOFw8=
=HquP
-----END PGP SIGNATURE-----

--UN3RtKAiUtTEnQd3--

