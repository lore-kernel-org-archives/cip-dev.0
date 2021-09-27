Return-Path: <SRS0=3z+2=OR=lists.cip-project.org=bounce+64572+6751+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01808C433FE
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 10:09:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F9860FF2
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 10:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27F9860FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id O6hpYY4521723xrW7TpQr496; Mon, 27 Sep 2021 03:09:57 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.29149.1632737396304878607
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 03:09:57 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 387531C0B7C; Mon, 27 Sep 2021 12:09:51 +0200 (CEST)
Date: Mon, 27 Sep 2021 12:09:50 +0200
From: "Pavel Machek" <pavel@denx.de>
To: uli@fpond.eu, cip-dev@lists.cip-project.org
Subject: [cip-dev] Coordinating stable reviews
Message-ID: <20210927100950.GA11971@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NhAkYGTH1R62ozVjOgEcOcNxx4520388AA=
Content-Type: multipart/mixed; boundary="RgUKMIRYrLLW3X7afk5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632737397;
 bh=GsT3bqPIp/BBbtMSE0qAEAXoIlmupJUMv8xtN0uasUc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PuGPLdoxPDhc0kzeVIhbSODO9xb/j9KazVNUT/XemGVEd+RvCrIMi0FevchmnJLTRwB
 ABuEs06kfcLA9vqnS5fQXnNDSgUDUz20maH5hVY96PnsJAeEADk3qqJGu4S53645EjTa+
 tUDBV0gHH24C0p02/7U/I99vNLhOEzqPOIs=
Message-ID: <20210927100950.XADjhsAymfeV3gfxkSNzvNuzpKm3KIHeJZN_XIveD5Q@z>

--RgUKMIRYrLLW3X7afk5Q
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It is good to review "stable" patches soon, because such reviews are
more useful for the stable community, and because when bug is spotted,
it is easier to get patch dropped in the 5.10.X-rc phase than waiting
for 5.10.X release and then having patch reverted in 5.10.X+1.

Unfortunately, we don't have good system for coordinating reviews in
-rc phase.

There's a script (commit.py) that produces one-line-per-patch output
suitable for review. One possibility would be to have shared place
somewhere reviewers could tag "I'm working on these patches".

I don't believe lts-commit-list.git repository is suitable for that;
format suitable for review is different from what we have in
lts-commit-list, and there is going to be multiple updates per day in
busy periods.

We don't really need commit messages for this. Actually, we don't
really need to keep history, either. It would be good if system could
be controlled from command line for easy scripting.

Any ideas what kind of service could be used for this?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFRmG0ACgkQMOfwapXb+vJRbwCfY3b+ezSJoL6txCpH+CdShXGw
OVwAoIbvMlYcW+K3mc0eh8OCr98KYhys
=WsMM
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--RgUKMIRYrLLW3X7afk5Q
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6751): https://lists.cip-project.org/g/cip-dev/message/=
6751
Mute This Topic: https://lists.cip-project.org/mt/85896746/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RgUKMIRYrLLW3X7afk5Q--
