Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A6C3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 11:00:27 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.43])
 by mx.groups.io with SMTP id smtpd.web10.35442.1721041219081095139
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 04:00:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XriG7Bxc;
 spf=pass (domain: siemens.com, ip: 40.107.20.43, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlRCGkKR2w6BVqS+zjVHKbOIEQzshiIpVPTsAApU47vl4tedQjtfUy6ruOnvrfcfsW5iANRcPVvH2ZDlkYJkFp6SosuoP9walYsVFpM9bpu4gX5vKq1JBU8KK17juAR4ktrjQiqD4y1QpMV8+vT9t61TgxQAHPfxiYwphfJRGM3q2nDi53Z9UD1fsZSVrQ3CBtN8Xkjfy5TNpZnW0twR3c4u2Axk5cKphfCLWZq1sdpIt4FQvExztQ/LOdzW92uC9klItEmdxkssKMGD7jXWcqhCT6QTNccOTT1ZdhyAWh+qzFoQTcTecRfuOD/tPSEf9Tp9Mxi3tjZAWabJ5AErYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu3Ok8IeabNeV4NHKc75fGJ8MXX1dpxm0E8MPnjoOGI=;
 b=UX1CFT8IQR2fk4Z7267Lecuh5ucA4T0qahE/GwtVyXGFmAURWvrJgH3JNX+3xrhAvPv46j6Qnd7C8R6ZwD4BLP/606w7lUs6B9yG7/e8xOcjS1LXdEM335rqMVGtXAcHpcOENFvSCR5OV5xDlGYbz1TF+ExNgiMRCELFGrH00/bYldCHCbGE+YigzrF645gQ96u35i2Em7iWIqs5ocdwsuHJr9ROnnO1dqiGxYbHC9ZSTZSdXvT+L/+U73Xbt8bi8LHVFc87RCKqx7KmJblJpLYvNQgNIc2z7e6SgwugjsVErxsDQZxyvTvSXehyFcTDPi83JruAswQ0yL34IAI+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu3Ok8IeabNeV4NHKc75fGJ8MXX1dpxm0E8MPnjoOGI=;
 b=XriG7Bxcm77W2O8DdnfMFtIUP7B5+779PJD6Ecxdt6BUCd6jOjyMgFfFzwcPkg7uF9xEy0x8XUDYsI1GNp/1X+gwu2ATrKYwz2a2m3DLPbQw5yz7+4hPaUAi1ECBEQJ+QFjJWF6u6pu9Uv63oRbcM5c8PdurfKoZRXCZvYFxjxcg5QIh4cVHmxTO0LfeC7I12a8tANfigF2Kw2ph8YVkxKcUqYE/IoyrGIKFWKz5ICJj/fO/3YIERRGztnSnAXfsUktzbOqqrO1z+zb0JA05OFcaj0GfJTvB5y7o5ot98ApTLKFv51GsZ/T1uYkABS+4b3zfEdq5UsUeRy0lVFNXBA==
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 11:00:15 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 11:00:15 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [PATCH v2 1/4] initramfs-crypt-hook: Do not attempt to repair a
 partially encrypted filesystem
Thread-Topic: [PATCH v2 1/4] initramfs-crypt-hook: Do not attempt to repair a
 partially encrypted filesystem
Thread-Index: AQHa1FsJaBsU8IcfL0CVFJiNoiKMX7HzIw6AgASAk4A=
Date: Mon, 15 Jul 2024 11:00:15 +0000
Message-ID: <5b3b2712f583ef0ce9e74dc95f1dfd2cdb499f6b.camel@siemens.com>
References: <20240712125713.2066512-1-stefan-koch@siemens.com>
	 <eb80845a-dcdc-48c9-bfef-b07e79006e9e@siemens.com>
In-Reply-To: <eb80845a-dcdc-48c9-bfef-b07e79006e9e@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4953:EE_|PR3PR10MB3883:EE_
x-ms-office365-filtering-correlation-id: f955ac33-de64-40f3-b356-08dca4bd4ed7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U1MwbEVUdjM4ZkdiUlZEK0hGZU9IQUp3bGxkR3ZOdW9QZnNJcmlJYm1WOVYx?=
 =?utf-8?B?ZHdDdTROS01iV2ZvK2thc016aEtvdytoTC9VYjRYbkdGUXp3MUc5cW5ZcHI4?=
 =?utf-8?B?T2g3OVBwMWRpOGZETGNYdzNpaFRVdGtZTzdZbFduRlg3TlJOU3k4Q01jbEY2?=
 =?utf-8?B?dTlrRnRTaTdIakVTSmhEQWtUY1ZOckJpSEMxWmNjS0pvaE9EdlNsaVlLSWxB?=
 =?utf-8?B?cVRrRmduWGlEcXF2alg1QmxkSjJGR0I4a1U0aUlXaWIwZUJacnd0MDUwUW9z?=
 =?utf-8?B?eTlMYVdnelBybml1WXVtUTd2c3VoT1NsRU9YTjlOdE01czdzd3c3QjRxTTlS?=
 =?utf-8?B?VmJzYllTNGtwUG5pck1nZmExU3FNYzBOUC82NUpycGVLZkV3bGVKVDkwVmNN?=
 =?utf-8?B?VUNYYXFqWTdvNm90bXJvandHUGV5QkZycmVsSnRFUGdEclRYVC90V3I0clpq?=
 =?utf-8?B?Rm5tajdpdUNXVGY2WGJUSGpxbmd6dytVdCtvdGRoeVZLZXg0SXJGa2lhSFR3?=
 =?utf-8?B?VFI0TzBBbDhoOWQ4bEJWRlp1bloxempIditmTllWU2w2UVpHSUhQRDB1NTJx?=
 =?utf-8?B?RG53L0ZPcEFQb2JqZ1JmalBYMHZzdHZxcDZXMjhuL0wyMU9kQ0xFdXNqNUpi?=
 =?utf-8?B?RjN6d1V2VFRCYnhhNzAyMWt3aGlvTEdyZXRlVDhSeGFTdlgvSmhaM0pNaDFX?=
 =?utf-8?B?K094Y3k0UGp3d3lwTmhaK3VpNG1ZazhTTGFEbDFydmdSS1RGeXNUaXUxZVYx?=
 =?utf-8?B?clIvL3pidUNRaGVESVVBM0RncGFZS1BpNTFsQ3ZuN0FQQUxIc0RPcXNsQUta?=
 =?utf-8?B?aGNueUJrRGNOSHViMWJpbFZWVUN5V1h4a0tYLzBLemo0dTAxdGZ1VW5jazU3?=
 =?utf-8?B?TWRjTThIWWlTazFOSmg0cUZkdlNLekhiTjdBS2NuSnVlYktsc2xDM0xmT1F5?=
 =?utf-8?B?cHFyQlR1OHd5Vk01TUNIRUZRaG93Y0tQN1ZGK0RQUFZvOTRUaDM1UDFRbGVG?=
 =?utf-8?B?aytJaWJISkNRSXB2emtYYTFJR1BTTTBxNzZhMjRmQllaZDJYMWlCbEEzZ2p3?=
 =?utf-8?B?aTZiR1pzS1Z4UWxZTVdrZlVVYWxBS2puREdmQ3d2UFAxMHZ2UG1KQ0s1ektU?=
 =?utf-8?B?N3lqVG1RQ2ZIemFnUXM1bklsUjdZeFI5VDIxSHFKaFc4ZWlwZll2SUU2R2tD?=
 =?utf-8?B?Um1YbjJSTkEwY2ViZWRjb1hicVIvcU1uMUROYmFrb3Y0VXlLRENndVN4ODhB?=
 =?utf-8?B?bU1GN1ZILzBEZW9aNFZLVkdROVBJWUlWMkdjRm5sYVBFQnVudVhqMzJybnM0?=
 =?utf-8?B?TVE1ekh0aDVGai9RcHJtb1Jtb0NBUjU2QjFaQVhOaklFZ3crRm4wcHpWWVhT?=
 =?utf-8?B?RFRPeFp6UmwwRWNNRnhHWHlDWDhQZkdpY3F3a2xhZUlrUTJqUGk5SWN6ZlhG?=
 =?utf-8?B?cXI0UkZVYXhNbGJmSVZaMWhXb2dlQzlsWU1sZklRN1VoMjhWT1Y5M25JNkRq?=
 =?utf-8?B?Tzd6NnROQzJnSDFJWFJqK0Q4OUVhajFPQjRjR0JxOFowVGhMd1pQYWNrYlJx?=
 =?utf-8?B?c0ExMWQ0RGtiamZSZkVlcE5jVUd2L2N5TjRCdWZCdXdxSFFNaEUxczVmSnZh?=
 =?utf-8?B?clMzdHB1Yyt1alRSSmJUYVdMMEdrRVFOa2M4NGM5eXpESUh2Sm9yOWNIL2Z6?=
 =?utf-8?B?SkdxMDd5U01maFRuakdyYVFqd2pVOUVyOGJnZ0NPa3M2RSt1Vk5CNHMwWUJp?=
 =?utf-8?B?VXVGSlczVHpoMDdZcG1XazhwZVdQVTZGaHNHaUl6a2RhdGlRSTliSEdQVjkx?=
 =?utf-8?Q?HNqsFY2Q+9BpxAXckQy7pFGBafeQ12F+v7Qmg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YUF6UWRKZmpvMi9KMHQ4OUhGbWpTSG82ZlVZZjY4ajdURWlDWVE5WjBoVm5X?=
 =?utf-8?B?ek9aTWt3SmlOb0FWSFl3di9xVmdHbUFOb0txc1poS3lvbng3a2J2RWR2N2xI?=
 =?utf-8?B?bG9zY0NueXVuNktTSnl5ZzJsTDJXWUpRQlkwMTMvdWgvWTcrcjZHSStnUXVH?=
 =?utf-8?B?Q0NTL2tUTHVZYlJiYWdJaHhaK3lwV2JwRW9HcytISW5WVTFDWVR2Mk9ZSFB3?=
 =?utf-8?B?VjBOWUpIUWJldEo0RlptZ1JjV21XSkJxRVdoZ0hUTHlOWkFYTUVBeXJhcWZy?=
 =?utf-8?B?eSs1S3QzWDhWMHVrTk5GN3liUEk4OG93WFp0NzVyOGNkcm1GS0thUXIvenN0?=
 =?utf-8?B?aWdGdndJZDZpaG8rTy9uNnF2a0FDWFNhSE1nTHRUNjdDVDE3aU1tQlUvOUV4?=
 =?utf-8?B?T2F4TVhNZWR4ckEzSy9meThFdnAxS3NVU0ZjVm5GN3hBTzhtYWtLUXJkajF2?=
 =?utf-8?B?VUUxcElOTGxZOXM3NGs0YUhEeHVlRk9xOWVhUHlwWjVQSi9BblVkaE9iWVJI?=
 =?utf-8?B?UjZJZDFjWHJFV01Nd1BEM1ZaTGJsOFVVZkZHSU11QVhzM3gwSWw3ZDRRVUlL?=
 =?utf-8?B?UWtqVkx2bC8rY1JDWWxVZnJUTVkyK3FENDd5Q3c5QlNML3BLU3BpalQzK2Nw?=
 =?utf-8?B?c1lCWHoxZ0dVb3psblh2azZMRVRCMGhPQUFqLzArRno3KzcrcjJET1NXYUNS?=
 =?utf-8?B?L2prVTJOM3ZNNlkzaVFtaEszL2ltY05qWURlQUhDMnZpVUpXQzgzcEJpMzh5?=
 =?utf-8?B?Tkx4RjduWkRFQnZjTGVnSWpmaDdVNnI3VUlsMjd0dGc5VlIwQlNseGRUMVBi?=
 =?utf-8?B?Z3l2QUR4c2lvOEovTk4rSC9ISjJBQlpjRFlKM01TMXI0eks3V2ZjQzlJMXM2?=
 =?utf-8?B?bVgzS3FzUG1nVW96NjZ5VmNLaGhvSEFNQ3l5QzA4MzJiMHVnUjRYN092OGRO?=
 =?utf-8?B?N2luY3RRZnl6KzBNZnA2cnRWYmVJV0FmS0NZWEw0TTlPTzNTTDBnUVNGTXBq?=
 =?utf-8?B?ZXYvVTAyejZNSjVLeDJaQVNBRXNnTXFPWXgxaEZucitVeW4wQis1TFE4WHBp?=
 =?utf-8?B?NGZOZWtWamJLQ3l5TStZaU56L1RzczBhY2FpWXJEYTBPZGtrN2dvRjhnUEd6?=
 =?utf-8?B?YU5rd2NpeGEzcWFEbitiY0M2Mk1aWFpLcEl6NzE0S0lPT09UVDZ1NnJyS2JN?=
 =?utf-8?B?bkllS05Sdk95OU10RTcwL3NTVCtOVUovd1VJL1IxMnE2VHBDWnV2STFXNEZv?=
 =?utf-8?B?M3I1Y0pYUnh4L0lIc1RPR1QxdzB5NUtmWU5vQWdCZ0V5c0FGaXBzalM5UzRK?=
 =?utf-8?B?OGQ1NzlYTDY3SzE5dnJMZmt2V0VONEdCTmV6L3pIMEpSZlh0WjVhVnduVVFz?=
 =?utf-8?B?VFM0L1ZFYnUxdzFEc0Nuc1FyVExqS1VWd1BGVUsxZnRkSStWUVArdGkrWHBj?=
 =?utf-8?B?QnNuYkpGYUx4ajBvZGVBalA5R1l2aEFldkpXNFN2YmdzMER1bUxQeVhKZWhk?=
 =?utf-8?B?YVAvUnRGT043U0JsbFB3UXhkRUpZUWhvdXVIMUlzd24yMERUeldrMnFZR0pK?=
 =?utf-8?B?TGFqTW5SWUhPSmtKaHMwQkJsK0RkN2dSTkxjR1QrcTdON0Q3Q2tTWXcrTnlU?=
 =?utf-8?B?cTZVNjRDalFIbUQ3d1M1ZUFpQ3pOKzFNVEphQXhVWGh2ZWo0aGpqbU5FbjZ2?=
 =?utf-8?B?RDhieFRLNU9DNk10VU80eDhhOHdla3RUZlFxUzN0Ym1RNytjcWwzYlJlUGxn?=
 =?utf-8?B?TEJpRm4zMXViS3NDdjlYMXZOZWxZZ2Q4aHJ6ZVgyVVV6OXJudU42NHNjaDZ4?=
 =?utf-8?B?RENPTkNmTGtTUXRDOVBOOThVT29lNlAySisySjRnRTJKY3M0czhiMCtubWhM?=
 =?utf-8?B?S25HSGthT0pqNitWTktLRlZVMFpxYW56amEwa2VjejhwSWg1MUhDQXhsdy9Z?=
 =?utf-8?B?Qjk1QitPcU1BSjNoa1hBWGdXMkErRmVVZ01VcHBtYnZHQVhSL2lYbSszWTQ3?=
 =?utf-8?B?TG1tVG10Si90TW1zZWpEMSt4RlNlcEltN0NzazFPRENoK3pYeFY2K05mL2xn?=
 =?utf-8?B?YkxkV2tFOTczN0pQK2pKMzhLRkM0WUJxTEZaOE52TXZvTEZnNlVGL2VuNytt?=
 =?utf-8?B?SitqL1pCMFJ4Y285bDBlNXJRZ1FVb2QrMEZ0ZnNlUFNmaWNZVDl0NmJ1Tkd1?=
 =?utf-8?B?cUROR0g1aUljc3ZHdnRzYVE0aXJ5eGdSKzNyS0t6SDI1N2V3VVFDZ0ZOTk9p?=
 =?utf-8?B?cjBiby9ORFQ1REVCMzJxUEQxRFNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E50D3095CDCDB42B750B5333FB391D4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f955ac33-de64-40f3-b356-08dca4bd4ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 11:00:15.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBsQuReAYzWpHXPR4EOScVUusxWOb2qMQPK+4EmJhngpLlTaZYl1ltErAni+Tie0xrri8jPXAygeE6JgBhO+3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 11:00:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16490

T24gRnJpLCAyMDI0LTA3LTEyIGF0IDE2OjE1ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMi4wNy4yNCAxNDo1NywgU3RlZmFuIEtvY2ggd3JvdGU6DQo+ID4gQXZvaWRzIHRoYXQgZTJm
c2NrIHdpbGwgcmVwYWlyIHRoZSBwYXJ0aWFsbHkgcmVuY3J5cHRlZA0KPiA+IGZpbGVzeXN0ZW0g
YWZ0ZXIgcG93ZXItbG9zcyB3aGlsZSByZWVuY3J5cHRpb24uDQo+ID4gDQo+ID4gSW4gZ2VuZXJh
bCwgY3J5cHRzZXR1cCBpcyBjYXBhYmxlIHRvIHJlc3VtZSBhIHBhcnRpYWwgZW5jcnlwdGlvbiwN
Cj4gPiBidXQgdGhlcmUgaXMgbm8ga2V5IGF2YWlsYWJsZSB0byB1bmxvY2sgdGhlIHBhcnRpYWwg
ZW5jcnlwdGVkIGRhdGEsDQo+ID4geWV0Lg0KPiA+IFRoZSBrZXkgaXMgZW5yb2xsZWQgb25seSBh
ZnRlciBmdWxseSBzdWNjZWVkZWQgcmVlbmNyeXB0aW9uLCB5ZXQuDQo+IA0KPiBPSywgdGhhdCBp
cyB1bmRlcnN0b29kIG5vdy4gUXVlc3Rpb24gcmVtYWlucywgdGhvdWdoLCBpZiB3ZSBzaG91bGRu
J3QNCj4gZml4IHRoYXQgZGlyZWN0bHkuIFF1aXJpbiwgd2FzIHRoZXJlIGEgcGFydGljdWxhciBy
ZWFzb24gdG8gaG9sZCBiYWNrDQo+IHRoZSBUUE0gd3JpdGluZz8NCmdpdGh1Yi5jb20vc3lzdGVt
ZC9zeXN0ZW1kL2lzc3Vlcy8yMDIzMA0KaHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVt
ZC9pc3N1ZXMvMjAyMzANCg0KVGhhdCBzdGF0ZXMgdGhhdCBjcnlwdHNldHVwIDIuNi4wIGludHJv
ZHVjZWQgdGhlICItLXRva2VuLXR5cGUiDQpwYXJhbWV0ZXIgInN5c3RlbWQtZmlkby9zeXN0ZW1k
LXRwbTIiLiBCb29rd29ybSBoYXZlIGNyeXB0c2V0dXAgMi42LjEsDQptYXliZSBjb250aW51YXRp
b24gb2YgYWJvcnRlZCAocG93ZXItbG9zcykgImNyeXB0c2V0dXAgcmVlbmNyeXB0IiBjb3VsZA0K
YmUgYWNoaWV2ZWQgd2l0aCB0aGF0IHBhcmFtZXRlci4NCj4gDQo+IEphbg0KPiANCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gS29jaCA8c3RlZmFuLWtvY2hAc2llbWVucy5jb20+DQo+
ID4gLS0tDQo+ID4gwqAuLi4vaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0
aXRpb24uc2NyaXB0wqDCoCB8IDgNCj4gPiArKysrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9y
ZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gaG9vay9maWxlcy9lbmNyeXB0
X3BhcnRpdGlvbi5zY3JpcHQgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtDQo+ID4gY3J5
cHQtaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zY3JpcHQNCj4gPiBpbmRleCBmZjRjMTM1
Li5mOTQzYWVhIDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1j
cnlwdC0NCj4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnNjcmlwdA0KPiA+ICsrKyBi
L3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiBob29rL2ZpbGVzL2VuY3J5
cHRfcGFydGl0aW9uLnNjcmlwdA0KPiA+IEBAIC03Nyw3ICs3NywxMyBAQCByZWVuY3J5cHRfZXhp
c3RpbmdfcGFydGl0aW9uKCkgew0KPiA+IMKgW29wdGlvbnNdDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oGJyb2tlbl9zeXN0ZW1fY2xvY2s9dHJ1ZQ0KPiA+IMKgRU9GDQo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGUyZnNjayAtcCAtZiAiJDEiDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCMgZW5zdXJlIHRoYXQgZmlsZXN5c3RlbSBpcyBjbGVhbiBvdGhlcndpc2UN
Cj4gPiByZXNpemUyZnMgd2lsbCBmYWlsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCMgZG8gbm90IGF0dGVtcHQgdG8gcmVwYWlyIGEgcGFydGlhbGx5IGVuY3J5cHRlZA0KPiA+
IGZpbGVzeXN0ZW0NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIyBlbnN1cmUg
dGhhdCB0aGVyZSBpcyBubyBhdHRlbXB0IHRvDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCMgcmVwYWlyIGEgcGFydGlhbGx5IGVuY3J5cHRlZCBmaWxlc3lzdGVtDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICEgY3J5cHRzZXR1cCBsdWtzVVVJRCAiJDEi
ICY+IC9kZXYvbnVsbDsgdGhlbg0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZTJmc2NrIC1wIC1mICIkMSINCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZmkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICEg
cmVzaXplMmZzICIkMSIgIiR7cmVkdWNlZF9zaXplX2luX2tifSI7IHRoZW4NCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYW5pYyAicmVlbmNyeXB0
aW9uIG9mIGZpbGVzeXN0ZW0gJDEgY2Fubm90DQo+ID4gY29udGludWUhIg0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmkNCj4gDQoNCi0tIA0KU3RlZmFuIEtvY2gNClNpZW1l
bnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

