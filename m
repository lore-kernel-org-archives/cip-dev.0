Return-Path: <SRS0=55kY=CH=lists.cip-project.org=bounce+64572+5327+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D2C433E2
	for <cip-dev@archiver.kernel.org>; Sat, 29 Aug 2020 11:51:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61623207BB
	for <cip-dev@archiver.kernel.org>; Sat, 29 Aug 2020 11:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="heA/6CNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61623207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5327+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3eUlYY4521723xZGeIjugQXd; Sat, 29 Aug 2020 04:51:09 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.9870.1598701867646724961
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 Aug 2020 04:51:08 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 384021C0B82; Sat, 29 Aug 2020 13:51:03 +0200 (CEST)
Date: Sat, 29 Aug 2020 13:51:02 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] arm64: dts: renesas: Fix SD Card/eMMC interface device node names
Message-ID: <20200829115102.GA19324@duo.ucw.cz>
References: <20200827154032.28116-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200828181147.GA10270@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200828181147.GA10270@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zZO99LrerkUywYHfQbJyeYOfx4520388AA=
Content-Type: multipart/mixed; boundary="ZDADeqoc4duKdhc4tEei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598701869;
 bh=3hxv3E+rbE/sIS+L67bRRWOiBvNfT+D11vF0Ef2LCAs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=heA/6CNbv5doViU7lQ49KThPL8evtAW4/FBhvReZulj+BR07mPFR5qci6UxFU4kJGav
 1R3WppTRTHwTIMNN12mcsKi3QA85i4h2e1txyQqVT7YzGfLEJWpRPUcFEvqRPOaYte7Qw
 a0lZA8v4JI0s8ruYjkIzVTAXRmRHWM7WCSg=

--ZDADeqoc4duKdhc4tEei
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-08-28 20:11:47, Pavel Machek wrote:
> Hi!
>=20
> > From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >=20
> > commit a6cb262af1e1adfa6287cb43f09021ee42beb21c upstream.
> >=20
> > Fix the device node names as "mmc@".
>=20
> I believe this is only fix for some dtc warnings, so... it is not too
> urgent.
>=20
> Anyway, it is okay, and i'll apply it soon if there are no objections.

Applied and pushed out.

Thanks,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0pBJgAKCRAw5/Bqldv6
8oC6AKC1YNqD1SuBJVvfp23eJb5H83CzcgCgppDd9u/1RAPrk5q9HkcskU4o7yI=
=zHyi
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--ZDADeqoc4duKdhc4tEei
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5327): https://lists.cip-project.org/g/cip-dev/message=
/5327
Mute This Topic: https://lists.cip-project.org/mt/76454173/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZDADeqoc4duKdhc4tEei--
