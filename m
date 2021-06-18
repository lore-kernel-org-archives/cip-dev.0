Return-Path: <SRS0=TYsr=LM=lists.cip-project.org=bounce+64572+6535+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB150C48BDF
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 08:04:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173C961351
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 08:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173C961351
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6535+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 43nhYY4521723x6PyMtBdiyC; Fri, 18 Jun 2021 01:04:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5025.1624003441996386932
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 01:04:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7F64F1C0B76; Fri, 18 Jun 2021 10:04:00 +0200 (CEST)
Date: Fri, 18 Jun 2021 10:03:59 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] New CVE entries this week
Message-ID: <20210618080359.GB25229@amd>
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
X-Gm-Message-State: ZwiaHtT06n61sRJTYca5inPrx4520388AA=
Content-Type: multipart/mixed; boundary="6XtnZ7n3AUdS7Wpn4xPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624003442;
 bh=QpqmKegi6DjvlE6gp9EKEPmlF/6Ja1wye/zQV/js5b4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rTkC2lK3UlWFuuEz4EJresszs308ZOr/DiTSBI7ui/KZpLMJtdZ3cuszEd9OD/2Jvz9
 ExRpKW0FEBeOIKFtsOO2Fe3INNzR3/y711Rw5SFAcVrfFgEGSVkpNArFNPFhOWS2HP3IG
 dK6SX8wOSBHta0r4FL1CEkuqi9SoIhKfNok=

--6XtnZ7n3AUdS7Wpn4xPU
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In last import, CVE-2020-36385 and CVE-2020-36386 was confused. That's
fixed now. And we have following new issues:

* 2021-06-13

CVE-2021-0129 -- Passkey Entry protocol of the Bluetooth Core is
vulnerable to an impersonation, fixed 4.9+

CVE-2021-0512 -- HID arrays, fixed 4.9+

CVE-2021-28691 -- Xen, fixed 5.10+

CVE-2021-3573 -- Bluetooth UAF, fixed 4.9+

* 2021-06-18

CVE-2021-32078 -- ARM: footbridge:, hopefully noone uses this

CVE-2021-34693 -- can: bcm: fix infoleak in struct bcm_msg_head

CVE-2020-36386 -- An issue was discovered in the Linux kernel before
5.8.1. net/bluetooth/hci_event.c has a slab out-of-bounds read in
hci_extended_inquiry_result_evt, aka CID-51c19bf3d5cf.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDMU28ACgkQMOfwapXb+vLROwCfXNjKVQIuSsJACJ6qjibeRJxq
5gMAoLTZa+gMbsw4F6Fifv0bjYKEIRR0
=GOHZ
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

--6XtnZ7n3AUdS7Wpn4xPU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6535): https://lists.cip-project.org/g/cip-dev/message=
/6535
Mute This Topic: https://lists.cip-project.org/mt/83449660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6XtnZ7n3AUdS7Wpn4xPU--
