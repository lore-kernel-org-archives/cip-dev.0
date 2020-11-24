Return-Path: <SRS0=Gm66=E6=lists.cip-project.org=bounce+64572+5837+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC5C6379D
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 09:28:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E622075A
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 09:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="krEui4lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E622075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5837+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qXa5YY4521723xbXw9FCPHge; Tue, 24 Nov 2020 01:28:01 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.49846.1606210080050857018
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 01:28:00 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C08AB1C0B78; Tue, 24 Nov 2020 10:27:53 +0100 (CET)
Date: Tue, 24 Nov 2020 10:27:50 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
Message-ID: <20201124092749.GA26484@amd>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123193739.GA5619@amd>
 <OSBPR01MB5048F8E3ED247EE8F532969EAAFC0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB5048F8E3ED247EE8F532969EAAFC0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nfVYSuAhVYpgnD0zm9JDK64xx4520388AA=
Content-Type: multipart/mixed; boundary="dpCJpkArfi9Ug85epI1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606210081;
 bh=0XFrYlOX8vpARXdwuWOOwL0vUlrRbLpaPjkburin4C8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=krEui4lohplSqwGb9abHEOOWyEFDVhydA2rPRuf8ss+9SxZTCt0cVPHBmmc2AOBkfxJ
 GGebc0LTd+0Qgpw9nj/shhynmrXy3WtE41utoXuYvzFVB0cdlfEwMgh57q56fQjiBd29n
 4Kuf6dCLvhe1BpXYzKSjLkJEGHnERxMnV04=

--dpCJpkArfi9Ug85epI1K
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +void rpcif_enable_rpm(struct rpcif *rpc)
> > > +{
> > > +	pm_runtime_enable(rpc->dev);
> > > +}
> > > +EXPORT_SYMBOL(rpcif_enable_rpm);
> > > +
> > > +void rpcif_disable_rpm(struct rpcif *rpc)
> > > +{
> > > +	pm_runtime_put_sync(rpc->dev);
> > > +}
> > > +EXPORT_SYMBOL(rpcif_disable_rpm);
> >=20
> > Should these go to header as static inlines?
> >=20
> Would be nice will make them inline and squash it in the current
> patch.

For this series, maybe squashing is not neccessary. It is pretty good
as-is.

> > > +static int wait_msg_xfer_end(struct rpcif *rpc)
> > > +{
> > > +	u32 sts;
> > > +
> > > +	return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
> > > +					sts & RPCIF_CMNSR_TEND, 0,
> > > +					USEC_PER_SEC);
> > > +}
> >=20
> > This can't be right. sts is used uninitialized here.
> >=20
> Third parameter in regmap_read_poll_timeout() is the variable in which va=
lue is read and the fourth parameter condition has to be tied with the thir=
d parameter (there are similar instance in the kernel).
>

Okay, that's some rather evil code. It should really be
REGMAP_READ_POLL_TIMEOUT, because it is macro with weird semantics.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+80hUACgkQMOfwapXb+vLybACguap866sxX3I9J3LKulntYK5d
QjYAniKWbs+n//5gL5BCCpkUfKJh2GhP
=8pNi
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

--dpCJpkArfi9Ug85epI1K
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5837): https://lists.cip-project.org/g/cip-dev/message=
/5837
Mute This Topic: https://lists.cip-project.org/mt/78451541/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dpCJpkArfi9Ug85epI1K--
