Return-Path: <SRS0=7EUb=6E=lists.cip-project.org=bounce+64572+4590+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D874C3A5A0
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 20:22:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83BA20782
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 20:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gxLYWTsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83BA20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4590+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ousSYY4521723xFrsN0FmgTV; Mon, 20 Apr 2020 13:22:50 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2473.1587413758476593552
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 13:15:59 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B63531C01E0; Mon, 20 Apr 2020 22:15:54 +0200 (CEST)
Date: Mon, 20 Apr 2020 22:15:54 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH 1/2] dt-bindings: display: Add idk-1110wr binding
Message-ID: <20200420201554.GA15616@duo.ucw.cz>
References: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587412250-16752-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1587412250-16752-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sck3r7zaDCxM8JNYxCZY1jMix4520388AA=
Content-Type: multipart/mixed; boundary="CAYAnaQvX239DMqjfIMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587414170;
 bh=tttla2JbPzcjQsdQGPC6amYj76Tjvc4RIqjOV1rfkTg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=gxLYWTsWHzuNd/gngYwEAfiMrLqr56CLG+RWTXJCXiw7PbwMkxtn5QRKoxZJbKm/iMo
 6wQsdl3yDB1yGZ0MjdZ0x9l2fuiUnhp9oWRal/5zffS2M7/ieowcbhE4jBfiUor59+x0j
 1jWRqkDrscIIVBzd7LxkVXskbYv6vq4sFRo=

--CAYAnaQvX239DMqjfIMr
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add binding for the idk-1110wr LVDS panel from Advantech.
>=20
> Some panel-specific documentation can be found here:
> https://buy.advantech.eu/Displays/Embedded-LCD-Kits-LCD-Kit-Modules/model=
-IDK-1110WR-55WSA1E.htm
>=20
> This patch is based on commit d26087162857b12bd9d0424f2dea2cd9654e50a0
> upstream ("dt-bindings: display: Add idk-1110wr binding") which adds yaml
> bindings.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Okay. In future, I believe we can take yaml binding, even for kernel
where yaml support is not included. The markup is designed to be
human-readable anyway.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXp4C+gAKCRAw5/Bqldv6
8qqRAKCATq5aKYznGGklUi20G5gqbr92nQCgnbMrgPApMNLDUBOeHjovCG0Pyp4=
=ZBG5
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

--CAYAnaQvX239DMqjfIMr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4590): https://lists.cip-project.org/g/cip-dev/message=
/4590
Mute This Topic: https://lists.cip-project.org/mt/73158052/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CAYAnaQvX239DMqjfIMr--
