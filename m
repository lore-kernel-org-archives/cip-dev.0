Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568FECDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 09:19:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39319.1782119977087128724
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 02:19:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 65M9JYlB1039590; Mon, 22 Jun 2026 18:19:35 +0900
X-Iguazu-Qid: 2yAbPsFEuUjxcO99D5
X-Iguazu-QSIG: v=2; s=0; t=1782119974; q=2yAbPsFEuUjxcO99D5; m=Nl0zUml7BCrYXxpDBZoYNP7GynvVZ250GIQOHlwEFt8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gkN1y47VlzyPQ; Mon, 22 Jun 2026 18:19:34 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbEZzzbgG83c/3sePO7miuZtrSnAizwQWhp/gDsFZM8Iboy3dvYQPw41t/+Q0GniS2Kvwd7ZwJ0V9urIihr613Fx/2YaENEzW5qpMj5BuHEiYv0oHXiZ+ymo98XbtCB4AeItozorx0NqIdkf5EBLiItAJLuXHl1RMoA6BPf+gl9uCGmEpLz3KK4gpglLtkUn/s3wQHsJOnsa6zRy8ritGPWOPhMiPGmtNMsKbkCAV4Nmz7CoQyJBOLSuJTbb/AjG+xSqMWlcWUbCYc4KGPpszQaewBI5VxbPjbZtnjI6kuu+wzwR9JtKp1ZLutBhtqMO+29sMhaD9g2d+uzQpTi/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orJ8KPeTqKjIAxZle+dCBiBSZqTQyh7RA0Io0NtJHcE=;
 b=kCQy0RDvzsY2k9Fp6+iypi9ysR/vogwtv4gtiLt8ilVtwGmocI/0ATYsF/JKl48T9eIWia/qQZAVi6OwScS0nLau3fqxSMKDZedSqeLvad/LJWNsJNwbFTZyDo5rDFe3zldnnV7N+2wOW/QlBgfDp/Lmge6QHlHrp9Haal6UMxSkxUzfxb8UzDzyXX/UtM+T/aeAG/VIxb6F1xXus3CJmaCrQtBZpTPxju/ltlD+0c7qUsPQWABhW5gpj3WNPabRTveQwfJAhHI7gB+CKhK7H+3o9Go+gqY3aNG3hCZuavPo0vdB1hsVn5XaIcsttOCzgHkpmzotD7L6T2kRdq6BPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH v2 2/2] Add crypt library packages for
 Debian sid version
Thread-Topic: [isar-cip-core][PATCH v2 2/2] Add crypt library packages for
 Debian sid version
Thread-Index: AQHc/U+1ynRXhnYHo0G1hki8OIQWkbZDxpEAgAaOcyA=
Date: Mon, 22 Jun 2026 09:19:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB11063A0DA32C5961F137E00ABC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260616050628.3560536-3-Shivanand.Kunijadar@toshiba-tsip.com>
 <32e2d89f-352f-403b-be31-79eb3331d14a@siemens.com>
In-Reply-To: <32e2d89f-352f-403b-be31-79eb3331d14a@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|OS3PR01MB8400:EE_
x-ms-office365-filtering-correlation-id: 64f9222d-adbd-49d4-a2e1-08ded03f5c14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: 
 RUMgxaBPyNhBCpm1z6gbeRCSPAi71o0Zl3OOJ7JrMNLJacEXRwmfksJ6Sl60E/S6an2JQ6OXb2mkeYoU9fpdS1OXJtrRAY3D98isSuWSQK01QQITIVzawlrh6DnIKN5X7LPJ05eRt1vLqcCQ964W73+lvMrPnZtBmIMBQXokcyUOAHhIT2NYufP/If8Gf0Px2Qr5TYSnQ/xxtIh+V6c0cB3R4IX/724AHluYVwndvNS4Ekjgvdb2Vcg3bLJVD/zsY6IQv7JudgzeVNTz19T5nZIPOzLXwGeQBM2ihE1EBXv8sf0eJRuI1Ef3aFEVFlUuGu6vSTBu5G6/neDNYs7HS6m1V9J39qCse76Typ2lqjh6SPLB4DzrrOs4w8gfEF5bHX5mx6GFGB/KnpTpMwT2lLlckmfLG1VhJYCoAZRZiHWNfvRpCeFlyUjvlsTvOkaJ2YVUj/KofY575zSDVtmmL9YWsl+7P0wNwx/RrMG0y6RTxm31j2nNjQ9EsFsYiog6hRnha9x0Vprtt6eFMrvoh8VNgChBfaf4uh7vko3KATTHdtD6P+uhBF08QCDmabpGOy8XlILAA20A+Rb9vcSCLAVJ0+OCD769VKmsz9lh5ISJhY1O2Alqd9GgfvLJuFI+4/BnpP6nY4i7nmy6XEytIomJHcGkUMagTBdIOepgS79AFYY6xCRCshJlbwp7v5NtYQ8AOB6veKRoitRVbU0BbALo76Q0NOZBWXqNrV7JLys=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTRaUHJNL2dnUGVxSjVWa3NueEhteTJTeW9FNHZJZ3lCRzlEdG9wcllMRE5k?=
 =?utf-8?B?eURwWC9YQ215Znh4eHE1UUhMVHd5dElwSVBzaVBBWHNCejRVNWk3SE1qa3Fz?=
 =?utf-8?B?cFRDZWtTQklwRmFLS1BYKzVXV3J2eUhFekdEY0ZNanpNN3hFcEZPU3Y4Y1Jy?=
 =?utf-8?B?bVNHY29CekFLdC8zeGRzZXZoVlY4RklOQkFaYnpHeTIycFpsS0ZrRzRCTXBP?=
 =?utf-8?B?UzNvYTJBSVdnWXd5SFBZTVZ4bS83TmNEb0JMTC9lR0pSR0dzNXdKbjhuQ1d1?=
 =?utf-8?B?ZEJHUHJyQUU4SUFLTlhNSHhPaFhTNFZVV0JGMU5ZLzFtb3gzU0dkYVA0OEZX?=
 =?utf-8?B?eXdDSjlSZGJTSzQrUFhrVU1CU2RpdWkwazVhdUcxaTNoQVJoSnllQTBudkFH?=
 =?utf-8?B?ZW1ENE5sNHltRHZxaUthU0lQZVNMSkNxd2ttbTVHM1pNa0lGYkQxdVlUcFpU?=
 =?utf-8?B?YXdTT2ptb0JNdDFTcFkzWWtpaks3THBsTkV3UGlFQ0U5Z1Y5UVFiNUpjaEZP?=
 =?utf-8?B?TzgvbnpaM3pxUU01dld4MDJlTS9melF5ZnM5aXZRN1B2eHJuMThhQytTREVx?=
 =?utf-8?B?REZnWDZEV21icmxHdlErMkI5QTFCSUM0cGNzV0F3enh5SnVOVlp6ZHNaME5H?=
 =?utf-8?B?eW9XRlB0RVVPcU9jcHRpZTFQd1R2VEh4WWh6QjFQTkRJLzBFS1lrYWxKOWJ4?=
 =?utf-8?B?ZWQ4NXlPbVRmU1FpaFcrUEp3RU9xMVlwMHJUZFZ4Z3dML1pxcUxYT3pQZlR6?=
 =?utf-8?B?RzFXV1VXR3pFSk9uQ2MyOFBSaG0rdG84ZnVaZzQ4UW5OcENHc0Rid0tQVGRx?=
 =?utf-8?B?ZDNLeklQMTJ4cm1IVXdwTU5kYmZ6dlZQdjhtdDVHeVFlZUt1R3IyaFJZZUE4?=
 =?utf-8?B?TmV0Wk1LZ0NNZWM2aXJqeHdLM2VFVUN1bGZIcWRheEY2bzIwbEwxSVNnYkxR?=
 =?utf-8?B?clkycTB1QTVPaDVieFhVaFFLYnh3OFpVRVlPS3MyMnE2c1hqU1J2Z3oxbVJK?=
 =?utf-8?B?bFNHbWphNWcxRk1XYTcvR1E3N1ZzdVd6TkVMK3pyZFI4M2FCN2VVYTJSSmgz?=
 =?utf-8?B?TGJvZlJRSkg0MzNFSU9FWFZkT2lEaHZwK3RLVWlsNVQ0SWJLK1FXbjhmeWdx?=
 =?utf-8?B?b2x5V0xERWkyWEM4RGdZN1RoWlh0bzkwQ2dBTmFDTlJ1Z0t1TTRRYVJ5RW5S?=
 =?utf-8?B?Mi8xajJlS1M3WXY1dEtxOFJzTHN1SmNZbzcvSmJwbXk3TmpONE1jQUl3eFF2?=
 =?utf-8?B?TEplelI5WWhnUUVWLzFBNTk3UTlwZXlONUpYZG9xUHJNaXNsOGZKNGQraXow?=
 =?utf-8?B?VUE4QmVKYlZqUHJaRFR3Unl0NjVNS0kwLzJqcGtzc0FzUTRHeENVRkZ3UjJr?=
 =?utf-8?B?QmxJY2wzN1VCM1pNTTNSbUo5b3VDTDlGdTZzYy9ONzdzYkxvT25uYi9jVG5n?=
 =?utf-8?B?aXRnVDFFSnIyYmF6czY1YjlVaXVNOVo3WkVQYXJhSFJLRDFaVm5WdTRJWDRs?=
 =?utf-8?B?L0lqNUIxeTFTZGhqZ1F5cWFBNXVrNjBTc1dtVm5zU0pxbWpUcnZpTk05cmNU?=
 =?utf-8?B?NzY2NkU2TWN5cE9KVHBrdjVKaUFJVlJSciszcmp4S0FSYm1RUXBSZnNja1R5?=
 =?utf-8?B?Mms1dXA4cEZOV3FCRXZwRE1zc1VxNnZLQURvZTRTc0xpZWE0TnptMlMvdXJz?=
 =?utf-8?B?Y1N3Rkpta3lvaWFlYVpkU3JrUEUwTi8wejRaQ1FORnMwS1JDM3pBdG9tOEcy?=
 =?utf-8?B?V0hJQytoWGhUWUZpd2psbVpjNVJtYTBLZ1BSMDM2YlZPZXhhVGRhREZQYjc1?=
 =?utf-8?B?Z3JyUlBVNVl1bWJuS3MwZlY1b2RKREVhZ2RvMk1XdU5WT1NzYk96V081TnZ5?=
 =?utf-8?B?ekpYN3pQT3JWVkJvZVhRYUk5M0hjNDVJanBoMjhydU5VQmtwT0FvdC9QeWpN?=
 =?utf-8?B?di9MY05YaFhDYlJaMXc4TStIUkpTNERaS2pENlp0WHdkZkVjU01ZR2FXUGl6?=
 =?utf-8?B?OVBmdURrQ3dqbk1wTzZiWTRwUDY0WHgzOGRncm5CUTRIM2dBUnRheFJTbmhR?=
 =?utf-8?B?UVQ2YWtTNnRwUWNnaVhQY2RvanlpZkpjT0FBZHpIK1l4bVNGcGYzR3cxako4?=
 =?utf-8?B?WTd1VnU4K25GcUlJNWhoaWIvVU92SDVCVklraWJlcEp4TGRPbjdMeDNMTGhM?=
 =?utf-8?B?bkZSUm9ZbzY0UVdDdVhscVRub3pTeTROU0dTMFBMWExoTVRxQmpjejM0QUhy?=
 =?utf-8?B?WFhCV2NyZnp6dDhrTXFlUDd1TWNDOThNY1hIMWZFaUNoazRScktWOW9OM3p5?=
 =?utf-8?B?U0k4ZXdrVHc5YVg2VVNGc051SjBxSlRTeUt4VWFpRkQwWHI2ZU5ZTlF0dXJW?=
 =?utf-8?Q?i6xwoFYKDpKB0Gwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Cc7YSE8p+eiYNIRvdRumQwdMzvwYshbmQgBRYZV506DkNMANPi9UKQiK+hZLkniofcRuHS3ovN/ubGIXZHiTeYbEZMiDyYWnWGgT3OvGJh8gJ1HwfXPsT57wUuvVl+LCKYqxVZOFW+Z2o2Q/r1Izv4g1A/6KTkr/9SQV5JU8PHPlpX5mQet692kHnYJmhMXZxQ1Wikd4vodVjYHrd52tvXXFJWog8WzLjYahyR3i9Tu0xn2fXcaXdGIG0LX8zXVVy6TEUdrLnsyOk6Z22lpWCWt9rn9iq2tt9MQfdP+5n7z9X+zU/Tjg075zJEG2H8JXe5uLKA0qTxHMSMmIr0UuGA==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f9222d-adbd-49d4-a2e1-08ded03f5c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 09:19:27.9526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQRn2AI2QZcadLi9PYNXtMyAJb2vMyQ+UbMDqu9eDvHKISJAVM+4sHRe03vMu8g65MU3zO1cVfEkxi8kIlne1G0suHLuZPddJfqDPk7GrXbx5CAc8VD9Tofx9tJaCzay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8400
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 09:19:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23244

SGkgSmFuLCANCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudCwgDQoNCj4gUGxlYXNlIGFsaWduIGlu
ZGVudGlvbiBoZXJlIHNvIHRoYXQgaXQgaXMgZWFzaWVyIHRvIHNlZSB0aGF0IHBhY2thZ2UgbGlz
dHMgYXJlIGlkZW50aWNhbCBiZXR3ZWVuIHRyaXhpZSBhbmQgc2lkIChyaWdodCBub3cpLg0KDQpE
b2VzIHRoaXMgbWVhbiBqdXN0IGFkZCBzb21lIHNwYWNlIGNoYXJhY3RlcnMgYWZ0ZXIgc2lkIHRv
IGFsaWduIHdpdGggcGFja2FnZSBsaXN0IHdpdGggdHJpeGllIGxpa2UgYmVsb3csIA0KDQpERUJJ
QU5fREVQRU5EUzphcHBlbmQ6dHJpeGllID0gIiwgbGlidHNzMi1lc3lzLTMuMC4yLTB0NjQsIGxp
YnRzczItcmMwdDY0LCBsaWJ0c3MyLW11LTQuMC4xLTB0NjQiDQpERUJJQU5fREVQRU5EUzphcHBl
bmQ6c2lkICAgICA9ICIsIGxpYnRzczItZXN5cy0zLjAuMi0wdDY0LCBsaWJ0c3MyLXJjMHQ2NCwg
bGlidHNzMi1tdS00LjAuMS0wdDY0Ig0KDQpJZiB5ZXMsIHdpbGwgdXBkYXRlIHRoZSBzYW1lIGlu
IHRoZSBuZXh0IHBhdGNoIHNlcmllcy4gDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBL
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPiANClNlbnQ6IDE4IEp1bmUgMjAyNiAxMDozOQ0KVG86IGt1bmlqYWRh
ciBzaGl2YW5hbmQo77y077yz77yp77ywIERJVENfRElULU9TVCkgPFNoaXZhbmFuZC5LdW5pamFk
YXJAdG9zaGliYS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzog
YmFsYWt1bWFyIGFkaXRoeWEo77y077yz77yp77ywIO+8pO+8qe+8tO+8o++8v++8pO+8qe+8tC3v
vK/vvLPvvLQpIDxBZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgZGluZXNoIGt1
bWFyKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lw
LmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvKTvvKnvvLTvvKPil4vvvKPv
vLDvvLQpIDxrYXp1aGlyby5oYXlhc2hpLmY3NEBtYWlsLnRvc2hpYmE+DQpTdWJqZWN0OiBSZTog
W2lzYXItY2lwLWNvcmVdW1BBVENIIHYyIDIvMl0gQWRkIGNyeXB0IGxpYnJhcnkgcGFja2FnZXMg
Zm9yIERlYmlhbiBzaWQgdmVyc2lvbg0KDQpPbiAxNi4wNi4yNiAwNzowNiwgU2hpdmFuYW5kIEt1
bmlqYWRhciB3cm90ZToNCj4gU2lnbmVkLW9mZi1ieTogU2hpdmFuYW5kIEt1bmlqYWRhciANCj4g
PFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT4NCj4gLS0tDQo+ICAuLi4vaW5p
dHJhbWZzLWNyeXB0LWhvb2svaW5pdHJhbWZzLWNyeXB0LWhvb2tfMC4xMS5iYiAgICAgICAgICAg
fCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IA0KPiBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1m
cy1jcnlwdC1ob29rXzAuMTEuYmIgDQo+IGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNy
eXB0LWhvb2svaW5pdHJhbWZzLWNyeXB0LWhvb2tfMC4xMS5iYg0KPiBpbmRleCAzY2IwNTIwLi4y
YzNjMzMxIDEwMDY0NA0KPiAtLS0gDQo+IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNy
eXB0LWhvb2svaW5pdHJhbWZzLWNyeXB0LWhvb2tfMC4xMS5iYg0KPiArKysgYi9yZWNpcGVzLWlu
aXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9pbml0cmFtZnMtY3J5cHQtaG9va18wLjExDQo+
ICsrKyAuYmINCj4gQEAgLTM4LDkgKzM4LDExIEBAIERFQklBTl9ERVBFTkRTOmFwcGVuZDpidXN0
ZXIgPSAiLCBsaWJnY2MtNy1kZXYsIGxpYnRzczItZXN5czAiDQo+ICBERUJJQU5fREVQRU5EUzph
cHBlbmQ6YnVsbHNleWUgPSAiLCBsaWJ0c3MyLWVzeXMtMy4wLjItMCwgbGlidHNzMi1yYzAsIGxp
YnRzczItbXUwIg0KPiAgREVCSUFOX0RFUEVORFM6YXBwZW5kOmJvb2t3b3JtID0gIiwgbGlidHNz
Mi1lc3lzLTMuMC4yLTAsIGxpYnRzczItcmMwLCBsaWJ0c3MyLW11MCINCj4gIERFQklBTl9ERVBF
TkRTOmFwcGVuZDp0cml4aWUgPSAiLCBsaWJ0c3MyLWVzeXMtMy4wLjItMHQ2NCwgbGlidHNzMi1y
YzB0NjQsIGxpYnRzczItbXUtNC4wLjEtMHQ2NCINCj4gK0RFQklBTl9ERVBFTkRTOmFwcGVuZDpz
aWQgPSAiLCBsaWJ0c3MyLWVzeXMtMy4wLjItMHQ2NCwgbGlidHNzMi1yYzB0NjQsIGxpYnRzczIt
bXUtNC4wLjEtMHQ2NCINCj4gIA0KDQpQbGVhc2UgYWxpZ24gaW5kZW50aW9uIGhlcmUgc28gdGhh
dCBpdCBpcyBlYXNpZXIgdG8gc2VlIHRoYXQgcGFja2FnZSBsaXN0cyBhcmUgaWRlbnRpY2FsIGJl
dHdlZW4gdHJpeGllIGFuZCBzaWQgKHJpZ2h0IG5vdykuDQoNCkphbg0KDQo+ICBERUJJQU5fREVQ
RU5EUzphcHBlbmQ6Y2xldmlzID0gIiwgY2xldmlzLWx1a3MsIGpvc2UsIGJhc2gsIGx1a3NtZXRh
LCBmaWxlLCBsaWJwd3F1YWxpdHktdG9vbHMsIGNsZXZpcy10cG0yIg0KPiAgREVCSUFOX0RFUEVO
RFM6YXBwZW5kOnN5c3RlbWQ6dHJpeGllID0gIiwgc3lzdGVtZC1jcnlwdHNldHVwIg0KPiArREVC
SUFOX0RFUEVORFM6YXBwZW5kOnN5c3RlbWQ6c2lkID0gIiwgc3lzdGVtZC1jcnlwdHNldHVwIg0K
PiAgREVCSUFOX0RFUEVORFM6YXBwZW5kOnN5c3RlbWQgPSAiLCBzeXN0ZW1kICg+PSAyNTEpIg0K
PiAgDQo+ICBIT09LX0FERF9NT0RVTEVTID0gIiBcDQoNCg0KLS0NClNpZW1lbnMgQUcsIEZvdW5k
YXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


