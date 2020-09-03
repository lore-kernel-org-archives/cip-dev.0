Return-Path: <SRS0=svFj=CM=lists.cip-project.org=bounce+64572+5404+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E91C433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:31:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D782206C0
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MvDqpIco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D782206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5404+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3e3UYY4521723xfcvvHRT3Zn; Thu, 03 Sep 2020 10:31:51 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.19542.1599154310865637583
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 10:31:51 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5C2E81C0B76; Thu,  3 Sep 2020 19:31:47 +0200 (CEST)
Date: Thu, 3 Sep 2020 19:31:46 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] of: Add missing exports of node name compare functions
Message-ID: <20200903173146.GB7795@duo.ucw.cz>
References: <20200903160052.8806-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200903160052.8806-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CqpKoAyJFkkHtwrRuo4wFIkPx4520388AA=
Content-Type: multipart/mixed; boundary="KCgBd5xkZ7pG3scXqVyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599154311;
 bh=qmlRNeWhZEGow9Uj6aqPHhrq/W3hSEzvCHvke8wSGb8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MvDqpIcoiBPXrPGVYB0EtvBecYeggtcM5zWa3BXs4VcOuSsTPfyUoE+Hpop/QYJzwt9
 5CCiTXFiPHLI0pDAADtVL8HnEYvGfGhu/a1IPoTBCTFocXzqz6BMzWHameMY8dskAw6cr
 YvkX9sNcR7vPVPvBbuSY0YMQjpFumm/GlgE=

--KCgBd5xkZ7pG3scXqVyg
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 173ee3962959a1985a109f81539a403b5cd07ae7 upstream.
>=20
> Commit f42b0e18f2e5 ("of: add node name compare helper functions")
> failed to add the module exports to of_node_name_eq() and
> of_node_name_prefix(). Add them now.
>=20
> Fixes: f42b0e18f2e5 ("of: add node name compare helper functions")
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Fixes build failure for multi_v7_defconfig
> ---

Ok, what is going on here?

I don't believe f42b0e18f2e5 causes build failure; it adds functions,
but it can't cause build failure without a user.

Which commit fails the build? Do we have that in 4.4.y-cip? Can
this be placed before the buggy commit so that build is not broken?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1EoggAKCRAw5/Bqldv6
8iM5AKC6fwpE3qc0GsKhd0ES++cW2A9xFACfcVd9bVtT+Xv9/8Sbd4V7VmjcVfA=
=4N9l
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

--KCgBd5xkZ7pG3scXqVyg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5404): https://lists.cip-project.org/g/cip-dev/message=
/5404
Mute This Topic: https://lists.cip-project.org/mt/76610346/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--KCgBd5xkZ7pG3scXqVyg--
