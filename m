Return-Path: <SRS0=X/20=CG=lists.cip-project.org=bounce+64572+5321+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C6C433E2
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:53:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255BA20738
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kqUgOzl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255BA20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5321+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XS5uYY4521723xgb0yL1iQLT; Fri, 28 Aug 2020 09:53:31 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.47506.1598633610095776490
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 09:53:30 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B52341C0B76; Fri, 28 Aug 2020 18:53:25 +0200 (CEST)
Date: Fri, 28 Aug 2020 18:53:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, iwamatsu@nigauri.org,
	Chris.Paterson2@renesas.com, quirin.gylstorff@siemens.com
Subject: Re: [cip-dev] Everything failed in gitlab
Message-ID: <20200828165324.GA9883@amd>
References: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
 <20200827082132.ca3vmztk43723bas@kratos.fritz.box>
 <20200827131025.GA28744@duo.ucw.cz>
 <CABMQnVLyjmJSEBce_oJSgSTGU5muMEyy3iwhikjuAS=DT3o3Hw@mail.gmail.com>
 <5e5a71ba-fbb0-99b0-126a-b11d51608309@siemens.com>
 <OSBPR01MB29838DB1D31267F8BBC0A91392520@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <d985a86c-97fb-f1c2-9b91-2bfba8185cd5@siemens.com>
MIME-Version: 1.0
In-Reply-To: <d985a86c-97fb-f1c2-9b91-2bfba8185cd5@siemens.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ICOmt18bY3LwDtdimSMuT4Xjx4520388AA=
Content-Type: multipart/mixed; boundary="z82acDE6Ss4z3maRtJCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598633611;
 bh=H11RjqVa7Cg5i6jVpIJkaiWCwgeBVHv/3j2Q9yTezCA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kqUgOzl+uQSplqgksezv7P+uhiM3MuemLF1T0cvUgtw60Kd3egvlXLtrv1QNwD1qJae
 ZmedrOD1Phb0k+dcfEEjwIAJAx7/FCbSzgYMOUJ6ryj9WBnlGSaPmFftpmQURxbyprt3I
 jUrQzgYEtP1WPCm2wSiH10RdySTefDeDmoE=

--z82acDE6Ss4z3maRtJCP
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> This is happening not only in cip-testing (kernel test) but also in
> >>> cip-core[0][1].
> >>> I don't manage these runners. Has anyone changed permissions etc?
> >>
> >> I do. Just restarted a build
> >> (https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/70799173=
8), and
> >> it is apparently working.
> >>
> >> Is there in issue with who is triggering the build and what permission
> >> that person has? Just restarted [0], and that also works:
> >>
> >> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/707992917
> >=20
> > Gitlab runner is now working on all repositories.
> > Thanks!

> ...but I didn't change anything for that. I guess is was a temporal hick-=
up.

I can confirm that builds now work. Thanks to whoever (or whatever)
fixed it :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9JNoQACgkQMOfwapXb+vLJEACgrLyhl4OSJn0vMiosJKw88Fel
sXgAn14d97yeQ47dKQHe9jLKhCg0mgG1
=YeGE
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

--z82acDE6Ss4z3maRtJCP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5321): https://lists.cip-project.org/g/cip-dev/message=
/5321
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--z82acDE6Ss4z3maRtJCP--
