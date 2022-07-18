Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36799C433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 05:44:50 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.117])
 by mx.groups.io with SMTP id smtpd.web09.23918.1658123084458313555
 for <cip-dev@lists.cip-project.org>;
 Sun, 17 Jul 2022 22:44:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=CvlGH7tR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.117,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsO864uMdEqgwluj3MFmHyOM9ln/1ipfW/KXG3TZeuASa6hbmlx0E8U2M8cpnyw/P7yvZbVxdhNhrf3qOJAQkCsejtsDLyD+PjReABvwY0xP5vQyy/nfGK42EilmoS+B5OHJRKvVxwi/rADTSUcyLjxRO/Z8NrVS4qbshDBNJ2n6XN9CsgYke9/mp83KLL3PfhhSxKTs2S1baiKIJ1FXduMhjPIg0xdNkYnRIJhxYmCTAVhmRqbfDYZfb0bkK0rJnG/2qRPzzY4VL0tBS704N4l49Dz0AE5NPvL+QCRL/DRBhuK+Z6uKseaBylidWiAMgYdOcZp050yNErb1rB1nWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bn5gn9ghhERsse8FsZgbU23X3PZtmnrE2Ku6nVyC/A=;
 b=BgkHW4hn7zVdvWZYIBO716FML4cPY2shDxddTByxQyHw4DcN8ANgpAEkR874+/NV4uGBwStHHy69H3IwE9fkFLIwS0TokZgySbp+kXQnglEvwW52ig538/a4FWiaqt+VoABdCu+65iEHDjpf+bjYUbfE1YzFBC/yxM75ICN3VTvlgqdEHR/ejQq4/FDkDQBjywsAqrxwGsfoA5X/dbpVfhoctfriOf024LPzp9goNJ6rpPAOBp58FUZ3HLq81A/mdo6HKZiJgRW6oof+lGu3w7ihe1vutahWsz2cXaVk+j2W5k1nS4/7mHnMBuDN+RZeupnA10LUy+hgLoCTRgwjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bn5gn9ghhERsse8FsZgbU23X3PZtmnrE2Ku6nVyC/A=;
 b=CvlGH7tR017CB03Xub6Tmhm2W7SMn5we/x65etWAyUUOso+q0pbfXFUyCVDQHI6y5vNaP9qI/hIvWCv3rW/BKz/BIvlkegHV4mNbp9C28PnImQs9+Ifol1WUGG+FKVBu4w0uPhjnSv7eB/TIucRa3bYoao8XUpmkyTkGg30d/Ow=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10164.jpnprd01.prod.outlook.com (2603:1096:400:1ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 18 Jul
 2022 05:44:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 05:44:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Thread-Topic: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Thread-Index: AQHYmB4DoFtie5laUESOxGXECxlswK2A1G6AgAA7jkCAApJA8A==
Date: Mon, 18 Jul 2022 05:44:39 +0000
Message-ID: 
 <OS0PR01MB592291A21992DB4B471AB5E4868C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-4-biju.das.jz@bp.renesas.com>
 <20220716105351.GB18467@duo.ucw.cz>
 <TYCPR01MB5933D3A6DA16E05E80D87DBE868A9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB5933D3A6DA16E05E80D87DBE868A9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24a3056b-fd94-48e8-41f0-08da68809b57
x-ms-traffictypediagnostic: TYCPR01MB10164:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 otK+1mROztdiBVJ/MKhKAECkQVXMzgBxrnGWbvb/mOjaU9zHcI914XnxLltfiCZJG5T1C+AVZDO9H5vEl1DF2nABbokrfRI0X783caeE6P9rwTFp217wwRC8btkjBsXqjt+0bTbpxPNZGPzpiM0TK+Uukm1uU9uORtnehtb793rTaqaN5HHswwei1Lb60OWpwJzGnM1maYQw5Jux/03ZmZyzImCKeAbgl06CDp6XiKcOmE5EygRUEx955MCKhamE9fP5CYHPzIIGy+em/hSZnsV+WflnromvwkkNptqSgrgH4o7NXTcEmLjnc5RdIj4Y8bMuOvFy21+wy4lmwqBMWCPBhfRVw3EP0elrD1GzNNvqkMfc2YTd9b4QKtW4rrZw/UePp7s9FdG+OvmA3WjVmBhmEeQLQvssfvYp4OsHLY+7/fT8EhxDHlgGZzWMRWhzFBcaOI5teoQ7dlcYhgOhxcaAOhq/OOpf5BjnDH00JPJU2D3rACUMOYxoyFJM+oQBzX1Rj8+A899AYNG9cmZAVX+Smc56T9LGfK3C5/PevJ8Uk1xpiKrE9Yf2qTBHXluqpoCAxasAlevtrg5+0xdyYymYaD7O84RI6NcKhfMKQ5RU7Ns829UyaKQ7pbxTpoH2BK7ScgAWQu8F8sdNQQ/ZTOpiM2U85VV0sFMP4Wm5Zd8LOY/Xux8ZzGsJSRfoPxwUJdJRTiJ5pfjz1XHr325iqJ5mj8HDW4CGujgXuKYY7YnybE5mURH/vGoSYkRCG1Q2ASw6TRzp4WzNEex5LUISzuUIFDdtVQi1ARREm3bY05t9gKkN4vu7zoNL0QgFYnfo
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(71200400001)(41300700001)(478600001)(186003)(107886003)(7696005)(26005)(122000001)(6506007)(38070700005)(38100700002)(83380400001)(9686003)(2906002)(52536014)(33656002)(5660300002)(8936002)(55016003)(316002)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(8676002)(86362001)(54906003)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WGVkTTJkZG55UFgvSFFIVHJTR1B0YkUxYTYxVWFBa1Q5WjU0ZzJkdzdtNG5k?=
 =?utf-8?B?R2dQK2dweVQzVmh5aFpiWGtvTjY5WndXT25yQ3Ruc0NwQ3hnMlFzNnMraXZU?=
 =?utf-8?B?dEVVb3dJSjgzUWJTbzhRK3NCUndLT1kvOWFQNEF5b28wTXlZNUVXczY5TEhD?=
 =?utf-8?B?d2c0OEtXSzhlSllMVWFhcXdxOWJXME5SL0lxWUVKQ0NvOGR1S3dpYXM1NWRP?=
 =?utf-8?B?eWRqK1F0aGtBeDJVU3J4RHR3N2FwMGRvaHIzNHZmTVIwRWJvSG84RWptNWd3?=
 =?utf-8?B?ajVKVk43UlFiQW1hQXNQQ0xwWkZnRi9IVDVCTG5SK0JJeVZ2cU5XMTlsRGdy?=
 =?utf-8?B?cysrYTRLem9FdDJ0ZVlDMzVLdlNJRVRHUVJWZ3lkbXhpT1p2THFaRzhwK3dm?=
 =?utf-8?B?cnFvZ1JPMW1YV08wc2RWME5NR0tmUTNYeXJkV0FkUUttRk1DU2phYmFVRmFI?=
 =?utf-8?B?TGJVVWpyNXdnbWpad0g0Zm0vaitlelV4bGFHMzVBTzFxWWVSY290eDBUVkU1?=
 =?utf-8?B?aWRGcFk3UnBXWVBMNXVNcU1lUUJxbGM0bld0OU85eXM4YXhwaDF4aGZ6VjFi?=
 =?utf-8?B?Q0tQRFBicWhVZGVRcnU1ancydzhvd0JjampROU9ZRG91YzBIc2x2V3dpQ3px?=
 =?utf-8?B?TmQwYzdORVNEczE3U3pKdHUrWjEwSFBqTnBCMkdxOE1mN2wxaW5PSWRxUkpz?=
 =?utf-8?B?Uzh4em1pM1JWbWFwVWgxSm1Fb243dUxyWmhJQW1kMWkyUU5EK2ZjS3dtdy90?=
 =?utf-8?B?UDhpamlyMVFyNml4YUdVbFJqQmxoUXNCc1VuUkJ2VnF6cmswTWVhd1M4Zk81?=
 =?utf-8?B?QUcwS1FualhDb09LOWo2Z1JyVloyYWo3aWV3T1dLQS84V3N4V1ZYK1RVQUZk?=
 =?utf-8?B?dDhKWEJHbzAvMzZ4QlgxTm1HSVJOK2orWHdRb1hkWU0xbkRDQzRPTndRdE9M?=
 =?utf-8?B?VEJxbVYzRzdKN2JrbXd1ME9ITktpMytWdGNGK1hPeGg4ZlFMTUovQU8xck5r?=
 =?utf-8?B?bkJPWDJBWm5FSU94OEhtNHRCTGRmdUpHZFlxWVVpeklhbFdOUVFsWFZQMFNP?=
 =?utf-8?B?N1FmR2JwYXBvZnZYU0diZVZsUXgyamZja3JRMUd1aFhsMW5DaHRiL2txQ05U?=
 =?utf-8?B?c2o4RGZYaElCelFSbk1zV0xqWm44ZVBmNVA3M2JQMGdJTHU2RTAzdjNjT2Ny?=
 =?utf-8?B?WS9HYmpqNVNLaGcwbTJHL3l5ZVhGRjd1YVAzcmVXMElLTTh2bHhBMXMrY3NO?=
 =?utf-8?B?eVM4NjBxcWRSbVNkT05wWUlDTU56a2hiUTk2OC9UMVgyWU5uWElXWUpYNDlh?=
 =?utf-8?B?YmhqUkFhMHFWL09HSURaUG9zV2lxdHhlNzVtTWYxSndyenBVRG1mcGhITWp3?=
 =?utf-8?B?SGNNQkxLY3ZmTzlzQmVnZU5RWGRjVnNYRnJCaUc1aU5lbzFWdkJtUWVoQ2VU?=
 =?utf-8?B?ZTFjNXpCS1NrYTVMdW90NWhJRzVoZUFBTUhka1JBLzRyNW43YURVSzh5OHNm?=
 =?utf-8?B?ZzY4Q2VzM3BTYTBPNFB4L2l1V1A5dEVNZitRdWRTcG04RVRoTjVjRlpXZmxL?=
 =?utf-8?B?SlBTV1U1NkNtd0NOdmRvdFFNaGxwQjJ4UzdGNlEzdTBMbENVN01ua2tQK0d3?=
 =?utf-8?B?TXgxTVJxMUtzNGFxYytrcUp6YkxUR3NMbG5WemZmT0lXV3FpZ1VuWExjVGxl?=
 =?utf-8?B?RzU2cXBzRWl1dFBXOVd1RFZ2emRweWo5Sk40RzFaTlhPN3VVU2pkNjZCQ2Ez?=
 =?utf-8?B?cERzY0FPVWNaeXVxK2ZubFEyWHRMWlVzOE9UYi95a3BKZ2pHYUt2U1VtcE84?=
 =?utf-8?B?cDN5aDl2MXdmZGh3MFg4M3YrNnhoYUd5emR5N1BVb05TVG50RTNqRVFmdlp1?=
 =?utf-8?B?Z2NmbFpOOHA5a3g0b0s4OU9TT1VaNFM2WjdudndtVHNTSXNHdzRwSGVBY0dw?=
 =?utf-8?B?SGRyNFAxOURlVzdJZEh3cTZVWlZTWGtVUkRUcU56dDl6VVo1UHlvQ2hyT1F0?=
 =?utf-8?B?TjFqZGhsWGtiSUoxYi91RHZLSERLbW5sL0hyNk5oQ2JLMGtydW9keUxHbFN2?=
 =?utf-8?B?WnErOVBxYmkwMGhOZFNXbVRoUHo4RXMzSjJjdUJ1YmJWbDZVWGZnbERoQ3R0?=
 =?utf-8?B?QjhleWNQdkw5ZkFMVGk0Wktpc0dWeEpQR01hcWgycC94VE9ZSDd5a2VCTEVJ?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 24a3056b-fd94-48e8-41f0-08da68809b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 05:44:39.7324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 BoM+ysuvK9TJO2zr4Nk2I1ZhEUJfZ/EYeyrdYpeYC4iBE7HydW4bMg+CVw7/wG+SwYdV4Tnk38AZfcvOO0Fdq24taUF63c0IfVZ53PHSepk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10164
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 05:44:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8842

SGkgUGF2ZWwsDQoNCj4gU3ViamVjdDogUkU6IFtjaXAtZGV2XSBbUEFUQ0ggUkVTRU5EIDUuMTAu
eS1jaXAgMDMvMTNdIHRoZXJtYWwvZHJpdmVyczoNCj4gQWRkIFRTVSBkcml2ZXIgZm9yIFJaL0cy
TA0KPiANCj4gSGkgUGF2ZWwsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gDQo+
ID4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFUQ0ggUkVTRU5EIDUuMTAueS1jaXAgMDMvMTNd
IHRoZXJtYWwvZHJpdmVyczoNCj4gPiBBZGQgVFNVIGRyaXZlciBmb3IgUlovRzJMDQo+ID4NCj4g
PiBIaSENCj4gPg0KPiA+ID4gY29tbWl0IDY3M2M2OGJkNDgzOTBkYWQwMWY3ZDE3NjcwZGUzZTMz
YjYwODYwYWMgdXBzdHJlYW0uDQo+ID4gPg0KPiA+ID4gVGhlIFJaL0cyTCBTb0MgaW5jb3Jwb3Jh
dGVzIGEgdGhlcm1hbCBzZW5zb3IgdW5pdCAoVFNVKSB0aGF0DQo+ID4gPiBtZWFzdXJlcyB0aGUg
dGVtcGVyYXR1cmUgaW5zaWRlIHRoZSBMU0kuDQo+ID4gPg0KPiA+ID4gVGhlIHRoZXJtYWwgc2Vu
c29yIGluIHRoaXMgdW5pdCBtZWFzdXJlcyB0ZW1wZXJhdHVyZXMgaW4gdGhlIHJhbmdlDQo+ID4g
PiBmcm9tDQo+ID4gPiDiiJI0MCBkZWdyZWUgQ2Vsc2l1cyB0byAxMjUgZGVncmVlIENlbHNpdXMg
d2l0aCBhbiBhY2N1cmFjeSBvZiDCsTPCsEMuDQo+ID4gPiBUaGUgVFNVIHJlcGVhdHMgbWVhc3Vy
ZW1lbnQgYXQgMjAgbWljcm9zZWNvbmRzIGludGVydmFscyBhbmQNCj4gPiA+IGF1dG9tYXRpY2Fs
bHkgdXBkYXRlcyB0aGUgcmVzdWx0cyBvZiBtZWFzdXJlbWVudC4NCj4gPiA+DQo+ID4gPiBUaGUg
VFNVIGhhcyBubyBpbnRlcnJ1cHRzIGFzIHdlbGwgYXMgbm8gZXh0ZXJuYWwgcGlucy4NCj4gPiA+
DQo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgVGhlcm1hbCBTZW5zb3IgVW5pdChUU1UpIGRyaXZlciBm
b3IgUlovRzJMIFNvQy4NCj4gPg0KPiA+ID4gKyNkZWZpbmUgVFNVX1NTX0NPTlZfUlVOTklORwlC
SVQoMCkNCj4gPiA+ICsNCj4gPiA+ICsjZGVmaW5lIFRTX0NPREVfQVZFX1NDQUxFKHgpCSgoeCkg
KiAxMDAwMDAwKQ0KPiA+ID4gKyNkZWZpbmUgTUNFTFNJVVModGVtcCkJCSgodGVtcCkgKiBNSUxM
SURFR1JFRV9QRVJfREVHUkVFKQ0KPiA+ID4gKyNkZWZpbmUgVFNfQ09ERV9DQVBfVElNRVMJOAkv
KiBDYXB0dXJlICB0aW1lcyAqLw0KPiA+DQo+ID4gVHdvIHNwYWNlcywgcGx1cyAiY2FwdHVyZSB0
aW1lcyIgZG9lcyBub3QgcmVhbGx5IGV4cGxhaW4gbXVjaC4NCj4gDQo+IE9LLCB3aWxsIGZpeCB0
aGUgMiBzcGFjZXMuIEZvciAiIGNhcHR1cmUgdGltZXMiIEJhc2ljYWxseSB3ZSBuZWVkIHRvIHJl
YWQNCj4gVFNVX1NBRCByZWdpc3RlciBlaWdodCB0aW1lcyBjb25zZWN1dGl2ZWx5IGF0IDIwIG1p
Y3Jvc2Vjb25kcyBpbnRlcnZhbC4NCj4gDQo+IEkgd2lsbCB0cnkgdG8gZHJvcCB0aGUgY29tbWVu
dCAvKiBDYXB0dXJlICB0aW1lcyAqLyBmcm9tIG1haW5saW5lLCBpZiBpdA0KPiBkb2VzIG5vdCBy
ZWFsbHkgZXhwbGFpbiB0aGUgaW50ZW50aW9uLg0KDQpPcg0KDQpXaGF0IGFib3V0ICJUb3RhbCBu
dW1iZXIgb2YgQURDIGRhdGEgc2FtcGxlcyI/IERvZXMgaXQgYmV0dGVyPw0KUGxlYXNlIGxldCBt
ZSBrbm93Lg0KDQpDaGVlcnMsDQpCaWp1DQo=

