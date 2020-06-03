Return-Path: <SRS0=LpaQ=7Q=lists.cip-project.org=bounce+64572+4667+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2501C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:21:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2CA20738
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ICO9sr8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2CA20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4667+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SncWYY4521723xLH3QfMqDej; Wed, 03 Jun 2020 08:21:57 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.16191.1591197715616182116
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 08:21:56 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 319FE1C0BD2; Wed,  3 Jun 2020 17:21:52 +0200 (CEST)
Date: Wed, 3 Jun 2020 17:21:51 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: masashi.kudo@cybertrust.co.jp
Subject: Re: [cip-dev] FW: Needs of security patches on reference platforms
Message-ID: <20200603152151.GA16550@amd>
References: <TY2PR01MB497299162A4205C540691913A0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TY2PR01MB497220F7BDB51660FF9B221FA0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <e6529e13-4bb7-1105-9bc8-f84bc0b3132f@siemens.com>
MIME-Version: 1.0
In-Reply-To: <e6529e13-4bb7-1105-9bc8-f84bc0b3132f@siemens.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: m3dkneXy2OkSWbyb44GtH7eBx4520388AA=
Content-Type: multipart/mixed; boundary="bHRAPlsRxMo1uoj32MhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591197717;
 bh=WrCzrthO5E8AgwnWPg5S1m0jUFbiGRdBL7WyLRYglH0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ICO9sr8qm7wvwxwjrUpi+LZKQ/Ou83u/vH6Wp1lQ5Vw1t3a+g81ha4Yq/+VoC6iHVQE
 7ZJhRiii1UqOiutp6RPUBvtGANXfx5F/llZIlXHG42WXMyE7D+9FyLSAS0TVgVslP4abi
 VI2L9dx/TNYQzPn6pSGE8Qi8PRNJ+UcLb14=

--bHRAPlsRxMo1uoj32MhT
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > At the IRC meeting (May 14th), the following two security patches were =
discussed.=20
> >=20
> >  a. CVE related to KVM SVM on x86,
> >  b. XDP sockets enabled for Cyclone V
> >=20
> > They were recently ported to upstream, and we would like to decide whet=
her they should be backported to CIP or not.
>=20
> Why did not stable pick them up? Because they require active backporting
> work to make them apply?

Yes, IIRC.

> > Regarding a., SVM is for AMD CPUs only, so it might not actually be use=
d.
> > If it is the case, we would like to ignore this patch.
>=20
> In general, KVM on AMD was surely a niche over the past years. Since
> Ryzen, this changed again, also for embedded.
>=20
> That said, I'm not aware of active use on our side at this point, but I
> may not have the full overview, and I can't speak for other members.
>=20
> >=20
> > Regarding b., XDP (express data path) is used for network intensive wor=
kloads to bypass certain parts of the network stack So, it may be used by b=
ig tech / web stuff, not embedded.
>=20
> XDP plays an essential role in deterministic networking, thus is
> absolutely an embedded thing as well. But that usually goes along with
> TSN, though it may not be limited to it.

Ok, good to know.

So... there are few reasons why it is important to know what is in use
or not:

1) If we see patch in stable, how much effort should be spent
reviewing it?

2) If we see a bad bug (probably CVE) that needs a backport, should we
backport this one? (or wait for someone else to do the work?)

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7XwA8ACgkQMOfwapXb+vIa6wCffZvhx5DIDAQlENspvLkP+cZA
CccAnjk6Q8+wdfJXkVX3PgLZF/XHzB8Z
=QLTl
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--bHRAPlsRxMo1uoj32MhT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4667): https://lists.cip-project.org/g/cip-dev/message=
/4667
Mute This Topic: https://lists.cip-project.org/mt/74496040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bHRAPlsRxMo1uoj32MhT--
