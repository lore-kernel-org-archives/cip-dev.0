Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB15C47DDF
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 15:40:09 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.84])
 by mx.groups.io with SMTP id smtpd.web11.8110.1706001539663944610
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jan 2024 01:19:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uPnVUla7;
 spf=pass (domain: siemens.com, ip: 40.107.247.84, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhtnPBIyRoZD7gU+b8A3Vqwn1mSqJ+CBjOIfWGwrYv1aXUD4OfrYqX2v+5gT3AEfmgx0lXDRsfn9QgkUZW7OyykYBwk3b+EM+zYvXBdfIylgm7qsU0ux2Hg3U015SO5PCCsMV6U5ZmiM5lylfXZjUgLI98JMlHqtgVJ1FpkPD7v+46U0C1JErB7xdWeuaaXxBGyuxCMdmMmEI7ApYbADi76Ed9WOByC4Hqa/tU59qs4XvvDWn+WvDYb1TH+MIn/GVmz27N/wZ+0smEIRZiiylKPOhsn3yu92m6Wv9fsHaYjuLgrG9NiA5T6N2VzkirZWlAd3q46dSidbuw1a4ssCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU7rEgvC8pa2VNXlZVRwaYB7eM2eKyRcwCY5yrXRscc=;
 b=WlG38eytUvWeBOWUsqa9mAKvHhnUXBQYx2azyRs3rSV2hGv+W28EEQGnw1xB87ns+kuoCzBikddienUYEREgZA/nEC8Z/+ItEJRaNCIqkHMCcSXZfrZQpKn424Zb/rQrJHToF2rSUNgI7WBtvjW8mY6PEe2UFD/mtf5YS4Go00E7KriaHUmdEDlppBrquPTEhKmS8GWB9Qk23H1Zg5BGxrX8LmlwiqzNZWe8gOUgzw0oHBSMavYEbUz6fUUL1HBLjQAbFdT0PVVLLrcIrV1NgrJDcheIvqlO6yfSzQMh0iG7BNELNvMTNH5xTzbw9XQcXrHrvv7hqn4sT+9jklT93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU7rEgvC8pa2VNXlZVRwaYB7eM2eKyRcwCY5yrXRscc=;
 b=uPnVUla7Xqfxpjk8PMdqXjYT0WTaf4RCs71XNo0Be62aK6AfKkg8jy5Z2+Z6sNaOlfOunfmJ6VcCOOD0yLcPyyqecISERYhEWO4gcdt1ivBDP9PWXe5W1DN693Vx61JhRsjIMGJNCCRRD+OZd+kHE8aggVLzGsmqgKEmqmuOkfeoBaa/4OX/K/xPqqbNDmf+ubK8SLMZfvNxLH+K9tvXjOOaT+jWteQaDOLHWFygoHyZuYFBMozBXa7ZRnbhujYAkSuoaFpjjOPuxc0b5CcHb3CzzK6zU3k+5a/4FiJIYUACBqcLwIoX6tGSHuRt0kWMr3Gu9pOE6aNufc1bZuYepQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS2PR10MB7637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:640::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 09:18:56 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:18:56 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 3/4] swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
Thread-Topic: [cip-dev][isar-cip-core][RFC 3/4] swupdate.bbclass: weak default
 assignment for SWU_HW_COMPAT
Thread-Index: AQHaTS/RqN9IuT0sXESD+uc4GW1Q3bDnH/8A
Date: Tue, 23 Jan 2024 09:18:56 +0000
Message-ID: <bbbf2ed11c8eaac108e935f199c8acae2ac97817.camel@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
	 <20240122123751.83696-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240122123751.83696-4-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS2PR10MB7637:EE_
x-ms-office365-filtering-correlation-id: 948e9224-c4a6-44b1-1fad-08dc1bf45377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mRD6QZw6H1msxEPjA1vN5r0NeL7JDxG1fyv5zm1MNPOce2TdSdT4XWY36JmBsQz/vScJJIJ4pEvFy45pU0A1ArwWEOlrivUAcLT1K0HFpYwvWlhtzp+Cha5aX3t767+n7LH7W3so2y+sIIwjGlqcyPmq9RvTLEhMfHBkjacHSU3rplLeJu0ZI0mkUysZWz5L+PEyJwrg4F+XkjJiTVR7dqWL2cOGqypZ8WsmPKBbthx1N5+cjNF4FMNVGF0FSUGI/R7PQ5AFB0OqbIAiF1n6gVbE5b0wBuwxhPk7S8fq5BchKG/IFAviL3YVFF/d0IHm0jbgGT+/KxZglT1QwoF4vlZ7siW+OwcUlNszTkAxOKxKwFWPfSo6aVHFVQpxAxM2dgkDfyvMEBSriDyGLuCQwX/pCeNGp3Mrs8eE25BgtYhlbDr37YOZiDTt6DAJLMtkNDgH1I9n8PDwQbdzmYZAXqbEcNCgkgl9ZVGfxdjCE+icJlC+kW1iumSjowFfpNnWFnNl5iAejUiYw8jwPBPGRd3MANux12hJae8i0YdjTiIbsBvkkj5l0fbNnAjNjwcobHwoh+kqfaxwoiBoYxxzMCC5bbxcjxF8nq6hJ/kcD0KnXw2Lb9YMcACpWUxH2/Zj
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(38100700002)(122000001)(82960400001)(64756008)(8936002)(91956017)(6506007)(66946007)(6636002)(2906002)(5660300002)(66556008)(36756003)(6512007)(66476007)(316002)(478600001)(110136005)(66446008)(6486002)(8676002)(76116006)(2616005)(86362001)(71200400001)(83380400001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V2NKNEtyRm51N1dSUDRBL3g5Q3BnRGZWcEdNc0NTcXpDTlU2ZWkrRDRyUmRp?=
 =?utf-8?B?R29GL01jSm1iUjNhSWc4TDcrWEtnTmc4dXdkY3JZRXFtM1JBM2NKcm9mUmVD?=
 =?utf-8?B?M0E2eHRNTUFpUE5lcTNtZVZJbkhEL2w1blFMS01PTGFhUFlzNVg1ZUFaQXBI?=
 =?utf-8?B?eFZjSnNpa2Fvd3RzRTdsYUs5cEtZTTZra2FzV1RZSjhZNDF3b3FSaGMxZ2J1?=
 =?utf-8?B?K2tJYkRqS3hUYWlXdXFrclg5SEs1Y3FWc3dYeHk0RGRsZzU1R3Z4b0JkQUU5?=
 =?utf-8?B?UWdwankzYTdWU1Irc080TWJtTUxNeDUvbEFCSXNtV0M4WkYxWTlpTXIwMEQ2?=
 =?utf-8?B?UFFpYmxUTHg1a0F5b0hvOFpmaWJ1dGQxZHFsNTVlMWFTU3RQWGs4S0NxSUts?=
 =?utf-8?B?SXU5Z2hHOVErcU1yckZqMnRGNHJZblVWaEE4WnFUditWUk9zTkpMR3RqcWRT?=
 =?utf-8?B?NlVrWjhZN3E4azFHMzEyMEdYYXhPVDlhb3c4bHNvaFBlaEYyelBBZmpPYVR4?=
 =?utf-8?B?Uyt4aUdkVXlSMlZrK0xSeEhWbEJUR29VQm9MVjMwRG1EZXJRVUFSYjVaWmVM?=
 =?utf-8?B?M0gvNDZxdVJuakp0VkpMelIxcDE1cVdRdU8zNlowUUFPcU1YczNXbmVsMVo5?=
 =?utf-8?B?dlplQWJjbnI1UjBmVjl1QklPb2JDNlhHN1U1VldWWUJCZForM0xsd2ZlWHJJ?=
 =?utf-8?B?eC9yNVhUZldzOEdSa1ZJNmJsN25xODdQR0VkdDdENFJvak9yLytCTGVnZWxC?=
 =?utf-8?B?bENhKzg1aFl1UkZxeFd4dUoweEl6Y01iUUE0YW1ycjR4R3NFeEhxcG9aaVpM?=
 =?utf-8?B?UFJyRWs5L0Y5M21LRE1odTRvQ2JranB6STdvVkEvUldydnE2Qy9QS0NkdlVW?=
 =?utf-8?B?bUF6c3hQbWkvcWUvbWJmbTAwMDcwYXBhdGhkL1M5aW5pR3VUWXEwT01qcTBR?=
 =?utf-8?B?ZlVrWmpRNjdTNEQwT09wbFAxeDFUdC8zOUJnK2VWRUdUdlhuakoyc1hFc09C?=
 =?utf-8?B?Ujk1bU1Vd290cXQ2V3poQTd5RVdFcDdHU3E4T3B2R0RkNzc3TzB6OWZ2RXpp?=
 =?utf-8?B?TSs4bGlLc0JlWDFSVWQzQUhmamRUYUJ2YUJDRlVoamRIbWowcW0xRk9RNE1H?=
 =?utf-8?B?NGxKb3RTbU5rc2RRZkQrVldkMEVaN3BaOERBQVptWHlnY0tPK0R2Q1hMUTVj?=
 =?utf-8?B?S1lqanhRb2V1QnF5dlFueU5pMlltaFNuNys1RnhrVnY4eC9IUERKVmpoLytS?=
 =?utf-8?B?Vmd1TGd6YWhvbEtlRG1EYXZySDNwWFYvUS9MWTJpbWtMWEJ0eEdXUjgxZlhB?=
 =?utf-8?B?aUJDd2RXR2lmandvZW5kNTVQM2ZKaTNsYVlhNjYzSmp5dHp0WnF5OUtadHVM?=
 =?utf-8?B?S254U0gvdUwvMWtENVYwYWhKSUZWc1BoZzYrazlTc1p1OGRaTXpwajZ3VXdC?=
 =?utf-8?B?UmM3OC9xUEFhNzAwcW5rZXA4OUJGQ2JoazlzeFhJaTRDOENONnFTNThDb1VB?=
 =?utf-8?B?UGJQRUkrTjEwTVF3cTVoSEFUOERZMTlYRlFCNFhqVkVrVk9tb3F5ZkRZbndz?=
 =?utf-8?B?Z1d3aUxBbUhCTU9ZdEkxb2MzSXlUUG5RbU8yc2x4Z0M1elVtR2NtRXpKSm05?=
 =?utf-8?B?SmR2b2NWazlGRzk4YTdna1V2Ym9FV3NFc211emhyZnpVU0Y3Ly9HMEp4MTZJ?=
 =?utf-8?B?WC8vU3hjdmtKai9lcWpUMEswZDA0cHZlN3VVcmh4QnEzb0o3TE9nSEd2aXp3?=
 =?utf-8?B?VUVJMFJFTnd6NWQwaWVVbTZreUdTdzZZWVBoQjFBeTBYdEd1NzFjQ0hNUnAy?=
 =?utf-8?B?OTN4MTFmdjZ4TnFxM1Nxd1NiclIrU21TNFcwTEo5SEdNYi9HMVN3REZGYTBN?=
 =?utf-8?B?cVFHQmJlU3FMNmFiK1UzcnFDVGw1WERqL1hOTHZnOUh1QWtYaGdVVWt2QStQ?=
 =?utf-8?B?UWc0OTRhRUtndEduWnhqa1lRYjgvV2tPZk0rajdZaitQdXdHV0oxYlRWN2VU?=
 =?utf-8?B?VmRMQzZGK3BIWHNsaUJTVDZsOE9sZ2d3N3B1Qis2aVVBeEpoVXp6ZHBhQncy?=
 =?utf-8?B?d1RXU1J5eVhBemNEM25UYUtQbkJiTXJCT0lKOFo4amxmekxoWTVaU2V5MWFK?=
 =?utf-8?B?Yk5xdE5uSGUrRVpvNklBbXRueWJ5QUYyNDVXQ0tlZ00yeDloZjJTRitXcWgr?=
 =?utf-8?B?cFZQUHRyckZmVlY2eVArTlJpUks1dXFvbFVkOStFZkt0Z0NYMHQ2alhsWnlr?=
 =?utf-8?B?cnBmL3I2SHJyZFYzaHVZZGIwdENnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 948e9224-c4a6-44b1-1fad-08dc1bf45377
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:18:56.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjYITq3fkILq7jBY2eDGSfOmKuQRXvsNQ582UCFfpQtALrxzvvLSzlumUAfvlDh6sVncNs9Tb7kz0sxMBWKOcj/E+lyW2rlPc1DM135fMuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7637
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0B55285B2001542AAD221011766530A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jan 2024 15:40:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14448

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDEzOjM3ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhbGxvd3MgdG8gc2V0IFNXVV9IV19DT01QQVQgaW4gcmVjaXBlLWNvcmUv
aW1hZ2VzL3N3dXBkYXRlLmluYw0KPiBhbmQgaW4gZG93bnN0cmVhbSBsYXllcnMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMu
Y29tPg0KPiAtLS0NCj4gwqBjbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MgfCAyICstDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzIGIvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNz
DQo+IGluZGV4IDhmMTIxNWQuLmIyYzEwZGIgMTAwNjQ0DQo+IC0tLSBhL2NsYXNzZXMvc3d1cGRh
dGUuYmJjbGFzcw0KPiArKysgYi9jbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gQEAgLTIxLDcg
KzIxLDcgQEAgU1dVX1JPT1RGU19QQVJUSVRJT05fTkFNRSA/PQ0KPiAiJHtTV1VfUk9PVEZTX05B
TUV9LiR7U1dVX1JPT1RGU19UWVBFfSR7QGdldF9zd3VfY28NCj4gwqBTV1VfVkVSU0lPTiA/PSAi
MC4yIg0KPiDCoFNXVV9OQU1FID89ICJjaXAgc29mdHdhcmUgdXBkYXRlIg0KPiDCoCMgc3BhY2Ug
c2VwYXJhdGVkIGxpc3Qgb2Ygc3VwcG9ydGVkIGh3LiBMZWF2ZSBlbXB0eSB0byBsZWF2ZSBvdXQN
Cj4gLVNXVV9IV19DT01QQVQgPz0gIiINCj4gK1NXVV9IV19DT01QQVQgPz89ICIiDQoNCkhvdyBk
b2VzIHRoYXQgcGxheSB0b2dldGhlciB3aXRoIHRoZSBsZXNzLXdlYWsgZGVmYXVsdCBpbiBzd3Vw
ZGF0ZS0NCmNvbmZpZz8gRG9lc24ndCB0aGlzIG5lZWQgdG8gYmUgaW4gc3luYyB0byBwcm9wZXJs
eSB3b3JrPw0KDQpPciBkbyBJIG1pc3Mgc29tZXRoaW5nPw0KDQpGZWxpeA0KDQo+IMKgDQo+IMKg
U1dVX0VCR19VUERBVEUgPz0gIiINCj4gwqBTV1VfRUZJX0JPT1RfREVWSUNFID89ICIvZGV2L2Rp
c2svYnktdXVpZC80MzIxLURDQkEiDQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGlu
dXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

