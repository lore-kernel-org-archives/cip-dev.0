Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4874CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 08:43:56 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15942.1779871426174876650
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 01:43:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gAQSay9b;
 spf=pass (domain: siemens.com, ip: 52.101.65.34, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU0YnWyf0GWI0+aqgEU97r72Y6P5UR3RwwTf1acmg/DUxg4otoejR/aNqa3PSY1I0GDFLPmMVVSituwPim5K3THJ7U207STo25usA8Spum/xdzX1C208ixbxpmmSM886Hl08PPL8oQad0E134IOMsS+Ae/gzbOsbfcPDF5JP8ouVHbVpRPdDNBvNmt4RxWwOZR4uvrhj/VR4ZP56YJw8ocYEBFour08O3/3m6e9XjFvyN8KmH1vYAizGcr0J3yCTb062K8AIc+C8YxJPXuzfWskEABtWZzlC9yx03HnwiOjFGJC4VjpNPM3AiA21/4B0BNjOkPObnuZKxNcD5Hb8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTm9axNigdh6R+3Ll7+i/HP+6qlyYO6nBGUsvJPDIzY=;
 b=TB7eVYIleY5JemzaE6pjNCX0/hKiCPS8nkAZi1948c/UlTYhBD9iiXNAYr9hnki9CczKniN6GJGZScM+l8/oAnVXVzRqPlCY67pDppwM25NSPScTIaOnw8jlE7pmGPa3cV6qXNrCQdhiB5u1/geZBNdkJm6bbBo6uiTRgiCCkatRaGFJxlg8IjSELpjhMl1kbCEBL+6SX+KuRctR8LM+XS48dkNDFTj5ajnlk8Vg59dqXpqy9ClWbyYmQ9xnonA/6IFqhvacxcQp3Ksr7B5hv59V8G5Kghgqv5OqS/BTx9OvbF4BewbUEdDhSeoYkG8U3Bsw4RAr/M6f6AQGTqZ7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTm9axNigdh6R+3Ll7+i/HP+6qlyYO6nBGUsvJPDIzY=;
 b=gAQSay9bICu5+eZ3TMPMzslN2+O1le+QjmlxwBNF3ua3GrQZRezcvb6eWvPklUShcYbTz9UqJmf+XzCpZ4a8ZktKppN8j/evP4O9AYT/Y0I9hIURuVnkzE5iCgW9Gt6seHsNQzV7a7XT446SBGpou+2+tTjWBJcUIZY3dO8r7mhD+ReNDOP8veCnX8w3jcaRlcxEf/AwiS/fTzMeA5brTMrQT8iJwBos1GMwdhUHdAR2ye9fLgH007D9zCPpuiG9pNdZPGi8eCqz03j0wYqj8+bzYGu1/G+9IRJRZsSpltlwDRzL5gxhGIlBIs3v4G9ZpVOVQCP38XXK3vY9x9YkcA==
Received: from AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52f::15)
 by GVXPR10MB9797.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 08:43:42 +0000
Received: from AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2547:a1f4:bf9d:cb19]) by AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2547:a1f4:bf9d:cb19%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:43:42 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/1] chore: drop btrfs support
 from expand-on-first-boot
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/1] chore: drop btrfs support
 from expand-on-first-boot
Thread-Index: AQHc3jLhzjtyD1Ug0Uy+rIDKYamFvLYhrXCA
Date: Wed, 27 May 2026 08:43:42 +0000
Message-ID: <3be8ae20617ba88cd1384fc6f674b2630b71d758.camel@siemens.com>
References: <18AD50CC7ED9498D.2359280@lists.cip-project.org>
In-Reply-To: <18AD50CC7ED9498D.2359280@lists.cip-project.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5952:EE_|GVXPR10MB9797:EE_
x-ms-office365-filtering-correlation-id: a6648612-650e-44c8-f0b5-08debbcc0e64
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099006|38070700021|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info: 
 z/WAmyFVnOiIlVx8mVAt8DexjMn+uaoqhvgap+hZOgRN2h9aaoRWj5qtKlqsDs70swXe9gSKwSYTBDeYu5WBeW4JZEn5orgekhhLpMtWTK9ahJINcEFyvyFCYhT3grF0f4YFNaq8Mvrsdv5qL1t3IsydhQzYSWRpLDa9J7JZpsY4FvjN2VJfm+7gGmdn/iq7CI3GWcsACTYAoNeUuRD+YJkzNsnjTrftj/JbGR+uC8nzw9I/Yl0ktT6SA8JStdJwYnVCKqRK4tR7CF7uncxs4cTlMpw+J412OXMQ3O/YlpvwNcjfk3cW3S4AveN/ET5GyC/kBiWNSCJjPgpqar6aM36x4b2vxQMCGDIUrYMrUXE8QVZK9ZvkupchHNm4oopllu9Zy+JbQbk64OXhrWlLsY57uCsIbdPCnV5U75+y+jwa11FbBOhZlPxx/BYc5rI00fUj/1QcltpJcAJwDigNETCytzmQ3y6RJJt0gXJgNKwPeU+9mqk6NCZWnXU6FrsHdib1gYUlKG690dS8YXlZDGukPmDpAMNzg/fT71IDiHaG4MUR38HnjxIEHR/k6mra3ENY2b3TwmtzBcvyK+JMQwqaFKk7pkHdotSyerqC71gAloOI9U11wPlbQIv+P6WhHoxECJHBrv2DntRIP3LYHVDifb5htMKtUWC/MAb9pA6hFG01SXbxlLWJrdW9B6RMfvkLNyVVnBCEB/y0VY1tfF+csW9qO8MeDaUzPGH3wF5peYxytGvzoVVKxEbSyZaP
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099006)(38070700021)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WEhEVDhRaGV6UnRSTTlpbHpFK2tycEU5NS96aGFBbXA0alFEZnFDVGFYRTBU?=
 =?utf-8?B?QWVMVW1QVElQaVp2YncrN3JmeXBTRG9QcE5IcXR6OFhtNTBCL0gxakR4eGJo?=
 =?utf-8?B?M2lUangrNVFLSHF5S3JxY2VBS0lhUDJhZ3FTNTRYSHZ0NWZCMmxVMEhKZTl3?=
 =?utf-8?B?dFZlK2Z4Z3ZMbnFhNE1JK1Q4cEJVTjlFTGMrQUF1NGFkTHJHdHN3RnZ0ZUJr?=
 =?utf-8?B?ZmdEMTM4b1hIRzNEZVFKWmF3K1h0NURVb015bnpNUHlFY2FTL2twMmxPS2Ev?=
 =?utf-8?B?Q0RkbXJ1eUtta3UrUFoxeTVjU09vbVdrTm5Yd0gyMm5sbGZQaTRraUw2S3M5?=
 =?utf-8?B?eVpoKzZhbVdGN3VzanZHRXFaWTZkcmdRL04wMVFSOG5wRkRMYzRYaURCcVJY?=
 =?utf-8?B?Y04vdkUrbHR1MHhZZlVMSjMzNmNZSEkvT1RRdmtJemQwV3k3OGthRERxLzBU?=
 =?utf-8?B?T2cyQW41dFZmcWY5dER3eVBTZDFNT3RyNlRCLytvRlQ1cUFKNDU5QjdqWG4z?=
 =?utf-8?B?WEY3bHRGWXRDUTYzd3NZSDE4N3ViRDNkSE94b2dnM3pIQ3FTalRZRGxod2Jj?=
 =?utf-8?B?VDJMTWFMd2lJNkh1TVJMSElIdTl5ZGJFTTI0Q0hqand3NjczV05FWEczOU9J?=
 =?utf-8?B?ekx3enIzR0ttVkRCQSswRFVTS1drZTNwazlSUXhUZlZkY0grdHdHQnUvT1I5?=
 =?utf-8?B?V2ExcmxCRmFNZnF2ZFVDSE5hUHN0Qm82SmU5KzZjWWo0Vjg3YUpjYzZWQWhD?=
 =?utf-8?B?TUk2NFh0RnQzWTZsS1JFNUtBWEtvMmpPaDJXM3JQbmlZd3ArMGZvVVdaRGJt?=
 =?utf-8?B?ZUN5SWt3MS9DekUvcWpJOE9MN0QvRlgzd2xnd2g0VXFJblZTOFlGVmgwcWFt?=
 =?utf-8?B?NG5SVEFvQ0FpV3ZKaGwyU1VXWGxOSmxnanlSN0ttcTRSejJsby9HYU0xUmRX?=
 =?utf-8?B?UmVMM3Y1ZzFjZmNhckZVVld4WmZ1WFEwM0xBb3NiNjY4cVZ6c3JvUGVnNkd1?=
 =?utf-8?B?dElDRDQ2RitCWTY4cUxMUmhnc2R1ZGltMFNvbUx3ZUhya2ZCS0Rvbi84NTlH?=
 =?utf-8?B?S1J4N2diSTVyRElrN0laUTNhUWJhc2NNRURlN2lMcGRrWXdKZ3dFUmJueURL?=
 =?utf-8?B?a0F2amhqVVBmbWlpMVRwMnRKUGtyZUp6MmdGWllrY3NmUlFGbWR5L0VRN2ZY?=
 =?utf-8?B?QzhSMVA1cEJjb1AvNzdVUDNpZW5IUE5lSFQ4am5sekhxYmFHKy9qMTRhRVls?=
 =?utf-8?B?QnFSNWJYdzY0NmszNS9ZSnNHMC9QQldTS3UvdHJVQ0VoSjFBcys0UEhIUER4?=
 =?utf-8?B?MGNYcUI0WVo4QVd1dHB2bm9qT1hvc2JGSkxLbmxYS081T0dGdzYyZm16UHJt?=
 =?utf-8?B?WDBHZktoY3E4QlJtcXZhQThqUzBxU1FVSHZHYTAvRmxWZUJKTENYT01wb1Z3?=
 =?utf-8?B?Rmsvc1pIaWRiQktuRk9BeW4wRE5RdHhDNG8wZlZ2RUMraG1SRnc2MCtpcTJ5?=
 =?utf-8?B?ZG94ZVdVTW42SXUyaUttTVB6b1JlaGl2cXFwbzZjYzJkV2ZUMUZNNEtoYVZJ?=
 =?utf-8?B?b0syb2hOUU1jVDlzQUgvYmZ4c3V1WUtScVNIbmdLcmZwTEtDR1UrekN3eGVm?=
 =?utf-8?B?aUMxY1lmRmNFS2QxWFpSci9MdXVXSzYyR2U0aUdPNTdCZUpodkZaV0U5WWp4?=
 =?utf-8?B?NlI5RWV1T1NTNjdhWnM2KzhTMlJtQ0dHTzd1NW1hRlE2V1o3MTJBc0xrNmVm?=
 =?utf-8?B?OEVtTFhnMHM1aWtja0l3c29SbC9ocERQTGhrNXNlMlI4MGFvMkVzbHdpVGhQ?=
 =?utf-8?B?Vk4yZVRWL0plczJVWjB2Ym4yTC9rNzVnQUpBT1hGVW1pRkFVZDlLWlFxUTBy?=
 =?utf-8?B?SWsyWnVJMzZlclJjR1JmblhwZEI3RG1LQXVJZDRtMW1qSUNTWE9xUFl4b3Ex?=
 =?utf-8?B?Rjl4SUxEb1JvcEtTeEw0RHg4Q2Fwd0tEbHZ3eWdva2VZdSs0OXNrQ1UxVlkx?=
 =?utf-8?B?bzlyVEVmSFBBRGVURlh0Z2tZa05iUFRDVUl6SmI1VjE1eUd2eG1WMnEydjlt?=
 =?utf-8?B?eXREcTZ5U2tnNVBLcHhtd3FEV2hUdG1qL1BLUEFMVUg1UFZGUWVvRTlPTmll?=
 =?utf-8?B?RDByVW1lQnJ1bkVGMlJTM0ZJMng3LzlYQk5BbWtKOFNycVdXNmZadmJqZDdq?=
 =?utf-8?B?YUtsa212TnJzOEs2clhkWUhXazZNR3NKdllVN1JWQTdYVmNIQzcxVjBocWdS?=
 =?utf-8?B?WGZYT3dsR3NNbFhUdEJHcVdWSG9WVzdraytSSEk2eFU3SmNUbHpnRURaQlhB?=
 =?utf-8?B?NGdIY0pQRzB4ZVVLcW5VY2ZhNVBLdlBhTXloWmpQdk55RHRZaGx5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB8B0AD3A2C9FA498DD2C3E13F64F3CD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a6648612-650e-44c8-f0b5-08debbcc0e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:43:42.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbVS3JKaqbZpA38VJBAjB995g0ytoKXPWKUHQCBlhTzBNWmVm/uxBcWW1rK2/Ijtx1Xys/U1/sFk9FDDSEcpRFrBQQAmT+fuiAJuywyZV2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9797
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 08:43:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23013

T24gVGh1LCAyMDI2LTA1LTA3IGF0IDE3OjA0ICswMjAwLCBGZWxpeCBNb2Vzc2JhdWVyIHZpYSBs
aXN0cy5jaXAtCnByb2plY3Qub3JnIHdyb3RlOgo+IFdlIGN1cnJlbnRseSBhZGQgYSBkZXBlbmRl
bmN5IHRvIGJ0cmZzLXByb2dzIHZpYSB0aGUKPiBleHBhbmQtb24tZmlyc3QtYm9vdCBwYWNrYWdl
LCBkZXNwaXRlIHdlIGRvbid0IGhhdmUgYSBzaW5nbGUgdGFyZ2V0IGluCj4gY2lwIHRoYXQgdXNl
cyBidHJmcy4gQXMgd2UgY2FuJ3QgbWFrZSB0aGF0IGFzc3VtcHRpb24gZm9yIGRvd25zdHJlYW0K
PiB1c2Vycywgd2Ugb25seSBkcm9wIHRoYXQgZGVwZW5kZW5jeSBmb3IgdGhlIGludGVybmFsIHRh
cmdldHMgKHZpYSB0aGUKPiBrYXMgaW5jbHVkZSkuCgpBbnkgbmV3cyBvbiB0aGlzPyBEaWQgaXQg
c2xpcCB0aHJvdWdoPwoKRmVsaXgKCj4gCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggTW9lc3NiYXVl
ciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4KPiAtLS0KPiBOb3RlOiBUaGlzIGhhcyBi
ZWVuIGZvdW5kIHdoaWxlIHdvcmtpbmcgb24gdGhlIENJUyBoYXJkZW5pbmcuCj4gCj4gIGthcy9v
cHQvZXhwYW5kLW9uLWZpcnN0LWJvb3QueW1sIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9rYXMvb3B0L2V4cGFuZC1vbi1maXJzdC1ib290
LnltbCBiL2thcy9vcHQvZXhwYW5kLW9uLWZpcnN0LWJvb3QueW1sCj4gaW5kZXggZjViZTY5OS4u
YWRmYmJiNiAxMDA2NDQKPiAtLS0gYS9rYXMvb3B0L2V4cGFuZC1vbi1maXJzdC1ib290LnltbAo+
ICsrKyBiL2thcy9vcHQvZXhwYW5kLW9uLWZpcnN0LWJvb3QueW1sCj4gQEAgLTE1LDYgKzE1LDcg
QEAgaGVhZGVyOgo+ICBsb2NhbF9jb25mX2hlYWRlcjoKPiAgICBwYWNrYWdlLWV4cGFuZC1vbi1m
aXJzdC1ib290OiB8Cj4gICAgICBJTUFHRV9JTlNUQUxMOmFwcGVuZCA9ICIgZXhwYW5kLW9uLWZp
cnN0LWJvb3QiCj4gKyAgICBFWFBBTkRfRlNUWVBFUzpyZW1vdmUgPSAiYnRyZnMiCj4gICAgZXhw
YW5kLWJlZm9yZS1lbmNyeXB0OiB8Cj4gICAgICBJTUFHRV9JTlNUQUxMOnJlbW92ZTplbmNyeXB0
LXBhcnRpdGlvbnMgPSAiZXhwYW5kLW9uLWZpcnN0LWJvb3QiCj4gICAgICBDUllQVF9QQVJUSVRJ
T05TOmFwcGVuZDplbmNyeXB0LXBhcnRpdGlvbnMgPSAiOmV4cGFuZCIKPiAtLSAKPiAyLjUzLjAK

