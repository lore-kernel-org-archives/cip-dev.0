Return-Path: <SRS0=sA3X=JK=lists.cip-project.org=bounce+64572+6365+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7157C433ED
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 10:12:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1320C613B1
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 10:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1320C613B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6365+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AorXYY4521723xh99GxuLGJq; Tue, 13 Apr 2021 03:12:17 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7067.1618308736375352480
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Apr 2021 03:12:17 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D0E991C0B7C; Tue, 13 Apr 2021 12:12:12 +0200 (CEST)
Date: Tue, 13 Apr 2021 12:12:11 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1 clock for CRTC
Message-ID: <20210413101210.GC26782@amd>
References: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: umqt777yNfWLeLyk7emrqT5Gx4520388AA=
Content-Type: multipart/mixed; boundary="r83j83SsOFIcvnJDM4k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618308737;
 bh=eSC8Qup9NPp7XVq7HcWJOS/9CHruKVpmjuHABwGGON8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OeUmC+7jf/a9xHxqe1jEq5Cp0Oq3aCyNzouv9UNDxRbqW7Ox1iuI10cZy0MNA7fxa1r
 2uIGDWZWJWwTIx/BS1pzGUTgbKSBbTtDhDT641xkToG5Nx4HRn+sb6wwRquufzTo6w0gD
 yYv/SUxkZ6ep//hXHEr9brCvqAvEtIp/rRQ=

--r83j83SsOFIcvnJDM4k2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline

--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>=20
> [ Upstream commit 53ced169373aab52d3b5da0fee6a342002d1876d ]
>=20
> On D3 and E3 platforms, the LVDS encoder includes a PLL that can
> generate a clock for the corresponding CRTC, used even when the CRTC
> output to a non-LVDS port. This mechanism is supported by the driver,
> but the implementation is broken in dual-link LVDS mode. In that case,
> the LVDS1 drm_encoder is skipped, which causes a crash when trying to
> access its bridge later on.
>=20
> Fix this by storing bridge pointers internally instead of retrieving
> them from the encoder. The rcar_du_device encoders field isn't used
> anymore and can be dropped.

The patch looks okay to me. I'll test it and can apply it if it works
okay.

But I don't believe it is in our 5.10, so I'd like it to be submitted
for 5.10, too.

Or just tell me it is okay and I'll apply it there, too.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmB1bnoACgkQMOfwapXb+vKqDACeMY24gAUV21cslyRmbEU9fDSP
O0QAnjKyEGo54DfB8kQiPg4x8YUlSNjB
=tND2
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--r83j83SsOFIcvnJDM4k2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6365): https://lists.cip-project.org/g/cip-dev/message=
/6365
Mute This Topic: https://lists.cip-project.org/mt/82032629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--r83j83SsOFIcvnJDM4k2--
