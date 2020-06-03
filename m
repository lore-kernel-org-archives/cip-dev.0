Return-Path: <SRS0=7bx0=7Q=lists.cip-project.org=bounce+64572+4669+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37387C433DF
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:28:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE92207D8
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mkaKbqv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE92207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4669+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ah0tYY4521723xH1PRNkRh03; Wed, 03 Jun 2020 08:28:30 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16470.1591198108124938412
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 08:28:28 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 03AF71C0BD2; Wed,  3 Jun 2020 17:28:26 +0200 (CEST)
Date: Wed, 3 Jun 2020 17:28:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CVE-2020-10742 -- nfs client weirdness with max_rqst_size
Message-ID: <20200603152825.GA26103@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6xpf3eTM61kKewCkeO48fzSFx4520388AA=
Content-Type: multipart/mixed; boundary="QFbBWEKyHIRIQne9Gy75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591198110;
 bh=3DX4jklKssV8+aQ82BpohM7/KIHJEpFPYBhWmMyGF9s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mkaKbqv39sE9Efjwhc43it4rFwD5rtoekIdziz9gupAWOKpLWuUCoq7yBiB6hhFSNQa
 xj8yKRV9MrzZh17JWZd22h40jIYsDCephBfhlzHN7V6AjzP1vaVODxVsoqahrKmWWpNxB
 9Au9rBtgQtQFrNFrF2Z22f3k+ppEUVHRoiw=

--QFbBWEKyHIRIQne9Gy75
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I did a bit of research on CVE-2020-10742.

Unfortunately, RedHat is a bad player here, and bug reports are partly
hidden from public.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1824270

https://bugzilla.redhat.com/show_bug.cgi?id=3D1835127

The bug does not seem especially bad (it looks like it needs specific
configuration to trigger), and Salvatore Bonaccorso was not able to
trigger it in 4.19.118.

Original report is for 3.10 kernels, so that makes some sense.

I don't believe we need to do anything here.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7XwZkACgkQMOfwapXb+vK9XwCgntvzRGOVwTG4MjiojkZH+E1+
p34AoKV477aHzj095SuT4g2z/m2zdVCx
=HznC
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--QFbBWEKyHIRIQne9Gy75
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4669): https://lists.cip-project.org/g/cip-dev/message=
/4669
Mute This Topic: https://lists.cip-project.org/mt/74651769/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QFbBWEKyHIRIQne9Gy75--
