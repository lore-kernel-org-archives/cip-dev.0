Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C008EC433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 09:41:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.17459.1640166098611440494
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 01:41:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BA2F01C0B7C; Wed, 22 Dec 2021 10:41:31 +0100 (CET)
Date: Wed, 22 Dec 2021 10:41:30 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for pinctrl/dmac/iic
Message-ID: <20211222094130.GA15186@amd>
References: 
 <TYAPR01MB62528F92704101B24FAC60F8927D9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: 
 <TYAPR01MB62528F92704101B24FAC60F8927D9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 09:41:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7224


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-12-22 01:22:09, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi all,
>=20
> Hi!
>=20
> >> This patch series adds Pinctrl/DMAC/IIC support for Renesas RZ/G2L SoC.
> >>=20
> >> All the patches have been cherry picked from v5.16-rc5.
> >>=20
> >> I have created a MR [0] for cip-kernel-config (for testing purpose), w=
hich
> >> can later be merged once this patches have been merged.
> >
> >Series looks okay to me. All I could find are
> >whitespaces/comments/documentation issues.
> >
> >I'll proceed with testing; I can apply it if it passes and there are
> >no other comments.
>=20
> I reviewed this series, there was no issue.
> And build test was all green.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/4339457=
22
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHC8soACgkQMOfwapXb+vLZvgCdGY/J5RPekGFs2TQtEtF+41Sh
28sAn2XtVBI1aDk8ZXp4Uo8pSUTbH2gJ
=wRvT
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

