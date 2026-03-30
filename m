Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6281FF495E
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 14:08:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52163.1774879723085945531
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Mar 2026 07:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 62UE8fo32444540; Mon, 30 Mar 2026 23:08:41 +0900
X-Iguazu-Qid: 2yAbiBABH1fVTEHVpq
X-Iguazu-QSIG: v=2; s=0; t=1774879720; q=2yAbiBABH1fVTEHVpq; m=LYUjft80XiB9ZuvxmwSq0jLNtKW4k3T+Bd2a5ItZK+g=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fktQJ50XFzyPQ; Mon, 30 Mar 2026 23:08:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOTx3VMHjMACZseIIKK1J5t2lnUbGmvq1GbaSYG5ADKIz8FJvjNmJqb4Y30LSB0BM3wxozM1zD81GyMPg+dbzDnvKfufQH2o+3gLHF9ewj/kKGQZz4MS/UjdcjUeo1iMUAJ1DEOX9mXZGfaUd2rAguL0iRvq096cHz47nVHYmT6w3bfzGUkumf9HFkNhi7yZAgY9gUap2ZfvNc4QojzJDN0pc0sRahZptb72aCP+7pRptjZdwA/405PJJ8CdinCZiC/ptO3lZA2xUxRGg/kNufMFYxCBPTuJ6/LFWNgiICCWppcHYResSQ6CoYDcTcLyC1YvArwjXneELfn3s5taCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIX6Ggzi99lpiMvwcspqwiNG3jo5mUd//7lwfEkVJTg=;
 b=DFiZq28MACwoR41fYn+Zk07IdN6oc3/S9homomKix3V87hRcMboacV6XMpFlZtzVb6naiKjr9ZYwCGE4uwd+jolomsC/z12Q20GtEZeFtO0mgsmbES4IkMs+KEF5oPcbYeWU/KUoj6+iTBaQvLabyP9/Flt9o6gX49UJuP2TbOBF/9alKP4l4lrR0EmnIJxU+kGn20nAvGFDsK2rsRRlhuxUisqPriBdPy69UL4FyOCMM7m4k3OW7UphdNobBrclLa+EX8qhhc3gdh5SAlNkW82sTYFqaFRxPU5ZW+e6PPFrQUGABzjZWX1jBu5JP9pesWhRxCFe2r6qJRydaRsYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <christian.storm@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <Shivanand.Kunijadar@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <koshiro.onuki.h55@mail.toshiba>,
        <kazuhiro.hayashi.f74@mail.toshiba>, <michael.adler@siemens.com>
Subject: Re: [isar-cip-core][RFC v1 2/7] wfx-onboarding-progress-client:
 Custom progress client for device onboarding with wfx
Thread-Topic: [isar-cip-core][RFC v1 2/7] wfx-onboarding-progress-client:
 Custom progress client for device onboarding with wfx
Thread-Index: AQHcsEaisOzkPenAh0Gf3GS2tGpDOrW5iyAAgA2mQ8k=
Date: Mon, 30 Mar 2026 14:08:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669430F11952E58F7D0CAA6C452A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260310044554.990348-3-Adithya.Balakumar@toshiba-tsip.com>
 <32CBE05F-35A4-443A-8985-AC0B64E559AD@siemens.com>
In-Reply-To: <32CBE05F-35A4-443A-8985-AC0B64E559AD@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYRPR01MB12805:EE_
x-ms-office365-filtering-correlation-id: 977820af-eac3-4bc0-5e8b-08de8e65d6b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|56012099003|22082099003|18002099003|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 lXNjQRKAfw+lmWitv48Sh1tgJxKDTfLuXpDFaTyBoh9NBcQ1NTu0W4p3o5NYlsJ9QXeJvsl6g3CWdSBJaOExqnRBRQONFkpTpBXDdHmfUiNOF+3BoeHEVxQ8ruMaSjnON6ki7QkvR9PTgcQchsZDYeUJpeGyr5gzCNPBKAzKOuM/T2qFB/SG7L/6MZLh0lflGLm9Di0SiBWEHjMNbNiKM7mlwCWpV3bNixw+9QJoS/ekGSffo2NZtkKvB3/F+qXYBmIP9rE2DH/txRNXwGQgHq2LSVPj8E+KQfzbMkzC+FPW7ldP6s806CJjBdEXJQYmJVJ6QaC1XXeo3ZGpCtAEUKbRVv6Vx3r1FiGgd//bmtUWiXnML0kFYO2yyqEskm+bSoamWuUskEpUnJb9dLgkcq/4Eu5+nWh+adIFhJplGRGsaqw0VsS2xQ9tzmQi/j8ClDIK7rM8Icip1DyZ4pi9hcJPyHf5ZmCjRZQ8QOo2BncFTp2YpcUDe4owPEgYU2OvN/dhDPovGEMvRBqX2A9yQ9pYC7S3KwODKegQZXHc8VBYJ4BX1wi5joI+l40F3jmJLNHr5Yn15yiho6ZthZEV+govYI+H2XLl39GWzoCylkDfUa+DjnGPdjW40fwAB2TYodh+Y2dRvGkoqQyRLizKfK56eqzhqyuTyl4sCuGgjaNMK7SHnWSXGluQTz8LEikXpdjuofWMm8URDvvKrPeXKe/DHbZKQuxWiQcc8h9UzXnNFjtqoeI4MJ3TPRqNsu9P
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(56012099003)(22082099003)(18002099003)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?Z3F1eHdZNGRPYThOZTlSMFdySFEwRGJHV1VwN3psWjhwU3l6aWZMNkIzY1k4?=
 =?gb2312?B?MkIrUGR5VVNYa3FtMHczdktYaGJhaTVNSVFjeWlGRjNYTzBqeWJwcEdjQ1dH?=
 =?gb2312?B?SXFpeXdOeGtyZmtFQ2NxMnkwQkJEaDYvemJTUzQrM3FoOWNvNEVxR2pKZm5F?=
 =?gb2312?B?NTcrMTZMRGRaVUtqSHByWC9sRU5zSWFvbUtaU3hYL0hIdksyV0tuTy8wSUJM?=
 =?gb2312?B?eXhSYktzOUdscm92R2tTWDMvMTlQTnJsSlhvYjVmeFF3SjZIZ2RzTjkyd1pS?=
 =?gb2312?B?RFlNYnJlemxiOVJnVUdBbEFpbSt4UzFGVHhta3J5U3BpeFRKeWdOenBnMnlS?=
 =?gb2312?B?YUI4ajk2TkpJb20vMFNrSVhjUGZVeHNkYmtFVlo4dEw2L092YTVQUW5ETUU5?=
 =?gb2312?B?R0psWU9Lck9Ud25odkw5NVdGM0lKMS9DVVRERjdoZXhHZDI1MXVnaXJtTGFo?=
 =?gb2312?B?U3hRc3htY1dSSTRUSzhxUFJUVUtMdUVQUlVES2IwalMrTCtSdVRJVVpUa1RK?=
 =?gb2312?B?ZEhUdDYvV05PN0kwSGFtRmJNU1N6L3I0VkI3TVFaS2xoOE4yMWExQytiK3BK?=
 =?gb2312?B?dlRuRmVNYS9odkpwRTZSdXNRdDlDY2lvZ2NUY3hXZCszT2FmTzZUOXp4bGRq?=
 =?gb2312?B?bnVEdEYzN2JOOXlNcUhNYlpiNHlNMCtnbGFNYXRTRGU5alFPMmdwT1hwbUJn?=
 =?gb2312?B?M01QekE0c3Jramk2Ukk2ZmNvVjd5MVl3eFNycjFDUEl0eUZvQXRFR1dEeUNB?=
 =?gb2312?B?OUhLSWtoUnFEZHBocTRsSG1td3VoQTY0cW1ERUFMWGE5SDl1V2FBbjRlSURj?=
 =?gb2312?B?MXE3WWtHaU1pVXJIRkgvU0xET0tLMGVsMy9mN09Xck5yckw1QjFyRHQyb013?=
 =?gb2312?B?YnpXSUMrKzVuZmRXSVh4eGJmMTkyOTR3clFkOXQ1ME5Sb1dEZkM0Tm1VekZ6?=
 =?gb2312?B?c1hUUlYwRklkY0NnbWlwTWxQNzJncUlNK3AybHNvN3pFbWp3ZUJXY015Wjgr?=
 =?gb2312?B?TXR6cHNNREZiYi95MWFyTVozcDlyanY4Ukg0VnlicjJkYWdyOVRtdGlJSk4w?=
 =?gb2312?B?L3RjeWxqNkRLelVTeU9lLy8yQVJQOEU0MnBJUmdwTXVJMXJkWVhsU0NMbDJM?=
 =?gb2312?B?WmM3Y1NlWGt1ZkJIVThiN2lCYnFyM3FicStndWdteXh3WEdzR1hjdHBpN3RB?=
 =?gb2312?B?UmlxTE9aTVFoZnJLakc0RWpHVXM0amlNNU5uR2duM3htNGt4UXFzWmJDV3hp?=
 =?gb2312?B?Mk5IRVRhOVFxTkx2dnlIWXplY2xiTU9qenQwenZDZG1KSUozOGhOQlpJNmMy?=
 =?gb2312?B?cXVXZGpiSU1HZFNNMGxaM0xwWkZnanl5WlVxR2ZKeGpkNjF2RFkra1FpTGRm?=
 =?gb2312?B?WnlkS0UvSEtaMldPcUpnOXVkLzJ5YUFjWERydTNqUzZHRkFVZGNJcTlEeURR?=
 =?gb2312?B?Slh3TURrSjNSRHFtMXAyKzlHL3ZQSWRNeVlFSmRoc3VmRGNTbHFXKzUyR3VG?=
 =?gb2312?B?S1d0TjJSMkZaQW4yWXVuT2pocGZvVU9Gbm5WVXlXbG5GK25jSGl0eStrSUM5?=
 =?gb2312?B?SkhDWnZlTDk5eDJVa0NjbCt3MUU3SGQ5OFpvbzlXdHpVblZMWlVNQkNQWmNr?=
 =?gb2312?B?VDhZRys4RXI4TzAyR3pZb3BUVWlnOFkyaEFnSHhPK1hOY1ZjZjdjMHVEbDBv?=
 =?gb2312?B?bWk3TWh2RGlWSTliZEt6eGRpWW1LT1ErZTlBYzd2d0VVQzArWkRWSUZjYTFH?=
 =?gb2312?B?dWJ2bzh6MTZWa3hJSjBlcGUrZUNPYnYzcmlyMG0rdW9VbE9pTW5JaklBVzRG?=
 =?gb2312?B?SURoeXZCSXEwME1TMkZwRUVxdEtqL3Jhc1RKcXJQdVdqTUV6TVBtdjJiam1t?=
 =?gb2312?B?aEkyOXRwc0JaWmZOMGJsZHBpQVNCbiszNEY2c1lONkp4dXhucFNrNDUrR2xU?=
 =?gb2312?B?d1J5QzNJZXJwQ3VpUzZqUjVxR0tlVmwzTHF5dzlSRjllMVBrdmNKZVFVV1BH?=
 =?gb2312?B?V3ZJNk9mbkNETW8wd0dWU0NSZWRtRTZvakxocS82RDlmcUdpYjhpK2JWc3Jy?=
 =?gb2312?B?TUJoanpmZy9FYmd3Rnp4TmxYd3ZmMllFamduWW1QQ0dHc3VkWnpDeHJmYW9i?=
 =?gb2312?B?UE9NU3ZaTXIzdEZkQkhYci9xTXB0QU9kbzRhaHlsZVZvcVBCM0doWXJlOXVM?=
 =?gb2312?B?d1RzcWlqUjczMkVQdWZuMjd6bkFReGIxazZTWHRVOVRPOWZhS2NYdnFCTEY3?=
 =?gb2312?B?ZVgveUtxd091TzRYWjE1UDVUNmxSRVZGNmxIUHU4NWJhUmZLeFJkRlJRcFFK?=
 =?gb2312?B?TDhIVWdCdGRuNmh0eld1Y2FnakNFVnhCcm55N3ZEblQ3cXZPbEl6cmFTUXd2?=
 =?gb2312?Q?a0IZ266JboXnl7MA=3D?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669430F11952E58F7D0CAA6C452ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	AVXFYEBJZorMqnyyFhuCoR0tqqKCV+IbxH3i0WgrLveKPIs0yYIx1blNFo1yEGmNkeyiqkB3VDiOq6W1a3VXri4NappMUfZ9swKHBrc228HurmiUs4F8RUOipQ14safryygslSCObhKuVDD/aBwsS2eyhi2eOO8yQcOfoYxCreIctQNWAP+NYVm2rPS8vcUs+eTvHEjYAbASI8ueEtTYn+FLLjhfISuFEBQsPAQUX8RFkhE8mo7Hpyic15i6K5Vfc/ueUqPK+DZm0IuYQdSvNm0Kzi4TM71zS4C5vBnOElr+eMCQ1lKA3blP21XcYXf2YOu+W7Rh1/PREPsH46fvhA==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977820af-eac3-4bc0-5e8b-08de8e65d6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 14:08:37.8219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzD72QYqo3eyHzvL/1ori3PO4NBneYLST+cyACyzu1Nk4p56PonRSw6/xYYtCuEVnsn+5BPGCtpSbqE9rbxbDE7b4/JQ96qv64SjXC43ntlykaI9o5NwvnGgRsRaxuRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12805
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2026 14:08:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22607

--_000_TYCPR01MB9669430F11952E58F7D0CAA6C452ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgQ2hyaXN0aWFuLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4gQXBvbG9naWVzIGZv
ciBteSBkZWxheWVkIHJlc3BvbnNlLg0KDQo+IEJ1dCBpdCBkb2VzIGdldCBhIGJvb3Rsb2FkZXIg
c3RhdGUgdXBkYXRlPyBEaWQgeW91IHNldA0KPg0KPiBzb2Z0d2FyZSA9DQo+IHsNCj4gICAgICAg
IGJvb3Rsb2FkZXJfdHJhbnNhY3Rpb25fbWFya2VyID0gZmFsc2U7DQo+ICAgICAgICBib290bG9h
ZGVyX3N0YXRlX21hcmtlciA9IGZhbHNlOw0KPiAgICAgICAgLi4uDQo+DQo+IGluIHRoZSAuc3d1
IGZpbGUgYWNjb3JkaW5nIHRvIGh0dHBzOi8vc2JhYmljLmdpdGh1Yi5pby9zd3VwZGF0ZS9zdXJp
Y2F0dGEuaHRtbCN1cGRhdGUtYWN0aXZhdGlvbiA/DQoNClllcywgdGhpcyBpcyBzZXQgaW4gdGhl
IG9uYm9hcmRpbmcgcGx1Z2luIHdoaWxlIGdlbmVyYXRpbmcgdGhlIG9uYm9hcmRpbmcgc3d1IGFy
dGlmYWN0IGhlcmUgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wbGF5Z3JvdW5kL2NpcC13Zngtb25i
b2FyZGluZy1jbGllbnQtcGx1Z2luLy0vYmxvYi9tYXN0ZXIvb25ib2FyZGluZy1wbHVnaW4vdGVt
cGxhdGVzL3N3LWRlc2NyaXB0aW9uLnRtcGw/cmVmX3R5cGU9aGVhZHMjTDUNCg0KPiBJbiBvcmRl
ciB0byBub3QgaGFyZC1jb2RlIHRoaXMgYXMgaXQgaXMgbm93IKhDIGFzIHRoZXJlJ3MgYWx3YXlz
IGEgc2VydmljZSBtaXNzaW5nIGFuZCB3b3VsZCByZXF1aXJlIHRvdWNoaW5nIHRoaXMgY29kZSCo
QyBJIHdvdWxkIHN1Z2dlc3QsIGZvciBleGFtcGxlLCB5b3UgZGVmaW5lIGFjY29yZGluZw0KPiBz
eXN0ZW1kIHRhcmdldHMgaW50byB3aGljaCBhbiBpbnRlZ3JhdG9yIGNhbiBob29rIGFkZGl0aW9u
YWwgc2VydmljZXMgc28gdG8gbWFrZSB0aGlzIHNldCBjb25maWd1cmFibGUuDQoNCkZhaXIgZW5v
dWdoLiBVc2luZyBhIGN1c3RvbSBzeXN0ZW1kIHRhcmdldCB3b3VsZCBtYWtlIHRoaXMgbWVjaGFu
aXNtIGEgYml0IGZsZXhpYmxlLiBXaWxsIGFkZHJlc3MgaW4gdjIuDQoNCj4gU28geW91IGNvdWxk
IHNldCB0aGUgc29sZSB3Znggam9iIHRhZyBgb25ib2FyZGluZ2AgYW5kIG5vIHJlYm9vdCBieSBT
V1VwZGF0ZSB3b3VsZCBoYXBwZW4uDQo+IE9ubHkgdG8gdGhpcyBzcGVjaWZpYyBqb2IgdGFnLCB5
b3VyIGN1c3RvbSBwcm9ncmVzcyBoYW5kbGVyIGFjdHMgb24gYnkgKHJlLSlzdGFydGluZyB0aGUg
cmVsZXZhbnQgc2VydmljZXMgdmlhLCBlLmcuLCBhIHN5c3RlbWQgdGFyZ2V0IGFzIG91dGxpbmVk
IGFib3ZlLg0KDQpZZXMsIHRoaXMgaXMgaW5kZWVkIGhvdyB0aGUgY3VycmVudCBpbXBsZW1lbnRh
dGlvbiB3b3JrcyAoYXBhcnQgZnJvbSB0aGUgc3lzdGVtZCB0YXJnZXQgcGFydCkNCg0KPiBXaGVy
ZSBpcywgYnkgdGhlIHdheSwgdGhlIGRpc2FibGVtZW50IG9mIHRoZSB3Zngtb25ib2FyZGluZy1w
cm9ncmVzcy5zZXJ2aWNlIGRvbmU/IE9uY2Ugb25ib2FyZGVkLCB0aGVyZSdzIG5vIG5lZWQgZm9y
IGl0IGFueW1vcmUsIGlzIGl0Pw0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBUaGlz
IGlzIGluZGVlZCB1bmhhbmRsZWQuIFRoZSB3Zngtb25ib2FyZGluZy1wcm9ncmVzcy5zZXJ2aWNl
IGp1c3Qgc3RheXMgYWxpdmUgYnV0IHdvdWxkIG5ldmVyIGJlIHVzZWQgYWZ0ZXIgdGhlIG9uYm9h
cmRpbmcgZmxvdy4gV2lsbCBhZGRyZXNzIHRoaXMgdG9vIGluIHYyLg0KDQpUaGFua3MgYW5kIFJl
Z2FyZHMsDQpBZGl0aHlhIEJhbGFrdW1hcg0K

--_000_TYCPR01MB9669430F11952E58F7D0CAA6C452ATYCPR01MB9669jpnp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Christian,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thank you for the feedback. Apologies for my delayed response.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; But it does get a bootloader state update? Did you set<br>
&gt;<br>
&gt; software =3D<br>
&gt; {<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; bootloader_transaction_marker =3D false;<br=
>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; bootloader_state_marker =3D false;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; ...<br>
&gt;&nbsp;<br>
&gt; in the .swu file according to <a href=3D"https://sbabic.github.io/swup=
date/suricatta.html#update-activation" id=3D"OWAcbcf1e8f-fe14-3d57-6310-367=
33f591def" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://sbabic.github.io/swupdate/suricatta.html#update-activation</a>&nbsp=
;?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Yes, this is set in the onboarding plugin while generating the onboarding s=
wu artifact here
<a href=3D"https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plug=
in/-/blob/master/onboarding-plugin/templates/sw-description.tmpl?ref_type=
=3Dheads#L5" id=3D"OWA46cb9af7-03c5-20ee-ccf2-26ba43d39533" class=3D"OWAAut=
oLink">
https://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin/-/blob/m=
aster/onboarding-plugin/templates/sw-description.tmpl?ref_type=3Dheads#L5</=
a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; In order to not hard-code this as it is now =A8C as there's always a s=
ervice missing and would require touching this code =A8C I would suggest, f=
or example, you define according</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; systemd targets into which an integrator can hook additional services =
so to make this set configurable.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Fair enough. Using a custom systemd target would make this mechanism a bit =
flexible. Will address in v2.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; So you could set the sole wfx job tag `onboarding` and no reboot by SW=
Update would happen.<br>
&gt; Only to this specific job tag, your custom progress handler acts on by=
 (re-)starting the relevant services via, e.g., a systemd target as outline=
d above.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Yes, this is indeed how the current implementation works (apart from the sy=
stemd target part)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Where is, by the way, the disablement of the wfx-onboarding-progress.s=
ervice&nbsp;done? Once onboarded, there's no need for it anymore, is it?</d=
iv>
<div><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
<span style=3D"color: rgb(0, 0, 0);">Thanks for pointing this out. This is =
indeed unhandled. The
</span><span style=3D"color: rgb(0, 0, 0);">wfx-onboarding-progress.service=
 just stays alive but would never be used after the onboarding flow. Will a=
ddress this too in v2.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks and Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Adithya Balakumar<span style=3D"font-size: 11pt;"><br>
</span></div>
</body>
</html>

--_000_TYCPR01MB9669430F11952E58F7D0CAA6C452ATYCPR01MB9669jpnp_--


