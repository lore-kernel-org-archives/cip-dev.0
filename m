Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2BCD1288
	for <webhook@archiver.kernel.org>; Wed,  3 Apr 2024 12:01:27 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.105])
 by mx.groups.io with SMTP id smtpd.web10.9238.1712145466878894413
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Apr 2024 04:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q1zBW0/A;
 spf=pass (domain: siemens.com, ip: 40.107.15.105, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+subFAv6/c8nP07W5abpzUuw6ybE5HzCRvpJx/HxPVvY8O8xc20+9XvRh/TVOizXryap0XMYVjESigNV41cuIsNFfDinw+ClCuaN/+ZO9SGIRCMiN2K+ZQ59RKJyGyrNfLpa9jj3RT8QbNpoo71il17Xu/r/xp8TQswoAeE1Y3+MplmTxp2kodkmObLckaIScXKZsTHSAB5ARVLzhZ1n1tUz1Ryrdj3H2B4RFI67CdmBgFuo6JzMvMgQ3dPztDrzckkOHwNS1BA7P1tzSeiwrVbR1g1S93DiD/sUBuAifl8J8nckpHRgEnt1V51dPDftm/102a1I78V0onWDyb1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7TpSevwp232zlUA808BySq3xB1Kjv6QnOX2NRWRFrk=;
 b=e0vSZsfu5n6UUGZo2IstZVFKBjjJRN9FN4qpMu+gKsY0BQ2+KBafbqmXeMlIeOrIvgpnoUZSDC9i1IAy59TNduBbtxHuuBt5cKv17QyE92YUaFAkdv/AZQSitfJlDCsGf49ghqI6puLSMlis6rN6uFK32C0/c+I1uohfDP8MDITTsKLqoHIiVUcyi32nQn+iODZmaxXB5+fwkn6OhuFCkoCtRyUgk523eeR5XUy2w2tlmaPNTqEH215gzuAF0D3LdoeTnVy/rtiGpkrUWLZy/+RU7BEcdpbY/VNZPSxddRzIaf2eWV+9gE8usLGd6BTlYDHpo1K9BKCD0P+xlG4n3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7TpSevwp232zlUA808BySq3xB1Kjv6QnOX2NRWRFrk=;
 b=q1zBW0/AdlPIVfmmYSQD+s9Js1YRzauvEvPO0a+pcagf8KpOCdkgeHXFHaf/E8Cs6R+8ZAdV9uIqYsD1EsV/NbDIEanC6vqcuGoy5TShcueEi8MbIBiRmQWLDAoqdwTW4z4CSf/WeXziff/goxCPp6o+gdd/2/IbV1K+zd5zWcq46QMy2nb0jFFmt3BoZhh2U7ARu+G3YKL+uZTYfXedU3GF/nnPE2b4RzIvdysrnLx0UwKzn++cnhZ/gsevC9lp64/u3zOl0Ogs54PtbCu/VfsvKSH8ttXXEoRtcF2glpnkVF7TE2UQJ8cYl/5LMo0yCMoqnWKPzfs2I4sc2FtL2g==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB9PR10MB5552.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 11:57:40 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 11:57:40 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
CC: "shivanand.kunijadar@toshiba-tsip.com"
	<shivanand.kunijadar@toshiba-tsip.com>, "sai.sathujoda@toshiba-tsip.com"
	<sai.sathujoda@toshiba-tsip.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core][RFC v2 1/4] swupdate-handler-roundrobin: Increase revision for Delta Handler support
Thread-Topic: [isar-cip-core][RFC v2 1/4] swupdate-handler-roundrobin:
 Increase revision for Delta Handler support
Thread-Index: AQHahb4gD7t08fQ/F0eKcyAznPGkVg==
Date: Wed, 3 Apr 2024 11:57:40 +0000
Message-ID: <7e2c146f03dc50cd1ae7778bf7b3bec7d8e10d91.camel@siemens.com>
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
	 <20240320103229.1078738-2-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20240320103229.1078738-2-Adithya.Balakumar@toshiba-tsip.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB9PR10MB5552:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SC1m4F9HVZ/MbXZvi2l/EoUzofyyCyVzpDdRcGnQTAl+yvu+fIJGhcvU8Ss46bgF9UbvmYzFhIKGM3XmTy+8q5welf2juqKPXr5hrZuc0GGhztn+JQNpzFLF1bPEZqi+giMi0mB5YHXxE/f2NbVx6CXHyU8EEQSB6TvlQt2MePMv1/RasSYEwoX64mxLkqKIMQx/MbAfMYQfhp5xW7BrIMaAq5iBWOwhyUqwDXpa4hpYvrCoumLGO7DYI7JG+CCzXQb5q0DrFI4I9sJ2DvTDpQVzZzv/lGYDEKoHS16JBYLeUGcHvsUsYvSq8FUimA/od8sfZgDsqCtXwlMw/xnOq1VlrDGSsQ0kxjYsLeyEdweNaE9UnLgetdKtW10dkqxaQi/S1WhOY2RwJWBXISxDkbYznxScPNsM+szeCdvmWLb2tl9spuHwK8Pq+fxCe+6tHxlqu9OXX5mfm5QRm46n2y0a3g76b1aMHK5Ch9b7n96DVkFDM/vE0tJmsEy9ks7nXRhvd30J+eWdqd0Iblgump5bFpEXxEzhdUsGmpSvYLecq/rFRC2W2VTEgIs5vddHlKeJTsHxcvLzY6gjX9qS2NihoTqDsMFGS3lAMdyjIykdnQvBKptnjVjc8nYcMmO5jXvQkpH2Vg1v/LvRsaUJCv5P2KwTsF1HLHu4vVe3ymA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SElPc0c4em43V3dWN3hJSnFtbnhNTzFGWm5oangyelF4T2l6Rmg4T09FRkdV?=
 =?utf-8?B?bGRXVEI5TkVEdUpZQm9zTzNZMXhlVGtCV1dXUXFLbmZLNzNaTnNHaGluQW9m?=
 =?utf-8?B?Mnh0VldETTZ5ZUNjU2lJbGc2eEZxMkZlSFNEN2I5OUx5RmlwY1NDWHFCZWhy?=
 =?utf-8?B?WVNINExwdGhPUHhFYU5OR1czTnd1ZGNjazVQNWtXR21vYTYyVlNrZXNTVlFr?=
 =?utf-8?B?TjNHQ3dOZUY2RDlXRmVqbndzcEFBaWprL0Z1eklaOVIxLzZ5WTZseFcrTE9m?=
 =?utf-8?B?dUtiVC95NjBBaktmZW42NStaQ2YwRG1reEN2VVdOUHJaUlRtdm5hbXVIOHlC?=
 =?utf-8?B?b2hQdkJCNVpjRnNEN0xtbDFFT0FiR1lHOVZsc0xYci9ESjdub1lVNUd1cUNL?=
 =?utf-8?B?Vmd3VkxkRU1FbVFiVWVNbHhTc0gvS2x4emRvNGdFVFlLVE52MlR6YjFsZGdQ?=
 =?utf-8?B?R3VkMUs0TDVZT0RaMVhRS0VqWjV5cUFzbDVaWFpYL1c3a3ZJa2pDbDI2eEN6?=
 =?utf-8?B?ODJSMWhmWUtER2tFbkJMMHdxRldJaVc4QXgwTkh2Y0UyVDVlcVBVVW11NXd4?=
 =?utf-8?B?dlFpQ0M0SE9YeloyQytWUFlDb3hSVjk1YmV4bHZLd2FubWNhRURiM1haVkZH?=
 =?utf-8?B?MTY2UFI1NkwrR2ZRY0FUSUl1V0NBcExuVk9vUVNDUFBiU3VXNmlnVWdEbHRs?=
 =?utf-8?B?cXpGZDJwT1JIN1VJYUc1eStRQ1Rva2xHQ2dHU24wQWI3RGxpMklvZitiRldr?=
 =?utf-8?B?TmFUbVRYamsvYWY4ZEpoSDlIbG9mN2ZyM0lpM1NXa1hrblRVenBvVU9DSmJ0?=
 =?utf-8?B?Z0UzNEFTYWlId0ZFRDc5akU2dG9JcThCVlVPa1lJMVl5dW9YNEtKaVpIMnJa?=
 =?utf-8?B?ZDliRXRMd0hWamtoeWgzTWVBYVNsU3pOcjJNWDBSZnQ4MStRdmZPTWhUeFp0?=
 =?utf-8?B?MEdpSDFZc0FxYXNYWklxYkVqZFBXTVhZWVJBeFZ6ekFjckYvaTBGeE1PcnRy?=
 =?utf-8?B?R2NsN0R4dHNSeEZranQ4UUZEbkR0RG5PT3ZoRy9YSFZ2RGZXVjlsUXQ4Nzc2?=
 =?utf-8?B?RjJmQ0NSZk55VFpsUitkUDU3Z3pSbDFvNlJBVldmeGErVDN1Sng4LzdaU21q?=
 =?utf-8?B?elJWd0lvdjZXNTk3aitSWFNOVkJtTit1YmNLbElsT1UwdEZzNEgraE55czNC?=
 =?utf-8?B?RUhpekdLTlM0azNYNGVIRjNUSWFXQTVPejZsRmRMenVheUpFWG1jckNnMzhy?=
 =?utf-8?B?T2x1TDdDMlRweFhUaU9Wbzh4QVNzTUEvQW5vUHhpZHlMa2VJbUxTd25kZlpk?=
 =?utf-8?B?NVh4bVlhUWk5UGFiZzNxMVZVRzJXc0NuNlJ0NDIvTER6RlFOQ3dlLzdqelhJ?=
 =?utf-8?B?K0RCbnpjaXBqYWRNTFJuQzFEeCtWSXJYbHJBUmlyZlhsV3ZMNGpWa1FQQ29m?=
 =?utf-8?B?aFF1KzJVRXlRRXJ4bU5BTjF4OWlsdGZVbGdaZDAxWnBoc0R1UTYwT1UzYjM1?=
 =?utf-8?B?RlpwNHVuQkVyUEVOOFVTRTVDVzZ6NVkyRjJvWW13aFZCS3BhLzcyZFlIUjI0?=
 =?utf-8?B?bks2MmJhZlRJbEFPNGp1Yk9RbVVHRTQxUUhuSUd6Q0NMTDltYnlsSnVxRzcv?=
 =?utf-8?B?dStoN2tmYlZDanZyWjFRVklocUFRS296WWphUFdRMjlaU0RoUFcyUnFZVllw?=
 =?utf-8?B?cUdvRmxzQW9mVkx3NzZLU0R3VVN5aHlZbElieFdleFkrRWxKWnF3R2dUMGo5?=
 =?utf-8?B?eE1hTGUydFhJbFJoUThacW9OUnR1RnZ4UExyYUNVT1hlK05IOS95MGc4T2xw?=
 =?utf-8?B?d3BuQTRlSHBnajBvVHBZVmR5RmI3QnI5cmloWmxmcHF6c294Y3J5ZEtiWWkv?=
 =?utf-8?B?cEdpQkxJa1FKMm1TVVBLdlVxS3g1NWQzREpkL0k4MzhHbERlS0tHUlc1M3ln?=
 =?utf-8?B?VEMxLzd0S1ErM21qekxGemthS2VrOW1IRXhjNVJGQk4xRFhyNUhlSzlCdytN?=
 =?utf-8?B?eXJla0RhMmR3ZHNUZ0tlbGRMZXNUOXVVSkxKTmdDa1lkZjVpcGFmL1M3MVlW?=
 =?utf-8?B?RDBuaE9jWDRqSjBPTlF4WTg2bW00N1NMUnVtVkFLdk1TaTN3N2ZwMEVIdTlh?=
 =?utf-8?B?YmtRcFlIUjBheHJOVC92QWEyek80QXdPY3R6ZFNsandDanYwU0tqa1VuM3Jl?=
 =?utf-8?B?UExUZFowcGk3alhZKzhpMUNNeHZCSzZUWGRTdWI3WVZhdThYSEd0RTRYb0JB?=
 =?utf-8?B?c1FzV3M3bzA0aEcrTjVUUUZFdVhnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a754d43-0711-4d01-c53d-08dc53d54355
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 11:57:40.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Trur1svC2sTY8QDIMe74H6v/geOtpjZZphiM3NwLmC4iPqzYadljX18mPEwldYNVr+lRjNcoVp2SnlLDFk1h2RWcHYMkhdx2+ZchgKFeBR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5552
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3433FF554BE1C440835BCACC12484190@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Apr 2024 12:01:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15486

T24gV2VkLCAyMDI0LTAzLTIwIGF0IDE2OjAyICswNTMwLCBBZGl0aHlhIEJhbGFrdW1hciB3cm90
ZToNCj4gVGhpcyByZXZpc2lvbiBhbGxvd3MgdGhlIHVzZSBvZiBkZWx0YSBoYW5kbGVyIGluIHN3
dXBkYXRlIGZvciB6Y2h1bmsNCj4gYmFzZWQNCj4gZGVsdGEgdXBkYXRlcw0KDQpASmFuOiBUaGlz
IGNoYW5nZSBpcyB0cml2aWFsIGFuZCBuZWVkZWQgaW5kZXBlbmRlbnRseSBvZiB0aGUgZGVsdGEN
CnVwZGF0ZS4gSXQgY2FuIGJlIG1lcmdlZCB3aXRob3V0IGhhdmluZyB0byB3YWl0IGZvciB0aGUg
cmVzdCBvZiB0aGUNCnNlcmllcy4NCg0KVGVzdGVkLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxp
eC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KDQpGZWxpeA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBZGl0aHlhIEJhbGFrdW1hciA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT4N
Cj4gLS0tDQo+IMKgLi4uL3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbl8wLjEuYmLCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDINCj4gKy0NCj4g
wqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluL3N3dXBk
YXRlLQ0KPiBoYW5kbGVyLXJvdW5kcm9iaW5fMC4xLmJiIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRl
LWhhbmRsZXItDQo+IHJvdW5kcm9iaW4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluXzAuMS5i
Yg0KPiBpbmRleCBiMzkyNzhlLi40MWViMDZjIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUv
c3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluL3N3dXBkYXRlLWhhbmRsZXItDQo+IHJvdW5kcm9i
aW5fMC4xLmJiDQo+ICsrKyBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9i
aW4vc3d1cGRhdGUtaGFuZGxlci0NCj4gcm91bmRyb2Jpbl8wLjEuYmINCj4gQEAgLTEzLDcgKzEz
LDcgQEAgaW5oZXJpdCBkcGtnLXJhdw0KPiDCoFBST1ZJREVTID0gInN3dXBkYXRlLWhhbmRsZXJz
Ig0KPiDCoA0KPiDCoFNSQ19VUkkgKz0gImdpdDovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lw
LXN3LXVwZGF0ZXMvc3d1cGRhdGUtDQo+IGhhbmRsZXItcm91bmRyb2Jpbi5naXQ7cHJvdG9jb2w9
aHR0cHM7ZGVzdHN1ZmZpeD1zd3VwZGF0ZS1oYW5kbGVyLQ0KPiByb3VuZHJvYmluO25hbWU9c3d1
cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluO25vYnJhbmNoPTEiDQo+IC1TUkNSRVZfc3d1cGRhdGUt
aGFuZGxlci1yb3VuZHJvYmluID89DQo+ICJiYjM1MTI3MjMxZWMwOGE2N2Y3OWE3NTg0Y2NmYzBj
YWRhODhjYzRlIg0KPiArU1JDUkVWX3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2JpbiA/PQ0KPiAi
ZTY5MzZiOGMyOWEyMGNiNmE2ODkzZmFhZTU3ZTEyNDk5ZWJiYzM0MiINCj4gwqANCj4gwqBTV1VQ
REFURV9MVUFTQ1JJUFQgPSAic3d1cGRhdGUtaGFuZGxlci0NCj4gcm91bmRyb2Jpbi9zd3VwZGF0
ZV9oYW5kbGVyc19yb3VuZHJvYmluLmx1YSINCj4gwqANCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNo
bm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

