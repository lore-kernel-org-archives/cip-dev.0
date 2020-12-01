Return-Path: <SRS0=jUh6=FF=lists.cip-project.org=bounce+64572+5912+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B11C64E7B
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 07:50:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DA32085B
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 07:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nBB17pNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DA32085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5912+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mfbbYY4521723x5OSXtGFBHh; Mon, 30 Nov 2020 23:50:45 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.134])
 by mx.groups.io with SMTP id smtpd.web12.6936.1606809043808048366
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 23:50:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bme33KrHOIoD3qkal1D3xZ5XP8aZq/eaAMpXxJhkgpkNRxzSkI5/aYvbOp1Gl3d+WlgS19M72I0qbRSYrgYlePqWVvES6hYXXzPyWst7ZnBdnRQSOTlPLTtxEMiZfB1DqVXtXE4OWqg0gi0Oivqh03UU9z9feH24GtWbVC1pkoEXplMmanFF6rexVuASDY+1urWuqiGfo0geAmrABcKzuTtPbSl3aATN1IY8+L4nrlb9r1hDGfrAJ1hoRmpeNMwFBxf7FXI58euiVCA7AVOCwwxhOkEC//CIwHdELDqY4LCYLK+YNXrTXlUS6CO2KcesQEnyjG2zYlmB3CaHegEvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mdOWTuzNkJy1g+jru0IEdih1olGvcbxlRv8cH1X66g=;
 b=VgPgMe1EUSUMmqstfCr4XoawyagyMfIQ8jE5RTyuVSgpwT88iAUgZkNgl8vU+9gWHXVFRr8f0pOtJhUsP0AjT+62kOf/atbYZWoK8+TL7tSCl3cOcwvipoEStFi6PV74Pf7wxpSJWVy/nAx7tb0hjTT1xmwR7dt9jK/ZCBVOwqpK8IBo2/HrzpJnK4v22YbDZGXqI41XFcb4isVsIpIPSOuLSmDvWld2BTcmt+bZ87KJRF3hYEQk2wNVJ/YagdqwfyqG1v66YMqc6lTTB3ZV6flIJiOuMNnBzbpOrxIeYz1Bj9YZM65ECauHlRvrFyXUoLzDivEMH72VMyFZUgdrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS0PR01MB5730.jpnprd01.prod.outlook.com (2603:1096:604:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 07:50:39 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 07:50:39 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 07/11] ARM: dts: r8a7744: Add device node for PRR
Thread-Topic: [PATCH 4.4.y-cip 07/11] ARM: dts: r8a7744: Add device node for
 PRR
Thread-Index: AQHWxyPYjVX5GJ0f60KbmlGCEXdbZqnhZ3awgAB3MRA=
Date: Tue, 1 Dec 2020 07:50:39 +0000
Message-ID: 
 <OSBPR01MB50486CAAF35B78EDD2F526EBAAF40@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201130141916.8211-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB298383351F9AA2DE1CE8E07692F40@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB298383351F9AA2DE1CE8E07692F40@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c343d8a-4812-45d2-2e66-08d895cdcbed
x-ms-traffictypediagnostic: OS0PR01MB5730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB57302A97289A46BD7469441EAAF40@OS0PR01MB5730.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 PQnvSO50n/yxlZwldAzm9T+cWW8Rax5QCOst1+ETN0Sk1awc881eMG3d3WKv29Wy74FvQG1ABMD0Xc301UrqUqHZPnUzaMl2Cw0wp3fnAeeLiwJgGIvc2dDkKWT40e7o/3cvBU6hOjFRzIzS82pSBqCHrk9Z43t2WZMuco3ZrWrHqfApwZ7hCqis1oFVQ0PDCJi9DFMJoFAhObyOUBQNsExQ5mjo0W0EFzSl2/k8vvYzKD9g4l6DW9KT0Q0gibpbu8aq1z/70S5n3L58Zuz+drUC35T0qIbXxzWxlYSijGZD6BdnZAT8OPcCBQYNmtn605g1ZGoqh7P5VDM1cPvIqw==
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?SnNXTTRiTTNqRlNiK2lPVlF5YVliTVVRMXRNd09GQXE1VTkrLzVRZHVCeSsz?=
 =?utf-8?B?bHVseVhCNkJoWUMwaWprSzJlRXd6a0U5VTkvSFVoV1FGOXVVdHF4T2IyTzhZ?=
 =?utf-8?B?NlhRUEtNbW9kelFBZFJsWFg2eHV2RXNCbGM2U2tiUWpFVnVqRDJPUzZvdEw4?=
 =?utf-8?B?R2xvTHVVcHlNQzdVOWYzVzhwNFloVTk3bVBnY3JCQ2MzZ1ZEZDBwTmlaTlpy?=
 =?utf-8?B?WC80QVdLajdha1h0b3JjaFFEdmtDNkZ0VmFQK2NmYUJITHdEN1QwNVh6RnBQ?=
 =?utf-8?B?QmZWQTk0T3R4WnQ0THQzOHhQOTBtVFBwbnY3LzV0b2ZUR0w4TGRHOTE1Z0tE?=
 =?utf-8?B?SnlQOHdLRy9vOUNGRnZycEVXc1Q5ZWNQQ3BJQWZRMWpNTWlGMGVtOGQ1NnpT?=
 =?utf-8?B?bzUxbnJWNmFFdTkrQzNUVmNhdGF4RzFYeS9Zc25GcGxtcTZySXJOR2U0SC9m?=
 =?utf-8?B?K1hzQUNiNHJJOEdnS0orZDFNZ1RieVZhcmc1NEtzaFVsVGZZeXZ5NWVzcjBL?=
 =?utf-8?B?cURyVjlkS25PcWNiYWl1eDgrOVhiTDZOdStiY0J5NUxrZVBBYkkwTWNhSXBJ?=
 =?utf-8?B?cEt3dVA0akF4QytvSnk4aXBMRE8yZFQ3MU1wRTZMY1NiRDZ4L1llQWo4ODVz?=
 =?utf-8?B?M3NGRXJ0QVAzcndoRDJIOFI4MjFJQ3ovT2NSdkZoZXZjV1EyQ3F2SUpLSGta?=
 =?utf-8?B?UHlWUHNxRFJ4NTdadUhqN1d3TmhsYlJaRDRncEVUOWs1bTZDeVJNaUpJaWcx?=
 =?utf-8?B?R1MxM3lrL0tNODRVRjJWM1g4M1VubkJ5MGhmdkVVZnluNTJGYmxDLzdDR3Fw?=
 =?utf-8?B?eGRGalBFci84am1WbC9nbWhwSjkvVGc4RzRBTHE5OVRjUEJzM0tybHdGaUZn?=
 =?utf-8?B?OVNWb2dkVzBHTXhPanpqc3lIUmVxZS9BRDQ5WlRsTlRBSTlvYVMyZzdmQm1l?=
 =?utf-8?B?cCtXMVNrQ0ZoTUw3WlVWeEh0ckI1QVFzbmozSVVoaHVXc2Q2c2I3OEsyUTVm?=
 =?utf-8?B?eTRHSDBrUTZZRDF3TDllVzRUUEtteTZHZlBjT2xuYjFwdEZMaHFXYjFFYzdn?=
 =?utf-8?B?aHNSV3dISWVVKzc4K0ZPVUxsT2RYNFV3UXJ2SkY2SmZRaWlGbzJVSkdDY0lk?=
 =?utf-8?B?dmVyL3I5dUZRV3VjN05UVVpRNnFZaDl5ZWp3K3dJeCtTVGhNMU1OYS8yeUg3?=
 =?utf-8?B?SEJNeXd0YmJmTkc1OVptMkVZcjJSeW5JSDJqek1jY0YwMkhoL2k1emg1RElq?=
 =?utf-8?B?OXVNajBCa2FDWllIRWYxU2lnanlOYXZldkNzUDFLL01RUGZQa1h2R085RmZz?=
 =?utf-8?Q?wokI4zxbMsjcU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c343d8a-4812-45d2-2e66-08d895cdcbed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 07:50:39.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBAX1ukZV0+2t3qFD5MQL8fW6+qcxVcLohqKyrxBFS3oufquHGx+LUIYUd5tokJofwZs6FOMHQBfeEqZ5oZfG9vIA0czKyIjjAaRDGE8rGPPDNfofXaxKslyh+9MwpJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5730
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UM5uW1ypKzVWJkNyolgYdAd6x4520388AA=
Content-Type: multipart/mixed; boundary="6AP4QypviKBCSp8MbNuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606809045;
 bh=HcHLFlGdS3Jm09v6pVmMpXkRUf/9y9rbm+4zaulF1ak=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=nBB17pNIz3oLBazzz7xy3ri4cvwlDnT1ICbRxe6ZyGEFKdmVAxjPsUq7eutYGNJ2W7h
 ve0e/3Ow/Bndf/IoCw3Adu7owCagkQl4cdtOZ+qVkn5VVbsYRj2OYKgTQL8igrOxpK7yc
 J3U6PL8gCnlR94fghIEiMk8Qi+ODBhuuch8=

--6AP4QypviKBCSp8MbNuM
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5q
cCA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFNlbnQ6IDAxIERlY2VtYmVy
IDIwMjAgMDA6NTINCj4gVG86IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFk
ZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7
DQo+IHBhdmVsQGRlbnguZGUNCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCA0LjQueS1jaXAgMDcvMTFdIEFSTTogZHRzOiBy
OGE3NzQ0OiBBZGQgZGV2aWNlIG5vZGUgZm9yIFBSUg0KPiANCj4gSGksDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTGFkIFByYWJoYWthciBbbWFpbHRvOnBy
YWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gPiBTZW50OiBNb25kYXks
IE5vdmVtYmVyIDMwLCAyMDIwIDExOjE5IFBNDQo+ID4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXBy
b2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KX
r++8oe+8o++8tCkNCj4gPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQYXZl
bCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+ID4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBi
cC5yZW5lc2FzLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggNC40LnktY2lwIDA3LzExXSBBUk06
IGR0czogcjhhNzc0NDogQWRkIGRldmljZSBub2RlIGZvciBQUlINCj4gPg0KPiA+IEFkZCBhIGRl
dmljZSBub2RlIGZvciB0aGUgUHJvZHVjdCBSZWdpc3Rlciwgd2hpY2ggcHJvdmlkZXMgU29DIHBy
b2R1Y3QNCj4gPiBhbmQgcmV2aXNpb24gaW5mb3JtYXRpb24uDQo+ID4NCj4gPiBDaGFuZ2VzIGFy
ZSBhbHJlYWR5IHByZXNlbnQgaW4gdXBzdHJlYW0gYnV0IHRoZSBQUlIgbm9kZSBpcyBwYXJ0IG9m
DQo+ID4gaW5pdGlhbCBTb0MgRFRTSSBhbmQgY2Fubm90IGJlIGluZGl2aWR1YWxseSBiYWNrcG9y
dGVkIGhlbmNlIHRoaXMNCj4gPiBuZXcgY29tbWl0Lg0KPiANCj4gSSB0aG91Z2h0IGl0IHdvdWxk
IGJlIGdvb2QgdG8gaW5jbHVkZSB0aGUgcmVsZXZhbnQgY29tbWl0IElELg0KPiBGb3IgZXhhbXBs
ZSwgdGhpcyBzaG91bGQgYmUgaW5jbHVkZWQgYXMgNjkyOWRmYzU5MTgwNDkyNzJlMDc2NTNiMTc2
MGIwYjMwNWYwOThlNiwNCj4gYnV0IGhhcyBiZWVuIHJlbW92ZWQgYnkgNjA1ZTg5NTY4ZmFmZTU3
YzE3OTEyMTliNDExYWIwNzcxOTgxYmVlYS4NCj4gDQo+IElmIHlvdSBhY2NlcHQgdGhpcyBzdWdn
ZXN0aW9uLCBwbGVhc2UgYWRkIHRoZSBzYW1lIGNvbW1lbnQgdG8gb3RoZXIgc2ltaWxhciBwYXRj
aGVzLg0KPiANCkFncmVlZCBJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgcmVw
b3N0Lg0KDQpDaGVlcnMsDQpQcmFiaGFrYXINCg0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgTm9idWhp
cm8NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIu
bWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3I4YTc3NDQuZHRzaSB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3
NDQuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDQuZHRzaQ0KPiA+IGluZGV4IDA3OWY0
NmYxNzA0OS4uMzEyYzlhYWU4YTEwIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3I4YTc3NDQuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDQuZHRzaQ0K
PiA+IEBAIC0xNTI2LDYgKzE1MjYsMTEgQEANCj4gPiAgCQkJfTsNCj4gPiAgCQl9Ow0KPiA+DQo+
ID4gKwkJcHJyOiBjaGlwaWRAZmYwMDAwNDQgew0KPiA+ICsJCQljb21wYXRpYmxlID0gInJlbmVz
YXMscHJyIjsNCj4gPiArCQkJcmVnID0gPDAgMHhmZjAwMDA0NCAwIDQ+Ow0KPiA+ICsJCX07DQo+
ID4gKw0KPiA+ICAJCWNtdDA6IHRpbWVyQGZmY2EwMDAwIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9
ICJyZW5lc2FzLGNtdC00OC1yOGE3NzQ0IiwNCj4gPiAgCQkJCSAgICAgInJlbmVzYXMsY210LTQ4
LWdlbjIiOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQoNCg==

--6AP4QypviKBCSp8MbNuM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5912): https://lists.cip-project.org/g/cip-dev/message=
/5912
Mute This Topic: https://lists.cip-project.org/mt/78608808/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6AP4QypviKBCSp8MbNuM--
