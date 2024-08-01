Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B32C3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 11:43:36 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.55])
 by mx.groups.io with SMTP id smtpd.web10.62130.1722493996296033062
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 23:33:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=InBLRJGm;
 spf=pass (domain: siemens.com, ip: 40.107.104.55, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzDFXKEXg3f0gyUlqo70ruiGoeC6haXmmRaz/eU18Tl9UGGohdVOplpW4Q0ryiZI4RBoZkgt0XZ3N92nCS1IB9OTIThwxjEKeeenk6f+9yyvi2wRLMgorJfGkDFg+lHokrD3DR6cunivqJkD50sPURxH/povQJGPx0dtOn13444kt6BWgQW4m95fU5IAs5NF3pVkCuglDczCdKFNBeyihYhzMhfdS5+715PWEnSAO2PGoPnXj5mGRudAIKqn4sszDxeRimvaVzf8xFHrLVy56+xTsToA1PNHeZM8/La4FwJDiXBZ+39RXSO2gsZZQtuiSFAJTnlYQhbbahchazHY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2YdnhFvqlmWEKS1RZfeGOqscUHvSbdBdVRiaj2Imps=;
 b=cnjTHVOSBaMs+VaNF+SDyGXzDRDxmYHvXdevCDoCkGpn+Exi9K3jIwD4o0rf/IqkZfGCmjrZidKAqNCYUv9pL8sRN8mXcsyS7wcFJlaQZSS99HQli55vMaXP4GklWuBDcyjAnjzOnK+i25WmUOCdFSX+tKsMgXbTSLFK+d0UhD3xq1E+ZDUoDA/L8E4ka+aVgnSNIdcuJgrWxnKgYUysSljxxdcAytPlhn/5sriunFQGgeOSwHQWLH5VFXZMZR4B0jdtotemQC1ZrxkapEE40bQY1lUn8NolIx7b4vK6gXoBFo3IYBOkrumApOoecnfs0RrepkBdIeljFexMzUe++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2YdnhFvqlmWEKS1RZfeGOqscUHvSbdBdVRiaj2Imps=;
 b=InBLRJGmZz7e6lpnjKVlfGqESIr6nlKvRBhOf1KiLqCL7KG8l0QOud10gw1mCU/jAzal9Fjj/2J3mpjZi2WdGgA9+BfvgSmxwZrmNGSwIJWAW8WHLToTYZkmYjuokAhK4lYyYEyBLOZ1J1I8j3sGSF5nCnHiDwC3v+Z2Ognvhugrz86kzWU6/NTltMvq3HGWnyPo5uTzl7BOi1jjvJt4NZT8L+9aGJZelimR/mT1MqRBxnn8c+iPKUOwsPtlUwGaZY46RSr5ndvzvAvxGN/fTYuLgl6Bm3OuoghbWjAoILNvfxh6hTzRJyyJvzqbVaLz1/vGbojVAgiitOdLP1hEXw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VI1PR10MB3326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 06:33:11 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 06:33:11 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "jan.kiszka@web.de" <jan.kiszka@web.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "Arjunan, Srinu" <srinuvasan.a@siemens.com>
Subject: Re: [isar-cip-core] [PATCH v2] classes/squashfs.bbclass: exclude boot dir for efibootguard bootloader
Thread-Topic: [isar-cip-core] [PATCH v2] classes/squashfs.bbclass: exclude
 boot dir for efibootguard bootloader
Thread-Index: AQHa3OgJwvfbNkeNAkK5Y9JMi1TncrIRHLIAgADi2AA=
Date: Thu, 1 Aug 2024 06:33:10 +0000
Message-ID: <62f86ea16dd812e7e0ea25208c9196c71b4e4bbb.camel@siemens.com>
References: <284ef2098da5aaeff02a565c4316fff854add437.camel@siemens.com>
	 <20240723100631.75683-1-srinuvasan.a@siemens.com>
	 <12d8317a-9510-431b-b24a-9175192e6378@web.de>
In-Reply-To: <12d8317a-9510-431b-b24a-9175192e6378@web.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VI1PR10MB3326:EE_
x-ms-office365-filtering-correlation-id: 16ffbf1f-7285-45ec-0f67-08dcb1f3d060
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MVVSOCsvMDNhNURhbEpDeFZuVjB0K29MekovdXZZcGFuNTlyNGZQdzhwMkRv?=
 =?utf-8?B?N0R0UllpTVdnOXhxUm1BTE9TTGhpamJHUC8rR0ZhNVMwckR4SktrdFFiQVRr?=
 =?utf-8?B?UEgySSt4cXJ3SzhheWF0T2NuSHZWMlJSK0xsZ0lmYW9IRlM1cGFDT1YybHNC?=
 =?utf-8?B?TTBxODljVTY1OW14T2Y0OE1PNTVMbXIvSUhrKzcrSExuWmZQYjFuRHE4aHJi?=
 =?utf-8?B?UXptVW9YNG1QV1JEb2IxTDhoYlJ2UWQ5VElNRE1yYkQvTDlwbm5wNHRSbm5v?=
 =?utf-8?B?TlhmeGJJc2lQcmszeDh4MlA5QytPdlVmU2YzcVJuWjlaUjZzdDlqVnJieHVs?=
 =?utf-8?B?R01zbmtQUVl4NGgwdzd2QzN0dTlLQ0dMZW1JWEFGc1h5WmEvVGY3bVVuZTFD?=
 =?utf-8?B?aFoyalVLM1dhODZIOFlBUGp6eDFMbXJZUVlPNkJYWXJnSGpxWmNVT1JXa1Uy?=
 =?utf-8?B?STJVdWJXQmtUVGo0N1lEQlFzaDhGUzB2RVJRM1IveWJWY1MxRlVMd0RxbU94?=
 =?utf-8?B?bWNmZ2tyNDdzUkhKUGdFeG5HU014VmtyQkwrOXZRcUhkaGF3SUV6NzViTHRV?=
 =?utf-8?B?aiswemtPMFFIeXM4ZmNYdkc2R2lIY0VFWks3K1hQLzdVVnNYaTk2TFlVNTQw?=
 =?utf-8?B?aE5kajBoVFEyTEhCNnUxR0Mwc3VEaUdaNVlkR0RiUFp4Ym9yOGhtRkRTK1VZ?=
 =?utf-8?B?UUlkZGU5Q2xUNkJmWmRiTmEzTzFZMkI1Yjh4Vys1eTB5Q1dYYnQwNkRZa21Q?=
 =?utf-8?B?MERpQUJsK3pMbXlTNUVMTWx6bDQvUldpRS9EbHM5SEFlWHBWOTBEakcyMWYv?=
 =?utf-8?B?a004MnVmdllLa2MwekFkdnZxZUFQVjA4bjdtSDhqaThxMkROQko0bU5jM3JD?=
 =?utf-8?B?KzRhNjJjdkVvMHkvYzBuNHFjZlRFcXlwcHF6Q1kzQjIrWGU5eXJDNm9OSzRp?=
 =?utf-8?B?MzhvOHlYc2R4djFHODBBWXZlckVmL3puUldTby9DWHVHck1kT3dybW8xWnBG?=
 =?utf-8?B?OStSaDB5T3NpR0thb0VOaFdYRlhkb1o3TXlCdlZiUVh2NnJrQXUxc3hXTlZm?=
 =?utf-8?B?MEtqZEhpNldQMk1Sb3dSTzVZbGFsbFdKbkdleVRpNXhRaENQbjRPK3MrZTR2?=
 =?utf-8?B?RDRMZWUrdXFVZEdsMlk1dExxYi9oWFRaUWRHRG92Rm9tSFJNTEpIMlZ1cW9j?=
 =?utf-8?B?ejdqaG42Q0l6UHZrNjhhQWk5MWliNlpWWWc4OTZNM2pxTUJyR2xKcUpEVkxq?=
 =?utf-8?B?QWdQMm9ocUZxa1NUYTlvNjc5N3F4aDJrOUNnMzd2Y0pDS0NybHY4SFVpWTg2?=
 =?utf-8?B?Q1gwQXN2T0JzcnRQWDZBY2hZNi9hRVNWNlhnckpEWDE5dzFUc2JXaTkzaXpj?=
 =?utf-8?B?bkVQSDc4MFVvbmgyWm5nc0pNb2hNbUxqT0ExeERxclJrV3VvTHZZcFNEcTRp?=
 =?utf-8?B?SENqY2hZcHAvbGtLOVNpdDNkZ08zbTdtbHEyQ0hXMUI5Ny8xME14YjcvVDhP?=
 =?utf-8?B?YmgrRytOQWdQL0RiYjJoZ2REVlRlNStyVGgrZTZlUzMrV3Yydzl4ZG9HbllB?=
 =?utf-8?B?R2wrcGtMUFFSbnkxbGcwRWhYWm5HYlFZcklpUDNRZE5QMTdwYjYvMnJZUFRC?=
 =?utf-8?B?S21mK3pjTGtSUFlFWWQ1Zkp0amJrQm16em9hcVVlUHg0QjRrdUwzS2VEMGhj?=
 =?utf-8?B?c2lEcnBHcWxrZTZkVnpSTmtFaG9TNlcyODVCNEErVWExM1pMZDkrQXJpNitk?=
 =?utf-8?B?SHBrVzJ3SmdQY0FHdzIxekRHS2lFb1ZyOUhrcDFMYXY4aFpkU2xJZkYyeGht?=
 =?utf-8?B?cXVZd0o2RmdHcm1pSFFLODlLbU9pNSs4bS9XRFdPSGxseGNaaERVQzZRNHpC?=
 =?utf-8?B?WDdNTTV1NUl6Mm9DZ0dHaEJPN0NGOFNUVDFWM2QyREpxWEE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bU1PQ09uWFhIOURBNTlQNDF2YTlrS25IbndaTmI3UXhWVEp6blZrRzN2K0dr?=
 =?utf-8?B?RWh1K0R3blM3aXpsWW9pbVRHdERoNTZlMDFleWJkbUZFV0o2K3U3WFJuYmkx?=
 =?utf-8?B?YVNCNVhXSlNKMERpUGgrY0prMkFaMHlFMURSa2NqRlRsTTB0WmNKZ0xTUEFp?=
 =?utf-8?B?NC9aSi8ydVdOY3o2RVZUMTlWbWM1RWJkRG1nSkNKSzFOYjg3VlFFMzZ0V3h1?=
 =?utf-8?B?aTdETjdYdnNoQkxjZVorTmUyRmVBSmY2cmNZOFF2Y01kcTN0dWQ2RW5TOXJ2?=
 =?utf-8?B?SzJ1YTNiMzZYWkZkYTJMWGQ1aEV3TzBhRWswcndQc0ZxbjJRc0pQNzB6YUhu?=
 =?utf-8?B?ZDJ6OFRjNW1nZWhzSjhWd2FJWHRPT2xzc21PMFp0RmpPWUlOWTViRERBRGlN?=
 =?utf-8?B?YTZMZ2hhUy9vaXBpU2s4V1puQlBjVUFqdkVxU3I1THBPVThqaWRiMEc0eHZs?=
 =?utf-8?B?QVhNbEg3QS9YdmVyeEh0ZGRsazV4QzdwcTJnOUZzN3kwVVRhb2dBcWE1YUJD?=
 =?utf-8?B?Mzg3Y2hYSXZHczNjSEsyNUF4bHRPWTdFS1ZnOGVKYWIxMS9sd3lEbEdnWkty?=
 =?utf-8?B?V3lJMmNYS2hkMFJTS3Q5U2p6bElqVnBIelRSSHJITVlYbllXOU9oaVhoZlEx?=
 =?utf-8?B?RTk4WEdWbmhNMU8yNFJhU3JFOCtqZGxkbVBKb2ZCRUxwbFBZaFJLa25POW1X?=
 =?utf-8?B?TEpjVXFLZ1ZmSzJIaVVxdEVydUh5K0FSM0hkM2lBOXVLcXNQV2E0dll5cS9S?=
 =?utf-8?B?VEFTSzQyTXRxdUpzK2Z1YTBQV3h1MVRudHN2dGE2MC9GbkVSVWVRRzZXNHBM?=
 =?utf-8?B?RXY2SjBvWCtZMmFBOEhIZVYvanllU1NIMlZXcGJheXBGTXZ4Z3N1NVhyWlhR?=
 =?utf-8?B?NkRpRVNQc1pIYUE5cHNLQ2ZtcTRmUDAyME9MUDBaZlk3bTlRckJGZFJhSllN?=
 =?utf-8?B?Y3lLU2FBU3JrMVJQTWhxaXRvS01GSVlBNy9UWUpnU05waWxPNmVwaXJycjVH?=
 =?utf-8?B?dUozcEd0QkkyWVZROTVKczAvTTd5eTl4SXp3R0dMUkRGRnZ0MDJrcTltYlBz?=
 =?utf-8?B?U0lLc29aRGtTMkNQS1NHMlQ3SE43Q0FxYU1tb2VoL1dWUzJwRCszaVBDS3lC?=
 =?utf-8?B?dVBGY3FETkVucFM5Nmx2ZmxOMjFIeGd1cUhmYVJ5RlBjNWtWYTNEMkxKMFB1?=
 =?utf-8?B?ajhHZVU1UGlISkJHemhMTnZEbTJ0MTBaellWZ1VFNm8rSlpQL3pYSm8wcWlR?=
 =?utf-8?B?REZ5SUV5WXpGai9jRTR1cWxpeHFQQTByK3c5aGJVcEJySFBPZFJhbFNzL1VK?=
 =?utf-8?B?VUx2TXRRaVpUZ3VHTnRCUE9yNktERlFtbXkxcTFVbHJwM0l1VUtXb3JDNy9u?=
 =?utf-8?B?OW9lb2ZTaGw2QzI3ZkZNWGhMMDBOdTN6MW9Vb2lhMFI4ZEdXQUV3WnZ3eGN0?=
 =?utf-8?B?c05YVUdqeFQ4cW81bS9xelVoQjNXS0xuNExSOGZsRGR0c0xYZFllZ2s1cDdT?=
 =?utf-8?B?SW1Ka203WWo1aDl5dlY2Sk5KZGVmeHhGd2tLcy8wUlZsKzNvVVRIV3E3R3Vv?=
 =?utf-8?B?SCtYTDdheHdaTFNBQmQ3ZE9pd2gyeFB3NVFxU1orQ1JNeUFHT3A2QUdOZWZO?=
 =?utf-8?B?aE52bTAvRHhpTVhYK1h2UkVKN1dXQWFzYmF3WEVVS0lPN280YTVaQlRzaFZL?=
 =?utf-8?B?alYzL0RJZnJ2S3NkNVNzTnZqNXZ6L2NCMnRBcHlRQkg0QW0yRUpVQW05QTVX?=
 =?utf-8?B?UEJYVEVBM2MvVzZYQi9pd2NBWWpJTm1FdlYxV0J4NmZRdkU4bE53MllmSG0w?=
 =?utf-8?B?SDNpVUpOeTRGQXlneEVuQXpOZmVPSHNNZHA2Nk80czZ1M0Q0QWR6TVRCd2FE?=
 =?utf-8?B?clM3dnczRDRSVXgrSlFQNlFxMVpveG9PeFJTVkpIUUdyZnVGdkdydStObmJJ?=
 =?utf-8?B?MndncjMxN3NKYnpRNThSd2ZFNWhJeHMxblJkZW5LVFFpUUNMQk9WcS9IdCtH?=
 =?utf-8?B?MUkyNUhvS2szOEtTaTBYejZoajNkVXZNOVFpREtNZ0VsYTdKcXhSTy9HK21G?=
 =?utf-8?B?L1Zia1g3cFZmNFQzMDNLZ2UrSkNHUTYzWEkyNEQwYklDSENyNHBTSDhBMkdr?=
 =?utf-8?B?Nm9TTk83RUs2Nmc0QW9vWTNUN0ZpdGxyQm1hbzBJR2RtWmV4d2lHY3VmWWRw?=
 =?utf-8?B?Nko4UDBiQzV1dS9aenhVNXQxUDF3VGhoUFg0UDFHUWtkdVNma1dMeVVxYS9n?=
 =?utf-8?Q?XY8khZh322OFn5TaocpBPxsuaQHUmyX75vaaIqBAIU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ffbf1f-7285-45ec-0f67-08dcb1f3d060
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 06:33:10.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GgXdZCcF86acDnWyw78T46ya04SRUUMLNeiQ+irNoexC08NdKPVlJuHCFHdENpkk3lAjsPivqMLEFXNpC14+n1Yg0Ty/mjyilgx/RzERtNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3326
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C67B9F93D947144494250225E6D14ACB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Aug 2024 11:43:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16704

T24gV2VkLCAyMDI0LTA3LTMxIGF0IDE5OjAxICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMy4wNy4yNCAxMjowNiwgc3JpbnV2YXNhbi5hQHNpZW1lbnMuY29twqB3cm90ZToNCj4gPiBG
cm9tOiBzcmludXZhc2FuIDxzcmludXZhc2FuLmFAc2llbWVucy5jb20+DQo+ID4gDQo+ID4gZWZp
Ym9vdGd1YXJkIGJhc2VkIGJvb3Rsb2FkZXIgYm9vdCB0aGUgc3lzdGVtIHVzaW5nIGxpbnV4LmVm
aSAoVUtJKQ0KPiA+IGFuZCBpdCBoYXMNCj4gPiB0aGUgbmVjZXNzYXJ5IGJvb3QgZmlsZXMgdG8g
Ym9vdCB0aGUgc3lzdGVtLCBoZW5jZSB3ZSBhZGRlZCBib290DQo+ID4gZGlyIGFzIHRoZSBleGNs
dWRlIGRpcg0KPiA+IGluIHNxdWFzaGZzIHJvb3QgZmlsZSBzeXN0ZW0gdG8gcmVtb3ZlIHRoZSBj
b250ZW50cyBmcm9tIHRoZSBib290DQo+ID4gZGlyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IHNyaW51dmFzYW4gPHNyaW51dmFzYW4uYUBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGNs
YXNzZXMvc3F1YXNoZnMuYmJjbGFzcyB8IDMgKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2NsYXNzZXMvc3F1YXNoZnMuYmJj
bGFzcyBiL2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcw0KPiA+IGluZGV4IGIzOWJlMGMuLjI1ODJj
ZTIgMTAwNjQ0DQo+ID4gLS0tIGEvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+ID4gKysrIGIv
Y2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+ID4gQEAgLTIzLDYgKzIzLDcgQEAgZGVmIGdldF9m
cmVlX21lbSgpOg0KPiA+IMKgSU1BR0VSX0lOU1RBTEw6c3F1YXNoZnMgKz0gInNxdWFzaGZzLXRv
b2xzIg0KPiA+IA0KPiA+IMKgU1FVQVNIRlNfRVhDTFVERV9ESVJTID89ICIiDQo+ID4gK1NRVUFT
SEZTX0VYQ0xVREVfRElSU19FRkkgPz0gImJvb3QiDQo+ID4gwqBTUVVBU0hGU19DT05URU5UID89
ICIke1BQX1JPT1RGU30iDQo+ID4gwqBTUVVBU0hGU19DUkVBVElPTl9BUkdTID89ICIiDQo+ID4g
DQo+ID4gQEAgLTMxLDYgKzMyLDggQEAgU1FVQVNIRlNfTUVNTElNSVQgPz0gIiR7QGludChnZXRf
ZnJlZV9tZW0oKSAqDQo+ID4gMy80KX0iDQo+ID4gwqBTUVVBU0hGU19DUkVBVElPTl9MSU1JVFMg
PSAiLW1lbSAke1NRVUFTSEZTX01FTUxJTUlUfSAtcHJvY2Vzc29ycw0KPiA+ICR7U1FVQVNIRlNf
VEhSRUFEU30iDQo+ID4gDQo+ID4gwqBweXRob24gX19hbm9ueW1vdXMoKSB7DQo+ID4gK8KgwqDC
oCBpZiAoZC5nZXRWYXIoJ1NXVVBEQVRFX0JPT1RMT0FERVInKSA9PSAnZWZpYm9vdGd1YXJkJyk6
DQo+ID4gK8KgwqDCoMKgwqDCoMKgIGQuc2V0VmFyKCdTUVVBU0hGU19FWENMVURFX0RJUlMnLA0K
PiA+ICcke1NRVUFTSEZTX0VYQ0xVREVfRElSU19FRkl9JykNCj4gDQo+IEkgc3RpbGwgZG9uJ3Qg
Z2V0IHdoeSB3ZSBzaG91bGQgY2FycnkgdGhpcyBrbm93bGVkZ2UgaGVyZS4gSXQgaXMgYWxzbw0K
PiBtaXhpbmcgdXAgIkVGSSIgd2l0aCAiZWZpYm9vdGd1YXJkIiAtIHRoZXJlIGlzIG5vIGVmaWJv
b3RndWFyZA0KPiB3aXRob3V0DQo+IEVGSSwgYnV0IHRoZSBvdGhlciB3YXkgYXJvdW5kIGlzIHBv
c3NpYmxlLg0KDQpJIHdvdWxkIHJhdGhlciBqdXN0IGFkZCB0aGUgL2Jvb3QgZGlyIHRvIHRoZSBn
ZW5lcmljDQpTUVVBU0hGU19FWENMVURFX0RJUlMgdmFyaWFibGUuIFRoZXJlIGlzIG5vIG5lZWQg
dG8gZGlzcGF0Y2ggYmFzZWQgb24NCnRoZSBib290bG9hZGVyIChhcyB3ZSBjYW4gZXhjbHVkZSBk
aXJzIHdoaWNoIGFyZSBub3QgcHJlc2VudCBhcyB3ZWxsKS4NCg0KPiANCj4gQW5kIHRoZW4gaXQg
aXMgdGhlIGltYWdlIHJlY2lwZSBvciAtIGV2ZW4gY2xvc2VyIC0gdGhlIHdrcyBmaWxlIHRoYXQN
Cj4gYnJpbmdzIGl0IGFsbCB0b2dldGhlciwgdGhlIGZhY3QgdGhhdCBzcXVhc2hmcyBpcyB1c2Vk
IGZvciByb290ZnMNCj4gKGFuZA0KPiBvbmx5IGZvciB0aGF0PyE/KSwgdGhhdCB0aGVyZSBpcyBz
b21lIGJvb3QgZm9sZGVyIHRoYXQgaXMgbm90IG5lZWRlZA0KPiB0d2ljZS4NCg0KSSBkb24ndCBr
bm93IHdoeSB0aGUgc3F1YXNoZnMgcm9vdGZzIHdhcyBtb2RlbGVkIGFzIGJiY2xhc3MgYW5kIG5v
dCBhcw0KcGFydCBvZiB0aGUgd2ljIGltYWdpbmcuIFRoaXMgYWxyZWFkeSBjcmVhdGVkIHByb2Js
ZW1zIGluIHRoZSBwYXN0LCBhcw0KdGhlIGZzdGFiIGluIHRoZSBzcXVhc2hmcyBpcyB0aGUgb25l
IGZyb20gdGhlIHJvb3RmcyBhbmQgbm90IHRoZQ0KcGF0Y2hlZCBvbmUgZnJvbSB3aWMuDQoNCkNo
YW5naW5nIHRoaXMgbWlnaHQgYmUgYSBzb21lIGVmZm9ydCwgZHVlIHRvIGl0cyBpbnRlZ3JhdGlv
biBpbiB0aGUNCnN3dXBkYXRlIGNsYXNzLCB0aG91Z2guDQoNCkZlbGl4DQoNCj4gDQo+IEphbg0K
PiANCj4gPiDCoMKgwqDCoCBleGNsdWRlX2RpcmVjdG9yaWVzID0NCj4gPiBkLmdldFZhcignU1FV
QVNIRlNfRVhDTFVERV9ESVJTJykuc3BsaXQoKQ0KPiA+IMKgwqDCoMKgIGlmIGxlbihleGNsdWRl
X2RpcmVjdG9yaWVzKSA9PSAwOg0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuDQo+IA0KDQot
LSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

