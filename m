Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA6C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 11:12:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.11569.1706699557873062878
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 03:12:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 84EEC1C007F; Wed, 31 Jan 2024 12:12:35 +0100 (CET)
Date: Wed, 31 Jan 2024 12:12:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de, biju.das.jz@bp.renesas.com, yuki.saito@toshiba.co.jp
Subject: Re: [PATCH 0/1] clk: Fix for restructuring for no reparent case
Message-ID: <ZborIz5UgFSvjKRf@duo.ucw.cz>
References: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G0iNx14kQp+oHTvQ"
Content-Disposition: inline
In-Reply-To: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 11:12:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14556


--G0iNx14kQp+oHTvQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> With v6.1.72-cip13 + Zynq UltraScale+ MPSoC ZCU102, we observed that
> Ethernet does not work when it's speed is 100Mbps.
> This issue happens after d94c14f6fa34f2b8b33e5957f5b8dfb5aaf56b1e is
> backported to the clk framework, which is not a part of linux-6.1.y
> and probably is one of the dependencies of versa3 clk generator support
> for Renesas SoCs. See the patch series "Add versa3 clk generator support".
>=20
> In mainline, a fix for the backport commit above is provided:
> be8fa5fd0a48fd2decc4de81ffe72bb3ceacecd9.
> This should be applied to linux-6.1.y-cip as well.
> With v6.1.72-cip13 + this patch, we confirmed the ZCU102 Ethernet
> works at 100Mbps.

Thanks a lot for investigation and sorry for the trouble.

The fix is simple enough, I am currently running tests, and can take
it if they pass and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G0iNx14kQp+oHTvQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZborIwAKCRAw5/Bqldv6
8r6bAKCPJFva7FV83ovSOXkMbp4shIiGVQCfWRHRtA2DgCZdE49DSshlHQ0VTmo=
=1NxB
-----END PGP SIGNATURE-----

--G0iNx14kQp+oHTvQ--

