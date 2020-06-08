Return-Path: <SRS0=5uyI=7V=lists.cip-project.org=bounce+64572+4771+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90133C433DF
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 21:37:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B5620760
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 21:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ldZEFwJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B5620760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4771+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UVSaYY4521723xVJ6eM8wnfx; Mon, 08 Jun 2020 14:37:44 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1309.1591652263711283336
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 14:37:44 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9833A1C0C0D; Mon,  8 Jun 2020 23:37:41 +0200 (CEST)
Date: Mon, 8 Jun 2020 23:37:41 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip v2 00/15] PM / OPP v2 & cpufreq backports part 1
Message-ID: <20200608213740.GB2851@amd>
References: <20200608093028.21612-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200608093028.21612-1-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bB7lFRlh59PER93QM8vWzhIgx4520388AA=
Content-Type: multipart/mixed; boundary="eq9sRpnQQYxp9IZV1sbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591652264;
 bh=xUp8v+3M+MzjHLNMjH+p07tlF/XmW3Dfe63R+cGAsTk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ldZEFwJQ18Ij56txa38ISAEd5LE/uJSNlF5T0Ux1+5jwY3QK0PWp2ug6t4zsEj+Vt4i
 0HfRGmuyflOzMDByea9y8/81rnjRBTGAb8t4oph7gMZuQpmj+CZmrmVcvVZ70V35NJefv
 TAuQG/QO9S1JJJ1xJym/yXWAeVj1benFr+Y=

--eq9sRpnQQYxp9IZV1sbJ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is v2 of the part 1 of MOXA's PM / OPP / cpufreq backport series.
> Changes since v1:
>=20
>   - Added missing SoB and upstream commit hash for "PM / OPP: Set
>     cpu_dev->id in cpumask first"

=2E..

>     01fb4d3c39d3 PM / OPP: Parse 'opp-<prop>-<name>' bindings
>     fd8d8e63467c PM / OPP: Fix parsing of opp-microvolt and

OPP subsystem is shared with other boards, so I believe we should be
careful here. 01fb4d3c39d3 introduces a bug and fd8d8e63467c fixes
it. I believe it would be better to merge them together. Adding a note
such as:

[Merged Bartlomiej Zolnierkiewicz's <b.zolnierkie@samsung.com>
upstream commit fd8d8e63467c922be9ae4452cca2980d473477d9 to fix a bug]

before your signoff should do the trick.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7er6QACgkQMOfwapXb+vIuygCeIYBqDOoJ9Eu2Q9dxRPtg5yNl
NowAoLLPLZVnFylkr1YZbKIxwRjYaFgt
=EVm6
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

--eq9sRpnQQYxp9IZV1sbJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4771): https://lists.cip-project.org/g/cip-dev/message=
/4771
Mute This Topic: https://lists.cip-project.org/mt/74748491/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eq9sRpnQQYxp9IZV1sbJ--
