Return-Path: <SRS0=v2iu=BD=lists.cip-project.org=bounce+64572+4993+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889D0C433E3
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 07:30:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33512065E
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 07:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ax33tS1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33512065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4993+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PPUBYY4521723xX9cmU35KZf; Fri, 24 Jul 2020 00:30:16 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1454.1595575814533165683
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 00:30:15 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3109D1C0BD2; Fri, 24 Jul 2020 09:30:09 +0200 (CEST)
Date: Fri, 24 Jul 2020 09:30:08 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Add RZ/G2E Dual LVDS display
Message-ID: <20200724073008.GA28645@amd>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
 <20200722214933.GB16146@amd>
MIME-Version: 1.0
In-Reply-To: <20200722214933.GB16146@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TSp6RZnzZ4nDsdBlvBf2qCBgx4520388AA=
Content-Type: multipart/mixed; boundary="8AMzuVTsU2l4pyansDAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595575816;
 bh=/e22EQYhz6u0pP+abE/dBbKJawH/Dw1HS5RJcbtDyVI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ax33tS1x4uz9TsSZV6JjQlq/PqrP4Vmsjb8LrxvG5Vyxsxhj0JkxJHAr1hVeN6ZKTKh
 t4yIJo1keN5u3Bl74ffolZ2QZUaqoVktNinODThO0AgmnVCxD16XGNNEyYzIqG5qOekMI
 T0RkWGIhMJWzFCW0F8WG7uV54bD3w2R+RS8=

--8AMzuVTsU2l4pyansDAz
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Add RZ/G2E Dual LVDS display support. All patches in this series are=20
> > cherry-picked from upstream kernel.
>=20
> I could not find any issues besides double of_node_put in 11/.
>=20
> It is currently being tested:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/169687006
>=20
> If noone objects (and tests pass), I can apply/push the series.

Applied, thanks for patches.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8ajgAACgkQMOfwapXb+vJ+ugCeJ7I1T3FGMyJ77ZyTi+n/Jz6W
LLYAoKJMKcFhV7KLD+IDP/38luqoK2EZ
=xUrd
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--8AMzuVTsU2l4pyansDAz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4993): https://lists.cip-project.org/g/cip-dev/message=
/4993
Mute This Topic: https://lists.cip-project.org/mt/75730020/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8AMzuVTsU2l4pyansDAz--
