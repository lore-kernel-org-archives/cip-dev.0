Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E868AC3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 06:15:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.30075.1721888147651786059
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 23:15:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 46P6Fi2c1404926; Thu, 25 Jul 2024 15:15:44 +0900
X-Iguazu-Qid: 2rWh23w22J1p5Hy0wh
X-Iguazu-QSIG: v=2; s=0; t=1721888143; q=2rWh23w22J1p5Hy0wh; m=xgYKfTUjRZJyda1N2SLtMz+R0iwp6CJbSZHFh0PKnw4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 46P6FgUE818193
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 15:15:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQm3RxSLl02CHHV3mwO9ufb7MlUw0999GP/gP+tsc+pyy0ANtz/pGHjuby8R2K32Vt5h7RtlcoylbocW2A87fq6JnQ3WSV9j/IeJ13EvuQAaI7vSxcamkYjsZqhH78e5U1nO8djcUDs247RG5kw/yi198UUhtCDQAFdzQYr0INUkZmSxgP/4zry+KyDhrmyzH5oLUvKO7f44WJFt+Q2aoNIRy6fYQ/0emL+Oi871dOmtv5p97kbG14+ns4iVfz9ZLw98hjUsPZ8D+LhYnXNlUMBx8D2j2ocbt2MSxREw3gK0LC5RJCQkfWUtFODhS61H16X26+Q0+zlw46KbEOipNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlbhsrQE6EJt8j278VobdZktSIRgkto4+R6hA1UzzsM=;
 b=KBw05KbgpBopniulKEkw2/yISHxnX2v4cLeRZlWiQyQtTNo23iekYzRgZodA67Ivhc8m2E1csQf3eDEnROZh9zo5brGRCeADj5hjVdxGDbVmbbbJbgrGl/qf5IzYocldKOnyCKYPAiGFaP83XgmBrLPuWvKkB1+MhyCSkvMl5C+GbCmisDK7ou0AY9SYgPy+xWffQ6wlnzryI75tlrOd79A9bHh8tD8jPShFBV9g1FMLh7025M6+ZHCilOgmPJHBqnYUOMslQp2T17D4qS1EmptGVYNEtCsCY5ih9tRu97WnWnBUywdiKrtefQ83nVJEo/o/E8BWvayF7k04BfqBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: Sporadic failures of swupdate tests
Thread-Topic: Sporadic failures of swupdate tests
Thread-Index: AQHa1GEaJrvjQ9LEBEqUr/NOQi8XF7IHAL2A
Date: Thu, 25 Jul 2024 06:15:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
In-Reply-To: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB10261:EE_
x-ms-office365-filtering-correlation-id: c9bd9d41-05ac-4ee6-bec5-08dcac7134eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dkk5UGpGbjVWSGg3eEx4WEFSZEFXcFRmOXhYVkVsdGtBc0VXN2REOWJRQjBT?=
 =?utf-8?B?dXJ3Z1JVRURWbGZ3MXhZVGcyME5CTVRpWjZXQXowODhiYWlpYVdEbjVKWk1I?=
 =?utf-8?B?YlJYZWM5WVpiSEtaWjVEaktqOWdnczRyMERIem45UWdOL1RaZVZwZXZMM2Ey?=
 =?utf-8?B?WGFObW9kenExcWdPT21pUFZJVWpKWlMxekg2YjQ0M1owUEwwcmFQd1BTNXM0?=
 =?utf-8?B?VWpRUHlKbElDY1BKRFRZMU9EY2h1eDNpSGxpVTJTWmk4ejU4WGhGN3RxaWk0?=
 =?utf-8?B?QWp0d3EzWllQbTJQSW1jOVZ1ZG9XYzZmVkxXVEhIVU9ZdDcwNzNFaTdTN2Nq?=
 =?utf-8?B?SlRCTk5BaUcvVWhVOTVIdUV4YzQ0Lzc3ZktIem9qWEt5N1dYSHk2N29Odks3?=
 =?utf-8?B?NHg0RExGUGgwTXc1Q0FMMGpGOTRPek53TWQ4TjRlRTdBT0UxTFJHOE5qNFBp?=
 =?utf-8?B?SmZsb2QvWCtMU0NwQVR4TFBiVlo5RHN2K3JCTHY5VGxFVG41N0lTTWEyOTRz?=
 =?utf-8?B?MUUxQ1NSaExVUW1RZkhRWmZwNk0vU2F4UkkyZmcxUWVralZJdktIYktuTXRz?=
 =?utf-8?B?WHBNdFJrZDNTM1N0bC9PaVMrTENjQVRIQTRKRDBwSC9TVlVkOTNFR0J3SFhS?=
 =?utf-8?B?M21wajdDRGJhcDNqRjdZWWs3djAzeUlGV2I5RXFyOWFWZEhnL2pOei95NnM5?=
 =?utf-8?B?dkRMYk9VZVdnbnpmK3hxZVpkMlY5bXpPcTAreFJKdG81TWhaemQ1dzlEbGNG?=
 =?utf-8?B?YWtxSmp0eDZuZlFlaExPSEdTbXg5MXNWMFBDTTNRemJNMmhmL3BhbVh1K1BE?=
 =?utf-8?B?VDdicEM1akZHQklKOWFuZ2tTZ3lzZWNhckJJdTFaUDlnNmM0VUw2aUVTTVNP?=
 =?utf-8?B?enNYWDNtZlkyMGxvcEl3QmxpaEllZVJpbnB3VzNCL3F4VkJmeEZjcEF4Rzcy?=
 =?utf-8?B?Qzl2OTQ5VnR5eWNLU3U1WnJqT3hmTVl0a05lVEJGWk5tVEJ2Qml4aThTeG5r?=
 =?utf-8?B?VDJkWXZWNlkyaVdJY0gwUGhmcnBDUTJWaE5GQ3ptUWhrZXdvK1ZZcWFIaUxv?=
 =?utf-8?B?VTFpYy9ERFFpM3NJWE9jbWpJWFk2Nk5uSnFOaWp1eUM4RFhKMEM3Wmh2dS9H?=
 =?utf-8?B?TmNDUVlxa0RXNExzVDNtWnpMcDBGTXNET3Q0cW5VTldQT1dKT3I2ajRKdWx5?=
 =?utf-8?B?aFJNaGVPQTN5SkVlelV6dTI4c3QrK3czcUxKSGNaQmVEY1pFaGJpUC9pWlFZ?=
 =?utf-8?B?cmZHUys0ZzlVY2pFMXFIZGlxc1lvSkcwdDdPY0wrZ1lmV2dvRFd2ZDNmbW9i?=
 =?utf-8?B?bVY3R1ZnMXJra2xCREdUS08xbzdzQzM4REVIL3BXZlI3UEVHTEhnaGUwdmVo?=
 =?utf-8?B?a3RPSUVpZTI5d212U1YwRVR4N05FenlZMlI0cjRiTVhWOXRUbDMvODMxeG5Z?=
 =?utf-8?B?dHBGR1lRMllhV3JQTzJoZVlxcTlOWVBuNjNndG40SVMrTTNFamRaMkd4VUtE?=
 =?utf-8?B?VjhVWHdsLzFwVUZudTRHeTdCUktyKzE3L0NsTFFhdzBSbHBwMnFZNzJxd1dO?=
 =?utf-8?B?NlhtNzFHT2N1SndqL1ZxT1ZxU0JxaVdrK1ZCVnh1dUJVb0ZSWUgzMXNYNmZs?=
 =?utf-8?B?bUJlQ1BYRlZoaUxGV1laVVoycVhpNmNVT2o4REE4bko5eVBhRFpRc2xTMGp2?=
 =?utf-8?B?Y1l1VTZEL2EvZGlaNjFHMWhyUTJYV0VSRzAxekhJOEpmL01ieVJQK3hXa3hK?=
 =?utf-8?B?Wm5xOUN3RnNka0V1eS9KVDJJazBuKzRBcTEyUWxiVDFFd0ZIWUxJeHljejlQ?=
 =?utf-8?Q?2LPgrYyQFmTADjxDb2/ICfoZqBXTN0uxWKbww=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bFJvbzg5bWs4Sk5kRUppV05MTHVkNk9LbFhCV05TQmZlenRTOFJNMW41ei9T?=
 =?utf-8?B?RVFsS3dFK3E3ai9wWVlUbnpOYzNnSHpoRThZU1N4SEwxTkRkZklwSVM2c0Jv?=
 =?utf-8?B?d004d3NZdWJwMFI2Smx2STc2RjNRSWRVUnVtV0J6WDVmaEphOW9iTmJTZmZl?=
 =?utf-8?B?TGtINzJZdG9SVzJIblJHNkN1elVwb2NxZ0szdW8xYkl5cTgzYjNST1JmVktB?=
 =?utf-8?B?ZWV3NTB4bWMvc2dORGQ0RkdMYVNKdUNvTUlsTytxUWJSbHNScWtWdStHVmk5?=
 =?utf-8?B?S3FDNUdsQTNUbUFzSk9TZzkyZUZCZ1NaSlVLM2NuWTdmNEpxZVRKRTZUWnBj?=
 =?utf-8?B?MGJrdUJOMTNWRVB6aXRoc3JuMHV4eUFxWGNxZW9MdXdjMDVsSmVZOFY4L3lI?=
 =?utf-8?B?NXI2R1FCME5oQVRnNTVubzF6cm5xRXlvOEpId29OVFVUTzZUdERuYTdibnpP?=
 =?utf-8?B?MDVGeWV0V1M2WkF0UHJNaGlrOFNRZTV1WElZUTlSNURZNFYwT2NMVm16T04r?=
 =?utf-8?B?aUZTdWEzYmpkUGVZdkJncVpMc0ZEbXNuMnBlTDR1ZUpIUEFuYjRNcG92SVkr?=
 =?utf-8?B?RmpMWWNBd3RaSWNiSXRoSitZYzBDaFhmUTZqMFRJK2hIOGdZaDlsTVJtZXE1?=
 =?utf-8?B?SlBMczlzN2QvaTVVOUdtM0F2SHFOcDBDcklEcHhqQ1U3Sm5uR1pZRjVpeElO?=
 =?utf-8?B?MnFlQkloNEZhRXF0SnFqZ0x4TnZCZ2Y1VWRJNkNHcjFKbmo3SEtLTHJJenAr?=
 =?utf-8?B?aGc4dkpDaGFyb2tjYnBWVU9uMWdLK2F0SkFFcHNYeGtFREVyNCt1S1BpWEFV?=
 =?utf-8?B?Ty94NkJMUFhYcStOam03djRURzVkUWtmY2g0RnJoamptT3VjSnhBVnB2RWVl?=
 =?utf-8?B?RmNic0FPcmY3SzYyYlBXUEpaZ1M4d2NPK2pXb3Era3VpODE5NHJIN0lMY0xQ?=
 =?utf-8?B?RHhxMXB1cit1a3Y5M0txeDgzdjkvbkVmL3lsb2wxbEZuL09Gd2xDa1NRT1I3?=
 =?utf-8?B?a1prRWNoODV5aWw5UGQyMy9SS0VDUDI4Y05KRGtuWFZqekREVWloVjZmTGE1?=
 =?utf-8?B?dWtiSzVTRlg3eW5IUXY2clF1VVRENUZ4N3JMVkRuRE9TZk9RWlk0Y1BadHRn?=
 =?utf-8?B?WlRTamc3QS9jYUlhL2t2YmNLT2U1bFZvY3FJNVZGaTRReDZ4OFBTVEhRbkh5?=
 =?utf-8?B?YjhSeGx0VU50UFRUc3BtSnM4cCtIYmY3Q0xaWHUzYnFrNytoNFVZUDJuSVNK?=
 =?utf-8?B?bk1JOEdsKzhtMGJSVWF3SVRIOUtJUWdOZGs1Y2h6ZVhjQnV4VDZaLzZ6aU9K?=
 =?utf-8?B?eW1OZDdhQVpJOHVNcnhCSm42VHdZejhHZTUxVjlRUVFHSWhZTXFiZVlUcU9k?=
 =?utf-8?B?cDREckFRRHlVWEFPYWxtVUZoL3daam1wTU5oNjgrSklRRlg0T0c4aXY3MTNS?=
 =?utf-8?B?N3habm5JQXNNNjNHbFU2MU1TL1dRNWdIRjZkYlVxOTR6bko2eUF6ZTBaaVF2?=
 =?utf-8?B?bVhWaWx2dGZ3K0ZxaU81WGwwcktSTXJuWEllZWdqbUwwa0ZwR1orZHZDT3F1?=
 =?utf-8?B?S2xCK3FFUVo5NFY1MDFPNHBNSTdOaHRVdEFEeFN0TmhOZXJ4NktTNGdvZHlI?=
 =?utf-8?B?ODZ2MWdON0l5aHVUc2VBY2dKOFVJV0treks3WUZVcmxDVjlmMk1NTkJZb1B3?=
 =?utf-8?B?MWU1cnNWOFlXVFlBTXorVkg1NGptcHMrSTQ2UDhWTkFMUkNYUlRzSzR6dFZU?=
 =?utf-8?B?NVovTnBNY2xLOUhQbzIxMW8rcWs3K0lvcTFzSHAwSG50N1YvbXNDU3RjOCtu?=
 =?utf-8?B?a1BnZ1FoRG5aVHJtTTJXL1RqTGN2NDdnd0xvUTYwUUlWUk1JR2lmZjBkZkhT?=
 =?utf-8?B?dFFKQmtRcWg1QUhBRjdjVytCbUlwazY3YzIwUVBPNHlRSnJ3eXE0UGNSNVlL?=
 =?utf-8?B?RXJiS0U1RDhHczZPSUtwMldVeFFjNDhKdWpRTk9Ddm13MmJ4V0tvRE5oM1Yz?=
 =?utf-8?B?bnFScUlibXl1K1ZaUG1UUGdoSncxV0dsTGtkZ1czT0EybTIxNUdISmRYRnhp?=
 =?utf-8?B?L0I0c0FRZ29JZFp1aVNCOEhZR0t0MUE3ZnpLdkg3WkZFeFRCcnlPOHhsZjlC?=
 =?utf-8?B?OVdFbEVnc2l6d3pIMjNQTjdGQS9vWG5qNWgyYitINHZlUThkcll0bzZMalh5?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bd9d41-05ac-4ee6-bec5-08dcac7134eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 06:15:39.8805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQGSJDPb8mg4f9+WLJJ2Y6+woiKim0qqu8x3vaWCZWhQh2TUiO41mWWEYnYU95lvY8WWCV0EQY2luzvqyuP2BIrXbaoskusOKlHKFmU4df8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 06:15:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16616

SGkgSmFuLA0KDQpJIHNpbmNlcmVseSBhcG9sb2dpemUgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNl
LiBJIG9ic2VydmVkIHRoZXNlIHJhcmUgVFBNIGVycm9ycyBldmVuIGluIG15IGxvY2FsIG1hY2hp
bmUgZHVyaW5nIGRldmVsb3BtZW50IGFuZCB0ZXN0aW5nIHdpdGggc2VjdXJpdHkgdGFyZ2V0IGV2
ZW4gdGhvdWdoIHdlIG1hZGUgc3VyZSB0byBydW4gb25lIHNlY3VyaXR5IHRhcmdldCBhdCBhIHRp
bWUgb24gb25lIGxhdmEgc2xhdmUgbWFjaGluZSB0byBhdm9pZCBhbnkgVFBNIHJlbGF0ZWQgY29u
ZmxpY3RzLg0KDQpDdXJyZW50bHkgSSBkbyBub3QgdW5kZXJzdGFuZCB3aHkgc3lzdGVtIHJlc3Rh
cnRlZCBpbiB0aGUgbWlkZGxlIG9mIGJvb3QgaGVyZSAtPiBodHRwczovL2xhdmEuY2lwbGF0Zm9y
bS5vcmcvc2NoZWR1bGVyL2pvYi8xMTY0NDAwI0wxNjY3IGFuZCB0aGlzIHJlc2V0IGlzIGhhcHBl
bmluZyBpcnJlZ3VsYXJseSBhdCByYW5kb20gdGltZXMgZHVyaW5nICBib290Lg0KDQpBcyBvZiBu
b3cgSSBiZWxpZXZlIGl0IGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCB0aGUgc3RhdGUgb2YgdGhl
IHNsYXZlIG1hY2hpbmUgb24gd2hpY2ggdGhlIHRlc3QgcmFuIGluIHRoYXQgbW9tZW50LiBJIHdl
bnQgdGhyb3VnaCB0aGUgbGlzdCBvZiBhbGwgdGhlIHVuZXhwZWN0ZWQgZmFpbHVyZSBqb2JzIHRp
bGwgbm93LiBTb21lIG9mIHRoZW0gY2FtZSB1bmRlciAnTEFWQSBCdWcgZXJyb3InIGFuZCBtb3N0
IHBlcmNlbnRhZ2Ugb2YgdGhlIGZhaWx1cmVzIGNhbWUgdW5kZXIgdGhlIGNhdGVnb3J5IGluIHdo
aWNoIHN5c3RlbSByZXNldCBpcyBoYXBwZW5pbmcgcmlnaHQgaW4gdGhlIG1pZGRsZSBvZiB0aGUg
Ym9vdCBwcm9jZXNzLg0KDQpJIHdpbGwgZGlzY3VzcyB0aGlzIHBvaW50IHdpdGggQ2hyaXMsIGFu
ZCBJIHdpbGwgbGV0IHlvdSBrbm93IHRoZSBpc3N1ZSBhcyBzb29uIGFzIHBvc3NpYmxlLiBPbmNl
IGFnYWluIHNvcnJ5IGZvciB0aGUgZGVsYXllZCByZXNwb25zZS4NCg0KVGhhbmtzIGFuZCByZWdh
cmRzLA0KU2FpIEFzaHJpdGggU2F0aHVqb2RhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IEZyaWRh
eSwgSnVseSAxMiwgMjAyNCA3OjEwIFBNDQpUbzogYXNocml0aCBzYWko77y077yz77yp77ywKSA8
U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KQ2M6IGNpcC1kZXYgPGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnPg0KU3ViamVjdDogU3BvcmFkaWMgZmFpbHVyZXMgb2Ygc3d1cGRh
dGUgdGVzdHMNCg0KSGkgU2FpLA0KDQp3aGVyZSBhcmUgdGhlc2UgdGVzdHMgYWN0dWFsbHkgZmFp
bGluZz8gVGhlIGFsc28gcmVwb3J0aW5nIHRoYXQgdGhleSBhcmUgdW5hYmxlIHRvIGNsZWFuIHVw
IHRoZSBqb2JzIHByb3Blcmx5LCBidXQgd2UgcmF0aGVyIHNlZW0gdG8gaGF2ZSBUUE0gZXJyb3Jz
Og0KDQpodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29y
ZS8tL2pvYnMvNzMyNjQ3NzMxNw0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1j
b3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzczMjY0NzczMTgNCg0KUmV0cnlpbmcgdGhlbSBzb21l
dGltZXMgInJlc29sdmVzIiB0aGUgaXNzdWUuIENhbiB5b3UgY2hlY2sgaWYgdGhlcmUgaXMgYSB3
YXkgdG8gaW1wcm92ZSByZWxpYWJpbGl0eSB0byBhdm9pZCBhbnkgZmFsc2UgbmVnYXRpdmVzPyBP
ciBkbyB3ZSByZWFsbHkgaGF2ZSBwcm9ibGVtcyBoZXJlPw0KDQpUaGFua3MsDQpKYW4NCg0KLS0N
ClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


