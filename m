Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324DCC83F1D
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 06:21:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.1382.1752560467613560186
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 23:21:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 56F6L4MU548820; Tue, 15 Jul 2025 15:21:05 +0900
X-Iguazu-Qid: 2rWhqikyh2rnA8kudW
X-Iguazu-QSIG: v=2; s=0; t=1752560464; q=2rWhqikyh2rnA8kudW; m=gpZwJCwcTJgS7tFqbKHfSKKxJQwDsgimeO+SNWYBDww=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 56F6L2U03433210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 15:21:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffnzx+4WyZM7qqZYAMG+d3QjJCm9Uk9K/YtqRVfPB0ATHqahhmZvBx1jnkCAcDWmN9O2ycwDREyyaYyZuei7Rr3qD3NE6C5dHLPUPmX+rSKakAyzmyzZ84bfk9xoRepxe7ghd4e4RhK1S2xQ0ziM+CyBKRJwcognefd3stMjeP3P4wJg5LKXQn0pYPE6SHzDMbPcUW/LYTsEJBFdfFNeV5PMXRQ2/hg6gx7umUAIY6Ers0/nIxVkZh6dhYMEpigsbl3h8uyRG5wyrcIOAySxaqDBGiHwKpjowkzJ3sEPQZZ8Z2Pmr0JolpyGtpOIhaI6jH/aAfuZOcXCWyRtQY9N+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbiC9P20Q7/kAM0cjMXnFSaXeBwQIqauPbsPbpOuRsc=;
 b=IzAUemwl9nUfscbUhOoS0LIsNSQVLCWWrWyovb3bg0Vhqol8b3LuVr5SPMvJBfrukLgM+PAnaoj1alVlwNMIJhmOG78+8GRdTuOPl6I7soq5LqrFwbpIZGWJZZnVvkXNI7/tlOYVROgik5daZBidMXIBNbcLGy6Q+4lPgx4TERe1QKGinQP01XhyhgHC7W8ymSdx+2eZQD+k2dlkq7HLSND/smiUENZp+RAgqnDt5Fxjiwstjjm7uV648sd4OCLEN1tSbRFyVBH05aJY3OI0RTcsaiKCO0E3VQuL3bKXAgoe16/forb8Z+UL33jHi9qNrdzrW+7QPWk2X7ORIv3RJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Topic: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Index: 
 AdvrHhlzn/A/DOQaQCWzDQhadgxFugAAWvSAAAJFldAAAq2dgAAAqsrwAADXmQAAADm2oAKFRenw
Date: Tue, 15 Jul 2025 06:21:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075915C17031D280B208A16C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OSCPR01MB15383:EE_
x-ms-office365-filtering-correlation-id: 261e2706-0391-469b-d4e8-08ddc367c49f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UERML0NFVGVDdTNqVFNsbGx0Nks3RGtkaktQK2ZtMDhBQlUrWmg0Yk1iMWRK?=
 =?utf-8?B?TFhBTmlzOUhiWU5JeVZYZkpQaE4vMFphR01lenc3M3VoSXBLdTRLeUVzVHZn?=
 =?utf-8?B?L2tpYmQwckRsckxObGRwVHRObGt6MUM0b3NDaGpraW9rTEdHS21ZdExKRW4y?=
 =?utf-8?B?aEVpaUpOdC8wajZnOHp1aXlDbFFHVXRISzR6Rk1ZQXNtZGk5b0MxZ3NFNXN4?=
 =?utf-8?B?UlQvK3BxUTZYeTJKZFE3T042NS9CTk9pN0pVREx2dFNGUk94UUEyNDVDUHdj?=
 =?utf-8?B?ZFUxYVhJUEJNNDZNVFdDMUtFTlEwSlNBcVBhOXIzeWJ1YWcveE1xWlFhMnBs?=
 =?utf-8?B?eThmZzBjdWlobE42Tm5rQkZURHFBeFR1RXpGVmpoWTBuQ3daMURyM2s4OTE1?=
 =?utf-8?B?ajlNZGMrcWlyUmd3OCtab2h2NWJmUFdkbDIyVm00TjIxaEEzVTJ1aStFQmpR?=
 =?utf-8?B?WDM0NlRQMHJqUzJMQUhDekloelZYLzhjbytGUlZwd0JkU0dKT09meElQYzZk?=
 =?utf-8?B?ZW42cml2V054YTBiMzdJNkU0OE80cm1xWTdQb0RpMkFBR3NTbXkxakl4OHV3?=
 =?utf-8?B?WEc3Rmt5Q2RBa3JXMnhHeWtFV2N2U1d5dnVUMlVWcDkwbXNZZUNMMGZ3dGpu?=
 =?utf-8?B?WjZ3Y09ZTDcxdjE5UmliRERCUGZRRzVNRktmc3hGT1VRS1VPdWxLa3ZJTTI3?=
 =?utf-8?B?bWZyWmxLUWZvc3dIVXBFQXpiZkl0MEsvM0F2N3dRTTJVOTNuTDNZb1Z4eHNS?=
 =?utf-8?B?dUZ2MjAvTm1DZXdsT01MQXdrTDBoRm5oMFR6THBXWWVyNkpLU2RaZHdRcXYv?=
 =?utf-8?B?aXozd0phNWxIaTVGQmx3Q0Z6ZTFSalE4SHZHeXRUUmt3VDZnQ3FleTNaM1F6?=
 =?utf-8?B?Zml1d2RNK0szMGNGKzRaT0kxTVh5ZGJYbkdYNTYwVi90eWFMSXBnemlDOFhZ?=
 =?utf-8?B?S0NaK29lNUYxTGYxOUQzQ2xjR2tETXpxcmxueTRjZENJUEtOcndWMmNyMWJ2?=
 =?utf-8?B?NUpHU3lIQ0VsUUQxbTJ2bE5obTNlZDVCQk93bjl0cmVKTWFTNnBDVzlOQU0x?=
 =?utf-8?B?RUE1dDlNS3EyWnBtYkRQZDJGQXV3WENaTlNBZGUvTTRYNjNSbjk4Ky9Gd2V1?=
 =?utf-8?B?L0Fta29NaWZRSUxZdDVmSkNSZ280MDduUFNOeERIdHhSV0ZhdktHQ2tKNHl6?=
 =?utf-8?B?MDVsWTV1VVBLYitNVlh0NU1jQmNIWCtFR0pSYjRXVFdDeDk3UWtmMENlbDFY?=
 =?utf-8?B?bDEvM0RPZUYyMmQ3elpFT1IydFNic1IvODYzTEZ6UFRRUk52NnpVWjNsc0ZN?=
 =?utf-8?B?UnN2bm9XemFnTkV5Rythblh2OTVONGx0YzlRNUFkY3J0MEpuUTd2anBsb2Yv?=
 =?utf-8?B?ZGpyQkxPZ1dhSVFNUmkvcUFkSjFUem5icEJpTGtSTVlDWUhMNFE0QTNWbGcr?=
 =?utf-8?B?YndyaHRrdEVrUW9Ua0lvSzNHemlSK0k3T1hzeVNhamI2d055VUhVcXhEaWt2?=
 =?utf-8?B?T2NPK212alQrSm0zTVdXSWtzbjVpQ3lqc252dklscUthZnJ1SHpma2loWWZ1?=
 =?utf-8?B?L3V1NThwRzRkWlNzTGFsTzFRaWM0NVJMemFrMnAyTE4zNHN5a09hTmlHUVlY?=
 =?utf-8?B?eThINlpyNHhhMVF1ay9LWDc5MHp6b0JzNjUrb0V2UmwzaVFvY2xoQktEaHo3?=
 =?utf-8?B?MWhnRGRGaTlkNEowWnhZU1hlSnl0QXhBdHZWWEhhR2Vpc1ZNaTZjL3VLY0Jy?=
 =?utf-8?B?QmlZMmNSR09MYy9ENFFPRWUyTU5sekYrSGo1a3BaVXYxWWx1RWdoTzdDeHkx?=
 =?utf-8?B?bmpaem83MUFqSTNXaGVlbHhSVHJhSTQ4eEt2bWFrMUdkb0hnN3c1WDhNdU1p?=
 =?utf-8?B?WDJ6VllEYW9CV3lnbDlFOG8rWmZva29rdkU3dWJ4SlQxTFJwZDFhSmJEb1ZW?=
 =?utf-8?Q?QGeYVp9pznU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?alBlQ0tRY0dsZnEzTFVxQjdLWEw4T2VZYUEwTElBbk1ZL3VsWWx0a0J4Q0Ft?=
 =?utf-8?B?dDB1Wms4dEk1emp3SmFoQTRoYTMyQUhURDc1OWVXMUhaejNIb3JmSXFoenI2?=
 =?utf-8?B?WE9SOWVreFlaMUtYclNmUE9tdm5jQWdSNXAzV0kzd2RIMTVjQVA5eCtwQndC?=
 =?utf-8?B?VVc2NWxjMTBlK1luQUI0L0NqU1ZHdVJDaG5TenRVUzF3KzZaN1RFZXNOcGRF?=
 =?utf-8?B?SUd0MjlNc3lSelFVemQ1WHlFdFZTeVBUdEVZZ0diVllzSStqRkkzT3VOUnho?=
 =?utf-8?B?dDdNYThyTDI1RS9vem94N054elIrdUV4L1pRdEtsWm5YcDVXY3JHcFpZZGVs?=
 =?utf-8?B?N2Rab2owYVZwZks4eXplekU5OEIxSVB5emdySDdBaVNSOEtvNHdRM0EzOWds?=
 =?utf-8?B?VnRXMmdGSUtMQUlabVBLQ3I2Uyt2UjFDQjA5TGFvQVZoUlNmOHNBb1hwMCtr?=
 =?utf-8?B?Y2RrZWFGblJtTU5Bd2xvY3Zod0JxWERhNnZYU3NYSkVUeHpITlZ0UE8xd3pr?=
 =?utf-8?B?cXdnR2ZPS1phYzFMdkc2QjhJTEpTYlBveUo2RnJVbk8wUVNscnE3ZU1DbGdN?=
 =?utf-8?B?bnNZOHFWYU1ST0tZcVY1aHQvSWlpcVFOVldBNDNUUEhWY2ErMEc3TU1iaWtB?=
 =?utf-8?B?VDBLaWJyY042THZ4a2dmU0k4NXVsTVoyQlg4TGJFUkhhZUEyQTQwQi9VWkN2?=
 =?utf-8?B?ZFoydnZIb29jUkppVHdBZUpSY3E0bTZmWmFmeEtGenZPUkNtSndtVm1HTUsr?=
 =?utf-8?B?VU13VFBrWkJaVS9VbTZWV1hrMlc5U2VFc2JyVlhqZHJDamVZWG43Wm9rZDYv?=
 =?utf-8?B?SXVuTFllM3dkR1liZEJEWFVJTlVXbkdBWEtDYnkyL1JpcnRFSkN6MXN1eWRj?=
 =?utf-8?B?Z0xHbEdkaW1Xa1d3djR1ellZSENMd2VLdkNuekE3VEZ0UGF2S25zeUZtK1Yx?=
 =?utf-8?B?dFVTK3EyazcyRHE1ckpFYzd2N3krdU83VGhKSkpFd3pyaDNzNmc4ZHJkdllm?=
 =?utf-8?B?M04rTDJMbjA5U0xnUm9zTDIvaHU4alZHdmpJNFcrOHdPdlFLU1VQVTJKRFIr?=
 =?utf-8?B?V080SHFqbE5qYjJMVWJENDlibHRDRUlGSytZM2dQY1dYTWFaajQ1Qk5iYmxL?=
 =?utf-8?B?SnExbW1HNXRxUkJnUE11ZFkrOW5vNUFKOVJXS09ObDdWVjZPbVM1aFk3a3Fo?=
 =?utf-8?B?YjRCTmdmWURnL2hkTzB3UGJzaUVxZndqMHpsS0x4ZzlneGd0SDZKWHhQc3hO?=
 =?utf-8?B?TmpyVkxJM05qWkpDWm1wcjJOdjViTWlLTXJhR1VwR2cxNncyc0JWYUFUYWpz?=
 =?utf-8?B?enJYVXczQzhHeEl4NmFZelVFU0ZlMHZXeWVSa3hERjQxSTNHMUV4WjhYd2Ew?=
 =?utf-8?B?cGlpTGhVb0g1V2JRT3FoRC8rdmRueE9pbFEyWmJnU3lOc3gxZGRxbjJteC9R?=
 =?utf-8?B?VXVMSGF2MHA5R3VsbXNjN3VaaTVxU2o3Vk1OcW5JUEZmQUdPMVRrQzAxMW5Y?=
 =?utf-8?B?VVphNUgyeHF0OGFmL0w1TTVjMzJDQUVzWUEvMXZKdVk3TzJvN3Nsek9JMm1u?=
 =?utf-8?B?YUNEQm9vUnlPUEVTdjIzRVMxTm5DTEFoaHhrTXZIK0Q4eDVkTEFwMTRMVXdF?=
 =?utf-8?B?VzV3T0dXYVBZVVptNmdNOUsyU0lOcjJaajVFSWJxZFJvc2Z0TmtIWGpDVUtG?=
 =?utf-8?B?V25ZL2s5cGlYRVk2Y0Nxd21uN09QR2E4czVMNEFadm42cHZleTBVVWltMTBh?=
 =?utf-8?B?YnlPeG9KYXZycjc4bDBFL0tiNElFSDJucVpFVkhyZzBEZHhkVm8rbmNHN21z?=
 =?utf-8?B?VkpwRy8yRnhRdWhYWS8wMGpaY1g4TXRwaHNITG14TFRxdjJxbkM3OVUwbDlP?=
 =?utf-8?B?Zi9Md3UwclNLZzFYeXpMc1cyanhWUWdEODBSaWUwU3QrZUNJaCtqeXVYN2Vq?=
 =?utf-8?B?Y3pkVEJLcGJ0MEVMV3czNGNVWDBHRGhDV0d6aHc5d2hOdU1XUWtuOFpMbFZv?=
 =?utf-8?B?Tm1WQmptWW1QOTVreHNBTC9VamRDVW41NWRxczc5VVVKZVBhNGRBSXFUenJG?=
 =?utf-8?B?c2ZpUVNZRW1pS0ZLS0VDeG1YandwSFZycjlUTkF1NTFhWktPOGtHWUVNWkJa?=
 =?utf-8?B?bVdUTnV0UXZESXpGZXVLM3NKV0lhSFZOb0tWTW1BUUhxSWxIVlk0eEFRWmpp?=
 =?utf-8?B?a3laK3ppc2M2aHNZczhNTDhEWFU4cElvbkxtenY5RHo4dlcxTXJMNjZqYUJ0?=
 =?utf-8?Q?2wR3xfxqtE4ITDSncnoaWs4/eYZE1V9lWBm3nAWBy4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261e2706-0391-469b-d4e8-08ddc367c49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 06:21:00.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xHo6MetKS7J+H9Y3vWxukbUjwbIpkkjadlyu62KgWfcymBP1N48pKHDO7uiCiXJDNX9++2mHlnJuLAUAJmWe2U4CUa3s1bA0irUczRJZtvEU15iwMD2NYevAdPYyxE0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15383
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 06:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19532

SGkgSmFuICYgQ0lQIG1lbWJlcnMsIA0KDQpJIGhhdmUgaW52ZXN0aWdhdGVkIGZ1cnRoZXIgYW5k
IGZvdW5kIGFuIGFsdGVybmF0ZSB3YXkgdG8gc2ltdWxhdGUgdGhlIGRtLXZlcml0eSBjb3JydXB0
IGlzc3VlIGluIExBVkEuIA0KDQpTdGVwIDE6IEV4dHJhY3QgdGhlIC53aWMgcGFydGl0aW9ucy4g
DQogDQpUaGVyZSBpcyB0b29sIHdoaWNoIGhlbHBzIHRvIGV4dHJhY3QgdGhlIHBhcnRpdGlvbiBj
b250ZW50cyBmcm9tIC53aWMgZmlsZSBpLmUgN3ogDQoNCiQgN3ogZSBjaXAtY29yZS1pbWFnZS1z
ZWN1cml0eS1jaXAtY29yZS1ib29rd29ybS1xZW11LWFtZDY0LndpYyAtb2ltYWdlMQ0KJCBscyBp
bWFnZTEvDQpCT09UMC5pbWcgIEJPT1QxLmltZyAgZWZpLmltZyAgaG9tZS5pbWcgIHN5c3RlbWEu
aW1nICBzeXN0ZW1iLmltZyAgIHZhci5pbWcNCg0KU3RlcCAyOiB1bnNxdWFzaGZzIHN5c3RlbWEu
aW1nIChST09URlMpIHRvIGV4dHJhY3QgdGhlIGFjdHVhbCByb290ZnMgY29udGVudHMuDQoNCiQg
bWtkaXIgdGVtcF9kaXINCiQgdW5zcXVhc2hmcyAtZCB0ZW1wX2Rpci8gaW1hZ2UxL3N5c3RlbWEu
aW1nDQokIGxzIHRlbXBfZGlyLw0KYmluICBib290ICBkZXYgIGV0YyAgaG9tZSAgaW5pdHJkLmlt
ZyAgaW5pdHJkLmltZy5vbGQgIGxpYiAgbGliNjQgIG1lZGlhICBtbnQgIG9wdCAgcHJvYyAgcm9v
dCAgcnVuICBzYmluICBzcnYgIHN5cyAgdG1wICB1c3IgIHZhciAgdm1saW51eiAgdm1saW51ei5v
bGQNCg0KU3RlcCAzOiBDcmVhdGUgc3F1YXNoZnMgaW1hZ2UgYWdhaW4gYW5kIHdyaXRlIGJhY2sg
dG8gLndpYyBmaWxlLg0KDQokIHJvb3Rmc19zdGFydF9zZWN0b3I9JChmZGlzayAtbCAtbyBOYW1l
LFN0YXJ0IGNpcC1jb3JlLWltYWdlLXNlY3VyaXR5LWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1k
NjQud2ljIHwgYXdrIC12IG5hbWU9c3lzdGVtYSAnJDAgfiBuYW1lIHtwcmludCAkMn0nKQ0KJCBv
ZmZzZXQ9JCgoJHtyb290ZnNfc3RhcnRfc2VjdG9yfSAqIDUxMikpDQoNCiQgbWtzcXVhc2hmcyB0
ZW1wX2Rpci8gcm9vdC5zcXVhc2hmcw0KJCBzcXVhc2hmc19zaXplPSQoc3RhdCAtYyAlcyByb290
LnNxdWFzaGZzKQ0KJCBkZCBpZj1yb290LnNxdWFzaGZzIG9mPWNpcC1jb3JlLWltYWdlLXNlY3Vy
aXR5LWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1kNjQud2ljIGJzPTEgc2Vlaz0ke29mZnNldH0g
Y291bnQ9JHtzcXVhc2hmc19zaXplfSBjb252PW5vdHJ1bmMNCg0KQWZ0ZXIgc3RlcCAzLCBpZiB3
ZSB0cnkgdG8gYm9vdCB0aGUgaW1hZ2UsIHRoZSBib290IGZhaWxzIHdpdGggdm0tdmVyaXR5IGNv
cnJ1cHRlZCBpc3N1ZS4NClRoaXMgaXMgYWxyZWFkeSB2ZXJpZmllZCBpbiBMQVZBIGxhYi4gSXQg
aXMgd29ya2luZyBmaW5lLiBSZWZlci4gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVk
dWxlci9qb2IvMTI5MDQ2NyAgDQoNCkkgd2lsbCBwbGFuIHRvIHNlbmQgYSBwYXRjaCB0byBpc2Fy
LWNpcC1jb3JlIHRvIGVuYWJsZSB0aGlzIHRlc3QgZm9yIGFtZDY0LiBhcm02NCBhbmQgYXJtaGYg
YXJjaGl0ZWN0dXJlcy4NCg0KVGhhbmtzICYgUmVnYXJkcw0KU2hpdmFuYW5kIEsNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGt1bmlqYWRhciBzaGl2YW5hbmQo77y077yz77yp
77ywIERJVENfRElULU9TVCkgDQpTZW50OiAwMiBKdWx5IDIwMjUgMTY6MDgNClRvOiBKYW4gS2lz
emthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmcNCkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIERJVENfRElULU9TVCkgPGRpbmVzaC5r
dW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8
pO+8qe+8tO+8o+KXi++8o++8sO+8tCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+
DQpTdWJqZWN0OiBSRTogW2NpcC1kZXZdIExBVkE6IFN1cHBvcnQgUk9PVEZTIGRtLXZlcml0eSBj
b3JydXB0aW9uIGRldGVjdGlvbiBjYXNlLg0KDQpIaSBKYW4sIA0KDQo+IFRoZSBhcHByb2FjaCB5
b3UgdG9vayB3b3VsZCBoYXZlIGJlZW4gbXkgcHJvcG9zYWwgYXMgd2VsbC4gQnV0IG1heWJlIHlv
dSBjYW4gZW5yaWNoIGl0IGJ5IGRlcml2aW5nIGEgZml0dGluZyBvZmZzZXQgZnJvbSB0aGUgb3V0
cHV0IG9mIHNmZGlzayBmb3IgdGhlIHRhcmdldCBpbWFnZSBmaWxlPyBUaGF0IHdpbGwgYWxzbyB3
b3JrIHdpdGhvdXQgcHJpdmlsZWdlcyBhbmQgd2lsbCBlbnN1cmUgdGhhdCBwYXJ0aXRpb24gY2hh
bmdlcyB3aWxsIG5vdCBicmVhayB0aGUgdGVzdCBjYXNlLg0KDQpUaGFua3MsIHRoZSBvZmZzZXQg
aW4gZGQgY29tbWFuZCB3YXMgaGFyZGNvZGVkIGp1c3QgdG8gY29uZmlybSB0aGUgYmVoYXZpb3Vy
LiANCk9mIGNvdXJzZSwgd2UgY2FuIGRlcml2ZSB0aGUgcHJvcGVyIG9mZnNldCBvZiByb290ZnMg
ZnJvbSB0aGUgc2ZkaXNrIHRvb2wgc28sIHdpbGwgdXBkYXRlIHRoZSB0ZXN0IGRlZmluaXRpb24g
Zm9yIHRoYXQuICAgDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMu
Y29tPiANClNlbnQ6IDAyIEp1bHkgMjAyNSAxNTozOQ0KVG86IGt1bmlqYWRhciBzaGl2YW5hbmQo
77y077yz77yp77ywIERJVENfRElULU9TVCkgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10
c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFy
KO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNv
bT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDv
vLQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KU3ViamVjdDogUmU6IFtjaXAt
ZGV2XSBMQVZBOiBTdXBwb3J0IFJPT1RGUyBkbS12ZXJpdHkgY29ycnVwdGlvbiBkZXRlY3Rpb24g
Y2FzZS4NCg0KT24gMDIuMDcuMjUgMTE6NTgsIFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10
c2lwLmNvbSB3cm90ZToNCj4gSGkgSmFuLA0KPiANCj4+IE5vLiBJIG1lYW4sIG9ubHkgaWYgdGhl
IHJvb3RmcyBpcyBlbWJlZGRlZCBpbnRvIGEgbHVrcyBjb250YWluZXIgYmVjYXVzZSB3ZSB3YW50
IGl0IHRvIGJlIGVuY3J5cHRlZCBhcyB3ZWxsLCB0aGlzIGtpbmQgb2YgZXJyb3IgaXMgZXhwZWN0
ZWQuIA0KPiANCj4gVGhhbmtzLCB1bmRlcnN0b29kLiANCj4gDQo+PiBEbyB3ZSBidWlsZCB0aGF0
IHNlY3VyaXR5IGltYWdlIHdpdGgga2FzL29wdC9lbmNyeXB0LWFsbC55bWw/DQo+PiBJZiB3ZSBk
b24ndCB0aGVuIHlvdSBsaWtlbHkgZGlkIG5vdCBoaXQgdGhlIHJvb3RmcyBidXQgdGhlIGx1a3Mg
Y29udGFpbmVyIGZvciAvaG9tZSBhbmQgL3Zhci4NCj4gDQo+IEluIENJLCB3ZSB1c2Uga2FzL29w
dC9zZWN1cml0eS55bWwgZm9yIHNlY3VyaXR5IGltYWdlIHNvIGl0IGludGVybmFsbHkgaW5jbHVk
ZXMga2FzL29wdC9lbmNyeXB0LWRhdGEueW1sLiANCj4gU28sIGl0IG1lYW5zIGl0IGlzIGhpdCBi
ZWNhdXNlIG9mIGx1a3MgY29udGFpbmVyIGZvciAvaG9tZSBhbmQgL3Zhci4NCj4gDQo+IEluIHRo
YXQgY2FzZSwgaXMgdGhlcmUgYW55IG90aGVyIHdheSB3ZSBjYW4gc2ltdWxhdGUgdGhlIGRtLXZl
cml0eSBjb3JydXB0IHNjZW5hcmlvIGJ5IG1hbmlwdWxhdGluZyB0aGUgLndpYyBmaWxlLiANCj4g
SWYgbm90IHRoZW4gd2UgY2FuIGFkanVzdCB0aGUgdGVzdCBjYXNlIHRvIGNvbmZpcm0gdGhlIHRo
aXMgKENvdWxkIG5vdCBmaW5kIGRldmljZSBtYXBwZWQgdG8gJ2hvbWUnIGNhbm5vdCBiZSBlbmNy
eXB0ZWQpIGJlaGF2aW91ciBpdHNlbGYgYW5kIHdyaXRlIHRoZSBMQVZBIHRlc3QgZGVmaW5pdGlv
biBhY2NvcmRpbmdseS4gd2hhdCBkbyB5b3UgdGhpbms/IA0KPiAgDQoNClRoZSBhcHByb2FjaCB5
b3UgdG9vayB3b3VsZCBoYXZlIGJlZW4gbXkgcHJvcG9zYWwgYXMgd2VsbC4gQnV0IG1heWJlIHlv
dSBjYW4gZW5yaWNoIGl0IGJ5IGRlcml2aW5nIGEgZml0dGluZyBvZmZzZXQgZnJvbSB0aGUgb3V0
cHV0IG9mIHNmZGlzayBmb3IgdGhlIHRhcmdldCBpbWFnZSBmaWxlPyBUaGF0IHdpbGwgYWxzbyB3
b3JrIHdpdGhvdXQgcHJpdmlsZWdlcyBhbmQgd2lsbCBlbnN1cmUgdGhhdCBwYXJ0aXRpb24gY2hh
bmdlcyB3aWxsIG5vdCBicmVhayB0aGUgdGVzdCBjYXNlLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMg
QUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


