Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED2C87FCF
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 09:33:50 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.56])
 by mx.groups.io with SMTP id smtpd.web10.60489.1754949817537650563
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Aug 2025 15:03:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YTcJsyKb;
 spf=pass (domain: siemens.com, ip: 52.101.83.56, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLCrr2lTI/sDKWiLBs6u0RTdzXedCJ2gqlo+NKBG6blXBD1IfZZ90NoU/RUu6q/JknL+2Pu+bITbRZzn5SeegvD5N4EYKNhwzaDiVEcRpytV4QnGO7u2o6yXkUkMVu0u9WWY9cSXu+xxlr7bgj0juGqGvQC/518+aELq6g+tszFmRqmyM2oUns8E2x19jcMlqVX/bPPLPx0mFTyfH0BxjG4a/rP6NSuPq1I/2etfqsQNteJS0yD+4Vy5mxhcbcrveZO6LzwEUBu73hGeVp8MDgDOrCdDuWSeF3wjmz5PKB8hNDu9aAM/FXOfKw/9OXhqrGKetFBaDbweAtQELK1OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL3T2snWjxuSl12jMQJJfYIsS/6CkQdJBc5NY+RvCGk=;
 b=ds8p7ooL+Cw3MHeFRTnjKLVG7htYXaosZ+PIsDVNIHTX23EnQsyCDjqY2tah98u1aZRZL2gHiDmtnuXc3xPNjiG16MKB8Cmfd83xdQGO3CBy5XF3Q+XtqWcUX7jOfeeTM27+8ptmlrX4MNIPaIaUUFcdKYmN3rZ38kpYtiRvWX0HK+SgSd/kujOb/Xc5WaVRuFsMv29O7GGK+C6xBtMeFB/Aar56kLHeukTToeT0PGn/zkv6aM2zMKL2bY35HXVu0XE4sy1kg3pP06oX1c46eRIATeQviMQNhp6v3Wwc+3w0/TN3UXOIFWzI9tWgoGvuYxLVW607ah9JPIB2jSwKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL3T2snWjxuSl12jMQJJfYIsS/6CkQdJBc5NY+RvCGk=;
 b=YTcJsyKb/NW/l0A5PtehW4rxx0yLWEsuUXtD53tBA5Zs852Xx7AvwS7p/fz4yieacUAPvO0noc34yRkx+rkUIVays2psD+CdqDalF4Huw6kT6yD2znfYMg+ZEccTHgbM8rYYc9C1T39n3YSJ2sHNmN6xs918up0+c3Y+bgkErWo7bSR0m96pd2p7b1HdmoNQj6Px5Q8/QP5ck+d5M53ZSpG3CuEuZl2gsw2m8CtyREhr8ICy/oNlyaSPJE5RQ8DJJrBQIgksmoALg0qGwnvJcsSgY147oXlftTe+6iQ+kA/klBtjBJX6G16TvOYyX3sbQWMJiwCWOeAd/PKVTEjlLQ==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by DU0PR10MB7384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 21:49:08 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 21:49:08 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/7] add factory-reset-helper to set the marker file
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 1/7] add factory-reset-helper
 to set the marker file
Thread-Index: AQHcAhLnISmgJwBF30SosHU9uK6nZbRUYFjAgAjpMgCAAMT1YA==
Date: Mon, 11 Aug 2025 21:49:08 +0000
Message-ID: 
 <PRAPR10MB54226BA5C3EF7B346B86E1198028A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
 <20250731120043.333345-2-Quirin.Gylstorff@siemens.com>
 <PRAPR10MB54225CBF1FE9452C812D29F88022A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <8e20d8c8-41ee-4d30-b51e-fd1f95c2b2dc@siemens.com>
In-Reply-To: <8e20d8c8-41ee-4d30-b51e-fd1f95c2b2dc@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=85034bb6-04d9-4a95-88c2-2ff122b1e6c1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-08-11T21:45:58Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|DU0PR10MB7384:EE_
x-ms-office365-filtering-correlation-id: b4e222b0-24b2-4ac5-e5bd-08ddd920e69b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZDNDVnRjb05XeHFiQlJyTXdCZTA3RE5aOUJ1RGdYdGJjU3JUeHMyaVRKY0tN?=
 =?utf-8?B?aE11b0FENk8wTkhJKzlLYWVaS1V4MXZDK2RwTkVIOGw0K2FITWxxT2xhY1hL?=
 =?utf-8?B?UThxWTNoeFZqK2U2bHZhc2dCQXZ2eTZVMFlpUXRYZHI4ODAwT0FKNXNFaCtz?=
 =?utf-8?B?eVdCK1h6b1dTM2NQZHpSVkdKa2dIWC81ZU5GQU9zamNQV20vdFVKUW9kUmVV?=
 =?utf-8?B?SzduYng4SmVxRmZSMzY1eE15Ymtac0NIK3N6T2QyenpMWXhFc2FvcjhKRmFB?=
 =?utf-8?B?VWR0aVZIVjJvWWpaSlljRjZ5SW1RZEVuNmI5cTFZS3NhOGJsZG5pVDQwVnFo?=
 =?utf-8?B?cmhpYVVybFN5SllCMUpjM2xsbTUraEVSOHhuNDFZWEVoMHdOWFFuOVRueThU?=
 =?utf-8?B?L1V4VEc0YjMyTlN1cTZOc1ZvSk5BSURQa3J3Qkt1M3FTanZTYmIrMjdsUVFJ?=
 =?utf-8?B?OFNqYWpSUjBvZWcvWG01UU9iU3NLeSsvaDBhQThPUkxoMlcrSU0vUGt5QlBV?=
 =?utf-8?B?OVNTQjc5RnNhZVc4eXhlclN4SldYYnpRaFlrQTZDeVJQLzlkTzcrQUdrNlNM?=
 =?utf-8?B?YW9zMCtmaHA2MEk0U1lwdklhQi83WFRnOEJhZ1hla3BOVUtCcmlPZ2xhN0Zt?=
 =?utf-8?B?Y1RScWZoUi93Z3pYN3d0NjdTZTVKQlRCcllWRklvVnozdEZjUlFHYml0ZUw4?=
 =?utf-8?B?UEtzZFlZaVFHRHJyOURidmc1a2QraE5Zckw0cHM1WC93TkFybXREb29FaUVC?=
 =?utf-8?B?MjkyemxJSXBEdEVLaHRWYWlqU1MvV1c1VENLdUd5ZFVnWTllZ0pGQlR0NnVW?=
 =?utf-8?B?M2tqenVFUDN4NnM4YWk4UWY4T2FnQUVFdGlNTW5sakZONVNDa1krYmdxek0x?=
 =?utf-8?B?blloU3lBZnZEK05oNlNCa3ZHWjVBd2Myb2NENE9WSTBDZlpZcElVSTdxS25O?=
 =?utf-8?B?VEUvdWlrN0JIbkVGZFYzaS96bUNrcDN6N2orS1FmQTgvV1dQTU56U3NzNzBE?=
 =?utf-8?B?M1JXbTB5ayt6cXVrWGs4ck0wcFdOTTFrK1hUWU5WK3pKOGNMTWNacUpUTWxk?=
 =?utf-8?B?RHlNdXcrNXhBL2FGQkRHUk9teHE1ck04Y3crWTI3Z2xJK0xqRGpHdmkyK1Fu?=
 =?utf-8?B?d3dpMnZqemFFc0VRSkFzQXVpa21meXdvSGtsdlRUS1d4K1VjZEd6TGk5cENx?=
 =?utf-8?B?bVJUdmFoWG1JY1lDbVhFK2NldXNVYkR0a2wxdmxLY2V1RHk3dUtlclRqZkps?=
 =?utf-8?B?aENMMGw3YTI2RWxZMkZqdlVtV3pxSWxDcHlRL2REcmFMYUFxaXVPN244MHdr?=
 =?utf-8?B?VzRBL1JvNEpSRmM0ZTVTdlY5TGs0ZUprcnhCN3lpMUdVa2dveCtiaWJsTkxZ?=
 =?utf-8?B?QldSQzQ4MUNtWjFjWS9JZGd5ZDRaVks5M3hwVk5YTkpsVVkySzdHejQ0My9W?=
 =?utf-8?B?RGlEVUNEbWpWY2xRM1p5TGtPVWRlYmEyTTVIdnprbDZNNFEyZW5Ed2dHcVRj?=
 =?utf-8?B?ZllnN3pCemxyV3lJRVZkZ2EyS2p0eCtUQlJyWVo1SUNGdzVKK1NiTHJ2SEtK?=
 =?utf-8?B?WlhFMjhIZFcyUEw5RlgwVGFmWUJZejdteTFoZ3BmeWVsOG02aWV0c1pJU2lk?=
 =?utf-8?B?RmNrWUtSYVJVSGtBZE9najRwSWFZVTk3eWhhcFFnR0Z2WWZwT2NTa2xyTGM4?=
 =?utf-8?B?blFTdmxBdnV5N0tPUXlZR3B2d24wT0JsQnRKVkVyS0hGcU5wWUFSRzM1NjJT?=
 =?utf-8?B?bmhNVUx6YXdvbjhyWUhUcjF5K1F0VEQ2Wm0wS2RESzZpbzgveHVpMndWNFhD?=
 =?utf-8?B?NStzT1U0OVc3NldSRHd1Ry9HSXozZDVOdUVGOE1VN1FBMXp0WVl3RzJKNTFN?=
 =?utf-8?B?a3lMeC8xSjVWaXMxTG5od0c4a3FROUsybG1GM1J0bnByTndPV2h3NTh5NGho?=
 =?utf-8?B?dXEyRUpkOHA0emE5bUlVY3oxMk9VbGlNaEE2Y3pnOGNwQVRCekJGaTlSc0NB?=
 =?utf-8?B?Uk4vbUlBRFRVd3hnSUNrbFM1RmpSTmZwOVFTNWhVdzFyL1BQTk5VRDNITWw3?=
 =?utf-8?Q?ietn7/?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NWdjS1ZGRklUUkxDWW1kVzFZQ3JMVDlPS2srMGQ5ZFhuNGdHZUJSeUxrSmhz?=
 =?utf-8?B?bzdyNFBzbkI5RThleDRpZTdzZzNYYXI1c2xLT2JxeUw3aWhnNGJvZVVUSmtK?=
 =?utf-8?B?dHp0bENkaENJeWJZQ3VvaUFTK3pESit3RW5hZzNpa3MxbHZzbERmK2VwWFBR?=
 =?utf-8?B?c0g1eUNqaGtwZXZZeWFWUkRrWDc5VXAzRkJPTGhnbENnWG0yV09DeWUzRnpT?=
 =?utf-8?B?SmF1WkpIK25FUzk1ZUoxcnp0REhHMlN5MzZsRjM4bm1iQWZDMGpHK0M2bnFv?=
 =?utf-8?B?SlpLWHlMbGxZd2xGcmlzMjJrL05iNkY2cTZaTlpxWHphREZTdFR6YTNvN0Q3?=
 =?utf-8?B?bThzSlcxeGZEOVpQVDEzb3oreFJET2pmUkJ4Y1JmamtTR1htcXg0aU9tSVlq?=
 =?utf-8?B?U1BEcmF3ejZaeEdBempCc2plQmxuN0srb1FhYllBeFNkRUNOTUZHS2VxaE5R?=
 =?utf-8?B?NFZYM3RlME5sd2tsc1E2U0pGMUZ5UnlhRG9WVm9hNERLRDE2Ri9hSTg0dTZD?=
 =?utf-8?B?aDF3TjFLeGZqNEZBcUVQOU42MnB6Sld2VklaNVBYRUZiS2VaVGJjZ1ZOM1Yy?=
 =?utf-8?B?RHo3R1QyS0Y2UVBmK3Y4UTJpVVd0SDVQZjlrbk1EakZlSXVyYk1rZldjU0FR?=
 =?utf-8?B?OWhoSmloUnFSUjZEQzYybVpPS0FFeDBmbiswaU5JTUlPZUpQVW5Pb3M4TjIv?=
 =?utf-8?B?MnlEZ0plVWVubzF1blozY21jZ0VmdjJIaXNEd1RwNjB4K0tYVVdkMWo5OStG?=
 =?utf-8?B?QnJhcWc3b01HSUtKMWx6R0ZxaWdLaDIxcDZIdGtZSnZEWXhtcEc2dk9Tb1Q5?=
 =?utf-8?B?aU9nblpFL2xTT3BuWklIL0hRaHV5aXQzRmszdGIvNTQrU1ZNaElzSllXZ2Qz?=
 =?utf-8?B?MkhIdytjM0JyT0J6U0FUR3dwNXVQRDNEc1picnFWNHY4Vzk5bUNoTVlDOG5q?=
 =?utf-8?B?eFBhUzdQcFNCOWlRQlMvMFplSnowcTFMWDh6MW84UkdJMG02SzJDS053UHlN?=
 =?utf-8?B?VXRrMjJUR3E2UkFOTE9qeVdFSCtKL0xrWnJDbjljWUJPRzU3TVF3WkJXS1Z5?=
 =?utf-8?B?TXhLWE45YmF0U3VueDhiT0wvYWY0M2pvYUdaL2FxZmhST3ZpcXpyU1VhS3pE?=
 =?utf-8?B?clh0WXk3bmxRSmFRUmorSExEL0JNUFhBK3EyOG1DZThSUk54MHB2THRKb1Nh?=
 =?utf-8?B?d1lQL0RpN2pwOFdFU0thbllTbjFlU0F6bmhETmxhSXN2cytlQ3JKc0RVZFVD?=
 =?utf-8?B?Qms1THQrdGVXOUFhZGdMejkxVEJvcDBUbnV3N3A4UCtoN3B1dDVVOFI0YUZF?=
 =?utf-8?B?c2c3ZWY1YWZJSldRMlk5Y3hpNkxJZmE5bjVwRGdmNUlnSmU2M3V3SGFUNzVW?=
 =?utf-8?B?T1FTUEhza2NJOHpvNko0NmZsU1dzWFc2SDA2V3FkQVNlZ0Zlb2VwWFBXTHNP?=
 =?utf-8?B?UXdBQW9LQTVOTTladXkwSGpBd1pjaGwyMFhTc1dzcmloTEY5VnJ3Qml5UGo4?=
 =?utf-8?B?UFNyQmFOdHVNcXlyb0JFTWUzWDJpWnkzTkRSQzhOdFJlZ2JBenFMWHQ5alR6?=
 =?utf-8?B?SWdlc3hkNlVuNmxxU1c2VHJVVlFwM0Q4ZGVyT05hQTBTRTdZOGZtY0dtS2RS?=
 =?utf-8?B?b0NkcXZFTG90RVhTMVlNK09hdUZ5L3ZqRHF1OFA5aFNhSmJYZUVNS3FFRWlS?=
 =?utf-8?B?VWkvMWhPZXQ2cG9tZ0MrREZhWElnZzdvNUdTUkp4c1A5U1JWb2ZqWkhvbG9u?=
 =?utf-8?B?NmxYWWg1VnFEWTlFcG0rVXFqeW93eW8xcFZlN1NDbzdkSGZUT1pYQ0lCNEY2?=
 =?utf-8?B?eU1GV2luYndMdUpGRlVnMS9QM2N2Uk14MGVnQmFnazFDVGNrREIxWit3SUhO?=
 =?utf-8?B?UUFRYWlpdWhIdk05RlFTcFhNZjZid3I2T01uVU9KU0NzRVdMeXJiTVVMMTds?=
 =?utf-8?B?WkIxZHlSUlQxanVnbmgyczd1MDd5WURDd0NJamFkRk14RE05UlJMY09ZSU85?=
 =?utf-8?B?UVB1angzbk1iR3gzL1o3U3FLWEZvK0dML1JkMmlZeHBZUzJodEVLMWZ3a2xW?=
 =?utf-8?B?eG1nUXh5am43QjhpY0RlOU5Ob0tzMlpFd2VvbG9YdEErN0p5WUJlaWpBKzFF?=
 =?utf-8?Q?9tAogtQ1bQ9wGKES5XnhW3Lb/?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e222b0-24b2-4ac5-e5bd-08ddd920e69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 21:49:08.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2M8rj3xcLirGV5MVV2NU4moYh60QYN7SZrQJQrKbhiYYJiOi1OK58oMCL3u6HmIz9aBRk8OC8Gl0tLpWp2kCAnzmit5T+HtYBBTHVwOA5XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7384
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 09:33:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19723

Pj4gQWRkaXRpb25hbGx5LCBJIGhhdmVuJ3QgbG9va2VkIGludG8gdGhlIHJlYXNvbiB5ZXQsIGJ1
dCB3aGVuIHJ1bm5pbmcgDQo+PiBvbiBjaXAtY29yZS1pbWFnZSB3aXRob3V0IGFueSBvcHRpb24s
IG5vIGxpbmsgaXMgcG9wdWxhdGVkIGludG8gL2Rldi9kaXNrL2J5LXBhcnRsYWJlbCwgc28gdGhp
cyBtaWdodCBub3QgYmUgdXNhYmxlIHdpdGggYmFzZSBpbWFnZSB0YXJnZXQuDQoNCj4gV2hhdCBr
ZXJuZWwgYW5kIGRpc3RybyBhcmUgeW91IHVzaW5nLg0KDQo2LjEueC1jaXAga2VybmVsIHdpdGgg
RGViaWFuIEJvb2t3b3JtLiBJJ3ZlIGJ1aWx0IHRoZSBpbWFnZSwganVzdCBieSB1c2luZyBjdXJy
ZW50IGthcyBtZW51IGRlZmF1bHRzLg0KDQpCZXN0LA0KR29raGFuDQoNCg==

