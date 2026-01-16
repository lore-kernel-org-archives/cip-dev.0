Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F5D4A612
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 08:20:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1822.1768551617445139913
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 00:20:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=H+vfzfKy;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1768551614;x=1769761214;bh=gda2W67gBfFkanmOheFhbKjAAMRLGWvUv+IdB
	N46j0c=;b=H+vfzfKyL0RnMQpviVzNqBPrsjfZ5uvnkasHd09m2a2K0HHZb43wSoTDUYn86AViwKW
	/j0EJmR8kZv66l/GfRJa0GNT/y6yFi4Ua/JsO9WUPljq2uc7qYYDJCZXnzlWt7Pmd+Ijs4m0qXGxb
	LuRyZAtlmsdEQ0FyuIaKb2F9GO+67A2oZ2xAYAc1Z4ClLROjUAfCiq2bhy42sZ4VhvHYLGiO5tdW3
	FwR2/ny7wJoIdipSEzZZvR5vRnOi7qZkN6zfIMY8WEIk7BVhOYRvSqygW4DtFwDDm5YS5GB6NxJB+
	RwMCOtkTTACdHalHwnknzebNrgg2fpfXwSqhPhWsNn+A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60G8KElv3627511; Fri, 16 Jan 2026 17:20:14 +0900
X-Iguazu-Qid: 2rWheNI8kwoIqN2vNh
X-Iguazu-QSIG: v=2; s=0; t=1768551614; q=2rWheNI8kwoIqN2vNh; m=hDiXKy2wIjeGbdqXaY4YcDjVd4J/Y4CfcgebYwSDZDo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dst7x5XDjz1xnZ; Fri, 16 Jan 2026 17:20:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNSuaDHcasDqN8mnIJT36SmTcicBkNw03yxNww/gpApYZmFTVl3UIhVJGFKPLVkw8Uju+GzPdW8TqqU2JfDoFAXk56KWOP2iOoYgtCdmwRg8uPYhLfMP4pM36Y/juGQ2yX7ehS3F9zsjJD29NPArOc9Qcw8bRxKVvpzs9BsaiB3fqLEIVMEJV3cVcmvTgeFQLh08Fwf1O2EqU+wdhbCVcWi/LrXOwvX+nDhhFG5AS5UfpWrs+948HMF+06d7q4ydCVpMXo+O7ww9xz/XwHl4psk5BWbxAYW3QW0NaS4wjnkC8Pu7Ru7v8lEOQ5Wk8rHWvnYS10gamiH/puFbSWxIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Keafrn7oEOUabzNQ4G+37sv7Aiap5DBWrwkekb9dw3s=;
 b=aeSGJ7R0vRNgOJlJ8oEWaAlWRj0N3/rG+oL/pxNB2CKCU2fWPXfIE7m1y01IzAlSAab7wi2wxbt+0jFesg8Ap0Yg66uSlq5ACSMjZ89XlrRw+l8zvfHVFMtyf3GsIIO0iXdXSmClNPgpVqRB1Rjz37+3bLthb7pPuo1k7+8TLA3xJNhYkVtiCO+zhjey1HzJeT4ou/orRP45e4bAYqd1fLqWgVGE4t64kzS2AL794/Lf0h0KNx57IPpIuRRwRAGYXDU3URRgtplzTXp6SX6HtaJztM8cSxZE17LtPlpr2NuoOx4HLFcWM7wZyYBnaY4GP0tm3K1abmQkaSQoAOIRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Fix ISEL restore on
 resume
Thread-Topic: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Fix ISEL restore on
 resume
Thread-Index: AQHchgrxeSa5CbWOK0iKNNWc7qZDrLVUdQUA
Date: Fri, 16 Jan 2026 08:20:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481852ED078D02DFA970560FCD8DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260115103710.133165-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260115103710.133165-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB7900:EE_
x-ms-office365-filtering-correlation-id: a4f596b5-bde7-447d-cbe9-08de54d81101
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?OUZwMXg5aUYvcGRHZGppK2FFd25ENFErSE9ZYzJMN3J4U1F4ZGdEcHpI?=
 =?iso-2022-jp?B?NGtSQ1pNUlJpelR3WXcxOGJ4czB6QlRsdDY2UWFzeHhVSVNDWjYwV2Zv?=
 =?iso-2022-jp?B?ck14bEsvR2grQ2tpQlVOdGo1UnVIbUhjakRoT0NsWC8yM0NIdnhoMG9s?=
 =?iso-2022-jp?B?ZzR6ajNtTE83K1VMZWh5eEU5a21xaHZyQ2tSTmEvSDlXUXBkV3JnZmNr?=
 =?iso-2022-jp?B?bW55SDhEckI2aEVyK1BtcWtzZG1nNmpqdURGTFE5Rjd0dFZZRW9HNUdt?=
 =?iso-2022-jp?B?dEdoc1BFbUMxZVNWam52aTJRNy9NOENHN3pNOWcrY2JEMzVyVmRqMXVC?=
 =?iso-2022-jp?B?ekE3b0tqaldkSzZWZDh3TFdBQkhJQk81UjdUZ2RHR01aUStsN2E0LzVC?=
 =?iso-2022-jp?B?NEwwNW1XMFcrNi9IUWJQa0x0eEV5THhYbmRmd2JXNjh4d1hoNk5sa25U?=
 =?iso-2022-jp?B?MzJWQ05VSC9qZU9LOU5GbW9RbnpzRENtbjhuVUIzMDVFMjBjdFNlKzZx?=
 =?iso-2022-jp?B?ZmNlYkFCNlJyekc3SGd3QWUxZXlQcDNYYVZDbTBNY0l4ZUF3ODVLZ0la?=
 =?iso-2022-jp?B?LzlFTkRERTNOZnhLMEs4MWpzQ2UrcDhWMzNBdVY0K0hxWmltKzk1anVD?=
 =?iso-2022-jp?B?K2ZjVXdxTjd0dU9kUnFieTJRS1lMTlNDenJJa293Q2xuR2NQZjBTNDRG?=
 =?iso-2022-jp?B?QlEvZzZhRmhHY3dnOSsrbVc5NkdpRjNGUnFnUkRwWHBUWHpqUkJBMWta?=
 =?iso-2022-jp?B?VUhyY3dxS1RIMGJiUUFGMGxSK3F1UFVYSVZsNHBqbGZOUFZ4SHAwN1Rs?=
 =?iso-2022-jp?B?M1lPbWo2QzZKRjEwSkV6Slo3bk9lb2VIOG5jblcrMVhmdDJlRzJwNG9B?=
 =?iso-2022-jp?B?Q3p6elluR0JwenoxNTUxSllrdy8xUCtaWjJWcmN6N1NwSDN6UjJRaTdD?=
 =?iso-2022-jp?B?ZXRMYTVIc1g1NlBhVTJjMm1KQjZCbTZzNGJtNWVqdnhBK1NZeXJRZEtK?=
 =?iso-2022-jp?B?M21CbUV5TndUbUttbGJXOWJEUUpJbWNJNWZjREZXTEVRazE4V1JObWJI?=
 =?iso-2022-jp?B?amJFMHN0T3ZabEw0c0REeVpRZTZLSHRoQ0ljWW0rVmQ3M1NWSW94NVlj?=
 =?iso-2022-jp?B?UUdISE14Vlh2SW5SQTlHZlB1a2FEMVhQTytUeGNMa1NuaEpCcEJxcXNw?=
 =?iso-2022-jp?B?QzZiZUlMREUrd1lRbTlHakEzM29KazVZWTdwY1FPNW5NVWZMNDZlMWRr?=
 =?iso-2022-jp?B?TjZBMkhGSEZRRUtKOWt6dGI3N2hCdVU4MW1VdWV2ZTNmOWNYNy9PcTk1?=
 =?iso-2022-jp?B?SUNWNEMrbnNMMVlndnh1STBzVVhjZDZic3lxajl2eUdkZTY4a2ZZd3E4?=
 =?iso-2022-jp?B?SjJhRGdVKzBXNVdWejQ4S0g1WjV1Z3lVTEpzeW0yMG5yVWRTVVJSYWdR?=
 =?iso-2022-jp?B?ZlNualpBeWxpSFBuemZ0SVlTSlRXV21LeDhxTFBmMFNHMHFmV3YwT1dT?=
 =?iso-2022-jp?B?NXo2N0Zvc3oxa2JUdkVBajk2cVVhU0Q2Tmh4WFh1R3Qyd2dXdTdCdHlx?=
 =?iso-2022-jp?B?TFdUZlBpNEF0a2VTQW5NWTZQQVZzTlZlMDFGZm1TR2t5ZExkYU5XcHFG?=
 =?iso-2022-jp?B?ZllTZks0TXhzRjl5amVHVXdnaFdNRTdudkF6NHlUKzc1VHV6NjVOUzRK?=
 =?iso-2022-jp?B?MmFSRGdTNjJjKy9FWFNlQzNWOVVXaEMxQWYzRVN2VklOQ0pubjNUWUhE?=
 =?iso-2022-jp?B?L0lsZlBxTWVxdmlhSk4yWE5yOFExN1hPaUFSbE5oOHdjUmNqNVExZ1Bq?=
 =?iso-2022-jp?B?MjV6ZDdaVUhNUXgyODlCNHBWalZQeVhNUGZ3Z3Q5RlBtQnUwQkx2MjN6?=
 =?iso-2022-jp?B?N1AxNmxiYldOWllmUkVzaHVDSytvTHhtVVV6Ry9EeCtEdnZaWUJ1cWR1?=
 =?iso-2022-jp?B?UVRmOEdLK0t0dzVMK1hvQTlGVDRFRFZxNGpmTXFOQ3F0NVA0d0lNZ24z?=
 =?iso-2022-jp?B?Y1dNR09aTVZiMkw3Z2VlUkZCQ2JLSnFwZkNlQTRDcEtrdWdaUGU0aEJH?=
 =?iso-2022-jp?B?YVpuS3BCdWFUQzg2ekN6d2ZiU05EWk9TTXQ3RC8xa2NVM3NFeldhUFk0?=
 =?iso-2022-jp?B?eTcxTWZQZHFTTklIdDVkOGZhZ2M1Q3JHSk5HYzAzcVlOUGFzOCtnWUpw?=
 =?iso-2022-jp?B?KzB6QWpZczV6dTlPMnNuYW9rYmsxZG9PLyt1V0l6WjRFU1laM1RzNkxs?=
 =?iso-2022-jp?B?Q2lBSUR5NmxNdUlOUTVvdTR2cVRKSW1BV2ZrNDRLdDc4Z0pVaERuUnJi?=
 =?iso-2022-jp?B?SDdmNw==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NHRlV1RwYUdZYktvKzdBbzZIVEdwM1Q4cnFneDB2TS9ucU43aktiaEVZ?=
 =?iso-2022-jp?B?M0J0dkJ5OEJkRDl1cUdjdzQzSSt1cDBPRmYvR0N1dm9rL0x6ZnlySVhG?=
 =?iso-2022-jp?B?NkQ1ZndNL2QrUmJIa2poSng2NVF4QmdVNU9GaXVYZXhOOGl1ZFhiOFdk?=
 =?iso-2022-jp?B?ak84S3ZwY2thY055OU9ITTVvOFAzZm85VG9LcVRqYkdKM044cU5MRDlw?=
 =?iso-2022-jp?B?M2oyTjhpenp6M29BTG9iRkpDNFVqc0MyMk5QbHBsVmkwWWVFcFI3K2Zo?=
 =?iso-2022-jp?B?bHhydGJnL1ZKVXF6RVFoNGVYU0VabnB4L205MjdSd1hhbWxMMW5GMGdP?=
 =?iso-2022-jp?B?cjhmc2VnVGZsdlpkMWx1bmkrdkExM2lZZ3Q3UTdHajFQb21VRDlYNmQ3?=
 =?iso-2022-jp?B?RDdhOW5hT3p6T0I5OUFlZkNDZ3ZvTVhWaE9FVWtGWHYzVGdrcitjM2N2?=
 =?iso-2022-jp?B?cWJ1OVovYVZyd1kyTkcxbTlZK0VDODJPNkwyQmpFVGh5b0NxSTZjNytH?=
 =?iso-2022-jp?B?N2lTQUlqRHpCeWNWcU4raW9rU2ZzYVowVmYxbHpDVjdUT1FLMVFIelZU?=
 =?iso-2022-jp?B?cUppanVTSDJxQ2diaERvTmRoRGdjVUtOd2hLYytDaU53YmdlOUtMdmZx?=
 =?iso-2022-jp?B?RU5zYkh5MTZwL0tJZk1DZDJzZmRGWXlaUW4rdDFIV3RMMFJUM0NQaGx6?=
 =?iso-2022-jp?B?RFBNb2h5RVZqNlFCYTJtZWV5bU9iS1FBcTIzdnBMZ2ZjSk5jdnVOZFJk?=
 =?iso-2022-jp?B?dEFURTNWTWZ1eUJHcUkxaFJXa1FVS2o1bWoveWh3dmlRTE1PcUZMN1Fl?=
 =?iso-2022-jp?B?Zit3UVJHeU5zelBWcjFPNnFaUHdsbk9UMUtEbi9ETEdYOWZJQU1xZkF6?=
 =?iso-2022-jp?B?Yk9yQzNSK3NVb3JhdUR3WnNrVXZaRWtpcFNqVENVdlhZRnNRK0VmOWFn?=
 =?iso-2022-jp?B?bmJCTGN0akhHY2tHSDBoSDhmaFVvZVdycGNRallRODhQRHMvUWR1cWNZ?=
 =?iso-2022-jp?B?djYrUU1qZCtwSVM3UytsRCtJc3RKZWpGK3FXUTJVb1VBdmc3eks0NFFC?=
 =?iso-2022-jp?B?ckFIeTJGQmFhT2VZUWFDUnB5K1ErNjJrZkVYQ2xRV0M1SW9ScUdvVWQv?=
 =?iso-2022-jp?B?SXBFeVRTTnRDcUJNeUdJdUVlTDB2c2xSU0FOeHg3SjFBY1NZM3lxZlNp?=
 =?iso-2022-jp?B?MTZkb2VRUUFtK0tMejdCbkhValR4TmUrdm15TTA1YVJvOUR2UFpLakhy?=
 =?iso-2022-jp?B?ZWViYnpMajVEeUFhUnBpaG5oblVNZXh3K1lYL2wxRzBOeFNRVVE3SDdO?=
 =?iso-2022-jp?B?aWpZaFZnU3Jpc2JvbC9acTlLWTRuSko3MHhBY0xkNTVqZFBRcm1SMk1q?=
 =?iso-2022-jp?B?WTJZclowaGVqSWEzZnp3Q3g4OWVUeFB0MlRCVU5xU0h0M1R1dE4zdi91?=
 =?iso-2022-jp?B?UFJ2Y0xlb2Vsb3FlcTJZREtQOVI2V0VrcmtLc0t6bXZiM0lWSkk1Rm1N?=
 =?iso-2022-jp?B?TTdPdnBCWUpOekFURXY5OFdxNTM1TVh4cEw0RFZ0bUh5aVd2czFQVzRJ?=
 =?iso-2022-jp?B?MzMrK1duVmc3aTg4dk1RVk8yTWtSejV0aE1YUVNkejRPVDNyZ1FLRmF2?=
 =?iso-2022-jp?B?djJHellIZHZYZnJjYjE5aTM4Q2xNOHVoRkRHWXd2V3A3YkE0SWhNMDJk?=
 =?iso-2022-jp?B?T3JjcjROSjgxekR5Y2R2T0JBN2lwbkUvRWFBaHVya3F5SHoyOFF5c3VU?=
 =?iso-2022-jp?B?V3FrREMxYVZKSW9mK1VhN2FLVDd0alNMTXYvalRLYWtEMjE0cS9sN0hD?=
 =?iso-2022-jp?B?OENqdlg0RnRRRitIY3BxdVJDSFNIQkJlUnllZjlEdlVuOU50c0h6TU81?=
 =?iso-2022-jp?B?UitRNjlySHhJK21ZZFYzQndyYkRBdk1NUUpsdnN2bkQ1V1NZVXJWN2la?=
 =?iso-2022-jp?B?c3J0MmR4RjNRU2ZLYWVZYUo2NmwvTXVEdUFwYlpBMkdmYVdWNFovZU8x?=
 =?iso-2022-jp?B?YkFtNEpnWWh4MzRQQmthZmVsZWgzRlZlQ1FkVFdyR3RpTlkrdVMwckxJ?=
 =?iso-2022-jp?B?Vyt5cGppSzJKcU9oR2xlOTJZK1lQZ2NQTEZjcnJEdjRHVkxsK0FHY1V4?=
 =?iso-2022-jp?B?M3JkRSszUWVRYjd2cDFpNzc1dTRCZkJMUWF4MTNuK1NYMHlSZGhhT0ty?=
 =?iso-2022-jp?B?dkxGWTRCbmM2QzNoVk90Zzh5dW9oOHpBTUxuVmhiT0s3QkJPY3dwb1hS?=
 =?iso-2022-jp?B?ZXhhSGlOdk51TGlsWG1xOVZnd2djUmdxVjUwYS93bVBpSE9RaUpjQWxU?=
 =?iso-2022-jp?B?UmorMzZmQkVhZmVpSnkxdDNkR3gxN0xORHpFQWNZZkU5bTNTcFBETjc1?=
 =?iso-2022-jp?B?Vm9SbXdkVzBPQWdMUkx3V1VQV0gxeWtsSnozUTJlSFdDckxEbE52UGdx?=
 =?iso-2022-jp?B?dEw5QUJ6S3I0dWViRGQ4c0FwUVEvZHorZ3BxNG94cDd0RGJKQmxuM2JC?=
 =?iso-2022-jp?B?cEJGbWI3Yis2Qm1CcEl0cDVuS1ErT3M0OW4wYlBIbzY5VDRTTHBmTndv?=
 =?iso-2022-jp?B?Y3J4dTVQWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f596b5-bde7-447d-cbe9-08de54d81101
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 08:20:10.8054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srGLPQbqdgLXCrDN0iGDwHnmkDiqNmZBFEEIJREAnKsMP5g++p8PGiDyuuJFsiCFdfOy60iJHUmp7ymNP11vLzQcyFKrcRk8UgCMUOHAOaqsmzmadjoeeHO/6rb/DJ+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7900
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 08:20:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21628

HI all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Thursday, January 15, 2026 7:37 PM
> To: pavel@nabladev.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Fix ISEL restore on =
resume
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 44bf66122c12ef6d3382a9b84b9be1802e5f0e95 upstream.
>=20
> Commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
> gpio_irq_{en,dis}able*()") dropped the configuration of ISEL from struct
> irq_chip::{irq_enable, irq_disable} APIs and moved it to struct
> gpio_chip::irq::{child_to_parent_hwirq,
> child_irq_domain_ops::free} APIs to fix spurious IRQs.
>=20
> After commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring IS=
EL in
> gpio_irq_{en,dis}able*()"), ISEL was no longer configured properly on res=
ume.
> This is because the pinctrl resume code used struct irq_chip::irq_enable
> (called from rzg2l_gpio_irq_restore()) to reconfigure the wakeup interrup=
ts.
> Some drivers (e.g. Ethernet) may also reconfigure non-wakeup interrupts o=
n
> resume through their own code, eventually calling struct irq_chip::irq_en=
able.
>=20
> Fix this by adding ISEL configuration back into the struct irq_chip::irq_=
enable
> API and on resume path for wakeup interrupts.
>=20
> As struct irq_chip::irq_enable needs now to lock to update the ISEL, conv=
ert
> the struct rzg2l_pinctrl::lock to a raw spinlock and replace the locking =
API calls
> with the raw variants. Otherwise the lockdep reports invalid wait context=
 when
> probing the adv7511 module on RZ/G2L:
>=20
>  [ BUG: Invalid wait context ]
>  6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 Not tainted
>  -----------------------------
>  (udev-worker)/165 is trying to lock:
>  ffff00000e3664a8 (&pctrl->lock){....}-{3:3}, at:
> rzg2l_gpio_irq_enable+0x38/0x78  other info that might help us debug this=
:
>  context-{5:5}
>  3 locks held by (udev-worker)/165:
>  #0: ffff00000e890108 (&dev->mutex){....}-{4:4}, at:
> __driver_attach+0x90/0x1ac
>  #1: ffff000011c07240 (request_class){+.+.}-{4:4}, at:
> __setup_irq+0xb4/0x6dc
>  #2: ffff000011c070c8 (lock_class){....}-{2:2}, at: __setup_irq+0xdc/0x6d=
c
> stack backtrace:
>  CPU: 1 UID: 0 PID: 165 Comm: (udev-worker) Not tainted
> 6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 PREEMPT  Hardware
> name: Renesas SMARC EVK based on r9a07g044l2 (DT)  Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x90/0xd0
>  dump_stack+0x18/0x24
>  __lock_acquire+0xa14/0x20b4
>  lock_acquire+0x1c8/0x354
>  _raw_spin_lock_irqsave+0x60/0x88
>  rzg2l_gpio_irq_enable+0x38/0x78
>  irq_enable+0x40/0x8c
>  __irq_startup+0x78/0xa4
>  irq_startup+0x108/0x16c
>  __setup_irq+0x3c0/0x6dc
>  request_threaded_irq+0xec/0x1ac
>  devm_request_threaded_irq+0x80/0x134
>  adv7511_probe+0x928/0x9a4 [adv7511]
>  i2c_device_probe+0x22c/0x3dc
>  really_probe+0xbc/0x2a0
>  __driver_probe_device+0x78/0x12c
>  driver_probe_device+0x40/0x164
>  __driver_attach+0x9c/0x1ac
>  bus_for_each_dev+0x74/0xd0
>  driver_attach+0x24/0x30
>  bus_add_driver+0xe4/0x208
>  driver_register+0x60/0x128
>  i2c_register_driver+0x48/0xd0
>  adv7511_init+0x5c/0x1000 [adv7511]
>  do_one_initcall+0x64/0x30c
>  do_init_module+0x58/0x23c
>  load_module+0x1bcc/0x1d40
>  init_module_from_file+0x88/0xc4
>  idempotent_init_module+0x188/0x27c
>  __arm64_sys_finit_module+0x68/0xac
>  invoke_syscall+0x48/0x110
>  el0_svc_common.constprop.0+0xc0/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x4c/0x160
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x198/0x19c
>=20
> Having ISEL configuration back into the struct irq_chip::irq_enable API s=
hould
> be safe with respect to spurious IRQs, as in the probe case IRQs are enab=
led
> anyway in struct gpio_chip::irq::child_to_parent_hwirq. No spurious IRQs =
were
> detected on suspend/resume, boot, ethernet link insert/remove tests
> (executed on RZ/G3S). Boot, ethernet link insert/remove tests were also
> executed successfully on RZ/G2L.
>=20
> Fixes: 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
> gpio_irq_{en,dis}able*(")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://patch.msgid.link/20250912095308.3603704-1-claudiu.beznea.uj@bp.r
> enesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [claudiu.beznea: fixed conflicts:
>  - dropped code unavailable on v5.10 CIP
>  - kept code from v5.10 CIP on merge conflicts
>  - manually adjusted the remaining  untouched
>    spin_lock_irqsave()/spin_unlock_irqrestore() with
>    raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore()]
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Hi,
>=20
> The v6.1 CIP variant of this patch was already integrated at [1].
> The patch was backported in v6.12 stable at [2].
> Please consider this patch as well as it is necessary for the Renesas RZ/=
G3S
> SoC.
>=20
> Thank you,
> Claudiu
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
dri
> vers/pinctrl/renesas/pinctrl-rzg2l.c?h=3Dlinux-6.1.y-cip&id=3D9c6a8dccc2a=
f82f7
> 4d6401d5c13f4039bbad02eb
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3D
> linux-6.12.y&id=3Df8bb150f228f4c1500632a81e91e6ad99df5c90c
>=20
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 63
> ++++++++++++++++---------
>  1 file changed, 40 insertions(+), 23 deletions(-)
>=20

Ah, I was just working to backport this patch. Thanks!
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 7e6ff6617c93..bcdbf1362fa3 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -307,7 +307,7 @@ struct rzg2l_pinctrl {
>  	spinlock_t			bitmap_lock;
>  	unsigned int
> 	hwirq[RZG2L_TINT_MAX_INTERRUPT];
>=20
> -	spinlock_t			lock; /* lock read/write registers */
> +	raw_spinlock_t			lock; /* lock read/write registers */
>  	struct mutex			mutex; /* serialize adding groups and
> functions */
>=20
>  	struct rzg2l_pinctrl_pin_settings *settings; @@ -462,7 +462,7 @@
> static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>  	unsigned long flags;
>  	u32 reg;
>=20
> -	spin_lock_irqsave(&pctrl->lock, flags);
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>=20
>  	/* Set pin to 'Non-use (Hi-Z input protection)'  */
>  	reg =3D readw(pctrl->base + PM(off));
> @@ -490,7 +490,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct
> rzg2l_pinctrl *pctrl,
>  	reg =3D readb(pctrl->base + PMC(off));
>  	writeb(reg | BIT(pin), pctrl->base + PMC(off));
>=20
> -	spin_unlock_irqrestore(&pctrl->lock, flags);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  };
>=20
>  static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev, @@ -821,10
> +821,10 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, =
u32
> offset,
>  		addr +=3D 4;
>  	}
>=20
> -	spin_lock_irqsave(&pctrl->lock, flags);
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  	reg =3D readl(addr) & ~(mask << (bit * 8));
>  	writel(reg | (val << (bit * 8)), addr);
> -	spin_unlock_irqrestore(&pctrl->lock, flags);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>=20
>  static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *re=
gs,
> u32 caps) @@ -1056,14 +1056,14 @@ static int rzg2l_write_oen(struct
> rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8
>=20
>  	bit =3D rzg2l_pin_to_oen_bit(offset, pin, max_port);
>=20
> -	spin_lock_irqsave(&pctrl->lock, flags);
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  	val =3D readb(pctrl->base + ETH_MODE);
>  	if (oen)
>  		val &=3D ~BIT(bit);
>  	else
>  		val |=3D BIT(bit);
>  	writeb(val, pctrl->base + ETH_MODE);
> -	spin_unlock_irqrestore(&pctrl->lock, flags);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>=20
>  	return 0;
>  }
> @@ -1400,14 +1400,14 @@ static int rzg2l_gpio_request(struct gpio_chip
> *chip, unsigned int offset)
>  	if (ret)
>  		return ret;
>=20
> -	spin_lock_irqsave(&pctrl->lock, flags);
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>=20
>  	/* Select GPIO mode in PMC Register */
>  	reg8 =3D readb(pctrl->base + PMC(off));
>  	reg8 &=3D ~BIT(bit);
>  	writeb(reg8, pctrl->base + PMC(off));
>=20
> -	spin_unlock_irqrestore(&pctrl->lock, flags);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>=20
>  	return 0;
>  }
> @@ -1422,7 +1422,7 @@ static void rzg2l_gpio_set_direction(struct
> rzg2l_pinctrl *pctrl, u32 offset,
>  	unsigned long flags;
>  	u16 reg16;
>=20
> -	spin_lock_irqsave(&pctrl->lock, flags);
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>=20
>  	reg16 =3D readw(pctrl->base + PM(off));
>  	reg16 &=3D ~(PM_MASK << (bit * 2));
> @@ -1430,7 +1430,7 @@ static void rzg2l_gpio_set_direction(struct
> rzg2l_pinctrl *pctrl, u32 offset,
>  	reg16 |=3D (output ? PM_OUTPUT : PM_INPUT) << (bit * 2);
>  	writew(reg16, pctrl->base + PM(off));
>=20
> -	spin_unlock_irqrestore(&pctrl->lock, flags);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>=20
>  static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int=
 offset)
> @@ -1474,7 +1474,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip,
> unsigned int offset,
>  	unsigned long flags;
>  	u8 reg8;
>=20
> -	spin_lock_irqsave(&pctrl->lock, flags);
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>=20
>  	reg8 =3D readb(pctrl->base + P(off));
>=20
> @@ -1483,7 +1483,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip,
> unsigned int offset,
>  	else
>  		writeb(reg8 & ~BIT(bit), pctrl->base + P(off));
>=20
> -	spin_unlock_irqrestore(&pctrl->lock, flags);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>=20
>  static int rzg2l_gpio_direction_output(struct gpio_chip *chip, @@ -1865,=
14
> +1865,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, struct
> rzg2l_pinctrl *pctrl
>  	return gpioint;
>  }
>=20
> -static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
> -				     unsigned int hwirq, bool enable)
> +static void __rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
> +				       unsigned int hwirq, bool enable)
>  {
>  	const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[hwirq];
>  	u64 *pin_data =3D pin_desc->drv_data;
>  	u32 off =3D RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
>  	u8 bit =3D RZG2L_PIN_ID_TO_PIN(hwirq);
> -	unsigned long flags;
>  	void __iomem *addr;
>=20
>  	addr =3D pctrl->base + ISEL(off);
> @@ -1881,12 +1880,20 @@ static void rzg2l_gpio_irq_endisable(struct
> rzg2l_pinctrl *pctrl,
>  		addr +=3D 4;
>  	}
>=20
> -	spin_lock_irqsave(&pctrl->lock, flags);
>  	if (enable)
>  		writel(readl(addr) | BIT(bit * 8), addr);
>  	else
>  		writel(readl(addr) & ~BIT(bit * 8), addr);
> -	spin_unlock_irqrestore(&pctrl->lock, flags);
> +}
> +
> +static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
> +				     unsigned int hwirq, bool enable) {
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
> +	__rzg2l_gpio_irq_endisable(pctrl, hwirq, enable);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>=20
>  static void rzg2l_gpio_irq_disable(struct irq_data *d) @@ -1898,15 +1905=
,25
> @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
>  	gpiochip_disable_irq(gc, hwirq);
>  }
>=20
> -static void rzg2l_gpio_irq_enable(struct irq_data *d)
> +static void __rzg2l_gpio_irq_enable(struct irq_data *d, bool lock)
>  {
>  	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +	struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl,
> +gpio_chip);
>  	unsigned int hwirq =3D irqd_to_hwirq(d);
>=20
>  	gpiochip_enable_irq(gc, hwirq);
> +	if (lock)
> +		rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
> +	else
> +		__rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
>  	irq_chip_enable_parent(d);
>  }
>=20
> +static void rzg2l_gpio_irq_enable(struct irq_data *d) {
> +	__rzg2l_gpio_irq_enable(d, true);
> +}
> +
>  static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int type=
)  {
>  	return irq_chip_set_type_parent(d, type); @@ -2069,11 +2086,11 @@
> static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>  		 * This has to be atomically executed to protect against a
> concurrent
>  		 * interrupt.
>  		 */
> -		spin_lock_irqsave(&pctrl->lock, flags);
> +		raw_spin_lock_irqsave(&pctrl->lock, flags);
>  		ret =3D rzg2l_gpio_irq_set_type(data,
> irqd_get_trigger_type(data));
>  		if (!ret && !irqd_irq_disabled(data))
> -			rzg2l_gpio_irq_enable(data);
> -		spin_unlock_irqrestore(&pctrl->lock, flags);
> +			__rzg2l_gpio_irq_enable(data, false);
> +		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>=20
>  		if (ret)
>  			dev_crit(pctrl->dev, "Failed to set IRQ type for
> virq=3D%u\n", virq); @@ -2393,7 +2410,7 @@ static int
> rzg2l_pinctrl_probe(struct platform_device *pdev)
>  				     "failed to enable GPIO clk\n");
>  	}
>=20
> -	spin_lock_init(&pctrl->lock);
> +	raw_spin_lock_init(&pctrl->lock);
>  	spin_lock_init(&pctrl->bitmap_lock);
>  	mutex_init(&pctrl->mutex);
>  	atomic_set(&pctrl->wakeup_path, 0);
> --
> 2.43.0



