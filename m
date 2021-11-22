Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0163BC433F5
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 17:37:26 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.137])
 by mx.groups.io with SMTP id smtpd.web10.1047.1637602643346129859
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Nov 2021 09:37:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesasgroup.onmicrosoft.com
 header.s=selector2-renesasgroup-onmicrosoft-com header.b=K2RLRCFe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.137,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKNslhEBfR5HyTKme7xV4RTf0nxyGxzKOu2RhyEbuH1q8jNl9BQEZ19EgtELyMlcPEZUkBCtElhweMMnv2AqXJgVEffjXc4fYIQgISToIfsLmc8r1Ke+8Bma16RIv7Pz8NPKEx5++GH9l3yFppXNoZJGOImVnITTTOvkvNo8X0C4ZTYXWsKckkr2pL5e65MhIVJoREUWBNiCnFf0E9en+yJ+hKYCmDsfLvv2cmeq+aY0ECm8W3nnHkHuFvnePBdecaKUa2EOEA+MR9my/lROeztuoBENaYKTLLtS898qG8hky+INlh0kJI1I2Y5wDUFbdS7JDQ2F2do7usa9iZRZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl3r737jWYxgAw/KSci9VHaqaYO406zHwaViBfVec1o=;
 b=NqaqsU/feF5bRfxxBL6g86rGdalyDptEAkOLvfTw3WHxvCoF0NV4O/C+kjq9dP3ak1fR99Rg0+lUpqFzu63VWzjsXFZpL3JnWSoIFNk1xnG6oBdNvX4QphzaMBndVa/k6FBnjASpZ/oj5DRIZHONL9zzsAIOfWSlG5/1p1Hu0Qnw78lPvInEuMPfrVvhkg3ZGV4g6LXYQed95ngwrU4FDgrMsA/7GjsXutreXsJ663v0d2uRbRW87PApRqTKqJwhsk6V2RMRpyPkG+ajX9LZ8LJOpxuSLXKty4QrdWTk4yCpBVzJfa/P/xXaHFP0pTvYhJ461E+aDDk5Uv298eSTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl3r737jWYxgAw/KSci9VHaqaYO406zHwaViBfVec1o=;
 b=K2RLRCFeLlgiQRy8HGu59IzuXCGXgksYdJY9I+vH3HLp3Kc4ORfPFEpwA4/CDvRp03GluBGWgr0+kah3c/YcJ5tzuLyDYMhig1SZ4lgxLwl+TeT2tcaN+oMGXeWm4io+uK5B6QdTloYlKPC+4e0LAh+wtNAsKlOcXUxhxQLqZVs=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS0PR01MB6082.jpnprd01.prod.outlook.com (2603:1096:604:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 17:37:17 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%8]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 17:37:17 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
Subject: RE: [cip-dev][isar-cip-core][RFC PATCH] customizations: Add FW and
 tools required for wifi testing
Thread-Topic: [cip-dev][isar-cip-core][RFC PATCH] customizations: Add FW and
 tools required for wifi testing
Thread-Index: AQHX35P3jazBx1Bj2EKODlz0WRDgIawPzOIA
Date: Mon, 22 Nov 2021 17:37:17 +0000
Message-ID: 
 <OSZPR01MB7019EA632E0BDCC0F4251C9FAA9F9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211122111940.12250-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <eb289805-9e98-7d2d-8e6d-1786087d0ac3@siemens.com>
In-Reply-To: <eb289805-9e98-7d2d-8e6d-1786087d0ac3@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36600d6a-27e2-4b1e-fd7d-08d9addebaaa
x-ms-traffictypediagnostic: OS0PR01MB6082:
x-microsoft-antispam-prvs: 
 <OS0PR01MB6082C20B7C2F93D0C9E6B484AA9F9@OS0PR01MB6082.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Tc9YAkuErs54TagmtSp6CpaH/NEIHYhOZSCvrEBney+CYT9/9B4nZT/SHeoNTKfLk6HHiEoNdZL4z+NDZc7oSPgmdFY8WY0Bao2lVedF8JA3IDg8VU9EyfCHL3V260B0fNjzBz/ao38qwW0VLKTZS0aZNBhrD1pHIVEfoaQ6OB/Dqz3IXJ/RGtsy5vkACsXz4GKfR5DTxe/P4dUbTGr0nr9fEB+/F26A0CPStY51PebJkdH4OAQfYr3Zz6eq2ZuHHMn05G0HsatROWTe93wksAE+PV8nZxQbHfaG84lCKbDGk/M4adnqsWFaYEaRMae94vIPPCj72ouwAWG6Nb6l579uZkgoBvPAtzHfQ87Y6AmfzwWxE/1Izo913VIPzQ7/Dc6LO4uk1uHoMjn4R+K9Xvbt/k1sq+a/78KJ4Sy5RkKz9uXtyZ/O3SiZSzhqUxqSyWifz3aATi++fO+SmLvk8AZziTVgspvlSvraG+RNKnxWgxhbUqo0Xs8BU5mlNtBAIVrvmEell+2En//2NYilYeYmQrS0wDhQ3FT3DQveKBX/aAzeajY4NUBn4jZiUaNUW52MWs33Q5/X0xvFicHclqTTnhJs0TViDOfonalN/qpGtICPOdyqoOjZdPgZvIHE0IVHQXcxNKfGvzv4U6DXcROmvUbAFAWNBv4KMKoc2DFWMjiJhmwNWByMwacv6xVmNu29kXNTP0YUVQZcYW3PSBdb2kolSB/4CKrlZ3AUWUdAmkUYjS5295mBkrrRgTWFflzL6Xa70Mv0GIbzk6QmEjEQKOAm61oewZ3tHzVT8E4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(8936002)(86362001)(52536014)(76116006)(122000001)(66946007)(66446008)(64756008)(66556008)(66476007)(55016002)(26005)(8676002)(5660300002)(38070700005)(9686003)(966005)(38100700002)(316002)(186003)(83380400001)(6506007)(71200400001)(110136005)(45080400002)(53546011)(7696005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Njl6bllRT3FVaVU3UkFLYVdWNkhic25BWTVvYzVSSzRSRFBLMXptRWt1elk1?=
 =?utf-8?B?ZlBCSFNYSVlDUnVCSkdVRVlQbzV1Y3o1TUhyN2RGeUl6dThZWjlLd3BqeGtm?=
 =?utf-8?B?SWgxL1NCam5iK1ZwV0FNQkZwaStSakJVN205WVE4T2JZa0cvcWl5UERjcFVM?=
 =?utf-8?B?SHFRTTNuZ2dlbVhwQ1U4SjhtUHdxTUZ1NmR0NVRSR0p1R1VIZGd0YjllMmhJ?=
 =?utf-8?B?Ly8yb1NXUTl4YURucUZrVTV4aEFITlZPVnhPcXdyWVVUNURBcXB3UWIyQVFU?=
 =?utf-8?B?cEdWR2dhT25uT0Vabi9vd2JVZmIzTnQ0WXpZekVnVzFmMFpGSGU1dnRnc3Q0?=
 =?utf-8?B?M3NtVmFqc2hubnhYSi84WjY0MlpHOWdkTGhONzdyK2pKUVoyK0I5Rml2bWpM?=
 =?utf-8?B?UjBsVTJnTXRHaHgyNDBIV091eEUyVUtsMlVLcVZqVjBOVUNQcGwweTU2eFJB?=
 =?utf-8?B?UmpYSFdqM01rajF5RjNmdFl0RUpTajZjSVRESjdkdzZvQnBXck9rYzhuT3pW?=
 =?utf-8?B?elg0N2hNM2lDQlhNdHMzNmNWUHo3M3FobnFTYUIzTDZ2WlJPNmtLQ25TRjBS?=
 =?utf-8?B?K1hFTWFxbHVqQ2hLbTlGUGZwT2ZLMVRscm1QSWlVRTNad0pXNnpDQ25HSHJW?=
 =?utf-8?B?RWZrMWNGQWlVWUtKRExON1NDUWxLL0RoZnJXWFRyZWtTakdnWVdFK2ZtTTgw?=
 =?utf-8?B?OWJCTkU5bXUyNmRicWdIbm02SFFvelcrNVc2bC9PZmxzWEI0R0NtRFNEdjZa?=
 =?utf-8?B?VzdxZWlXKzNZWklvWGIwN1VScTk4SVpBN21BYVdzVytIcVR4RlJza2hEa3c5?=
 =?utf-8?B?VmRzSEcwclphSWJ3WWhYWk5wNmdwR0F0VEtac2lERzFFSzhVR09QS1dSZnN3?=
 =?utf-8?B?MnE3WGZDa1hMLys2djBvRnk4OFN2d0JQM1F6KzFMWW81YlZFbXhNeisyTnhW?=
 =?utf-8?B?blF2a1hTL3VlTWtWSGtVR0JoZHA0aGlCZmpxc01XK2Qva1FBbC95L1lvYVE4?=
 =?utf-8?B?bXdWc01OODJGaE9HOUxUWmFEOVJodVp0NXdOdnlleE5nUlpMRlZjdHpkRCtp?=
 =?utf-8?B?NTJnUS9CUjRVZFpkM3JxQmFkYUp0Wjl6SlJYNU5LaXgyd0I3TC9vOGxoTUJY?=
 =?utf-8?B?Y3ZUM3dSMmFlRk5pMlYrN3VCb0Z2cG5DcS9UWnd6ZHg5WG95SzJXNG1FbExh?=
 =?utf-8?B?RWl0NVVhNlYyWGFIK082b1d4QXoyNWJlM05WYXc0Sm1vL1VqaEpxNE9qOUdo?=
 =?utf-8?B?cnlGSWpYZ0IxZlNiejRUbzFjenpjc3E2M1N6SVk0MGJ1bTY1NFdaOEtIY3hT?=
 =?utf-8?B?dGxMVmk3dXp0Mk5MNCs4TmlHTTBLUmEwc2pWZWFSQ2x6amVzaVBZZCtlbm1o?=
 =?utf-8?B?eGtFZG1QUURFNDhvQ0RZVTBYcmRPSzB5L0hzQUs2NXk2ditrUlVsQmFPYjdC?=
 =?utf-8?B?NkZMM2xENDJCRmYwa1FRb0d0T3ZQaTR1c2ZPWi9mNkJMb0JIN2RrNjZDUHNm?=
 =?utf-8?B?Y3RzQmZDM2FXZ0Z4UCs3cUhkMFhNcHdOd0hCUktrOC9jLzNQbTIwVUFTZDBJ?=
 =?utf-8?B?NWg0eGFydkVqTGpmTEJnSDlubG1EaVJKaUZiL2RHVlllVTFMUVpCYUlvaWtJ?=
 =?utf-8?B?VDdIdGtaZE4zMGoxUnlpdS9PYUhlY1hZOXhhWUVIenVlU2hPZXIyVXZNeDZr?=
 =?utf-8?B?VENMenVEc1M3bC9vSWxjZlNNNXR4N08wTUtiZkhWSGprYnpnQ2w5SkVwQ0Y4?=
 =?utf-8?B?WHpMYmlqczJ3aER3ZXQycnprYXRwTyt5VXE0YUxaTkRlVlhjejBzZU1adUdH?=
 =?utf-8?B?bFZDZWxrU0VnNTU0TW15d1ZTeGxwOHRJZWd2NHRIMlVXZURzeUJueS8wd2Jn?=
 =?utf-8?B?WmpIOHJyYm9GMFFrTWI4YThZSmxISzlyUnhaMmJUdHByWm5KUlNLSkxCc0ZT?=
 =?utf-8?B?MG9ubWs1bmNFUStGdElQcVFDeW12ZjRtVVJMcnQ4MUNyWTZ1ajFJWUpYdTk2?=
 =?utf-8?B?aFNibkwzb3RLQ1JGTm1KYWNJN2hWOXFISzVEOWlLR3psampaR3VIdm1IV1R2?=
 =?utf-8?B?dXp2eXp0dGZiOE5NcWZRYjhEUzQvQ1ZLZkRJamI5NnJuc0J5WlZ5TyttRjh4?=
 =?utf-8?B?alFXTnFaNVNjUlpoQVdnYVltUXBZQVJFdEFnMmhJeHljZzJ5VUJsQjM3b1FN?=
 =?utf-8?B?Uy9Lb0l2MHJmMEErVFA0TWQzMmhpSXZEcTNzZ00waUJnK0FiMzE5Y2xNeXFj?=
 =?utf-8?B?ZEN6Q2JMVkF2bjhBcGRERVc2QlJEdGRXQTIzYXFtNzk1WnVyWGZXRmNmcEZt?=
 =?utf-8?B?NDNweEtGUXk0QVJnZUFobEI5ZklyZS9lcDlSK1h4bVJIcGtlbEwzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 36600d6a-27e2-4b1e-fd7d-08d9addebaaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 17:37:17.2782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 dZ5lpzSzPAC33mRctTod6txTxCqPwwG6N8OPKwtorgdlejnAvyHfFI0ZALslq30FwhlQZb/2p3fkL9eglUdUvUDe4NsnRWoC5TBALVni4pyPcRHx/6cZ861WstWrbmEu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Nov 2021 17:37:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6964

SGkgSmFuLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBxdWljayByZXNwb25zZS4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1l
bnMuY29tPg0KPiBTZW50OiAyMiBOb3ZlbWJlciAyMDIxIDExOjI4DQo+IFRvOiBQcmFiaGFrYXIg
TWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT47IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOw0KPiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhp
cm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+
DQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl1baXNhci1jaXAtY29yZV1bUkZDIFBBVENIXSBjdXN0
b21pemF0aW9uczogQWRkIEZXIGFuZCB0b29scyByZXF1aXJlZCBmb3Igd2lmaQ0KPiB0ZXN0aW5n
DQo+IA0KPiBPbiAyMi4xMS4yMSAxMjoxOSwgTGFkIFByYWJoYWthciB3cm90ZToNCj4gPiBBZGQg
ZmlybXdhcmUgYW5kIHRvb2xzIHJlcXVpcmVkIGZvciB0ZXN0aW5nIHdpZmluIG9uIGhpaG9wZS1y
emcybS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5t
YWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiBIaSBBbGwsDQo+ID4N
Cj4gPiBTZW5kaW5nIGFuIFJGQyBhcyBJIGFtIG5vdCBzdXJlIGlmIHRoaXMgaXMgdGhlIHJpZ2h0
IHBsYWNlIHRvIGFkZA0KPiA+IHRoaXMuIEkgd2FudGVkIHRvIGFkZCB0aGUgZGViaWFuIHBhY2th
Z2UgZGVwZW5kcyBpbiBtYWNoaW5lLmNvbmYgZmlsZQ0KPiA+IGJ1dCBkaWRudCBmaW5kIGFueSB2
YXJpYWJsZXMuDQo+IA0KPiBJTUFHRV9JTlNUQUxMX2FwcGVuZCB3b3VsZCB3b3JrIHRoZXJlLCBz
ZWUgZWcuDQo+IGh0dHBzOi8vanBuMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20lMkZzaWVtZW5zJTJGamFpbGhvdXNlLQ0KPiBp
bWFnZXMlMkZibG9iJTJGbWFzdGVyJTJGY29uZiUyRm1hY2hpbmUlMkZycGk0LmNvbmYmYW1wO2Rh
dGE9MDQlN0MwMSU3Q3ByYWJoYWthci5tYWhhZGV2LQ0KPiBsYWQucmolNDBicC5yZW5lc2FzLmNv
bSU3Q2FlMjYwMWY0OWY1YjQ3MjViMWFiMDhkOWFkYWIxOTQzJTdDNTNkODI1NzFkYTE5NDdlNDlj
YjQ2MjVhMTY2YTRhMmElN0MwJTdDMCUNCj4gN0M2Mzc3MzE3NzI2NDQ4MDgyMTElN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRp
STZJazFoYVd3aUxDSlhWDQo+IENJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPW1xcDB3a25HeXhL
eVk4Mll2Z0hKWGw3MmFUdTREV1N1VU9IY2FaUG84eEElM0QmYW1wO3Jlc2VydmVkPTAuDQo+IA0K
QWRkaW5nIElNQUdFX0lOU1RBTEwvSU1BR0VfUFJFSU5TVEFMTCBtYWNoaW5lLmNvbmYgZGlkbuKA
mXQgaGVscCBmb3IgbWUsIEkgd2FzIHNlZWluZyBiZWxvdyBpc3N1ZXM6DQoNCnwgRVJST1I6IE5v
dGhpbmcgUFJPVklERVMgJ3dpcmVsZXNzLXJlZ2RiJyAoYnV0IC9yZXBvL3JlY2lwZXMtY29yZS9p
bWFnZXMvY2lwLWNvcmUtaW1hZ2UuYmIgREVQRU5EUyBvbiBvciBvdGhlcndpc2UgcmVxdWlyZXMg
aXQpDQp8IEVSUk9SOiBSZXF1aXJlZCBidWlsZCB0YXJnZXQgJ2NpcC1jb3JlLWltYWdlJyBoYXMg
bm8gYnVpbGRhYmxlIHByb3ZpZGVycy4NCnwgTWlzc2luZyBvciB1bmJ1aWxkYWJsZSBkZXBlbmRl
bmN5IGNoYWluIHdhczogWydjaXAtY29yZS1pbWFnZScsICd3aXJlbGVzcy1yZWdkYiddDQoNCnwg
RVJST1I6IE5vdGhpbmcgUFJPVklERVMgJ3dpcmVsZXNzLXRvb2xzJyAoYnV0IC9yZXBvL3JlY2lw
ZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2UuYmIgREVQRU5EUyBvbiBvciBvdGhlcndpc2Ug
cmVxdWlyZXMgaXQpDQp8IEVSUk9SOiBSZXF1aXJlZCBidWlsZCB0YXJnZXQgJ2NpcC1jb3JlLWlt
YWdlJyBoYXMgbm8gYnVpbGRhYmxlIHByb3ZpZGVycy4NCnwgTWlzc2luZyBvciB1bmJ1aWxkYWJs
ZSBkZXBlbmRlbmN5IGNoYWluIHdhczogWydjaXAtY29yZS1pbWFnZScsICd3aXJlbGVzcy10b29s
cyddDQoNCnwgRVJST1I6IE5vdGhpbmcgUFJPVklERVMgJ2Zpcm13YXJlLXRpLWNvbm5lY3Rpdml0
eScgKGJ1dCAvcmVwby9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLmJiIERFUEVO
RFMgb24gb3Igb3RoZXJ3aXNlIHJlcXVpcmVzIGl0KQ0KfCBFUlJPUjogUmVxdWlyZWQgYnVpbGQg
dGFyZ2V0ICdjaXAtY29yZS1pbWFnZScgaGFzIG5vIGJ1aWxkYWJsZSBwcm92aWRlcnMuDQp8IE1p
c3Npbmcgb3IgdW5idWlsZGFibGUgZGVwZW5kZW5jeSBjaGFpbiB3YXM6IFsnY2lwLWNvcmUtaW1h
Z2UnLCAnZmlybXdhcmUtdGktY29ubmVjdGl2aXR5J10NCg0KfCBFUlJPUjogTm90aGluZyBQUk9W
SURFUyAnaXcnIChidXQgL3JlcG8vcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS5i
YiBERVBFTkRTIG9uIG9yIG90aGVyd2lzZSByZXF1aXJlcyBpdCkNCnwgRVJST1I6IFJlcXVpcmVk
IGJ1aWxkIHRhcmdldCAnY2lwLWNvcmUtaW1hZ2UnIGhhcyBubyBidWlsZGFibGUgcHJvdmlkZXJz
Lg0KfCBNaXNzaW5nIG9yIHVuYnVpbGRhYmxlIGRlcGVuZGVuY3kgY2hhaW4gd2FzOiBbJ2NpcC1j
b3JlLWltYWdlJywgJ2l3J10NCg0KQXMgYWJvdmUgZGlkbuKAmXQgd29yayBhbmQgY3VzdG9taXph
dGlvbnMuYmIgaXMgdGhlIG9ubHkgcGxhY2Ugd2VyZSBJIHdhcyBhYmxlIHRvIGdyZXAgZm9yIERF
QklBTl9ERVBFTkRTIHZhcmlhYmxlIEkgd2VudCB0aGlzIGFwcHJvYWNoIPCfmIkuDQooTm90ZSBh
bHNvIGFkZGluZyBERUJJQU5fREVQRU5EUyBpbiBtYWNoaW5lLmNvbmYgZGlkbuKAmXQgd29yay4p
DQoNCklzIHRoZXJlIHNvbWV0aGluZyB3aGljaCBJIGFtIG1pc3NpbmcgdGhhdCB3b3VsZCBtYWtl
IGl0IHdvcmsgd2l0aCBJTUFHRV9JTlNUQUxMX2FwcGVuZCB2YXJpYWJsZT8gDQoNCg0KPiBXaGV0
aGVyIHdlIHdhbnQgdG8gImhhcmQtY29kZSIgdGhlIGluc3RhbGxhdGlvbiB3aXJlbGVzcyBmaXJt
d2FyZSBpbiB0aGUgbWFjaGluZSBjb25mIGhlcmUgaXMgYQ0KPiBkaWZmZXJlbnQgcXVlc3Rpb24u
IE1heWJlIGN1c3RvbWl6YXRpb25zIGlzIG5vdCB0aGF0IGEgYmFkIHBsYWNlLg0KPiANCklmIGFk
ZGluZyBJTUFHRV9JTlNUQUxMX2FwcGVuZCB3b3JrcyBpbiBtYWNoaW5lLmNvbmYsIHdpbGwgZ28g
d2l0aCB0aGlzIGFwcHJvYWNoLCBhcyB0aGF0IHdvdWxkIG5vdCBkaXN0dXJiIG90aGVyIHBsYXRm
b3JtIGJ1aWxkcy4NCg0KPiA+DQo+ID4gSXMgdGhpcyB0aGUgcmlnaHQgcGxhY2UgZm9yIGFkZGlu
ZyB0aGlzLCBpZiBub3QgY291bGQgeW91IHBsZWFzZSBwb2ludA0KPiA+IG1lIHRvIHRoZSByaWdo
dCBkaXJlY3Rpb24uDQo+ID4NCj4gPiAqKiBEbyBub3QgbWVyZ2UgdGhpcyBwYXRjaCAqKg0KPiA+
DQo+ID4gQ2hlZXJzLA0KPiA+IFByYWJoYWthcg0KPiA+IC0tLQ0KPiA+ICByZWNpcGVzLWNvcmUv
Y3VzdG9taXphdGlvbnMvY3VzdG9taXphdGlvbnMuYmIgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3Jl
L2N1c3RvbWl6YXRpb25zL2N1c3RvbWl6YXRpb25zLmJiDQo+ID4gYi9yZWNpcGVzLWNvcmUvY3Vz
dG9taXphdGlvbnMvY3VzdG9taXphdGlvbnMuYmINCj4gPiBpbmRleCA5MzJiMTFjLi5jNTA4ZmQ0
IDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMtY29yZS9jdXN0b21pemF0aW9ucy9jdXN0b21pemF0
aW9ucy5iYg0KPiA+ICsrKyBiL3JlY2lwZXMtY29yZS9jdXN0b21pemF0aW9ucy9jdXN0b21pemF0
aW9ucy5iYg0KPiA+IEBAIC0yMyw2ICsyMyw5IEBAIERFUEVORFMgKz0gInNzaGQtcmVnZW4ta2V5
cyINCj4gPiAgREVCSUFOX0RFUEVORFMgPSAiIFwNCj4gPiAgICAgIGlmdXBkb3duLCBpc2MtZGhj
cC1jbGllbnQsIG5ldC10b29scywgaXB1dGlscy1waW5nLCBzc2gsIHNzaGQtcmVnZW4ta2V5cyIN
Cj4gPg0KPiA+ICtERUJJQU5fREVQRU5EU19oaWhvcGUtcnpnMm0gKz0gIiBcDQo+ID4gKyAgICAg
ICAsZmlybXdhcmUtdGktY29ubmVjdGl2aXR5LCBpdywgd2lyZWxlc3MtcmVnZGIsIHdpcmVsZXNz
LXRvb2xzIg0KPiA+ICsNCj4gDQo+IExldCdzIGFscmVhZHkgcHJlcGFyZSBmb3Igb3RoZXIgdGFy
Z2V0cyByZXF1ZXN0aW5nIHRoZSBnZW5lcmljIHdpcmVsZXNzIHRvb2xzIGFzIHdlbGw6IFB1dCB0
aGVtIGludG8gYQ0KPiByZXVzYWJsZSB2YXJpYWJsZSBhbmQgdGhlbiBhZGQgdGhhdCB2YXJpYWJs
ZSBoZXJlLg0KPiANClNvIGp1c3QgYXBwZW5kaW5nIERFQklBTl9ERVBFTkRTIGFib3ZlIGhlcmUg
aW4gdGhpcyBmaWxlIHNob3VsZCBiZSBPSyBmb3IgYWxsIHRoZSBwbGF0Zm9ybXM/DQoNCkNoZWVy
cywNClByYWJoYWthcg0KDQo+IEphbg0KPiANCj4gPiAgZG9faW5zdGFsbCgpIHsNCj4gPiAgCWlu
c3RhbGwgLXYgLWQgJHtEfS9ldGMvbmV0d29yay9pbnRlcmZhY2VzLmQNCj4gPiAgCWluc3RhbGwg
LXYgLW0gNjQ0ICR7V09SS0RJUn0vZXRoZXJuZXQgJHtEfS9ldGMvbmV0d29yay9pbnRlcmZhY2Vz
LmQvDQo+ID4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFQgUkRBIElPVA0KPiBDb3Jwb3JhdGUg
Q29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==

