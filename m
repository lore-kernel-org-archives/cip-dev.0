Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBBEC3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 14:00:29 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.55])
 by mx.groups.io with SMTP id smtpd.web11.34194.1723039026874881900
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Aug 2024 06:57:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nRiAfAyV;
 spf=pass (domain: siemens.com, ip: 40.107.103.55, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXDcPj/2v4sdU9uUoXYqcBVuWlJDdo8eo7tXv9ugeE+HhZF6BfQhx2P+NcvOYQHtxGqS+joncpFhORP/Cd86V1KEDZF0Pk2+CHM3rd6scaYkGEqjGOeBR2wZ0Iig8fWyYsvPLqFXbRmU35CTZ+xQfFOvgPnY9ggq/xTkBP3YZ8KSs84Ug1dPbBLACvN6XsU6U5u/KT9BqNyhhQOW39MGR1HC6oSIRqJqNNrRIr6Rnu2wC1fzdpi7P+wq+N03g7R4VtJxoL9Gdtkbadh0SL/yS5QVvBSKFpWZyrIb2k1hQNM9T+ogxLgYc5ktywuFxKfChkz3Mt1WlsfC0YP3n3ghXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38+PRcydivNxN0UAqpKqrldCaqo6p+5k3fwIugVh/yg=;
 b=Bx1s7e++iNTifdwadiMrKRB9GQ3sgHiwuO+yJMTyJvkTS7QQJMV32LY92s8i28dWufb6eKfO9gH8rQ6xDZ0nmfZaDQQOMHItYH/fGtqeONcpYQ6Z50rBM8ZmtUjpwgXW8u8tkKpsq068Q8llezF66wX5DpnHhUM7mKRxBdqBbvVmQRQLEKn5BshbaRoyxXHRtDrg+MmqoBdSe66M/NQDvatTKLF9iAwBw/cWxNIEPhslf7Y94OLkqtChNg1ib3WPRdwtEhkmXPoA//w+Ul3nzf2MA/qYUYpN//+qn+p+NzMP2KCgc1TdgT2wT1M7zzn7x9BpKA+BIAaLto29CCqu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38+PRcydivNxN0UAqpKqrldCaqo6p+5k3fwIugVh/yg=;
 b=nRiAfAyVpl7mm+pdM/90th0L2gTTIT4mUrXO/seN9mJYGTdSTV0qQeTJ33i+lovEcz/SOGLZta9zaKVcGPwb7ih5a9kVuwZ/ILT0aIEMbN9iXxgqh+i/Px6KNu+U9/J9Qvv6URhE+DmhsDAjHQuoibu76v7U38iBSdLXuyx6YeoAXwd5WIdiDkTs40nz2jl1/zx152pCCOx7MWUI417Z42eaRFjamIXdIyQbJzIUCft77xfKcLe6VRIciUO4zl7PviLifk/sH1E81yCALI0IPxIxOawbNlZRkVmqniuJGQL0Lkg6nyI9x9Qc89e3iceElmyZWHdo5qxdOAHzBt1DWg==
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 by DB9PR10MB7243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:461::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 13:57:02 +0000
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33]) by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:57:02 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/1] fix(PREEMPT_RT): disable CONFIG_RT_GROUP_SCHED
Thread-Topic: [isar-cip-core][PATCH 1/1] fix(PREEMPT_RT): disable
 CONFIG_RT_GROUP_SCHED
Thread-Index: AQHa5xhUVibn9sGzXESx1SymlMN5ubIYuA+AgAMdGwA=
Date: Wed, 7 Aug 2024 13:57:02 +0000
Message-ID: <507f6d620142517158eefe35c269c39786d65dcf.camel@siemens.com>
References: <20240805091722.6871-1-felix.moessbauer@siemens.com>
	 <b3a26322-57b0-4ea5-86bd-2da1c772cedd@siemens.com>
In-Reply-To: <b3a26322-57b0-4ea5-86bd-2da1c772cedd@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6823:EE_|DB9PR10MB7243:EE_
x-ms-office365-filtering-correlation-id: 1e8d068d-49d0-48b3-9ec3-08dcb6e8d09d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U3FjUXk3SHI2YWhvcUNJRmIzNnNOYXV5RUg0VUl5NERoM0pzQTU4ZTdKSWlU?=
 =?utf-8?B?cng4TTBneGFYNStmdXRlQU5UR0hVZFE2OW5zQnI2NCtoR0pObDFyUU5nbjZm?=
 =?utf-8?B?bDloeUE0ejMxS0RBR3hYRGg0WlhYMWMvMWZtbEllWlluTytTTEtpT1RUOEJK?=
 =?utf-8?B?ZGliMTk4bndFK3JSMTlBVk1iMUZvdmlmdDJFbWN4SHZad3BpbUNtSDNWT0dv?=
 =?utf-8?B?cWRUUEJXOUx3TExrZWtndG5EZFUzS2ZTVi9EQTlxaG5IMUhwa3Zxa2tibSti?=
 =?utf-8?B?bW84NHdPNlRxWk1IZ2o4UFJXRm1YajhlRzA1NU9oYmhqWjQxUm5zMlA3UWtw?=
 =?utf-8?B?RXlhQXVmaXlVQ05tb2hMSHRiaTdhOUZicE0zU1Y1ZDY0TDY2T2NxSVlsQTIr?=
 =?utf-8?B?cFNhVXRIUlJoeFpyTmVPR1FwVVpmeHphS1JTSkZ0NitQaTZMMHFxaUtFaG1H?=
 =?utf-8?B?T3NHd3NRVDdRSjhTUnRGZ1gwZHg0Nk9QelZVLzVYZEZqVEZmN3FCdmdSeDhJ?=
 =?utf-8?B?eWNFVU1iMEY2SnhXK0RiODZyZ0lYd3NWWEZtYmFuR0NkRkp5anRwZkxtZngv?=
 =?utf-8?B?TmZQb054VkQ4bHFEM0phaTFCQ0FIMW9DNWZyOEdZd1U0Qjg4MmxXd25TeW5q?=
 =?utf-8?B?NXlXOWhjL2MwT1A5Rk53Y3AxcTFycnQybDk5SHdQQUs4RUVlWmF2c2pKQW1C?=
 =?utf-8?B?MkQ4TEFPcTJDMVVKRGUvTS9CbTRJVGlxbEhrem83Mk9JcEJsYndxYXkzTnpE?=
 =?utf-8?B?RkY1b2cvTFIwbGhjb0RkUXlwc0EzR1dlUXgvWFJzMVprLzFiQ3BBK2ZEcjRi?=
 =?utf-8?B?VDFlZzRlYmJkaDlBMkR6V1V2TFRYRUxLNnBzbXZLUDI1ZkZCVFlpRlJDaDhh?=
 =?utf-8?B?bW9vejFtR25CNnBVOEkyYmFHWU5vcnBNNkhMTm1OakJVQVdlcE1CMVB4S3Yr?=
 =?utf-8?B?NTBZQkozZkVwcjFUNUFocE5IQnNDM20xT0NFN3NYL1dXTythVk1ad21yQVht?=
 =?utf-8?B?VXIxWVdHL2lEOFdyTENMM1VQUXJWWkt3cDFESkw5MjFaK292ZDdGOUlNNHJk?=
 =?utf-8?B?elBBTHA5TjIyTEhheXEwRnY2aHJYQUxVTzFCUEJiRkk1eStBWm5rWWt1TEFa?=
 =?utf-8?B?TkJITW5VM3FoVFlKTU5TNGlscTJHVE1CYjFRZ0JBc3pwd3h0bmZYRHFPaG1k?=
 =?utf-8?B?S29HTmxyRE9WZ0h2dUFTRTk3a3RqRStveHdPOFNRMUFCM0cvaUlsbzdrNVhM?=
 =?utf-8?B?cDNUNkVCeUNMa29iK3hKR2JTQ0FzZHdrNm54VlF0Tk8vMmZzemZZVEJXT1JO?=
 =?utf-8?B?ay8xcUM0KzNYZXFSRW00S3hkdUw2OFlJNE5VaDFzTWY0WFBpb2Q5ZjZoalBW?=
 =?utf-8?B?S3V1LzdmTGl6NTQ2bk1uUVpvZVV5V2xSajBRMTJsMGlNdHlPVnBsdE5YMVkr?=
 =?utf-8?B?b0F3bzBRcWlmTk5YNnNBdkJLVTlaV2o0ZXZNdjZKV3B2T1dkdFZsT0ZBck5D?=
 =?utf-8?B?Nk5hUjR2UFdLTGJucUpDQzNtdXRveXlSYjNkWDdsUzN2MHhWYmZ3SHQ2U3Q1?=
 =?utf-8?B?aFJ0elpFdjVEdy9VaUVnVDRleVkxb0RzRTR0U1dLTCtqWG5helM5aVVnWE0z?=
 =?utf-8?B?S0IyNC9uY09NUlN6dllETkNHMkwybCtJS3RaZFV3V0kwQTNlcnBFa0FVbUdJ?=
 =?utf-8?B?d3Zlc2VtdnEvelJMRHlXQ2RtUGZDMTVyTVBueS94WllTLzBLRUhCNkp3cTlW?=
 =?utf-8?B?RnJlR3ZTVkcxZHZlMmZXVlJrNGJMVDJnbDJJZjFWYXltQ0lpNCtUWHlJdTM4?=
 =?utf-8?B?aU9OclFTZllUTHcraHZkQ09GaTJORzRNYVUvd24zUDJHazlJR2MwTzBGK3lq?=
 =?utf-8?B?U05wdXE2VGlpNDgxaXVyeE5KbVFBZkpDanNMRkptSnliWVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VGV0Z1Y5MWRQdzlacXp2UzZtcXpDc0o1VkpYSG1iaitNbFhhODVZRXVJNHcz?=
 =?utf-8?B?WFkvTkVVbC9iRUhzeGNXL0M0RU1RNUQ5OFI5eCtJVWkzYTU3dDFFSWJqWDV4?=
 =?utf-8?B?R0N1aUJFMzFjSmxPdG9pUHBMeEJNU3FTSUIwUVV1TnJOSHd4aCtyQTBnaTc2?=
 =?utf-8?B?RGhaUnZBZ1NCbW52eXRFTHJxUVdobFpqSmtoV2JsVXJBWHAxUmVLSHRGT3lP?=
 =?utf-8?B?Sk9hUzhlK3ovTnp6RFliTnc3U2xJVy81U1dwVnNCSG9wN0wvOEsxeG9qWHd0?=
 =?utf-8?B?clpIa2h1MXVqR2lhNXYzdTAvS2RuVmxCNklBbkJHNFNuL3p0eUh3b2VTM01n?=
 =?utf-8?B?VDFTQjk1M2IybmFRbnlOS2FDenhiWXdpZUErZVkzcFZzU1Q2cUNGWk4zM3ZR?=
 =?utf-8?B?NEtZOWU5dmNDT2toR0UrUXhJMmd4WjEyb3NoKy9FeUlKZkNoVVVreEQ2aElR?=
 =?utf-8?B?cWFNUTFxdHIxQUJYYlJ2SUNhZmFUeUE4M2NpK1czaGVTNTQrMzQxZ3pZR3U1?=
 =?utf-8?B?V1NkcDhxT2J5cStCWEQzcWFjUkRoakl0ZlByZVQ4MnBNdmdHRHcvb1RCOWVo?=
 =?utf-8?B?QXFOK1pXOEJ2bmUvRHAwenZDbTZLaDUrNXNwQkt6Rnl5am1YaEdLMU9MOHdi?=
 =?utf-8?B?Yy9tZjVaQUVKSG5EakdsUGl1QzdTcHJudEtTdlJsRm9Ma1FyWVRmTlFBWlF5?=
 =?utf-8?B?YllVOWFTcHpUOGdHZnRYTmNlUXVNWW56UVdCdm1UK3V4YlVodTY1M0RkaTVt?=
 =?utf-8?B?UlNQdWoxM0VZRG1JbG1mUFZHRk1NQ21ZRVIxbjJJbXk0Ukdob2Z1WUl0RXYx?=
 =?utf-8?B?S21JOXR1SzA2RmdTSUlwaWZUblZtb1NKSThHbFVGV0RqUHFHaHBtMFpiTTlh?=
 =?utf-8?B?WEoxZ3lsTk5hSi85MWhDTW5kWnE3UUlVQlU5S2ZmNTdFaVRJb2dQQlpvOTYv?=
 =?utf-8?B?U2JycDVWV2dDaVVsUGNUMG5YRDROLzBTUUVXMmVYbnJZL0U4WFdQbnlEeWJ0?=
 =?utf-8?B?YkE0Wnk0M1FncEJyeE54dDFBbmNoaEVhUlNmbVVoRzJDT2VFa3E0VkFMUGV0?=
 =?utf-8?B?dGgvNVk5ZzN1YVFTd1U4SUJkcDdkdEhiMnR2WTNQaHVodWdWUEtmVVpCRFZp?=
 =?utf-8?B?ck9oNmpYczV0MnhzbUJwbENOVDBobTRYb2VqNFJ1djFsTHJXMEs5cnZPaU1l?=
 =?utf-8?B?K0VSa2FDend0RkxudE5tZ2FRaEE2MnNYM1lVSnRBRVFjeStJNlp6SVBCeGI0?=
 =?utf-8?B?RUs0RVJueE94U1VsRUJibm8xMUpuUnRmQ2hyNitpdnNpOWdJbHVJeWJQa2JR?=
 =?utf-8?B?Nm5ZOVcxUnFjaElWOWxPcWQ1UkZvNE4veFU4VXN4dk4rN29GMDFjQmd5T01j?=
 =?utf-8?B?cldTNnJzOW5Ka0ZJMmppdVFJdjlORFlScms5d2xuSjByUlVzN213dnI3RTVn?=
 =?utf-8?B?UW9HUnMzNnF6b0lUUWdqdDNFWE1ISW54Mkk2cExPZlF6aG80Z0xkNFZpbm5R?=
 =?utf-8?B?enh2V2RQWUV6RnRjSDB3UndheENodXJHa2RqV3Y4cVdUMzBwQXc5d0VMUW5L?=
 =?utf-8?B?K1VZVWdXOGU4a21FVk5QNVdXdlFKdTFjTjhZNVdNdlVhM1l6Tml1QTAxSXpK?=
 =?utf-8?B?bjJwbTR5d2lsSTlOZkRtaTJGYnI5b0JibUdpZ3Juc3NURWxNeGVpUXk1TUp5?=
 =?utf-8?B?akpoSjBtZ2hEWThhTVd4b0IvRXlVWmJpa1ZHVEx1Yk1oOUhqQTlBdlBSVUxa?=
 =?utf-8?B?TlFBNzVFbXF3S1FmNEhjSWNUYWt5ZzdTZ1ZWTHE2NUdFMXZSaEVKRXBsanlw?=
 =?utf-8?B?WVJuNFNOcVk0SnRIeUNOUHNneUQwaFN3N3pZcG10ZkZBUkdUdEFPKzhGR3py?=
 =?utf-8?B?KzhTRUNlVk44VllkWEEwQ3FHRWYrOG0yamJ0b3piSUxyZjBabFVpdno0MXZB?=
 =?utf-8?B?aHFNQ24vK1BvbGVGQkpqTHRLOXY3bit6dXNISTVCejZJQnl2S0h2RzV0dVRj?=
 =?utf-8?B?NTZkTXd2UDZmL2o2YjlRWlBLOEg2ekJLUE0xZ3pNYmhEb1dMdWh1MlRhdXZy?=
 =?utf-8?B?OHpReEpDaGFnNTlzVEZIaFdaVGo3NkJ6QmZSVW10UkszZm5WZTJQNXhMZFgx?=
 =?utf-8?B?dWdmbjRISFRuRU01UjlncG9vNyt1MkNWd2FDdEVKUW9xc1RCdS9LbUUyMkxP?=
 =?utf-8?Q?QyC50gOx3QnEdd61eGIc7nA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8d068d-49d0-48b3-9ec3-08dcb6e8d09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 13:57:02.8134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIQH8hzkzEceTrDmXUxGWMCY3V1tVcHg1c3U3sSsEVQrbsfWVBErlZwSVcHVMw36+ltj5HTlClIcNGjSmI+G1Q/Rz5QHfBdhgfWK7kYpX1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7243
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <356FA7162432CC4787D2ACCDA998CE4A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 14:00:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16758

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDE2OjI0ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwNS4wOC4yNCAxMToxNywgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGlzIGZlYXR1
cmUgaXMgc2ltcGx5IGJyb2tlbiBvbiBSVCBrZXJuZWxzIHRoYXQgdXNlIGNncm91cDIsIGFzDQo+
ID4gdGhlDQo+ID4gY3B1IGNvbnRyb2xsZXIgZmVhdHVyZXMgcnRfcGVyaW9kX3VzIGFuZCBydF9y
dW50aW1lX3VzIGFyZSBub3QNCj4gPiBleHBvc2VkLCB3aGljaCBhcmUgbmVlZGVkIHRvIGNvbmZp
Z3VyZSB0aGluZ3MgaW4gYSB3YXkgdGhhdCBhbGxvd3MNCj4gPiB0bw0KPiA+IHJ1biB0YXNrcyB1
bmRlciBSVC9ETCBzY2hlZHVsaW5nIHBvbGljaWVzLiBJdCBmdXJ0aGVyIHNlZW1zIHRvIGJlDQo+
ID4gaW5jb21wYXRpYmxlIHdpdGggdGhlIG5vaHpfZnVsbCBvcHRpb24uDQo+ID4gDQo+ID4gVGhp
cyBwYXRjaCBqdXN0IGRpc2FibGVzIHRoZSBmZWF0dXJlLCBzaW1pbGFyIHRvIHVwc3RyZWFtIERl
Ymlhbi4NCj4gPiANCj4gDQo+IE1ha2VzIHNlbnNlLiBEaWRuJ3QgdHJpZ2dlciB5ZXQgd2l0aCB0
aGUgc3RhbmRhcmQgUlQgdGVzdCBpbWFnZXMNCj4gYnVpbHQNCj4gZnJvbSBpc2FyLWNpcC1jb3Jl
IGRpcmVjdGx5LCBidXQgb3V0IGNvbmZpZyBzaG91bGQgdGhpbmsgYmV5b25kLg0KPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMu
Y29tPg0KPiA+IC0tLQ0KPiA+IEknbSB3b25kZXJpbmcgYSBiaXQgaG93IHRoYXQgd2FzIG5vdCBk
aXNjb3ZlcmVkIGVhcmxpZXIgaW4gb3VyIFJUDQo+ID4gdGVzdHMuDQo+ID4gTWF5YmUgUXVpcmlu
IGNhbiBoYXZlIGEgbG9vayBpZiB0aGUgY3ljbGljdGVzdCBhbHNvIHNob3dzIGVycm9ycw0KPiA+
IHRoYXQNCj4gPiB0aGUgc2NoZWR1bGluZyBwb2xpY3kgY2Fubm90IGJlIHNldC4gQnV0IG1heWJl
IGl0IHNpbXBseSBkaWQgbm90DQo+ID4gc2hvdyB1cA0KPiA+IHRoZXJlLCBhcyB0aGUgc2V0dXAg
d2FzIHRvIHNpbXBsaXN0aWMgYW5kIGRpZCBub3QgZW5hYmxlIHRoZQ0KPiA+IGNncm91cDIgY3B1
DQo+ID4gY29udHJvbGxlci4NCj4gDQo+IFRoZSBsYXR0ZXIgaXMgd2hhdCBJIGFzc3VtZSBhcyB3
ZWxsLiBJIHRlc3RlZCBpdCB3aXRoIGEgcWVtdS14ODYNCj4gYm9va3dvcm0gNi4xLXJ0IHNldHVw
LCBhbmQgY3ljbGljdGVzdCBoYXBwaWx5IHdvcmtlZC4NCg0KSSBqdXN0IG5vdGljZWQsIHRoYXQg
dGhlIENPTkZJR19DUFVfSVNPTEFUSU9OIGlzIHVuc2V0IGluIHRoZSBDSVAgUlQNCmtlcm5lbCBj
b25maWcuIFdoaWxlIHRoaXMgbWFrZXMgc2Vuc2UgaW4gcHVyZSBjZ3JvdXAyIGRlcGxveW1lbnRz
LCBJJ20NCnByZXR0eSBzdXJlIG1hbnkgZGVwbG95bWVudHMgc3RpbGwgcmVseSBvbiB0aGUgaXNv
bGNwdXM9IGtlcm5lbA0KcGFyYW1ldGVyICh3aGljaCBvbmx5IHdvcmtzIHdpdGggQ09ORklHX0NQ
VV9JU09MQVRJT049eSkuDQoNClRoaXMgbWFrZXMgbWUgd29uZGVyIHdoYXQgZXhhY3RseSB3ZSBh
cmUgdGVzdGluZyB0aGVyZS4NCg0KRmVsaXgNCg0KPiANCj4gPiANCj4gPiBOb3RlOiBUaGlzIHdh
cyBkaXNjb3ZlcmVkIHdoaWxlIHRyYWNpbmcgZG93biBrZXJuZWwgYnVncyBhcm91bmQNCj4gPiB0
aW1lciBzbGFjayBvbiBSVC9ETCB0YXNrcy4NCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4g
RmVsaXggTW9lc3NiYXVlcg0KPiA+IFNpZW1lbnMgQUcNCj4gPiANCj4gPiDCoHJlY2lwZXMta2Vy
bmVsL2xpbnV4L2ZpbGVzL3ByZWVtcHQtcnQuY2ZnIHwgMSArDQo+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1rZXJuZWwv
bGludXgvZmlsZXMvcHJlZW1wdC1ydC5jZmcgYi9yZWNpcGVzLQ0KPiA+IGtlcm5lbC9saW51eC9m
aWxlcy9wcmVlbXB0LXJ0LmNmZw0KPiA+IGluZGV4IDRhZmUxYmYuLmVhMzc1NTYgMTAwNjQ0DQo+
ID4gLS0tIGEvcmVjaXBlcy1rZXJuZWwvbGludXgvZmlsZXMvcHJlZW1wdC1ydC5jZmcNCj4gPiAr
KysgYi9yZWNpcGVzLWtlcm5lbC9saW51eC9maWxlcy9wcmVlbXB0LXJ0LmNmZw0KPiA+IEBAIC0x
LDYgKzEsNyBAQA0KPiA+IMKgIyA+PSA1LjEwDQo+ID4gwqBDT05GSUdfRVhQRVJUPXkNCj4gPiDC
oENPTkZJR19QUkVFTVBUX1JUPXkNCj4gPiArQ09ORklHX1JUX0dST1VQX1NDSEVEPW4NCj4gPiDC
oCMgPD0gNC4xOQ0KPiA+IMKgQ09ORklHX1BSRUVNUFRfUlRfRlVMTD15DQo+ID4gwqANCj4gDQo+
IFRoYW5rcywgYXBwbGllZC4NCj4gDQo+IEphbg0KPiANCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNo
bm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

