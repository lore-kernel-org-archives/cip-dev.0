Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658CFC83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 05:44:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.15035.1752644653832076037
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 22:44:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=qh2Z5tIy;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752644635;x=1753854235;bh=bGFXHQO60TrBzpk3wYzqcUZe3mPLVMGSrV01eq2
	m2Fk=;b=qh2Z5tIyiy9m1+MEnlMYiGH2UC7wxOhmhUXlRxIo/F6k1xJ7kIlSroFHlhrrrleo5/4iS
	eIzxqx630ryWZ2Y47VqzPecf7TvC8MZcCc6MWhLsIV1WPKXkKXfh5TABQm4ji3l3p+C76TnMfjD2C
	IrNBKzc+Pbtn2en1gpijxXc4Tn9yZmDavwTZkXwH7L9vb5xZ8ylT+TVxGnAC4iXzwCvTIFMRzah94
	+rMtJ5Jb1o0xooKkNYv96+UXOxXbWA7WOZZ51q7l54T0yMSaZQFMkqFd13GhrcOl9/auWwMNi4yYx
	xdGFka+alpQS7kB1OLYnefcI6RAGBGRDWDwvXCP8Rw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 56G5hsaD3696348; Wed, 16 Jul 2025 14:43:54 +0900
X-Iguazu-Qid: 2rWhSHZE8Fw6QU7W2S
X-Iguazu-QSIG: v=2; s=0; t=1752644634; q=2rWhSHZE8Fw6QU7W2S; m=97hVZvm66XHpGyrm9odlhjqhdRi3HcCoxECYTwrwPkI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 56G5hqKC3795062
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 14:43:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd5JAgir0yxGSVkYOs4Qrcg+5R/n8nOJaHYcg7oAh5Lrjg+JFZJB2P4G4IC4jm6MKNwkBAoX2uTdOoOO+tsjcBvTktmpvcSMcoj942e/X3v/QsIVOWjstNOj6g8RsvHDu3Wr8X1ASZ7a4VCz6z4xI1k21Ej62hpEIJfgEjgVZWyNkSkxMov/iaIVCunE4Ag9Rt6B1ZGcs/XajWsyM6rROmRnZXpsalFEUajp6dl3frr2X4QtETB5AagZ45eR0OCWAkqQqKLKv9u7tKKMehHmW/sGaPVL5KtBztS2cVOUmPxKwD+SMXj5obHWgwY0rI3xFZopbUpx9W2U+TahH2MplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGFXHQO60TrBzpk3wYzqcUZe3mPLVMGSrV01eq2m2Fk=;
 b=QEGWimtWVzDa/YBqfuas6tABg/jCRVd39rEjIj4D3L93QBcsMBy8CuDbyN+6QBkaRpZagy98MBt/VN7RRpL/JuI06LpExVL5xjwcYzmS8zmvDiOnPu0gRcJN2pbKLIJC/RSUVYm0mbBw7h4YvAZIB8+hwjPznNQBJ0iVoR+U0O2pjbam8wH11yayY2pAwn2JuG2hSTQOlwn6VXT9gXcWnXTVcHoc7b0RiNlEzC5HkEf64co+D1Z7uIAWUtprCWEM6K0PUwRX0JBBEng0In5mN+zEDvFtRVY6Fc5pTk2JVNqDvNTDR5tDBuPgF97yOc0XHdN/doHD8c1jT9xK12rwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.19-st6, 4.19-cip122
Thread-Topic: Request for review for 4.19-st6, 4.19-cip122
Thread-Index: AQHb9aORvHAwJdvnSUqQma3vMeA/h7Q0PMWQ
Date: Wed, 16 Jul 2025 05:43:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818AF35C423F05FD71D3C179256A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <261306466.197838.1752596058568@webmail.strato.de>
In-Reply-To: <261306466.197838.1752596058568@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB13414:EE_
x-ms-office365-filtering-correlation-id: aeef9a0f-81a5-4124-808f-08ddc42bbdbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dmNBckZJV21QZUlpbmYvYnkzQnpTWG5kNWRUYldlK1pBNTJIWFlzLzRDSktl?=
 =?utf-8?B?RUhDNDNuMjdSemVFa1ZrN2h1cE44TWpDMElJc3l4VWllM0lnaEEwTEFJOVpy?=
 =?utf-8?B?OWZRRlZaVnlSQUE2THFYcEdXK2l4VWs1bUU1bk9TVjJNaEJIUFB2RG1JSEFy?=
 =?utf-8?B?K05rczlKR2NNT2YyWUhTT2NLNVNhdDQzTHpwR0UvVUNCbW4wVUQ3ZUtpM0JG?=
 =?utf-8?B?ZVRjakpsUm40VU5CelpqTzZCRGU1L2xEWnZVN0t0bjFOdkFXZmJNTFpycTVR?=
 =?utf-8?B?bHJaSDdqS1Yzcm1TcjZBekFRK2p3S3AyZGM1d0NuSmhzQ0JLaTAzTTMrTlN3?=
 =?utf-8?B?Y1NIWlZyUGY5NDQ3NnJBSTVPdm1wQjc1Q1dEdFNNaWFMd3JOck9DcEZwb2w3?=
 =?utf-8?B?U2h2dlh5aDRNTnNqamxvZnE1UVlweUZJNzRqQXhtOHV0Vjc0OTh3dkJXN1RM?=
 =?utf-8?B?YUVsWUZxNDU1aFprdHpvbmZTeXY2Ym1Sc1YzNHJrcUZOb3JzYnA1YTJ4bjhp?=
 =?utf-8?B?d0VSUGJOWk5xSFRTL0hwdjk3NEU5bXZuTThGdGdGMWpKZnJZcVB5aVNKOUhB?=
 =?utf-8?B?Q01vWGRlT1lJRExJUmx6d3pRaVNaZGEyUzg1V2x2UGV1T2xKcDNqSkxNRVdK?=
 =?utf-8?B?ei9ZVXlmSk5tYmVLTGNQM0FsNWN2dFBFK0JNUlE0RkRvTDFDRERzY1dlK20z?=
 =?utf-8?B?Vk1YV3NOUEtsUmovNFNkbWFHM1Zqc3JjbE5CM3U1djFnNG9ETVVCNFZpK1lP?=
 =?utf-8?B?bVVDd29md2RSVnZsN09ndC9uZkJ4V24wcEVUOWs1VERJM2ZVZGN5YWVtNXdK?=
 =?utf-8?B?ZDNOTDJ0Uk0vOXpnQjRBeGpZN0xxQ2x1c1pLSGRlWElRelRRNjRwa0pwNkFY?=
 =?utf-8?B?djhWSEg1ZFpyMVQwZUNNNUYyWEpvRHdPREJSNlhtL01nRXhUS1Rsdko4Rkxm?=
 =?utf-8?B?QW90SUZCY3RHY01GVlp6REhGaTU4RDRobzR5MFdCZ0tobG4zV0ZpZFdNeGdP?=
 =?utf-8?B?dzFiUk1ITU9BVjc3QVpuUjRPNHJ5a0tMUDV2Rk9xbE1SNjhPTGpZSDVEdzM3?=
 =?utf-8?B?TzZuWGdJSk1ES3F2NjJTTlplbW1MazdJRzUzWXJrNDJmM2MyWU1oaktybW1w?=
 =?utf-8?B?MFBhUnVvZU5DOGFmZXNuS2tGbjltQXZOclhJN2hCb0Y0bXdlL0xOUUVqNGM1?=
 =?utf-8?B?YmVZdUthSVVqZkhmNTNGbWs1R2pvN3BFNFBoVC9yV3FVVkc2N2lnbjJ4Y1hr?=
 =?utf-8?B?QWEvU3loekFkalc1NDZJb0JZMldqWnhUaW1ZRWVrTUgrN1YxUi9qM29pNmVz?=
 =?utf-8?B?Y29qUHFvaVQ1MXFELzlSNzlDRmk4aGFIbnpzVnViZjNpRnBEZ0MyTWFYSjZz?=
 =?utf-8?B?N3Q0eitUaDBSdG5XcnhKclF3a1ZHYUo2K3RXaFV6cnE1ekl0NlpPbzJlWHJR?=
 =?utf-8?B?NDRZL2ttalNQOGh6Y0lUT1cwUllqa0dPcWg4a21GS25KdVFZRU9QcUdzbDVi?=
 =?utf-8?B?WHNlblVaS1dTd3ZSRU0xdkcwSGc0b2k1TlVWbTduSWx3bTY5K1RPN25WVEFW?=
 =?utf-8?B?ckhENVVRbHhoWXhnZEdPMlJJdzdiVTAxSXdZbVZ5YlZHQVVjQUo3eW1HcE5t?=
 =?utf-8?B?UTVGanZZMDRMUFZHVHZxVHdjZnFpck5VVmFScVd1OUpPWHhVRVczOE1PazhG?=
 =?utf-8?B?VlVBYStobWpkc0dmcW5hM01FOTBzZ0hycWwxSW44WUtibUkxOU8rNTdMRlVl?=
 =?utf-8?B?Z0ptRTJjL3RxbG5PMGwzbFU3TTV2SVBGZXBuQndsWHRUTjBHK2owaCtrb3hN?=
 =?utf-8?B?OXZCVGJPcEthcXhnQnc1TGRFMzcxYkNYcnFMaS9Xdm9TSnhnSzcrRlZJUUN3?=
 =?utf-8?B?dlc5VkdvM0FuNzZOZUJPWmRiNS9ad1g3cjBjdG5TK1NGaVVZMmhiei9EMXcy?=
 =?utf-8?B?T0piSkZCOE9PYmhKWXZvKzkyaHRuR2pCZ1V4OGMwcjd2Q1NUa1pUSDRNNmNt?=
 =?utf-8?Q?u3jkqhpvq2KaRrKbv0QBeUOyZd3BgM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cWxvSEVCUzZvQXZ4TG1PeEdCMEhqZHd6S1l5KzI1bGJ1UkFHanlLRno4VWpj?=
 =?utf-8?B?YmFhbUlITjVXZlFhb1I3RUN2bnlMYTl1RnVMcXAvcnpxZTE2YnFKNS9QaGdO?=
 =?utf-8?B?YlBFOGo3bTNuSmhtRkgvVytoMzBoMGNIa2QzT1dwaVhENjFKb2dTOXpXNmsv?=
 =?utf-8?B?TGJRWWVjSllFMHFOdzlSaWl5MktRTFVsWGl3VEJZcnRncU5sNjNQMXlQOEh5?=
 =?utf-8?B?RU5PUkRlY0N1SjV0V3A3SmFJU0hFTHJUOTN4TWRZMnJaQXdXMlpnY3V5VHZn?=
 =?utf-8?B?eGZRbkpCTm1IbVU2azY2bytLdmZFWXd2Q1RNR0sxcWgrcC9qUDNlN2pCVzky?=
 =?utf-8?B?emZTVWNQbHZhQWw3c3hzQmQ5K1A4RURKTzNHY2hrZjRaTWE4RTBFQzFyaVpZ?=
 =?utf-8?B?MXVzZWxmYzhlQXg1VnNlZTFYUDI0UERVSk9Pb0JBOFRXQ0phM0RtdGcxaXpt?=
 =?utf-8?B?bURmR2grNFZwNjk0YXlBNFBCUDdZWkNwTGFIWTBLTjVYTnZQU28rWG91OGdG?=
 =?utf-8?B?NTIwTUMrakV4SjFGU1ZKZkgvNEZyaXJ5TmdOWmlXQVFqTzdGeXVKNlkxR2R5?=
 =?utf-8?B?VE8wbnNOYjlMR3dEaUd6UUUyUzdXQXhOQ3FTODQyekZZR3dYSFBCcnNuOFow?=
 =?utf-8?B?cHA2ZXhaTUJZdG90aEVuNzRybERrYVNyRnc2VGozekxDNmFETGNpSHkwM0Nx?=
 =?utf-8?B?ckg0L0lXNXFsSlJCYTJrKzVKLytGZHhNeXVENXkvVUMzL1BhM2xDR1N1dzgx?=
 =?utf-8?B?dUxZS1RYdFVKSHFyZTZTbHE5dHhFZ0lYbHo2YmFYUEN3dlRZcm0yQkZXQTVM?=
 =?utf-8?B?UnNSRGlpeWhVSXNJZzB3NWl5akdmVFhmeVZiNENoRlJKS1VLYTVya1doTitl?=
 =?utf-8?B?VjVZcjk5QUY2MWlmMkczTTFQUkVsQ1NJNGt3akU0U1ZIZWF3RWxPaVpyRk1U?=
 =?utf-8?B?cElPQ0JueXpURy9RM2hBTFpPeTlFZ3c2NXRmMHNxWWEzZ0ROYzhWdlI4NjVR?=
 =?utf-8?B?eGprQmpYVWJVSnc5TjgvNkRLNmwyRTEyUzhZOHphU1ZhRGt4VlpOSmxoUnhS?=
 =?utf-8?B?WTlDWjdtMmpFdTVQbUxyam93YVQzZjExY2ZrUm1neWlKYis2a2RyWUdrM0FX?=
 =?utf-8?B?V0RqeHJ6a2V6UVpJNC9sNXgwNFRNMi9mL1diSGZRL0d4MkRNb1luUjZ5NGNa?=
 =?utf-8?B?SEJURGJEb2tsOHc0Yng1ZWk5cTU4UXQyYk1Cd1hIRTBZT0Vab2lFemgxYVQ3?=
 =?utf-8?B?VW1rRFJOY21ncW1TRHdTVUd2dlVjMDl6dWNwU3UwREQrTUNzVmw5ZHRhOXRi?=
 =?utf-8?B?eXVUR2pSUFJpOFIvTlVkaTIwVkJLY1B4MVBjMFFEaHdqRHN3NytHZTF4ei9p?=
 =?utf-8?B?UStBNWVHTTFsZTBYRE1uMzNYSnQ4M083bVA5ejlUZE1vMEhVbzNmNDVwdDgv?=
 =?utf-8?B?VG8weDJsckNXdUN6Vkl5YmZRaGMwYzI3NXlUSE5uZVVjN0tkNXRscUJzTVZJ?=
 =?utf-8?B?YzBGbWZJNGQzVy80YmNsRXArYVR1TEtZVGh2OGY4QU9OZ3RnanROV280VHZO?=
 =?utf-8?B?eFNBWGJ2bFF3VGhBWkxHV3JUbGVwS0FURDRlbW1IMm9LckdMQ1EyYWNtMVkv?=
 =?utf-8?B?ZEhpb3JwOHFjRTB4Ry9qZUZyMXc5QmVQb2hSeFR2ZEpxQVRUdVBRVytGRHhR?=
 =?utf-8?B?UHM5M3A5dHd0YzIrRE9WNGMrMU1iNUZzUmhNajN6d3NnUHRlTzZ0R1pRS1pV?=
 =?utf-8?B?dzdHei9aeUFwWGlJd0c3eVlyNWhiWmxjcnd6K1FDTDVQWXBZZFpJeFhZaDd4?=
 =?utf-8?B?eFVYM2ZiZmZNTWhSNGp6RDVMOExQdlN5Zy9IaE5zZ3FKVGFaRytBMDJtZ0Zw?=
 =?utf-8?B?RWFwdTVWUVVtME5JVEF2cHFIaTl2NDlBVFQvN0VDbXpUMzNuRVJVMHUwYlY0?=
 =?utf-8?B?cnYxQTNrZTF2ZUdmSDdObTkyRStQS25EUWd2VDJxbEdEVEdMS3hiK21zTHNh?=
 =?utf-8?B?UkprcERyeWhWeVhEZlFibFlRZTV1OHBjOWI2Z1o1NnpPd05OczBtQVFzSitK?=
 =?utf-8?B?N3F4THErd0pwbnJvc3EyOThGMEphTFN3UkFTTEtJOGdaNDY3ZUFyZmFyVDV4?=
 =?utf-8?B?ZG5pRUpWNGFkT3JZUzlJSy81dTBHVnI5RnR5VW8zZHZ2ZXlCRTIxNG9WcUVu?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeef9a0f-81a5-4124-808f-08ddc42bbdbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 05:43:50.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APtscXthNJ5QSmI10iBzSl+7YwJKUoK9Ai7OBqLmtXy4eWWPxjdDfGO7MT4MsmxjJvHNcFU6BFUk/qrZagmIPV8aKeUFCdoL46ZTffBxRVoo+Hq7Ptu3OImJdSEFhqYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13414
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Jul 2025 05:44:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19545

SGkgVWxyaWNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmlj
aCBIZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTYsIDIwMjUg
MToxNCBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbngu
ZGU7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6ENCj4g5rSLIOKWoe+8pO+8qe+8tO+8o+KX
i++8o++8sO+8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0
OiBSZXF1ZXN0IGZvciByZXZpZXcgZm9yIDQuMTktc3Q2LCA0LjE5LWNpcDEyMg0KPiANCj4gSGkh
DQo+IA0KPiBIZXJlIGFyZSB0aGUgbWFudWFsIGJhY2twb3J0cyBmb3IgdGhlIHVwY29taW5nIDQu
MTkga2VybmVsIHJlbGVhc2UuIEFzIGFsd2F5cw0KPiB0aGV5IGNhbiBiZSBmb3VuZCBpbg0KPiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgt
Y2lwLmdpdC9sb2cvP2g9bGludQ0KPiB4LTQuMTkueS1zdC1yYw0KPiANCj4gYzQ4MDEzMDQzYjA0
OCBBUk06IGR0czogYW0zMzV4LWJvbmUtY29tbW9uOiBBZGQgR1BJTyBQSFkgcmVzZXQgb24NCj4g
cmV2aXNpb24gQzMgYm9hcmQNCj4gNjI3ODgxMTI2Y2E2MiBtdGQ6IG5hbmQ6IHN1bnhpOiBBZGQg
cmFuZG9taXplciBjb25maWd1cmF0aW9uIGJlZm9yZQ0KPiByYW5kb21pemVyIGVuYWJsZQ0KPiA0
MWRjNTg3NzQ4NWU2IG10ZDogcmF3bmFuZDogc3VueGk6IEFkZCByYW5kb21pemVyIGNvbmZpZ3Vy
YXRpb24gaW4NCj4gc3VueGlfbmZjX2h3X2VjY193cml0ZV9jaHVuaw0KPiA3OGViMGRkN2E2YWUx
IHNjaF9oZnNjOiBGaXggcWxlbiBhY2NvdW50aW5nIGJ1ZyB3aGVuIHVzaW5nIHBlZWsgaW4NCj4g
aGZzY19lbnF1ZXVlKCkgNGJhNjhiYjU5NTUyYSBicmlkZ2U6IG5ldGZpbHRlcjogRml4IGZvcndh
cmRpbmcgb2YgZnJhZ21lbnRlZA0KPiBwYWNrZXRzDQo+IDI2MjU4ZjdkZWZmZTYgdnhsYW46IEFu
bm90YXRlIEZEQiBkYXRhIHJhY2VzDQo+IDJjNmQyYWY1YmZlZTggaHdtb246IChncGlvLWZhbikg
QWRkIG1pc3NpbmcgbXV0ZXggbG9ja3MNCj4gNzZhNjA1ZGU1MTMyOSBuZnM6IGhhbmRsZSBmYWls
dXJlIG9mIG5mc19nZXRfbG9ja19jb250ZXh0IGluIHVubG9jayBwYXRoDQo+IGRjMTEyYmU2NjI2
NmQgc2NoX2h0YjogbWFrZSBodGJfZGVhY3RpdmF0ZSgpIGlkZW1wb3RlbnQNCj4gYzVkZGQ1ZDkz
ZjQxMSBBQ1BJQ0E6IEF2b2lkIHNlcXVlbmNlIG92ZXJyZWFkIGluIGNhbGwgdG8gc3RybmNtcCgp
DQo+IGFiMmZjZDA3NTNmMGEgZjJmczogcHJldmVudCBrZXJuZWwgd2FybmluZyBkdWUgdG8gbmVn
YXRpdmUgaV9ubGluayBmcm9tDQo+IGNvcnJ1cHRlZCBpbWFnZSA0ZjRjMmQ1MGU2YTBhIGYyZnM6
IGZpeCB0byBkbyBzYW5pdHkgY2hlY2sgb24NCj4gc2JpLT50b3RhbF92YWxpZF9ibG9ja19jb3Vu
dCA0NDIxNWVjYTc1ZTdkIHVzYjogdXNidG1jOiBGaXggdGltZW91dCB2YWx1ZQ0KPiBpbiBnZXRf
c3RiIDg5YmM2MjY0OTU5OGEgZHJtL2k5MTUvZ3Z0OiBmaXggdW50ZXJtaW5hdGVkLXN0cmluZy1p
bml0aWFsaXphdGlvbg0KPiB3YXJuaW5nDQo+IA0KPiBUaGFua3MgZm9yIGhhdmluZyBhIGxvb2sh
DQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgdXBkYXRlLg0KSSByZXZpZXdlZCA0LjE5LXN0NiwgTm8g
aXNzdWUgd2VyZSBmb3VuZC4NCkkgYWxzbyBidWlsdCBkZWZjb25maWcsIGFsbG5vY29uZmlnLCBh
bGx5ZXNjb25maWcgYW5kIGFsbG1vZGNvbmZpZyBmb3IgeDg2LCBhcm02NCBhbmQgYXJtLiBUaGVy
ZSB3ZXJlIG5vIGJ1aWxkIGVycm9ycy4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


