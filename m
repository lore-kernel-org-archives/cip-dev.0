Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B4DC43334
	for <webhook@archiver.kernel.org>; Sat, 16 Jul 2022 09:08:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3728.1657962525684203976
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Jul 2022 02:08:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DDFAA1C0001; Sat, 16 Jul 2022 11:08:42 +0200 (CEST)
Date: Sat, 16 Jul 2022 11:08:39 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH RESEND 5.10.y-cip 01/13] kernel.h: split out mathematical
 helpers
Message-ID: <20220716090839.GA5658@duo.ucw.cz>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20220715073916.2321319-2-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 Jul 2022 09:08:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8835


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> commit aa6159ab99a9ab5df835b4750b66cf132a5aa292 upstream
>=20
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out
> mathematical helpers.
>=20
> At the same time convert users in header and lib folder to use new
> header.  Though for time being include new header back to kernel.h to
> avoid twisted indirected includes for existing users.

This is rather intrusive for two lines which we really need, and may
cause rejects in future.

I'd suggest identifying the defines needed by the driver, and just
adding those. kernel.h would be acceptable. Or you can add math.h with
just defines needed, but please avoid code movement.

Best regards,
								Pavel

> ---
>  fs/nfs/callback_proc.c        |   5 +
>  include/linux/bitops.h        |  11 ++-
>  include/linux/dcache.h        |   1 +
>  include/linux/iommu-helper.h  |   4 +-
>  include/linux/kernel.h        | 173 +--------------------------------
>  include/linux/math.h          | 177 ++++++++++++++++++++++++++++++++++
>  include/linux/rcu_node_tree.h |   2 +
>  include/linux/units.h         |   2 +-
>  lib/errname.c                 |   1 +
>  lib/errseq.c                  |   1 +
>  lib/find_bit.c                |   3 +-
>  lib/math/div64.c              |   4 +-
>  lib/math/int_pow.c            |   2 +-
>  lib/math/int_sqrt.c           |   3 +-
>  lib/math/reciprocal_div.c     |   9 +-
>  15 files changed, 215 insertions(+), 183 deletions(-)
>  create mode 100644 include/linux/math.h



--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtKAFwAKCRAw5/Bqldv6
8m4eAJ9xKkgh4OGJ4aG+yZl1GOx6/nTmhQCgqi/zeXg0+E7zMCqMNAaDh/XOXt0=
=uv6F
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

