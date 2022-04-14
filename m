Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217E6C3A59D
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.5816.1649894835831868436
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 17:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 23E076S8003556;
 Thu, 14 Apr 2022 09:07:06 +0900
X-Iguazu-Qid: 2wHH6X4jz8uWXpXS2G
X-Iguazu-QSIG: v=2; s=0; t=1649894825; q=2wHH6X4jz8uWXpXS2G;
 m=1mN2VVPCHTb3uX/e+VmyP6wyh2diX8Nzu8sLBOI3DGE=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 23E074o7031542
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Apr 2022 09:07:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzzjLVfeAEPgY3sI4/3db37JIfupzAjo7guCI66UxYs2tRyVnbHJ0soR1mP6v6L23Q1ZcST+U2NvXG7h3vcFow9qYDbDnxa1V2i9cAmEQ+92whTGDimOX1vM6KD6vqtfYoHGLeBId2n5Hueund/Cj2xhc8JPgeaG7hjNTDjN/FIrs2GTO1cq/vlJ1GVffQl3vCpjz6wdgPMtojD2wUsUAlIsz40WhZDdE7avj02x9GXNn4tMOEpgkF49UP0pBwNVJZnjdtnRHlE6nTKNUmzeUuWLOnB6qazwMi9kLCDaa3QB7VWuTjKJv2l8ls9wmvb2k0bXOQ/4ixdZ9m7x2SETrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAM+1kLTDcDlc92+mhCNBxl8rqBpj5AZ9YSfnVSdHGM=;
 b=PCE1udTLGnUmZMWUd3oT6xbYSkbqFPMav9AvgA6/00mTpTX9+7OzrZpQo/lxZ77quJSh+95YM2PastHfRWfg60UZXi0ugzWgjHG81I/KG1yTzGCDiISyfiHaVo08dUiyOWCwvdXA6oqnX3bqeVeRhaRLQ710xb94zpO9QsXpqpz8Xm03/FwRo/gqdw2gIVfr1XVsbIFu/sgxSJ6aypApVYh4PqjumkWyedsUGO+RsQ5AWg6SUZhF7J4NneP9LKeXSoFQsyNuzBxG2nRrv8xeCdaJ+qFQ5K0s1+2koQd8x6JTDYDdartX4zJR+qHFlq9DKAswzoeMDzECH5H2ABMMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHYSl7P2JD3ml0h1EumoNr2UAwCZaztmG8AgAD4huA=
Date: Thu, 14 Apr 2022 00:07:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942026F2F1D20AE6CA02CBFF92EF9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <76860af5-c727-1ca9-a572-ef505ed51aaa@siemens.com>
 <20220407090607.GA20233@duo.ucw.cz>
 <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
In-Reply-To: <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0fbce5b-4ac2-4d23-ac03-08da1daab3bd
x-ms-traffictypediagnostic: OSZPR01MB6956:EE_
x-microsoft-antispam-prvs: 
 <OSZPR01MB69566AF9E8C16C41B0052CA592EF9@OSZPR01MB6956.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Mg3piR2Dz+rbIhxPIANu0l883q7lYhWTPDNSMBxnXU35qwPvrKTAMLfIbLkHHTy7uuG7lTxa9gzlxMX/d8JV7ZSqmobesWuDrKxydAkF0wxhjpKn/eRRryi0+DREoZhrBo18tF4jbYNzeVjSaVfZ7R+a237J/rdnTA+upeXm5OsKR7uWmdWvF+u2v4AwAzpfImHQcPyB7KOu5mTYKOjaDoB7d+AF5ZFFRsFi9sUNPpIcISu9hbiM+ePrgwrGww09oebPpoLubL/3jnfQBOeYQjrOunub8UoKb1uxxntP2PGW5PvdqXNjhohTgXjKgZ+1upBkpATfyrN/H0w6sx61858QCxa3SJtEpY4mQq+jDbz1ijyoTlBo2CHnEptlVljL6+tVGETwvUy1N0YUR6EhOIwKGBkOHSr1NiUYNOJrNeFRzTZAVYsl3SMxgul79oRh0zG1JYpdlAYv/y98HthMrWSBv4HYrE+8AQHbl70VDPvYQkVX7CFJ3Djv6J94TnDu2VE4T5TAOt4w6Kw/6B/zJNNgZupztjHUPWihJw1bDTxYQCiiDBq2QTstQcLngauMCsSQiWJzFogU1o2sEMeOkCHb8faPVKT6M+dZod571joz9HIB64gQuC1ylH0EXVNmsXX6AbkeuhY3pSPU57ROvA2UlAgfEG2SPU6QnoQ/EW8aCBcH4R4PYfvEn7dy8j4vAKDxyFr/cZ8mjYEHSq4xpCBw2lo+Rb/ptO9s2Q/DlMmdbGIlj/T03javEHlwGsJbZTtEDiPLsqFqIwjqo1r2x9L7sxjzAqZ7g4B6fwYoHXM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(71200400001)(38070700005)(110136005)(26005)(86362001)(122000001)(55016003)(66476007)(966005)(316002)(2906002)(508600001)(66446008)(64756008)(9686003)(8676002)(52536014)(5660300002)(8936002)(83380400001)(55236004)(7696005)(186003)(53546011)(33656002)(76116006)(66556008)(66946007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a0FzdmhsV0wrWEk0a0ovUENHT2R3SnBYTHg1UzEwZXZ6N21HaGVoY09mbzZa?=
 =?utf-8?B?MXJCblByUkRhS3VlRHZ2ZklSM2oxTXF1cnphN1ZLck9IWXRHQ3dWKzh1cjJx?=
 =?utf-8?B?dWNDMllBc2lkUTFjeUcxRytiRE9pSXZlTnRlY2NCZTNUZTA5dG5DU1hIbzlW?=
 =?utf-8?B?cmVSNFdWcHFxNmQvekVkZGRiWTBPSktvclRDcm1BelBTWUpXQzA0NUFTbmpW?=
 =?utf-8?B?aWhCRGRSNUJpbHczYzJjRk4veUUrY2tMZTVFejZuZ0lhWGdRN00yV3c0Lzhl?=
 =?utf-8?B?TlE3TjlzYURKbTNvUzN0b1RTdlRWQWNDbFhaMkI5MzVDQ0NTK3JhNStkck9i?=
 =?utf-8?B?RmJYQmJrUzBpS283eDlLT2FPLzFKSW5HN21saGs0c2dJM0tPR0pVTXgvekda?=
 =?utf-8?B?MHcvcklLT2k2ejcvcWdlckZ0OVcydGhqU1lUMW5veWFubnlhSURMTGFxRnZQ?=
 =?utf-8?B?WkpuaUJWQ3R2OGxCWUxnMmR4a0piaVZTdW96UlpPcmMwS3pHOXpKVGFFUWh3?=
 =?utf-8?B?SmNJWVlUdUdxY1ZDNkp1dk5hZ01qZjgrUWRKSmNnTEZiNURmQnQ0QUpHMTdm?=
 =?utf-8?B?eUxBcXBydUtWVy9VR2NhRlNOVFZsRGlPVlpCWjVyQ1N3UGl5aWVjc04yOExk?=
 =?utf-8?B?Y0xFUFhzM0ZvbVBScG5jeTFoS0lBNnY3Z0dkTDZQeWc0SGVnS2hXL2h3NlZx?=
 =?utf-8?B?ZTRGM1UvNFNpc1B5TzRqSko5Qk1KKzJ2OUsrY1BRbmF1NDFQLzhCQktYR053?=
 =?utf-8?B?dVRlKzNScFJ1ejBLeDZtZTNQVmhnZzdVdVhSZlFob0l4aEFvMGxTWUc3TjNy?=
 =?utf-8?B?NUNPQUtYV3FkbVRwZ0V1dmxRTkU3OHNPQXNnN05iT1VjZ040VmNIN3RVdHVR?=
 =?utf-8?B?UFpXcjB5OFNmZ3dHbXJkWUdwN3RLR3Zza3dPdGpCczhuZlhvS3lqdDMrWVNp?=
 =?utf-8?B?ZXFVd1cyb0Npb0RXRGZ4SnFzTVBSVnBXVmZ4MEZnUSsvM1E3eklBTVJVVEVW?=
 =?utf-8?B?cGFJbkt2RVdlQ1V3NWFJcDBRYjZQQkFvdnJ1eTZKL1NYV0JXRXB6NWxLNGFh?=
 =?utf-8?B?K1V2MXNkWFhPRVZLV1ZERGZjRUwxdXlzVW1EL0JUK0JRdFc1Mm1IRk9NOWRL?=
 =?utf-8?B?eGp3NEhRRzh6dWhoZC9MS1JySkZqK0h4RXdydWJLUWJJLy9BajBFTFZpUWJ4?=
 =?utf-8?B?bkdybzM0RjJYMk9NS1c1b1RPQ3ZGMHh0Y1ROYjZhZjl0SUhOb0lOb25kYUN5?=
 =?utf-8?B?NGJ3V3RWeVZqUElrWndNYkNwc2Q3YnhvMXFVZ0xQSE5mRE9kT0sxd1FRYXhr?=
 =?utf-8?B?TFdjak0vcW9FQ3hUTGxONHp0d3hzV2ZWVHFTcmVZTGxsenV1SlNSenQ3Sy9W?=
 =?utf-8?B?aFlpdXN0V0V6Wm1PaWJJUkNNNVNPOGhadGhlQSszZTdGdjhnanozRnNHb3hO?=
 =?utf-8?B?S3JqMkI1MGFtMnpaK21ZUmpiSWlIemIxS0JLcXVTekdZdmdXbFBtWkNoYkpC?=
 =?utf-8?B?N2ZsNFhSa2hxQXdUREdyZHF1Vi9ySDI2WkwxU0VXQU8vbytKVThzM3JtZFp1?=
 =?utf-8?B?SFhjQUNBYjZIdHhNdHNIWW95MGtsRGtlM3htdzJGRmVFTzYvbDdUR0JhSUZq?=
 =?utf-8?B?SFhHOUZwejkxaEFUZEw3TTFxUWRZdGNkV2M1RTlxemw3K0hPcTVqSmpvcVIx?=
 =?utf-8?B?Ry9ZUEM1a0kxWDZaRzJSYzRYa2E0TmtaaWpESVpnSmxYK3phUnZYSTVUVktL?=
 =?utf-8?B?MHlRcTdiWWxmb3lnS1VvbGtMbm0zN3lxbk8zb0VKQTM1T2ZVcGJ4NkVoMCtU?=
 =?utf-8?B?djZlOUw1eHBwc0RBT1I5R0Y5cmhQdEx4K1U0YWY4TXM5c2lLbmJ3Vk5tU3Nx?=
 =?utf-8?B?Uzl3QnphWWdpaUZGWEFlRVhtRGZHbGVhQ2JqeTZ2Y295OWNobUlUWU84M1FS?=
 =?utf-8?B?M1AvSytGcmhqV3ZYMGNENFEvSkkxSTFvOVJPNmp5Z3paYUVoc2ZDRENua2Qy?=
 =?utf-8?B?bUZXaVZuaEFmOVVSWUIwSjBKdUlJT0ZDaDBaUExlcStIR2Y0eDhiUS85MTFE?=
 =?utf-8?B?OEcrQ2xhbHl2a1d6Q1dWd3lxMEJIQjc4TXY4YXdyZ29SLzFRbFNvSjlLaFJk?=
 =?utf-8?B?YllOYUVRWG5haUJ0V1hURzB3bm41ZXdwaVhRUHlSdUVWK29UTnFhTktxVTc5?=
 =?utf-8?B?cUlIOGtERDUxK2JjRUVUd2Q1WGUwRlpaTTBJVkFUTlFuVVNDWHRFN0VXZXJp?=
 =?utf-8?B?RzhCZkdTSjh1eTVwQzFtSU02NGpVTk5KRHJtNDFwUU5IZjFWdVlibkNzU09P?=
 =?utf-8?B?cWw3cFMwMTU0VkszaEUvNWZVZ2NhdXd5L0NzQmhZL1A3bGZDVWdHQXhPRzU3?=
 =?utf-8?Q?ESXXOE6Fqb8QLY4w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d0fbce5b-4ac2-4d23-ac03-08da1daab3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 00:07:02.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 0zRQkuoFTe9njfJlAcs0JcxzcvD47ZmhdFNOE5muKOYGsUkcrhqoTC0E0MY/UXDoal6F3DiIqpFfSiBNiaYEzJdnM1wr1x9GTp2njsPh7IXHX3K0i2oGVzQ8e4/Kqto5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6956
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 16:03:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8085

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxMywgMjAy
MiA2OjEyIFBNDQo+IFRvOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIENJUCBJUkMgd2Vl
a2x5IG1lZXRpbmcgdG9kYXkgb24gbGliZXJhLmNoYXQNCj4gDQo+IE9uIDA3LjA0LjIyIDExOjA2
LCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+ID4gSGkhDQo+ID4NCj4gPj4gS2luZGx5IGJlIHJlbWlu
ZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8NCj4gPj4gZGlz
Y3VzcyB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4gT3VyIGNoYW5uZWwg
aXMgdGhlDQo+IGZvbGxvd2luZzoNCj4gPj4NCj4gPj4gICAgIGlyYzppcmMubGliZXJhLmNoYXQ6
NjY2Ny9jaXANCj4gPj4NCj4gPj4gVGhlIElSQyBtZWV0aW5nIGlzIHNjaGVkdWxlZCB0byBVVEMg
KEdNVCkgMTM6MDA6DQo+ID4+DQo+ID4+DQo+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93
b3JsZGNsb2NrL21lZXRpbmdkZXRhaWxzLmh0bWw/eWVhcj0yMDIyJg0KPiA+Pg0KPiBtb250aD00
JmRheT03JmhvdXI9MTMmbWluPTAmc2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQ9DQo+IDM3
JnA1PTI0MSZwDQo+ID4+IDY9MjQ4DQo+ID4+DQo+ID4+IFVTV2VzdCAgICBVU0Vhc3QgICAgVUsg
ICAgICAgIERFICAgICAgICBUVyAgICAgICAgSlANCj4gPj4gMDY6MDAgICAgIDA5OjAwICAgICAx
NDowMCAgICAgMTU6MDAgICAgIDIxOjAwICAgICAyMjowMA0KPiA+Pg0KPiA+PiBMYXN0IG1lZXRp
bmcgbWludXRlczoNCj4gPj4gaHR0cHM6Ly9pcmNib3Qud2wubGludXhmb3VuZGF0aW9uLm9yZy9t
ZWV0aW5ncy9jaXAvMjAyMi8wMy9jaXAuMjAyMi0wDQo+ID4+IDMtMTctMTMuMDAubG9nLmh0bWwN
Cj4gPiAuLi4NCj4gPj4gSU1QT1JUQU5UIE5PVEU6IEknbSB1bmZvcnR1bmF0ZWx5IG5vdCBhYmxl
IHRvIHJ1biB0aGUgbWVldGluZyBteXNlbGYNCj4gPj4gdG9kYXkgZHVlIHRvIGFuIGFwcG9pbnRt
ZW50IGNvbmZsaWN0IChkYW1uIERTVC4uLikuIENvdWxkIHNvbWVvbmUNCj4gPj4gZWxzZSBmcm9t
IHRoZSBrZXJuZWwgdGVhbSB0YWtlIG92ZXIgYWdhaW4/IFRoYW5rcyBpbiBhZHZhbmNlLg0KPiA+
DQo+ID4gQWZ0ZXIgRFNUIHNoaWZ0LCAxMyBVVEMgaXMgbm90IHJlYWxseSBncmVhdCB0aW1lIGZv
ciBtZSwgZWl0aGVyLiAxMg0KPiA+IFVUQyB3b3VsZCBiZSBiZXR0ZXIsIDkgb3IgMTAgVVRDIHdv
dWxkIGJlIGV2ZW4gYmV0dGVyLiBJIGRvbid0IHByb3Bvc2UNCj4gPiBzaGlmdGluZyB0b2RheSdz
IG1lZXRpbmcsIGJ1dCBzaG91bGQgd2UgdGFsayBhYm91dCBzaGlmdD8NCj4gPg0KPiANCj4gRm9y
Z290IHRvIGZvbGxvdyB1cCBvbiB0aGlzOg0KPiANCj4gQXJlIHRoZXJlIGFueSBjb25jZXJucyBh
bW9uZyBvdXIgcGFydGljaXBhbnRzIHRvIG1vdmUgdGhpcyBieSBvbmUgaG91ciBlYXJsaWVyPw0K
DQpOb3QgZnJvbSBtZS4NCg0KPiANCj4gSWYgbm8sIHRoZSBuZXh0IGxvZ2ljYWwgcXVlc3Rpb24g
d291bGQgdGhlbiBiZToNCj4gDQo+IFN0aWNrIHdpdGggb25lIGhvdXIgZWFybGllciwgb3Igd2ls
bCB0aGlzIGNhdXNlIGNvbmZsaWN0cyBhZ2FpbiBvbiB0aGUgZW5kIG9mIERTVA0KPiBpbiBBdXR1
bW4/DQo+IA0KPiBQbGVhc2UgcmFpc2UgeW91IHZvaWNlLg0KDQpJIGRvbid0IGhhdmUgYSBwcm9i
bGVtIHdpdGggZWl0aGVyLiBUaGlzIGRvZXMgbm90IGJpZyBhZmZlY3QgbWUuDQoNCj4gDQo+IFRo
YW5rcywNCj4gSmFuDQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0NCj4g
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51
eA0K


