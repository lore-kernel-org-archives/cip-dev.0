Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311FAE7E0D0
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 11:37:18 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45548.1770637035085242578
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Feb 2026 03:37:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bps9HO+P;
 spf=pass (domain: siemens.com, ip: 52.101.65.42, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJdXWvi02epWqb0LZKGLAceR4uEBtR5wvPZwwAtOaP3Q9vGWbh226E2WPbDX+EcB9okTPsTX40vOJkNvwMen6kfKxqnCoDguBGZ193kTqYADRJjeIj4Ii0LFxBDv3LUymoYiZOlqxrVAIM+fFLWSTVzRABTTivFNCDTw7NqXXm0nsHPfTVi4OceWJdvsR7mw4fesN0h1WD24xMKZYiVEctBXnsaP7GGyrADV3t/eM5r1acu0wvzBYuzETdZah/6YLLUNoi6AMMyAcSdsiIeiINxgyjptWbQxbZJhvLgXKlEWFsiClXIpMMQn6jLzZd2SiwFOO38RX8QEiIEPz+WR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9VfbtOL8TVPrfiQCDvT7gUIfI/pTD4d5uDkRx+qun4=;
 b=wbuVIlgkM93DMvInbY7egJ2P8VbocQcXGaL57MeKxlvqqvNAobxSpty9BxwSo0lF4hczQCKAPIcDdtWjyBb/yGLOJL3tTzuOB+YKRFtvgJBs3BI7er7yU1mU5wGUwWNI3DH7fBqUpMcpUuJ7Lmgc2z+OtK8tZfRxo8UgJusgLbgM1LbMP50h6ryJ24/olBTQ1wFJBMEPuEWnrGI1OFSS9b4nqB8OabKs0cI4jhgrVIOpBCbHk7y1xvjq6uIrKpAIWPAXiaEODAzcmNxjmtpYAwyMp72tsk0PDQf7FfwcTLJzWAkQ1RY5Ec5eXjIJJVfZS3cb+PPk//pKX08pr4UKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9VfbtOL8TVPrfiQCDvT7gUIfI/pTD4d5uDkRx+qun4=;
 b=bps9HO+PDGBUMOdMUv9sHFtWpBQ7nVB3PAyR26bBIRn7Vn/6zICwA3cQNpkZGLWRj3xq9HpjlIhm8W+E1llJ+Pwv01oF+X6/8k3TH1yAC09NxW8UPmUA+zLAJTcymlQFJjFvRvpizAQOk4zJACpb7v5HYq4utOlqHrhqNH0plbf9jg+fmBQxHr0AgkH1ROkGrd4OW6cz0RQYJCBrcIk0bxnAxxJn678m0HLEttMIfYGl2Qwsu8+O0b7WxYjq9hJvDV83WalULBt4Qp/YExoNls/0m86x1sUq7QeceRP4I3cd0enwslAFAGajy5xGDzRnTlSIWp6AfuGVNg7ox60dRQ==
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15)
 by GVXPR10MB8782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 11:37:11 +0000
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828]) by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 11:37:11 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
Thread-Topic: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
Thread-Index: AQHciWA0+no2hYoNOEuQkOtrpvl0h7VnfAQAgAA6b4CAADcvgIAMVXoAgAYa/IA=
Date: Mon, 9 Feb 2026 11:37:11 +0000
Message-ID: <b62c6b7b888acaff421399adf8c9078a1c035d57.camel@siemens.com>
References: <20260119162444.672037-1-alexander.heinisch@siemens.com>
	 <32bacc829a084a0ea04f52ccc568e3f2adb27acc.camel@siemens.com>
	 <442bbdc5-5d46-4ce6-85be-dabe01ce52e4@siemens.com>
	 <d0d12eedcd058d076a2b4ee16240d3f3f1f72329.camel@siemens.com>
	 <35d9181c-ab62-4ba2-99b4-9e4c027bbb8e@siemens.com>
In-Reply-To: <35d9181c-ab62-4ba2-99b4-9e4c027bbb8e@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7349:EE_|GVXPR10MB8782:EE_
x-ms-office365-filtering-correlation-id: 3d3d96fd-a2e4-41a3-1f6f-08de67cf9070
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?KzJKOVRMWW81R1lLTm8vZDBRM215blpraW5PbjZkQzcyZXBQd0NOTkdzSmVw?=
 =?utf-8?B?ejEwZ2o3SUpobWZhMjRZUXNqWWJOQWRMMUxOVks5RDNhVTZtMTQ0b21XVUQ0?=
 =?utf-8?B?S2pTWkJ1R2ZDZndpTzBTQkVxaDJ5YVRmMzJVNCt1RzRQN1lLMjlHVFdkZlVh?=
 =?utf-8?B?NmFPZzUwSklVTnh3TUYwR2xyQXVqVHFubWlXNVg3TkdBaWZIWjMxcFhmUmx5?=
 =?utf-8?B?bjNERG5oS2NzMFcxdC9IT0UzK3BWQzMzdmVnN3dIVDZmaG1YUUxLdFBLZDBB?=
 =?utf-8?B?NGl1WUdCYXhDMVRmSHNVTXlyMjYzN1dSbk9ZZWVTWXI1bEFvdWlEVzVCWXd6?=
 =?utf-8?B?K3NoTzAzMGh3UTVyU1NTTHBOQ0NESm9ZaDYyWDlrS3NPM1hlejQ4dHVoMTN0?=
 =?utf-8?B?UkN3SW9IRDZ2Si9wT3UxTVhnaGk5UWcyNkR6WDc2SzhqTERZV2JJSE1qYlBi?=
 =?utf-8?B?eHN6TlhvZENzbW1sbWQ1T0ZqZ0R4TTR2dTdkZlZLVFY2czVtWGY2UjN5OGZV?=
 =?utf-8?B?SjMwdXJIMTdpT3ppMHRVcU5ZY2xUS2ZSUFljbzFqZ09WRkFkQkg2WWR4MzNL?=
 =?utf-8?B?SHJaM2dQMTI5MEUrM204MVpGK2JQZnpLVWh2TXdyS2NBQTVYbzl4OHUvU3pB?=
 =?utf-8?B?MldvaHFQOWlieGxxeHFycEVCMUx4emx6VU5FaG5aVU1nWWQ5bjYxQjhTL21k?=
 =?utf-8?B?Q0MyQVRLNVg1VFk0dTZCbHMrNmRzakJLYjZtZkY3ZXNsaXlGRE13Z2FUa2JO?=
 =?utf-8?B?Q0pNbEV0cHZ2U2tNOEtjVW55WTRmUDQ1TytKd3FKVUJEWXQ4Z2Jhcm1EdEFB?=
 =?utf-8?B?WEptSzd0NnV1T0lsMC9IS1VmUGtSbytTYStSa3NIUWZVcWJ6Q3ZSTTQ0OVpP?=
 =?utf-8?B?Rks1Y1hhZ0UvRW5RZHBwS0V6MW1Ga3BEai9acVB4MWt6Mm1jM3dCR2g0SGor?=
 =?utf-8?B?NU1haEx5WEhGb3RtN1dWWmpucWVrTWpWRWVtK2ExSXArN25JVU00K0xHOFYw?=
 =?utf-8?B?NXliWjZQbjMwakRQOC9Tb25OSHlzaFgwWWM3UWRCMEVOUVE0bmpDK0RJR1BE?=
 =?utf-8?B?YTJubTEweDZPOVM4emNhQkN6Ni94U21qZTNMb1g2d0NIcHV2OFVyWVVHU2lH?=
 =?utf-8?B?OGcrWS8xRGJKL29aRmtmS3FvMXdaZjkrS1hHUFQ1SCtlWHFiK1ZOem5rNkk0?=
 =?utf-8?B?SURGTFBWZmxWOGd5Wmg4Z1lJektveGp0RGNCbWdBTHNsL0hHb2svREkybk5D?=
 =?utf-8?B?aVg5TnRkWjdDeTRlQ1B0Sy81VTV3Y2JrZ0JUMVNPKzZ2anRvTVYwZWtIRTZH?=
 =?utf-8?B?VGsvVllTZzdXOHV2NzRNci91ZzJTOXFtekMveENOZkRJNGs1NStRc1h5RWxQ?=
 =?utf-8?B?RGxyRDhXa2hENWdoWXp5N1B5R0orSkp5TDdpbWlPamJDOXRVZ3NmNjZPZERF?=
 =?utf-8?B?VWhrbnA5NzVjUVRCZk1vQWJXUVVNZllGajBaZ1I5bENGMnNoVkN4d3VwWjAx?=
 =?utf-8?B?UmRoM2ZYU1dETjE1WWtGNDkwcHhHaTRCNUpEb1F0TkFiT1JCR1dHdjN5NVF6?=
 =?utf-8?B?MXByclhWQlU3UDBnd0NWa1RrT2N4ZjNiZ1J5OE85NE9zQUhNazFGR1E2a0g2?=
 =?utf-8?B?Q2hYM3NlOEUyc2d3K0tZays2TVFITC93Ni9FVFJXTGN2emJsblBrLzJFZHFs?=
 =?utf-8?B?UFFuN1ZTdDF2ZUZxN0ljTUpuVVlJc0I1QVJWTzFxaXAyN3plR3ZPYitNVm83?=
 =?utf-8?B?OEhzNGJVVEIraS9wQWhuNHIxZ0crWGZEYTQ0NVhUdVF6ekw3VE4rMG5taTZL?=
 =?utf-8?B?ZU9iVW1tbHJnczZRd0pFbStYN3A4NDFjRkQ3Z0R3VTVPVG1IdTNDTWZMSnFS?=
 =?utf-8?B?WWFUdm03WENpK0NxM1ovSloxS1ZiaDNTaFp1YURjTlVjKzZ5dWFjbVVNL2t1?=
 =?utf-8?B?MzhOTTZMTjEvdXFWVnNFa2dBbEZ2MENadVBKSC8yRXVVcVc3TFp3MU51cTh3?=
 =?utf-8?B?SVM2QzFqNHV3dk1rNVdndVFueWF1Q1dkKzVnbUU3cUpCa0xhYm1pUUdpRjR5?=
 =?utf-8?B?WmdDTjdrd3VUcGgyOC9QWjNxN1ZCOUpqVXZ3dlF5K2k1Y2cvM2h4ZC9qeHlK?=
 =?utf-8?Q?fmwAafK9FyNrzgphdF7/89OYw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RnJ3U2RCMUNqaEU4SFRDYmFjVTBWM3hsdVFpMCs2QkYvOWZSQ1JmWkd4U0tk?=
 =?utf-8?B?dWllNkVTWmQvUklRTnlBS3FWb3I3S2JKN3hUamhZcUo2cWZmTVZGWWhQZzk0?=
 =?utf-8?B?eGwyZ0sveHR4Y01WcHJxWm5NREhxZDlRODN2Z0kvS0FMcEdxKzdza3crRTJ1?=
 =?utf-8?B?b2k2cjlNZEdHOGFFNzJvSCtxS2VQSU9XNzJRMXpqWDRxdmhLd1lCWFN0cmlM?=
 =?utf-8?B?dnNHTTVCYWdPay9VS3oxVE1UY2ZucnUyVUxwanM4OS9tbUNhdUg0R0xRMElo?=
 =?utf-8?B?M29FbE1SVzc3MEZEQmNpaEdNamJqQWZBNTZ2VDIxbU5nOFRkTnh1Zi9qZnZ6?=
 =?utf-8?B?bG1VUno1WlNKZ2RTNzJDMlZJaS82OFZRRmhHNXU5Z1dKcDAvM0pMU0xOaTlW?=
 =?utf-8?B?U1ZTa0tObS9WUDcxeHZQVG5uZVM3VzVxMGJQTHo4NGpML2pqOUZoTndPSXBU?=
 =?utf-8?B?V2JuN1RKL2tSNytJVUgrdno2OGhaWW9tQnNHYjBvenFLQmJpWFBYRDZ4ZHlw?=
 =?utf-8?B?N2h6WElITTRPRGpJckwwVEJrdzVFSnBIeUMyVFFNUzIyU1c5SUlGU0NVUXow?=
 =?utf-8?B?UHhQQ29CdmdOTWp6dHlYbFZBTUpkbm8yMFlqNm9tczArZU8xWjlTM29IblQy?=
 =?utf-8?B?V0Q3Ry9tVGdvRlpNQ2NPbTI4MTl4UUZrM1dTYVZZQVErSnd1K2w1RWZ1T0F4?=
 =?utf-8?B?SW5oNytydEY3OG94Qno4RUJxWFBKRWllTzBWQkJ6M28zaHlkUldnMSt0UEc5?=
 =?utf-8?B?NnJDcmNsc0tWNEZSM3J1RWRXVGtDZk9oK3pWa3hTbjJIb080VnBHOHZtdkFp?=
 =?utf-8?B?b1pNTUtRRlppMXZXSlVxVHV5U2p4bEdXYVZKWm43ck04RjdpeXl5MlBhTTg1?=
 =?utf-8?B?c0owYTV4U3UzSE9IRTMrVGlTQ25KZ0tQNTBSZUIxaVE0WjlnK2tqWm1KOC9p?=
 =?utf-8?B?a0dQYlR2dEZtcjlZOWgrVmIyUTF6Q0VwV1c3KzdHMFJPYUVUMGxBRSs5Y1pr?=
 =?utf-8?B?eUIwVkhzcUFjUVdha2NOdU8vYWU3ZzR6akFCTWdsN0hNdGRnR1BuZGhWMFdL?=
 =?utf-8?B?dXZONEJudktwTU00eDVreEQwOUdia1dvYmxBekRLQi95eEpwRHdTN3oxbjJ3?=
 =?utf-8?B?VnZ5OVZDZ2lRVkwrYmJtQkNxVWtRd1RTaW5qU1JoenVaeEx3TEFrSER4emRw?=
 =?utf-8?B?YlAwWHlYalE1SUJPMmFYSmFlcXp1eWZzNWxUcUs0TnNGNis2WFZIVFhzb0Jr?=
 =?utf-8?B?M3RPSlI0RVJiMzVlRVRnZWlMdUw5SC9UNm5yT0pKdjB3b2REL2NuUnRuVzNm?=
 =?utf-8?B?Vm0xTHdYemhHaE81bXBqa1E0Y2VGc1RndEZxYWc0b3IxM0RlUllKenhpTXJS?=
 =?utf-8?B?bzRVVkppZmJtdDByMmRGNG5VdUh4M3BLdkpWd00xUGV5YnZWanlMVWhpV2pp?=
 =?utf-8?B?OTJNTU9PRU5ZeDJpcEZmZTBFdjJSa1hZMWtMdzlVNE80T2FuK0V6QW9NTk1O?=
 =?utf-8?B?aWY2cmFVQXozbm1vK3VoKzAzaWNUTDRFU0h2R3ZOMnFaTHhiQjNsSTdGWVhv?=
 =?utf-8?B?dlp6QlRUOHdOWXFaaWtLOWdXMXAvR0MycHNjK3lsTXU2ZDFVVVBySlhZdm5L?=
 =?utf-8?B?QXJScUovTDVOQXltT01BcWNiVWNDVE1qM2Ywbk52d2JIM2tOcW1vTFZIcjc0?=
 =?utf-8?B?MWY1SmE4N1BnZ3lzYVh6aUVoZVFoNkxhWVM4bUg0Z0VaRU1uQWErQTZQUThF?=
 =?utf-8?B?RnI2MHRhK1N3MGpKQ3h2M0lyUjNhNS9Ra2lRVjBJeHRGSjNyYjl2dk5nem0z?=
 =?utf-8?B?ZG02TFRiQy8rUlMralgraXE3OThwZ1NyRlFNMnVkTlhFV1Z0Y01DbDNzR2Z3?=
 =?utf-8?B?N0NPd2FmN0x3OTI0QzJCZzVXQTE1eWZrSlFoaTRDSEdwY3FIbWswcURVa3lB?=
 =?utf-8?B?RDB4Tk40UUZvZ2pobGQ0U084MUhlUll0cWxidWY1MTBWc2p3bUZWYy9iZHVU?=
 =?utf-8?B?YTExN0lWQWV1TGNmVFI5cjZheXJudjdhNWF6dFlwS2pwMncxb2lKK3RlNE1M?=
 =?utf-8?B?NzFSRkdvdWNVR2RmM3RrSllBRTVuVUd0c0dzYjM0ZGNOcURORjl1ZWNOYzFo?=
 =?utf-8?B?NUV0U0xqUVl6YnJJQ3lOWjVYVDZHd3NudlptRC95aWxUVStMaDh6SU1ZdVAy?=
 =?utf-8?B?a28xcHlQY2JiY2VxeTFZTVBQczRHcXZzVmZNMWFQQmdEWnZXRHlVMnkzY2JN?=
 =?utf-8?B?WStPUzNZbU8wYklUbW0xMHNpL2FFOFdLR0UxVTkzMWdJY3pHZUZBYXpTbkYy?=
 =?utf-8?B?bENUbHMxbzE1Q1p2bG1GV01PRDd5TncweG9WTjJLTThvV3hQelFXUWd6RWVw?=
 =?utf-8?Q?uuHe1J5/7w/chh8scTmVLNB7PrSBP9TaH5QDc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1A600B2549D7742AFF6670BE123A8E7@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3d96fd-a2e4-41a3-1f6f-08de67cf9070
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 11:37:11.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MU3q4SA5CGWB32rmoCJBCNdLEZ09Wf7HDQuTO6Ogxl4Vhlm+Tj+OCber54cvF0LhrMWjP3SzLkjnYgqdGJv24HWD6fk9g3UpitbRw/IENZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Feb 2026 11:37:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21847

T24gVGh1LCAyMDI2LTAyLTA1IGF0IDE1OjIzICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDEvMjgvMjYgNzowMSBQTSwgSGVpbmlzY2gsIEFsZXhhbmRlciAoRlQg
UlBEIENFRCBTRVMtQVQpIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNi0wMS0yOCBhdCAxNTo0NCAr
MDEwMCwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiA+IE9uIDI4LjAxLjI2IDEyOjE1LCBIZWluaXNj
aCwgQWxleGFuZGVyIHdyb3RlOg0KPiA+ID4gPiBBbnkgY29tbWVudHMgb24gdGhhdD8NCj4gPiA+
ID4gDQo+ID4gPiANCj4gPiA+IFF1aXJpbj8NCj4gPiA+IA0KPiA+ID4gQW5kIHdoeSBkbyB3ZSBu
ZWVkIG5lZWQgdG8gZmxpcCBTV1VfU0lHTkVEIGluIGJvdGgga2FzIGNvbmZpZ3MNCj4gPiA+IGFu
ZA0KPiA+ID4gdGhlDQo+ID4gPiByZWNpcGVzPyBJc24ndCB0aGUgbGF0dGVyIHN1ZmZpY2llbnQ/
DQo+IA0KPiBTV1VfU0lHTkVEIGlzIG5lZWQgYXQgdHdvIHBvaW50czoNCj4gMS4gZm9yIHRoZSBj
b25maWd1cmF0aW9uIG9mIHRoZSBydW5uaW5nIHN5c3RlbSBzd3VwZGF0ZS1jb25maWcNCj4gMi4g
RHVyaW5nIHRoZSBidWlsZCBvZiB0aGUgKi5zd3Ugd2hlcmUgdGhlIHNpZ25pbmcgb2NjdXJzLg0K
PiANCj4gRHVlIHRvIHRoaXMgeW91IG5lZWQgdG8gc2V0IGl0IGluIGEgKi5jb25mDQoNCkFsaWdu
bWVudCBvZiB0aGUgZGVmYXVsdCBhc3NpZ25lbW50cyBmaXhlcyB0aGF0IGltcGxpY2l0bHkuDQoN
CklmIG9uZSB3YW50cyB0byBjaGFuZ2UgdGhlIGRlZmF1bHQsIHRoYXQgaGFzIHRvIGJlIGRvbmUg
aW4gYSAqLmNvbmYNCmZpbGUuDQoNCkJSIEFsZXhhbmRlcg0KDQo+IA0KPiANCj4gUXVpcmluDQo+
ID4gDQo+ID4gVHJ1ZS4NCj4gPiANCj4gPiA+IA0KPiA+ID4gSmFuDQo+ID4gPiANCj4gPiA+ID4g
T24gTW9uLCAyMDI2LTAxLTE5IGF0IDE3OjI0ICswMTAwLA0KPiA+ID4gPiBhbGV4YW5kZXIuaGVp
bmlzY2hAc2llbWVucy5jb20NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogQWxleGFu
ZGVyIEhlaW5pc2NoIDxhbGV4YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20+DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gVGhlIHNlbGYgYnVpbHQgdmVyc2lvbnMgb2Ygc3d1cGRhdGUgKHVzZWQgYnkg
ZGVmYXVsdCBpbg0KPiA+ID4gPiA+IGRpc3Ryb3MgPA0KPiA+ID4gPiA+IHRyaXhpZSkNCj4gPiA+
ID4gPiBkbyBub3QgZW5mb3JjZSBzaWduYXR1cmUgdmVyaWZpY2F0aW9uLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IGBgYA0KPiA+ID4gPiA+ICQgc3VkbyBzd3VwZGF0ZSAtbiAtdiAtaSBkZW1vLnN3
dQ0KPiA+ID4gPiA+IFtERUJVR10gOiBTV1VQREFURSBydW5uaW5nIDrCoCBbcmVhZF9zZXR0aW5n
c19maWxlXSA6IFJlYWRpbmcNCj4gPiA+ID4gPiBjb25maWcNCj4gPiA+ID4gPiBmaWxlIC9ldGMv
c3d1cGRhdGUuY2ZnDQo+ID4gPiA+ID4gW0RFQlVHXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOsKgIFty
ZWFkX21vZHVsZV9zZXR0aW5nc10gOg0KPiA+ID4gPiA+IFJlYWRpbmcNCj4gPiA+ID4gPiBjb25m
aWcNCj4gPiA+ID4gPiBzZXR0aW5ncyBmb3IgbW9kdWxlIGdsb2JhbHMNCj4gPiA+ID4gPiBbVFJB
Q0VdIDogU1dVUERBVEUgcnVubmluZyA6wqAgW3N3dXBkYXRlX2Rnc3RfaW5pdF0gOiBwdWJsaWMN
Cj4gPiA+ID4gPiBrZXkgLw0KPiA+ID4gPiA+IGNlcnQgL3Vzci9zaGFyZS9zd3VwZGF0ZS1zaWdu
aW5nL3N3dXBkYXRlLXNpZ24uY3J0IGlnbm9yZWQsDQo+ID4gPiA+ID4geW91DQo+ID4gPiA+ID4g
bmVlZA0KPiA+ID4gPiA+IHRvIHNldCBTSUdBTEcNCj4gPiA+ID4gPiBgYGANCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBUaGlzIHBhdGNoIHNlcmllcyBlbmFibGVzIHNpZ25hdHVyZSB2ZXJpZmljYXRp
b24gYnkgZGVmYXVsdA0KPiA+ID4gPiA+IGZvcg0KPiA+ID4gPiA+IHN3dXBkYXRlLg0KPiA+ID4g
PiA+IFRoZSBzZXJpZXMgaXMgc3BsaXQgaW50byB0d28gcGF0Y2hlczoNCj4gPiA+ID4gPiAxKSBC
dWlsZCBzd3VwZGF0ZSB3aXRoIHNpZ25hdHVyZSBjaGVjayBlbmFibGVkLg0KPiA+ID4gPiA+IMKg
wqDCoCBUaGlzIHNpbXBseSBmaXhlcyB0aGUgcHJvdmlkZWQgZGVtbyBidWlsZCBjb25maWd1cmF0
aW9uDQo+ID4gPiA+ID4gaW4gdGhlDQo+ID4gPiA+ID4ga2FzDQo+ID4gPiA+ID4gZmlsZQ0KPiA+
ID4gPiA+IMKgwqDCoCAoKyAuL2thcy1jb250YWluZXIgbWVudSkuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gMikgRW5mb3JjZSBzaWduaW5nIGFuZCB2ZXJpZmljYXRpb24gZm9yIHN3dXBkYXRlIGJ5
IGRlZmF1bHQuDQo+ID4gPiA+ID4gwqDCoMKgwqAgVGhpcyBwYXRjaCBtb2RpZmllcyB0aGUgc3d1
cGRhdGUgY29uZmlndXJhdGlvbiBmaWxlcyB0bw0KPiA+ID4gPiA+IGVuZm9yY2UNCj4gPiA+ID4g
PiBzaWduYXR1cmUNCj4gPiA+ID4gPiDCoMKgwqDCoCB2ZXJpZmljYXRpb24gYnkgZGVmYXVsdCwg
d2hpY2ggbWF5IGJyZWFrIGRvd25zdHJlYW1zDQo+ID4gPiA+ID4gcmVseWluZw0KPiA+ID4gPiA+
IG9uDQo+ID4gPiA+ID4gdW5zaWduZWQNCj4gPiA+ID4gPiDCoMKgwqDCoCBzd3VwZGF0ZSBpbWFn
ZXMuIEhvd2V2ZXIsIHRoZSBkaXZlcmdlZCBkZWZhdWx0IGNvbmZpZw0KPiA+ID4gPiA+IGZvcg0K
PiA+ID4gPiA+IHNpZ25pbmcNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiDCoMKgwqDCoCB2ZXJp
ZmljYXRpb24gb2Ygc3d1IGZpbGVzIGlzIHByb2JhYmx5IG5vdCBkZXNpcmVkDQo+ID4gPiA+ID4g
YW55d2F5cy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBbGV4YW5kZXIgSGVp
bmlzY2ggKDIpOg0KPiA+ID4gPiA+IMKgwqAgc3d1cGRhdGU6IEJ1aWxkIHN3dXBkYXRlIHdpdGgg
c2lnbmF0dXJlIGNoZWNrIGVuYWJsZWQuDQo+ID4gPiA+ID4gwqDCoCBzd3VwZGF0ZTogRW5mb3Jj
ZSBzaWduaW5nIGFuZCB2ZXJpZmljYXRpb24gZm9yIHN3dXBkYXRlIGJ5DQo+ID4gPiA+ID4gZGVm
YXVsdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiDCoMKgY2xhc3Nlcy1yZWNpcGUvc3d1cGRhdGUu
YmJjbGFzc8KgwqDCoCB8IDIgKy0NCj4gPiA+ID4gPiDCoMKga2FzL29wdC9zd3VwZGF0ZS55bWzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMSArDQo+ID4gPiA+ID4gwqDCoHJlY2lwZXMt
Y29yZS9pbWFnZXMvc3d1cGRhdGUuaW5jwqDCoCB8IDIgKy0NCj4gPiA+ID4gPiDCoMKgcmVjaXBl
cy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlLmluYyB8IDEgKw0KPiA+ID4gPiA+IMKgwqA0IGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuNDcuMw0KPiA+ID4gPiANCj4gPiANCg0KLS0gDQpBbGV4
YW5kZXIgSGVpbmlzY2gNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

