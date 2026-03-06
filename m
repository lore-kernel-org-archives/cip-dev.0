Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBCF51416
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 14:29:09 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70125.1772807347641196486
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 06:29:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fV/SNBez;
 spf=pass (domain: siemens.com, ip: 40.107.159.59, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI9aFoChB5lCQTvbj7vQk3GhXF/JtovUZrE69qzYghrhR+VbihJ9rLyuYAheoQmpoLPydaasziiznb2BTel/h1JJDlHv2WI28EFE+Q9v4SWeCuocYkD6bpt1h2EYTKy041Uv8guzCqMgYUVXNQ6pjXpZKdPHH4DS3rUgsr2J+p1pEfTn3FRODsMRm02kejR5lassYBH3/eRv5SLle984RbVNnJfFW98v349JtyD93/fPk/VB2Y4A8wSD5PeB7jffJDam4FO4+LG9zoHcQ7ExIQ2WnVzSNM44OroyEIByW/a/0wPTKUov6mzP89wcD0oRI0K7BnA5imUPO+SsEOoW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E7GGXIjY9wHvc3Bn6MpebUJz1BNPc9HlbtPGuHNN44=;
 b=tpQl1OjZByIY58lY5qIJQBFQCSVx34fvH1HxLtRHaOooeCXOo8cjcwM9YrtvpWMqKQ7c4/4W8K+UaUDUfCrs7E/8dP2/eCyUZgmUfcOrzx5NYjY8t+fbfHEhw6Wr5WGM7x2C5t5c8u1v+YWfWRINlW5dRg8GOLMq+T8zWqcCOV4YRdbv9g88+9cTgp833pOIAY+tjXC+d+bkNRaXnf+F32GZLNSrH1Fq7hE+JSh5utUqQgy9Jmr2wrFnFw2KhM1lXNXI07innIgbz7ICjEYmO76uTeimdXfCDtgjo/JVp3zIipi5U3JuK10I2panTg9sQMQfoQ+eR1PeEz94w+y2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E7GGXIjY9wHvc3Bn6MpebUJz1BNPc9HlbtPGuHNN44=;
 b=fV/SNBez0cPB3fnUePMicRoWbK7tVDE1PreiQ8BtIRO2yZ4EHKei655dR7u2/R9JHeLLcbgprQSOObFQfgyDOrjtHUZmK/bsLNaS8G/jR6/Z7qqifjh3S8pxVkbh3KsY2XTAUqBfTNJrSXZi+CRKKrXG2vlEBiEkufm5McHaX2AZT84sRof1lRcDl0PJdYvXoZn/lisdA2a+Gbp5nZrZuujVXQJyJ7WLCugtU9LQpkFo0+6gXZzZAYO7h+RiBeGqwZ8H57QtGa8JUK7ovVgXrecc0TB1CIdtbCqZcpjQITnoDX3RyZ1jxU+bRh+YLw/Mah8gNVDV1dRcAvDL/yZFDg==
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 by AM4PR10MB9477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 14:29:02 +0000
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::349d:731e:a849:b4a5]) by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::349d:731e:a849:b4a5%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 14:29:02 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Heinisch, Alexander" <alexander.heinisch@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2 0/2] wic: Wipe LUKS2 header of rootfs-B
 on bmaptool copy
Thread-Topic: [isar-cip-core][PATCH v2 0/2] wic: Wipe LUKS2 header of rootfs-B
 on bmaptool copy
Thread-Index: AQHcrXSkqO20etbu5UauJqnYMeOndLWhkD2A
Date: Fri, 6 Mar 2026 14:29:02 +0000
Message-ID: <d4adc9e349cf327841c690df4fd167fe5401940d.camel@siemens.com>
References: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
In-Reply-To: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-8 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6823:EE_|AM4PR10MB9477:EE_
x-ms-office365-filtering-correlation-id: 0e26ff2d-13b5-4b1c-cd2a-08de7b8cb6e6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info: 
 FBskfWzF9VZplyJUstvxXAQbVFeXacovEB0RA83VLRpWbbkr475proLd/sSytUNpqpXOT2ka0jhlamxoI2n5qJzPNrWgROK7X1TsK0bqHxpoBkBy5kYqMkQBQ5KYbU1oPLbycz7ON/hyqekcHbbcj6Ke9aGQ0T6xjp4gBye/C/jIR85oS/YG4wLJ7fu6CMppCkmNJvQ1OIKbWEs53sYgL+P/tKOEo/DldO6VdeKhGNEC8xCBBYjDnB/UjHkCAPfER78ll2DVWFd4IRk+k2dwX0wTNdaLW5UQ5o4UV99dKkgGLpeScyY7H/amCAuyBVqQ/nozCSdZXz+ivuSDGyGz0INyTyy36ljsLpSFBVmLMShg3GGqAMzvq/pilqh6MwldENEo0ZIiLG6DQDHCkQbQn649W0gS3Anq5yHNE45o84XvD5TgQST+xNmL6SIz8QxB3DVkGVPTI6mi/qHqVyXm7t3ouYOXYI8RmN6jYrorYtjVJbdmllAtQhcA0E1ttw83oSu0papbrs3OyWmyLijgqiKVyKNCkCefQtNbsPWYt5/bSRtw20sklKvcM+PRFh1hXX1tClA3d/lS2eShh6Hpe59mzVzNRLQhrkw9Lj64+X2o21zJOpFNIH4NeEKO40DgbyqPNDxFmN78UUfKXthosS/fMGqLFeIcf0a8vX0YMBYWDJ8vU09J2xXvSudRwI/0/shcFFwk+bXW/HJdcL3Q2T2xugpKw5dGCPyK1xbYbWi8pnwODfj15b1RWNQdZ6znq19r4FXxc1akbXwmPGZBEnLy/K7V4Fmq2xtZ1qlpAYU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OGcxcnloSkI1bm5jUDZNVzIvUDByYURCV1VIOTlzNDByZzRIeWNvUXNZQlp1?=
 =?utf-8?B?S1FSdXdBdVlhN3c4WDBHREZRWTZMZjF3djd5UzJzbUJRYUZUUVNWVGl0bk8z?=
 =?utf-8?B?WEhFNVZ1Q2NZUGtyRm94Rk5XVXR5czhzN1JnYTJDQ0VDSytiMS9wL3U1VXlM?=
 =?utf-8?B?OHpLU3hlRWQ0bkVZYjVVNGJDTzQwRVhRK2xoUnpBeTI0Q3R5bDdGZTIrQ3Ew?=
 =?utf-8?B?UzA0Rll5UHNWVWdKYzNsRlVUSWFPblNBOWJNQjczOGo2RzZNRUt4UHVib0Zw?=
 =?utf-8?B?Y1ZMUVk5VHFETTA1SXVObG9FSVhiUXQ3ZTVDcGVtOTZsK1U0b1dFR3pseVhr?=
 =?utf-8?B?MWFLdmFpSzlLdkpBenZMakEwSDJydmVqNGpyRW5RUGE5YTBUSmc1UnNpT0VY?=
 =?utf-8?B?VjlhbUp5MTdLU0Y5M0lZSDdwZlNVQU5KU29MTTduaFFrckdVaWVmVXQwYjVL?=
 =?utf-8?B?aG5rTjllVjl4NVVLTVhrNnA3Sk4yaVdJNVROTnRPbkpwREFGelk4RXVYVEc1?=
 =?utf-8?B?SEtESm9nWHZSNGtRcXlHZmppcFhnMnZldGxDK3NNMlhpRXJxVHlDQjNyYTNQ?=
 =?utf-8?B?NEhYYlIxSjZIMVNKd1poK0MyallmNGM3L3ZHeEx6OWNHM2t2UzBVSXJVNDFX?=
 =?utf-8?B?V0Q2TVBLeU5lUDYvcldEa2pibWloNENjK1ZaOUZMbU9CM25MMHE5OHliaXZw?=
 =?utf-8?B?NFBmSStDZms1OHdTYysvZXRJaDdpa3ZTUVo3Zmc5Z0F1SUhLMnk0N3IrNytK?=
 =?utf-8?B?aXN4MmtXcklZZThlTTNFQlNnWjlFL05ZSTUraE92dm1pdXM1cDNxaW5COXVm?=
 =?utf-8?B?N2Q2SzZJMUxyMkp4S0VSczZIWXFVRlRZLzRZeHYrTFY5Z1pKWVJKRituSm9p?=
 =?utf-8?B?em5KakgyNnJJVHFKaWxXVzd5SmV4OFBzUnFaT3BFU3dMcjd2a2t0d0dyNjFH?=
 =?utf-8?B?d2xhSlovQlQrSDFJaURCTlRnYW04YncvR29MazZGNWZoaVRocHVFR2dTMGlH?=
 =?utf-8?B?R1ZGem5ydUQ4TXpvU0V3dlhlRDdEK3BZYU4ycFNhWFptUWk2bjEvYXdyUVVB?=
 =?utf-8?B?V2tWTzN1OWRGblo0UzVtcDdBaEZmZTVSYW9VN2J2U1JuQkU2QjZZL2x0aENu?=
 =?utf-8?B?OU9VZTFGT2sxaVhrQlpDa0hqa0M1dFVxaFZzMWI1MllrM2Nxa0Q2Rm1GaExZ?=
 =?utf-8?B?eWRVbW5ISk9TZFB1UHN6bzRZNm5LakthR2NFMko4dXBKZnE4VEp3MGs3TU1J?=
 =?utf-8?B?RFlxVGcxS0ZTQlUzalF3cDkvdmN4ZWo4a1R5ZEpMSXlVZXBnelhtcHlWL1B5?=
 =?utf-8?B?Z1lWV0ZUUFpFQlNHUEVmS0hSaHFDNVMzVk5HbmVrZldLQ1hueVJiRE1wYmR3?=
 =?utf-8?B?eWpVekpmaEkvK1BsYXQxQVlMOXRFbG4xOFJUOGFhM2VZYjE2LzN4UCtIMFY3?=
 =?utf-8?B?VW9VM0pXdmN2UWxqZkJ1Wjl2RC9oVHZpcElDR0JTbTJLVHJNYllHSldxZ0xU?=
 =?utf-8?B?UThsMDFRYTJlaFdKN1I2bmpWeFVJZjBseUUreERQMkhXQWRBRHBxOVgxeksw?=
 =?utf-8?B?NThXbUt0L2RsN2svV1BLYWNxMThRWHIrRlRENCt5YUV1K0JCdFFCNXoreE1K?=
 =?utf-8?B?QjBqbWg3YjVHZy9BM3hJMjlFTTJPSkZjZ2JJRmc5RDNNbHF5dzlscXdkL2ZI?=
 =?utf-8?B?VXV6ZkU0U3lDTXp6RkFOTHRHUmQ4ZEJkSnljNmpIWVpzajVHWGo2a1NOZTlj?=
 =?utf-8?B?S1hEdmw5Z0s5cjZBY3M2TkpjUTZrTi9LUmtnQW9HRTZROXpzN0toSWlZekFX?=
 =?utf-8?B?K3QvNjIxN3RORUV1YjlpSXltcUFDa095VGhTYWZxYldzTWQ3ZC9PNnVIYmIy?=
 =?utf-8?B?eGlJYk1oVk1TVWNZZmltdU9YZU9zT1lWQ3ErTFZGSENuQVRzNFozaUE4WFB5?=
 =?utf-8?B?WWlqMlZZZjZDcUpDMlcyUjY0b3ZTN0huOXUzRHF1cjNrZ0hqZnpJOStUT1pN?=
 =?utf-8?B?VVh0UGphVDI1MVhCa2lXakF3ZHlZM0pJOVlKMEJad0oyNEdRblpYQUZQQjRv?=
 =?utf-8?B?cVJUNUJ4bEtCRU9Ha1NnTklIdmNMdC9JT3ZqSTUwSXFGenhLSUQzNWt1ekVK?=
 =?utf-8?B?M2x1Rk5nc2RMSkJKaE1ZRisrYlV1L3pnY0dQYWNEKzFEcmhHK2gwZzRPTGVN?=
 =?utf-8?B?dmltdXdkcUdCSW9jaVJJOXU5aStnVEtpRVhOZkJoTFlIQ3BFKzhEbmVaWWlN?=
 =?utf-8?B?VGdhQk1oY29VeTNxV1l0ZFNIdUhUMmpOcWVWZjZObVMrMVRlYTc3WGpPU283?=
 =?utf-8?B?S293VS94dlMzL05GZnNXNWVnNzBIOHE5aXU5TkxpbmI2UC9iWkVzRzdGNXhQ?=
 =?utf-8?Q?zOfBS8ZixSOJS2S6K+jxtgbUdLD0elko8szgV4ZRyUkHj?=
x-ms-exchange-antispam-messagedata-1: CiskDggAami30Td4z5mHzDTjisU8fzPBijg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <695155D2795F274785155AB7163C3926@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e26ff2d-13b5-4b1c-cd2a-08de7b8cb6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 14:29:02.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5//jiFR3s+3CIqITtlfOhAxgJRip+jb4xTf8bG3z1pSLMIzG3pkFxbtfN1brhHtGY1/FiDoR2oEdicb0oUdMUu3aRr+HacP3tdiX933OdE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9477
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 14:29:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22105

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDE1OjIyICswMTAwLCBhbGV4YW5kZXIuaGVpbmlzY2hAc2ll
bWVucy5jb20NCndyb3RlOg0KPiBGcm9tOiBBbGV4YW5kZXIgSGVpbmlzY2ggPGFsZXhhbmRlci5o
ZWluaXNjaEBzaWVtZW5zLmNvbT4NCj4gDQo+IFRvIGNvcHkgaW1hZ2VzIGBibWFwdG9vbCBjb3B5
YCB1c2VzIGEgYm1hcCBmaWxlIHRoYXQgbWFwcyByZWdpb25zDQo+IHRoYXQgYWN0dWFsbHkgaG9s
ZCBkYXRhLiBUaGF0IG1lYW5zIGVtcHR5IHJlZ2lvbnMgLyBob2xlcyBpbiB0aGUgZmlsZQ0KPiBh
cmUgc2tpcHBlZCBieSB0aGUgdG9vbCBhbmQgdGh1cyB0aG9zZSByZWdpb25zIG9uIHRoZSBkaXNr
IGRvIG5vdA0KPiBjaGFuZ2UuIC0gVGhhdCdzIGFjdHVhbGx5IHRoZSBmZWF0dXJlIHdoeSBibWFw
dG9vbHMgZXhpc3RzLg0KPiANCj4gV2hlbiByZWluc3RhbGxpbmcgYW4gaW1hZ2UgY29uZmlndXJl
ZCB0byB1c2UgQS9CLXJvb3RmcyBhbmQgZGlzayBlbmNyeXB0aW9uDQo+IHRoYXQgd2F5LCB0aGlz
IHJlc3VsdHMgaW4gYSBMVUtTMiBoZWFkZXIgY3JlYXRlZCBmb3Igcm9vdGZzLUIgZHVyaW5nDQo+
IGRpc2sgZW5jcnlwdGlvbiBzZXR1cCBvZiB0aGUgcHJldmlvdXMgaW5zdGFsbGF0aW9uIHRvIHJl
bWFpbiBvbiB0aGUgdGFyZ2V0Lg0KPiANCj4gVGhlIHByb2JsZW0gd2FzIGludHJvZHVjZWQgaW4g
NjNlZWYyYjRmYjVmZWIzOTNmOTdjZWNjNGY0MzI2ODg0MDNkZWQ1ZA0KPiBieSBub3QgY29weWlu
ZyB0aGUgcm9vdGZzIHRvIHJvb3Rmcy1CIGluIHRoZSB0YXJnZXQgaW1hZ2UsIHdoaWNoIGlzIGFj
dHVhbGx5IGZpbmUsDQo+IGJ1dCBuZWVkcyBzcGVjaWFsIHRyZWF0bWVudCBpbiBjYXNlIG9mIGVu
Y3J5cHRpb24uDQo+IA0KPiBCYXNlZCBvbiBkaXNjdXNzaW9ucyBpbiBWMSB3ZSBkZWNpZGVkIHRv
IGdlbmVyYWxpemUgdGhlIGZpeCB0byBhcHBseSB0byBmaWxlc3lzdGVtDQo+IGhlYWRlcnMgaW4g
YW4gQS9CIHNldHVwIHdpdGhvdXQgZGlzYy1lbmNyeXB0aW9uIGFzIHdlbGwuDQoNClJldmlld2Vk
LWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KDQpU
aGFua3MhDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNo
LUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==

