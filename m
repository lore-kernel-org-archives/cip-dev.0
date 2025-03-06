Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84A6C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 09:35:21 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.15])
 by mx.groups.io with SMTP id smtpd.web11.8943.1741253718322401859
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 01:35:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nbAAE/tU;
 spf=pass (domain: siemens.com, ip: 40.107.159.15, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE7+8mL31fxNvpHurTRoEpqc5d7PksM++Vjgtaw+wLKy3K7CoT1ODUxTwEGuVgwqXoH/pK3x2HnpdBUFFHmX+Eo91izmdDKJBLG45B7axXm9E8HS3x7qA7qVnDtpJbuCczM2kQ5ennfW6F5iQl7VWrreTfSRxRU7ypP1QEixUYm2OXcerYmJJwT4VlqN+GfTx+OhmvQMTe6GgCE8L1dL4fFzW4fiWpKol8//SqhbSQfoVmQkGFdldvy8VyZWxBJ7hWmRPvMc8jX06P5KChy3/e6aaTPq441GJpi/bp5ggUIQlHxVJ7NKH01v3fuHzEvl2mkJM8Hn3irhnCRNWzIGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiIinovDtPD+vW1gjfm4moGAXjoUdetG4yoCpfj9SWA=;
 b=E0qp/gVxnTTl4zJ4wcwYuVUjmEOh9nBJY/d3RXM6ZhToNBCqMDsgddwwOoDaJqnGtjHSWafiRUQ4H4KdUVmvTuwh5hMoUkQIKu+WJpOZHR4bdtzRq98YDQ0x73HMH71MiX2lE3D+hNrMZ5QB+5ulfYDvWxE+sML6biTlxUzFyuFhhNmzm219hGEvZLU28ApbM5OGbuEWV71H3Hn2TGLczaD/oaVU8P+hv0co0RgcHrZZgjwdomCsBXV9YAwHV/sznviwEVowx2KlRWnusqSximoXXbfWz9SjgBsShcl9MjX3IPar552jzS+cHvfEr73BqH3Wycuj2Sd7jrODy4u4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiIinovDtPD+vW1gjfm4moGAXjoUdetG4yoCpfj9SWA=;
 b=nbAAE/tUCXaN0gsrRCfBCCH6WGBTLwXFFdMtbXwX//MbSx86ohL8ryC967lm2uRGEa6jBhxFb+WDL2VbCkrxK+2qmdL4WxRebgbz7Bt4hilIuv1eGZCBz0cfnGRO5Mk4Nk8PCvYCzuU8N9jTpR8ZUdK5hnMYuCSWnxmv7n2rpRwGS7hBRBEOoGU0WXb+9RUPGUMHrhUt6MnU9rDMt3EITMze8Vibajjv16PY3t0r1Niz95KI/e5mkEIh1p3SDfyAOtRPV6ckhyegO+Q+hB5KT9bLdCNUsFwj5TZxI0wAcuaJzDkLx7dEVOT4bxL4fYvM3XrZS4uUduMj6NUjGn91DQ==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by AS8PR10MB7561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 09:35:13 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 09:35:13 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, Claudius Heine <ch@denx.de>
Subject: RE: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static
 temporary encryption key
Thread-Topic: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static
 temporary encryption key
Thread-Index: AQHbjcZjg721RQXf2k2xxOWIjwaZ/7Nl1W6A
Date: Thu, 6 Mar 2025 09:35:12 +0000
Message-ID: 
 <AM7PR10MB3320E9FCB6FBE8D3FA69DA0686CA2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
 <20250305-initramfs-crypt-hook-patches-2-v4-2-4170912e5261@denx.de>
In-Reply-To: 
 <20250305-initramfs-crypt-hook-patches-2-v4-2-4170912e5261@denx.de>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=f975cd4d-d629-4bfa-ad52-19760c1a2552;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-06T09:16:49Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|AS8PR10MB7561:EE_
x-ms-office365-filtering-correlation-id: 8d0377bb-72c5-4a73-3ebf-08dd5c923204
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VTVOc3ZYSHhHeVN3cUZtemUzN3duYldZNmMyMFBvMnFLTXZVUlBkMHRSbEgy?=
 =?utf-8?B?SllxdHA3Z2R1a0w5bFBvWFErUHc5eU9mVklTOUhYS1Q4aE1qOEV2dllRTngx?=
 =?utf-8?B?SUY1SFFsZTNUUnAyZ2FSZFFuNjN4K0hZd1dHdm9ya2lrc1VXWWQvWm50enF0?=
 =?utf-8?B?dGhNb1ZuTVN2QnhVekFDek4yNU9vcnZvcURSR29RaVVFaklieFZhbWR3eklE?=
 =?utf-8?B?MzBQQkppQU9sUjBTcWFyZlpmRUZtN0graS93RTZrNHd1VnR6dmdYeGg2cWhL?=
 =?utf-8?B?SzFqeU5PUFpuN2NocnptZ1B6d2JhZVptUHRjZUREckkvazZ0OEF1d1pJSjF0?=
 =?utf-8?B?d3A2Rk9OWlBmWE1mZm1VZ25Cdk5aTXZhTEQva1J1L2Q2aGxxZzAwWFplVmNN?=
 =?utf-8?B?ckkrTXpDQnQ4NURCZUdTWlp4UHZUYWEzaXNIK2QvRFlDa3RRS0Y2YVAzNjJo?=
 =?utf-8?B?aENQWlFqUldMaTA0bjhocGRtaFFhMjBXVWUrZVNJbFlrZWJsZkpEeXpnSHV3?=
 =?utf-8?B?U1oxY2VGRUJ5ZFk1UGVqRUN0blJ0R25oY1BjZjdHUGVaUGV0MStZSk5uV0dZ?=
 =?utf-8?B?QWJNbW1mYUtQc08xTUMydm9yTHRZcDZsQWE0TVhlNUFvUjY0bklKVUY1bC9p?=
 =?utf-8?B?OUplK1lReWhzdVI2OWxSSGgyZUUxbkRPYk5uWk1RU2NZUWNpSTRoRU9TMWVr?=
 =?utf-8?B?UmNtUThFSkY4RmFCMFJhNFRuQWVaNFdKOHNhQzhlYXpFMTltWHFCb1JGcDM1?=
 =?utf-8?B?NGNLWThmeEVtZkxNRHVFbGZuYkVrTnVsRDd4VW55d0ZCUW1SeWRjbmdvcHhn?=
 =?utf-8?B?YXhSTEx3SFMxUHlkMk8vSmdtQ3ZyWG9ycmhRVkx0RHY4M3g5aU5LeklPdSt0?=
 =?utf-8?B?NmNqQk03R1Z6VUtLd1pReHBNYWhOUXcwYVV4OU16WTYvTDJIUmNnbVF6OHEz?=
 =?utf-8?B?YWZ3VFhNMlRKVWtKT1VLUFNZY053cHNQOHBzOG1zK1dDbzRxaU9ZaU9keE9W?=
 =?utf-8?B?d295QVJUamtHOXhucDFvaUc2TWxlVklqTUVYMVlzcGpLd0wyTVl3ZzlYNDhy?=
 =?utf-8?B?bjdGSk91RXJWVzcwaFJ3dXFFSkZ6STRvcnlkYU0wQ2NFaFBKaVcvNE9aVnhw?=
 =?utf-8?B?YlZsMVpkQ3c0VlFvR1pGaG5WQWR4Si9jSU5FK1Y4STVZSGR3OWhRcmh1b05a?=
 =?utf-8?B?ejBCUGFJYUFtcjJwK2gvYnVXZ0hyUExBRGhyUUpVN0dSZUdzL0J3TFRaR0F3?=
 =?utf-8?B?VmlrZVhJZE5aOHp2RDhyZ3RMT3pLTzdBazBaNjVyNzNlUC9WQVc4SEFJUlVJ?=
 =?utf-8?B?UlJHdUZNOGh0b2REdldvUm1KZ1hxMFBOVytxODlqMGRWajQ3T21seHRpVTQy?=
 =?utf-8?B?bVl4WmowNEpualZnSTFrMWlLaEsvZURKQjRqN2NuMTJmOW11dVNPQzVBNFJK?=
 =?utf-8?B?Qk92d3lBWHBjZ200UjhrVXNPcnl2QUFkNVZmUE1tOHh3VWlkcjdGTngvQVQ0?=
 =?utf-8?B?NGlKOUF6REE1VTg2UGh4dUdLSVZ3WUd1M0lrcVBKcDlsTWl4ektUcHljNGJM?=
 =?utf-8?B?Z2tZR0YzcWNTYmRYeGw3YmdpZG5uZ1l2MUZFQ2pwOURycVR3R1VWRGxtTnJq?=
 =?utf-8?B?SUc3Slp6dzhETDFURHM0V2hEOG1DcXl0RWJiMnI4cStiWXZTelBmS1ZXU3Rn?=
 =?utf-8?B?b1RoNEQxYUFvaGZBallEb1VaWExNcitrT3ppNXpaMWR5a1lvNExEZFFicWRu?=
 =?utf-8?B?R3VGUmF6R3pieUk2YTFBR08zeGhkaThmbzZZNjlpK2Rtbjlkek5lcVpzRHZx?=
 =?utf-8?B?MWZYWHZPZFA1MkRFWS82bFEyRFRlUWEzMitQVVFKdERjcktYejFNOGVzYXNX?=
 =?utf-8?B?T0pXSnI0cHNHemFuemY2aE4vWThzV1VJMjhMYkFteDVhaldpV1lnOWkxdGF4?=
 =?utf-8?Q?xKkisoVXaDRAcdWf8xkJ05efpG75p+b1?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L3BhdngwbnVNQzFWNEZSM2N4cFNKMnBJdlNOVUVUdUxZaEY3NGkvQzJqTmF5?=
 =?utf-8?B?Q0JEaU12RWZpbCtjSDI4ajR5bEdjWVNOejJ5TkJoVC9iTUZ5U1A0VHdkc0hK?=
 =?utf-8?B?cjN0OU1BUitQZ2xHQjR4Z1QvMERtNlpubFl1Nm1GSGlUajVKblBCUEdmM1Nh?=
 =?utf-8?B?eHBOWGd3N1R2WEd1Ylg2and0NHAyWEZ5b2Y1ZHgyMWpRTEhLN1lqQ2ZLNCt0?=
 =?utf-8?B?NHh3d21La3dHMVVYWkNCZitoTlpxYlpzWEJDYWlad2tuNXRMK1dQK3J0OTBE?=
 =?utf-8?B?aCtYRXkvZjB4SWZNelB4bU4zbUN2S3dneGlsaFBxdUthRHFxTEt2QnB4YnpX?=
 =?utf-8?B?dnhvZS85UllVbjIxaFJkTnNDQmt1SVFxTnMvaU44SENwMDVLbzB4Tk1tVnpt?=
 =?utf-8?B?d2tDME0wZEpRd0VadldWbEtLVDhhSUpkZzFQbjR0ZDA5cTFKQ3dwUzZpMkNv?=
 =?utf-8?B?Z2JhelIvS1o0UTE1dzY1V01wZXZ6bFZxdFN0VmZpdTlSN3VQRG15Q0lEU2FS?=
 =?utf-8?B?MHNlZ3NHdlZ1aFZHVDRCWVVPY0NEVFdrZ1F5TFJXT2ZNTkRGNytweW9XS1kz?=
 =?utf-8?B?RkdVWlBvSjFGWkJPVzF3SzdRWGxIbDZWTlNYY2E2RjdsWDc0UmZlRnFrUnNy?=
 =?utf-8?B?YktUTmlTTjlMbUdJWENIK3NMNDFUbERxTDlISEl4cWttb1JKenl2MWF2ZzNY?=
 =?utf-8?B?ZFNzY0RiQzNlQlU4YWd6TExSaWlKeVVEZ3lnLzlibWI4NmRpdDhrWmxFTW9r?=
 =?utf-8?B?Vkd5eS91VmR1V3lGemZLWDZGV3lBOG12cS84L0kvekFkU3JRWVdBRUduTDJk?=
 =?utf-8?B?a3V0RWRlN3IzR0wrV0FPaWRZRWZybFEyd0xrRTVmVTBpTXVCQkE4L2ozYjB1?=
 =?utf-8?B?SXRPM01YVnAwRGVveVdESThMYUZ6RENqMnVMdmFEdEc1K2w2aXpLTXowRmRa?=
 =?utf-8?B?cVlsU3YxWjRwZHROOGZBWWlJMzdBc3lWSWZERWJWVTNVVjVaZGIrdkNPVGxZ?=
 =?utf-8?B?ajhucWUrMWN4N1NaVW11bS9sVDFBNHNyTU91YWRzNW95QXdTUDZ1SHhEVGpK?=
 =?utf-8?B?cDFxU3dyaHNjaTd5Rlh4c01KRy9LMG1pYmZZUzEzUlJIQ0tZNmxTWWlXNWh5?=
 =?utf-8?B?UXg0c0svZzFKRE5vMVp5R3lBeU4rMlBxQWFwTEdoRnJzYnVEN1JPQ0N5eWV4?=
 =?utf-8?B?LzR1K2taT0NlR1lBalB5Wnp5WENJdCtLN0VQdmxlbGxDcGx0bkVMcXRkaVow?=
 =?utf-8?B?aG12MGp5akZ5WjVUWXkwZENwNGxTOHZqb1dGRFlUc0U5aEZiUDR3NDcvUENU?=
 =?utf-8?B?V05OTEx0ZWhZYnY3UC9yakdWc2pqbHh3aEVRQU5aaVhEalUwdE9IbzdpYUxR?=
 =?utf-8?B?RXhCZjk2aWY0YjlUQ2oyckJ1enV4ZWFVeEk1TmFiOVJFNklxQVpZc1Z0VDFz?=
 =?utf-8?B?aW41d1VrSUFQSXZsYjJKZHhubUkrWjJlbWV2aGhXQ3g2aUhNZ3JSK1NDL3NW?=
 =?utf-8?B?MExnWDUrUkFodFJrbWpYTUk1Z2hjQUd0WkNtSjc1UUFoUnk0Q244WHh4NDV1?=
 =?utf-8?B?M0hCWlUxZFEvNStjdmVjdTZGOTRpZWdvR0c2Sy9GSmlrV1VhWExZRnN1WElo?=
 =?utf-8?B?Nno2NUxKVlFqQ253TVRzSVF0Q2lSU2o4NkZWN0RrUTR2T3FNZTZiRERkejk0?=
 =?utf-8?B?Q2g4cTlKQ0tudXVQNzJaakFPS3o5MGp1UjN0YVhWSnkwaC9xWkwvY2Y4MDNJ?=
 =?utf-8?B?cDJmclI2bkFhRk5qZ1hrZUlKeW9QUUsrdkU2L29JZ2ZkTUhLT1Y0bzNBMnBU?=
 =?utf-8?B?YVpPZWRMcG9xUXhRZEdYVTQ4dUJyek5yNGxOTmE3M2dwZGdlcjRPYVJoSFE3?=
 =?utf-8?B?N2dUb3BDbUJzUXozajRqcngydmwxNUFXUzk2cDF3NFJ2Y0dZWUVScGRML2h6?=
 =?utf-8?B?UnBTNWpkTDFud2pWQ3UrNFMzUU5wQlQ2YlJQdDV2NGpRMy9RWHpEOHJjbWhK?=
 =?utf-8?B?SUhuSExqSXRNSkZsVVptSW1NS3FQQW5BWnJKYXBkUjVBWmhncVdCMkRFK0tP?=
 =?utf-8?B?SDdCSysvS2lJVnIwTHdiMHpmVlRXSk5PNFU4Y0VxTEZGN2VjS24yM2VIRHhB?=
 =?utf-8?B?VG9FSTFFSXhSbktqV0ZYRTdxY2tidVpuNzdYMXdFQ2ZsNDVDQnNDdEFpNWJ5?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0377bb-72c5-4a73-3ebf-08dd5c923204
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 09:35:13.0048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UNkkkmOmdO6L4Er9SEac0ixoENBuesISEyLgR5IfgIr2hwNFGGk96ipt1pRgA9G3ZFthnzcH4mFj+45+ylXf7B+hbO8Yqt4/vTLpDOYB/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 09:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18052

PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBDbGF1ZGl1cyBIZWluZSB2aWEgbGlzdHMuY2lwLXBy
b2plY3Qub3JnDQo+IFNlbnQ6IE1pdHR3b2NoLCA1LiBNw6RyeiAyMDI1IDEzOjAwDQo+IFRvOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogS2lzemthLCBKYW4gKEZUIFJQRCBD
RUQpIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPjsgR3lsc3RvcmZmLCBRdWlyaW4gKEZUIFJQRCBD
RUQgT0VTLURFKSA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT47IENsYXVkaXVzIEhlaW5l
IDxjaEBkZW54LmRlPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gW1BBVENIIHY0IDIvNV0gaW5pdHJh
bWZzLWNyeXB0LWhvb2s6IHVzZSBzdGF0aWMgdGVtcG9yYXJ5IGVuY3J5cHRpb24ga2V5DQo+IA0K
PiBVc2luZyBhIHRlbXBvcmFyeSByYW5kb20gdmFsdWUgZm9yIHRoZSB0ZW1wb3JhcnkgZW5jcnlw
dGlvbiBrZXkgbWFrZXMgaXQgaW1wb3NzaWJsZSB0byBjb250aW51ZSBlbmNyeXB0aW9uIGlmIGl0
IHdhcyBhYm9ydGVkIGF0IGEgbGF0ZXIgZGF0ZS4NCj4gDQo+IEluc3RlYWQgYSBzdGF0aWMga2V5
IGNhbiBiZSB1c2VkLCB3aGljaCB3aWxsIGFsbG93IHRoZSBjb250aW51YXRpb24gb2YgdGhlIGVu
Y3J5cHRpb24gcHJvY2Vzcy4NCg0KRHVyaW5nIHRoYXQgcGhhc2UsIGFuIGF0dGFja2VyIGNvdWxk
IGRlcml2ZSB0aGUgdm9sdW1lIGtleSB1c2luZyB0aGF0IHN0YXRpYyBrZXkhDQplLmcuIGBjcnlw
dHNldHVwIGx1a3NEdW1wIC0tZHVtcC12b2x1bWUta2V5YA0KDQo+IA0KPiBTZWN1cml0eSB3aXNl
IHRoZSBwYXJ0aWFsbHkgZW5jcnlwdGVkIHZvbHVtZSwgd2l0aCBhIHN0YXRpYyB0ZW1wb3Jhcnkg
ZW5jcnlwdGlvbiBrZXkgY2FuIGJlIGNvbnNpZGVyZWQgdGhlIHNhbWUgYXMgdGhlIHVuLWVuY3J5
cHRlZCBwYXJ0aXRpb24gdGhhdCB3YXMgdGhlcmUgYmVmb3JlIHRoZSBzeXN0ZW0gaGFzIGJvb3Rl
ZC4gU28gdXNpbmcgYSBrbm93biB0ZW1wb3JhcnkgZW5jcnlwdGlvbiBrZXkgc2hvdWxkIG5vdCBh
ZmZlY3QgdGhlIHN5c3RlbSBzZWN1cml0eSBpbiB0aGF0IHdheS4NCg0KRm9yIG5ldyBkZXZpY2Vz
LCBkdXJpbmcgZGV2aWNlIGJvb3RzdHJhcHBpbmcgLyBzZXR1cCB0aGF0J3MgcHJvYmFibHkgdHJ1
ZSwNCmJ1dCBzdWNoIGFzc3VtcHRpb24gaXMgbm90IGdlbmVyYWxpemFibGUhDQpCdXQgZXZlbiBp
ZiBpdCB3YXMsIG9uY2UgdGhlIGRldmljZSBpcyBpbiB0aGUgZmllbGQsIHByb2JhYmx5IHNlbnNp
dGl2ZSBkYXRhIGlzIA0KYWRkZWQgZHVyaW5nIG9uYm9hcmRpbmcgb3IgZ2F0aGVyZWQgZHVyaW5n
IG9wZXJhdGlvbi4NCg0KVGh1cywgb25jZSB0aGUgdm9sdW1lIGtleSBpcyByZXRyaWV2ZWQgKGFz
IGRlc2NyaWJlZCBhYm92ZSkgYXR0YWNrZXJzIGNvdWxkIA0KcG90ZW50aWFsbHkgdW5lbmNyeXB0
IGNvbnRlbnQgYWZ0ZXIgeWVhcnMsIGdldHRpbmcgYWNjZXNzIHRvIHNlbnNpdGl2ZSBkYXRhIHdo
aWNoIA0Kd2Fzbid0IHRoZXJlIGluaXRpYWxseS4gDQoNCkJSIEFsZXhhbmRlcg0KDQo+IA0KPiBJ
dCBpcyBqdXN0IGltcG9ydGFudCB0byBsZXQgdGhlIHJlLWVuY3J5cHRpb24gcHJvY2VzcyBwcm9w
ZXJseSBmaW5pc2ggdW50aWwgdGhlIHRlbXBvcmFyeSBlbmNyeXB0aW9uIGtleSBpcyByZW1vdmVk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdXMgSGVpbmUgPGNoQGRlbnguZGU+DQo+IC0t
LQ0KPiAgcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMvbG9jYWwt
dG9wLWNvbXBsZXRlICAgIHwgNyArKysrLS0tDQo+ICByZWNpcGVzLWluaXRyYW1mcy9pbml0cmFt
ZnMtY3J5cHQtaG9vay9pbml0cmFtZnMtY3J5cHQtaG9va18wLjYuYmIgfCAzICstLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMvbG9j
YWwtdG9wLWNvbXBsZXRlIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2sv
ZmlsZXMvbG9jYWwtdG9wLWNvbXBsZXRlDQo+IGluZGV4IGFlMGRjZWY0Y2I2MmExMzViZWI2ZDQy
MjkyMzcxNDRiNmQ0ZWRmOGIuLmVhOWI2MzUyZGFhZGJlYTYyNWQ2MTY4ZDFkYzc1YWQ2MTYwMjhm
ZTAgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29r
L2ZpbGVzL2xvY2FsLXRvcC1jb21wbGV0ZQ0KPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0
cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10b3AtY29tcGxldGUNCj4gQEAgLTI1OSwxMCAr
MjU5LDExIEBAIGZvciBwYXJ0aXRpb25fc2V0IGluICRwYXJ0aXRpb25fc2V0czsgZG8NCj4gIAkJ
d2F0Y2hkb2dfcGlkPSQhDQo+ICAJZmkNCj4gIA0KPiAtCSMgY3JlYXRlIHJhbmRvbSBwYXNzd29y
ZCBmb3IgaW5pdGlhbCBlbmNyeXB0aW9uDQo+IC0JIyB0aGlzIHdpbGwgYmUgZHJvcHBlZCBhZnRl
ciByZWJvb3QNCj4gKwkjIHVzZSBwYXJ0dXVpZCBvZiB0aGUgcGFydGl0aW9uIGZvciBpbml0aWFs
IGVuY3J5cHRpb24gcGFzc3dvcmQsIHRoaXMga2V5DQo+ICsJIyB3aWxsIGJlIHJlbW92ZWQgYWZ0
ZXIgdGhlIHJlZW5jcnlwdGlvbiBoYXMgZmluaXNoZWQgYW5kIHRoZSBUUE0yIHRva2VuIGlzDQo+
ICsJIyByZWdpc3RlcmVkOg0KPiAgCXRtcF9rZXk9L3RtcC8iJChiYXNlbmFtZSAiJHBhcnRfZGV2
aWNlIiktbHVrc2tleSINCj4gLQlvcGVuc3NsIHJhbmQgLWJhc2U2NCAzMiA+ICIkdG1wX2tleSIN
Cj4gKwlibGtpZCAtcyBQQVJUVVVJRCAtbyB2YWx1ZSAiJHBhcnRfZGV2aWNlIiA+ICIkdG1wX2tl
eSINCj4gIA0KPiAgCWNhc2UgIiR7cGFydGl0aW9uX2Zvcm1hdH0iIGluDQo+ICAJCSJyZWVuY3J5
cHQiKQ0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhv
b2svaW5pdHJhbWZzLWNyeXB0LWhvb2tfMC42LmJiIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJh
bWZzLWNyeXB0LWhvb2svaW5pdHJhbWZzLWNyeXB0LWhvb2tfMC42LmJiDQo+IGluZGV4IGRmMzM1
YzlmNzVkNmU3NGIzZTE2NzY4OWVjOWM3M2RkMzc4MWE4OTAuLjY5ZDIwNGU5NTM5YzJlNTAyNGRi
ODMyZTViMzA1ZmU3MzM5NjMxN2IgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2lu
aXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy1jcnlwdC1ob29rXzAuNi5iYg0KPiArKysgYi9y
ZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9pbml0cmFtZnMtY3J5cHQtaG9v
a18wLjYuYmINCj4gQEAgLTE0LDcgKzE0LDYgQEAgcmVxdWlyZSByZWNpcGVzLWluaXRyYW1mcy9p
bml0cmFtZnMtaG9vay9ob29rLmluYw0KPiAgREVCSUFOX0RFUEVORFMgLj0gIiwgXA0KPiAgICAg
IGNyeXB0c2V0dXAsIFwNCj4gICAgICBhd2ssIFwNCj4gLSAgICBvcGVuc3NsLCBcDQo+ICAgICAg
ZTJmc3Byb2dzLCBcDQo+ICAgICAgdHBtMi10b29scywgXA0KPiAgICAgIGNvcmV1dGlscywgXA0K
PiBAQCAtNDAsNyArMzksNyBAQCBIT09LX0FERF9NT0RVTEVTID0gIiBcDQo+ICAgICAgZWNiIGFl
c19nZW5lcmljIHh0cyINCj4gIA0KPiAgSE9PS19DT1BZX0VYRUNTID0gIiBcDQo+IC0gICAgb3Bl
bnNzbCBta2UyZnMgZ3JlcCBhd2sgZXhwciBzZXEgc2xlZXAgYmFzZW5hbWUgdXVpZHBhcnNlIG1v
dW50cG9pbnQgXA0KPiArICAgIG1rZTJmcyBncmVwIGF3ayBleHByIHNlcSBzbGVlcCBiYXNlbmFt
ZSB1dWlkcGFyc2UgbW91bnRwb2ludCBcDQo+ICAgICAgZTJmc2NrIHJlc2l6ZTJmcyBjcnlwdHNl
dHVwIFwNCj4gICAgICB0cG0yX3BjcnJlYWQgdHBtMl90ZXN0cGFybXMgdHBtMl9mbHVzaGNvbnRl
eHQgXA0KPiAgICAgIC91c3IvbGliLyovbGliZ2NjX3Muc28uMSINCj4gDQo+IC0tDQo+IDIuNDcu
Mg0KPg0K

