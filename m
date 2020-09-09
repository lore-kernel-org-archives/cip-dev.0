Return-Path: <SRS0=sth9=CS=lists.cip-project.org=bounce+64572+5437+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3DEC43461
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:25:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DBB21919
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 07:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kp+zYPqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DBB21919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5437+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fXJhYY4521723xhXLfvzLFvA; Wed, 09 Sep 2020 00:25:01 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.8434.1599636299790606694
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2020 00:25:00 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 42AA31C0B79; Wed,  9 Sep 2020 09:24:56 +0200 (CEST)
Date: Wed, 9 Sep 2020 09:24:55 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Pavel Machek <pavel@denx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/6] RZ/G1H add support for Ether/[H]SCIF{A|B}
Message-ID: <20200909072455.GG27139@duo.ucw.cz>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903172335.GA7795@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200903172335.GA7795@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: N73KjwFBEdNkee0f6W8gwwRpx4520388AA=
Content-Type: multipart/mixed; boundary="9EFKyMckJ01TEkgEJMhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599636301;
 bh=gRiqdX2gFKvcPZ8iIAZv1hYcR6UBQPbM5U0+OPSkJlo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kp+zYPqO/sXkJrGtyGl/fjLZx8n+r50goX0/SM176CmxU3Tj09CAmOBO7rCsq6FLVEy
 kG9s44dINEiRaG2YTjdLudbvYf3OCmIxIzXIaqL1tBW9EmAIVUWOePBXYbx1Wu20fdnHs
 i263L9Kd+AMqP8rc/jK/w5u1NEqifiEtE1Y=

--9EFKyMckJ01TEkgEJMhW
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline

--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds support for ETHER/[H]SCIF{A|B} to
> > R8A7742 SoC and alongside adds camera daughter board dts
> > which fits on iwg21d-q7 development platform.
> >=20
> > Patches 1/6, 3/6, 5/6, 6/6 have been cherry picked from
> > upstream kernel, patch 2/6 is a hookup patch to enable=20
> > eth on R8A7742 SoC and patch 4/6 is a fixup patch.
>=20
> This series looks okay to me.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1iDRwAKCRAw5/Bqldv6
8gmyAJ4o9cwKMNdVlOUUgJsENXubmfW6HwCgoFzvImzslYuS9/Uetd0MmEeoxEI=
=kZIT
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--

--9EFKyMckJ01TEkgEJMhW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5437): https://lists.cip-project.org/g/cip-dev/message=
/5437
Mute This Topic: https://lists.cip-project.org/mt/76608365/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9EFKyMckJ01TEkgEJMhW--
