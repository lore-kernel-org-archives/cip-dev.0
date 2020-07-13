Return-Path: <SRS0=+l0k=AY=lists.cip-project.org=bounce+64572+4921+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E541C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 13 Jul 2020 07:50:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A3620702
	for <cip-dev@archiver.kernel.org>; Mon, 13 Jul 2020 07:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YSL3tpyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A3620702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4921+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LxgfYY4521723xsSx0YnOL95; Mon, 13 Jul 2020 00:50:36 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.14781.1594626634288557789
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2020 00:50:35 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E7EDE1C0BD5; Mon, 13 Jul 2020 09:50:27 +0200 (CEST)
Date: Mon, 13 Jul 2020 09:50:12 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] v4.19-rt status
Message-ID: <20200713075012.GA11207@duo.ucw.cz>
References: <20200702093244.GA12176@duo.ucw.cz>
 <20200709211033.GB9193@amd>
MIME-Version: 1.0
In-Reply-To: <20200709211033.GB9193@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cisWbcTnFYJrF46o8iVhARU0x4520388AA=
Content-Type: multipart/mixed; boundary="BoomcB79n9A6CAuOPuGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594626636;
 bh=kZvKulF91iic2qyStnOy4462euEIrggY/bJ6T4qm8JQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YSL3tpyWLWIC2U1k3mw9g9vfglVMUFIDgX/cnyNgql2FzjiBJZTHRO6bQ/vno3HK88d
 WKQ7pkhgW2EdCR31U+esJzo3xksg8ZUU7XMvdvIIk3DwR9sg0cDaaHqUa7V8qX58dyu3j
 2/aovaFoF69nPFbre/7inVn+c9g9ZPUUuPc=

--BoomcB79n9A6CAuOPuGH
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> > Newest 4.19-rt kernel is currently v4.19.127-rt54. That's not good
> > match for us, as -cip kernels are v4.19.128-cip28 and v4.19.130-cip29.
> >=20
> > I could do kernel based on v4.19.127-rt54 and v4.19.124-cip27, but I
> > believe it makes more sense to wait for newer v4.19-rt release.
>=20
> Still no new -rt release.
>=20
> In April, Tom Zanussi took over 4.19-rt releases:
>=20
> Apr 20 Linux 4.19.115-rt49
> Apr 28 Linux 4.19.115-rt50
> May 3  Linux 4.19.116-rt51
> May 4  Linux 4.19.120-rt52
> May 20 Linux 4.19.124-rt53
> Jun 7  Linux 4.19.127-rt54
> Jun 10 Linux 4.19.127-rt55
>=20
> Based on past releases, I'd expect new -rt release real soon
> now. Hmm. I guess easiest option is to just ask Tom ;-)... and I did
> that.

And Tom said he expects new release this Monday. With new -cip kernel
released, that should be good timing.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXwwSNAAKCRAw5/Bqldv6
8jQqAKCeMCKEsg3H6pu+mXgxueAsMHwDbgCgpOf4bmzuJoGLeKnh69JkQ0vTQTM=
=drz3
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--BoomcB79n9A6CAuOPuGH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4921): https://lists.cip-project.org/g/cip-dev/message=
/4921
Mute This Topic: https://lists.cip-project.org/mt/75254805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BoomcB79n9A6CAuOPuGH--
