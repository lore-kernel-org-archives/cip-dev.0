Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FBAC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 19:48:27 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4665.1742327302761476354
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 12:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dDmaX4zS;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0666101F63AA;
	Tue, 18 Mar 2025 20:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742327300; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Yrkop2ChaaGbOl25DNgFN7Fz2zOzdI3PmkeR+eXm1Ms=;
	b=dDmaX4zSailwPj6qrDP4RUP8I4QvswH2q/+Dxmo92kbb8RNEFNTtc/TXvvYZ6l/h9DQtxJ
	DkDeyq0ybA4uvMnIx+S1XKuiCOptapl+bq3+Wgq1ezmD+UtPxq/aIY6mqTxaPI8wz+1G0U
	Zm3xmho2aNbQOW1UE3f+HTGrHvbIqTZxc+lVUQ/yUpB0lxSqc+0uqC0cyzOqhsY63KUCFV
	1xLIwCd3cRHEZiEKMCAgCfAVToUxf+zzEQqt9aW3Wq3df408EJztrliTeJmHaBBBQtkREH
	8A+uPTcsr4zJvnEuVvsovBpVq/Bkwyik63oZagnezVH7N2hgrAJidgr+dPsvAA==
Date: Tue, 18 Mar 2025 20:48:14 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9nN/lceTGApULQg@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
 <Z9LHJC92Bp3HxjT2@tom-desktop>
 <Z9P/qUzPfn368iGo@duo.ucw.cz>
 <Z9QTPtKb5Y3E3vqP@tom-desktop>
 <Z9QVjxYJH4OSm0sP@tom-desktop>
 <Z9ci7jj/Dne7qADQ@duo.ucw.cz>
 <Z9gymvnsOxYFrn5K@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zk5Ogw1Is3Qi1v/o"
Content-Disposition: inline
In-Reply-To: <Z9gymvnsOxYFrn5K@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 19:48:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18242


--zk5Ogw1Is3Qi1v/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > What is relation between RZ/G3E and rzg2l? Because early patches =
seem
> > > > > to be for rzg2l support, not RZ/G3E. Splitting those preparations=
 up
> > > > > would be good.
> > > >=20
> > > > Thanks for your comment.
> > > >=20
> > > > RZ/G3E and RZ/G2L SoC have some similar IP's.
> > >=20
> > > Sorry, to be more precise:=20
> > > RZ/G3E, RZ/V2H and RZ/G2L SoC have some similar IP's.
> >=20
> > Thank you. One day I'd like to understand that naming scheme and how
> > different SoCs are related to each other.
> >=20
> > > > Fully agree.
> > > > I will split backporting in smaller patchset as you suggested.
> > > > Thanks.
> >=20
> > Thank you. I went through the series up-to 23 or so, and it looked
> > mostly good.
>=20
> Thanks for your feedback.
>=20
> I've done some investigation/testing here.
> I'm going to split the big series into the following for now:
>=20
>  - first series:
>    serial: sh-sci backpoting patches 65/85 to 76/85
>    (required for a minimal boot)
>=20
>  - second series:
>    clock + minimal boot support patches 1/85 to 22/85
>    (as you suggested)
>=20
> What do you think? Thanks in advance.
>=20
> Later:
>=20
>  - pinctrl
>  - i2c

That sounds like a good plan.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zk5Ogw1Is3Qi1v/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9nN/gAKCRAw5/Bqldv6
8ug8AKCNG3Al2XP+CGEmH4tPVebRhjOZvACeLzgx/SyTlgSjZ2jSDvPp3DJWBHo=
=s31P
-----END PGP SIGNATURE-----

--zk5Ogw1Is3Qi1v/o--

