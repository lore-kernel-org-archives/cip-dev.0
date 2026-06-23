Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B8CDB479
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 13:02:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20536.1782219724458498241
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 06:02:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65ND21H84160731; Tue, 23 Jun 2026 22:02:02 +0900
X-Iguazu-Qid: 2yAc042kWO3b2HZFx3
X-Iguazu-QSIG: v=2; s=0; t=1782219721; q=2yAc042kWO3b2HZFx3; m=Hn9qhNgj8mXVYA5gsN2tp1H2TT0bSUkVY+vQjY8ltc4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gl4w93gR4z1xnZ; Tue, 23 Jun 2026 22:02:01 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxie3Tp6mG7hIISE/MsatKUQyQKE2mZk5v1IOAxm4F3NeNaefWhyHmWPuGNhG8heYF4vXTac8kbuDLZJ4KpC6vukh0/k+hsiccVmnfxp99ev3HY1kNW0HliF/vTCR9gOXAUKCGHcX20lXCjjTJ8przpyNaEutJn9A4/oVFZezJkE7sUvS2lOULCKoIxScqEzl5whpfhIwOvp2dAMTnUyskwX1A6twii3a6GGXt/c/Sc5UBM7zKuh12N3oL+FUwiO7Tbw8zGKsbltNy/YsIMj6XXXU7zadhASF6oan1mZsmI3WSl3IdswANWrxnI7A3C/WUh9KSY8s3PUQPbFKEO47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDMeW/C+rHuUhYCVlGEGrFqq3izJrIslQf+lopyvJC4=;
 b=xwWz00o4teTfdutCm4pQHWnzaH6zY1J8NesAMMmnmbrESw8USmxicwtRMzhDjJp3WQQ6MHY5q8hMXthlhU3ld/PLULQAttoz5RcSrYYjIxWm0H4oI5VpxsqDJMGoNFj3QVs6NjZnc3Fxd6LHTgOeQ72KTI8yQ0qdQZt6V9YhAftKwy247YTaBGUr+05plPJ8Y3reizeQ2360vheYvGym9z81Gs+1tb7y971ZpTyHRNLQKtGHo5W6L81qBqw5hLcIshJHQfeL1RLoOyxtgrgHKlx09h5an6Pc7SK7NmDD9N10yzKWtEmAS3HD0oozaZJqiHUePjL4xq0B9YBvPC/Yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH v4 0/3] Enable Debian Sid support
Thread-Topic: [isar-cip-core][PATCH v4 0/3] Enable Debian Sid support
Thread-Index: AQHdAwA8qMvU1l8IBUy43zfJEDocSLZMFT4AgAACsQA=
Date: Tue, 23 Jun 2026 13:01:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075746DDA24B486D0D524BBC7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <fd407f79-72ca-4da1-8937-9ab989c3a1cd@siemens.com>
In-Reply-To: <fd407f79-72ca-4da1-8937-9ab989c3a1cd@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OSZPR01MB8671:EE_
x-ms-office365-filtering-correlation-id: 81e16284-0587-4e81-f294-08ded1279981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 5HcVzihKDXwY0gREGnwakvczWAD3wPk7lePKR7cD0JS8+yNmW5uPzJiQdjTKpYYsLoH1kAvKzIzIf5ttEkFcyOGndmRyz0s4UaFx3JBV3v3IQMeRQMW6A7qgvawSEve1e0nLIwXWV3FYkxvJa2ETHX6NmtTf4aKBxm33BeRJpCr0A6Q2r5WE2Fe2+NmsBpAvBD5iHonjaVs6qlFOJqghefDU6wvv4yVfMKu9KAj/yQuGtKhC/3vQfxJL0ByRe8wIanjeRtyj9ub9km1J0ERQHoX5v47TLlAqy2YLTg71Rq2gjLOuqMZtTnC3EVDxeczf5B2BslM3tWkkq5giCmp0Td3+4C/cQtUGiV96ZUPT5BSuVF968nbYiBzp51XK6P/SkwvEtd7B1EEr2sLGJgh2I3nrx8c2hYUqtUffqRr0jJJ/ADIbPhDkaJF0JHWqZ1zq9bOfs/1aDZCSUctKaVdwDqMUat3OI3BL0vD5q8oqS6j8ym4Jjawsch+0y6SuoFkr6WRV/iykZABbWGDPcqf2Y0iLt8tOJ587BX5BIAbSxit2cmYPSNEXSwCGfSky6ZiHbfzVPqQtZFjBAQJC4CsolHfNQs2GmH6b9NLlNDMX+Ho0r5NbYfszOkMLweAyc8fMBEXpFsUz56bJ0QorwNtP/ivtkWRGAgho8splGzaZ+onleu6vCcuNU6G8TB6Gs47P2aI5IwNHKcZHprmh0KLbbsVUlyGng/CLqxIF67uf1p8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eEdnbXlkQ2ZIZDNnaVUwYmxDTWZNaFM3bURLRm1rUmptVnd1MVhxYm1wU2Rs?=
 =?utf-8?B?a1crd1JBbVFqVTl3cmpNOHlDcGdJWVQybFQ4cCtRd0VnVmJuUW1XMlYvRkY4?=
 =?utf-8?B?UlVPSWNoV0NyeXlZNTk5NFdoN3RBcmo2cytvUUtWWm5HajYwbGRwSEJkOFRi?=
 =?utf-8?B?NUc0M3VIcXlpeE0vSzh3TllSV2dGVytUNVJaY3pZL2lWeDBmcWFWaG9Pckx0?=
 =?utf-8?B?MHhFcTMrWW1kZEwvbmw3dmZsYXp0RDU3SENsK3JMcGhlS2J6OUhCNDVmY3pP?=
 =?utf-8?B?c2FTVFBHTmtPOGg5ZGlKckhaeEtHeHpXcGlyZ28vTXJ0d0VEN2JpQ1p1RXZ0?=
 =?utf-8?B?V1l1S1NXZGN3dWU0ZVVLY0xxek13MXdEV01OUVpFRHhhQlUxaHNJc0JqNSt3?=
 =?utf-8?B?d2owWUNNWVgydjlpSHUyWDVwdXp6WERlR2RFWnRSd1hJZE9sdDQwTTRCNUtv?=
 =?utf-8?B?L0VTRzR6d29VM0krdW9hd2hIM3NJYWZBL1NkUFJwNlQwTGZObTRYSnlpdzRP?=
 =?utf-8?B?dDNsR1A1czlZVzRpWmdIMEJ3cWh6Q3IvSWw4NWhtU2JlNUhvQk5XRG9CR0k1?=
 =?utf-8?B?TlQ4WDFYbjJOaUdZQmpUU29Ob0Q3MFFNSmYyS3oyQjd0NzRwMERKeEg4R0Rk?=
 =?utf-8?B?R25XVGlCd25aZFZyakM3WVRGRVB3UTFQcCtzZU1JZ2VPck5nNmw1WXRVNWhQ?=
 =?utf-8?B?NjhGVlZwM2FsTm1zTUZxR2k1QUFabjQ1UXdUMFpRVEhJOWdaMlhiNHk3dW5a?=
 =?utf-8?B?Q3VZTG5FRGdXYm9ub0V0Z2UwSHV4bThQdW9IVlJUd1RLM1hkczZlVFlLeDdM?=
 =?utf-8?B?cS9taTNaL29TcENURTFaRWdXdjEyMFJHWFZYYlVCdzNBYmZTS3Q2aXJjK29D?=
 =?utf-8?B?NEFJM0xnclZnWEFEUVIyQU5RR0xPNUkwRFFXbUx6dW5OVDg3Z2d5Q3FxZlZF?=
 =?utf-8?B?RVB4VmliejQ1ZDhtZXBvSDNrdDdVZ2h0VmZrRVBIeU5TY0svdUNmMm5GRUF0?=
 =?utf-8?B?SG1LNzBMY1ptd2FqRkZJV2dsdDdtZVIrem5hNW5rQ1M2YkYyUnJ2RW1OUkNB?=
 =?utf-8?B?QlZGaWtlWFZVRTZWZTRyaEhMbzM4LzN5OGcxa2k3RzVWQURHK2JWMGV2TFB6?=
 =?utf-8?B?VXZQbU9aVWRVRldGRENzenp4M3JoSmZvYjc3ajNoMHh3MmY2ekJpL3BNVzl2?=
 =?utf-8?B?dWJvVlNuZFA3d09Ka1V5dmRjREU5cmthZ25FU0dpWFNqQXlFcGhndVQ2VjFQ?=
 =?utf-8?B?bGMvVFl3WkJuQ3A5L2dsNENreTdvSU5rd3JicUdaU2hvcE4zMmJ5QnZtdVp1?=
 =?utf-8?B?YUVmS1NmazBxVUw3MlNYSytSQ3dJaDR1dVNPM2tVZ24wdDRhUFhZTHRVU1J6?=
 =?utf-8?B?aHQzc0NpUW1OZ0tlTXYwR1hkbC9GM21QNEY2MklkZzRXYWdqUDIyN25xUjR4?=
 =?utf-8?B?NFZ4NGdLZjBIbkRKbWw3bmZwdG5xL0JadysvWlNPV3hHRnhCK2R3ek9ha2Fz?=
 =?utf-8?B?Q0lYY0wrQzBJZEIvZzBPanBNbVVTRTBkcGVKLzUyQmV3clpWVFJUM3IwUEhj?=
 =?utf-8?B?SW9yRWhiTi8wUTFRMzFpRUxZSVZPZEtELy9yNTFORFZ5Y0VOQWNxcVZ6T2RP?=
 =?utf-8?B?ODlqZXd1YUVCdVViTTNrdFU3R1paU0o1Q2hLc05DNnk0WHhDb1JDNmdHODV6?=
 =?utf-8?B?dzJBTk03bnVZY2UrbkFDNlMzL21WTk0xMnl3K2hzVFljNnF4bHBKMnk3ZjFj?=
 =?utf-8?B?U3BGMzBCSEV4VERnTzQ2YlRNWHRmUEoxcEl0dzdqaXhZK3N1M04vSEI0TmZa?=
 =?utf-8?B?WllBQWNHWENyWUZDMS9YNlNXb05JS0lSWENUcHY3a0RXeDRFQi9CdHZtdlB0?=
 =?utf-8?B?NHJaS1ZmZ0taNHo2OEF0KzZYZ050dFNLUXV0TXY1M0wySkltMmRxZmY2eHBL?=
 =?utf-8?B?UUtIZDVVK2VSNzNJczlPMCtVR3ZJWkdiNW44cWpsRk5mNjdhU0pIdklYKzV4?=
 =?utf-8?B?QVZGQ3VuSG1qaTFOc1BnRlJHZng0aU4rNjROVVVIbGtwcXc4UDdlWDQ1M1Yx?=
 =?utf-8?B?ZG1SRWFrdWpQTFhBbytzQmNkV3c3YUVjMjN3cW1kRHJCY3lZSldUZlRmaWQw?=
 =?utf-8?B?SW04WEtyODZhLzFic2srSVpSSHpPS1ZOYUxwTThjUkRZNmE1YXEwbTdqZGI4?=
 =?utf-8?B?b0tVZkNOVkJTTjl0UzZsUlNhRXc2Y0NtdkxFQWxlU0ZpZ2VWbWEvdk1OTEJX?=
 =?utf-8?B?c1FtVXdZL2MrdFJYVVZ6V0VWbEVHam94ZjJRclRhdTh0bGkwT21EczBRQUJ5?=
 =?utf-8?B?ZWk2bFJkZ1poTmRzM2hUb2gwT05TNElub3QwSEZLS29yNXBnSVZmblUyTyt2?=
 =?utf-8?Q?AH+LPYjM9CoNAZH3yJAiHKhgqbiSBmeTYcQVM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	W87iWF/u4Q/TkmbPQ9se45QRj5K1Tk2wVi8frVwvFZx0BbBK8YBkX1ACGf2B/pxRzq2AUOPGLDYwxyDiAOVoPViEtTVwJYHWJ1SO1VsQn65DnJEW9uUhXdmifEUui4a/v4Jp1CrISXO2ZyIvPUiwpGsvlizc5YcZDk89v/ie4vOyr8jVStsym/GHK0G7la7DtX/DYPKX6YzrBKIDcDW2iZrrwvNQdnYOada7rSK+NEv2HZ+CZu5xMnj3m+0AHQR3byBQ4KdGr2donBImgUTIdZwElUynFHHCMfcacDRR5txWi11SxVuBpRaKzsExa6pRyEoDLFUiqVEvULKVVLYfvg==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e16284-0587-4e81-f294-08ded1279981
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 13:01:54.2067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AMBRcBHfKm/WGNzhrdktdgG8puwiXjD6TWcf5Qe6ufHHc/FCE00PbnfWQLXUNHQT0KV2quNe6hVHrJsu6TTWavUPegIO3R2UwBbEWKpjqOXZc54YCaV8pqPLxVJtQe/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 13:02:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23273

SGkgSmFuLCANCg0KVGhhbmsgeW91IGZvciB0aGUgbWlub3IgY2hhbmdlcy4gDQoNCkkgaGF2ZSBv
bmUgcmVxdWVzdCwgdGhlIHNjaGVkdWxlZCBwaXBlbGluZSAiV2Vla2x5IERlYmlhbiBTaWQgYnVp
bGQgJiB0ZXN0cyIgaGVyZSBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUv
aXNhci1jaXAtY29yZS8tL3BpcGVsaW5lX3NjaGVkdWxlcyB3YXMgdXNlZCBmb3IgdGVzdGluZywg
YnV0IEknbSB1bmFibGUgdG8gY2hhbmdlIHRoZSBicmFuY2ggdG8gIm5leHQiIGR1ZSB0byB0aGUg
YmVsb3cgZXJyb3IuIA0KDQoiVGhlIGN1cnJlbnQgdXNlciBpcyBub3QgYXV0aG9yaXplZCB0byB1
cGRhdGUgdGhlIHBpcGVsaW5lIHNjaGVkdWxlIiANCg0KQ291bGQgeW91IHBsZWFzZSBjcmVhdGUg
bmV3IHNjaGVkdWxlZCBwaXBlbGluZSB1c2luZyAibmV4dCIgYnJhbmNoIHdpdGggc2FtZSBvcHRp
b25zIChpZiBpbnRlcnZhbCAmIHRpbWUgem9uZSBhcmUgZmluZSk/IA0KTWFrZSBzdXJlIHRvIGRl
ZmluZSBDSSB2YXJpYWJsZSAiQ0lfUlVOX1VOU1RBQkxFX1NJRCIgaW4gdGhpcyBwaXBlbGluZS4g
DQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6
IDIzIEp1bmUgMjAyNiAxODoxMg0KVG86IGt1bmlqYWRhciBzaGl2YW5hbmQo77y077yz77yp77yw
IERJVENfRElULU9TVCkgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT47IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogYmFsYWt1bWFyIGFkaXRoeWEo77y077yz
77yp77ywIO+8pO+8qe+8tO+8o++8v++8pO+8qe+8tC3vvK/vvLPvvLQpIDxBZGl0aHlhLkJhbGFr
dW1hckB0b3NoaWJhLXRzaXAuY29tPjsgZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBESVRDX0RJ
VC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o
5p6XIOWSjOWujyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpIDxrYXp1aGlyby5oYXlhc2hp
LmY3NEBtYWlsLnRvc2hpYmE+DQpTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVdW1BBVENIIHY0
IDAvM10gRW5hYmxlIERlYmlhbiBTaWQgc3VwcG9ydA0KDQpPbiAyMy4wNi4yNiAxMjo1MiwgU2hp
dmFuYW5kIEt1bmlqYWRhciB3cm90ZToNCj4gVGhpcyBlbmFibGVzIHRoZSBzdXBwb3J0IHRvIGJ1
aWxkIERlYmlhbiBzaWQgYmFzZWQgaW1hZ2VzIGluIHRoZSANCj4gcmVwb3NpdG9yeSBpbmNsdWRp
bmcgQ0kgKHNjaGVkdWxlZCBqb2JzKSB3aGljaCBoZWxwcyB0byBkZXRlY3QgdGhlIGlzc3VlcyBp
biBhZHZhbmNlLg0KPiANCj4gSSd2ZSBjb25maXJtZWQgdGhlIFNpZCBpbWFnZSBib290IHdvcmtz
IGZvciBTV1VwZGF0ZSAmIERhdGEgZW5jcnlwdGlvbiBlbmFibGVkIGltYWdlcy4NCj4gDQo+IFRo
ZSBzY2hlZHVsZWQgam9iIGlzIGNyZWF0ZWQgaGVyZSANCj4gaHR0cHM6Ly9naXRsYWIuY29tL2Np
cC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9waXBlbGluZV9zY2hlZA0KPiB1bGVz
IGFuZCBjb25maXJtZWQgdGhlIGpvYnMgYXJlIGdldHRpbmcgdHJpZ2dlcmVkIGZvciAiV2Vla2x5
IERlYmlhbiANCj4gU2lkIGJ1aWxkICYgdGVzdHMiLiBPbmNlIHRoaXMgc2VyaWVzIGlzIG1lcmdl
ZCB3ZSBjYW4gY2hhbmdlIGJyYW5jaCB0byANCj4gIm5leHQiIGFuZCB1cGRhdGUgdGhlIGludGVy
dmFsIGlmIHJlcXVpcmVkLiBwbGVhc2Ugbm90ZSB0aGF0IGEgbmV3IENJIA0KPiB2YXJpYWJsZSBp
cyBpbnRyb2R1Y2VkIGZvciB0aGVzZSBidWlsZHMgKGkuZSBDSV9SVU5fVU5TVEFCTEVfU0lEKSBh
bmQgDQo+IHRoZSBzYW1lIGlzIGJlaW5nIHVzZWQgaW4gdGhlIENJIGpvYnMuDQo+IA0KPiBGb3Ig
dGhlIHNpZCwgSSBzZWxlY3RlZCBJRUMgc2VjdXJpdHkgaW1hZ2UgYXMgYnVpbGQgYW5kIHRlc3Qg
dGFyZ2V0cyANCj4gYXMgaXQgaW5jbHVkZXMgYWxsIHRoZSBmZWF0dXJlcyAoc3d1cGRhdGUsIHNl
Y3VyZSBib290LCBkYXRhIGVuY3J5cHRpb24sIGZhY3RvcnkgcmVzZXQpLg0KPiBUaGUgaWRlYSBp
cyB0byBoYXZlIG1pbmltYWwgam9icyB0byB0ZXN0IG1vcmUgZmVhdHVyZS4gSSB1bmRlcnN0YW5k
IA0KPiB0aGF0IGluIHRoZSBJRUMgam9icyB3ZSB3aWxsIG5vdCB0ZXN0IHN3dXBkYXRlLCBmYWN0
b3J5IHJlc2V0IGV4cGxpY2l0bHkuDQo+IGlmIHJlcXVpcmVkIHdlIGNhbiBhbHNvIGFkZCBzd3Vw
ZGF0ZSwgc2VjdXJlIGJvb3Qgam9iIHRhcmdldHMgZm9yIHNpZCANCj4gYXMgd2VsbCwgcGxlYXNl
IGxldCBtZSBrbm93IHlvdXIgb3Bpbmlvbi4NCj4gDQo+IEF0IHRoZSBtb21lbnQsIHRoZSBzZWN1
cml0eSBpbWFnZSBidWlsZCBqb2JzIGFyZSBwYXNzaW5nIGZvciBhbWQ2NCwgYXJtNjQgJiBhcm1o
ZiBhcmNocy4NCj4gVGhlIHRlc3Qgam9icyBhcmUgZmFpbGVkIGFzIGl0IG5lZWRzIHNvbWUgYWRq
dXN0bWVudHMgaW4gdGhlIA0KPiBgc3VibWl0LWxhdmEuc2hgIHNjcmlwdCBzbyBJIHBsYW4gdG8g
aGFuZGxlIGl0IGluIGEgc2VwYXJhdGUgcGF0Y2guIEkgaG9wZSB0aGlzIGlzIGZpbmUgYXQgdGhl
IG1vbWVudC4NCj4gcGxlYXNlIGxldCB1cyBrbm93IGlmIHlvdSBoYXZlIGFueSBkaWZmZXJlbnQg
b3Bpbmlvbi4NCj4gDQo+IFNoaXZhbmFuZCBLdW5pamFkYXIgKDMpOg0KPiAgIEFkZCB0aGUgZGVm
YXVsdCBrZXJuZWwgdmVyaW9ucyBpbiBjaXAtY29yZS1jb21tb24uaW5jIHdpdGggZXh0cmEgd2Vh
aw0KPiAgIEVuYWJsZSBEZWJpYW4gU2lkIHN1cHBvcnQNCj4gICBFbmFibGUgQ0kgaW1hZ2UgYnVp
bGQgYW5kIHRlc3Qgc3VwcG9ydCBmb3IgU2lkDQo+IA0KPiAgLmdpdGxhYi1jaS55bWwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgOTAgKysrKysrKysrKysrKysrKysrKw0KPiAgS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKw0KPiAgY29u
Zi9kaXN0cm8vY2lwLWNvcmUtY29tbW9uLmluYyAgICAgICAgICAgICAgIHwgIDMgKw0KPiAgY29u
Zi9kaXN0cm8vY2lwLWNvcmUtc2lkLmNvbmYgICAgICAgICAgICAgICAgIHwgMTMgKysrDQo+ICBj
b25mL2Rpc3Ryby9jaXAtY29yZS10cml4aWUuY29uZiAgICAgICAgICAgICAgfCAgMyAtDQo+ICBr
YXMvb3B0L3NpZC55bWwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNSArKysrDQo+
ICAuLi4vaW5pdHJhbWZzLWNyeXB0LWhvb2tfMC4xMS5iYiAgICAgICAgICAgICAgfCAgMiArDQo+
ICBzdGFydC1xZW11LnNoICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArDQo+
ICA4IGZpbGVzIGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKSAgY3Jl
YXRlIG1vZGUgDQo+IDEwMDY0NCBjb25mL2Rpc3Ryby9jaXAtY29yZS1zaWQuY29uZiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IA0KPiBrYXMvb3B0L3NpZC55bWwNCj4gDQoNClRoYW5rcywgYXBwbGllZCB3
aXRoIHRoYXQgdHdlYWtzIG9uIHBhdGNoIDIuDQoNCkphbg0KDQotLQ0KU2llbWVucyBBRywgRm91
bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhwZXJ0IENlbnRlcg0K


