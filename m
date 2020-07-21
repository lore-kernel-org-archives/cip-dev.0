Return-Path: <SRS0=FpoB=BA=lists.cip-project.org=bounce+64572+4951+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF13C433E3
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 13:42:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C6920709
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 13:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="InfPTCZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C6920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4951+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1YjuYY4521723xuFOa4Bd479; Tue, 21 Jul 2020 06:42:46 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.19138.1595338964203215758
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 06:42:45 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ADEB51C0BE5; Tue, 21 Jul 2020 15:42:38 +0200 (CEST)
Date: Tue, 21 Jul 2020 15:42:37 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional support for Renesas platforms
Message-ID: <20200721134237.GA11801@amd>
References: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
 <1595267543-32854-2-git-send-email-biju.das.jz@bp.renesas.com>
 <20200720210008.GB9879@amd>
 <OSBPR01MB2983171CA949DF2DA8967BED92780@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983171CA949DF2DA8967BED92780@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LT6YlVt6NwPs9sZJdyfTJgjDx4520388AA=
Content-Type: multipart/mixed; boundary="ijbVgrIf5po9inbvHK3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595338966;
 bh=9jhe0CTM5TohxY+V1/jb35i+x9aG9LuWJHDtFz3hsuo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=InfPTCZT2tNLTaT5Uy0HuioA4xKyxamQqkooKqxxJgtrCFxkJdW5zM52oMYqADzMani
 7KDdLyWjEStJh7xCmWX08nvFyGPMg7UiE3BnPQ27ciWZGLgtARd/3TqCJmfkO7/kBnqMW
 X+09vxAII3sShKYlw+PODcdII4dzTJITX84=

--ijbVgrIf5po9inbvHK3P
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On Mon 2020-07-20 18:52:23, Biju Das wrote:
> > > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > commit bf9e333ec0d54f7428d9192ad403c3cb523584c7 upstream
> > >
> > > Increase build and test coverage by enabling support for more hardware
> > > present on Renesas SoCs and boards:
> > >   - R-Car CAN and CAN-FD controllers,
> >=20
> > Ok, I can apply this if there are no comments.
>=20
> Both patches seem to be okay to me.
> I will push to repository if there is no problem in our test.

I see it is already pushed, thank you!

Biju, the first patch seems like a bugfix suitable for -stable. Can
you send it to Greg (etc) for inclusion?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8W8M0ACgkQMOfwapXb+vIgCwCgsWAumgdZAhKQfMHu5lE1ERPS
Y18AoI+MPblq99h0WMmbWKDI8RI+sm1s
=vn2m
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--ijbVgrIf5po9inbvHK3P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4951): https://lists.cip-project.org/g/cip-dev/message=
/4951
Mute This Topic: https://lists.cip-project.org/mt/75687531/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ijbVgrIf5po9inbvHK3P--
