Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A73FD116F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 14:21:41 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8768.1764685291147670449
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 06:21:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jCcBtX0I;
 spf=pass (domain: renesas.com, ip: 52.101.125.10, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it6KInyVlXccG9xmwar97msgBnVMwu2+y1U/1H6BtE0Os0pzI3I1i27o9rtMbpMzhpWWCGYFNxwPObMoFFTWs9Uv5plX0MYIvVh3GRQnI/6xFh+NMhIo9fd1Mastr6Oa4rP7BIj4kekuzzyIrbdckyYFH4mv4CQ6Vo2Mnj7YKgkaTkILtDtdZcuw6G4dy0Xk/WllCRp6CzNidAzAxsx1rTcegyotmyHgkzdO+os2SHolkkBHtehl2xDupV9ndHHUNiq41qmyt2b1U69lcBo1QLp084xvHWksPuabDR6jmvCtVLz+mxI5INaArVUGjZH68oO8VGLBL0FlRMzL5Oxafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Xo/dtKE4v1WzzD3yrsSAXThAAAg6URpIF5TCql0FI=;
 b=hTX8arGp/O+v0F8jrmisJBfeX9FSXPPanq1jutm59YhOw0IG2aUF+v4X+aSODMzFlLvsNNKcXMaia7giXVmrYKKR1AYTT9u69O/0PJHubyqJQ1yX4ufj+3oR17LhQT/kzSbYc41WcBhVY611fNjLfWZX21pKWm8jn6hyVemYnfTz89KcnJ9BuZNSb7/+pRiF3f+yaJxoyghQyOjUXZq1GiW8f4kb5+IlUaxG0795Q55RGC9ykgVvuT+3rbKSO/C6LAVQx2h/lWTmZKHZrfoN93OxBuUExfUokZAAgeG67OzDNHrDAa/48Px7+E6BySkTkSWZP4isCrQE72Mk73T9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Xo/dtKE4v1WzzD3yrsSAXThAAAg6URpIF5TCql0FI=;
 b=jCcBtX0IBJlCXJWb3tW45M++GtbtHJg2VFgkT4S0Z+VJywpxgs/AnJndGqrb4MLMYMUoGuTaiwpqmuvGbC8eyAYKQztT7hWT2i4FOGt8GcF2JsnWf+u/ufaSFv0geZbJUYck245dKdivj4nBO7JlwkXkJPy8HNtwjIGZUNly+Mg=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OS7PR01MB13634.jpnprd01.prod.outlook.com
 (2603:1096:604:359::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 14:21:26 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 14:21:26 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Arisu Tachibana
	<arisu.tachibana@miraclelinux.com>, cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: Deployment of isar-cip-core images, lava images
Thread-Topic: Deployment of isar-cip-core images, lava images
Thread-Index: AQHcYpzyVciSnrArx0GrkuWM6vnhq7UOZcdA
Date: Tue, 2 Dec 2025 14:21:25 +0000
Message-ID: 
 <TYYPR01MB1513215D1DF4F9187043D495FB7D8A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <bbb91f28-1475-4b64-a2da-2883b784f1b4@siemens.com>
In-Reply-To: <bbb91f28-1475-4b64-a2da-2883b784f1b4@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OS7PR01MB13634:EE_
x-ms-office365-filtering-correlation-id: 770591f2-3f97-4595-5074-08de31ae13cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|3122999012|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SUVxRW9kT2dFaGVVRkN5dUJ6QXRhOVR5VGV0QXB1UGZ2dU03TjRxc0JRUllZ?=
 =?utf-8?B?bWVaUEtBS3h1MEN1SmNqbUpEdkJ5WGdXaEpmTU9MZnFVczhVSTJHSmJaRVhP?=
 =?utf-8?B?L0h1RmhQNTFNVW9pNStiRVk0OFViTHBuTXVJL3diNzRjUkQzbXNhbWtESUVI?=
 =?utf-8?B?azJXZGJtV3dMMFpwVU55Nkt3WG9uQ3JJaDRPYXFRYUx0UCtxNUNTWnNTbWFH?=
 =?utf-8?B?UFRqTldUcEVrZmNLQ3ZlOW5zV1liM3p3N0Q4V3ZWMmVZc28xZmRoSWtucEhP?=
 =?utf-8?B?T2ZMVkVqbXJabFZ5YWZHYlhsdXVhQ05Dc1VZaGd6dnZzM09yOVdMY25OMmRS?=
 =?utf-8?B?ZWpMa3R4L3A4Mi9WM1VqalJIQ0tiR3ZIM05kMnNpdHVPK2FYcmJSV2x0cC9H?=
 =?utf-8?B?b3JTTFdGdkl0c2cwbGFVRHFVaUxVNStkY3hrUlhYS0NFaVdjSTNLNU1lN2pn?=
 =?utf-8?B?eEdVcFFXb1dyS0tQYXZ5MWN4aTBmMStUbFlJVWRONVBEZEM5ZW5nNktBMTk2?=
 =?utf-8?B?NEI5b3hPT3VKUUh6QmVxcGNWRDlTS0N4V0luQ3dWQkdLQ2VlbU9xUjkzMThO?=
 =?utf-8?B?MytPaTMwcmxuRUhYSi93bG1aamk3S2dsckdlcGhvQytSQ2p4bmlSVnV1ZC80?=
 =?utf-8?B?T0xEMnE5cGNxb2FqQTV4MWd3ZkloWWw1eVFXdjF1WXdKekE4Ni9oZ3lJUjNY?=
 =?utf-8?B?TTdWSytIM3MyUnJSTS9FVHZjRi83WXVBZVpZNEh6UGJRWnZqUTJKeGIrR1hJ?=
 =?utf-8?B?OGlGeHgyK1lPMThGQ2hVakpXZUxQd3FkMFptUFRvR0ZoSWlYWkw1WEtnL2Zu?=
 =?utf-8?B?dS8rWEFLeTdCaWFLSXkwSXBkbDgzYTJGd1dxdmZETTZLN2YrWTdBdnZRd2ky?=
 =?utf-8?B?TlNhL2dPdEN5RjRVQ1REM2NRNUZtMlNjcE1IdUlQVnlrSEJTQnhYVTF0czBW?=
 =?utf-8?B?TS85QlpqczRkUmJiYTlrRzF0SGE3a0JZUkswMDZFUTVLK3hOb1NmR0dUWEN5?=
 =?utf-8?B?TSt6SU1WQVo5MlFpWm9lV1RHT0tFVTFNR2RGampUZ3B4YSt5bDQ5RjNrNWN2?=
 =?utf-8?B?T0JtbEdhamhvaHAybmREYnlNdW1CaTlNL01tRFZyMkdpdzl2dlNaOVhGZjBB?=
 =?utf-8?B?aGt5ZG5RbGFoWGhldTFidnR2RVlhME1NdkRpdHJxcHJYMzRFQXdzNmVkeXk3?=
 =?utf-8?B?c242clNhc0FNbFh3eWNRd3E5R3JjYkV3bHpVV3hIS1VBdzFZKy9kL0JJbmZK?=
 =?utf-8?B?OWRtNnIrTStpeFBnSEdZK3JDbWxLZE9sNnJFQVVEWkN5SjF6ZVFQS09NN09N?=
 =?utf-8?B?azlqYTN1QjhmMUdiTVhkOTRvUHpJZmFBZlliMlRVRWJ5cHIyNnlzQnNjNVdn?=
 =?utf-8?B?aS9xYVF0NFlUVVA2QW5nUmJNekhKVzlNMkxRN3RNa1dxeWVGSVhKbVdjY1VK?=
 =?utf-8?B?L2dFdDkvdjZrbU9RS08xSzVIc1NwOUpINURrSnVqc1o1UnhtbnhOOHNUSzF6?=
 =?utf-8?B?N3VJRGNIbmhYN3JNUGhRb0FiV3BMMU9CRUtlT0I0NnZXTkxGbnNadjZSRko3?=
 =?utf-8?B?MzRzeTVaSjZub3UveldSY2I3ZFBpOVpQdjVxMm5XWjcrQ2lHM3JRUFNDakZZ?=
 =?utf-8?B?S0paWE94VERFZzVFNVpoQ1NBSytlbTJaS3pWYzlTT1FTalNHYytaN0N6TUxR?=
 =?utf-8?B?dG1KU0hYRjFUMVJieUhORmpHcm95djZIT2JvUkd0Qy83eEN6b0dyNTRWTElI?=
 =?utf-8?B?cmhjUVo4eStPSFpGRVd3RlZtZlZBL1MrTDdwSzBRYTcwbWw5ZG5sZGhzeFhj?=
 =?utf-8?B?T0VrcWVhSlFLQ3UxRk1UZkNVQUxLWUlBOERpVVlYODJSQkIxYjdXR1RLcmtq?=
 =?utf-8?B?bkJudmkreW82OHpZZHRHSlM3ajBuQ3VQZjV1bGJITU9RczRWSXNRaGJzdjZJ?=
 =?utf-8?B?WVNpTVUwSmxxR25VOVRXTnZoWEgxU0ljdldCYzlrMTd4RkZVZ2dOalBkRzJi?=
 =?utf-8?B?VWJSbUVNOGNhbE9EdDRseWJGWHk0ZUhHaUNXcVBkeTZFd3ZmU3laVGJIYjJk?=
 =?utf-8?Q?KuqOUN?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3122999012)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eE5zbFpZcGxZVmZQZUJrU0JZM1ZTVm9Jc1NvSzZsN2U3NXJjdk9BY2k4S3hQ?=
 =?utf-8?B?UmFYOUg2ZzI4ajA1SWhHbmlnU05pN0FSdENSSURzUEFqV1ZnV2ErNXdHcFV4?=
 =?utf-8?B?V3lPdFI2L0xzY3cvSXB3UDhPVDYrT2dlYk1zbWxodno1elVZZ05uMDFLOXF4?=
 =?utf-8?B?OGZnNGRFQmVKdU5SbU9WYlBnRi9QV3hLM25JR29LOXdDSlFxSWQzRnkybW12?=
 =?utf-8?B?dDJVZUFadG04eGFwb0ZCZUJEOGlQMk5kZmtqUys5a1ZZZnptQUVyTldIWndv?=
 =?utf-8?B?VWcxNzlwQWEyUTJwdTdHTDBQSUNIOW5ma3ZQVTlSemdSTnB1eVQzTGdUT3U0?=
 =?utf-8?B?UGlmQ1N2MExlNlA5SmpRK2RramtwLzBZN1FGVHg5ZXRmRXp3VDRzZDRybFov?=
 =?utf-8?B?bHJkaFd4aGdhQzl2YURYQzJmMzhIRGdPNWlaK0J6QW1WOGpUY3A4NWFNWlNk?=
 =?utf-8?B?RlFGamRyaytjRmZ4UVVJT1RpdFJTb0FMRTRCbXdyR1JldXlqSDdlckt1S1Iz?=
 =?utf-8?B?b2h4SVVnbmdxT2drQjdBeTF6ZVdHMDlTUzVueXB0THQ2ekdJZUZhWlM3ZWRv?=
 =?utf-8?B?UDhnaU5mQ0NCNnhXVm1xZjdtdGxnRnhZT3VjQjhuUXJHUzUxbFF0T3JRT1E4?=
 =?utf-8?B?T3RMb1hDYkFpOVdCaUNQRUNjVjFOVnpVeWFsVW4rUEtJc0hlZ2o2bzZxUXJh?=
 =?utf-8?B?MU51eVFOREFURi9aMDhBM3p5a2x5dEVBRXN6S0IrUmVNTEF5NDV0YUNPT2hv?=
 =?utf-8?B?MTZ6SGg2YmN1SkRKeldLbVpWY2dsRHBqcXozdGlMSUpKOUo5M2hUWDg4U2xR?=
 =?utf-8?B?TVBiY28ySXdKRmdER0tHVE15OHJYUks5UWF1Z250ZVgzcXgxSitjMjdsVVBK?=
 =?utf-8?B?NmxWWWtUS2I5dGR6SEVscFlTTms5Z0hsbEJ0YWRSU3JSZjBYNkZWa3hObzRT?=
 =?utf-8?B?cHYxcmdpbEZuZW5yU0JhQytRS01kSnZid0RiQW0vWDV2dGdWRXFmYzJQcVhM?=
 =?utf-8?B?dlhsM083d3NhNTRXYWdiVWxrSG92dWx3RjIrNlBkbTZtZEZCUEt2dm1KMVdv?=
 =?utf-8?B?SXFKL1RoVTBLSVVyeStmM2NMR2NXSXBMOEFQZUl1S2RRY1Bac04wZFQ0cmpa?=
 =?utf-8?B?M1g0czVvdWJ3RVVZYjRzMjJPWWR1V0ZXN0h3S3F6ZzFyMGRMUC9KcjZ0Nllt?=
 =?utf-8?B?QVk3VkEySlZkMkV0ZEt0d1hLYUxrOGVzU0JPbW9EZi80aytiS3llSWMycy8x?=
 =?utf-8?B?NFNHV0ZtemhFSGVWaTdGTi8wU0tNNng3dm5JQ2RxR0RRd2dpTmUvNGVMTXl6?=
 =?utf-8?B?ajUxakJ3bldTN3ZoaFozSmFvbTRGWkFsTjBGSm1tUmhxcnZmdXV6aStEVytr?=
 =?utf-8?B?L0VVdy9ESDdsRGpMS1p2Q3NsQ2xhNXBtQkxTU2ZBOUdiMkdHWkNJVXNOR1lU?=
 =?utf-8?B?SzZRNS85ckdFN0l1NGJhUjRtd3kwalVnK081aXdmZTBqYVdaQzRmckNmWGho?=
 =?utf-8?B?OUdGcHRSRHBoTzZZeVlCb1dTSkdaR0FWSHlnK0JTdjdUbVpZVVh4cVovQ2VZ?=
 =?utf-8?B?WUpSSGl6TUdlVVlGR3BaOUdHYTJJcXpCMnFPSVdHazFYNnZxWVhpaE5hQWpx?=
 =?utf-8?B?NFBiS1J6cVd4b3lHc1N2SHIvKzdsM1d6ZE5zWHpkc25lYmRpZnZ6YnNvZGlu?=
 =?utf-8?B?U01ZRFFHY2hjK3NxK2FuS0gwbEVFRU1wd25CSFAza2hGbjR3UDloT081YzZi?=
 =?utf-8?B?YmtnQ2lQY2VjZE9oSDlWR1NmVnE0aGxuMCtldHE1RGdqQ3JhL3NadG1EVHRW?=
 =?utf-8?B?bTBKNGgwL3FJYTIyd0xmZnJvRWlqcStrMXBzUWJDdHVxMWJFLzdib0tOdzgv?=
 =?utf-8?B?K2owUFU1SFBEMG1QdkVnNlRYbExSRjNUc09uaEN0bU5ZM055YjJVOER1VVdF?=
 =?utf-8?B?QWwvZWFiMWF2QTRNbzNCcUR6Kzdsb0c1cWNIdC9nWU55RGxXU25xTVFMalNu?=
 =?utf-8?B?RlFJVzZJaUoxcExwL1Eyc1dNN05mNnhDVGdsQ3VkeEtaVEVoVFRuK0VGcE1w?=
 =?utf-8?B?Znlwc3Y5V0VyLzgvL3lFSFhzbmUrN0JOb3V4Szd6M2h6Qm8zMTZHZzlueHJw?=
 =?utf-8?B?bXdReDVkL1ZaYmNscmRTZlM5Mm1RWTM2M2g4a0lYODc3U0lMR2ZYRnBzOXRE?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770591f2-3f97-4595-5074-08de31ae13cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 14:21:25.8739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWEva62mbtk6Cxoh1q3IhORvaNSIMUs3IS3B82dTminm7ZkzJMM8EN/+JhKDscfnBFHkoCSpxPh34uliVgMu/erEeJZ4BAEI0qYV6/EnFMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 14:21:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20810

SGVsbG8gSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+
DQo+IFNlbnQ6IDAxIERlY2VtYmVyIDIwMjUgMDg6MzINCj4gDQo+IEhpIGFsbCwNCj4gDQo+IHdo
aWxlIGZpeGluZyBvdXIgcGlwZWxpbmVzIGZvciB0cml4aWUgdGVzdGluZywgSSB3YXMgYWxzbyBz
dHVkeWluZyBvbmNlDQo+IG1vcmUgd2hhdCBhbGwgd2UgYXJlIGJ1aWxkaW5nIHJpZ2h0IG5vdyBh
bmQgd2hhdCB3ZSBhcmUgZGVwbG95aW5nLiBTb21lDQo+IHF1ZXN0aW9ucyBhcm9zZSBmcm9tIHRo
YXQ6DQo+IA0KPiBGaXJzdCwgSSB3b3VsZCBwcm9wb3NlIHRvIHJlZHVjaW5nIHdoYXQgd2UgZGVw
bG95IHRvIFMzIHRvIG9ubHkgd2hhdCB3ZQ0KPiBhbHNvIHRlc3QgaW4gdGhlIENJIHBpcGVsaW5l
IG9mIGlzYXItY2lwLWNvcmUgLSBvciBhcmUgdGhlcmUgbW9yZSB1c2UNCj4gY2FzZXMgb3V0c2lk
ZSBvZiB0aGF0PyBUaGVuIGxldCBtZSBrbm93LCBhbmQgd2lsbCBrZWVwIHRoZW0gd2hpbGUNCj4g
c3dpdGNoaW5nIGZyb20gb3B0LW91dCB0byBvcHQtaW4gZGVwbG95bWVudCBbMV0uDQo+IA0KPiBX
ZSBvbmNlIGhhZCBkZXBsb3ltZW50IHRvIGtlcm5lbGNpIGFzIHdlbGwuIFdlIGRpc2FibGVkIGl0
IGFmdGVyIHNvbWUNCj4gQVBJIGNoYW5nZXMgdGhlcmUgWzJdIGFuZCBkaWRuJ3QgcmUtZW5hYmxl
ZCBpdCBzbyBmYXIuIERpZCB0aGUgc2l0dWF0aW9uDQo+IGNoYW5nZSBieSBub3csIGFuZCB3b3Vs
ZCBpdCBtYWtlIHNlbnNlIHRvIGxvb2sgaW50byB0aGF0IGFnYWluPw0KDQpDdXJyZW50bHkgd2Un
cmUgdGVzdGluZyB0aGUga2VybmVsIHdpdGggdGhlIEtlcm5lbENJIGdlbmVyYXRlZCByb290ZnMu
DQpUaGlzIG1ha2VzIHRoaW5ncyBhIGxpdHRsZSBlYXNpZXIgYXMgdGhleSB3aWxsIHNvcnQgb3V0
IGFueSB0ZXN0IGRlcGVuZGVuY2llcy4NCg0KV2UgY2FuIHN3aXRjaCB0byB1c2luZyBjaXAtY29y
ZSBpZiBpdCBicmluZ3MgYmVuZWZpdCwgYnV0IGlmIGNpcC1jb3JlIGlzIGJlaW5nIHRlc3RlZCBp
bmRlcGVuZGVudGx5IGFscmVhZHksIG1heWJlIHdlIGRvbid0IG5lZWQgaXQgZm9yIGtlcm5lbCB0
ZXN0aW5nPw0KDQo+IA0KPiBGaW5hbGx5LCB3ZSBhcmUgYnVpbGRpbmcgdGhvc2Uga2VybmVsY2kg
aW1hZ2VzIGFuZCBhbHNvIHRlc3QgaW1hZ2VzIGZvcg0KPiBoYXJkd2FyZSBhbmQgbm8ta2VybmVs
IHFlbXUgaW1hZ2VzIGZvciBvdXIgb3duIGxhdmEgbGFiLCByaWdodD8gRG8gd2UNCg0KVEJIIEkn
bSBub3Qgc3VyZSB3aGF0IHRoZSBuby1rZXJuZWwgaW1hZ2VzIGFyZSBiZWluZyB1c2VkIGZvci4N
Cg0KPiBuZWVkIHRoZW0gYWxsIGluIHRoZSBwaXBlbGluZSBbM10/IElmIHdlIGNhbid0IGNvbnNv
bGlkYXRlIGV4dGVuc2lvbg0KPiB2YXJpYW50cywgZG8gd2UgbmVlZCB0byBidWlsZCB0aGVtIGZv
ciBhbGwgYXJjaHM/IEknbSBqdXN0IGxvb2tpbmcgZm9yDQo+IHdheXMgdG8gcmVkdWNlIG91ciB0
ZXN0IG1hdHJpeCB3aGVyZSBwb3NzaWJsZS4gSXQncyBncm93aW5nDQo+IGF1dG9tYXRpY2FsbHks
IHNocmlua2luZyBpdCBhZ2FpbiBpcyB0aGUgdHJpY2t5IHRoaW5nIDopLg0KDQpQbGVhc2UgZmVl
bCBmcmVlIHRvIHJlbW92ZSB0aGUga2VybmVsY2kgaW1hZ2VzLiANCg0KS2luZCByZWdhcmRzLCBD
aHJpcw0KDQo+IA0KPiBKYW4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXBy
b2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tDQo+IC9jb21taXQvN2I2MmVkMjM0MmE0NTZm
ZDgyMWRhZmE2MzFiYmY5NmVmZmEyZDY0OQ0KPiBbMl0NCj4gaHR0cHM6Ly9naXRsYWIuY29tL2Np
cC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLQ0KPiAvY29tbWl0LzljMmNkOGQ5YmVj
MjBjZTMyZWNlZDU0MjkzZGE3N2I4YzIzZmNlMjcNCj4gWzNdDQo+IGh0dHBzOi8vZ2l0bGFiLmNv
bS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0NCj4gL2Jsb2IvbWFzdGVyLy5n
aXRsYWItY2kueW1sP3JlZl90eXBlPWhlYWRzLA0KPiBidWlsZDoqLWtlcm5lbGNpIHZzLiBidWls
ZDoqLXRlc3QgdnMuIGJ1aWxkOiotdGVzdC1ub2tlcm5lbA0KPiANCj4gLS0NCj4gU2llbWVucyBB
RywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg==

