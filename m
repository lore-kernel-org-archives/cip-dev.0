Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F211CDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 09:05:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39163.1782119148173136091
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 02:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65M95jal703693; Mon, 22 Jun 2026 18:05:46 +0900
X-Iguazu-Qid: 2yAbhMIERdDB36Og3W
X-Iguazu-QSIG: v=2; s=0; t=1782119145; q=2yAbhMIERdDB36Og3W; m=FK0efaqnyWAm3h7y13iiUxLeUavo4ElKDFFPNb/+d9M=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gkMk01R7Pz1xnk; Mon, 22 Jun 2026 18:05:44 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpD2XIxIRghH+6rnU4IBDGJZ9GsPtOEtZXy8C+EhYrBYcH1ro/0vgD34CtpyZ4BlrCcLPdAXqUOt4TABgS4UNvGbyMr+vLtaamm/1ptCQOxF2eSHkFVkUjJ+HKXuKU9rSvD5lSx7vJ2SV4zCTTgDM0yDgg6W8DZ6ho8rmGQhph0SKgsWcsAOpPAa8G+ynBOVhs6ve/vDt/+S5uv+QkHdHtRnpaZSsImk5nBpJYa3U5xhUtVxF2u/pSxr7sUBOnh6uu2y0e3gA1J6gg1uO4vVqy30Eeihm9mZe1xElW+iCfYkGYTR8XTg2sAfGt1MBLKBLQdjoFFZYZiTipwBWL1erA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xur+MNdzJiQJtVg/foDhp8xXuLRlEoQQHWuQNGlCEhk=;
 b=FdQUzDLoW5UqBsf5lChNauDvawaoHw9GmIRdkDxGYWBhEq4npeZsPSnORq7JXqjRU107z0JpV7rAiRB5RP7yjs0U1v0bXmsdukjCgtE7uHCP+KVi3EUEimX7yXCnFH6vl1uAAQ0FHfLtxmhHJISzPzypHS/WIp7bbaLDqdYZoO87Toatu4qJ9lyBrJRkrs4/Ct5rTxfuIUb4YFFSRSPpF23z945N7qkRDWnrrfDIJoW3U6lqhRaRFMzIwyQmXju5/l1Hkq9C2M4elOW5gGSZ7cQudH2r1P8UG4tiQrMRFSNRHRPdi6fWGTCM2EKdzN5brJYJy/nK4DxA6P+hS/itIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH v2 0/2] Enable Debian sid support
Thread-Topic: [isar-cip-core][PATCH v2 0/2] Enable Debian sid support
Thread-Index: AQHc/U+0lSSCbrzpCkWBeqj5OBE6xrZAxKaAgAAnpPCAAtkPAIAGiznA
Date: Mon, 22 Jun 2026 09:05:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB110631BEEB631A61D4138A35DC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <34c18027-b049-41a7-b43b-fb200bde4abc@siemens.com>
 <TY3PR01MB110757AA7CAC37C32CF6E444CC7E52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <ec961ebc-6887-42a4-a3af-c79ab2735ae0@siemens.com>
In-Reply-To: <ec961ebc-6887-42a4-a3af-c79ab2735ae0@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|TY4PR01MB12947:EE_
x-ms-office365-filtering-correlation-id: 1aff3a19-a83b-4b7d-af00-08ded03d6f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 mS7ThmqQEqzEODvdvX/WtonjhGrVCW9B/unVDUXC1dBHOlzbR/zr6SIRsUiOoz/f84GxiF/XEX+j5kiFeGgGe8YoN4lzHuaYWz1aStd55XYRap52NNrByyfKPgDc/9ArFcyAlJbWXYIf+Tb53xm6W+QMsWNQir+pP2RO0zoKCYjFeasvCoYR1d1Cnvs3zDUyCir/puBN2vryvhbyYiWlGkcJM5zTQ8L8ki6OwriHzhshHsuSa2mgdUw8HpXYyCq0vbO99KkSWXdB1p2KWZbllyqxYLmOEHwMzRE2Y5LGOzyzIK4jVWxaV+HWNZ0gS7vhgrrsCx+SBTtUEsAwLpughV7Gu2XpEtMs8OYVKhZUmzMgU/0DfzdUVFfnOiQI5/5WT0E97UCRuOU9EKo0fo/p6hE5LuNau+xy6TerYN1OjjwJIzBWcnl099cFI7Futhhg3LhQiKGJ/D+GrUXcAkNo6YsMoLgM0MZSXzIBxpurPesprkaZyfyScVDOZJdoUp1lI1zGrbdS/tCyd7xhPj/EWf+/5mfI5248lvI1L/QUP4ak1IqimDXUSU5GJoFTaxcmHNZLAQHllMaY/6gnsnmDBV5Byrr4y1dEiWBWnr6F6eRhmlr2IUvTSaoS4+GZ8E8BDm0GTiDuh9NQoTeWYWLgXR8VGRd9jJvgLCwU+LuEq+CgTbjfqghUc3vB34bHaDhpSqEQKugF/vi1iWwJmlcBFNkONwoJFpJn6qrZHXrAa1M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?elg5aXlrNTBFVzhWUXdHeHovMFdFR3JnOTVtK1ViVkxUb2txWnNHMlp3d28v?=
 =?utf-8?B?MjNVcjJaWjVIODlWSWJkQVlrdEVoOUJ1LzJhVlBXL1E5RkhORDZ2SjBoWjVo?=
 =?utf-8?B?cTlGVFF1UzAraVlMd3F1cWlCelRYTkR4b2pJdmw5c2ZGSE1md0dsOUFPSUZD?=
 =?utf-8?B?WXorWGU4REVnVUY4dHVQNHNrbTdoaXlPVnR5ZnpIaWxGYkZxNCtHRmF4SzRT?=
 =?utf-8?B?RFpxT29OZG5hSGtaRFA2WTk2Y2NZTjhrUmdXZ1pnTjgvWXc5MGVRR0R5Ly94?=
 =?utf-8?B?SmpIcVNmbGVxd2N5S2R6K20ybEZqL3ZkNGE4WWs5cXdWUkQyOVVTTHUwZHdM?=
 =?utf-8?B?bUNEOExxSDI2VzFLS21Kd21PUmVPYS8yRTczdjAvMFlTc3ZSY0o4bjJFVzl2?=
 =?utf-8?B?U0wybmpzekpKb0JwSDdWN0xpQTNMaHU1M0F0Q25NQWZ0YkNlUTZUZTg0NHZI?=
 =?utf-8?B?bEV6UGV5Um5rWE1tQmptMWVUOTBJTFNVRUcxUnIyTzVWMDVvWldSeEk0RTRK?=
 =?utf-8?B?SGJkK1Z0cjF3NGNvUTVKbTQ4cUdESFVqaXU2dlVNSUFBS2ZOUHFGNmQzS01q?=
 =?utf-8?B?c3Y4NzFYeVY0VkVIUmpVS040MlQrS3I1QXVYanYrY0pOVW9VQUtQa1ZuUkxS?=
 =?utf-8?B?UHgrVWQzVFk1dDV0dEFvZ0d6S0tEZ2FKUytPSmQ5dVlzMWNnWnhGaDhDR3k1?=
 =?utf-8?B?by95dnhkNjJxbGhQcnBiK0pWZnhBSUhOYlNhbkc5TTY0VDltQnBJSDNFcVpo?=
 =?utf-8?B?U3pJejVQMEtTM2ppMHRzTEVVcktBNVloRWZWN0dob0c1S0VBY0tkRmdFZlV5?=
 =?utf-8?B?a01salphTzZOUFcxWmdTUm5rRHNaQm9BU0hkUjBrVGFKUFFCbk1DY2ltN1Rq?=
 =?utf-8?B?M0Q4bGN2S3JPc1gyNXlOZGVEclVyNmhDMHFyVi9mZ2paNCtxYUtLUS9zL29t?=
 =?utf-8?B?UStjWHVxZFhiZGsrUWxnRXVKQmRRaVF4VFgzaldFbUhvT1VLVURidCtSZXJo?=
 =?utf-8?B?OGhUY095Uzd5YnFLZ2JZOGc0dUp5OThJTUhwSUN4akhKdW83aGhXbEw1MC8r?=
 =?utf-8?B?SzlqdVkvenZNbTU0dWtqRE9OaU1BYWErb2FYdm9na3FiNUVGcGphUmY2MGY3?=
 =?utf-8?B?QlFpVElWQzA4RkovM3MyNlJxRWlxcWFNamtqemtMWm9UcjNyY0IraXVLYW1D?=
 =?utf-8?B?V3NlU05RcHJkNEhvUm1yTFFCUUhIdG1GVUJzYmZLZmpqdlBXUXJFc0tjTUFl?=
 =?utf-8?B?M0FsUjFBOGlYRW1KZC95TXE5eENvM2FTamNPbzhqVFg2SWRoUWhMUGtUdFJs?=
 =?utf-8?B?VWUrOVl6dDNuWHBSTjJZOGVlbFBVay93VEdRUXJiZmNYaml6Sm45T01BK3NU?=
 =?utf-8?B?dkRVZnkzT3Y2bkFRVTB2T1RtMEJhUkxUY3VLNHk1bE1teFZ6UHdRZEVSNTNi?=
 =?utf-8?B?ajg3M3NIOEpBWFRzcWNlNDV5MnhiVG9oYjFoc3lwTER2d01XUHRpalE4TWlu?=
 =?utf-8?B?SlQyTVdHRk1vWGRxcDA5WlY1ejRsSnJBREVPbGNUNWJTMTdTOG15bXgyeWNk?=
 =?utf-8?B?V2hzYWpoMXJNZSsyVFcrRHNsWkZOOXF0RTFDa2VJR1lEd2RuVUplWTV2VUJp?=
 =?utf-8?B?TVpZL1JQQngrWURIUlNtZkljVnZuTHdZbDd1L09jWVUxam9ZdXpyMnU4K0p5?=
 =?utf-8?B?M1Y0YVl3UXllMEx1dTNSMDBFSlJtZmw5N2V5Uk93VW5zWDdZY2lCTjR0cVJS?=
 =?utf-8?B?bHFaY21rOUhpTkorT1I5cnZFMmdLQ1RLQ0wzVTFKckc2TlI5b2Z3L05mZVRI?=
 =?utf-8?B?akl5bjdKU3FnT0NiTytrYkEyMUFxRGlnRzcrVnJ3c0ZRT3NOL1dqRDdPdU00?=
 =?utf-8?B?UUpIZ04rMVhsNnhLcjBtcnphUjhFSUtvQlFZT1g1Z1AzYkREY1hUNVl4RGI5?=
 =?utf-8?B?ZURTRHVRSHM5Nng3VXgyS3BTMnFzM3F4TmJPOEhYQ0RuTk9SQnAyRDdEbm1s?=
 =?utf-8?B?Qk14ZHJXV3BBczhwcDBLcURtSTI1SUp2cUZ3eFUwcVVacTdBeDF0RDNZKzdl?=
 =?utf-8?B?WFhvOFlRMXpDT2ZQdDdPTnlOdmU5b2hKWEUxa01Va0V1Ti81dVEraHhPSXNS?=
 =?utf-8?B?MDNpb01HaEtzZXFIOGNsd3JKWVVYZnJ3aTdWNHJjMHl3YkVVMk9WZ0EvTDVT?=
 =?utf-8?B?dlhDUk1MRVIvTmI5K1NZZXFyK2ZrYTdWTm1HS1FibnZPanV1WXdxeTJWQ0lW?=
 =?utf-8?B?cytsOEpXN2JUcldZbXJjZ3VIU3hyb0Z3S1NlWjg5YVJKWWxsSTZCT2pCYzQ1?=
 =?utf-8?B?NXpHOVg3QStSWVZvOSsyemZvbE1yOGpTOHpGbFczWDNNQ2VSUi9IeGNDay9W?=
 =?utf-8?Q?t32bi379pfGjgTCRmB4tiOM2Fuyhs6tZ/TU8C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	I19syV7ithTQVRSm7BRImP1UnqG8sX7NllVEYiFYl7mqYVnqEeqU+amH3lok7+zFqv+YZ5J/J84knp22Ag+MIrGtCWZBktI/xS2jr5NOPLRbSxWYWqqlY5Zw78Ce/9M2ntpRerjsqW1sx2T+KhzMG5QD6OMUk9IkknXz4TIbDMv8tl0ETi4Eu2GxIQlBEwp/ccd7XacMuuJjwlo9gPnISquZ/YmNtWpcnAbcIJNT+tkkUqpQ/dzNIi6e9EsAN0skkrNIX1AJw2MVvFWmvDOH26Yu++3clwqZRRp9qs3lZn650U1zPI645RrEqsoNm8YaeMEaMAMAdXk5Ohk4W6g16Q==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff3a19-a83b-4b7d-af00-08ded03d6f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 09:05:41.5305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxnpjPhsq1AVIbH+gJSJE2UBvNzhrchp11nvjJ8PvAUwoEajmev6Ti+BvQQ9NtrIUfYe7S8LFwUuSFF3xojE8XJE2h2sSbMLMee9Tr8RZXQ+31vXmEZ8rzP+25sPnhfW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12947
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 09:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23241

SGkgSmFuLCANCg0KPj4+IFNob3VsZCB3ZSBhbHNvIHByb3ZpZGUgYSBmb3JreSB0YXJnZXQ/DQo+
PiANCj4+IFllcywgd2UgY2FuIGVuYWJsZSB0aGUgc3VwcG9ydCBmb3IgZm9ya3kgYXMgd2VsbCwg
d291bGQgbGlrZSB0byBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggc2VyaWVzIGZvciBpdCBsYXRlci4g
DQo+PiANCg0KPldvdWxkIGJlIHBvc3NpYmxlIHRvIGRvIHRoYXQgdGhpcyB3ZWVrIHN0aWxsPyBJ
J2QgbGlrZSB0byBjbG9zZSBmb3IgdGhlDQo+MS4xMiByZWxlYXNlIHNvb24uDQoNCkFwb2xvZ2ll
cyBmb3IgdGhlIGRlbGF5LCBJJ20gd29ya2luZyBvbiBpdCBub3cuIFdpbGwgc2VuZCB0aGUgcGF0
Y2hlcyBzb29uLg0KDQo+PiBJIGJlbGlldmUgZW5hYmxpbmcgdGhlIGJhc2UgaW1hZ2UgYnVpbGQg
aW4gQ0kgZm9yIFNpZCBpcyBzdWZmaWNpZW50IGF0IHRoZSBtb21lbnQuIHdoYXQgZG8geW91IHRo
aW5rPw0KPj4gDQoNCj5UaGUgd2hvbGUgcG9pbnQgaXMgc3RyZXNzaW5nIHRoYXQgY29uZmlndXJh
dGlvbiBzb21laG93IHRvIGdldCBlYXJseSBmZWVkYmFjayB3aGV0aGVyIHdlIChvciBEZWJpYW4p
IGhhcyBpc3N1ZXMgd2l0aCB0aGUgdXBjb21pbmcgPmNoYW5nZXMuIENJIGFsb25lIHdpbGwgbm90
IGdpdmUgdGhhdCBieSBpdHNlbGYgYmVjYXVzZSBpdCB3aWxsIHN0aWxsIG5lZWQgc29tZW9uZSB0
byBsb29rIGF0IHRoZSByZXN1bHRzIChpZiB0aGV5IGFyZSByZWQpLiBCdXQgaGF2aW5nIG9ubHkg
PmJ1aWxkIG9wdGlvbnMgYW5kIG5vIG9uZSB0cnlpbmcgdGhlbSBvdXQgYW5kIGFsc28gcnVubmlu
ZyBvdXIgdGVzdHMsIHdpbGwgbm90IG1ha2UgaXQgYmV0dGVyLg0KDQpUaGFua3MsIHVuZGVyc3Rv
b2QuIEkgd2lsbCBlbmFibGUgc2VjdXJpdHkgaW1hZ2UgYnVpbGQgdGFyZ2V0IGluIENJIHdoaWNo
IGluY2x1ZGVzIGFsbCBvdXIgZmVhdHVyZXMgYW5kIGFsc28gcnVuIHNlY3VyaXR5IHRlc3RzIGlu
IHRoZSBDSS4NCg0KPkhvdyBhYm91dCBwZXJmb3JtaW5nIHN1Y2ggQ0kgcnVucyBvbiBhIHdlZWts
eSBiYXNpcyBpbnN0ZWFkLCBub3QgYXMgcGFydCBvZiByZWd1bGFyIGJ1aWxkcz8NCg0KSXQgbWFr
ZXMgc2Vuc2UgdG8gcnVuIG9uIGEgd2Vla2x5IGJhc2lzIGFzIG9mIG5vdywgSSdtIGVuYWJsaW5n
IGl0IGFzIHBhcnQgb2Ygc2NoZWR1bGVkIHBpcGVsaW5lLCB3aWxsIHNlbmQgdjIgcGF0Y2ggZm9y
IGl0LiANCmh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1j
b3JlLy0vcGlwZWxpbmVfc2NoZWR1bGVzICANCg0KVGhhbmtzICYgUmVnYXJkcw0KU2hpdmFuYW5k
IEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogMTggSnVuZSAyMDI2IDEwOjM1DQpUbzoga3VuaWph
ZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8U2hpdmFuYW5kLkt1bmlq
YWRhckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNj
OiBiYWxha3VtYXIgYWRpdGh5YSjvvLTvvLPvvKnvvLAg77yk77yp77y077yj77y/77yk77yp77y0
Le+8r++8s++8tCkgPEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBkaW5lc2gg
a3VtYXIo77y077yz77yp77ywIERJVENfRElULU9TVCkgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRz
aXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8pO+8qe+8tO+8o+KXi++8
o++8sO+8tCkgPGthenVoaXJvLmhheWFzaGkuZjc0QG1haWwudG9zaGliYT4NClN1YmplY3Q6IFJl
OiBbaXNhci1jaXAtY29yZV1bUEFUQ0ggdjIgMC8yXSBFbmFibGUgRGViaWFuIHNpZCBzdXBwb3J0
DQoNCk9uIDE2LjA2LjI2IDExOjQwLCBTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5j
b20gd3JvdGU6DQo+IEhpIEphbiwNCj4gDQo+PiBTaG91bGQgd2UgYWxzbyBwcm92aWRlIGEgZm9y
a3kgdGFyZ2V0Pw0KPiANCj4gWWVzLCB3ZSBjYW4gZW5hYmxlIHRoZSBzdXBwb3J0IGZvciBmb3Jr
eSBhcyB3ZWxsLCB3b3VsZCBsaWtlIHRvIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCBzZXJpZXMgZm9y
IGl0IGxhdGVyLiANCj4gDQoNCldvdWxkIGJlIHBvc3NpYmxlIHRvIGRvIHRoYXQgdGhpcyB3ZWVr
IHN0aWxsPyBJJ2QgbGlrZSB0byBjbG9zZSBmb3IgdGhlDQoxLjEyIHJlbGVhc2Ugc29vbi4NCg0K
Pj4gQW5kIGFub3RoZXIgcXVlc3Rpb24gd291bGQgYmUgaWYgd2Ugd2FudCB0byBoYXZlIGEgQ0kg
cGlwZWxpbmUgam9iIGFzIHdlbGwsIHRob3VnaCBvbmUgdGhhdCBpcyBhbGxvd2VkIHRvIGZhaWwu
IA0KPiANCj4gSSBiZWxpZXZlIGVuYWJsaW5nIHRoZSBiYXNlIGltYWdlIGJ1aWxkIGluIENJIGZv
ciBTaWQgaXMgc3VmZmljaWVudCBhdCB0aGUgbW9tZW50LiB3aGF0IGRvIHlvdSB0aGluaz8NCj4g
DQoNClRoZSB3aG9sZSBwb2ludCBpcyBzdHJlc3NpbmcgdGhhdCBjb25maWd1cmF0aW9uIHNvbWVo
b3cgdG8gZ2V0IGVhcmx5IGZlZWRiYWNrIHdoZXRoZXIgd2UgKG9yIERlYmlhbikgaGFzIGlzc3Vl
cyB3aXRoIHRoZSB1cGNvbWluZyBjaGFuZ2VzLiBDSSBhbG9uZSB3aWxsIG5vdCBnaXZlIHRoYXQg
YnkgaXRzZWxmIGJlY2F1c2UgaXQgd2lsbCBzdGlsbCBuZWVkIHNvbWVvbmUgdG8gbG9vayBhdCB0
aGUgcmVzdWx0cyAoaWYgdGhleSBhcmUgcmVkKS4gQnV0IGhhdmluZyBvbmx5IGJ1aWxkIG9wdGlv
bnMgYW5kIG5vIG9uZSB0cnlpbmcgdGhlbSBvdXQgYW5kIGFsc28gcnVubmluZyBvdXIgdGVzdHMs
IHdpbGwgbm90IG1ha2UgaXQgYmV0dGVyLg0KDQpIb3cgYWJvdXQgcGVyZm9ybWluZyBzdWNoIENJ
IHJ1bnMgb24gYSB3ZWVrbHkgYmFzaXMgaW5zdGVhZCwgbm90IGFzIHBhcnQgb2YgcmVndWxhciBi
dWlsZHM/DQoNCkphbg0KDQotLQ0KU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2ll
cw0KTGludXggRXhwZXJ0IENlbnRlcg0K


