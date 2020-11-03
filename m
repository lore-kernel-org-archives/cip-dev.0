Return-Path: <SRS0=5Hbb=EJ=lists.cip-project.org=bounce+64572+5712+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2629C2D0A3
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 09:22:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7047E223BF
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 09:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RjYcUsHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7047E223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5712+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gQjgYY4521723xBIbZB1iegh; Tue, 03 Nov 2020 01:22:30 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1746.1604395348821009308
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 01:22:29 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7F06F1C0B77; Tue,  3 Nov 2020 10:22:22 +0100 (CET)
Date: Tue, 3 Nov 2020 10:22:21 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add PCIe{EP}/SATA support
Message-ID: <20201103092221.GA19849@amd>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201102103119.GA6161@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201102103119.GA6161@duo.ucw.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: x3cjbnBxtJNydREboVxMTuHex4520388AA=
Content-Type: multipart/mixed; boundary="yuwy09WmyLqPF9BvhDQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604395350;
 bh=IOwCeGyhTTAwlQ8xPtnnt1NWKgfG9R3ep9EoeJ0RQOM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RjYcUsHDRe9X4KtAslE/dbOtcP23lVI++T/3j4FQk7Ng0yqvQSMsFOj5d+V3rm0U7ZY
 BB3xQy6nUCZhxOKxiePOZP2Bky9pwR3V5lGly13W0Shz2twBhkNHJE8PAFnuKC32pStwZ
 cc4yWM/cmeG/hzoX4Mi/nefMdXEPhU7NB2k=

--yuwy09WmyLqPF9BvhDQf
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds PCIe{EP}/SATA support to Renesas RZ/G2H.
> >=20
> > All the patches have been cherry-picked from mainline kernel
> > v5.10-rc2.
>=20
> Looks good and passes our tests. I can apply it if there are no other
> comments.

Thanks for the patches, applied and pushed out.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+hIU0ACgkQMOfwapXb+vIJeQCeMtvSnVYWitYzlCYt5hm4flAe
8cwAnjrsKteg10OUVbVTuMsUzrh3Yl1r
=xC9i
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

--yuwy09WmyLqPF9BvhDQf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5712): https://lists.cip-project.org/g/cip-dev/message=
/5712
Mute This Topic: https://lists.cip-project.org/mt/77977469/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--yuwy09WmyLqPF9BvhDQf--
