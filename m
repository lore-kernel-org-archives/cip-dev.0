Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4766FC2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:56:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web11.4316.1720778153011902687
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qHnug1sT;
 spf=pass (domain: siemens.com, ip: 40.107.22.49, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5OEFgl10NC2bcpoQArQanQxfihhgaDeVuKVJ7upHnz8l6DoEnL5CJdQy5jAXS1P3Rh3aaoya4xHMy7I/1mAaKV8tNtdXqqp5rC1G9hL9pzefN0C46lApTKbS4sgB0HE68eqe0n3ovOToR6/R0XEBRjwcohb6DpTKvunz5chmPemV8hrLD4YG4jWN5H9b6JITkspwwgBXPc7Gc308vBriHQ2o/BVQI4/m6Dp8wzvHDAanTzigI6BdnmsA8jyLXaBNGjeGR3gt6HACv7bgZZnMeW22+I3iCJxW1W9Ym+mq6rOhzW5YTmuoyNubYiHOrIT0oZ1yt+aL0ctRsil+j/Ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0dJMiOHZZgS72Z0ESd5+gh3I2bwSBhfGXOhC3De1V4=;
 b=FV9kVdPj50sZg32lkqUq13BNYefeUibE71nQf2i6XDyz1NwvQj2fSvHiGtgK7CivJ/G7zQ+c02OKKXUB/W/Mj34VxOdq8cUeY/RB4b3dLqEeB0xpkUQ0zz7c2YVhmc6bapxiyvxYIFunsioZ0KgcWuHpKFaqBj48DD0KwSF2c2QWsGgpOHX1E4ftwRON/gamY+qZaiguYF4qQUTPA4VP5TVtAaxKJIb5ZD3BdEU31FgQNZWJ9g6x3LDtA0+VeeOaYztUIHVUGeqzyoZRChf01c3W9N9OglTvdyQP0rZ40gRPHcOQZqEAen1BS/ZokUDvUHI19eVwINjrUrVPxny+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0dJMiOHZZgS72Z0ESd5+gh3I2bwSBhfGXOhC3De1V4=;
 b=qHnug1sTQWJQIBdtVb+jyfK1DDCyR7A8PPyLyV1z4qgQbN76ZAEf3l8IUXIcPUqBQbUwuKGRe2b4Rux1r22uLoGOjdnnP5A+J8fi4FzC8xpgvwi4M1SEAG31K2zRhwmBPd3H6m+3ZAGeCFrp2FgnCe4mhR91Be9M5Y6jiZPxIlohk7r26XAiPt3sd/j9w0StTkf9MiWrgm4IrItVa7iJICh3wF7DdaSw7cIgAoO42ULDSO5pDamuupO3wP2UEwydjKkO5vgvlRDPfHW/d082jGJwWUwb0zJKc3Yh87I+nTD7suzPPHKqOHKNydl7TFVM9ldebFd0p2xi2x7akpjPnw==
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by AS8PR10MB7112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:612::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 09:55:50 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:55:50 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [PATCH 1/4] initramfs-crypt-hook: Do not attempt to repair a
 partially encrypted filesystem
Thread-Topic: [PATCH 1/4] initramfs-crypt-hook: Do not attempt to repair a
 partially encrypted filesystem
Thread-Index: AQHa1DMn06ticaTLTEWbV5kzpfliHrHy1IKAgAAGcIA=
Date: Fri, 12 Jul 2024 09:55:50 +0000
Message-ID: <e05ea88cf990c1cd1f43c9b8c9a085a2464d578c.camel@siemens.com>
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
	 <20240712081143.1376952-2-stefan-koch@siemens.com>
	 <79534275-072e-4209-be09-89160c566151@siemens.com>
In-Reply-To: <79534275-072e-4209-be09-89160c566151@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4953:EE_|AS8PR10MB7112:EE_
x-ms-office365-filtering-correlation-id: e842eade-a978-467f-a878-08dca258cf8f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T2JHUmpkOWhPVVhpWXFHc2lRRHFTZGNKMHRKbWs5S3I3Y2dnMzNtcDNvakRG?=
 =?utf-8?B?dktENzRFUmwvRllmdzA0OFRHK1dKUjdaY1ZJNUVwWGZUVFR2UHJkK2NlM2M4?=
 =?utf-8?B?VEF0eXRpdlBxUjRVWjFlb3VnUHkxbk5ZVmRuNmxNSUhCVlM5THFDdGx0MWlh?=
 =?utf-8?B?ZlA3aGtONWtRMzFadWVRNnhFNUtmaEtHTDduSGIxWDYxcmpmOVBvZVpvQStH?=
 =?utf-8?B?Y2pnNHE2SkxFUjBtUE5nUGtOL2lCaWpYa0dvTDBCSHFFclJYVVhxN0d5dnVM?=
 =?utf-8?B?UEViamlTZmVBd0tiS2lrSURGaFh3S3BsK3E0MjZQMjhzcjkwVXN2NXVjdGNn?=
 =?utf-8?B?cU56Uk9Eb0o1cHJ4aktFc1hqOUE2UFNrRTk0NWNvcWdEK0NtVzQwU1JlOEFp?=
 =?utf-8?B?WGI1WHpsZW9FQ2wzbEVWYzVPRERRVC9GRkdsckhrRVdpS0VOaG9nYlBVazNi?=
 =?utf-8?B?Nk5MWG84b2JLVVJEVFVJSms2c09RVnFlQ2F5dGVvVlhNSjh1cmxnTTRxTEIz?=
 =?utf-8?B?cUlCdXptemVEbEpCRkx4clo0eVpiNXhMU0Urdmpsdkc3QkhQNmFUNkp5T3dT?=
 =?utf-8?B?QTFTUTlWRXhkSWU3ZzRRNVM5L25SVmpyb2xMaHo5TlV0NFlMQ0dCN1pGMmh1?=
 =?utf-8?B?QjJ3TmFteE1NWU95Uk8vNmN2SHA1WFFHVkxONlhpK1EramVSTUR5OTZrcDdk?=
 =?utf-8?B?SjN4SUNuV0liUCtBRm50SnFLU0N2ZnFNcUZLa1d2YzBtcHNvUkhXMndVT0th?=
 =?utf-8?B?bjgyR2dFeC9IdFErNnV4Y2RHaytTWmtBYjNYMjlyUDNBMVc2dXdxcE15QmVM?=
 =?utf-8?B?YkhZa1FjZ1p5MHdQL29aOE9CN3pqMzVSc0MzdCtsRXFFL01ReHZ2R0JKUlpS?=
 =?utf-8?B?WlVRWjdLNFhSZVNDTDV5eWFEVTFMZ2doZkdGR0Y5enhHNFoxVGhGQTZhZFVN?=
 =?utf-8?B?QndHOTJnKzBLRlFwTENjZnhvUmw0c00xSVMvdS9PdXNtUzBpY0c4ZlA0czNH?=
 =?utf-8?B?YWRja1lNakEwKzVKYlpHbUZqUWpaVDkxVmtEcVMrTjhKYmhHN0toazV3QnAy?=
 =?utf-8?B?bE1JN1M0S3BIV2svMW5oT1phdkltQ0tTT3RtdDhPS3hLbkZ0VEtKWXJtY3Z2?=
 =?utf-8?B?ZDMxbEZ5UnNBY2dnY09EV3hVaXBZWTg4T05qNnNqTEc2NCttald0T090T2tK?=
 =?utf-8?B?b2R0a1NlWDFzVnJYVENiQ3FrN0hrR0thb2liM05HRmkxV1R6bDdTVUEyaU5L?=
 =?utf-8?B?bFZxdTZPL0h2dU9HTG9GajFHSENpQU40T0Mwd0VzSDlBMTdBemkrQ1BSd1c5?=
 =?utf-8?B?eUg1V1BoZStwTldiY1R5S1lnL2kyT1R3MEhndzA2ZHRCNkt6Y20yU3ZEeExq?=
 =?utf-8?B?ajREZDVUK3JHMkZ0WGJtZ3VyVVpZYTF0WXozMUQycWtzbHVLdWJ4a1kwT3dR?=
 =?utf-8?B?YkZkYTRvNm1KNmNHZ3ZDUnJoSlBsS0hGNVk0MW9UeUFlSGVSdHREaUJGcGZD?=
 =?utf-8?B?UFo1eGZXSkVzZ3FJZ0E0WHQ1NUtIbExnVHNBZTRuSWhCSHludHJOZUxYVzhG?=
 =?utf-8?B?WnNCRUFWTmI4aXhCWDUzdDdWMWtYWFlnY2pFWHJHVFhRRTNsbkkzVi9YRFRS?=
 =?utf-8?B?NU82ZFR2ZnByZkZWWWR3N2h2YytYd2hxWHBzMFJCZE9YbjZiU2oxMWdYdjhw?=
 =?utf-8?B?VUlOUHhQNzIxNmZUQ1lsbWtUeC95N21XVTNkeXpDRlQ5UGQyREZmaW9GbHFU?=
 =?utf-8?B?dXZmTG9kaEhvclRNZXd0Y0htVUNkd3hqc0t4QTRWbk91RlkxSHhqdFREOGZ4?=
 =?utf-8?Q?y+24jsTYu7HysXmpQeeqoxUst13UkOVYgfPv8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dHYvQkRtcVB5aGQwank0dFBEQVBPY00xMTRiVVliT2NZdytlaUVvQ0d4Yk9G?=
 =?utf-8?B?Tk95Z3lCY1ZESnRJUHBLNUd0elNuOElzUURkNFhUVnFsblJVM2M0TTBsTnJ4?=
 =?utf-8?B?Sng1WmlEenBwanRoa2c5d3pLcHQ2dENEL0Jmd2FpSmxtU1dtOVUvOWlHNlMz?=
 =?utf-8?B?QzRJQzR6TzEwY1lpQUxNK0FVSjFPV2FlR2Vxd3pFVWszOFgxNnk4dWFyVmYy?=
 =?utf-8?B?VEtEcXFHL2lqay9FaWNCQ3ducHhkYkRvejZsZUJUZlVKeHV1amx0Q1prWkJ6?=
 =?utf-8?B?M29xZlpBdjA1NkFISExzWThjV3lGdjdjRHlRWWJ1Q1AyWDRYV2J3Rzg2NzdK?=
 =?utf-8?B?RUJCM2dlL0ZuWkhaZlUxbnZCdG11ZGRTZTE4V29KVExYb2hRL3pTNDlpSGRs?=
 =?utf-8?B?VEl0VzlHY3o0OW1KeURzMHlFRmI2VW5GYXJHVW1obTJhcE5GWm0rSUluMWJR?=
 =?utf-8?B?RXdzMGpFcmJNcEtsSEtxcUgzOEdMKzBVeG1uM1g0WUlFazlWSkJjYW9VNFBi?=
 =?utf-8?B?T3RjWkNQK294azFTMmR3MHM1VDhEWjZra0xkYzhVNmdJU09oY1ZnTE1pWUho?=
 =?utf-8?B?VlIxaXFvdlNaOUJyRXZNejBhdVlRMTVPSmQ5a0FHTDlneDIvamY5ejBhYy9h?=
 =?utf-8?B?R2dBbGwxb3FjbFAxckcvNi9XaXY4SEFCRUJYVHluNmtDSEY2Tm5qYTkyR0Zo?=
 =?utf-8?B?bWRScUhtSkZNb1hJbXVmaE1qWCtQT0xkV0NmWWVCd0FWZVhvWGVCdkhqenpL?=
 =?utf-8?B?QVo0RTFiM1N3T0NYV2pWbCtXdnNockw2NmJiY0pVU1c1RWwrdXU5eldvMWU5?=
 =?utf-8?B?R2IrZzJxTGtqQVdqcDM0UzhYK2pHT2JGalNXVzc5ejkvWmZuYm5ZNXZQTHNZ?=
 =?utf-8?B?c3NXcWlmalhvRkRWQkRuWEQrbTdxOHNvUjYxTVNsOEQ0QUJzK0VtZXluVG9L?=
 =?utf-8?B?KzZCSFVGVU1CUlVoNjJjMEtKYlE4UmdCaTBBTnFPaTdNTmRQajRNMFZpeGFX?=
 =?utf-8?B?N081d0RqMDZWQzg1RmQxQThWM05CbHd2TFd0RGp0bTRtWEoyMlpyNG4rYXFM?=
 =?utf-8?B?RGh0QmhjY2hyVzE3YVR2NjV3YWFJNTRXTDd1dTQrcjB5eC9XN3FGWktNWGov?=
 =?utf-8?B?eVMzOGpaT0ZTd0lUYXhjMXhVZ0FHNisyeVB6YlBPYWs2UlVrV3lHOUI3SVJR?=
 =?utf-8?B?R0tpcjZNV2ZITEFJYTBzWWRjNCtmQzNkR2diZXFjUnlXVFFBUGkrek44Vm4y?=
 =?utf-8?B?bVA3azVrdTJtQ1o2Um1tWmEwMEVBNURZWW81cDNoVmR3TzFpZlcveWZxWldI?=
 =?utf-8?B?c21NSm9XSVJkck9kWFVxazFzL1FsUHRZZUEvcHUxbkZjZUhad2JTYVFHOVlF?=
 =?utf-8?B?TkRRZCtodlFqOW5OQitlakwwVFFQZVFSN0h5bDdDbE0xTEx6U3FPWTYweVh3?=
 =?utf-8?B?bTVlTjIwK3duWlBSdFNzN1BxTDVBVEVWZFdVOFpqVDQ0dkVKNEF6aDFlUWE3?=
 =?utf-8?B?Rk5xeFpiQTVVOVNSUnVnWHJGVG5qaDhyZ1E5djgzR1Fqak1JcElMZnE0M05n?=
 =?utf-8?B?bmpFb2pFUUpsUkxqSjIwOEYvRDZXRTlNWlRKOWYraEpIeDVWaWVFSkFVMklR?=
 =?utf-8?B?R3hrczZUSi92WDlNaGc1ZFZUUDRKa2tMME5BWjl3Q1FTYklLWnMrbGpZczVT?=
 =?utf-8?B?TFRMZTkrWGFGUUdqb1VhelV1NFlEak81UGxoYjhhZnppazNlR2xtMGtDY3lF?=
 =?utf-8?B?eDRORldLV1ZOVG1nNjNCMFJUUUFUWDQwSnNpeGhaUVBXUEpqOVBaRGM2akxn?=
 =?utf-8?B?QVMvVyt0WGJ4VktQYTJFVitjc3I2eDlmdzhKbDl4YmYzL3U3ZkNXdDRJS2ti?=
 =?utf-8?B?TUhrRlpnRE1DZ1g1RVFCRUxyV2F1eTUwd3NvbFZDR1JuUHhJSlcyeTdIRW9o?=
 =?utf-8?B?ZGR0SjkxTm5FQnl1SlZPaVFIQXZIU2hIOTljRklCWUZ2dzRoVGFsb0NnWWU0?=
 =?utf-8?B?bGE2NFBITTQrQWdoQUZoVzdKUjhUcjl2Q01JMjYwUnVIVXFKUTZUdVJ2c2l5?=
 =?utf-8?B?SDd6V2pGSTY3aCs5NTNoYmh6dkJFYTdJamF1NmVET2VDTEJjd0x1OVNaWlRG?=
 =?utf-8?B?Wmxyd2xMVVR0NzJFK3lpM1RJZWdaWGkzeXpkM1k4NFcxSE96dk1mTC80UVJF?=
 =?utf-8?B?aFpHdThMaXM4VlA1TWw3Rzd4NWNMSU81czZnVWRuTUJZQ05LQTZHK3lDdVB0?=
 =?utf-8?B?YkJuQUJMZ2VKelpyOHZEeW5sdUNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03DB5D1441B8B54C81D3153E2DC2908C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e842eade-a978-467f-a878-08dca258cf8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 09:55:50.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7QEywq/ARwtyMHrNbSN0GPKftvJbSByqsaZbC8vAKRKsZ9G19bJtj+iWaYZRi5uTMqNkYxQ32JR2tSzBQfAsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7112
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:56:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16473

T24gRnJpLCAyMDI0LTA3LTEyIGF0IDExOjMyICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IFdo
YXQgaXMgYSBwYXJ0aWFsbHkgZW5jcnlwdGVkIEZTIGluIHRoaXMgY29udGV4dD8gUGxlYXNlIGRl
c2NyaWJlIHRoZQo+IGVycm9yIHNjZW5hcmlvIHRvIGVuYWJsZSBhIHByb3BlciBhc3Nlc3NtZW50
IG9mIHRoZSBhcHByb2FjaCB0bwo+IHJlc29sdmUgaXQuCldoZW4gdGhlcmUgaXMgYSBwb3dlciBs
b3NzIHdoaWxlIHJlZW5jcnlwdGlvbiB0YWtlcyBwbGFjZSwgYXQgdGhlIG5leHQKYm9vdCBlMmZz
Y2sgd2lsbCByZXBhaXIgdGhlIHBhcnRpYWxseSByZW5jcnlwdGVkIGZpbGVzeXN0ZW0gLSBhbmQK
ZGVzdHJveXMgaXQuCgpBcyBkZXNjcmliZWQgaW4gdGhlIGxhc3QgYW5zd2VyIHRvIFtQQVRDSCAz
LzRdIGNyeXB0c2V0dXAgaXMgY2FwYWJsZSB0bwpyZXN1bWUgYSBwYXJ0aWFsIGVuY3J5cHRpb24u
IFNvIHRoYXQgcGF0Y2ggaXMgZm9yIGZ1dHVyZSwgd2hlbiBzb21lbW9uZQppbXBsZW1lbnQgYSBw
cm9wZXIgVFBNIGtleSBzdG9yYWdlIHRoYXQgcmVzcGVjdHMgcG93ZXItbG9zcyBjYXNlLgo+IAo+
IE9uIDEyLjA3LjI0IDEwOjExLCBTdGVmYW4gS29jaCB3cm90ZToKPiA+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBLb2NoIDxzdGVmYW4ta29jaEBzaWVtZW5zLmNvbT4KPiA+IC0tLQo+ID4gwqAuLi4v
aW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0wqDCoCB8
IDgKPiA+ICsrKysrKystCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRy
YW1mcy1jcnlwdC0KPiA+IGhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0IGIvcmVj
aXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLQo+ID4gY3J5cHQtaG9vay9maWxlcy9lbmNyeXB0X3Bh
cnRpdGlvbi5zY3JpcHQKPiA+IGluZGV4IGZmNGMxMzUuLmY5NDNhZWEgMTAwNjQ0Cj4gPiAtLS0g
YS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtCj4gPiBob29rL2ZpbGVzL2VuY3J5
cHRfcGFydGl0aW9uLnNjcmlwdAo+ID4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZz
LWNyeXB0LQo+ID4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zY3JpcHQKPiA+IEBAIC03
Nyw3ICs3NywxMyBAQCByZWVuY3J5cHRfZXhpc3RpbmdfcGFydGl0aW9uKCkgewo+ID4gwqBbb3B0
aW9uc10KPiA+IMKgwqDCoMKgwqDCoMKgwqBicm9rZW5fc3lzdGVtX2Nsb2NrPXRydWUKPiA+IMKg
RU9GCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZTJmc2NrIC1wIC1mICIkMSIK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjIGVuc3VyZSB0aGF0IGZpbGVzeXN0
ZW0gaXMgY2xlYW4gb3RoZXJ3aXNlCj4gPiByZXNpemUyZnMgd2lsbCBmYWlsCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIyBkbyBub3QgYXR0ZW1wdCB0byByZXBhaXIgYSBwYXJ0
aWFsbHkgZW5jcnlwdGVkCj4gPiBmaWxlc3lzdGVtCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIyBlbnN1cmUgdGhhdCB0aGVyZSBpcyBubyBhdHRlbXB0IHRvCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIyByZXBhaXIgYSBwYXJ0aWFsbHkgZW5jcnlwdGVkIGZp
bGVzeXN0ZW0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAhIGNyeXB0c2V0
dXAgbHVrc1VVSUQgIiQxIiAmPiAvZGV2L251bGw7IHRoZW4KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZTJmc2NrIC1wIC1mICIkMSIKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmaQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAhIHJlc2l6ZTJmcyAiJDEiICIke3JlZHVjZWRfc2l6ZV9pbl9rYn0iOyB0aGVu
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYW5p
YyAicmVlbmNyeXB0aW9uIG9mIGZpbGVzeXN0ZW0gJDEgY2Fubm90Cj4gPiBjb250aW51ZSEiCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZpCj4gCj4gSmFuCj4gCgotLSAKU3Rl
ZmFuIEtvY2gKU2llbWVucyBBRwp3d3cuc2llbWVucy5jb20K

