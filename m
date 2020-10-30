Return-Path: <SRS0=Qwg7=EF=lists.cip-project.org=bounce+64572+5699+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F81AC00A89
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 18:08:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CE4206E5
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 18:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lmzIqFIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CE4206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5699+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i1qjYY4521723x6yISTLmAX0; Fri, 30 Oct 2020 11:08:14 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.121])
 by mx.groups.io with SMTP id smtpd.web10.18401.1604081293361797144
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2020 11:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzIijrEY/jZrgQSr3TVfTCRIHAm9cr+egp/dve/StWm4hYZ3L397wLyEB6SwiydjIm7ZrLCuERCi2AT9zz18kgXWj64AECAwwNcg/6EMs3kje+be3l8g8HeWJtj5XGX8+ITWUBDEy5hSXrsSBE9oVv7Qezh9dTyKUfIJPeyp2i/Bg3ifggP8DMsqZMZ2ZOlqMDahxZFVQX2nruToD9lQPs/C+aFeWlQ6EbYChw2jTxjp6u2WxGfeOzITh0R3N6tfX0nSvMGFUPr0A7WXVJlujjFlkpbJ5oIcfNSPX1ZT0Ue5Mgnm/gHuK5uKFTdwBXAE+4TOnGh19xL41I5dBp+FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7iMbCjxjmhuy6FGvCXqh1buvCFwCN/jzFj2/wuT9W4=;
 b=PzjfwavobppdOC8ZxEAF1XL67l5Lbe7K0KZKbQCo12uWfZqQjlgmdo+cLRg8O1j6rRlg3qWQm62pbqa4X2/2++ASvTSwgaICOrF1vsw7IMqOqrr4nWhEHKwiUq7xdnCWV+bKvUTq8tRjzSsWskX3i/TTacgy3JCM1DfsP+Da7F4283XCXhNIgqC+apjS6ZBx662VtOIxyqMK1Cn62t08eHCzkADEW9fpfocKBTa6Z2UxksUpnoRmi0/AdDqHKHFauW/Ju7u0S221m8hYMLMvPFc1KCYtqnA+wzY7nKqlwk+PDR9FaZdKPdAV4cY97Rx85VfoQU4TqSeKgRbcmKH7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2133.jpnprd01.prod.outlook.com (2603:1096:603:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 18:08:10 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 18:08:04 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
Thread-Topic: [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
Thread-Index: AQHWrfQc9s/kf/bCpE6T6+A4LeyKN6mv8jIAgACA+SA=
Date: Fri, 30 Oct 2020 18:08:03 +0000
Message-ID: 
 <OSBPR01MB5048BC6684FCCCAAB7647510AA150@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201029130451.GA6691@duo.ucw.cz> <20201030102556.GA21753@duo.ucw.cz>
In-Reply-To: <20201030102556.GA21753@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09b0b0ec-bb69-4507-4ed8-08d87cfebef8
x-ms-traffictypediagnostic: OSBPR01MB2133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB213348E9247C969C7D84E3B9AA150@OSBPR01MB2133.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ofQMWkfJPsKNUjIrw+Sloy2w+fNKdBHWIjKFrPMX2jjxQ7V4HIwBc9r42y6r4UgLs5IhHA6EkIY+ga3x6kQsnzvHjtqTuJOa/G1DcxxORzmoygfUoxNC3tkaYhtcINSh8JJ8mi4cMQBrhtG2q15aFrULU9F5SelgBH+trZvNl192KqM8oZoc5oClNjmWcIh20dySSkTiPBUa7Y8skJt/ChUKPqi6xspKeihJ0EZrTjTjbeLNpp6sHhXW0a9eTd/69rOQejNdgq4pW02BQEIgM3BuEtpZecOePFdXRMVZjuLfvhbRQlRprAOWNzt9QZhTFVThesH7ydrBMp5oCxzR8A==
x-ms-exchange-antispam-messagedata: 
 2N/D/jTIwuJb4ZCSCNO3WNnTfjcR1npxP6fKm63WocvSX2Zl9DHdJrVRLw/vodqPo9NFZdMcA2oFKg1aGdLyUDPwq9CcKMWZEoj29n9mRFrieGws2GywlYIfM+dbqvOfAUa79aFeIs8p1x+hlQWroJ1DpeT9Gf+CFi+a58X7o6XnObSM/w3Ba+x2QSyEZJHKvXIRA2kHodai5i79qSkioT7XxH9RdWksvwtMykO4sSsEO3YFjO45sXvEQ+wxYR0DH7nfca4ez/IGV3jHlbLle/QB7Y+OrrJetQbwdITIa4P5EvqyEMgjd67zNvIPbWz4B/XVQKPKx1NsSn7j0ZsNe/ydsIGNtw0nBWr9ZHAEINp32r2Jh5C1xRsJzhB8A2WPBcuOSH0fAjRDR7yJosNXDHiHDxCjwhGkRjJQX8q1XKd0caNOJEDxuKUu63/L8m7+q5QtEYKZxyq79PTCvTAxDIVfQcNmvWboagov7sKaSaw0Hl7+h/qbPIN6hMgRv67d1l/gaKGGcPj2qYGs8ZDmJZ0aRw0Wm9/USoq39zNJWQbCDjgCaVg4ULbNdmS7IpfzbSXzu/g/FGULM1J0omRv18yjujGNhjzaDkd7Tqlw+q1zLKKicjQV4D88ElYI8MHTnOGpg+D7o5JXioT3aquWWg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b0b0ec-bb69-4507-4ed8-08d87cfebef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 18:08:03.9067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wejH1ret6fAwx9qj6Jqjoy6c01wDmepQTLwqvc79evM6SCatUgLv2p9pWzCu7C1RY8ae85TZPlPlAD7YbKOyow8IQjiBEIemwaq9O7avWq4lhIQlmUkblvG/0Ka2ioG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2133
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aPWf5hBxDeWis4IhRq8rOmUhx4520388AA=
Content-Type: multipart/mixed; boundary="ltbqnw7Zlg2mXYyqo3NE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604081294;
 bh=CwxAMmqm+ciU3H5xq94tKxBf3IM7albZQ+15N2LeWZs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=lmzIqFIA/LiQDcoyKCCq/GZSYxsP5MjXfvvG3Kq/CQpPt+jhc2LOC7SjAYoZXD6WMHr
 1+/M3ZdZRTuBP637K5pfqeELT/XQxx8bpDiGFxC81vPiHbYXrEY5lFMpUSc+X0MBbQmtb
 0ZY/NKr9/u3WJeNSIvTaDbbmMyRRvemogkU=

--ltbqnw7Zlg2mXYyqo3NE
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 30 October 2020 10:26
> To: Pavel Machek <pavel@denx.de>
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-=
dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
>=20
> Hi!
>=20
> > > This patch series adds SATA support to RZ/G2N SoC and enables
> > > sata node in Hihope RZ/G2N board, alongside a fix to sata driver.
> >
> > Series looks okay to me, it is currently being tested. I can
> > apply/push it if there are no other comments.
>=20
> Thanks for patches, I pushed out the series.
>=20
Thank you.

Cheers,
Prabhakar

--ltbqnw7Zlg2mXYyqo3NE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5699): https://lists.cip-project.org/g/cip-dev/message=
/5699
Mute This Topic: https://lists.cip-project.org/mt/77885348/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ltbqnw7Zlg2mXYyqo3NE--
