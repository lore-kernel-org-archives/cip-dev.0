Return-Path: <SRS0=jYjR=AZ=lists.cip-project.org=bounce+64572+4925+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CE2C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:41:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA16F22519
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IWEe2SHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA16F22519
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4925+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Fph8YY4521723x8Jy4MXKJKf; Tue, 14 Jul 2020 10:41:30 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1905.1594748489262632626
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2020 10:41:29 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 945C01C0BD5; Tue, 14 Jul 2020 19:41:24 +0200 (CEST)
Date: Tue, 14 Jul 2020 19:41:24 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 22/23] PM / OPP: Remove useless check
Message-ID: <20200714174124.GD18210@amd>
References: <20200708154554.26450-1-wens@csie.org>
 <20200708154554.26450-23-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200708154554.26450-23-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: s1mhGlYKpS9OyN8PtEENxmAdx4520388AA=
Content-Type: multipart/mixed; boundary="SRKKcCaYPJoNe0QdvzgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594748490;
 bh=4rTCcvHmOtBYJDkHng1or2KDw4OJXGxpdqZaOvXTddA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IWEe2SHb83MxINT+rXA1Py8Vhs635ZCV2w5q0hXUQoGgdBDRA7cqb8zSjVZp+aF86vC
 iOd76jsRgkudGmbb2A+80TvDgdwCIGHTMHWudNP5YqvqsJ9SqIp82WvbzK35KhK7vvE4x
 vWlJkMGcymJ7p88j7Vy3QBsG3MGZDn6TwdM=

--SRKKcCaYPJoNe0QdvzgK
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline

--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> commit 21f8a99ce61b2d4b74bd425a5bf7e9efbe162788 upstream.
>=20
> Regulators are optional for devices using OPPs and the OPP core
> shouldn't be printing any errors for such missing regulators.
>=20
> It was fine before the commit 0c717d0f9cb4, but that failed to update
> this part of the code to remove an 'always true' check and an extra
> unwanted print message.
>=20
> Fix that now.

So we have 2/ of the series, fixed by 18/ of the series, but 18/ is
buggy too, fixed by 22/. It would be good to have them close ... or
possibly merged or dropped.

Thank you,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8N7kQACgkQMOfwapXb+vJAvwCdE0KduT/1h77YCjIQoDtGZjkz
Y+QAnRpLOskzhpI0AgD98HWCe8mdOGJ4
=r3Cy
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--

--SRKKcCaYPJoNe0QdvzgK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4925): https://lists.cip-project.org/g/cip-dev/message=
/4925
Mute This Topic: https://lists.cip-project.org/mt/75379099/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SRKKcCaYPJoNe0QdvzgK--
