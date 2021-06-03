Return-Path: <SRS0=6tIB=K5=lists.cip-project.org=bounce+64572+6491+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B3C47097
	for <cip-dev@archiver.kernel.org>; Thu,  3 Jun 2021 08:34:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75103613C9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Jun 2021 08:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75103613C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6491+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YGDAYY4521723xRSqZ6DoDEl; Thu, 03 Jun 2021 01:34:53 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.5103.1622709292669389547
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jun 2021 01:34:53 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 71D011C0B76; Thu,  3 Jun 2021 10:34:48 +0200 (CEST)
Date: Thu, 3 Jun 2021 10:34:49 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CVE entries added to our database this week
Message-ID: <20210603083448.GA19005@amd>
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
X-Gm-Message-State: tj4M9YnL4IVqdBQNEX0Cl0vbx4520388AA=
Content-Type: multipart/mixed; boundary="rw69cV0n4MZflJNefGvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622709293;
 bh=qoA1k2nrr12PM35OMCppsEjO3jZrZKEDua5Lw8crolM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=DK5l79M106v9kxSs6GMhhz6WGqWIKfiwSPeWR47KRTBSAo0sCW6gm4eOjCrouK1DqSg
 +Ara/FTxMsyuMHJfVrP+Ph82TSoxrlNnthlmv4nZqHYCCI+MYE9yIJIL2HWWEAoQ2dgho
 FAOk5cDffP3TFi8btu34GRCyl/27exmnIiM=

--rw69cV0n4MZflJNefGvZ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I tried to get a list of new CVE entries that are not yet in our
databases... and this is the result.

Many of the issues are pretty old, and I'm not sure how to search for
patches fixing each issue, so this may not be too useful.

Best regards,
								Pavel


* 2021-06-01

CVE-2005-3660 -- 0 -- DoS with memory consumed by file descriptors.
CVE-2007-3719 -- 0 -- DoS with process scheduler.
CVE-2008-2544 -- /proc is suprisingly rw
CVE-2008-4609 -- cross platform TCP DoS.
CVE-2010-4563 -- allows detection of tcpdump / sniffing
CVE-2010-5321 -- 1 -- old DoS in video4linux
CVE-2011-4917 -- "Minor info leak, unlikely to be fixed upstream"
CVE-2012-4542 -- 1 -- scsi SG IO ioctl allows surprising access
CVE-2015-2877 -- 0 -- samepage merging may break ASLR
CVE-2020-0347 -- 2 -- iptables bounds check
CVE-2020-26555 CVE-2020-26558 -- BR/EDR pin code pairing broken
CVE-2020-26556 CVE-2020-26557 CVE-2020-26559 CVE-2020-26560 -- bluetooth me=
sh
CVE-2021-22543 -- KVM memory not read only

CVE-2015-1350 -- 3 -- DoS allowing unpriviledged users to remove capabiliti=
es, sounds nasty?
CVE-2015-8952 -- DoS on ext2/4 + ceph + samba
CVE-2016-5728 -- 3 -- drivers/misc/mic/vop/vop_vringh.c in the MIC VOP=20
CVE-2018-9465 -- binder use after free (from 2018?)
CVE-2019-2025 -- binder use after free
CVE-2020-0435 -- Bad candidate number.


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmC4lCgACgkQMOfwapXb+vIllQCgjfiODRIaEtQDn3MdlthpvLap
TgcAoKAa8ogPYMvix9zrgGMc+LhckauK
=VbMi
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--rw69cV0n4MZflJNefGvZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6491): https://lists.cip-project.org/g/cip-dev/message=
/6491
Mute This Topic: https://lists.cip-project.org/mt/83279214/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rw69cV0n4MZflJNefGvZ--
