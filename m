Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B618C982FF
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 11:25:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7890.1790076353153319689
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 04:25:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t4z0Dxkp;
 spf=pass (domain: siemens.com, ip: 52.101.66.71, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxmn6imA4j417GPzRw2x8OWkASpEvfXHlW+6puaX9mBzMCL9E4VajEA9IqMWJxpbHbFaP66iHIwVk+awVMnHuqd5Az6CvoMUWAv1jaWVebMPMmRYc6OCpNTc5a7vV29ZC2z7YfB7alxVdk6sWZP7y5nQkrVbII/9V5EXZW/3g7uGdstQ8OSB7J/SKRqQJypUFeNPfgCqDLONziMXofYWHqfQ3SnSi49aap6uTM+sWe9tZH8Jzx38BLLwZAQ+1WnYEKQJcyRTgDmtP9LTi/a8c6e/AlCmz02BVoWdHmI3ZIjKekS9Hm3NBJ8/GddMhGWMN/nTKFn8H3AlC7rM0ok4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OlO1nCwLXQ8+PonkYgc3Xvz7AjxyWk0K/eO3KFWE8I=;
 b=R7w2m/K/yFL4qDD/TygdDQztu5aKw2h4+yzovwGZIlitjTLcxEhW2tKpk/KpMmsoX5oxPLtDhCBNDz3pchp7t7Upe/EQyKWBz0yEAUx8T5Cj/P35tVfSrRnp32cuPYoBpV206K6o+pqezjehNYod10yZYT7C6VbRovmQ66+1Bbn3HqKGlKtF6wKFW15T6QQbpsxVW9O3+hJoOSE5RAOLYIk3GnGD9pXBsAoFxUvSKCgVFMWB7yK0BHSmGKb8G1z2lxhtUBPkmcqcEvHtMz35OuPg7H+qwHXQIn4IU1MOnke27Y07VyUp8nS/xckptnCQ++4Qes8CHyny9tN4HsFhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OlO1nCwLXQ8+PonkYgc3Xvz7AjxyWk0K/eO3KFWE8I=;
 b=t4z0Dxkp/ctjPMtie1nnIPQ+q+IeRs7wQXoZYEsDUz4K5Vs83mcsWbQrg9o5MX5SrqLT2H9DSUfLyZn0+MxchPVdbcULE3zoNs6aXPAWHlJ367pwzPCe9K5oyBguUqOQQyslisfGj0eY2VCDHmQIKdF6N6DZ/cAvtV9SWIg9LtP4ZoONDsJY4D0BoHEDB+9yRwRF4xmEi6h3rRGzFS1oFJq5opDRelc2TX6VKxZ0zbYIb8OVpIGa8obU8hpAyWYejXVzFECRQNF7AgOO0qoAdMcQzvG6Fc0UwDC7rNPblGtXe++RfKvnhRquDbVpNQRfex0T9ki0fhzBHk7+Kbe1Bg==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DB9PR10MB8213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 11:25:48 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:25:48 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, "kazuhiro.hayashi.f74@mail.toshiba"
	<kazuhiro.hayashi.f74@mail.toshiba>, "kumar.dinesh.h95@mail.toshiba"
	<kumar.dinesh.h95@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH v2.1 1/1] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Topic: [isar-cip-core][PATCH v2.1 1/1] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Index: AQHdSajxKWCm/9FfiUWBkqwlQdkvnLbY84cAgAGDYgA=
Date: Tue, 22 Sep 2026 11:25:48 +0000
Message-ID: <14bb00f8c0e6d1c8a6bb543f984c57701032ae70.camel@siemens.com>
References: <20260921090931.156453-1-felix.moessbauer@siemens.com>
	 <693473c8-b994-4969-a980-3e7c2e5dfe5a@siemens.com>
In-Reply-To: <693473c8-b994-4969-a980-3e7c2e5dfe5a@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DB9PR10MB8213:EE_
x-ms-office365-filtering-correlation-id: 8814d6d9-dd9f-4dd3-421d-08df189c406d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|38070700021|10067099003|3023799007|6133799003|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 XEdKTqIcMK751b1Oc/lTQDtsdAaNmJPOisIwaJiX7tgrXoxLXVvS2nnFwXMPTr9vszC2XK3wz+G3IOAFIuXV7Lm0spnDABhrswYGLiV3nEMF3YK4QT9oMBSXFecZnvwv/P/cMVV42OtTiIdk8JC+mHErZ8jnZm3nopwkZro1zd1u4oQWg7N/nd+C5WeT0Kt65jnWeEyPh+Wva3warSLPLLCkOV28jpUEb+lNhGcUh/RMz7A6qMSbIuTXG7XS5oRr9yF/O8Cds37GpDvcgemZV5f5pnxelpYJ9G0QzW+tLfsOaErn8QFC5NioqCjkZyj8BVPDYNl+ePvcgBQ7JhL8I5GAggHEMh/nYAZ6tirwr3e6uMlYtV7ZyBXK9n0xBS0QHQ72mKMq1IoK6tXphFjXZAJwuzcmFZPBsQhsvdQLBSUa6OZT1lHqX7gqhTnqjZAIeW8Ek+Wm1va7Y0lH4299r9dYrVnEmnvl9Y16YfOvNGYSyPeuEKcfKRn/Fud8jo1z6raZXjBfvoqqMOORf/CaXIYR+H559A2Noia5E8/UOJbBDC3c+7jymYmjjwIgl4zhG12O0lsPf4W8hxxVizKviW9mde66NOMLaAY13t3zfYaFv1yO2zc8i8pF5EY1nqYdQnuM31Sz9hK9cHnRCfF/TgHp4i0B+IXFbtLrtBcdX/z9SBmaBLyBNhh8hwMIFF+GfnZWIsB2eB1OLkRIiHc3phnkFT8VHGfIpSGSFwW3dlY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003)(3023799007)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NEQrdUk5M0dWWU9iQzFmeWM2d0ZrZmZ5YzBqcFZ3SXJFb0RUT3hDdXFzTytE?=
 =?utf-8?B?YVRMRFBnd3pCdFpySFQzNnoyOUYvUmRPUlFUTE1rOUpqY0hscnhHL200SnE3?=
 =?utf-8?B?dmcxNFVxbzF0SndCR1RNdDRub0pOUVM3MExMSXgyT1ZFdjFlK1gwSmFDczQ0?=
 =?utf-8?B?dzFaanhteUp0YXRuM2EvSlRVNmljeFZHUG5rQkZzalQraktBUXNVWTJZSzRF?=
 =?utf-8?B?R1c5dnRDOWwvVkhEUmdQMU5yM3NkVUgwSU9UYW1FN2hDYVFiYlFtbXBWVlBl?=
 =?utf-8?B?RlNsYjNCUXhDQW01cWhudnJLazRxeCsxak52UXdpWFJZdHkzeWhGOWR4S3p4?=
 =?utf-8?B?TFIxeHpqYTdYN0d6Q3RwMk1TS0RpVUQrcEp1OXdTbFlYVlBQaVh1aU56WDhY?=
 =?utf-8?B?ZGd1YkZzWXQ0M3h0cUpUdFl1VG91NUpKOWU3SEp5NWI0QUhLTUNiYlZmMUpK?=
 =?utf-8?B?SE9VVjV3dUNML2hPNWRqM21ORHBPZTZoRHA5WTNzVDZIR251cFFsQ0Yra0Nn?=
 =?utf-8?B?dUZnSndoODRLVDhkUXgrS1drUTQxOGJwMEVaOFN6aWx2UzEwM1I5YVBuVWNv?=
 =?utf-8?B?ekZYUkJac0lEY3h4UDRlQWhMRmlKdE5QdHNvNnJaTG1iR09ZTWJ3eFZYUDJs?=
 =?utf-8?B?dGFscXFWVkl0d1d2NDVodlE3L3VNY2h1NS9TMWRxMGVsa1piZCszNU1SMm9E?=
 =?utf-8?B?UGJFWThrNUdkeEM3Q1RrNTE2U1IvZVppRHFpbWlIUHYvMWF6cStuUWpzT2FJ?=
 =?utf-8?B?OEtWZXROc21oeS9oUTZKMERnTDM1NVE2RDRpS1hnRTJvU3lFRkxwYzcxcjBr?=
 =?utf-8?B?cW1NbUVGbVN0dUFGUXlvdTdQekI2OEZhK0ozZWY4b0N0NDhXOUhtUC85ckpY?=
 =?utf-8?B?L2RMai9xTmhWdXMzTUZVaU9RNHBRd0hNN2EySlRQNjJCSkRUM1I0TEptL1dO?=
 =?utf-8?B?eE9rdWFKN2lNSzJoZm8wUkhrZURGWjQxMUozK0hYVVlwMnEzTFFHQjVCdFhk?=
 =?utf-8?B?VTl3eEhyWFhOMUxkWkUrUE1GWWRBd1JvK2ZoWlc3R0ZKWGErVytTV0ZsTkdD?=
 =?utf-8?B?OVVWTzE4WmRpMjArLzZFVW9Hc09XVkJXVjcvQ3ZrQk85ZnN1dzlyNlR4Um1S?=
 =?utf-8?B?UGhDRW4zeG5QRVJOTW40ZGRveGVUMDZhWW44M0lUS2tRQmtNRkdGZEVkc25K?=
 =?utf-8?B?WmtWTUlhc1h0MTRMdlo2citoZHF2K3NmYlVIK1YybDZaQklUTi9tQ29jSnZm?=
 =?utf-8?B?N2szczZvbXRhcDNjTGR1SGFxL21TYzFSbzRuQTc1ZytkVFVzWXk3TjFXWllU?=
 =?utf-8?B?bzVZTTc4RGpSclF1UmdYM2dXRGNZYXFYaDJpT3pIVkxHQ1ZTSFBBVmRNWGJp?=
 =?utf-8?B?V2M4ZUJ2TXl2cndkeWpkckhVYS9YdDlGS2tNMFdsdlR2dStlWXo3cWFDQ29H?=
 =?utf-8?B?M29XdkdVdTdqc2VyYVhYU3dwT3ZJN3kyYlJpVUhZTjVXd3lJZFNNZDROTGhN?=
 =?utf-8?B?Z2xVZTFPbS90QlV4Y09DWGJ3Mkh1eS9LcDUvcmtOUENieGh1QUNySGR2cnRr?=
 =?utf-8?B?WHpqM3hnVVl0dlcvUnVQWldxaXFNS0VTWnEwajQreTJuczViNjFxT3p6Mmtx?=
 =?utf-8?B?eU5ScFRBOEVZZitPWmI5Sml6anFFMExnbzYzUjI5ejNSdWd5WmQxOE5NeFp1?=
 =?utf-8?B?RXdGNDRMejV5cG91WVVXWjg2cGJScEVmVkwxTUtDN1pwZ0F4MitSUHc1Q1Fk?=
 =?utf-8?B?Z3JBZ1ovY0E1Y2lkaG92bjBGaDhweHZlcDFtTzBHa2VBc0ZKMTE1M3BibHVs?=
 =?utf-8?B?ZEt2eU1ZZkNCNWZ2d3l4WHJXa2JTYjdWUlg5Y1pqYnNGYWFIUXFxMEVzdTJD?=
 =?utf-8?B?MFh6WS9ZVGlJbkFFL3l4TFlHVkhEN0dtdWZrUElHamwxOXNCSHlPS1EzTnpq?=
 =?utf-8?B?ZkFjOXRsTDE4bTdaaGwzUUNGU204WmF0bElEREZ5aGNhaFIyRTdFM0lRa2VT?=
 =?utf-8?B?aXBxd0dnTzUrQ1psa3VwSW5vbzQ2UU00dmNuM0Rmb0NKQjA0a0NnZ0RsbXFI?=
 =?utf-8?B?QnRSTUhZcFdjdDlqN0kyWUtkaS9hVFVUL2dJczFxZUlLeEtjWGpjbFRIZFkr?=
 =?utf-8?B?QlhNVUVpQjJpd0w0Zi83Qys5a3I2QXIzWGVGN0trV1V0VXlySXhPTU4wb3BR?=
 =?utf-8?B?UEFhRHNLT1BVbFRXekdBWWJzRmlybzJMdFkvdEtZeEJzMXRwYTB3WExmaGQx?=
 =?utf-8?B?Q2tMUVlWRGN5OTVDS0E1T01RYmRlZkJNUGtLR1dCanlFSStjZkJrNVdPV2FT?=
 =?utf-8?B?bTBLUWhLc1dvanp3akVTRTNrcU01amlOZ2ZnK01kaHI5aitmaCthZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FF2660F2208B84180858682F2B1B6FE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8814d6d9-dd9f-4dd3-421d-08df189c406d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 11:25:48.4512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K32T7qpK3A2SijFsf3r0QdWdbsZbLs74mdlTwTJ65rp0ddal0dquf2cvGA4Wyhp262r5rhWvU2HLLEpF2DdSI1j0JPyn6KbxoemyAA82pbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 11:25:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24262

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDE0OjE5ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDIxLjA5LjI2IDExOjA5LCBGZWxpeCBNb2Vzc2JhdWVyIHdyb3RlOgo+ID4gRnJvbTogU2hpdmFu
YW5kIEt1bmlqYWRhciA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPgo+ID4g
Cj4gPiBDbG9zZXMgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXIt
Y2lwLWNvcmUvLS93b3JrX2l0ZW1zLzE2Mgo+ID4gCj4gPiBbRmVsaXg6IGxldCBkY2ggdGltZXN0
YW1wIGRlcGVuZCBvbiBTREUsIHBpbiB0aW1lem9uZSB0byBVVEMgd2hlbgo+ID4gc2lnbmluZywg
cGFzcyB0aW1lc3RhbXAgaW4gY29ycmVjdCBmb3JtYXQgdG8gc2lnbi1lZmktc2lnLWxpc3QsIHBy
aW50Cj4gPiBiYm5vdGUgcmVnYXJkaW5nIGNob3NlbiB0aW1lc3RhbXAgdmFsdWVdCj4gPiAKPiA+
IFNpZ25lZC1vZmYtYnk6IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5pamFkYXJA
dG9zaGliYS10c2lwLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZl
bGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+Cj4gPiAtLS0KPiA+ICAuLi4vc2VjdXJlLWJvb3Qt
ZWZpLWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYiB8IDkgKysrKysrKystCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2lu
Z2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiIGIvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9v
dC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4gPiBpbmRleCAyNjNm
Nzk0Li5iMTRkNmNjIDEwMDY0NAo+ID4gLS0tIGEvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9v
dC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4gPiArKysgYi9yZWNp
cGVzLWRldnRvb2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0
c18wLjEuYmIKPiA+IEBAIC0yMCw5ICsyMCwxNiBAQCBERUJJQU5fUFJPVklERVMgPSAic2VjdXJl
LWJvb3QtZWZpLWNlcnRzIgo+ID4gIERFUEVORFMgPSAic2VjdXJlLWJvb3Qtc2VjcmV0cyIKPiA+
ICBERUJJQU5fQlVJTERfREVQRU5EUyAuPSAiLCBzZWN1cmUtYm9vdC1zZWNyZXRzLCBlZml0b29s
cyIKPiA+ICAKPiA+ICsjIFdlIG5lZWQgdXAtdG8tZGF0ZSB0aW1lc3RhbXBzIGZvciB0aGUgY3J5
cHRvZ3JhcGhpYyBvcGVyYXRpb25zCj4gPiArIyBidXQgd2UgbXVzdCByZWZsZWN0IHRoZSBjaG9z
ZW4gdGltZXN0YW1wIGluIHRoZSBEZWJpYW4gY2hhbmdlbG9nCj4gPiArREVCSUFOX0NIQU5HRUxP
R19USU1FU1RBTVAgPz0gIiR7U09VUkNFX0RBVEVfRVBPQ0h9Igo+ID4gKyMgc2lnbi1lZmktc2ln
LWxpc3QgZXhwZWN0cyAiWVlZWS1NTS1ERCBoaDptbTpzcyIgYW5kIGludGVycHJldHMgaXQgaW4g
bG9jYWwgdGltZQo+ID4gK1NFQ1VSRV9CT09UX1RJTUVTVEFNUCA9ICIke0B0aW1lLnN0cmZ0aW1l
KCclWS0lbS0lZCAlSDolTTolUycsIHRpbWUuZ210aW1lKGludChkLmdldFZhcignREVCSUFOX0NI
QU5HRUxPR19USU1FU1RBTVAnKSkpKX0iCj4gPiArCj4gPiAgRFBLR19BUkNIID0gImFsbCIKPiA+
ICAKPiA+ICBkb19wcmVwYXJlX2J1aWxkKCkgewo+ID4gKyAgICBiYm5vdGUgIlVzZSB0aW1lc3Rh
bXAgJHtTRUNVUkVfQk9PVF9USU1FU1RBTVB9IFVUQyBmb3Igc2lnbmluZyBFRkkgY2VydGlmaWNh
dGVzIgo+ID4gICAgICBkZWJfZGViaWFuaXplCj4gPiAgCj4gPiAgICAgIGNhdCA8PEVPRiA+ICR7
U30vZGViaWFuLyR7QlBOfS5pbnN0YWxsCj4gPiBAQCAtMzUsNyArNDIsNyBAQCBFT0YKPiA+ICAK
PiA+ICBvdmVycmlkZV9kaF9hdXRvX2J1aWxkOgo+ID4gIAljZXJ0LXRvLWVmaS1zaWctbGlzdCAv
dXNyL3NoYXJlL3NlY3VyZS1ib290LXNlY3JldHMvc2VjdXJlLWJvb3QucGVtIFBLLmVzbAo+ID4g
LQlzaWduLWVmaS1zaWctbGlzdCAtayAvdXNyL3NoYXJlL3NlY3VyZS1ib290LXNlY3JldHMvc2Vj
dXJlLWJvb3Qua2V5IFwKPiA+ICsJVFo9VVRDIHNpZ24tZWZpLXNpZy1saXN0IC10ICcke1NFQ1VS
RV9CT09UX1RJTUVTVEFNUH0nIC1rIC91c3Ivc2hhcmUvc2VjdXJlLWJvb3Qtc2VjcmV0cy9zZWN1
cmUtYm9vdC5rZXkgXAo+ID4gIAkgICAgLWMgL3Vzci9zaGFyZS9zZWN1cmUtYm9vdC1zZWNyZXRz
L3NlY3VyZS1ib290LnBlbSBQSyBQSy5lc2wgUEsuYXV0aAo+ID4gIAljcCBQSy5hdXRoIEtFSy5h
dXRoCj4gPiAgCWNwIFBLLmF1dGggZGIuYXV0aAo+IAo+IE1ha2VzIHNlbnNlIG5vdyBhcyBpdCBy
ZWZsZWN0cyB0aGUgZnJlc2huZXNzIG9mIHRoZSBhcnRpZmFjdHMgdGhhdCBhcmUKPiBzaWduZWQg
KGlmIFNERSBpcyBkZXJpdmVkIGZyb20gdGhlIGdpdCByZXBvIGUuZy4pLgo+IAo+IEl0J3MgYWxz
byBpbiBsaW5lIHdpdGgKPiByZWNpcGVzLWRldnRvb2xzL2ViZy1zZWN1cmUtYm9vdC1zaWduZXIv
ZmlsZXMvc2lnbl9zZWN1cmVfaW1hZ2Uuc2gsIGJ1dAo+IHJlY2lwZXMtZGV2dG9vbHMvZWJnLXNl
Y3VyZS1ib290LXNpZ25lci9lYmctc2VjdXJlLWJvb3Qtc2lnbmVyXzAuMi5iYgo+IG1heSBzdGls
bCBuZWVkIHRoYXQgREVCSUFOX0NIQU5HRUxPR19USU1FU1RBTVAgdHdlYWtpbmcsIHJpZ2h0PwoK
R29vZCBjYXRjaC4gV2hpbGUgdGhlIGdlbmVyYXRlZCBzaWduYXR1cmVzIHRoZXJlIGFsc28gb2Jl
eSB0aGUgU0RFLCB0aGUKY2hhbmdlbG9nIGRvZXMgbm90LiBJJ2xsIGFkZCBhIHBhdGNoIHRvIHBv
cnQgdGhlbSBvdmVyIHRvIHRoZSBuZXcKcGF0dGVybi4KCkZlbGl4Cgo+IAo+IFRoYW5rcywgYXBw
bGllZC4KPiAKPiBKYW4KPiAKPiAtLSAKPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5v
bG9naWVzCj4gTGludXggRXhwZXJ0IENlbnRlcgo=

