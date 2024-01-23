Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD5BC47DDB
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 15:39:59 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.78])
 by mx.groups.io with SMTP id smtpd.web10.7946.1706000973678635954
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jan 2024 01:09:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uqbfmU2r;
 spf=pass (domain: siemens.com, ip: 40.107.13.78, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXZUJwiXXPOBtkPvWpXEblmXGvOjAwl9Vs/hKTvxuDdYUHxSwaHeIdcgPYSt4YlzSe4Q7zj+pvk16ZX9Dc7LC/SUZ7S91fyyg/OJ/ut5UxMv2SAJqI77DnTG9bAoeu8cghJ7R8BMlzd7BrlJxhRQrHqDMJpvXpLQUxQhY/f3T0HOWYRZ2gJa8+4J58r9d4e0d/B2WNjkxe11FCYgVYZCMqAeHem1fLjJVIu/26wyyIOPUt9q4VjoT+oUqwLDjc1DwHr9L/jxcmzWBhg9ETNexSIweuCB9gDY++zhrc895Wvpg7eENMUG2uUjHf7lfWxX04sc8XL5MV4V692ElQ17dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/U4S+bPXm2d28gxjtO1oNJs6+eLKlwZZxGXxJd8Z/4=;
 b=n39w2mE2xuj5cBgBNhfCe4FBh2Myv+8mMl8gRQS0/xX19jPyYY95aSZTlJAE6NH81gw1m+xkJgaj1KyIqFUJLtzSRyWRUvVyBVXxepyfBuG3yrM52G81Sx/iFWHBKO/OFar7da5MDXBYMCM7Pz6uCTJjubsXIk+k779cYamHgb71yokEUoqT1sSgyGSAL3P3IxeEBDoZqYKcwzb01phUcM4zjO2fk4K2UZwlQ0NtgVqWwJ1JXNnr0z6LjP1EP+R2ZKnu4UwmvUaobi7arvpjHcqo3xgQquTlOrTxqsN/ipYYWeeftNhk4THNCU77un3Tu/58oG1fKIZHCeVzq1WjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/U4S+bPXm2d28gxjtO1oNJs6+eLKlwZZxGXxJd8Z/4=;
 b=uqbfmU2r0L++vyP6VheXs3fiYs8uoec42w7Om0hheNWlGemU8kM6dy/foNtDHrDac3+sAXibVYabqpeZwold+qI0Ju9EFbNxddpPf+iqELW2yVbpMg55JpwFdBg+e5TKfhR7o+TDJnpshlkaW0NKAEjShsHBAKKMNYJZfvLtNYELcbtzoggbMjW3TwSQHa22pNphqVbN5A+WzAJyXxwgpsUVxW5PHtzLPicPzRT0nUUevtY0venHG3TXo8KZCKWq+Aw4kBvPgs/GMjGOVYihT/nDKtluj68N4dsud12TP8Dkxt5A6/sFesNv+vwxRBM2Yq4j2Ohf30tB0BI+SfE5/w==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB4PR10MB6264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:380::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 09:09:29 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:09:29 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 1/4] swupdate-config: move swupdate.cfg from customizations to own recipe
Thread-Topic: [cip-dev][isar-cip-core][RFC 1/4] swupdate-config: move
 swupdate.cfg from customizations to own recipe
Thread-Index: AQHaTS/SunCgyUQCgkuEqX7Yngm5QbDnHVuA
Date: Tue, 23 Jan 2024 09:09:29 +0000
Message-ID: <d529423415fb897468c9beb550d60d851de25568.camel@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
	 <20240122123751.83696-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240122123751.83696-2-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB4PR10MB6264:EE_
x-ms-office365-filtering-correlation-id: c4bc6625-e254-4238-9f65-08dc1bf30135
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8VcNBsWExAvyYPazZKTX8oPYqy6BVKNYfE+n29ztbiYrHU4IXyhkZ/iRElTyF9Kdn7PZwd0Gqb8ad/6mszdUGH1JqYooM5rX2Oe46RGyCpCasgusfzS2dehFk9AiTmFEMC+g8d1TRjQrI+M/Dpuj0W6JHX5HVjeM0b/Et65I/HVf3aHlLFGrK5xfAkFcbOGoawIj8aK+MzBNHq/OcDK66Ccb1qrz4B31Io35jl2qwm6i+9PLM2EcB+Sl5hJ8z8aICTHKyLRg62FcPcYtjN4BzUj/uqGJe+KYtySXUrxKNZI9mM5riBbtoLbnRv8NVh8yBr2TtBVvLbsA8Yzihj9YMlLzU/ofoaFzqQxa57Q2PjiJX3beYzGvxbzNbdH3u4gTsltCkm1IcxHegEkIhuY8MkFdUqk9k6+gj/SqrKZ368GaY1FV6BIEEFgXSO4gm70SMbf4h8hF3Sl45U1dVy7y0GIDNMYEBa1fqN44mL4yKrwDeaSz6KQrluhhQn7tMkwTfDAzZsmEJWfe0Whftgvaqw4siZxE2mNWklRMD9LYd8Yopsqelg0ueZhsJLRxe18Tn5IkRhDLK8FyvoNe9WmlZGYCP29vS4aLY59C58iDXrN6RbSxOYw4fePTElQ/F9zV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6486002)(71200400001)(6506007)(478600001)(38070700009)(36756003)(76116006)(8676002)(2906002)(8936002)(66946007)(64756008)(110136005)(66556008)(66446008)(66476007)(91956017)(41300700001)(86362001)(6636002)(316002)(38100700002)(122000001)(2616005)(82960400001)(6512007)(5660300002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bEQyMFlLQmdoakhSNEtKY0p2bkdHWlpuZ0hsNXFJQ09odHVlM2VxWEVrdWpl?=
 =?utf-8?B?RmVXTEhOVGc1NmNudmhicWxWTjhIcStpa1greHVQUTlDb0w0M1Nicms0UW5F?=
 =?utf-8?B?Z29nTGZOQ2lkcFhYb2pDL0hyOTUzTnkrUStGS05Rd3RzSHJ6REo3RXdIWFhx?=
 =?utf-8?B?TVFhYU9Jbk5VOGltUTJ1M04vZWJwejRibjJDRE4yc0xBeGRwUDRXS3l4LzE3?=
 =?utf-8?B?QVZIVG1qUHZkdXM0Rm80SzF5MVo3MG0vZUp0bngvWVRIalBseTJNSmZxd0lW?=
 =?utf-8?B?d1ZVaWZpU2Q2K2w3Y2QrVVJaT0NQTERQc2FoenhVNW56K3dRQkZnR0ZGRmxP?=
 =?utf-8?B?RGNBN1lWS08xNDBWRDNFTTZXRCtwdkZKSXNVMVJRV0VhSlNRMHNoM1BIZ0xX?=
 =?utf-8?B?dng4UndXYS9wUTBtSXh0Z1RmM2NSbE93N0djOEczOTNEY28wRWJObVh6VVkx?=
 =?utf-8?B?VzNjOE9DSEVOVVo3VGVaVzRzcHplUDdBSnl4anJpK2grN2F4MlpBM1hEQVBS?=
 =?utf-8?B?MWlSTjRPQTQySG51NTR0TVVITFhsTm4yN3VnVXNmNFBEYmlhdUV1MW90bEEv?=
 =?utf-8?B?MnBvVWIwcWx4K0Vwd3IxZzdlNGxjWHhpeDBEQjVyWWtzMjY0ZkV5MEh6a281?=
 =?utf-8?B?QjNJSDFFNFYrUHM3a0lNY2l2Um9kZ2tzM3l0L0RlUFZMdlBTVVA0SjZrZWxP?=
 =?utf-8?B?UWUxSHgyVlUwRnEyT1FTV2p3YUYzeldRT2RJQlMrYzNGZUpDRTQ4TXJpMStt?=
 =?utf-8?B?a0pQSjI3a2JnWVl5YXFQVzVjWGxQV1czMyswK01ITlVDNG9DcXZ1TXJkeGxr?=
 =?utf-8?B?c2YxajZSZlNLNi92TUY0NnNqZXI0NytyUlYzWkNMT1dyQ3U5M1UzLzJCVFhi?=
 =?utf-8?B?dmdWWmIvMWFQSVNhZEtLMTNlS1dENXpHTkVMekZpYldDSU0yVXRFa0NjMmln?=
 =?utf-8?B?TmdydDFnaXRaR3IvMHJNQWVNTVBaaVVCVHljdkhuWVlRWXlHUmVUQmxQRmE4?=
 =?utf-8?B?VHQ3SjNHOFl4RGhRcFI0ZFZZK0E4YnZpSDdERHBoa25VOWtJUWsxKzE2ck1W?=
 =?utf-8?B?aTR5b29iVzNycWUrWFhtR2tTK2RzdytIb1VKMDdxUENCYjhFdzhMQm1sOWpv?=
 =?utf-8?B?akJVczlVeWREMWNtTnRqZmRQZHVSdDR0c3FXTTIvL2VMVlc2U1Z2QXVDNVlm?=
 =?utf-8?B?MUswS3lVOE5IMFU4VnFBeWZJWWlQYzdkbzJpZGFWK0NUWGsvRW1DRmE3N3Z0?=
 =?utf-8?B?Y1U3bURhTGQvYkNrUGtvQ1YvSkxTeHlPSWs3TXFDdkZMMzlRdEpXNldKY243?=
 =?utf-8?B?cEsxQ3NZcGJzcTdobmJZSE5uaTZsMDdlQlRUTFBIRGJYRG4yYmVXS2pFYjdY?=
 =?utf-8?B?dFV5VUVRWkZtNVRYVXFnYmNja3NhZnREZTYxeTNKUVE0djl4d2hTZTRqa1Fr?=
 =?utf-8?B?MWdjQXRtQnBsNHVDT1R1eC9YWmJtMUxzM25lL3FXc3pBTEtMUjBxa1BvZFQw?=
 =?utf-8?B?eTArT1Ivc1d1WGtiY0FqL1ZPT21nelhnVDRxYlFkeUNDaER3R3dQS29LQnBU?=
 =?utf-8?B?bVJLZXBuRE1KMmxlN2pDR0hNZTJiSzFaSDRxb25wUkM1Nk5CZ25qNWEvdnEx?=
 =?utf-8?B?N1I3cUpScy9nRzRWM3hVenppTjV6ZGJlYkpQUmRRbk44NDc3bDRYN1hJSkZr?=
 =?utf-8?B?S2RWczRsR2JYdkNHTjIxeUFXZXdyT1p0TG45YlE3dWFqYnMxMXpJWHJLWFda?=
 =?utf-8?B?RG5JYmZCZzJ3djE2a0dxNHpFV2doZ1BERlBFeUJkVEJ5RGRHdG1UYUpsMnZW?=
 =?utf-8?B?THVaOVpFbERDSE00WTdEZnovV0ttbklhUjJnbHBMQjVGaCtIYllOUVRCNTQ1?=
 =?utf-8?B?SVhweHFSQ2FzMWFhRTVDRVNKY3VlV2VrK3Y0UXQ3TnJpWExyOVRSNmZ3eHl3?=
 =?utf-8?B?cHNoWE1rVE9nd3pUQUlZZ1hzdHo3Tks2WWtvWkx4STZQanpSVTZRbjI3aWNT?=
 =?utf-8?B?VHJEMmRSTUEvdElpZUdPTXd4UE1SZThQOGdGa1k0NWQ1dUxZdUk5RnRUTzU4?=
 =?utf-8?B?V1VPLzFLSkxDNXFseWJCcFFxZnQwa3dvVE1ub1JnYzBvMGUxTG5MbkNZN1I4?=
 =?utf-8?B?V3llcUREWG9xNnJpdjFYVGQvWC8zaDFScDc3OVBteGxhNUFZMnFUVnc2Y1Za?=
 =?utf-8?B?eVliTy84S3FyNkk4Y2xiNzRXU1NNODFvSU00ZzJwMUVlbFlMdVliRGRnd3pJ?=
 =?utf-8?B?YnNWMytKaTVXc3hrZnQvZ2dyenRBPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bc6625-e254-4238-9f65-08dc1bf30135
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:09:29.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovbfSewBm+VPefnDmcV7fxeG1g82AajXHm4AYHL/HrP9E26pj5YXfhCaTH54NmopUKbVHyY7sUXZl2l6EJzVdO5Mv9zaC/vvoOt18P3XSfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6264
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <819CC7DDF67D37448C5A9C1C054C3AE9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jan 2024 15:39:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14446

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDEzOjM3ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhbGxvd3MgZG93bnN0cmVhbSBjdXN0b21pemF0aW9ucyB3aXRob3V0IGlu
Y2x1ZGluZyB1bndhbnRlZA0KPiBwYWNrYWdlcy4NCj4gDQo+IEkgYWxzbyBhZGRzIHRoZSBwb3Nz
aWJpbHR5IHRvIHNldCB0aGUgU1dVX0hXX0NPTVBBVA0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVp
cmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKg
cmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2NvbW1vbi5pbmPCoMKgwqDCoMKgwqDCoCB8wqAg
OCArKy0tLS0NCj4gwqAuLi4vc3d1cGRhdGUtY29uZmlnL2ZpbGVzL2h3cmV2aXNpb24udG1wbMKg
wqDCoMKgIHzCoCAxICsNCj4gwqAuLi4vZmlsZXMvc3d1cGRhdGUuY2ZnwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMA0KPiDCoC4uLi9zd3VwZGF0ZS1j
b25maWcvc3d1cGRhdGUtY29uZmlnXzAuMS5iYsKgwqDCoCB8IDI3DQo+ICsrKysrKysrKysrKysr
KysrKysNCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtY29yZS9zd3VwZGF0ZS0NCj4gY29u
ZmlnL2ZpbGVzL2h3cmV2aXNpb24udG1wbA0KPiDCoHJlbmFtZSByZWNpcGVzLWNvcmUve2N1c3Rv
bWl6YXRpb25zID0+IHN3dXBkYXRlLQ0KPiBjb25maWd9L2ZpbGVzL3N3dXBkYXRlLmNmZyAoMTAw
JSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9z
d3VwZGF0ZS0NCj4gY29uZmlnXzAuMS5iYg0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29y
ZS9jdXN0b21pemF0aW9ucy9jb21tb24uaW5jIGIvcmVjaXBlcy0NCj4gY29yZS9jdXN0b21pemF0
aW9ucy9jb21tb24uaW5jDQo+IGluZGV4IDc5YmY4MGQuLjhkYzUwMzcgMTAwNjQ0DQo+IC0tLSBh
L3JlY2lwZXMtY29yZS9jdXN0b21pemF0aW9ucy9jb21tb24uaW5jDQo+ICsrKyBiL3JlY2lwZXMt
Y29yZS9jdXN0b21pemF0aW9ucy9jb21tb24uaW5jDQo+IEBAIC0xOSw4ICsxOSw2IEBAIFNSQ19V
UkkgPSAiIFwNCj4gwqDCoMKgwqAgZmlsZTovLzk5LXNpbGVudC1wcmludGsuY29uZsKgXA0KPiDC
oMKgwqDCoCBmaWxlOi8vOTktd2F0Y2hkb2cuY29uZiINCj4gwqANCj4gLVNSQ19VUkk6YXBwZW5k
OnN3dXBkYXRlID0gIiBmaWxlOi8vc3d1cGRhdGUuY2ZnIg0KPiAtDQo+IMKgQ1VTVE9NX0hPU1RO
QU1FID8/PSAiZGVtbyINCj4gwqBXSVJFTEVTU19GSVJNV0FSRV9QQUNLQUdFID89ICIiDQo+IMKg
SU5TVEFMTF9XSVJFTEVTU19UT09MUyA/Pz0gIjAiDQo+IEBAIC0yOSwxMiArMjcsMTQgQEAgVEVN
UExBVEVfRklMRVMgKz0gInBvc3RpbnN0LnRtcGwiDQo+IMKgVEVNUExBVEVfVkFSUyArPSAiQ1VT
VE9NX0hPU1ROQU1FIg0KPiDCoA0KPiDCoERFUEVORFMgKz0gInNzaGQtcmVnZW4ta2V5cyBjaGFu
Z2Utcm9vdC1ob21lZGlyIg0KPiArREVQRU5EUzphcHBlbmQ6c3d1cGRhdGUgPSAiIHN3dXBkYXRl
LWNvbmZpZyINCg0KVGhpcyBsaWtlbHkgY2FuIGJlIGFuIFJERVBFTkRTLCBhcyB3ZSBkbyBub3Qg
bmVlZCB0aGUgcGFja2FnZSBhdCBidWlsZA0KdGltZSBvZiB0aGlzIHBhY2thZ2UuDQoNCkZlbGl4
DQoNCj4gwqANCj4gwqBERUJJQU5fREVQRU5EUyA9ICIgXA0KPiDCoMKgwqDCoCBpZnVwZG93biwg
aXNjLWRoY3AtY2xpZW50LCBuZXQtdG9vbHMsIGlwdXRpbHMtcGluZywgc3NoLCBzc2hkLQ0KPiBy
ZWdlbi1rZXlzLCBcDQo+IMKgwqDCoMKgIGNoYW5nZS1yb290LWhvbWVkaXIgXA0KPiDCoMKgwqDC
oCAke0AoJywgaXcsIHdpcmVsZXNzLXJlZ2RiLCAnICsNCj4gZC5nZXRWYXIoJ1dJUkVMRVNTX0ZJ
Uk1XQVJFX1BBQ0tBR0UnKSkgXA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgZC5nZXRWYXIoJ0lOU1RB
TExfV0lSRUxFU1NfVE9PTFMnKSA9PSAnMScgZWxzZSAnJ30iDQo+ICtERUJJQU5fREVQRU5EUzph
cHBlbmQ6c3d1cGRhdGUgPSAiLCBzd3VwZGF0ZS1jb25maWciDQo+IMKgDQo+IMKgZG9faW5zdGFs
bCgpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoGluc3RhbGwgLXYgLWQgJHtEfS9ldGMvbmV0d29yay9p
bnRlcmZhY2VzLmQNCj4gQEAgLTQ2LDcgKzQ2LDMgQEAgZG9faW5zdGFsbCgpIHsNCj4gwqDCoMKg
wqDCoMKgwqDCoGluc3RhbGwgLXYgLWQgJHtEfS9ldGMvc3lzdGVtZC9zeXN0ZW0uY29uZi5kDQo+
IMKgwqDCoMKgwqDCoMKgwqBpbnN0YWxsIC12IC1tIDY0NCAke1dPUktESVJ9Lzk5LXdhdGNoZG9n
LmNvbmYNCj4gJHtEfS9ldGMvc3lzdGVtZC9zeXN0ZW0uY29uZi5kLw0KPiDCoH0NCj4gLQ0KPiAt
ZG9faW5zdGFsbDphcHBlbmQ6c3d1cGRhdGUoKSB7DQo+IC3CoMKgwqDCoMKgwqDCoGluc3RhbGwg
LXYgLW0gNjQ0ICR7V09SS0RJUn0vc3d1cGRhdGUuY2ZnICR7RH0vZXRjLw0KPiAtfQ0KPiBkaWZm
IC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9maWxlcy9od3JldmlzaW9uLnRt
cGwNCj4gYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmlnL2ZpbGVzL2h3cmV2aXNpb24udG1w
bA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi5lYzFkNjY3DQo+IC0t
LSAvZGV2L251bGwNCj4gKysrIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9maWxlcy9o
d3JldmlzaW9uLnRtcGwNCj4gQEAgLTAsMCArMSBAQA0KPiArY2lwLSR7TUFDSElORX0gJHtJTUFH
RV9IV19WRVJTSU9OfQ0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25z
L2ZpbGVzL3N3dXBkYXRlLmNmZw0KPiBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvZmls
ZXMvc3d1cGRhdGUuY2ZnDQo+IHNpbWlsYXJpdHkgaW5kZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBy
ZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvZmlsZXMvc3d1cGRhdGUuY2ZnDQo+IHJlbmFtZSB0
byByZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmlnL2ZpbGVzL3N3dXBkYXRlLmNmZw0KPiBkaWZm
IC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9zd3VwZGF0ZS1jb25maWdfMC4x
LmJiDQo+IGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9zd3VwZGF0ZS1jb25maWdfMC4x
LmJiDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAuLjY5OTEzMjENCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmlnL3N3dXBk
YXRlLWNvbmZpZ18wLjEuYmINCj4gQEAgLTAsMCArMSwyNyBAQA0KPiArIw0KPiArIyBDSVAgQ29y
ZSwgZ2VuZXJpYyBwcm9maWxlDQo+ICsjDQo+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywg
MjAyNA0KPiArIw0KPiArIyBBdXRob3JzOg0KPiArI8KgIFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJp
bi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ICsjDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBNSVQNCj4gKyMNCj4gKw0KPiAraW5oZXJpdCBkcGtnLXJhdw0KPiArDQo+ICtTUkNfVVJJ
ID0gImZpbGU6Ly9zd3VwZGF0ZS5jZmfCoFwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIGZpbGU6
Ly9od3JldmlzaW9uLnRtcGwiDQo+ICsNCj4gK01BQ0hJTkVfSFdfVkVSU0lPTiA/Pz0gIiINCj4g
K1RFTVBMQVRFX0ZJTEVTICs9ICJod3JldmlzaW9uLnRtcGwiDQo+ICtURU1QTEFURV9WQVJTICs9
ICJNQUNISU5FIE1BQ0hJTkVfSFdfVkVSU0lPTiINCj4gKw0KPiArZG9faW5zdGFsbFtjbGVhbmRp
cnNdID0gIiR7RH0vZXRjLyINCj4gK2RvX2luc3RhbGwoKSB7DQo+ICvCoMKgwqDCoMKgwqDCoGlu
c3RhbGwgLXYgLW0gNjQ0ICIke1dPUktESVJ9Ii9zd3VwZGF0ZS5jZmcgIiR7RH0iL2V0Yy8NCj4g
K8KgwqDCoMKgwqDCoMKgIGlmIFsgLW4gIiR7TUFDSElORV9IV19WRVJTSU9OfSIgXTsgdGhlbg0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnN0YWxsIC12IC1tIDY0NCAiJHtXT1JLRElSfSIv
aHdyZXZpc2lvbiAiJHtEfSIvZXRjLw0KPiArwqDCoMKgwqDCoMKgwqAgZmkNCj4gK30NCg0KLS0g
DQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

