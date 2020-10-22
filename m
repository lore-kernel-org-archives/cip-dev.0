Return-Path: <SRS0=4G2m=D5=lists.cip-project.org=bounce+64572+5656+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA3C4363A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 18:24:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904A724640
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="F4rPMfTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904A724640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5656+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZMbSYY4521723xCsJKgAMsCH; Thu, 22 Oct 2020 11:24:07 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.999.1603391046312176778
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 11:24:07 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3F4F91C0B87; Thu, 22 Oct 2020 20:23:59 +0200 (CEST)
Date: Thu, 22 Oct 2020 20:23:58 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 41/50] PCI: rcar: Add endpoint mode support
Message-ID: <20201022182358.GA9140@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-42-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014092226.GA1866@amd>
 <OSBPR01MB5048542ADFEDC0D29EE57D8CAA020@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <20201015180115.GA14732@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201015180115.GA14732@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sC6WJ95lprMre2MPSLFNZF1jx4520388AA=
Content-Type: multipart/mixed; boundary="3IcXGM9yLEZIDmMTengC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603391047;
 bh=Mged8u9mDHiugIpVjZpr2Cy6JG1cph8RuJ3K+mn3k4o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=F4rPMfTtzUavmNsKxQpLcfGw/xK34lZCBIpdr9uKWS1KKn5YdVjVrFS4duH8GOkR1DF
 HNDGMsM/9a8ByacyyW7bx1FlYjMJ7+xbMI2U49iyuDzTe7hS+M/n3m7LNSnTMrN83RxVL
 mcylqVmGAFHmx0j8+2T+pQ5V36C6M8PlJBA=

--3IcXGM9yLEZIDmMTengC
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-10-15 20:01:15, Pavel Machek wrote:
> Hi!
>=20
> > > Plain 0 would be enough
> > >
> > Agreed.
> >=20
> > Ill post patches upstream to fix this and then backport or do you
> >want me to do the changes in place ?
>=20
> Yes, thank you.

I mean "fix it upstream first" is good strategy here. This is just
cosmetics. You don't even have to backport it.. just fix it upstream.


Best regards,
								Pavel


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5HOPgAKCRAw5/Bqldv6
8rdTAKCy3b4vhv7O9ctGWxnp/QYp9fMh3wCfUWwBzkgi7WFJMEwJYVUG/+AWLDI=
=VbFW
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--3IcXGM9yLEZIDmMTengC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5656): https://lists.cip-project.org/g/cip-dev/message=
/5656
Mute This Topic: https://lists.cip-project.org/mt/77461723/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3IcXGM9yLEZIDmMTengC--
