Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED6C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 16:00:38 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.54])
 by mx.groups.io with SMTP id smtpd.web11.649.1715184033237345233
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 09:00:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Y6cMcT7U;
 spf=pass (domain: renesas.com, ip: 40.107.114.54, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmZys066zPDhjDKGro1vVCXvXKrBaWsae+jBpYZs2VmRx+IgAEeKEvMM0gV6E8kzSIRN48BwDUKeaWFYQj53iB3QNNpzB8Wc+HY18MOCC69UPb8/O2RRgLq+1Zszdc+hpO0JIJc63cAXrmxHPf7xKS3UjCoPnqb7IIx5RZQdSII+MEm46iGwWnmy4x0cNyrLH8bmTUiH61BQkyE/C8MeK7c8DTmDehJ59UfxjLscNVE6inQo2Gzulm3Ds7HwBCPARDG7WZK6fQ0l4yYjT5FAdWnUByBlqtaySBVbqrJQsHR+Sjbn5fIE9D7OEwLALf42P/Sc/WNER06Tf3YGOSLHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=majVfUCySp89vDyDt4a0cngZH//GsO90JfEJeDEj/I8=;
 b=cc7XDMNozYpVx9X47R/bbwN3bziyJvaBFBartv/MGqWCmiZTqivqaRw06G/26iVzYbr+Ujua+/YP78ApAqgKvtvm5xHfg6yggKhNX7ZpCVRoIys2VBRbE/5Ti78Jf/aJvgQ6s6xAGZsMyPk0qgsdDutnfdDSgppMJBO1uJGR74jk6Ckd9EA731ghaFDLBY5z0NnzlWwyib7NJQtMPjUyoq02yZp/mINWzXxbipvOYCEkrYKq4PfztC6rFcPs4Kr0hNdUJEnqrN9s666Yu2h9wgQw1qjmpRn4/RrwtyAmF9e2vwMxDOTrIKHD4nz/xsFl55AAf+9FzSgK0IUcvFsd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=majVfUCySp89vDyDt4a0cngZH//GsO90JfEJeDEj/I8=;
 b=Y6cMcT7Uarz9O9BRGmKbpG/IMbMZ+Fp/inCahdumY92ZzNlkm6Z5EN894Zuv/SD+ldR4eo1jm2kC28BaRtnHOfcrDJB2XnZ3kS4X2tKub/qtdsRsat5acKlkGww63Z/DHpXCBMxEHCvl3vOsJ8oHmYvKU+JZggbxH2W6STJXWO8=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS3PR01MB10343.jpnprd01.prod.outlook.com (2603:1096:604:1fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 16:00:29 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7544.046; Wed, 8 May 2024
 16:00:22 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, "Kiszka, Jan (CT RDA IOT
 SES-DE)" <jan.kiszka@siemens.com>, "Schilling, Benjamin (MO MM R&D SYS SEC)"
	<schilling.benjamin@siemens.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Generic x86 kernel configration
Thread-Topic: [cip-dev] Generic x86 kernel configration
Thread-Index: AQHanXLBMHZXsuqxUEeBAFiIFDofR7GNhO0A
Date: Wed, 8 May 2024 16:00:21 +0000
Message-ID: 
 <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
In-Reply-To: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS3PR01MB10343:EE_
x-ms-office365-filtering-correlation-id: 41b50d76-3c3f-485c-498c-08dc6f77f741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QzM0SmNHKzRWSGtVU0NmMHVlTGlvS0huekg2bWI0azQ4SmZ0Y3FKTmVzR3No?=
 =?utf-8?B?b0tIZGhkVDdkd1FNZXNlUCtlTFhKNS9tTitXVGNJZGZaYk9qNU4reHFDcnky?=
 =?utf-8?B?cG40Zmg2aTNZbGFZOUxNMjVncTYxc0tVWHlhaG8yaERYQ2ppdk9xTk16MGZ5?=
 =?utf-8?B?aFZWa1RmSWhWNldHNHAzdEpXV1puYi9ZNXF0U3g4OFdZRllBT0Yvb3ZsclV5?=
 =?utf-8?B?RFBDMDFoek1TOE5jcDl6Umg3MndUNDI4WW5GZ254Qk85VVdGY1doam9UQjhR?=
 =?utf-8?B?cy9tSTAwdzlMYmU2RU8xSFl5WkJwa1BBUVlHZGdPNzVUMVRCYmtDZ2g2Y2FB?=
 =?utf-8?B?YVo0S0haYUhNMXlhbk55REFvVFRNcW9xYjM1c1gvdG9sdEdKRndqeFBKZFJj?=
 =?utf-8?B?MEpuV3B4QlRtdXZpa1BHOGw1NEpKamNXbXBGNnMyemFjb0locWdMRm50TTFw?=
 =?utf-8?B?QUtOU2phMFhzNk1FS1FnNXZ2ZzVuZGk5UngvaFhIU0pFOHZ2NGM2d21DeFFX?=
 =?utf-8?B?b3Nvb0xRTU5tYWJoZjVOUGxkQ1dFc1Q3UExOT2VjNmErdG54dXJnOTdMNlhm?=
 =?utf-8?B?VTNNZndkdytEcllhUDUvSGgxK0VrSnN0bFNjOFk4S0xBeG9IU1JIVkNZMmJp?=
 =?utf-8?B?cytNY1NjakFvZFdmN2dkQkt6OVZlSjBIMk9NL1BPemdPSThYU2FjZU55SjlO?=
 =?utf-8?B?SWgrdG5oMWJuV3JrbTBva3dDWWx1eWdxWkFWWlM2azJVZnFtbisyRUNYU2Zj?=
 =?utf-8?B?aWhOZDArSHRBalplL1ZmcmcwQ2NYMFdyTDBFUmlHOElnV3djbjA0Z3hhUXBY?=
 =?utf-8?B?aStoTjJBRDVpWWgwZWNBdFViVUY4NXpncFVnZ1lNMzVyc05nL1pyL3hXMm9N?=
 =?utf-8?B?N0tBZkRGT3dkMktoeUVJOGlDVTB2c1E0L1VmdStqU0MzLzlsRTlUeCs3aSsy?=
 =?utf-8?B?cXZhZERsMndQQWpMTTN3N1h0UjJlenJ1NTJ5aG5Mbi9oUG9VRUZ4dFRIcWov?=
 =?utf-8?B?ckpWcE4rclpmODhCVEtmMUJmK3M5WVhSd2FsOEtYemkvTWQ2aDA1L01sMnJG?=
 =?utf-8?B?ekJXV2xQOUIxbllwd1VIYlFVOHBiMzliK09RNlF2QUZEWk1DSGNLNGcyNDRi?=
 =?utf-8?B?Q1FjclR0V2czTitIRjc5WmVTYmR3b09BUHFnb09JR3hOYjRwY05jZXNXRnk2?=
 =?utf-8?B?RmVza0ZUWXZWWFhZLzA0OTZ6eFJBalhXTFlrSzRQakdYeTY3dVNQTk50SzVw?=
 =?utf-8?B?M2loZmhValJpNk90MlFzaVRzNy9aclprVWRGWUtTNFJYWVlSbDE5eFZUaWtv?=
 =?utf-8?B?TUZSY2t5bnFaSEVwRWpGbTBGNFN1dXVwaUI5VDZrakd3cnp6WGpqak8zU3Fq?=
 =?utf-8?B?dThnVmVaUzR2UllSaTNWV282YnVrdEFEeE9EdjVxNDRlaFkxQ3FGWGxFaHdQ?=
 =?utf-8?B?U2hXOXpxQzhLa2h6WWtmWmVpUWJubHYzalpobHlnLzc0bXBMRjB3WFBoa2ZS?=
 =?utf-8?B?cmJvVHRwZS9IaHMrN0xZRXdHcHNud01VeHlxUXk3UFpCTlF2YzlZaytuUnlM?=
 =?utf-8?B?cEE3WHMrMWRxNDBQcnBWMTZBRlZRS1ZlaXdqRjZWN2ZRVGFzMGszdWZrZHhM?=
 =?utf-8?B?RS8wL281YVp0Q1Z0ZEN0R1M3UG9IL2ViamYrcGU5VjJGZ1A5NzJsWVJCYjdJ?=
 =?utf-8?B?MEo5WFI1MUs5a0wvYTRXTml5b3BuWUJyYVdwRXFTOEtQeXJTVytkcEZBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFZybnMrV0tkNXFRb2ZZT3R3Y01xMHdSdXd1UFVCT2Y1bUxpM2ZoQWhJdHcy?=
 =?utf-8?B?eVJYb2Rxd3pqNzExeEVzNENZY3MwTm5mRmdHMFVHVnc0YUJtUm0yZWZxM3BC?=
 =?utf-8?B?bXRVaDF1MHRZZTUwMW5RbW9zYzBReHpJeG01eGRseGVxVi9uZzdBT1IyOVl1?=
 =?utf-8?B?ckFnN3JRUitycUJaQ3hvUmxZckFvOVErcyt6bit3cWRvalNBRUhGbUlnNU84?=
 =?utf-8?B?WHo1dHNsaHI1YmhPNHdhNEJ3bm9ZMVRTKzBTbW1qVDNNaTkxcWxsVW1OYTFu?=
 =?utf-8?B?aFN5anRtQXZKWDJ1R2Q5cW1LREpYL0VCVTljKzhqWmtMeENnVEVraXVod001?=
 =?utf-8?B?V1pwQmNqeEZnRWNQeWdWdytZdGhMNDBENnNtYzllUGdNanljTHRiMXZpdllQ?=
 =?utf-8?B?TVJvQ3gxcmlkMGxTRXhmaVJSbGpjZzEwakphMXp6UDdlWTJ1K0ZNcVpHT01r?=
 =?utf-8?B?b0FueDRoZ1pmU1lVSjZueHhORlA2TGE1MFdoU3E1dUp4QUR2UG9aMURRVENx?=
 =?utf-8?B?eEJVMEdleGdmbGliNzBOS1hxcTMxQThNbFB0a0JrM3ptbGhyaFI5azh4Vkcv?=
 =?utf-8?B?WEtJK1Z1MzZFR2NHdFVuMHowRG9HbW5xQUFJcmd6eVJ6WG1XYVVtM3phRUJi?=
 =?utf-8?B?TXNSVFQyaEtQVG1jSVJrZ2VZb1F6Vno2ZXZ3bXhBdnBjcjVkdU1WbEFSZ3oz?=
 =?utf-8?B?RkZuRjRaMDhZWlo1NXpvR2t2OENLcnZIZVBIczcvL2RzM0Y1cW5lMHBaUmFY?=
 =?utf-8?B?MVo5c21NSDVmdUNoWi9aOS92L0tCTXhGS2hRY2VKcmp4dmE1ZVJKRWJjZnNB?=
 =?utf-8?B?WkpUMmNFcjFJTUFUQWQva1J1VVFQUmxYM2owSmNmbVV3OTlYbE5jNjRCa2lI?=
 =?utf-8?B?Q2U3Ly81WkRVOWN6bFBmdTVVemZBRmZDNFpLQWpQbU1KaHRYZHc3eGhoRG9M?=
 =?utf-8?B?YUJXV0JsZzJ2ai9reEJ3dS9BUVdralY3VUFMTkcvUlE4Z3lZSWh2TWNFalA0?=
 =?utf-8?B?RVBuam02L2lEWFpoTHE3ekhWQmdnaGNYM0Erc3dtYXdHVVhnUzN5OVBmRGg0?=
 =?utf-8?B?bVcyUXgramVRV2wxLzJ5Wk1XaGVZTkJCREtJaWp3b3JwcXVNeWxlVWsrcEV5?=
 =?utf-8?B?dXU0Z0RiY1hUWkVQaTBOTEx3bDRBcjNMa1JzY1BEVDNLaFhhcTU5QXpOelRw?=
 =?utf-8?B?enlZQmYydytSMUdPUGJ4NUZUZWl2ZTAwZHdOMmN6MGlXUXlVMEswUnZuVUwr?=
 =?utf-8?B?M0ZzLzljL1hSV3NDTzJmTXJFZmRZeDV6UEFjT01HNmpxeHEvNWsxWENzc004?=
 =?utf-8?B?WHl3UzdhQSsweDJJSDdIRnhRUjc4cDBjaFBxODBZSXhwdE85RXpIZzFSblRJ?=
 =?utf-8?B?R3UvYzhWZGs2a3dnNStkTHJMR2dKRWV2c2VhdUVCVDNxTVpGcnU2MUtwdDd6?=
 =?utf-8?B?a1BzZzhzenU5QjBoK2Z0T1Q0MTNmdjJPOEkrWmE0UklqSWwxV2xVeTQ2Syt6?=
 =?utf-8?B?T0JYK2Y4WER3TVdrc0VzVEs1bnBoTnlLZFFMRklCTXlSQUpScGQxczM0N2FL?=
 =?utf-8?B?cTJ2S1Y0bUpUOHRhMk11VmZxWmRRWEZhdDVJN2hHZU93Nk5oYkNMSHBtaXMr?=
 =?utf-8?B?V2xqZ3diNjZQK0N1cU9jNkJseWVxYWg4UXllc0lHRzNuM3d6RU92dE9Qc3NO?=
 =?utf-8?B?UEE0TENKYVdpRnc4YTkxMUhXcTdnTnFpVDFUTkFzSWNlUVlSTG5nV0JuYmhT?=
 =?utf-8?B?bXpVNjFjUnJuOXBxUXhMSVg1ZUFLN3FwRHM4ME9Qbk1TS3VkZy9YcnZRRU8r?=
 =?utf-8?B?NEc0elhIZFdxdTc2RTQzSkNNTDl0R2dvdTcrcjdnZktBczBGNWcwTlV1SnlT?=
 =?utf-8?B?TjF3STBPRDRRSjJsSTFWeXJ5MnA1KzltZUh6VEZZVEFtWHErTkZpcVJvalVa?=
 =?utf-8?B?eTh1T2tFeEtTakpWTytXdVJzQ0tzZGJhQUFJckNMdUFtck1NRnZnamJIb2tu?=
 =?utf-8?B?bEtBRG9SdzVxWGdzcFFKdEloZk5WTXM0SzRQTlhFQTFOZ29udG5LaWU0MkVP?=
 =?utf-8?B?dWRDNVBHeDVhcmxvTStTRURhQXAxS1ZHVmN2ZEpZck05VFl5cC8rdHIrek9E?=
 =?utf-8?B?dXhGS1VQZ3QrNVBEem5MOXRySE90QzZwRVNtT0ZhVTNDd0hUK3VzVlIzNlN5?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b50d76-3c3f-485c-498c-08dc6f77f741
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 16:00:21.9785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sEVJ+8Ahkw7xt8xC+oOSD5enLUTTY6SNZjttHTWmiy1+UfSrQmXC2b3JId2Lj+/6p3ixaHl6YAqeo9vhMLr96M3hlRf9aZnl6fxfkmLq2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10343
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 16:00:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15862

SGVsbG8gUXVpcmluLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgd29yayBvbiB0aGlzLg0KDQo+IEZy
b206IEd5bHN0b3JmZiBRdWlyaW4gPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgTWF5IDMsIDIwMjQgNDo1OCBQTQ0KPiANCj4gRGVhciBhbGwsDQo+IA0KPiBJ
IGhhdmUgdXNlZCBhIGZvcmtlZCB2ZXJzaW9uIG9mIFsxXSwgd2hpY2ggeW91IGNhbiBmaW5kIGhl
cmVbMl0gdG8NCj4gbWVyZ2UgdGhlIGZvbGxvd2luZyB4ODYga2VybmVsIGNvbmZpZ3MgdG9nZXRo
ZXI6DQo+IA0KPiBjaXAta2VybmVsLWNvbmZpZy81LjEwLnktY2lwL3g4Ni9zaWVtZW5zX3NlcnZl
cl9kZWZjb25maWcnDQo+IGNpcC1rZXJuZWwtY29uZmlnLzUuMTAueS1jaXAveDg2L3Rvc2hpYmFf
YXRvbV9iYXl0cmFpbF9jaXBfZGVmY29uZmlnJw0KPiBjaXAta2VybmVsLWNvbmZpZy81LjEwLnkt
Y2lwL3g4Ni9zaWVtZW5zX2lwYzEyN2VfZGVmY29uZmlnJw0KPiBjaXAta2VybmVsLWNvbmZpZy81
LjEwLnktY2lwL3g4Ni9wbGF0aG9tZV9vYnN2eDJfZGVmY29uZmlnJw0KPiBjaXAta2VybmVsLWNv
bmZpZy81LjEwLnktY2lwL3g4Ni9jaXBfcWVtdV9kZWZjb25maWcnDQo+IGNpcC1rZXJuZWwtY29u
ZmlnLzUuMTAueS1jaXAveDg2L3NpZW1lbnNfaXBjMjI3ZV9kZWZjb25maWcnDQo+IGNpcC1rZXJu
ZWwtY29uZmlnLzUuMTAueS1jaXAveDg2L3NpZW1lbnNfaW90MjAwMF9kZWZjb25maWcnDQo+IGNp
cF9jb3JlX21lcmdlX2tlcm5lbF9jb25maWcvcmVjaXBlcy1rZXJuZWwvbGludXgvZmlsZXMvbWNv
bS5jZmcnDQo+IA0KPiANCj4gSSBoYXZlIHRlc3RlZCB0aGUgdjUuMTAuMjE0LWNpcDQ2IHZlcnNp
b24gb2YgdGhlIGNvbmZpZyB3aXRoIHFlbXUtYW1kNjQuDQo+IFRoZSBuZXh0IHN0ZXAgd291bGQg
YmUgdG8gY2hlY2sgaXQgaW4gdGhlIGNpcCBsYWIgb24gdGhlIHJlYWwgaGFyZHdhcmUuDQo+IA0K
PiBUaGUgc2NyaXB0IHRha2VzIHRoZSBLY29uZmlnIGVudHJpZXMgb2YgdGhlIHNwZWNpZmljIGtl
cm5lbCB2ZXJzaW9uIGludG8NCj4gYWNjb3VudC4gSXQgYWxzbyBhZGRzIGFsbCBkZXBlbmRlbmNp
ZXMgdG8gdGhlIGNvbmZpZy4gWW91IGNhbiBmaW5kIHRvDQo+IGxvZyBvZiB0aGUgbWVyZ2UgYXQg
WzNdIGFuZCB0aGUgZGlmZnMgdG8gZWFjaCBjb25maWd1cmF0aW9uIGF0IFs0XS4NCj4gDQo+IEFu
IGZpcnN0IGludGVncmF0aW9uIGludG8gY2lwLWNvcmUgY2FuIGJlIGZvdW5kIGF0IFs1XS4NCj4g
DQo+IEFueSBjb21tZW50cyBmcm9tIHlvdXIgc2lkZT8NCg0KSSBoYWQgYSBnbyBhdCBidWlsZGlu
Zy9ib290IHRlc3RpbmcgdGhlIGxpbnV4LWNpcCA2LjEga2VybmVsIGluIG91ciBHaXRMYWIgQ0kg
c2V0dXAgdXNpbmcgeW91ciBtZXJnZWQgY29uZmlnOg0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1w
cm9qZWN0L2NpcC1rZXJuZWwvbGludXgtY2lwLy0vcGlwZWxpbmVzLzEyODM0NzY4MDENCg0KSXQg
YnVpbHQgYW5kIGJvb3RlZCBva2F5IG9uIHRoZSBpcGMyMjdlLg0KSG93ZXZlciwgaXQgZGlkbid0
IGJvb3Qgb24gdGhlIHFlbXUgc2V0dXAgaW4gb3VyIExBVkEgbGFiOg0KaHR0cHM6Ly9sYXZhLmNp
cGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTEyOTk2OA0KIlRoaXMga2VybmVsIHJlcXVpcmVz
IHRoZSBmb2xsb3dpbmcgZmVhdHVyZXMgbm90IHByZXNlbnQgb24gdGhlIENQVTogbW92YmUiDQoN
CkkgZG9uJ3Qga25vdyBpZiB0aGF0J3MgYW4gaXNzdWUgd2l0aCBvdXIgcWVtdSBzZXR1cCBvciB3
aXRoIHRoZSBrZXJuZWwgY29uZmlnLg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQo=

