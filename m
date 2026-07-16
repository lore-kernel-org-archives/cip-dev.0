Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD0C4450E
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 11:39:41 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10891.1784201975939853660
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 04:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=T/IV7ZFH;
 spf=pass (domain: renesas.com, ip: 40.107.74.34, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6k/1GLR6P2Is+C+9Y8YQ6L0PTf54owOaxtey/c1TBlwb2hHfYyqY6r02PXBlud/ccFWoNhmej0aG/EMuiTEin58HaMvBXWv6fiXhfbMjnN5DOSBytzhIbz7QcYZcql3cSoMfkX08QuZVvF0pMW6BqQ4Fe+T1UZnNvpFwI2pCD2oLLPIz576d9TS56Z6ZRnZgKrWuoDTB6Hr8iJRwi3BiJ3MYUihWQPhyYt6Opzbaw2zbsruSgt4C0O3AQE8UaDkdsWD3u3EOmvJdl5rdgj9gD/14I7Irqw7i38jUcgPDEwInrTtanUDYrPiAkZzmpZONkqo9PPba4PjtCBAXils0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWvzTqWumU8U0ZoNGbGXw8UOKyrTpNCwrAV4wESqi8Y=;
 b=pqD1diAEeeJB9if0C9YAt/jQcIurdOkCqxjysTHr8padOmvM+kMZMjk9UOMV4YoOFtMhtnHXVr1XsEJvgYDgFGM6ZGXbfvSt1qmvxJkOTm+Kj/aFejHodXVe5ns3hdzCuwrl2H0wfPaD2VhqP/qP7peYYJO/zY0MzkLiFEZTYljBjOsscsBNqItCbsw9Mf4xBynJZgbp1fv+ETgh1W2W/z95dvgQA207RXruBfTCMzkewx2Zvw1YpgiPXeJ00CNl3maMOcdVec4QMhG/KpRVXtRIYWTdJURq6Qax/R2xbJjJAi5F+13EhT9ENi4oa8UqoIMajS9ojgkN+5zWpsYq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWvzTqWumU8U0ZoNGbGXw8UOKyrTpNCwrAV4wESqi8Y=;
 b=T/IV7ZFH1Sxx6nqtksx8iZpaik4ec9La9VWSegqnoIsvFjw3f1oV/wPsdJpTuEVfNPSKKNpP1iCpOYf2dUHZQqcCfl0G6RP0Rpqt/ysH09ED+FFDKZrxyA7B3SiF3Q3ReRdCK8jeZPSN8TxDk3jt62aaJepDvA40edNdcJLzRPA=
Received: from OS9PR01MB17501.jpnprd01.prod.outlook.com (2603:1096:604:44b::5)
 by TY1PR01MB10723.jpnprd01.prod.outlook.com (2603:1096:400:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 11:39:30 +0000
Received: from OS9PR01MB17501.jpnprd01.prod.outlook.com
 ([fe80::25ba:1510:ed8b:158c]) by OS9PR01MB17501.jpnprd01.prod.outlook.com
 ([fe80::25ba:1510:ed8b:158c%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 11:39:30 +0000
From: Hung Tran <hung.tran.jy@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v2 2/2] ci: Add rzt2h-evk build target
Thread-Topic: [isar-cip-core][PATCH v2 2/2] ci: Add rzt2h-evk build target
Thread-Index: AQHdFFFDq47fjDoIDUun4d9GNalaNLZvoguAgABjnxA=
Date: Thu, 16 Jul 2026 11:39:30 +0000
Message-ID: 
 <OS9PR01MB17501C59DEA908E102CBB6735C6C72@OS9PR01MB17501.jpnprd01.prod.outlook.com>
References: <20260715115810.2379-1-hung.tran.jy@renesas.com>
 <20260715115810.2379-3-hung.tran.jy@renesas.com>
 <170f960f-3867-4520-9cda-d11f4ab8a109@siemens.com>
In-Reply-To: <170f960f-3867-4520-9cda-d11f4ab8a109@siemens.com>
Accept-Language: vi-VN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB17501:EE_|TY1PR01MB10723:EE_
x-ms-office365-filtering-correlation-id: 8aa7cccd-920e-423e-45af-08dee32ee665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: 
 uzQ037pPG5kZ91R6mwUOBO3nG5Y8rjj1VxxGJtQaeKWhNCIgeVGHX+QbLYlX1YriooOxV5K+XHxzlYNW++Bzr1ZoIpoo2fvzfreSBa5VI570soY/DPok9ypN9d3EX5JbNnjX4fthZOxJs1VlJ2wmQqUqj8cHVGUKfhCL/HmGW9QMbVjvybPIzkbp2JvF9TqQk6woqllVKbZd79zJDnZ5UoDwyOJozRgpPcBVst6og4URmBLaxTy1swJEZ8thNw2e1gnT9u2WZZSXCZzGD31xV/uFAKMA6aaUojEpgIs1CYthW3rTOXgCtiDYeeDQzg28pKOpGBkpB6VHpE/z294hYxAT+q4dzd12eY0EqWusUsJ8601pBFFSqlvC+0tPzMltlnkWvznUGIiqjZchOs5YAAvg7N03JQcEPaA4LaIn4TBWrkXGCJmXfd2XPeUKJSJ8EFwPsSTuhA7zODJED6Arr3gvYHv0iTOvjosB/SSONcmA8+FwmACVCyynXQuog52Pm7xYwFbpvO9ClIzEUZ7FUELMb8qK4UMmf+cyk+M8/NXYrIrOrn1zXw+dUnhwepBVt1WQHqXqd1nMjLseFpBarxRFpqe9EFkswZB8HWrjfjNoBzulkm2mlA2OiYbH5dPsiY/QmTgWkW7njAkoOssZheBTmSluONXgXLo5A8ibHadF1e57+Q18IcQxPPMoHALX4BQ4s8VWaO2CbsAHJw1Dzh7Evayv6MZ+TTpufN4rWKc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB17501.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dkpCcEthVmlUc2x1bVFseHNWbUkyV28rVWxqanRwQlphbzUwRUxreENOd2VM?=
 =?utf-8?B?SG5HRnJtblVKZ29CSWFveVJDS3FZMnhvaWh2SFBnRmd0bUtzTnhZL0k2Wkdw?=
 =?utf-8?B?MkJOUlhiY3N5M2dkYmc2azNETGQ3TmJvenRCRmVZeFRBWGJGZnJ1bmlvaTFG?=
 =?utf-8?B?WE1iSXNLcjlvT3N0aUFWS3lueWhXNnFGUVE1OTc3YjBYTlJBR2FHUWpENFBZ?=
 =?utf-8?B?RWtoUmZyRjJ4bFBoMld6NnF3dVVqa1JuT0JJVFNvb1NPUHdJbGluVkwwbVdp?=
 =?utf-8?B?bStNem91ak4rVlVqeTVNays3WEdVWmZ2SkZLYjd2NzBSeHljODkrazY0Vits?=
 =?utf-8?B?VWx0UFJwTkxNOElEYXg5OGlRckxzOWNpbWVBL1cwYmVGVEl2djRMRFdmakox?=
 =?utf-8?B?blRxZ3VvbkFCWTlIV1dCTFBiR0FwRXhoczgyM3d0Vk44ajkzMWVDTHFWUEhy?=
 =?utf-8?B?TTN1VDNxM05JSUFKOWg3S3lSdGZqODV2eXl2dEtxL3lCZUFkSTM0WFFpRy9y?=
 =?utf-8?B?bDBIKzQxdlpVcmVDRXhIeGY5TTYzSmxOeFJCZ01hVFc1QmJpZWx5L05zTDdO?=
 =?utf-8?B?TGhzVEQwUld6THgzWmNvQW05RlNRN2tQQmNiYStjUXdzTFoyb2N6Zmt3eDFW?=
 =?utf-8?B?M3VkMmxxZHdUQWhJSVh1bE9Hd085QVlRSTlmWXd6a3FWdDBzeC9oS2QzSGlT?=
 =?utf-8?B?M25tNGhvT0JtcXVBbkZnM1ZseGRCU2YwMW1PQU1WdGpnMk43MHFXcjhmUC9V?=
 =?utf-8?B?bkw2VjZlQndDcGZNbktYYW04TkcrMzl5R21TM0xSVExvcGxBNTcvUWdXaHdI?=
 =?utf-8?B?YWNwY0h3UHMrWjB1ZE11Q2VZQmtIZDlNN21xQWdEMUswbUEyb09CUzJRZ3dZ?=
 =?utf-8?B?NU5wSHZJK3JPekg3ZjduTGUvY2dQYkFIOEV5bXVYUEJsbkdWUzlPM3ZIVXpN?=
 =?utf-8?B?OUVGd01IUzdEaVJHcUNIOFBjaHZndGFjVlB4WDVkK3lKTEpPeGdFcituS2hJ?=
 =?utf-8?B?ZHVWWmVua01HYUFCWTA4Vzhpam9wRkw4SDd6bUpUd3VrbW5SUGFReGRZdEVB?=
 =?utf-8?B?TkoyUmtyNWNtdk53RDBUeTRIbGZoTXNpbHdRZ3J3WTBXSUhrK3NtYm5FaG5j?=
 =?utf-8?B?ZWt4WlcxaW56dGhSTGx5NkxHUEVwbmFKRVdydTBjYWxwRXAyY3BpRGNvYXlu?=
 =?utf-8?B?RXFpY29zOHNxRHpaNm8zQTBURHUwakNNK1pqaDdGYlBCaFVLTEdFeDFMRERn?=
 =?utf-8?B?dDRrNVUyOFQwN1JjOEkzMFlaOWh6eEZaKzEzRk5zVE45dDNvUjJWVkI2SUha?=
 =?utf-8?B?VXh6YVV2U2xsaE1idWNRUXhKK0xVQ0srWkttb0V4emtwN1lYdTd1RllxZS9q?=
 =?utf-8?B?Q2xmNmlyZHUvR0NmQjhkbHhqTnVYWWx4WDNqSXRTSFY4UUVxd25Uby9oR1pU?=
 =?utf-8?B?TVRmOUVwdEFqK2VJVFI1SVVXUmw5VDNpMUhYNnowVFMzMGFSRzFPblBYY01Y?=
 =?utf-8?B?NkNzQ25vcDJIdVpqcUJlVE9qZUJVSDc5Rm42b0gxYmxHcEdQU290OGNJSzE0?=
 =?utf-8?B?ZGtNcTRYa29XMFhlayswc2U1aGYwWWFNb3ptOURRU0VXSW1rZTJKNEZreEFs?=
 =?utf-8?B?NVZCQVNKUXl3M3EwVEVYOFVkM1k2aElKbVBHUTd5aE1uTm93UDgydngyWTc3?=
 =?utf-8?B?MVpZQlhwdmNjaXE2cFF0Y0NwRExTZzNoQmRIQ3RDaCtmZkpVUzM2V3h3TDky?=
 =?utf-8?B?UXl5akVFa2N3bEdxREFZRGFhNHBNT0dUbXljeHg4RFB4U2ZZQUw3NWhJSU15?=
 =?utf-8?B?NGV3b2lySG5MRDZLUHFFRlo5clNNMDRmRU85YmdrMUp3cHYyWFFsTjRTeFh3?=
 =?utf-8?B?KzdZNmNhQW01d1g2L21HbHRrNDlVTTVTOWV2T3h0OFAxaXM0VzVYWmRSRE9n?=
 =?utf-8?B?Q1YzZUlLVytHa2RqclRIeEpTQTRlQ0h4cTJvbFpHVGxiaVR2WHhsTGE1K3A2?=
 =?utf-8?B?ZmJXeVR6aVZvUTIxZXJKclVKN29WMkJqYXdWa1hKRk9CdHFGcG5KNjVaTmtU?=
 =?utf-8?B?bW1WS3EwaHBldEVrUGRpOElNaDlQd1k0RlZWbzFoVEVlRE15M3daRU5ZdndM?=
 =?utf-8?B?cEl5M0RVS2JPR0hhcm1IZ1ZLcDB4UmhlQkRpOXd0d2ZkT0M4NGZENlIzeXBC?=
 =?utf-8?B?M1ZzR2JHdWxab3dSM1pnTzEzem5EUTlNNkNsOVdFWE0rcklRWjVCbVFVOGJR?=
 =?utf-8?B?OG5LVmdhZXFpRHVFNy9xV2RnclhMaFpuV0tOUWl0SkNuaVErVE16bFlsclo5?=
 =?utf-8?B?WHl6a05rM0xpZys5b2JEL0c3RVZQNXJ2ZGt1THhBS0k2OVpDMFc2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB17501.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa7cccd-920e-423e-45af-08dee32ee665
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 11:39:30.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAQlFArW6lAf9+vEv6RDnqcSeIJNVJToS481on/4iMDO7xtO35XZYLIwdJJSv4Zxzr7cERSU4AVXSJF4rDjWzevBR3kmR7wbvr5IqjUSzOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10723
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 11:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23620

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDE2LCAy
MDI2IDEyOjM5IFBNDQo+IFRvOiBIdW5nIFRyYW4gPGh1bmcudHJhbi5qeUByZW5lc2FzLmNvbT47
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbaXNhci1jaXAt
Y29yZV1bUEFUQ0ggdjIgMi8yXSBjaTogQWRkIHJ6dDJoLWV2ayBidWlsZCB0YXJnZXQNCj4gDQo+
IE9uIDE1LjA3LjI2IDEzOjU4LCBIdW5nIFRyYW4gd3JvdGU6DQo+ID4gU2lnbmVkLW9mZi1ieTog
SHVuZyBUcmFuIDxodW5nLnRyYW4uanlAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIC5naXRs
YWItY2kueW1sIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvLmdpdGxhYi1jaS55bWwgYi8uZ2l0bGFiLWNpLnltbCBpbmRleCA1YTIwYWQ2Li5mMzMxODRi
DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvLmdpdGxhYi1jaS55bWwNCj4gPiArKysgYi8uZ2l0bGFi
LWNpLnltbA0KPiA+IEBAIC0xMjIsNiArMTIyLDEzIEBAIGJ1aWxkOmhpaG9wZS1yemcybS1iYXNl
Og0KPiA+ICAgICAgdGFyZ2V0OiBoaWhvcGUtcnpnMm0NCj4gPiAgICAgIGR0YjogcjhhNzc0YTEt
aGlob3BlLXJ6ZzJtLWV4LmR0Yg0KPiA+DQo+ID4gK2J1aWxkOnJ6dDJoLWV2ay1iYXNlOg0KPiA+
ICsgIGV4dGVuZHM6DQo+ID4gKyAgICAtIC5idWlsZF9iYXNlDQo+ID4gKyAgdmFyaWFibGVzOg0K
PiA+ICsgICAgdGFyZ2V0OiByenQyaC1ldmsNCj4gPiArICAgIGR0YjogcjlhMDlnMDc3bTQ0LXJ6
dDJoLWV2ay5kdGINCj4gPiArDQo+ID4gIGJ1aWxkOnFlbXUtYW1kNjQtYmFzZToNCj4gPiAgICBl
eHRlbmRzOg0KPiA+ICAgICAgLSAuYnVpbGRfYmFzZQ0KPiA+IEBAIC0xOTYsNiArMjAzLDE0IEBA
IGJ1aWxkOmhpaG9wZS1yemcybS10ZXN0Og0KPiA+ICAgICAgZXh0ZW5zaW9uOiB0ZXN0DQo+ID4g
ICAgICBkdGI6IHI4YTc3NGExLWhpaG9wZS1yemcybS1leC5kdGINCj4gPg0KPiA+ICtidWlsZDpy
enQyaC1ldmstdGVzdDoNCj4gPiArICBleHRlbmRzOg0KPiA+ICsgICAgLSAuYnVpbGRfYmFzZQ0K
PiA+ICsgIHZhcmlhYmxlczoNCj4gPiArICAgIHRhcmdldDogcnp0MmgtZXZrDQo+ID4gKyAgICBl
eHRlbnNpb246IHRlc3QNCj4gPiArICAgIGR0YjogcjlhMDlnMDc3bTQ0LXJ6dDJoLWV2ay5kdGIN
Cj4gPiArDQo+ID4gIGJ1aWxkOnFlbXUtYW1kNjQtdGVzdC1ub2tlcm5lbDoNCj4gPiAgICBleHRl
bmRzOg0KPiA+ICAgICAgLSAuYnVpbGRfYmFzZQ0KPiA+IEBAIC0yOTIsNiArMzA3LDE0IEBAIGJ1
aWxkOmhpaG9wZS1yemcybS1ib29rd29ybToNCj4gPiAgICAgIGR0YjogcjhhNzc0YTEtaGlob3Bl
LXJ6ZzJtLWV4LmR0Yg0KPiA+ICAgICAgcmVsZWFzZTogYm9va3dvcm0NCj4gPg0KPiA+ICtidWls
ZDpyenQyaC1ldmstYm9va3dvcm06DQo+ID4gKyAgZXh0ZW5kczoNCj4gPiArICAgIC0gLmJ1aWxk
X2Jhc2UNCj4gPiArICB2YXJpYWJsZXM6DQo+ID4gKyAgICB0YXJnZXQ6IHJ6dDJoLWV2aw0KPiA+
ICsgICAgZHRiOiByOWEwOWcwNzdtNDQtcnp0MmgtZXZrLmR0Yg0KPiA+ICsgICAgcmVsZWFzZTog
Ym9va3dvcm0NCj4gPiArDQo+ID4gICMgYnVsbHNleWUgaW1hZ2VzDQo+ID4gIGJ1aWxkOml3ZzIw
bS1idWxsc2V5ZToNCj4gPiAgICBleHRlbmRzOg0KPiA+IEBAIC0zMDksNiArMzMyLDE0IEBAIGJ1
aWxkOmhpaG9wZS1yemcybS1idWxsc2V5ZToNCj4gPiAgICAgIGR0YjogcjhhNzc0YTEtaGlob3Bl
LXJ6ZzJtLWV4LmR0Yg0KPiA+ICAgICAgcmVsZWFzZTogYnVsbHNleWUNCj4gPg0KPiA+ICtidWls
ZDpyenQyaC1ldmstYnVsbHNleWU6DQo+ID4gKyAgZXh0ZW5kczoNCj4gPiArICAgIC0gLmJ1aWxk
X2Jhc2UNCj4gPiArICB2YXJpYWJsZXM6DQo+ID4gKyAgICB0YXJnZXQ6IHJ6dDJoLWV2aw0KPiA+
ICsgICAgZHRiOiByOWEwOWcwNzdtNDQtcnp0MmgtZXZrLmR0Yg0KPiA+ICsgICAgcmVsZWFzZTog
YnVsbHNleWUNCj4gPiArDQo+ID4gIGJ1aWxkOnFlbXUtYW1kNjQtc2VjdXJlLWJvb3QtYnVsbHNl
eWU6DQo+ID4gICAgZXh0ZW5kczoNCj4gPiAgICAgIC0gLmJ1aWxkX2Jhc2UNCj4gPiBAQCAtMzM3
LDYgKzM2OCwxNCBAQCBidWlsZDpoaWhvcGUtcnpnMm0tYnVzdGVyOg0KPiA+ICAgICAgZHRiOiBy
OGE3NzRhMS1oaWhvcGUtcnpnMm0tZXguZHRiDQo+ID4gICAgICByZWxlYXNlOiBidXN0ZXINCj4g
Pg0KPiA+ICtidWlsZDpyenQyaC1ldmstYnVzdGVyOg0KPiA+ICsgIGV4dGVuZHM6DQo+ID4gKyAg
ICAtIC5idWlsZF9iYXNlDQo+ID4gKyAgdmFyaWFibGVzOg0KPiA+ICsgICAgdGFyZ2V0OiByenQy
aC1ldmsNCj4gPiArICAgIGR0YjogcjlhMDlnMDc3bTQ0LXJ6dDJoLWV2ay5kdGINCj4gPiArICAg
IHJlbGVhc2U6IGJ1c3Rlcg0KPiA+ICsNCj4gPiAgYnVpbGQ6cWVtdS1hbWQ2NC1zZWN1cmUtYm9v
dC1idXN0ZXI6DQo+ID4gICAgZXh0ZW5kczoNCj4gPiAgICAgIC0gLmJ1aWxkX2Jhc2UNCj4gDQo+
IFRoZSBib2FyZCdzIGtlcm5lbCBzdXBwb3J0IGlzIGxpbWl0ZWQgdG8gNi4xMi4gV2hpbGUgaXQg
Z2VuZXJhbGx5IHdvcmtzIHRvDQo+IHVzZSBuZXdlciBrZXJuZWxzIHdpdGggb2xkZXIgRGViaWFu
IGltYWdlcywgSSBkb24ndCBzZWUgdGhlIG5lZWQgdG8gY292ZXINCj4gdGhhdCBpbiBDSSBoZXJl
LiBTbywgbGltaXQgdG8gYSB0cml4aWUgYnVpbGQsIG9yIGRvIHlvdSBoYXZlIG90aGVyIHJlYXNv
bnMgdG8NCj4gc3ByZWFkIHRoaXMgb3V0Pw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4N
CllvdSBhcmUgcmlnaHQsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY292ZXIgdGhhdCBtYW55IGNvbWJp
bmF0aW9ucyBpbiBDSSwgd2hpbGUga2VybmVsIHZlcnNpb24gaXMgbGltaXRlZC4NCkkgd2lsbCBy
ZXNlbmQgdG8gdXBkYXRlIHRoaXMuDQoNClJlZ2FyZHMsDQpIdW5nIFRyYW4uDQoNCj4gDQo+IEph
bg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KPiBM
aW51eCBFeHBlcnQgQ2VudGVyDQo=

