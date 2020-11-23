Return-Path: <SRS0=GWdm=E5=lists.cip-project.org=bounce+64572+5833+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387D2C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:02:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5352B206D8
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gqDyxYyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5352B206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5833+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PwdWYY4521723xjokkyQrlWp; Mon, 23 Nov 2020 15:02:21 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.102])
 by mx.groups.io with SMTP id smtpd.web09.44136.1606172540630030532
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 15:02:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSzv6C/MLeWpuAnEiNBShPVQX572k8ohp2MSVUQpjLQYueDY7FSfXwtdIvNd9Ji9GIPoObDVuysT2rzBpboyltobKlvrk9CLJYL99lblIXqYCXWmwivqR5ZGm4n1smY5Ov1Ym3HpArLpbw6dWVcfYRpRs8WaA64be/ar0uWZz1T4wcC1tvkDI+tQ022tf245SwyH7NbcmB1HUBaGvabcVjGHnnNcwuj5sVA3aJcNGMeFUrrtjoC0RGMxK6m5xn6tuKo3r6CCL+Rvt/usMH3emMxerxbiHGaiSl/rbXunssVvrml1V8xQUf3w9UkqTgnd/i3jcRNLl3oj0/5LctP1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoxTWchBdRwvd8LpyBWN13hMJLXZgkcWq1qwiCw49Vk=;
 b=A0RasZuQ3mBardrLxdNOoVUItHvExNTLCUGDoAXdJMyqQ7SUpkslBzjeGdOzWD4y5+KPCKQ+sNGHWxlk1+FsEPiVgzMpjImt41onghPTeFDcmDIRSOo4eDo0JykXLNJQKt6iI+9KfXzbk/VNwJxAlG0N3HErEbd+e8PfnLn09GTDwrTKBQ5hWMY16pc7ioxodCbNyvCOUdZdr/p70Fi0SG/6u6wVNDr9AHm08UYjaAtJh81RQ5H2DeyaNjpVOM5LaHMK7Qt54KUOkzx44dfVXyLkOlNpPSkKlcdP5Y7/IzinDdpeh2hdCKgAAN9pA/rbjuIDQqV32EL9YVgxjroa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4182.jpnprd01.prod.outlook.com (2603:1096:604:4c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 23:02:16 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 23:02:16 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
Thread-Topic: [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
Thread-Index: AQHWwdA5VGtdd6+dZUeV4uDONxNnA6nWVWwg
Date: Mon, 23 Nov 2020 23:02:16 +0000
Message-ID: 
 <OSBPR01MB5048784BD35C2B67F5BF3405AAFC0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123193830.GB5619@amd>
In-Reply-To: <20201123193830.GB5619@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3c7546a-4e7b-4ac7-c912-08d89003d2aa
x-ms-traffictypediagnostic: OSBPR01MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB4182F5B2E846A71AF6F08CB6AAFC0@OSBPR01MB4182.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 a10U2AJrMi/+lyEcXZB+Kx8JDwkqpIB2juN6bDYy1nCkNvDKz33BuiDsGYSWUaF2Pll9Bl2Ljuh3x+L7rhmDwUokrY4AA/9rtBILrfkbykZacdan2ORKdSZft1f6jl5EWiqY/QZV4h3QCAHGTYt9EKd3hRQngM4lYebZQEdL0DlLmoSpcjp0K+E8qmLw3pX9fFbT9e4M3NG/zbrV1Al9q8TTOhkB9olPA4/w46sEBsE3DEdnwHJqHC8tL8dwhFgG4D0gmSprONEjU4QpGRG2kfawZoV9fx/azDauUoZXtsAAR52BNJ18w89VSO49AVcHUYrPw3QtNNuZxnxpJodtJQ==
x-ms-exchange-antispam-messagedata: 
 n+5mPphXh40KK3AWXF0zhzii+TMjA2WIs7MCTG7ETRYHPw3KXX2owyRsfZTF/FBDMp62ArufVSlyogbxlfiZDKMO108/WTZ3TqVlLkGIDGjGu5xRJjSv07Xyk4QqnP9z+ewMMzTX/VqFAipwJzKrpgI0282j/hgfvoGFyBIu02SVnOxnH6x6xE6OLyjVXLqrv9sIaWM6ik9jGuSBt6VfqUHepXx+bbw5MVJhqGmimqG2lJH1LipHzH5xCCbQTD3CoCAlgyHZYD0Uj+GLWWgUYofXBI4Kdf5l3bPESLWlO4delwBjf4CWIPsPyBbpgOxDrA7gEv9Fa+0GhbA3WmNE3eWcs+jFCVvRgoVxGbM7e1B3waJi82FbiCB5azMzx8/4wJawkjRn46LnKXsAR0xXMdy54+3PFF5uaOpkSWADY2/V5aUXfG4ICgDoVcXBBJm9HYOcIf2KD19v5DX4KJ/1oDAxTsfWoH78qIOQwIOWExvDwInm7X6UitbKlHw+rrXUDNnZHrq1drPzYDsQY64TW6q/uvcWAgjm0gQlViSBQ7AnFuNPjyFIsetS7eEfci4LOWKkBWu+D+Uo7qra/WIKuNQezOKQJCSExPPPtz6odckYr2QJs534WxpvpMeySVI+ODphQV46c7fbokB+A+EmQJK1f8wxEEpC+s84V2bmbdHk4yr1dGjpfHCNOlSeGyY2NhH2+N+VpliCnV1iXPi2nmwhW50Bh2Wf4UImT1JkvloQjaJrcgXK92XahS1YQpmjjBTC/ZaFi6y7JLOZqFmT1X2WJ72w1jWOy1gUezC3bwDv5UfCV5qnXdnHL8W1Qj0y7lkemMFf7kwy5uX7famGWQyFU1E4iQuPLtnyigFpwwycVlkZVZxkRiSVkcd5Esyr2cHb4sUlBQ4NlSamRLyU+Q==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7546a-4e7b-4ac7-c912-08d89003d2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 23:02:16.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV0xILsUCuWKrRBqWJYl38StrQi6tYSHDfjph58BKxrbiWN8B1ooKAd1bzccp302jFWYiQKYdBRH1nedb70BEU9618sCIWDniCE8SWlbbZ3iBmOTOEmN9JzojTDLMsuT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4182
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MlufmVRtBSF3W8EMb1ieliG1x4520388AA=
Content-Type: multipart/mixed; boundary="IGGDGlIRhJBVd3azaDCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606172541;
 bh=1h+dINTrGITBVkav6rfsluwxgNxhWIlD5Hq/0oyW0lM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=gqDyxYyRNmLIU8bm+yQo7cdgOdzI2hTMs5tr3rzSVDPdnJyBBfRs+A/qOeC4ybFKpUy
 yx+dTwNm6qN/P+FHTosqZvMRoyYV0L9R7idRu27z9mfcPKdVQZpPOtdaFJj7yiw/8yFQY
 n7ptDfgyy54ouKNOlRjaRjIIqXFhQVht06c=

--IGGDGlIRhJBVd3azaDCy
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 November 2020 19:39
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
>=20
> Hi!
>=20
> > From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> > +int rpcif_manual_xfer(struct rpcif *rpc);
> > +ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, voi=
d *buf);
> > +
> > +#endif // __RENESAS_RPC_IF_H
>=20
> Oh and I'd use normal C comment here.
>=20
Agreed not sure why checkpatch failed to catch this for upstream.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IGGDGlIRhJBVd3azaDCy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5833): https://lists.cip-project.org/g/cip-dev/message=
/5833
Mute This Topic: https://lists.cip-project.org/mt/78451541/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IGGDGlIRhJBVd3azaDCy--
