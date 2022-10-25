Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBB2C38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 15:57:40 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.123])
 by mx.groups.io with SMTP id smtpd.web11.8989.1666713458621374640
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 08:57:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=E2GauM08;
 spf=pass (domain: renesas.com, ip: 40.107.113.123, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idVbGEXLOfnOUTD5V5yPPu8GOCGhm0wSRjKKzT9cyCeKikGcLiwRTtI60W6ecHTALsR3gvbqhjiFT8RxhsRuPM1GOg8GmzFMVcge+o84Z3/bpP7NhvE9VTJTWigIXm8spg+2AzfyCaxv84E8pybGd1iz1lnAKayFlJG4QrzhHEL0B2xlo83BhQIhwwLXbMV1q9hpXi9rkVxwdtnXpMlizI0d8g1KoOp4o7IkBK5LJRXZsgCQa7RgWwsTnBg+6zFKK3QokSmKVH21s2q5TcuefQTo4kzr/W275w9W8iHgq5I4271hKFzwwYCZr4wHdgnAm4FsqRI7HI2X0+Suu29INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjR3jKccCS3u1muWn6c4p5uoSI7Cl6elqzKoWWJ7ju0=;
 b=ew1fWl0PqvL158J/f3HmRY9W3JmRK+/hf7mpF9I/8+C/DSDYE0arZV95jPSsFLuGV3nRH8+CDB1yRGcvhKxSotpfuJOYn5ncmhpJgrMCEJ5D4pmfBWD2NVFbzB5xkAInFlZxpDtB4R+fIfTRMgBkG5YwSac/gw8P3L/3oEZol6Ozl8SJcv+YxCN2R8dGaujNCW5OTwObG2VNlsrk4Aij9Yh6k79KRTGJUG+eY4O90DSuogOHQW9EIH0NeUG/vE3ciizMxszHPNGFwJ2evxUoZO1q7EQWPUtj4YM9yI3pqqOIX2tytwwweG0TcesLe7SuKRp7eG96D2ZFHkyLwjKZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjR3jKccCS3u1muWn6c4p5uoSI7Cl6elqzKoWWJ7ju0=;
 b=E2GauM08mGovN6PZgtX3Cdc8FFW3M4MARi6KcyXbGjueifrk1Vs9Bvs/UukNFdAHIPCWTBER/cTuTguW4kj5IWHDcu2zHskjUDvRIrFL/z/DnUtnOq5fYKnpcBAq2vcUb6fYjtUEHfafBRoYmTTAVav5dADe0y6xi7/aI/ie2lI=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYWPR01MB8432.jpnprd01.prod.outlook.com (2603:1096:400:173::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 15:57:35 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45%6]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 15:57:28 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>
Subject: RE: KernelCI, gitlab testing notes
Thread-Topic: KernelCI, gitlab testing notes
Thread-Index: AQHY5J49/hNqPf6v0Eqj/sxDQHsnNa4fR3Ig
Date: Tue, 25 Oct 2022 15:57:28 +0000
Message-ID: 
 <TYCPR01MB10588638D4BFDFF15F7CB9E98B7319@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20221020160844.GA19694@duo.ucw.cz>
In-Reply-To: <20221020160844.GA19694@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYWPR01MB8432:EE_
x-ms-office365-filtering-correlation-id: bd52f4b6-2e2e-420e-6912-08dab6a19e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UfxppZ99yATqSs2nc4gHYX929wdSNgUsoGypfx5p2Em57yoXE8iRSxikWbX6zkwyr7Japd4uEIPjKtZVXE8TJUQeHbGoyGh80UH9wT4jVU+tOjsrJK7jiIeYSQHWMj9l5UEdc9O0dzYDaqe/TxBO/hyD2pVIv5C+HJFaDLgaR4BNjuzmpkJSosSC/yQOStI/7wR+RMfVt2zxufX0FtfQh2SQGAx4EZehoQRtKGlFrevATLE4ynRxcdgaKyaY9Iq8o9ODdFUWXhBT/yRFsKlMt5WWOLRcFQ4GQMC9obL+kYGXYe2fA2gjUBNPWYqlOAh/vz0qfEp9pOjOLGsCk+KnAFnB+1z1QwzmmH8GlS0QJI7RXKOqp8k5cWb+erGnvSZyVT5SwdtbmvZwz7nyb9xojU4eTegCitR1xDKOIE7njQorj1IHZkv1ceOU8fcesEc6jYl4YxTYL39IjOGRFN+gkUptRAuvSmhvEamHj45X21VjfW0paasC2Tg8dV51RIZtAdMPHQ+mrSXdvMjDxhrEnCHqZXEY9xHTNSk1u+WgczLIN+x6ao+U/1WidMsBzij5uwo3+n7Uge4Roqy4ftprE7hVOJbcrzaz86trkN5q9r+rD3dE8ddi0U0t5jX1qqVpAYdnKgKCVSU6tb5hqm3c/8uVMf6SV/Y0hrSsZlLzRJ8FBAbThDaMRNFweT/TvnHTm531vWdizglU/wxn5SegZoIHCch9fm1Ly6Tswsr+C01DhwAHTEzHPDvMLrLCeHvP1dehFQwrCySbA10RWWU0sLhxO3Mc/0RqN/ir/4l/k6WMi8Y0XDVBIPRg7/00cIk5qVw1dmJ6lwZWXPY+xvn3kQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(66476007)(8676002)(55016003)(316002)(66556008)(64756008)(66946007)(66446008)(38070700005)(83380400001)(71200400001)(110136005)(52536014)(8936002)(41300700001)(966005)(478600001)(33656002)(5660300002)(186003)(76116006)(9686003)(2906002)(38100700002)(122000001)(86362001)(26005)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eVpMUlh4dDkrOHFRUFJuWTNOMFIyK0gzVXc4MjdIRGJ1ZzI5SVBjSjdTbGo5?=
 =?utf-8?B?ektTdjV3bzRicUNDTG9lZk5WY0RyLzdCa3crMTdCZU4zbnlQaUpJZnVWQnor?=
 =?utf-8?B?UjFFcW5KS1dBK0hWc3pqUm1OdTVaT080UEc3dVNRRVlWN0NVVVpiVU5aQUg2?=
 =?utf-8?B?MjljRkhZai9lU2R3Nk1qQVcxMFVoSm1QUmEvb1lHcHFGaWkyNjVKek1KQTI3?=
 =?utf-8?B?YzBpbzlORzVtNkgxeWxtcnJwVDVkcjducTdWYTRuaDR3bTd0SkVMZ3Q5MTNr?=
 =?utf-8?B?ZnJWTWwyQzVDWUpNNkphSTIyckg1T1BlYk5DSHJwUHc1eHVhditsc3JKbE51?=
 =?utf-8?B?SGQ4SHNtUytkNmRTM2syaWpob2tnU3U1OUZKOU1PSlVCVEpaTWZBUVV2aEZ6?=
 =?utf-8?B?Wkh5N0U1YUtXQTNTRmRZRXJsVlhQcXRwdG00c1V3TkVqOGZhWElhbWFhSHFn?=
 =?utf-8?B?Z0k3b3RrVDV3VXlGTE1IMVVDMG5UYkNJQjd5TUlNa2xWR0xGVXI5K0hxZDdj?=
 =?utf-8?B?MGJrcDJVR0VQaTI5MXhTS3VvSE1IT29tUnVsbmZWd1JvQjlTODdORlVnSGc5?=
 =?utf-8?B?RmdwMlJBQThQVU50TTh2SkpmUkwxVjFQcm1UdCtUcTV1ZUgxMUQxVW92NEsy?=
 =?utf-8?B?ejhtWjZYNVl1c2JTU1paY0xXUk1na1AwRGc4b1kzL0xpS1lyU0IzakxOc1pj?=
 =?utf-8?B?RkFiQ2J2citqWlZPdFp4SUNFTU8rZXpTSHUvTGlVeFJIT3R1TzFNRXpreWVm?=
 =?utf-8?B?a1RERGdBR1pmNFpiT1hZUHBhV0RXZ1dGekZMeFU1bFljZ3NCRytQYVF5V2Zo?=
 =?utf-8?B?cGh5amNwamlJcFVkZjJSajZvRnJrY2RaT2hNWTlOelJTd1VSRkJuajRJbUhR?=
 =?utf-8?B?UkpzdS9pRWVRRS94aytKS0dtK21tcWNLOUdjazZQdmlUb3Ayck9ZbFNPUjlo?=
 =?utf-8?B?R0ZDbXVIQWFHQWJVUldwbkVtOG9xeG1QQjRERW85a3V1cWZqWHlQWGdrMS9P?=
 =?utf-8?B?VnROaHFPUWEyTmd1YTBwMlNUKzBsVXlBY1plRVExc20wWlA1SlNHcUJjUnFU?=
 =?utf-8?B?VjlhR1BuUENmenoxOTc0ZDFjR0drTDZhNGM4NjROQTVpYSswUVFaTmRvZUFn?=
 =?utf-8?B?VkZaVndZUzZnd0hrNmFkL1JSSC9FQ3FGOHNmbUhDb3d1V0hxU2cyanU0NWtE?=
 =?utf-8?B?NU5ZZElHUElDbzd1b201aHZJeTdPaldFeURpc1M3UWljaWFxR29zSGZON1Zl?=
 =?utf-8?B?SDZJTVNQUWZyVHZWQ28ybFF4OGFRZFJHY1FScTJzZFo4eFFGTm9memZNV1VN?=
 =?utf-8?B?WGh2dW1NcFIyVkxRNlh4SDRXcHdpVHExelBMWXBTbVRzV0trd1lXb1FDNHBu?=
 =?utf-8?B?a24ya0ZOVlh3TlVDeHpseWNWNXBpRlZraUNSNThpOTNJSWR6bVk2T3pna25L?=
 =?utf-8?B?QnBDSVRFQ1RyVElTNXd4Q3pFTFZnSGJKam92Y2RYWEpKYzY1ZEZQTVd5Wjd0?=
 =?utf-8?B?dzA5eXhic01lQ0QrMVgwdzJ4bkRKVGJSTGc2ZVpBYmhoeDVibXZxdUVuTTd6?=
 =?utf-8?B?OGg2a09zbWZ2M3JmM3A1UUVKdkFHMmU3TDUzKzA0b2FBU0Z0N0twRkl3WmlU?=
 =?utf-8?B?NktaaEY1blZvNDdOVi9IRTlFYlRTSjhlZHk2R3dTbTRqRHlQY1RCSHRoSjd2?=
 =?utf-8?B?NUR6T3hEb1BJQ2ZvVzZIT2s5TE1FcWhvby91YU9KK2cxSWEyeFh6aDVrREI0?=
 =?utf-8?B?OHpIbGl2dlMzV1J2RmRiT0xXYmZkMkZ0TlB6b2F5MlFFNHpjbmVkR00vdnZR?=
 =?utf-8?B?T3o3QW1vOHd3WEQwSDY5WnlkL0MyZkg4RXluTTFSMTVLQ2pyZ0VOdm83VGJD?=
 =?utf-8?B?ZDZXa0g3dERXZEpJbWI2d1pHeE04cEZMZDRjYjdEdEc3VlozWWxCcjM1UTM5?=
 =?utf-8?B?a3dIU0Ntakp4T3A0SE01eU5FYzBlOWFyUllxMGtQQzQwTHFzd0UxTVpsdlpX?=
 =?utf-8?B?VFVFbndlcFVzeUJnK3FGTUkvZmllYWt4eGFzbi9RSUd1cldoR1NpT2srZDd0?=
 =?utf-8?B?ZmNMeTJtbGJrMkJxUUhsUDh5VE8wS09IWlljQ0F5T1J0VG5pYlhVQzhZYlF5?=
 =?utf-8?B?dEkwRWxXak04a3BNSGE3dTRaREFrUHF3RWtmenR1UXFaSUxqREs5bksyVmVM?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd52f4b6-2e2e-420e-6912-08dab6a19e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 15:57:28.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PEEKBdLOu7uCErE1bUUbtJbjU9G3TLdgN4K3bamabunNpoRdlqyOSRJ92eN6eK6h+t8prkemauTp0YXKv6sDN5QVWuJYRgU091YgNFQ2vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8432
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 15:57:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9835

SGVsbG8gUGF2ZWwsDQoNCj4gRnJvbTogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPg0KPiBT
ZW50OiAyMCBPY3RvYmVyIDIwMjIgMTc6MDkNCj4gDQo+IEhpIQ0KPiANCg0KWy4uLl0NCg0KPiAN
Cj4gKiBVbmRlcnN0YW5kaW5nIGdpdGxhYiByZXN1bHRzDQo+IA0KPiAraHR0cHM6Ly9naXRsYWIu
Y29tL2NpcC1wcm9qZWN0L2NpcC1rZXJuZWwvbGludXgtY2lwLy0vam9icy8zMTg0Njk5MzYwDQo+
IA0KPiBPaywgc28gd2hhdCBzaG91bGQgSSBiZSBsb29raW5nIGF0Pw0KPiANCj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gMzc0QWxsIHN1Ym1pdHRlZCB0ZXN0cyB3ZXJl
IHN1Y2Nlc3NmdWwNCj4gMzc1LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
Mzc2LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IDM3N0pvYiBTdW1tYXJ5DQo+IDM3
OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAzNzlKb2IgIzc2MzE0MyBGaW5pc2hl
ZC4gSm9iIGhlYWx0aDogQ29tcGxldGUuIFVSTDoNCj4gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0u
b3JnL3NjaGVkdWxlci9qb2IvNzYzMTQzDQo+IDM4MEpvYiAjNzYzMTQ3IEZpbmlzaGVkLiBKb2Ig
aGVhbHRoOiBDb21wbGV0ZS4gVVJMOg0KPiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2No
ZWR1bGVyL2pvYi83NjMxNDcNCj4gMzgyDQo+IA0KPiBJIGhhdmUgc2VlLiAiSm9iIGhlYWx0aDog
aW5jb21wbGV0ZSIgYW5kIHRoYXQgaW5kaWNhdGVkIHByb2JsZW1zLiBJDQo+IHNlZSAiQWxsIHN1
Ym1pdHRlZCB0ZXN0cyB3ZXJlIHN1Y2Nlc3NmdWwiLiBJIGd1ZXNzIHRoYXQncyBvay4NCj4gDQo+
IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAta2VybmVsL2xpbnV4LWNpcC8tL2pv
YnMvMzE0MTAwMzg1OA0KPiANCj4gTm93IHRoYXQncyBwcmV0dHkgZXZpbDoNCj4gDQo+ICogMF9z
cGVjdHJlLW1lbHRkb3duLWNoZWNrZXItdGVzdC5DVkUtMjAxOC0xMjEyNiBbZmFpbF0NCj4gMjY2
KiAwX3NwZWN0cmUtbWVsdGRvd24tY2hlY2tlci10ZXN0LkNWRS0yMDE4LTM2NDYgW3Bhc3NdDQo+
IC4uLg0KPiAyODgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAyODlBbGwg
c3VibWl0dGVkIHRlc3RzIHdlcmUgc3VjY2Vzc2Z1bA0KPiAyOTAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAyOTENCg0KWWVzLCB0aGlzIGlzbid0IGNsZWFyLg0KV2hhdCBp
dCBzaG91bGQgc2F5IGlzICJBbGwgc3VibWl0dGVkIHRlc3Qgam9icyBjb21wbGV0ZWQiLg0KVGVz
dCBqb2IgPSBMQVZBIHRlc3Qgam9iIHRoYXQgY2FuIGNvbnRhaW4gbWFueSB0ZXN0IGNhc2VzDQoN
Cj4gDQo+IEZpcnN0LCBtYWtlIGl0IHN0YW5kIG91dCB2aXN1YWxseS4gW3Bhc3NdID0+IFtva10g
YW5kIFtmYWlsXSA9Pg0KPiBbRkFJTFVSRV0gb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gDQo+
IFNlY29uZCwgc2F5aW5nIGFsbCB0ZXN0cyB3ZXJlIHN1Y2Nlc3NmdWwgKGxpbmUgMjg5KSB3aGVu
IHRoZXJlJ3MNCj4gZmFpbHVyZSBpcyAuLi4gY29uZnVzaW5nLg0KDQpBZ3JlZWQuIEkndmUgdXBk
YXRlZCB0aGUgd29yZGluZyBpbiB0aGlzIGNvbW1pdCBbMF0sIHBhcnQgb2YgYSBkZXYgYnJhbmNo
IFsxXSBJJ20gd29ya2luZyBvbi4NCg0KWzBdIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVj
dC9jaXAtdGVzdGluZy9saW51eC1jaXAtY2kvLS9jb21taXQvZjI3M2Q1NWIxYzc4ZDgwZjJlNDRm
MTBjYTIyMzM0ZTY0ZWViNDYxMw0KWzFdIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9j
aXAtdGVzdGluZy9saW51eC1jaXAtY2kvLS9jb21taXRzL3BhdGVyc29uYy9jaGVjay10ZXN0LXJl
c3VsdHMNCg0KQ2FuIHlvdSBsb29rIGF0IHRoZSBuZXcgb3V0cHV0IGluIGpvYnMgaW4gdGhpcyBw
aXBlbGluZSBbMl0/DQpBdCB0aGUgbW9tZW50IEkndmUgc2V0IHRoZSB3aG9sZSBHaXRMYWIgQ0kg
am9iIHRvIGZhaWwgaWYgdGhlcmUgYXJlIGFueSB0ZXN0IGNhc2VzIHRoYXQgZmFpbC4NCkhvd2V2
ZXIgSSByZWFsbHkgZG9uJ3QgbGlrZSB0aGlzIGFwcHJvYWNoIGFzIGl0IG1lYW5zIHRoYXQgbWVy
Z2UgcmVxdWVzdHMgaW4gR2l0TGFiIGNhbiBuZXZlciBiZSBtZXJnZWQgaWYgdGhlcmUgYXJlIHRl
c3QgY2FzZXMgdGhhdCBhbHdheXMgZmFpbCwgYXMgYWxsIGpvYnMgbmVlZCB0byBwYXNzLg0KRS5n
LiBTTUMgdGVzdHMgd2hlcmUgdGhlcmUgaXNuJ3QgYSBtaXRpZ2F0aW9uIGZvciBhIHBhcnRpY3Vs
YXIgQ1ZFIFszXQ0KDQpbMl0gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0
aW5nL2xpbnV4LWNpcC1jaS8tL3BpcGVsaW5lcy82NzY1NDU5NjgNClszXSBodHRwczovL2dpdGxh
Yi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1jaXAvLS9qb2JzLzMxNDEwMDM4NTgj
TDI2Mg0KDQpUbyBhdm9pZCB0aGlzIGlzc3VlIHdlIGNvdWxkIGNyZWF0ZSBhIHNlcGFyYXRlIGpv
YiB0aGF0IHJ1bnMgYXQgdGhlIGVuZCBvZiBhbGwgdGVzdGluZywgdGhhdCBnb2VzIHRocm91Z2gg
YW5kIGNoZWNrcyBmb3IgZmFpbHVyZXMuDQpZb3UnZCB0aGVuIG9ubHkgaGF2ZSB0byBsb29rIGF0
IG9uZSBHaXRMYWIgQ0kgam9iIHRvIGdldCB0aGUgZnVsbCByZXBvcnQuDQpJJ2Qgc3RpbGwgbmVl
ZCB0aGlzIGpvYiB0byByZXR1cm4gYSBncmVlbiB0aWNrIHRob3VnaCBpZiB0aGUgYWN0dWFsIGpv
YiBydW5zIHN1Y2Nlc3NmdWxseSwgZXZlbiBpZiB0aGVyZSBhcmUgZmFpbGVkIHRlc3QgY2FzZXMu
DQoNCkRvZXMgdGhpcyBhcHByb2FjaCBzb3VuZCBva2F5Pw0KDQpPZiBjb3Vyc2UsIHBlcmhhcHMg
d2Ugc2hvdWxkIGp1c3Qgc3dpdGNoIG92ZXIgdG8gS2VybmVsQ0kgZnVsbHkgYW5kIG1ha2UgdXNl
IG9mIHRoZSBmZWF0dXJlcyB0aGV5IGFscmVhZHkgc3VwcG9ydCBzdWNoIGFzIHRlc3QgcmVncmVz
c2lvbiBkZXRlY3Rpb25zLg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoNCj4gDQo+ICogTFRQIGZh
aWx1cmVzDQo+IA0KPiBJJ20gbm90IHN1cmUgd2hlcmUgd2UgcnVuIHRoaXMgb3IgaG93LiBBbnl3
YXkuDQo+IA0KPiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi83NjM0
NjENCj4gDQo+IEkgcGlja2VkIHVwIG9uZSBmYWlsdXJlIHJhbmRvbWx5LCBhbmQgdGhhdCdzIGNv
bmZpZyBmYWlsdXJlLCBub3QNCj4ga2VybmVsIGZhaWx1cmU6IHV0aW1lbnNhdDAxIDEgVEJST0s6
IGNhbid0IHJlYWQgL2V0Yy9zdWRvZXJzDQo+IA0KPiBOb3Qgc3VyZSB3aGF0IGlzIGdvaW5nIHRo
ZXJlOiBxdW90YWN0bDAxLiBEbyB3ZSBoYXZlIHF1b3RhcyBlbmFibGVkPw0KPiBzeXNsb2cwMSBh
bmQgZnJpZW5kcyBpcyBhbHNvIGZhaWxpbmcuIElzIHN5c2xvZyBjb25maWd1cmVkIGNvcnJlY3Rs
eT8NCj4gDQo+IEkgZ3Vlc3MgYmVzdCB3YXkgd291bGQgYmUgdG8gcnVuIGx0cCBvbiA0LjQtbWFp
bmxpbmUsIDQuNC4zMDIsIDQuNC1jaXANCj4gYW5kIGNvbXBhcmUgdGhlIHJlc3VsdHMuDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJUGF2ZWwNCj4gLS0NCj4gREVOWCBTb2Z0d2FyZSBF
bmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5rDQo+
IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVu
emVsbCwgR2VybWFueQ0K

