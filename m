Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F9EC25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 09:45:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.79388.1717407904080565077
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 02:45:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4539j1h62711816; Mon, 3 Jun 2024 18:45:02 +0900
X-Iguazu-Qid: 2yAb3nxBquVwcbEpXO
X-Iguazu-QSIG: v=2; s=0; t=1717407901; q=2yAb3nxBquVwcbEpXO; m=R8fjUikJp10Nnuz/MB2FhaEVezrxq2WzbyA0m4I6hQo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 4539j0cm1321718
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 18:45:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT4W8HUe30ZsRhFSOG17ResQOmSxhAlPBB4f9HsmJboKul1fbOwir+mv9u0dTSXAOlgYt+FJ86Kpa9Ijr75X+WBkS/nzfpCDs0pWtuDUGPPwwBF+tE5T7eq1rVNRB03Vli5ywPH4bRLwkbKQw3dmlIgnfD7YghZREnzEeLBc2WuL6PWChH7oZQNrIXDS9W4mHr/tdCT4bkEysjlwbjKOVfNDZmfWvVScn6yQZosfjSjEsqLCujetXbKga4jnpt5/ZFNqI11b0X6uECSpAdMCscuyPUu3KSz02hGA/PAY1UF5qS0UY7Ly3E+AKUYsq+Sx3qIJVQrHXdan+pyB8yBkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vir+dKJoCmpRYEron9I4q88ePcKVKRV5nQcqRCS83do=;
 b=VYHEKd3tLFry0VD9fPRP5ORkgArMnIgdb57jzIoDoUeDi3Ozk25lPlzcNirjLs4B2SLvTuoMFZunEjp99+hePlh3jEXAyuuEfk996diI2EuSokMGO/W3RsHN3iJ6UqOHdFYZMggVqnS6R5OmrXxmpyxNAuCjsX/m8f+k1A6aGDnFuRMb+S078OaWv0uR6t11HyRnqWMD15JWjUrr1ge9WNf9DIzf6d37yubCoSR8Le6oo0yC36j5aYtSitQjljQ+5RKAR3W7H6waHRWq8xehDQnoklBEfGB6tBOxJpbOZ4M7/+Aw/HL6NRwBskoJ5xOZ2zKDiVQxOmQfq8I0UIHYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets
 specific for CIP core functionalities
Thread-Topic: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets
 specific for CIP core functionalities
Thread-Index: AQHatYT3zvzSaB/7DkyVmZfNM6jWa7G1wUKAgAADQxCAAAVg8A==
Date: Mon, 3 Jun 2024 09:44:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103885E6783C601CA5052BEC2FF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240603070920.2942859-4-Sai.Sathujoda@toshiba-tsip.com>
 <441b9fa4-27d2-48b1-8c8c-9380ad839ccc@siemens.com>
 <17D5748A2FB0DABE.21428@lists.cip-project.org>
In-Reply-To: <17D5748A2FB0DABE.21428@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB7239:EE_
x-ms-office365-filtering-correlation-id: b034c710-258a-476e-42b4-08dc83b1d4bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YWJ1SzdvYWEyU3I4dFNybDJ0RFhFeDNQZmJZZ2xMUEpuYWRXRTVNL3JpSGh6?=
 =?utf-8?B?MnlyaFB2aW05RWtudzBkSXlqcTZzUjh4TWtORHh2dXFiMW1xOFJCaTdkZk9X?=
 =?utf-8?B?M2JscTVodndBcnZmM2REbWExaUtpcWNXaGNoL2tqdG13RnM5WFBsMkVOelFk?=
 =?utf-8?B?ZVdCcWd1VTF5bDVxamJtRUh3YmhXOTQvNy9SVDNWbTVyYi9hRkxiSXdBUVE1?=
 =?utf-8?B?aVZkTWdxV3B2L2ljcm1MWU1CZE0yeDArRVI3V056aGRNRlZlZ1p0eHNHUnRE?=
 =?utf-8?B?SVNBT0Z3RkV6eS83dHh6NXBTQmgzUXc1TTd0Vk94cE1vNUNEa1FRQVdKeHgr?=
 =?utf-8?B?NHJGMkFFVCtiNWtPV0NWd01TMnBpclNqVXRmaFFKQWRBWExhZUsyNXRUY1E3?=
 =?utf-8?B?a0NTNkdxSDFtaWhQcjVZOWNCOTVpTkVyR1BhM2pUSDQ4NW9iMkJ0TE9wajVE?=
 =?utf-8?B?bS9xUHgwNzh6OTNOWEJsUE43WlFKZVp0a2ZYMGI0aE4zY01ZQUx4ckFTYThO?=
 =?utf-8?B?dnh0dHRIZlJhV1dkcHZza0FBUURld0tkcElBa2NmNnhqdVlpY3FhdzM0WjBu?=
 =?utf-8?B?K01jWEQ0V0hFOUJyeWk3TVZMTk5CTXQwU2NSQ2hMbERuRHhxdXpwZG9UT2Vj?=
 =?utf-8?B?dTBPZjIxcW1ZbFIvTU1uZ0hPbkxzWXlnOExOcnBScC9kLzdiZVdHQ3NYNkZO?=
 =?utf-8?B?eUNoR292UzZldGFyNk5Dek9UTlE1TXJBRlgveEJHUU5YblY2cGE1ajFEZ2ZC?=
 =?utf-8?B?bVNaSjlLc1A2dm9YNzhqdjRXMTlHTjAyemx1b3Y2RkFEbE5YNDlVNVJyeDg0?=
 =?utf-8?B?YTZ0RmwxWGN1NHl2VlREbnB5L1VEWVcxK1JZdGFQK2JOK3pBUFVRRm5WK3dp?=
 =?utf-8?B?WjJOUXBIdUpySlduYi81bXA5UFAyaVI1MVhSLytzaS92eDJKMzN3VWZQT0tY?=
 =?utf-8?B?QnBITThMVFVZMXc1NEt2TXo3MnVGcW0rZnc5TktuVC9xL292WXp3Q0d5SjRK?=
 =?utf-8?B?bjJEQVRBSEdoWGVxdUM5RmtWWmNzSnhDUDc1elZ5d0FPckkzVk0rTzJGY29X?=
 =?utf-8?B?U3A4R2p6NGZHd0hBWnVYQVJaV2tDcFJZMERON1V2ckY0SGpMcHIxdjZ1by8z?=
 =?utf-8?B?Wlp6c0IzTGs1QS83T1BiTnVuRGhxTk5EZnpNQ1dvbTg0OG03Q0JjdFZNQXlY?=
 =?utf-8?B?OXVmTDlFOWhSeWdya3JZcXlNVEZ6NG9XTVZFc3B4K0QrdldhNUNiQkhsM2Fm?=
 =?utf-8?B?NE5iUVpHVERReTIzdVdQMXRHOFBHbVpSQWx0RTZncFJRUitZQVZ6b2tCOWZP?=
 =?utf-8?B?dUZILzhTNDY4WDlESDc1YzJRenJ5ZVUwdnFFVFBmNERleTA5T1BuODJOU2dC?=
 =?utf-8?B?cVNjWGdrZkxHMEMwWmMraERwekVwdko3bzJjWExXdVVndXRyWStZRkc0RlU0?=
 =?utf-8?B?NUx4ajZaYXh0QzZqamtiNCtodlRTWXk4WE53Z3N0aUJXRXJXeWdEcWs5SnRv?=
 =?utf-8?B?RkkrYVVGaDFMVHYwdGZFa1g5eUtGZHdZeWRNV2dvT3VxZnE3YiswYzI5WE1Q?=
 =?utf-8?B?RUh1VXV5Mytpd0FZTHdhT0RkS1I3cWk5ZS9Yd3NmcXNoUXlnOGo1UzgwQWts?=
 =?utf-8?B?Mzc0UjhYUWhod1ZSamdtaUZHYVdyMXFEaG5XMGZSZS9RZVJNaCtjSFNzOXN2?=
 =?utf-8?B?cFFMY3JqU0xpYTRsNk16eTNkb0E1Rk5uVDNEWThkaW00OWZpL3NtcU5SLzhW?=
 =?utf-8?Q?Eq6hj4DFTCK38xwp5Jtai++3JwiXSA0+zf7QbNj?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q1IvRkZiZ1NMblZyakpEbERqb1FuSE5vMXVkZDkxelZxQ2VoL3l0c0Z0UFJj?=
 =?utf-8?B?MzFmRWU0V21CUC9YV0FGbFFJaC9qRS9NYXVXTHN6VXVEZkNvR1VlYmh3NHpN?=
 =?utf-8?B?TjZBV1VCdHRNd3VwSmRmYXNhQkdobFZFSEhNbURlRFB1bUJDVU9zcnlvKzc5?=
 =?utf-8?B?U1J1ZkZ4VjFYQk55Vm5kYXZUUUYzZVNjbithVUl5UTU0MFBMdXZxOGxhYUpq?=
 =?utf-8?B?NER0MUpvdUVxLzBubjVjTlRwNmxwMGUvelVoYXd2ZGZHTldNN1ZCYTJsaE1J?=
 =?utf-8?B?ejR0dFM2OEZKaDVWbU9xUE9MQzBnTDRWY0RpejZMZjZrbXlyTXVqcHBXMlpm?=
 =?utf-8?B?dkRJV1NZdFRGWjgxQ3M5b1FQa0NHUzQwZGkvbWRzZWNjNjhsTEZZVHBuem16?=
 =?utf-8?B?SnZlS25hZXBJMXFXZFk5eGY3NUlhaWVWbDZtci9WZlhnNTk3cVlsOGpBQjdj?=
 =?utf-8?B?cnNUUnB5dEVtY3AwTHlkbXpkdUdRTFFQYXVhaEUxUFF0dE9CNERDSTYySDlG?=
 =?utf-8?B?YmhYa2xWN2ZORGdQVCtHTnp3Uk5lVlM0dU1FTHRDeUZHMFlmd0Y5MngzaG1K?=
 =?utf-8?B?WEFmSjhSNlNoZDVqNlZuUWNmWmxZYllxRzlLOTJlUTVtbUNzbFRaMVZ2Vkln?=
 =?utf-8?B?bFhtOTJWS0VFZGtpUk5HbzExWnNsMXBmUE5ZQ2ZnQU4zbU5WQVNvWEdOUnkx?=
 =?utf-8?B?eHdsZU9hK0UrdHlUQ2hkYTBMYytIOUVTR2J6S1ZmcitBcyttQzBqQ0MwWXU1?=
 =?utf-8?B?d09IYTFlUDQ1TElPK2RrdTVWZUl5K1Nac0YwZG1lMmh6QTZMWjNwbGQyUk1I?=
 =?utf-8?B?WXl2WEdWYkpUODI2RWJsRkRXQmRsdE1SSDI4V0s2NmR0VXBUVjNoT2t4YUNi?=
 =?utf-8?B?ZkI2cng1b3RFWlUxN01LeVpGcHN6WGd2R0lJN21pQUdFNFRlRmtwZlFHc1Jk?=
 =?utf-8?B?K0hTRHFHTWNmSEFKK0x2cit5T0x4U0NYZ0VIUmhFeVQ0U09zZTRmUGEyODdu?=
 =?utf-8?B?REw1RDRRYmJqcWhKeElsRFgyTkE1VEpzTkZLaHZaV2EzSTd6UFhrRjlkZEhT?=
 =?utf-8?B?NVlIYzFpeXpJNnRvS3VvUlNKOWlYTkVMK1ZxQ01Sdm1Fd2ZHYURQdWdCenk5?=
 =?utf-8?B?Qk1sd24vbi9hSXV4NEhlZjY2dDhMZFYvMEFxVUpNVmhoVG4za2ZFVGFOTkhL?=
 =?utf-8?B?cERnOEI4aGh1VWVGbXUwQzl0UlNrQ1pSV1VtZlpqYjV6VmxsbnJBOWVERHJF?=
 =?utf-8?B?Lytla1ZmdmxRNVZPcHBnZHQvc1B4cUVQWk5VMkI0K2pIZWVDVWdXeTNERklu?=
 =?utf-8?B?TGpKUEpKcVVkeElaQUQ0ckZCTkJTMWZaWmZKb1NXVWJoc25DcFpZdTc5ZXpT?=
 =?utf-8?B?UUFacDc0ZlFBdXlPRW04MlQvYkhnL29IdFRNSFJjRFdNUTBDamg2RW0zR09F?=
 =?utf-8?B?MWJJaU1aRGZmTmRrUTRiSjBGQnFWMDB0ZUVjbm1rRzRwWVZaWndqc3k2UkRM?=
 =?utf-8?B?aHl1bnpPZFB4dVdZbVlUSlg3V05HcXFrT2xCSmJ6VHAvQnJYM2dWS3JUd2dt?=
 =?utf-8?B?SmgwdWFMdVNrV1NkOVhESURLWnU4bFFJd1pTbmJEYnd2UFJGc25YZWF2Q0Nq?=
 =?utf-8?B?ei9IWFdOSWpaenRSL0J2TlVYV0RZWkYveFVTaWVHOWMzZnNpOWhnWnVlRm9t?=
 =?utf-8?B?MmV1K2QrbUJ4eE5JTDR0NWRBSGRKc2xZT3JjRkpTZU9sQy81YWRsOUtVd09j?=
 =?utf-8?B?cjNRekhzclJkTXpMcml2NmZZM29LSWQvVUZHays0R1lNSEtSeFVaUnhrM3Bs?=
 =?utf-8?B?WlRYdlFidG5JUExRTmsxN1hudWRuRXR0ODhNY2xteG8xTGMxbEhmZlp6dzJi?=
 =?utf-8?B?ejcySUxiTmVObldWUXlaSUk0aGdib1hlRDFzNVJxSTFEaVRjT2FIYkRiUC94?=
 =?utf-8?B?NjBaUFNDMzk3OWphbCtIeGlGOTFmWjBjTzJ4WERNbmNOZXlHYnFCSXpaSzAx?=
 =?utf-8?B?dHJ2TkZjR1ZERWdCT3laYTRpOThDZ0MrbXM4NFJvUFlKd01VTlE2emJ2Rno4?=
 =?utf-8?B?NVdlaC9OZWVYOU5lYWc0SEY5RHgzMmlzc0RiYW9ZcytCVVhLVmYrUnpxTlZw?=
 =?utf-8?B?b2JiZHlRZUt2ck9wV0NWSnFtWXZQUW45ZXNldXV0TmJUM3ZxSFc0bHg1OHlY?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b034c710-258a-476e-42b4-08dc83b1d4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:44:58.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29wm1U51SMWogp16U1c5eGs8nAM2L3DgHOys2OgmLaA/t2wK4pgPn5MIksWuPrcPQ9E7YhF4KF8gr/N1NO7cip2qie+ZC56rLBbAD9RUlSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 09:45:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16093

SSBhcG9sb2dpemUgZm9yIHRoZSB0eXBvICJtaWdodCBub3ciIC0+ICJtaWdodCBub3QiLg0KDQpS
ZWdhcmRzLA0KU2FpIEFzaHJpdGggU2F0aHVqb2RhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBzYWkuc2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5j
b20NClNlbnQ6IE1vbmRheSwgSnVuZSAzLCAyMDI0IDI6NTkgUE0NClRvOiBqYW4ua2lzemthQHNp
ZW1lbnMuY29tOyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1h
cijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10
c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp
77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5j
by5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUgMy8zXSAuZ2l0bGFi
LWNpLnltbDogQWRkIHRlc3QgdGFyZ2V0cyBzcGVjaWZpYyBmb3IgQ0lQIGNvcmUgZnVuY3Rpb25h
bGl0aWVzDQoNCkhpIEphbiwNCg0KSSBhZGRlZCAiYWxsb3dfZmFpbHVyZTogdHJ1ZSIgYmVjYXVz
ZSBJIGZlbHQgZXZlcnkgY2hhbmdlIHdoaWNoIHRyaWdnZXJzIGEgcGlwZWxpbmUgbWlnaHQgbm93
IGJlIHJlbGF0ZWQgdG8gdGhlIGZ1bmN0aW9uYWxpdGllcyB3ZSBhcmUgdGVzdGluZyB3aXRoIHRo
ZXNlIExBVkEgam9icy4gU28sIEkgdGhvdWdodCBpdCBpcyBub3QgZ29vZCB0byBmYWlsIHRoZSBl
bnRpcmUgcGlwZWxpbmUganVzdCBiZWNhdXNlIG9uZSBvZiB0aGVzZSB0ZXN0IGpvYnMgZmFpbC4g
U28sIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIGdpdmUgaXQgYXMgYSB3YXJuaW5nIGluc3RlYWQg
b2YgbGV0dGluZyB0aGUgcGlwZWxpbmUgZmFpbC4NCg0KVGhhbmtzIGFuZCByZWdhcmRzLA0KU2Fp
IEFzaHJpdGggU2F0aHVqb2RhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBK
YW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IE1vbmRheSwgSnVuZSAz
LCAyMDI0IDI6NDIgUE0NClRvOiBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVq
b2RhQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6
IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3Vt
YXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3v
vKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFz
aGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZSAzLzNdIC5naXRs
YWItY2kueW1sOiBBZGQgdGVzdCB0YXJnZXRzIHNwZWNpZmljIGZvciBDSVAgY29yZSBmdW5jdGlv
bmFsaXRpZXMNCg0KT24gMDMuMDYuMjQgMDk6MDksIFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lw
LmNvbSB3cm90ZToNCj4gRnJvbTogc2FpIGFzaHJpdGggc2F0aHVqb2RhIDxzYWkuc2F0aHVqb2Rh
QHRvc2hpYmEtdHNpcC5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBzYWkgYXNocml0aCBzYXRo
dWpvZGEgPHNhaS5zYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4NCj4gLS0tDQo+ICAuZ2l0bGFi
LWNpLnltbCB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS8uZ2l0bGFiLWNp
LnltbCBiLy5naXRsYWItY2kueW1sIGluZGV4IGFhYjU1YmUuLjBhMjJhM2YgDQo+IDEwMDY0NA0K
PiAtLS0gYS8uZ2l0bGFiLWNpLnltbA0KPiArKysgYi8uZ2l0bGFiLWNpLnltbA0KPiBAQCAtMzU4
LDYgKzM1OCwzOSBAQCBidWlsZDpxZW11LXJpc2N2NjQ6DQo+ICAgICAgZGVwbG95OiBkaXNhYmxl
DQo+ICAgIGFsbG93X2ZhaWx1cmU6IHRydWUNCj4gIA0KPiArLnRlc3QtY2lwLWNvcmU6DQo+ICsg
IHN0YWdlOiB0ZXN0DQo+ICsgIG5lZWRzOiANCj4gK1siYnVpbGQ6cWVtdS1hbWQ2NC1iYXNlIiwi
YnVpbGQ6cWVtdS1hcm02NC1iYXNlIiwiYnVpbGQ6cWVtdS1hcm0tYmFzZQ0KPiArIl0NCj4gKyAg
dGFnczoNCj4gKyAgICAtIGxhcmdlDQoNCkNvbmNlcHR1YWxseSwgd2Ugc2hvdWxkIG5vdCBuZWVk
IGxhcmdlIHJ1bm5lcnMgZm9yIHRoZXNlIGpvYnMuIERvIHdlIG5lZWQgdGhhdCBmb3Igb3RoZXIg
cmVhc29ucy4NCg0KPiArICBhbGxvd19mYWlsdXJlOiB0cnVlDQoNCldoeT8NCg0KPiArICBhcnRp
ZmFjdHM6DQo+ICsgICAgbmFtZTogIiRDSV9KT0JfTkFNRSINCj4gKyAgICB3aGVuOiBhbHdheXMN
Cj4gKyAgICBleHBpcmVfaW46IDEgZGF5DQo+ICsgICAgcGF0aHM6DQo+ICsgICAgICAtIHJlc3Vs
dHMNCj4gKyAgICByZXBvcnRzOg0KPiArICAgICAganVuaXQ6IHJlc3VsdHMvcmVzdWx0cyoueG1s
DQo+ICsNCj4gK3Rlc3QtcWVtdS1zZWN1cmUtYm9vdDoNCj4gKyAgZXh0ZW5kczoNCj4gKyAgICAt
IC50ZXN0LWNpcC1jb3JlDQo+ICsgIHNjcmlwdDoNCj4gKyAgICAtIHNjcmlwdHMvc3VibWl0X2xh
dmEuc2ggc2VjdXJlLWJvb3QgJHtDSV9DT01NSVRfU0hBfSAke3JlbGVhc2V9DQo+ICsNCj4gK3Rl
c3QtcWVtdS1zd3VwZGF0ZToNCj4gKyAgZXh0ZW5kczoNCj4gKyAgICAtIC50ZXN0LWNpcC1jb3Jl
DQo+ICsgIHNjcmlwdDoNCj4gKyAgICAtIHNjcmlwdHMvc3VibWl0X2xhdmEuc2ggc3d1cGRhdGUg
JHtDSV9DT01NSVRfU0hBfSAke3JlbGVhc2V9DQo+ICsNCj4gK3Rlc3QtcWVtdS1JRUM6DQo+ICsg
IGV4dGVuZHM6DQo+ICsgICAtIC50ZXN0LWNpcC1jb3JlDQo+ICsgIHNjcmlwdDoNCj4gKyAgICAt
IHNjcmlwdHMvc3VibWl0X2xhdmEuc2ggSUVDICR7Q0lfQ09NTUlUX1NIQX0gJHtyZWxlYXNlfQ0K
PiArDQo+ICBjdmUtY2hlY2tzOg0KPiAgICBzdGFnZTogY3ZlLWNoZWNrDQo+ICAgIG5lZWRzOiBb
XQ0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50
ZXINCg==


