Return-Path: <SRS0=ZpnE=A7=lists.cip-project.org=bounce+64572+4941+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34467C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 21:00:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BD420773
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 21:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IrbZUJFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BD420773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4941+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id w2FPYY4521723xWheVnFbbno; Mon, 20 Jul 2020 14:00:16 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5226.1595278815282744263
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2020 14:00:15 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 55CBB1C0BE2; Mon, 20 Jul 2020 23:00:09 +0200 (CEST)
Date: Mon, 20 Jul 2020 23:00:08 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional support for Renesas platforms
Message-ID: <20200720210008.GB9879@amd>
References: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
 <1595267543-32854-2-git-send-email-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1595267543-32854-2-git-send-email-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ig5schDZ16e4U0EI79r6GkJkx4520388AA=
Content-Type: multipart/mixed; boundary="lhNCUja75WJ1njLu07FH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595278816;
 bh=hFqjQridigYKE0ZKkPTJkzJp/tkX0Xz2TL+ldPJ1CDY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IrbZUJFwy6abJn2x+8dom7p6ZDYWAthfrZYBEuD0aK+W9a0wumWXqtyw1+7NF5jlEp5
 uSRwb+6auB535ck6Ug7T7wFPyZjMWZ2k1YXonaXKrkc6R8bfsBCAGjzO6HFgHF/P0ozXw
 saqp8AVdQ0u6PGJVfnUvi7O+1u2Al1GPc/I=

--lhNCUja75WJ1njLu07FH
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-07-20 18:52:23, Biju Das wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit bf9e333ec0d54f7428d9192ad403c3cb523584c7 upstream
>=20
> Increase build and test coverage by enabling support for more hardware
> present on Renesas SoCs and boards:
>   - R-Car CAN and CAN-FD controllers,

Ok, I can apply this if there are no comments.

Should we have some updates for cip-kernel-config?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8WBdcACgkQMOfwapXb+vIYBgCeJKOtlib5JaWeyfP9ofN1zJeb
4BMAoKMTE1xtLGAHAyz/TO+yNKf2JbA1
=957r
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

--lhNCUja75WJ1njLu07FH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4941): https://lists.cip-project.org/g/cip-dev/message=
/4941
Mute This Topic: https://lists.cip-project.org/mt/75687531/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lhNCUja75WJ1njLu07FH--
