Return-Path: <SRS0=O1SA=EN=lists.cip-project.org=bounce+64572+5764+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBE7C388F9
	for <cip-dev@archiver.kernel.org>; Sat,  7 Nov 2020 07:33:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016B420704
	for <cip-dev@archiver.kernel.org>; Sat,  7 Nov 2020 07:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wliFmQC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016B420704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5764+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Nb9FYY4521723xgtXpPGVdU9; Fri, 06 Nov 2020 23:33:11 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1193.1604734389824565179
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 23:33:10 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7B42C1C0BB0; Sat,  7 Nov 2020 08:33:04 +0100 (CET)
Date: Sat, 7 Nov 2020 08:33:03 +0100
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/8] Renesas RZ/G1H add PCIe, SATA and VSP support
Message-ID: <20201107073303.GA14654@amd>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SPO2CpbzwCMtZwydPs4zZV1ex4520388AA=
Content-Type: multipart/mixed; boundary="lPmb65WFcOPG9R0XIwrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604734391;
 bh=DmOO0fdgMk8I38cSC0lww8lvbbbEjCvIYNMZ4Qp3U30=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wliFmQC0fhLgjv3O/NCtbhmPrBbrbHtm/X1kWXbbMenXpZoe/Jfpkdr6i9qtgxyfGxh
 nupytTwfADmlEPHyX2jgJhlpMJlM/PBi5vjMNeXSn0lC3z57xZ0wWI9VGHGA7vRDQV6SE
 m9P/LYjS19tQN3WGqAbATgBu6400UcBh2NI=

--lPmb65WFcOPG9R0XIwrY
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for PCIe, SATA and VSP.
>=20
> All the patches have been cherry-picked from Linux v5.10-rc2.

I don't see any problems with the series, and it passed basic testing,
so I can apply it if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+mTa4ACgkQMOfwapXb+vLpbQCgxOMhPRuRIVpfXQBfHtrYE0mF
kfsAn1U/V/z3DIyH7+y+3NXY4z4lsrt3
=RATY
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--lPmb65WFcOPG9R0XIwrY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5764): https://lists.cip-project.org/g/cip-dev/message=
/5764
Mute This Topic: https://lists.cip-project.org/mt/78070979/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lPmb65WFcOPG9R0XIwrY--
