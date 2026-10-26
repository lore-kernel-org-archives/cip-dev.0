Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45363.1793027484053632400
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 08:11:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BpGbBbLK;
 spf=pass (domain: siemens.com, ip: 52.101.69.60, mailfrom: benedikt.niedermayr@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w95/40czJMND1n4i46pp+IsYJPmRvE/dRVUF1foGaYR2cupNJj96Lmu3euB1avHGe8t6Tlmpuzb03NqsIMTXjrxCfMmz2i/0tT/zMfr5NUpFbbvVdncc8vkKLeUrNAY6Id4oLNc7AQkujTp4G3YcNa0T5Q7hoGephZRwMSLBOcTO3Vc3gTcyHtTfRShTMRBBgblq4T60pMZk4vuc6sPChkTEE3bV0D3tAj5DEhaA3/ulgJ1Z9fks4/IC94FrFMM35qfQgkwXliBdbhLXXjbm6916TVrEqF8x8qRgUZAMMFCrKj7kqpc43q5yUXmBOjqhyGFmUqbj0SVhVnybNb6ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWufGs03QCG4tDIcwYcLpYwvFQ2V716I7bJ+RtQqrmY=;
 b=n5mzAeHF9PM7uGnhGzs38a4kHquSB90FwzbIv3uPLojZKpREPufrE8ZwgZLA4ktIJ4d/COvo+Twiz3DzB8f8zyPAfqixmzIfBE8ox7O2B0xK5553rQp4PWA63naLTlJXbg4cLRRp1chlsNXEtvoRb/lsEgMuTfyn9sYtMjYAL2Jz4DW8hVLJSaF3YYoMcxkIA6LYbgZJAd8qaJQoTHJvg4EtL0C5y+6kkvlaHHuwq+omoeKw/l3+iGs0Lk7W1Fy6Pn3PZXzMJ6RxnYXEvA8zNkzQQHagZxY0m/LSmMrAr208JqMFnvJUf64SdqH+GfZjea2ZjsHHCgNRFmhy/g/6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWufGs03QCG4tDIcwYcLpYwvFQ2V716I7bJ+RtQqrmY=;
 b=BpGbBbLKB4YOOkLIINojn7uTwEfCOs6Sj3YofsbCEK+OZO/Tfv2q9eTascHWhwtHGqbjaB/awBz8tzJQhZPrmvOsGzrB65k6lSgkmjkXq9trYDpOLZFKMnQCSEwbHPtSMB+tYzNgKvusv6dNykjFqTFWhtXo+s6aAyJJrHE2qG8R5u5Krq+InKisVobDa3BRj80uJl4UY1gaYDl4y6ApZeKmuIycxNeO8nzwwgo0GD0HNCDKCYnI9bf9Z0Kr2oGzBOmErGsrVcwZrxkWoAAOwv8a0ZeJxy5/5hv+CPa8rTMCEx5iAhS6joL+EyhhCh1OXbZtcN9nH/Us2aANfarAPQ==
Received: from VI1PR10MB2368.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:84::20)
 by DU4PR10MB9592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:617::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Mon, 26 Oct
 2026 15:11:19 +0000
Received: from VI1PR10MB2368.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11f8:23f:fe2d:c421]) by VI1PR10MB2368.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11f8:23f:fe2d:c421%6]) with mapi id 15.21.0569.005; Mon, 26 Oct 2026
 15:11:19 +0000
From: "Niedermayr, Benedikt" <benedikt.niedermayr@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH v3 0/1] start-qemu: allow more variable
Thread-Topic: [isar-cip-core][PATCH v3 0/1] start-qemu: allow more variable
Thread-Index: AQHcurgrQqbcT/0s+0iUubsOFE9y9LcRQxAA
Date: Mon, 26 Oct 2026 15:11:19 +0000
Message-ID: <4e58ca62-392b-4ab4-98b0-9bdcfed4ab98@siemens.com>
References: <20260323101546.3273376-1-benedikt.niedermayr@siemens.com>
 <9a353cbd-f3b5-4f90-84dd-f27e9846d50e@siemens.com>
In-Reply-To: <9a353cbd-f3b5-4f90-84dd-f27e9846d50e@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR10MB2368:EE_|DU4PR10MB9592:EE_
x-ms-office365-filtering-correlation-id: ba17319e-6bd4-4859-86ab-08df337363b0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261026121527099003|38070700021|4143699003|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261022115727099003|261009223027099003|10067099003|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info: tz0ArCvb8Xl9N7HMR+TCwvf1pG36dmS5IcFrM0rya8/x7xqNl1sH+I7q9dMoVi0r+k+zz8qMx5eSmIXu0qJizns5ciVdz2KZIQz4eJCMDQ/y63ZO48eNX3dzfOtOC4sX78DVxdWIGKKr27srSUOhb3WHmpYFHg3LHs2xu6KxsHCFRQUcuQlde4AwkWhSdwoJKq7IhTQ9SXiSXbXuoEzAeWdVo9axzuFvKIt852UeOXROM5v6dAD8Cmi/3VZ1AFL5KBTIXZrn/2MdASkac1npzQhcHRVEJ5bea4zRC5/q5tA2zTM7vqCvANEJYxZcv6J5bgwmyV59JwVrjSZGesEp4pkSFrd+kuGwFtfdBcw4SezZuVmog1dAExlLbUWPE7KQp+PUt8QXIgemRSW1/xtn4dLMsGyHR/4gqiqaown7EzizHSyeTXrUs1QABWUR1vtmN/KxbypqBYfcgkFunrvEMwXi/Ymm6FUDFBdYxhbr71wnaUXykwl/5jApfjfBnGiw5Gxnbz2dTErAWYTO7Mgv2H5eiwe3+aB1WXEjC83zu7wJIZfoVa8dNMwXl+oNAfVV+wMOcCa6ghEnRJjuQOHEL/GO9sGj5NahD8CJNvfNF/Q6dJVQEAPiBNx6X02AtT27Rl3I5d2M7OHqCk3zMx43tdXDv2sSt7WxYKH6hfXBjymNQfW25KIflR87ri6T3KNzI5KRsxNEPpyQjWXpYa72ny+nINjmM21A0Tmjr5dQhpA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2368.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261026121527099003)(38070700021)(4143699003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261022115727099003)(261009223027099003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG9jQlVITkczektnTXorekgvaUg4aXVUTHNtZVgvbWQ5VWJIM2laTzg3NEdP?=
 =?utf-8?B?US83d29hZmRLMngrejFubXF6dzRjcmovUUdBbit0NmdKbXRWU0xCUzlscHJt?=
 =?utf-8?B?VzZWZmg3MzJNaFNRdjBBN2ZEK09XVFY2ZGpTZEVrM2xiWE15REx5aS9vdWg2?=
 =?utf-8?B?RVRPVEw5a2t6cDZUamVWa1Q3eWQyYndrb3A5Z09KdS9wdzU4QlNmMUtrM0FZ?=
 =?utf-8?B?a3BLcXYxbkNXUTh6QWx3SFNHQnpWRnYzTGlBWE44UW9HSElBQllGdEVsNXhS?=
 =?utf-8?B?eWRtS2ZpZC8rWUJKa1ZhWHRkcnpwbG5lWDBjYWpRNXhRUjVrd0s3TWNiYlZw?=
 =?utf-8?B?UWJYMFVSeDlsOElMb2ZGVG50blpwbzl3am5NYS9TOUhsT0dDNTdkeFBkUmFT?=
 =?utf-8?B?cm56cysxUFI2Yit5WWZXcDh1U1ZLWVFkYWxhZENCaWFDK1RrSEo2a1MrUWgz?=
 =?utf-8?B?ZkRRS0laU3NrTXB5djNhR3dpQ3JFUVgxL0wwNXBHVHZIbTNCNUpJWWtZZ2Rz?=
 =?utf-8?B?UnhhK2dYWk03aXJna1ZmcFYrN01mak9PK2dmMEZ1V2gvM0tNMk1rWHhJT3Zr?=
 =?utf-8?B?L296UE9oWnJIUkE2WmhXOWg0WUN6UXZZQytiL0k0c0RkekIwNUhMSk9tWjFC?=
 =?utf-8?B?Q2NzWS9nVGdlRUJGUzlibUQ5eUora1hFR3U2MDNCSHJRays5eTEyUVRKSnlZ?=
 =?utf-8?B?aXpzaWc1OTJyR0JkRE42cUduWVYyNE56RXhEekt6WmtOZ01pbHJaNHVXM3g5?=
 =?utf-8?B?d0JRR1JJc2RJZElZSFIzZHFqaVdFK01xTXpjSEQyUkRyU2crVVExakxtUlpr?=
 =?utf-8?B?L3phQW96YU9ia3ZVUGp6S040UGZKVWRRVFpxcmRnU0dtekVWU3VxMWFKdzU3?=
 =?utf-8?B?VG1tTVBUWUNRbUdXZVBCS0dZdzBJVlNwVUZJWkN2MlE2RVcyTC9BRlpqNUpX?=
 =?utf-8?B?ZTBrS3o4NXhjeS9XQURXSXhqMkdMelRINXY3MnBXQjQwdTVJSHYxZENFRTNG?=
 =?utf-8?B?bDZmZTd4aVM3YWN0ZXVaRnN2c3RxZHZlNUpvcURtMUFtVWVPakpwV3lTMzR2?=
 =?utf-8?B?R3Fyb2kxRDZTZlNhU09nMkNaYnBqQnJSNGFQd2FORHBOYmxjYVNQR1U3UFVw?=
 =?utf-8?B?bk1XK2x2Qm5zU29TVlV6b2tpRTBWOE50KzlLOXc0ckh0Z3pnVnVOc2FBd0VU?=
 =?utf-8?B?bk1NUFNiVEIvZVhWNldZaG9oOUU3L1ZabXJTWEJyYmRVOWxiUnVGRGxpdHU5?=
 =?utf-8?B?MjRmQkE4RGg4VVJmanhEMVhxeGpOcFZuMENUYllYYXF6Mll2YnV0ZnJQY21r?=
 =?utf-8?B?T3N1ZzhaVVRPNWV0VGxpQTdmTE4xSDhXSmw0RGczVHF0eTRrak9DSXd6RmJP?=
 =?utf-8?B?LzZGdlVDM0N5aGRMT1FrUFpTUEo0RHVNdDVyNmdWTUtDNEF3KzRVaVVXWnlj?=
 =?utf-8?B?SW13ekhpTzJUVGhnWkZuSmFPZDdyMW5SUGV3bFNVMzRXRE1sNUxhb0JKTmNK?=
 =?utf-8?B?VFg4Wit0THo5clBmUzVvMjFTREhKMnBaZGFJSXF5cnBjZWFieE9nL0k2d1Vp?=
 =?utf-8?B?T2U1a0ZTbnNTK2l1Tkx3aXlmSzB4NWFSTEtjaWxVenRsMi9zTERQb0lxbGhm?=
 =?utf-8?B?ZlN0VG5LTjBOREpDSldIY2s4MXNZM28yZEE3MU9tRUliamg3OVR4TFpkRW5F?=
 =?utf-8?B?VWk2UWRFZ1VCamVOK3NLU2E3ZHgxeWFpWWxLUk5jZkh6RmNOMHhtOVR5MUpC?=
 =?utf-8?B?NHlDdkkzb3BIdFNadS96U2VCZDhFcGFhQXNWZExXK2ZFczE4bXNDU1pReUZD?=
 =?utf-8?B?ZEQrTW83aWhaajRvQzBYOENSaWpsY2JEU0NPa05rNjlLSFNraGRzVlp4a2RU?=
 =?utf-8?B?dmQwVGtNQS81UVBNUDI2YTFOVzEwdXc0bXl3YjZqTzl4bEMvWDV3cUEyYkhp?=
 =?utf-8?B?eW1mSXpIVjBZVi9Cb1czNlg0ajhIemk4Y3p1aTFycUNETktnVlg0NXZhdUtV?=
 =?utf-8?B?c2lZTVZHUnBDWTk4SDFTSyszYkZQczlleGE3aDZURXNVWEdsTXBTZFhUTUtr?=
 =?utf-8?B?cGxuc091VGlZRXR1ejloMjRQK0ZPSFAwc1JJQkVuTjI0R2RrQ1c0WHJ1cWlW?=
 =?utf-8?B?U2JNQnNMeXlCYXZhWStUK2JpQ29vYk1RSkFtN3BQOW0xU09xT0Irb2tZVENn?=
 =?utf-8?B?alBybnhwZzRmUlY5NU14aWxIckxuVE1hQ3pwU3JJSGNUNWhvVzlLc21aeERF?=
 =?utf-8?B?MmtBVlRGNEt1SFNjWDVXd2JPYm8rRG5VMmVWUnR4SmppUndSQUxLN1RycHJG?=
 =?utf-8?B?TlBUVG9jS1NLYXRkeEpZclJ5NklTcDhzUDRUUU1iS21MVGpsdWpmR1A2ZGla?=
 =?utf-8?Q?DDRqY1cV0S2586vc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8537F5F97C4A174986FC5A2CD37012FC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2368.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba17319e-6bd4-4859-86ab-08df337363b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 15:11:19.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRvESXVIr6+1LPDihuZLCQlja8g+NTRP/aHq1eRzA8gIbF0AUHKqstgiYF6+7+++kwsDk8GPrySt3V6I8f3qa4z8186ysCJehO961KQOUws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 15:11:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24545

T24gMy8yMy8yNiAxMjoyOCwgS2lzemthLCBKYW4gKEZUIFJQRCBDRUQpIHdyb3RlOg0KPiBPbiAy
My4wMy4yNiAxMToxNSwgQmVuZWRpa3QgTmllZGVybWF5ciB3cm90ZToNCj4+IFJlcG9zdGluZyB0
aGlzIHdpdGggcHJvcGVyIHN1YmplY3Qgbm93DQo+Pg0KPj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4+
IC0gRml4ZWQgdmFyaWFibGUgbmFtZSBEQVRBX0VOQ1JZUFRJT04gLT4gSU1BR0VfREFUQV9FTkNS
WVBUSU9ODQo+Pg0KPj4gQmVuZWRpa3QgTmllZGVybWF5ciAoMSk6DQo+PiAgICBzdGFydC1xZW11
OiBhbGxvdyBtb3JlIHZhcmlhYmxlIGluamVjdGlvbnMNCj4+DQo+PiAgIHN0YXJ0LXFlbXUuc2gg
fCAzNCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+PiAtLQ0KPj4gMi40
My4wDQo+Pg0KPiANCj4gSnVzdCB0byBzZXQgZXhwZWN0YXRpb25zOiBjYW5kaWRhdGUgZm9yIHBv
c3QtdjEuMTEuDQoNCkhpIEphbiwNCg0KU2VlbXMgdGhhdCB0aGlzIGhhcyBiZWVuIG1pc3NlZC4g
SSBkb24ndCBmaW5kIGFueSB0cmFjZSBvbiBjdXJyZW50IG5leHQuDQoNCkJSLA0KQmVuZWRpa3QN
Cg0KPiANCj4gVGhhbmtzLA0KPiBKYW4NCj4gDQoNCg==
