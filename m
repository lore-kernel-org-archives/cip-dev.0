Return-Path: <cedric.hombourger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F7D18139
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 17:37:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web10.1009.1728927464585484390
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Oct 2024 10:37:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dQ2Are2B;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: cedric.hombourger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpAkS9naCPO45hp3lToDHQv9blnXWDNw8wgSWViB/fn+Y6IcjE8AOPHX2C/kXCRxm3YAr7G2jB6o0YFik55TVhMG0pAjo3sAzKBWOYA7+olf8LypCQELg9YrC8Fl5dUJLEKA4Yq1q5gLmAvn3rg+0SIUSIWy4uhmii0TFkAzs9naAC/bgyAGu+Ebkisa8HUJ6kd0KoBcN5sGLeMrGgoms2R7Tk8Y1sgDm8Teiki6RmfG6QcRVevx9EYsQ7i3V3ZTOItSUEJhb3PTAu4iNklBuRZ3B1Yb2tuHgSJkAq+2EciUsajpExjtRbwPCpffrEWGsCav+JssxRjJXphff99M3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmPJRdXCo6brd10HuJSXJQwBDyi1okqvkjKXWRurBvg=;
 b=ppyiwLXgCJ3H15M97uvqyrU4IpwGUBbut3sOAZ/EO5Fd7J2HBuUzfD1CMum7UYofCpHwbNsTojT6hrBoMpn35lY+fOG6WvTqMdgJUStq4NqVAq34YZysWV5SEIoiWpXeN8XCAIXWT2tmr714Rci6jWHPs5wQ3E9U1JDQgla+xIuo97/ZxiT2FmQZYIJyRrTR0z9+dMMUC1DOJ6OxZWtAgSy+i6EWMxQJWzV2/Cq8N//9TR4pt9ka17QNgBBH8Z96HhUpvaFGy7RCt8rtJXvqxCiaG0XUhoB1vCsEv0kPbKpLRfWdRYuvUFGa07UbboM4yx9ujEVQ1M1o336iGZLxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmPJRdXCo6brd10HuJSXJQwBDyi1okqvkjKXWRurBvg=;
 b=dQ2Are2BTf3CkvYl1piWLiT0vSxFGnP9CaMt/RT/HOUF3TdCcx+ptDT4yABiXIL/UFt1U/5OzlshK9TyEOhI/0VEuoj+qE5i08xTgohj6mFRT6RSuwJzECFNeuzaHL/uwK7oWL/vybw5wFL5FXoSidwfkf1HF9YqFjSbIShQ8UEF1s0UKV7W/HFPhWEoP42sO2LQAcrpXc7IS0SX4Oi1BbwH4qeWO07ZNVAp4wXfPPnG4d3BHpFcBwQTP7oMgcn9Ut661zqUeFE02CVjYz4TXqtVOp8mzNmmFOGMu8oQdja3S5RK7c6+uVFyfz3g0LK24ACW2hWpYigXONvrlfAZkw==
Received: from GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ad::21)
 by PAWPR10MB7675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.15; Mon, 14 Oct
 2024 17:37:39 +0000
Received: from GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa28:2e8:91f1:fcec]) by GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa28:2e8:91f1:fcec%6]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 17:37:39 +0000
From: "cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Bezdeka,
 Florian" <florian.bezdeka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] distro: add preliminary support
 for the upcoming Debian 13 (trixie)
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] distro: add preliminary support
 for the upcoming Debian 13 (trixie)
Thread-Index: AQHbHlGaTL60fIaC90usBN1lTup5P7KGcWiAgAARegA=
Date: Mon, 14 Oct 2024 17:37:39 +0000
Message-ID: <0048221369047dc779374b49dbca135a61f50b81.camel@siemens.com>
References: <20241014155604.569003-1-cedric.hombourger@siemens.com>
	 <8e39db0082a1279609fbd3d9ceb60ed3abc1c1bf.camel@siemens.com>
In-Reply-To: <8e39db0082a1279609fbd3d9ceb60ed3abc1c1bf.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6137:EE_|PAWPR10MB7675:EE_
x-ms-office365-filtering-correlation-id: 78bc6241-b4fa-434f-6220-08dcec76e696
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZXdBaG1WL2FNM2NITnY1Rjk0Y09qTS94NnN4Yi80Q3VKRjN6UXhCd243YWNY?=
 =?utf-8?B?eUZJSEI0MlF3dXJPRDMza1E1L25lRENOcU4vbW9JNkRUN3FURUx1aHQvSFRX?=
 =?utf-8?B?ZnErditwcHV3YjMvcnRjSmpoRjlhS3pzRlpSU3NEVFZhY2RKYmFIS3c2dDZY?=
 =?utf-8?B?dm5PbkV6dlhSQm0yR21jMnl4R0dzUTZNM3F1SjJkL1NIdVZvaURnZ3QzTUc3?=
 =?utf-8?B?ZEg0YkFQSlFHK00xbHNJMjA0SXVvaWdwbTBXaG85WHhkTDlxc2tlTnNXKzdv?=
 =?utf-8?B?MGttSnNmRmdKd3JIdjRZa1ZKazg1QzMvWTRpSnUxR2RVTDVqejNrdCt1NkNM?=
 =?utf-8?B?Z05FWkxseHJMRGtSRFJDdERtakl5SHMxemZiME1ubi9GNDBPY2lHU0c2N0J2?=
 =?utf-8?B?MGk0Wk5ZWTJTcEMvMlgxYUhndTFUZ21wTjBVK2huWERjSkkxSlZqSzN1TGlr?=
 =?utf-8?B?cjJEdnBQbXQrbkFtNHdnTDlCN25hTklwVC9kMkZBdGxZejNldVdLb01IMHN6?=
 =?utf-8?B?RFJjMVhQbENubFNvdldrS1MrYmZ5Qzk4bkdYWThuSm5pbHFxUU15ZXYwYmdt?=
 =?utf-8?B?aGVyS2hndVNkbi9iNjhVSEx0SUJRb1EzenVSdWVOcHhuMzlWVGhiSjJ5THNU?=
 =?utf-8?B?ampETytGdTVhVFJiWEdRZHh1WHBMNERMZXFjSkdJQ1hveW4zNGZnVEhPR1lW?=
 =?utf-8?B?U2JWTUlFbWxxRXJ4VGtjcHo4T0d6ZXg3UEpyeis0dndaRjJBbnhmMXcrL3Zh?=
 =?utf-8?B?VkdMS0xwVzZBNGxoMmR1RWdibWlhM2kwYVloNVVzVkIyWmZ2OXc2MzhtL3dR?=
 =?utf-8?B?WUl5Y0xCaGhzUDN0ZnAyN21CRURwbmt5UTB5cUdYS2RST29YV1VMUllxQ0R2?=
 =?utf-8?B?ZVV1TThZL25xbmxnVmdOMUJCN1FFQjJFSFNQRjEybEF3V2FZWEdYOTVRQVdZ?=
 =?utf-8?B?UWdNWjhEdmpwVnhIQm5CUXRlTW8vWDZRYWJRTlNDc0lRcjRoSnkycjA4WVZk?=
 =?utf-8?B?U0lhZG9PbDdYb3JyT09TQWt2UnlVdHpvUGt4eWZaNFZhL3JjWElRd1dYeFNn?=
 =?utf-8?B?RVJzZnNvaWc1aWVHeC9UcXlQWW5PL28rK1QrZW9NaUlrSXh4QVR6aGVQNlZr?=
 =?utf-8?B?V0lVcy82RFhCT1pjVmc4STdKM3JJOTFmTlVOTmQ0dy9TWTdDQ25FdkxEUURa?=
 =?utf-8?B?MzBMY1hOaWhMOWZpK2xZOHRjdUJieUxjY2g3bDF5MnNoMk04QlhkalpDeVZB?=
 =?utf-8?B?NHBxSUxJYStidVRFWFpiYlBHMXhPRS9FSk5jZm9uSWFNVUxVT0ZTRDdrdSsr?=
 =?utf-8?B?dVhScklEWDJwKytVYjN0MzR2aUVRTTluS1cwc01mSmpyaHRvdHBUVzh0NTZL?=
 =?utf-8?B?aDdqa0ZUYm9wSjh5RUtRMCtUWWdnalZEbTJJWjFCc3orRGc5YVBycVB4YWpB?=
 =?utf-8?B?Q3oyMDRhWEZHR1daM3BxOGRoME5GdFFNUEZaeFRpSHkrNlZDeUNqVnJQdVpM?=
 =?utf-8?B?aUZxd2toTzg5MGpTeDI4Tjc2S2N5cVJ1YWxZQlZiTFVYTDBTVGJXbTl3Mlpq?=
 =?utf-8?B?QVF2MDBIamRUODV4SWxJVjFQd3JQU3VkV3VldGxNWDJTQmx4Zm5RV1d0U2pO?=
 =?utf-8?B?aHhFaVA0eWptZ0xDNWJCWWxEelIvL05SejNxeXRjZGlUekZkbTJZTnFMWGJW?=
 =?utf-8?B?UjJxbEo3SDVXSlZpOGJnWHpJc0FYQVgyTDlTY2V5UHZ3K3IzWSt4czBwQnNM?=
 =?utf-8?B?eEdyU3ZLWm11NlVTVHBaUFlWQWt3OGlCRDVvRG1SUEVJTmlwYkVMcVZQaDUw?=
 =?utf-8?B?Q0ZpdGw2eWFta2pkRjRadz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WXNrR0d4S2lvaFRGVTlFL0JWaTNFTnZsMHErZUNsT1UzS1lNTVoyKzRWOUpr?=
 =?utf-8?B?YkM4bUNTcW5MTVZ0UEFKZlRRck1TVkNqbFo1M1IvcXp6RFJZVWZUdDQ3ZW1s?=
 =?utf-8?B?OFNKOXhIU1NJZGtkcVlqSG55ZWZSOE10MjdOOGdraHdvOHNtMS9ra2lsRFlT?=
 =?utf-8?B?SW9jNHpmWFpFcHhyeHZtbHRJL0VDVDRzQUZINTladHNZakVqWG9PK1FFNFBz?=
 =?utf-8?B?RkVmQ042Sk9QWHhsREJkS2FNSksvZ1JxZ0JXZ2RCOEhQcyt0Q1Bka25QQ3BV?=
 =?utf-8?B?dzBDTWMvdnZtMWJHNSt1Z1YzeVNYQlJKUk5mSjVIZ1E0Rml3UUhNanhNaFFT?=
 =?utf-8?B?bWZ6bkgxcDQ1OTZML3YrNzVqY0E4bFJZUS9XZm1BQlRvdTAzV25sYVlIWWs2?=
 =?utf-8?B?cmZ1WEIyN3o2UTZpRTI3R1I2NWhNL0JiYWFmVjRCREI0bUhFNml3TEo4RExw?=
 =?utf-8?B?KzBkZEdRZStCSHY2Sm4wcTNIRE9qcFJkTkJOVjAxWkJjMTNnNEVQZUNMT1h3?=
 =?utf-8?B?RTRHVnFxYmlEQzVHck13RE9FaUxDK3h6Y2l3SlZPMlUwbGhEcDdPOS9QdFNl?=
 =?utf-8?B?MjF5VUVsdkhCb1NiUjF1RVRZbUJQcWZFeWM3Y0RwOWlUTTRBdVppekNqcEQ0?=
 =?utf-8?B?SXpVT2phRlppckN3eGJVK0pjOU5kVUlYVFhyQy85WUJmMUREY05NZVFzUDJh?=
 =?utf-8?B?QzdtUUtuSlhCVzN1dXY3Wk0rZ0RTaWoxUXR0QzJQWVg0NU10c1VOb3lpNUNS?=
 =?utf-8?B?TXNEb0RhdksyWSszaE1Qcll4UkJhamYvb2gxMkZSdndMbnZUVHNiNXRRVFhL?=
 =?utf-8?B?dVJPQmtCaU5kcDBlN1RoNzBlK0Y0VnJueDkxTm9hTnIzVlRSRitYb05FRmdO?=
 =?utf-8?B?R1B6cG43WXA2RHNKbEFxb2xVMzZPcTZSdURzaWw3MkVkTDlxeE53MDhqNSt1?=
 =?utf-8?B?WDBOZlRUYU5BaVNoWFVXdmdKd3U3Vng0cGRwdkEvb2xSNi9jcUNWUlhqTHc2?=
 =?utf-8?B?bFFCM0FHeWFaMVhBNlQ4bExCc2h5SndKN0JER1NpYWR0Z3NiblJVVGpFdnph?=
 =?utf-8?B?V2oxUHNyK09Cb0p0NjlFYi9wUkFkTVJVZVFScTlWOHd6UjFBc0JQQWNYV2pZ?=
 =?utf-8?B?ZTcyTFB5UkMxbXFOaHJvRHAvbDhCNGl4UEd5dExCNFRaNWdMaWJjTnBYM0wz?=
 =?utf-8?B?MUtzNUR2aEN1bjRQLzRVYjQxR1R2TFV0ZjFYbTZvK1NCclhqQmJENTJWM0dO?=
 =?utf-8?B?aDhyMUwyRFZxbGZSRFBEa2lrUVVEVjV3TFV0cEpOekdJWkdySERxSVY4bzZD?=
 =?utf-8?B?dG9nTEhnRmdPOGF6cW8rZ1p3UTVvZkdWYzd4SkN4bVBTdWNqamg3REU4aDJX?=
 =?utf-8?B?S2Z5L0pCUDJzeTNBTUZYYU51VUdUanc3enN6YVB3SHBrbG1mM1FwLzdRdE9P?=
 =?utf-8?B?bzAya3pGL1VWRmpxWWtiTm1IYWNTYkdJV3B6REx5NnpEaWNybExXbnh4MTRY?=
 =?utf-8?B?RmhIdE1lZCtwY0FYRG9GL3FJbHVqQ2Y5Wno3ZTFUb2hmT1k0eDd1VGFVcGlh?=
 =?utf-8?B?QndVeXFGMFV4OTVCQ2dkMkMyUUpIRHhkRWNqL2NEYWIxdVRXdWVaYmdCN1Bo?=
 =?utf-8?B?L2tiR2R3Q3NYTk5vQ1FzcFNKQm1VZVRMZFZOTng2d3Q5OXJjdnNLWHpYZkZX?=
 =?utf-8?B?b3NHK25lWFJkME56RE9KWWdrVjdRZGRkWmJQeXhZZmFsQUFNNWVZemZ2cVZX?=
 =?utf-8?B?d3UycXphNFNpSDV1ekR4VzNXaWVvUzBuMEtnV2RaUngvejhxZ0d4RUtZdzFG?=
 =?utf-8?B?djZOdDZPeHVxVTQzbGFqQnZITUM4eGJoQ2Yza2h0dVdEcFhleE5sYVA4MGJ0?=
 =?utf-8?B?OUY1RWhtWU9zWWpURmdlcG43Y2VoNFVaMGJvTnVzMnpTM1RMdHdlQVpweGtw?=
 =?utf-8?B?WU9qRExpNFF1YlVkWVFobURDZWU5a3VvZmU2dUtYNWRWWU5kdE40Y2xlU21S?=
 =?utf-8?B?WG00b2ZiVjJSWmlyRmVLU0VnekJCdGUrUnRGNWZFZDM4V2FGVW9kRVdVRTlu?=
 =?utf-8?B?Qm9GTCtYZGQ1QmprbFZ1T2VpdVp1cU9xR0VleU45Y2N0aTZITGFKdXRHSHB0?=
 =?utf-8?B?aWNPTElEcTdCdzBwRTBOK1VjaU9rNUVRTk9uTHJEVFNrTUxqVWpXSUF6bHdY?=
 =?utf-8?Q?4vIscl1F7tn/k8TB7IXO58E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88D4EF043554604893A57C5BC1562839@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bc6241-b4fa-434f-6220-08dcec76e696
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 17:37:39.8504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxqiaPsof/0SsPgZN9LKSPLXdxJHKnd/xVdilfNFrjqFMkM7VnwnLeQSYuvaqCkAMDH2g/scq63ddSSSIkMHRNkmxBIlQF9nvkTVdkkKRhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7675
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Oct 2024 17:37:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17036

T24gTW9uLCAyMDI0LTEwLTE0IGF0IDE4OjM1ICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIE1vbiwgMjAyNC0xMC0xNCBhdCAxNzo1NiArMDIwMCwgY2VkcmljLmhvbWJvdXJnZXJA
c2llbWVucy5jb23CoHZpYQ0KPiBsaXN0cy5jaXAtcHJvamVjdC5vcmcgd3JvdGU6DQo+ID4gRGVi
aWFuIHdpbGwgcHJvYmFibHkgc3RhcnQgZnJlZXppbmcgcGFja2FnZXMgbmV4dCB5ZWFyIChmaXJz
dCBhDQo+ID4gc29mdCBmcmVlemUNCj4gPiB0aGVuIGEgaGFyZCBmcmVlemUpLiBJdCBpcyBpbXBv
cnRhbnQgdGhhdCB0aGUgQ0lQIGNvbW11bml0eSBzdGFydHMNCj4gPiB0ZXN0aW5nDQo+ID4gRGVi
aWFuIDEzIHRvIHByb3ZpZGUgZmVlZGJhY2sgdXBzdHJlYW0gd2hpbGUgd2UgbWF5IHN0aWxsIGlu
Zmx1ZW5jZQ0KPiA+IHZlcnNpb25zDQo+ID4gdGhhdCB0aGUgZGlzdHJpYnV0aW9uIHdpbGwgc2Vs
ZWN0IGZvciB0aGVpciBuZXcgbWFqb3IgdmVyc2lvbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBDZWRyaWMgSG9tYm91cmdlciA8Y2VkcmljLmhvbWJvdXJnZXJAc2llbWVucy5jb20+DQo+IA0K
PiBNaWdodCBiZSBhIGJpdCB0byBlYXJseS4gRXhwZWN0IGJ1aWxkIGZhaWx1cmVzIGZvciBhbnkg
a2luZCBvZiBjcm9zcw0KPiBidWlsZHMuIFBhY2thZ2UgdmVyc2lvbnMgKGF0IGxlYXN0IGZvciBn
bGliYykgYXJlIGN1cnJlbnRseSBvdXQgb2YNCj4gc3luYy4NCg0KV2VsbCB0aGlzIGxheWVyIHBy
b3ZpZGVzICJzaWQiIGFuZCBpc2FyIGFscmVhZHkgcHJvdmlkZXMgYm90aCBzaWQgYW5kDQp0cml4
aWUuDQoNCldlIGNvdWxkIGFkZCBhIHNlbnNpYmxlIHNuYXBzaG90IGRhdGUgaWYgdGhhdCBoZWxw
cyBidXQgaXQgaXMNCmRlZmluaXRlbHkgbm90IHRvbyBlYXJseSBmb3IgInBsYXRmb3JtIiBsYXll
cnMgdG8gdGFrZSBhIGxvb2sgYXQgd2hhdCdzDQpjb21pbmcsIHRlc3QgaXQgYW5kIHByb3ZpZGUg
ZmVlZGJhY2sgdG8gdGhlIERlYmlhbiBjb21tdW5pdHkNCg0KWWVzIHN1cmVseSBwZW9wbGUgZXJy
aW5nIG9uIHRoZSBjdXR0aW5nIGVkZ2Ugc2lkZSBvZiB0aGluZ3MgKHRyaXhpZSwNCnNpZCkgc2hv
dWxkIGJlIHByZXBhcmVkIHRvIGZhY2UgaXNzdWVzDQoNCklmIHlvdSdkIGxpa2UgSSBjb3VsZCBw
cmVwZW5kIHRoaXMgcGF0Y2ggd2l0aCBhIHBhdGNoIGFkZGluZyBhbg0KImV4cGVyaW1lbnRhbCIg
c3dpdGNoIHRvIEtjb25maWcgYW5kIG1ha2Ugc29tZSBvZiBvdXIgb3B0aW9ucyBkZXBlbmQgb24N
Cml0LCB0aHVzIHByZXNlbnRpbmcgdGhpcyBvcHRpb24gdG8gcGVvcGxlIHVuZGVyc3RhbmRpbmcg
cmlza3MNCmFzc29jaWF0ZWQgd2l0aCB0aGVpciBjb25maWd1cmF0aW9uLg0KDQpDZWRyaWMNCg==

