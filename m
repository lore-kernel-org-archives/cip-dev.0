Return-Path: <SRS0=3sve=HU=lists.cip-project.org=bounce+64572+6186+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B4DC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB9C64E92
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB9C64E92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6186+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fCfLYY4521723xClq81Ql2Jg; Thu, 18 Feb 2021 10:35:02 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.894.1613673301707187428
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Feb 2021 10:35:02 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2AD571C0B96; Thu, 18 Feb 2021 19:34:56 +0100 (CET)
Date: Thu, 18 Feb 2021 19:34:55 +0100
From: "Pavel Machek" <pavel@denx.de>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-18
Message-ID: <20210218183455.GA22234@duo.ucw.cz>
References: <CAGb2v67v7o16fV4s7GTgO96P5=g3icjNUNGNs0mDdcm2BZYm=w@mail.gmail.com>
 <20210218094923.GA28023@amd>
 <CAGb2v66RODCVTdiway7SiNVQHDcgFiVHH0XYJmktQSa+_hdFnQ@mail.gmail.com>
 <d5665f714ddfbe257446b9bc3d6dcda18e86f67d.camel@siemens.com>
MIME-Version: 1.0
In-Reply-To: <d5665f714ddfbe257446b9bc3d6dcda18e86f67d.camel@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0v0QSY9RILY9ulxx0b60UOTAx4520388AA=
Content-Type: multipart/mixed; boundary="N6uo3P6ybXHMQaAk8Hdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613673302;
 bh=bPu72XCMrsqCw7+t/xmBTVEngLECMpqq2I/j7YsV7Go=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GWOY9CSXPKbVEGLc7ovHynu4+KIclDef2IIB/sx67Hw6LPkckZ1jlfluMm97g1li2aZ
 EnF9bpM2dm2/TEvIIx2WF2azt6lJdVRb74P5YSwTM19pAq01HNGPN6yBan0vQaVZEW4Ur
 3DwQwBImnthqf7x3QgtnRlL46IRO1k9UIi8=

--N6uo3P6ybXHMQaAk8Hdh
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Linus doesn't seem to be processing PRs for the new merge window ye=
t,
> > > > so we might have to wait a while before the Xen ones are fixed and
> > > > backported.
> > >=20
> > > Well, Xen is not a typical thing to run on embbeded hardware, but I
> > > did not check the configs.
> >=20
> > I see Renesas and Siemens have it enabled. Is Xen still relevant?
> > Or has everyone switched over to KVM + QEMU?
>=20
> Where is the mentioned kernel config located? I wasn't able to find the
> correct git tree.=20
>=20
> We already had a short internal discussion and are quite sure that we
> don't need it. Just point me to the configuration. We will review again
> and come up with the necessary patch to disable it.

It should be in

https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/tree/master/

One example is:

https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/4=
=2E19.y-cip/x86/siemens_iot2000.config

If there are other options that can be disabled (maybe you don't need
CONFIG_UNIXWARE_DISKLABEL=3Dy), that would be good to know, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYC6zTwAKCRAw5/Bqldv6
8lWoAKCPFPk3vTsQmu1zsLTKXaLheotpewCgpFbVeijOhvoXNkbPlYrP7secbU4=
=mdtd
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--N6uo3P6ybXHMQaAk8Hdh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6186): https://lists.cip-project.org/g/cip-dev/message=
/6186
Mute This Topic: https://lists.cip-project.org/mt/80725760/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--N6uo3P6ybXHMQaAk8Hdh--
