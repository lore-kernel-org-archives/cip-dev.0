Return-Path: <SRS0=hbXq=LP=lists.cip-project.org=bounce+64572+6566+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609C0C4743C
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:51:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ED561001
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED561001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6566+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tABfYY4521723xU71MRiZsyF; Mon, 21 Jun 2021 14:51:17 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.404.1624312275771799628
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 14:51:16 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1795B1C0B76; Mon, 21 Jun 2021 23:51:13 +0200 (CEST)
Date: Mon, 21 Jun 2021 23:51:12 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Michael Adler <michael.adler@siemens.com>
Subject: Re: [cip-dev] Failing -stable-rc tests
Message-ID: <20210621215112.GA554@duo.ucw.cz>
References: <20210621193629.GA22045@duo.ucw.cz>
 <OSZPR01MB6877C72DEA6B911F7DC43441B70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSZPR01MB6877C72DEA6B911F7DC43441B70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: llh2gSQKgCBCFU6O6HJIsDKix4520388AA=
Content-Type: multipart/mixed; boundary="HemGr104PtoTv8z9SnD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624312277;
 bh=N8SLG70r4iibo6R8/Ohw+39Bxtd6ecJGAfN1WiUh5eQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MKsxvbTP78xnNBhqoXLisqOClrpgeihlNLXA+om9P/3rFQzBxhq6aAaES68SUy7m2BH
 OSuWSeksvR2x9LkKemaMVTw2c72JDvJjwEE28uL2H2KmOaYVehSl1WI/pU+YMWBg1oSVc
 ROqTi6AdRFDf+uwixTftFiGsQeFp5yLGHMY=

--HemGr104PtoTv8z9SnD2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Pavel Machek <pavel@denx.de>
> > Sent: 21 June 2021 20:36
> >
> > Hi!
> >
> > This is one of the common failures:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /jobs/1364210937
>=20
> Thanks for sharing the details.
> We'll take a look.

I re-tried, and now I got this:

https://lava.ciplatform.org/scheduler/job/302528

I'll retry once more, I believe it will go way.

Best regards,
						Pavel
					=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNEJ0AAKCRAw5/Bqldv6
8jYAAJ0fqNrf1njwWsd0tXoVlnaCzhlfqgCfd+xzP3xoZ89Npv8o8TXB5G0skeI=
=ij9R
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--HemGr104PtoTv8z9SnD2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6566): https://lists.cip-project.org/g/cip-dev/message=
/6566
Mute This Topic: https://lists.cip-project.org/mt/83697468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HemGr104PtoTv8z9SnD2--
