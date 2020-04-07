Return-Path: <SRS0=QUzF=5X=lists.cip-project.org=bounce+64572+4558+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B668C2BA16
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 06:48:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18682072A
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 06:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sURTtA/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18682072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4558+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id a7QaYY4521723xrBHmJXhg3L; Mon, 06 Apr 2020 23:48:46 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.90])
 by mx.groups.io with SMTP id smtpd.web12.4554.1586242124879641219
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2020 23:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGfndUNd2oZcYVyhHObkSwUVNTYxiGK0ld0u+4KmyINU0kbNyG7IomdosbeutAKM5+hnNc+mhQdqaAtmvVQUEsz042H2EY6E3jBQg/FRK3vw99SZA0d2gIeCMmcXEdEnP6nFAw3fRL4ALL8Ebgkm2rYliWYPQVTvPtKlV3hkNBUkcnJkK3+tMOswSiUyZMKDC3TERjFqCsSZn5BHgmP7GsRqSP1FUfZmw0GjIMb3pPnoG5FyMYYqpYGrBLQtQbH4mB2yENvf1LqXG7+OjX6C73pBrEPb5dhX3+oOfiAP7991xIhCXRQM+8uXy7ZbMejlgd7ph4MnlDx+dTUn0Sly1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCCuhubkuAefU+BBhzhXqoz4mb4UOCUf7ZqUTA9LGzY=;
 b=Kn+n8OTN1OkiP38iI/0z7CSp5umVyKP4+lZFSgqsJ+d078GNf7S7aiIzUcIhwo/tfEupULk5moH7V1YesHarZh0sindgH19gxeAl3Y2e7xHHNenLsvHTfHNJslpP/B+rbXzURnAIB/GTy6PfJGIsPKDWVOxlFTXjrbGpj9/E2cwWqFE3OUivMDrtId+9r7mJw5NGqcOB2xdt8seuTxzHJzNJvZR12MbBS/vFuuP2Eq4g7SnctO7SpeK59VvfLOyt/GhSIamAaQadpKOWuu3UFFLBxKpQZb3w5W12JeCslrDAtaksRNrgM8R9G4nPi20J72auG2v1Rb8eeN2ZXwQwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com (20.177.101.84) by
 TYAPR01MB3519.jpnprd01.prod.outlook.com (20.178.138.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Tue, 7 Apr 2020 06:48:41 +0000
X-Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::e52d:16f1:7b5:a1a0]) by TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::e52d:16f1:7b5:a1a0%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 06:48:41 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: Pavel Machek <pavel@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Python 3.x vs 2.7
Thread-Topic: [cip-dev] Python 3.x vs 2.7
Thread-Index: AdYI0Y7wF02Ds+P+SQqCBlZlaiG5IABL904AAH62CgAAGFYHgAAR8NGQ
Date: Tue, 7 Apr 2020 06:48:41 +0000
Message-ID: 
 <TYAPR01MB2399CAF8B56C489427E7A791DFC30@TYAPR01MB2399.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <20200403214708.GA32080@duo.ucw.cz>
 <8d490687-c9fb-239e-5d01-55fec493168f@siemens.com>
 <20200406215205.GA14162@amd.ucw.cz>
In-Reply-To: <20200406215205.GA14162@amd.ucw.cz>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [111.239.162.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e695b29-0951-4ae7-7bb0-08d7dabfb590
x-ms-traffictypediagnostic: TYAPR01MB3519:
x-microsoft-antispam-prvs: 
 <TYAPR01MB35195DDF875669BB9F36FA39DFC30@TYAPR01MB3519.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Pts2JhmZaym1HC8fYDeBvnDt2/ITnCSv5yJlY/ra/fEO3qtM3btcsGEP/0szp3kFCxkySGAMZAZcFeszC0B11IzRLDkoeT7694pzcQTPTI3UD0UpPTsBUAOBM69BkQ1DbVoIihkvj6mVXRMOcRCCxu6tBLCjtK8CEaDIK2ACqdpNHquBJJpQpdiQIPt82NnsA0yiaymC6yYXCOVMZLu6dOgrGdc7T0mgPfatLNr7KDhPvDNoVJBI95c7WFBYN+PUGDci7Wav900c6lSaGLm8U4DsonqKIkn+fMn7skwkiuTmrXFSp85CO3dnH+x1VK65
x-ms-exchange-antispam-messagedata: 
 DNh57ljUrPtgd38PQvAjvuAoWzCj1723iB4JMjvafYci+0yOPA0rkAsnUnyqRYKcmac0ked/4znWhadksJffrDVyPZqZ1ex9X0cCh7/poCSE1mw3xUJIOAOjngIHsbF5dBoQ7rcY567FADnQ+5UmSg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e695b29-0951-4ae7-7bb0-08d7dabfb590
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 06:48:41.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjcgFnaSea/K2hYdaZKGX4S0kM4nOXORFblcRLlR8iBE3TWyAVkHXHDPzCo9Dmf1SzajQo8r+99HZhH4EPpdpD9CTDlT9/kTJTE4qhBdozo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3519
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cxbDV5TzqUq8IZaTPOmJizJox4520388AA=
Content-Language: ja-JP
Content-Type: multipart/signed;
	protocol="application/pgp-signature";
	micalg=pgp-sha256     ;
	boundary="=-=DQLi3WSITc13+3=-="
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586242126;
 bh=vgjBarcpIm9AFSi4WlaTVqKVAQB5paOGyt7Ub8k4zEQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sURTtA/ztIeDDEAiwBfaY0VJJXuuYs/K/22DTGr2/zDAyH+mJpDWbXapj8dIRdGHb2K
 UQNbQwXM7yDjgwex5EYKdv4ZSjn16/E5RValjGbva7fLcJeJdRrs6gvWWD9nW2GnvGbzs
 Cz1v//B+i1O7gle0smsMSkRumi9zBNsvQj8=

--=-=DQLi3WSITc13+3=-=
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

>-----Original Message-----
>From: Pavel Machek <pavel@denx.de>
>Sent: Tuesday, April 7, 2020 6:52 AM
>To: Jan Kiszka <jan.kiszka@siemens.com>
>Cc: Pavel Machek <pavel@denx.de>; Kento Yoshida
><kento.yoshida.wz@renesas.com>; cip-security@lists.cip-project.org;
>cip-dev@lists.cip-project.org
>Subject: Re: [cip-dev] Python 3.x vs 2.7
>
>On Mon 2020-04-06 12:15:16, Jan Kiszka wrote:
>> On 03.04.20 23:47, Pavel Machek wrote:
>> > Hi!
>> >
>> > >
>> > > FYI, unfortunately we couldn't find the alternative package for
>system backup. The duplicity is the best package for us from the license =
and num
>of dependencies point of view.
>
>> > > See the following.
>> > >
>> >
>> > > <duplicity>
>> > > Encryption: Yes
>> > > Schedule backup: No
>> > > Incremental backup: Yes
>> > > License: GPL v2
>> > > Dependencies count (aprox): 80
>> > > Reference: http://duplicity.nongnu.org/features.ht
>> >
>> > I'm not sure what your exact requirements are, but have you
>considered
>> > "tar"? It should be possible to pipe its output to aespipe (and
>> > possibly other tools) to get encryption, and it should be able to
>do
>> > incremental backups...
>>
>> I suppose there is that concern about GPLv3 again (as with broadly
>used
>> rsync) - which is generally overrated. There exists legal views that
>already
>> GPLv2 requires to keep such licensed components replaceable on the
>target.
>> What then effectively remains with v3 is its, well, wording
>complexity.
>
>Does "tar" match the requirements?
>
>And I agree that best option would be to accept GPLv3.
>

Some of the security members didn't accept GPLv3, so currently we dropped =
GPLv3 packages from the candidates.

BTW, I'm not sure but is the CIP policy on accepting GPLv3 still to be dec=
ided?

>If that's out of question, I'm pretty sure we can get GPLv2 tar implement=
ation
>somewhere. busybox has implementation, and I'm pretty sure there's GPLv2 =
fork
>of busybox. Old version of tar should be GPLv2. Still better than porting=
 duplicity
>to different python version...
>

Thank you for introduction about "tar".
I will investigate whether it meets the requirements.
And also I'll search GPLv2 implementation if it meets the requirements.
If it's not decided yet about the CIP policy on accepting GPLv3, we cannot=
 adopt GPLv3 packages.

Anyway, I agreed it is difficult to support python 2 for a super long term=
. And everyone agreed on this point.
So, we cannot support each libraries using python 2, at least.

Best regards, Kent

>Best regards,
>                                                                Pavel
>--
>DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
>HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4558): https://lists.cip-project.org/g/cip-dev/message=
/4558
Mute This Topic: https://lists.cip-project.org/mt/72826088/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=-=DQLi3WSITc13+3=-=
Content-Type: application/pgp-signature;
	name="openpgp-digital-signature.asc"
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEErBrREiMJ3+GX1RoROtg6yLpqhgwFAl6MIf8ACgkQOtg6yLpq
hgxNTgf/Wu4FRVRdOmllkwhM9kgpTkSyhsBRZYBCqzk5mkHOm9bSoi1vHqCIElt6
RLsGq5kxpsonfRW0n+iqZwYgAGn4smOlpxc+Wczh7QdTg5XfZAmptsTz8dVPGtqs
wVHorPIPdd+kInoL2UFDJMa7A33A9jzP+agCBQ2e86aAyFKPB7wcpEtJSU64FPkC
duddwPRRrKR+Mfqu6f7zursAy+aoGNAarXoGL+GBMh6e6IFalP3E+kAGlqgYsGwD
+/P+Ya3hIZlpJCzE744RW9mljS7kM+e5V770JQdr07jfofeWMqlDIoX7GEcQeOva
+c9EDXEaAauyxOwfB/MUSEfh86cXoA==
=PfrA
-----END PGP SIGNATURE-----


--=-=DQLi3WSITc13+3=-=--
