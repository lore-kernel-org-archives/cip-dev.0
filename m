Return-Path: <SRS0=hW8H=GC=lists.cip-project.org=bounce+64572+5982+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38EBC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 12:45:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60809221FA
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 12:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60809221FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5982+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SCWxYY4521723xAZrPa0nmn4; Wed, 30 Dec 2020 04:45:34 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.6108.1609332333701840495
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Dec 2020 04:45:34 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D52D91C0B78; Wed, 30 Dec 2020 13:45:30 +0100 (CET)
Date: Wed, 30 Dec 2020 13:45:30 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>
Subject: Starting testing of 5.10-stable? was Re: [cip-dev] Testing of -stable-rc fails completely
Message-ID: <20201230124530.GA13161@duo.ucw.cz>
References: <20201229085357.GA17217@amd>
 <OSAPR01MB23857C22D82B59C59F0AD25BB7D80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB23857C22D82B59C59F0AD25BB7D80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: caZ2q9a5C3FQ0Tm3FegO5K0ox4520388AA=
Content-Type: multipart/mixed; boundary="fkJ0WM5K0trB1YC2uv3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609332334;
 bh=bQPhdgi+LVpmxzkmGdgDeHcISQpEb5BZoUg1gvkvgJk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jrbFvSjj2XwMgnVRZHYU10FPUmMS/Q4zoY34pPbwcD7rj+Q+Cvq3YckT04T4TdG4yNz
 vktK0+7w+brfjUB9YRMX75pUOdqgQVtliUqP2PHksFU0Ffv/w6l2i5Q8/t26jruzJrGUv
 Lmz8PtZSvYGMpoxQL9Q7UXb3AA/EpIvs5vY=

--fkJ0WM5K0trB1YC2uv3x
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 100Cloning linux-stable-rc
> > 101fatal: repository '.' does not exist
> > 102fatal: repository '.' does not exist
> > 103fatal: repository '.' does not exist
> > 106
> > Uploading artifacts...
> > 00:00
> > 107WARNING: output: no matching files
> >
> > Any ideas?
>=20
> Thank you for reporting.
> I had a typo in my latest change to the CI pipeline ?
> I've fixed this now and the latest builds are going through now.

Thank you!

Now... I believe we should start testing 5.10-stable trees, as we want
to maintain that tree "soon" it would be good to know how we are
doing...

I guess it will need some configs. I believe we could just take 4.19
configs for a start.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX+x2agAKCRAw5/Bqldv6
8tWSAJ4tx9hzKlbmEKrSspKvJ9GrXQXF3wCgr+QSUfW2ENLLWeYCJK7vcSHIHjo=
=8mHE
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

--fkJ0WM5K0trB1YC2uv3x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5982): https://lists.cip-project.org/g/cip-dev/message=
/5982
Mute This Topic: https://lists.cip-project.org/mt/79311303/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fkJ0WM5K0trB1YC2uv3x--
