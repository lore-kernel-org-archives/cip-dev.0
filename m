Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96EAC4707B
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 19:51:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.27134.1704829867181348910
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jan 2024 11:51:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 522B41C006B; Tue,  9 Jan 2024 20:51:04 +0100 (CET)
Date: Tue, 9 Jan 2024 20:51:03 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/30] Add support for Renesas RZ/Five RISC-V
 SoC
Message-ID: <ZZ2jpzco/6c5h/UP@duo.ucw.cz>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JFHlVYhAvkFZk01x"
Content-Disposition: inline
In-Reply-To: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jan 2024 19:51:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14320


--JFHlVYhAvkFZk01x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> entry-class social infrastructure gateway control and industrial gateway
> control.

I don't dare to apply it without testing. So... can we get qemu-riscv
and this board tested for 6.1 (and probably 6.8)?

I'll also ask anyone for comments here. The series looked good to me
the last time (I may take second look), but I'm likely to apply it if
it gets tested and if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JFHlVYhAvkFZk01x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZ2jpwAKCRAw5/Bqldv6
8u9rAKCEIAOKuenlAJv03b92ezmlN5patACeKAkCQJzUVWcpHeu9IdVMzlJEaKY=
=Gk81
-----END PGP SIGNATURE-----

--JFHlVYhAvkFZk01x--

