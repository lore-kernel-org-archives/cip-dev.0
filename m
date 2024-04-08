Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584DECD1296
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 14:25:22 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.105])
 by mx.groups.io with SMTP id smtpd.web11.108168.1712586258584946135
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 07:24:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HIBsUzei;
 spf=pass (domain: siemens.com, ip: 40.107.14.105, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2P6gInlgUZXTnxbJvHWYPfqENTbq3JfofDRVkBWjH1vY0yUIMbr/wPHI/0aDL40WFenJv2y+eNdEhDhq6hMD0Zu2NVIUptwmvKpkYIceEUoj+/wkX+4hhvtWuy0pxTbrUus4SQHpc4FFLnmy/uGiv/F1wY9RdRk20VLf5krmPbn7NSP6lZ7Vq376M6CnrathGZUL16yuqKq19gYwVQODaDSYwwkZ0y9ozXiBpnXmgKZt34/5kBsHLRFmG++w9AQoHkibwmN/rMdCA8k+Pzz8wr3WX9J9YjuGiQGy2xomMHZ9zVblTJjE5sHR/l1eDHiI+4+Kde27qqV07X/f9TXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4LQpfoqmBINWhjN79mQcCEzOz4G+1w+1haa+KuwgZY=;
 b=W24VLaDE2mTV9YfuXCreF/TPR3cimnsBnXWGAhQis1F3+aVc3yFPSuAEkCpjuPsCUPZFa4Pu9uUsLhdBf6lgN827SqSGZsEJ7ssSta6pXiDdg57ukkTV+Wa6UozLnfJHn0RLyGj8NPzK0iXza7a+rSf0b/WdIkqBo+6jyCap5Xwz4YC5bQFVP/82UfqV231CXEF/cvPfa3SEzp+n24fXkL5kHDD8x6KaebLtu9Vd6Gk3EKUixkZmDRK1MiWhHUcB2S+GYyYa/nK3IzmVK87Av+Edu6KHBiXMxDNiRrY9orfqZgEJGJUClTG78yYWNckkg2iw/ulguWO1r3Hyf7MA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4LQpfoqmBINWhjN79mQcCEzOz4G+1w+1haa+KuwgZY=;
 b=HIBsUzeigobuQjBubT3X2hQDYf1r1fYiRzQsniVYkuVx26Zt/v+e+4+jOYn8JaSO0D/fxEoA5svWOl/l8Hw4/UvN9G1DqrQ5BgjrYgY0t2jCIBRgIF8Qs9qfp+GCnCEKD2yh3mNEfZlujyAXRsy8AJLK1UwvlV87eQ/XJbsysScQqj2+3SwmCfC4Hn7gAp3f/vBVOyPaLw7oLuVSJ/jPO3HzAzoPu4BmkrHUIrIcZ9OkIdkGMw7hWlrmWLml1pWWLfTYu36t4P0GEQUr+IvICO7pfw2c7/Ce9JYoxUE7JzYQoiEBUmvC49PzCwGcbdBb3jJkDbqMoEN3/zZYMn0fWA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PAWPR10MB7272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 14:24:15 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 14:24:14 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] layer.conf: Move SOURCE_EPOCH to kas-cip.yml
Thread-Topic: [cip-dev][isar-cip-core][PATCH] layer.conf: Move SOURCE_EPOCH to
 kas-cip.yml
Thread-Index: AQHaibKoji8trtxrWESNC/HBa0BGh7FebXaA
Date: Mon, 8 Apr 2024 14:24:14 +0000
Message-ID: <12141908dbe3e6ce7d39008923646b5f7e310a31.camel@siemens.com>
References: <20240408124535.300693-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240408124535.300693-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PAWPR10MB7272:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MW0vdmb5DqnToP1KHRmmE22bASG1y97ZhQWd2nq68GhlPabBIS81xQCOHSOiSaZSJnR/uVltn3LjCyBW/KhCKhnLfx51RApx4ZwwUPBShM48l3NhkhA0EiD33jO0zKFxmdnM9Eo+lmizi0vHjtpA7D7yBMLVBhPKzYAnsAsDAvfgm/JNWrwOIQOZ5Dv8as8zUfU+9pv3O1avccznWEXtuWNkNloYLHeHrOOV4gLhOXdTakxquSWSVFDJrxlvRzAUChg/A0YHSpZ1kOaS1qraKtAHT7UBwKM9U5VDQ6Ar2UmMbr3YtBhSlZ1CUq+d+CNi4UCiOkzKDVhlTC7GMIm26Q9ysT0m77uXe95KeKK5iXJ/cCIimR6ok0H3v9HOkatEUijcTXZ7/jPJ3YRWM9dMTGXhVbvEBe/Ft/IV1yrDk7WTTgqDimYiaPaSpWykKTdmTgByoSFa6U+wWZJxMblY+I/BUmOXrj28EWXfS52BDUiPK6lIxmwsQ/TOFFvVtJcl3ChyfyA23s0QnNIWBF15+oZgBOGwiN8R82OEchPnyTx0T0p+v2a38iNVXXlTpnRxKArDxnZFhyFnrz7WdYB1p1ijyzBzvcqxm0ZjNFOLP9vBckVVaj4BBbf4pSEyQ4F/2agu6w3Dl4bC3Dt3dYRxbU/qPEYv9WFc2myKNfyyrrI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M2VTdXdzV29YUnphZFM0RlR6cVkxTDBTYWFvZ00reWgvUVJvcTlCZ3VMc2Ja?=
 =?utf-8?B?bG5TaXdLcHdEYWpPQkpHSVJseXU1Um5mVkNtSWMvRDd0ZG56cUFkUStmZE1Y?=
 =?utf-8?B?VE1aRG52V3hFTVNoY1BEWi9mUCtKMEw5bzdnQVI0Q3VITFlGVFlOa21xOXlL?=
 =?utf-8?B?dEk4L2xSSDFUb0FOTkJQZzhRL1NoelZUbmFUalh5dEViand1aEU4TkhJbzd3?=
 =?utf-8?B?aDhSQUlWRXJ2QWZIVjZkaDJrUC9jTEtDR2VoSkY5Mkp3QU1naE94MjRPL1Q2?=
 =?utf-8?B?c1l3VTZWSWlkUHp3andua3FyKzFBWGIxR1REeXhESksvSnpDTXl0TVVLU0xQ?=
 =?utf-8?B?ZGVuUjhsM0lLZWdZcyttN2Y2NVZMajBuL21keVZzN2RILzlRaHAwWHpzb0gy?=
 =?utf-8?B?bnFBbmF4bXFaNUhacm9rb1NNeFlraFhBN2YrMEJ0VitRZUlad0V4QThha2w1?=
 =?utf-8?B?V1R3dSs5ZVJUczBrN2xjUTh6aVJtR0hlK0RVZkxQY0pMY3kxcThkT3ZDT2dU?=
 =?utf-8?B?OGtxaE9aVlc5NmMvYXBGR2xReXI4VktURDRyRHdTZzZINzVydzUyRlVwOUpx?=
 =?utf-8?B?LzZvL2NLRjNpSUI0UVhhM1VNUC9pOGppOEdwMEI2ZVN5ODVMdTEzUlMyRHFm?=
 =?utf-8?B?cHF1MHhWeW13RTVFMkt1eDcwak8yd0pzYVJIR25hd1ZranNrUURSaHhEQld6?=
 =?utf-8?B?MldsUVpZNDZLTFpLVDlDNkQ0OXFWWjlTdGlXVE9YSko4MlNlM2NXU09lSVh2?=
 =?utf-8?B?ZVA0RHdYQit4N2l6YUdsbEVEck1CWVNaTXIzODIrUHNjQjFSOStqODRML3E1?=
 =?utf-8?B?d09oWUd2ZGNPajRJd01uUmpUWmVEMFJrZzhrb211QW0wZGxMSWk2bVp6cUJ5?=
 =?utf-8?B?S3dPaFhKOXBOSjM2aFB2ZUw3bVMzOTVtd1ZMN08rRXcweFFDYlZHODZ3N1B3?=
 =?utf-8?B?d3V0bXBicW5WVkZRUHRoU1RwSTNWeUU2b09xa2Y5ZHYzbnBTSUtIYXVHb1kz?=
 =?utf-8?B?clAwME5VN05MR2hDYjJ1blg5SjFicWRYdlhTTnlzQ015SkE5MmFMQnhwcjl2?=
 =?utf-8?B?RGlmNExDTUNoV1N1VnZqUldNdVZ2YmJYZnVpelRGT0JqZy9UZmI3Wk8rRzFk?=
 =?utf-8?B?MksxUFpOamhPL2RJMVJmUnBYbjVjVFVIVDhpMTIzaWtkMXJLK3NvWHV1bmpk?=
 =?utf-8?B?R09nUDVWeUJtNmF0VVpxQ2Zocks4UXNFc3htaGhML21YdXVsajVBbExyQ3FB?=
 =?utf-8?B?bXVvMnRMK2hZK0JPdWc3dC84VysyNEE5ZnRINkNPU1pTeHlPSmRQT3pXT2Zl?=
 =?utf-8?B?WGl0NENDRG9qSUh2TEtCZ3luTUo0SG5PdlhTcUNrL280Ryt3Q29YdFJvaVpI?=
 =?utf-8?B?Y1VkWWNYa2gxRzREdU1qL240WnF0K0RXSkZpQXY0UmxFSVMxd3F2TWhUMU13?=
 =?utf-8?B?UWhrSnFwS2JOcEpPandLbXFIWW40TWFmamFVS3ZPY0czdU5kNndVNlNFRkRu?=
 =?utf-8?B?WEhrZzQxNlVGc05CVm1EWXdVREVZb2ZhZ3VqNUM3ai9xNkxObHZsR1dXQzVD?=
 =?utf-8?B?NmJzN0xlKzBNTktkWXJYTnJNNDc5V0ZxUjY3ZjQ2OHcvanRYZElyK3ZudjA0?=
 =?utf-8?B?NkN2R2R2cmNzS2tuQ2RvU0NBemNuUEVJMUxkUlVNbVZkVFJwNEx1UmF3WDlv?=
 =?utf-8?B?Yk1YODZaSkZORk9haHdNRThKRTZPT3dPRC95dDFpSnpMSHBkLzh0R0VPUmhW?=
 =?utf-8?B?YVErT0NLaVZkVVlvM2xocVVhTURPQTE2QkswL1FqNGVCT3diTjZIaEY0WGpn?=
 =?utf-8?B?eUlMOEo3RjRncTdlSkJQcDJWU2s1TWJ1RXFJbmZSQWpzZURmU0JVZ0VEcWxK?=
 =?utf-8?B?Q1RjcitWRzNzbUFMSEl4VUFaeHZwWjlzUmR1OHpMUWVsR0VIUUs0dWI2N1NF?=
 =?utf-8?B?SWpVOGhJYTYxdWR1UmVGV1R2NFl4clNRTXc4ZzNpckZLZTRqdHBLcTNCVlNS?=
 =?utf-8?B?ZFpXNGdDUjlTbzdzSnBRaDR4cGJ5b0J1b0ZNMCtyYld5dUdETDhJVzhxZHEy?=
 =?utf-8?B?SjBvZlhrak8xYm9ubGpEMDhHZUFMeE1iK3picExaQVAzQVJuR0xCSTJEWTZX?=
 =?utf-8?B?OGVLM0NhaDV4VWFqemoyekhDdUdCTUdIdlF4aUFWMTJmUVZPWm9jM0VMZDR6?=
 =?utf-8?B?QnZ4OU1WV25GRm96VXZxTk8rVnduSjdsbXE2Vlhpb1FkU0FhblR1SHJDSFRE?=
 =?utf-8?B?MVV5aUpTR3pVeDdENExKYkxuTTlnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68009047-ae37-44a4-de88-08dc57d7916e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 14:24:14.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gp/HpbwMDMPKdoPsnUYKLclk0sUzXTmHh0wY7rOxsGf7oN7GFeLP5ID5tFZgyoQ5R2nA52Qmxdwvx4fEYptnBbq+VXTjHRXhEwvfj0fwUVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7272
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <34FD348A7C66264FA62730830D3232E2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 14:25:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15504

T24gTW9uLCAyMDI0LTA0LTA4IGF0IDE0OjQ0ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhbGxvd3MgZG93bnN0cmVhbSBsYXllcnMgdG8gb3ZlcndyaXRlIHRoZSBT
T1VSQ0VfREFURV9FUE9DSCB3aXRoDQo+IHRoZXJlIG93biBpbXBsZW1lbnRhdGlvbi4NCg0KVGhh
bmtzIGZvciBmaXhpbmcgdGhpcy4NCg0KQWNrZWQtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4
Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+DQoNCkZlbGl4DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+IC0tLQ0K
PiBXYXMgdGhlcmUgYW4gcmVhc29uIGZvciB0aGUgJ0ltbWVkaWF0ZSB2YXJpYWJsZSBleHBhbnNp
b24nIGA6PWA/DQo+IEluIHRoZSBzaGVsbCB0aGUgdmFyaWFibGUgaXMgZXhwYW5kZWQgY29ycmVj
dGx5Lg0KPiANCj4gwqBjb25mL2xheWVyLmNvbmYgfCAxIC0NCj4gwqBrYXMtY2lwLnltbMKgwqDC
oMKgIHwgMiArKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZi9sYXllci5jb25mIGIvY29uZi9sYXllci5j
b25mDQo+IGluZGV4IDgyYjQwODQuLjYxOThlMWIgMTAwNjQ0DQo+IC0tLSBhL2NvbmYvbGF5ZXIu
Y29uZg0KPiArKysgYi9jb25mL2xheWVyLmNvbmYNCj4gQEAgLTI1LDQgKzI1LDMgQEAgTEFZRVJE
SVJfY2lwLWNvcmVbdmFyZGVwdmFsdWVdID0gImlzYXItY2lwLWNvcmUiDQo+IMKgDQo+IMKgSU1B
R0VfQ0xBU1NFUyArPSAic3F1YXNoZnMgdmVyaXR5IHN3dXBkYXRlIg0KPiDCoA0KPiAtU09VUkNF
X0RBVEVfRVBPQ0ggOj0gIiR7QGJiLnByb2Nlc3MucnVuKCJnaXQgLUMgJHtMQVlFUkRJUl9jaXAt
Y29yZX0NCj4gbG9nIC0xIC0tcHJldHR5PSVjdCB8IHRyIC1kICdcbiciKVswXX0iDQo+IGRpZmYg
LS1naXQgYS9rYXMtY2lwLnltbCBiL2thcy1jaXAueW1sDQo+IGluZGV4IGQxMDE2MWYuLjczN2Nm
YTAgMTAwNjQ0DQo+IC0tLSBhL2thcy1jaXAueW1sDQo+ICsrKyBiL2thcy1jaXAueW1sDQo+IEBA
IC00MSw2ICs0MSw4IEBAIGxvY2FsX2NvbmZfaGVhZGVyOg0KPiDCoMKgwqDCoCBVU0VSUyArPSAi
cm9vdCINCj4gwqDCoMKgwqAgVVNFUl9yb290W3Bhc3N3b3JkXSA9ICJyb290Ig0KPiDCoMKgwqDC
oCBVU0VSX3Jvb3RbZmxhZ3NdID0gImNsZWFyLXRleHQtcGFzc3dvcmQiDQo+ICvCoCBzb3VyY2Vf
ZXBvY2g6IHwNCj4gK8KgwqDCoCBTT1VSQ0VfREFURV9FUE9DSCA6PSAiJHtAYmIucHJvY2Vzcy5y
dW4oImdpdCAtQyAke0xBWUVSRElSX2NpcC0NCj4gY29yZX0gbG9nIC0xIC0tcHJldHR5PSVjdCB8
IHRyIC1kICdcbiciKVswXX0iDQo+IMKgDQo+IMKgZW52Og0KPiDCoMKgIERJU1RST19BUFRfUFJF
TUlSUk9SUzogIiINCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQg
Q2VudGVyDQoNCg0K

