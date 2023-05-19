Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D34FC7EE23
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 22:13:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1508.1684534383795270677
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 15:13:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2B91D1C0E57; Sat, 20 May 2023 00:13:01 +0200 (CEST)
Date: Sat, 20 May 2023 00:13:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
 deprecate old ones
Message-ID: <ZGf0bB94Ugj2sQ36@duo.ucw.cz>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8OMNxWhXWmxMyEai"
Content-Disposition: inline
In-Reply-To: <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 22:13:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11571


--8OMNxWhXWmxMyEai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'll have comments on 19/, but this one is kind of important:

> From: Paul Cercueil <paul@crapouillou.net>
>=20
> commit 1a3c7bb088266fa2db017be299f91f1c1894c857 upstream.
>=20
> This commit introduces the following macros:
>=20
> SYSTEM_SLEEP_PM_OPS()
> LATE_SYSTEM_SLEEP_PM_OPS()
> NOIRQ_SYSTEM_SLEEP_PM_OPS()
> RUNTIME_PM_OPS()
>=20
> These new macros are very similar to their SET_*_PM_OPS() equivalent.
> They however differ in the fact that the callbacks they set will always
> be seen as referenced by the compiler. This means that the callback
> functions don't need to be wrapped with a #ifdef CONFIG_PM guard, or
> tagged with __maybe_unused, to prevent the compiler from complaining
> about unused static symbols. The compiler will then simply evaluate at
> compile time whether or not these symbols are dead code.
>=20
> The callbacks that are only useful with CONFIG_PM_SLEEP is enabled, are
> now also wrapped with a new pm_sleep_ptr() macro, which is inspired from
> pm_ptr(). This is needed for drivers that use different callbacks for
> sleep and runtime PM, to handle the case where CONFIG_PM is set and
> CONFIG_PM_SLEEP is not.
>=20
> This commit also deprecates the following macros:
>=20
> SIMPLE_DEV_PM_OPS()
> UNIVERSAL_DEV_PM_OPS()
>=20
> And introduces the following macros:
>=20
> DEFINE_SIMPLE_DEV_PM_OPS()
> DEFINE_UNIVERSAL_DEV_PM_OPS()

Changing interfaces / deprecating macros is not good thing to do in
-cip kernel. How sure are we this will not cause build failures or
build warnings in unrelated piece of code?

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8OMNxWhXWmxMyEai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGf0bAAKCRAw5/Bqldv6
8p6CAJ9BhvKonVFYqirRcDm2tcqTa55GlwCeMcTwPUDctTgY5SjSpUoN/75rbAI=
=ZKJt
-----END PGP SIGNATURE-----

--8OMNxWhXWmxMyEai--

