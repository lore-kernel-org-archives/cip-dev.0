Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF76CA1013
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 19:36:00 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3791.1757014558935267804
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 12:35:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DghY7XTN;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9ED6103A8404;
	Thu,  4 Sep 2025 21:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757014557; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PzyClzbY/e5OkW4rWvIjYllT8o4/6LvJ51GJvnKhev0=;
	b=DghY7XTNmnonU3j+FoTHJRMLNZZBCyyBIRkLgpyImF9rB4nn3acvfjjjmds+sEcKbhma1o
	0DD1pKIaD5bzeRwajMlff3uLpRzI+Uw7QkG2MvvvTsH/9GUpETkR6DFlkDa4/oHCP9s4R5
	kcqYhH1H/b3EsgB2lmfjRPP0dfO9TaMURsL96Kr2x3N8xAbF5GgntCnc0U7hwb7fbiLOcI
	bYTfuXLN21C1AZo4exjVfOsmXE+P/O8yFeFV/6TP6ksRgD3IcA+qqfE2e8lVGn9SYRy4Lg
	YhMotg7mAUPvErSCDNAHiGpx++ASF73C/GddCesxTRttom+Wgi6zY2bfbxIGVg==
Date: Thu, 4 Sep 2025 21:35:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/55] Add support for CRU/CSI2 on Renesas
 RZ/G3E
Message-ID: <aLnqGAjsakEWS/DA@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nffhMtJTOIjd4Qsz"
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 19:36:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20018


--nffhMtJTOIjd4Qsz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> This series adds support for the CRU/CSI2 IPs found in the Renesas RZ/G3E=
 in
> Linux 6.1.y-cip. These IPs are similar to those found on the RZ/V2H(P).
>=20
> In addition, it includes patches required to successfully run the v4l2-co=
mpliance
> tests against the OV5645 and the entire media pipeline.
>=20
> This series has been tested on the following hardware setup:
>=20
> OV5645 image sensor (Coral Camera) =E2=86=92 RZ/G3E CSI2 =E2=86=92 RZ/G3E=
 CRU
>=20
> The series applies on top of [1].
>=20
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D993368&st=
ate=3D%2A&archive=3Dboth

As in 6.12, I applied the series. I did not apply the patches "media:
v4l2-subdev: Refactor events" and more as they are not strictly
required.

Some tests are failing, but it is "0 targets available", and I don't
believe this series could reasonably break those targets.

Thank you and best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nffhMtJTOIjd4Qsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaLnqGAAKCRAw5/Bqldv6
8g94AKCAk7EtaMeIGOidS5RR33+s5rTXAACgkeJDOg5HwYPGnHbi8ZI/PS7Wx7M=
=EvM5
-----END PGP SIGNATURE-----

--nffhMtJTOIjd4Qsz--

