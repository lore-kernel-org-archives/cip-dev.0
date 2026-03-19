Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4321090254
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 16:35:33 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.453.1773938125101611527
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2026 09:35:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KMuM9kUe;
 spf=pass (domain: siemens.com, ip: 52.101.83.20, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLdLhbX59L0bjr2d5tvVnmPw8Rh2vKPP+wTSowYZYxd5RErXfEmNGmZaIECJaC9/W3mbOqCmzIin+iMHYHQ3Fs/f/+uYdeUGatA5YjMzYAhjxRuVH02WseOh/IBEDsEIPmzzUl/ieFReY2IlQyRiC8rF3pTKXcbIIyxozVCg/hzjZAydUS5Vz6p+QIpfhcyj/hP/0YXX61VsovC47r2wgQ+RGinfQZJk/A7uY/cvKWd487Q7pBkdMbseCKu2Hhk9AFPL+IX1AnXDCAQRfvVGj+IkoAq13tcF/CBzwkV8Flk7xeOd8FBfrAm81OoNA/JktDJll1qzjRjPZXlT2NAbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul7nP8zSa0vWt8GaugU2wcusnn8GEtkhttKk5NcJlgQ=;
 b=xV/DGlNbZgsVxqhwzrn+lmsJSVGgdW9jJCQFey21XydUYFsnHj3lN8fkGUpfI5Dpyfoc1DV8h3ITTS3YM+ek5auCa7lSDJz2NIncUyb9fk4T2UUIZBp2WRUtcgiKC8EegyPJril4P+G19Gg+bV4erni70YFP+kK2GiuA7PSyHfQXsRMePgTUbsPUmd5G7mYugnnZtwpOXSnF0fvjFrkPWV8sxyo4JKnJ3kBg4/v63jS4OUYQDC/6uhPrYmx51kWqdHj2IJnoNtO1ofgAJAMWead12fLCMUST9iBSomACxXpTLKom3+YUANNyRQhx+fprHzBVoe+0k3p+HWlapyH01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul7nP8zSa0vWt8GaugU2wcusnn8GEtkhttKk5NcJlgQ=;
 b=KMuM9kUe1Ka/i4Irtvf9b+vVxo1Rmh2+IiWN2mxGdz6A7GgXRz2FAmafeSku6AXS4nyv27v8tfjtaIoTMwrKA9tcFWqV6G1o8FnbdiJUkjMEbRqMzYr3HIaJqHoh1c9aJYSwjePbOmBzIRoGCDC/9HceH7DAIevS/bfSwd+igqYDP/rNdIq+VCxGFrDwNzTmoPKx0TI3G/L5mrlOe94w0B3hrCK8+kpvt9y07XIM6O/0RbtNMZiPEor3izFMEHjNZ+pqlc8/JChMjXdV8/feiH/aBEmpbI3p7jASoe5wA9/262j+vWUWDd+KG2vIT9Jo93O/ZA/tGIanKp6JcbYM2g==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GV2PR10MB9823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:320::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:35:20 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:35:17 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Set owner for
 reproducible swus
Thread-Topic: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Set owner for
 reproducible swus
Thread-Index: AQHct7fs5JPJXaR3mUaGWfRG+FXt0bW2DUqA
Date: Thu, 19 Mar 2026 16:35:17 +0000
Message-ID: <3e9027c3db1a174a46df9176d3cfbe19bcf1a975.camel@siemens.com>
References: <20260319154905.2525216-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260319154905.2525216-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|GV2PR10MB9823:EE_
x-ms-office365-filtering-correlation-id: 81f89df6-1f4f-49f4-5ed4-08de85d5811f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|55112099003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 2+rKKKrnzk4jyJuigJx5yowzLyPB37ZdShtCuPIPm1kWyho6ajlg2WIX9vbRJ+s/hs4U3z1sGwp631Z12D9K0axDX28Uc+kCcFAFSQOnIDDIx7gxkVDxgkNeJwCGOd2uiqPGGqcHsiHhCjTvGHlpsxBqYm24oKDgtIRUs4rLmJMBsxa3xTut4wlvsVlY700oF8bSqSzjRUWZVA0IXLaLtr3IA+hGlX6VBoMSL3PhxR+l1lND0dTSUkkImAMgl8n86pTcgIZXSLBGcUQPqFIJfHqhUM0bhNRpw+wdPIQuSZdYRZ+DvyDG9sHQMtyzuQGf6sAALMZUGdAoGt86UK8ib0DTnQ3kZXPo7+1CZkmsz3WPsXNOLLQQgRTmH+aejOsj4t8UzjPErVqS6kzS8qVhKzh3cO8W64VbFp+3yZDT9BnX6PV12r99W8Q6I7/S97eHRAkFIzHijUe2sNM9J7mNhAebeyqMw9KOASZd6VnACRIii54dNaOANXrUx4htrWcTbx0GK9ThAX4gfVlTKMTJHQswgZCEY/1i3+5gdcbE7fSTUfqDuXgGzItav7+InYLDcX21TMYSIBFnUoZwb8DmH/qV1c+BLY3vGcx+XkcjMfrxH1aSYFsm8dvi1ipwlYv1Gj19lM8e87eGFQ+XMHH9q1EkstAWE1O0wqtUrjeoN5l48J4a6HYW4oLVPHWYmBmB++oWrjKpHka+xJtizV8wSMAZei4SEn0yT3gKnUYWQqLLvvdbzYt5zUmt68u7YbdYZt12z0FinS8Yt9va1VtOE6m1l2cnFu8AawjFy4lYtBs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(55112099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aWRuWThnbnZtMWkxWFNISFdsY25mcW9Ja1FWMDRmdjdOLzIveW5vZDFBdHJ2?=
 =?utf-8?B?RHZ6YVk4MldKa1p6NEV1KzltWXEzc0tRTG9SdzlmS1F2dEhaVTVUL1VjbWpZ?=
 =?utf-8?B?RGF1SnU3R3hQbkdmcGhnMmpQTUpHbDJKSU9UUnVGd2N1eC9lTkJaY1Vva25Z?=
 =?utf-8?B?ODNBQm1sMXExN3BEUy9jSXQ4alpHdGRuMWYzdWNOcmlMK2E0Z29lVnVhWWph?=
 =?utf-8?B?Y1hDT0w0TXZ5UlJ3MWtlMDA5NWQ0VTF0TzQ5dWJNb09xZjhsNUwrS2JUQncv?=
 =?utf-8?B?UXMwYjVYRmMrZENWak5mUWYyZXY3VzIwS3U0MCtEWTZHc25ZejhyWjVIU1dh?=
 =?utf-8?B?Y3pSdWNuWGVZUWJKYnZNTWdCVERUQlB1dDZ3SEI5NmVzeEZNaEYrdXpsOTVW?=
 =?utf-8?B?cm0xR2xOWlVMSkRhdG1BSVZzbC9NUE8vbWQzNWsvZE1mZk14QUUxNXIrYXJE?=
 =?utf-8?B?UHJXd3ZTeEFRa1ZRTmEvRjY1T01WVGdET2pxR1pweHB3a2FlbGVadGh1aGdW?=
 =?utf-8?B?RkdXdkNpVnNuWUpLRWVTeFg4SUt2YUR2OHFyRXcwZm9FUkF2RUdGTXRZVTlt?=
 =?utf-8?B?TTBiTUQzb0IvbElYZFpFdmNtQm0wSXNrd3k4L0lvaFN4UFRuVE5BcnBqRG1L?=
 =?utf-8?B?RjVKNnRtVThYWGQybHptWnhBV2FVMEFNWHptRzRGZ1Bqayt6QkNYa2pGaVY4?=
 =?utf-8?B?b0xMR1grU3VndXpic2JrRXl0R2IzTjcrVnYxWnNjSUZMTUlWOEJLWmNYaElx?=
 =?utf-8?B?YjAycnd0WlNxTmhNbWRSTVFOSEZnTlpOSjVVejdzQ0lNVW52RjUxcVVtSlVE?=
 =?utf-8?B?LzNISHk3MkxtTWs4bEluMXNsZVdNVUZKTDYzS3JBZEVIYnYrTFlLcEZucVZR?=
 =?utf-8?B?SXlGV2RDb0YzQXdkWjE5TTBHMFJsU1VuUDhXMkI5RHVPN2JFMVJxUlEzVDZj?=
 =?utf-8?B?TWpGbzZRbWNLRVFVUWd0MHkwTTRXR3lsTU4rR0NsWVg0RTZ0MFBUNS9JNjZC?=
 =?utf-8?B?TW9DQUJPZHJpTWJOeDNaL0pwc3orYlM3cVZGbW56SEwyNFAyTGY0Yml2Q25C?=
 =?utf-8?B?R05FUStBU1NZRnIrczNOWHJSa2daSzFtVisyY0IrMytoUThuakhyMTZmclBk?=
 =?utf-8?B?Qm9VczdxZTl1NHlGQ1ZtUlM0SXZRU3lPaXpXMGIyS05ub25vNGs0c2tQZVd4?=
 =?utf-8?B?UHVXdUF1cFp4Uy8wK3JxbHRnVFdCMU1tVDlhUTNiSXgrL2VsdG83aElBMkxP?=
 =?utf-8?B?dE5tcjQ1cUN2MjFhTW1hNHFhVEN4TFRqWm1EQUhEYkUxZE1IZUVCUTEzanln?=
 =?utf-8?B?akdPWE1UUWFSNk40SGRta0paRjY1ZGdSbUljMm1TSlpITFVWc1NHWHVWT3Z6?=
 =?utf-8?B?cjNzMEptRWdFcHo0Z0ZDQWV5NWhpNmUxVm1ORFZYVzU3ZDJLWjhqVEJFMHlL?=
 =?utf-8?B?bHQxV3ZzajI5ZGw5UnMrZC9yS29ZZDlsbnhpOGhyWmNwcGxKcW9TVUFpSFR1?=
 =?utf-8?B?cXEvVDA3Q3RJU203MUUxTmh1SU1IOEVqV2dNMkt0RU45NDJWekFpUG96WDJn?=
 =?utf-8?B?aDJiRDhramlzT3I1b3M1VitsZE1jNVovUUFKNzl0citPZGNXWUtMbTNSNHpx?=
 =?utf-8?B?MDdIOHUzUXBjdzgreGJEVUJTUnlBWXY2ak5rNy9wQ2trejVia2grTFpVb1h4?=
 =?utf-8?B?cWF5T1ZOL0dzbXA4dS9HWlU1MDZSQUhxbzg0a3RBRm4weWg1bFp3N0QxMFBz?=
 =?utf-8?B?SzhaRXJoK1VUK3VwV3FJaXViMjRKOExndFRIVlpURzgxaWRsWmUrSDJUOVY1?=
 =?utf-8?B?OHVkUUVrOEJWTVlCV2FiUUNwTkN5N1F5elZWUG1SaEhVOW85RzNwblM2UEZE?=
 =?utf-8?B?MVJ5SEo2aGlLdHdaNGY2MUZ5Ry9KTEhCOEFzbTFMSllkczVUL1l1d3puYTZr?=
 =?utf-8?B?bGZkQVFrRDA1OE1LUDlOMTVGS0VESXVxZ25rd29IMjhDQmVaeDZVZXdrQkFl?=
 =?utf-8?B?azA4cjZqNjd4QlBlM0RaOEdyeGpuejNUNGJPYXhOVUVlVG9zaFVsUklURjBm?=
 =?utf-8?B?bURrYjBERzBDMUZTOGtQMTZtejRzcmJoYWZ2TFZvOFZkdE1JVktQUjJkQkE3?=
 =?utf-8?B?dkJZTmxJVzNLNUVGa1NPa0lsNWpXMVorRUNJTGtFUlorWHExdUFveE5CNUFr?=
 =?utf-8?B?ZVcwM3duYWhNaUhTY0Y2ajAwUThsQTIvR1g2VkFUQ01ic05rTytFYnBwa1F4?=
 =?utf-8?B?bVVQaFUyemtFR3ZZL1RqR0pYR3lFU0Z0NGRpaWRuUk10c1ZSU1BDQ2x6TkF0?=
 =?utf-8?B?K1BGdnF0VGxLa2h0eGdQZGJFZ0NlUURMSmhkL0VMWlJ0N2xmRWlEKzFIaEx2?=
 =?utf-8?Q?89ovf+lEcx9Ohb5mCfZ4EGswFhbBcUrJ+j6BANbdksCu4?=
x-ms-exchange-antispam-messagedata-1: tA64LtxjqXHfSI1uK4JJyqDdL1rIgNqMLMo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66ACD1F2292E1C45A9132DCA1651DA2B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f89df6-1f4f-49f4-5ed4-08de85d5811f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 16:35:17.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElAveYv9RV0CyVP8aYkg4tsNud1jlnK+uolorjA1siYXkVPkz66aBIefYP6TRRPCTkO6lVr01DT+up6lOq2/7nY4iirSsqb2HVreszZaAfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9823
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 16:35:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22512

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDE2OjQ4ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhdm9pZHMgbGVha2luZyBvZiBidWlsZCBpbmZvcm1hdGlvbiBhbmQgYWxs
b3dzIHRvIHJlcHJvZHVjZSB0aGUNCj4gc3d1IG9uIG11bHRpcGxlIG1hY2hpbmVzLg0KPiANCj4g
UmVwb3J0ZWQtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZA
c2llbWVucy5jb20+DQo+IC0tLQ0KPiAgY2xhc3Nlcy1yZWNpcGUvc3d1cGRhdGUuYmJjbGFzcyB8
IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2NsYXNzZXMtcmVjaXBlL3N3dXBkYXRlLmJiY2xhc3MgYi9jbGFz
c2VzLXJlY2lwZS9zd3VwZGF0ZS5iYmNsYXNzDQo+IGluZGV4IGQ5MmQ1NWYuLjhlOTAxNjkgMTAw
NjQ0DQo+IC0tLSBhL2NsYXNzZXMtcmVjaXBlL3N3dXBkYXRlLmJiY2xhc3MNCj4gKysrIGIvY2xh
c3Nlcy1yZWNpcGUvc3d1cGRhdGUuYmJjbGFzcw0KPiBAQCAtMjkyLDcgKzI5Miw3IEBAIElNQUdF
X0NNRDpzd3UoKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgIGVzYWMNCj4gICAgICAgICAgICAg
ICAgICBmaQ0KPiAgICAgICAgICAgICAgZG9uZSB8IGNwaW8gXA0KPiAtICAgICAgICAgICAgICAg
IC0tdmVyYm9zZSAtLWRlcmVmZXJlbmNlIC0tY3JlYXRlIC0tcmVwcm9kdWNpYmxlIC0tZm9ybWF0
PWNyYyBcDQo+ICsgICAgICAgICAgICAgICAgLS12ZXJib3NlIC0tb3duZXIgJChpZCAtdSk6JChp
ZCAtZykgLS1kZXJlZmVyZW5jZSAtLWNyZWF0ZSAtLXJlcHJvZHVjaWJsZSAtLWZvcm1hdD1jcmMg
XA0KDQpJIHByb3Bvc2UgdG8gdXNlIC0tb3duZXIgMDowIHRvIG1ha2UgdGhlIGNvZGUgbW9yZSBy
b2J1c3QgYW5kIGVhc2llciB0bw0KcmVhZC4gV2hlbiBsb29raW5nIGF0IHRoZSBwYXRjaCwgJChp
ZCAtdSkgYW55d2F5cyBzZWVtcyB3cm9uZywgaG93ZXZlcg0KdGhlIHdob2xlIGNvbW1hbmQgaXMg
ZXhlY3V0ZWQgaW4gYSBoZXJlIGRvY3VtZW50IHRoYXQgaXMNCihpbXBsZW1lbnRhdGlvbiBkZXRh
aWwpIGV4ZWN1dGVkIGFzIHJvb3QgYW5kIGFzIDw8J0VPSU1BR0VSJyBpcyB1c2VkLA0KdGhlICQo
aWQpIGlzIGVmZmVjdGl2ZWx5IGV4cGFuZGVkIGluIHRoZSBpbm5lciBzaGVsbCBpbnN0ZWFkIG9m
IHRoZQ0Kb3V0ZXIuDQoNClRoYXQncyBhIGxvdCBvZiBtYWdpYywgaGFyZCB0byB1bmRlcnN0YW5k
IHdoZW4gcmVhZGluZyB0aGUgcGF0Y2ggb3INCmV2ZW4gdGhlIGNvZGUuDQoNCkZlbGl4DQoNCj4g
ICAgICAgICAgICAgICAgICA+ICIke1BQX0RFUExPWX0vJHtTV1VfSU1BR0VfRklMRX0kc3d1X2Zp
bGVfZXh0ZW5zaW9uLnN3dSINCj4gIEVPSU1BR0VSDQo+ICAgICAgZG9uZQ0KPiAtLSANCj4gMi41
My4wDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1
ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==

