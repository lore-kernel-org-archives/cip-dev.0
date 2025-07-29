Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395AAC83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 00:21:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.1407.1753748451111170982
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 17:20:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=ZlTqO43c;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1753748434;x=1754958034;bh=qokS4/IR/2qVps9dyH6J3HyzlS8eaN7JDmWwg8w
	QdH4=;b=ZlTqO43c8aYgRjikS6S9HkgIOq8snbrla5TIrzY8TeChQEuZXmq20lPWGwVL0kVj3pjsX
	6YmFjvmwtwHdAvRzowVNY141UFeGjFZdJQT2CuiFXJxrgE2g1GfHr4MuwPk4VdvHo9ydzDfRKDHDv
	0NeSI5I5OVID3tqgI/efrtgF4rrPuCPy3W/Qdc/2YucnwdDJN9yEmlewE3QCSvSDK34+wUxu++0X8
	sWfGgYrmW1Rvwul5ms0Pc7v2puzrqLN6PhTeXnTUCn5CXhgcKFjlzwTkxa5EjXLyhIy7aE3iUleP9
	ALd7sF9X/ho39hj1B9ZfhT0BofbODbu7Sq7tJMLejA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 56T0KX1X2766794; Tue, 29 Jul 2025 09:20:33 +0900
X-Iguazu-Qid: 2yAbpfLvJv5eCsWaoD
X-Iguazu-QSIG: v=2; s=0; t=1753748431; q=2yAbpfLvJv5eCsWaoD; m=+z7QOx5gk728Zsp+IAeL17Y/EgD356fTNt9/7S9td4o=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 56T0KURq817705
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 09:20:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKT05oxvPqyMSgcW4074Lb9t6hTA2woTmL8rgNr+4V09c8GoufxnZvwJxVlz7Dr2NTqszrCwn7u3pCqsV6vPRpe0fi61gUSkOJxjYKMFL1wH8rsBCdkmL8gnOV0fHs62/57Tz9Q7d6oYMDDviGCZr9zD7pR0KmT1nhXXV3/sLFxoTv6LzEnDl+E4PaNAoQeNoH8QzZgFjwwGyi54oo6DjS+3X9s58OwMlvy6rHYuOIv/Msx7eTYuANCWBEBo1IB2iqSSEaPCkqm1D5j0V7h+YLcFQCctj8yzhfJBQ1B5EKpAryTFQp2ZBt7kNf0tygyQS6Hvi+l/vGrNoWu1s2iajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVcBKiExqDx2jGRjm21QDwdInRXAdZPppfIGyEKFXko=;
 b=K8x2zqS1oBmNPCwxJReEkOMgbJTd3dJ9VfywWPGVy5BBD5CyazxA8vrndvsTqLCWZNsnIsE5YzrVzUzWAjIbhVVczjQuVR2QmDAYfrifl+IJQUmdawD9tBSqueoILxPqOQ8t12Fk7IEwfEjzWKYXv4RmFoIulqk70JPoOT7VMhD3Gvx800QynUxIi8/mAPSykHC8iC5DzVq2EMSApYOz+fjhAOdp3KINaaboNrXFZTBmG7B7zTzdSR1hK2Eih4Pf99pScbC95hq39tC/SLY6t2LuUOdZBa8hTlUhY1HWJI735/+R9+WzbEHLLq7c6JmUpme4/sS0mRo/rtpFFoFKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
 Add I2C2 and PMIC support
Thread-Topic: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
 Add I2C2 and PMIC support
Thread-Index: AQHb/8ZoEyzJxO3hJkunaTPNgpRNOLRIOndQ
Date: Tue, 29 Jul 2025 00:20:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D9C76A97479F7BF1997E9225A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8612:EE_
x-ms-office365-filtering-correlation-id: 0c82ab21-f8e2-408b-caa4-08ddce35b674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cEQ0YkEwTkpXbldXdEljOWdBek5uZHFFVXZ3cy9Kckk3UXVsc3Q1c1FO?=
 =?iso-2022-jp?B?NlBGTi9qclRQSEFvVnMvVng5YkIxRmdmQzZ2eUhMVjloc2VkN1RjcE1J?=
 =?iso-2022-jp?B?SVpYenlxc3RvaUszbThsYXVCR3MwNVp2S3k3VUdBcXU3Z2MzSGg2TklH?=
 =?iso-2022-jp?B?OVNxSFYrK0s0K2t2Y24xU0FrZDkvdnFhUHpQcGFUWGNYMWszVDN6Wml2?=
 =?iso-2022-jp?B?dTE4bVpNL0xud2JzT0VLOTd3YU52RFNiVEc0NUNXTGNTSGhpZjdLbDNH?=
 =?iso-2022-jp?B?ZHZrd0I4RVlFVzZLd2I2SlhCTGFiaXRaZitwKzlTczVLQXRJWFVIUGxm?=
 =?iso-2022-jp?B?ZVJROGZwbkR0T2RRY0s1VWxuTXRPV0RhNG1JWXdRY0hFQ2ZjMEl2YWFT?=
 =?iso-2022-jp?B?dm1YdzBCSkVwd3c5emdtcmJkRDJaRjJYc1pZMFQyYVVTL05oOUVqaG1y?=
 =?iso-2022-jp?B?S3pLLzhWTGZZVWY4eXE4M0ZlTmI2dnBPKzdybXM5NnErUnc3RlJackhk?=
 =?iso-2022-jp?B?a2wxNE0vbWZLV2I1K1dkMXhLSHQybis0WDhDWW9vQk4rNEt4QVM2dTBz?=
 =?iso-2022-jp?B?SU1xSFo1RTZmK2phZDU5YnIyYnFzV3BpL21VTG51RGVyYXdoOExZUmZG?=
 =?iso-2022-jp?B?cjhiQkJSVk5lTi90SDNxTDAwcDBrNmswVGx6azZsVUNseWtqODJEWGp0?=
 =?iso-2022-jp?B?ZEl2TTlyTlFUUExwZW5HUWljRkxCR0swRXFTeXFyY0U5cG9mcnlVZXNY?=
 =?iso-2022-jp?B?aFBWWm5tdVliTi94Ym5kd0tQdzZoSTVORE5aazhGY3VkcGVxQm8wYmFU?=
 =?iso-2022-jp?B?bUp4cm9zY1VBYllFbDdVR0tERU9lUDVmUTRFNUtoUzRib0hwOVJydjNH?=
 =?iso-2022-jp?B?OWErODl1bUh4UTY2SkwyMk5nYXE0ckdHSUZmTzBDb0Z3RTA2YmZOT01O?=
 =?iso-2022-jp?B?RnB5MFFoeXdOTGRwRnR3cllKRGJwa292RnRhVDdPcWNvZWFmVndPdDht?=
 =?iso-2022-jp?B?VnBPdWs3ZWJaSE1rV1ErRU5EbVo1bkdrV1Ztc3JUTUU1YS85bDlEVGJE?=
 =?iso-2022-jp?B?NEhic09SbW51WVB2S2EvL0FFang4cnVrSHk2aVNDQnlia3NCM0lCTkQ1?=
 =?iso-2022-jp?B?ZlNtWWRqZTBEWk5VeThOR1NHNGNvT0ZaeGV4WmFxSHp4bjZ4elA2akpW?=
 =?iso-2022-jp?B?RklnRnVBNW02R3VuQ0JjZUVFVVUrN0xVelEraDNzcjdKS045YkozT1Ur?=
 =?iso-2022-jp?B?VXV6ZGdBVUIxYytPLzF0V2U3dEhlZDl3QTdXSVZSWXUrVk9YWnJvZ2h0?=
 =?iso-2022-jp?B?TUZlNm9YTzd4RDFUWjBoNE5iMlRaNVI0b1J5bzZiOCtNeXdGTTVNTkkr?=
 =?iso-2022-jp?B?SnBIYW9ieHRvalZXUjhoVlJseWNiMk1taVRyWlhWcjNpUkgwdXkyTmxL?=
 =?iso-2022-jp?B?aGpzd0gyNWp4RFlLb25UOGhwcklZbExQU0ZSaTdVeUZ4OVJ3Z2haOEhV?=
 =?iso-2022-jp?B?L0x1MGp5cjNkNEVyNk4yZlNzbEIxYk51YjdLR0FLdy9EaEVrNG4zclp4?=
 =?iso-2022-jp?B?YmYxa0Y0bzZzenZiaWNVdGRPditxMUlNZjBncjcyNDVxck4xSDI2Y3ds?=
 =?iso-2022-jp?B?N0RXWmhwVHVVZ3RYamRKVndBaytnWElBU0lySHdhdFBqRVF1Y0dPcFhv?=
 =?iso-2022-jp?B?YnozZnhvUTdQdmpEUmJCK1BPNkdTSGdXRFU0em1WREhycnJOMG92TWxr?=
 =?iso-2022-jp?B?bzlDdm92aTR5bW14aXpaeGdDTWt0ckx0Y2pYdFpWV3VWdWhsUnhoeitx?=
 =?iso-2022-jp?B?bnFEK2F3VnBiUU9KZmc3dFlWSWxFb0R5YkZHN0N5M0l5OTRHN08rUzBn?=
 =?iso-2022-jp?B?QjNzdnlFL2t2WU5VZ1N0NjlTVDh5Y05CSjY4NEVOS24reG1LV2FZdU0r?=
 =?iso-2022-jp?B?MnNIRkdYK1g3WkRaN2VLRGNhMkQwSmc2NGF3bmZwb0pzVXFtb0l1VkE0?=
 =?iso-2022-jp?B?ZHhFMG96WGdXNXhjczd0MXU3ZUN4c01OUVBDTTkrczZ1bmM1RWdsRC9V?=
 =?iso-2022-jp?B?dW9RSU1TcVIwV0dsa2tmdkh0d1BocXRtLytxa1hQTVBPVEZ3UGwwN3Jt?=
 =?iso-2022-jp?B?NEhnbnFjSnNySXkxVnRqNlpxM1JrcFJFVWt1OWx1YXVTRklHdlJBdXVk?=
 =?iso-2022-jp?B?blJjPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RkMxdjQ1WnE1b0E3ZUpzQzI3WlFGUFlkTDRjRXUxTy9sZ2s5blp0OXFh?=
 =?iso-2022-jp?B?Zzl4OE5RZmd4VWMxa25IbkFxV24rSUlmblJWUE10OHpaaEtGZEJ1YlMw?=
 =?iso-2022-jp?B?ZStrN2h3SDNaR2U4Zy9aVFBkWTZ1bDlyT25QY1lxTzRBZU85MndaWVZi?=
 =?iso-2022-jp?B?bW9XZWtIMkRYTi96b0Mrb1ZDSm85V1FaMmJCOHBCVFVRbGRRbUtmUUh2?=
 =?iso-2022-jp?B?b3dlZmZlbk5jR25sRG9Ieit0MDNwY1RuNjJlOWRZYlNqdnZXSWlIdThD?=
 =?iso-2022-jp?B?c05BYWN0VVVwSld3eXcrc3JRMHFxRUUveXY0dTQ1NmxpQjQ1NmVGa2Vr?=
 =?iso-2022-jp?B?c0hodkxIL2N0Q09kbUFWUzM2TXhIZHcwUGZQREd2Z04xejYrWjBadTZN?=
 =?iso-2022-jp?B?ckZlM3QvaDVyelkxYU1FazN4dXFpN2s3UVJtZjZ0T1JWZUVqclg1M01B?=
 =?iso-2022-jp?B?YXVuWUM4Vy9HTFhCSnZERHRsUW1SVCtzQWFzQmRTaGsrSHoxWFI1V1RT?=
 =?iso-2022-jp?B?ZGpSYnRaaDFWeUpEbWphY2d1MXdBZStSbW82TDRmSDgzakc0R0ZScXp2?=
 =?iso-2022-jp?B?Nm56L0lPZ2dUS2RKRFQrWWRDQXJoZ2ppSDV3cTN2dm05U2xuVmdVdWNG?=
 =?iso-2022-jp?B?N2lSNmoxU0crR3h2T01hTVZic25reWFaSERPUzJPc0tRRkQyU0FWVTM2?=
 =?iso-2022-jp?B?alZuVFlDSWxUdlZmYjJpRzlPR0V1OXhEQTZrM0ErMjB3TWxzZmowWElq?=
 =?iso-2022-jp?B?MUVYY08yWjJ2c3hsZkFibHJjTTZoODljUjJmamZtM29aQkllWDNZby9F?=
 =?iso-2022-jp?B?VkFObmVFK2N1dmFaLzlaeTJ2eUFnRkJzSVhiOUZGNm0wbXZTNXFBMzBW?=
 =?iso-2022-jp?B?QUw2b1V5dWJZd21ZZEFSTlhCZnI0MHMvSndlb2xJL1ZiSWZUaHFhKzFl?=
 =?iso-2022-jp?B?d2pMbHJ5bDFMWi82S1A0aURHZitZbG92S0lySVdIY3d5WC85c1k2ZER4?=
 =?iso-2022-jp?B?Z2VPRUxQbmtjSEhuMzkwRVc3dTRBeFd6VERCamVZbis0WFNOaGhaVmk3?=
 =?iso-2022-jp?B?bEJvMlc4elA5WFJ2c2s5TVZ3cm5vQTZuR3kyV3ZEdW5JeE95RXRYOUpF?=
 =?iso-2022-jp?B?Ly9JdjNEV1R0MERYU0hjVVRLKzJoRFBRUjM2WnRkRGpMUEhmNmZVaGpK?=
 =?iso-2022-jp?B?SXpvVVdPWGtKWUJvMGUvdXdOWHYrT3I0V2dweVB1MUNpTjM5NEZwNzhB?=
 =?iso-2022-jp?B?bjA4WnBTS0xzb0NqdW9DR3VKd0QyMGZ2R3JCdEJycFM3bEpjTVFXeXNs?=
 =?iso-2022-jp?B?aHN0U1hEY1N6VWhIQWEwWjRwdTh1MTY0Q0grb0V1UjVpTGV5U1dMWGNI?=
 =?iso-2022-jp?B?c1dnNm1SRVdHU0VGZ0Y2OENweEtHU0ovK29nQiswRnlQeW9Eai93MS9H?=
 =?iso-2022-jp?B?TS8xa3ZKOEJaR0I4UnNwTmNKUjlzdTRwWHdaU2RmVC85N1B2M1FXUjFQ?=
 =?iso-2022-jp?B?Y0kvSUphMW1VU0dLb0I4M3g3QldGbjREWWdxenhjWm91MjM3bm1GZmhh?=
 =?iso-2022-jp?B?VnpNYXpLeXZ4YXd1L1ppaVpNSXcrT1pITmdlSkowdnp1YlR5SlRXc1Z2?=
 =?iso-2022-jp?B?clp2Q0xGL2RSQjQxVjk0WnZocW1oT3BjNEY3Z3JHMTV4S1VZZ2ZxcGVY?=
 =?iso-2022-jp?B?eFVZY3dOWGYyeVlnbHNTZWFWMUhwMGJhcnlUL0Jxc2V6WWtySGxrUXRj?=
 =?iso-2022-jp?B?M2RJb0Qxc0ljTjdJemd0YXNBMWozMVFBVzJnN3JtRm4rRVdmVlFqbE5h?=
 =?iso-2022-jp?B?TnhWVnBkSXNEOXhMa3ZCZXJYWml2QnBCU0tHbDVuWis4SWM1bFRDUTk4?=
 =?iso-2022-jp?B?cE9PTU5MN1hCUzBUcEh2MEZFL2lrbjlTZTU2VGpja0tydmwwcVlYMnJT?=
 =?iso-2022-jp?B?OWV0RDJnamwxYXdMbUFzN1ltTkM3ek80SzlHVWVsZFFQcUJGZmNRRVN3?=
 =?iso-2022-jp?B?OVNocnB3cUdKbkI3TFFrdElHVHR1OVlzMFovbHZJTlVmMDcwY2J2cmdR?=
 =?iso-2022-jp?B?SzZkc0w2ZGRNYnJTS1AxWTZNMU10NFFhY3lZTkZBUjdiekc2Zm45Yy9m?=
 =?iso-2022-jp?B?V0dhWjQ2MGZad2hRUTd4K1NhVTdjQWp0R0ZYVXJURzBJMElGQ091YkZI?=
 =?iso-2022-jp?B?OVZ6amNwNWZENXpRYnNrSXBtRmNUTzkwdHZZQjVxWW9xT0crS01SaVE0?=
 =?iso-2022-jp?B?eFpWU3lNYnFDT1F4U1F1Z2ZyMWthekFWcDBHVmUxSGtBMmRTTFhTRFdR?=
 =?iso-2022-jp?B?dkZvTUR2Rm5WYjhSWlQyNmkyaVdFV1R0dlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c82ab21-f8e2-408b-caa4-08ddce35b674
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 00:20:24.5598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7KPVHjWaEBKyioTlPwpc3VrYYlSI5eTDB63P2oF7dHaANU6CeIilss4uDq2JZ3Xo5WB4hVq9M/dJz9gZF9L3Kb7+h8gY1WrJ9Tk/qqBi6hjr/EYmZZS+o2nPS6K73xf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8612
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Jul 2025 00:21:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19610

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Monday, July 28, 2025 10:49 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
> Add I2C2 and PMIC support
>=20
> Dear All,
>=20
> This patch series adds support for the Renesas RAA215300 PMIC into linux
> 6.12.y-cip kernel, on the RZ/G3E SMARC EVK board.
>=20
> To enable PMIC communication, the I2C2 pinctrl configuration is added fir=
st,
> followed by the RAA215300 node.
>=20
> Thanks & Regard,
> Tommaso
>=20
> John Madieu (2):
>   arm64: dts: renesas: rzg3e-smarc-som: Add I2C2 device pincontrol
>   arm64: dts: renesas: rzg3e-smarc-som: Add RAA215300 pmic support
>=20
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 38
> +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20

I reviewed this series, looks good to me.
I can apply, if there are no other comments and test was OK.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/195352898=
4

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


