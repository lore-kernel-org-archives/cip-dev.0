Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D0C41513
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 11:36:32 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.82])
 by mx.groups.io with SMTP id smtpd.web11.14320.1713864952078983878
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 02:35:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t0HtGjgK;
 spf=pass (domain: siemens.com, ip: 40.107.21.82, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3BWLCQJPIbSZnF674/6JH3fUJf1ZlkS2dqeHm8j6ne43RZNpP0xK02/+Jkwm8A3RJCyje2IF6pD/nrfC+mLLIvrVcijrgkX5X3JAfAB4phBwFTnHZZSWCjwqAnW+bihf9S9mg2r2hFjxN7x7f4BCbV//duZ5dDW/O6S+c8Ty1LEmKIGSFrTudmJ3mpwMDvxh13sPvveultFrBo0++sAbEz1mwayqPlYZXeSda3DaCBnl0IqkcWBe3dnV5iftOwZrJXdMu4C2sLa3kD+zwCLaqZXx4Xd034GG3ZQEaUYLUTRQhqBR2VCXlNUnsEASGVbpZXMpHg5jg4upbkhL0M/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY07twswuQAkCVxO7PSFE6Y98ZXR64MoHrCWORB7z2s=;
 b=VwfBzUIAMdy1/i6A3iHbg9Io6Sp7Kk8ZgeEtUolg4C+e7Gt13aYPHgJtyxQZsAENqpkKiBnGy36NlpFyQRb2WXOoTCgl8chKicj0Hyp8RXsiy5vLBKPFApZ5bVceMeg7MJLDBv7OBOIRE/yx3eknB1RrpCqrRCSOVqsNln5krNlfcY4RptxIEqKa6dXoOFxXfV6u3MGF4eU0GLe6MJRN3WDTKVBC17WkFUNADKbwXS78gbEi4O1uQ55KWjgmJLDak4+b+H7z2W+p/CXBq6Ym2UoSkePZsHbe02OjZbbJx7dcpMdUEezXiauZhSow5rbeLJx3s7KzCbNgZyGMvJgi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY07twswuQAkCVxO7PSFE6Y98ZXR64MoHrCWORB7z2s=;
 b=t0HtGjgKvCWl4z5tmUmrjNiaNspkctbTHcjZX7hKhHUznOjChDX/MzL4CAj6mf+jcKM9/4CJzHwWBq6EkdnrZ5NXs0rx/KdLsJQe3d/9U7ELc4IHfbSr+jrSHzyBsiD7ZtHFrjDacJV1pPfjDatQ60FZTIkdhlGG8VN/+0T0B5CxIttjgyJjiin7wd1iJu4C6DEbT5UHz5MGChkoSIsESZjn/MEwetY0+konpqIlBr6W/5oNeCdKUBEprHsZ+HaQTP88o5EIaZBQ4GNQ0ePauORQ43EGYpJdxub3CZlFAo1KlzIRq7f7dt7xNKLmdFMejd+IQGpyTKLUAoEn25bODA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB8PR10MB3628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:35:48 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:35:48 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to identify encrypted partition
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to
 identify encrypted partition
Thread-Index: AQHalWGf3mtVU5Lzz0SMvFl7Y1ut7Q==
Date: Tue, 23 Apr 2024 09:35:48 +0000
Message-ID: <9154239823f08a82d34c8810a51290e8e557fb40.camel@siemens.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
	 <20240422141120.577573-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240422141120.577573-5-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB8PR10MB3628:EE_
x-ms-office365-filtering-correlation-id: 6b0cafff-cc88-4f97-a538-08dc6378c241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VTJhN2ZjZkFtVHdZV0JuTmVYeGpGaVJkMjZGb1ZGbDY2ZUxyaU9FeXBBV2tS?=
 =?utf-8?B?UlhvYjVWeUxGZDY5emxQUGkwQXdEd3RkbHdOb2FIZlZoWU5sR2NGVlV0YnRC?=
 =?utf-8?B?c0xpTVcvckh5SVBZcUpzVWdLb3lHd3lXMlV3ZU9Hd0wwbW90T3dwYW9uQ3U5?=
 =?utf-8?B?Z1JINldybjF4Ym0zZUUxLzF3Mm05eGs2bmFYSFF2eXA2WC8rU3pjUnBOTlp5?=
 =?utf-8?B?dVFPSVBNVDN0NnRmU3ZvdXhGWjd5cnZNbXV2b2JoT0o3SXBsbFJCN3N3V240?=
 =?utf-8?B?dGpCcXpsTXFuVWdZSWwySmFibndEaWdZa2FZWEVOQkU4Q2cwdFJMR3pVUXZy?=
 =?utf-8?B?dTVYMzBCdUl4VjF4TXhzVmtONFlnVVpUcVU5RFZrZUUwWnVVcFdMS1VEWmVw?=
 =?utf-8?B?b2M2WXlDRkVoOVB4SXRmWDNaN1dxQ3JzYWptQjJPRkFwLyttNldMODFaTWdO?=
 =?utf-8?B?VUw0S3ZOZmNLUW8wcEFnbk9VKzBQQ0VBaGxEYkpCR1B0cUE3NGY5Sm4wdW9J?=
 =?utf-8?B?ZjJEUmRVL1FLcnd2MExGOE1XZlpwc1V0SGJXZDAyYkFoN1llZXRvdElDRnJR?=
 =?utf-8?B?N213TWRyR09SdzZ1TGJIaHM1WVBnTUtJaFpFRjI0T2wwdjNuZjhUS0xrRHA4?=
 =?utf-8?B?SDJ1cDg4SUkvc1ZQeWMzdGVnQkVUOXFBT0ovUGRTcCtxZDhQOE9BcVFJL0RI?=
 =?utf-8?B?Q3Q0N21NWHlYcUhZRFdZcnJvU0M2L1dpS04vSCtuMWtEQ2hyVW8rMGhaMGdK?=
 =?utf-8?B?UU9yQnhwdk5UaDg2QWp2ZlpWT0x6eEZpbzRoUHZUbEc5MWRFdUtzYnRXOXNO?=
 =?utf-8?B?cXYrYWNJaXFIeVJtTXJESndCVEZYb0xnajFzeWN1Qk5tSTNsZ3l6ZURFRmNG?=
 =?utf-8?B?ZlcvZmV4OUM2QVIvaHc3bFdLTGExMDgxTzA1QmNwd2ZIaW9oZlVUYmRNK3cw?=
 =?utf-8?B?QU1UNk14bXN1SGd0dDE2SVBHTHJQZldubDlTSFBOWXFSMEl4Mk1qT1poTmJD?=
 =?utf-8?B?RTFMSGl3WlNwLzRocVcyREdkNGM1Ni9INmZxemxvRDk5WFdobzdKSVFlZ0xx?=
 =?utf-8?B?SXA0MWRxVGFaWkdTajRrNjBnL3llOUxKTUI2V0NwdjZtQjVkRElvaTZPRklo?=
 =?utf-8?B?QU9HWEo3RXVEWUJtbGpGRWV4b1F3cS85UXNQMVNOd3AvbjNFQWtaVURsQVV4?=
 =?utf-8?B?TytxZHFQNDJOUjdzZG5oTmFrK0orVFVGQ0xwNFQvWmJIbXpsVC9HaDhvUVQ1?=
 =?utf-8?B?UGdNaHFxMStJVko0dGlnY3hQb05ISkVlQTE3VG4zZG9PV3NTdlZWcVdudDdj?=
 =?utf-8?B?ZVl3YlJBYXhyajNFOGNZcTNKMmZjUStaemVIbmM5RjhRUmw3VjdJcFNQR2Zn?=
 =?utf-8?B?VTF3M2RYYkpBZk9Mb085Y2k0SHkvenZSK3JiZnRtVVdUWG8xbmxjUUlMWm5z?=
 =?utf-8?B?Z2g2Y2JGNlFmMnU2TFJGeVJJM09nRU9iV3hTZW9QTDIzSFFIRjNSN3l2b0VH?=
 =?utf-8?B?WWZzd1Q0VlNiYnhLMU1rMVkyNkZBS1JnTDdXT2hCT3IzK2NVZHozbUsxVS9o?=
 =?utf-8?B?bGc2blJQOWJlVTB1YU91alhWSzBGRG51WnZaU1pNb281RzJKc28zdDBsVzlE?=
 =?utf-8?B?bHNlOXpHWnlESUREZEVMYW9UeU44QWhkZVYxT1phbHY0N1JySkdsVStqL3Fx?=
 =?utf-8?B?SndnV2dSNnZneEltMVRoNTJObHpGYVhGbjNlVUpYRkUrV0lVcDlOT3lYQ2xl?=
 =?utf-8?B?TWs0ay91NXg1Wk9EWUx4TWE2OXM1TFF6VWV4Y3NqNTVBMmdUR0hOVVp6eVdh?=
 =?utf-8?B?R0dkMVE0eTNERXdGeWhZdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFBYWXNuN2dqM3lBYXNlWnR2UDlKSXVGeDhWYlBIb21VcFVtWU5oUEZVVnF2?=
 =?utf-8?B?eDJ0SmkrQ0ZWOTZQMDJzNE5jbW5jSVZ2dEpJMHhqQURVdGdwZGdkODBad1Aw?=
 =?utf-8?B?OGc3KzZWQzhMMktDRklSczdFR2tWckdvQXVsdW96N25uako5ak92QWU0cjB3?=
 =?utf-8?B?WXNjd05udEY5S2dZaGtvY1BySGwyUzNQM3ptZU83cG1YRDM4WTYzS0ZZK2Fa?=
 =?utf-8?B?Y1dIeW0zZEhpVlo1RTBSRmZ5YSsxK04yTFJTSmRKZUprME5vTG81MG1YWnRD?=
 =?utf-8?B?TDRMQkVUa2ZIQnRvMlFiL0NtT05NdGh0dU1YdlVQd2pMSHRFMno3WGdjb0Rz?=
 =?utf-8?B?bE9hZU9HMGNKMGx3VzJ5ZDFoREo3dkJ0SkFQY0FhdUxFcXFqOWx4K3k3NzBj?=
 =?utf-8?B?eVFsMm9zTCtGTlRSN0lLUVN2RnRhbFQ0SGllZ2ZtQmZjR3QxTzFka2hlSHF6?=
 =?utf-8?B?enJJdStwRkszYmhTYU9nQ1FLMG5vanJMZ3ErUmhyUUtLR3I3UEpsTUpsOWt5?=
 =?utf-8?B?VlBtTjEvcHBvUmQ0Nk96ajFQemJWVWF4eUJRM1Z0bkIwWkUyNkRzeGpTQzBy?=
 =?utf-8?B?ZDliWTJDRndLMmx5cXcvUHNKL3dFTmtiMmhjY3EraXBqcklUYVR0SUlNRHB0?=
 =?utf-8?B?V2pUSGtPQ1VnYWwxYUNVeW5LUE9iU0xRdjYvVWNCUmFtT29OeFFLTXoxM09r?=
 =?utf-8?B?b3JoU0EzVGVQK1MrWGZhQVREei9vTVVZYWdsTUZReVJFSi9vZHdmV0VyUDg0?=
 =?utf-8?B?dnlGMDlQQS8vS21ya0podVlPdlYvUWNyUnRSczROSWpWOXhUaE9yaGlyL0JZ?=
 =?utf-8?B?amxiVTRxcWRRRWthTEc3bkdrRnpPOE53STI0VEZPbFgrNFRQMmpyS2pNRUIw?=
 =?utf-8?B?bjZVRUtMYUtFUzkydHJKL29jRlZCeWZnaGh3cThGb1FneDVuUnV0REJDVWVZ?=
 =?utf-8?B?S3Z4Y1dCY3FodWJiRG9xSkRsMmRaVTRkWmhrVitIblFtM2ZYdENkV0l5MjJr?=
 =?utf-8?B?ZUNUdEFFY0lxeVJabkx6K25kNkJtTUtsMWJ0bEJSVUtncDZydXFRQWZzRmpZ?=
 =?utf-8?B?Vk4ra3kxOHBFaDdjMG53VHgzWlRFOExtRGQyVWd2U0I5VmF1eVRXMHMxeWVL?=
 =?utf-8?B?RVhBOUNzQUsxNy9EQldNb3dITEN2NDBoUzBCcEdNek00eU5NWTVEN2pPSnlh?=
 =?utf-8?B?S0l3Sk9rRTJ3dENRdDRXWEFGS3FHTi9hSWh6MTl1U2NSTXhLS3RDVEpsMlps?=
 =?utf-8?B?RzBJdk5DTUxQbGlFZ0UzQ0Y0eVVlenRzcURYSzh1cHcvMGw1dVJVUnZMTit3?=
 =?utf-8?B?VW1kdnNUS2RBTEdGY21CcEdVM0NNcUNYa041SE1JeTFqdHdVZytDNHBUT2lD?=
 =?utf-8?B?QjdNZFljZ2UvaFplcUZpM1hHaFZwZnc0MDUvOTZDR1REZVFZSXJLeFpmTzM5?=
 =?utf-8?B?ZXZIK3pacjRxbC9NS2E3K21JZWoyaVZRVGNsZVlqZlhidndEb2NRRGdpT2Rw?=
 =?utf-8?B?bS9ZaDdVSUxjT1dkTEVmVStGeWV6S1JuQUVrSVNDUUZQMkNrK3hwcFRacm1H?=
 =?utf-8?B?Nitlc3NPT3E3YWNaSG40bVcwUUliR0RJVDJxZlpSZ2tEUUlBclF4SVhUcWha?=
 =?utf-8?B?Q09RK0YyRU5MaEowSFJpZ3hKL3lqaVdkaXlPYkVLd25KeFRhQi9wSGEvWWw0?=
 =?utf-8?B?N3l5MkxSY2hTc0NReVNjTXhUejRJbXpzbXJLMVBGVC9od05NQ0o5WDQvY2h1?=
 =?utf-8?B?ZEMvak5BbzRINERhL3dNQVA4d2lzK1k2V1l2elRXWWZlRFpqU2xVY2pDOS9M?=
 =?utf-8?B?dXNGQzRuVVExNWpuQW9ycFpSeDBIaVJ6UzdtZ1NIWUdYN3o5S0FIb05NZzA2?=
 =?utf-8?B?dWpCZVZFUWF0ZkttSjQ4Q2hwaGlzank1MVQxZldURkJvb1B1NFIvK21NNXkr?=
 =?utf-8?B?ODI4c2k5bDdKM0pFYVc0YytQZmUrVVF5bSsvT3NtMEowUGUzQmt6aTMxT1NW?=
 =?utf-8?B?U0M5c20wK0dPSUlRSmgxUDE1RFJONFlLYjMxaXZydnZRd2ZpRWR0UWFYZkZy?=
 =?utf-8?B?OGdxdmV4S3h0T2pUUnBxaFp2aGxBQ09qbmRhaDRGUlBjaStIRDIyM0VKbWkr?=
 =?utf-8?B?STg3RTU3bjNsVXBRVmZwekZjeHpkT2RGYkROZHRadHplWWJPNkVKSlJpaTdQ?=
 =?utf-8?B?czFqSWplT0JzaGtpU3FZVDlUQU1XMTY1RHBaaFNiYmJ5cGpITUVMaGMvZjdv?=
 =?utf-8?Q?BMR8mS/UhBNMB4M4VN6jExt0cdd/4g6l8ZMOcmal6U=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0cafff-cc88-4f97-a538-08dc6378c241
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 09:35:48.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kV/qC2ZB/I07jlxB6/G+kBdr3WoBjt8I4wuF4Gaw8aSrXpsvaw9lFqYKut4vTTd1cW9QWyNfPylB3KeNA5Kp59WG0Q84npsKUyUSBFS0oV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3628
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D0547727A83454887F0680E84CD3312@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 11:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15736

T24gTW9uLCAyMDI0LTA0LTIyIGF0IDE2OjA5ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBmaXhlcyBhbiBpc3N1ZSB3aXRoIGVuY3J5cHRlZCByb290ZnMgZHVyaW5n
IHN5c3RlbSByZWJvb3QuDQo+IFdpdGggdGhlIHRva2VuIG9wdGlvbiBpdCBjYW4gaGFwcGVuIHRo
YXQgZHVyaW5nIHJlYm9vdCB0aGUgbm8NCj4gdmFsaWQgTHVrcyBwYXJ0aXRpb24gaXMgZm91bmQg
YW5kIHRoZSBib290IHVwIGZhaWxzIGluIHRoZSBpbml0cmQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiAtLS0N
Cj4gwqAuLi4vaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2Ny
aXB0wqDCoMKgwqDCoMKgwqDCoCB8IDINCj4gKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRy
YW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+IGhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2Ny
aXB0IGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLQ0KPiBjcnlwdC1ob29rL2ZpbGVzL2Vu
Y3J5cHRfcGFydGl0aW9uLnNjcmlwdA0KPiBpbmRleCA1MWM4MWYzLi42ODVkODgyIDEwMDY0NA0K
PiAtLS0gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+IGhvb2svZmlsZXMv
ZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0DQo+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRy
YW1mcy1jcnlwdC0NCj4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zY3JpcHQNCj4gQEAg
LTEzNCw3ICsxMzQsNyBAQCBmb3IgcGFydGl0aW9uX3NldCBpbiAkcGFydGl0aW9uX3NldHM7IGRv
DQo+IMKgwqDCoMKgwqDCoMKgwqBmaQ0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgL3Vzci9z
YmluL2NyeXB0c2V0dXAgbHVrc0R1bXAgLS1iYXRjaC1tb2RlICIkcGFydGl0aW9uIiBcDQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCBncmVwIC1xICJ0
b2tlbiI7IHRoZW4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB8IGdyZXAgLXEgImx1a3MyIjsgdGhlbg0KDQpIb3cgZG8gd2UgaWRlbnRpZnkgIm91ciIg
cGFydGl0aW9ucyBpbiB0aGUgZmlyc3QgcGxhY2U/IElmIEkgcmVhZCB0aGUNCmNvZGUgY29ycmVj
dGx5LCB3ZSBzdGlsbCBpZGVudGlmeSBieSBsYWJlbCwgd2hpY2ggaXMgcXVpdGUgcmlza3kuDQpP
dGhlcndpc2Ugd2UgbWlnaHQgcmUtZW5jcnlwdCBwYXJ0aXRpb25zIHdoaWNoIGFyZSBub3QgZXZl
biB1bmRlciBvdXINCmNvbnRyb2wuDQoNCldlIG11c3QgZWl0aGVyIGlkZW50aWZ5IGJ5IFVVSUQs
IG9yIGF0IGxlYXN0IGxpbWl0IHRoZSBzZWFyY2ggdG8gdGhlDQpkZXZpY2UgdGhhdCB3ZSBib290
ZXQgZnJvbSAodGhpcyBpcyBrbm93biB2aWEgdGhlIHN5c3RlbWQNCkJPT1RfTE9BREVSX0lOVEVS
RkFDRSBvbiByZWNlbnQgZW5vdWdoIGViZyB2ZXJzaW9ucykuDQoNCkZlbGl4DQoNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvcGVuX3RwbTJfcGFydGl0aW9uICIkcGFydF9kZXZp
Y2UiDQo+ICIkY3J5cHRfbW91bnRfbmFtZSIgIiR0cG1fZGV2aWNlIg0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlDQo+IMKgwqDCoMKgwqDCoMKgwqBmaQ0KDQotLSAN
ClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

