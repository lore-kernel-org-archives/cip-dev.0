Return-Path: <SRS0=pIue=LE=lists.cip-project.org=bounce+64572+6501+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A9C47094
	for <cip-dev@archiver.kernel.org>; Thu, 10 Jun 2021 17:05:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A093613DD
	for <cip-dev@archiver.kernel.org>; Thu, 10 Jun 2021 17:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A093613DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6501+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p7umYY4521723xczxeSHtRbt; Thu, 10 Jun 2021 10:05:44 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.1382.1623344742607321798
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Jun 2021 10:05:43 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 21DC31C0B77; Thu, 10 Jun 2021 19:05:39 +0200 (CEST)
Date: Thu, 10 Jun 2021 19:05:38 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] New CVE entries this week
Message-ID: <20210610170538.GA12973@amd>
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
X-Gm-Message-State: ptBQgkjXbgwprsJAPCBoGZiTx4520388AA=
Content-Type: multipart/mixed; boundary="6pjapMbj09tbQ1IGJ0iW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623344744;
 bh=seTNOB+hB/8qCit0gJ+LnKOFXtS9QO85JGsA68QRiik=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=g4Mcs3qmo0reEuZvFXDl+v+M3Cvh46plhODf5m6J19vhkuE/Sps9RCfK6B7q69Xuvb9
 iaqAsN16htk2fO5dozCV0/1vX2t3Q/scCa0yyPhhXsMDNqeFhr89gYbf6//YY5uuEbu7b
 HF3aq9KkVf1EyyQw5ttlObXFgroPB+pBOZo=

--6pjapMbj09tbQ1IGJ0iW
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

These are the new issues this week:

Best regards,
								Pavel

* 2021-06-04

CVE-2021-33200 -- BPF fix turned out to be buggy.

* 2021-06-09

CVE-2021-0606 -- EoP in GPU DRM Driver / reported by android, probably upst=
ream commit e7cdf5c82f1773c3386b93bbcf13b9bfff29fa31 ... may be interesting?

CVE-2021-3587 -- redhat Bugzilla 1968057: CVE-2021-3587 kernel: nfc: Null p=
ointer dereference in llcp_sock_getname

CVE-2020-36385 -- An issue was discovered in the Linux kernel before 5.8.1.=
 net/bluetooth/hci_event.c has a slab out-of-bounds read in hci_extended_in=
quiry_result_evt, aka CID-51c19bf3d5cf.

CVE-2020-36387 -- An issue was discovered in the Linux kernel before 5.8.2.=
 fs/io_uring.c has a use-after-free related to io_async_task_func and ctx r=
eference holding, aka CID-6d816e088c35.








--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDCRmIACgkQMOfwapXb+vKANgCeIY6k9lx4zq95NJEUAdd8ybq5
B2IAniqCgCrKsmXQqWUwWgD1+j0v8/rq
=7k8u
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

--6pjapMbj09tbQ1IGJ0iW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6501): https://lists.cip-project.org/g/cip-dev/message=
/6501
Mute This Topic: https://lists.cip-project.org/mt/83449660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6pjapMbj09tbQ1IGJ0iW--
