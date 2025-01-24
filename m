Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC77C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 05:57:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.5564.1737698214445637275
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 21:56:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=cXrZF8Nu;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1737698201;x=1738907801;bh=tGqbm+jGv+JTvNMn//UxhtlJ6vDTn2x0kQ8NlD6
	jhro=;b=cXrZF8Nu9zKA0QgfV+Vjx08ySPY8FTdYXLSux2AfUpNb3akhRzPcR4Oo6gnM5JVlo3D1V
	DCiv7s/VUpf+32AVkGU8BpoVEFGopNbcoT4T+8GxYYP2W6zXmtg96L25ikv+g6RtBvWaHnG+FJUdp
	JzhrDupeuzB2qdxUCSvEzXX7OLDFnzFtQi8bV9xJ4rdZ9HRAr2VPtU8nfjnhmKaE2c21e/8MvIacI
	ub008q3rpwQf1S/AyT4uphN5l4GqbLxpNu70xiB4cMMWlca8kTOV9U9+7C3zmA4lQ0HGbhzkBpdEp
	GLJjAFBPWixuBfnmmWu0eAZ2lLmr8JfZFtANvqhAog==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 50O5ueIx814575; Fri, 24 Jan 2025 14:56:40 +0900
X-Iguazu-Qid: 2yAbyr8UnTJICYjM62
X-Iguazu-QSIG: v=2; s=0; t=1737698200; q=2yAbyr8UnTJICYjM62; m=3Y2tJXL2rvk45E77G+aNVQzaDEUkA7YMogoYkmOyW/I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 50O5udX53668958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 14:56:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+1xbVJTvKSHCxi0KpNcjVzYw/nFeeV59+iDQYAYMInB4US8XNrMvz0SEwXVhI+YD/HyeilkJmfNTYEIdrH+Djt5ZsV1xQLVXNp8koC78wMmAlcz1WR8mPS3Mg7awZqxN+GPo2XQf+pmKc/NGjiCHp+dsswx9LK6WpzSNQHpJ96PcGrFKT8AO53BluEQkwCbWk/HBXe6QxtVTD5SwKxv0ns5fGEgbZnF7vF6sOfgwpG6YE2Ej81dKmGWklQYrJxiBM4J2jVa+Ome0dXxIL7EUBI0z6vIAB+pr4G1OF32vAV6a+5TyGIkdJV6HHs6jfVN0GzcUv6nQQIXuDkpp70tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGqbm+jGv+JTvNMn//UxhtlJ6vDTn2x0kQ8NlD6jhro=;
 b=cTWOS1p7jLdcXquiF8GbgUVXFVZlKTEXvQY2KJp4dUVvtVSrd07LvaUkUScU8eYi3NOpMOpMhKAewQl6WVM+1wEqi8wWQEwqy6I03bSYTxWYvVABF5WIHAe3nQC2UPvNGC5IqWFes7BdtlNFqEXOfQyTGjVwyl8a1iUvfKyN7uvFAFXMKMkSLl9vyCraAEraW6t1zijZrPVKkmvvkaPcrvjckPk8uob0kXfa/fq74M6q/le+MsVHVkavbUBJUrZ4tf++2o751x0RrBWrNoKD8Xzo/Quunm+FNirEqVjTHVLo7RI+qgLxMDLHLt3Cu2z8OUGvREcc23GgBvVIpBH7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [cip-dev] [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the
 RTC support
Thread-Topic: [cip-dev] [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the
 RTC support
Thread-Index: AQHbbMP8OupQwieLgU2sP4S6iBS7IrMj2K3AgABzEACAASFFwA==
Date: Fri, 24 Jan 2025 05:56:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388D3CC612EC167DE317C6E92E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB6388E136F89EFE42C5D4D43C92E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <9a4bf2e6-2b5c-4e33-b8b7-98756f544895@tuxon.dev>
In-Reply-To: <9a4bf2e6-2b5c-4e33-b8b7-98756f544895@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS9PR01MB13148:EE_
x-ms-office365-filtering-correlation-id: e504ac4c-cc22-4712-3b2f-08dd3c3bdd14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bnErd1Q2bnpOcThRdktOczJIc2RuMGdXWSt5aWlxYW9VKzNzYXZ0TEpYbnR0?=
 =?utf-8?B?Q3pQNENzRThxWmttaEtoTVVmcWxmQlpoVjNkTXZzMy9kT1ZqTlNwbDRraXFk?=
 =?utf-8?B?MVRNRnR3SS9GWTZuQlV6MGdoOENnaXZQZlA0eHFjZUoyZTJFeWp6cFAwUE9T?=
 =?utf-8?B?ViszYzlYV1BuQnc3eUNMOVV3c0QwTU4yVVhUYS81c001TElQU216YjdZZFBP?=
 =?utf-8?B?dDlpQk1ScklURkFQNjNIWThLMVhnS01aYkVKWU41RWh1eE1oKzc0WXRDbGRl?=
 =?utf-8?B?NmZkbVIzcjV6KzZxa1ZEbG9ScTE3UTRGOWJxM1J6eEU4QkRJMWZodG9INjI5?=
 =?utf-8?B?S3NERVZzRXEyRCtVVE9RcjhhOFVNL0UvcWZVcFZUTEllNitVVDZxemtHbTU3?=
 =?utf-8?B?MTFXRXE5WC9oK0htN0tDM1FRdWtWaUh4UC8yUG9BaWt0MlFOZzQ5YzJ3RVU1?=
 =?utf-8?B?aUE5bW93Wjl2dTdreHlKS05SUDlvQUZDbVo3RkMvRjdaQ0h4T2MrZEFrVnB2?=
 =?utf-8?B?T1hmT2MvZmVMdDAyVFNmaXNRcEQwaFgyM3lJTFhOM0YvSXk2SStzQ1dsUndj?=
 =?utf-8?B?RUhJODZ6aG1LSllXVVN6Mkx1NDVua29oNDBHV2wvK0NBRUMraDlmK1ZsU0ky?=
 =?utf-8?B?T1ZDWWhwSDRKaXZ5a29JUjdScGsyMXlMZ2ZnQ1RTNmdJNElyeWxUc0l6VFgz?=
 =?utf-8?B?NXNxZ2VpN0ZFTHhnZEg3V29ja0lhb1dsQklQcjE4b1RXZUpyaDNPbm43Vkdr?=
 =?utf-8?B?WlNOSnRrN2dEZEhIdW5NTUJ5cGlpeWdwbmcwRU9qcmxGeUxaemtsWXVEWDlv?=
 =?utf-8?B?NVhWdjRvc1p3U1VLVkNRUWVia1NCV1Bpd2pzc0RaOVJ3NXR5dFpvbzB5N2RR?=
 =?utf-8?B?UEx6NXFRY3d2SnBUQ0hqMHVsVkU5WVJZRm9Xa3NLbGdsMzhhR1N4UjRqZ285?=
 =?utf-8?B?U2kwbm1VZ01qZ2NRbkxhM1o0RU4xUG90NWhURXFnYkpOZjZiMGNPQXltc2VN?=
 =?utf-8?B?WGFucnRrQzNrNzRCN3c4cnBOTDRHUHFzTFk1L2xXMERZK3d2VHYvazlVVUdH?=
 =?utf-8?B?aSttZ2o1eUxNdlVGeTlmQ2NDU0xLZEg1TEl1TlpwS2ZkYUxoQkRYQk9aMGpr?=
 =?utf-8?B?a0tBdDJQZDY0V09ISVBIaXJERFN4MCtPYkh3bHBpMEZka2FqR0VjRVMxbWNQ?=
 =?utf-8?B?UzdXdXFwT1I2bHBpV2oxOG1acFJnOXFGRDRwL3FYSmNvNUw2QWVnajdLeDdI?=
 =?utf-8?B?dDFwcS9xbWhpVTlmQTBuWVVlWTJLU2dzUkRxVWh1bWhwbGtSQ0Iwc3E3c1Vi?=
 =?utf-8?B?OUlvbnZGaW5yZ0ZYUVZCb20wR3dPWnlrQlY0QXczKzFmTVd2cmhsVG5PQnZH?=
 =?utf-8?B?YWk3OVpyUTloRjNJeFBhT1d2VlZJV2svU1hJcDBWWm9wZ2dBVXRmS1dmWE1J?=
 =?utf-8?B?UndDMlQ2WmpUS3owT1o5THNpdHdWUngyUEdubnhwN2U0Tk9ZMmUxVFc3OEt3?=
 =?utf-8?B?V1NMNFZKdXFRZGFkK0xUcW1BYUx1RXZVbHBFV3hMdEQzNVRuQXNkS1FoM3ZO?=
 =?utf-8?B?T2c5WmxjUVV3R203U1NMaklkdGZhNmhkdytKYkttNEpSMURqY01OUzl0WE5w?=
 =?utf-8?B?QThaNTdXYktRVXZ4U2lBWjUrOVZiT2FRdlFyZE5kUmhVMHRMdmlYSFBZanFp?=
 =?utf-8?B?bDdQb0xkSGdiYUxUc2theFFEQmNMcnRQcm1zT2ZZSVFuK3JQaWlZVFh6Rnkx?=
 =?utf-8?B?Y0RKc1EwejF1dU56ZkROR2hYTytIb0FmRXhOeEJiMTN4TW1mRGdzU1RaVzhB?=
 =?utf-8?B?b0dJVGh5QVRYN0JkMW1aRlZSVkhaaS93VmpxbWkyUXlwaGxnWDQ1R3hYa3ZZ?=
 =?utf-8?B?ZTU3aE9yeFBoOUg5VzBZZm5rejdENkJnYWNjOEV0am9VZVFZMGVTVHJBaHJN?=
 =?utf-8?Q?ZV54F7EyLvH7ysAnUGjeWJfGrRrlv6FU?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L21kRXVROXZ4ang1SWgvMnJZbGZmOVVVZnVLcC9rRnc2MXFIL0dWUEFBTmg3?=
 =?utf-8?B?Q0dnYTZEdytPQ09yWGovbCtmTk56RWk0SGhIQXNRVWI5YW1LRTZpaDc0SHdr?=
 =?utf-8?B?WUI5UHgxcFY5anBkL0J4em14V1hYSzVEQ29RTjZxb2psMVlFeHF2bDFxOEJ5?=
 =?utf-8?B?dnYxQm13UmYyTmhVbG9MM3FMTkYwWHlEKzg0SXNzUUNocWNKZU8zTkhlY25D?=
 =?utf-8?B?RzFONGRzVHd3emlieWJTdkU1bU1lajZ1UVI3T0l6TTl2T0tLcFljVEpGbVUx?=
 =?utf-8?B?S1NhdUw5ek1ERFU1cytKSVBxQVBJc2hsdWFWWTN1b2lGRU9MZG9DVFJFd1l3?=
 =?utf-8?B?SUZKYlpSVmpIZ01IRU0vQnIrYnhlKzMrRE1JYnZXSm1MTlBPaU9TSTdsV3BI?=
 =?utf-8?B?blVueTc1ZEdOQk1oN2xZaHFocmlkNVYxZXZTdS9tTTNQMThpVkE3N3YzKzMx?=
 =?utf-8?B?VkhTRDBCMS9YR0dKOWZRSS9JODFjT2RhZy95YkQ4YnAzM1dYR2dVUENBQlNS?=
 =?utf-8?B?WTJqRHUwc01WOE5tckNpd2lNT1QxUm0yZWt6WnZiU1VuYlI1VTA3Ylc5aU1K?=
 =?utf-8?B?c2kxaE5JMWNHQ2UvUUU5MjNydlR6T2NDcW1jd2xzbnI5a3dqUm9FWTVRTWR0?=
 =?utf-8?B?V0dKQStuY25mYUorVjdKZFdWcWRZdmQyaFJaQVA3NTZYQ1RlL1VEeFdyZlZL?=
 =?utf-8?B?YjFzYW9uQktWYjEvZkhWaG9nc0pwRkRiaDFqVThMVjVYend6SVg0SHVFeUQ5?=
 =?utf-8?B?UEN4U1FuL3o0RWFQS0twZlpaT05JakVvSW5IM2VzVTIrc1NxdE5yKzJ2Ni90?=
 =?utf-8?B?SGJPdnZ5V2xxajk2QUU1U1lVY3ZDK0FrcnY4aUZoSnVKS3pFUk9ucVovdkQ5?=
 =?utf-8?B?MnpnOEhQUDNwK1hYdGkxdlJIRGNrY24xQnhEaEpseTFPQmNpNVhGUkxWWUsv?=
 =?utf-8?B?YTJVMEpEUXZXU3lhMkdGcTVxYTFmR09FSlMwVkhqVTErRU9sbzJqektPc0pW?=
 =?utf-8?B?Zkg1Y2tVbVpPeTdlclhrYW5OOGw1NW53NWtWOWRvM21ncjVNUCtFZG1YSkVk?=
 =?utf-8?B?Q2g0d3RVQ1RIOFNja3o4QUZia0VVOFFEdkdRd2dDTkJUdW53Vjl3bUl3dmNU?=
 =?utf-8?B?WWNNSWdCbi83eEpGR1pwbCtPM2NFc0h1V1ppblhqbFBZb1I1VUVQTElwSlBl?=
 =?utf-8?B?UElkSzB0eGg1UlRsVVNodHNhSWRJMWtLc3ArWEtpZEJqOG9tMGFMZUsxaFFT?=
 =?utf-8?B?WkNhRU8xcUVxcVloem9pcVNwaEJNQkFkM1NBcXJYZldhQUFGVGFFR1R3TmQy?=
 =?utf-8?B?cGp1SmlaUjFvSzdtdVRjdlRNOUpMRkVsaXRQSlU4NWJiWW83YUNiUmxMK05C?=
 =?utf-8?B?M2QvWmk5Q0p1OTFtUURBeUFlVXJxcWdld3pSVnNjN2lYS2FURGlVNmt3ekha?=
 =?utf-8?B?VUFYVmVOSHpPdTNleStLMjdTYkxmQmlDZ3dZaUhnS2Qwa2VNK3V6Rkx4OFVO?=
 =?utf-8?B?MTkyRlN0QzVjWE01Y0k1b3BGcE9zS3ZLREVDdzJKTzV2VmxtU1FWSjZBbEUr?=
 =?utf-8?B?N1hkRHFJOUNIVHg0UFRJQkZneU9HekVjWStxL21oYVN4NFN5M1Z3L3VOcjA4?=
 =?utf-8?B?bERqVXlGN1FLaml3STVpaWw3VU1DL2ZxLzVoc2tlUEJkRHZTczdJZEx0b3pV?=
 =?utf-8?B?L1dENE0vZys0UlhaZmJLclRxZjMrblUwcXIvbmJGR1p5Ni9zd3VQRldQejFR?=
 =?utf-8?B?K2xKdmQ2REpCTDRjQTlIWHpQeS9JcGRSMEpISTVLa05CWFR0bkRkeWx1ZVlx?=
 =?utf-8?B?RXhVV1B5MVBmV2RaYzdRZjhvZ09UTVdqQVdpc0RYcFh0YXZZNjZYS0dITVB0?=
 =?utf-8?B?YjNKdk95eTl2Q21NU0NmdndvVHVMeEYxeTVGam82N09KaHdxY2I3UGs1MmpW?=
 =?utf-8?B?SWJLYVJPLzNWSExoZ3pMOGwrb2pSV3I3WTdIaVZ3OWZMK09rcE55dTlvWUJH?=
 =?utf-8?B?aWNIeUJzS2xWTHFXQUxoRTA3ZFpYWjZFYnRKcCt5bHlnVkZvclJoTVE4T1Vn?=
 =?utf-8?B?Z0dsTUdOVGRuV2pWMEt2ODNaN3ZJcjdMcVVWWGU4eDY4WDZDTHEzZjJkYkNQ?=
 =?utf-8?B?ODFycmR0Y2dCeE1KS0RRMDZsWGRjV3pLenFiNUJVc2FOTCtySjBGSXEvanRa?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e504ac4c-cc22-4712-3b2f-08dd3c3bdd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 05:56:36.6029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgKRpRjDXRikd48SLigCWxivmH7MmdIEKINV+nKIPzEfK7k45yJjGSGvB0aD1yHzJAV/IPkOX1B9MB/j2zk3Q/DFjIMTMZKJydn/QkRbznFBeNVNuVGi/w8/0VnjPRhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13148
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 05:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17612

SGkgQ2xhdWRpdSwNCg0KPiA+IEkgcmV2aWV3ZWQgdGhpcyBhbmQgZm9yIDUuMTAueS1jaXAgc2Vy
aWVzLCBMR1RNLg0KPiA+IEJ1dCByZWdhcmRpbmcgImNsazogQWRkIFN1bnBsdXMgU1A3MDIxIGNs
b2NrIGRyaXZlciIsIGFzIEkgY29tbWVudGVkLCBJDQo+IHRoaW5rIHdlIHNob3VsZCBjb25zaWRl
ciBpdC4NCj4gDQo+IEZvciB2NS4xMC55LWNpcCBvbmx5OiB0aGlzIGRyaXZlciBpcyBzZWxlY3Rl
ZCBieSBBUk0vU1VOUExVUyBTUDcwMjEgU09DLg0KPiBUaGVyZSBpcyBubyBTVU5QTFVTIFNQNzAy
MSBTb0Mgc3VwcG9ydCBpbiB2NS4xMC4gV2l0aCB0aGlzLCBkbyB5b3Ugd2FudCBtZQ0KPiB0byBi
YWNrcG9ydCB0aGUgZnVsbCBwYXRjaCAoYWxvbmcgd2l0aCB0aGUgZml4ZXMgeW91IG1lbnRpb25l
ZCkgYXMgd2VsbD8NCg0KSSBkaWRuJ3QgY2hlY2sgNS4xMC55LiBUaGFuayB5b3UgZm9yIGNoZWNr
aW5nLg0KSWYgeW91IHdhbnQgdG8gbWFuYWdlIHRoZSBzYW1lIHBhdGNoIGZvciA2LjEueS1jaXAg
YW5kIDUuMTAueS1jaXAsIFBhdmVsJ3Mgc3VnZ2VzdGlvbiBzZWVtcyBnb29kLg0KV291bGQgeW91
IGNvbnNpZGVyIHRoaXM/DQoNClBhdmVs4oCZcyBjb21tZW50Og0KICBUaGF0IHdvdWxkIGJlIG9u
ZSBvcHRpb24uIEFub3RoZXIgd291bGQgYmUgdG8gYXBwbHkganVzdCB0aGUNCiAgaW5jbHVkZS9s
aW51eC9jbGstcHJvdmlkZXIuaCB3aXRoIGRpZmZlcmVudCB0aXRsZS9jaGFuZ2Vsb2csDQogIGV4
cGxhaW5pbmcgdGhpcyBhZGRzIG9ubHkgZ2VuZXJpYyBmdW5jdGlvbiBhbmQgd2hlcmUgaXQgaXMg
b3JpZ2luYWxseQ0KICBmcm9tLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


