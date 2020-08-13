Return-Path: <SRS0=jip9=BX=lists.cip-project.org=bounce+64572+5122+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B733C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 20:49:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E70F20675
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 20:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LymtfWoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E70F20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5122+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TLVRYY4521723x5LvODdx94x; Thu, 13 Aug 2020 13:49:07 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4525.1597351746982160572
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2020 13:49:07 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 711581C0BD2; Thu, 13 Aug 2020 22:49:02 +0200 (CEST)
Date: Thu, 13 Aug 2020 22:49:02 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] drm: atomic helper: fix W=1 warnings
Message-ID: <20200813204902.GB24086@duo.ucw.cz>
References: <20200813083925.7830-1-biju.das.jz@bp.renesas.com>
 <20200813083925.7830-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200813083925.7830-2-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: m1LQ5xA0OOjgDi8MDSONcp8px4520388AA=
Content-Type: multipart/mixed; boundary="lQNT4JAMxzvk9K0FVC1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597351747;
 bh=zmbOjv18kPPsrNMlFqnpHpWAiDQTKlamMwzkhCjK0F8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LymtfWoFg/Q2ABwfLikn/HAVC09Qz4G73bT9XMN0UclyIzSXMundRqnhAOjncd889cv
 MElHD0OjgXLJPwjyrc7BfjQZrl1q6HYh+AiH0oMEsDnc6R0mYFagsjC18b36TdGYDtL+I
 sFvPI0jwu/tRs27tVWbhlQ2D04gjJbkY9gQ=

--lQNT4JAMxzvk9K0FVC1V
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline

--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Benjamin Gaignard <benjamin.gaignard@st.com>
>=20
> commit bf5d837a0a4ced7cc223befc9e76d4ad30697d27 upstream.
>=20
> Few for_each macro set variables that are never used later which led
> to generate unused-but-set-variable warnings.
> Add (void)(foo) inside the macros to remove these warnings
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Link: https://patchwork.freedesktop.org/patch/msgid/20191008124254.2144-1=
-benjamin.gaignard@st.com
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for the fixes. Applied and pushed out.

Best regards,
									Pavel
								=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXzWnPgAKCRAw5/Bqldv6
8imWAJ4h0t7RDjwSuH/iZCon9bg7UPqoMwCgh7wsQovXLGCOVUmGWYZXUuxEAnA=
=XdkE
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

--lQNT4JAMxzvk9K0FVC1V
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5122): https://lists.cip-project.org/g/cip-dev/message=
/5122
Mute This Topic: https://lists.cip-project.org/mt/76165489/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lQNT4JAMxzvk9K0FVC1V--
