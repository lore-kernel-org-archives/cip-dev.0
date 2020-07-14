Return-Path: <SRS0=qEXD=AZ=lists.cip-project.org=bounce+64572+4924+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E62C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:38:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7896622518
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cQ6pPUaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7896622518
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4924+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GpuBYY4521723xEMrAxjcjlj; Tue, 14 Jul 2020 10:38:49 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1759.1594748328144724352
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2020 10:38:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BFF11C0BD7; Tue, 14 Jul 2020 19:38:45 +0200 (CEST)
Date: Tue, 14 Jul 2020 19:38:44 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 18/23] PM / OPP: Initialize regulator pointer to an error value
Message-ID: <20200714173844.GC18210@amd>
References: <20200708154554.26450-1-wens@csie.org>
 <20200708154554.26450-19-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200708154554.26450-19-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pm3o1blHO6F6ytR8TNlammMkx4520388AA=
Content-Type: multipart/mixed; boundary="8ViaTuJXRUrGXKPiUPFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594748329;
 bh=AZ92phoaKC1SpYehudVL34uP+6xiF3CHucG6/OK53D4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cQ6pPUaz2UfEDEei4wicD+bGHaHlNO8jVL/lqcLce0GCoX9dM6X48dK5LI12/kVjZ9b
 B88P4niOYjIdazSalmdBYqY1nuTdBzhYfFwXmTXYNtZJgEFC4x9VaQqP8T0W5WnqaB84K
 QxHNAXcYq/AvZJ+eqSCiLHBw8KwZfr2kBb4=

--8ViaTuJXRUrGXKPiUPFM
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline

--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-07-08 23:45:49, Chen-Yu Tsai (Moxa) wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> commit 0c717d0f9cb46259dce5272705adce64a2d646d9 upstream.
>=20
> We are currently required to do two checks for regulator pointer:
> IS_ERR() and IS_NULL().
>=20
> And multiple instances are reported, about both of these not being used
> consistently and so resulting in crashes.
>=20
> Fix that by initializing regulator pointer with an error value and
> checking it only against an error.
>=20
> This makes code more consistent and more efficient.

Again, this should be close to (or merged with) patch 2/ of the series.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8N7aQACgkQMOfwapXb+vIvLACfdn/yIUO8waZdptrJJ4xplYQh
9esAmwWiSxa+tdfQd8502Z4BKhVcZRCj
=McjP
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--

--8ViaTuJXRUrGXKPiUPFM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4924): https://lists.cip-project.org/g/cip-dev/message=
/4924
Mute This Topic: https://lists.cip-project.org/mt/75379095/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8ViaTuJXRUrGXKPiUPFM--
