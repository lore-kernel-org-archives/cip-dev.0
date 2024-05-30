Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E1C25B75
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 01:37:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.5942.1717033040685106707
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 18:37:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=sdJwFFPT;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1717033038;x=1718242638;bh=uNqmUh5H6SGs/sNsL3IfHaAsS572NNtmytRA8N+
	TKTY=;b=sdJwFFPTV4Ctijy5PXB3MZh3+J/bHj/OQKNiudcusKJeBKydcuOluwbcV1fNmwsDZtJFQ
	DR9bfXMvFDphkew+5YSSLBNnMrsjdT1G7yUn8nRdx82AaP8NbHX1wOO2ekHdY2s6GROK9rmuNjWpP
	9OttiAFzjrY+F+JPk9jhbcWbAIuaqyvfEQzQ0EE+ELqvO4RyPvo3ryLFqCZ6NKvRa/h6rqAbbBzGi
	IESAQvwHj2L0DC7AjLgsIXWiyVYCFR1iinVr8ieHdevG5XCI5T9aZujNtdDBLusRBN8XplBoG6F40
	QJpbymLLsbhtLoER9kZnHRuAmTy95iKrN4v/5rT9Iw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 44U1bHT6424127; Thu, 30 May 2024 10:37:18 +0900
X-Iguazu-Qid: 2rWhAUbYjmuBmVVE4Q
X-Iguazu-QSIG: v=2; s=0; t=1717033037; q=2rWhAUbYjmuBmVVE4Q; m=pEpQ/0nmSM4rNga0SkLGXv17Hlw9QJ4KXs1SgA9FaYM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 44U1bFJO3032207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 May 2024 10:37:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwYDf3JT31VfMmA2/Pk14bXuKIk6PSEBV/8/BOiwevl719D6xD6oEwSKxckSY2zYIJf597s27+HcZJxP7us1FtYn8fGq97SGzogEC8tETL/Zwp9lC0i8fCjtZfdvKJvJLLrvt/eYRCtIkNMiMn/UZZ314l+3uuEtv4CWF7yBcclfJ2mhs7kkVuy6T9yv1ugtTMok+DoXismrWhF2yXQFVBXXsytpyaf6l0wMEzn4S0YanzZFPlWU6utPEL7LsUA5g/mnDW1LSs5VsOmiTMd5lc+MfLPepqcmh/DNC9w6DFK6q12wkl5ry0z3KafxO/Ne3Deq9YQ3xeVOoHf+r2RGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNqmUh5H6SGs/sNsL3IfHaAsS572NNtmytRA8N+TKTY=;
 b=mzEl+xZ/chq0CvkHIIvW0Yj/R15CM/Shf+pA3t15U9jCZL2ce7e/M5/RCkx9Aq4nCeJ5MMuHAZWe68cI35Y3Lo3UoHxjc5+AgeEONau+dKDyURJO+VD47H62iYkEW0MTmSyG1dPXz8AfaF7+v/p6pPmkSvD900iG4LJQocNn4ienR6tjfPxGoSX7HncAMkd1n5m3cBH6G7ud+zdXHqo5uhaKWqHao1ESnsd/IZMGES6IThebvxigLwf+llevcijrtc5/w+uDgCWOndK/PXJ9fhUXC7/73VPRVPz4JFN5T2ewdDeB3T7PdDcmDn4ptGtkPocnhHTv3mO7+/ytjUwRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>,
        <jan.kiszka@siemens.com>
Subject: RE: CVE-2017-5715 on simatic-ipc227e -- was Re: [cip-dev] gitlab
 -stable-rc: mirroring not working?
Thread-Topic: CVE-2017-5715 on simatic-ipc227e -- was Re: [cip-dev] gitlab
 -stable-rc: mirroring not working?
Thread-Index: AQHapuz650TSBMJ53Eubbc3kHCYHGLGmW+2AgABu+QCACEoBIA==
Date: Thu, 30 May 2024 01:37:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
In-Reply-To: <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSRPR01MB11457:EE_
x-ms-office365-filtering-correlation-id: 3bd06b6a-c3d0-4573-ad12-08dc8049015c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NzNQeWZ6ZmNheUVFV295OWEwOWFsLzJybU8rZk84bWdiWUhjZTFqODMxYTJi?=
 =?utf-8?B?cUJBRENtVWt0WkExZHFDNDNxQkhHaTBzV2xGUkVjMWFhUHFkeVYvaGRWcURP?=
 =?utf-8?B?eHkxdHluWDFvVm93R00ySG14cVdRSmVTNHdCajVMSk1jUEpiN0hWM0FuaDBV?=
 =?utf-8?B?VmlnaWFKTDJvb3NwbGc1emx6d0NmZjEyRm9kbVYzY0piTWd6cndmYWxXcTZp?=
 =?utf-8?B?KzVvQjRBaDUzMzJ6NVBxSWFleFhLUkFvc2pWWHdOQi92bmtreGcwVHZMcDJk?=
 =?utf-8?B?dWQ4UGwxN01UdUhJVG5uQkdqNFJ3aVZLWjh6S1BscHZ4QmNrL21YQUtOMElu?=
 =?utf-8?B?YmlsV0hqWE1EVHdmYWJQSGQyN280K1Fma1RqcUsvcHpSM0svOWRVdHZBT2Za?=
 =?utf-8?B?NUFqZ2gvZlZ5R005WVRxRy9TYlBGWDhRZGdxa1RaWEZZRzNlY0hFclNRd25U?=
 =?utf-8?B?dW41bFBtUW56YlBadjlhenJtb3NDSEhidWQ1dVQ4RFJSZXR6RU5XOWZtVGtx?=
 =?utf-8?B?UE5aVGhjMVhZWjYwVTBDb3NPSXQrZHRaQnN2WlVIZU1NNGpGaHBUNFpzVzEr?=
 =?utf-8?B?eDBqVGxlckhzeEpVVTZ6NjZNMEpVY2lraFhyWnErTENBY0xka1JFVEVSYlR5?=
 =?utf-8?B?c3FXLzJDeExWV2h5TFB1YUtqWTVaUGdBTGt0WnQ1THBWcEhtVnI2SnF4ZW5S?=
 =?utf-8?B?NDA1cjZaclV4VzhqcTNPd0JoclV4eFB2Tk5LN2ttMmRmT2lERkV4SnJPbks5?=
 =?utf-8?B?ZzErdk1nUWVQQ2JaSjV4M09jc3JvZlRKSWNxTkJ0ekM0R2w0M0Y4bXBOOFZU?=
 =?utf-8?B?eS9HVVpIcy9wMGF0dmQ1aVZvdExDRFZZK2loY1F5TFNUMHV5OVRxWnJ3cXZl?=
 =?utf-8?B?a0ZBbzVSSnFuMlUxVjdZUzJtcEtYdUNGU2dSRmF5aGhQR21oUnpmWWEyd1li?=
 =?utf-8?B?Y1ArWVNEMlFISnoxZVZOaFI1NE41MXlOb3J5WlUrdkJOSjFJa0I5aUplaEVG?=
 =?utf-8?B?RityWHFYbUxLVkRsM3krV1Bpa01odDNjeFhvVWxGZkg4anB4Zy9UeFF0MjZh?=
 =?utf-8?B?Z1cxZHB0MnhVamwzOWFEKzJXa3NsNENsYmlXTittbG1weURmZUxmUzBYaE90?=
 =?utf-8?B?R25UOWxpQzdBa2tvN3pVYmdrMVhiSUpNaHRBNkFwZ1dnbmszL3hTWWxDaUVh?=
 =?utf-8?B?OHpkVUFvTmJtMlh4dE5iY2daY29Da1VndmI5LzJORlpHTWdiT09kQ1VQRlpv?=
 =?utf-8?B?aTEzRkw4L1MyRzdHbzh1VGlRem5Ca0loUTJWMzZIaG9sejNZL042aVRMZm0y?=
 =?utf-8?B?N0xMSUt3VTJBQnUxOVdQZ3RZalBaUGFWVW42VE04VkFhSG45S3EzQnlablVK?=
 =?utf-8?B?MWJwam9RNWNuYStyaWdhbkM3eGNVSXBKK1dwOFFZL3pzMGdwMHEyZW53K3dO?=
 =?utf-8?B?TnIvMzlVMTBwRXhRM1NqQTFPZXFJeGIzbStOand4Q1UrRGtiQlZGUkI2c3dp?=
 =?utf-8?B?OTVtZ01ZWktad0w5V0k3UUFPQlgwemFpbW93ZWt4WW15YUZaSURKcm1YYlRN?=
 =?utf-8?B?enNFdG5WSFpuQklVMTBZS1N5T1AxNDJyb05FT3NIYmFBRHVkL0R5Q3pEVXhE?=
 =?utf-8?B?dFZ1QnVZRFF3ZkNFMUxXT245RUllTXdJWnFCVEwyNHBHb3krRjJVVWc4SWVB?=
 =?utf-8?B?VXFzZm1hdkQ4QThxZHUwdFg5d0wvVVZJbFZ6bWRmbkpTY0RsZ1FBZmpITWw3?=
 =?utf-8?Q?lIGJBCYRHVBT2/hWls=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cnNicmp1M3JubDVBS3BFSW1iSG9zcytoRWVadmtaWW1QT3kwcG90TFNTeFlO?=
 =?utf-8?B?ZGhIbnJMWE9OMjRJakxoZ0tvMVdCS050WlI0NmlEbk9kS29vYlhxMDJEUGtW?=
 =?utf-8?B?bE56c3pvNjV1OTFnS0xYZnFjTXJEZkx1OWM4bVZtRjRmYkxESWNsMzQxbjN1?=
 =?utf-8?B?YVNBMWdQZmsxWXU3QmN2NHRDWHdDdk9VbWxMaSt4SVZ4OWc5blNRbzhGaldD?=
 =?utf-8?B?V012NjRpMElVSUJXRDVjWkZmaGx3UlFEZlc4VnZYMUgxVGc5UUo1d28rVjlr?=
 =?utf-8?B?UFNlc3NMZW1XNjNSdHlMSHFZZUc1NTZrOTRZTDJBckYxcWdBVGVzMVhuUUNW?=
 =?utf-8?B?KzRRMVFRdmZSaEwyMWJDR0JNNFM0WTdYVlR3eVljV05obEVQQkwrbnBld3Vx?=
 =?utf-8?B?M1F5V2tDNXVSVFRrY2Q3WHI4a29UWGc5WE1oN1QwcWJhMXlGb1NMbUpNQ3BU?=
 =?utf-8?B?RU9iSktXZDUxTmdnUjYyOTFLbHBhS3pEMUg5c1lxS1I5Mm5QYVBZaVczalhw?=
 =?utf-8?B?MEV3TGlJRk1saXE1YVVjUTRFcjZYMWJlWVhCM1BRenFlUXdLQ0RYYjlUTjhD?=
 =?utf-8?B?NDRQVjlIRkQ4YndiaHBVVmVzMm5ab3MxTSswM3c2RXVzVldTMnFia05wZ0hi?=
 =?utf-8?B?VTg3Z0hqSkI1YkE1VVJjaFRienM4RjQxUzFLTytIWlVWVnA4c29IeHZhRi9G?=
 =?utf-8?B?aFFIbjV3NDVMNFpZNmh6SGEzZjAwKzd2aE9XbjRkM3NLNEZaR05nU1grNDU0?=
 =?utf-8?B?VXc5YXJyNDZTNFZzMWs3ekJTd2I0aU14VGw5RmhlNGZQQ1NNQmJDSVdxYnRD?=
 =?utf-8?B?TCtXS2dYNGlqTVdOMDY1ME4rY3lZZDBKOXpWaXJYRTBiY2l5c0owaUpvZnQz?=
 =?utf-8?B?UFRLQWRDUTFUcG8xdVNUVnBFRXpXNWl0UXY5cnpJMklQbGpOOFh1TTlCM0FJ?=
 =?utf-8?B?akRGNHpPOHJwa0toNnBMbDVEMXg3V0xWL0MyNVZkYnpzOHUrbGtjeGNYYmxt?=
 =?utf-8?B?TzhWSmNKbmNXRWFVbk01L0VBTHltWXBUM2dxSkJITzJsR2JPa0Y3WmcyS3Fp?=
 =?utf-8?B?VTJsbHROVURyYmtONUd1bjVCamFZQmY0TER4ZEhzNG1HL1Z5b25RS3BUcmlT?=
 =?utf-8?B?U1k1QUNZcmcvQUFTNjUxNXYrdEcyMGxqN1lzRTgvdXhtK1JJQ0ZTS1JVLytQ?=
 =?utf-8?B?YktaVGpsdDRBSlliNlcrMTNHSkU3eWQ1UWQ2MGc4S3pUU002MHZRUW1MY25m?=
 =?utf-8?B?dlZRcHlsaW1lMkVzU3RDRmxlNTZtRCtIaGh0ditBS25UM2MyUlkwejhaWGtk?=
 =?utf-8?B?dG5VNVpOcmdleTY1OTUwbklNUmhsallnRDBoRGVJU21Vd0dIUHJsOFR1eXE3?=
 =?utf-8?B?OE0yNGxhMk05WHZLMUFGS3o4OXN3RUk5R09DR0lIWVNqZmE0S1ZaN2lybDl2?=
 =?utf-8?B?Sm9wd1dBVEcxZlZBZlJGZ2hjdDR4Tkd4amJvRVErVzVMcVppdFo1eGJ2TmQy?=
 =?utf-8?B?cEV6dEJqTXJLZkNzRkx1UXRoUHp2UFpDeDBvZ0xYdklwU0xOQVhObU1NSXFj?=
 =?utf-8?B?STRQd0ZwVFE2YWttWTdBUDhYdm5ETXUvVVNpUS9kRTREdi92UVRYME1rbjZH?=
 =?utf-8?B?azRlNjRZOGliSFJicm5xU2ZvVktzSlhXZjNyZGdETWp4Qkc2Ty83b3c0TjFk?=
 =?utf-8?B?TkgxcUYyeldGdFRmL0luMjRubXFUSHlYam5GSmQ3OXBzY3d2RTY1aG9aU1N4?=
 =?utf-8?B?NVFZaHNVRGo5cTBDYnNNalVlby9QTmhlMU5VVTBRMTBYQjFEZTZRU1M3dVBy?=
 =?utf-8?B?ZVVvZ2pCeG1DY05jb0pQSGNKL3VhMXI2Z2Q4TTAxRjBSZU5lUzVVNmlGdDhS?=
 =?utf-8?B?amFNVVpFWHVwdFJaSS9EaUNwb0pvUndwenM3S0daTVIrVjJySlZYV0NpK1BO?=
 =?utf-8?B?cXlGdXl4VUdhcmxvbWhVTjVTTUN0TEZKZmRJMzJRTVBIcnByR2VCajF0TnJD?=
 =?utf-8?B?ZWpvMkx6QXdCaFFBQTE0aEd6UVliTGhWM1M2NDhaT1ROSk5OaGFKTHZ1bGpq?=
 =?utf-8?B?ZDJ3QjVZd1pzSlpscVluaDN4bjNRUEtsOTR4RFE0QVlHWjJEdUl6RC91cXNS?=
 =?utf-8?B?YWxVeWNTTFdUaDBIakx3Z0s5d0p0RlZPNUhvbGloRVNUcmNCSEdsekJTbnJw?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd06b6a-c3d0-4573-ad12-08dc8049015c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 01:37:02.3038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGQWasgBbmW2IQzuf0Ydqn9MlaoDlB4xZeiB0XVIoYNXSOqFGAyGc1hMyHkXQc12QFo952Z4Cd62r9qRBvHreEV4F86thOo7Ppo/Ts7qX8wB+4pAkjFafNTAKyzM85Gm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11457
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 May 2024 01:37:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16069

SGksDQoNCj4gPiBQZXJoYXBzIHRoaXMgaXNuJ3QgYSBtYXNzaXZlIGlzc3VlLCBidXQgSSB0aG91
Z2h0IEkgc2hvdWxkIHJlcG9ydCBpdCBhbnl3YXkuDQo+ID4gRm9yIG5vdyBJIHdvbid0IG1hcmsg
dGhpcyBhcyBhICJrbm93biBpc3N1ZSIuDQo+IA0KPiBIbW0uIFRoYXQncyBTcGVjdHJlIHYyLiBD
YW4geW91IGdldA0KPiANCj4gY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Z1bG5lcmFiaWxp
dGllcy9zcGVjdHJlX3YyDQoNClBsZWFzZSBzZWUgaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3Jn
L3NjaGVkdWxlci9qb2IvMTE0MDQwMi9kZWZpbml0aW9uI2RlZmxpbmU3MSAuDQoNCj4gDQo+IGZy
b20gYm90aCB3b3JraW5nIGFuZCBmYWlsaW5nIHZlcnNpb25zPyBBcmUgd2UgdXNpbmcgbGF0ZXN0
IHZlcnNpb24gb2YNCj4gc3BlY3RyZS1tZWx0ZG93biBjaGVja2VyPw0KDQpQcm9iYWJseSAwLjQ1
Lg0KDQpJIHdpbGwgY2hlY2sgdGhpcyBhcyB3ZWxsLg0KQnV0IGl0IHNlZW1zIHRoZXJlIGlzIGEg
cHJvYmxlbSB3aXRoIExBVkEg4pi5DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8gDQoNCi0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgUGF2
ZWwgTWFjaGVrDQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMjUsIDIwMjQgMzo1OSBBTQ0KPiBUbzog
Q2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT47DQo+IGphbi5raXN6
a2FAc2llbWVucy5jb20NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1
YmplY3Q6IENWRS0yMDE3LTU3MTUgb24gc2ltYXRpYy1pcGMyMjdlIC0tIHdhcyBSZTogW2NpcC1k
ZXZdIGdpdGxhYg0KPiAtc3RhYmxlLXJjOiBtaXJyb3Jpbmcgbm90IHdvcmtpbmc/DQo+IA0KPiBI
aSENCj4gDQo+ID4gPiBJJ2QgbGlrZSB0byB0ZXN0IDYuMS45MS1yYzIgYW5kIGZyaWVuZHMsIGJ1
dCBnaXRsYWIgc3RpbGwgaGF2ZSAtcmMxOg0KPiA+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1w
cm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LXN0YWJsZS1yYy1jaS8tDQo+ID4gPiAvdHJlZS9saW51
eC02LjEueQ0KPiA+ID4NCj4gPiA+IENhbiBzb21lb25lIHRha2UgYSBsb29rIHdoYXQgaXMgd3Jv
bmc/DQo+ID4gPg0KPiA+ID4gUGx1cywgaXQgd291bGQgYmUgY29vbCB0byBzdGFydCB0ZXN0aW5n
IDYuOS1zdGFibGUgYnJhbmNoLg0KPiA+DQo+ID4gU3VwcG9ydCBpcyBub3cgYWRkZWQ6DQo+ID4g
aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LXN0YWJsZS1y
Yy1jaS8tL3BpcGVsaQ0KPiA+IG5lcz9yZWY9bGludXgtNi45LnkNCj4gPg0KPiA+IFRoZSBpbml0
aWFsIHRlc3QgcmVzdWx0cyBsb29rIG9rYXksIGFwYXJ0IGZyb20gb25lIHRoaW5nLi4uDQo+ID4N
Cj4gPiBJdCBsb29rcyBsaWtlIHdlJ3JlIHNlZWluZyBhIG5ldyBmYWlsdXJlIChWVUxOKSBmb3Ig
b25lIG9mIHRoZQ0KPiBzcGVjdHJlLW1lbHRkb3duIGNoZWNrZXIgdGVzdHMgLSBDVkUtMjAxNy01
NzE1Lg0KPiA+IFdlJ3JlIG9ubHkgc2VlaW5nIHRoaXMgZmFpbHVyZSBvbiB0aGUgeDg2IHNpbWF0
aWMtaXBjMjI3ZSBwbGF0Zm9ybS4NCj4gPiBGYWlsZWQgdGVzdCBjYXNlIGxvZzoNCj4gPiBodHRw
czovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTM4MTAzI0w5OTgNCj4gPg0K
PiA+IEkgY2hlY2tlZCB2Ni44LjExLXJjMSBhbmQgdGhpcyB0ZXN0IGNhc2UgcGFzc2VzOg0KPiA+
IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzExMzc4MDcjTDk3Ng0K
PiA+DQo+ID4gUGVyaGFwcyB0aGlzIGlzbid0IGEgbWFzc2l2ZSBpc3N1ZSwgYnV0IEkgdGhvdWdo
dCBJIHNob3VsZCByZXBvcnQgaXQgYW55d2F5Lg0KPiA+IEZvciBub3cgSSB3b24ndCBtYXJrIHRo
aXMgYXMgYSAia25vd24gaXNzdWUiLg0KPiANCj4gSG1tLiBUaGF0J3MgU3BlY3RyZSB2Mi4gQ2Fu
IHlvdSBnZXQNCj4gDQo+IGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS92dWxuZXJhYmlsaXRp
ZXMvc3BlY3RyZV92Mg0KPiANCj4gZnJvbSBib3RoIHdvcmtpbmcgYW5kIGZhaWxpbmcgdmVyc2lv
bnM/IEFyZSB3ZSB1c2luZyBsYXRlc3QgdmVyc2lvbiBvZg0KPiBzcGVjdHJlLW1lbHRkb3duIGNo
ZWNrZXI/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJUGF2ZWwNCj4gLS0NCj4gREVO
WCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IEVy
aWthIFVudGVyDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04
MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQ0K


