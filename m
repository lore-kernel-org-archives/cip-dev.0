Return-Path: <SRS0=PJDY=7L=lists.cip-project.org=bounce+64572+4654+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA0C433DF
	for <cip-dev@archiver.kernel.org>; Fri, 29 May 2020 07:57:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E3D207D4
	for <cip-dev@archiver.kernel.org>; Fri, 29 May 2020 07:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QJUJmFAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E3D207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4654+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7ObaYY4521723xcSkU1JC61Q; Fri, 29 May 2020 00:57:49 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.30297.1590739067919010591
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 May 2020 00:57:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BCE31C0388; Fri, 29 May 2020 09:57:44 +0200 (CEST)
Date: Fri, 29 May 2020 09:57:43 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.120-cip25-rt10
Message-ID: <20200529075743.GA1335@duo.ucw.cz>
References: <20200511150426.GA18173@duo.ucw.cz>
 <CA+TH9Vm8dN918_yu0reQCHzh7hu62F8SefD96tx5T_XrEy634g@mail.gmail.com>
 <94f92587-9b2e-1b1e-021b-348aa16e1463@siemens.com>
MIME-Version: 1.0
In-Reply-To: <94f92587-9b2e-1b1e-021b-348aa16e1463@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wWVfRC3lWVndE8bOzBMlHZ82x4520388AA=
Content-Type: multipart/mixed; boundary="BYXsQOMqJQUSeYzN44fo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590739069;
 bh=5NrtKccNt6komL3KFQJ1kqL8GpIeJhNo6DD5QTT7J3k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QJUJmFAP+U/1S9JDnpNd2I3T+rdKKLVELTUhX8tAu2TpiQQeC9vYm9Ipk0CF90XjD2s
 dVgCLYKeNbZ9uYkgGlTmAKdOJ7tA7e3weeRbJjhfuJZwLiesBlXuaO9uvCJ36HDVZZk3H
 jKg4OvCvqyDhWQkrzdyRSfVxw+eTw4TMFxI=

--BYXsQOMqJQUSeYzN44fo
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> v4.19.120-cip25-rt10 should be available at kernel.org. (-cip26 was
> >> not available when I started the -rt update, thus it is based on
> >> -cip25 patches forward ported to 4.19.120. There should not be big
> >> difference besides the version number.)
> >>
> >> Trees are available at
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/=
?h=3Dlinux-4.19.y-cip-rt
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/=
?h=3Dlinux-4.19.y-cip-rt-rebase
> >>
> >> And their content should be identical.
> >=20
> > Tag 4.19.120-cip25-rt10 doesn't seem to be there (only
> > v4.19.120-cip25-rt10-rebase)
>=20
> Pavel, please fix!

It should be fixed now. Sorry about the delay.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtDAdwAKCRAw5/Bqldv6
8o+IAKCr1V6feArIGxuAv210EpAjRKvGygCfXKtvEWqvmk0omSAUUz31p/Zicag=
=WziO
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--BYXsQOMqJQUSeYzN44fo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4654): https://lists.cip-project.org/g/cip-dev/message=
/4654
Mute This Topic: https://lists.cip-project.org/mt/74137657/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BYXsQOMqJQUSeYzN44fo--
