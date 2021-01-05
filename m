Return-Path: <SRS0=8tAf=GI=lists.cip-project.org=bounce+64572+5997+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060E2C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 10:26:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3C82250E
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 10:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3C82250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5997+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YhcGYY4521723x9qi5WvzpyM; Tue, 05 Jan 2021 02:26:39 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3407.1609842398215062004
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 02:26:38 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ECDED1C0B78; Tue,  5 Jan 2021 11:26:24 +0100 (CET)
Date: Tue, 5 Jan 2021 11:26:24 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: thermal: rcar-gen3-thermal: Add r8a774e1 support
Message-ID: <20210105102624.GA26440@amd>
References: <20210104102911.8533-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210104102911.8533-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tSRh47fp76RQRJQOMH8qdhMUx4520388AA=
Content-Type: multipart/mixed; boundary="upAEtZQOjr8QXtNUdGT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609842399;
 bh=MLyZiRvGc1u6Uiaw8CcL4Lj48gfx/VzRC+2ej1ufXNc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eqh/KSXcQPJVXxuR2jA2wRTlOeyPlpHIkohXANj7b0rW8W65rZO2fjup0kMJJLwBEAE
 TSBsia0pnhWrvxSrLs2XcX+47m9Z7vf1bXzCTLH7WOt4hGhRmvHZI1zF5X1YC27O5mFL4
 MxYMbxGqdow27STxSJa/DoLNlxsarJSZgrc=

--upAEtZQOjr8QXtNUdGT0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit adfe9285bed09264bf99689c4a6e932f0134cdb1 upstream.
>=20
> Document RZ/G2H (R8A774E1) SoC bindings.

I applied your recent patches, and pushed the result out:

95fea62f9f4534c3b963acd44f03754d9fe0829a dt-bindings: thermal: rcar-gen3-th=
ermal: Add r8a774e1 support
848657b4ebe54338acc6d8f1d6c37bff0b5c55ff dt-bindings: PCI: rcar-pci-host: D=
ocument r8a774e1 bindings
2cbd0f424f601eab085460c14c202f39feda536c dt-bindings: PCI: rcar: Add device=
 tree support for r8a774b1
0936cc2da8b741881a3385567c5788f2667f9a9c dt-bindings: timer: renesas: tmu: =
Document r8a774e1 bindings
435ffed6c9186e8540bbf908601d94998027860f dt-bindings: pci: rcar-pci-ep: Doc=
ument missing interrupts property

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0Ps8ACgkQMOfwapXb+vKxegCgw22cNHGHy0KtacnIvT5ip1Cc
6lIAn2N9ObgTgwgbxdEIpGxmZw8ga7n6
=W9dj
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--upAEtZQOjr8QXtNUdGT0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5997): https://lists.cip-project.org/g/cip-dev/message=
/5997
Mute This Topic: https://lists.cip-project.org/mt/79421300/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--upAEtZQOjr8QXtNUdGT0--
