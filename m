Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7634C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 09:54:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.56529.1715594073034219196
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 May 2024 02:54:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44D9sUQV1418906; Mon, 13 May 2024 18:54:31 +0900
X-Iguazu-Qid: 2yAblVO8EL1eOV4Fd2
X-Iguazu-QSIG: v=2; s=0; t=1715594070; q=2yAblVO8EL1eOV4Fd2; m=22v89JhHV+9MyZVnAjCrmjACKeugsGmHW+W8aUUHK58=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 44D9sTL64058682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 May 2024 18:54:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAmuJE14XFVBq49WnqyKLkScVon+Mt2XfeIyJ0SW5T9yAqJJYh+gmb6iQgWkpcEPunIO/6SPvXYAA3bdWzsQrnQGTNTMc/7192LxIdWuNtA9zvLPR0KgeCm5JXoNMa/OmuoFej7YnLi0zL0IUE5qZh/w7LXnemm114BjWywseQjgxzs8JEpwG4DBeUpLv7ceYZ+ishgzYe8hXyaInlxAnrktPb9136eqp5kzTR2AZWcXgCcHSGPljk/0TeTkhTwku9QxFgFtcMBtOTepbPcFdZp6Jz/SXOaqKCIC0qBknBd6XNATIo0ixP9BvEwavTctIUwRc7LYlDC8z1/q457jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j1cATProFJMPO1c6IIiVbDBhi+k4bCa2zSlB6bokA8=;
 b=SjrPvu8ihBPnoq/+NBOrzl7G213o35icYUgopbB+JeU3dUD6w3v2B8HytYfg8Y+VTponERhFUxYwglP5qlf3IGOwi/5SQVyNVHPpUv2m5cCaHzpd4Du/T5i8y7/1SInHlU0B8MWRHcra8+xqRJyh6UW0f1r/k+2g+730yzgM0Ytflt+qJftNCj8lDdqEoivvx4586k4uyoKccByhku0wayobocgaLAzvTEGUdhE+bU3T8aGDbKr5gYEBO3E0VW+k6vALucUBUD//v/Qa7sZxY6ZsySc91yzQuXAOkZ5zR6aSOVXCgS+QoYCcegdZYRFqkd9mWocuoUsgUj0dV/7k9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <Adithya.Balakumar@toshiba-tsip.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: isar-cip-core reproducibility pipelines
Thread-Topic: isar-cip-core reproducibility pipelines
Thread-Index: AQHaoug/sQ1ECt9jNUqOznGPM9x2A7GU7cVQ
Date: Mon, 13 May 2024 09:54:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385F8722F6CCB6B7B711DEDE1E22@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: <7e896b03-0217-4a7b-a856-0ff2a51097fd@siemens.com>
In-Reply-To: <7e896b03-0217-4a7b-a856-0ff2a51097fd@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYYPR01MB12403:EE_
x-ms-office365-filtering-correlation-id: 786bb00e-1a70-4a84-c4b8-08dc7332ad59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?REx3Q2FPUFhqOGcrdEpnWjN5eTNQa28zY3JoK3pyYW05ZGxIUVJPM0Yza211?=
 =?utf-8?B?ZkFhNXFISnJrQnNwYk13WG5yU0YzenhrOXl2bmJJcEFOOGhxYzEzRHVuRUNw?=
 =?utf-8?B?V20zVm9xak83RUFONFVZNkxkUEp4L0tKTE9FN0grZmhLUE5xV2k0YzMrRU5z?=
 =?utf-8?B?ek1DODhmRWZZNktDemlNU2tibWJtS0VLRUFGSWJNaE5sMXp3Y3NDVFduMy9O?=
 =?utf-8?B?K015TlFXZlg1akJ1WjhpTldMaUZ1c3Y2cXhEMzhTSnJaYnUzbFlOOWdwTHpS?=
 =?utf-8?B?b3VsMnBVMzJLSnp2NGJ4eHo1YWJ3MlV5L0Fqd093VmZUcFpEWVZ3MDMxZkcz?=
 =?utf-8?B?MjhlUENnT3dNWGtBejlMbkJVQnJ5V2JMUk1nakJqdWFWTHVPblVKY3Rrdjg3?=
 =?utf-8?B?OFVpTUdRU0VGYk5qTm9jdkROQ2JpbFZRL2J1TStDanZqUFVjWHZ2L1psTlhG?=
 =?utf-8?B?VDdBN3ZrcDBJOTdyQnZrTmFGWWkrTlZFN2RNUzQvYmFJakNRRSt2Q08vbXNa?=
 =?utf-8?B?MDNTbi9mV1NXdTRoRlBydVJYdDdrVmRyM2dJd3d6dVpUK20wcFJzR1NJMVlZ?=
 =?utf-8?B?ZWNoZlV6KzBhR3ozKzQ1TlcyOVZpZXJTbHZCendzOXVNU0toTm41YWJtUHBi?=
 =?utf-8?B?Qy8wRnZwcTRMUjRoU3g2b1JDQXltUEkxTjZ6ckpBaGp0MWdoYzJlQXFmVGtl?=
 =?utf-8?B?QTBuaVcrWjFrTkZoL2Y1VWRucVBtWjRSWjV6N2hWbmp4b1cwdVpqQjBpS2U5?=
 =?utf-8?B?NCtUaElzbWtKd0VHaEo3V1RYZ1BkYWlOQTJVeSs2ZjU2MXBjalBFUkhuOGNp?=
 =?utf-8?B?azBWQWV2S25MNmUvOU11cWpxTnI5WVk4SFVRankxaGVJSDBYazQ5NnVNSE00?=
 =?utf-8?B?STBUQU9EYklPOUhQYjdPRDFoYWppelA3UHNMdWl5d3VJTndsY1R0cWtqY2NI?=
 =?utf-8?B?Wk41UWIzeFVNNG9OQXRlVmtJSHB5ZDNHWjVqNUs4WW0rNjZZTkRuL3RGS2Ru?=
 =?utf-8?B?bEFFZXJvcDJGcFhWa1VZaGoyc1VpbVJSNkpBMDI2WDRBcDBBWlhvODZJZ3Rl?=
 =?utf-8?B?VTF1UkFXaXJqS1FlYXBKZ05iNlJHZmNtRGF3dzhzZ0c1UktoY09OYkdpZm9p?=
 =?utf-8?B?dXpEanhONENhV2t5VjJUY3J1bElXVzZwN3VWSjBwY2FKQXNNcDJyK1ZPZmt5?=
 =?utf-8?B?U2t3VWc3MkFJTkNsQS9yMkhrUzZWSFZYSkZLaHRKdEdZL0U4ZGJEdmRacG5G?=
 =?utf-8?B?YnJJVXRXb0gzY1p2NW00KytyY1BmY3p1RW8vZTRZZndnQ0UzaHloN1QySDBH?=
 =?utf-8?B?YWlFbW4veXR4U25wS2FqSkFsS004ejlQa0cvaWI3djVzUXdDYlA2Ly9SYjha?=
 =?utf-8?B?b1BlR29penhvMzI3WXJwUlRONEl3ZWd4azUxRTJuaDQ0cUdHbWNLMVRWTjdN?=
 =?utf-8?B?L2hIbk9TQ1JScnlSSk01RnNDK2RZWDBZbVlNYmFTL3h0UmhMbG1jYWVIVUEz?=
 =?utf-8?B?N3kraEdsUmlKUTA4V2ZYTkxid3dOaWhYcStXdSswZDNXQXdhWFg1bTNUQ3d6?=
 =?utf-8?B?U203WHErSEc1STdwT09KWEdVMzJUdWY4QUltTGJsa0V0Sy95NTdBTml4dGNm?=
 =?utf-8?B?UnltRXdVUUphTjgxdHlGaTV3RlFGRm9yZHNMTjRuOS9IOXBNcGxtSjI0MEFE?=
 =?utf-8?B?S1ZSeHpvOC95di92UTFtbE8wZDdMSDR0YWNOdEcyZXZZWDl0QVJQeU1RPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SlU4bUF4cHpvZEh5elk4WWNDWHVDdTU3YUd0a1NMQUFSWnBCSUY1bzBONmtE?=
 =?utf-8?B?eFhzd0NZVkpCNDc3RFRTY1hHU2p1eHM4TXNBdUN1dEFEaXhzVnB4dENpMmNJ?=
 =?utf-8?B?dndsYTlpMmsyekN4T3VOZFk1ejBLL2pBZlk4Sm9iZWJrc2JCQjByTDJCZTc0?=
 =?utf-8?B?SXpTYmFPWThXdUExeFRiUjNBY0M5TUdvT0FXMy9vYzVVL1Rsdks5NjhzdmJT?=
 =?utf-8?B?QlhzZWx6a2NCL3ArQ0J6a3hYS3ZLaWpwMDFPOCtpMWpMa0ZkSUdTaXRqOXNQ?=
 =?utf-8?B?c1l1UUMrcXAzaERQQ1ozU3RlUCs1czVvQlNKVlEzM3Y3ZGRLOC9RdmlvYVI3?=
 =?utf-8?B?OUpyelRlWnFsZDdsQVhzUytDdmh3U3drZEFZQWNXTE12ZjJrOENxa0VGdWdH?=
 =?utf-8?B?MWFXTUIzeTZERThwVUE3alphK2lzUnhyZ2c3Z0RiL1JnTzhlZEVmQ3Q1SjZo?=
 =?utf-8?B?VWpOWmN6VHlxdWluM1JjS2pLVlJrMmFSRFBkUm9PV3EvWGdudGdES0Q3V0l6?=
 =?utf-8?B?TFFnbUx1SHBNYkRhaEo0TjU4dVRQbWppeWQzZE51bmVySHJMZ3FZZWdzTVBw?=
 =?utf-8?B?Y1VLcHoxUDkzWGZUTURPa3kyMmdLTFhBa01hQnkzYzZIeFBWN29sUVpmSmRP?=
 =?utf-8?B?RjAwTjVpWUhqYzhpb0MzMWNIZmdrSXhGWjVubHRRb1ZBck5YamFobEJSU1Vj?=
 =?utf-8?B?ZGxDcGk3YzU5clpMR3RxaEN0aHdZY2pTRWc5S1RMUWI1aDRPL0lPbFQvM05G?=
 =?utf-8?B?UVZuUjdCSmk5RlhGTGd6Tk5KTjRkL0dhUDc1S1BuNmYzQm5jbnl4aEo5YXRQ?=
 =?utf-8?B?aGxuam1tS3FPdXB6d05Nc1VtaWlSa1gzYkdkTzFaTlZYekVDQ2gxNmNRL3lF?=
 =?utf-8?B?eXZVTU5XUzYxeEQrYWtoTk5lSUhSbk1YYk5ETVBxUkpBeDArZWc0UkU1SUFU?=
 =?utf-8?B?Rzc4TUU4VVpYamNCVm5FS2lRU2tYY1hpQ3VyQ0hFT2xjQlYyWHBuRDVFOHRx?=
 =?utf-8?B?VnNBSlY1MldSaC9Dd0FDdlRQMTRsTHdJZ21iTFlVWldzWGhTbkpnQ2UvZ1NN?=
 =?utf-8?B?QjA1UGJUcGdSL241QkJSZkpDNnJYMHNvSDJ1WGxkQU04QWlIMzBLckxnd0dz?=
 =?utf-8?B?Skp3aTEySFliZEV6R24zMmxhZ3RqUjVYSnBKQXhMazFuOWxFV25sWGFkMlpW?=
 =?utf-8?B?V2lpUytSbXBKV3R5UW8yMmk5MUt0alZoeVZZaTNqdDdCUWs3eDBXZFltbVRm?=
 =?utf-8?B?QnNtZEYvSUZLRXNhSWdieHFOZzFMWGZwb2Y1LzZsdnBqcUk2MlB6NE9aSkQr?=
 =?utf-8?B?MjJ4TkgwT29EVk5jeFh5WWtWc3I5a0FRbGpMWlF5Q1N1VytiT3ZYWFdCaGlm?=
 =?utf-8?B?UVlFa2ZOdFJCaFRuaHFQcW1DeVlydEc5ZUI3MHFSaW1DdTZqbDBWVUNQNkhS?=
 =?utf-8?B?b3VYMS8rNXBQNnM5OWVWNkJ1dGwxbzFrZlBvNjVPZlduVkcxR3FJTGhPRFh6?=
 =?utf-8?B?bmo3b21TbHpNMHg0Tnp6NUFFS293STJ3Qmd0OXAxc0w1WnlhWW5sMGVPVk1Y?=
 =?utf-8?B?YTQ3QlhqNzZSdGNZemhnRDRmTzBuQ2xGSndtRXlDeWZ2TVM1ZzFicTdOQ1la?=
 =?utf-8?B?YWtRTGU4K1d0dVJHZHF3cjFJRlU3UFZUYU1reERlRFpXV2lBcTJCM1E0R2Ux?=
 =?utf-8?B?Vy9DZWE4R1g3TmhBY1V0Qm1ma0g2eWZSTTI2WVpYRzJrY2RTd1hzZDNseUF1?=
 =?utf-8?B?YmhXSnFQbCtNK0NJNXJxSjVLZGZiTCs4QUhuZkt6anNkbWkyWUQxTHd5UUEz?=
 =?utf-8?B?aU43Uzl0VVNieVp2bGo2NWI4bDN0V2hRSHlDSVdFRjZWZmg4S3g4MEdBQU1E?=
 =?utf-8?B?ZEtuak1ncWdrWHIvUWNQUGdGalVXNTFoRUROM2ZLM20vdU1iNjZIVjM2USt4?=
 =?utf-8?B?emxNRjZBZ3NjNGowMlZXSi9kVWpEZ3VWYkQwWjlHR1pwU3hidUdvMS9zZ1JR?=
 =?utf-8?B?c2JMVXo0K1pneEc2ZU1yODNrVWVoSzZxdEVEdllQWG85OUZKZmZNSGFLVTQ2?=
 =?utf-8?B?WEQ0YmZJcVNUZ1oyK2swMisvMitRSFdJWHRNRnVvTEpnS1pScmpSbHZJWVhq?=
 =?utf-8?B?emNudFdObTRzb1FDZ3hXS1FyN0JBNVNDKzY2SEtZSjJ4QW55eTJJZ2hOL1dP?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786bb00e-1a70-4a84-c4b8-08dc7332ad59
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 09:54:27.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjfU4VvZBT8YjLSoEA/zkMbRmeZtvIce0t+/6CgEoXfk323hRMlrtLwmfKlXc0XxnBKdlQaOhqzzlvF/cLBT2wxdcVmbRT31D/dtwtDSZIHjVCasFqAROTGBxOIkYmLl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 May 2024 09:54:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15885

SGVsbG8gSmFuLA0KDQpUaGFuayB5b3UgZm9yIGxldHRpbmcgdXMga25vdy4NCg0KPiBIaSBLYXp1
LCBoaSBBZGl0aHlhLA0KPiANCj4gRllJOiBJJ3ZlIHRha2VuIGNvbnRyb2wgb3ZlciB0aGUgd2Vl
a2x5IHJlcHJvZHVjaWJpbGl0eSBjaGVja3MgWzFdIGluDQo+IG9yZGVyIHRvIHN3aXRjaCB0aGVt
IGZyb20gbWFzdGVyIHRvIG5leHQgLSBlYXJsaWVyIGNvdmVyYWdlIG9mIGNoYW5nZXMuDQo+IFlv
dSBjYW4gdGFrZSB0aGF0IGJhY2sgYXQgYW55IHRpbWUgeW91IG5lZWQuDQoNCk5vIGlzc3VlIG9y
IHVzLCBhbmQgaXQncyBiZXR0ZXIgdG8gYXZvaWQgdXNpbmcgbWFzdGVyIGFzIHRoZSB0YXJnZXQg
Zm9yDQp0aGUgIldlZWtseSByZXByb2R1Y2libGUgY2hlY2siIHdoaWNoIG5lZWRzIG1vcmUgdXBz
dHJlYW0gZml4ZXMgKHNlZSBiZWxvdykuDQoNCj4gDQo+IFRob3NlIHRlc3RzIGFyZSBhcHBhcmVu
dGx5IGZhaWxpbmcsIGJ1dCB0aGF0IGFscmVhZHkgYmVmb3JlIG15IGJ1aWxkDQo+IGNoYW5nZXMg
aW4gY3VycmVudCBtYXN0ZXIuIEtub3duIGlzc3Vlcz8NCj4gDQo+IGNpcC1jb3JlLWltYWdlLXNl
Y3VyaXR5LWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1kNjQud2ljLnA2KGhvbWUsZXh0NCk6DQo+
IE5vdC1SZXByb2R1Y2libGUNCj4gY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHktY2lwLWNvcmUtYm9v
a3dvcm0tcWVtdS1hbWQ2NC53aWMucDcodmFyLGV4dDQpOg0KPiBOb3QtUmVwcm9kdWNpYmxlDQoN
Ckl0J3Mga25vdyBpc3N1ZS4NCkFzIHdlIHJlcG9ydGVkIGluIHRoZSByZWd1bGFyIG1lZXRpbmdz
LCB0aGlzIGlzIGFuIGV4dDQgcmVsYXRlZCBpc3N1ZQ0KZm9yIHdoaWNoIHdlIGFyZSB3YWl0aW5n
IG9uIGlzYXIgdG8gdGFrZSB0aGUgcGF0Y2hlcyBmcm9tIG9lLWNvcmUuIFsxXQ0KDQo+IA0KPiBJ
J3ZlIGFsc28gY2xhaW1lZCBWZW5rYXRhJ3Mgb2xkIHNjaGVkdWxlIGFuZCBkaXNhYmxlZCBpdCAt
IGl0IHdhcyBzdGlsbA0KPiBhY3RpdmUsIGJ1dCBhZ2FpbnN0IGEgc3RhbGUgcGVyc29uYWwgYnJh
bmNoLg0KDQpXZSBjb25maXJtZWQgdGhhdCB0aGUgc2NoZWR1bGUgInZlbmthdC9yZXByb2R1Y2li
bGUtdGVzdCIgaXMgbm8gbG9uZ2VyIHJlcXVpcmVkLCBzbyBJIGRlbGV0ZWQgaXQuDQoNCkBBZGl0
aHlhIFBsZWFzZSBjb3JyZWN0L2FwcGVuZCBpbmZvcm1hdGlvbiBpZiBhbnkuDQoNClsxXSBodHRw
czovL2dyb3Vwcy5nb29nbGUuY29tL2cvaXNhci11c2Vycy9jL0t3RUd1dkZkY2U0DQoNCkthenUN
Cg0KPiANCj4gSmFuDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0
L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9waXBlbGluZV9zY2hlZHVsZXMNCg==


