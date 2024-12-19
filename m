Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B9E77188
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 01:00:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.120376.1734570012160456865
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 17:00:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=bKnuIoR1;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1734569999;x=1735779599;bh=jqzWwTgxxq1mqe/LOzwjuwAJmCQu0pz0RRXwOuh
	xLco=;b=bKnuIoR1q1YjA1a2mhwfbMAYF+lvNf3nLRw6ByhDgLiX+sxC9tFfCcTxsczNIUwgQwaIz
	/zJDoLLkuf1nQvE0HTTemPlSMQSMFToEFwfHVThjhKkHIPFx/gzYCb2+E5Liuxy3SdYwgRtGuR4FB
	Xpq1eAyj5MgphPK0ZnDHt0IIHs8hycvfqrD2bOcIbeW+OAjRUknSTqqaAYYCeJHt9+qmuJxGNWTNm
	pkKpYLMlS47TUQFXnQJqP7BppaYoSEOLSRZOrWx43u98StC16xVOqWfn2M5uFwzhML6u2F0WcMLKO
	rhWUpzPskJU+3Hp0x1ND7UlPNHKswsk0gSlrT103Sg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4BJ0xxgg130219; Thu, 19 Dec 2024 09:59:59 +0900
X-Iguazu-Qid: 2yAbAvUQJtj7GgI7q2
X-Iguazu-QSIG: v=2; s=0; t=1734569998; q=2yAbAvUQJtj7GgI7q2; m=+nycth8Hvbgbp1jJOjh/xqxdLEPh51ts8ehy4bVm/OQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4BJ0xv9q2033980
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 09:59:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP2vdWj2Au5RJf11DAXvZAi0TFFUYCVB4TtkTSDxMuuWNESN2yOnKKAWJYDL1Gy9kEIhdMNBzyRKIvwBj6FolIzZFQvjjxw3uyFjZs15GY+xLdUt9hnZRitD4efjO3zMKbDtL46sQvlpJm+1BXBjOatxOSKVnJT5Joxzda6qYPLxoBwGB6F+kBU4DvWbidP0ponwg9Q/DTDfd+RCJE3oFKWVis3p0tnQF1BG9hiAmUBRpAnOqgcatlEVdBa985c4haUkZlaezWRGgOPnl9aguq+Bkm/nTfQrcHp/03GL93Cywib5hHZH2lOReoR6Hb9yx4N+XfGvjMHQhGnRrpV//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c45UlcO8Ivo74njhUQwhkNGpLOCYORI7hf/uzW9fh4w=;
 b=txgxIEXsZ6GPmb7GWM0fwvQEV58lXHXzGH0sRvKG0lw8XRQdff+R0pfQdFFdc6RjCUk2JQjZp2w1K/+nLoYs11qp3tkgtGTt8V11r3BMPzO0Kh9ZtxikbvDjkkFXtI+ufQ3FjOaixyz2inTd8BzB0SaxGGN/5P3FI9mg0weI+AMh+vP3M7JbUcqIUVDxo3uImC7do6VLCliuvLwgJgogI/+9bcl2SKJ3uqPZrHy6Y4Y2AOLm6in2hyKPLJr5Oscpq47ePY105ZU7FET4eLWBKf1NN6mLF0WIBSKflBKikbYr7OfTSyEMtBLeNux684zJvUHCOxhD9fuXmY2RAyyMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip dev][PATCH 5.10.y-cip 00/10] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Thread-Topic: [cip dev][PATCH 5.10.y-cip 00/10] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Thread-Index: AQHbUUelR/hD46BfO0iBtYvWJdhel7Lsv1sw
Date: Thu, 19 Dec 2024 00:59:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63881DBC3B5EC1E36196027292062@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSCPR01MB14836:EE_
x-ms-office365-filtering-correlation-id: 98527826-78a9-4279-971c-08dd1fc873dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YWdIcDM1d0pZaUUrS2hEYVNhTVFLajBMS0c1cXVHcnpUUGNyWWNPS2V1?=
 =?iso-2022-jp?B?L29GSHd5ZjRubEVBZy8vQ2Rib3FUWnhJWC9pV2h2RU5mclVTREx1THpZ?=
 =?iso-2022-jp?B?THF4TEh6ZTBBUmErREppS3ArY3FvNlFWT1QyVW05Z1RLbkU0SUtBUUxn?=
 =?iso-2022-jp?B?NXhLdUd1Z1pscHcrM05sUFI2RDlySDdaRmp2ZEpRaDhGSlI2Wk4yK2th?=
 =?iso-2022-jp?B?WFdPZWZtWGttNXdJd3V5dnJLZjVlZkJiZkx4aUhHbEUwQlp4Q0VCakI4?=
 =?iso-2022-jp?B?d2pDVm56UERVdzBsaUpNNHJUY29YMTZId0dUYWdQZUoxNkRsV0ZzVEU2?=
 =?iso-2022-jp?B?Tzk3K2lWaUlxZ0JENGV0Mjlya3UzTWRSUWx0a3I5dFRFcU50TmlnQ1l1?=
 =?iso-2022-jp?B?V2lhdnBIMDgwY0NZOG9uLzZmeG9zRlU5cmZjM2cyR0w5TkZBbjIwUHVs?=
 =?iso-2022-jp?B?Vng4ZWJzVy9zMFJ6bTB6cGJGSTIzRm8ycWwwMFV5dWN2OVRvanNTK0lX?=
 =?iso-2022-jp?B?YmZ2VFVRdThId0RZejNadGdRSWpybkZ6L3U0Rkt0L1BXT2FuanVVS0c5?=
 =?iso-2022-jp?B?WDNKb3N3U3psRkpxcGNtd1IzTnpJRjFHamFKRmNranB5NXdsYkpZZ09q?=
 =?iso-2022-jp?B?eUFUUiszREduQ2JmRUpWNnJTWTBWaHVyNGN4QjA4TGN6RVZuSXRCMkN3?=
 =?iso-2022-jp?B?ckxFSGpoL0tkd1grS3ZMM3BrM09yclNhaVhDY0xXMHB5T0NGbGI2ZS9M?=
 =?iso-2022-jp?B?UC9WYk0zVVhhUEY2SnN3dTIra2dReHdOTjIrKy9HTHFNaTFWdGY1SzRF?=
 =?iso-2022-jp?B?WFBlMThmenhXUDVLTEdFZjRIckxxT01LbGZSU3haSnF3S1NFeDJJdTRn?=
 =?iso-2022-jp?B?bGxPS3IreDlpcUFIb3hPU0NlQUNYMVp0bjROblY5Sk5wT0lieDd4d2t4?=
 =?iso-2022-jp?B?anByUmFyK1lLb3JyK1NnTmg3Y2xmYmNZMnBvM1FZZWx3RjZGektEd3Jm?=
 =?iso-2022-jp?B?MXBOckV0VVpjdXhrbkFIeUJyNkh5TEdjQ0F6M1lCQk96SDVkSFcyc0hJ?=
 =?iso-2022-jp?B?ZEI5NlpKdzExZHJDYXN2cWd1UkFmakp6V2tGNUtxc0d5QndOdndkRERt?=
 =?iso-2022-jp?B?bGZaUndmd1AxOFY2ZlA1VHVtMVIzRWNrbHRMMHZzYk04dy81SWdtZUdM?=
 =?iso-2022-jp?B?VXo1U2xlSkJJakNnZjNJcGdwSllSNnFTR1FoajdteXl0QUNVdldJWXNO?=
 =?iso-2022-jp?B?NmFUVXZraUVheTFWYW9ySDRxSU9BVVlKbnlqSmpWaGNDV0pEUEdhcmRD?=
 =?iso-2022-jp?B?V0k1Y3Fud01vWDZoQy91YnhiNTU2THUwWW43bm15ODV6aHBwUSs2dmJ2?=
 =?iso-2022-jp?B?cjlrcVlQb09pMVVKTXN0cnpvbHpid0VoODVPTkQ0VUFZcnZUS29VYkNL?=
 =?iso-2022-jp?B?ZHVYVytESFI2NmE2US9NeUN3Yk5vZVhlL2ZLbHRSNHprZ1RNdlRQRSs5?=
 =?iso-2022-jp?B?UlBBK3J4UzdqYU9XRWlyd1Eya2J3bnA3eStyYUJGaEhudVBjVkpoV05M?=
 =?iso-2022-jp?B?UFRtREJlNS9XWjFYdUN5SDhxY0RpSmlWZWpPYUZpaFBJOWE1SzlLZVlx?=
 =?iso-2022-jp?B?Ris4cWtYZVYvaEJvSm51ckpPVEJuZnM2OE1kZVVITWc5dkljTVpma0VR?=
 =?iso-2022-jp?B?ellLZGFvQW1BUk1pWk5mZ1VhMTdGU3hlc3AwU3BjSzY4d2FtUFp2K0RM?=
 =?iso-2022-jp?B?a3JwM2wxczlOdzVLdjI3UHZTZUcvbFZMZ1l1SmtseWdDYlNCVXFCbkUy?=
 =?iso-2022-jp?B?M0praXFPVEFHK1lTT2svREFoZE9pZjQ3VDJWbzFmMjNiVllvUjBXQzFL?=
 =?iso-2022-jp?B?MUdPUVBmamJteXpVYVBXc2cvcjJmRjdZMWpDY3NYbVpKM1Jva2U0RkVu?=
 =?iso-2022-jp?B?cTRKMG5nUG8rRHByVW5Gb1VaeSt1NWtjRjNLOFlWSDFQbUtWM3Vkc2dI?=
 =?iso-2022-jp?B?L0hhdHdqMmFyamxBcXdtZ3NIZXBtdm9oMlBwUFVLN1lKdkhiL0gwYUtF?=
 =?iso-2022-jp?B?SWRtSEVncjRzUitHVzNQRDlTeFJrZDVxbnVLdFZCaDlGK3NJZWdGVktG?=
 =?iso-2022-jp?B?NHRTTEhXd1hpSllVWk16TUhDMEd1cC9RPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dFFEdmFBNFRxclVJTnJDUFpOeVZaVUhXQmlCZjE4TENUSGVZYUN2Vmhh?=
 =?iso-2022-jp?B?ckNGVy9MRVYxOEJFRURPTzk5UlBUU0tTTmdDZHovV1Y1ZWVJTmViSEZR?=
 =?iso-2022-jp?B?QjBpd2dXT1p1Y0dnL2ZiTkd1TmhUM2k0c2lxYW5YZm1pWXZUa25pOGE3?=
 =?iso-2022-jp?B?Y2xjc1lTWHNZYUtVRU1wbXJGRk1iSTdiTnlOeS80SnIxeitsdVFyeDIv?=
 =?iso-2022-jp?B?VTJnQjRDMC9TZjFJeGg1MlBYNW9MRWZDKzBoU1R4M3MzSVROQklVU2JR?=
 =?iso-2022-jp?B?cWdadVJEcnArL2gxSjFkU3MxbFFEczZyRmdmUGk1UndvSUtrU3FJTjJL?=
 =?iso-2022-jp?B?MnZTbUZneWE4WWY2eEovVzNvemRHeThpNGFseTk1amNHNXBEY09KcVFh?=
 =?iso-2022-jp?B?eEdBcWE0OHpDT2dQdE4wYVMzb1hPakZoOUVrVlZ2TUY4YWlrN1MwTm9G?=
 =?iso-2022-jp?B?UWl4WXNjQnVFK0x4clM0S1M1R3pROFNhWnlLNHVNTjF0WGl3NUFOYWpV?=
 =?iso-2022-jp?B?OWo2RjdqTWx0T3B2cHVDUzRFQVowRm9JTUtHYkRuU3RXdmNmd2YvaDdK?=
 =?iso-2022-jp?B?bFQ3d2hDUTVaOHhqT1ptNmNNQTkyamRxM3VvNDFmcXpTUTRmTTRjTW5i?=
 =?iso-2022-jp?B?NW52Vlpqdkc5M2pTVENLL2Y5OWVSRFl1REEzcnpxZ1d0OHhUcXJYVEpm?=
 =?iso-2022-jp?B?WWE5Z0Z0ZytTWUZWemxROW96d3hzWkZ5SzJ4QTh2MmdNOTBHVWo3SlBO?=
 =?iso-2022-jp?B?bzcvRlFhVEg5NXRhNUNFZXZ1MEtKR3p3ajBOQ1ZZTEk1UjgrbHFNZ0Vs?=
 =?iso-2022-jp?B?VU03UVozZUdRdGRyR01SOE1sd25jWFU5aW5yVk1qUzJtazRNTmM1STdw?=
 =?iso-2022-jp?B?aExDZTY4S2lYUXYrK1hRVEdGdTRPb1B0RUE5Wnk1VmNXVXpHaUZlMlI5?=
 =?iso-2022-jp?B?TUR6b0ZpMHJDSC9nVTVQV1Bucm5tSU1NTmQ1RDI2ZmFXalhVWTZoMENG?=
 =?iso-2022-jp?B?enlkRFJMeCtnTDhkZzZ6d09VUm5rVUZ4RWhOUjBFb3B2U2dYd3lwNWZM?=
 =?iso-2022-jp?B?eHVLcVNQRy9wK25BN210b2R6TVBDK2pKbUJTTGtQTWM0bG5vZCtwS0dY?=
 =?iso-2022-jp?B?MWxwaExhTFBWM1pSQmVKVVJNdjlYeUFxNlZ0WVRzdXRCM0JZZ3ZkeHdm?=
 =?iso-2022-jp?B?UHNJdlgzNFVDVkdiNmU1L3B1V24rKy83YVBFZmJ0NTk2VzA3Y3REemV5?=
 =?iso-2022-jp?B?SWtJdUNOR09DKytGMHpDcVFWcmkwcTcxRWlqNCtLeDkzMlY1QlpsWWs3?=
 =?iso-2022-jp?B?ZU9VbXQ5VUlMVktYd2JHSjVMc1pLZTFieFR2dWxkU2xqN0ZuTjFXbW5l?=
 =?iso-2022-jp?B?TkFZMzA1Q0dhd1I2NlNEZVFNdEhjY1JmWThUTmlzeHJGaG5uQ3NmSHY0?=
 =?iso-2022-jp?B?NEQ3Z3RyUXJhWG4zTEdsSVBWeGE1Vzk0VHZCMmxsRkg2bTF0dkgrT0R6?=
 =?iso-2022-jp?B?bm9KZlExTy82WVI3M095MUZKQUszZEJ5L0x4czBsU0lkZU1Wa2psQ1lx?=
 =?iso-2022-jp?B?NjBxdndEZElrUFJHckVjaEtQb092OWIrbWNkSWtrTlVkbG1HQXFOZktt?=
 =?iso-2022-jp?B?bC9DTVJSTWtiMlM0NnZ1eW5ZcWg5NW1TV0NlQVViRzdFVWFYcW5PUHZo?=
 =?iso-2022-jp?B?RGQzOGVlUmFSaXZic1RxWDdjVVR3MGhIMVg0TE9rb1ZyRUVqdzM1M2g5?=
 =?iso-2022-jp?B?bzZPSmZodlpsaEJ4SkVHYVhqb1Zmbkt0cnhvVTFYWHZhU1hoWjdhbWFY?=
 =?iso-2022-jp?B?bEZlWmZVbFExa2MrUFBxb1ptOUxvcG5NNlVmOWFBM3RVZ2IzL1g0ZW5N?=
 =?iso-2022-jp?B?TWJTYjRTRXRtNStBVTlVZjVTRGhiY1hTUnVUMHFKM1ZkUlBlUXZsb0lk?=
 =?iso-2022-jp?B?SlY5NFZneGxnOHZlVlo4OVZFcGwzUEx3Q3FwcVZUQktBTWl4OWxMSnFK?=
 =?iso-2022-jp?B?Y1ZzTFp6OXJ0eCtCT1Rkb1YyMEZUZllFRXhWaGg2UkEzWWxwaHlOQ0lF?=
 =?iso-2022-jp?B?aEMzTitYSlVIRVYyUnBxdUFjNVpEYjRRRjh1UTIrdzArN1BzV1lBQ3FG?=
 =?iso-2022-jp?B?eXlOck55UFc5VWU1dkVTZ1IxczZVZnFGeUQ1VlErT3ZGRXNDUFBqNVdn?=
 =?iso-2022-jp?B?OTJlVWFLdW1oNW5yMjNnZWcxdXdTam9GR3c0VDU2T3Nua3VhTXU0R3Zo?=
 =?iso-2022-jp?B?Z1drd3hmS252emFubmRvSklCWjdFaW16VmhpMlZUQS9CdVl0bFdLUzNK?=
 =?iso-2022-jp?B?RzlFaGx5dFFZQnRBMi8rckRYT3dlS2JFeHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98527826-78a9-4279-971c-08dd1fc873dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 00:59:55.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXSzrHRJSw+d/1F+TQOd9Mn4xHP2nHy9fVPlz5D57Sj3YugyT6MPbwEkVz3ET3Em277epQ8VDQpS0CD/l/JD/LJt/YusHWTiCYUBSGhYBl6or4E3f3tfrz2IcwzK5Tn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 01:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17472

Hi all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, December 18, 2024 9:23 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org;
> biju.das.jz@bp.renesas.com; prabhakar.mahadev-lad.rj@bp.renesas.com
> Subject: [cip dev][PATCH 5.10.y-cip 00/10] watchdog: rzg2l_wdt: Backport
> RZ/G3S support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Series backports the watchdog support for the Renesas RZ/G3S SoC.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (10):
>   clk: renesas: r9a08g045: Add clock and reset support for watchdog
>   watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
>   watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
>   watchdog: rzg2l_wdt: Remove reset de-assert from probe
>   watchdog: rzg2l_wdt: Remove comparison with zero
>   watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
>   watchdog: rzg2l_wdt: Add suspend/resume support
>   watchdog: rzg2l_wdt: Power on the watchdog domain in the restart
>     handler
>   arm64: dts: renesas: r9a08g045: Add watchdog node
>   arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
>=20
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  14 ++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   5 +
>  drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
>  drivers/watchdog/rzg2l_wdt.c                  | 133
> +++++++++++-------
>  4 files changed, 103 insertions(+), 52 deletions(-)
>=20
> --

I reviewed this series, I had no part to point out.
I can apply this, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


