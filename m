Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E81CF11CE
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 10:44:08 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.62])
 by mx.groups.io with SMTP id smtpd.web11.40344.1728557040993459281
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Oct 2024 03:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=dfgm8amw;
 spf=pass (domain: renesas.com, ip: 40.107.74.62, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4u0aRhxRG523BlKyskUjpwszzg3hVafCxYjDVBHuXMTCYW0kjOIWU3hlFblzw7iwqDx7YeTqPLm/rFkJSq6eeR8+jeNicIrRofqdpezch4nGKFLW19O46L8SIHQ4c9EZDxo8S3QmVsep2428eyV5PgPYgx+ttzdlpMSxuZPPwYEmr8VnbSirI+2RvXwe8bsEnH/vCDXmI4YpsgOE6hp5FO31LgbH69rnvWZnl10dJg9NC/zJAqralNG6UwAIfxLdKMAY24Y9k2XLEZiUmX3F32/f5p2LGK3wxB2IyBR9/VFf7KlJfYnXJPAOwf8Saq/PK57IovjpDQJcD4/I7jDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO9ikiyzAykyGqmiIv3bfOnEkg9BSrBzdEny29T+S1I=;
 b=B/m6ucGdNFuNCsIl5olaZwc7BfyTaiQZtexsCVvfGQWT8cLlajz5Ai8Nn/H1Rim3n5EPiE5jmAOute7j2om0pGtKh0Avfczs3U14cd0SVpJXE2+LZytkKcl0wz9sxxQH27fUJzTP3+EWqL9VIl0yYI+cGY4VqFfqhf3D6shUk7Vfsn47SAEY+fKkWLqhJKRlX99CVcFsoIZkWiIx4GgMMv9e5MPdc5S0zBNjUeTAmyxJd3DWPTNARx6qaJNo97iHS/cqojbeBLObBryZHUfKS3UE+bZqSMC/qcgLmt/bfEEzcHcMXqZ8tQqtN0LPcMjY+S6EFidErcWunDc1zEWGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO9ikiyzAykyGqmiIv3bfOnEkg9BSrBzdEny29T+S1I=;
 b=dfgm8amwlYHIUtm+yluK6art3eedTh0OkzQ6gE0yrbP97QofLHQmD3ubEIr5CWdrpeRJDKNNqedHvMYo9a+CE7QxyZDSkBgLPSocFukT+7SclE7dszVMRHREbMK6eyrkQfXKLSzuvQfQvFQ8xBpAi/ZtPIDy0cyYx9jR/8RrcqQ=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TYCPR01MB6835.jpnprd01.prod.outlook.com
 (2603:1096:400:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 10:43:56 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 10:43:56 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHbGuQyMCVPJJ0FfEaNaYYVNbLPjrJ/zGHg
Date: Thu, 10 Oct 2024 10:43:56 +0000
Message-ID: 
 <OS9PR01MB123898FA611F6D7502000193BB7782@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <114a7d54-edf6-482f-a5de-434108c27174@siemens.com>
In-Reply-To: <114a7d54-edf6-482f-a5de-434108c27174@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TYCPR01MB6835:EE_
x-ms-office365-filtering-correlation-id: 8cde0598-175f-4e4e-8283-08dce918713c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?b1N3SWVwR2loZVVHSkorT01DYWVoWmxEWEQwNEgrWHowVkozYm9QeUphaDhR?=
 =?utf-8?B?dUlBVDNOUTZrMDJLZU5oNDZQQWNEQ1J6N0RsSFpCek5HbHU4NHNiVW1ZeS8w?=
 =?utf-8?B?RHRqNCtvOXhOMGxYckNnS0g2VnNTcCtIU1AxeXJoVXZuREUyVlN4YW5oVHMw?=
 =?utf-8?B?RGVpc1pYMkVtMTNPWUpEazFiRS8vWW5CUEZleGQwU1hBY3c3bXk2Y0NXazAv?=
 =?utf-8?B?SXVhMmxVV2dkeUhOQmJ3cS9sN3BSb2NYVm5pcS9zeGFMbExhQlN6QVdxcWNo?=
 =?utf-8?B?NUpHUUhNUTBzWUNTRTRhdDF5clVsL1RoZFF1SmxjeVBuaGNKMnlSa25may9N?=
 =?utf-8?B?MW5YZ3EyT3NzWHZMYXh0NzlmWHZtbENmNndnbFhvR1Y4cWwxYXBJNlVKb0JS?=
 =?utf-8?B?Y2Nzd2ZMaGRRUkV1eTE5eTFnK25qa0tnSmo0WTBoNFFhTE0vZUw0ZEZ5d3Ro?=
 =?utf-8?B?Ui9ZeWZaZUVSS3hVSVk5SHBWNnZ3ckdZWEJCcmlPZklDNFNBbU9tYjJVQmN0?=
 =?utf-8?B?OWV3NFJtYVI5ZUMyZVVyZ3VUejRrRkY4akVIUHlqaTBaMVRPWHdOMXlDelFh?=
 =?utf-8?B?bStVcndlS3lsaEJYZyttMGg1QUdxWnZacWFaRHBjc0ZjZ2t1TWZiNDJ2cTly?=
 =?utf-8?B?TjlXL0lSMFgwTXhWMnhmeGcrZjlidTYvSmkycFMxSnQxSUdkbmd0L3BhdnhW?=
 =?utf-8?B?NEtCWjJsL0pYajdHaEhaYUVEcDlHbHNXRDhLeGJJWmtpcVg3VVg2c3N4NzFB?=
 =?utf-8?B?Uk5wcUhObmFwVG5mVVBXUysrSStUZld3SHk2WUZPN0NqY1I2a0NEdmtYenhx?=
 =?utf-8?B?bkpQcnZwL0k0THVoNGpPWHdlZjlEWEtITUtOLzhQYUN1b0dWRVluUi9tUENo?=
 =?utf-8?B?RFlkZHJJVG1MZGF3M2gyQXdKZmZ6amJ5M0NoYVh3Slh6MER6dU52Vkk1L0t4?=
 =?utf-8?B?eXpoaVEvRElTR2ZhdFZkbGpuSlFkajRPWXZtVStlZ2RZckhBSmFhb3ExZTNV?=
 =?utf-8?B?Uzd2TFlFa1kwWU53cElrdW1xcUlCM2JCeloybythdktWNjVFR3dXUG14V3Bt?=
 =?utf-8?B?NU5wY3RpTGZrZFlyTi95UVNTT1Z6M05JdHBWdDAvNmdKWjNMN09yc3JDLzMz?=
 =?utf-8?B?emozbHFQaitzU08yZ204dUhGVW8zTEpWMnE2dWtKTW1CdjlScy8zN3hzMnhT?=
 =?utf-8?B?bjc3Uy90eXF4a3ptWlBkTmpCMUNKT3RnRTVObVdidll6N3ZxYlZBQ3FzdTFp?=
 =?utf-8?B?aWkzYTdJMmVVdmJkK0dydzMyV2pMaUQ5SjA0Z0twdkFURjVLYTN5bnZXME5j?=
 =?utf-8?B?MGhMTUk2RW1LTVBDYm91STlhM2JndWs2Ti9XWjVvcU1GUnpXWGgxazVGSzhr?=
 =?utf-8?B?MG9BRjgyK0ZzZzJlbDNKRldYcU93NU1nOGdMenhUak5HTS9MVUFjMFdaZmg4?=
 =?utf-8?B?cEFwckxZV0Q5RDNKSVRkOFpPWkpmbGVZL0FPd3U2c2VpVW1zME1EZC9LY2RU?=
 =?utf-8?B?NDYxMGNxTTljRXRLdFU5a0tKbTJUQjRPZzNWU2lOOEEyZ1RaSitEQ1hXYW5L?=
 =?utf-8?B?VWhVN2M1RzJNNVZiQ1NubVM3dkk3UzJJT0pvV25CeU9xaFdRT3N2TWo4dmhP?=
 =?utf-8?B?ZFZqV1dZZzJneEFoR3ptdUdWcG5NVVRBWFRYZ09uSGJUckZ5Mkk5LzNWeFlD?=
 =?utf-8?B?V0JBYzZEQng1Y0dvVmtuYm11ZGRuTXg1cDZDcjZ3VE9XbHNGbnRqTXNIUmZ1?=
 =?utf-8?Q?9njjOal3jnidpbbzCI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFFQZDFBTDJGc01saDFISDBUZXlYUCt4ZTdjM1VCeUFJVWF2TzNYeFBseHJ0?=
 =?utf-8?B?N1o2WEU0b3NmTkNCM2dWVlNBMkZjZWNtcnZRUnplUFlveTZvNmFSTmxxNDBl?=
 =?utf-8?B?a3FyY2UxV085VXlPaHdxaWhydnRsTmpzWDhpVWRiTVNqaEVNaUc2cVdYOFpt?=
 =?utf-8?B?eVZaaGN2NTZxTFJLTlNGc2JvM2ZQZTQ1MTVwejVveVJOWFpVZ0QxdVozM2th?=
 =?utf-8?B?ZlgxbWprelJpRTZucHo2SENzY2ZMMFlPWXpzZ3VsM0NuYStIYzBSTm4wZ3Ri?=
 =?utf-8?B?OGVIbHltcEhZTytJZks0aGozU1RRVnZ6WDN6MEdpSHlvTU1GTXJPTzVpbEVp?=
 =?utf-8?B?dU9hd1laUFhueUdrdVhQVGFqeXBiMStnemRUYTRwcXlUc0krU1o3RjJqc2d3?=
 =?utf-8?B?eWhkTk9JWkJlcGZNS0RvNFNlaFNPK3piK1hieklOdUhwMFpRdStPU3dWNVky?=
 =?utf-8?B?dlVrcS9RVmhoWWlYZmxvcnFzdTN4MmhkRm51VlJpZFpSVmRRVUNLa0RpVUpn?=
 =?utf-8?B?V0w5RkduTDJLRldWeGk0SmplQWV0RWZlaHUvZ0c2Z1BCWHNuQnN4Yi9NNlpz?=
 =?utf-8?B?UUd6VzNVK05hMm0rQktVQjJIWC9pdGV5ZzNpd096YXJLanpLTDcvOFEzQU9S?=
 =?utf-8?B?elduRmtkTmQ4VVlLdVkrb1Y3VFR4dFNMSllxeG54ckhpdTVPZGV5SXhvQll1?=
 =?utf-8?B?U1NSVVZ6VWpLR1Z6Rnk4Z2FBNTlaV0VyRlRtNkdPc2xKVnY3VXRiejdSa1Qw?=
 =?utf-8?B?OFRXeDJReUFQaGVCeWEvOXhSVi9QUFJ0dWR4Wi84NEQvWkVRb0IyZUlUWTNC?=
 =?utf-8?B?Mis4cDNPQXpkMzgrTDdvUDNNdG1nUXZGR0JnMnNSNCtHSThoS3htQlpYZHNh?=
 =?utf-8?B?YXhHelRNRkQ4Z3djTlRLa0h5WmVhTkFmMldOSSs2Qk4zVDBza0ovMEJza0Nh?=
 =?utf-8?B?RlUrdjNwNnkwMzgwa3A4Vk1keEJSN0RPV1VmaDJHSURWZTVGSEZJazFEMnBi?=
 =?utf-8?B?NXM4d1ZLUDMydklrbE8xMy8xVXZPaGlsWWhaWTJqVDJjaE5VektBVjJIOVhS?=
 =?utf-8?B?dWxMNlVaOUc0UHlhWWN3aUt4NzdyODF0QVR0YUdRZ3lCMHJwczl0UDBGTVB2?=
 =?utf-8?B?Y2J6OFN4V3FzT1hXSzdlcGNoRXJYZURyaVM4VG01NlBBRFNBNEFBMzYzTTEv?=
 =?utf-8?B?VlQwaXZRbmRudzNGdGpmWmpnTnJlYU1wNFRibXludFlpYVExTUNYTXZxNS9J?=
 =?utf-8?B?QVkzY3h2TkxoSjIvSnRyZStPVTRSN3VwdUJmRHFOSGgyajJYVFR6dXcyUEVn?=
 =?utf-8?B?dmRYYXpnK244dFQrV2w1OFg3Q253ZG5zWTMweW1pZENXTWhPbnJxZnNOcDhP?=
 =?utf-8?B?V0dnNXRwOUQxRFhHbjlYMWJZYy9tNUxVUEoxeE54Um5EeVZreEZ0Rmp6RXda?=
 =?utf-8?B?NjZmMXJCNlhXZm9wY2ljcnEzdDZXMXM2MjQ3T3d3cThCMVkxaHROUW5obkht?=
 =?utf-8?B?U3FIcmRLcUYyUzlsT0ZvTlpraUpYZWMrdkVIeWdxcXc5L012SWVMM1Uxajhj?=
 =?utf-8?B?bStEMG9EUUNZa3ZPMm1jbC9xQm9lT0VQQlBFUUZwT3kvNE9vVmRjSjRMTzVa?=
 =?utf-8?B?cFNLbkJSeVIwV1Q0NFJoMEVtaDRwSVhYWHowZmxrM01yVSt3VkNUcnA0aUl5?=
 =?utf-8?B?SFQ0WVFnQ3hMemtJcHU5R1JYanozYmx2S1F3VTdhcWlTU2JBQ0puSnMrV3NK?=
 =?utf-8?B?dU9sT05FK09vaGZqUHY2NWZpNUZuUWVoRlBrbElpS09uU29wV3kvQ1k4R1p1?=
 =?utf-8?B?SlpxWExyZ25Na1M2VFJoZG1VRkx2ZVBZTW1HdFpIVmxjUWh6MndpQm85VGlX?=
 =?utf-8?B?eTF4SW4xTm52a2hnejI1elI2NWRmU3VwVktEMzFRaElhTCtRTHgycC9FWHBU?=
 =?utf-8?B?Z2hEM2dkWG5sbGVESlBGOG1tMWF2VEFhWEVpb2dhcTY2cnArb0JzckR2TjRX?=
 =?utf-8?B?R0d3R2poeE1BakNmQ28wWHhrM2hSSkd0c1NzMkpzbm9UbEZYNG9OS0ZpMHBC?=
 =?utf-8?B?bGxSdWs5THJKZXlyUHhnd0JHUVVxRUQ4QXpUWENaM0crTXBWOWF5cUs4R1p0?=
 =?utf-8?B?WThTZUVPNVBsRWs1c2EzdFdHd2EwMTRHT3Bwb1ZLcElDejF0d3dQbkR1VTl2?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cde0598-175f-4e4e-8283-08dce918713c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 10:43:56.7793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCGCHL16li3ax5+R/ckVVtzzYDAayzCKM8aEQftD3ZDxgMXZDwZMSDXffoSfnHbqAHQp8sIThyP1EGNN4FpxcxJ4hMkSABfdnYxcx1hSkOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Oct 2024 10:44:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17024

SGkgSmFuLA0KDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiAxMCBPY3RvYmVyIDIwMjQgMDg6MTUNCj4gDQo+
IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRlbmQgdGhlIHdlZWtseSBt
ZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MNCj4gdGVjaG5pY2FsIHRvcGljcyB3aXRoIENJ
UCBrZXJuZWwgdG9kYXkuIE91ciBjaGFubmVsIGlzIHRoZSBmb2xsb3dpbmc6DQoNClBsZWFzZSBh
Y2NlcHQgbXkgYXBvbG9naWVzIEkgd29uJ3QgYmUgYWJsZSB0byBtYWtlIHRoZSBtZWV0aW5nIHRv
ZGF5Lg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoNCg0KPiANCj4gICAgIGlyYzppcmMubGliZXJh
LmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBzY2hlZHVsZWQgdG8gVVRD
IChHTVQpIDEzOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xv
Y2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjQmbW9udGgNCj4gPTEwJmRheT0xMCZob3Vy
PTEzJm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0xNzkmcDM9MTM2JnA0PTM3JnA1PTI0MSZwNj0yNDgN
Cj4gDQo+IFVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAgIERFICAgICAgICBUVyAgICAgICAg
SlANCj4gMDY6MDAgICAgIDA5OjAwICAgICAxNDowMCAgICAgMTU6MDAgICAgIDIxOjAwICAgICAy
MjowMA0KPiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjYm90LndsLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWVldGluZ3MvY2lwLzIwMjQvMTAvY2lwLjIwMjQtMTAtMDMtDQo+
IDEzLjEzLmxvZy5odG1sDQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAgIC0gcHJlcGFyZSBibG9n
IGVudHJ5IG9uIFNMVFMga2VybmVsIHN0YXRlIGFuZCBjaGFsbGVuZ2VzIFtKYW5dDQo+ICogS2Vy
bmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCj4gKiBLZXJuZWwgcmVsZWFzZSBzdGF0dXMgWypdDQo+
ICogS2VybmVsIHRlc3RpbmcNCj4gKiBBT0INCj4gICAtIG1lZXRpbmcgaG9zdCBmb3IgMTAvMTcv
MjAyNA0KPiANCj4gSmFuDQo+IA0KPiBbKl0NCj4gbGludXgtNC40LnktY2lwOiBpbnRlcnZhbCAz
MCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFdlZCBPY3QgIDkgMDQ6MjM6
MzcgQU0gVVRDIDIwMjQNCj4gICBsaW1pdCBkYXRlOiBGcmkgTm92ICA4IDA0OjIzOjM3IEFNIFVU
QyAyMDI0DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC00LjQueS1jaXAtcnQ6IGludGVy
dmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIFNlcCAzMCAw
OTo0ODoyOCBBTSBVVEMgMjAyNA0KPiAgIGxpbWl0IGRhdGU6IEZyaSBOb3YgMjkgMDk6NDg6Mjgg
QU0gVVRDIDIwMjQNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuMTkueS1jaXA6IGlu
dGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVlIFNlcCAy
NCAwOTozMjozNyBBTSBVVEMgMjAyNA0KPiAgIGxpbWl0IGRhdGU6IFRodSBPY3QgMjQgMDk6MzI6
MzcgQU0gVVRDIDIwMjQNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuMTkueS1jaXAt
cnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVl
IFNlcCAyNCAxMDozNDowNCBBTSBVVEMgMjAyNA0KPiAgIGxpbWl0IGRhdGU6IFNhdCBOb3YgMjMg
MTA6MzQ6MDQgQU0gVVRDIDIwMjQNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTUuMTAu
eS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTog
V2VkIE9jdCAgOSAxMDo1NDoyMyBQTSBVVEMgMjAyNA0KPiAgIGxpbWl0IGRhdGU6IEZyaSBOb3Yg
IDggMTA6NTQ6MjMgUE0gVVRDIDIwMjQNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTUu
MTAueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2Ug
ZGF0ZTogU2F0IFNlcCAgNyAwMTo1NjozNiBQTSBVVEMgMjAyNA0KPiAgIGxpbWl0IGRhdGU6IFdl
ZCBOb3YgIDYgMDE6NTY6MzYgUE0gVVRDIDIwMjQNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxp
bnV4LTYuMS55LWNpcDogaW50ZXJ2YWwgMTUgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFz
ZSBkYXRlOiBGcmkgU2VwIDI3IDA5OjAzOjI4IEFNIFVUQyAyMDI0DQo+ICAgbGltaXQgZGF0ZTog
U2F0IE9jdCAxMiAwOTowMzoyOCBBTSBVVEMgMjAyNA0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4g
bGludXgtNi4xLnktY2lwLXJ0OiBpbnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiBy
ZWxlYXNlIGRhdGU6IFNhdCBTZXAgIDcgMDE6MDA6NDIgUE0gVVRDIDIwMjQNCj4gICBsaW1pdCBk
YXRlOiBNb24gT2N0ICA3IDAxOjAwOjQyIFBNIFVUQyAyMDI0DQo+ICAgU3RhdHVzOiAqTGF0ZSoN
Cg==

