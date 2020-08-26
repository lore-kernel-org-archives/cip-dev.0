Return-Path: <SRS0=1pdk=CE=lists.cip-project.org=bounce+64572+5255+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FC5C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:24:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1103720767
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XlaBL8MW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1103720767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5255+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xSNyYY4521723xvGTx1PpRvK; Wed, 26 Aug 2020 00:24:37 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7664.1598426677032881559
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 00:24:37 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6990E1C0BBC; Wed, 26 Aug 2020 09:24:34 +0200 (CEST)
Date: Wed, 26 Aug 2020 09:24:33 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add OPP/Thermal/Timer/CAN[FD] support
Message-ID: <20200826072433.GB7244@amd>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IPSf4IYiIZWQQ7TEgkrxKLQMx4520388AA=
Content-Type: multipart/mixed; boundary="Z9oqKTImJyAtMAqsWceX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598426677;
 bh=ptetcUv8gxPOWzBl4vyIV6cepCdTN9rGZHTn8LD5qPA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XlaBL8MWeSacy2GXfQKx51+Wy2bSIQhx3IeOSUjYrBVlEQxW2xU+tSASgRnI9g6MAC+
 99ZQud0n/Q5HVs49AYuvRS3u9XUmbaQuV7CufhbTitJrQwC2mZcTsDDgm9NLEG6BIYGPC
 EER7I4c1hfCoFXpLVx2w8NnakThD72NkLPU=

--Z9oqKTImJyAtMAqsWceX
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add RZ/G2H SoC support for OPP/Thermal/Timer/CAN[FD]
> to 4.19.y cip kernel.
>=20
> All the patches in this series are cherry-picked from ML.

Thank you, series looks good to me. gitlab has troubles testing cip trees
at the moment, I can apply all the pending patches once that is solved
(assuming tests pass).

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9GDjEACgkQMOfwapXb+vLSxwCgmrNVcnmrfG/Vi4sq0B3go7/S
uP0Ani+t7Qgsz/KsTk3hyAdEQTXYI3YG
=PNsB
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

--Z9oqKTImJyAtMAqsWceX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5255): https://lists.cip-project.org/g/cip-dev/message=
/5255
Mute This Topic: https://lists.cip-project.org/mt/76406704/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Z9oqKTImJyAtMAqsWceX--
