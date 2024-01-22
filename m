Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB5BC47DD9
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 16:49:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.70368.1705918786893787657
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 02:19:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wpYBx2hQ;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocHW2AECoc97vY/XLAoCv8AYbN/VwnxBZWTvTmT2YuD57JvdzLuS0wbrBASurOkjqEpe/Mf6muQ22xRaCD4FmsVuzx/hb8vpUC0OYuOnz2FJDzHhKqtdtNdvuLuP40wQNgnsvJydqHyjapV6Tb6s5qKSxEEJkl98j5JxAFiywY8Fxa5C4QIdAAJ7Hyk9SReGQch6FF5tuKX8m3plK2jPJjAeLRt0btPckBhMoKGEwenFLrkK6YKg/FS3WY4sV/weWo60tYkssL2cdM93tUBR6lw7qkO+OCZBUWScTmUIqEgBN/NGRAPdTUzeQ+E46gvSt+LAWN3dnCNBf7Ub6vg0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReqPRYf4X+W9y+YzQiHqP+df/9ko74yeeuX2GYKV77A=;
 b=Rv7IA54hJEhJZ60LOtiFLleeZ88b2rIprIEfFc3n6b2ikJGqrYOnDt6TXW8pp81a6ZBqeBcDb16mApX4J3iTYKDoBb7+YatNSki6F9nzKc5MEAYLvIIRYbTaanInw+pXnH9gLu2KAdrVjisLeJsPPVhRWG6QLhGS3/E/KZRGI7uu6woqSkLEOFfrLty+cx8oEMs7aXfacNGb9emxAKQulqT8Z9sYHpgCsLWDW275tpjcOwHYmdcIr4D3BzFHiTI5kONYE1SJLfrLqTWFT21rhqSWL/BQbGP0BxKQOAseS+8u9kI6VSVnUMXN7fHRsbKftCDiAEkTMh+MezdmKwS5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReqPRYf4X+W9y+YzQiHqP+df/9ko74yeeuX2GYKV77A=;
 b=wpYBx2hQF2V8gKq5gyHQBCmwpDs9vT6XHpbU8w4SQG4WYpUm6jIos58ftONZj0EzLl8EJMZf3etCWz4VpE+OYqj5U1LRRm9Yd88k+S6iGq8+w+Z+k0RiHtqdnx8I53f390rS8neBMUPAFZyGWfJij2NddSsM4iePwSK8y9ZtMsRjsE7vDHYOZM1pZdKnEmf4sgE5/12G/zJ4laEod/O4uYSPAhQHPGzsvVQz2OLih/nMw3lzi0BX5C10N1kSijaUDD2PjSYtmf7BqKId+72rQUzeIpbEI04H5ytsedTMLwdR5CNRqkNxHTG8D/zQ5q+Wj1o3+FbjzQ+YV8PrN4aF8g==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB9PR10MB5332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Mon, 22 Jan
 2024 10:19:43 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:19:42 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] efibootguard: Fix broken SRCREV to official tag version 0.16-1
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2] efibootguard: Fix broken
 SRCREV to official tag version 0.16-1
Thread-Index: AQHaTRyCsTkwzqwvOEO733rbdyVyxw==
Date: Mon, 22 Jan 2024 10:19:42 +0000
Message-ID: <c47c9dfffa80bc7d5debcd7fbf66e4e4759d5602.camel@siemens.com>
References: <20240122095210.54158-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240122095210.54158-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB9PR10MB5332:EE_
x-ms-office365-filtering-correlation-id: dbfbc5e8-e120-433d-9fde-08dc1b33a671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LvjSDz6PzIzrlS7R/yiJI+qrbAcbRyqXhfPBmefyDFFcD8zlt7iS39ar3EUUQaInNi3A5c33OlFQD22XBDu/+DrSjYn63iiMqJi9BSSTpJooOt7ZfVVZA5D+hQ1quRAJCjhT0HdZc6LgTulus8sxHbvRx4GXFwPN6j4FuCHMI0fWTotvEtxb9DTfnot6ucOabXvI3ibeim5mHGhkAh05w+Q5ifixjSWZDpBVkFYLhQrLHfBuBO6r7eXWSK9mpC9AY6PGn+VNlo0otVFMvDTlMneR7ap9BbecMAMDSbXz9g6Y92gdfrgwPcE31V9AkeG1qdBNF9X7u+s4vmDC9DJM8Nohys+JW7G8dQkE/KYspqhiTTPA3dgQ1xdzr91XQOVck14DrLsb40qdBdEYQStte3EB1/i2prRNQ0DbFcFjz7Xyt82UHlb7K+x+2Jzaf7Dtm+467urftku6/7NlKQO09NKOaRyugfgMd4VAbWe0ufTC4bCoQMefmneTIVZt9ky0SLJXI9ILcQPOda6pN8TtYJh7Qg1P6SATfeVEBHOcEsJKM0HvYgDjgjLIKSN3Ij5Z9cILx/7EWyqpzhinR5M7rhJ1lmQ0GO9q3BZChJqpLrY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(8936002)(8676002)(5660300002)(2906002)(41300700001)(38070700009)(2616005)(6512007)(6506007)(71200400001)(83380400001)(6486002)(478600001)(966005)(122000001)(38100700002)(6636002)(82960400001)(316002)(66556008)(66476007)(64756008)(66446008)(86362001)(110136005)(91956017)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dFdOWEJEYi9UM2RuWHpQc1ZnVEl2TzNhU2tQSWVFYkRGRk45dkowa1FjWENi?=
 =?utf-8?B?SHJNNWxwb21kUU1tK3RDT080aUEzNG5mSTl6djd1M3ovZkpKK24rVXp2YldN?=
 =?utf-8?B?WEdIMXc5TDlNWjgrc250aGFhbC9mS0t6VThVTzBSSFByNDdmRHh3V1F1SkZq?=
 =?utf-8?B?U2dnZWpJdGtnNFBVZ2NKMDY4N2JodCtoME00M3hzanZVRUtncnoyVEFybC9K?=
 =?utf-8?B?WElGRmNzWGZwM2NkbHI3TGQvSmVtcmp4RzZJV0lPOUF6RVJuQWpKUVB0cXBX?=
 =?utf-8?B?OVQrOGJ1bkUvT3UwSWx4cDhuTU5vMHczTEpMVTlFUVF5L3R1RkVQYlRabkhF?=
 =?utf-8?B?TExiY0pPcFY2SklTaWY0RDdLcGEycm11NFp6T0drUVdhSjFZb1JROCs3WU5n?=
 =?utf-8?B?T1JNaUVqVXR3bGg4TFhKYVJsaXRoZm9LMlo2WW5NTjhCeVNpbVNPUG1HZW83?=
 =?utf-8?B?Z3h0bmlqeXA5aVpKdVNNb296cmNBME5EZDcveXE3YWpHUDZmQ3RZa0Z4UmY4?=
 =?utf-8?B?SUUxT2h1M0Q4eTlRNHczbHN2cUxKUU5PTFNWM1k5TU83QUNBZTNObkwrdFFp?=
 =?utf-8?B?WlY5Q3YyOEE4TTJaYzZMWmVYY2FxeXc0SWFMZE5mVnlPKzZ5alhPOVRwYm5j?=
 =?utf-8?B?Z2JtMVZ5cnhabERMQlYyZjMzY2YzVE9lNVVyb2kwQ29vVGMvN2dzeEZKOUd1?=
 =?utf-8?B?alpFOWJZUjhTdmw1ZzgvYS9lYWdOTmw1MHNybVRrdW8rMlpESjFwNXRZNjlK?=
 =?utf-8?B?RSs4V0l4YUpvTGNtS2VNVVNzSGRIYnRsdjJHaWxvajBhMzNnQVE0b1hyMmVH?=
 =?utf-8?B?VnpCaFFjM1ovWTUxNC9Wa3A0RXpwNWtrbzBnZ3E4WEFxY3hxQlVLNitnLzdT?=
 =?utf-8?B?Smx6dTh2ejdKM3VTK0hRNklaQzN1OENURG9rQkRjcWZWNHpzWlViaGhOZXlw?=
 =?utf-8?B?MVNXaVUyRXFGQkxZYWR2UnlyN2g4MEJ3dExQM2xKditOdmh2MmdBWjhITzNm?=
 =?utf-8?B?dTFaaHA3SXhLMGk3bXh1Z0pHR0xqWFlHQ1FEVGtOOGMwdlVGNWdlbGM2KzNs?=
 =?utf-8?B?eXR4NlRXYk12bHd6TU9KSUR1Y1dnS3NpVjhXWTd4T00ySmlnd1BEY1hzek92?=
 =?utf-8?B?LzVEQ0FyR0pjc0FaVVluNjFpTXVtYWtTWmw0L3hWVGJHZU1NUGdsbnhpKzVx?=
 =?utf-8?B?UWN6WitHUHBVdHRIQWM4b1l0emhZYm9Fakc0YnU4VHZFTitYdENZc0xZWHpk?=
 =?utf-8?B?ZFVGdHZ1S0FpVnhhMTJRMEtBcTZRc1pkUzFaZXFweUVTeWZsNDVyQ2FrcFRt?=
 =?utf-8?B?VVNhZlJTZjVDN2J4Mk40cnJpemNpdHdRSDFURlhybzZqdzQ0RDlSeTFWejJh?=
 =?utf-8?B?WUlLRnBzMzhPQlBSZENXRGxUZjBub21WT1gwd0lTNzBiMWI3YnNwd1h2M083?=
 =?utf-8?B?aFVDeVJjd3UvUVA5WHRmTFhhVGNVRHhkY05QOFkxdnp6TG9QYkdhT3NTR2lT?=
 =?utf-8?B?N0t4WFdQV3RjS1hQVlh0MDlHTi9EbE1BeE5JVlh1SzFTOUhsa3cxaFhUQWxN?=
 =?utf-8?B?NmR2Z1N4eVVhY21SYUxpSjBlbXM5am5xMWV6Zk9MazFKQjhrTmFwcDU3anJp?=
 =?utf-8?B?bXY0QktYdHVWTkJOTDIxSGkxOXo5bTV4VjJDRWNaY2svR0E4bTJMS2pPdzZw?=
 =?utf-8?B?Z1lqWklHRUhZc0dsWHRVM2dKSGd3ZGVwa0F2TFFTMlNmeFUvVzJrRjhYZ2Rz?=
 =?utf-8?B?S3dCRVo2N2hMaTRZbDJiMXMwZEVIL2VheWpoTy9HdUY4cmI3V0Vad29ZeHpJ?=
 =?utf-8?B?bU9PaCtkalU0c1d2TytjODM1U3JDUlcwR1JHVlF4WUo1Y2ZUM2RQVVhGNWVG?=
 =?utf-8?B?cjFVUXp0VFRCcmZ6Q1BxNGZjQ1luRTJsdml6Y0pSMFdtQ3hpOHA3RDZIN3Vj?=
 =?utf-8?B?ZjdrdUFYTDBRT2MwNzl0eWdqT1hhd0VhZS9TRnpGd0svR3hGeTE3NUhKcitQ?=
 =?utf-8?B?dEdWY0RUZzhVUWlucmtaQ2lKRUhYZnk1eEFIeWplN2V3RnVMZ0hMem5Wc1hh?=
 =?utf-8?B?WlNuOGdZYzBmOXVSNU1ncFREa0hEUThKRG1Kb0dJOUl5dXRQZjRTZ0xnNUkv?=
 =?utf-8?B?UWc2RE41SzlaeWdIV1VzTEM4WTJTMlVBc3h5cjhVdXFLU0VraEVUMFUvRXVF?=
 =?utf-8?B?bUQ5OHk2QmpEVWUwS25oaXRqOTJtY2NQbzR4SVh1RWFiV2pTTTZjb2s1TUpa?=
 =?utf-8?B?TFptanlDelhoVExpN3g0NWVIUFJBPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfbc5e8-e120-433d-9fde-08dc1b33a671
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 10:19:42.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2OTlPpO2dKgQENBVzq5HX1c/ENt03nV5FnFmfiuae+M90fZf9uh4pLwlUmKFiHgZGWmkeEHltSkZyQioxCJ3NRfngSGD8tZumEshyQA+JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5332
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F35D59F6B304AB439A4BBB05FA664E85@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 16:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14441

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDEwOjUxICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBpcyBub3cgdGhlIHRhZyB2ZXJzaW9uIG9mIDAuMTYtMS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20+DQo+IC0tLQ0KPiDCoHJlY2lwZXMtYnNwL2VmaWJvb3RndWFyZC9lZmlib290Z3VhcmRfMC4x
Ni0xK2NpcC5iYiB8IDMgKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtYnNwL2VmaWJvb3RndWFy
ZC9lZmlib290Z3VhcmRfMC4xNi0xK2NpcC5iYg0KPiBiL3JlY2lwZXMtYnNwL2VmaWJvb3RndWFy
ZC9lZmlib290Z3VhcmRfMC4xNi0xK2NpcC5iYg0KPiBpbmRleCA5MzExNGMzLi5lOWEzNGQ0IDEw
MDY0NA0KPiAtLS0gYS9yZWNpcGVzLWJzcC9lZmlib290Z3VhcmQvZWZpYm9vdGd1YXJkXzAuMTYt
MStjaXAuYmINCj4gKysrIGIvcmVjaXBlcy1ic3AvZWZpYm9vdGd1YXJkL2VmaWJvb3RndWFyZF8w
LjE2LTErY2lwLmJiDQo+IEBAIC0yMiw5ICsyMiwxMCBAQCBTUkNfVVJJID0gIiBcDQo+IMKgwqDC
oMKgDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zaWVtZW5zL2VmaWJvb3RndWFyZC9hcmNoaXZlL3Jl
ZnMvdGFncy92JHtFQkdfVkVSU0lPTn0udGFyLmd6O2Rvd25sb2FkZmlsZW5hbWU9ZWZpYm9vdGd1
YXJkXyR7RUJHX1ZFUlNJT059Lm9yaWcudGFyLmd6O3VucGFjaz0wO25hbWU9dGFyYmFsbA0KPiDC
oFwNCj4gwqDCoMKgwqANCj4gZ2l0Oi8vc2Fsc2EuZGViaWFuLm9yZy9kZWJpYW4vZWZpYm9vdGd1
YXJkLmdpdDtwcm90b2NvbD1odHRwczticmFuY2g9DQo+IG1hc3RlcjtuYW1lPWRlYmlhbiBcDQo+
IMKgwqDCoMKgDQo+IGZpbGU6Ly9kZWJpYW4tcGF0Y2hlcy8wMDAxLWQtY29udHJvbC1NYWtlLWNv
bXBhdGlibGUtd2l0aC1kZWJpYW4tYnVzdGVyLnBhdGNoDQo+IMKgXA0KPiArwqDCoMKgDQo+IGZp
bGU6Ly9kZWJpYW4tcGF0Y2hlcy8wMDAyLWQtY29udHJvbC1yZW1vdmUtbmF0aXZlLWZyb20tcHl0
aG9uMy1zaHRhYi5wYXRjaA0KPiDCoFwNCg0KQXMgdGhlcmUgd2FzIHNvbWUgYmFjayBhbmQgZm9y
dGggb24gdGhpcywgaXQgbWlnaHQgbWFrZSBzZW5zZSB0byBhZGQgYQ0KY29tbWVudCBhYm91dCB3
aHkgTk9UIGhhdmluZyA6bmF0aXZlIGlzIGNvcnJlY3QuIFRoZSBjb3JyZXNwb25kaW5nDQpkaXNj
dXNzaW9uIG9uIHRoZSBkZWJpYW4tY3Jvc3MgTUwgaXMgZm91bmQgaW4gWzFdLiBDaXRpbmcgdGhl
IGFuc3dlcg0KZnJvbSBIZWxtdXQ6DQoNCj4gRm9yIHRoaXMgcmVhc29uLCBJIHJlY29tbWVuZCB0
byB1c2UgOm5hdGl2ZSBhbm5vdGF0aW9ucyBzcGFyaW5nbHkgYW5kDQphbHdheXMgY2hlY2sgd2hl
dGhlciBpbnN0ZWFkIHRoZSB0YXJnZXQgb2YgdGhlIGRlcGVuZGVuY3kgY2FuICBiZWNvbWUNCk0t
QTpmb3JlaWduIGluc3RlYWQuIFN1Y2ggY2hlY2tpbmcgaGFzIGV2aWRlbnRseSBub3QgYmVlbiBk
b25lIGZvcg0KZWZpYm9vdGd1YXJkLiBIZW5jZSwgaXQgbm93IEZUQkZTIGFzIGEgcmVzdWx0IG9m
IHB5dGhvbjMtc2h0YWIgaGF2aW5nDQpyaWdodGx5IGJlY29tZSBNdWx0aS1BcmNoOiBmb3JlaWdu
LiBlZmlib290Z3VhcmQgbm93IG5lZWRzIHRvIGRyb3AgdGhlDQo6bmF0aXZlIGFubm90YXRpb24u
DQoNClsxXSBodHRwczovL2xpc3RzLmRlYmlhbi5vcmcvZGViaWFuLWNyb3NzLzIwMjQvMDEvbXNn
MDAwMTIuaHRtbA0KDQpGZWxpeA0KDQo+IMKgwqDCoMKgICINCj4gwqBTUkNfVVJJW3RhcmJhbGwu
c2hhMjU2c3VtXSA9DQo+ICJkNmQzN2M1OWFlZDE3NDg5ZDAyYjRmMGI2M2RiMTY5OTRkZmI4Zjlm
NzBmNTRiZTRkNjVjMzY2ZjU4YzZiZTlkIg0KPiAtU1JDUkVWX2RlYmlhbiA9ICJlYWNmOTRlNzY3
MTM2YTAyNTc4NTBlYTBjODg4ZDIzNGNiOGNhY2U0Ig0KPiArU1JDUkVWX2RlYmlhbiA9ICJlZTU1
MWJjNTIzOTA2OGNlNWFiMDI0MDg5Y2YyMDM4NTc0OWFlNzdlIg0KPiDCoA0KPiDCoFBST1ZJREVT
ID0gImxpYmViZ2Vudi1kZXYgbGliZWJnZW52MCBlZmlib290Z3VhcmQiDQo+IMKgDQoNCi0tIA0K
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

