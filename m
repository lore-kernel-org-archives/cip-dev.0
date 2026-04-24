Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF4CFE5215
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:54:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19457.1777031668663784520
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Apr 2026 04:54:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=AnjMv0hI;
 spf=pass (domain: renesas.com, ip: 52.101.229.60, mailfrom: chris.brandt@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9nFwhUnXQ6L3193nUZncnkuwzwOoQ41N/5nr5O59hXbDI50m/4FgEa1cnP+atdMDtjIj2dJaYURK9JIxVvOSfMcxH3DNjGLBKCvrQJ/rh7XZZbBft/cbD5wsgq7slv2BzCIhHyCPtCCoFPfbDGWCO3SR5TdeDpyE2uOy+nTMh7RMv9g8YQQ0xwrWO50QcI/PvMX6/hIyRbHUBZE6MaVIKCzM6jUdGRwLveOoNNqsduEJlQ6LKLKcDGoDNWOYBWW9wViD2ugClh8qGwaPsB+4MR+zwkdK3lWtVkRm0Z/nuUwQJNmae1Lfsl06dSL85XUvGiAw8Spia3s2HBHOEVs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB2l/ox78DeNMXZRtkSEaLfDx1Yq6lqw99efHl63KZ0=;
 b=L21z7pGtoHmVJreVTaW7dABz70X8o/His4FmDN898jVRRtsqohAy8zWgXoc3Y79lumm37PIgdI9FnCMjuYZR3e8D00t5vi7io9iUQ+0W7yXBt8Lqm7HKCm3tvI2iBO6Rat3HG1qf9lmpCt2fO1Jzr3ohyXxJo6DxylqC2VmSMrqOqKmvdqMamPewkqDKyt8JGuorcWYUvvZgTYCL6IwFvMzAqeFbXChvpS64xfUh24N7JGFeAxdMeFFVVih2TEf9nL2VwdZaHyfM8o2RFWBhMF/O9jkhi92uqDjmzfq02yujGue5ywfaNl2oWBKwsRXnQk3jrRIqQFLMWZPjT7c2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB2l/ox78DeNMXZRtkSEaLfDx1Yq6lqw99efHl63KZ0=;
 b=AnjMv0hIdxfOT4+0RpHw5LFbuMLmCej5xmxJzyqTIlW6Afoe/mamw8NmmNBMKCYtv/Hp7xvF1gM9S2RbI9HfqB6FT/ZZANc8qklt9zUGGF+cZRdmUTHJPMXo9ID+czCYsV13AFrxNj6xSlm87u6c7s0Wpl5cMrRPZG7eabwxuzk=
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com (2603:1096:604:1a2::11)
 by OSCPR01MB16417.jpnprd01.prod.outlook.com (2603:1096:604:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 11:54:24 +0000
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983]) by OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983%4]) with mapi id 15.20.9846.023; Fri, 24 Apr 2026
 11:54:24 +0000
From: Chris Brandt <Chris.Brandt@renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/10] Add additional support for
 MIPI-DSI for RZ/G2L
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip v2 00/10] Add additional support for
 MIPI-DSI for RZ/G2L
Thread-Index: AQHc0xmlrgumSxBAw0yOkn4PAN6xkrXtm2rwgACAIGA=
Date: Fri, 24 Apr 2026 11:54:24 +0000
Message-ID: 
 <OS3PR01MB8319F5029D9E215D55B5C5438A2B2@OS3PR01MB8319.jpnprd01.prod.outlook.com>
References: <20260423120630.1487798-1-chris.brandt@renesas.com>
 <TY7PR01MB148180710B3BCE73D8222AEF2CD2B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148180710B3BCE73D8222AEF2CD2B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8319:EE_|OSCPR01MB16417:EE_
x-ms-office365-filtering-correlation-id: 786d9e2f-234a-4471-669f-08dea1f83aa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18096099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 ipuJtQelmMG1Y0hTjEpLtSfISQxrXi2DDI0xkD4cLIqlZ9bwMuiKWIMzvGRVz5AY1gXxnXyiWUr0PQigs7dMVFcLuX6qNCOhwzoyGCS3zrXTpsa7++WdV3g+40e0wjQR3ALCctxh+MXLeEocYyAaS1gpCsxyZJ+gIrq7+GKK0ou4OPOoRrLRZMZwimGZMciCXUr8Je6x7LzV8RxRZHuCL0vVTY9lpSpyBBfCkkI1d9aGCLTAiuIvNxUOhYLtP4voRuO73YA0W4e9/BQ2U7joLOcM+e4v+0PQbHJ7cj40P+CR8ErhVozkDy5hUeh09QcZxk/hhctL0UV6KJXQvqarenFVcTpUBIiAGCFGFr7BcztyEVF/Up6hCi3TQJwQZ2POO3OgpPLy2PIKm5Vy2kCAerRcIdcCjraCFzTqANWhg0KUKRBVt4HQNewUXEJLU/9zd8HryDg3peTaHRDEEpWVgnHlpCyhFXl2uxl4oIAQQwETbScxs5WeLpK1tudpAMuWY7Rxn6Zplm2Kfr+ddRAlQLGYtJhJI7BGbaHkFY25kEwdCSF0V2NF/hEdqjytDkeGXH8e/1WiIJlcPpruO1UEn1IONT3WBdm/PjI1qj74CXQD0k+6CMjSKcYoenlChuz6lWUoPNGf+5h6wTge0Ivi9pn38z9ZA9tykkbk7YKFXWWA+/u4dsIiVyswoRhihzdyYSKn+yVt33oWiPU9/CeKWs5epOn330zMjOrO3Z/SExIXvlDB20UAOHxbVmpvlUolhhAZSMD4hSNlfi8s6yleySILgSUMPVsrItmExd0oHeM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8319.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18096099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a0V0UVNjU2VMUUVOSHB0blNrNlNhREdYZFhrdDd2STE2U0dXWjBORkt5OWJJ?=
 =?utf-8?B?eW1IY2U3WjZTUVZnd090UkpNcTRjUlNCRzFHVlJ5U09LazhFbXBPamF6TzE0?=
 =?utf-8?B?UkhzUkthdGtRN0xOSjl2ZCt3bk5aQWxtYnA3WmRpYzZuQmFvS2pJa3dOUmtt?=
 =?utf-8?B?ay9YSVpQR2ZaaGRjMnRmcVByV1dGL1NPVE1sMExGY1hIZWxtVVJPVjhZblVl?=
 =?utf-8?B?dzVMa1MzaVROMHB4SElYalB5ZVRBdDF1RlFEaGFCbUplT1Q1dG1DcFBjT1lx?=
 =?utf-8?B?NE1ZdFUxaHN0RWdycE1pcWhocnluKzN4eVcvT2JrRW13UUdSdmZMbFJJRFkz?=
 =?utf-8?B?c0VwbzQzQ1lkRFBpWTVzcm40R3lMb21Ydnd4ejVLb05pZUVrRXNLTHpxK29T?=
 =?utf-8?B?em1DWjZsTFBrNStJRzJaTElYd3lyWGFENGRWSVpaWUYyZTJPZGZPSmdmdWRl?=
 =?utf-8?B?dWZObmhZQmlTdUoxQlkzbkZWQVdIYVlDUkhWZG9FOVRTUU1mb3V1RFBHYmJV?=
 =?utf-8?B?TEorRUlERXFXdVE3TVlUVFBFRG9nTDJQWVprQVZ4c1JmNlltbTAza3c1Sld5?=
 =?utf-8?B?M1hqcFpzVWlUL0hBTkJNUVNWcEcwdVZWZ2dpbGFuOUpNWE50bk1sdHcrek1i?=
 =?utf-8?B?MEgxK3hpcTVtSVhIWDNKZTA3VnFpc09jSTZ5cFNEVkN1WHVkOXNYczdhWENY?=
 =?utf-8?B?VUdzN0VudGJlRysvRkZLbXkrUDFoRzVTYjVObEVJYnBLTlBNVDFQSG5DUFpa?=
 =?utf-8?B?dGNoTUlLaXY0NTUzS2lHVE9YcVBTTFY4MHdnQ3F3WDBmYVl6YnhCSlpJTXZD?=
 =?utf-8?B?dWlpSnk4ZjJEaXpvUjdVMmhKOHZiOURibHl5U2tyS3NPc0Q0R2wzR3Y4emdV?=
 =?utf-8?B?Yk11dkV2UU1Uc0lPUU5RZ2lyNmtqMFVPVEF2V2VBZDVVVlMwUXVxdGo5OWw1?=
 =?utf-8?B?cEhCYkdKTG14MitOUlhGeitBc3RldkFiVW54ZEhYM1hsZnBEUlBuL1FZeTJE?=
 =?utf-8?B?ZGtzenAvOWd3bDVadGZaZXpMYS8ySEJhNzBpQjJuZzlScnljdk8rckY4dng1?=
 =?utf-8?B?SlM2Mi9wSHI5ejdadFhmYi9kTm0xWXYvUmlDVGkzanE1ZW5jY2Z6cStQUW53?=
 =?utf-8?B?dm13cmJ2QWJmVHRXLzZVK2lpZ2RCL2oxa25PV2lMQzB1V3dHbHM3QVdzalh3?=
 =?utf-8?B?c3BmN2ovWnRNM0RTVVBDVVJVR0dkakhJaXltWUFQZ0JwZGNWNlJvMEpUM0kx?=
 =?utf-8?B?MFBiNVY1VUk4Y1MxRU4vU3Q5Nk4vR2ZhMU5mN2tVRXpKOW9kcUdBZi9pT0lV?=
 =?utf-8?B?SEowa3VYSjNpVTVJT0l2M3l3Z1FwZVpvSGdiNjJvOGhQZW1qWjdqemEvRDM1?=
 =?utf-8?B?RHNWR0dKZ3ZVTVRybGd5TjZPTmhFcm9iVytNNmlVcjRoa2MwTEZ5TEZiYjU4?=
 =?utf-8?B?QThVUWUramQyazVFYzJxRXFvTm94aG92TW51OHhhRW0xOUI2WjhwaERKRWRk?=
 =?utf-8?B?VWJJOExxSE5QcUJ1bElSMGRpUWlza1E4bE9YTEJUUk5hdkdxK25kWlZEQTBP?=
 =?utf-8?B?QndDdlFvSFVwdXBHRS8vN09TK2wvQ1dzS3VhYW0yODU1YkNROS84RmdLU2hu?=
 =?utf-8?B?NTk4ZUYwMjhlK3cxOU9HSDJrYzVaZUFpdk5MOEg4dHpHM2p4STV2SmJKZitk?=
 =?utf-8?B?bkRNR2lRakxXWjNURHRoR3RZck56RkVnWFNlK3ZRa1NOb0FpbmFKOG9mTmI1?=
 =?utf-8?B?MU9vOHhtcmticG10M0NuUW15TDBTS1dGTkJ2cXk2bEUyazVDbEdiQytOOGM5?=
 =?utf-8?B?cnJCNWE0NHQvUzM3dzJTNUhyT2Z6aGJkVnM0UnY5Z1Fmc3NjM1g1bnM0R3hH?=
 =?utf-8?B?dW9CK0tlZXhHS053WUJZWHEzMElrU3I0T1NHUHRlSTczaWFWZWFtZkNkTlRm?=
 =?utf-8?B?TkhKQzZyQ1VidllIMEtwL2JhUmNpVXhackwwMllyejd5a2ZGbmJCY1dSbjMv?=
 =?utf-8?B?VzZUMTVjeStzOW5za1p6TmdYc01TSmJYMTkvZ3ZTRy9WMjFLdDdPYS9PM0Fo?=
 =?utf-8?B?bkg0Qy9NMU9QdXhGMXg3alZ4aFpUQ2JzL09IdEUrcDlXeGJRMzRuUjdKSjZE?=
 =?utf-8?B?dk9wQ094dW9EeUZZcnF3RjBZNUs0R2hvNU1MeDlLTTYwN29UL1VTd1F2V2ZM?=
 =?utf-8?B?d29jREdFL2htK29VUVRwdDVycktiNko3bnI1ZS9GQlgxaDZuRWhsZTlXUXd5?=
 =?utf-8?B?dThqOHZkdXJwZHpWc3pjMEg0azZ3bS82bmZPSDUxem9WMGNteEw0MjNGSzA4?=
 =?utf-8?B?TGszemVHemFsaXR6ajZBNHdHRkZwUG5wcG0rU0ZQUWkxVSs1WEw0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8319.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786d9e2f-234a-4471-669f-08dea1f83aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 11:54:24.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kS8/YikOHzcQz3oXX48gTsDg5r3D0kjkWBa/xKZUBJV3YeAH45iD3dXdOfm+77/OH3K2rWUUcmYTG3Pz0e1PmR8lb/M63KEGQxv+EPEUOKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16417
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Apr 2026 11:54:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22809

SGkgSXdhbWFzdS1zYW4sDQoNCj4gQXBwbGllZCwgdGhhbmtzLg0KDQpUaGFuayB5b3UhDQoNCkNo
cmlzDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxm
IE9mIE5vYnVoaXJvIEl3YW1hdHN1IHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClNlbnQ6IEZy
aWRheSwgQXByaWwgMjQsIDIwMjYgMTI6MTUgQU0NClRvOiBDaHJpcyBCcmFuZHQgPENocmlzLkJy
YW5kdEByZW5lc2FzLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBu
YWJsYWRldi5jb20NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW1BBVENIIDUuMTAueS1jaXAgdjIg
MDAvMTBdIEFkZCBhZGRpdGlvbmFsIHN1cHBvcnQgZm9yIE1JUEktRFNJIGZvciBSWi9HMkwNCg0K
SGkgQ2hyaXMsDQoNClRoYW5rcyBmb3IgdXBkYXRpbmcgcGF0Y2hlcy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpcyBCcmFuZHQgPGNocmlzLmJyYW5kdEByZW5l
c2FzLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDI2IDk6MDYgUE0NCj4gVG86
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g
5L+h5rSLIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJvLml3YW1hdHN1
Lng5MEBtYWlsLnRvc2hpYmE+OyBQYXZlbCBNYWNoZWsgDQo+IDxwYXZlbEBuYWJsYWRldi5jb20+
DQo+IFN1YmplY3Q6IFtQQVRDSCA1LjEwLnktY2lwIHYyIDAwLzEwXSBBZGQgYWRkaXRpb25hbCBz
dXBwb3J0IGZvciANCj4gTUlQSS1EU0kgZm9yIFJaL0cyTA0KPiANCj4gVGhlcmUgaXMgaW1wb3J0
YW50IGZ1bmN0aW9uYWxpdHkgbWlzc2luZyBmcm9tIHRoZSBNSVBJLURTSSBkaXNwbGF5IA0KPiBk
cml2ZXIgYW5kIGFsc28gdGhlIGNsb2NrIGRyaXZlciBmb3IgZ2VuZXJhdGluZyB0aGUgY29ycmVj
dCBwaXhlbCBjbG9jayBmcmVxdWVuY2llcy4NCj4gDQo+IFNpbmNlIGV2ZXJ5dGhpbmcgaXMgbm93
IGFjY2VwdGVkIGluIG1haW5saW5lLCB0aGlzIGlzIHRoZSBiYWNrcG9ydCBvZiB0aG9zZSBwYXRj
aGVzLg0KPiANCj4gVGhlIHBhdGNoZXMgd2VyZSB0ZXN0ZWQgb24gYSBSWi9HMkwgYm9hcmQgdGhh
dCBoYXMgYSBjb25uZWN0b3IgZm9yIGEgTUlQSS1EU0kgcGFuZWwuDQo+IEFkZGl0aW9uYWxseSwg
dGhlIFJaL0cyTCBTTUFSQyBib2FyZCB3aXRoIGEgTUlQSS10by1IRE1JIGJyaWRnZSBjaGlwIHdh
cyByZS10ZXN0ZWQuDQo+IA0KPiANCj4gVjEtPlYyOg0KPiAgLSBDaGFuZ2VkIHRoZSBmb2xsb3dp
bmcgY29tbWl0cyB0byBiYWNrcG9ydCBmcm9tIHVwc3RyZWFtIGluc3RlYWQgb2YgTFRTDQo+ICAg
IC0gImNsazogcmVuZXNhczogcnpnMmw6IEZpeCBpbnRpbiB2YXJpYWJsZSBzaXplIg0KPiAgICAt
ICJjbGs6IHJlbmVzYXM6IHJ6ZzJsOiBTZWxlY3QgY29ycmVjdCBkaXYgcm91bmQgbWFjcm8iDQo+
IA0KPiANCj4gQ2hyaXMNCj4gDQo+IENocmlzIEJyYW5kdCAoNSk6DQo+ICAgZHJtOiByZW5lc2Fz
OiByei1kdTogQWRkIGF0b21pY19wcmVfZW5hYmxlDQo+ICAgZHJtOiByZW5lc2FzOiByei1kdTog
bWlwaV9kc2k6IFNldCBEU0kgZGl2aWRlcg0KPiAgIGNsazogcmVuZXNhczogcnpnMmw6IEZpeCBp
bnRpbiB2YXJpYWJsZSBzaXplDQo+ICAgY2xrOiByZW5lc2FzOiByemcybDogU2VsZWN0IGNvcnJl
Y3QgZGl2IHJvdW5kIG1hY3JvDQo+ICAgY2xrOiByZW5lc2FzOiByemcybDogUmVtb3ZlIERTSSBj
bG9jayByYXRlIHJlc3RyaWN0aW9ucw0KPiANCj4gR2VlcnQgVXl0dGVyaG9ldmVuICgyKToNCj4g
ICBjbGs6IHJlbmVzYXM6IFVzZSBJU19FUlIoKSBmb3IgcG9pbnRlcnMgdGhhdCBjYW5ub3QgYmUg
TlVMTA0KPiAgIGNsazogcmVuZXNhczogQWRkIG1pc3NpbmcgbG9nIG1lc3NhZ2UgdGVybWluYXRv
cnMNCj4gDQo+IEh1Z28gVmlsbGVuZXV2ZSAoMik6DQo+ICAgZHJtOiByZW5lc2FzOiByei1kdTog
SW1wbGVtZW50IE1JUEkgRFNJIGhvc3QgdHJhbnNmZXJzDQo+ICAgZHJtOiByZW5lc2FzOiByei1k
dTogbWlwaV9kc2k6IGZpeCBrZXJuZWwgcGFuaWMgd2hlbiByZWJvb3RpbmcgZm9yDQo+ICAgICBz
b21lIHBhbmVscw0KPiANCj4gUGFsaSBSb2jDoXIgKDEpOg0KPiAgIG1hdGg2NDogTmV3IERJVl9V
NjRfUk9VTkRfQ0xPU0VTVCBoZWxwZXINCj4gDQo+ICBkcml2ZXJzL2Nsay9yZW5lc2FzL2Nsay12
YmF0dGIuYyAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gIGRyaXZlcnMvY2xrL3JlbmVzYXMvcmVu
ZXNhcy1jcGctbXNzci5jICAgICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9jbGsvcmVuZXNhcy9y
emcybC1jcGcuYyAgICAgICAgICAgICAgIHwgMTgyICsrKysrKysrKysrLS0tDQo+ICAuLi4vZ3B1
L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJsX21pcGlfZHNpLmMgICAgfCAyMjMgKysrKysrKysrKysr
KysrKystDQo+ICAuLi4vZHJtL3JlbmVzYXMvcnotZHUvcnpnMmxfbWlwaV9kc2lfcmVncy5oICAg
fCAgNTQgKysrKysNCj4gIGluY2x1ZGUvbGludXgvY2xrL3JlbmVzYXMuaCAgICAgICAgICAgICAg
ICAgICB8ICAxMiArDQo+ICBpbmNsdWRlL2xpbnV4L21hdGg2NC5oICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTMgKw0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA0NTAgaW5zZXJ0aW9ucygrKSwgNDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjUyLjANCg0KQXBwbGllZCwgdGhhbmtzLg0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

