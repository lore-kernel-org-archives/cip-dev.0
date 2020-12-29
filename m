Return-Path: <SRS0=FPDx=GB=lists.cip-project.org=bounce+64572+5978+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F313EC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 29 Dec 2020 08:54:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E9E207CF
	for <cip-dev@archiver.kernel.org>; Tue, 29 Dec 2020 08:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E9E207CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5978+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2f5cYY4521723xZK0EVHDqEu; Tue, 29 Dec 2020 00:54:04 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.9708.1609232043752450031
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Dec 2020 00:54:04 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B46B51C0B78; Tue, 29 Dec 2020 09:53:58 +0100 (CET)
Date: Tue, 29 Dec 2020 09:53:58 +0100
From: "Pavel Machek" <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] Testing of -stable-rc fails completely
Message-ID: <20201229085357.GA17217@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gdfShODCP6nQpFT9WXAHwBxYx4520388AA=
Content-Type: multipart/mixed; boundary="nxh7T5UW2EltI9VFcloL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609232044;
 bh=LdmK67ed4CEVMidFdxzzylPiGx/cQhbym8Ggpxax4aY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EqRRKZgfZgJogjrsMwsrTYt69trbDrmwNCGXQvoku0dnVWHqFQGn2KEngZD/YMwxZb+
 6+VWJpMLto/DmOdf6zhVuie9ppiEu4iSIM5GYyEllpmZixKca09NBWCfW+ndvsoIAQ4a7
 u0bNivwitmYeIrvuyUBuTqEiLkcgeEUJa2w=

--nxh7T5UW2EltI9VFcloL
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It seems -stable-rc tests are now failing completely in "cloning
repository" phase:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/934209=
886

Skipping Git submodules setup
99
$ echo "Cloning linux-stable-rc" # collapsed multi-line command
00:30
100Cloning linux-stable-rc
101fatal: repository '.' does not exist
102fatal: repository '.' does not exist
103fatal: repository '.' does not exist
106
Uploading artifacts...
00:00
107WARNING: output: no matching files

Any ideas?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/q7qUACgkQMOfwapXb+vKTIgCfUo6hFXUzcDOqTNqvrH4bIjWE
r3UAoIxz6MsnLFcmJvidsAs2R7vNSs3l
=zRul
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--nxh7T5UW2EltI9VFcloL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5978): https://lists.cip-project.org/g/cip-dev/message=
/5978
Mute This Topic: https://lists.cip-project.org/mt/79287435/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nxh7T5UW2EltI9VFcloL--
