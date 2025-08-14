Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F179CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 05:29:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.16236.1755149331910925356
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 22:28:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 57E5SlDV2083324; Thu, 14 Aug 2025 14:28:48 +0900
X-Iguazu-Qid: 2yAbj3N9ck15rGNzhx
X-Iguazu-QSIG: v=2; s=0; t=1755149327; q=2yAbj3N9ck15rGNzhx; m=DLjSxrZDkXATWrEusTLfaR7YIqO9cLThtqJWUg0GSvI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 57E5Sj3B2195449
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:28:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf9a2luETuKb7B5iUsyY3w65E5MrTL2Xff00rd5e6hwAZW/M009b1exTQRw7I53rV7imj/wHlEeGvZeJ4CHcDdtom8rQjzDZmZl0R5sPxHdOnr311w0ehUC5u2lIkTwxMULIH5tpkeATHe1SjWLxMPLAkd/vcn9AkwDV7LaSwOFFLOh2mS9rseXTr7Pj8WD5yXspMw7joJfo+/F24QnFRDstoLGNxJ/WH8LZzO7vzT1XcZDDKorQlupUuwakD/BVAupAfzK5mpTBGVe/AWl4BiSTw8sV1rfN57qhLYOxbnpbILG5wqFW7gabOCxIt38xqDwMzVUzGrXafWfnOhYg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlEZbzsFfAtmmi/ccGo5VGxOsPAeE3Hj6koXusT4sr4=;
 b=DjiUBzd6bda0+i7hqliFHfIPVrQAKQIy7IwTGn4M8+3yRLvyIw3Kj3v38OyKAqhDik0Vjz9Sq+EroKsaJtk/BvzG3635rl+BTJLOAoXWArTvZyMAemjf0e41cXv3OP/aX2FL9+3WByjEj9b1+b+uOqVLC+iY3UeUdar6vqay3C3XQzu7JjpKMW4vhO/pKgm6F4zBx/uSKzHP+eeEjGj6ftqV3jBlc+PXFspapzzMY9jrWo1src70ET/VG0oyII97pYcst36sAEh5hFcVZXmorqBD+p9XMHrgZ7p6o2D9dVetT7ZjuxOXJ1bucZnfb8YdL0xFMu4oj8WbZmBEGLqm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][PATCH v1 0/5] Add support for delta
 kernel binary update
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1 0/5] Add support for delta
 kernel binary update
Thread-Index: AQHcDFoN/LNXcEcJf0CEmE/G5X9OdrRgqwsAgADtP+A=
Date: Thu, 14 Aug 2025 05:28:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075BDCA1A20271720BFA5A8C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <420f5c3e-e5fc-41fc-8b95-e5e86af0e4dd@siemens.com>
In-Reply-To: <420f5c3e-e5fc-41fc-8b95-e5e86af0e4dd@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OSCPR01MB15926:EE_
x-ms-office365-filtering-correlation-id: 94e4fb9c-57bb-4a24-1b2b-08dddaf36eeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Yy94SzFmWVhiU2JBbVdBdHl4K3c3QmN5WTF3UFZweWZhMzlrWXRJZGw3ZTVo?=
 =?utf-8?B?L1FqdkdzeGZ0RHYwcXFXdDZHSzB5MDZwVVhBaFNQRW12NW8zcEZ5OTdPZThM?=
 =?utf-8?B?RXRjd1RsUWRwSTNKRFFmcHBrMTRwTzZmQ1N2OEh6UFE3enAvM2JqeG0zTm5H?=
 =?utf-8?B?Z1QvU1hOZXByY1p5bm1kRGFPR29EM0hhMm5GOWhOeFZ4UlRXeTl5enpVajg0?=
 =?utf-8?B?Wk5PUnBCUEljNk1OeVhZaXRPZXV3TDlKOCt6aXdscXVoTEFXSHhpRjJiUXRM?=
 =?utf-8?B?M21PcEZZblRYbTBWYjIvbGs2aVlTWmdlRDdRVGFnR1hQSE5kdUdGNUFTRUox?=
 =?utf-8?B?T0FSY2hGb0pnSlk0b3JhRmlpc3ZYeXBQVUZEZHg3bVVNcU5LdG8wLzlaREdF?=
 =?utf-8?B?M0M5V1lFNnBNYTJlY1VOWjRBUXVwYjdjRm4yMGpaWG1rQVZPcHZ2d3J6bFBv?=
 =?utf-8?B?V2psL3MzemVzcUo5TnNJTUNKbUY3L1dQUlVLS2xlWEc5L0xGdk5NTUNYaVRQ?=
 =?utf-8?B?KzRpakxadUhRNnlrSzl6MmlVbmF6emlqTzk3R1JyT25QajBLdGovTTAxMERF?=
 =?utf-8?B?SWY2THFOVmV3SFRIYlNGazUzL0VCVHg1UXBlc1FybFRadXZlTTd3WjV5L3Iy?=
 =?utf-8?B?Q01PNEZNbEJSc29OU0o3UldyUGE5ODNYdVMyZEg0bXNQYUszWUx0ZGh0MmM0?=
 =?utf-8?B?RmZsRGNUSXpITzRYV2pPWGZXU3VMZzZvQzFLVFo0Rm5FSitQQU5jZVVScUZt?=
 =?utf-8?B?NTNHWmZiNkJGdTN5RXZsTzRWWEJyUm1BZTVyNmd4R2xYZUlQV0pqRXJnc2d0?=
 =?utf-8?B?c0k1cmxSb2pJUkcrbXlJR2RCb0lrUVh2dG9hWElLSEE5a2VaT2dIcSs4YzBq?=
 =?utf-8?B?Wk14VkY5MTFxSThqR1lRYnJQYkhpUU9tTEpnSGNaUFVVVWN5SGszRkN6NEli?=
 =?utf-8?B?Z296OWxtaFI3TWNCZkNiK2luVXMyb2dhR3VFem9EdjZJZUNPbTBRYVhVUXVN?=
 =?utf-8?B?bWlxN09Ib0ZiMjNZY3hTeUFIbGRFZ1BOVU1vU3dXUGkyLy9KaDdlZkJqNVV3?=
 =?utf-8?B?U0lyUWlrK2tOM0VzMHIxR2dwcjFvTVV0QzM3MWs1TUtJMVpwTUJpbkFSNTRX?=
 =?utf-8?B?eFc4RlZhVUU1cjBBQm9Pd2tCUmNOSVM5SG1rUVpXbHhpS005OEhNTmRlb01W?=
 =?utf-8?B?SFY3aG5MSy85UXBWeit4S0k4T2N4NW82REpZY0syNm1meitsaG95enpQNEhm?=
 =?utf-8?B?dWhhSWVZaUErVXFOdjJaNlk1M24wd3VQb0xoSUJNT2RwTmR2Wjh0TzhnV0Zj?=
 =?utf-8?B?bEhSNk9YZjNxcEtjV1hPamVJcHBmcmpzRkRqRE1xTXpsM2V3TjZoVURaMFFV?=
 =?utf-8?B?cjJQcmZsRGEzdWtPcUFXdTN3Y1lZdmN2TzNRWkZHWkFJOXBISFNVaDgrYnVy?=
 =?utf-8?B?NW8xcy81S0ZUVThOQXN6dEZCT05VRUtvYk95ZEhWV3VNSjk3RjVqaFVjcmUw?=
 =?utf-8?B?TzBXcFJKTG5UMzN1SnFOOFloNGUxcXdsNEdxWW54emFQMEZOZ1BaeXNiVEJM?=
 =?utf-8?B?dlVUQTdaWVBncFJ6TkdkbDNtcFR1dm5KK3puWEsrVDd4Q3FuYWZoMU9iYU1D?=
 =?utf-8?B?YXViVDVPc1FzVU9oUllIRStPU3pzMU00K2RmYkcwcDNGOWF2SnNPRzVPcHoz?=
 =?utf-8?B?MXBheUExNU5XZENpMWgyZ2EyVzZwMjNkWlA4MjcyUFRQb2hkTnB2em9oOXRy?=
 =?utf-8?B?WFhqZjhXaDl1YVZvODc3azdXcjBmV0N2SGczL2UyNWEzQ1M5VDExbEp6Tmo2?=
 =?utf-8?B?Um5HREd5WUpvTGw4ZEFjRm51RHFpV01PL0l5Z3N4d2ovbnRaWjlEWG9pQ0I0?=
 =?utf-8?B?NUg5VHZuU213R2R3TGVJVHFjNnVNM0hPc1dsaFBqL0ZpeG85OWczL3M3bnBy?=
 =?utf-8?B?bkVVeHo1UUppMHlNV01BYmZkeW9RamlHQ2lXWHNxNjljWkg5TmZqYzcvdmho?=
 =?utf-8?Q?d0UTi6jtYP975jfv0VWmJufHuMiiEU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?THYvTFgweFc4a2o1ck8xaE8zSDNGN3licEdUU0xoM0NUOTJXMjExcTZUYzY5?=
 =?utf-8?B?bmRzN1NrMlRaNDlpRXdOdmR5dkRlTjRmM09aMkJtalZHeHBuSEsvV25Nak9O?=
 =?utf-8?B?djRBOEU5bjRnb2l0Ymx6M2t3NkZkRTAyMzh0U3VzSG1mdkJhL2dIZ2VzVG92?=
 =?utf-8?B?VjN5elVrRVlqNkt4ckhYa2RURzdmRXhyL3NkbWFVUjg0TGwySUZmMjRTL0hY?=
 =?utf-8?B?dXFYOStic0syemNzL0xkRVFOcThFQ2s1MkZ5ZE14aEZIWTZVZ3FwakRhQ2JG?=
 =?utf-8?B?QWIwQ3BaQTdIcFUvWXRoRzlob0pMWDg2elpXeVVLRVlxSGF5OUkzOE15SWN1?=
 =?utf-8?B?Q09pY3JORW5xRmxmWkNUVTRNTG9MTHdUZWVNVk1PMXdWTEhVN1ZVQTlnSDlx?=
 =?utf-8?B?K3hiWU96cEMrTXViSEJLSWZWTDJTSmI5bEdmblowaEx4SDZuTFo4eTVaMkhm?=
 =?utf-8?B?Q2NDdTFaNGo3WVJucmIxS0IwTmgwRS9LMjd3dW1KdlJYcDQ5aTFYRWRkOUdF?=
 =?utf-8?B?ODcxeWdleXZpS0dTU2lkd2xFMTRETlRDNHdmd05zMW5OVHVIWHB0Zmc5anBl?=
 =?utf-8?B?OWg1aUdwQ0R1amtlVEI0a0RyZUNETklnMHBMUXNEKzZCRHFFYXJ5VmRKYTcx?=
 =?utf-8?B?anY5NlNrYXpVaWpqK0w5UWpwRndLRjVLS0hQYnVNSzZ2ckp2Q0w5eGFMV3RW?=
 =?utf-8?B?U1FzQ2JkSUt6ODg0ckNNRityVXZSdHhsUGErRk8xOUxSYllCUVFYOTlZVkgw?=
 =?utf-8?B?Ri9HNm5XRENLWTJiZVVxSGszM3M2b3JKZ0FZc0RETnl5UklzWDU2WU1uTVkz?=
 =?utf-8?B?cGYzTlBwT1dGaUZJem1GWmVRTTBESUZ3Nm9HTTl2U3BGR3drTWIvdWRVMzkw?=
 =?utf-8?B?NDM2R2VkUWJXZSs5K0lzMjd1OStLUjdjKzA3Wnh4dDh1YmFhSWppL3VzeEJz?=
 =?utf-8?B?Z0lySjhLMEM1KzlyWWt4RUJnZWVUVnBvS0FTR1ZkT003TzBpQjN5cksrVXJW?=
 =?utf-8?B?VENZTnBMdkhnRVlKZzFFeG1rd3RNdVRNVHZmdkFYSmR2dllEaVpzalllbHM2?=
 =?utf-8?B?Mmc4dEFaSzl4ZlJkTE14anNDTE9LUVYxWU0wYWRRWFQzK0pYaSs4d0FvMlI3?=
 =?utf-8?B?NkorbHR3amJWdzhxcVY4d1ZBWVFzU3kzY09wN2JyeGc0U2htQkF4YzNHTkxL?=
 =?utf-8?B?dWJ5d05Wc29ObmIwNmFIQU95NnN6SldFdjNmcWgyS0RrNFMrRy9NZFVmUTR5?=
 =?utf-8?B?NUNTQU5zbHVxVGc0aFIwbTc0bFg0aEdQUCs5Y1hlWGhkb3NmVmtYWHo1MHo0?=
 =?utf-8?B?aThPek11MXFYbEpnYlcvVVpwbnkrNkQ0MENMZDg2N09QSGFGUHNrY1l2dVU3?=
 =?utf-8?B?RE50ekJiM0ZrbWMxdlZLYlhsNVNBbW9hYS9mV2paN28wNGFaVDcxWVVXa0xJ?=
 =?utf-8?B?dks4NWYzeTNWNG5UYmRPSUYvR3dlbzNTT3BvTTkzSTROKzVHUE15K0t3MUhK?=
 =?utf-8?B?Y1VPVGlnU0JjV3owaXkycTM0V053MmZ5aVpTS3dabzlGbkdwbzllQkM2K2VO?=
 =?utf-8?B?YUpra3lxcUREQU4xd2FvV05rNUM2dytxNkxZOWdmWFdZVCs4U3FxQkwxS2NO?=
 =?utf-8?B?M1FWaEx2TWFFT1lsVWpCYVpRaWJIVGNiS2FuVEt4bGRJL2JWVHhhNkE2d09h?=
 =?utf-8?B?VElzWXlPZkxPS3NBQ0ltMSt3L2djQjZIR1RPeCt3Tk8xMklNVUxJbmFzOTdk?=
 =?utf-8?B?NnVIelkyYmdtZmJaSHdjV0JFbDdDRzFTTUIxSWlPcFZkdDN0bGQraFYzVUNU?=
 =?utf-8?B?SDUwWERKMDZnNm5sdkNFS1NWSmI2aTFCSVlyRzdqNk90L3JLaHllWFllOVNC?=
 =?utf-8?B?VElVL010bndnTUt1ZWhpa01lckNxdHVZVStIVFlWbTE3dVROaXRNa2duaDVZ?=
 =?utf-8?B?T0gzQnVpREpnZ2xTa0U5czdDT0Fuc1RmSjVPTW5OOWc1UDFzN21GcTJyUTVS?=
 =?utf-8?B?WDNIVVhPWFBhQ3hWU0lRQUtQSWxqQTBvaWkxL3BBUE91M1pZVnEyN1NCWklU?=
 =?utf-8?B?NzBZbmxlNmdETHlTZzMwaE9Pa0tpaWdRS1c4aTR1M3hNM29HZHpIVjdWQ1NS?=
 =?utf-8?B?K01rS2I4ZFY4Ti9aeHRZYUUxczBkR3I3ZThqWVVmNFNQTXpudGxQd0xUSmgx?=
 =?utf-8?Q?igpAQffvqKBrSwcVx29nJ7Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e4fb9c-57bb-4a24-1b2b-08dddaf36eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 05:28:42.8921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT0anuvJhjCVAEcP6h2sdsF5goqRJYA+Pv+4TU/T2hC+5l25hElVUyilRECTqyZruP42oMaOzB5Ov9JzE/72whI0/gYmOe+BH6qiY9Bc2BTitK15AJjT0cooSGZ0qEWV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15926
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 05:29:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19736

SGkgSmFuLCANCg0KVGhhbmtzIGZvciB0aGUgcmVwbHkuDQoNCj5SaWdodCwgd2UgbWF5IG5lZWQg
YSBiZXR0ZXIgZGVsdGEgZXhhbXBsZSBmb3IgdGhlIGtlcm5lbC4gSSBvcmlnaW5hbGx5IGNob3Nl
IHRoYXQgKHByaW9yIHRvIGRlbHRhIHVwZGF0ZXMpIGZvciBoYXZpbmcgY2hhbmdlcyBib3RoIGlu
IHRoZSA+a2VybmVsIGFuZCB0aGUgcm9vdGZzIHRoYXQgaGF2ZSB0byBjb3JyZWxhdGUuIEJ1dCB3
ZSBhY3R1YWxseSBhbHJlYWR5IGhhdmUgYSBsaW5rIGJlY2F1c2UgdGhlIElEIG9yIGhhc2ggb2Yg
dGhlIHJvb3RmcyBuZWVkcyB0byBiZSBzdG9yZWQgPmluIHRoZSBVS0kgYW5kLCB0aHVzLCB1cGRh
dGVkIGluIGxvY2stc3RlcCB3aXRoIHRoZSBpbWFnZS4NCg0KWWVzLCBldmVuIHRob3VnaCBpZiBu
byBjaGFuZ2UgaW4gdGhlIGtlcm5lbCwgdGhlcmUgd2lsbCBiZSBhIG1pbm9yIGNoYW5nZSBpbiBV
S0kgYmVjYXVzZSBvZiB0aGUgcm9vdGZzIGhhc2ggdmFsdWUuIA0KQW5kIGFsc28gaWYgd2UgdGhp
bmsgZnJvbSB0aGUgcHJhY3RpY2FsIHVwZGF0ZSBzY2VuYXJpb3MsIHdlIGxpa2VseSB1cGRhdGUg
Zm9yIG9ubHkga2VybmVsIG1pbm9yIHZlcnNpb24gY2hhbmdlcyBub3QgZW50aXJlbHkga2VybmVs
IGl0c2VsZiAoTm9uLVJUIHRvIFJUIGFzIEkgbWVudGlvbmVkIHByZXZpb3VzbHkpLiBTbyBpbiB0
aGUgY3VycmVudCBDSSwgaXQgaXMgZGlmZmljdWx0IChuZWVkcyBhIHNlcGFyYXRlIC5iYiByZWNp
cGUpIHRvIGJ1aWxkIGEgc2Vjb25kIGltYWdlIHdpdGggY2hhbmdlIGluIGtlcm5lbCBtaW5vciB2
ZXJzaW9uIGFuZCBhbHNvIGl0IG5lZWRzIHRvIHJlYnVpbGQgdGhlIGVudGlyZSBrZXJuZWwgc2Vj
b25kIHRpbWUgaW4gdGhlIENJIHNvIGl0IGluY3JlYXNlcyB0aGUgQ0kgYnVpbGQgdGltZS4gDQpC
eSBjb25zaWRlcmluZyBhbGwgdGhlc2UgcG9pbnRzLCBJIGZlZWwgdGhlIGN1cnJlbnQgYXBwcm9h
Y2ggb2YgY2hhbmdpbmcgUFYgd2hpY2ggbGVhZHMgdG8gbWlub3IgY2hhbmdlIGluIFVLSSBpcyBm
aW5lLiANCndoYXQgZG8geW91IHRoaW5rPyAgIA0KDQo+Rm9yIGRlbHRhIGRlbW9uc3RyYXRpb24s
IHdlIGxpa2VseSBuZWVkIGEgc21hbGwgY2hhbmdlIGluIHRoZSByb290ZnMgb25seS4gTWF5YmUg
ZW5hYmxlL2Rpc2FibGUgQ09ORklHX0lNQUdFX1RFU1RJTkcgLyA+a2FzL29wdC90ZXN0LnltbD8g
T3Igc29tZXRoaW5nIGFydGlmaWNpYWwgYW5kIHRydWx5IHNtYWxsLCBidXQgdGhhdCB3b3VsZCBj
bHV0dGVyIG91ciBtZW51Li4uDQoNClllYWggdGhhdCdzIGNvcnJlY3QuICAgDQoNClRoYW5rcyAm
IFJlZ2FyZHMNClNoaXZhbmFuZCBLDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmc+IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
ClNlbnQ6IDEzIEF1Z3VzdCAyMDI1IDIwOjIyDQpUbzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTv
vLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAu
Y29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3VtYXIo77y0
77yz77yp77ywIERJVENfRElULU9TVCkgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsg
aGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkg
PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZd
IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCB2MSAwLzVdIEFkZCBzdXBwb3J0IGZvciBkZWx0YSBrZXJu
ZWwgYmluYXJ5IHVwZGF0ZQ0KDQpPbiAxMy4wOC4yNSAxNTo0NiwgU2hpdmFuYW5kIEt1bmlqYWRh
ciB3cm90ZToNCj4gVGhpcyBwYXRjaCBzZXJpZXMgZW5hYmxlcyB0aGUgZGVsdGEga2VybmVsIGJp
bmFyeSB1cGRhdGVzIGFsb25nIHdpdGggDQo+IHJvb3Rmcy4gV2hlbiByZGlmZiBpcyBzZWxlY3Rl
ZCBpdCBnZW5lcmF0ZXMgZGVsdGFzIGZvciBib3RoIGtlcm5lbCBhbmQgcm9vdGZzLg0KPiANCj4g
SW4gdGhlIENJLCB3ZSBqdXN0IGNoYW5nZSBQViB2YWx1ZSB0byAyLjAgZm9yIHRoZSBzZWNvbmQg
aW1hZ2UgYW5kIA0KPiB0aGVyZSBpcyBubyBjaGFuZ2UgKGNvZGUpIGluIHRoZSBrZXJuZWwgYmlu
YXJ5IGF0IHRoZSBtb21lbnQuIERvIHlvdSANCj4gdGhpbmsgYnVpbGRpbmcgdGhlIHNlY29uZCBp
bWFnZSB3aXRoIFJUIGtlcm5lbCBpcyBhcHByb3ByaWF0ZSBoZXJlIHRvIA0KPiB2ZXJpZnkgZGVs
dGEga2VybmVsIHVwZGF0ZXM/DQoNClJpZ2h0LCB3ZSBtYXkgbmVlZCBhIGJldHRlciBkZWx0YSBl
eGFtcGxlIGZvciB0aGUga2VybmVsLiBJIG9yaWdpbmFsbHkgY2hvc2UgdGhhdCAocHJpb3IgdG8g
ZGVsdGEgdXBkYXRlcykgZm9yIGhhdmluZyBjaGFuZ2VzIGJvdGggaW4gdGhlIGtlcm5lbCBhbmQg
dGhlIHJvb3RmcyB0aGF0IGhhdmUgdG8gY29ycmVsYXRlLiBCdXQgd2UgYWN0dWFsbHkgYWxyZWFk
eSBoYXZlIGEgbGluayBiZWNhdXNlIHRoZSBJRCBvciBoYXNoIG9mIHRoZSByb290ZnMgbmVlZHMg
dG8gYmUgc3RvcmVkIGluIHRoZSBVS0kgYW5kLCB0aHVzLCB1cGRhdGVkIGluIGxvY2stc3RlcCB3
aXRoIHRoZSBpbWFnZS4NCg0KRm9yIGRlbHRhIGRlbW9uc3RyYXRpb24sIHdlIGxpa2VseSBuZWVk
IGEgc21hbGwgY2hhbmdlIGluIHRoZSByb290ZnMgb25seS4gTWF5YmUgZW5hYmxlL2Rpc2FibGUg
Q09ORklHX0lNQUdFX1RFU1RJTkcgLyBrYXMvb3B0L3Rlc3QueW1sPyBPciBzb21ldGhpbmcgYXJ0
aWZpY2lhbCBhbmQgdHJ1bHkgc21hbGwsIGJ1dCB0aGF0IHdvdWxkIGNsdXR0ZXIgb3VyIG1lbnUu
Li4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpM
aW51eCBFeHBlcnQgQ2VudGVyDQo=


