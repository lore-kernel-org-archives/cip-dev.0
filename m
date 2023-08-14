Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F328C001DB
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:54:13 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.79])
 by mx.groups.io with SMTP id smtpd.web11.105462.1692014047858157895
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:54:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I5DplLx0;
 spf=pass (domain: siemens.com, ip: 40.107.8.79, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWoxh016sRgvxEKPt0PRyxgDEzXKuCJMTfCSSGzwcm0NmWit1rDXZEaUljq1d/xEAAmRmprAB0eGFDkHMvTMWZbdQq7S1Rsybja8Akvk/Df5sGp2DvgvSPxJ+q9mQiVtw+r3hA6FkjAmW5UFSMEPjghfT5AI38u/b6+BRd5leBOIo9VE0dn8g/C7cAAS4CAsJM4ixw3yGyW+5lnn4IcbfK9g74K1roMcAm2oBkP65Vc9VttQuzNnZuv7KuHzSXC7bZq+ZFrlMWNuS/olG/PIE/pVrdMuVg7cUe4K9AKp4m+NGf6IoOqy7hM6fBiz6c2UmK+fOkp/BmVrvUtWePFODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9pOYEHGrjjizPfYYQ8tD9j6iesRVFzXFwApwKp4azQ=;
 b=cMlwf31DUv5F3J4EdTRty4thuwwM4GVHBMlobD18Yx1p8oibSbgdDFHf7HVp9fTgsTOw+OQK+oJRDhv5g1/GNqnRPGFAEhTIVgflzzr4aQhWbA9Ksgh8CCkMBVbUHbcuS0LJtTPvBxA/q+BIHl6Zr5cVlo9hothH3XeZspq5StTZDXTkFKr/URsyaAZL0dSD2BGwwlExiqM96ZBO1x7pD7dB3nX+lt7iE4+p6HqtCiKabrsoAxZ5RY/gz24nvgMc/Yw3moQG0jeVaJU24RXgv37xH2sQUPJrOn3eCIK/qS27Th8W8kEUxUoRvPc40+gUCMXPchV0EGlLqKn9Xa3BFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9pOYEHGrjjizPfYYQ8tD9j6iesRVFzXFwApwKp4azQ=;
 b=I5DplLx0c2OYQsfuIsrRlZuPeQ4IqmTS2QsEoXlolhW1z3EeBQGhY2kt5+cq1OJYOyy9vbGgp/OffdojGm+5gEGfyu75MeQzl7wwRGqrNegDk7ezkBJMc6wiQK4bTNoq92N78fQbfQ/Lv2rlJC3OpL7FUOot2gWnAirRKlZtlzs4xC66eXAFk+DZr27lsZO31+s2qEY7/CdqwJW4oiOyAp7e7cT4Yos5TXoXLpVAdMxkbtMPBVUCs8KFDIlvZcLBZhBstXcYuD3xkqvhBsmdHO0gdxDoVsQ4URjnxpmOVKKpdUmhJHmuV+5szdHqZ2hZzjVsGxLlmOWm5Pt1RmCmug==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS2PR10MB6975.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:578::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:54:04 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:54:04 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Thread-Index: 
 AQHZwWCHFkOweebVN0+CPtd6o803+a/jalIAgAALhwCAAa0MgIAEnlOAgAAE/oCAAAJ0AIAAAJ+A
Date: Mon, 14 Aug 2023 11:54:03 +0000
Message-ID: <cce2b43a574581a1b1fda9aed3dd124b34772edf.camel@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
	 <20230728143320.3891194-4-stefan-koch@siemens.com>
	 <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
	 <a49cdd53-e2b9-52c3-ac40-b11264952b28@siemens.com>
	 <e27c652d-f203-483f-bc7b-1b994f3d4e7c@siemens.com>
	 <9443dd8ff4eb0bb72c28c99f62d71c341d6f958a.camel@siemens.com>
	 <6ec810bf-51d6-4ede-9c31-027e8da203f4@siemens.com>
	 <002682c4-d856-69bf-de30-9ce7fc85231b@siemens.com>
In-Reply-To: <002682c4-d856-69bf-de30-9ce7fc85231b@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AS2PR10MB6975:EE_
x-ms-office365-filtering-correlation-id: 7412f812-3587-4193-446b-08db9cbd2831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6zY22n4PfHPgoSwa1V+0USUqTvHG7wd6M9v2pIwVan9HX6YYdP2uPw2ISoMgIyck8NxNF93llnUEsgOp7n2f90ELt2NHMHTTDWaxAH1/hAaA91L7263l8+IvlBsPnh/gwdU/jTuSK73q6d37u1WkBV4u1RZymAwVqkjWbnYSCjHBOMAR+mCFiZSS1FK0yn86HG1ab2tJsdDSVhM4zJCsHEjhf3kzerjFHVfq7G9pfMaITzMmxh0NfFr65BOy8NyizuqAzO7U4hFW61EnBqkDzmPtNfIGwkMcFrzTpmTOT+vIpLx5/CXUBYzvgQ5qPMXiMFfYpCKtJZx5bbjesAvKEcIs1QA7+WD02He5ft1GDumz28w6Zf0G0fCkwUoX2DZNRI2yiFm1mQcYeTXf07emR2uCL1L7pe/P4DeIlUq/7U57KX3CyWv02NTsRtzAH1KFf16x6yXP3rHF+72g6L//Z6w74kAWo5sinqD1aSNo676TzsV2qHuNGydTQqm5f4g54aH7Qv8kro9QhS59MUxidR1eVzDOc3wpbirvj8xANmE24B7ygmGKktel5Dou+IlKqRJlo+UvCnOw0Mc/26wIA2Wum5GNl5ami2ITj5AWOkkcUM5FNm85THzT7cjjKavJx8aDJrE7vGTtXVoOo4lS6g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(366004)(346002)(186006)(451199021)(1800799006)(66946007)(66556008)(64756008)(66476007)(66446008)(76116006)(91956017)(6636002)(316002)(110136005)(41300700001)(54906003)(8936002)(8676002)(5660300002)(478600001)(71200400001)(2906002)(6486002)(53546011)(6512007)(6506007)(107886003)(83380400001)(2616005)(26005)(4326008)(82960400001)(38070700005)(122000001)(38100700002)(86362001)(15974865002)(36756003)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UzZYL1dEZUJUNUpnKzZDVkYvcnltcWpDWnNIMCtMRjc1d3UvRGxuU2RNckFQ?=
 =?utf-8?B?alRmTnNmT3gyNW9SRmRGLzB6a3Z0ZGZRODFKYUZucFpxVzQrOWFmNWdyTEpD?=
 =?utf-8?B?ZEMwc1Jrc3poRk9rbERnZ3FZb2J1TUhWaG1KbmJ6cHhEZm9Hb0VJeUtZREJ6?=
 =?utf-8?B?MFRBRXlMLzNabFVEdlo4STJrQnQ1Rld4MTMzYTE0OG5rdFhCVjhSMEZUQ2Qw?=
 =?utf-8?B?RjJ3SUdyVGUxdUFYdjlxekEycEpHQnhvN2NxU2J2WGlydzJ3OGk0ZmlOSFQr?=
 =?utf-8?B?RHE5YWsrNkQ1dkpxQ0JrSTBqWVJGN1pmWFhWbGRVSkcrN1RkTERrSThiSU43?=
 =?utf-8?B?QjBQWXY3MDVGVDBYemY3emo5c0tuSTRzYmVnbWhaT1BwbFZlZ0ZMSUoreHR4?=
 =?utf-8?B?VytrNmttZGZ6NlNTTXJsQVNHd0hjamRZaWhTbVNQdjBCUXFnQ3pwbE5JenVo?=
 =?utf-8?B?TjRxaGZJcVN6akFQeE9rTDdudURqL3FQaDl2czg3MnpBRVhPT3NEakQzY2hR?=
 =?utf-8?B?MHdtM3VNYktwQVBzV2UwNjFBYXNHN2w5a09YS2pSMlp2cE11ejJyR2g5TGlU?=
 =?utf-8?B?UTlrVDJ4dXVaWkdheG04Ym1aUno5QWZsK0p6UGJwSmY1MGo1VzBaM001elJa?=
 =?utf-8?B?K3FLTUdMK0JIaklyWWVsc25NMzhsYVNJcjV6cjdvVm1FekRjb21nVWhBWEty?=
 =?utf-8?B?VTA0SUN6dW44RnVjbldHWTZvajd4VVRxQ1QyRkZnRkdUR254RE9tS2tLR29F?=
 =?utf-8?B?b21KY3FtMG5UOTZDOUR2T0sxOWVPcGx6TDJGaFBBV0ppcU5tdG1vbjRkSW8v?=
 =?utf-8?B?KzIvQjFzcnpLWExIQWxyOFgyWGJ0SEhHUWdTcEhNL1Y0Vjg1ZXh2ckgxWGtF?=
 =?utf-8?B?Y2hibWpVYnQ1VmRveFM4WFpXMmM4RWp5Mnc0bWVXTWR3TU1NK1p3RmpkTlYw?=
 =?utf-8?B?THZWRi8zdVpPQTFhN3dsMjBLOHZaYXNtaTBYam10eVFENjB3cnFUT2JDcXBC?=
 =?utf-8?B?NFBsZWEvekRpNFlmR041OGl3OVZoR1BuekowSTZkVjVPSDFDVFJJUjNkOE1P?=
 =?utf-8?B?UDNhUmpTQ1AvNVZmVUtaL2lZdzduWGVQL2xoMW9jV3pwWm9JTWlkUldGSk44?=
 =?utf-8?B?Z0tSeHNYdUtGeE5KVkcwM3VZZ3FrZEVXNld3NHQ1Z2lUd1UyWWJlTGtNQXQ3?=
 =?utf-8?B?Nm4wNFk2UURCcDcyZ0dTbWxmVytJTzA2VDRvTFQvWEFtM1BaaEdheFJZZXY4?=
 =?utf-8?B?ZzB5ZFhPZ0xtUWRucmlzUU9kcUIwYVErUkxpYzV2Y2o4R1VISGNPNUpEY0lG?=
 =?utf-8?B?VTVnWW1kNEY5L0xNVERpN2diSUFGM2Q2WW9abkl1Zk84LzdSRHVZUWhRTHlQ?=
 =?utf-8?B?Nkc3RDJIUEFDczJTcmlVNWpkRDZKbVZNMWNxbnZ0cGpJbXZkbjkxTEtIM0NS?=
 =?utf-8?B?cGxjajdkdHMwc2xJSUp3TDcxQ1JyaitkNHNjMktKUHRkc1l4RWZMY1MyTlJF?=
 =?utf-8?B?enFucFNZNFlraXJEQWRtUWgrTWVYNTJ1VkdPMElqZmlOazNRcDE1V0FvcEg2?=
 =?utf-8?B?YjZlYTg2K1l6dWI5Z045MXdVTVIyVzJHcUFBL1JZdzNEUmpBK3ZGUmJiTTRi?=
 =?utf-8?B?eHZ4UzE5NGxjSVJaekNKOWlnR2E0WmpEcUoxZWhNSnU4eWRkaGxGM3JzeHJp?=
 =?utf-8?B?YXAvT3Z5bHBGcDFOdUszK3JnU1YyTWxicUpMdExjbVNMYlhsMFFGT1M5Ym5r?=
 =?utf-8?B?QnZla0ExaGlUalBRamN6SEw1Zkc1S1VDUWhxTUpzTmdyaHJza1dScDN1YjZa?=
 =?utf-8?B?Y0E4VFk5SmJrL2NTSHcxQkJHSHNkUHpTcWRQYVgyckNDVkFzaEpPZUUzNEdt?=
 =?utf-8?B?R0ZuZXNZa25zaEpGbHFWVEltcnc3Q2QwZUM0RnVlK1BlMWJ3MC9oOGdQeElp?=
 =?utf-8?B?dUhMcVZnbkVYSk8xM0JoZllPWDA2bG9yRWZRbVFxUkwwQjFGZ3RTT1FtR3lj?=
 =?utf-8?B?aEk1K2dabFhPUjFaeGliZE4reHJ6UXJGc09oODJ0d1hzWWFCYll6UDA3WlFL?=
 =?utf-8?B?a3VSdjBUb0o4Q1M1UWZYRVM1enNWbUcxVWJxeHAyRjZaaEZpY0dTOGEvRzVi?=
 =?utf-8?B?Y0tjekdvdnE1TklGbmU3NVhRZEw2bzJPOVVpay9ya01DZWlkZGRCdjhxOHRz?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCC1D09E6F1A1E409E44D9FDE38C8FA1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7412f812-3587-4193-446b-08db9cbd2831
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 11:54:03.9534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EU0t74fW7eAc0QNei1X3kqdvja/Je1BF5qou5+vX/ypCGAfbUONXrAtntKcJidVLKR/DuzfYo5A4o2RfCNDgEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6975
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12646

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDEzOjUxICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDgvMTQvMjMgMTM6NDMsIEphbiBLaXN6a2Egd3JvdGU6DQo+ID4gT24g
MTQuMDguMjMgMTM6MjUsIEtvY2gsIFN0ZWZhbiAoREkgUEEgRENQIFImRCAzKSB3cm90ZToNCj4g
PiA+IE9uIEZyaSwgMjAyMy0wOC0xMSBhdCAxNDo1MyArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToN
Cj4gPiA+ID4gT24gMTAuMDguMjMgMTM6MTcsIEd5bHN0b3JmZiBRdWlyaW4gd3JvdGU6DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gOC8xMC8yMyAxMjozNiwgSmFuIEtpc3pr
YSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gMjguMDcu
MjMgMTY6MzMsIEtvY2gsIFN0ZWZhbiAoREkgUEEgRENQIFImRCAzKSB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gVGhlIHRpbnkgbWtlMmZzIGRvZXMgbm90IHN1cHBvcnQgdGhlIHVzZWQgLXQgb3B0aW9u
Lg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEtv
Y2ggPHN0ZWZhbi1rb2NoQHNpZW1lbnMuY29tPg0KPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4g
PiA+ID4gwqDCoCAuLi4vaW5pdHJhbWZzLWNyeXB0LQ0KPiA+ID4gPiA+ID4gPiBob29rL2ZpbGVz
L2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuc2NyaXB0IHwgMiArLQ0KPiA+ID4gPiA+ID4gPiDC
oMKgIC4uLi9pbml0cmFtZnMtY3J5cHQtaG9vay9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+ID4g
PiA+IGhvb2tfMC4xLmJiwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gPiA+ID4gPiA+
ID4gwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gPiA+ID4g
YS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+ID4gPiA+IGhvb2sv
ZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc3lzdGVtZC5zY3JpcHQgYi9yZWNpcGVzLQ0KPiA+ID4g
PiA+ID4gPiBpbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiA+ID4gPiA+ID4gPiBob29rL2Zp
bGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuc2NyaXB0DQo+ID4gPiA+ID4gPiA+IGluZGV4
IGIzMmIyZjIuLjRlMDRkMzcgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4g
PiBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiA+ID4gPiA+ID4gaG9v
ay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLnNjcmlwdA0KPiA+ID4gPiA+ID4gPiAr
KysNCj4gPiA+ID4gPiA+ID4gYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+
ID4gPiA+ID4gPiA+IGhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc3lzdGVtZC5zY3JpcHQN
Cj4gPiA+ID4gPiA+ID4gQEAgLTQyLDcgKzQyLDcgQEAgcGFydGl0aW9uX3NldHM9IiRQQVJUSVRJ
T05TIg0KPiA+ID4gPiA+ID4gPiDCoMKgIGNyZWF0ZV9maWxlX3N5c3RlbV9jbWQ9IiRDUkVBVEVf
RklMRV9TWVNURU1fQ01EIg0KPiA+ID4gPiA+ID4gPiDCoMKgIMKgIGlmIFsgLXogIiR7Y3JlYXRl
X2ZpbGVfc3lzdGVtX2NtZH0iIF07IHRoZW4NCj4gPiA+ID4gPiA+ID4gLcKgwqDCoCBjcmVhdGVf
ZmlsZV9zeXN0ZW1fY21kPSJta2UyZnMgLXQgZXh0NCINCj4gPiA+ID4gPiA+ID4gK8KgwqDCoCBj
cmVhdGVfZmlsZV9zeXN0ZW1fY21kPSIvdXNyL3NiaW4vbWtlMmZzIg0KPiA+ID4gPiANCj4gPiA+
ID4gVGhpcyBpcyBub3QgY29ycmVjdC4NCj4gPiA+IA0KPiA+ID4gT29wcy4uLiBQYXJhbXMgbG9z
dCA6KCBUaGVuIGRlZmF1bHQgc2hvdWxkIGJlIGV4dDIuDQo+ID4gPiANCj4gPiA+IEJ1dCB0aGXC
oGNvbmRpdGlvbg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIFsgLXogIiR7Y3JlYXRlX2ZpbGVf
c3lzdGVtX2NtZH0iIF07IHRoZW4NCj4gPiA+IA0KPiA+ID4gaXMgbmV2ZXIgdHJ1ZSwgYmVjYXVz
ZSBvZiAiPz89IiBpbiB0aGUgaW5pdHJhbWZzLWNyeXB0LQ0KPiA+ID4gaG9va18wLjEuYmINCj4g
PiA+IGZpbGU6DQo+ID4gPiBDUllQVF9DUkVBVEVfRklMRV9TWVNURU1fQ01EID8/PSAiL3Vzci9z
YmluL21rZTJmcyAtdCBleHQ0Ig0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiDCoMKg
IGZpDQo+ID4gPiA+ID4gPiA+IMKgwqAgwqAgc2VydmljZV93YXRjaGRvZygpIHsNCj4gPiA+ID4g
PiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiA+ID4gPiBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRy
YW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy1jcnlwdC0NCj4gPiA+ID4gPiA+ID4gaG9va18wLjEu
YmINCj4gPiA+ID4gPiA+ID4gYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9v
ay9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+ID4gPiA+IGhvb2tfMC4xLmJiDQo+ID4gPiA+ID4g
PiA+IGluZGV4IDFjMWJmM2QuLjNjM2Y2YmIgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+IC0tLSBhL3Jl
Y2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy0NCj4gPiA+ID4g
PiA+ID4gY3J5cHQtDQo+ID4gPiA+ID4gPiA+IGhvb2tfMC4xLmJiDQo+ID4gPiA+ID4gPiA+ICsr
KyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy0NCj4g
PiA+ID4gPiA+ID4gY3J5cHQtDQo+ID4gPiA+ID4gPiA+IGhvb2tfMC4xLmJiDQo+ID4gPiA+ID4g
PiA+IEBAIC0zMiw3ICszMiw3IEBAIFNSQ19VUkkgKz0NCj4gPiA+ID4gPiA+ID4gImZpbGU6Ly9l
bmNyeXB0X3BhcnRpdGlvbi5lbnYudG1wbMKgXA0KPiA+ID4gPiA+ID4gPiDCoMKgIENSWVBUX1BB
UlRJVElPTlMgPz89ICJob21lOi9ob21lOnJlZW5jcnlwdA0KPiA+ID4gPiA+ID4gPiB2YXI6L3Zh
cjpyZWVuY3J5cHQiDQo+ID4gPiA+ID4gPiA+IMKgwqAgIyBDUllQVF9DUkVBVEVfRklMRV9TWVNU
RU1fQ01EIGNvbnRhaW5zIHRoZSBzaGVsbA0KPiA+ID4gPiA+ID4gPiBjb21tYW5kIHRvDQo+ID4g
PiA+ID4gPiA+IGNyZWF0ZQ0KPiA+ID4gPiA+ID4gPiB0aGUgZmlsZXN5c3RlbQ0KPiA+ID4gPiA+
ID4gPiDCoMKgICMgaW4gYSBuZXdseSBmb3JtYXR0ZWQgTFVLUyBQYXJ0aXRpb24NCj4gPiA+ID4g
PiA+ID4gLUNSWVBUX0NSRUFURV9GSUxFX1NZU1RFTV9DTUQgPz89ICJta2UyZnMgLXQgZXh0NCIN
Cj4gPiA+ID4gPiA+ID4gK0NSWVBUX0NSRUFURV9GSUxFX1NZU1RFTV9DTUQgPz89ICIvdXNyL3Ni
aW4vbWtlMmZzIC10DQo+ID4gPiA+ID4gPiA+IGV4dDQiDQo+ID4gPiA+ID4gPiA+IMKgwqAgIyBU
aW1lb3V0IGZvciBjcmVhdGluZyAvIHJlLWVuY3J5cHRpbmcgcGFydGl0aW9ucyBvbg0KPiA+ID4g
PiA+ID4gPiBmaXJzdA0KPiA+ID4gPiA+ID4gPiBib290DQo+ID4gPiA+ID4gPiA+IMKgwqAgQ1JZ
UFRfU0VUVVBfVElNRU9VVCA/Pz0gIjYwMCINCj4gPiA+ID4gPiA+ID4gwqDCoCAjIFdhdGNoZG9n
IHRvIHNlcnZpY2UgZHVyaW5nIHRoZSBpbml0aWFsIHNldHVwIG9mIHRoZQ0KPiA+ID4gPiA+ID4g
PiBjcnlwdG8NCj4gPiA+ID4gPiA+ID4gcGFydGl0aW9ucw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBEbyB3ZSBoYXZlIGJvdGggYWxyZWFkeT8gQWxzbyBpbiBjYXNlIG9mIHRoZSBpc2FyLWNp
cC1jb3JlDQo+ID4gPiA+ID4gPiBnZW5lcmF0ZWQNCj4gPiA+ID4gPiA+IGltYWdlcywgb3Igb25s
eSB3aXRoIGFkZGl0aW9uYWwgY3VzdG9taXphdGlvbnMgb2YgdGhlDQo+ID4gPiA+ID4gPiBpbml0
cmFtZnM/DQo+ID4gPiA+ID4gPiBKdXN0IHRvDQo+ID4gPiA+ID4gPiB1bmRlcnN0YW5kIHdoZW4g
dGhpcyBpc3N1ZSBpcyBjdXJyZW50bHkgdmlzaWJsZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBj
aXAtY29yZSBkb2VzIG5vdCBpbmNsdWRlIGJ1c3lib3ggaW4gdGhlIGluaXRyYW1mcyAtDQo+ID4g
PiA+ID4gdGhlcmVmb3JlIHRoaXMNCj4gPiA+ID4gPiB3YXMNCj4gPiA+ID4gPiBvdmVybG9va2Vk
Lg0KPiA+ID4gPiANCj4gPiA+ID4gT2ssIHNvIHRoZSBwYXRoIHNob3VsZCBiZSBhZGp1c3RlZC4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEJ1dCBub3cgSSdtIHdvbmRlcmluZyB3aHkgdG8gc3BvdHMgaGF2
ZSB0byBiZSBjaGFuZ2VkLiBUaGUNCj4gPiA+ID4gc2NyaXB0DQo+ID4gPiA+IGNoZWNrcw0KPiA+
ID4gPiBmb3IgY3JlYXRlX2ZpbGVfc3lzdGVtX2NtZCwgbWVhbnMgQ1JZUFRfQ1JFQVRFX0ZJTEVf
U1lTVEVNX0NNRCwNCj4gPiA+ID4gYmVpbmcNCj4gPiA+ID4gemVybyBhbmQgZmFsbHMgYmFjayB0
byB0aGUgc3RhbmRhcmQgY3JlYXRpb24uIEJ1dCB0aGVuIHdlIGhhdmUNCj4gPiA+ID4gdGhlDQo+
ID4gPiA+IHN0YW5kYXJkIGNvbW1hbmQgYWxzbyBpbiB0aGUgcmVjaXBlLiBPbmUgc2hvdWxkIGdv
LCBhbHNvIHRvDQo+ID4gPiA+IGF2b2lkDQo+ID4gPiA+IG1pc3Rha2VzIGxpa2UgZG9uZSBieSB0
aGlzIHBhdGNoLg0KPiA+ID4gDQo+ID4gPiBTaG91bGQgd2UganVzdCBkZWxldGUgdGhlIGNvbmRp
dGlvbiBhYm92ZSB3aXRoaW4NCj4gPiA+IGVuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuc2NyaXB0
IC0gc2luY2UgdGhlIGRlZmF1bHQgdmFsdWUgaXMNCj4gPiA+IGFsd2F5cw0KPiA+ID4gc2V0PyBP
ciBhcmUgdGhlciBjYXNlcywgdGhhdCBkbyBub3QgdXNlIHRoZSBpbml0cmFtZnMtY3J5cHQtDQo+
ID4gPiBob29rXzAuMS5iYg0KPiA+ID4gYW5kIGJyaW5nIGluIG93biBjdXN0b21pemF0aW9ucyB0
aGF0IG1pZ2h0IGZhaWwgYWZ0ZXIgZHJvcHBpbmcNCj4gPiA+IGl0Pw0KPiA+ID4gDQo+ID4gDQo+
ID4gSSdtIGluY2xpbmVkIHRvIGRlbGV0ZSB0aGUgc2NyaXB0IHRlc3QsIGdpdmVuIHRoYXQgd2Ug
aGF2ZSBhDQo+ID4gZGVmYXVsdCB2aWENCj4gPiB0aGUgdmFyaWFibGUuIE9yIHdoYXQgd2FzIHRo
ZSBpZGVhIGJlaGluZCB0aGF0LCBRdWlyaW4/DQo+IA0KPiBUaGUgc2NyaXB0IHRlc3QgY2FuIGJl
IGRlbGV0ZWQgLSBJdCB3YXMgbW9yZSBvciBsZXNzIGEgZmFsbGJhY2sNCj4gZHVyaW5nIA0KPiBk
ZXZlbG9wbWVudC4NCkknbGwgdXBkYXRlIHRoYXQgc2luZ2xlIHBhdGNoIGFuZCByZXNlbmQgaXQu
DQo+IA0KPiBRdWlyaW4NCg0KLS0gDQpTdGVmYW4gS29jaA0KU2llbWVucyBBRw0Kd3d3LnNpZW1l
bnMuY29tDQo=

