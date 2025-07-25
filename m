Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7047C83F26
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 00:40:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.9084.1753403996117949803
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Jul 2025 17:39:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=U6PLaUwq;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1753403993;x=1754613593;bh=GNWAJVRdzFt6nDXpwH3rVohsADeJ26Z7rCVb8Fh
	/H5o=;b=U6PLaUwqSNxedPrOYRHH1F4rx50Zbfs+J99oJg2S9tA4reV9XjBm8Zsbx12eg9dNo+xjR
	pWCJqub0rWRXVHv3TTaWdwlBN5dqNUXlxitZIu3QNnnc4IOUTsur2ZlWGMTKurLGNeVpt0SrZEHNC
	Dt9SwnBQ8BOBfik0wt12TKcXIsAE9LDHNBfAVmERapKtlCivFzTy2cPayI6vmsBIRT6QxkFSRSvay
	UsZ9aU+4MJvccikavvPGBmsaSeGUzmwoSmciaKI6IMAtOPFe09gIbK3EIt9LgEIwSVMwWF6MESD0i
	VJht4Q8C+c5z79hEDSlFL4pWFP8ygi6ntwMXKxEv0Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 56P0dqs93057986; Fri, 25 Jul 2025 09:39:53 +0900
X-Iguazu-Qid: 2rWhEqwpnJnrBzS1NT
X-Iguazu-QSIG: v=2; s=0; t=1753403992; q=2rWhEqwpnJnrBzS1NT; m=YnUiD0nMOWRb71xNufnpRRY7BY72zBIceiLcJIgHGi4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 56P0don01245248
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:39:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InQzkO7sr4lNcryJ9gytB1jEJDufLttOnZL92XzfUjKM1ZEurpYVV34/H/bGNwTlfDt947H1pUm4rtqKXSESrVIjGyoNnoTUw+jXrXceCTz2r/Yxp/GYDoEclOYZA7wTw/yqfCUQHMc5mXhP580JkBptARF9THQxl/J9vVe3u+rY6Wq+QqDblVZxsyZXw3hEaBFS+OCU6rbhgC6oS1xhKYnw9XbuWtf6zi/ccrXw8pZaTBywPm04YMOTZtULZRk8uPuok27kdlGrqYxd7D/Qg+rxGiMYYiCAElEM09WYnUSV8dda4hjfgXNDBe/SpbX2mPiC3ML+PfrNNddus2HQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNWAJVRdzFt6nDXpwH3rVohsADeJ26Z7rCVb8Fh/H5o=;
 b=GmOCxIxX69TP8i+9+2kY8+GIp6x57xiZA+NvMC+KhTyoplw53bnqYgnnfgYikdIEeLaXLWm/inXdJmrn8tamzon/d7xwlc+79dKfe76M4MA+bxtTzzoxIFm8bzbcrgN0M56dJJkaeVu23JmFwEgY+2baJj7lsgB10YniKu0FRqgskAfsvbJgVByqyXzt/oBitQ44Nc8GcfgIE2OYpuHDibKgzKCr737gPnnUFJ0pMbW0+j+9k/Rwi1+IzqzJd3kvn+q1ej2bnNA+tlnS46TbuNVVIL5VkPDm+hfgo5wqewnNzzKvUoe0NY6KVB/ktxiGVVzbeHYnyfABSHCYl+1TtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <nicusor.huhulea@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plug
 Detection and build/runtime issues
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot
 Plug Detection and build/runtime issues
Thread-Index: AQHb/D8TcyBMW+EZ/EueJllMNsS+G7RCAD7w
Date: Fri, 25 Jul 2025 00:39:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183384926CD579DA7618F89259A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
In-Reply-To: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8338:EE_
x-ms-office365-filtering-correlation-id: aad28987-cfde-4ea1-4047-08ddcb13c2b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Q3pKd05ZTDVqaHJLUmFFZXRXK2JaN2NEeGtURjh4Um5vYXVGZG9kVG5WQmV0?=
 =?utf-8?B?VnV1ZkRPM0xuUlg2TEJYS3Q3T2FQSW9ZZEhqaUsvZ2tJNitWWm5KZ1dqbkVU?=
 =?utf-8?B?N0daRGIxM0x0QjBBckJqLzlFNjk3eCtab3F4NHM2ZWllQjlVWFBvUXVKUExz?=
 =?utf-8?B?QTNTdk1hbTB2ZW52WDJFODBPcmlXNGMwTjh1TG5ldzRGdUNYTENCQ1BTNUFi?=
 =?utf-8?B?RFpNbi9SWG9KWW42ZENnSjdGY2cxUi8ySThQN3dYVjI4MkdHV2lXazVMNElQ?=
 =?utf-8?B?TDNZQnNlcjlJK25sRmN3Z0pnM09vRU5KZ3Z1YnNRRGI3amdjWSswcytybTVj?=
 =?utf-8?B?MFgvTldvajNKLzB1c3lzZEFMN3JLZmNoaXFtdzlwQ3plM2tCUGRpdFpJMEN5?=
 =?utf-8?B?aTlmS2M5T3ZZNlFFWjY5ZGh0emhBaUJVNzE1MjZsWkZmSkpsdjlVbXQvZVlJ?=
 =?utf-8?B?eERhSTh5R2w0cG1rZVpDaVJrSFd3ZTR2eTBpenIzVytiYTRDMytlNGtRMDhZ?=
 =?utf-8?B?TFRRUFY1VURHcThwUDBmWUlCdWxGell1TTNSNWM2c2htbi9ySGNnanBjNzhV?=
 =?utf-8?B?bEVHTDlQK3cvby9WaGNZYTlrbzdSZ0lpbGVGQnZPTUJKS1pUcFF4U1BSYyt6?=
 =?utf-8?B?MFl5RWFmR29XcDhWd3FyQ0U5TWtrYnUxZ2lqTE9hY0J2UmVuK3B0a2pWVkZI?=
 =?utf-8?B?cytxNm4rWHFYcWI4MTFib0hldFBrb2NyM2hTd2xYTXIyMmQ4MTB1dVhrZVNt?=
 =?utf-8?B?K1ArTGdabnk4QlZIaEplbWg4cWZncVRsU3NPWFp6VFRVeldkejdWZmZuL3gr?=
 =?utf-8?B?RWFoOVUraWN2S1hqdWVGQVRFL3crYi9Rc01objRITTQwVExiU2hqb3I3cWxJ?=
 =?utf-8?B?enZ3Y0Iva3B1eDY0SDBGclRENkhwYzdJNDczcmhRaDFyZmFPZG1Qd3crTjIr?=
 =?utf-8?B?UnRVcWc0UW9DdXZMdWFWN3dBbjdqTUZaTHNUaTh2MHA1QXpKUnhoNkluekky?=
 =?utf-8?B?RlNGa3hONTVmOWtkU1Jqck9FaFVnbGI2cWFFczRQYzkvRGVHUWl4Vkc0U09H?=
 =?utf-8?B?bERFN0hzSzcwV3ZmV0gzekhWS3R6ZHJVbFhGSUt0RG82ZDFvcFVKL1pzeFo4?=
 =?utf-8?B?ajFlTGFmaVB2aEpNNWtEUUpNcnF3VDJvOVVjbzFGdXFVN2VsejFReVpaKzFs?=
 =?utf-8?B?VU55Y2JzM2V5SG5XRVJmZ1dLbGZoQ0NsQnZwSitBcy9KemFLNU1LMjhMVG4w?=
 =?utf-8?B?MUg5dThjZWFrbWY4b1FHZ0c0TjdOcW1uMUxYMC9Nb1FiUys3dEF0OG9XUy9I?=
 =?utf-8?B?Ris5UVpiYWl0akdlY1lNZlgrSjJuTXRjall0YlErSng1c0g4K3ErZmlabUpD?=
 =?utf-8?B?NHRpMUJ3S0h5akU0b2hZL09ZdEZTb25mNWdYV1FMVnZTM2xZSk8wVkMvemNz?=
 =?utf-8?B?akVMK3R5OWJleDI4dGU0RFIveHluKzRrWml1N3J5ZTMzcjQ0aXk3QzRodnov?=
 =?utf-8?B?QWhlclZ5c2NGdC9TNU9IUlowdlBiVlQrMTVGOVhlZDQ3Tk9aZEdlWXhRWm1X?=
 =?utf-8?B?dWFoWlBvWFhRdlhpRnp6b1BrZm1ZZXVROTgwb05zci9ibzF2SjlTRUtYL1py?=
 =?utf-8?B?QnFHVTNidWx1VUJidHRSZmFBd2Z0ZzNsby90SkViQU1WUlg0cEdBUDRKVS9h?=
 =?utf-8?B?elhzRmhDSjdrbm9FNUd3RmNJbVdvdUJUbklYNUt3d0JjcitZVklta1ZFeDJH?=
 =?utf-8?B?S0h1aitlcFVMZVk2NnBBaVBuNnVHTVJiNGxoWkp6N29PRjBkMDBXQjgwbHhD?=
 =?utf-8?B?ajVackZzc3EvL2ZFOVA3dXJWVTJQY2JsVDVLbEl5RS9PbUh4WWlHbjh5Q0tZ?=
 =?utf-8?B?ejVrRnJLWEhDcFY5a3dIbDhDc3hpRVhhSEhZK0tvRWdPY3BEaE9qcld5T1FO?=
 =?utf-8?B?czhOUm1jQkNyMnJOZzU4bFVsaUlueGdEQzkwek1VUnJ3ZlNZWC9ETGcwYlVM?=
 =?utf-8?B?M09ySmJhcnVnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OURTdHoyZ0hNYk9sM2RCZDAxNmV1N1BNaFpLcFNIUGw2bEhFTlRqNElSdEtI?=
 =?utf-8?B?QVcvc01kMVZ5T1h4Q1B2RVVRc3NIL3NkZ3gxOWhBTkFRU0Z1WWtzcjZ6dzZ6?=
 =?utf-8?B?TkVxa0tmQjk2UWw1TTM3NGdFaTFRaTRoei9mdUN6bkFpOU95eW95OFJ6REt6?=
 =?utf-8?B?OFNtU0xkakhjc1RyZFdwZG9WL2xrZi9UZTBTWnA0czJSaE5xc21WUDZaVUhD?=
 =?utf-8?B?dGhMOGdVMDY5NEJ5NjhJMGEwOHNtQ1RZSkEvSlJ0VkxkK1VSWUVMVW5TcVNB?=
 =?utf-8?B?bWpNK0U1TVNEdEFzMXIvc0orUCtmdDNyeUNBYUs5VmV4b2VQRHdjMXpyVmVP?=
 =?utf-8?B?dHNqU0oxUnFPL1grb1o2MnBhcVVyMkhSc1VScndrcW9FeW9wS1V5dWk5NE9p?=
 =?utf-8?B?ZnpvVnNac3RCV2pnSDdzTGxidG96Umd5Vk9JMUNLU255Rng4MVZoZWNZNU5j?=
 =?utf-8?B?UjFLdEsxY3hCRXRiZEFTNWh4VjR2cjBxUVpVMXRNLzhKSWlyeGViVXVJd1FR?=
 =?utf-8?B?NHhSWis4ekwzeVE1ZEdISmZpdmVoVlUrNEdRYmZUK0liY01MZ2xzRWROeGt0?=
 =?utf-8?B?WEJ1TlNhaHMvYzRoYjU2RmtCT21xVWprNTI4aHg3anBHcVBIbHMyOEc5dWlm?=
 =?utf-8?B?VUV2dEdaOXZrZ2RPWHlWRDAreGdoc2tiaEFybnRRaVVSVUY3dEVKaHFlZjZv?=
 =?utf-8?B?T3htalFuaUh4SFFTbTMyL2ppTkxUK0taT3gwWmFLb1ZqQkZibTc1WUVkcjNT?=
 =?utf-8?B?dy9TTkZleFhnV2QyZkhQVEZZd081cTRoUUt2aDhXY3NkRHpjVEdkb1A3a25u?=
 =?utf-8?B?djhIaVp0S2ZZeldOdGYyTkFYZHZPMkYvc1FsVVZzcXhVYnlIeWVzUTJRYWpP?=
 =?utf-8?B?SXRVZkh6S1pYSEhpR2dDTVBDYjNSd2o4MjUzRkJrM0VGcXRJS2NkYVRrWUU3?=
 =?utf-8?B?RXlrdkpiTDhjUW4yRFJrYnhDSElmUm1oZVpteDBoUGxYTzhUdm42d090MmtI?=
 =?utf-8?B?Vndaak80ekZMNGdFa3JMVnh6M1JhTXJSdDRadC9kR3FvLzNHSXAwOGtNMzFM?=
 =?utf-8?B?NHUvb2lyMGtPVUV1cXF2c3Y2c3JHakU0ZmxIWS9wMmJFZTlFNFpMRE5QOFQ1?=
 =?utf-8?B?S3NOMnFKQU5YVGxDVUw0K0JSNVp5SGZZaFU4R2xUMDN0eDVlbllYS3JnWkxt?=
 =?utf-8?B?a1gxTzdJclJiTWNvclpJWXV6cTQxcWRMZGY0MDF6VjR4aDlvcVJTQWpnbEpP?=
 =?utf-8?B?QjNBUi9pTWoxaGg1b3ZWZmxqM3JrdHNHM3ZyZ3BFRlJGazIwd0srSnE0SGpI?=
 =?utf-8?B?VmJ5K2JqRjd6QnJBc25DK3pMUFpPWmp4WUY4WDROMnlTZ2h1U3liOXp5M05X?=
 =?utf-8?B?ZSttVDdqUEJhM0tJTkdzSXZtR2lNY2NMNUlEQjlKdHNNSmpBUmg3c1BESnRz?=
 =?utf-8?B?QmxKMjhiVjduYmJ0cWloVEE4U1V1MU5ZNnp4d3VvZE4ydVJzdENiVnJiVVY4?=
 =?utf-8?B?bWV3OW1nelRkWWF2TUg5RDY1Y1RhQ08wU25mRG5CMk9aRlROR3FFUDNZQXFk?=
 =?utf-8?B?Q0s5SGU2MUxMaUlaQVltUS9lQWlYeUNWSEt6YVI0QWg2OGhNcXp5b2l3Slps?=
 =?utf-8?B?SWN2bXVPZ3ZnS2h3NHlWdzVWcWo3Q0p0UFByenlUSFgraUtnbkpsYWlRRTk0?=
 =?utf-8?B?dHZLY2ZaU0dEZ0V4a0tLdXF2MGQrL0RPWU1kNWZYYnpyOUc0Uk5qTllnZVhi?=
 =?utf-8?B?enJWVjVYckw1WUR6cTEwZWJkaTE3M0hNYkpLejNrMG5DYVJOYzFMZTE5di83?=
 =?utf-8?B?YVVZSlc4QWl3M1JDeTVjQXZmMVFldy9DV053NGkyS0dhQ2o2VFV6WmJ5QkpC?=
 =?utf-8?B?WGpWckxEbFZFYXBCSGRhT1ZjVVZTRnVzWklWcjRSMXp5dUIvcVE0NTNFM1BC?=
 =?utf-8?B?WFBwejYyQXhNa0dmek95ZldrNENrWTFXbTBKVXcxK1A5eVVVbERjd1E3RUU0?=
 =?utf-8?B?eEpKTTd6N1lqVzBTU1Z0cm03c0JvZm1xYXNQRllQa3JUb0IwR29ETTRONU1q?=
 =?utf-8?B?cFNIZ0RWSjkvem9hVnFVaWFjdzZ1RCtKMUpZL1pYbG1IN2EzREFqaXR2V0pi?=
 =?utf-8?B?bFVyUnRNeHN1c0E2dThkZ0Q1YldPTzQ5bGJpc0N3OTNHaHZkZHZvOC9Da1Ur?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad28987-cfde-4ea1-4047-08ddcb13c2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 00:39:48.7757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zl8VufK5X/8vAZtdJOKHreqAR56kILf2TyW8mWlnFt1nUWLfViVciWMiJy9knOiqeiu/KwR5KROEkxBPEdMKCgxPGKCV/ppM/Hgaq5foQDKbmBmKGAL2GGllXcyBBx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Jul 2025 00:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19589

SGkgTmljdXNvciwNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQpJJ3ZlIGxvb2tlZCBhdCB0
aGlzIHBhdGNoIGFuZCBpdCBsb29rcyBsaWtlIGEgZml4IHRoYXQncyBuZWVkZWQgbm90IGp1c3Qg
Zm9yIENJUA0KYnV0IGFsc28gZm9yIHRoZSBzdGFibGUgdHJlZS4NClBsZWFzZSBzZW5kIHRoZXNl
IHRvIHRoZSBzdGFibGUgbWFpbGluZyBsaXN0IGluc3RlYWQgb2YgdGhlIENJUC4NCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIE5pY3Vzb3IgSHVodWxlYSB2aWEgbGlzdHMuY2lwLXBy
b2plY3Qub3JnDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyMywgMjAyNSA5OjU0IFBNDQo+IFRv
OiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogTmljdXNvciBIdWh1bGVhIDxu
aWN1c29yLmh1aHVsZWFAc2llbWVucy5jb20+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBbUEFUQ0gg
Ni4xLnktY2lwIDAvNV0gZHJtL2k5MTU6IGZpeGVzIGZvciBpOTE1IEhvdCBQbHVnDQo+IERldGVj
dGlvbiBhbmQgYnVpbGQvcnVudGltZSBpc3N1ZXMNCj4gDQo+IEhlbGxvIG1haW50YWluZXJzLA0K
PiANCj4gVGhpcyBzZXJpZXMgYWRkcmVzc2VzIGEgZGVmZWN0IG9ic2VydmVkIG9uIGNlcnRhaW4g
aGFyZHdhcmUgcGxhdGZvcm1zIHVzaW5nDQo+IExpbnV4IGtlcm5lbCA2LjEuMTI3IHdpdGggdGhl
IGk5MTUgZHJpdmVyLiBUaGUgaXNzdWUgY29uY2VybnMgaG90IHBsdWcgZGV0ZWN0aW9uDQo+IChI
UEQpIGxvZ2ljLCBsZWFkaW5nIHRvIHVucmVsaWFibGUgb3IgbWlzc2VkIGRldGVjdGlvbiBldmVu
dHMgb24gYWZmZWN0ZWQNCj4gaGFyZHdhcmUuIFRoaXMgaXMgaGFwcGVuaW5nIG9uIHNvbWUgc3Bl
Y2lmaWMgZGV2aWNlcy4NCj4gDQo+ICMjIyBCYWNrZ3JvdW5kDQo+IA0KPiBJc3N1ZToNCj4gICAg
IE9uIFNpbWF0aWMgSVBDMjI3RSwgd2Ugb2JzZXJ2ZWQgdW5yZWxpYWJsZSBvciBtaXNzaW5nIGhv
dCBwbHVnIGRldGVjdGlvbg0KPiBldmVudHMsIHdoaWxlIG9uIFNpbWF0aWMgSVBDMjI3RyAob3Ro
ZXJ3aXNlIHNpbWlsYXIgcGxhdGZvcm0pLCBleHBlY3RlZCBob3QNCj4gcGx1ZyBiZWhhdmlvciB3
YXMgbWFpbnRhaW5lZC4NCj4gQWZmZWN0ZWQga2VybmVsOg0KPiAgICAgTW9zdCBvZiB0aGUgdGVz
dHMgd2VyZSBjb25kdWN0ZWQgb24gNi4xLjEyNyAobWFudWFsL3N0YW5kYWxvbmUga2VybmVsDQo+
IGJ1aWxkLCBDSVAvSXNhciBjb250ZXh0KS4gQnV0IGl0IGFsc28gaGFwcGVucyBvbiA2LjEuMTQ1
LWNpcDQ0IFJvb3QgY2F1c2UNCj4gYW5hbHlzaXM6DQo+ICAgICBUaHJvdWdoIHRlc3RpbmcgYW5k
IGRpYWdub3N0aWNzLCBpdCBhcHBlYXJzIHRoYXQgdGhlIEhQRCBmaW5pdGUgc3RhdGUNCj4gbWFj
aGluZSBvciBwb2xsaW5nIGxvZ2ljIGluIGtlcm5lbCA2LjEuMTI3IGlzIG1hcmdpbmFsIGZvciB0
aGlzIGVkZ2UgY2FzZS4gRGV2aWNlDQo+IElQQzIyN0UncyBiZWhhdmlvciB0cmlnZ2Vycw0KPiAg
ICAgdGhpcyBrZXJuZWwgZWRnZSBjYXNlLCBsaWtlbHkgZHVlIHRvIHNsaWdodCB2YXJpYXRpb25z
IGluIHNpZ25hbCBpbnRlZ3JpdHksDQo+IGVsZWN0cmljYWwgbWFyZ2lucywgb3IgaW50ZXJuYWwg
Y29tcG9uZW50IHRpbWluZy4NCj4gICAgIFNpbWF0aWMgSVBDMjI3RywgZnVuY3Rpb25zIGFzIGV4
cGVjdGVkLCBwb3NzaWJseSBkdWUgdG8gY2xlYW5lciBlbGVjdHJpY2FsDQo+IHNpZ25hbGluZyBv
ciBtb3JlIG9wdGltYWwgdGltaW5nIGNoYXJhY3RlcmlzdGljcywgdGh1cyBhdm9pZGluZyB0aGUg
dHJpZ2dlcmluZw0KPiBjb25kaXRpb24uDQo+IFN1bW1hcnk6DQo+ICAgICBUaGlzIHBvaW50cyB0
byBhIGhhcmR3YXJlLXNvZnR3YXJlIGludGVyYWN0aW9uIHdoZXJlIGtlcm5lbCBjb2RlIGFzc3Vt
ZXMNCj4gbmljZXIgc2lnbmFsaW5nIG9yIG1hcmdpbnMgdGhhbiBJUEMyMjdFIGlzIGFibGUgdG8g
cHJvdmlkZSwgZXhwb3NpbmcgbG9naWMgZ2Fwcw0KPiBub3QgdmlzaWJsZSBvbiBtb3JlIHJvYnVz
dCBoYXJkd2FyZS4NCj4gDQo+ICMjIyBQYXRjaGVzDQo+IA0KPiBQYXRjaGVzIDEtNDoNCj4gICAg
IC0gUGFydGlhbCBiYWNrcG9ydHMgb2YgdXBzdHJlYW0gY29tbWl0czsgb25seSB0aGUgcmVsZXZh
bnQgbG9naWMgb3IgZml4ZXMgYXJlDQo+IGFwcGxpZWQsIHdpdGggb3RoZXIgY29kZSBvbWl0dGVk
IGR1ZSB0byBkb3duc3RyZWFtIGRpdmVyZ2VuY2UuDQo+IFBhdGNoIDU6DQo+ICAgICAtIEFkZGl0
aW9uYWwgbW9kaWZpY2F0aW9ucyB0byBlbnN1cmUgdGhlIGRyaXZlciBidWlsZHMgYW5kIHJlc29s
dmVzDQo+IHJ1bi10aW1lIGlzc3Vlcw0KPiAgICAgLSBDb250YWlucyBjaGVycnktcGlja2VkIGxv
Z2ljIHBsdXMgY29udGV4dC9jb21wYXRpYmlsaXR5IGFtZW5kbWVudHMgYXMNCj4gbmVlZGVkLg0K
PiAgICAgLSBUb2dldGhlciB0aGVzZSBmaXhlcyBncmVhdGx5IGltcHJvdmUgcmVsaWFiaWxpdHkg
b2YgaG90cGx1ZyBkZXRlY3Rpb24gb24NCj4gYm90aCBkZXZpY2VzLCB3aXRoIG5vIHJlZ3Jlc3Np
b24gZGV0ZWN0ZWQgaW4gb3VyIHNldHVwcy4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciByZXZp
ZXcsDQo+IE5pY3Vzb3IgTGl2aXUgSHVodWxlYQ0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgY29u
dGFpbnMgdGhlIGZvbGxvd2luZyBjaGFuZ2VzOg0KPiANCj4gRG1pdHJ5IEJhcnlzaGtvdiAoMik6
DQo+ICAgW1BBUlRJQUwgQkFDS1BPUlRdZHJtL3Byb2JlX2hlbHBlcjogZXh0cmFjdCB0d28gaGVs
cGVyIGZ1bmN0aW9ucw0KPiAgIFtQQVJUSUFMIEJBQ0tQT1JUXWRybS9wcm9iZS1oZWxwZXI6IGVu
YWJsZSBhbmQgZGlzYWJsZSBIUEQgb24NCj4gICAgIGNvbm5lY3RvcnMNCj4gDQo+IEltcmUgRGVh
ayAoMik6DQo+ICAgW1BBUlRJQUwgQkFDS1BPUlRdZHJtL2k5MTU6IEZpeCBIUEQgcG9sbGluZywg
cmVlbmFibGluZyB0aGUgb3V0cHV0DQo+ICAgICBwb2xsIHdvcmsgYXMgbmVlZGVkDQo+ICAgW1BB
UlRJQUwgQkFDS1BPUlRdZHJtOiBBZGQgYW4gSFBEIHBvbGwgaGVscGVyIHRvIHJlc2NoZWR1bGUg
dGhlIHBvbGwNCj4gICAgIHdvcmsNCj4gDQo+IE5pY3Vzb3IgSHVodWxlYSAoMSk6DQo+ICAgW1BB
UlRJQUwgQkFDS1BPUlRdZml4ZXMgZm9yIGk5MTUgSG90IFBsdWcgRGV0ZWN0aW9uIGFuZCBidWls
ZC9ydW50aW1lDQo+ICAgICBpc3N1ZXMNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX3Byb2Jl
X2hlbHBlci5jICAgICAgICAgICB8IDEyNQ0KPiArKysrKysrKysrKysrKy0tLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2hvdHBsdWcuYyB8ICAgNCArLQ0KPiAgaW5j
bHVkZS9kcm0vZHJtX21vZGVzZXRfaGVscGVyX3Z0YWJsZXMuaCAgICAgfCAgMjIgKysrKw0KPiAg
aW5jbHVkZS9kcm0vZHJtX3Byb2JlX2hlbHBlci5oICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAg
NCBmaWxlcyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQo+IA0K
PiAtLQ0KPiAyLjM5LjINCg==


