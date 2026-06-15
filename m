Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C6CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 09:40:13 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.126028.1781516407629231241
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 02:40:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UbNguLYS;
 spf=pass (domain: siemens.com, ip: 40.107.130.4, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYUrs94YiQ04MrdspjxehM6g4mvH1MM8vpWNC2XFq47D84BrOgDjEnH/eVux+F15ejcsRZQnSFNqSYffpTbwSE5DMyJeAOlI5ZWqUJhrp5/HABz5ubwwCyBnoT0tzE0zhus7rC2Zr3CjBIAkRDGqvLNSvl2V87nVwXKVM18CSQWLd43s9YLAxoTI+qeq5oK9G1rHOyl+T8uq+zQHkN/nmemxHOHOrAaywHvvkdX4OQrqxfCDx0pZ73aUJTjVLHgitGm1WpqAH7RW6gVopF+lyUZdUDacVyYC8KfMY2R3psWuBrxQN9rzMNVEvML6ccdLAORZLtwLpgtNaJAW/03vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8IQVeVY37os7J0t2YHVMiqgK+nUNk7OUXU+Mscife0=;
 b=dvw1JlGBGrg/525oSICs1Ca9C136oUsWY5UJ8uc2M5dNqoFcVLGTpY3NAzLpL052TM/h9YyLdNMTbu9Gt8YMZiyRXY1DfTtOYrwWPQI51nfrN2ja+XJKgzJEXzLzLA2LeUNdRwdsITfiwLEBj4PfC1duP7EGUFlp7Gf1H0yKj+hZX44ix3y/OdSjSU97uuOaBcV6zQH8RDWVewlrzNtCajmt7kwmpgyWGPgAuXpNP0eIiWZ7wGaB+vzMeEuzQ7TdrI6/nIHdB2wL/NJt9TIK4ninGraXWiCwlEM3hWeVltTuh/zKVayRgC/N6p0mFH+1127Tml0GS955yCEectw1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8IQVeVY37os7J0t2YHVMiqgK+nUNk7OUXU+Mscife0=;
 b=UbNguLYS1fHTWBkCUX3iGrA2BRqPdDLzenOTzj7krflM02JektLj5YJdxY9kHQ48j9OidBIVhio5ccAvigBQG+kzByHbxPwSk7va8aWbN1IZ/hxsKJiqvPeZ/YIwlz9jj9/bfODJxINUCgsSJNTPAcAQvzM4vqO3NMDR9EPEoGUkBpGeofXzBj3yGqaAKKccr2YB+OAIx0cIlGri8s9FbYBfg+hohjs/fe8sBmFjA1bE4iNZm0U3ImAx6d0uc9IaB0pOYdVJG1GcGe0J1JCD8JhOZsku22a+qMiwzOd7ZsiVx5eyPi5GNuenyoGrjuRcXmivynbVYB1DrQxKmSXHKA==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU2PR10MB7744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:491::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 09:40:02 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:40:02 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Arjunan, Srinu" <srinuvasan.a@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core] [PATCH 1/2] shtab: mark package as
 arch-all
Thread-Topic: [cip-dev] [isar-cip-core] [PATCH 1/2] shtab: mark package as
 arch-all
Thread-Index: AQHc/A44snow/9A23kOJQf9WXOpx5LY/XcQA
Date: Mon, 15 Jun 2026 09:40:02 +0000
Message-ID: <2ab1c9078bef00a746fef3a4e44dec675f408d84.camel@siemens.com>
References: <20260610212746.22275-1-srinuvasan.a@siemens.com>
In-Reply-To: <20260610212746.22275-1-srinuvasan.a@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DU2PR10MB7744:EE_
x-ms-office365-filtering-correlation-id: d382ca75-dc31-4bfd-626b-08decac212f1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|22082099003|18002099003|55112099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 wuzKoGCP2JGHKISteeVd1Czs2PzY/Ho8BpzUEu+Az5Nga5UD0tfUsLNLyKq+070MRhaKMc4GDgvaHLAmW9xAAM+1DJFIvKe02oDePhmt1qsoEahpirUrZgWGccZ3Bhkr0oxp448QbU9s2l+/cjfnFHxa3qylezRQytCLSQ4W/KBMjkJng/RDkrBwl2/3lfhNzZtakg8Q5gAvFQL4JRkufp9Ho3JPW88HPTI/fqRNdi5papETiSrVVG12ngI705R3LckLVvzJTelBT8+bdpKTfCRIB9ZkqwG8FMmRk/th67lYBK/XEVBVoUVrwTYtKNVf1L4UM74ouhee5ShUY/4ywketUxdAL2eepaKjH/8PU9zJx+e9gq3dazXY5qNETUWnSbyX5CXlBMbfhUhbvjeaDRBk2IzyulkMepeqlucMUjcYFN2Ae8FmlfXQVG7rtAbLdpuCSqtghmpWSuavC1cdlT9fXVsCFG277bZNE+73MnS0fSgbao+S0kbmmKicCfhnZ4zzJRLO5kYB9g3LNhdoorSbYWnwR4OBMUVe1skEJAvpK52QvCEfrZ+tBufXiSoPhrAO4CnXf+Tw4yXowfusgB0qa5AY6PTCCCId7komFpiC4cn0uq9WhFBVapSGYmtvMT1zTJnAQ51txSirXx8c3zL48i3AjqioDg3PywThq4uJSubeX6ZF3Ze69KGR+fIWwf5kU5A9PqCFXzFy765W1Ns8UYilgnqQzPsafDrbMko7Lr2X3X55xIqSWRPlP+se
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TWx2a0MwVmM5NHFUY0MxeVptbFNBQXlobU5xd1VmMkJRZmhrcWVMemhGOHFy?=
 =?utf-8?B?bERXK2c1ZktYY2VIWHk5REZxUkE1by9XeTJUUk1QVnd2TnlEeHQrUGlEVlhK?=
 =?utf-8?B?MVpGRWl4ODFLVTg1N3p5K2dVNVIrdkJaK1diY3hGbjRTQlhBWFBDVTh0OFdH?=
 =?utf-8?B?K2tKVG51bHgrMGxLL0xYcmVvNkIrTlovNnJWaExLbDVCWlhLK0Mwd3RmTkFi?=
 =?utf-8?B?U0pad1JMaEllZGdxZ2hNOWV1MHRRSzlGWWVJSGtTVHI5OW5GUkNzUktjbEN6?=
 =?utf-8?B?aVJTenVUVyt1SGhuTHozcDdHR0tJWUdSckFDVE15aCt2YlpWTUxBUXdFUU9t?=
 =?utf-8?B?dVNHT2VqcURYOXhWOVR1dmovQU9aQnJvbFBYZk9ScFEvWC8rMHlIUEZwMWtk?=
 =?utf-8?B?Mld5d2t1SEx0ZnZkdWV3akFYUktnWTd4bGg2SUZjYnhEY3NhTndkcUo2STAx?=
 =?utf-8?B?RERpa2lPMjFxYzdRL2Nob2tiR0xQcnNCSXg4REh1aUJHQUk1WlB3cWl6bzdX?=
 =?utf-8?B?b0hhd2lFWGQ0Nk9KeDliWklGQXVTNnNwdThOWmx0bllTM3NkcDhOem1sWUQ5?=
 =?utf-8?B?alo1UjlnSm9zaUJWeGVQRkRFaStJUVdSdmxya1c3bWlkYTBGLzQzOWtQWmJm?=
 =?utf-8?B?MTNaZlFUQk1FR09aNXlKODJjUFJreHVMMitoclUxeHJmTmFkTUZKbTVhRkly?=
 =?utf-8?B?VmRDd3ZvQmdiQjFsbmJzN0VXSkFRdVYvdWNOVVpkcUs5Um9RMUJpVkxSMmRO?=
 =?utf-8?B?MXZwQ1htMlJwSytUam5mT3IxUnQrR1gzN21tNFdSdjdyQSszWTNldVNzajIz?=
 =?utf-8?B?bmRoU2ZKM21wWDhncDIrNEl2UEZDN0ZKTDRWeFNMeWZNVmhORHZVUVZyRlFt?=
 =?utf-8?B?aWpaYWpkMytSYlNHUkpSMkJuNi96am9BSmV3SUVTdW1HY0NFN1JxTmI2OXpY?=
 =?utf-8?B?THI5TUIvK0wvbXZJQUpnYlVGLzVXMktocWFtRElVbCtWa2RmMGZFN294MFNH?=
 =?utf-8?B?TDRJdTl3R01jVHd2TXV1cVJBK0NpY1NrQXdnMlFrTDZnQXRKT1piczNkODlK?=
 =?utf-8?B?bjY4bWROaVpQd0tVVHdkNllYZnFBakI5VDg0dzNHVUJTSktxb3EvUUQyZ3Mr?=
 =?utf-8?B?b21SMEVZR3EwNkxsV3hkLzJ5NUJqR3JEZUwyWHNoZUFjVEI3d3pDRnJyOWFp?=
 =?utf-8?B?NzJNc09laUl1K2Q3M0c4NDdyT0RRVFhHTEY0Tjc3Nk5lbDh2bDNFMm5jaDlw?=
 =?utf-8?B?TnB0NnJrUVh4aWVIY2lQZEVvSkpyZXFZZEdXRjNVc2FhUzEyaXJOUUZmMXRW?=
 =?utf-8?B?MVFHaS9LSis0TUN2cDIyYVhGdVlkUVFGTmpicHgwQzVMY1dWSEthN3oreVFB?=
 =?utf-8?B?OTF4bDJyOEJ1SWVIWC9BcVVrenl6UnZ4UkorZk5tTUFyNnREcGVEQWFGcGg3?=
 =?utf-8?B?RlVNNDNxaE5YUmdaNEZ0eVZjMWJCaDRBcENRcXNCaXBNYStCU29hQ2NReFpK?=
 =?utf-8?B?ODZpZWV1QU9TN2UxR3NtcWxYclhDK2dtZTBkZ3huMnRTV0s3N09QSkJ6NU40?=
 =?utf-8?B?ZHF6K1JvOFNGME5tZXI2d3ZTak9Yem5vUFd5aHd3eU8wYVp0eE1hRXFYc0xK?=
 =?utf-8?B?RkROamZ2ZlFNK0FGYUtMQUFISHNGem02S0pVaDJkb3JXYXh0TDFtQ3RRSG8r?=
 =?utf-8?B?RnlCV1c5MnN2TCtSVkVHZlNsMUsrRXpBZ0NtMGFWZkFUVGQxZkxPR3JiOVJW?=
 =?utf-8?B?eElha3l3czFyUGpBdXEzQUd4aGU3RGJEemNNTlhwTTJnZUU3aDY5NTk3cGFi?=
 =?utf-8?B?UUZnY3BwVnJjNG5zUUQwK1NYM3Fma0FjNHhwdEJEdGs1YkZTZ0xvU2R2UDNJ?=
 =?utf-8?B?TklNRVF6b0RiVnN3WVZDQVZjYXFXSHVRcXRSU1hjQnJnUDdmODhoSDRNWkFG?=
 =?utf-8?B?dFhBbUEwd3hFYkVQK3J3WHpVVUs1dnlWeEY0SE4zak5rNEV0bHpUMnBpOE9v?=
 =?utf-8?B?WFpTS3ZGUkJXRjF0SGRhZ0dSMkwvbzhwTnBMZVFuN3NwSklsUkpnTjh5QWRO?=
 =?utf-8?B?blJqcE1RUTlyYWI4K0hKU0xBbWFPWGZFZ3BJZkNVQjNSK0dkWU5xYnA1UURJ?=
 =?utf-8?B?bjZ3eVZGSlp5QnJOclNNVEtkRll2dURkd21EaEZZZHZUUzZTNHg1MDdvQXdX?=
 =?utf-8?B?K1pLVXMyZjVQckFaakRsMnZvZlNXWXNDNWsvcUw4Vk41RVhpeXY2N0pOd1kx?=
 =?utf-8?B?KytmeHVNRGJBckM5RWc3dHZDdTNkVUhGVHEzNW5Lb25QNk9BY2tuc0NRMEor?=
 =?utf-8?B?eXJmeDFHQi9xYWREVnJZRFBHTWNoMll4VVBSaU1OM3lXWWFlUjA1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DCFE069536C3A479469C18ACC39BF89@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d382ca75-dc31-4bfd-626b-08decac212f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 09:40:02.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBzChb3skTLYlWAtOyR2r3vymj70Nxus9SJbQJdUw+FXvRRq4sH4/ZmOt5xMSnr2pxOk9VTEjg3sd50cRH8/N8Y7A1bxFl6OxfBskycQ30o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 09:40:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23140

T24gVGh1LCAyMDI2LTA2LTExIGF0IDAyOjU3ICswNTMwLCBTcmludXZhc2FuIEEgdmlhIGxpc3Rz
LmNpcC0KcHJvamVjdC5vcmcgd3JvdGU6Cj4gRnJvbTogc3JpbnV2YXNhbiA8c3JpbnV2YXNhbi5h
QHNpZW1lbnMuY29tPgo+IAo+IFJlY2VudCBJc2FyIGNyb3NzLWJ1aWxkIHByb2ZpbGUgY2hhbmdl
cyBhZGQgdGhlCj4gYC0tbm8tYXJjaC1hbGxgIG9wdGlvbiB0byBzYnVpbGQsIGNhdXNpbmcgc2h0
YWIgdG8gZmFpbAo+IGR1cmluZyB0aGUgYnVpbGQgYXMgaXQgaXMgYW4gYXJjaGl0ZWN0dXJlLWlu
ZGVwZW5kZW50Cj4gcGFja2FnZS4KPiAKPiBTZXQgYERQS0dfQVJDSCA9ICJhbGwiYCB0byBmaXgg
dGhlIGJ1aWxkIGZhaWx1cmUuCgpSaWdodC4gVGhhbmtzIGZvciBmaXhpbmcgdGhpcy4KClJldmll
d2VkLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPgoK
PiAKPiBSZWY6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbGJlcnMvaXNhci9jb21taXQvMzI3ZmIzMTMK
PiAKPiBTaWduZWQtb2ZmLWJ5OiBzcmludXZhc2FuIDxzcmludXZhc2FuLmFAc2llbWVucy5jb20+
Cj4gLS0tCj4gIHJlY2lwZXMtcHl0aG9uL3NodGFiL3B5dGhvbi1zaHRhYl8xLjUuNS00LmJiIHwg
MiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBh
L3JlY2lwZXMtcHl0aG9uL3NodGFiL3B5dGhvbi1zaHRhYl8xLjUuNS00LmJiIGIvcmVjaXBlcy1w
eXRob24vc2h0YWIvcHl0aG9uLXNodGFiXzEuNS41LTQuYmIKPiBpbmRleCA4Y2NlZjM1Li4wM2Uw
YWVkIDEwMDY0NAo+IC0tLSBhL3JlY2lwZXMtcHl0aG9uL3NodGFiL3B5dGhvbi1zaHRhYl8xLjUu
NS00LmJiCj4gKysrIGIvcmVjaXBlcy1weXRob24vc2h0YWIvcHl0aG9uLXNodGFiXzEuNS41LTQu
YmIKPiBAQCAtMTEsNiArMTEsOCBAQAo+ICAKPiAgaW5oZXJpdCBkcGtnLWdicAo+ICAKPiArRFBL
R19BUkNIID0gImFsbCIKPiArCj4gIE1BSU5UQUlORVIgPSAiY2lwLWRldiA8Y2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc+Igo+ICAKPiAgU1JDX1VSSSArPSAiIFwKPiAtLSAKPiAyLjM5LjUK

