Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF37C433EF
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 06:14:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web09.4514.1656051279608966337
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jun 2022 23:14:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 25O6EbVq023056;
 Fri, 24 Jun 2022 15:14:38 +0900
X-Iguazu-Qid: 2wGrZSY9KAvo6wowFd
X-Iguazu-QSIG: v=2; s=0; t=1656051277; q=2wGrZSY9KAvo6wowFd;
 m=MZgOc1sfDbQRlUaTJ6oQkm36YQg9fWdjh9jUHE+5OH4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 25O6EaN8033223
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Jun 2022 15:14:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBSCHKsMmj9NT/kHJ1QZsfKuR/04qUAoaB/5ROEpltnmgADUF2lc1uCu1zgHKVzKZbzu9alj+NObRzmTFLQb9Lw95y3ksohlfjqczFfNx9TAyR8mPcVPIwmQoCdO97khFzAgZ1f/0sL6B4jNm8bH+C5MZSFf1Uud1Vx8EUfs5jiWj+KNzhWHM9gBx56c+j1mw6ksjRnpoFYRbp4moXY/vQjqMUctxEcXGThsEblNZSKGsP6SzQRz6eK/B9tUdXrJmJ8zuJi9y4Xx6RQn30eOXLM6FRLLDUx0c4TMUPIdHL2OapFGUtHXCJ8kvErYeojUA/dwD9D5R8+QHQp2zLkneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeTUbpI+xSKmcdjARHXmKOtv6VOCSU3XincjSZwsM74=;
 b=g4TqU0RIBDCxCtj1y9ARGs5vjcopOM4UmM2e2g4QYBg8nJO2WxsD+d481Lcsu8Ul0vtDGr6ZyNjd8BKncc00RuvwnMy36+VIJ6ibZ7IzUNhz4SKGfWODmDeSC8r+JSAtXwXhEeoV2ilpJZdlostq659Qx1ZaPogoAv0hZPbm2YbALhq8WU8v91lUEoZI9M67WiNQM+6vqitISmjsndZo//J1cUbcHBz3vUu2CP3zPn4XXzZUTzNuY1gxDCdvIUjG8+dRoZVklQC2Or4ZaTSY3o6Q4LjpwunvLLUVC5vw4RtG39TiOplszmztJElZdxhTVx8QIoBOiMPV2HBxGs7UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] How to increase the size of the rootfs in the
 isar-cip-core image
Thread-Topic: [cip-dev] How to increase the size of the rootfs in the
 isar-cip-core image
Thread-Index: AdiHLEE60rWXvhuPQIiktp+GultvCgAXCMZgAAJVquA=
Date: Fri, 24 Jun 2022 06:14:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55429006101E86D0C50EC304A4B49@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: 
 <OSYPR01MB5542D88313015EC03720450DA4B59@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <72b772df9e9842c38814b902671d88d3@mentor.com>
In-Reply-To: <72b772df9e9842c38814b902671d88d3@mentor.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a7e8188-7f39-48cb-e656-08da55a8cedb
x-ms-traffictypediagnostic: OS3PR01MB8244:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LGDc6OBA548z2TFHWnK4311Q3lXirORzJ9IxYS7krVGL12tsoH2Cl4cm5+v6JTMp8d9n+2iDnSFE7Y0yIpm+Keiiw70mqlwW7xCnOkn6a4iwV1etH2JddJu6//CRRRvVtkzE16UsdVM+s+hFGze5K2FKdybea6QP3jHxFqVrqtmJ3sVEL+PEI9HTHd8JUhwNr0R/D67gyss9E89oD2h6XhCKNIMNU1QKk6DR5gMc4mxdjDX2qa+RRyYsuvv07wa52AUycNJ5kj6j0V0sN2PRDMdpadVdOG0itoL7+mXFS2SFWjByJIfnKwpBLCwGac99AYm3PwK1KT3g+8MUCq8JLVGa8r64xsucaR5C/OYxzcbN1EseddLKN46rN0vs/+D2jETAP8B9hTWzLAEkA8dOl9Kd+tacP8nF7+oKn6K124qJDCpr9JuLI5SntTH47EvrArnGjM6V8+0nLFszPjWhH3ypceuN3BkcE9l4IDfqbyN+FwTGYWvMZVpzDJ3bV4UBAB6fumR0ECb6icAUFhsk9kpmZviihORXEKYig0e91qJB0yWqzltYjfFJ1Qfi1eJfC7XfvdE6aNcXLywkkOTBIRtpexeTppeUPTtK+9YEbxJIqqR8VRq5xaoKXaVd/9PjKEFfS2uUKyxeyYzJGxDVsQRRFd5iUIdZaX0+V3Np9/B5PXZcXgtWQwsWxm/mk2sN9A10cAOZ/vC3MLLO0sks7envls+IFp6PCpk2+dkPkwL8DupmtoT8K0Vfx8afuiZnbdUSk+VbT2JN/8DEFVumjj2NjW5dW76PQ+QX3d1Sm15mqyzhX4JSaGc99PzQWkQsDq+qgloNWVkH0MK8h0KIcA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(186003)(38100700002)(316002)(86362001)(71200400001)(9686003)(2906002)(85182001)(66556008)(76116006)(66946007)(64756008)(8676002)(6916009)(38070700005)(478600001)(66446008)(66476007)(6506007)(7696005)(122000001)(41300700001)(83380400001)(26005)(55016003)(8936002)(33656002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VWVrUkNQZnNpczJ1WnQ4cllvTisyMUVLWWlXSHRuSXFxNC8zV3ZtWkxLSXlR?=
 =?utf-8?B?MXFUd3ZXcG9EclVraFJsUHJ6dDdteWJiRWpDNCtTN09lcXJqMWdLdTVrNlZB?=
 =?utf-8?B?M29OMVNmZm9BeTVFRE1ydW9kZUlya3VSZmJuejhjNGE5RExFZFRLWXF3bjJW?=
 =?utf-8?B?QjgvZG95cHh1S3BHb2Vib0F1Tjdkd3plRXpCRUZXWHRNanI4QVhlTTZ1b3pz?=
 =?utf-8?B?MHhXOW5ITEE0b2dzRmttNjc5SjIyRDFwU2pyblpwZTg2Zm1FcUE3azRIU1Jz?=
 =?utf-8?B?enR6NFA5Z0M1K1Q1NGtHb2ZaNUdQdEsveEtFcHZ5aGdGUmR6aUNmUVBoWm9E?=
 =?utf-8?B?WFl2OE43dEx6RXFOTzIxNVJKZXpLQlZGSTk3bkpVZkJnYm1odVI1eGhXZHUw?=
 =?utf-8?B?R3NVUlJTbEM5RVJSOXZ5NXBpamx0ZkQzQ1FSSy9ueUREanlHTkQxUmJENVpa?=
 =?utf-8?B?ajh4NS8rcWlzK1QyL2lzS0RXamRsY3A5ek9BMDJNeXpKamRuRjFqY0U0eitt?=
 =?utf-8?B?aEcvUWp1U3VKZ3MyTkg1SGZLWDBMamI2cUwzNTltcWM0SWFoYXJJSXd0eVRt?=
 =?utf-8?B?OGVORGRQL2dFaUV5TVRVQmg1YlRMaFRIL3doWVdJdGNvSDZsU2x6cWxkdnVy?=
 =?utf-8?B?MTJYVWxpNExLUVVoTXR4QnlhdlYwU0tITktKS1JNU2xDZ1Z5ZVY5M2x1WGlh?=
 =?utf-8?B?aCtmcFFVTjd3Z2ZSeEVEblk1azNzWDZHVHlrNEdxemFJNTRhWEFUNjVCMmpi?=
 =?utf-8?B?dnVnci9uTTZWM2dma3BraTV5MThZc1JHMzJXY0N6RmZKV0xFQUoxdURMbjF4?=
 =?utf-8?B?RGFLQTh4SUYxejI1VjcxM1I0dk9oUDZGOFZvakJRMnVhYmN5RDFwRlg3bld4?=
 =?utf-8?B?K3hGN1pQTFRNWDBqdEJUcmgva3MwVGdqTDRCTGlzL0NaRDJxRkZWcnk5Si9Y?=
 =?utf-8?B?eWR0OTYrZ2JMZ0tkeWVtWUhqK2dESW1lTnJLbUhNTE9xWHcvMCtSSTdJWmpl?=
 =?utf-8?B?NVh3R0FSeG1xUVNTZHIvandmY2oyVUc5QVlsVTZKL0g0SktGRWp1SE14Uk1B?=
 =?utf-8?B?SDZJbkJmb2Q4QUdPOVBpTkVRMy84K1R0U2xBZExuZ2l0RFBQWkU2cGR3cUV1?=
 =?utf-8?B?UnNOSzFhRE5iZ00zQ0dmVHh6V1FYVzdicE1CeGRBMFpPdUYwMFA1VzBiNlUv?=
 =?utf-8?B?d1VZRHFaVEZLVXNQMmdFaEswcmgzLzJtbmc5RjRnMXl5UlVvOTY3SUh3U3VC?=
 =?utf-8?B?MDYxTzAyNFBrVFB5VDZUSm03blV6RCsxUVpTT2g1OXY4Wk5ZMVlkSlgrbVdy?=
 =?utf-8?B?M3RrSDhRcGh5SWphUlhjbUFTUWRPbVoyV0dablhJZTlIUWUySTAwaFg0Mjc4?=
 =?utf-8?B?Zm1xK1cxQ0R0b09ybzlPekpwUk1PbEdxQ0Q0anMxdndzM1ZqVjhrSFV5elVQ?=
 =?utf-8?B?YmJwNzFTR0N5Z2hyYkpMZnNOQ2JDSWlKZS9CcCtNYzY0YnRiV2dCMDFPNkd0?=
 =?utf-8?B?N2RtNWs1b2xOaVFnWHR4TWcyNS9ueGFZbVg4VzBtTGU0R1pidE4xUkJQSno3?=
 =?utf-8?B?SUQ5dGpteHNSaHVzRDRoUVNxUnlKNk5PTkMxdEV2cG1LeVJWako0SDZwNjVX?=
 =?utf-8?B?Q1Rza3Z1ME1IdDJvVlJUcWRoQk44ZXdhQnk0eFc2eHFKWmNKY1lyOElWTFFv?=
 =?utf-8?B?dGVNbFBiU1orbzBtMXZ4a1V0YThENndtQkRwaGsvKzVLdm10OC9ZVXQxMjdB?=
 =?utf-8?B?ME9xMy9QTXVjVXF0TWV5MHFvKzhiK2lCS1k2cmZ5MmF3Q2xJYXZjYi9MMmhS?=
 =?utf-8?B?OXd5VVhUOEsxZ00zT0VIWGlQSkNIMXNyOXA3bzRMY2xMTnhHWTVPb3RnZFVm?=
 =?utf-8?B?a0I2ZjZnSDYwNHF0eTd2S3JrckNFaHFUbk0xTnFJamkwMk9vVlZmWGRNeDls?=
 =?utf-8?B?VkNwdzBFMTdZY0ZPSHlBbHJVdnFnTVJzRkM4dFg4Sm5BV0lQYllSaVBGYnM2?=
 =?utf-8?B?NFR2LzM3dDA0aW5xRkdVQllhSzQxNWZEL3NoWE1MUHBoTHhQV3IxaW9tOGxI?=
 =?utf-8?B?b2FZT1lPUkJrZi9jRFdrWmNHR2lGa2ZQdUFsWHgySHdUdWZQUE5wdEJMZ1hB?=
 =?utf-8?B?ZGF4NUVZZWcxbm1LM1lsZFoySmpobkdESUFrWXhNTkQvR2wyTUdlbEE4Sksv?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4a7e8188-7f39-48cb-e656-08da55a8cedb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 06:14:33.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 /xQThBHCYSGmacoytZ5n1HhprKmV51elAOrjnnEXLA0w9Ggt2Jc7Jo85wZI43awSR7hnphsgPxK9TTZrfhoJd/0o3jnblUE+OyWAzWTJ/pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8244
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 06:14:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8589

VGhhbmtzIFZpamFpa3VtYXIsDQoNCkkgYW0gYWJsZSB0byBpbmNyZWFzZSB0aGUgcm9vdGZzIHNp
emUgYnkgdXNpbmcgdGhlIHZhcmlhYmxlICdST09URlNfRVhUUkEnLg0KDQoNCj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mDQo+S2FuYWdhcmFqYW4s
IFZpamFpa3VtYXINCj5TZW50OiAyNCBKdW5lIDIwMjIgMTA6NDQNCj5UbzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcNCj5TdWJqZWN0OiBSZTogW2NpcC1kZXZdIEhvdyB0byBpbmNyZWFz
ZSB0aGUgc2l6ZSBvZiB0aGUgcm9vdGZzIGluIHRoZSBpc2FyLWNpcC1jb3JlDQo+aW1hZ2UNCj4N
Cj4NCj4NCj5Gcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZg0KPlZlbmthdGEgUHlsYQ0KPlNlbnQ6IDIz
IEp1bmUgMjAyMiAyMzo0Ng0KPlRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPlN1
YmplY3Q6IFtjaXAtZGV2XSBIb3cgdG8gaW5jcmVhc2UgdGhlIHNpemUgb2YgdGhlIHJvb3RmcyBp
biB0aGUgaXNhci1jaXAtY29yZQ0KPmltYWdlDQo+DQo+SGksDQo+DQo+Rm9yIG15IGV4cGVyaW1l
bnQsIEkgYW0gdHJ5aW5nIHRvIGluY3JlYXNlIHRoZSByb290ZnMgc2l6ZSBpbiBpc2FyLWNpcC1j
b3JlIGltYWdlLA0KPmJ1dCBJIGFtIHVuYWJsZSB0byBkby4NCj4NCj5JIGhhdmUgdHJpZWQgdGhl
IGJlbG93IHZhcmlhYmxlcyBidXQgbm8gbHVjazoNCj4NCj4rbG9jYWxfY29uZl9oZWFkZXI6DQo+
K8KgwqDCoCByb290ZnMtaW1hZ2U6IHwNCj4rwqDCoMKgwqDCoMKgwqAgSU1BR0VfUk9PVEZTX1NJ
WkUgPSAiODM5MjcwNCINCj4rwqDCoMKgwqDCoMKgwqAgSU1BR0VfT1ZFUkhFQURfRkFDVE9SID0g
IjEuMCINCj4NCj5hbmQgYWxzbyBiZWxvdyB2YXJpYWJsZSBpcyBub3QgaGVscGZ1bC4NCj4rwqDC
oMKgwqDCoMKgIMKgSU1BR0VfUk9PVEZTX0VYVFJBX1NQQUNFID0gIjgzOTI3MDQiDQo+DQo+Q291
bGQgYW55b25lIGd1aWRlIG1lIGhvdyB0byBkbyB0aGlzLg0KPg0KPkhpIFZlbmthdGEsDQo+DQo+
Q2FuIHlvdSB0cnkgc2V0dGluZyBST09URlNfRVhUUkE/IFVuaXRzIGFyZSBpbiBNQi4NCj4NCj5o
dHRwczovL2dpdGh1Yi5jb20vaWxiZXJzL2lzYXIvYmxvYi8xMDAwZGY4ZTk4YjlhNTg0OWE3ODk3
Njk4MDM5Njg3ZmQwY2RkDQo+N2QzL21ldGEvY2xhc3Nlcy9pbWFnZS5iYmNsYXNzI0w4OA0KPg0K
PlRoYW5rcywNCj5WaWphaSBLdW1hciBLDQo+DQo+DQo+VGhhbmtzIGZvciB5b3VyIGhlbHAuDQo+
DQo+VmVua2F0YS4NCg==


