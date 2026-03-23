Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC9EC01B9
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 10:08:01 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13611.1774260473376576216
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 03:07:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oOFCPdZL;
 spf=pass (domain: siemens.com, ip: 52.101.70.58, mailfrom: benedikt.niedermayr@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw3Kph9ZQ8VyDAUcVVdegXKUVd6YOc2npFcsfKhHmgy5aM7J9rfSYfhOohbSDqPiz1qaJS2yyZS8p+vSkr7r46NFb2TbNhHQ7dmAbO8LVyswHzhQa1bNSCCw1p1/c06xdZchgEaMDBkNMdBB9kYsxeO9gwIWBldzXcJzPXU/3KLLUHMx7stj1kCkgplTts3LG+NsEzXpFbb8PBwXWYhf40iwPwF4K7wZ5rUW5Intuf6P9FEH4ZGGlgZVDNQu5TfAB0wG571HhHExPt3qPaEgjpDYeU3snZTGdeS3GUkbonpsmqtUnTbWp8yw7siGVFJNJABSBT8nyWdBUCHr0bnD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oC4XcixxunkRjDmzbSCRi1R+EJdT4mUl7pqFCOGxs8=;
 b=yb8Xx/vXMuUJ0JglkvTEmDgltZ+G18S5DkWmW+jJlhyAshYiL3gB94Br6am3YMhNsGFRlm2smKX3IZIa0E6PrCagEFFCFcsysdWc4iDZFIXpC66pgShWtwzQB2cY8LgvH+advQzpj6+aLAkHLk2DiktccEbpjremm86g/JcugwV4QW1ti78Dd0zf3j4h+vqn5XSx3quGGmwVXLO8UMF9jWts4M9Hp4JWnjaziUk8y1x6/K57niBddfq+ObzOORTP20lby2wqxCpWVPFlCn/PzxZNl+SlC5Ol93n6ouToAIgpZpLWTTwbczKLgN7gb8SJGzKHRZnc16a+Tu8xSnFBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oC4XcixxunkRjDmzbSCRi1R+EJdT4mUl7pqFCOGxs8=;
 b=oOFCPdZLfd/2V5Bt+F+qy4Igz345B6xkLfDLoFYofoGUYA5cVY4aa4B1xES/tll1QWy+p5aCnQ78zwxUdK1+h/H5vUwpCIvba0nveSKJL+8ZYSDKO+J3sYyk9fyfjXy5AvEGqgBIfh6beLLAe8HFBxdSr69Kt8mbfkRcyfSTw0WOYK1pbGdJM86pNr7Ys2T3wLoG7jHbfx6Uz8eDX0Tk1PASG6q83f2JYXY6OEanahAmYTV+qCciPOUw6x/MQWlGXYhMQJSTnJJKwC8K5Bvqwx0jhxfLDg1Rx3eDy+A3ABQcEb6r0fzMW+++TIk5LWvr2dolUO2pGs4J2hLelixCpQ==
Received: from AS2PR10MB7639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:645::6)
 by VI1PR10MB7831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 10:07:47 +0000
Received: from AS2PR10MB7639.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e19:8b3e:89c2:cde0]) by AS2PR10MB7639.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e19:8b3e:89c2:cde0%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:07:47 +0000
From: "Niedermayr, Benedikt (FT RPD CED OES-DE)"
	<benedikt.niedermayr@siemens.com>
To: "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] start-qemu: allow more variable injections
Thread-Topic: [isar-cip-core][PATCH] start-qemu: allow more variable
 injections
Thread-Index: AQHcuUELSc8r8BEMS0u3kUIhdQfBMLW750gA
Date: Mon, 23 Mar 2026 10:07:47 +0000
Message-ID: <147befda-14e5-4d81-bd37-e8da6afa5830@siemens.com>
References: <20260320101020.2534001-1-benedikt.niedermayr@siemens.com>
 <ca460c60-093c-49f8-a4b8-11f93d784196@siemens.com>
In-Reply-To: <ca460c60-093c-49f8-a4b8-11f93d784196@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7639:EE_|VI1PR10MB7831:EE_
x-ms-office365-filtering-correlation-id: 30aa33b8-b8cc-4024-47e3-08de88c4089b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003|55112099003;
x-microsoft-antispam-message-info: 
 gtNP20QzoTp18ah4myH+nrs+Vjqn79CHwu0GahrGiSvuTSFYER/0g582HihfVV9u0Fp82mdxj+CnFCHUVaxTJBHVbdE4t3+4+8wXD4gUuffzQNWm6HQSRkomobARM1sgqoTmu8uC13MEVy11CJyMEfkxd8NVPBBnsY06DvDF32KxPL6hX4IvRhjao7arM8FpscdHgQ4g09xTpYn0d9Xjg12pcNfWlrOdc6cR1FD8yZebc3ZIHF8mukapEYji6PR+1qmDZ+bPJMgpNUCClV8dNirYZqPGXaxT+u1D4we0YJ+ncxzQXtKhnBVH2Ug2ECTdfqB+RkRvWbzSgsPd+wk3HndORRMW/kl3bj5YDFFx5JMkpMxql8xxs6Bzsaf+dSNn1Q9ALn42wK89JXFCg2MOSTm8mOVWR0rWMx5sTGEbHRTjq1uvwB09P19UM3l+LFHGI7a/2EPBs9Euoh7qEC0BPzvYreLrkrzFj+OX26TzZL7magggdM1fXN/m25ZH5H15X2OU463QQt3fnh1kh93QUAOSgq+KkEuSNEH3h1+rpG04D2ApgtqX/mAol7D3IXO4byBo/VPayXBFL4F5k0tbb8btj57nMw0o4Kt/8Uso/VnsR8g4ktdBLfV684qgqzq6sVp+pJGKQ5+oZ/65Z6LbX63imOg3IXQ/B5R6z+4jhQyzRZJ5JAxkWhu5f1dTHSU17mBxS7k3SSVUdClcAK3k9qcz6exMwMj1jRePvpjTXbGW1mbVu20h0rOlfrdC/Q3cj6Cj9DShd1M1gAbZR9sZPlDi58G65To8v7BTtnu7rzs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7639.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QkxNaW1xTkhEcWE4Ymc0RXphSitHekZXcXJpUXZZZS95WXJCaWU2VEFBaE1H?=
 =?utf-8?B?eEZ2RVc2dXRWQUZZRElYV2VSYk1yaU5WYnZkdFEwMGZlcVR5djNOekVBUkd2?=
 =?utf-8?B?TU14WWlTTTh3T0lvWjhRREZEQXNvU0trS2FmWURTcUd3d0hOcHVna2poekll?=
 =?utf-8?B?ZVFNYjdwM2ZscDUzd2Y0Mk5TSUpTUER3RUhwRWpBY2VDajE2eVcwaVFjWnBV?=
 =?utf-8?B?bGVkZVFlQTlET2UxOE5DVE1qNERaMmJHeVM1dGZwVzh5eDRjQ3dudkRncWNF?=
 =?utf-8?B?TisvdTYvK3NHYlJRdzRrS2JMNG82b2J1S0lBUndYZ2F2eS8wS0tvVXplNXk5?=
 =?utf-8?B?ckhxK0ZaZkRNclhTc2Rpc1YxM3hKSjNmNW54L2V0Y09HRmxpV3hCSkZzWkJt?=
 =?utf-8?B?QllGbEpDL3RlOTQ3dFRkZGEyT0YwTGZmNXUxNzRmZjhaWkJBRDEwOXRITjhX?=
 =?utf-8?B?SWtlY0J4V1U4emc2RFF4dGN1MDF3UGN4Z3lna0NIQmJvSUc1K3RpN3pIZDlt?=
 =?utf-8?B?Sld0YjZSa3VWTlM4RU0yc1B2L0N2QXRERHNKMnFRZzA1SFZMTERDYlBORnhS?=
 =?utf-8?B?eUsrTit6Q2lrWGlPSVdxR29leEk3NjgyUGtOOXI3NHNMU3VvdkxSazBEUXNk?=
 =?utf-8?B?NHZWcE9OOTVmZ2IrbVVxNzNCOHZUWVd2SXFBUzNaMzljMkZacnE5cWxLTDlo?=
 =?utf-8?B?TjhoOHB0VGFjK0pGcHdsTng5NTdTSlRKRWJkemQzWFVxRnV2TVVSSTJDWnJM?=
 =?utf-8?B?OHRwRHFwU1lacjFwNnhBNWliOVFNWWFJb3hISm9oc3UvWkNmelUra2lMcllx?=
 =?utf-8?B?Y01ZTkhzS0lYanNoNWRpbEprSjEyYldqdzBBMWVqWGhtblhaT2VUQUtsMG12?=
 =?utf-8?B?M1hTdEJpZXErR0tGai9BejJNTHlCa3BSaUMrdlB2WUlxSUNPUU1QS0JpdzFL?=
 =?utf-8?B?cCsrVU9yMzlPK0pKZW5JTkREYk5yRVZkZ3k2anR3UHRtbTdDOXFlcXFzL1U2?=
 =?utf-8?B?YmNLbVJmd0xKWnRSU2FrbmhJbkVidHEzaVJJMWpqZEgvUjl5VDYvUWxHZnpz?=
 =?utf-8?B?TUpCYzdKNGZwODRPeEVjSFBvSEkrczdraFZWamZZNnVXODV4MTVSdzdjUmE1?=
 =?utf-8?B?WlZXUit5Zzk3bWRyZkVpRXE3TG9scTRlSmlKc1lHVUwzSVZqYVo2TXVISlNV?=
 =?utf-8?B?RUpVd1pqeVAyMFJqam43V21RZ1FZTFhxWjdQUWNmbDBlL2RGc05lK0o5N3NW?=
 =?utf-8?B?alBwMjhzYnEvYnBtSnhzQWwzMURUM2JoUFFBNU5JQ2lpTUxMNnFoZTdDUFJn?=
 =?utf-8?B?dG9Dc0tKMXQzMUZKWXIrQXRVc0JCQ1JVRGJVRzc4UDAwa1IrQWUvNndCUmlq?=
 =?utf-8?B?SFB2TTRnTXlEYkVrVGROSWFZVUd5RGhFblY1VVNwa3NySXVjSXVWeTRzVmlH?=
 =?utf-8?B?QmdOWTd2OUVualBna0ZNUU40R0ZvdFA5bEZqenVFcHdtK01JRVBXM2dadE04?=
 =?utf-8?B?OW03V1o1cWN3RFhqWVV1cUduQ2JJV0hhUHdYaDU2QmNrTm9PS1Q4UW9YUnpR?=
 =?utf-8?B?b2VlZ3pCRXFuZnVJUWlubk9QN2ZjNzlRYmwyaDM5ZVQrL2UyaU1kc3AyclR1?=
 =?utf-8?B?MXYvWnZtYWFPZVZrODgrakJaT3gyOHdKOUhhcnpQRG1sUHhEM1pUamJqbUo0?=
 =?utf-8?B?bnpGVUtFZ29EaDFkOXpRWXJKZFBKa2k5RE9XYk9zOUFsTFREQ0NUK1JGcnl6?=
 =?utf-8?B?TlNUbDUrOWdjeWFnZFNjeWozWmlBK1BsaVVLYnE0cHMyNnRraUVGVkU5Y2JG?=
 =?utf-8?B?MEVzNFQ0R0llQytkcDhmRE9TNHBzUWpJZTFZVm03UWpSenpaT3J0eERpcGdk?=
 =?utf-8?B?TUtKYVNaekVpbWd1TTZzTFRBOWdvbk9oNllkeDVNdzFzbytzdC9KR0VBb3VN?=
 =?utf-8?B?RGNiZHJmUTJnb3J5S0JZdlZxaE5ZSWozeHhBV2J0azAvRDh6bnJLZHVVOXF3?=
 =?utf-8?B?Sy9xcjExZVE0aWZmOXJobitpdmprVmM0RWhHcWRSL0NhZkRTUGdnRk1zdktr?=
 =?utf-8?B?OUJHM096TzBGcUwrVkw5ZjJjQnRBOTNWMlZnUUdIL2I5aWg1dDVYNC9OUEpT?=
 =?utf-8?B?MThxdXNqaThrK1VISldFOCtUcnliZjA1RHJnSWZTZThCYmZGMm52WFkxKysz?=
 =?utf-8?B?V1NmakZFWmJPdkVJdmVybjhEWmp2TFY3STFJbWYyVUE0M1E5RWlRdEVsWFpW?=
 =?utf-8?B?YW1TQ2UyV2dTa2NyZVRXenJhUE05YTA4ZWw2cDg1OE5VYWpPR1doWFlHaHlF?=
 =?utf-8?B?QUc0Wk92SmtWV1QvcVVJelNGSzh4SjdwY1l3cHRYc2syaEZlc1cxeG5mVEVE?=
 =?utf-8?Q?nPECto9GyK4m7V+I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4E89710B124EF448D08E5A88F92DEA5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7639.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aa33b8-b8cc-4024-47e3-08de88c4089b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:07:47.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqwIqfOgAwLsSMJ4oDTJqQ1FDvWAPNC4mxSIXjabY/pGWF6Ds+9K1TUMhinp9yPbNlQKN6MGsxdfFFYtnVEHQL67KdVHRW8P1VwJmrCHR/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 10:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22524

T24gMy8yMS8yNiAxNTo0MywgS2lzemthLCBKYW4gKEZUIFJQRCBDRUQpIHdyb3RlOg0KPiBPbiAy
MC4wMy4yNiAxMToxMCwgQmVuZWRpa3QgTmllZGVybWF5ciB3cm90ZToNCj4+IFRoaXMgYWxsb3dz
IHRvIGluamVjdCBzcGVjaWZpYyB2YXJpYWJsZXMgaW50byB0aGUgc2NyaXB0IHNvIGEgbG9jYWwg
a2FzDQo+PiBtZW51IHJ1biBpc24ndCBtYW5kYXRvcnkgYW55bW9yZSBhbmQgdGh1cyBpdCBjb3Vs
ZCBiZSByZXVzZWQgaW4NCj4+IGRpZmZlcmVudCBlbnZpcm9ubWVudHMgYnkgYWRqdXN0aW5nIHJl
bGF0ZWQgZW52aXJvbm1lbnQgdmFyaWFibGVzIG9ubHkuDQo+Pg0KPj4gQ3VycmVudGx5IHRoZSBz
Y3JpcHQgcGFyc2VzIHRoZSAuY29uZmlnLnlhbWwgd2hpY2ggaXMgb25seSBhdmFpbGFibGUNCj4+
IGFmdGVyIHJ1bm5pbmcga2FzIG1lbnUgbG9jYWxseS4gSW4gY2FzZXMgdGhlIGlzYXItY2lwLWNv
cmUgaXMgaW5jbHVkZWQgaW50bw0KPj4gY3VzdG9tIGxheWVycyB3aGVyZSBpdCBtb3N0bHkgaGFw
cGVucyB0aGF0IHRoZSBrYXMgbWVudSBvZiB0aGUNCj4+IGluY2x1ZGluZyBjdXN0b20gbGF5ZXIg
aXMgY2FsbGVkIHJhdGhlciB0aGFuIGthcyBtZW51IG9mIGlzYXItY2lwLWNvcmUsDQo+PiAoaW4g
c29tZSBjYXNlcyB0aGUgaW5jbHVkaW5nIGN1c3RvbSBsYXllciBkb2Vzbid0IHVzZSBrYXMgbWVu
dSBhdCBhbGwpDQo+PiBvbmUgbWlnaHQgc3RpbGwgd2FudCB0byByZXVzZSB0aGUgc3RhcnQtcWVt
dS5zaCBzY3JpcHQuDQo+Pg0KPj4gVGhpcyBwYXRjaCBzcGVjaWZpY2FsbHkgYWxsb3dzIHRvIGlu
amVjdCB0aGUgQkFTRV9ESVIgYW5kIEZUUE1fU1RNTSB2YXJpYWJsZXMNCj4+IHZpYSBlbnZpcm9u
bWVudCB2YXJpYWJsZXMgZnJvbSBub3cgb24uDQo+Pg0KPiANCj4gRGlkIHlvdSBjaGVjayB3aGF0
IGlzIGxlZnQgYWZ0ZXJ3YXJkcz8gV291bGQgYmUgZ29vZCB0aGUgc29sdmUgdGhpbmdzDQo+IGNv
bXBsZXRlbHksIHJhdGhlciB0aGVuIGFkZGluZyBhbm90aGVyIGxheWVyIG9uIHRvcCBsYXRlciBv
bi4NCg0KSnVzdCBjcmVhdGVkIGEgdjIuIElNQUdFX0RBVEFfRU5DUllQVElPTiB3YXMgc3RpbGwg
ZXh0cmFjdGVkIGZyb20gDQouY29uZmlnLnlhbWwgb25seS4NCg0KPiANCj4gUGxlYXNlIGFsc28g
ZG9jdW1lbnQgdGhlIHZhcmlhYmxlcyB1bmRlciB1c2FnZSgpLg0KPiANCj4+IFNpZ25lZC1vZmYt
Ynk6IEJlbmVkaWt0IE5pZWRlcm1heXIgPGJlbmVkaWt0Lm5pZWRlcm1heXJAc2llbWVucy5jb20+
DQo+PiAtLS0NCj4+ICAgc3RhcnQtcWVtdS5zaCB8IDExICsrKysrKysrLS0tDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL3N0YXJ0LXFlbXUuc2ggYi9zdGFydC1xZW11LnNoDQo+PiBpbmRleCA3Y2NiZWZlYjVm
NDcuLjVhMDkyNDI1N2IzNyAxMDA3NTUNCj4+IC0tLSBhL3N0YXJ0LXFlbXUuc2gNCj4+ICsrKyBi
L3N0YXJ0LXFlbXUuc2gNCj4+IEBAIC04MCw4ICs4MCwxMiBAQCBlbHNlDQo+PiAgIAlmaQ0KPj4g
ICBmaQ0KPj4gICANCj4+ICtpZiBncmVwIC1zIC1xICJGVFBNX1NUTU06IHRydWUiIC5jb25maWcu
eWFtbDsgdGhlbg0KPj4gKwlGVFBNX1NUTU09InRydWUiDQo+PiArZmkNCj4+ICsNCj4+ICAgaWYg
Z3JlcCAtcyAtcSAiSU1BR0VfREFUQV9FTkNSWVBUSU9OOiB0cnVlIiAuY29uZmlnLnlhbWwgJiYg
XA0KPj4gLSAgICEgZ3JlcCAtcyAtcSAiRlRQTV9TVE1NOiB0cnVlIiAuY29uZmlnLnlhbWw7IHRo
ZW4NCj4+ICsgICBbIC16ICIke0ZUUE1fU1RNTX0iIF0gOyB0aGVuDQo+PiAgIAljYXNlICIke2Fy
Y2h9IiBpbg0KPj4gICAJCXg4Nnx4ODZfNjR8YW1kNjQpDQo+PiAgIAkJCVRQTTJfREVWSUNFPSJ0
cG0tdGlzIg0KPj4gQEAgLTEyNCw3ICsxMjgsNyBAQCBjYXNlICIke2FyY2h9IiBpbg0KPj4gICAJ
CQktZGV2aWNlIHZpcnRpby1zZXJpYWwtZGV2aWNlIFwNCj4+ICAgCQkJLWRldmljZSB2aXJ0Y29u
c29sZSxjaGFyZGV2PWNvbiAtY2hhcmRldiB2YyxpZD1jb24gXA0KPj4gICAJCQktZGV2aWNlIHZp
cnRpby1uZXQtZGV2aWNlLG5ldGRldj1uZXQiDQo+PiAtCQlpZiBncmVwIC1zIC1xICJGVFBNX1NU
TU06IHRydWUiIC5jb25maWcueWFtbDsgdGhlbg0KPj4gKwkJaWYgWyAtbiAiJHtGVFBNX1NUTU19
IiBdOyB0aGVuDQo+PiAgIAkJCVFFTVVfRVhUUkFfQVJHUz0iJHtRRU1VX0VYVFJBX0FSR1N9IFwN
Cj4+ICAgCQkJCS1tYWNoaW5lIHZpcnQsc2VjdXJlPW9uIFwNCj4+ICAgCQkJCS1kZXZpY2Ugc2Ro
Y2ktcGNpIC1kZXZpY2UgZW1tYyxkcml2ZT1kaXNrLHJwbWItcGFydGl0aW9uLXNpemU9MjA5NzE1
MiBcDQo+PiBAQCAtMTc1LDcgKzE3OSw4IEBAIGNhc2UgIiR7YXJjaH0iIGluDQo+PiAgIAkJOzsN
Cj4+ICAgZXNhYw0KPj4gICANCj4+IC1CQVNFX0RJUj0kKHJlYWRsaW5rIC1mICQoZGlybmFtZSAk
MCkpDQo+PiArQkFTRV9ESVJfREVGQVVMVD0kKHJlYWRsaW5rIC1mICQoZGlybmFtZSAkMCkpDQo+
PiArQkFTRV9ESVI9JHtCQVNFX0RJUjotJEJBU0VfRElSX0RFRkFVTFR9DQo+PiAgIElNQUdFX1BS
RUZJWD0iJHtCQVNFX0RJUn0vYnVpbGQvdG1wL2RlcGxveS9pbWFnZXMvcWVtdS0ke1FFTVVfQVJD
SH0vJHtUQVJHRVRfSU1BR0V9LWNpcC1jb3JlLSR7RElTVFJPX1JFTEVBU0V9LXFlbXUtJHtRRU1V
X0FSQ0h9JHtURVNUX0lNQUdFfSINCj4+ICAgDQo+PiAgIGlmIFsgLXogIiR7RElTUExBWX0iIF07
IHRoZW4NCj4gDQo+IFdvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBleHBvcnQgSU1BR0Vf
UFJFRklYPyBBIGRvd25zdHJlYW0gbGF5ZXINCj4gbWF5IGhhdmUgYSBjb21wbGV0ZWx5IGRpZmZl
cmVudCBpbWFnZSBuYW1lLg0KDQpZZXMgbWFrZXMgdGhpcyBzY3JpcHQgZXZlbiBtb3JlIHJvYnVz
dC4ganVzdCBwb3N0ZWQgYSB2Mi4NCg0KVGhhbmtzIQ0KQmVuZWRpa3QNCg0KPiANCj4gSmFuDQo+
IA0KDQo=

