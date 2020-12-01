Return-Path: <SRS0=aCZS=FF=lists.cip-project.org=bounce+64572+5926+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A5C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:28:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA5120674
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DZtJdiXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA5120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5926+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qnqOYY4521723xT4vX66eE60; Tue, 01 Dec 2020 01:28:25 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.7658.1606814904799178212
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 01:28:25 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7FA451C0BC8; Tue,  1 Dec 2020 10:28:22 +0100 (CET)
Date: Tue, 1 Dec 2020 10:28:22 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection support
Message-ID: <20201201092822.GB4219@duo.ucw.cz>
References: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VsNusNSky9M4aq2SMBdUJ3omx4520388AA=
Content-Type: multipart/mixed; boundary="6LbsVhUolNGTTV2YGrWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606814905;
 bh=6Vzx4UzZuLZN1WLDAzZFeu3bHXU28lYUUlwcTekGyH0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DZtJdiXkSOX7bXokzPeaTBuXJNvVSJjUCl2S572uYdRGEhILX1WTgkcFgTOHpp86j2L
 rPLa9n1OyEFxFtc25BrLCkZjui7OPA451AyCu/4kozWPY2CC3DNohBbqlFbRVgX5VWNEA
 F26gNSH6/xu+c4QlpnT0SCmINdV9jq7elHk=

--6LbsVhUolNGTTV2YGrWI
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline

--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds SoC detection support for Renesas RZ/G1x SoC's.
>=20
> All the patches apart from {7, 9, 11}/11 have been cherry picked from
> Linux v5.10-rc6

Series looks good to me, I can apply it if there are no other
comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8YMtgAKCRAw5/Bqldv6
8qZUAKCQuSxOj4ED/cF+L949CwuV1dQIVACgvTjiRcxBqn8yyhjziwKnFFKmDDg=
=yY7d
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

--6LbsVhUolNGTTV2YGrWI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5926): https://lists.cip-project.org/g/cip-dev/message=
/5926
Mute This Topic: https://lists.cip-project.org/mt/78628858/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6LbsVhUolNGTTV2YGrWI--
