Return-Path: <SRS0=Q5/u=CD=lists.cip-project.org=bounce+64572+5251+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F51C433E1
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 21:51:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D282071E
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 21:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uOxwjKLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D282071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5251+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 61MSYY4521723xXF5M2xigbg; Tue, 25 Aug 2020 14:51:34 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1410.1598392292405752087
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 14:51:32 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 104721C0BD0; Tue, 25 Aug 2020 23:51:27 +0200 (CEST)
Date: Tue, 25 Aug 2020 23:51:26 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Message-ID: <20200825215126.GA28711@amd>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
 <20200819180505.GB5567@amd>
 <TYBPR01MB5309709F469C1BBDCB012749865A0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200823193502.GD25365@duo.ucw.cz>
 <TYBPR01MB53091561C3CC410E46A6A6F686560@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB53091561C3CC410E46A6A6F686560@TYBPR01MB5309.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OnwpgWfCouCxbrDtJDUI8HKbx4520388AA=
Content-Type: multipart/mixed; boundary="nhUbKU8rzXKLfTJ6zrQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598392294;
 bh=Gjn+rjl4yIUmLafmqdN3gyjCcfuR0l/Kc7LQCnZUHKg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uOxwjKLODay/yiRjSOSjDEOmJ2EMkyJpL3Y6owquHdVfbV88xE+9b2J3iWlT/Sews6S
 O5a/MWpO2GKAOzPTxOF910XORxAuGH/r409xfHBkqzbvIkmh+KBT13n3U1uE4g4hQiTSg
 Nhdq4LpFNXusKqAKMTJQDNaWbX13+zHrX48=

--nhUbKU8rzXKLfTJ6zrQP
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I believe it would be better to always use explicit revision in these c=
ases;
> > anything else is fairly confusing, as kernel update breaks your setup (=
aka a
> > regresssion).
> >
> > Now, if -rev2 had few copies, and people really have -rev4, there will =
not be
> > much breakage. But imagine if rare -rev5 is released in future...
> >
> > But mainline already made the choice. I'd just prefer not making same c=
hoice
> > in future.
> >
> > Now, what to do here? One way would be to apply a series, but add a
> > README.cip file explaining incompatible change (and any future stuff pe=
ople
> > need to know).
>=20
> OK. Either README.cip or " by including more information on the reference=
 hardware and test information on CIP wiki." as suggested by Nobuhiro.
> Please let us know, How do we want to proceed?
>

I guess we should really have README file in the tree, explaining
potential compatibility issues and anything unusual happening in the
tree. I went through old changelogs, and collected these for 4.19
tree:

* -cip3: MDS sampling vulnerability fixes

This release includes many CVE fixes including MDS (Microarchitectural
Data Sampling: CVE-2018-12130, CVE-2018-12126, CVE-2018-12127,
CVE-2019-11091). These fixes were more extensive and harder to review
than usual for -stable tree.

* -cip9: m57621-mmc driver was removed

m57621-mmc driver was removed due to uncertainty about its licensing.

* -cip34: Support for Renesas RZ/G2[MN] revision 4 board

In -cip34, support for revision 4 of the board was merged. After the
merge, r8a774a1-hihope-rzg2m*.dtb files are suitable for revision 4 of
the board; if you want to produce dtb files for revision 2 of the
board, append -rev2 to the file names.

---

Does that sound ok?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAl9Fh94ACgkQMOfwapXb+vJ7kgCaA0hw81QA4l350TvpfHdoMFvc
5JsAl22ZkfxQb/783ITuusqP8FirNiE=
=Dx+o
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--nhUbKU8rzXKLfTJ6zrQP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5251): https://lists.cip-project.org/g/cip-dev/message=
/5251
Mute This Topic: https://lists.cip-project.org/mt/76290781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nhUbKU8rzXKLfTJ6zrQP--
