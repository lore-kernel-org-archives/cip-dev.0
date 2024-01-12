Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C7FC4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 14:15:34 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.79])
 by mx.groups.io with SMTP id smtpd.web11.7823.1705068780873425788
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jan 2024 06:13:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xhzUYGhl;
 spf=pass (domain: siemens.com, ip: 40.107.8.79, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLTCky5SESxjWOjcTL0lJL5gQkpKQ+03450MDVcpgFYuUMl19S9uLYMDS/8vg+2La0PP0dAlpGcOBOH/1RkaceYKmPeFVibPjzs/piUVYG+jtDEAKayXh/BD83c3Jnn6x302roGzlUdJqynJvcx85puconTNAV+DVHKQOih74+Rid8dvhr8/moori12tEZLdaRHi01fBQxGHS0O/lgZBfxZkGaabRXR+76+L5CGRvqM/mlzWCWCUWC+vseUGVszNorfKFyIUVgttM+08Nm2B4He7itsODgAnLyz4HzDjsTW5dcVPtVa8w6lUQTsIb+s7+b1Y5Y0+1jmomXQEnsIraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTJK9c5wRmoaRsRceRtk3ni9X3IzBLyw6VF7tcnVOpM=;
 b=Lf+7SNVcz2HcInrIpA0w1CxdnZEp4s71P5wSkTZg4x48Xe6hYCjXHkCNmjaPnlzX997ahTLSO/RbN6irLZD528D9be+nE0WCB+Hi83d583dUvofeVH9KwM7dxE/Bw7+UPJ28ewDksWgTAXcVJbtPTK2D/gDtb0L6WREqjoT4TGgGnhyncxafK8LNzpesRKbTu31PRnlY3igUUH1/EEPohTW0/4kucvM6cm2fUIXxgWJ03NoWdhiv3A4ZGIMYeJrQUkld6d4e4aAGTBj+2Fdn7bhIQ7SfnVtwsWgvJY12GZ7r/Rhj59x7r/s/ORruHm0L+LOkXpl7WGFD2Jfqc4WRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTJK9c5wRmoaRsRceRtk3ni9X3IzBLyw6VF7tcnVOpM=;
 b=xhzUYGhlZhcOUZMHS6IM/xE4I2wno+hXTXYOFNN1HDI3QFP1xTwQmTIkBq9oQDusgYKW/nPa6ib7De8eS9y/A4in1dvIHbxQX36pppoio9rXgd1XZjvuE6j5EbhT+9FSjl3R+/lXHinG3TZS0Uf5JsRIxOpdi0u0wiWnT4li61eUIS6xAOB7oXVdFXOSsU16VeaeDlqEtNaHWf77Q1IQqeGFRzzsfoix87fPupDTb7hmBtsBdNtkclMOArXKGckLC0gZ6fG6g1VAg1dRdUKCmkgnr0oMx5cRsMCAmzWrHQHjzhAopX9AIOH0yO8Ty9Perk/xnoJV7aM7BWCZoPuW5g==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VE1PR10MB3805.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 14:12:56 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%6]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 14:12:56 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 7/7] doc/README.swupdate.md: add new section for bootloader updates
Thread-Topic: [cip-dev][isar-cip-core][PATCH v5 7/7] doc/README.swupdate.md:
 add new section for bootloader updates
Thread-Index: AQHaRMjNkDN2ZZYt7UeCJ3/kx0cdF7DWOU2A
Date: Fri, 12 Jan 2024 14:12:56 +0000
Message-ID: <75575f6ff4179fcc189b103b042bc806b093c4b7.camel@siemens.com>
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
	 <20240111200015.190376-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240111200015.190376-8-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VE1PR10MB3805:EE_
x-ms-office365-filtering-correlation-id: a60fe4e5-43ee-444e-3316-08dc13789300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vxWZOzcCBWsvUzPXKA/HlS4JEoVxTjsgiHGSsuueb3soZ3VL9RCJEja34A2lKrBGSeT3ELCge8DYZ2BV9k2zTl/4wIsXSQbegd0HQtDI8IzYEHdmEzbLsAMMCLorjzEfWE8g2wxfRzkcYuvXmyVGQ6CLIZCoqGYkM6Zx/wkjrH1Uzud6M9+4MKfyvNpHyZqlml1jLXTPQoINfaXtkMNA29pSfuHnfVn/RTPQTrbLia56fczk3YOpke4M55TzS8SWIP1XhD38NQCj7YYQpGtV3nt1A52+PmgmR0xCCjbACdfVjiziXM8zoG4kKIOnLbByztaL4ILz9nthYRRQfv2TH7RociUzUVZoQTPraW4QB4H6s6Yd9bM3sgKwZrMj/zVkhKf5Oi4HDkLsx1/TcM5Gze7AMbCvuS7EonSev9exkeohr2hRZcRVd9/eTC7Yz4tiZTdIlGpMqbybhAcJwwOzLTZ4V8yB3sIVLbFezQ6oo+6IuepPrZA6YbaYR7GVOws6mTXvPI3yF8U7jiL/+ot+yNT+pTuIXUIRbEsdxfkCoShOUo5a87abF/2zP48rs2KTXtFXzJL7shEkyDvOMfd3a2/hyLLxXRUmIBcXMzTTdMFvtf48/hrNpUAH6O0IgvMZVFnBMTCUmJCn7km3H8TbSA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(38070700009)(83380400001)(15650500001)(478600001)(71200400001)(6512007)(5660300002)(8676002)(6636002)(8936002)(91956017)(64756008)(966005)(316002)(6486002)(66476007)(66446008)(110136005)(66946007)(76116006)(66556008)(2906002)(6506007)(2616005)(122000001)(38100700002)(36756003)(86362001)(41300700001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YnRJeGs2RjF5bXdlSEpacndwUlRVVG45RmhxVUNaNVFFR0lrUlNEeEt6MkVI?=
 =?utf-8?B?ZVRhcVJ1d0laVVhYSlFlaHBiaTN1b0dMY01YRmx5MWVJdzc4M3dRUjZiRHJL?=
 =?utf-8?B?YTN6SEg1OUwyWkV4Y1o1akxaVnNtMDdJSzBUQW56OU1oUzd0WkhQOVZTU2Rh?=
 =?utf-8?B?c1V1eWwrcVBqallBVFdFbHZlMHlrTWo4ZllaU00vcDhBclBXOHp6ZXFBYUMr?=
 =?utf-8?B?bFlhbU40b0RLaFhhWFVyTHJVR0JNbzZ0Y0l0WW0xcHhhVDhvRUtwU1JKUzRM?=
 =?utf-8?B?MEdqRFJzajl0cXJnWmJwQzgxa0JZUnBsTUhmMXZkcDk2azdHL09mdk1MTWRp?=
 =?utf-8?B?UHNhTDZTdk1yTldDYURFenhQaFJvUkZmb1BzMGNWSElQQnNhNzE1S0lnZmZo?=
 =?utf-8?B?dk95VGZ6VjdMZFc3TDJEdHhBakliT0ZZL2c5U3h3YmZBNEplTmFkRFZoTUVQ?=
 =?utf-8?B?VWVtMlpRYmo2ZEtDVUszZEhWaXppbDRFRjZDeWxpT2hKaW5pajRqaUViSWRt?=
 =?utf-8?B?TDhZam1LT1JBdnB0Q2hFMWZTNFBqQ0diYmUxRWhSU05BTnZ5amErSFRPMlAw?=
 =?utf-8?B?Q1IxaGpSVVcrdEFNc1BVMUpUcm9ZVHFxY0JOckpQZ0NYL1JoTXZZWlNDTTZQ?=
 =?utf-8?B?WVZzWHNPWjV6SWZva05wTVpEaTVQdTZXdFh1aFBkdmVrdllSRDRVYWdJcXZL?=
 =?utf-8?B?NnRTamk1c1RzNnRjNXRiNkE2R0EvSkxvN3JVeGhNQ2tKL2JGb3V4ZzBqd3Rw?=
 =?utf-8?B?ZUF0dElNVWNBb3N6WXN0eFNVY3Fwbkt4aW5XYTh2V20vRHVmRkVITCs5bGFk?=
 =?utf-8?B?NlhvUm5xM1ZLYU1LQTFxYUVxOVZzeWZkNzNvdE9QekRjY2hldTEyR1BNTVdG?=
 =?utf-8?B?UkdDNy9TWDAzTmVqaEQ4UnZ1a1JFUjV1RjcwbkpTL2trWUNYS0tLZXRVSWgw?=
 =?utf-8?B?OUxPZkt3cVB6bHVrQW5zZVFuTUJqTElmemZxaU1qOC9YQm96aGxMb0RnVWZM?=
 =?utf-8?B?aGNUTmpPOVZoV3NTSmlrdjhqMXJnYi85ZTFnUDhZdkU4T2s3NVdRTVB3NTcr?=
 =?utf-8?B?dGl2Z2c4UlV4MVVyb1Q2WjZlNXM1OUYxOFNkcklUdjUxTFRtdUlTZWE5V2Nz?=
 =?utf-8?B?cW41ZmR3dXUrTkpFSWJ5N3FIbTBvUEc5MjZ5V25mUmEzM3RBSEtzelBYTWdh?=
 =?utf-8?B?cTM2ZWc0aGh1a1V4bFRMU2Q5VWMxMlNkVXF1RUFKcnRUNGhtS1NaTkVaTlhJ?=
 =?utf-8?B?T0FUTHJWakQrZ0FweUVqTjBHQjNBa0owdGtOKzJEbm9heDNSZ2pDUzgrZlQ3?=
 =?utf-8?B?Zi9EZzl5SnhXNVpUNm1yelAyREVEZ3B1ZnNlbHh0dnBoNE5NWnVFd1N5eHo2?=
 =?utf-8?B?TzBCU1Q5U1JaNDdaSzNYajUwVUlMYVRXWkU2WGM2V0xHRmQwRGFOQXNTRW5q?=
 =?utf-8?B?ellUWUFaUXBNMUdZVTlrTklhbkdjcEoyM3NhbFJjNDFzNGJlZXgrT3B4M3d2?=
 =?utf-8?B?TDh4dWxtMUdSZjlldmZVVTRjZ1RrU0F4Y2I4a0Z1L00zZnBUdUM3TXBzMkg0?=
 =?utf-8?B?T2pFRXA4UkFQS0NPclBZL0hvMFF5U0d5cWNPYXN1WFk4dkZVWTJKRFRNdE1X?=
 =?utf-8?B?SnVkR1hiUVVRWFRpYUxGcWVCeXZjZDZ3VzZRY0JkRFFZaWFEOHVYTVZSWU5t?=
 =?utf-8?B?RXRFOGNGT3F2UzJGNzBnQU85dzFoUGxEV0E0M3F1cDlZb245cy84Y01MVHc4?=
 =?utf-8?B?cE11UWVhWWpZa3c1REFtOGtuOVZPa3lFZVZ0UXJKVGlLNE1JcjlBN2R1RU5D?=
 =?utf-8?B?ZDQyTjdWUUVpOC9Vc0UzNEFTZkJVMkkzSzI5U2NnNTA3UzNuMDZmVEpxVWg4?=
 =?utf-8?B?cXBySE40RTBvZHB4R3JsU1NuT3YyWGJjQTNQNkh5NjVyVlVLODVvajlpUlZ0?=
 =?utf-8?B?cit3S21IZW9nK0ZuZ1ltK2hVdDhZTTAwSGpGRGlNNzVpMWZaaURaT0gwL3dP?=
 =?utf-8?B?K1ZnNG1kVnNXdEtJUWlycHFpNGhYREd6b0hoakRpNWZ0QjQ1b05XNjNKNm5H?=
 =?utf-8?B?c1NhWTVWVlkwSUJDNFRHd3YrZEtWYkFvRVc0d2h1UDI1cjhZajF4NjdqZGFN?=
 =?utf-8?B?V1VqUVBQNDM3QnlISGUxbFd6OStTQnVFMGZReU93aUFOMGl1ZzhrN2gwdVl1?=
 =?utf-8?B?NmxkOEFuWjYwa2U5MXRBVExqYUgvTWQ1RmpBRVQ2YlVXUEZ1YysybnVPNU95?=
 =?utf-8?B?UEI4RDZIM1d0S0VucTJ6L1dMaVlRPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a60fe4e5-43ee-444e-3316-08dc13789300
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 14:12:56.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJ8hGwcOaPvbW5N3cTFac8iLZijUES1PJ/6OXXQelg565x98y0HUVfluw6flwB0AWRUXFyppGL1L2xsVnB22uSb+9pD9dxbrqoqcpCcxwE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3805
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B71815FE9F3F24F9AEF857CDC3B4F2F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jan 2024 14:15:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14351

QW0gRG9ubmVyc3RhZywgZGVtIDExLjAxLjIwMjQgdW0gMjA6NTkgKzAxMDAgc2NocmllYiBRdWly
aW4gR3lsc3RvcmZmOg0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZm
QHNpZW1lbnMuY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVp
cmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgZG9jL1JFQURNRS5zd3VwZGF0
ZS5tZCB8IDEzICsrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RvYy9SRUFETUUuc3d1cGRhdGUubWQgYi9kb2MvUkVB
RE1FLnN3dXBkYXRlLm1kDQo+IGluZGV4IDAwMzU5YzcuLjFjOTQ2OTkgMTAwNjQ0DQo+IC0tLSBh
L2RvYy9SRUFETUUuc3d1cGRhdGUubWQNCj4gKysrIGIvZG9jL1JFQURNRS5zd3VwZGF0ZS5tZA0K
PiBAQCAtNyw2ICs3LDE5IEBAIFN0YXJ0IHdpdGggY2xvbmluZyB0aGUgaXNhci1jaXAtY29yZSBy
ZXBvc2l0b3J5Og0KPiDCoGBgYA0KPiDCoGhvc3QkIGdpdCBjbG9uZQ0KPiBodHRwczovL2dpdGxh
Yi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS5naXQNCj4gwqBgYGANCj4g
KyMjIFNXVXBkYXRlIEVmaWJvb3RndWFyZCB1cGRhdGUNCj4gKw0KPiArOndhcm5pbmc6ICoqSWYg
dGhlIGVmaWJvb3RndWFyZCBiaW5hcnkgaXMgY29ycnVwdGVkIHRoZSBzeXN0ZW0gY2FuDQo+IG5v
IGxvbmdlciBib290KioNCj4gKw0KPiArSWYgeW91IGJ1aWxkIGEgQ0lQIENvcmUgaW1hZ2Ugd2l0
aCBTV1VwZGF0ZSBzdXBwb3J0IGFuIGFkZGl0aW9uYWwNCj4gc3d1IHdpbGwNCi0tLS0tXiAgLi4u
IHN3dSBmaWxlIHdpbGwgYmUgZ2VuZXJhdGVkDQoNCj4gK2JlIGdlbmVyYXRlZC4gVGhpcyBzd3Ug
ZW5kcyBvbiBgKi1lYmcuc3d1YCBhbmQgY29udGFpbnMgYSBzdy0NCj4gZGVzY3JpcHRpb24gdG8N
Cj4gK3VwZGF0ZSBvbmx5IGVmaWJvb3RndWFyZC4gU1dVcGRhdGUgd2lsbCBjb3B5IHRoZSBmaWxl
IHRvIGEgdGVtcG9yYXJ5DQo+IGxvY2F0aW9uDQoNCkRvZXMgdGhpcyBtZWFuLCB0aGUgLWViZy5z
d3UgaXMgYWx3YXlzIGdlbmVyYXRlZCBhbmQgb25seSBjb250YWlucyB0aGUNCnVwZGF0ZSBvZiB0
aGUgZWJnIGxvYWRlcj8gT25seSBpZiB0aGUgdmFyaWFibGUgU1dVX0VCR19VUERBVEU9MSBpcyBz
ZXQsDQp0aGUgZWJnIHVwZGF0ZSBpcyBpbmNsdWRlZCBpbiB0aGUgIm5vcm1hbCIgc3d1IHRoYXQg
YWxzbyB1cGRhdGVzIHRoZQ0Ka2VybmVsIGFuZCB0aGUgcm9vdGZzPw0KDQo+ICthbmQgcmVuYW1l
IHRoZSBiaW5hcnkgaW4gcGxhY2UgdG8gcmVkdWNlIHRoZSB0aW1lIHRoZSBzeXN0ZW0gY2FuIGJl
DQo+IGRlc3Ryb3llZA0KPiArYnkgYSBwb3dlciBmYWlsdXJlLiBBcyBGQVQgcGFydGl0aW9ucyBo
YXZlICoqbm8qKiBhdG9taWMgb3BlcmF0aW9ucw0KDQpGQVQgcGFydGl0aW9ucyBkbyBub3Qgc3Vw
cG9ydCBhbiBhdG9taWMgZmlsZSByZXBsYWNlLiBUaGUgYXRvbWljIGZpbGUNCmNyZWF0aW9uIGlz
IHN1cHBvcnRlZCwgQUZBSUsuDQoNCkJlc3QgcmVnYXJkcywNCkZlbGl4DQoNCj4gYSBzbWFsbCBl
cnJvcg0KPiArd2luZG93IGlzIHN0aWxsIHBvc3NpYmxlLg0KPiArDQo+ICtJZiB0aGUgdmFyaWFi
bGUgYFNXVV9FQkdfVVBEQVRFYCBpcyBzZXQgdG8gYCIxImAgdGhlIHVwZGF0ZSBpcyBhbHNvDQo+
IHN0b3JlZCBpbg0KPiArdGhlIGAqLnN3dWAgZmlsZS4NCj4gwqANCj4gwqAjIEJ1aWxkaW5nIGFu
ZCB0ZXN0aW5nIHRoZSBDSVAgQ29yZSBpbWFnZQ0KPiDCoA0KDQotLSANClNpZW1lbnMgQUcsIFRl
Y2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

