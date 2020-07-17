Return-Path: <SRS0=BCIG=A4=lists.cip-project.org=bounce+64572+4935+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2600C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 08:25:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BBD2071A
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 08:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MXThX7eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BBD2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4935+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5hEtYY4521723xtz1Qhw8BpK; Fri, 17 Jul 2020 01:25:04 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7260.1594974301839472848
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2020 01:25:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D38C31C0BEB; Fri, 17 Jul 2020 10:24:59 +0200 (CEST)
Date: Fri, 17 Jul 2020 10:24:58 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
Message-ID: <20200717082458.GA10436@amd>
References: <1594905847-54471-1-git-send-email-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1594905847-54471-1-git-send-email-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vyimzEvpDA3JwmH8Bm950JzKx4520388AA=
Content-Type: multipart/mixed; boundary="mOnJK3ZvpaVJg0Ce52wA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594974304;
 bh=wEQNWzxHO0tXKWgIdHhjKTe+2L/EwrNsbLTy9KIlPHA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MXThX7eGgTZBv/p8spWse9mDsCga7HPWzx9ugp6VGfCsmBOgHQWlf0KPrKNLNkrYVYt
 LtpE0MQe+HDtR6cCwrfXTi3Tsy0Hpy8MNP/XY58fP77tk14qrjXyzY+UIFWxklEXG+9gh
 tYiAy15zCxYsEJkFV1/PLQGDJZUOvbVG43A=

--mOnJK3ZvpaVJg0Ce52wA
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
>=20
> commit 3dc4db3662366306e54ddcbda4804acb1258e4ba upstream.
>=20
> For SCIF and HSCIF interfaces the SCxSR register holds the status of
> data that is to be read next from SCxRDR register, But where as for
> SCIFA and SCIFB interfaces SCxSR register holds status of data that is
> previously read from SCxRDR register.
>=20
> This patch makes sure the status register is read depending on the port
> types so that errors are caught accordingly.

Looks good to me.

> Cc: <stable@vger.kernel.org>

I notice this applies cleanly to v4.4-stable. Was this submitted to
4.4 / do you need some help there?

Does this have user-visible impact?

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8RYFoACgkQMOfwapXb+vLTdACgqT96n0RGxiMlkLPDfJcfCZfC
4YwAni8jdattTLZr6rV7fnKvBuVgFUCH
=auWa
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--mOnJK3ZvpaVJg0Ce52wA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4935): https://lists.cip-project.org/g/cip-dev/message=
/4935
Mute This Topic: https://lists.cip-project.org/mt/75541395/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mOnJK3ZvpaVJg0Ce52wA--
