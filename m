Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8874.1794187854395305378
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 17:30:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ZlL5lp0y;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794187851;x=1795397451;bh=OIWUll/7B4/TrGVc9wlPIqtt9ROyEzT1lIMsn
	q3/Qt4=;b=ZlL5lp0yuYLdQiS87+W5eO+LPu8ihim8aLgikwRwAv9fXiRNPVFDfsCrsszNCuyYNUB
	9mZ7C9niOcsDHJNWVx4HOtK9Nz36NuX+lG1Wqsc3B9lVz4k2Binc72RfDND1ygYQqRz3CcjUTgegE
	YfKVMD5VXxpiM1bi0N4HXfmRnCoL5lPm/zlUQVzQX19YhEhOosj2W2flDZtCZw4TzV83Gm/oGeX0y
	ITd/u5NCnnVbY4FTk+zaTk9ngWAuqoTSW1DJ5kCfglPPS4Azk6u14WO5w1HHP4691bbEgV7Y8ozhu
	ARb9jLiPpQrdEVrQMbYt3p7aSXs/6P1Ep2kSPHpohEow==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6A91UpJ62323721; Mon, 9 Nov 2026 10:30:51 +0900
X-Iguazu-Qid: 2yAaCwNmB2NotG0C2y
X-Iguazu-QSIG: v=2; s=1; t=1794187850; q=2yAaCwNmB2NotG0C2y; m=pOXr76fvlHaYdE40UF7nH7pdSk3TwlN6XNgYhgLhBHg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNC0V30vJz1xnk; Mon,  9 Nov 2026 10:30:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPId3ulGrzdMr82WvfBC3mG7aUoLEpChNK1Y2CaCtazcGg0558adRR7nxLgF2AjU/dc1ku+Eovdq4MCzyP/2utjqNLdfQ2f66Hq42qqRlNo9vWiXI9EWXbl+VeywlO6HGT34jWeoMV3pNx22bl+Iw0h+I8zLIXA9RHu8EAodJ1AglofY3H624pFyWBLjStnCjnvWLGa/uxrga+U7D8m9QK0Y9ezNtBDV+OH6BjBjQg7cvGFu6JanYN+caM583pwCX2/L75031KEcyFncdllioNj8v8X8UY8ElFCANoO8AW2kpwZjwpywK4FKe1a5Njt7vxNRXDyQsXu3JLMhT2q5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIWUll/7B4/TrGVc9wlPIqtt9ROyEzT1lIMsnq3/Qt4=;
 b=c9MZ2KzVRp2vqBzdv0at5x13fxBCt5RsME932P37f3hBavl2Ims5WF6VGVkXoRBCB/HECQIqDFwUYne8LEDW+qzs8UU2CumV3UcHirzc/5hFhWYE7q5RktH+bYCWCG68J5a04fV91fOHz71vauyLfugLPavqz5pLasiS/sYuJSbw8O9PIqW8u9IAtOfbJTu+S932gtBsSrOr4d4PRT499HgV1WKN/YmNIIptS4E3BajOPfdnEZ5Ljz4oilE6G100aF7mOyEv8t9G5vBL6uaQFrEleqQ+2AvbAv7eq2J92m757P6onJZmvIE5nCK+ESnLx7XNA/hIZqJEN8homxCuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][RFC PATCH 2/4] u-boot: Revert 2025.07
Thread-Topic: [isar-cip-core][RFC PATCH 2/4] u-boot: Revert 2025.07
Thread-Index: AQHdbc5TAc11SyrZ00ucxBxT50mBpbcgyPyAgAQuOdA=
Date: Mon, 9 Nov 2026 01:30:47 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148189AD845368501556C558BCD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1793956065-3316-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <c78acef7-13a2-49b8-a8bd-3c54715e0ec9@siemens.com>
In-Reply-To: <c78acef7-13a2-49b8-a8bd-3c54715e0ec9@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB7826:EE_
x-ms-office365-filtering-correlation-id: 462496ad-1b5c-44ec-c09e-08df3e01150e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022115727099003|261022075727099003|261009223027099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: zKsehg/TM1HV4IG7BQtMyJIKJxXgwHvtPgvqMoClV5Kb99J62TjV2QJobKy09LRvc5M0O25evsNyYBm+AVNjzh+gI4kvMay+PI86O2bcFJKLDAnFTHNfo7wlUHk3AAT4dN84228/7ZIMSA6Q2JQhYm4Dd4MCqodNjJ42Li6bsQQh8KlKno8ZLIYb4CpyFlwOecs7mzwfjOkIp6N7oEemjtzYcMogdZUeNYfimMuo3XZ10P57Ps8mhPTP4CaiHaiSm5xls55SJ1qc20Uwt7+zHAuLXvvSUcf0Lf/OmD6Bt+yyvKvXS8vi4tvQtnnHisZajJdMQTlQyAHj1MWjW0G+wUKP01QibZ3KsPZh/TgDSTKuzxSXPDggvEecrOmHri8bUpLLQTwgb3m9YpsQrvgHEFhuyP7bo+yjKeZrNwRTLoHhFg+4UM6BpL9sOMRcG00iGE9v/Xk4dbS/Ao2plo/uIt0+QS8rF0GELLAnpU6g/HgUA9Gvw47cdyqfgWQ3p5aOxRUotE8csLCl+5tZlUdNodk/2PdYW4b6oxraYLVF6fOjMkNysTDDYLnmXj0udkPpVp5a7pKdysxlMy1Lspk7xnpCBhdqnc064QtpQpnkn035FuT+/O49Hy/cLwztGa4ZfIsmcAqpr/tAttzSy/1ei0SgVQvwLkSbMIpxSqvnPEq7zGqsC07tneJLFpx3tTvGRaMkJTsetXi3QwrJKrU4e3mP+71pBR1kdxw1h69HnvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022115727099003)(261022075727099003)(261009223027099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFBkZERzckp0RUxvSDBKM3BUZjM0SWdxbVY0a3BSUzNaQkxoLzJjR3EyanRz?=
 =?utf-8?B?eWk0eDdzNEx5M09SbGdUTlhKcjZxblRDTzNvVDhBTGIxbHNPSXovc3V2SC9l?=
 =?utf-8?B?dEdFZWV1SWROdElKV0wrNWZ4WmtVeDkwY211Sm1NM3IrK1NKWjJvSjFMWWJM?=
 =?utf-8?B?WnlQWkpPN05tQ3RseFdJYU03NEtkdTIzNFAybXFkUWJjN043WFZHMnV2aDQx?=
 =?utf-8?B?QUZZaXhhL0Q0cExzRU9JZTgxRS9uYVl6ZStaWlo0U055MmlIdWJxOFJ3TGY0?=
 =?utf-8?B?bXB5VThDRXc0dFROSUQ5K3lCMnhPem5ia29ISE9KMEk0YUw5Mi8wWEYrRFZL?=
 =?utf-8?B?SmtFbllzWHhHQlc3eEhyTlpSZFpGdWozalZOTXJOVnY4RE5Uc0tOSjI2eFN3?=
 =?utf-8?B?RmI4YmlTQ251ajBabUFubE1hU1JpV2kvdXhwV1pNYmJaNUlkRDhsRmROWEtv?=
 =?utf-8?B?MXFsT1lCcG1aWWQrdFEyRDRhbFJDMU1yM3NEdXBybVFYTXV4OFduZWNIRXlp?=
 =?utf-8?B?QjVsbVlvRDNQN1E3RnRLbXBZZ05pVGdXa0JsUEhQcTBJN0xrc1lCWDJNTk1H?=
 =?utf-8?B?aGtVakNMcXllUXN1bW9OZHFocmppUGl1SWVMN0dVZnZMSTZhejkwSkREbFFD?=
 =?utf-8?B?MUxTUFpiQjR5aFhvdUdoTWtqMjNGeVdwaEtFamtIa2ZwTmpobmdhd2NVNHJR?=
 =?utf-8?B?K3JZem1aQW5sSUE0MXowaHBLRWl6eDZWaVE4WE8yVFJrMDY4OFZtRG8vZm5o?=
 =?utf-8?B?M1dmb21nWmI2QytHQkFOanRYTytPTi9oY05GaTMyRElZbUZzSnFaT2FRUG51?=
 =?utf-8?B?TGc1WDBUaG8rc0hEcS9XVk5KNW5Nc0FuWjArRVRrYVpUOVR1MWlaTDkrajB6?=
 =?utf-8?B?ZTQ1M09wQmRjR3A4YXNzUzBuTTBhSytNN29USy8wT0dxSzd4bTN5OUxMdlZK?=
 =?utf-8?B?MmplVEl5c3NiRXhFLzU3aFVBWU9XSnNQWG5weHVNOEszbTJLWXBMYmVtMVFv?=
 =?utf-8?B?VHptT3VBS2t3MDErUTVldWc5NS9VQlJ1OXp6ckhvR0NHdlVuVC8xZ2lFWUZ2?=
 =?utf-8?B?VzRmZ053WDhZQ2hKV1plOGNvd3EvRzg0NDJIL3ZMOVlVTFZUbGg3UWdXMGNJ?=
 =?utf-8?B?cDFjYzh5QXNhSVBVdFJqL3d1T2hseDV5WkpSVXhPTUEwMDNzNXdZc0VlTzNZ?=
 =?utf-8?B?eXJLV1JwUFowZ2EwaWJhRmVJTENvMEM0bWdLMjdBUXNUNy9SRkluRFNEdFZW?=
 =?utf-8?B?RWF0TG9UZmhORVUyc1NCQlZxZ3c2TWFUQVhkRERmcGF2MVBvL2xrWEM3bCsr?=
 =?utf-8?B?emVTVkJzNlZBeTk3dSt6WVJoN0svUHBkaTg4THZJZkxCbi9WMW52NitueXRh?=
 =?utf-8?B?S29lQTZhMGI1MHNMSUFsSGFwRHF4dVJNVkFUM0VKZHVxT3JRQTBFSFF0c0lK?=
 =?utf-8?B?VG9WcFBkdTUvZnZxUUI3VlFuODB3VjByT0twOW1IcWJKaWluL2lTbll0MlZy?=
 =?utf-8?B?ZERpQWZHZkYwc0NaU3psL1VNZ0FUNG9oa3QyMGV1RzdIdHZacDEvbmRrOVBm?=
 =?utf-8?B?R1NGN3EweWJsWjBmZXk2QUtpV1YvZ3QwY2MxekRxN0xFS3F1QjRka0pSUitj?=
 =?utf-8?B?ZUJIUHpUYTcyYjdnS3MxeldSUzUwMVU4VzFqSjRSNkNDVDVHZDVnUDd3MFVj?=
 =?utf-8?B?ZlI2SXU3V3VKT1VqcnV1SjhwMHNwTTdrQmRLT0dCeXkvc3p4ZU9FRXBIYUNr?=
 =?utf-8?B?aERDN2d5T2tCVytPUXlGcm5WQ1hWQ1pGVWI1TmV4d2lnaCt4L2hGaTVJRm5j?=
 =?utf-8?B?NEFvWnhNeUJUMmNjbHBwcFhXcEVIbWpnRUNlR0Y1dzVCSWJFRU1NSFpHbXkr?=
 =?utf-8?B?Q0czVGtQWEpkbHNzN3pXOENIRVV1aDkvQTBIeUtMOXlYSDNKUVRkTHJiVWxR?=
 =?utf-8?B?ZkVMRDlSSlQxdGNMblBoL1M0bVFPUjVkUU9IOTZyZmhySkdFMWllWGhNVGJZ?=
 =?utf-8?B?ZnhidHhjYUFkTHkrWWlUSXdLc29md0ROcjNaRUlEMkVlM0grd0VzVVM1K1ZU?=
 =?utf-8?B?WHpCaGN0a01Pem5pSzRYRGhtb2M3ZnJya0sxUUNYbnVHb3Y3dGhpaFFsa2V4?=
 =?utf-8?B?QWNDTUZQNkpLOERiMEc4VWZ2S1p2bW8yOUErS0VRMVQyb2xrc0toMGxKbXJU?=
 =?utf-8?B?dkEvNStPU0JXclVYQW5VS3lkQUl5dUVrazlSbDl1aTQ3MkozNkNEOEFUbTdR?=
 =?utf-8?B?ejlRZU5uNFNYR0t3Vys2ZnQyM2lHZ3BZMlNSYm0xY1NBQ2k1d1Jnd2M0bUQw?=
 =?utf-8?B?YWc5VCtwMXRCYWhZL1pNM3NGdEtzT3lJbGhvWU82OGVTMGdHaDgwck0vWUpK?=
 =?utf-8?Q?e0f090qjGJgAFkv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0oRh7XRDiX8CJSqPvEN9iT4FBUrFTEvxH2o3+lEIaem1U34qwmw319UK02W5zOFDBtWFmh9OHRImgGJxtVdMZNk/lfN2KqIkimPIBa/ggTq+IBH11FB/UzAHLToFFw/U8S2Cqv8Z6Gw57dHppyPRMvk8ClI+tYvG0cjA6GgNkXNCPQrXOjENxnvau5/yZc7dl8xYc2ZMKn4UokkULMQz5x/3Ymyb1ouzzXP0Ig/a9VyqP5/dJPiTW/gPOuODA27WTnPL0lr85a9/bHved9w8+C2EFIJO62Ku75dBNOkwZkwX34hAsttFlEtwYeb/aTyGygt3+8+UkNe+eoOcKKohAw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462496ad-1b5c-44ec-c09e-08df3e01150e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 01:30:47.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzlO+14m6SUTkGgNLYxkCL5WuoHiv32pU1KnNaqNs1JMmzleGmae9Nw5SM2zfnwbXHwAbWhFnhsUBo21WmckTVA5QefZoP0+DjTNT8+MO+HhCOS45XQEuC+ApAcOc2bw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7826
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 01:31:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24666

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgNiwg
MjAyNiA2OjM2IFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8
pO+8qe+8tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRv
c2hpYmE+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBS
ZTogW2lzYXItY2lwLWNvcmVdW1JGQyBQQVRDSCAyLzRdIHUtYm9vdDogUmV2ZXJ0IDIwMjUuMDcN
Cj4gDQo+IE9uIDA2LjExLjI2IDEwOjA3LCBOb2J1aGlybyBJd2FtYXRzdSB3cm90ZToNCj4gPiBV
LUJvb3QgdmVyc2lvbiAyMDI2LjAxIGNhbm5vdCBiZSBidWlsdCBpbiBhICdidXN0ZXInIGVudmly
b25tZW50Lg0KPiA+IFRoZXJlZm9yZSwgd2UgYXJlIHJldmVydGluZyB0byB0aGUgcHJldmlvdXMg
dmVyc2lvbiwgMjAyNS4wNywgdG8NCj4gPiBwcm92aWRlIFUtQm9vdCBmb3IgJ2J1c3RlcicgZW52
aXJvbm1lbnQuDQo+ID4NCj4gDQo+IE9rLCB0aGlzIGlzIG5vdCBhIHJldmVydC4gSXQgaXMgdGhl
IGFkZGl0aW9uIChvciByZS1pbnRyb2R1Y3Rpb24pIG9mIFUtQm9vdCAyMDI1LjA3DQo+IGZvciBs
ZWdhY3kgdGFyZ2V0IGNvbmZpZ3VyYXRpb25zLiBQbGVhc2UgY2xhcmlmeSB5b3VyIGRlc2NyaXB0
aW9ucy4NCg0KQXBvbG9naWVzIGZvciB0aGUgY29uZnVzaW9uLg0KU2luY2UgbW9zdCBvZiB0aGlz
IGNvbW1pdCByZWxpZWQgb24gdGhlIHJlbW92ZWQgIjIwMjUuMDciIHZlcnNpb24sIEkgaGF2ZSB1
c2VkIGl0IGFzIGEgInJldmVydC4iDQpJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZS4N
Cg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8uaXdh
bWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gPiAtLS0NCj4gPiAgLi4ub252ZXJ0LVNZU19FQVJM
WV9QQ0lfSU5JVC10by1LY29uZmlnLnBhdGNoIHwgIDM3ICsrKw0KPiA+IC4uLi1tYWNoLXNvY2Zw
Z2EtRml4LW5vbi1BZ2lsZXgtdGFyZ2V0cy5wYXRjaCB8ICA5NyArKysrKysrKw0KPiA+IC4uLktB
U0xSLU9QVEVFLVJORy1zdXBwb3J0LWZvci1LMy1kZXZpYy5wYXRjaCB8ICAzOCArKysNCj4gPiAu
Li5vdC1nZW5lcmF0ZS1sb2dvLXdoZW4tY3Jvc3MtYnVpbGRpbmcucGF0Y2ggfCAgMzMgKysrDQo+
ID4gLi4uYXJtLVNlbGVjdC1DT05GSUdfU1lTX0VBUkxZX1BDSV9JTklULnBhdGNoIHwgIDI4ICsr
Kw0KPiA+IC4uLnNlY3Rvci12YWx1ZS1wYXNzZWQtdG8tbW1jX2xvYWRfaW1hZy5wYXRjaCB8ICAz
OSArKysNCj4gPiAuLi5mb3ItU1lTX01NQ1NEX1JBV19NT0RFX1VfQk9PVF9VU0VfUEEucGF0Y2gg
fCAgOTANCj4gKysrKysrKw0KPiA+ICAuLi4vMDAwMy10ZXN0LUZpeC1vcHRlZS11bml0LXRlc3Qu
cGF0Y2ggICAgICAgfCAxMzQgKysrKysrKysrKw0KPiA+ICAuLi5jZnBnYS1BZGp1c3QtYS1yYXct
c2VjdG9ycy1mb3ItTU1DLWwucGF0Y2ggfCAgNDQgKysrKw0KPiA+IC4uLm9uZmlncy1zb2NmcGdh
LUZpeC1kZTBfbmFub19zb2MtYm9vdC5wYXRjaCB8ICAzMSArKysNCj4gPiAuLi42LWNvbmZpZ3Mt
c29jZnBnYS1QZXJtaXQtRUZJLWJvb3RpbmcucGF0Y2ggfCAyMjkNCj4gKysrKysrKysrKysrKysr
KysrDQo+ID4gIHJlY2lwZXMtYnNwL3UtYm9vdC91LWJvb3QtYmJiXzIwMjUuMDcuYmIgICAgICB8
ICAyNyArKysNCj4gPiAgcmVjaXBlcy1ic3AvdS1ib290L3UtYm9vdC1jb21tb24tMjAyNS4wNy5p
bmMgIHwgIDcxICsrKysrKw0KPiA+ICAuLi4vdS1ib290L3UtYm9vdC1kZTAtbmFuby1zb2NfMjAy
NS4wNy5iYiAgICAgfCAgMjYgKysNCj4gPiAgLi4uL3UtYm9vdC91LWJvb3QtcWVtdS1hcm02NF8y
MDI1LjA3LmJiICAgICAgIHwgIDE3ICsrDQo+ID4gIHJlY2lwZXMtYnNwL3UtYm9vdC91LWJvb3Qt
cWVtdS1hcm1fMjAyNS4wNy5iYiB8ICAxNyArKw0KPiA+ICAuLi4vdS1ib290L3UtYm9vdC1xZW11
LXJpc2N2NjRfMjAyNS4wNy5iYiAgICAgfCAgMjAgKysNCj4gPiAgLi4uL3UtYm9vdC91LWJvb3Qt
dGktYW02MnB4LXNrXzIwMjUuMDcuYmIgICAgIHwgIDY0ICsrKysrDQo+ID4gIDE4IGZpbGVzIGNo
YW5nZWQsIDEwNDIgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPg0K
PiByZWNpcGVzLWJzcC91LWJvb3QvZmlsZXMvMjAyNS4wNy8wMDAxLUtjb25maWctQ29udmVydC1T
WVNfRUFSTFlfUENJX0kNCj4gTg0KPiA+IElULXRvLUtjb25maWcucGF0Y2ggIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+DQo+IHJlY2lwZXMtYnNwL3UtYm9vdC9maWxlcy8yMDI1LjA3LzAwMDEtYXJj
aC1hcm0tbWFjaC1zb2NmcGdhLUZpeC1ub24tQWcNCj4gPiBpbGV4LXRhcmdldHMucGF0Y2ggIGNy
ZWF0ZSBtb2RlIDEwMDY0NA0KPiA+DQo+IHJlY2lwZXMtYnNwL3UtYm9vdC9maWxlcy8yMDI1LjA3
LzAwMDEtY29uZmlncy1LQVNMUi1PUFRFRS1STkctc3VwcG9yDQo+IHQtDQo+ID4gZm9yLUszLWRl
dmljLnBhdGNoICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPg0KPiByZWNpcGVzLWJzcC91LWJvb3Qv
ZmlsZXMvMjAyNS4wNy8wMDAxLXRvb2xzLURvLW5vdC1nZW5lcmF0ZS1sb2dvLXdoZW4tDQo+ID4g
Y3Jvc3MtYnVpbGRpbmcucGF0Y2ggIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+DQo+IHJlY2lwZXMt
YnNwL3UtYm9vdC9maWxlcy8yMDI1LjA3LzAwMDItcWVtdV9hcm0tU2VsZWN0LUNPTkZJR19TWVNf
RUENCj4gUkxZDQo+ID4gX1BDSV9JTklULnBhdGNoICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPg0K
PiByZWNpcGVzLWJzcC91LWJvb3QvZmlsZXMvMjAyNS4wNy8wMDAyLXNwbC1tbWMtUmVzcGVjdC1z
ZWN0b3ItdmFsdWUtcGFzDQo+ID4gc2VkLXRvLW1tY19sb2FkX2ltYWcucGF0Y2ggIGNyZWF0ZSBt
b2RlIDEwMDY0NA0KPiA+DQo+IHJlY2lwZXMtYnNwL3UtYm9vdC9maWxlcy8yMDI1LjA3LzAwMDMt
c3BsLW1tYy1BY2NvdW50LWZvci1TWVNfTU1DU0QNCj4gX1JBDQo+ID4gV19NT0RFX1VfQk9PVF9V
U0VfUEEucGF0Y2ggIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IHJlY2lwZXMtYnNwL3UtYm9vdC9m
aWxlcy8yMDI1LjA3LzAwMDMtdGVzdC1GaXgtb3B0ZWUtdW5pdC10ZXN0LnBhdGNoDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NA0KPiA+DQo+IHJlY2lwZXMtYnNwL3UtYm9vdC9maWxlcy8yMDI1LjA3
LzAwMDQtYXJjaC1hcm0tbWFjaC1zb2NmcGdhLUFkanVzdC1hLXINCj4gPiBhdy1zZWN0b3JzLWZv
ci1NTUMtbC5wYXRjaCAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4NCj4gcmVjaXBlcy1ic3AvdS1i
b290L2ZpbGVzLzIwMjUuMDcvMDAwNS1jb25maWdzLXNvY2ZwZ2EtRml4LWRlMF9uYW5vX3NvYw0K
PiA+IC1ib290LnBhdGNoICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiByZWNpcGVzLWJzcC91LWJv
b3QvZmlsZXMvMjAyNS4wNy8wMDA2LWNvbmZpZ3Mtc29jZnBnYS1QZXJtaXQtRUZJLWJvb3RpDQo+
ID4gbmcucGF0Y2gNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhbGwgb2YgdGhvc2UgcGF0
Y2hlcy4gVGhlIHR3byB0YXJnZXRzIGRvIG5vdCBzdXBwb3J0DQo+IHNlY3VyZSBib290IG9yIE9Q
LVRFRSwgdGh1cyBhbnl0aGluZyByZWxhdGVkIGNhbiBiZSBkcm9wcGVkLiBJJ20gbm90IGV2ZW4g
c3VyZQ0KPiBvZiB0aGUgZGUwLW5hbm9zb2MgcmVncmVzc2lvbnMgd2VyZSBhbHJlYWR5IHByZXNl
bnQgaW4gMjAyNS4wNy4gVGhpcyBuZWVkcyB0bw0KPiBiZSB0ZXN0ZWQuIEJCQiB3aWxsIG1vc3Qg
bGlrZWx5IGJlIGZpbmUgd2l0aCB0aGUgdmFuaWxsYSBVLUJvb3QuDQo+IA0KDQpJIGhhdmVuJ3Qg
c2VlbiB0aGVzZSBwYXRjaGVzIHlldC4NCkkgd2lsbCBzZWxlY3QgdGhlIHBhdGNoZXMgZm9yIHRo
ZSBCQkIgYW5kIHRoZSBERTAtTmFuby1Tb0MuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8N
Cg==

