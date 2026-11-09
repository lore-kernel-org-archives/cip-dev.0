Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9381.1794190960824980989
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 18:22:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=U2ivRLyu;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794190947;x=1795400547;bh=Iq4TBKekEPIshO7EfzMVRVL4c9rmW8H44GyV5
	jDy4SQ=;b=U2ivRLyu0lGzzIp9FEU7Ouq4iwUOfOlZz3e3brjQb46LwmIcZxTREsjFRxwmuN633iA
	LjwROfovTinRuvOvqhqj3pESAweZNO92lIx3LY7GufAc+ZkiLWYosOi6TL2bK4oWxfz0h2VWBmEU+
	83XkU8AWx1XSeZ4D+zxdA2HuMRuOT5e4qdorLaEP1+nbsH/7hO3YQpdy9KGGYdeNlBHAkvSF04bFi
	tFNJTBjRun3NfF618ZRrcUaQmFuLGxwxShUUv0cQ6MCkpWsOtGsamZQG14UcmyjR6zgf49sv3awKJ
	/RywE3waD/5SDeOUfzK9IpFbaGCP9Ag/VQzX1/vbxhoQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6A92MQIp2708131; Mon, 9 Nov 2026 11:22:27 +0900
X-Iguazu-Qid: 2rWgYSPepm4R12d1AH
X-Iguazu-QSIG: v=2; s=1; t=1794190946; q=2rWgYSPepm4R12d1AH; m=hVWb8No5bm6fUwYTVT9VtshwcxQNU0k49ZZlvVRmtx0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jND813359z1xng; Mon,  9 Nov 2026 11:22:25 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhOKwJ7zmd/bdD5R135ADt9mq/Xd1jTxVVljRfDcUw7dC9eN0OZzQWDu+fDLby87nZtQ3a22scy+KHevbILWf0IN3X/f5ED9uIy3DBhpc0HB8QyrQjd9NU5kScIXEiu088eTDHZrtkJALluD6z3CxhfJYCmkzBpvfiPskowoE1PjZS949Yg5zVcNdA/8hgvDooPMNKyhOvvvXutTaWe4bbepYzTJoMFWgpRB7ZPduXvhsYlFSmoU5CUeqovCtd/4TAc03B2gWtKf4qMgLBQUSyJJyz8LSy2jjTfrfyO923hsG6B/IiA0Be3lp8p4ZqdLmto/PO5t668mJmtaei/vSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq4TBKekEPIshO7EfzMVRVL4c9rmW8H44GyV5jDy4SQ=;
 b=tLGDlzycwWOydRgdvfp0NX6Hb8Z5hgd0iGiyrXXlQSsB+Bzbm95B6RrKNZHYvu0DtU3nZXxtfEfHRiRGV0H5LX2JQnP8ajl85cCl8Xek4ExvThNv6Mrdx1VAOkR7I5qAlc4YDOTXVwlaT2TOvIg7k/nt+M5e2lsbA2jAoH/7ArUVeyZH7R5UXLuMKEbok975AzDLFwpEMoczG1Er5N4c8lhZRd4ZsGepTx7KHy0n2nSoD29OCOZOthczyYeSWjfqTjz1nxiCDtbkFim3804dVGPu4ZSFO4GkH2ET2UupEJllXDApXHfmV6U8O5H5SvlnDdQ9OuPuTamkXkR3MuQo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>, <uli@fpond.eu>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 4.19.y-cip] mmc: renesas_sdhi: abort tuning when timeout
 detected
Thread-Topic: [PATCH 4.19.y-cip] mmc: renesas_sdhi: abort tuning when timeout
 detected
Thread-Index: AQHdZ58XTA2o5ztGr0SmXjiq4JZpIbclEk5g
Date: Mon, 9 Nov 2026 02:22:21 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148182531E8307BD3B1211C01CD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261029121432.4909-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261029121432.4909-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB8215:EE_
x-ms-office365-filtering-correlation-id: 39c43d6b-fc1b-4670-9bcd-08df3e08494e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9/Whwcn7ZURuF9Dz0rJu1zT5wIG8zxIuzH7LWx6tgsKj3O5Mnn0Kn2Nuo0kd2scMQ1HWoPLYGUCHIF0G1yaDsisgyNwMLT1LUTP1jMzjF81oQiVk1H6FtfLGa4gQuRDxGu2+QTo9ljRmCTE9/WoySG6FqDZS8eNTcDijtSHa8FA5wPX+X1+0+illWVDH+TjwCqgyBw0U/UUClwgIbjazOTlM3SUxkKWReGwEdHAUn8cA2ylpaU0uRq98teuC1+Jt6MeQWECB4vA0eUerzGdcVwbPmLz6qi12Cy4J+xDcBlJmqRPynSXei3LeKwsySWmrggsH1vc9RPNQqrwQegI3k1zANta3uM7YddbszicpSQzP1m5PUWdDGyWVmyRTqrU3YZ+n5fjnl7u67XDs9dYHxHNT0jm89w5sH1b9pTfmJCOXRiuH0jV4dlRfFE1peGZ5gNrKGbVxklaLsCGd6/5cCFZejOn4Y0b72MLMWsmyF25N4eabW86S/fbsLbGJ7MQ8S1IYLRmQTEak7ekHyZ85c2dgRmdEdCXlYgp9Ex9c6axvvOVyNEhkdlTJJWQpNsIZC8vQ4L65X0dqrcJcYrB+KkUekYGntAIYEBJb0R0bU351mBCUerWdEC7gSxFxdzVO6oVH8Uxwb/nchnj/tpvOgrm5menEgNDIm+0Ufj6AUHc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3VTOVdEUXNscnhISldrS3dweG9hdDFtTmFVSytGNm0zNDlmaDhaRkEzNTJM?=
 =?utf-8?B?UHhhMEpXTngvOW84SGY5V1Y0TXBUYTlJWUF3NklkdHFhZzNxdjdkZERZUnNI?=
 =?utf-8?B?VXNUQkMxNTA5aGpldmZlRk4vUzRybHU4YXlKV0tabnNhcmZaNnl6ZTR0NmpJ?=
 =?utf-8?B?c1U5ZUFuK1JoV014RVA1a01vNWU0REdnbEFLQzRXbWdnQ0NMcHh0cDRVaTds?=
 =?utf-8?B?T2xWZlQ3YTJReGxkRXJ1aHBFdjRjY25IY0NrT2dkU05GSmhqTElXR0I1Y0xn?=
 =?utf-8?B?V1JpZDlaeEFoZG1nS1d3eTVHV3hQOERxVklBekJmSXV5KytBZFN4SVUzNlZP?=
 =?utf-8?B?UVRwWGZiWTNFeVpnR1JSNUoyeXRwVmw5STh1Q0k2M2ZIQjRpVmM5bDdBUysy?=
 =?utf-8?B?dytxUW5uOU5xNTYzNXZkNFRpU0RGV0NxL1RabkIxOGNiZTBDTHNRU0htU1BP?=
 =?utf-8?B?cTdlQjBPa09mVldkbHlRZ3JXeTZnZEZVUGhNUmhubjFRZnJPckVqSFY4RW9Q?=
 =?utf-8?B?WVo2VXFaTEN4ZUxwbEZmQkhnZU1Fd2pvV053czd6eVFwRGlBQjY0c0dtWjRF?=
 =?utf-8?B?MzE0bGVIZjE5SEFrRGZXb2piZ2NxMlROa0F4cDR6eXFpaEZldndnK0R2Wmlz?=
 =?utf-8?B?RFphNUV4RmFCbnBUQkRDZUNyUFdodjZjcDVhbzdkaC84anlQclM4Qk0yZFY4?=
 =?utf-8?B?ZkZlZVpjRW9MZXhWOXRRc2hPOWhKeTRNNWgzc1Rpais5a0JnQjArYUx2K0VY?=
 =?utf-8?B?RGZ0aDdxME9IempCUGhWTHNZelFDTERJTC9xREtsNG04bm9scFI0OWJpWUl6?=
 =?utf-8?B?UmhTUDVmVEw5RG5mLytMRUpISzd0a25TRDdmNElha2sramxsaTY4T09kdWFL?=
 =?utf-8?B?alRvZDBHTFVkS3V4cWpzMUY4dElIMFNHU1RSTWd2Mll3MXNMa0NCR2dlWmx0?=
 =?utf-8?B?enZWdm1qejdtd0pzVjAweDYvTkJxb2w1TjZSaFZ0Tnhtd21yRkRqTlNtUzhq?=
 =?utf-8?B?RmlyWHo4VGlHYVdXT01CdmdpUkd1NmdIZkl4am9FNXpKV3ArcXdSYmF2OHZj?=
 =?utf-8?B?aGdITThtTEV6Uzc0L0ljUER2c1VqN2doQnNkOG00WW5SZkFldkt2dWR2ZjJP?=
 =?utf-8?B?QVlUV2doMW9BRnNWaFRGYVAwRnc0YkZ2MmVXSHRkLy8zNm5NTldrK2dmNGVR?=
 =?utf-8?B?ZDVYZ0d5Tk1vMWNPWDlZMWFnZHR5ektub0tJR1R4cjlYcGtoYmIrVERxMlR5?=
 =?utf-8?B?dVFJRGJlZFFKS01pbzBNb2NQcXo4d202eTNMaWo0cXY1V0thbysyc3lsdWVI?=
 =?utf-8?B?S212MzgveEJrWDVBOHJObjdkbTg5MmdMTDFuRHJvdVRZS3pYY1MvNE1BUEVs?=
 =?utf-8?B?eUdHMVNlaFppeXUxVWRkekFKNFBnbjkzVDhXb1lVYUlFMHRKL3ptaVo1NUdj?=
 =?utf-8?B?b1RVbThQNGNPdW5LYldlTEFXR0lRcjRxQW1VNG9yTmFFWXVuUXJKcWRQdHRM?=
 =?utf-8?B?V3paWjdyMjVrVzJQZmxwUTQ4VGZzVEl4bEdSLzFnMUwrNHQrMzVqMkg3dmJy?=
 =?utf-8?B?SnFqVjVOd2hTUFY3b2dqMTQxZEpzYzRFODFHWFNkWlNaeVd3ZXRmMFBBdkg2?=
 =?utf-8?B?M0lwNGlJSjFMMUc1VzF6VGVCaHBwVWk1TTNpREpaZ0RSWEVweVM3aGR0MEli?=
 =?utf-8?B?a2pFM1puV3I2MU9ZbFZDaDN4Z0hrQVY5c0NPM0tPeU1Sbmp2cXBERmhxcHdm?=
 =?utf-8?B?VURZK0dQb2l1d0dmcGhmMnNaVU16ZWRsVE1EaGl5T2FiaGVpb2V3TE1Nallm?=
 =?utf-8?B?ZmFYSDRUMzY4MFI0UlUvY2t1bC9BRHpuQkdjc2NsSWRuN3BFTWhwZStYOEg3?=
 =?utf-8?B?Y2pvNFRnU1l1ZGNtc2ZOckIrb2R2R1NqdGMyZkJIOERSZjBER0VUVkxGOGRa?=
 =?utf-8?B?aHVPVHVpQWM4djJON2VuVlNyNGUyYlhDOVl1bzhUNExjY3d3dUZXbis4dmUr?=
 =?utf-8?B?eVdwYTZORDV5M05WK0I3dHlwdmxUc29qQkFiUzhmbzdBajhQU0hIWkdhN2Nn?=
 =?utf-8?B?RDBXS2x1dDE0N3VGenNvTW4vN3NQekJKc1dWK2VYK09PazlURWpBeWs0OXYv?=
 =?utf-8?B?RnJXdUw3a1RncWc5R1VaQi9wNFRrOVA3YkU5eGcrQVdIZkZlZ1Q1MlV4ZUhH?=
 =?utf-8?B?VGxqNjlpWnE2Y2hyNnVWWHAvU3h6b25DMWUvZzcvNGs3cDVhZG9ha09IelpZ?=
 =?utf-8?B?UStpWUI4ZTgvenhPUGtWbk9iVHkzWmxIYlE0aE5MelluT1NCZ0JBRGVEMTVV?=
 =?utf-8?B?Q2tsajgydWIwY21zSTNjSldLUVByK013S2NJc3FLY1hraGc4TDM3TEs2dm1M?=
 =?utf-8?Q?M6hQnsNIbIn1NcBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TiU4WsTf3SHU0Mb0jgJQOqneb3DFOCOBIEEA+a6VnfZkFJf//GfDPbpnlOPDe8v+CkNhO33nDYwMzS29TZ9NFBMtE9LC1wDZWFEt4S9jbjdnVJwzIr7sBQ+yNT3fzM4ZSv3Pj9+PsWds6HCeG5FiPKECCnZWMOqwvT3x14RAKTTtLki03VI/kNbArSlDM7vU/TWuIAh4Cu7ocY88VVNMN7x3fw7FH8/rcGhxwnwNPROEDD2iqu+wGf6np1TGtt0zftCEh81FD5ChTqJ67EmN9ZuajI5rE/csLI144j8H676QOb1y/6dKB1chTTQOZkYiGa0hHKVhE0EK2ShVSxBlUQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c43d6b-fc1b-4670-9bcd-08df3e08494e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 02:22:22.0180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+RFQ996byiA+nf3W+n+co4VGztB9TRfPuRRLoygekh5wQR875aQUQ572z7RTxoO9CXUHJ+T96OWJ3pWgz6Vey+a6BHo4WvOyYAgrE/BAj+JsggAH+du2/SPi6ev9qN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8215
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 02:22:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24667

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhZCBQcmFi
aGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIE9jdG9iZXIgMjksIDIwMjYgOToxNSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp
77y077yj4peLDQo+IO+8o++8sO+8tCkgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hp
YmE+OyBQYXZlbCBNYWNoZWsNCj4gPHBhdmVsQG5hYmxhZGV2LmNvbT4NCj4gQ2M6IEJpanUgRGFz
IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDQuMTkueS1j
aXBdIG1tYzogcmVuZXNhc19zZGhpOiBhYm9ydCB0dW5pbmcgd2hlbiB0aW1lb3V0DQo+IGRldGVj
dGVkDQo+IA0KPiBGcm9tOiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJp
bmcuY29tPg0KPiANCj4gY29tbWl0IDJjOTAxN2QwYjVkM2ZiZjE3ZTY5NTc3YTQyZDllNjEwY2Ex
MjI4MTAgdXBzdHJlYW0uDQo+IA0KPiBXZSBoYXZlIHRvIGJyaW5nIHRoZSBlTU1DIGZyb20gc2Vu
ZGluZy1kYXRhIHN0YXRlIGJhY2sgdG8gdHJhbnNmZXIgc3RhdGUgb25jZQ0KPiB3ZSBkZXRlY3Rl
ZCBhIENSQyBlcnJvciAodGltZW91dCkgZHVyaW5nIHR1bmluZy4gU28sIHNlbmQgYSBzdG9wIGNv
bW1hbmQgdmlhDQo+IG1tY19hYm9ydF90dW5pbmcoKS4NCj4gDQo+IEZpeGVzOiA0ZjExOTk3Nzcz
YjYgKCJtbWM6IHRtaW86IEFkZCB0dW5pbmcgc3VwcG9ydCIpIFJlcG9ydGVkLWJ5IFlvc2hpaGly
bw0KPiBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IE5pa2xhcyBTw7ZkZXJsdW5kIDxuaWtsYXMuc29kZXJsdW5kK3JlbmVz
YXNAcmFnbmF0ZWNoLnNlPg0KPiBSZXZpZXdlZC1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hp
aGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiBUZXN0ZWQtYnk6IFlvc2hpaGlybyBTaGlt
b2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gTGluazoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMDYwMjA3MzQzNS41OTU1LTEtd3NhK3JlbmVzYXNAc2Fu
Zy1lbmdpbmUNCj4gZXJpbmcuY29tDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNp
Z25lZC1vZmYtYnk6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBbUEw6
IG1hbnVhbGx5IGFwcGxpZWQgdGhlIGNoYW5nZXNdDQo+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFi
aGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL21tYy9ob3N0L3RtaW9fbW1jX2NvcmUuYyB8IDcgKysrKysrLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpJIHJldmlld2VkIHRo
aXMgc2VyaWVzLCBsb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdh
bWF0c3UgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQoNCkJlc3QgcmVnYXJk
cywNCiAgTm9idWhpcm8NCg==

