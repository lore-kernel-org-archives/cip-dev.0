Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D256CC83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:50:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.24])
 by mx.groups.io with SMTP id smtpd.web10.20725.1751453419006877816
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:50:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=NBDJVnQD;
 spf=pass (domain: renesas.com, ip: 40.107.74.24, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BELLptgogG66QPPIuOzEQTusYSbOF5N1p/QZCWe+nuySBlFKKBuDkrSpB+OOh72217fsVR88blCPcs81+XN1bYRXUlTjv+HBXJ5wEtcO+a7uDWnOqHgWSQUYcUh3w53zjpP7RyHlZ6e/Ol5XLEiH4W1WklsP3zGbM0ybidKjZKQOpS4iwe/rsq2A5Mtw2gdQrDViE1dB/3MGVejMuT/oWOwCevT4LbsQUIeW6hxvZtIyy3BVI2V9cq+Z30Zm3iElwRw+x1uiPMyCp9Bm4q0ENJOp2EMQ+Xd/0utit9xYhhVi/B1MYMjvlss2dBVykug6dMxsuluTBCTtXsPnKn7QXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu7fVmgZ9/a+w26gBNeQwBzM24LkrtKy3qU2tGL4onI=;
 b=I9v8NPeT77nR2NrI5RkFEvArr0Vw2a3vEqQKjS83MAIT/48FMBiDKyn2bb63M+uUd+KEkLOLPELc8wAbmEaxLDQUKj8KGdh+gL7MBAPD/tBfgTZ7PAfTWJyA99yloXgloPIHXb5cmGLNgducD8SU8gzPQllUxKz/gkAEHbUSHdng42GMYvTDzDbTXGaCs1QN004maJ7f93tjH+N+0QqGo3tMFrViQtIk257A0FwY1E5nDMqKDFuz0D1qI9lKQ0DMABgMkzH6JmbrIxQ+4pdzBusM5Px7YKwaE5eRuqXbRJ5MevFpZ0hNzd1OeqTFGpH3XmQRUfofqJmWvFS+si0lDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu7fVmgZ9/a+w26gBNeQwBzM24LkrtKy3qU2tGL4onI=;
 b=NBDJVnQDLNHxXFHm/ZPaF77VkggIXguRDG776WLaN2Gq1HbYkc/5wm1SwfSpAXWbY5BR1C2Oa5H/sRPeuUiELpAxC6x1u2WDWQhOktIrhG6L/PyGWQegHdcqVr70fTpAmbuAbEd4nJ+6acpvuqRkCiQkzWfsAeKfPcHfx6x/pU0=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OSZPR01MB9565.jpnprd01.prod.outlook.com
 (2603:1096:604:1d6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:50:13 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 10:50:13 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH] Kconfig: Exclude building 6.12-based
 images for the IWG20D
Thread-Topic: [isar-cip-core][PATCH] Kconfig: Exclude building 6.12-based
 images for the IWG20D
Thread-Index: AQHb6z3omYLGIR6EFECrba2x8io+ELQepz+g
Date: Wed, 2 Jul 2025 10:50:13 +0000
Message-ID: 
 <TYYPR01MB15132E4927BF24EA16311AAA5B740A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <a2690fd3-ae21-4f76-91df-8457a95ae22e@siemens.com>
In-Reply-To: <a2690fd3-ae21-4f76-91df-8457a95ae22e@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OSZPR01MB9565:EE_
x-ms-office365-filtering-correlation-id: 08ddb307-9819-4d1a-dff0-08ddb956396e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cmFFRm51R3hheGVjMmV6Y1hoZjM3QVM5MzlxMXhNdFUrRXF2OTF3ZmRwYlZh?=
 =?utf-8?B?cnJVLzZXaFp2Y1k3SkcvbTdrSW40dVdWeGhBK3Y1MVJqTmpPVWh2SzhFaGg5?=
 =?utf-8?B?djlwK2NuSjlrbS9IVUUvTytTSU1KbW0wMTBQU05aa3lyY0hZeWtSdUFiWkx6?=
 =?utf-8?B?VHhLeG0wOXhuTmIvSU4xTSszTVFwV2haRURnWEVmUGdMclQ0aVU4a3lTWXJv?=
 =?utf-8?B?ZE1BeWtacnQwM1hYUTRLMU5pa3RiZm5lOEtHTk9wVHVWaEhEZFc1SFEyVGxu?=
 =?utf-8?B?akJFZTJMZGxDUWYzTTBPRzEzMWp4V0hzZzlWTGZnZVNUekVsZUIxRlk1bmF5?=
 =?utf-8?B?UXk5K1NtRGw0QklmcXZJY3RrRGlKOWNCbWxGcXJGNkZjVDd5cExiVVFJWWpw?=
 =?utf-8?B?ZnFta254RHl6Qmk3clBGVi9tbHVibTdUY2JZcExJTkZsbFZlZWJ2RlJyamZJ?=
 =?utf-8?B?Y1poYWN5WWJaRkVCZU41YkkyZ0hqU2xiTXZuaXFwV3Q1UUdyYUgydTN2clB1?=
 =?utf-8?B?U3ZqSU5qMk5PTUhZS1phd2Y1cnl4TmZTOW1taWxlL3F0MzFscVVOc2p3TTFD?=
 =?utf-8?B?RXV2K3FicGNpZnJlc1U4YlA4WkRBYU94bU8xSkcxUmUrclkvQU5nRlZuMlpR?=
 =?utf-8?B?VDFGTktNczB1bk8yajdtcExWaER0TUpjMUI5VnpHOFdaKzBEbzZmNTV1SEJH?=
 =?utf-8?B?QWlWTkhYbEwzSVVrQUhpY1Z6bkZsR2wrR1ozRk5tQ0lQL1AxbmhnNGpwR0VI?=
 =?utf-8?B?K1cxbW5ncXRsb3hLTzBuUGJ3TTlwYTdXUWlqS3RXVmlrNUVYUi9GUzRKd1hP?=
 =?utf-8?B?SDlpL1BpdGZxc25nbi8rSU9hT2lLY3RKVytESHFpT25BeklWQnRqNzlMT0Z2?=
 =?utf-8?B?dnAySFFoMEdHRFhVS0NvaDdSSEJ6Q2piNWV0R2VSR1QxMUs1aHJGZldrRWZu?=
 =?utf-8?B?ZzQ3dWRzMVlQOHdHM253QzFPa1VRMTVLVUVmWWo5TzQ4c2lWbjhpU3F0Mm5w?=
 =?utf-8?B?NzQ3RHFCbm54OVVCak1Sd1RuWjhLK0w2RHRMeGh6akJGMGJRZG0yTDFzc2Y0?=
 =?utf-8?B?d21DKzNrbEJleVVMaEc3YXFvQm1MQk5kREh2eThPaHV1SDhlWk1mQlVPazFk?=
 =?utf-8?B?bUhRalBmbUpRcFNQVHJyaDFYM0w2K3ZjdG5nTzVRamtnV1VwdmpsYWlLNkNm?=
 =?utf-8?B?dW96dmFoNnFuRVlNOElBSnJtQWJmR3psMk1OTzFmUnFmblhEUStWalhOVE80?=
 =?utf-8?B?S1BrZDVIQmdRUCtqeGhCN0dEYk9TbUMybjRoOXQyUDRZNWYzVmRtOW0yM1lY?=
 =?utf-8?B?OVVpME14YTNzbVAxTG05cUEzWElaMFhOZHB5MHFrdWhNdGdTS1FmUXFrcXRs?=
 =?utf-8?B?WEEzWW9VR1JMc0xydm9ib0dwcisrckJXclBxVmdSWGwvN2ZuTmRrSWVhaDNu?=
 =?utf-8?B?TU55bnZkSkxhVDdIdk5XdkNBWks5WmVSUU5kbTlpZ040MEc5eU44eTRPdFdt?=
 =?utf-8?B?SFZjTVRUZFdkcXZYUDlwYmkwLzJmU1ZSZnRwZzBpejZhdG5lZFdWOG1MQnYr?=
 =?utf-8?B?cTVIdlJQZHIwRmZHWjVzanJjVmpYQTU3MjR0Nys2dllEckkvKzl1dmxCb0hv?=
 =?utf-8?B?TFFUZUdwNmV3SWxHaG9Od0dLTmRwN1VwOUV3cEViN28yNmRsbXh1ZjhXaEdB?=
 =?utf-8?B?SE1rQk04L3JIMWZmTFZSVjlKaUNWK2NXSlo0TFluYkw5VGFJN3RSbVQrcStp?=
 =?utf-8?B?bTNKNDZHcDRWMmR2WTNsT0RaUDFWdTZsbXM4MThCZHZKdW5YNFM2d25hN1Np?=
 =?utf-8?B?T2tNV3l5ZjdKeXlPL1NBUDlVcUJnV0FrbnRIcHpXM0dGZkhPYmpiR0pVZWs4?=
 =?utf-8?B?RjlaNStvNlZHaW8vc1gxT05id1o0dkdSWUU5N0FDSmlYNDRYRHNGSk04bDFH?=
 =?utf-8?B?REVrWGg3dTkwcDcrUmRrOEJRS2t1SnBhVjhLam9IMWNIYkxGYVlGYitacnJx?=
 =?utf-8?B?N2xTKzFoMlVBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VE9tcFIvYUI4Qkd4MWJVRnVIYjRtSS85RWtETzdZdWdxRkxocXBnYjVXUXdx?=
 =?utf-8?B?a09FZmZldi9COHMrTnQ3Snl5RmE5UnZ5YXY4N0E1K1dqbkNXcjE3N1NxYnp5?=
 =?utf-8?B?M2V2dFJRbXNJOVR5ZXpOTlg0OG1IKzFGSVhSUFF4MjNqbmZwMXg5V1FPWnhI?=
 =?utf-8?B?NVd6N2FLSWh5bzhsMDhaL2VJWTdOaUVTeHpIVmg3UUZ0MHo0ZWV4Skt1NFBU?=
 =?utf-8?B?ZWdobjRCeTltaGwzODhOem90YUpqWkluU3IyWWNwMENNRzdZcGorOVJZaFBE?=
 =?utf-8?B?YmNtT0NtV1YwTGRoWnMvOXdBb2RLUktIb0dMM1h0U09WMWRXSTMzSEhnYVRK?=
 =?utf-8?B?eDlSaVpTcTNSOVcvSDNvSy9XTTd5bkdWR1ArNnRIWkJya2dna1Y5SllTekZu?=
 =?utf-8?B?Uk1qMUR3M3BIWlRqcld6OUYvTzhQbGhaTEt6Si84ZysrZEhpbEtxcFl5Ujl3?=
 =?utf-8?B?dTUyazZDWXQvajRQczFxQTh4Tys3N3JqTmNPelNwSmF3ZWJFdzM2RUpDRmt6?=
 =?utf-8?B?dWJHc2Vka2lLYzNSZHliVWI4SGtBQXgrQmpTMmJzdDc3VmtSdDZ1ZEhvc1k5?=
 =?utf-8?B?cG8wdytOQWUzc1hvWWpYbjhDOGtNcTdZeVdVMjhUUkRQNDlOSDVSK2VvTzBo?=
 =?utf-8?B?QlM1YUVOR1l5Mk5QYkM1RDd3M3grT1NZejBtWEdxOXlGWTNuYWZuVWRycmtO?=
 =?utf-8?B?alFDRmZqbnRmWFFSUUxvZ2V2WUZvazhBbFd1SkE5UmZVVGlQUDRIZkdwSkVX?=
 =?utf-8?B?aStZekRWSjV3SGdudU9YQStUb2l5QnRYK0ZDUFNkZWRiV1d5Z1RmQUF2Tmdx?=
 =?utf-8?B?cFhSUkZQKzlqdTYxaFFEZ2FaRGFYR3FMOUtzaG9QQW5Ra0RPT2Q0cTQveDJY?=
 =?utf-8?B?WHM4dmwwandoTTFocWc2UWtyRkladkprc0pYWXNwb2daVUtWS1lIdVFEVlc5?=
 =?utf-8?B?N1ZGeG1FK0RnRnNuSEhEVEVQMW5hNVY3aFlGWXhEc1gweW50cXgxckswV2N6?=
 =?utf-8?B?MzdZWExXT0lqT1JGZ0RQUS83VGxGUmIxeEg4SzcxckErYWo3T004MGc0UXBN?=
 =?utf-8?B?NCtHbHJPTElqUWpkT2pQWGcxZEh0TktPRTBXek9EekYyT1AxaDE0TGJodkJ5?=
 =?utf-8?B?QzRKQkRQNkJOK0J2NWhxOGFsaE5sa0FEMTNKK1JRZTYyTkp5ek9nbFozY000?=
 =?utf-8?B?TFNYbHJvYVdrS3dEeUtUcVlVQ1dXMHZWelV6NTNMYi94c0h0QkxCcEtOZ0JP?=
 =?utf-8?B?NTQwRjVxN1BSM3JHMG11aW1NOEN4eFl5dzl1T0dnOTNBbGZpRjBXeXFYVzF1?=
 =?utf-8?B?dDlFbVAvdEdRMW9leThwY2ZmRmpUcnFKdUZZSmlVQUtaY0lYK2J2TzJMOWxB?=
 =?utf-8?B?eFU3UHB5NHRQeWZpb09NNi9LcllUajVVR1BaN2d5SDlpZXdvOGlsMEtieDBM?=
 =?utf-8?B?aDRHWndOa24rS2pxTXFpMDVBQkFyL3AzUFFkS09NQnNyNmlGOERWVzE0VFRJ?=
 =?utf-8?B?Mndmd1ZybU00Sll6amZVM3VNUHVHVXpEQldVdklFdVFHTmpOcUNBSmMrSEVF?=
 =?utf-8?B?L3FmTkltY2hlcmI3Z1YzV3dMVnhrYnlVT2M2Z2FwU0lsZHJyMjJ5elNhNERz?=
 =?utf-8?B?S2VjRXBiS1kzZWZDbDIzOVFkWGJvVkE5NTNEYWtaejBwUmNwUzM2RVpPYVR6?=
 =?utf-8?B?U2pYelRDQUNqSU90bHVPVng3UXNXNGR6QytuWlR2aHg3bjhTaDFkZ2tqcVFx?=
 =?utf-8?B?R0NDa0g1UlFzZVQxRlc5cWhydHI1RjR6YWdveTRudlNxdlJNWHFIak9EU1J1?=
 =?utf-8?B?dkdBbzJSUmFZSHRyMnFvRUxNVlBZalFDU0tpUEM0cjYzcTdHaks1bS9mV2Nm?=
 =?utf-8?B?bktuNGFmV1VLZHZpVzhGNjF2cHFrSXEvOHFtYVpNckVIS3lEcnNRUitxTmVa?=
 =?utf-8?B?cnNRZ1dSMG8vMVBhSmhDVldoRU9vQVAxMUdoUVFxbGRQQ0JBSnE3TC9KLzVz?=
 =?utf-8?B?NFM4OVBJWWdrWDAxZTh2azBON2RxeEF0eUxabHBCZGFJSlR4Q0p3NkdkaFlj?=
 =?utf-8?B?NE5DNVFOMTJXZ1E5V1FvL2xYV2ozdVJRdmlWUkh2MTRqdyt0cFhabW9KTmpF?=
 =?utf-8?B?bGdsVXg1MUl5a1ZOVm82V2phZSs3M045d2RoTlk3TDRDWXMvS2F4SU1BdTJv?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ddb307-9819-4d1a-dff0-08ddb956396e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 10:50:13.7804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+1dwCRgpAOKDGVYDhZVCkI7H6xHsRWZHoLztPnsDt+VLBU49MmUHgKYuf4w6vvFTaKSj7tzLYdPStfPeedoslhhkZR5w6rjQi+iE88Tn98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9565
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:50:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19313

PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiAwMiBK
dWx5IDIwMjUgMTE6NDINCj4gDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+DQo+IA0KPiBUaGlzIHRhcmdldCBpcyBub3QgZ29pbmcgdG8gYmUgc3VwcG9ydGVkIHdp
dGggNi4xMi1jaXAsIHRoZXJlZm9yZSBoYXMgbm8NCj4ga2VybmVsIGNvbmZpZyBhbmQgY2Fubm90
IGJlIGJ1aWx0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNv
bjJAcmVuZXNhcy5jb20+DQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiAtLS0NCj4gIEtjb25m
aWcgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL0tjb25maWcgYi9LY29uZmlnDQo+IGluZGV4IDU4MmNlZGRjLi5lMDc4ODkyNiAxMDA2
NDQNCj4gLS0tIGEvS2NvbmZpZw0KPiArKysgYi9LY29uZmlnDQo+IEBAIC0xMTIsNiArMTEyLDcg
QEAgY29uZmlnIEtFUk5FTF82XzENCj4gDQo+ICBjb25maWcgS0VSTkVMXzZfMTINCj4gIAlib29s
ICJLZXJuZWwgNi4xMi54LWNpcCINCj4gKwlkZXBlbmRzIG9uICFUQVJHRVRfSVdHMjBEDQo+IA0K
PiAgZW5kY2hvaWNlDQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K

