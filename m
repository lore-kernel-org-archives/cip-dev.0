Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCD9C47DAF
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 13:18:37 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.73])
 by mx.groups.io with SMTP id smtpd.web10.17756.1705653695139408331
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 00:41:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EfTB//9T;
 spf=pass (domain: siemens.com, ip: 40.107.8.73, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7U1nlOFIB5tscwgrgNrsKfSnkfhW69//DkUkkvNksn92t+o+erwxfEKwo4pHNbKr8x2kAoR28M8cBOfgvmHv1WQX7tiGTZUAZGWwH+KGaScbsD8ZQUb4NiyIdR5bXkfnGMi/jV+xifvEnXRShTTzdAZVvmh6bAv4lv9NjG/McUg2fr6oYKbxWYm676NZW9C2dAgR59UIRoJxWW5HUnywqT0AA1ikEz9+7Sd3Xv59zVyulh9oJhZNe1ubaQ1BNFZDgchLxMGqtMfB0ym19gagCITifzUkCB/O4x8FsoNoPMtdQO/Rw6avP/CJP17wujDS2gZuMt4TxnDlpDdMF107Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBlJbykCgwbrRXDfMEZ5WMaNRqtlwU5RCNQJxglkZpk=;
 b=htEmCR9xBvbjrd2/Dtgc3YqTvNbegVqomJLb19m9bNo76AiXi4/e5SGwAO+ffDlK1D9I7adJKR7CA8K5gT+/M1032ysVBT2/5O4XncFBve3jxfoHmCWCbX3Hh+wG55OsUPjOaiFy1pPOS6tfPlLYYu+mYk+4LEn0lsu9mUhuVomeTTGU4ptpL1RMvmiq0gJDAj88kfF4TNsfRxY8J9zKvwbcA7TIlhCG1kIqCokq30lOo+0049sS4tnzbDsFn1BA4tdPHanZ+5GTrDJsYYvGdaqk4Eplt5xChq2cdeLoQzwlpaSi034XMPNdd1VPJ3D1Ya3i6BDALU1+DPj8sYv91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBlJbykCgwbrRXDfMEZ5WMaNRqtlwU5RCNQJxglkZpk=;
 b=EfTB//9TeP3BYfZCssciNvvoBRJnAYXtbLF0iYHmtuiaqRAXVvXz2GOgP2jLQq9nXxk5ddKDJGupQomru5GxmJZV4sA4v9pGEdgZZtgzNtIyLmrczEImiAAmdAomwyjZVzx0vBNyAti23PdeYNQqdUIHXQrU1AxxYT3+ycuceC+Z51KjfkcfkskwP+PGdOjpLTnEsEsgWlF9b+TvWcWUUdTu8HVMTJu6YHna/bT5ChgZkztnNABUxn0qMfX6zPMOqdGHLz6PIUY9unt1hpYlKfuFs6GoJb7YDrGBwq+5BmPJQgaYV2lQT5uKUQKZNuw6nUuHE18XTKe+DAw86Po9fg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AM0PR10MB3169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 08:41:29 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 08:41:29 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2] efibootguard: Update to latest debianization
Thread-Topic: [isar-cip-core][PATCH v2] efibootguard: Update to latest
 debianization
Thread-Index: AQHaSkeZ4Iiq4V9XG0yZcQmZWn7n/rDgAmoAgADPnAA=
Date: Fri, 19 Jan 2024 08:41:29 +0000
Message-ID: <e00b6e017009e96402ea2f17a4294757b48e958c.camel@siemens.com>
References: <2b28ca7e-846f-47f3-bf8d-20e98cbe08b9@siemens.com>
	 <b8d7723c-f000-4e59-868d-e72e82a00e84@siemens.com>
In-Reply-To: <b8d7723c-f000-4e59-868d-e72e82a00e84@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AM0PR10MB3169:EE_
x-ms-office365-filtering-correlation-id: 8ad28ade-04bf-4bdb-f780-08dc18ca6e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7qh6Qi12BZMc81CgN1dp3wPdGjzfX+13Kd6I5eGTqpB1xOQ2VpwN997mkHQ6t2H6pU9VuWxWueUNAxm+uDLyXG920WE+WAH8KXCBL7cxIuZJk4hX8FSaZxODrI60qdBjDg5ca1viT93QR2JR7VUfMDfNxw5V4PmzNma0Vl5hc4dDe/YiUnziCmqnlXWP47t0Fzvm35FuVpHkgaBnoKDJ+ACcwHV2oMoXyexi2Z5rCSLW6gEUgiSwczw7kVmCEjdEySq5CElGrL9chRApD87DXoB0i1i+WxY0RHpFeTmHtJ/CBirTMeO68azR5b4XNyKkhK3IxIyY3rGbtn0fYu3u3oI0EU5TpeFhTE5MaBvTx82U2zh0n8Wmjmu54aZhq5kNjTd7N0F0a2cZWyKdSBCBWFp1uZqmdLSyKN7Db7PX/HkizeeNGYVFBNfDWzphtM5EBNfQAH3MqbLjg+ak8R3s9xsqo5xLjJodh6yi9c0B4zDhDkmkMyHj01hrohQq7IfSQOCo2owrNy4McpYeVCHtO2zh058kHuhQr6EFvvdE0EVbShWw22H97H60kgI/blzpvwLpHEbUr/OITcNqXXoA/oVZzT1vdiw2xO5b6PDKMA0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(4326008)(8936002)(8676002)(38100700002)(15650500001)(36756003)(82960400001)(2906002)(86362001)(38070700009)(41300700001)(122000001)(5660300002)(6506007)(53546011)(478600001)(966005)(6486002)(71200400001)(83380400001)(2616005)(64756008)(76116006)(66556008)(66446008)(66946007)(6636002)(66476007)(316002)(6512007)(110136005)(91956017)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dGwyQnUrSEd3UVNZZFFvZVNjYmp5TnpTUUM1VzFRTFdIenl4YjFtV1ZneGFJ?=
 =?utf-8?B?ZmdPYzlqblk0NkVzOGRPTXlpV0NBdGliZEJiZjBvQTFiT1NnMTB4YkdndHA3?=
 =?utf-8?B?aVhtU0w0RDQ2dHlJTmVZblFqSnhJSUJjREwyeTZBeVpwc2NpdWNPd1A1TVQ4?=
 =?utf-8?B?empBZ0x2SzFoTkQvUHJhSnd6RzNEWDFEaGxCengycmR3NnFHcm9WNU00VTdx?=
 =?utf-8?B?VVVsZ2pVcWdXeDdhdWhwcjl4d0xibFAxUlBkWkIvUGt6UFU1REpzM1M5TjYv?=
 =?utf-8?B?bTB5cnJuamFqRndzSTlsNSt2TGI4VVEzTkRJdnJ0aTN6ZG14NmFhc1Bxek5S?=
 =?utf-8?B?U2VxQm52OWRweWdGNWduK1A4N3BmV25YTXhwK1I2Vld6V2pIaVRCbGRCc1FJ?=
 =?utf-8?B?dzVLbXpPQWs3ZkUvOExEZHJ1NkNHVUx5bCtYUWJEU3FyeXJMQXJWNk5tQTZO?=
 =?utf-8?B?Vm5CcVQyQmx0My84SEtSci9qaHE4T3BIbTFUeHp4dVRDd3FHOGlpNnFWUHM0?=
 =?utf-8?B?bnpvV1pCcm80U1dHc1BhUWE0UndRa1B0UUNIRFhhWXdjSWlvN3d6VXF3bXRE?=
 =?utf-8?B?WlRaRG5Fcmh0QTNiZUlHK2FPb2dyWWRDWGlYZ1hGaTFHZHQwd3hBTHhrSWxx?=
 =?utf-8?B?OXVvSWMvVW5ZRTM2S3JUTzdORGxZMDFseUVaWk0vWStVOHdybjBlUmxUZFlm?=
 =?utf-8?B?MDB3N1d5eEV6OUhGTDIwM0s2SXRsMDJydnYvRWorM0lkSGVwWGpQc3BJTmZp?=
 =?utf-8?B?M0NGM0swdm9la3p6RWlZRTR5UUl3M3BSby9VSVVHNUFSQXF4M2FQc2s4emRE?=
 =?utf-8?B?d29jQ1VSVVVrRmpoM1ZDMC9SZ21lWkhsU0x6eC9YbEt2VXk2c2paVFFoUVdK?=
 =?utf-8?B?cXo3UGxGWDB4c2YrcytWVXhyNkM3L21pVXMyV2FlNHVLclZENGFSNTlDS0lC?=
 =?utf-8?B?U3RKUy9FVkdrclpuYTQ4UU4xV2VMNUdxcGxsWHRsZkJWaGZkbXAyV3FZVk1n?=
 =?utf-8?B?VGdUUFRmVU1WVndRNmw2anFnMmF2OFBoSWFzR2xPRTVKNjZFNlFsUkhTOFI3?=
 =?utf-8?B?bldrN0puV3BFL3dvcGdFNjZvQ0MybnNnSHppN20rZmJLWDNZSnBOUC9taDJJ?=
 =?utf-8?B?eVdDNkhsbENveWV2YUlnMmtpeW9KOFZCcjM4VDZBTkMzMkh0VUJUK3VQclE0?=
 =?utf-8?B?T1p0enJYcHdNb2VEb29GU1krbkxmamNsV1krVnVsUFc1MS9KbHNsOStUNFFK?=
 =?utf-8?B?TnhLL25SNGxiK2dQRUFIblArTDZwRjM4ZlVZbVJ0Mkl0SnMxOHQ3ZWhYdUVk?=
 =?utf-8?B?L1ZaSi9IeEtlTmhuUmNhaG5sUTRDS1ZYenMwMlNTWVJxZjVYMkFUNXlDUmlv?=
 =?utf-8?B?cThJS1FXWlBiaHBOYmdwNlBHY3ljL3hrUS9IcTR4bVVrNVBINmVrMVNoRFBv?=
 =?utf-8?B?SHpTV09YMUtqMlBpdng0eDNuK1duUUZxV1BuV1g0Z0wxS0QwREo1ZFhoTXd5?=
 =?utf-8?B?WnJvR2tOTEJNYzBHcEZPdmdWZitweVNuNlNWQ2lCeU9NNkZyeFBWWVZzUVps?=
 =?utf-8?B?RVNyVUR6eEN5cndmQTNkMnFEb0tsTjJhZmhtazlqV1JMTmxDNGxqR3AzVlhM?=
 =?utf-8?B?NDJnSFNGMHd4dFdFUjJxUnhDT0lzZHQxcUtXNkFqY0tpU1BCWWFhc3U4WHFy?=
 =?utf-8?B?V1h3RmE1cncyWHNBSzdxOVFoWHNSemV1Z1JEQjR4a3dFVDBqQnluQjc2SmZU?=
 =?utf-8?B?NnRrWTRLeUMzSWN2ZW80WFNidVVKTHVTeGxYZkIwTVUwZUxOVzk0L3hRbXpJ?=
 =?utf-8?B?ZWFEa3Vud1NscjFPYTJyeVA4L2M0U21FbHVHeitGendkMHg2M1BxMDJ1QWl0?=
 =?utf-8?B?bTdrY0EzVHluRHd4TWZ1eVN6Nnd3dlNHcFkvYmlUdnRKWXJ3Sy9OSzU2Q0wv?=
 =?utf-8?B?UzgrbDY1Z2xtQ1h3Z0VpSWlCajNPTWpHMjh2ekV3b25pdXdaMEtkYVk3MGtC?=
 =?utf-8?B?S0ljbUVmR2FoTjZ6RlJDNERxdXRVU3JCRlZUdTBZNm5HUDkxQWlSdmY2bzMy?=
 =?utf-8?B?ejVqN2JzbHY2VnlxajIxZmY4aXFBb3dQekFnVFJ5ZzNWR1F1VGNFc1I1M1pV?=
 =?utf-8?B?cEh3ait2TmlobDRSRzZIQ1JzOStSRzU1aTdiRTVtQVM1c3FuNnkwajF4Ukpu?=
 =?utf-8?B?MUdLSVU1RGNCZnlCNU5iMG9YS1gxakdhQ2o4RHRTU2ZtUVduK0dqL2ovR1FK?=
 =?utf-8?B?Z0hVeUxYc3k2akR5dGpacllFcXF3PT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad28ade-04bf-4bdb-f780-08dc18ca6e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 08:41:29.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjOtiXvvAQ9W/k3MJ6heNNMENE7zXjJbp1foPjQmBdD1vTMEGk7WWuPIuSqbCoIgiC6qtlPI2LoviK6E8gSD7ZqENCGMdLKnV0JwNWfp3XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3169
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8A74119B914A247BC214ECC1BCD9D48@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 13:18:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14427

T24gVGh1LCAyMDI0LTAxLTE4IGF0IDIxOjE4ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxOC4wMS4yNCAyMDo1MCwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiBGcm9tOiBKYW4gS2lzemth
IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFRoaXMgZml4ZXMgY3Jvc3MtYnVp
bGRpbmcgYW5kIGFsbG93cyB0byB1c2UgcHl0aG9uMy1zaHRhYiBpbg0KPiA+IGJvb2t3b3JtDQo+
ID4gYW5kIG5ld2VyIGZyb20gRGViaWFuIGRpcmVjdGx5IC0gYXQgbGVhc3QgYXMgbG9uZyBhcyB0
aGF0IHZlcnNpb24NCj4gPiBkb2VzDQo+ID4gbm90IGluY2x1ZGUgdGhlIE11bHRpLUFyY2ggaGlu
dCB0aGF0IHdhcyByZWNlbnRseSBhZGRlZCBhbmQgdGhhdA0KPiA+IGFsc28NCj4gPiBvdXIgb3du
IHNodGFiIHJlY2lwZSB1c2VzLiBUaGF0IG9uZSwgaW4gdHVybiwgaXMgaW5jb21wYXRpYmxlIHdp
dGgNCj4gPiB0aGUNCj4gPiA6bmF0aXZlIHN1ZmZpeCB0aGF0IHdhcyBub3cgYWRkZWQgdG8gZWZp
Ym9vdGd1YXJkJ3MgZGVwZW5kZW5jeS4gV2UNCj4gPiB0aGVyZWZvcmUgYWxzbyBuZWVkIHRvIHN3
aXRjaCBvdXIgc2h0YWIgZGViaWFuaXphdGlvbiB0byBhIHZlcnNpb24NCj4gPiB3aXRob3V0IE11
bHRpLUFyY2ggeWV0LiBXaGF0IGEgbWVzcy4NCg0KV2h5IG5vdCBzaW1wbHkgYWx3YXlzIGJ1aWxk
IHNodGFiIGZyb20gdGhlIGxhdGVzdCBjb21taXQgb24gc2Fsc2ENCihpbmNsdWRpbmcgdGhlIE11
bHRpLUFyY2ggc3BlY2lmaWVyKT8gSGVsbXV0IGNvbmZpcm1lZCwgdGhhdCB0aGUgTXVsdGktDQpB
cmNoIHNwZWNpZmllciBpcyBpbmRlZWQgY29ycmVjdCBhbmQgdGhlIHdheSB0byBtb3ZlIGZvcndh
cmQgWzFdLiBCeQ0KdGhhdCwgb25jZSBkZWJpYW4gdXBkYXRlcywgd2UgYW55d2F5cyBuZWVkIHRv
IHVwZGF0ZSBFQkcgYXMgd2VsbCBhbmQNCnJlbW92ZSB0aGUgOm5hdGl2ZS4gT3RoZXJ3aXNlIGl0
IGJlY29tZXMgRlRCRlMuDQoNClsxXSBodHRwczovL2xpc3RzLmRlYmlhbi5vcmcvZGViaWFuLWNy
b3NzLzIwMjQvMDEvbXNnMDAwMTIuaHRtbA0KDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFu
IEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiBJIHdh
cyBjb25zaWRlcmluZyB0byBob2xkIHRoaXMgYmFjayB1bnRpbCBweXRob24zLXNodGFiIDEuNS41
LTQgaGFzDQo+ID4gYmVlbiANCj4gPiB1cGxvYWRlZCBieSBEZWJpYW4gYnV0IHRoYXQgd291bGQg
ZGVsYXkgb3VyIENJIHRlc3Rpbmcgb2YgcmlzY3Y2NCANCj4gPiBiZWNhdXNlIGNyb3NzLWJ1aWxk
aW5nIHB5dGhvbjMtc2h0YWIgZm9yIHRoYXQgYXJjaCBpcyBjdXJyZW50bHkNCj4gPiBicm9rZW4u
DQo+ID4gDQo+ID4gTm90ZSwgdGhvdWdoLCB0aGF0IHRoZSBnZW5lcmF0ZWQgc3d1cGRhdGUgaW1h
Z2Ugd2lsbCBub3QgYm9vdCBpbg0KPiA+IHFlbXUNCj4gPiBiZWNhdXNlwqAgdGhlIDYuMSBrZXJu
ZWwgKGp1c3QgbGlrZSBvdGhlciB1cHN0cmVhbSBrZXJuZWxzKSBpcw0KPiA+IG1pc3NpbmcgDQo+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC80MmM2M2NiOS04N2QwLTQ5ZGItOWFmOC05
NTc3MWIxODY2ODRAc2llbWVucy5jb20vDQo+ID4gDQo+ID4gwqAuLi5ib290Z3VhcmRfMC4xNi0x
K2NpcC5iYiA9PiBlZmlib290Z3VhcmRfMC4xNi0zK2NpcC5iYn0gfCA4DQo+ID4gKysrKystLS0N
Cj4gPiDCoC4uLntweXRob24zLXNodGFiXzEuNS41LTQuYmIgPT4gcHl0aG9uMy1zaHRhYl8xLjUu
NS0zLmJifSB8IDIgKy0NCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiA+IMKgcmVuYW1lIHJlY2lwZXMtYnNwL2VmaWJvb3RndWFyZC97ZWZp
Ym9vdGd1YXJkXzAuMTYtMStjaXAuYmIgPT4NCj4gPiBlZmlib290Z3VhcmRfMC4xNi0zK2NpcC5i
Yn0gKDg5JSkNCj4gPiDCoHJlbmFtZSByZWNpcGVzLXB5dGhvbi9zaHRhYi97cHl0aG9uMy1zaHRh
Yl8xLjUuNS00LmJiID0+IHB5dGhvbjMtDQo+ID4gc2h0YWJfMS41LjUtMy5iYn0gKDkxJSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1ic3AvZWZpYm9vdGd1YXJkL2VmaWJvb3RndWFy
ZF8wLjE2LTErY2lwLmJiDQo+ID4gYi9yZWNpcGVzLWJzcC9lZmlib290Z3VhcmQvZWZpYm9vdGd1
YXJkXzAuMTYtMytjaXAuYmINCj4gPiBzaW1pbGFyaXR5IGluZGV4IDg5JQ0KPiA+IHJlbmFtZSBm
cm9tIHJlY2lwZXMtYnNwL2VmaWJvb3RndWFyZC9lZmlib290Z3VhcmRfMC4xNi0xK2NpcC5iYg0K
PiA+IHJlbmFtZSB0byByZWNpcGVzLWJzcC9lZmlib290Z3VhcmQvZWZpYm9vdGd1YXJkXzAuMTYt
MytjaXAuYmINCj4gPiBpbmRleCBhN2ZmYjAwYi4uODNiZTJhNGQgMTAwNjQ0DQo+ID4gLS0tIGEv
cmVjaXBlcy1ic3AvZWZpYm9vdGd1YXJkL2VmaWJvb3RndWFyZF8wLjE2LTErY2lwLmJiDQo+ID4g
KysrIGIvcmVjaXBlcy1ic3AvZWZpYm9vdGd1YXJkL2VmaWJvb3RndWFyZF8wLjE2LTMrY2lwLmJi
DQo+ID4gQEAgLTEsNyArMSw3IEBADQo+ID4gwqAjDQo+ID4gwqAjIENJUCBDb3JlLCBnZW5lcmlj
IHByb2ZpbGUNCj4gPiDCoCMNCj4gPiAtIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjAt
MjAyMw0KPiA+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAyMC0yMDI0DQo+ID4gwqAj
DQo+ID4gwqAjIEF1dGhvcnM6DQo+ID4gwqAjwqAgUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5
bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPiBAQCAtMjQsNyArMjQsNyBAQCBTUkNfVVJJID0gIiBc
DQo+ID4gwqDCoMKgwqANCj4gPiBmaWxlOi8vZGViaWFuLXBhdGNoZXMvMDAwMS1kLWNvbnRyb2wt
TWFrZS1jb21wYXRpYmxlLXdpdGgtZGViaWFuLWJ1c3Rlci5wYXRjaA0KPiA+IMKgXA0KPiA+IMKg
wqDCoMKgICINCj4gPiDCoFNSQ19VUklbdGFyYmFsbC5zaGEyNTZzdW1dID0NCj4gPiAiZDZkMzdj
NTlhZWQxNzQ4OWQwMmI0ZjBiNjNkYjE2OTk0ZGZiOGY5ZjcwZjU0YmU0ZDY1YzM2NmY1OGM2YmU5
ZCINCj4gPiAtU1JDUkVWX2RlYmlhbiA9ICIyZTgwZmFmYTg3ZjhmNmZkMDkzZjQ5ZmYzM2FkN2Nh
YzYxNTkyODcxIg0KPiA+ICtTUkNSRVZfZGViaWFuID0gIjIyYjE3M2EzMjkzYzk3NmM5ZGZmMmFl
OTIwODVkN2VkOTk1ZjY3NjgiDQo+IA0KPiBTb21lb25lIHJlc2V0IGhpc3Rvcnkgb24gc2Fsc2Es
IGZvciB0aGUgbWFzdGVyIGJyYW5jaCAtIHRzcywgdHNzLiBTbw0KPiB0aGlzIHdvbid0IHdvcmsg
YW55bW9yZS4NCg0KVGhpcyBpcyBpbmRlZWQgYmFkLiBNYXliZSB3ZSBzaG91bGQgY3JlYXRlIGEg
YnJhbmNoIGZvciB0aGUgY2lwIGhpc3RvcnkNCnRoYXQgaXMgc3RhYmxlLg0KDQpGZWxpeA0KDQo+
IA0KPiBKYW4NCj4gDQo+ID4gwqANCj4gPiDCoFBST1ZJREVTID0gImxpYmViZ2Vudi1kZXYgbGli
ZWJnZW52MCBlZmlib290Z3VhcmQiDQo+ID4gwqANCj4gPiBAQCAtMzQsNyArMzQsOSBAQCBQQVRD
SFRPT0wgPSAiZ2l0Ig0KPiA+IMKgDQo+ID4gwqBpbmhlcml0IGRwa2cNCj4gPiDCoA0KPiA+IC1E
RVBFTkRTID0gInB5dGhvbjMtc2h0YWIiDQo+ID4gK0RFUEVORFM6YnVzdGVyID0gInB5dGhvbjMt
c2h0YWIiDQo+ID4gK0RFUEVORFM6YnVsbHNleWUgPSAicHl0aG9uMy1zaHRhYiINCj4gPiArDQo+
ID4gwqAjIG5lZWRlZCBmb3IgYnVzdGVyLCBidWxsc2V5ZSBjb3VsZCB1c2UgY29tcGF0ID49IDEz
DQo+ID4gwqBweXRob24oKSB7DQo+ID4gwqDCoMKgwqAgYXJjaCA9IGQuZ2V0VmFyKCdESVNUUk9f
QVJDSCcpDQo+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtcHl0aG9uL3NodGFiL3B5dGhvbjMtc2h0
YWJfMS41LjUtNC5iYg0KPiA+IGIvcmVjaXBlcy1weXRob24vc2h0YWIvcHl0aG9uMy1zaHRhYl8x
LjUuNS0zLmJiDQo+ID4gc2ltaWxhcml0eSBpbmRleCA5MSUNCj4gPiByZW5hbWUgZnJvbSByZWNp
cGVzLXB5dGhvbi9zaHRhYi9weXRob24zLXNodGFiXzEuNS41LTQuYmINCj4gPiByZW5hbWUgdG8g
cmVjaXBlcy1weXRob24vc2h0YWIvcHl0aG9uMy1zaHRhYl8xLjUuNS0zLmJiDQo+ID4gaW5kZXgg
N2E1Y2ZkMmQuLmYyMGNkY2Y3IDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMtcHl0aG9uL3NodGFi
L3B5dGhvbjMtc2h0YWJfMS41LjUtNC5iYg0KPiA+ICsrKyBiL3JlY2lwZXMtcHl0aG9uL3NodGFi
L3B5dGhvbjMtc2h0YWJfMS41LjUtMy5iYg0KPiA+IEBAIC0xOSw3ICsxOSw3IEBAIFNSQ19VUkkg
Kz0gIiBcDQo+ID4gwqBTUkNfVVJJOmFwcGVuZDpidXN0ZXIgPSAiIFwNCj4gPiDCoMKgwqDCoCBm
aWxlOi8vMDAwMS1Mb3dlci1yZXF1aXJlbWVudHMtb24tc2V0dXB0b29scy5wYXRjaCINCj4gPiDC
oA0KPiA+IC1TUkNSRVYgPSI4ZGI0NjE1YjJjM2VlMGE5MzMyYjYwMzA2ODdlMTE3OWZjZmM4Njcw
Ig0KPiA+ICtTUkNSRVYgPSIzY2RjYTdjOGY0ZWFkMjNjMTk0YzRlOGE4NGUyNjMxOTg5ZTI2YjNj
Ig0KPiA+IMKgDQo+ID4gwqAjIFdlIGRvbid0IGhhdmUgcHJpc3RpbmUtdGFyIGluIHRoaXMgdHJl
ZSBoZW5jZSB1c2UgdGhpcyBvcHRpb24NCj4gPiDCoEdCUF9FWFRSQV9PUFRJT05TID0gIi0tZ2l0
LW5vLXByaXN0aW5lLXRhciINCj4gDQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGlu
dXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

