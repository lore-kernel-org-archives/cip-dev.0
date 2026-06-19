Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09307CD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 08:43:04 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38386.1781858577745415584
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 01:42:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vIZVK/fP;
 spf=pass (domain: siemens.com, ip: 52.101.70.70, mailfrom: benedikt.niedermayr@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0DT9dVCz19lsESJVjaopz9z9Dl1sWzkh+DTbw/bRqafmmyKN+0a+pvm3PIOIxMQhrgagyvSni3qPgNGD6XnAfMqGIl7TjERIS1p3jCxeuFcDDbzaIELrohY2eOZQftCtxusRGWsiSCBiaN9TFq3LY+oqccYNagzsVvKwiUaoNc7jCgX73MjaxWrfLnDPYPORQh7eyjtF4YUDfSPqzxo624LI1wJLvoey+2jQ+UreUqs7nkEvJyVzC0SjTgK/TQMEAXf1+q8l3mNTj+gkYSqKsY1eHGl/hNS5ycmlZDUsW8WhAVL3C2J7awWFUypPMBkI+PFctB8jEEIP7Bmxi23CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAArciSJnD7Gp7KJD//oN6ZVewm4Olr6QZvCOp2RZJw=;
 b=DUmEjQGokSR2nv5T3ris6dhQj2GQxEiTqBfYUMn98wE3Q0XOIgQhdXF7qSCNMDTF9CwEf1GWwW+1bXsI19Lm3CTKxIKMPQdmSMTVmwU95xTFpcK6MG3cZFo20yZ4hgg7zl82gVImMYCumqXW/AGnRNl25Pp3Dy6cn84/s5SFC7rD+ZrYjsJdmIcFzsixgdcUf/5pJlNkZ/r8U2xe5V0DJcrXuNCkt60LRuXRp8J8Z5cJgyjjhpfomPZo8ncWkjGZp1xQ2oQcULTM94+knxaIzsfHMnTmQjuTvmLx08PqYKj4bwAOfH/9sxLRarD6yUTxcW4Y+zl4A5a6SJlS3M33RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAArciSJnD7Gp7KJD//oN6ZVewm4Olr6QZvCOp2RZJw=;
 b=vIZVK/fPB71fSncnokaSGgMvLhLNuJk3SPGB2xpcl1bpDMYMHSbeTTohFk7HeFMP6M+iQgma+usTm4LwsTqbL4bO9Tzp/PWTGlF8zVf2+JGxbuo7A8AaTcScrxSA5CQGsBjCcfG9iXLyiMQQgr/q6LAUGQM1mskVIY4+FDTJNJM1xYzbCZAPvxL527dJHG3CRFu6IaeOLH5OuYyQ/0IGFEn8WEpqnyeKWeUyHkcmMNTzDFJ5G1rMqVeaL+kVNvM4gCxFF0tPdwyjZsO2zUhbGOH6SZFwv7KYAQJTddj7/UsUGYlqHbl2PQgY2U+DR1EpHSapp9JEh8tiUjBxqostCw==
Received: from DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::7)
 by DU0PR10MB5945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 08:42:53 +0000
Received: from DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e295:f11e:ecf3:deff]) by DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e295:f11e:ecf3:deff%4]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 08:42:53 +0000
From: "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: fix compilation
Thread-Topic: [cip-dev][isar-cip-core][PATCH] swupdate: fix compilation
Thread-Index: AQHc/8cMeSocr68NOkST8NJ2xqHMC7ZFj66A
Date: Fri, 19 Jun 2026 08:42:53 +0000
Message-ID: <a3f2cd46-2a1f-4fb5-9190-56ee4140c89a@siemens.com>
References: <18BA6EB3D38B258B.777602@lists.cip-project.org>
In-Reply-To: <18BA6EB3D38B258B.777602@lists.cip-project.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR10MB7645:EE_|DU0PR10MB5945:EE_
x-ms-office365-filtering-correlation-id: 28ece1bf-1a44-4c0c-5d0a-08decddec0b3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|4022899009|376014|55112099003|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 YURoCHS9MhPngl4pfxPu9FyCcf3uCv5pvyToH1WRFlS+O/c6uGTTkvOdFcMZT5bAP9799jLj0B/dmW7ZJc05fVsUxiKi/X9fmxK4VV8HUqFnPj6vMDprlHcZ2dTRBtHm1OzWANo4DfrUXGhguhKti+94DHxP1bUBTz4st6cAnRFHRWcPVDvRNmMd1h4KE24PcTV8aDDMc/AmlphBfTIixomLaCszg7ATozetNL3dXue7mVrqMFz9PHKfKFARj1/kdbRFLhekwglVFK3Jf4CvNFoaz5xa7cATM9IIddumt3e9yW/idDCESKU78YE3hoYZ107Ye5PqzLuiY9G91NLPxWPTbGXz2xeOksfwXyFKMmy2nbVEetLbK4BjVUACuAE2yvGAm2dBrOqxlIffKnMGUy0IvseCKJKFLAX54dfpaC5FCem0Hqienvm3siUlQ9Bwy9sh43wvQp9yMjozYh7Z+G301M5F2oL+0JGHtR5MQba6grjdD1eQ2ax/Vi9+dHm5l4okv+H5EDNmfrBxsUuaqTWeKB9dIjoCMrz5YASRIAs7PkK9G9fqy/X4O2B6seh+YAmNFXItM3XUfmjZP/ndi4NqFOQBxq0xvH03l4bjbg/M6/Hv3Bnfc71/u239QpY2pPNfi+LP9NDd0AzQy++lL45Qqn76KqcZRciIgBLXqC0kWNSWkUPH3tDK2QfDQixB6884GwtyUMhvnvM98T3dPHaqflQwThWkXzgDxlXhj74=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(4022899009)(376014)(55112099003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VElPSE5wWEgvNnBkLzFtL3dBVTM3TUhaOFI3bjVmYm5pVjArSnNjOCtKWEdu?=
 =?utf-8?B?S3BDZHRhTFZqbDdiV05JbHZQYU5JaGJINzJyeUo2T09xdHZHODlWb1NheEI2?=
 =?utf-8?B?MUlIbVZoeTFQM3RlQUw2N2lQZWtoVmlvbHlxWEJhSVdSM0UrLzNTdTdGZHZp?=
 =?utf-8?B?NC9Ya2tCMUFwR3lyU0Jzczk3d3VOSG9ra1FYOXRTTnBBR3ZZR1BJUFdQaUI2?=
 =?utf-8?B?N0RPRmtId3BhVlA4OXJVVVdDR1M0b3pXbWxiSWFiUUt3MEJiQnBqZHRic2hu?=
 =?utf-8?B?LzVpZzFQSllHNTJiVWdoT29lWEd2T2xwdUp5MjJpSWlUbERuWm1RZExFTGoy?=
 =?utf-8?B?VlVHd2RiL1Q0cjkwNnpUZVZxR3hkQmE4RUMxSlRpSERKeHN0WjB1amw2WU5s?=
 =?utf-8?B?RU9sak1xL01CVUpjN2o0bDVoUUNWakNiaU93cG9oaFN6QzJLU1hyZUo3MG8r?=
 =?utf-8?B?dEZ4VldWNWRvL1FCSGlPSWw0VGlQSDcycnlOd2hUOWJPdzlNVmpvbkp5ckJG?=
 =?utf-8?B?K0Noc01XK2lpTHdpb3kzTFJKc3Vud1pzbWF1dDByQ29RdnNtWlhEOXFnbllD?=
 =?utf-8?B?MGNiRG1Yc0VuLzZXdlREaGZPV3Z6MjdSR1B2ZE5lbVplMFI1ekhyNUVrd2VI?=
 =?utf-8?B?WlU4RXk5bHBwbHBkTTJIaDdaeVEzUWZOemZiamhCaWhvTXFTamZpclBqVEdp?=
 =?utf-8?B?cjdodVc1M283TllPNXd1VlpmUy8xWHF4bW9vQW41VFFHdWlrMWJPSVczSmxx?=
 =?utf-8?B?dmY0bktXTXo1YWZsU04zc2JXK1RXc1FTREczakVuTHVielptZFc2bmMvT0FY?=
 =?utf-8?B?aFlTa3FUU01QY2lReDdoSGJSZUhmRmR4ZkRpTE5kRlo4TnpwMy9TTDI3Y2pn?=
 =?utf-8?B?cnBWUXdqUmxKaTIxYkgzYXQ1N2E4TURJcUdFejZadjEySnA4R1JtTGwyZ01v?=
 =?utf-8?B?bFNNTGtQZUhVWWtJZkhhVDl0K241WnVYTTFscUN6RWNxZlJzeFdLem9LRGxG?=
 =?utf-8?B?TEVYQjBZb2tnTjhnWWYyN1UxNGE3WkdSQ0R0ckhvR25DM3N5ZU1LOG9neHVP?=
 =?utf-8?B?VVV2VTh2dnRzeml0ZlNwRFdFd2phVVNCcGtrTEdSSjdwb2NNVERpK0dpa0pI?=
 =?utf-8?B?ejlPd2IzNTVIQWZVSGpwK0laYlJGcERYakppUWpFOFV6THBlVXhsZ1VxZE5E?=
 =?utf-8?B?WDN4NUFmREdtK1ZKbE5nZFd4WU9xajNEbGRveldpeXRobTk4dnUxbUxpckJE?=
 =?utf-8?B?V1dqbFAxYW4wbU0vSE54elhZZ25vM0NXMSswZGhEYjFhenBHYzgrUE1iTko4?=
 =?utf-8?B?ajdrKy9kT2VBZ2srNG04dk1lTjRhM3BCU3I1YXBPTEIwbzU1SmxLbXRnK3Vo?=
 =?utf-8?B?L2xsWS9mTVRhRTQyQnNqakdGNmtOQm90YkMrV2xIVDZBMXVDQTFyUUJQWHgv?=
 =?utf-8?B?dm1CdzhUTy9ZYzkyb29jRVViQ0tQR0RLMmhSTUx0TmFPb2hhbTNmRFE2UmFu?=
 =?utf-8?B?eWJmRCswSTJyUGRoeEM5ejJuR3AxMHptNTRtYWpHWDEzNkJwbWZFY25LbGdp?=
 =?utf-8?B?NlNjOEhxN3ovZXc3MjlkeFluRmdaVi9ZSUlPUkVGUkFFMHQ5ZnhZTmJHZzdV?=
 =?utf-8?B?blYxTUJWOWNPOXgyczRIVU9YM3lZYS9ydUdGQkZWRTRzK1ArdGJVdUZXYXlN?=
 =?utf-8?B?VlNPdnJaMjlIaFIrY2txcTZuZnRLaUNZdGtOM3plOWV4OG55dTgwcXpwL0VW?=
 =?utf-8?B?VmVJTGRDMC9tMnh6RzJBNjlLWS9Qc1djdERZM0U1UlJ4OUU0NDBzb1ZYdCt4?=
 =?utf-8?B?U25JN29ZZVZmOEhJU2ZSa2JCcml1NDltcmlkeis0NHNKOGdJU09UK2VyTm5N?=
 =?utf-8?B?c05WV3RHZkVYTjlXTFpNVmh5QUNySkVmOWxUV2pUanVyQXMxbk5qRW5KdUth?=
 =?utf-8?B?Vis2bDRSRXUrMjVvQUNhSDNRV2xka0V5Smw4dXZrLzMxbE9HdEpBWmY4UEdV?=
 =?utf-8?B?ZDd0amozSS92cjdiMzZqQWlPL0h2S1QzY09FMEgwZkFXZ0htcC82ekZJRnVY?=
 =?utf-8?B?TmdIWU5CVCtHeDBGUHFmVmV4TXAwUlBXTU5hUFBROTFBVG5PZzdyRjJidUVs?=
 =?utf-8?B?VDBPa1VNTjlwbThGOUdRUFBYbTF4QU5LQTFmMy90OTE1UDNZVWl1Y1VTdkVG?=
 =?utf-8?B?azBKKy9yT2ViQmJQZ2Q4ZHFkS0hjWlcrdTV4WjVnenRGVkdiRkluZlBrMm1n?=
 =?utf-8?B?WGtMdjEraEs5UUlZUzUrL2JkSE0yU2xKdU92bFByMnhLNStUWDN1WlNMdjkv?=
 =?utf-8?B?Q0ZqRHU2Y1FBdWF5dTN3bzVFSFVJeFFrMzRwMFhDWjRrREt3T20xdW5IL3hE?=
 =?utf-8?Q?ZAwNvP0MZK/lt5/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <271255886CCE544E8985BBB3DD1E721A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ece1bf-1a44-4c0c-5d0a-08decddec0b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 08:42:53.1977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayheqRjqY4Ij3hi8r25Zp9Vtjw1bqXX8qHGzzhseXXpCFo4FwLmBczEgYDayA8W/W9sGF/1ho28atbddww9fAjOFZAbxT5+/NQDav29RooY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5945
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 08:43:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23229

T24gNi8xOS8yNiAxMDozOCwgTmllZGVybWF5ciwgQkVORURJS1QgdmlhIGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZyB3cm90ZToNCj4gV2hlbiBjb21waWxpbmcgc3d1cGRhdGUgdGhlICJjcm9zcyIgcHJv
ZmlsZSBzaG91bGQgb25seSBiZSBhZGRlZCBpZg0KPiBCVUlMRF9BUkNIICE9IFBBQ0tBR0VfQVJD
SCB3aGljaCBpcyBhbHJlYWR5IGJlIGRvbmUgaW4NCj4gaXNhcl9kZWJfYnVpbGRfcHJvZmlsZXMo
KSBpbiB0aGUgZHBrZy1iYXNlIGNsYXNzLg0KPiANCj4gSWYgdGhlICJjcm9zcyIgcHJvZmlsZSBp
cyBhZGRlZCB0aG91Z2gsIHRoaXMgYnJlYWtzIHNidWlsZCBidWlsZHMsIHNpbmNlDQo+IGl0IHdp
bGwgYWRkIHRoZSBob3N0IGFyY2hpdGVjdHVyZSB0byB0aGUgYmFyYmFyaWFuIGFyY2hpdGVjdHVy
ZSBhbmQgdGh1cw0KPiB3b24ndCBiZSBhYmxlIHRvIGluc3RhbGwgcGFja2FnZXMgaW4gdGhlIGhv
c3QgYXJjaGl0ZWN0dXJlLg0KPiANCj4gQWN0dWFsbHkgdGhpcyBjb3VsZCBhbHNvIGJlIGZpeGVk
IGluIHNidWlsZCBpdHNlbGYgYXMgd2VsbCwgYnV0IHNldHRpbmcgdGhlDQo+ICJjcm9zcyIgcHJv
ZmlsZSBzaG91bGQgbmV2ZXJ0aGVsZXNzIG9ubHkgYmUgZG9uZSBpZiByZWFsbHkgcmVxdWlyZWQu
DQo+IA0KPiBUaGlzIGlzIHRoZSBlcnJvciB0aGF0IGlzIGZpeGVkIHdpdGggdGhpcyBjb21taXQ6
DQo+IA0KPiB8IFJlYWRpbmcgcGFja2FnZSBsaXN0cy4uLg0KPiB8IEU6IFRoZSBwYWNrYWdlIGNh
Y2hlIHdhcyBidWlsdCBmb3IgZGlmZmVyZW50IGFyY2hpdGVjdHVyZXM6IGFtZDY0IHZzDQo+IHwg
VzogWW91IG1heSB3YW50IHRvIHJ1biBhcHQtZ2V0IHVwZGF0ZSB0byBjb3JyZWN0IHRoZXNlIHBy
b2JsZW1zDQo+IHwgRTogVGhlIHBhY2thZ2UgY2FjaGUgZmlsZSBpcyBjb3JydXB0ZWQNCj4gfCBF
OiBhcHQtZ2V0IGRpc3QtdXBncmFkZSBmYWlsZWQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbmVk
aWt0IE5pZWRlcm1heXIgPGJlbmVkaWt0Lm5pZWRlcm1heXJAc2llbWVucy5jb20+DQo+IC0tLQ0K
PiAgIHJlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMgICAgICAgIHwgMiArLQ0KPiAg
IHJlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIzLjEyLmJiIHwgMyArKysNCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMgYi9yZWNpcGVzLWNv
cmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jDQo+IGluZGV4IDQwMzhlN2UzODQwMi4uYjM2N2E5NmM4
NDdhIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jDQo+
ICsrKyBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMNCj4gQEAgLTM3LDcgKzM3
LDcgQEAgREVQRU5EUyArPSAiJHtAYmIudXRpbHMuY29udGFpbnMoJ0RFQl9CVUlMRF9QUk9GSUxF
UycsICdtdGQnLCAnbXRkLXV0aWxzJywgJycsIGQNCj4gICBTV1VfU0lHTkVEID89ICIxIg0KPiAg
IERFQl9CVUlMRF9QUk9GSUxFUyArPSAiJHtAJ3BrZy5zd3VwZGF0ZS5ub3NpZ25pbmcnIGlmIG5v
dCBiYi51dGlscy50b19ib29sZWFuKGQuZ2V0VmFyKCdTV1VfU0lHTkVEJykpIGVsc2UgJyd9Ig0K
PiANCj4gLSMgZGVhY3RpdmF0ZSB0ZXN0aW5nDQo+ICsjIGRlYWN0aXZhdGUgdGVzdGluZyBmb3Ig
YXJtIGJhc2VkIGJ1aWxkcw0KPiAgIERFQl9CVUlMRF9QUk9GSUxFUyArPSAibm9jaGVjayINCj4g
DQo+ICAgcHl0aG9uIGRvX2NoZWNrX2Jvb3Rsb2FkZXIgKCkgew0KPiBkaWZmIC0tZ2l0IGEvcmVj
aXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMuMTIuYmIgYi9yZWNpcGVzLWNvcmUvc3d1
cGRhdGUvc3d1cGRhdGVfMjAyMy4xMi5iYg0KPiBpbmRleCA4OTc4NWI2NmJmMjkuLmExMmQyMmE5
OWJiNCAxMDA2NDQNCj4gLS0tIGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMu
MTIuYmINCj4gKysrIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMuMTIuYmIN
Cj4gQEAgLTM5LDYgKzM5LDkgQEAgREVCX0JVSUxEX1BST0ZJTEVTICs9ICJwa2cuc3d1cGRhdGUu
c3VyaWNhdHRhd2Z4Ig0KPiAgICMgd2l0aCBjcm9zcyBjb21waWxlIHdlIGhhdmUgYSB1bnNhdC1k
ZXBlbmRlbmN5IHRvIGRoLW5vZGVqcyBvbiBhcm0vYXJtNjQNCj4gICBJU0FSX0NST1NTX0NPTVBJ
TEU6YnVsbHNleWUgPSAiMCINCj4gDQo+ICsjIGRlYWN0aXZhdGUgdGVzdGluZyBmb3IgYXJtIGJh
c2VkIGJ1aWxkcw0KPiArREVCX0JVSUxEX1BST0ZJTEVTICs9ICJub2NoZWNrIg0KPiArDQo+ICAg
IyB1c2UgYmFja3BvcnQgYnVpbGQgcHJvZmlsZSBmb3IgYnVsbHNleWUNCj4gICBERUJfQlVJTERf
UFJPRklMRVMgKz0gInBrZy5zd3VwZGF0ZS5icG8iDQo+IA0KPiAtLQ0KPiAyLjQzLjANCj4gDQo+
IA0KPiANCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFs
bCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMjMy
MjgpOiBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC1kZXYvbWVzc2FnZS8yMzIy
OA0KPiBNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL210LzEx
OTg4MDU1OS83MDc5OTI3DQo+IEdyb3VwIE93bmVyOiBjaXAtZGV2K293bmVyQGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KPiBVbnN1YnNjcmliZTogaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcv
Zy9jaXAtZGV2L3Vuc3ViIFtiZW5lZGlrdC5uaWVkZXJtYXlyQHNpZW1lbnMuY29tXQ0KPiAtPS09
LT0tPS09LT0tPS09LT0tPS09LQ0KPiANCg0KQWgsIGZvcmdvdCB0byByZWJhc2UgYWdhaW5zdCBj
dXJyZW50IG5leHQuDQp2MiB3aWxsIGZvbGxvdw0KDQpCZW5lZGlrdA0K

