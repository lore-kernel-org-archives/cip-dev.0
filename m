Return-Path: <SRS0=rXuH=MB=lists.cip-project.org=bounce+64572+6617+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6425DC07E99
	for <cip-dev@archiver.kernel.org>; Fri,  9 Jul 2021 12:41:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EAA6135B
	for <cip-dev@archiver.kernel.org>; Fri,  9 Jul 2021 12:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EAA6135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6617+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7LqTYY4521723xnNAr89ZN8w; Fri, 09 Jul 2021 05:41:21 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.10323.1625834478998737868
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jul 2021 05:41:20 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 169Cf6ji010791; Fri, 9 Jul 2021 21:41:07 +0900
X-Iguazu-Qid: 34tMQV1tQnluindTmK
X-Iguazu-QSIG: v=2; s=0; t=1625834466; q=34tMQV1tQnluindTmK; m=PGstCNbMRCbNJV6BiW3CMemM82N/UbiHRhPKHqws0go=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 169Cf5Fj035423
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Jul 2021 21:41:05 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 75654100108;
	Fri,  9 Jul 2021 21:41:05 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 169Cf50A008694;
	Fri, 9 Jul 2021 21:41:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMpk/QVxiAWQuDPRHhkpKJcDepVbMnWnFs54HquKsQYhNlu3NBp9njQkYcJcp2jh3yNm1a3AjN8FsBIlCp2Q2eacj5GxGAqgWwX0/t9zq3b0pDesLqElHUOlyPHiadigiCqGA1EnfDMDn2yrz4y7Dq/KDPY8X/4g6bypam4lma1chHg14x1moeabdnjLdjBra6qE+1sIuvq7gMrwvfvAiAUnHtNqzjEqvhU5X6xFuixQPz7Tv5wT180sm77pvh2yUcFcLNt1rOugjc7Bp3txi7/6sknX6Mj9ZfVCZGofOnAFsMomHYsU86WINzs6TsuNA2XaKObJUNi8YBqj+GfRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnb9r6Rez5Z8RVTasxioYSOxODfprIIpyFzIM0g6nbA=;
 b=KAAGgmQfYZqS1dbDjdPrizIrWUMlEaeeeKZHzHy+fJVoacZrzJC1lidr3E4+l++3j0fg5c4Je/s1+ARAV+ndgwwoC2L+nthS/nV6FONbml7gD2QQTVKJX70XIdANJPMcy2lKga2xULA20WQhEMr6QQbDrAjsLRUVscQFGRAbzpaX4WRxbnhGQdiEkcyh2uqH7SR7dHPkYhcBjlDdp2gL0Xx+3rgckmxR/iLrBfhPZ3+7JepR91HI75a7stZD2JfsLDDxb8BX7UlPIxY23v6WW4dKYj4NT/2PxBHYtcuENm59Z2h8ExK0gPlhumO8b9e6FPAw5x/rpkJOsHkjiHartg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <pavel@denx.de>,
        <masami.ichikawa@miraclelinux.com>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.196-cip53 and v4.4.274-cip59
Thread-Topic: [ANNOUNCE] Release v4.19.196-cip53 and v4.4.274-cip59
Thread-Index: Add0v6seDHsdqgc6QDiV0p0MfXqJag==
Date: Fri, 9 Jul 2021 12:41:02 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625214EE372EE7E9D88A445992189@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d6c4ec-ef1c-466c-ee65-08d942d6cfe5
x-ms-traffictypediagnostic: TY2PR01MB3593:
x-microsoft-antispam-prvs: <TY2PR01MB3593EB912B98FF9518E63AAF92189@TY2PR01MB3593.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0ETrfuuiO1SAXTM8yRXDKMH6BBmsXjX9JDAQq2bt84zwHfFpR8CqbDAC5RQfZAyvUJlxytStqgRutBJYnuYhvm9fuJb1vwZyTjuHUGTJUFkGiu8dhWzw619qzwfx3zZDX04Xuj2GzpiC1ugh+/JMPEnFrIQeme6Mta6NTLBNn19vdGrlC+IiHe/qZZ0TNagpdllTZ/4kV3AgvEcOo0tGdMR1Q48ZF8cbMyTr8N9syv0B5ls4mG70APStvdOyxmDRXZXqKWVUm+jFNQTGx6eVO3STVOJGck4mWYY9s/jd6a8QS2BIZ6Zbd2slOoxNVJypU5O8SJrlg46b4NCB+lPO6s/0CtJU1tfHGhzzQBdmXgwGWbEHeEoV/yJjF24e7ZV4d8X7KsW/AyDDEQH77jZzEU2Oor0tsecNCjYXl6NeCtozkP8vrouhPjefWOysfiJbaaQLhET00KbkQ9KYRAJXKKomCkv+OiIlObSP01QyVWOZYileTrH7U/WxXEuLTw/k8NXpZv3ut5X4tYSLpHA0c0BqoO7vCIzq60qIBgivdd9YGKMEuMtmq52vQDX0r1W243EphJ5xFCL7Lk+03rgzYXp0ytIiCpPfNrSzQ1t3EVIjMWt6Dz/2l35XKc+XasB/OXbj5Ao9J0p3Zi/QmHa6hwh6PP9ZSAGFxvq9msBU0spj9ihh3XzP5rV2TuQY4crGL5nPSEbAAc+9oJEP8ZHtBY3bYJGHWjcf6EaB3Lk7U4o=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHV4ZzFRWSt4cldCdUtyZVpNb09rZUJKNHRpV2xCTDJzZHBqNTJHTXlQSFFz?=
 =?utf-8?B?V1paQ1lMSmxrVVVzdXZUbXVVMDJPWDFjd21hMUpIWFhZZG82YTl2L1cxcmZx?=
 =?utf-8?B?RFpQcElSU0pseTY3d2gwaTMxSW9HenZ3S1lsSExXOFN2OEVJVmJEV2UvMXlT?=
 =?utf-8?B?bkM4Skh3aGJnYStpZjdENDQ4Wm4wNEhLdnRobDJENUtDclZNZEt2dzQ0NU9J?=
 =?utf-8?B?aUVSOTlsUDhXV3V2QlVCRi9OeXNTZWNrb0tOR2daOVV2UWNQOUUvV0hLVnR1?=
 =?utf-8?B?MzhkejU1cXVOK1djN0pmdkF1NDdmdFBDMXN6cytocjV3U0dsTVFnWHBBbEhR?=
 =?utf-8?B?Wk9jOTdHeHBJeXFrMTNTZDM5U0dFSDNpVWJGVHo0RGV0ME1Zdjg0c2F0V3Fv?=
 =?utf-8?B?cjFoU0g5V2RXWGlPQnVubGQrcTFlL1lzWlVZL2JXT3lXVWVCMEJwUlVQNzFU?=
 =?utf-8?B?OFZxMHpBMWduVDJzRHZyTTd2blRXMjEveTNXNThZSlhiMGlyWVJyVDJaWWY2?=
 =?utf-8?B?bUNSM0RqNjZzdzVkbVBCZmRBT3pvU0ZVYlp4RDNLajE0QTZ6a0pSaGphZlVk?=
 =?utf-8?B?d21SaXRTU29KeFNhRHVjUDlwZUxvdW1hNFNMNFU4VFd4OU51VTZRR2FKdXV1?=
 =?utf-8?B?KzAxcks0bDUzMHVwQklOejNRY2NRS1F0SE80UnlIVW5aQitXYzIrMDZYaFo1?=
 =?utf-8?B?V3lVUmJoQng5QXdPd1RMU0crTlRxQ1g1aEpQc2Rzamt6U2NrSXNCL29DMkNs?=
 =?utf-8?B?b01QdVJsaWQ4cG41MjgrQkhIektzYU1MRWp4eG1ZcW5aTTZkYW96U29tZGdk?=
 =?utf-8?B?dGcreHgvNHdVbkpYOWI0emdzQUNJeXBEUnl6REh0bGNxVU40S2t5aDRGNktD?=
 =?utf-8?B?OGhNSUM1ZFlmOXlhMUZmUTNUY3NpM0R0U3h3Q0k3QzhIZUhVUThEUU0ra3R2?=
 =?utf-8?B?OUVVNmFRcGR5R3FIZlhBd0JVcVZLSG5GL1JsdFVHVTIzZndNSklXcFpnOHFa?=
 =?utf-8?B?S1ZGK2hsakRWbFdnSVF4K3RwSTdNUEowY0dVTFRCUzF6VEJwbnNnbEp4TTFC?=
 =?utf-8?B?YTg1Q1JnNU9BU3FQUy9Hd0UzVUdteWVJMVBYSG1hcndZZ1dzRXRVcDJtVTNW?=
 =?utf-8?B?WXNDWFQ2eWY0Z2hCd3RUdEp0b2VUdlJUVWNSdnFYRU9UZ3BwNWJIODZWTk5z?=
 =?utf-8?B?Qng0OG9RT2R2djV5MTNCRC9YNGlXa0x1WS96ZFZ3eGw4WGJzYTdPYkUxRGg3?=
 =?utf-8?B?Ukk5OEpEalVZSS82M3dnZ1lSVVovTHUvVEk4T0lyUlJxdGs4aDBPelpBWThY?=
 =?utf-8?B?SnYzdGt0dlNvdFdiVVE5cWxjdUVqeUF5T1g2RFc5d3ozNm1yK3RWSGtPeEd3?=
 =?utf-8?B?OTVON3ptczM2b2ljbDlMQVp5b04ycEFxQzhQQTdWeFUvUlo1bGFkdTNVZkJO?=
 =?utf-8?B?UDdIcEhpMzB6cUFPZG8ra1QxdklyNlJnNmsyN2U5ZjdwcXozN1lWVEh3UHZD?=
 =?utf-8?B?WWFNQThLajl3alNrR3BDalR3bGRqZlNNWDlvU1pJUU5ieTNIakRLa2ttWnE1?=
 =?utf-8?B?dXZHeEt0TWlEblRVbWloUHRWWmZWOUdobkttMTBlbmlnV0hXR1BnSmxROEFX?=
 =?utf-8?B?QkdPK1ltUUxXYkVpdGNTOGQxZnRTN2svY3FTQU9nU0NZaUwrUUJhSm5xUzNX?=
 =?utf-8?B?Q1Vwdk1KZy96ZlNNbFJuZkNlMVpFbWc4QXJpdTJYbHdrTUhXS0RNOXdMK21U?=
 =?utf-8?Q?qRb4ZwQRg0kWeh3jHk=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d6c4ec-ef1c-466c-ee65-08d942d6cfe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 12:41:02.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhOI33D7MS9tnNxYar2gtFRI++ZvIbA02bT9yn1eqrl90QZrBk52/c10whc5l1FnhmxCSw12x+fL9QSVpMJYvZfcFlUr9ojRHsrG2k4gfCvd03cepWfIzth3JpNnLDMY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3593
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NgYaUZTLco6PhSFMjjkxjsTax4520388AA=
Content-Type: multipart/mixed; boundary="5ItskzfCtZtL6WJg0G9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625834481;
 bh=C1xVVV1JdBYyT4Jfm1duJpUCPNdWdzHCSS/YzcfnCEw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=g0xo7krs3Fe+6OLRPEv1MKQcQwTkIIwVKXupfFTOv6EVSpI3h44SbRTlchOQqrrVDcI
 8W4Qrad6mrUh2f30ifjSfWGqSiqOgAjaYolG+XU0YdnlC7XuZJ9Zv7pqMXskUJjRyPCNs
 HqzkGczmzboXGXTdsROoi3jcLPQrTFLLahs=

--5ItskzfCtZtL6WJg0G9i
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xOTYtY2lwNTMgYW5kIHY0LjQuMjc0LWNpcDU5Lg0KVGhlIGxpbnV4LTQuMTkueS1jaXAgdHJl
ZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tIHY0LjE5LjE5NQ0KdG8gdjQuMTku
MTk2LCBhbmQgdGhlIGxpbnV4LTQuNC55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQgYmFzZSB2
ZXJzaW9uIGZyb20NCnY0LjQuMjcyIHRvIHY0LjQuMjc0Lg0KTm8gQ0lQLXNwZWNpZmljIHBhdGNo
ZXMgaGF2ZSBiZWVuIGFkZGVkIHRvIGVhY2gga2VybmVsLg0KDQpZb3UgY2FuIGdldCB0aGlzIHJl
bGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCg0KICB2NC4xOS4xOTYtY2lwNTM6DQogICAgcmVw
b3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4xOS55
LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgMzU1Y2E2YTNlM2Q2NmNmN2Y2YjUzZGJlMGU1
MDQyZTAzNTU3N2IzZQ0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lv
biBzdWZmaXggdG8gLWNpcDUzIGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCiAgdjQuNC4yNzQt
Y2lwNTk6DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAg
ICAgbGludXgtNC40LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICBjNTVhZDM3N2U1MTQw
ZDI5OWFjNWY2ZTQzNjY0MmU5NzM0NTM0NzQ4DQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJ
UDogQnVtcCB2ZXJzaW9uIHN1ZmZpeCB0byAtY2lwNTkgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUN
Cg0KQmVzdCByZWdhcmRzLA0KICAgTm9idWhpcm8NCg==

--5ItskzfCtZtL6WJg0G9i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6617): https://lists.cip-project.org/g/cip-dev/message=
/6617
Mute This Topic: https://lists.cip-project.org/mt/84090219/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5ItskzfCtZtL6WJg0G9i--
