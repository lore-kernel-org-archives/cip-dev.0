Return-Path: <SRS0=4GqE=LV=lists.cip-project.org=bounce+64572+6586+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C5C48BC2
	for <cip-dev@archiver.kernel.org>; Sun, 27 Jun 2021 08:44:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0968161AC0
	for <cip-dev@archiver.kernel.org>; Sun, 27 Jun 2021 08:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0968161AC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6586+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MhOxYY4521723xcLRm7Ne5Wh; Sun, 27 Jun 2021 01:44:36 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.3084.1624783475451877439
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Jun 2021 01:44:36 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4C52F1C0B76; Sun, 27 Jun 2021 10:44:33 +0200 (CEST)
Date: Sun, 27 Jun 2021 10:44:32 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] New security issues
Message-ID: <20210627084432.GA26658@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JJPTvbXDLULUMolkecrgDFjKx4520388AA=
Content-Type: multipart/mixed; boundary="6wg2Y0MnJHX6DIGcVLLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624783476;
 bh=ct2PbeQrKen8VZ8RfJHtW5nIGu9sqhbrgt+kOWn5YaU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NJVXLQDoK84owooW2bDUx7C4prwXR+toOgDndC54c2Ju9UPD6+h5pr+Xc42L6UQAWnN
 yp4EdR5EULuQPr6UmLhO01CCSFl0mvDf93qyk3yz6MsoQ6e7RTOvp3E8E1jvIxsBitc/8
 zpEoE4CiqkDT/tRfzv2YgAZxx/m9mBwfoEo=

--6wg2Y0MnJHX6DIGcVLLr
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

My notes are below. On IRC, I wrongly assumed that "CAN BCM" refers to
some kind of driver. Unfortunately, it is generic code, and it is used
by some of our configs. This is in early stages, it is not even fixed
in Linus' tree at the moment AFAICS.

Best regards,
							Pavel

* 2021-06-23

CVE-2021-33624 -- speculative execution on BPF. Fun.

CVE-2021-3609 -- CAN BCM local priviledge
escalation. net/can/bcm.c. local to root. Fun!

CVE-2021-3612 -- drivers/input/joydev.c .

* 2021-06-24

CVE-2021-3600 -- More eBPF  issues. 4.19+, hopefully.

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNg6cAAKCRAw5/Bqldv6
8ulTAJ9Zp+mhpPkiwtv8AHfIXcefPBpnTACfQGFvWPfdNVLDR+Qc5Ko9fpFD1Do=
=Mydc
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

--6wg2Y0MnJHX6DIGcVLLr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6586): https://lists.cip-project.org/g/cip-dev/message=
/6586
Mute This Topic: https://lists.cip-project.org/mt/83820048/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6wg2Y0MnJHX6DIGcVLLr--
