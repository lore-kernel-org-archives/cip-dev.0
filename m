Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF0DCDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:43:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15061.1782197003917887262
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 23:43:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=S07BIaB/;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1782196994;x=1783406594;bh=/hZCYTzQn0O2YxPqyQ5evNtNaR6Pt8KCfnkL5
	cH1vqw=;b=S07BIaB/prMnjcONN5Uo9kebNFJripT0o6jhHaSd73KMOzEzKd5UhUG75+MuOp9mrJU
	xPum9n5tlZrxCbs9M4WRZVYAFmvdlpjpiVJZckNQQ1Jo/QTNPKg8AtoDFHDkV17EDkz9891xhh4Gi
	U096KXWralPS6EJKyVSE/JapT1Ttuv3tIB30mSNy9ppzVBQBcaUSxHBRaulNj/rUSvMRIjs9aWxM9
	WzLgkNXXlGSikPXTGh42LpYTD+5NAKAVT4hWp+2YZYpBhGUt/55CYWgil9mzXFkntlqJxByi7SLsZ
	NOXTit78Y+mfKB/G4MVl3j0liibZGBBRr88KCITWdTrA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65N6hDps3200592; Tue, 23 Jun 2026 15:43:13 +0900
X-Iguazu-Qid: 2yAbhMIERek7Y8FCQ4
X-Iguazu-QSIG: v=2; s=0; t=1782196993; q=2yAbhMIERek7Y8FCQ4; m=m09qjMQlkUuoB6wbg7vecVgFZtjXng6HsFQwONoH02I=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gkwW510BRzyPQ; Tue, 23 Jun 2026 15:43:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/w3qLn5lIbSv/kPNAU9Pxs0tlT/V7E223+h6gVmVADnAT3vli2Xgdxe5Sor7Ct7k1nP+INexivin/6BBTbWHwIh3y8YsKQKxVDlpoMvJwUU9GyR4Qk02/MgyPjMXnbKZyYvKx3U28AAB4qbN5tw/iQrehGWvD6AvGcAG5hTzfjlX2BdNa5BrOOa+OMv2gPPqFHkHJwvyAdqwsb9S4lXnq3MAALdu3w9R6AX2UkUhTAF3TnXB3x35adWbCRyHfw2zo00yRuxsNi/TFrvOc5UUMMJ+xEUXhu6Hq/n1sZG+dehBRvQoEW7cmv+LVdHFfLmcFq52n/5XT7ASXhtGPJVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hZCYTzQn0O2YxPqyQ5evNtNaR6Pt8KCfnkL5cH1vqw=;
 b=y8inTGzosSrrravUxHvGEjJ9zkhUlT5kgEznIquWdDyIL/4n97NCrYMMyEoeBs0mGwQd8zzEkM6SIi2Yfsa1x5MSQH5XngsQC3LA5v0eq/oZOQmRELKuBDj9fwS8/iazeuupfObNJHzsdRxGlCdG/bHxDicb2lpfQE2VbYqCu+nEIDxp+p2yvEeDmk6D8b5HqJcvaSMXXlkE24dtuvyzr8Zi4DWHM8qHpVeHzHVE7milplzEvDgXL845JE146lkC+1Jnm2YLOK9jm0vOZprVwd4D2bHNHmKyaqNTi6REIutc6U0A7zw0OA8jwzUER/7uioWFJwhIL9ogKS9XO7Yfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: Request for review for 4.19-st18, 4.19-cip134
Thread-Topic: Request for review for 4.19-st18, 4.19-cip134
Thread-Index: AQHc//bicMu07oeoO0qNnuPVvnW677ZLtlDQ
Date: Tue, 23 Jun 2026 06:43:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182F0C70D897CDFC896781CDEE2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <92480685.1219204.1781878850004@webmail.strato.de>
In-Reply-To: <92480685.1219204.1781878850004@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB12498:EE_
x-ms-office365-filtering-correlation-id: 9af53186-5ba5-4db0-72b9-08ded0f2b12a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info: 
 bEudFe0D+kHmbwnx/7FsMRVZyOmOMSQm23hmROiqkGJss42tOebdyt0kVciymSjC7GhmTW5MewzzY0E4UKSY1Amrk4GcBCIWgGtL6y6j5FOHAxIsuPI/y/OSKum+yH1e3Swlx7cH5b9sWOPlFVGqA9vRu1caDLfj5uchQ5crGXOME3iBIUXAXnitY+4uY8Oz0qtDZQ8BBzdbspoFHYuhNnpxS60dqJzImKZXbUYPRWKwpzOgpuQoBIhFh2IOUMOfmUIY2Lq1jrvGPf8bfLT3LXELKrokhh4MuIr+RWVrKnFuQWc34KaPgv2Fl2JnrjGo/X0lNHFEUXk2rilGNvBbZcrQdigmRIDxqCKI73lSRTe86s7ledl5RVkx7VUFC5pR3U19377CcfGnKSNDSNmkh/+lttl0toSBWCs1wmb/pPl8dRxOCCou5qOI8lxOWo1GWLltY7xRf/CLLY+1rJeHd4K+cdJYcl3WmvwiCJtvrt/tfu5YWLdBPbWSnDCjzg0BoBqVahgbUJEivjrnpZ0cBxJjT8+xpJ6+2n/GsKksifQrrGGkswyYBIWqYL0NhoREl9Xla+RDAcgAA8Rrq+LC7ZFOrkjerDpoGb5r3yRlUwU9ze0vfROzvy2DD7N7uJ+cM/0z8ZZ2ier0T8p0mnwe/mjqR4hv+jbudNCCmMscUpxAFuf9iyYRyefJKMFgvRx5VSLgHfhPVcUDy3u44N3b9/RSSduxDX+j7ZoNhppkURo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YXJ6V2lKZ2pkdDM3MVV4akhVQW1zbTB0dFcwSlJpWHI5RXdnRlJMRGM2SW80?=
 =?utf-8?B?NFBGSVk4akM3R3FnbFJrekZla3lxQ0hzcCtwYkJBOGJSR1p3RTFYTytncWt5?=
 =?utf-8?B?WDNpN0lnQWswcCtFYW9IMEphRU1FSE1tMlBZV3ZBUDE2enFqczdEeHp4aVBX?=
 =?utf-8?B?M1YrTTBzQVNMOUM0ODYxY21aYW5KK3hYV0Y3TXhtV2M1QjVYQitqMDBqNjY0?=
 =?utf-8?B?b3YwRFAyWFR1Q1l0eDNNbmtNSFpQNjVNUC9EVXpnRXpMZmpsc1Q3YkdDRTMr?=
 =?utf-8?B?ZEtERU1INitKWHVMTzRmZGV4REpmek11YmlIRXdwdS93dHFNVENINDZXL1NT?=
 =?utf-8?B?VXJXNklHZGhyNUQxdGJWcmVEOFFVT1FpY0t4Q0ZOa1M2RmFMQVdhemxrWVlv?=
 =?utf-8?B?RkY1NjE0WkdvTnRHMEpsTXM2Mk9wMFhwM3hiaGxHRHV5dkpkNTM5RXc1cVVQ?=
 =?utf-8?B?VEhUb0d3Mm04YWE0NmZJc29sc3JwTWRUSklnUnNEWFluVmVnWk5oZzlRV3BT?=
 =?utf-8?B?b3Z3cVN0QmpDZXVseThGczlpUzNnQllaR3A1bFdnais1NWtONmZBM2Z5VUpT?=
 =?utf-8?B?enI0ZFlPWHNkelNGWTlHVVI0OXI5VlF5L0RSaS9Tak9ZOTlZbmFjR0hwYVJT?=
 =?utf-8?B?N3VZV21WZVVJVXJhOEZXcFgzYlNpR1I3RWpUdDRsSFg3UXcydFh3bnYrT0tx?=
 =?utf-8?B?S240alV6ckk1ZTJjQVJPbHZMdFNaNkk2dzl3Z1Q1ZkJES3FnVmFaNXhXMjFm?=
 =?utf-8?B?a2toWitVSXA1Y1A3K0h0NkhnNmFibW0xTmdrVmJNK3l1ZzVPcmpkd1pSNmdD?=
 =?utf-8?B?QXIrdkxobkF1M0Z1Szh5MGRIbzZ0K3o5dElkeE1ZMDhSak1KYnhIbisvcWVa?=
 =?utf-8?B?VzhCNUx5VlI3V3dSWUcvY0lTVDJoOHpkUnd1NDl6OXVDU0IyUUVFTmZiNmFZ?=
 =?utf-8?B?OU5mbUQ4OUcwVUE1YnA3SytGdHpaMGRheHRCcTdCaEthKzdUcmhwZTUvaUVC?=
 =?utf-8?B?M0ZsbFJjSVpIejliRFEwNjhvelJZN3VsV0oyV2REVUtzNjFxUTVkWll3aWZu?=
 =?utf-8?B?dEtGbHVCVmh2MXU4UjBLYjcvNlFJemowcVd0QzZETSs5RnI5Y1kvZFlod1BX?=
 =?utf-8?B?ZjRxRkRiV1NNRjREMUZ1S1lkYkx4NjNEYjRLQUh3aW1POTU3U24ya1diNkRP?=
 =?utf-8?B?Z0NxdktVd0hJTHRlQWJzWDNQK2tqSU5kcnRGTW1qeTNQSjlYN1EvcUo4TzZo?=
 =?utf-8?B?cy96VHFKb2ZLejRJN0p2TGhqbzFoU01tUTRaL0VXUlJ2SFZ2UmM1alE0b1Rn?=
 =?utf-8?B?bWJQUGJBNktPL3N2Z05hOUFqbVVmL3dCVVM3UTJLS01tcmZQVFRWU0JjWEZC?=
 =?utf-8?B?QStCNCtjVVBKZktoQjhJM2k4b29mVCtLSGlrM1R5bysybk91QTNLRFZjN0Zt?=
 =?utf-8?B?dzlSTzNqT1NlMFBOalNya3lLWHVWclRnbjhodjRkeGU0SDQvTHNOVjhhZExY?=
 =?utf-8?B?SFdPT0tTVFlOaXdyWmNrUE5RcE9sTjYwVXlsaU90MDJvb1BOTEgvZFZzejJk?=
 =?utf-8?B?a1VEZEg0Y3lNV0pKL3JFUHIrV3dMcmtJNGVvREhxTlM4SzNLcEhsMDVqZm13?=
 =?utf-8?B?S0FBcVhaU2x4NjdWNkxYd281b3dhMGxIZnp1dnRTV1VMUzhPZmpqWFEreEs3?=
 =?utf-8?B?bVpJOStqQkR5S2QrZ2ZvNWZrTldVdFo1SkFzVDlvaTVpeFpMUW5PTW5NdFRW?=
 =?utf-8?B?SVBKa3FKNGdsUDBRQXlKRVgwMUhMZEt5N3psV0Z0RVJURThVc3hXellTYUN3?=
 =?utf-8?B?QTRRTEJ5djl3SnUwQzFBTFNqU3ZXTlRVSzZPM3lTaThUVDhVcE95QzZxUmlq?=
 =?utf-8?B?MmNDZnZDcmRXYlJWWW1COGlKRTdKSDh4M2VUVXp2aWlSek5NdHdWRzFoZjdB?=
 =?utf-8?B?Y3ErQTlhZ3hEcStMMEUwSi8vVjk5aDBKNDd3QmorN2tLblhNaGRreUs4NE93?=
 =?utf-8?B?UG1hOUx4Z3lDWnV3cFRoSWQ5VytGVzBPZ1hUQVY1Snd4RUFyQkUrNkRUU3lJ?=
 =?utf-8?B?TmZHREtGTjR0V1FiOVdIN01sVGZvLzhsaTB2M0xJZ1Q0OHZoeW1sZnNQcDJG?=
 =?utf-8?B?czNwVUVlRjhhbHpWVm5wZU9ib2doM2xwYVNyOUxzemlDQTQ5RFdQWGdhSVha?=
 =?utf-8?B?ZVB4UDRFdlhsL2VSQWgycWpVelJTTFl4T1IwSG5rcDkrY1ozMVVBcUtwMHNx?=
 =?utf-8?B?MGQwbnp5SlkzSndmZ0hCM3RBY1RpdndYOUh0bjdjaHV4MTUzbEhkdWtxQ05U?=
 =?utf-8?B?cC9VQ0NYKzVlQ1NlbDVxK1hmTVFpZVNxaFlsWUkvVVlOZnowaW5tTmNrZmN1?=
 =?utf-8?Q?p8XILQcCVsDhQbhs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	KeoaHdW85e9tR6j67x7aG5aD6PGrq+Cui3RyNAc98HR042EV+/ueE67JL7uLsD5hoOsIa8ZNcpvM2qQpj/iNwNOcD0LjRfAzuLyg8dtwwS+z3NzGJ5gei3AiONiVr2CZw8NoJA79fdKgG3UXVcXfAI7m8lfUTrWc3E+5fN3yP4fHUWx7xErmyvq+CiAU2wSn0sjJW9YR4Tyc9UebihZ/AdIYZN68E3sydO96PDh9Vib9IcrIrw84lYsMnNdrPZU22JsTXHwzT2sd0CJBz8Y+/VbqkPwt6V2Mh0+m6pWZsNxYDoKq+eeFOAgFQV1vLYLBRkIkLJotP90Fr7wyoSmSjw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af53186-5ba5-4db0-72b9-08ded0f2b12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 06:43:10.5751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANs787x5i7Wyf4I46qpVEdWdr401o2TozE12lo4DcgpxJshxRhoAx7jA3xcsnzQC6NZZ6rTAQQPAZEylrh9tw4BNCsi5Lt7V+w70UCOqYt8tLR3DxJRVhclhQnJYpVap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12498
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 06:43:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23257

SGkgVWxpLA0KDQpUaGFua3MgZm9yIHlvdXIgdXBkYXRlLg0KSSByZXZpZXdlZCB0aGlzIHVwZGF0
ZSwgb3RoZXIgdGhhbiBpc3N1ZSBQYXZlbCBwb2ludGVkIG91dCwNCkV2ZXJ5dGhpbmcgc2VlbXMg
dG8gYmUgZmluZS4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmljaCBIZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBT
ZW50OiBGcmlkYXksIEp1bmUgMTksIDIwMjYgMTE6MjEgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnOyBwYXZlbEBuYWJsYWRldi5jb207IGl3YW1hdHN1IG5vYnVoaXJvKOWy
qeadviDkv6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8uaXdh
bWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gU3ViamVjdDogUmVxdWVzdCBmb3IgcmV2aWV3IGZv
ciA0LjE5LXN0MTgsIDQuMTktY2lwMTM0DQo+IA0KPiBIaSENCj4gDQo+IEhlcmUgYXJlIHRoZSBt
YW51YWwgYmFja3BvcnRzIGZvciB0aGUgdXBjb21pbmcgNC4xOSBrZXJuZWwgcmVsZWFzZS4gQXMg
YWx3YXlzIHRoZXkgY2FuIGJlIGZvdW5kIGluDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0L2xvZy8/aD1saW51eC00LjE5
Lnktc3QtcmMNCj4gDQo+IGFjNjY3OGNiMTI5MzIgYmF0bWFuLWFkdjogY2xlYXIgY3VycmVudCBn
YXRld2F5IGR1cmluZyB0ZWFyZG93bg0KPiA4YThmNzJlZDMyMTYyIG5ldGZpbHRlcjogaXBzZXQ6
IHN0b3AgaGFzaDoqIHJhbmdlIGl0ZXJhdGlvbiBhdCBlbmQNCj4gMjM5OTcyZjU4Mjg1OSBuZXQv
c2NoZWQ6IG5ldGVtOiBmaXggcXVldWUgbGltaXQgY2hlY2sgdG8gaW5jbHVkZSByZW9yZGVyZWQg
cGFja2V0cyAyOTBjYTNkNGNjMGZlIGNkcm9tLCBzY3NpOiBzcjoNCj4gcHJvcGFnYXRlIHJlYWQt
b25seSBzdGF0dXMgdG8gYmxvY2sgbGF5ZXIgdmlhIHNldF9kaXNrX3JvKCkNCj4gZDA5NDEwZjgz
NTA3MSBidHJmczogZml4IGRvdWJsZS1kZWNyZW1lbnQgb2YgYnl0ZXNfbWF5X3VzZSBpbiBzdWJt
aXRfb25lX2FzeW5jX2V4dGVudCgpDQo+IDgxMzRlYWY2YWRjNDIgdGlwYzogZml4IGRvdWJsZS1m
cmVlIGluIHRpcGNfYnVmX2FwcGVuZCgpDQo+IDAyZDJhYzdmODRkMDAgc2xpcDogcmVqZWN0IFZK
IHJlY2VpdmUgcGFja2V0cyBvbiBpbnN0YW5jZXMgd2l0aCBubyByc3RhdGUgYXJyYXkNCj4gNTBi
ZWI2NWU1OTIyMSBuZXRmaWx0ZXI6IG5mbmV0bGlua19vc2Y6IGZpeCBwb3RlbnRpYWwgTlVMTCBk
ZXJlZmVyZW5jZSBpbiB0dGwgY2hlY2sgNjAyYmM0N2M4NzQ5ZiBjcnlwdG86IGNjcCAtIGNvcHkg
SVYNCj4gdXNpbmcgc2tjaXBoZXIgaXZzaXplDQo+IGI5ZDhhMmQ1MzdjZTkgd2lmaTogYnJjbWZt
YWM6IEZpeCBlcnJvciBwb2ludGVyIGRlcmVmZXJlbmNlDQo+IDA0MTQ0MGMwOTAyZjcgYnBmOiBm
aXggZW5kLW9mLWxpc3QgZGV0ZWN0aW9uIGluIGNncm91cF9zdG9yYWdlX2dldF9uZXh0X2tleSgp
IGY0M2I1ZjU1ZjAxN2MgY3J5cHRvOiBhdXRoZW5jZXNuIC0gcmVqZWN0DQo+IHNob3J0IGFoYXNo
IGRpZ2VzdHMgZHVyaW5nIGluc3RhbmNlIGNyZWF0aW9uIGZhNDE0OTg4OGQ5MmYgbW1jOiBibG9j
azogdXNlIHNpbmdsZSBibG9jayB3cml0ZSBpbiByZXRyeQ0KPiAwZWNkY2QwN2E3NWQyIGNyeXB0
bzogY2NwOiBEb24ndCBhdHRlbXB0IHRvIGNvcHkgUERIIGNlcnQgdG8gdXNlcnNwYWNlIGlmIFBT
UCBjb21tYW5kIGZhaWxlZA0KPiBjMTRkOGRjNTg4YWQ1IGNyeXB0bzogY2NwOiBEb24ndCBhdHRl
bXB0IHRvIGNvcHkgQ1NSIHRvIHVzZXJzcGFjZSBpZiBQU1AgY29tbWFuZCBmYWlsZWQNCj4gM2Jm
ZmFmZTVlODk3NSB4ODYvdXByb2JlczogRml4IFhPTCBhbGxvY2F0aW9uIGZhaWx1cmUgZm9yIDMy
LWJpdCB0YXNrcw0KPiAyMDA4MzU4ZDk3ZjE3IGJsay1tcTogdXNlIHF1aWVzY2VkIGVsZXZhdG9y
IHN3aXRjaCB3aGVuIHJlaW5pdGlhbGl6aW5nIHF1ZXVlcyBlMzM2ZmIyM2M2ODJhIHNjc2k6IHVm
czogY29yZTogSW1wcm92ZQ0KPiBTQ1NJIGFib3J0IGhhbmRsaW5nDQo+IDZmN2U3ODc4ZTNjODkg
YmNhY2hlOiBmaXggY2FjaGVkX2Rldi5zYl9iaW8gdXNlLWFmdGVyLWZyZWUgYW5kIGNyYXNoDQo+
IGEzM2UyNzAxZTg1YzggcnhycGM6IHByb2M6IHNpemUgYWRkcmVzcyBidWZmZXJzIGZvciAlcElT
cGMgb3V0cHV0DQo+IDdhMmQ2ZTkxZjQzYTYgY2FuOiByYXc6IGZpeCByby0+dW5pcSB1c2UtYWZ0
ZXItZnJlZSBpbiByYXdfcmN2KCkgNTU1M2VkNDhjMzEwZSBiYXRtYW4tYWR2OiBob2xkIGNsYWlt
IGJhY2tib25lDQo+IGdhdGV3YXlzIGJ5IHJlZmVyZW5jZSA3ODFmZjM0MjhkMDlmIGwydHA6IERy
b3AgbGFyZ2UgcGFja2V0cyB3aXRoIFVEUCBlbmNhcA0KPiBiNzQxZTE0OTE1ZWUzIHhzazogdGln
aHRlbiBVTUVNIGhlYWRyb29tIHZhbGlkYXRpb24gdG8gYWNjb3VudCBmb3IgdGFpbHJvb20gYW5k
IG1pbiBmcmFtZQ0KPiA5ZWRkYjgyZGMyNmU0IHdpZmk6IGJyY21mbWFjOiB2YWxpZGF0ZSBic3Nj
ZmcgaW5kaWNlcyBpbiBJRiBldmVudHMgYjAzYmZjYzIyNDMzYyBjYW46IG1jcDI1MXg6IGFkZCBl
cnJvciBoYW5kbGluZyBmb3INCj4gcG93ZXIgZW5hYmxlIGluIG9wZW4gYW5kIHJlc3VtZQ0KPiAx
MzM5NTJiODRmZjQwIG5ldDogc2tidWZmOiBwcm9wYWdhdGUgc2hhcmVkLWZyYWcgbWFya2VyIHRo
cm91Z2ggZnJhZy10cmFuc2ZlciBoZWxwZXJzDQo+IA0KPiBUaGFuayB5b3UhDQo+IA0KPiBDVQ0K
PiBVbGkNCg==


