Return-Path: <SRS0=b/Ic=CF=lists.cip-project.org=bounce+64572+5276+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18557C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:00:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C64822BED
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cdS11CDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C64822BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5276+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aKJSYY4521723xpvWXqLawIf; Thu, 27 Aug 2020 00:00:10 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13396.1598511608883267059
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 00:00:09 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 31CCA1C0BDF; Thu, 27 Aug 2020 09:00:04 +0200 (CEST)
Date: Thu, 27 Aug 2020 09:00:03 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Message-ID: <20200827070003.GA20517@amd>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
 <20200826214624.GB15974@amd>
 <TYBPR01MB53095251790B479E03B8D1F186550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB53095251790B479E03B8D1F186550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oRpU88mvhlbthk8cz7S7J5Wtx4520388AA=
Content-Type: multipart/mixed; boundary="CLWvkpJPYc5hwU9y1rP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598511610;
 bh=LiX2+dHxdOkDQKKWKeyNi0EoacJUGf1wponlB07Cum0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cdS11CDoVyxrfGuJmiMsgtVop13NNbedrOnBa/nPHoRwhTOkfQfqayND5Y1L0RbCMo3
 zujvTUCp6rmDZkRLt9hNKzuERTeNHpbrOt1xQXgTAvqLoCJq0dtjVjVon5ljZt0etxLhK
 zaXp/b47GV3h7cAqWLBlkTTStjuYCaz8aSs=

--CLWvkpJPYc5hwU9y1rP2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH 4.19.y-cip 00/10] Add support for
> > [H]SCIF/SDHI/I2C/RWDT/MSIOF
> >
> > Hi!
> >
> > > Add RZ/G2H SoC support for [H]SCIF/SDHI/I2C/RWDT/MSIOF on 4.19.y-cip
> > kernel.
> > >
> > > All the patches in this series are cherry-piced from ML, except [1]
> > > which is a new patch similar to the workdone for other similar SoC's
> >
> > Series looks good to me. (But gitlab testing does not seem to work, and=
 it
> > would be good to test it before applying).
>=20
> I am  not sure about the failure.  If it is related to testing on RZ/G2H =
board, then

No, it is definitely not related to your boards. Nothing ever
builds... it can't be your fault or fault of your board, but it just
prevents testing :-(.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9HWfMACgkQMOfwapXb+vL9NwCfcoNCcfCCEaGQ6Cw7JvIWy6Wy
JzgAnRFbLjH8KsRqqVXMkCKVpK7pvqMT
=Ij1L
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--

--CLWvkpJPYc5hwU9y1rP2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5276): https://lists.cip-project.org/g/cip-dev/message=
/5276
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CLWvkpJPYc5hwU9y1rP2--
