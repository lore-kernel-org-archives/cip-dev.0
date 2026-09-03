Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D1BC624A4
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 08:59:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3190.1788425960359532867
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 01:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=suFttSt2;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1788425958;x=1789635558;bh=OLk6M+3XqC7zRFcyKH46y30dAtwc7xES5IebS
	v1mrZk=;b=suFttSt2Xn1ASvyu2XsdUo31xAP+ST4M2OVbsGpcrakBsHN1sfMHUignG555CHWS3AU
	HgUypGn4QLtURbgFqa8GAtppB5XOl5/l/lHOBQ+LFBEoU2QliNTV9kjKA8usMNllzh0egOJRfyOSy
	kJlDzJJZxSKj8xwjcRnUojMw6KS2n9bj+/G8r1TBg61QypnhuDGz5RJc6w4HE0168VJFqAFjWcMt8
	k5p/9HjzMwN++rWpcjY+V5bz1YFFWLpvitXF17ovxMEAWOrSLh4c6CECeuF85MXRfZwtkyC00jc3y
	NeRfGUeXAUKobkrfsD6PpApKqzbSKRjslxKB0OUA6Ntg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6838xHTO2753642; Thu, 3 Sep 2026 17:59:18 +0900
X-Iguazu-Qid: 2yAbG25DVcJg54d6dG
X-Iguazu-QSIG: v=2; s=1; t=1788425957; q=2yAbG25DVcJg54d6dG; m=iKhPDsXmaeVkp77SBaAjcFn6RTGyf9irJLuP5WuRsgQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hbD6s3zgFzyPZ; Thu,  3 Sep 2026 17:59:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE0fp+Q0dOU+jhP6wjtzrk+QvbeYsfEgBKKF8CWLy1xh093nYFUZqDrBavQie4LFIRVUa3gknRjEvVivadmcqudEXyhBWoQupBKQ/7Bl6R0kAbN3Jwvl+ogukxELLuzbPBkvyBfPZDuz/VX1ftNQ7+HZ5ULPSJP56GfdnA3pTWEFxp1RxmCBS5SQdZg75b7ywEMuWEdgXa4MSPD3BsohujkalOmmV6UBsH65pmMQCctu2g7PiPnQaDUbuFB5tGHIv3vHtLZrjZfbVGcNjg6uQUT5CecnILkLv3JkZoMILNuJyuvlGobt6RV2H15Yo7sjEzrT2ajppw5xJQPSJD/+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLk6M+3XqC7zRFcyKH46y30dAtwc7xES5IebSv1mrZk=;
 b=nyrFBo7GsZXmznqF3GPU5vKhy9UqdZFLVfhNFzmbZkC4g3xHaTUOlRtguLMIUOVkdHyEKxK5+1FbmfuDsO8pCf6vrUt/HZs6/IPK2IfXlJqFbYjxzkVdcx0zEjsL6be/WUxlc4VrcFiASq/cHu2P0K9ZCFk7AGTQ4XdwZoxw4cIGZvgTli5DNIR+hkqu94XxC9Jryl8gdA6lSLp937FQg7DVbsK0SNbmzbcvoQt9j4E4WTzErb+ckEAnaHQGd50iA/xH5XyH60PGfGtOozQlfvGHxMz39qmjgUPIb8p1SbRXLywamkv07D02vc/9jENR8bCPeNf2LAok/m66LD4OsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHdO3byLiQsbrsCqEyPgH6H6rtKYba8jO5A
Date: Thu, 3 Sep 2026 08:59:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182257BB38C5FC2ABF36DDCDB62@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <85ce52ff-95db-4a55-a8aa-487a30348833@siemens.com>
In-Reply-To: <85ce52ff-95db-4a55-a8aa-487a30348833@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB17442:EE_
x-ms-office365-filtering-correlation-id: 7d687b0e-a952-4b6f-8417-08df0999a16d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 
 Vnqc/UHUoR6aNzcOi2TMNImJVvONvmxd2jnJ8SLQQm1DGemF8EFoC4joYmI1E5+FTVkHnGPc4iVFoewim4QZ7hYh0FbuorV8eBS+9aYgkKClXSYfhkBuqC3/5p1Jz9imQ1K0/4V2DKr3i9T6SWBhk0BcKMb99p3+MiU21+HIXmDSvKp6RDefSF0B75uqrDY6PfpRVM1hMkfVWAOeN16Xe2iOhRvfng5RyYt7+bsBFg6bNqOKS7eUZelLuesr2YzH61+gx0qxKbJnnaaOt/SoqedRe3lwtr+C6Y7MZ1PWZ2oV/6EQGm9Wq17tWPBP21SbSrH84LzZrFMWQnhsnlFtVXWnXWrk6zOUSGpLOntNQ/ImwYDtVS2AlgdWrDiiRxdwSZgBBLF6k5+b1KWPJBF+pcfME615pcPVMUyAN9dY6adjL/xbJHdRQH/KqcLPzZhGz2JnW8DlhsG3aSR4DD+XIePyHmX8uh2NwnFXngElLBRsAbx+QRPyHHlnSzTi79Zw43KOv4ya1/Ei2/NCen4/7ikpJqcsSJaaQWvNS6hMDrr9yMQf+R7r0MlfzWhxGFzQLOG4sNZRKceM5sbKSva/3cf2+SjXfy7JPUqbN+ZKgh6zWb/61NF3WFUocdqe+CJPIpoTMEqdOg1q00RSukTy35BAdI/gu3UajRjYzR9sd+s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OTNQa3BCc3FGNmJmaVhJdXpCTVZMU1dNelQ5bWFvbWhjMFRPVFdlNFRtcEQ3?=
 =?utf-8?B?SDlEUnc2TklSRk1mQTJPVWRLcDdZTVJ2eExoQWcrU0UwSzU4L3RqMkVoN0ZQ?=
 =?utf-8?B?K09PRWg0Z2JkMm4vaUI2Q2Q4K3B5OG1zTTVLemhGdi9FMjQ2U3hzLzZCdVpH?=
 =?utf-8?B?MTFiRGxvdjhuQVNiRElRRmx6WGQ5bmV2dWFSMytNam5oRlRlaXlQL0c5K0Z3?=
 =?utf-8?B?ZUpzUkZLaHBrNDNtNXdIWXNSUyt5dmQrNGJHYUhENjB3eWV1c3ZvWnpXV0pR?=
 =?utf-8?B?cDJ2Y041QW1ZV0d3b2N0MTI1UDhVUmVGaSsyV2RqR0k1ZTc4amRDWCt3RGkv?=
 =?utf-8?B?V2hSYnJMeXVTYmhEMFNQd1FLLzlEWnFZOHVLMnRmWmlvVXpVM3FpRTlPVDFs?=
 =?utf-8?B?TEZOU1hiRk9LVFFMQ0tSd2lDK3VLVDVJUm5NMm01NHV3QzFQNTUxTzJ1Z0hn?=
 =?utf-8?B?dUFqNGNEdHBWMWhtRmM2ZHZjNkpzOXZzNHNHMnhGcHN5empnU3hnVXpFb3ZT?=
 =?utf-8?B?cjJobngrUUVuVUFIWnpuVGdMd2Ridk5DUXUzS2JFR01TaDFoYTl3czNYZkFG?=
 =?utf-8?B?MFlQMlZoMGdMN3FJUUxVZkNLTFJjTmxvMnpRaXg1WmJKQ3VVTWpvdm5mMnQz?=
 =?utf-8?B?KzhWaHJXZVFjcDdKS1dBNGVwbW9sVXU3eG14YjlIY29STkpPMTN0VnlMcEt0?=
 =?utf-8?B?OFVndHFESTdSclI0MkVZZTFTR0xjRk03cVpodzlvZFl0UFVVUWtnNms1RWJn?=
 =?utf-8?B?eiszYytkUTV1ZTdJalA2U2d2RlZhT29UR285aFUrRXVWUC9GdXE0SDlrK3A3?=
 =?utf-8?B?Ung2aTc1cSt0RFQ3UUlCUU0wSDR4ZHBjQ2FZQVp3dVJDVnVWSVpybjNZa2dQ?=
 =?utf-8?B?MEtKRENQL0Z5bWx6Q1Z0ajMrcUNQNVlvaGtUZHMxSXhteWxkbUZMY0t3TkhB?=
 =?utf-8?B?MDJ3TEhvSmxVaVk0SkJPVW5rRWlZOHNBYVp0eTQzWUlUaTB2R3p3ZU1INGxy?=
 =?utf-8?B?SDFjdUhnUHN2MFo4WmdJUC93RDhuTTVxaDdZWmpJMzg2MGpiVTBFU0hTa3k4?=
 =?utf-8?B?a0hsZm9XbzJKdGpOMmtnKzd1R21NQzFwN2NzSUwxMzNoeWptOXNRWFRqMHpT?=
 =?utf-8?B?dEtXbHZGRDF3Z1A5Y3FvdldaOFlpSWZsVDRnV0J3U0tUMkJHZzFTWjhkN1hJ?=
 =?utf-8?B?ZEJnY2JsZlhVTlJESUNQWmxlWUEwdy9vYkJUNFVudllkZnRjbnFxalU3dFox?=
 =?utf-8?B?aG40c3dBaUxZelpDTkxXaSs4U3NWTTEwWmhnemhBRnJIYXN3b2d3M1QrYnZI?=
 =?utf-8?B?SkhoS2ZRZlRhQS9HNVNUTGcxY2xJdEkrTVJOb08xa1FrQWszK3RDTVJxZVhC?=
 =?utf-8?B?Ky9aNnBJNEZNbGJ0bzZYWU1IOUUxK0JaNzNqY3phZEdSemFzZ2ZrekR4Rkgz?=
 =?utf-8?B?ODZQRkZtSHNUbGx6RUFWY3ZvYndSR04zVXRaZ1VpZG9wUzE3ZnRLenQwd1M5?=
 =?utf-8?B?d0xWS0UyOEswZ3diaUptRzNpa3lwV1I3NmVXMVVPV3VHeGJYdng3NUIwQ1No?=
 =?utf-8?B?V0JJU3p5QzZqZHZYZ1V3SnYrelhXTDdEbmlLbjBNWDYrTENYbytIY1paeFp4?=
 =?utf-8?B?SWVEQ2k5N2FBMFNUUkV3YzNCSGdiK1diMVM4LzRraGJpVS9OUnJDWThQWWhI?=
 =?utf-8?B?MVd6NDJlZWJMaXdlOEZRQ2pDQ2lsUGI4NTVqNFZvLzU5SGtFSXlnaEY3UWQr?=
 =?utf-8?B?enh0c2x6bUxTc3lTL1gzdGJuTGRmVlpTS3lFTGIxNEUvSXJ2c3hWOFduQzg1?=
 =?utf-8?B?U2J4bm02d1hOalJ3VklBaGViT3BEVjRKR0YyTktPRjJLR3cwY09nSVM0S0tE?=
 =?utf-8?B?N0VRZUtZNVl5djVqN1dJN2FrZGlSbjN0RUtPSUtEMWt0OUk1VCtERlpHSzAv?=
 =?utf-8?B?aXliMGs2MktOdUl3TFJhTi9YVHZyb3RVSTVZL0JGSjBKTmU5NW9UZUxKcFhr?=
 =?utf-8?B?ckpXMzRkaTZTVlQ2L2c5M2pjdGtNUXV2bVlmajBrVjFJU21HWHNENW1aRzdC?=
 =?utf-8?B?TXZybHBWOG04RVB6SHhvZkNEbmFsMGxtNmV5WVNTZ2h1MTVwM3BvZW5YQW51?=
 =?utf-8?B?bXJjOFVpcWhIK0lNa2d0VlhZTmNNeHZmRzVKaEVjN1p6blFzQXIvWTcvMFBj?=
 =?utf-8?B?ditoNmxselM2YU81aHRrUkxqQWJzTUJQU2NDVTZib1h1WHB3MW4vVDB4MXE2?=
 =?utf-8?B?OVZMallRK0R0Z216T0srM05Vdi9ZTy9lRHRXazNyYS9JUnN6ZitDQXpOZzlm?=
 =?utf-8?B?NGVPVkt4WUlGcHlNMmZrNTNpdnN5eWxVUnJxVTRJOWlMQzYyejFFZ0lBV3Zh?=
 =?utf-8?Q?izA/1jRdxLWJNizQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	QR1qvo5Q6o7oqEKpGMKJkQGthN/kZyrjR2nRtqLJag3sREZt4xgdXRFG2d09kc3dP/tB1MMbnsWiOSI5zEfxoStOnOEUP8wDyWR+Ei7Fv/mGR2JO1uvta5kTX4HRIDov3OdsLtMhG9zNLE4eI75R5lnyHV7ii1IXCXGEgnEAhRWIDIB0WEhTDaNO8Ip4/8/iwmHWIPbX49JcRNbtAydYDBPmsx4szzX/VE3s836xvpb77NZqAOG1EcCA7nyR7zgOGgixzIoced0S6+yLJcOJzEcq0voMQ8vNHoUB0VpOGKfgTZvd3AvTJekF/XcxfrpXn5JRiqjFdFvZEUGDWg592Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d687b0e-a952-4b6f-8417-08df0999a16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 08:59:15.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PXF0g+8OVvn4nZT4JGT611MD+1jxZ3DrYBZ3bMiRPtGtw5/axtHW+ucUpoP/tQIo3NNreW4X8BsYLLg6JLBAYkch/tvdYgafr1wv17npi4aUUhfNu3JgGURBveG54ZU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17442
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 08:59:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24086

SGkgYWxsLA0KDQpJIGNhbm5vdCBqb2luIHRvZGF5J3MgbWVldGluZyBkdWUgdG8gcGVyc29uYWwg
cmVhc29ucy4NCg0KPiAqIEtlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzDQpJIHJldmlld2VkIHY2
LjEyLjk3Lg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgSmFuIEtpc3prYSB2aWEg
bGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMywgMjAy
NiA0OjM2IFBNDQo+IFRvOiBjaXAtZGV2IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4N
Cj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRpbmcgdG9kYXkgb24gbGli
ZXJhLmNoYXQNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRl
bmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MNCj4gdGVjaG5pY2Fs
IHRvcGljcyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuIE91ciBjaGFubmVsIGlzIHRoZSBmb2xsb3dp
bmc6DQo+IA0KPiAgICAgaXJjOmlyYy5saWJlcmEuY2hhdDo2Njk3L2NpcA0KPiANCj4gVGhlIElS
QyBtZWV0aW5nIGlzIHNjaGVkdWxlZCB0byBVVEMgKEdNVCkgMTI6MDA6DQo+IA0KPiBodHRwczov
L3d3dy50aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9jay9tZWV0aW5nZGV0YWlscy5odG1sP3llYXI9
MjAyNiYNCj4gbW9udGg9OSZkYXk9MyZob3VyPTEyJm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0xNzkm
cDM9MTM2JnA0PQ0KPiAzNyZwNT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QgICAgVVNFYXN0ICAg
IFVLICAgICAgICBERSAgICAgICAgVFcgICAgICAgIEpQDQo+IDA1OjAwICAgICAwODowMCAgICAg
MTM6MDAgICAgIDE0OjAwICAgICAyMDowMCAgICAgMjE6MDANCj4gDQo+IExhc3QgbWVldGluZyBt
aW51dGVzOg0KPiBodHRwczovL2lyY2JvdC53bC5saW51eGZvdW5kYXRpb24ub3JnL21lZXRpbmdz
L2NpcC8yMDI2LzA4L2NpcC4yMDI2LTA4LTI3LQ0KPiAxMi4wMC5sb2cuaHRtbA0KPiANCj4gKiBB
Y3Rpb24gaXRlbXMNCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KPiAqIEtlcm5lbCBy
ZWxlYXNlIHN0YXR1cyBbKl0NCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIEFPQg0KPiAgIC0gTExN
IHJldmlldyB0b29sOiB1cGRhdGVzLCBmZWVkYmFjaw0KPiANCj4gSmFuDQo+IA0KPiBbKl0NCj4g
RGF0ZSB0aGUgZGF0YSBpcyBjcmVhdGVkOiBUaHUgU2VwICAzIDA3OjAzOjAwIEFNIFVUQyAyMDI2
DQo+IGxpbnV4LTQuNC55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb246
IHY0LjQuMzAyLWNpcDExNA0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogV2VkIEF1
ZyAxOSAwODo1NDo0NSBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IEZyaSBTZXAgMTggMDg6
NTQ6NDUgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuNC55LWNp
cC1ydDogaW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb246IHY0LjQuMzAyLWNpcDEx
My1ydDYyDQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUgSnVsIDMwIDA5OjA3
OjEzIEFNIFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogTW9uIFNlcCAyOCAwOTowNzoxMyBBTSBV
VEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC4xOS55LWNpcDogaW50ZXJ2
YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb246IHY0LjE5LjMyNS1jaXAxMzUNCj4gICBsYXRl
c3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFR1ZSBBdWcgIDQgMTI6MzQ6MjggUE0gVVRDIDIwMjYN
Cj4gICBsaW1pdCBkYXRlOiBUaHUgU2VwICAzIDEyOjM0OjI4IFBNIFVUQyAyMDI2DQo+ICAgU3Rh
dHVzOiBPbiB0cmFjaw0KPiBsaW51eC00LjE5LnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkNCj4g
ICBsYXRlc3QgdmVyc2lvbjogdjQuMTkuMzI1LWNpcDEzNC1ydDQ5DQo+ICAgbGF0ZXN0IHZlcnNp
b24gcmVsZWFzZSBkYXRlOiBXZWQgSnVsIDIyIDA3OjQ3OjU3IFBNIFVUQyAyMDI2DQo+ICAgbGlt
aXQgZGF0ZTogU3VuIFNlcCAyMCAwNzo0Nzo1NyBQTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24g
dHJhY2sNCj4gbGludXgtNS4xMC55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZl
cnNpb246IHY1LjEwLjI2My1jaXA3Ng0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTog
RnJpIEF1ZyAgNyAwNDoyMjozMCBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFN1biBTZXAg
IDYgMDQ6MjI6MzAgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTUu
MTAueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uOiB2NS4xMC4y
NjAtY2lwNzUtcnQzMw0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIEp1bCAx
MyAwNzo0MDo0MCBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IEZyaSBTZXAgMTEgMDc6NDA6
NDAgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTYuMS55LWNpcDog
aW50ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb246IHY2LjEuMTgyLWNpcDU5DQo+ICAg
bGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBGcmkgQXVnICA3IDA4OjE1OjE5IEFNIFVUQyAy
MDI2DQo+ICAgbGltaXQgZGF0ZTogU3VuIFNlcCAgNiAwODoxNToxOSBBTSBVVEMgMjAyNg0KPiAg
IFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNi4xLnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkN
Cj4gICBsYXRlc3QgdmVyc2lvbjogdjYuMS4xODItY2lwNTktcnQzMQ0KPiAgIGxhdGVzdCB2ZXJz
aW9uIHJlbGVhc2UgZGF0ZTogV2VkIEF1ZyAxOSAwNjoxNjowMSBQTSBVVEMgMjAyNg0KPiAgIGxp
bWl0IGRhdGU6IFN1biBPY3QgMTggMDY6MTY6MDEgUE0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9u
IHRyYWNrDQo+IGxpbnV4LTYuMTIueS1jaXA6IGludGVydmFsIDE1IGRheQ0KPiAgIGxhdGVzdCB2
ZXJzaW9uOiB2Ni4xMi4xMDQtY2lwMzANCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6
IEZyaSBBdWcgMjEgMDg6Mzk6MjAgQU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBTYXQgU2Vw
ICA1IDA4OjM5OjIwIEFNIFVUQyAyMDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0K


