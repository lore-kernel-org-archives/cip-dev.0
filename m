Return-Path: <SRS0=CLZC=DL=lists.cip-project.org=bounce+64572+5498+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515DEC4363C
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 21:39:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDA2206DD
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 21:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QXvl/jtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDA2206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5498+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MTPMYY4521723xfgDxDPkkCf; Sun, 04 Oct 2020 14:39:12 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.20667.1601847550974890396
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Oct 2020 14:39:11 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 440AF1C0B76; Sun,  4 Oct 2020 23:39:06 +0200 (CEST)
Date: Sun, 4 Oct 2020 23:39:05 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"SZ.Lin@moxa.com" <SZ.Lin@moxa.com>,
	"ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Message-ID: <20201004213905.GA8065@duo.ucw.cz>
References: <20201004090653.GA18130@amd>
 <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Fa3IC1vUKirSRA9Ffr9gJsCpx4520388AA=
Content-Type: multipart/mixed; boundary="5CNtKjxsh4dsfJOCGfGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601847552;
 bh=7YToYN/3oIR4Ig6RJ6Mp3uW6v+/e8FoACgd3Hutta7M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QXvl/jtM6f9stP/4cWxHWhmzN+PWfIC9trPjiW80rK+b9850mZmFbOpnKwIDjS5d1JS
 WNL0NCyRsB16UmygOGCNkg4ctSjhA8QrkytEG85Hx3rMCZUMiGhNE0LeM+oTUw+EfHmqj
 wAERHGycdbJvDxO98yY+NpOFpcPsnau7vH8=

--5CNtKjxsh4dsfJOCGfGf
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New realtime trees should be available at kernel.org.
> >
> > Trees are available at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/log/?h=3Dlinux-4.19.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/log/?h=3Dlinux-4.19.y-cip-rt-rebase
> >
> > And their content should be identical.
>=20
> Thank you for the release.
>=20
> >
> > This patch merges 4.19.148-stable into -cip-rt (because that's what
> > recent -rt is based on, and older -rt tree is too old). Unfortunately,
> > that brings regression with ethernet on Renesas Arm64 targets, which
> > will prevent boot, and fail tests etc.
> >
> > Kernel that should work ok on Renesas Arm64 machines can be obtained
> > by reverting fb3a780e7a76cf8efb055f8322ec039923cee41f "ravb: Fixed to
> > be able to unload modules" on top of -cip-rt release.
>=20
> So we're releasing a Kernel that we know doesn't boot on one of CIP's ref=
erence platforms?
> Or did you already revert the above patch as part of your release?

Yes, I did that, as the changelog explains. Sorry.

I had to select from few bad options: 4.19.147-rt release is not
available and previous release is too old. So -cip-rt is based on
4.19.148-rt, and it brings in the bad commit.

I thought about reverting it for release, but all I'd get would be
rejects, as it really needs to be solved in -cip, not -cip-rt.

Proper solution is likely updating 4.19-cip to 4.19.148, first.  Then
figuring out what is the clean way to solve the problem, and then
creating new -rt release. But that will likely take more than few
days, and it will end up with different release number.

I can create new -cip-rt release when that is done.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX3pA+QAKCRAw5/Bqldv6
8nSSAJ4r860kZMqilLJirBQg6nFaN8tiDACgorgvNn8JdWbkjBUnlV8+a7prf94=
=sYpx
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

--5CNtKjxsh4dsfJOCGfGf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5498): https://lists.cip-project.org/g/cip-dev/message=
/5498
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5CNtKjxsh4dsfJOCGfGf--
