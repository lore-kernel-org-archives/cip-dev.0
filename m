Return-Path: <SRS0=XmDz=BJ=lists.cip-project.org=bounce+64572+5074+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072ABC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E0420809
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JlLorO47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E0420809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5074+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nO99YY4521723xNU4n0unIJw; Thu, 30 Jul 2020 02:47:38 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4911.1596102455868448802
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 02:47:36 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 37D041C0C0B; Thu, 30 Jul 2020 11:47:30 +0200 (CEST)
Date: Thu, 30 Jul 2020 11:47:29 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Message-ID: <20200730094729.GA683@duo.ucw.cz>
References: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WctxvLqGG3w5F16Mv3pkTPIOx4520388AA=
Content-Type: multipart/mixed; boundary="A8p1JLW5KLzlsH2Q14WF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596102458;
 bh=tHk9mzVtlLik13/RVN91Mmg5skfiALn0NVMc4MamTtE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JlLorO47Qy8rEHB0DQqMUuEp0rzYNWFqhY1pNsYxkCDQapfI6TJPLN4gjh2juM54Dd/
 Kj616nnnI8aWYMDMVidDAN4jDXa6hkMcZ1jHINQIDaoGNd8Dvq3y6mlYoxMTP+cQDyo4f
 sMy0A3N70LN8EXPowsDd/jgta2UssrEDeTs=

--A8p1JLW5KLzlsH2Q14WF
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Subject: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
> >=20
> > From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.co=
m>
> >=20
> > commit 99ae78f1fc3a73c88fe726c676ae963ce722bf20 upstream.
>=20
> There seems to be no issue with this patch, but we also need to update de=
fcofnig.
> If there is no other objection, I will apply this.
>

Patch looks good to me, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXyKXMQAKCRAw5/Bqldv6
8oYMAJ9TVH9jwIWCtody5+zEglqEdUvN7gCfRIsCCk4SMSSbja5vUH/uiCLjRbU=
=K4VH
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

--A8p1JLW5KLzlsH2Q14WF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5074): https://lists.cip-project.org/g/cip-dev/message=
/5074
Mute This Topic: https://lists.cip-project.org/mt/75862490/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--A8p1JLW5KLzlsH2Q14WF--
