Return-Path: <SRS0=O0Ee=BC=lists.cip-project.org=bounce+64572+4982+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F34C433E3
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 07:33:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883F122CB1
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 07:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dTvOXPGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883F122CB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4982+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xPHlYY4521723xX0Q8oeRQo0; Thu, 23 Jul 2020 00:33:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7424.1595489579504181164
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2020 00:33:00 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3E44B1C0BF0; Thu, 23 Jul 2020 09:32:55 +0200 (CEST)
Date: Thu, 23 Jul 2020 09:32:54 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20200723073254.GA23250@amd>
References: <TY2PR01MB49725D13A78694E61A9E03B7A0760@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49725D13A78694E61A9E03B7A0760@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QlUJcZRQ93wM5VcJfxvNJGk9x4520388AA=
Content-Type: multipart/mixed; boundary="4riSE7Rg7hEu8DcFOzrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595489582;
 bh=hDnjdkxF1iSR25MiMaVmLdkHgyO2nfNRkcB8eFYd2oU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dTvOXPGz3dDa6Ry83TCk4lnIgEi7HdbcQqJtK6VaKMhgihZa6MzO2UeOpFg/7kEAUM0
 XW6RSF06GKK9XP6jZQNiq8ZfF8rYeNa1+hUg2DIUtxWKX8V0BQvPGofM1i9NcMe0YX9v0
 16YQ/PfVdl3epzNc47M9oGQMxZPWYhcl4vk=

--4riSE7Rg7hEu8DcFOzrL
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
> I cannot attend the meeting today. Chris-san will host the meeting instea=
d.
>

I should be able to attend the meeting, but in case reality
interferes:

I have reviewed patches for 4.19.134.

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

iEYEARECAAYFAl8ZPSYACgkQMOfwapXb+vKBBgCdFRzQxcy4fBVcBvXsyb2wb7xv
5I0AoJ9mjToLbJ6QDTdtcq27G/FEXbGn
=jOaV
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

--4riSE7Rg7hEu8DcFOzrL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4982): https://lists.cip-project.org/g/cip-dev/message=
/4982
Mute This Topic: https://lists.cip-project.org/mt/75739176/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4riSE7Rg7hEu8DcFOzrL--
