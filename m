Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE026C982DA
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 11:21:57 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8762.1789730492141246181
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 04:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kLUEz+Wn;
 spf=pass (domain: siemens.com, ip: 40.107.162.5, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zW+0UyuFxQjk87P3aatVo/ZoH2DagcX96dj+8CqGLGOZEGU5fFK/qDFVjYbqU1c6PmcmPLiT3thYZOJJpF9HchiYRAXv+SDjeAW/eo6Ko4JtaRG22fiBvna03h0Lk/IQkc/7TueMl2jTfWcEhdvAJLWvS1aUi9tjRRI3ra0aqYdqMUkgVo1QCwEmxpuEgtJytd+5D+4xyXpEi1llptgGQxYLDEVXga4uEv5t3GIWz8bU1a/EWKp2Sj6SyglfmrNUdXACBCNnjlGT2vbs4OL4FiZeMfTi8PDUsNMcasCnB0S33ML6G/dhskQgw52byVa9X1pBHWeFOTZGhL23LlDbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65Df725b8ntAgSRAHH8HD+Ls+RiNu2kziaRMu3exivQ=;
 b=gLLYhN1IhSafetJgmIq7Jg8I/tApoS5cQfD0G4SZG+5iB5gIKJ/BIZfMkWqEYT8DLMSDzg4NMv0UNESTPNmEHSIBlQt96nnZWWQuOiPJyUXJZm6/5P+LcA6XjdDtNckh/xuFWy1M10oizEPK1bp+BnZswCK2PsDV/8QQgH7dUFHTvnoD0XjQPbGMxsG6dxQnbZP0d9paDv/+2rmF3YqDwsgswN7lNEWD/4K8BxfSXwj9afWk4WoSNUCzbE7cu0N4plnuw8Qay2SjHzthR+oNHTj1v86DDBa2Mkmo6EnW0W6P/lvQOy7E41PBd2W+qbcLaYCdzP667SlWk5WSsCIfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65Df725b8ntAgSRAHH8HD+Ls+RiNu2kziaRMu3exivQ=;
 b=kLUEz+Wnw54XdQCMwhnI1cFeGOKBOmu+sjMDdm+rma05U9hqlXU6D5udM3Tl8T+R7IxK+EBP2BriqmhDIjXo2guc6bw2HEDhGckb/Z48sx+UI5kiKop1zSNdOhUzDlcJ3pKIYXz/Wbb9TYrece4x4x8F9TrKKbCZ8uG9fdoxCvlUN6eraR4inYmbmw17t7iDTrnl775pnXtk4CkYiIkiXmS7rQoOZgWCCZ+0Y86kESVAHFpLf/SceKYuOGKtzddwKvS0Ihwks2T4fwGLX2x1BkGgshAzdD/epsGyW+ifu4haTQ6ydoHdCV5Ghz5feCoMGIBIt2nFjg+EpkJULYFpZw==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by GVXPR10MB9405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:21:27 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0406.014; Fri, 18 Sep 2026
 11:21:27 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Kunijadar Shivanand
	<Shivanand.Kunijadar@toshiba-tsip.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>,
	"kumar.dinesh.h95@mail.toshiba" <kumar.dinesh.h95@mail.toshiba>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Index: AQHdR0zKDblqapHsykqKMBs5AKB3brbUKW+AgAAB+YCAAAWuAA==
Date: Fri, 18 Sep 2026 11:21:27 +0000
Message-ID: <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
	 <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
	 <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
In-Reply-To: <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|GVXPR10MB9405:EE_
x-ms-office365-filtering-correlation-id: 7aa2cd75-b41c-408d-973e-08df1576fb11
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|55112099003|38070700021|18002099003|22082099003|6133799003|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 
 J1LeVvcA5iy0PntugL+eLXCeU6H+1vPK4V9F2rdArDpq6StotkbivWNy5tNodhkTsqgDJ/PvRDZnQHfvPVf19ARgZVAnMssqqLtyRKevMEgSOa7atzeQ1fkdJe6eya6sxfw2MjXoQY0yTrAf5GfEWvOKGxalPd0kCzNRsNLPxHTTed+yuQ2CRkqCDRJXSmtgB2ZLc4NZkBY37epe1gu2mh3Xjlxu8qghsbFyjXvzc4cCi598ruqcFHW+RZUzrr1uhLs/ljJWFRwjp8x8l3IwBxDxTz0atxFWwXDBicIrZLXWOE3SBXJCS/O8W4IQbbBq+DnMZTm9T3IU+Xy6D5P/TL5rfoDZbp/g57mXfzvveOSTmvDfQkWIXSGzoVENuRv32/vBP5fuKL/5lTVZ5mSbI352ToSLxar1ZVWKhqCdL1MUHS725KyuyHTic9oKBT72gaY0U4xH5y/MYYl5lkjlP4KHkgfFXcfUKzeA7Ma+2fDjUZB19NE3X0IuMB17KNQIKzm/DiH38S+Cmg2EOAhnnnJqRn2SDnw20nh/P53KmxTwNcRuIy8qMZFP8clOGBmDVY0mI/MQcsOeup9lExXs8wCGb/rB7aHKHAWHf9qdXNdx+AyRkt4r3D68kdp6ERqoQ4BENY4O9uWd5Bs+NrSlQpn6+c9i+Yf6yeqf61W8MUIvGolcVgGM0p+ZycykOtNvokzjGX+um+REBLm/nLRuLqYKUhqvt7FBLjFXoXJd88w=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(55112099003)(38070700021)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y3lsNWFydmk5YVVJQjV4MzVWeEpiV2NKdEJtK0UxWlVveWVFdnhXZ0ZZUXV2?=
 =?utf-8?B?SkNFSzg1c2V3OUVXa2hjVUhaaTdzQ1ZDY01Qb2EwNTFncTFVNlVwMlh6VnZS?=
 =?utf-8?B?aitnK1RKTE5uUVpOM3hXSlo1aW82Z25tSmNQLzRtTHJ3SmZreitEMzdlTnpo?=
 =?utf-8?B?czFvMnQxUkZYd2RHQTVmcEtRNVQyYUhiRHpIWUx0b09PbVg1czcydGtaaE96?=
 =?utf-8?B?cEFWSXl0RG9KT3dqcmEwdkJFQlpTbnlIektNMnBnQXZhSS9OcUVlY0JCY1VO?=
 =?utf-8?B?TnNUajZHa1Rza0QzQ0ZmRjUwQ3dvS1hxaytST2w4UitQSnhHQW51ampnQkEw?=
 =?utf-8?B?MVNoakFFWmpnZnU1SC92dHkyRkdORDI4ZUlGTDR4UW53VVdiVWxjNFpRbk1x?=
 =?utf-8?B?amRmRUpOZFNUWXdRYmZlSTgvbElTNTFZTG5tbnR1K3FpWC8vK3FEZzE3RUNE?=
 =?utf-8?B?RUJjL1NHMnJZN2hqbVBJTzlzZ0wyUmh2bGlUMWUzK3R4WExpcEFOb2xTNnRn?=
 =?utf-8?B?cXpuRmpJaTdEQnFZejdHMUdqYTQ3a2lRWGFzUnpGbVZuS3N0Vm9LU0JsRThh?=
 =?utf-8?B?Vmk0TEdiTStUMWFyWEtDVE5RL0tJTzhsMDZWaG9tdmZyc0JHb0tUeDAvRUlL?=
 =?utf-8?B?YktwY2J1Y24vQWNwQzZoZ1hBQkJnWFh1SDZPTmo4QlAxbGR5ZnIveGlncEQ2?=
 =?utf-8?B?KzVPdmJrdGN0RTRvU1YwczBxckpCMHlPVElDYnQvOWN6Y1NCVlEzUTVpZ25i?=
 =?utf-8?B?Nmk3R3dMdnBQaUwrdDBWRzFNM2lmRHRpV0dOREVMcnAzU1c2SFRkUTlIZWVK?=
 =?utf-8?B?NS9Tb1ZhV1VYL1Jucm90Vng2Mkh6dmtvemQ1MXZBbWcrN3QzVi8rQVFjUTJO?=
 =?utf-8?B?L20vWER5S3pSRnEyQ1RtcHF2bVNFam5Jc2Jwajd5VGVpbWsrYU12WlJVN2NP?=
 =?utf-8?B?WVFNRFQzUlJYUkhsZWY0YmpJT1FYQjRuRHkyVTcrYXdTOGQwc2JFZldYMVdI?=
 =?utf-8?B?cjRsQm9ac1hMN0NORU5DZjFwUi8xTEFYUGhVY3ByTnBOeVVDL0xhV2lsQWlJ?=
 =?utf-8?B?NTRST3Y2aXN5TGcvT1VSUUFsVDBKRVBnN0l6RE1KTk96b1drcS9NalQrWXdD?=
 =?utf-8?B?WWU1dFVJd0tGZzVjSDEwb1JHQmZsazZac1hKUVpTNzN6cFl5VU4zQjRSQ3RU?=
 =?utf-8?B?Z2NxdkxOS3lVNERtWS9FYUVVRnF0QU96Z3ljUjB1UFp4dW9ocWxYY3BCeU9Y?=
 =?utf-8?B?L3MxaG1VUTRGOVdPUDNHTUpwSkcrYUN0clhrWDFSMFl5TlE1TDlteGNBcHJJ?=
 =?utf-8?B?ZitmbE5uRllkSnRrMW00SXVGTUVhOHlpU29pTjc1ckkyUGdEQ3crc21FeldD?=
 =?utf-8?B?SmEvMllmZXhDbzBQNXpadzdJSU1HVWpJbjdwR3VuLzVNdTRBbGZ1RGlHc05a?=
 =?utf-8?B?blNVd1g5NWIySHFQWk1nV2h1TWVtMW01VWtpdGJkV0lQK2N2VFlsa0FSeTFC?=
 =?utf-8?B?V3AzejNIOWdMYzFhNnpJVFZRb2I2c1REZ0dVVHBhR1RnWkxyZjdVZ08zNlJR?=
 =?utf-8?B?L3hrZ2lUK3ZhOElGKzhjdzZkT2RtSUVNMndWUEhyME1pOVVmV0xmcjFxaHZS?=
 =?utf-8?B?dklBaEJhM0kzYWhiT2tBcG91ZTJuRFVsOTFSNzJxNHNSdENyYW5yZjNzcXNV?=
 =?utf-8?B?QVpUaEdDZG8zQThCNTNYb2ViVW54bjZiMnBIaDMxbGdCS1M5SnZRUDU4Mm9J?=
 =?utf-8?B?MkJ6UVNiZE5sUjNrQlhYMThhNGswZi9JRElYVWFUQ002UjFUcnpHWXBYU0Jp?=
 =?utf-8?B?Skw5YTViSnZFenZjTEUvbHBYc3JlZ1NBdk45bFZCdWwxdFZKMEVyTHl5RGdS?=
 =?utf-8?B?aXJWMCtyM3Q2VXZTNnZwbXZGWlo3dTR0T2YvVkorM0VyTjdSNUhOWm9ROGxE?=
 =?utf-8?B?cmtMeFpKRnBCZkVRdE5JL0diSjMzWG5MeXppUWh6Z0txQWhtclJucmp0S3V1?=
 =?utf-8?B?eGdxa3kyamFtcTErYVdHQ1JQa2RIcm9KRm9Jblk3V0ZWZ0U2R21xTkhXdFRM?=
 =?utf-8?B?Tm1EUWZoQUlLQkNtcVR1andUZnJVYmlvVVBvNHBLbVlFd2kvbjBoZTZPRTh6?=
 =?utf-8?B?UUZJZ2F4MEc0dmNIRy9QVDFnMjlCMVZPSkNFUDNzdXBwYm81SHhJcGNMRjV0?=
 =?utf-8?B?K3hwVWxWVEI5aFNxUTBOVDlpRXZvdXc1WXY5UVpSZDdJY1pSOE9EVExCWHBU?=
 =?utf-8?B?Wk1HSVArTWUxNDc3cDhTL0V5UEh5SW9IbURsMDhQcGVtTHorWk03SmpLQ25E?=
 =?utf-8?B?S2lKT2Z3L1pMSmxraHJTUDcyd3Z4bTZuK0dTREJDOUg0c2Z2WTZxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD2CF8F00365384FA2BD7EF4F4999886@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa2cd75-b41c-408d-973e-08df1576fb11
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 11:21:27.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T07HLtLypSDn3ApGl5NGEtSaAJ19i6362zQUUDSnL8FMHYVjsKIL48c3O+GgyI8dj3mAkabhLfNOokSWv67BO/YZ/bfibmS3KqItiU2zapI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9405
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 11:21:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24243

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDEzOjAxICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDE4LjA5LjI2IDEyOjU0LCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQgUlBEIENFRCBPRVMtREUpIHdy
b3RlOgo+ID4gT24gRnJpLCAyMDI2LTA5LTE4IGF0IDE0OjIwICswNTMwLCBLdW5pamFkYXIgU2hp
dmFuYW5kIHdyb3RlOgo+ID4gPiBGcm9tOiBTaGl2YW5hbmQgS3VuaWphZGFyIDxTaGl2YW5hbmQu
S3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+Cj4gPiA+IAo+ID4gPiBDbG9zZXMgaHR0cHM6Ly9n
aXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS93b3JrX2l0ZW1z
LzE2Mgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hpdmFuYW5kIEt1bmlqYWRhciA8U2hp
dmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPgo+ID4gPiAtLS0KPiA+ID4gIC4uLi9z
ZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiICB8IDgg
KysrKysrKy0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWRldnRvb2xzL3NlY3VyZS1i
b290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEuYmIgYi9yZWNpcGVzLWRl
dnRvb2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEu
YmIKPiA+ID4gaW5kZXggMjYzZjc5NC4uNmE1MzU3ZCAxMDA2NDQKPiA+ID4gLS0tIGEvcmVjaXBl
cy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNf
MC4xLmJiCj4gPiA+ICsrKyBiL3JlY2lwZXMtZGV2dG9vbHMvc2VjdXJlLWJvb3QtZWZpLWNlcnRz
L3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYgo+ID4gPiBAQCAtMjQsNiArMjQsMTIgQEAg
RFBLR19BUkNIID0gImFsbCIKPiA+ID4gIAo+ID4gPiAgZG9fcHJlcGFyZV9idWlsZCgpIHsKPiA+
ID4gICAgICBkZWJfZGViaWFuaXplCj4gPiA+ICsgICAgaWYgWyAtbiAiJHtTT1VSQ0VfREFURV9F
UE9DSH0iIF07IHRoZW4KPiA+IAo+ID4gR29vZCBjYXRjaCEgVGhhbmtzIGZvciBkZWJ1Z2dpbmcg
dGhpcy4gUGxlYXNlIGp1c3QgdXNlCj4gPiBERUJJQU5fQ0hBTkdFTE9HX1RJTUVTVEFNUCBpbnN0
ZWFkIG9mIHRoZSBTREUuIFRoaXMgdmFyaWFibGUgaXMgYWx3YXlzCj4gPiBhdmFpbGFibGUgYW5k
IGFsaWducyB0aGUgdGltZXN0YW1wIG9mIFNCIHBhcnRzIHdpdGggdGhlIG9uZSBmcm9tIHRoZQo+
ID4gY2hhbmdlbG9nLgo+ID4gCj4gCj4gQW5kIHNpbXBsZXIgY29kZSAtIGV2ZW4gYmV0dGVyLgo+
IAo+IFRoYW5rcyBmb3IgZGVidWdnaW5nIG15IGJ1ZyEgOikKCldoaWxlIHRoaW5raW5nIGFib3V0
IGl0LCBJJ20gd29uZGVyaW5nIGlmIHRoZSB0aW1lc3RhbXAgYWN0dWFsbHkgaGFzCnNlY3VyaXR5
IHJlbGV2YW5jZSAoZS5nLiBmb3IgY2hlY2tpbmcgdGhlIGZyZXNobmVzcyBvZiB0aGUgREIpLiBJ
IGtub3cKdGhhdCB0aW1lc3RhbXBzIGluIGdlbmVyYWwgYXJlIHBvaW50bGVzcyBpbiB0aGlzIGNv
bnRleHQsIGJ1dCBJJ20Kd29uZGVyaW5nIHdoeSBpdCBjYW4gYmUgc2V0IGluIHRoZSBmaXJzdCBw
bGFjZS4KClRoZSBERUJJQU5fQ0hBTkdFTE9HX1RJTUVTVEFNUCB1c3VhbGx5IGlzIHNldCB0byAx
aCBhZnRlciB1bml4IGVwb2NoCihmb3IgdGVjaG5pY2FsIHJlYXNvbnMgMCBjYW5ub3QgYmUgdXNl
ZCBhcyB0aGlzIGlzICJtYWdpYyIpLgoKSWYgd2UgbmVlZCBhIHByb3BlciB0aW1lc3RhbXAgaGVy
ZSwgd2Ugc2hvdWxkIHByb3ZpZGUgYSB3YXkgdG8gc2V0IHRoZQpERUJJQU5fQ0hBTkdFTE9HX1RJ
TUVTVEFNUCBqdXN0IGZvciB0aGF0IHBhY2thZ2UgKGUuZy4gYnkgaW50cm9kdWNpbmcgYQp2YXJp
YWJsZSkuCgpCdXQgc3RpbGwsIHRoZSBjb2RlIHNob3VsZCB1c2UgREVCSUFOX0NIQU5HRUxPR19U
SU1FU1RBTVAgdG8gYWxpZ24gdGhlCmNoYW5nZWxvZyB0aW1lc3RhbXAgd2l0aCB0aGUgU0Igb25l
LgoKRmVsaXgKCj4gCj4gSmFuCj4gCj4gLS0gCj4gU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRl
Y2hub2xvZ2llcwo+IExpbnV4IEV4cGVydCBDZW50ZXIK

