Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2007FC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:05:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.21508.1702559137350663927
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:05:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3BED5Y0W751530; Thu, 14 Dec 2023 22:05:35 +0900
X-Iguazu-Qid: 2yAaEcOP06FzuTKn1E
X-Iguazu-QSIG: v=2; s=0; t=1702559134; q=2yAaEcOP06FzuTKn1E; m=FlCS2222KpYrW1B5aoxxDnmuoNW8iyC3ARiVjy5amO8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 3BED5X0e3240965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Dec 2023 22:05:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBGDb/YcO6/9wmO4a+waMrGGdh5UNpuQVyu56UVxpcpF1xO+NYujnpOqsIhIlCsX0kgPdgOoxI9mOseIP/aWMaaPT5M5Zfh3pCyl/p8uvegtdHOZNP2pkocyKL+k6XmFSEEYcQ8MjjlysTPp4/LgxPajAAOjl4qo1FqF92nTxQ2bO9dpqCDc+HgT979goo9SisnaMZamC1ZXz/W9IONU5aSQof/l1/iKQ79eh0zxNrHo0Vr1Zb5KA27g+1T0iIFbkURWc2+gv0kC122JW9ZuUaz1PkIIN/KDSWv0eycE/AjnknKh2xhtwmh3bqMhajH9YkN+zhJk9euXemcmkkqHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGsv13g2gEA8kCfLph1IMQKEUwarHp8GfR6eI1v6FVo=;
 b=XF3CdzNeoGjTVb1y7jRFG4npzeTkBL6JVv4E689vZnzH6ZDUqFFBaQNmt0+3uwE5nUOysV+dc8NsVKDv6kuzWqRdJWolw5IylQ6CCeOlh8Et6gXtBc3GZyOQHMyv635gcsgmWz94Yku4bDn0UrtlHQt1N0S5rDhhKSL6GV2jjSeki26J2XcxZzWK7uEkyO3cvRk9J7TlzxODDSqixJ/Z5D04f1D8jxgkPVlGq5yqC6t8qjW8PNRx5zi62zbtlplmsOESlvbbEWGdk/nUgM06Y226QiwLQ7Ehq0MKDHpJ18hBLOy0ISwH3tZUYbC/+a3kAnTtcjHecuRJPBDGMbuqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHaLmWBURKkj5VxkkelzIPvIM9arbCovwLQ
Date: Thu, 14 Dec 2023 13:05:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245314D12E5E87434FA82C0928CA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <d1055a42-e31e-436a-ae87-8b253a55ecee@siemens.com>
In-Reply-To: <d1055a42-e31e-436a-ae87-8b253a55ecee@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYYPR01MB8183:EE_
x-ms-office365-filtering-correlation-id: 86c2a199-235b-4589-fe6b-08dbfca55a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y+9wWBKlwR3PvIn5+pisSv82kBdxCRjXKYxkZa4ew6b23VASIzOK4Z+eXOHeNXCSwwGbyZ2ICFom2kh0xt/iZWX8ZBMRtoYlDKD15JZNkCLGneQs7PmlacpA+2oZuI5F+FZnmxTKeuxMYK6LjO4F+WgXivnDX8+Y/xfqwOqKFQ5rIFtq9YWRxCWmRTkkJjfQeX6d3WHoPF129Lqu/kcX27rEdDH3sSG6LXEsVgXH6gBKe8+a5d2lNz38AwnG1hVzF0xa3gr5Ejm1sSgIx8DSnSVivygVA8pggiqlnh7WHSPFuUzE7v5P0avSsSiqDXnvgHzIuYgfE2V4FG63PhD7LxEWK0mbwi5OpYnFJ/DDulvR3plpZWV5J5BFsJGoXoZJimVOLKY1lPBz4J11apjQT4xtercnV4LtNlhVb6BJrtq5ivscwJJmiBhtWf5OV99InhGFpkarcs/cMJcdvTqRmmcUdsLbkv2eS3DSYGy3cB5u46mGT7BqIgDufx8olr9FIzVBUPzdvVNmNCl0/FrTwcitwZt8OvmSsc0mP+nYLIO+EdaeWcJVg0/2LTZV+qlW+i/cyBGoC5Dv5s1DwmHjdwgt8QHg+QiVKvUlKzzk+EQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(7696005)(6506007)(53546011)(9686003)(71200400001)(5660300002)(83380400001)(52536014)(76116006)(41300700001)(478600001)(8676002)(316002)(966005)(6916009)(8936002)(64756008)(2906002)(66946007)(66446008)(66476007)(66556008)(33656002)(86362001)(122000001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aU9TZkVRV2x0eUpuTWJnRUNxM3pncXR1WWppdkt0eVk2Wm9qempldDk4Yi9Q?=
 =?utf-8?B?YnhBRWxycWo1Y2FaU2NjWVdzejM3ZzRkRlB4S0tqZVV5MnhKY2lzNFV2cUx3?=
 =?utf-8?B?RCttRHFJZ3lLQjU4dklZMDNOTEsvOXBlR1JBZ3lMVllxcUd4c21wMmR6SEx2?=
 =?utf-8?B?TkNWa2NDMVFoa1RidENqZi9rV3lVWnRuby9kWmxRQzJhUUlsTnd2S3l4UXRC?=
 =?utf-8?B?aFU4SjNlaXNOeURzTkpSa1RVYk1PcmlyTjZiL3VJVXpRZ1FodC9QODZCekw4?=
 =?utf-8?B?am1CdCtubW1OdkQxV3B0S2lkb09ZbjNaaVpJU2Y5bXMzaFZNVjdsWTE4VWl1?=
 =?utf-8?B?cTFDb2s1RXNyQ0REQk1yS3ptNjBPa0R1aUZodkdlVjBPdFc3NnBGQUh3NW5F?=
 =?utf-8?B?QU9ab0F3OFdHcm1IdmlUanVvRWJYSHpZT09YaGU5K0JYSisrRGgxUno4QzJt?=
 =?utf-8?B?RDhvK0R4S2kyVDIzeU1CNjE2MVVWVUJqc0FMb20zS2lQMlNNSjdBS0tuVldM?=
 =?utf-8?B?NTg1S0RhNHFOTW40VlFERnRaeW9PQ3pNUkdkM1FmSWRFdzhYMnMvTVhCT1B1?=
 =?utf-8?B?bDRtcEg4eHhTajlrTTVxYTN6SzU0cHZFR2ZlbDcrOG1PZTRMTjdJL0R6VldT?=
 =?utf-8?B?Z2FJdnBpUnNtVkpabURqNktJZytDN2RwQ09yakpBa1REUnpmRVk1OXRTd1hQ?=
 =?utf-8?B?bmpMRFlwK1V5VmQwNzlycngxY2hSeEQva2NnZmVYRkZLTUsvZUV2Qm4vUW5I?=
 =?utf-8?B?bmFncGpmM1F6ZkYvLzlBSm1FV3ZXU3QrSjBnbUxhcjlTT01nVUdUQUQxZ2Ur?=
 =?utf-8?B?aGVpeWh2amI0VzNJeUhTdnI0Y3c5R2hKUjVhN1k2bE9GK3p6ZGpoMHJKOFpE?=
 =?utf-8?B?aXY5b1RORDB4V29GQmZtWEJ5enBOQXc1UlpvN0x6SGZuL3A1UFJDVWYwalR3?=
 =?utf-8?B?a3Q0bnZlWElsK3FRaFZyOFNUNDlnNVpoNTdTdTMwTFBqeUdvMXAvUE4yaTJG?=
 =?utf-8?B?c1JZaStPUWFyblNkSWxVdGFYY2ViTFg0T3JqSzh4WjFmL21tRDJFMWRvMDFh?=
 =?utf-8?B?UWhrdlMyTmxxcS9xZTU0SThwbnlTclczdTZ6ZTNXOWRsTnVjSW11cDF6TTFL?=
 =?utf-8?B?akNKNXZNNzRQWmlVSm1YNHZqMjdzTFVldlpkSTRaVnpxNElSalh1ODJoVzhi?=
 =?utf-8?B?WDd0alJBUS9aQVFac1BMamFZY0JQNXl6VUlKNWJocUNONTd4RVE2WXlEdUpZ?=
 =?utf-8?B?Mkcvb2E3ZmUvNEFrQTBmcUJUY0t1Y1ozOGw2RnRqeWJONWVWVGJDYmI3TThJ?=
 =?utf-8?B?TDV6N0ZnSDg5Z2pHMzB0ek16cjZqWW9YT0E1T2wwOXZQajFHYzVubW5zb09O?=
 =?utf-8?B?b1FkT0ZTTnMxQ0FwT2tnaG1OUzZVeEVncHVuQjJuejA4SkxIcnhkTDJvN1B3?=
 =?utf-8?B?cVJ4MHFXOXVMZDJZTDB0T2J3dTJtdm5CSEEvWjhrSTYyaUZGOStkZDVZT25G?=
 =?utf-8?B?c2cyOUVULzRJYVV4eXZkRnZHdENTTjRYcUdybEtsa2N3UnM0ZGRxUjNJazl0?=
 =?utf-8?B?b0pKYkpLbVZSb2ZxLytGSm5CWWVRdXU4UmtINk1DZTZQTkpyNnFxRXpzcHZx?=
 =?utf-8?B?WlFDd01Fd2pkZFUxbUErYmplc3A1WDAzNU9XTlhGNVc2YUtRQS9IQm4zN29X?=
 =?utf-8?B?WUszWjRnelBCL3Q1NmE5TWZMRWNSbzF3NURxTnE4UGNidE90K2lhWWVONHYz?=
 =?utf-8?B?V1BCTi9Jczk5WHVoeEw0WWpJa0hBM01NamN6Vm4zNm81T3lKQ1VQWndBUlpE?=
 =?utf-8?B?czNhT0l4M2IweU9oTnU2YU5haDhwNEJyRkhCN0U2NytjTVhNcFV5Ymc2V0JD?=
 =?utf-8?B?RTRDUkZobHBDcUNRTnZzS1Q5TFlYd1JZWUdDY0Z1VFNIM0h6ZExiaHM5b3oz?=
 =?utf-8?B?c3dITFhnd251VVo5YW53VzhOUlFkZ3lDN2NwOHFEVStBYlFEM1Z4a1psSE13?=
 =?utf-8?B?VjFDaVdjdG40YUg1L0NJci9YQ01mSG1Bb1lISFVQTk82SHhZSm9ZeURPSEt5?=
 =?utf-8?B?YlNRMWFwVGdVOGlneDNFaUdPL1RFQ0xuTzdVTlJuZXJUZ2tJam05elZGYUM5?=
 =?utf-8?B?c2xyOExyUlM4V2drdkYwOEFJQ3h2MUdtVVA4RWVrd2xKRGZncSs4R01KdU9D?=
 =?utf-8?B?UWVERDYwYURkYUJLb2RieUY4L1dldXp0dFVLSk1uaHBQYlRXdUF5ejBSLzVC?=
 =?utf-8?Q?bcb8FJ6T0R83c3yxAj+O/7eXM7WpFt171HUY5zQDfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c2a199-235b-4589-fe6b-08dbfca55a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 13:05:31.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNZ1q5HIS42ZGIs+qEZKzAgBQvZO5BdwVSxXM3hX/t9QF7+khbj0n58Cge/3O7xWz0wIYk/XaQ9s329MLp6D4aH9wYsMu+Lnt6BKTW0aWLsW0h6Zm3UUrVUA3Mj4Ajxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8183
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:05:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14097

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBUaHVyc2RheSwgRGVjZW1iZXIgMTQsIDIwMjMgNToxNCBQTQ0KPiBUbzogY2lwLWRldiA8Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJD
IHdlZWtseSBtZWV0aW5nIHRvZGF5IG9uIGxpYmVyYS5jaGF0DQo+IA0KPiBIaSBhbGwsDQo+IA0K
PiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdo
IElSQyB0byBkaXNjdXNzDQo+IHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5
LiBPdXIgY2hhbm5lbCBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4gICAgIGlyYzppcmMubGliZXJh
LmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBzY2hlZHVsZWQgdG8gVVRD
IChHTVQpIDEzOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xv
Y2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjMmDQo+IG1vbnRoPTEyJmRheT0xNCZob3Vy
PTEzJm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0xNzkmcDM9MTM2JnA0DQo+ID0zNyZwNT0yNDEmcDY9
MjQ4DQo+IA0KPiBVU1dlc3QgICAgVVNFYXN0ICAgIFVLICAgICAgICBERSAgICAgICAgVFcgICAg
ICAgIEpQDQo+IDA1OjAwICAgICAwODowMCAgICAgMTM6MDAgICAgIDE0OjAwICAgICAyMTowMCAg
ICAgMjI6MDANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2JvdC53
bC5saW51eGZvdW5kYXRpb24ub3JnL21lZXRpbmdzL2NpcC8yMDIzLzEyL2NpcC4yMDIzLTEyLTA3
LQ0KPiAxMy4wMS5sb2cuaHRtbA0KPiANCj4gKiBBY3Rpb24gaXRlbXMNCj4gICAtIHByZXBhcmUg
YmxvZyBlbnRyeSBvbiBTTFRTIGtlcm5lbCBzdGF0ZSBhbmQgY2hhbGxlbmdlcyBbSmFuXQ0KPiAq
IEtlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzDQo+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzDQo+
ICAgLSA0LjQNCj4gICAtIDQuMTkNCj4gICAtIDUuMTANCj4gICAtIDYuMQ0KDQpEYXRlIHRoZSBk
YXRhIGlzIGNyZWF0ZWQ6IFRodSBEZWMgMTQgMTI6NTc6MDAgUE0gVVRDIDIwMjMNCmxpbnV4LTQu
NC55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQogIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTog
TW9uIERlYyAxMSAwMjo0MDozNyBBTSBVVEMgMjAyMw0KICBsaW1pdCBkYXRlOiBXZWQgSmFuIDEw
IDAyOjQwOjM3IEFNIFVUQyAyMDI0DQogIFN0YXR1czogT24gdHJhY2sNCmxpbnV4LTQuNC55LWNp
cC1ydDogaW50ZXJ2YWwgNjAgZGF5DQogIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVGh1
IE9jdCAxOSAwMzozMDoxOCBQTSBVVEMgMjAyMw0KICBsaW1pdCBkYXRlOiBNb24gRGVjIDE4IDAz
OjMwOjE4IFBNIFVUQyAyMDIzDQogIFN0YXR1czogT24gdHJhY2sNCmxpbnV4LTQuMTkueS1jaXA6
IGludGVydmFsIDMwIGRheQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSBEZWMg
IDcgMDU6Mzc6MjEgUE0gVVRDIDIwMjMNCiAgbGltaXQgZGF0ZTogU2F0IEphbiAgNiAwNTozNzoy
MSBQTSBVVEMgMjAyNA0KICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC00LjE5LnktY2lwLXJ0OiBp
bnRlcnZhbCA2MCBkYXkNCiAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBXZWQgT2N0IDE4
IDEwOjAyOjI3IEFNIFVUQyAyMDIzDQogIGxpbWl0IGRhdGU6IFN1biBEZWMgMTcgMTA6MDI6Mjcg
QU0gVVRDIDIwMjMNCiAgU3RhdHVzOiBPbiB0cmFjaw0KbGludXgtNS4xMC55LWNpcDogaW50ZXJ2
YWwgMzAgZGF5DQogIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVGh1IE5vdiAyMyAxMTo1
MToxNCBBTSBVVEMgMjAyMw0KICBsaW1pdCBkYXRlOiBTYXQgRGVjIDIzIDExOjUxOjE0IEFNIFVU
QyAyMDIzDQogIFN0YXR1czogT24gdHJhY2sNCmxpbnV4LTUuMTAueS1jaXAtcnQ6IGludGVydmFs
IDYwIGRheQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSBOb3YgMjMgMDY6MTI6
MzEgUE0gVVRDIDIwMjMNCiAgbGltaXQgZGF0ZTogTW9uIEphbiAyMiAwNjoxMjozMSBQTSBVVEMg
MjAyNA0KICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC02LjEueS1jaXA6IGludGVydmFsIDE1IGRh
eQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IE1vbiBEZWMgMTEgMTE6MDA6MDcgQU0g
VVRDIDIwMjMNCiAgbGltaXQgZGF0ZTogVHVlIERlYyAyNiAxMTowMDowNyBBTSBVVEMgMjAyMw0K
ICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC02LjEueS1jaXAtcnQ6IGludGVydmFsIDMwIGRheQ0K
ICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IE1vbiBEZWMgMTEgMDc6MDg6MzAgUE0gVVRD
IDIwMjMNCiAgbGltaXQgZGF0ZTogV2VkIEphbiAxMCAwNzowODozMCBQTSBVVEMgMjAyNA0KICBT
dGF0dXM6IE9uIHRyYWNrDQoNClNjcmlwdHMgb24gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9q
ZWN0L2NpcC1rZXJuZWwvbHRzLWNvbW1pdC1saXN0Ly0vYmxvYi9tYXN0ZXIvYmluL2NpcC1yZWxl
YXNlLXRlcm0uc2g/cmVmX3R5cGU9aGVhZHMNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


