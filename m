Return-Path: <SRS0=akmg=B5=lists.cip-project.org=bounce+64572+5154+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBC1C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 17:39:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBC2207DA
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 17:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RlCeGYu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBC2207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5154+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id U72SYY4521723xweGzfNfBtL; Wed, 19 Aug 2020 10:39:05 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.93734.1597858743333680109
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 10:39:04 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 09A611C0BBB; Wed, 19 Aug 2020 19:38:58 +0200 (CEST)
Date: Wed, 19 Aug 2020 19:38:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/12] Support RZ/G2[MN] rev4 board
Message-ID: <20200819173857.GA5567@amd>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YpYpbXY9aIrUn7cazxERwAN1x4520388AA=
Content-Type: multipart/mixed; boundary="ASkUOY4uWparYzXNxw5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597858745;
 bh=N2DCHHb1vnGGXcF4XAaoQB+27sb/v1Lcd3C690XhxWM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RlCeGYu9CLbRw6gxZiDfDm8F0/41980zk8IJfDolhFqnn2uj4Xt9grugFVPfMm2+DnF
 F3ZmltBLp7Nk2e0kcRKTTUxjXSxHFzG0hdy3IzHP/GaQAO6M8cYlr4KJ+K9IPpGvwgyuG
 IUZtkeCDP/IX16PF2gqnCwPRDy/eb2AL0hg=

--ASkUOY4uWparYzXNxw5u
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series for supporting RZ/G2[MN] rev4 board to cip-4.19.y
> kernel.

>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 11 -----------
>  1 file changed, 11 deletions(-)

I'm pretty sure this is not the real diffstat.

Let me go through the changes. One concern: you are renaming dts
files. New names make a lot of sense, but that will likely break the
users, including our test infrastructure, no?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl89Y7EACgkQMOfwapXb+vL5PQCfQL4fI/HEu8OFY4UCkmnl50qP
OG4Amwbs8NHju1B2sVZFz0vhoEhh6c7x
=iYpp
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

--ASkUOY4uWparYzXNxw5u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5154): https://lists.cip-project.org/g/cip-dev/message=
/5154
Mute This Topic: https://lists.cip-project.org/mt/76290780/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ASkUOY4uWparYzXNxw5u--
