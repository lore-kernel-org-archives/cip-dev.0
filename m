Return-Path: <SRS0=bs6v=KA=lists.cip-project.org=bounce+64572+6423+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22BC433B4
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:18:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A2661154
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A2661154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6423+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0A1xYY4521723xdvwON3esf6; Wed, 05 May 2021 01:18:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4949.1620202680658047532
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 01:18:01 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6F48F1C0B87; Wed,  5 May 2021 10:17:58 +0200 (CEST)
Date: Wed, 5 May 2021 10:17:57 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	masashi.kudo@cybertrust.co.jp
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-05-05
Message-ID: <20210505081757.GB29521@amd>
References: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
 <20210505075149.GA29521@amd>
 <CAGb2v64aHtMy_TxaKPHjyw6vEaTn+msY9De-T6s5Xo1hRdWtOg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v64aHtMy_TxaKPHjyw6vEaTn+msY9De-T6s5Xo1hRdWtOg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vWKjTFNGwq3JDtbS3H2tTktpx4520388AA=
Content-Type: multipart/mixed; boundary="SqxJ20B6s6kuf8rwy1zq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620202682;
 bh=24oxYGZFwVADzNOm9PuLciyIQpW8tXgiZvkIHGEnXNo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GByvWtFdy5kylM/Isx4EgjOmc+Jlx1UFMPctFtaW4fjZc/EoV9HOjBpNhJ7H3NLBrFl
 k7lsYh2lRlQF7RYYp8pVZ1NHCxc73IwkC1lPj1mqF6Y9TOyORto3M+/xuIqxliU02r5QE
 qfiCc1JzWWeEbiYz7NGSmesW+AHM8LoUhcg=

--SqxJ20B6s6kuf8rwy1zq
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Two new CVEs this week:
> > >
> > > - CVE-2021-31829 [bpf: stack pointer protection from speculative
> > > arithmetic] - fixed
> > >   Fixes just landed in mainline as part of the merge window. Fixes not
> > > tagged for stable.
> >
> > Could you push your changes to cip-kernel-sec?
>=20
> Done. Sorry about that.

Thank you!

> > These are queued for 5.10.35 and 4.19, I believe they may be related.
> >
> > v |8373088d4 b9b34d o: 5.10| bpf: Fix masking negation logic upon negat=
ive dst register
> > a |fbb1ea771 b9b34d o: 4.19| bpf: Fix masking negation logic upon negat=
ive dst register
> > a |024fb2412 801c60 o: 5.10| bpf: Fix leakage of uninitialized bpf stac=
k under speculation
>=20
> I only looked through my inbox. And our scripts don't pick things up
> from the stable-queue. In any case they will be picked up once the
> stable kernels including them are released.

According to https://ubuntu.com/security/CVE-2021-31829 it is those
two patches that fix it. So this should get resolved in 5.10.35 for
us.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCSVLUACgkQMOfwapXb+vKlrACgphH40dB+FeXXHFGLdZ1eukyo
Q+sAn37VZAg8OgAnsGrqN9hT/k8HgsE8
=/86l
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--SqxJ20B6s6kuf8rwy1zq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6423): https://lists.cip-project.org/g/cip-dev/message=
/6423
Mute This Topic: https://lists.cip-project.org/mt/82597445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SqxJ20B6s6kuf8rwy1zq--
