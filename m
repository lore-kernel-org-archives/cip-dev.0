Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB1C3DA59
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 11:43:29 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web11.8692.1721130199367457199
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 04:43:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pXRQdujq;
 spf=pass (domain: siemens.com, ip: 40.107.21.81, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw/7ZTc2afM8WBuaOpQfxKhMHanZbGVxklZ1MDsyqdubSg5GTAEhIFYzTiMdDAY8lVXukdXLxbpd18NYwZaZRS2w2Cpy1l589oJs3C+p78NjLMIHORhZGaW4PYEP5mFH7IYDzgJl0z4CzAFKv6i4s8BMAKZpgL9vUqIo9YpU/8jRRuWMJ6u4DsY0y6SxGIgtUGvDIBAmk8NH2jjr2zurCKy91NFV7sZoErRgPb2dAH6HwfvspfSbYsaw4MjdgYKdbjASubWm1/6LYLtluVqMEVPLLomMatbomM4ekrxIzl+Fw+Upky9yHSq4GDHXomi2pqWF6hTe8oUp7eXNePKJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2L/ftj/T4rUKdAJK3VhpP2Elyd6VVfMem6iPyeodhw=;
 b=d0yamN62VGIoFNIhF/omzU1c5ib4ceMl8NonH/nLs7ctiOIw7DGgeN4AAHdaSozdefDvo+0ILGvABiYo7GKtKRLxkcOFrOdO1CJks6qBsvo1LIjIKPYFuFgQAxR1l/bI5CLDGd4ZZZ8QpfH1ni2t7+8QmFi3bH+5ERzg2rtCjCS0VxhB7BhFyeCW/GH61Lism8n5cRjkiQiWAfCo1Ae/YKcYxAiDXSSkMakB5OcSmOZCDN5zwdyQ6vowsFGJrEjNHSlefd3EMJ+AAdcV6QFWfQrmTKKnsb+u4bTdU8/ig0cTJe/8YXTj6aut0+fCXmE0cu9uSUiIF+rtId95XQeFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2L/ftj/T4rUKdAJK3VhpP2Elyd6VVfMem6iPyeodhw=;
 b=pXRQdujqI0ZttWF4FqfBpQmXRuuc58Dc2httAT5d3rCFzgixwbop2i5meMkuwhWgdtaZ+gV1EY44GexECNfZs3D0Fh8JRNFV8RvDH7nOV5VfLfWoKZSM0u/7uum320YMXUNz86nz6C2odP7TBe0jQiHSCzqwJD4Eb9SxhbmlBNEUTLdiuSnbpS1c6wKVG+LIuR7NsjywoFUabkiSGKNso+h7ABwrrMKyECS2TrqXeg6UCcpoxRgYY9CsH5tkutkY+cVPVXfmtqQctdPezWMY/53Xura1kYlNjm0nSVAwwktuZWoFFKs3PHuzKeA8zr7Fw99KCgaB4L4xto4Aho7wSQ==
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by DU4PR10MB9047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 11:43:15 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%5]) with mapi id 15.20.7762.020; Tue, 16 Jul 2024
 11:43:15 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [PATCH v3 2/4] initramfs-crypt-hook: Provide full losetup
 executable
Thread-Topic: [PATCH v3 2/4] initramfs-crypt-hook: Provide full losetup
 executable
Thread-Index: AQHa1r1oEn9ohVdXO02yr/NXggKN7rH4/GyAgABAyAA=
Date: Tue, 16 Jul 2024 11:43:15 +0000
Message-ID: <41c065cccfa7af03f6658ec2a54d248f62f69d4b.camel@siemens.com>
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
	 <20240715134630.1640160-2-stefan-koch@siemens.com>
	 <627e973e-d402-484d-ab9c-101d79a85696@siemens.com>
In-Reply-To: <627e973e-d402-484d-ab9c-101d79a85696@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4948:EE_|DU4PR10MB9047:EE_
x-ms-office365-filtering-correlation-id: b3e97c15-0f5a-49aa-4eb2-08dca58c7afc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?c1RKSXdhUE5qVHA5OVB3bFJKeWlkaEMwUlJ3bGVlUmlVSU5VOGJ6NkhQTjZh?=
 =?utf-8?B?ZXQ3S2JzY0gwODE3WSt2eHJLbmdWdlc5bzlPZE5UN0pFc2JlbU9hK3RySkpp?=
 =?utf-8?B?Zi9YdGZDNmZGQnBtRGpXaWYwYS9WYzJKVmJZQlUyTEFJa2NOTENZeTFoYUR1?=
 =?utf-8?B?NVJtR0tVVU81VXJwbEtIbGwxTG84T0l1SE8wQUpZNU5NWHZNdFhRWTgvb052?=
 =?utf-8?B?WWE0VkxXMEcweitidlB4enBTa1cxRjNhbVRmblVqeXlYbjNMSUk4eTZNQ29I?=
 =?utf-8?B?VkQrNUpzcWovenJnMWs4MTZBODU2ZEZtaE5VT3RNZWduRS91WDhtTUd6clFm?=
 =?utf-8?B?YnZHam11cU9ML0xFS0p3WTBXMUtaRXNDRU0ySzFRUElndTE3VWN5U1p5eG51?=
 =?utf-8?B?QmdGM3hDcmlxanFXUkNSR25NZFBNWmw2TEVNL0hMMzYxaVVyOHdoRERLeFRQ?=
 =?utf-8?B?VTdtRTQ3aTYvUEVpRGZpOEpOUVhrazBWcGErR24xRGhZVnlkTnZaWFkzTzhV?=
 =?utf-8?B?b2RxZXptNTlkOGlXRnB2R3U4dWFtaWNHYy9tem9OcUM0Mm5WdGpFMXFYaEJ4?=
 =?utf-8?B?VWgrZXQrRnRoQ2tyQjBaNXlnZzBXNGVudXNoMzlXRUdjWkkxcE12dGw4cFlO?=
 =?utf-8?B?dWdNK2NuNXROdm12a1RiOUU4YmF4NlYrR3ZQcWViTmU1WDhXWGZ2aVBublA1?=
 =?utf-8?B?NjZ1NFdVdDZ5c09NQmg0eUpBV0s4blR3ZGtxU1k3VDhsblJjNDVGWGJmZUYr?=
 =?utf-8?B?UE1hSENQQmNKbUhSZ3o4RVVlRDdKOU9wVVR2bWM0aEY4WEQxU1d3MmY1bW5O?=
 =?utf-8?B?NGcycG9sbE1YM0RVdUxwZ1NIQ3MxVVlKTEtTNXhkR0ozRzRxa05YbEZCTFgx?=
 =?utf-8?B?M3pqUXJoR3Rha1RsTUVPODJheW92VFZoQVBwUWd3Nms2ZWVmYVBacXBLdXVF?=
 =?utf-8?B?VENNbFZZUllQTkJ4R1pzRnM0SzRrUTZhRm5vUzZ4dGtHZ1V1OGNJQmoyZi91?=
 =?utf-8?B?NityK3B2QkZOUXpnMm1OUkh3QU5Kc3pnYVVzSVQrS0UxRFJYcE5iN1ltbjJO?=
 =?utf-8?B?MmRBN0pDS3pDek05eVpyQXdsTXQzUFJ6NHNwQS96dVVyZ3ZCMkhsQm1PemxB?=
 =?utf-8?B?VUNjNldBRlpSM3ByaytLcXdoKzc0TTNxYkNaNTMxWE93ZW90bEVmcS9NelhM?=
 =?utf-8?B?RlpVamdaTWdTZWxRT2N3NWo2NnNONlhXYzd0aSs3K0c0VkIwSHRocnp6V0sx?=
 =?utf-8?B?KzUrS2JhNXRqb0dabzZWZkNkV0JERW8weGdmYVZJUVJFak54S2MwMXdBUzNa?=
 =?utf-8?B?TmRjWVNXMHEzOC9lZDhnM0tCZDUrNVBESWs0VTQvTklrbnhNcHBjcjUzeERy?=
 =?utf-8?B?KzZzcGYvL0ViNzJoYmEyWWpwZi9oQUZGMEppWk1yOXBpTHp3UDQ3cHpNeHpx?=
 =?utf-8?B?SldvSVpwSm5xV2JzVjVRV2UzQkZVMXlHM0JYakJoM0FCVm9rdkxza2NmSXJn?=
 =?utf-8?B?Rmh0U1YrbnAvM0ZHcExkWFVkZTc2STBBZ0JmYjF2cWVGemdTajUrOWd5bVMv?=
 =?utf-8?B?YTNsRERsaWRmU0lqMmVuK3NRcm5Ocjd6emhsd1l3SU9VcDd4VDlxdlJUSWE4?=
 =?utf-8?B?Y294WisySWdhbTVxak51L1lZbmVTN2ZyekxOUklQVmJUbkNzS0NEVG5OSFJt?=
 =?utf-8?B?RUlITTVGTkg2WjRZUm1xbnhhcExqNmQ5VkFjbHJ2bzRMUGtyc1JwNGZndW9G?=
 =?utf-8?B?SEZRYVU0SHdWcTZBRHdtenphaWtQQit3OE1sVzlzVUEzMnlHYWVtSkhRWnZs?=
 =?utf-8?Q?61SFUawJOpkG/DEa5zUqJFm9Q/qHDU52eok90=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ckVkcG9RbnY5SUV2cVdoVFRHU2xSdVByWTF4Q0czdE9BS1dueDV5dVFpZER1?=
 =?utf-8?B?MkczbDg3dGV2UzVUVzErdVJ3NGM2dXlVQ0Y1Sm05VHVTNnA3ZzJmYVFpMVI5?=
 =?utf-8?B?WUpwZkxTV254VWZEYVlRYUM3d3A0REJUakdjakVzdUNPKzlJdVkzaWVzcVJT?=
 =?utf-8?B?c09LMEYybWN4ZGpJeGxIS2hESmVQbjdHTGQvdnl2TzRlOFVvbzZSMU1SQTB2?=
 =?utf-8?B?SkJlQXZnOVYxT080d0RQOFFqKzM0Zlp4RDNSczhEeDczZjNTdjUyL1E0ejNy?=
 =?utf-8?B?Y2ErdVVCK09BcFJOZjIxcHhnMVBsL0dES3RZVFRtUlJJMUVGUkpNWmdGYVpw?=
 =?utf-8?B?azR0ZnZMbjZzNWFNNXpXMGdzenphcEM2cjkzYjVjNHVpZWJoK3o5REhyV0Jm?=
 =?utf-8?B?UVN5bkVhL2RqTXMxTC8zWVByV24wd3BtRGM0WWEvVzBDTDVOcXdoR0ZzY2xT?=
 =?utf-8?B?RmhCTmNRTzhsL2E5UHBpRkNKbE5VTnkxM0JVcm5NT0FHV0pXM0FzcWFSOXA5?=
 =?utf-8?B?MFhDcyt0cmhLd2hrYkEvMjBieTRSVmJmdklmWGNES2MzVXFXdURsd1hKK1VT?=
 =?utf-8?B?NHRVRERTYitzL3ZHdzFzOGg4YzI1MDYybUVGWnJnMUVEczYyM01JajdKbEI2?=
 =?utf-8?B?OTU2aXA3VGhwRzJRZ1E3MHJVMVQ3b0JrbmY0NDkxWnR0ZmtxdXpqSHBvcmtT?=
 =?utf-8?B?bTBZQWFiTHR6a3JrZGh3TTBnK3ZucVhENGRELzBnS0FDUWlHT0JDU1dEOUYx?=
 =?utf-8?B?UGxvTjUvZE9XcFNFQUlvRXRvRnBvTzhJTlhEY0Rwd2ovUmg5RVRUSUtETFR0?=
 =?utf-8?B?YUQ0WXdEQzBta2p0YllJYkVZUTArWWNUblAwNVp3WXFWYjM1WUh4VHV4ODNj?=
 =?utf-8?B?eElnQXVURU1ldVZoUWNFNFhaRU9wdk5jSE82MVFDZkVTQ2xubEk4YUNmWk9s?=
 =?utf-8?B?ZzBIdkdZUTBOMkRSTVVwZE16QVBGd0hEZmxJMFNTaGpLWUdzckJVa2pjTU15?=
 =?utf-8?B?TWRpNnVPMmgwRWVUR1lYdi9OZDl6NkNYL2V3VnRyaGpxdGhPbkt2OXV4MkpH?=
 =?utf-8?B?eE55NjQvTk1vMXJ0MWxuYlByV1Y2bnMrZ2xHa0JNcUFYdmE2NEpnSUdMK1VL?=
 =?utf-8?B?aHFqcFdWcHF5RWo5d1dMM3hIMFJxTHBObFNqMlNyS1hUSE9hZmRTcmlHYWxU?=
 =?utf-8?B?dmZxOFA4MUJDL3A2dkdTY1NudDFHR2ZMOWtNSlI4MDR3ZU9VM3RQNkI1TXVC?=
 =?utf-8?B?ZS80aFl2N1U5bm9yTVlSRTZRN0xONGdjbWY4cG1rVXRrb3l2a3dwbDM3VEFx?=
 =?utf-8?B?SVRyYzQzeFZNUTNKdVhnMjd3OWpxaUZ2SkFoZmJ4MjJXdXhjYkZjUWVtb1lk?=
 =?utf-8?B?bzNLVE1CSFFNREk1OFU1dWlrM3JWaG1OQm15QVlJUjdHSHN6NnpKMExYMlBD?=
 =?utf-8?B?TTJtcGo0TENYZllsbUFFck5aKzRIUkg2SXg4SmpiZXM5U2xHTnMzNVN5Skt0?=
 =?utf-8?B?ZzA3NDROZDFydFRkYlAwaTVXY1hhejBZTEtwTndrcFJBdFRrTWozSlg3SEs1?=
 =?utf-8?B?QkNtOFovNDIrREc0WHRRanRHa1JDMEllUVMxRmdrVDBQRC9Ya1grSmlDa3Ri?=
 =?utf-8?B?Z0w4Y2dYOWFFdDhNTDVZOW9WdG1VRW0xOHFJSnRJeUQ3Wk00UGhvQTZrdDNY?=
 =?utf-8?B?a0xkaEZyZUlvd2EzTHZlb2tVZTVzUUFlUHEzcjNNS3M3RmhMKytJelhjTlEv?=
 =?utf-8?B?K0tWQVRUVVVSQjYvRG1kTTNoenhhYWs0WHl3N3dPU0pvUW4yYjMwYlhzRG9v?=
 =?utf-8?B?RmpERjdjQ2FpaXJ3NThOL0Q0aXowZ3NTRnFnNGtuNklxU1hwSkV2SitZYlBh?=
 =?utf-8?B?UFIvVWF6YVpJbndRSDhoaWMrOTZGSW1mV1NhbER6K3Y3QTYzT3V3dXd5bkJO?=
 =?utf-8?B?endpQjZpcEZmczk5KzV1b1RNNmRwMjdmUTNwbXl5LzhpSW5rQ1F1ZWZnc0pK?=
 =?utf-8?B?L1BLTXlPZkZRdXVoY2ZmRWYyUjlOUTVsR0N0dGZkdWFCSUN2clZud2RLK0Vm?=
 =?utf-8?B?NUxlb2swbWVkbjkyM0Y5L21wRDhOd2ZQY1E4bllDL05QbHlybkRxam9ESHQ0?=
 =?utf-8?B?aFFRRDBPanR3bmVVQWcvL3FHZE1LT0JYZkFmUENWVExGTHJWVGcvWWtCNm1R?=
 =?utf-8?B?ZlNvb3VEdHJtY0lzR3JCQ05nYWR0dFVsNDFEbU82ZUJGTThjYmkrNkVpTG9m?=
 =?utf-8?B?MExRbFMrRXdqRy9ZZ1BsTzdGeUdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3E4C00833997B4B9A807A192B95EC14@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e97c15-0f5a-49aa-4eb2-08dca58c7afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 11:43:15.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xU4jUfDuBW3vfVL1tXUf0uN1YUpIy0lYw1EU/+vzk49QfFBJ7PPpF2QPa+i8rN0EF9P/x0M3GaEp+LCgOLZ27A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9047
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 11:43:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16558

T24gVHVlLCAyMDI0LTA3LTE2IGF0IDA5OjUxICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDcvMTUvMjQgMzo0NiBQTSwgU3RlZmFuIEtvY2ggd3JvdGU6DQo+ID4g
LSBBdm9pZHMgdXNpbmcgYSBidXN5Ym94IGxvc2V0dXAgZXhlY3V0YWJsZSB0aGF0DQo+ID4gwqDC
oCBkb2Vzbid0IHN1cHBvcnQgdGhlICItLXNpemVsaW1pdCIgcGFyYW1ldGVyDQo+ID4gLSBUaGUg
Ii0tc2l6ZWxpbWl0IiBwYXJhbWV0ZXIgaXMgbmVlZGVkIGZvciBpbnRyb2R1Y2luZw0KPiA+IMKg
wqAgc3BlZWQtdXAgb2YgZGlzayByZWVuY3J5cHRpb24gd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1p
dA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBLb2NoIDxzdGVmYW4ta29jaEBzaWVt
ZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiDCoCAuLi4vaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMv
ZW5jcnlwdF9wYXJ0aXRpb24uc3lzdGVtZC5ob29rwqDCoCB8DQo+ID4gMSArDQo+ID4gwqAgLi4u
L2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy1jcnlwdC1ob29rXzAuMi5iYsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfA0KPiA+IDIgKy0NCj4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVz
LWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRp
dGlvbi5zeXN0ZW1kLmhvb2sgYi9yZWNpcGVzLQ0KPiA+IGluaXRyYW1mcy9pbml0cmFtZnMtY3J5
cHQtaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLmhvb2sNCj4gPiBpbmRleCBi
ZThjMTE3Li4xZThjNzRjIDEwMDc1NQ0KPiA+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRy
YW1mcy1jcnlwdC0NCj4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuaG9v
aw0KPiA+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiBob29r
L2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuaG9vaw0KPiA+IEBAIC00Nyw2ICs0Nyw3
IEBAIGNvcHlfZXhlYyAvdXNyL2Jpbi9zbGVlcCB8fCBob29rX2Vycm9yDQo+ID4gIi91c3IvYmlu
L3NsZWVwIG5vdCBmb3VuZCINCj4gPiDCoCBjb3B5X2V4ZWMgL3Vzci9zYmluL2UyZnNjayB8fCBo
b29rX2Vycm9yICIvdXNyL3NiaW4vZTJmc2NrIG5vdA0KPiA+IGZvdW5kIg0KPiA+IMKgIGNvcHlf
ZXhlYyAvdXNyL3NiaW4vcmVzaXplMmZzIHx8IGhvb2tfZXJyb3IgIi91c3Ivc2Jpbi9yZXNpemUy
ZnMNCj4gPiBub3QgZm91bmQiDQo+ID4gwqAgY29weV9leGVjIC91c3Ivc2Jpbi9jcnlwdHNldHVw
IHx8IGhvb2tfZXJyb3INCj4gPiAiL3Vzci9zYmluL2NyeXB0c2V0dXAgbm90IGZvdW5kIiA+ICtj
b3B5X2V4ZWMgL3Vzci9zYmluL2xvc2V0dXANCj4gPiAvdXNyL2xvY2FsL3NiaW4vbG9zZXR1cCB8
fCBob29rX2Vycm9yIA0KPiAiL3Vzci9zYmluL2xvc2V0dXAgbm90IGZvdW5kIg0KPiB3aHkgY29w
eSB0byAvdXNyL2xvY2FsL3NiaW4vbG9zZXR1cD8gcGxlYXNlIGRvbid0IGFkZCBhZGRpdGlvbmFs
DQo+IHBhdGhzLg0KPiANCj4gUXVpcmluDQpPaywgd29ya3MgZXZlbiB3aXRoIHVzaW5nIC91c3Iv
c2Jpbi9sb3NldHVwIGFzIHBhdGguDQpUaGVuIHRoZSBidXN5Ym94IGxvc2V0dXAgaXMgbm90IGF2
YWlsYWJsZSwgb25seSB0aGUgZnVsbCBvbmUuDQo+ID4gwqAgY29weV9leGVjIC91c3IvYmluL3N5
c3RlbWQtY3J5cHRlbnJvbGwgfHwgaG9va19lcnJvcg0KPiA+ICIvdXNyL2Jpbi9zeXN0ZW1kLWNy
eXB0ZW5yb2xsIG5vdCBmb3VuZCINCj4gPiDCoCBjb3B5X2V4ZWMgL3Vzci9saWIvc3lzdGVtZC9z
eXN0ZW1kLWNyeXB0c2V0dXAgfHwgaG9va19lcnJvcg0KPiA+ICIvdXNyL2xpYi9zeXN0ZW1kL3N5
c3RlbWQtY3J5cHRzZXR1cCBub3QgZm91bmQiDQo+ID4gwqAgY29weV9leGVjIC91c3IvYmluL3Rw
bTJfcGNycmVhZCB8fCBob29rX2Vycm9yICJVbmFibGUgdG8gY29weQ0KPiA+IC91c3IvYmluL3Rw
bTJfcGNycmVhZCINCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZz
LWNyeXB0LWhvb2svaW5pdHJhbWZzLQ0KPiA+IGNyeXB0LWhvb2tfMC4yLmJiIGIvcmVjaXBlcy1p
bml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiA+IGhvb2svaW5pdHJhbWZzLWNyeXB0LWhvb2tf
MC4yLmJiDQo+ID4gaW5kZXggNzJkZTViNi4uMzQ5N2Q5NSAxMDA2NDQNCj4gPiAtLS0gYS9yZWNp
cGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9pbml0cmFtZnMtY3J5cHQtDQo+ID4g
aG9va18wLjIuYmINCj4gPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQt
aG9vay9pbml0cmFtZnMtY3J5cHQtDQo+ID4gaG9va18wLjIuYmINCj4gPiBAQCAtOSw3ICs5LDcg
QEANCj4gPiDCoCAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gPiDCoCANCj4gPiDC
oCBpbmhlcml0IGRwa2ctcmF3DQo+ID4gLURFQklBTl9ERVBFTkRTID0gImluaXRyYW1mcy10b29s
cywgY3J5cHRzZXR1cCwgXA0KPiA+ICtERUJJQU5fREVQRU5EUyA9ICJpbml0cmFtZnMtdG9vbHMs
IG1vdW50LCBjcnlwdHNldHVwLCBcDQo+ID4gwqDCoMKgwqDCoCBhd2ssIG9wZW5zc2wsIGxpYnRz
czItZXN5cy0zLjAuMi0wIHwgbGlidHNzMi1lc3lzMCwgXA0KPiA+IMKgwqDCoMKgwqAgbGlidHNz
Mi1yYzAgfCBsaWJ0c3MyLWVzeXMwLCBsaWJ0c3MyLW11MCB8IGxpYnRzczItZXN5czAsIFwNCj4g
PiDCoMKgwqDCoMKgIGUyZnNwcm9ncywgdHBtMi10b29scywgY29yZXV0aWxzLCB1dWlkLXJ1bnRp
bWUiDQoNCi0tIA0KU3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

