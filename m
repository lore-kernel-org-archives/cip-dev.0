Return-Path: <SRS0=W4Ky=LQ=lists.cip-project.org=bounce+64572+6572+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E4C2B9F4
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:57:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD97361374
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 11:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD97361374
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6572+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id B5LOYY4521723xzuLtDmL44L; Tue, 22 Jun 2021 04:57:21 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7898.1624363039912746893
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jun 2021 04:57:20 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D8741C0B76; Tue, 22 Jun 2021 13:57:15 +0200 (CEST)
Date: Tue, 22 Jun 2021 13:57:15 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] Patches that need porting from 4.19 to 5.10-cip tree
Message-ID: <20210622115715.GA12826@duo.ucw.cz>
References: <20210602100440.GA27003@duo.ucw.cz>
 <OSZPR01MB6877A74A6479B7870A3211F0B7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSZPR01MB6877A74A6479B7870A3211F0B7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GVlqF8lMeZhuquuB3ZdhASpax4520388AA=
Content-Type: multipart/mixed; boundary="uwvaHvmherpc0TQKfaLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624363041;
 bh=MwLYTtG3IYQ28nCYMtTEtaObnY2C97m7aO2cIzZ+9gg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Z7PkJN6s3cNgb9HwyKEbqejAIKVoAM6Ih3risXIy+GVBB8t7jHyYoXFIOCECtOsINoa
 rkkdQBpVR3Pq5CsSzIscHm1y8Jtwo4V5ZRHFIHYy343dwwSO54N77yVlaER8jAanrqT/M
 yo7Pucswq6RvaYeBxG3USY00W7c5Da/uvkU=

--uwvaHvmherpc0TQKfaLn
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > *** gpg4o | HINT: Error while checking message with detached signature
> > (PGP/MIME signature)!
> > Couldn't locate the original MIME source of the mail to verify the sign=
ature!
> > gpg4oh32.dll:: func_IV Init OK ***
> >
> > Hi!
> >
> > Here is the list of patches that are in 4.19-cip but not yet in
> > 5.10... according to my scripting.
>=20
> Prabhakar has reviewed your list and has submitted all of the relevant pa=
tches in his "Renesas RZ/G2 sync patches from 4.19-cip to 5.10-cip" series =
[0].
>=20
> Attached is a spreadsheet that summarises his analysis.
> As you can see there are a lot of patches that are already present in v5.=
10, and some aren't needed.
> There are a few patches marked as "Don't care". This is from a Renesas/RZ=
/G point of view. They should probably still be looked into by someone in C=
IP.
>

Thanks for doing this, let me take a look.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNHQGgAKCRAw5/Bqldv6
8tLCAJ9gY9qQKmWjT2jfzkubba1q0/r93ACfdlw/LAe3On1hAIigl3K/56Q7arA=
=J+Gq
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

--uwvaHvmherpc0TQKfaLn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6572): https://lists.cip-project.org/g/cip-dev/message=
/6572
Mute This Topic: https://lists.cip-project.org/mt/83254843/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uwvaHvmherpc0TQKfaLn--
