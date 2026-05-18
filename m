Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA2CD343F
	for <webhook@archiver.kernel.org>; Tue, 19 May 2026 02:18:11 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (SEYPR02CU001.outbound.protection.outlook.com [40.107.44.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5777.1779101130310547128
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2026 03:45:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HwtWMfWM;
 spf=pass (domain: siemens.com, ip: 40.107.44.63, mailfrom: gouravsingh@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcjEXX6+0Wa3zVQGLIkKctUiYNytZpVjL9xNppDai1KmzQMg1X0pt5FthWtWb30cFMC69dtea2Sl6xBM6AJI2J7NU1x/lOo/70DegJOMRcAeitKs1UJH7R8DdNdu/qEe5j6dYTFno6SGt36qeuz6/Z0XufkN6bTQzdpqlu8mjRMyYN7Dh7axASSlsrzFHNY9HcHdNSEBa718EQdhUOrHd1cUTyCJUHnKQnfxseJFAG1RN+rlnENMvgtVSWPawD6O3Y2PVQ9UE846cn8PE6wMjvl/g2UHaKAqikHF892rVsK+lhlZ30RiLeWCARxPtqzMM6k8eZ5DHVmc5eBwtzqeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez68heEWY/4zR32sBFl397aFxiqGv1IMksrwwa3cUH0=;
 b=uArTNX4zBymjlkKuXTSsxjJkGVramN3gW63M8GnKWcjsx6zD+J2YOT+k6NVE5MRVNQovkmK2/XxCgSgxFPuSA3a3dYBYjuHaFXJIDUTERe84O2t5yGuqLrNuxHhH5uFXaE61TMbmo6oLhfv76ebvBMAFUIWIbdYdcAwLpfRw6E4i+ildOVZgnQJ+1Cg0Rdub0MyCZNGqAYndA4LOD4Kub1oY2+2etaDFVRN0+24CosT4icoXASL8ssK3MTv3lLfzCuWYGLvuKpY/mzSF2zEfPyF3l62VmHE8qEYaWHVJ0RMQMj6iIocJQQqpAIvs9Tx0Gzcih+KwtazNlcuPWclxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez68heEWY/4zR32sBFl397aFxiqGv1IMksrwwa3cUH0=;
 b=HwtWMfWMxH7T1ZjqCrlgoFcguuIdqOgOpjnethwjuP6rzB3+w6M6Ih00rIRjxgWghiOcq27qB4dDm/0TuC16jAs/HIsJspZug5kJBgDr1QlFC9r1ANhrXU1/5mqP206Xjyxr9mRqn6EfNXbhTFtjsUHVm70YL7k4xgaLcsqqqh9DPsgqV8MupTiOSZH/rbKt4cQruRYXiSaf8M5glsHek0NYZHTHP34TJB+24cSxm1oBq0O5KlF67mkx0bpN/cqXq5Y5fEvXOtBVQniqaJTsXNRCdTk0QZuZiSZcwN+mHt1V8owIyodY6kyGmDwh0P4wJY/YypWdHyXDWYOdVr0/7g==
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 (2603:1096:820:85::12) by SEZPR06MB5120.apcprd06.prod.outlook.com
 (2603:1096:101:39::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:30:20 +0000
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::f0fe:9f43:b3e0:4a1d]) by KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::f0fe:9f43:b3e0:4a1d%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 10:30:19 +0000
From: "Singh, Gourav" <gouravsingh@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 5.10.256-cip73, 6.1.173-cip56, 6.12.88-cip23
Thread-Topic: [isar-cip-core][PATCH] linux-cip: Update to 5.10.256-cip73,
 6.1.173-cip56, 6.12.88-cip23
Thread-Index: AQHc5qoeK3cSKTv+BUuTwfyGlZFtjLYTiFqAgAAMnVA=
Date: Mon, 18 May 2026 10:30:19 +0000
Message-ID: 
 <KL1PR0601MB46971E9E965F4339D11F6117BC032@KL1PR0601MB4697.apcprd06.prod.outlook.com>
References: <20260518093800.1396160-1-gouravsingh@siemens.com>
 <8415400d-0ab5-44f0-94be-18d7becf9c14@siemens.com>
In-Reply-To: <8415400d-0ab5-44f0-94be-18d7becf9c14@siemens.com>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=9b0c64c5-7f1a-4274-8345-d168cb0a3a69;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-18T10:29:03Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4697:EE_|SEZPR06MB5120:EE_
x-ms-office365-filtering-correlation-id: 7c117296-9211-4953-7f3a-08deb4c875fb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|3023799003|11063799003|4143699003|38070700021|55112099003;
x-microsoft-antispam-message-info: 
 OM+xeyEH33sIpNzpU4c4ANXALtDH9VzFwuFbbPjlvN8QjKLk2288NTf4lwHwy0ceuD4/i6xfDvq/YLpuX4J/J7wGz6ams/h1qRp44hWf38QmQvVFyFxK6KRk1FwmScUfxcGpKmkeUuWINA1+mbfQL0jRbZ+A7GPeZ9c26h+mRtEstNZqQHDE/Q6k5sKK2FsU5UYcWA3RolgA1ljgeUrTULgtOzjNmtiugSAobZFEHis66xoHi+xDhSOM3IUzMVPuHJGQJd1WdlxiQ/0r4OJE3idWnvhC6BoBF4W94nrF/9IloY6hxVoNe9jHaHkL+pmS6JFlwnJDnT+1+DbPNRPqDqKSvNaIXRP4X7OhVEMThP813Hx8w0SKws2oQhDzpJ9/wF1nawunBJd9eSBJcWAjUsRfEIt1r/E0xja2Ho8aC/KQpaEh8BKTiH+IffjDPxiCO3N1e8DA/1LYUE01SZmZvIIcV81squwqYvApiVIHGPtxF7ZNhroBAAedwRG9PNVWkNNqt3mC+7cZ+r+0rBqtCV2mEw/khtN3WP7MteTUp3YVfNGEMjbiwDYfZfNv8ynvZzah5+Nf7/yyokcZTeS8/zpQJ5nCPoMvc+yTk7GlQiGui3kSQFUdyIwjhDnyvrNap2CVC49DiHahAp4jeYGhkoPdCGcBntZ/o07Abxa6Gczncx38GnXD/VB37ESfb6832d3aVi6bEZI4SlluhfjwVUBA0LUDfVNBTCCKqPyKut1l60bP5S9OaW1dZAxxFOFg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003)(4143699003)(38070700021)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cmhKcWtacHhXYUlUVUlnNGJ4cUlLK09MU0FkalVkQUdZcjlDejcrMDBycmps?=
 =?utf-8?B?cGdocnQwNjMxSHVtQXVKeXpIUHRkaUVZNEpsNVVsbXNreWpVRDAzWHlSOFNH?=
 =?utf-8?B?bHJiNEhpV1YvNTRnRUZZRSt2V1RTek9Mc0p5ZW1vVERPWkJ3TE5CNTZXOUJF?=
 =?utf-8?B?bmF4K29IczNNdWdtZWhPK2FSNmZHNWkvclhVVTk2MEd1SmJoVUpjRnZhNExS?=
 =?utf-8?B?RENreEhyYm5odm1KazYvTFBDV2FHeFlaNVVxMVd3WjdlMTljY3o1bUVTZXhk?=
 =?utf-8?B?d1F2dEhYQm1BQk96Z3Z3R1VHbWhHZW01K1AvYVNxWm5ucU1vcnZZN3loc3h6?=
 =?utf-8?B?T1U2MUVGSFlBWWhHSkVkU3B5bkJHeE5JeTlyOGNvZWRZTDd4ZHpBckcyTC9o?=
 =?utf-8?B?Z0htaVgxL3ZSMnZkbHg5ZSs2Zitvb0pOOWRrUy84VTEvdDAyZzlSR0p4ZzVl?=
 =?utf-8?B?L0wzYUlBQjdDd3ZsL0Rkc1pOQkVCcU8yMXgybnZ1Y01JWWt5L0N2R1ZyNVk0?=
 =?utf-8?B?VTcxMytuOXJLZlBJVHJIdjJZaWFXV3hobEo2TkRXRFFUSjBidUExTE50SnJH?=
 =?utf-8?B?RTAzRUtrWks4RlJZdzNjUFdBK25Pd2gzUTRzSUREQ3hoQXEwTlc1dzNqZU11?=
 =?utf-8?B?eUVnWDlTRHdyUElsYVdLL002dDVTTTEwNlQxR21kWS8wd3RqNEJ5MHpGenVD?=
 =?utf-8?B?ZnlsN0QzUGNUc2ozTzErSWJSU0hiS2orNE84djFjUnErNmZxUE5NckJUblU5?=
 =?utf-8?B?RTlUSm11cThkeWJsTlVsbjJHTU9Tb3RYMXluYjMyZG42aFVBZnZvYWd2eGEw?=
 =?utf-8?B?eXVtd2V2bThiZmVmK2prWDQvcUxaN05XaGd2UGZKWlVEeVFtTFd3ZFBZNUFj?=
 =?utf-8?B?eXgwdXQyTG54K3owTFMzcTNZSjJib1V5RHl5a1c0bkJQS0Q2dW9Tbk1JRitm?=
 =?utf-8?B?TjIrMjJqRUNuZVo2dDVXZEsxamswbDBQUG5DZTJueEtwaGhRZWdyOUxtamRC?=
 =?utf-8?B?Vk1HL1dYVTROdGh2RkphQXRFbmdNSWtiUVNMdzNMVHNLaForeTkrRzB4S01m?=
 =?utf-8?B?bUpHSHl4dUU1QStwbXo3NWZKZlBGTjFMaXpKcitNaUdDMTBaR3hHbjZER0p3?=
 =?utf-8?B?aVRERGFRZ3Y4cE9ybFNnRXBPb1pYMzk0aHd0L09qNGt0TmREY0lqMjZxTjdX?=
 =?utf-8?B?VDBWZ1JrZHdKWTlzaEpCV0ZQbjNmRGtURUlqdGcxRkdsSTZJUE9hblo2SWVX?=
 =?utf-8?B?VEFxeUdYUVg4WVBIOXlRQ09zM1RTSDMxbHRreFZSTCtkRDdVTEpxSHFORVdS?=
 =?utf-8?B?RlM2d1A5a1E1S1RxQ3dYb05XY1NRTmkyaWN0NjJpa2tpSmFBQWpBczNFZXk5?=
 =?utf-8?B?cjdMNXRJMm5ocFpLM2duclFVb1ZmYjBCMEtsYUVNOHhHTHR3bHYwN3NSOVFx?=
 =?utf-8?B?Y3BpSjd5RFUzb0FRaTNYRXUzUDVHUjFqdTNDUEM2SlJBbHRmQmgzWExvbXg2?=
 =?utf-8?B?azB2M0pNYzRQYlVRZC96amdxNHlhNEduVEsrekI2dU9pWE5UVHRSRml0bEJ0?=
 =?utf-8?B?cjd0TjMrai84ZHpZTFN3NUFTb0N5RkVnRTlRNm43OWVxOTg1VDJvRFpvM2pZ?=
 =?utf-8?B?TUJxZnk4aTExMGt0a2l0ZlB6Q1c1dFlkTEo5c3ZoZlgyUXQwY3JuVzhDUkE5?=
 =?utf-8?B?dVNBYUtnbFhtL3M1UTJjNGZIb0h1VXpSeXFXN1Z4NTE2dU1EK0svdVhhdHlp?=
 =?utf-8?B?bTY3Z1NKTkF6R2RDd2pOZGZ0cGxDMDJ5Zm0yVVZnNDFEU1dkY3o4dnlVWFhS?=
 =?utf-8?B?ZjlBQmh0WEZNWXduTTJ4Y0NKallweWJyMU5PMWl3RUNwZGY4eVdYODczQzJt?=
 =?utf-8?B?L0pUYWhYWC91K2pKRUQ3aWRxakhhM3pSRlVuR1FUdFJ2VW5KT0FXS3h2cDVs?=
 =?utf-8?B?TWdMcEdoOFdSeW9md3lHeDZVNWdHWGludkJJL3BOQjZHTWVhRm1SNEZuVnN3?=
 =?utf-8?B?T09mQTZCbk1JQ2daYTM4blMxUytxdnFuQnBpWGx1bmJBUTQ4MDlPd3FBUVVn?=
 =?utf-8?B?ZENqM3BxRVlPMFNFWEgzWW12Nk5hVzV4ZnpNS05sNUpBSnJjWlg2WU9SWlhi?=
 =?utf-8?B?Z0R4WkxYVmF0YUJOdCtWd3JHNzA5MFlYWlorMkswNWUyREQ2QWtMQkRkdmto?=
 =?utf-8?B?d3JDOTN1RXZmVlRxeUJDdkIzWmYzclgySVpmbk1EUTcxVTExeUhQczVDOWl1?=
 =?utf-8?B?aUJzcC9lM1JGTWh5dmd6WE1VMUdxV0QyMGJsUlNtQ2w3b1ZpMWE3STd2ekpG?=
 =?utf-8?B?aE1BT3pla2JSK3RDSjVyVXVhNzdzcE9EcmFvNjVZZ1ZKWWNpc09VUT09?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c117296-9211-4953-7f3a-08deb4c875fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 10:30:19.8594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyNuTPdH6/XXSgxQzUmwW+52xlj5FQDqGY+9MQZkYQRmNLLFeS6EDCEMYT+t+ORKRQNK4996gZrfqc324O2Olg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5120
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 May 2026 02:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22979

SGkgSmFuLA0KDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoYXQgb3V0ISBJIHdhc24ndCBhd2Fy
ZSBvZiB0aGUgc2NyaXB0cy91cGRhdGUtbGludXgtY2lwLnNoIHNjcmlwdCBhbmQgaGFkIG1hZGUg
dGhlIGNoYW5nZXMgbWFudWFsbHkg4oCUIEkgbm93IHVuZGVyc3RhbmQgd2h5IDQuMTktY2lwLXJ0
IHdhcyBtaXNzZWQgYXMgYSByZXN1bHQuDQoNCkkgdHJpZWQgcnVubmluZyB0aGUgc2NyaXB0IGJ1
dCByYW4gaW50byBhIEdQRyB2ZXJpZmljYXRpb24gZmFpbHVyZSAoc2hhMjU2c3Vtcy5hc2MgaW52
YWxpZCBmb3IgYWxsIHZlcnNpb25zKS4gQXMgYSB0ZW1wb3Jhcnkgd29ya2Fyb3VuZCBJIGNvbW1l
bnRlZCBvdXQgdGhlIGV4aXQgMSB0byBsZXQgdGhlIHNjcmlwdCBjb21wbGV0ZSBhbmQgd2lsbCB1
c2UgaXRzIG91dHB1dCBmb3IgdGhlIHVwZGF0ZWQgcGF0Y2guDQoNClRoYW5rcywNCkdvdXJhdg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS2lzemthLCBKYW4gKEZUIFJQRCBD
RUQpIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IDE4IE1heSAyMDI2IDE1OjE0DQpU
bzogU2luZ2gsIEdvdXJhdiAoRlQgRkRTIENFUyBMWCBQQlUgMikgPGdvdXJhdnNpbmdoQHNpZW1l
bnMuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClN1YmplY3Q6IFJlOiBbaXNh
ci1jaXAtY29yZV1bUEFUQ0hdIGxpbnV4LWNpcDogVXBkYXRlIHRvIDUuMTAuMjU2LWNpcDczLCA2
LjEuMTczLWNpcDU2LCA2LjEyLjg4LWNpcDIzDQoNCk9uIDE4LjA1LjI2IDExOjM4LCBHb3VyYXYg
U2luZ2ggd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6IEdvdXJhdiBTaW5naCA8Z291cmF2c2luZ2hA
c2llbWVucy5jb20+DQo+IC0tLQ0KPiAgcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0
XzYuMTIuODUtY2lwMjIuYmIgICAgICAgICAgICB8IDEgLQ0KPiAgcmVjaXBlcy1rZXJuZWwvbGlu
dXgvbGludXgtY2lwLXJ0XzYuMTIuODgtY2lwMjMuYmIgICAgICAgICAgICB8IDEgKw0KPiAgLi4u
aW51eC1jaXBfNS4xMC4yNTQtY2lwNzIuYmIgPT4gbGludXgtY2lwXzUuMTAuMjU2LWNpcDczLmJi
fSB8IDQgDQo+ICsrLS0gIC4uLntsaW51eC1jaXBfNi4xLjE3MC1jaXA1NS5iYiA9PiBsaW51eC1j
aXBfNi4xLjE3My1jaXA1Ni5iYn0gfCANCj4gMiArLSAgLi4ue2xpbnV4LWNpcF82LjEyLjg1LWNp
cDIyLmJiID0+IGxpbnV4LWNpcF82LjEyLjg4LWNpcDIzLmJifSB8IA0KPiAyICstDQo+ICA1IGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkgIGRlbGV0ZSBtb2Rl
IDEyMDAwMCANCj4gcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0XzYuMTIuODUtY2lw
MjIuYmINCj4gIGNyZWF0ZSBtb2RlIDEyMDAwMCByZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1j
aXAtcnRfNi4xMi44OC1jaXAyMy5iYg0KPiAgcmVuYW1lIHJlY2lwZXMta2VybmVsL2xpbnV4L3ts
aW51eC1jaXBfNS4xMC4yNTQtY2lwNzIuYmIgPT4gDQo+IGxpbnV4LWNpcF81LjEwLjI1Ni1jaXA3
My5iYn0gKDU0JSkgIHJlbmFtZSANCj4gcmVjaXBlcy1rZXJuZWwvbGludXgve2xpbnV4LWNpcF82
LjEuMTcwLWNpcDU1LmJiID0+IA0KPiBsaW51eC1jaXBfNi4xLjE3My1jaXA1Ni5iYn0gKDU5JSkg
IHJlbmFtZSANCj4gcmVjaXBlcy1rZXJuZWwvbGludXgve2xpbnV4LWNpcF82LjEyLjg1LWNpcDIy
LmJiID0+IA0KPiBsaW51eC1jaXBfNi4xMi44OC1jaXAyMy5iYn0gKDU5JSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXAtcnRfNi4xMi44NS1jaXAyMi5i
YiANCj4gYi9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXAtcnRfNi4xMi44NS1jaXAyMi5i
Yg0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMjAwMDANCj4gaW5kZXggZWQ1YWIwMC4uMDAwMDAwMA0K
PiAtLS0gYS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXAtcnRfNi4xMi44NS1jaXAyMi5i
Yg0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xICswLDAgQEANCj4gLWxpbnV4LWNpcF82LjEyLjg1
LWNpcDIyLmJiDQo+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPiBkaWZmIC0tZ2l0IGEv
cmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0XzYuMTIuODgtY2lwMjMuYmIgDQo+IGIv
cmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwLXJ0XzYuMTIuODgtY2lwMjMuYmINCj4gbmV3
IGZpbGUgbW9kZSAxMjAwMDANCj4gaW5kZXggMDAwMDAwMC4uMzA2YzJhOQ0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcC1ydF82LjEyLjg4LWNp
cDIzLmJiDQo+IEBAIC0wLDAgKzEgQEANCj4gK2xpbnV4LWNpcF82LjEyLjg4LWNpcDIzLmJiDQo+
IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1rZXJu
ZWwvbGludXgvbGludXgtY2lwXzUuMTAuMjU0LWNpcDcyLmJiIA0KPiBiL3JlY2lwZXMta2VybmVs
L2xpbnV4L2xpbnV4LWNpcF81LjEwLjI1Ni1jaXA3My5iYg0KPiBzaW1pbGFyaXR5IGluZGV4IDU0
JQ0KPiByZW5hbWUgZnJvbSByZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXBfNS4xMC4yNTQt
Y2lwNzIuYmINCj4gcmVuYW1lIHRvIHJlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWNpcF81LjEw
LjI1Ni1jaXA3My5iYg0KPiBpbmRleCBiNGJlZWRjLi40ZDJmZWM2IDEwMDY0NA0KPiAtLS0gYS9y
ZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC1jaXBfNS4xMC4yNTQtY2lwNzIuYmINCj4gKysrIGIv
cmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgtY2lwXzUuMTAuMjU2LWNpcDczLmJiDQo+IEBAIC0x
LDcgKzEsNyBAQA0KPiAgIw0KPiAgIyBDSVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ICAjDQo+
IC0jIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAyMS0yMDIzDQo+ICsjIENvcHlyaWdodCAo
YykgU2llbWVucyBBRywgMjAyNg0KDQoyMDIxLTIwMjYuIE9UT0gsIHRob3NlIGNoYW5nZXMgYXJl
IGdlbmVyYXRlZCBieSBzY3JpcHRzL3VwZGF0ZS1saW51eC1jaXAuc2ggYW55d2F5IC0gb3IgZGlk
IHlvdSBhY3R1YWxseSBjcmVhdGVkIHRoZW0gbWFudWFsbHk/IFByb2JhYmx5LCBiZWNhdXNlIHlv
dSBtaXNzZWQgNC4xOS1jaXAtcnQuLi4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0
aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=

