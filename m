Return-Path: <SRS0=Pnme=A4=lists.cip-project.org=bounce+64572+4937+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C31C433E2
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 21:02:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5F12074B
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 21:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VL6jQEEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5F12074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4937+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TnrwYY4521723xBNgapdPKVB; Fri, 17 Jul 2020 14:02:34 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2400.1595019752404133837
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2020 14:02:32 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E73711C0BD9; Fri, 17 Jul 2020 23:02:25 +0200 (CEST)
Date: Fri, 17 Jul 2020 23:02:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
Message-ID: <20200717210225.GA29248@amd>
References: <1594905847-54471-1-git-send-email-biju.das.jz@bp.renesas.com>
 <OSBPR01MB298306064FDC07010DDC9E2D927C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB298306064FDC07010DDC9E2D927C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: t3j3vZahZ2Gd0szCQPbxUOzkx4520388AA=
Content-Type: multipart/mixed; boundary="1LEfqsw1RNxlY9CBHNVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595019754;
 bh=EbCTNBw+jrhdfNzs/BW22v+/w1LtHT7AmtddnJLVddU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VL6jQEEZRbjYSlVk3BTMB571afgPjPwVHer5vXeUrbFNPYiOq7nJvi9uJuup2sTiNlf
 gVoaRsmrjOM/arvVa8UW+6Mc5iQzzOiLeWk3S2M1N2t1xf5gDb85hFGcZGgJ62Eowlw6M
 TlKy9W9Yq2Vt/nIZeBt2a/21MgqUmKa3t2k=

--1LEfqsw1RNxlY9CBHNVI
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
> >=20
> > commit 3dc4db3662366306e54ddcbda4804acb1258e4ba upstream.
> >=20
> > For SCIF and HSCIF interfaces the SCxSR register holds the status of
> > data that is to be read next from SCxRDR register, But where as for
> > SCIFA and SCIFB interfaces SCxSR register holds status of data that is
> > previously read from SCxRDR register.
> >=20
> > This patch makes sure the status register is read depending on the port
> > types so that errors are caught accordingly.
> >=20
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
> > Signed-off-by: Hao Bui <hao.bui.yg@renesas.com>
> > Signed-off-by: KAZUMI HARADA <kazumi.harada.rh@renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link: https://lore.kernel.org/r/1585333048-31828-1-git-send-email-kazuh=
iro.fujita.jg@renesas.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Looks good to me.
> I will merge if nothing else is mentioned.

It looks good to me, and it passed basic testing -- so I applied the
patch and am pushing it. (I hope you don't mind).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8SEeEACgkQMOfwapXb+vInrQCeMls3Ou1tYJJBypNCEBCtb8qb
DbUAoLOJpr6IxN7C3wcxu4HR5uLd5YCV
=5tN0
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--1LEfqsw1RNxlY9CBHNVI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4937): https://lists.cip-project.org/g/cip-dev/message=
/4937
Mute This Topic: https://lists.cip-project.org/mt/75541395/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--1LEfqsw1RNxlY9CBHNVI--
