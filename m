Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F65EC27C79
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 14:38:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.22794.1718807916059546887
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 07:38:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 45JEcXiL1169756; Wed, 19 Jun 2024 23:38:34 +0900
X-Iguazu-Qid: 2rWhYYPQFodAKDMaaO
X-Iguazu-QSIG: v=2; s=0; t=1718807913; q=2rWhYYPQFodAKDMaaO; m=RLy5gOQrWJXrqJTFU2uJ85PE8Zwy7LZIFy1SiX3/1yA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 45JEcWkb2316745
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 23:38:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jggOgHzL46CQQXZ8j+/J0Vjdw93FRYmJRm3JIzH0kvsspn1zgYmO8Gy7PoDM3jFoou4D2iSanMVww7xR0BsgAhP56Vv3On8hKRWcNYsA9MUc1TgG3pNRMEDku3q2jzDTXqi2Z9pvVnLnt6hoC+HWFHu7RWgyTTTPEcXrya9aPVAxchgqqI7S7RfTv+hObDI+zfbEluocpT+OwmPF78Vpb/TuTkGSiRtBZMIA+CFX2sIUV8kY1IUMNksyh6FOQX0bDbSTvKA0Qd8CGkAYbu1wKlqG+s1T8CiipZeMYf9X8nkTai8XooG5YY+jcdoTridunqjAj4tDQj8SB9JvZl/7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrHyVVPzYys4UxXbUEIVwAb6sK4rautVRZP3SLvHwXE=;
 b=DDZwUbeSIeOr8FuTjrZCITxyCHZVlVZU8gIhOK4pqfrawWs98PEMUpDSRULyw1XEyrQ2VZ7Azxcexj3E3xfAUzMEXeJXAyjfdPiN9spgidBWZEoC6ztmkVfDHDoo4b8+IpOlm71ps3XKjVr877s6UROfe0cB2V7NRSQnE0HN3SdhWKYByJAh3CSXPE9T3uCM9tOTTGZWWO85phTU7zNE3vY2TcOgMP4gBljNdVLYbber8ITzP1TaAFOQMSy52iuZf014CySbtLzqxuv/W7Qe3M2hm1iKY2Jmyt7vyg83HSyrnCwVgu3UMIggvbShJdJtr2oLJ2tfzwfIWrwDR5CTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <schilling.benjamin@siemens.com>, <bjoern.kaufmann@siemens.com>
Subject: RE: MCOM device testing status
Thread-Topic: MCOM device testing status
Thread-Index: AdrCLbeQi0Gg2eBfT02xZu9XbekTxgAIy0WAAAEIgyA=
Date: Wed, 19 Jun 2024 14:38:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110751E3EC5B5EAE8A15B3A08C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB11075D40AA8B013BAF6DED310C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <5e3a4961-6b59-4fbc-900a-981144572682@siemens.com>
In-Reply-To: <5e3a4961-6b59-4fbc-900a-981144572682@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY1PR01MB10723:EE_
x-ms-office365-filtering-correlation-id: af89a2d4-a161-4ba8-e74e-08dc906d7cac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?elVGRzJBQ09nNzZFWGhpUGdJa0szWXJYLzk0Z3RSWUdDS2NJRUtHV0ZaU0pN?=
 =?utf-8?B?NzNzTzZOeC9nOTFCNHhxciszVnhwSDZqd1c5Ylgybi9ER2RXUlFXeUxSODJh?=
 =?utf-8?B?SW1tcEdXMlFiVDlGWit5MHplQ1JaOTY4UlVYNk9rblV6a21qRmY5SkJKSDZF?=
 =?utf-8?B?cEhHUndTMFFQRXVxYlBXL2lDNHNyWkp4ekwxdGJJbFdhSm5COTUzTGNWUjU0?=
 =?utf-8?B?YlFXSGpsVkpITmJpNXhzQXJMd0RKOWp1VW5ld21aaG4vV0NNSmRDa2xNYytn?=
 =?utf-8?B?cFZ4WDIvT2RCd3dWOWZ3L25MWmg4bXFYaGEza2dneFZaSUk0eVpCN2NHM3VQ?=
 =?utf-8?B?TDBveWlmdWVQd3BZTzdHd2hEUWNLbkh6bFZBSVlTS0xYKzZQV2JvL1NFd2lX?=
 =?utf-8?B?ZGZPYU5VbHhuSGJSMXJUbEtDbktKeVpmTzBTZ3J1RzRFMzBxZit4MCs4dnli?=
 =?utf-8?B?NFhOcTIrek5kbUFHV1RTNk8xQmtiK254UGZGNFhhVjFvWTJsRkx4N0N5aXhl?=
 =?utf-8?B?ck1jSmhZZDl1UE1LaHdSbHUrek54TDBXckhpVjNYRXRlbHYvTnZhZGMySzd3?=
 =?utf-8?B?K2RySlNxRlZ6VFQ2VittUS8vbUZnSmY4RjhBcUUxTFJIei90YXExdWtKMTly?=
 =?utf-8?B?NFA2elM1V2J4M2ZhVXdlM0R3cnpiUWQzSFNVc1oyVTlKbXBISHVmQmRXOWxM?=
 =?utf-8?B?NWt6N0l5WCtiMzVWajlEekU4YU1pTWZCWnI2UDBmV2lBeVlERUlKL0lCNlZ5?=
 =?utf-8?B?dCt6dXdGeDFIck4vemwrQzNoSVZEaDhIdE8rYVpQZFUzNG5GQjVzejB3MS9m?=
 =?utf-8?B?OVlLU1FnMTRVcWpmVDBHS3NEMitKT0ZaaVBHUHN6SDdWb202RHo4Qkh5c1Ny?=
 =?utf-8?B?U2JiTE42Uk1XYUJWckx3ay9SK3BDNlNPQkFlSmdDK1NyMjRiamYzUTJQOW1x?=
 =?utf-8?B?NnlKZGt4bXFEOXJ2QlNQKzBWN2VzS1RnUEhDaWozWVB2eXNmMFRWeGRoeUxt?=
 =?utf-8?B?RXgrZDl2bjd0Y3RxSjVXWTk4MllRck50cVI1M0dpVzNWWVlpY0pzcTFvbGpU?=
 =?utf-8?B?WWZQZ1lyKzRBa2tuajZuc0JUck5GcVZnSFVNWTczZTRGMDFybjNEVzR1L3kv?=
 =?utf-8?B?dkxjeWlmeVgyTElXdmZsTEZDYU1ITnkrckgweElZZmpGcUJocXZray9pWFpp?=
 =?utf-8?B?Y1FqQWh5NFc4ZERjNlBmdGhZYzdzOEh0Y0ZVVWlWbzlaQ1QySDNsWi94RjRw?=
 =?utf-8?B?SHptelQrODg4N1pKb0l0ajBHMWgrMnVOZCtaQ0h2OElPV0FUV2hZd2hudWlF?=
 =?utf-8?B?S1NyU1FGdEJXcnFtTVVxSzFYMkk3S0p6VStxT004TW9GQ0MxblpSaFYveXNF?=
 =?utf-8?B?cjc5cFNYTHlyNUlWZlYrMko5SGRmQllaOWNjNCtOOFB0Y2dnR3dZWTZFVTFG?=
 =?utf-8?B?dHc2K3JCZjlBTDFlbE5CQUNkRVJOaUNMdUJXdUFmWlNPT2NjempCYmZLWVJQ?=
 =?utf-8?B?dEo3K2dyVFUrSXh3WjFBQlRjV2lNV2pOS1RadGRlSHVjanVXTmpON1FRMmFh?=
 =?utf-8?B?eSt2V3l4djlvQ2hnM1ZyRnRRYjE4UjkyUjFRQ3FlYjdPZExWU0lMNmpMSU1Z?=
 =?utf-8?B?RjJsN0lGdE1oVGt3bHlnTGh0OXdEcExnMno3NU01dEpIcEdNeHVJcTViMTZ0?=
 =?utf-8?B?ZTBVSmRsQThtUkV1VnhlMTB2S3Y5Y0k5U0lVV29obzM3eEF5QnJsbGhpcjZx?=
 =?utf-8?B?bjVJcHI3L3doZnhnS3lvVC9EYURESE9BWDVncHo5TEFtRUtqMzQrQ2VOZUVm?=
 =?utf-8?Q?4p2TrG5GRg6orYBGRP02wgUf3FZpD3GLyFiDE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bGJ1dHVuTG9MM0NoQjNiNXQ2Y1pWSmIvQWp4UmRMM1MyUWRKS0hITE8zU1Nr?=
 =?utf-8?B?b1BnK0lTeWx5cDk3ZTdmdzlmSzFkSm1YaUhQaExueG5CRFV1OXdKVVRXU0N1?=
 =?utf-8?B?SkEzeE5lQUJGN0x2RVY5SndvcFc5NFRTNzRXaEdIWTdnR0QwS21CNWIxYmpn?=
 =?utf-8?B?U00yMFlBcVlndVJRR2lqTEw0dU9EQzFXUGl0MmMzVGluVnRyRzQzT3NyVEp0?=
 =?utf-8?B?RVVxWHA1SEdWaURRRDQxS2g2VUkzaXNLOFZqOENLbFVvSHpuNmdvZUcvemYx?=
 =?utf-8?B?cFJENjJDR2l0akNvOGtCTjlNT1llSFNESjVXVFp4SG5WcllYZzhjWmEyZ1RY?=
 =?utf-8?B?Z1dVcm11Y1RLR0pZdm5zcVptM1VaUVZMNzZGY3BiZDFSeCtzeXl4OHVZUGtK?=
 =?utf-8?B?SmpUTm1RSFhFc2RLWjdZaVk0S3lsdGhQRVlkMFA2TzRjenhQT0d0dE9tU0VD?=
 =?utf-8?B?bU4xNGdmQ0lsQy9Gb3I1em8wRW5VMk5QYmhzYnFNaGhJSUpzQmUrYmk1UWpp?=
 =?utf-8?B?RDAzTFRZK2g1NWpHTC8xMnpnTituQkN4aFZKS2svTE1wbk9Ldk1zNGVUL3J5?=
 =?utf-8?B?VTJ6MzJJcW4wRFhLNHduYjhWMGtTUERZWkdHK1c0eUlPS2lqUHNma3N5SFk1?=
 =?utf-8?B?L2padnQ1ZmM2T0psazBKNkg0V05ka0JqSDkweWIzK3BNSm1zRkdVSFVOUEcy?=
 =?utf-8?B?TVFacXBDbC91ZUE2NWtWZS84dU45bUNEYmlNMmRMYzFOMzdPbjFtalNOTXZD?=
 =?utf-8?B?WldrOG1RS1pLRHZoZ3ZUUzRxWm9TOCtvTkFUSlkxWmplYWxlc2lTV3ZqN000?=
 =?utf-8?B?ZUxQTjVvMjBiaEVLaC9LdTZlNWxkYXZIT3FVbW1iU2NSbjQ4ZEJmZXJud1pC?=
 =?utf-8?B?YldBblJ6dXllSG5GRFpibW1ENlhja3lYZzdDdVhUN0JWbHcvNE5JcU1Id1NE?=
 =?utf-8?B?V0Y3SnJMa0ZkNkxuOG5idkV2bTI4VFNIUnBwWlhZdmlTY2JCMzZYVzhCNm1S?=
 =?utf-8?B?cEkycVJHWS9RVGhZSnp2U3dRZk5Gc1BXdUxZUE5tL0JUejJudzZVdzlndnpH?=
 =?utf-8?B?bm02bVp2NFRNVHdoOHYzMU1mSTY2RDAvc1Y2dmt3MFUxS1NZN1VzL0tJdFJt?=
 =?utf-8?B?OU16T1RjRU5GeklpT2NZSUs0cnlvR3hCZjN5SnAvTml1dGRJbUUwdkc4ZHVI?=
 =?utf-8?B?RUZNZ3p0OFRrbjVvOWtnQVY5SE0yK2tEWTlqNE1lSFZSQzFVRGFINlFnN3NI?=
 =?utf-8?B?Yy9wNW51NjNMejVYdzNGQi85TldXMUtvOSt3VDZoMWhMbWNXbDhwQmRRdGFP?=
 =?utf-8?B?c1Q4RThrTStIZmlQRzNaZHBNdEU3SXlZMGpVOUFUK0lQTUR0aXRYY0ZXQ1BR?=
 =?utf-8?B?RWYrdkF1anRwaG5IZVhUaXB3eWZJak5lSGoxOUc4Tjk2Vzl6Qmw3RHMxWXdY?=
 =?utf-8?B?eU01TUJBaThZUkswaS9vdG9rREIyTnA5ZlpKVFdqVjBDQnF1L1lpVEhFcHdl?=
 =?utf-8?B?R1BFUlpFeUJRTGN6S1hPNEY2M0ZPaUYvQVZDWUxOQ3NSblZKM2tmY3NER1Ey?=
 =?utf-8?B?UVVobG93S1lDUWd0S0dCY2JQRkxKWXVoREVHQlhzUGx2ZzhCaWZLVUZmOUVp?=
 =?utf-8?B?N1MvTUZJUm96MzNUNnlPU0pWbUwwdGpoc3dobCs4M1RZc2pBekpVbGFLaStQ?=
 =?utf-8?B?bkhJM2lnU1FKVmZXRU44alA1RTJFZ3htYVg4Mmx4ei9adFRMWE9XYUV2eHhX?=
 =?utf-8?B?RGg5V2NsNE9GcVZVeFl3TmZHSWd0emhCZWloQkRyNm16VmFNRmNGVEF2aXlL?=
 =?utf-8?B?dWZmOTN1aTV5cS9VUG5rOFA2TTcyeWQ1bktFMVR6YzIvVllRVEozbyttR3o3?=
 =?utf-8?B?b1J0RCtWVUNzeHJySDVhdUZTY3IyVVI2SmZ5NitCYXlwSWxXNENLTjY5VnJU?=
 =?utf-8?B?ZG5mdzU4VG9QbUlNT0h0RThXMFlzSEtsOFFpQ2VXQTFHYVdxNDNKenF3RmVF?=
 =?utf-8?B?VDNyRVVCT2pQem0vYWQ1VWl5TWt3WU8wQlZ1T2V1OUtyMGlzM252am1BVlN2?=
 =?utf-8?B?U2dYaE85SFBsT2NGaVdtMU5aeDhCNW5VNTdncjVyZXdtMlRZUENJZktTa3ZN?=
 =?utf-8?B?NEZIV3BtcFBPSWEwQmsrbU0xbEdoQUkrMjBBc3pDdmt0ak1FbHo5QmxLd2c0?=
 =?utf-8?Q?kXr79cxcrsjxrXLNJIp4hXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af89a2d4-a161-4ba8-e74e-08dc906d7cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:38:29.6743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXPVrkMRwz13+oDgGcdHlk6DYwCsvZTjwn2f05xF8qTczNySrxN2/ncJu1bowi0VtJ1J2qhBKmJuYwSihFu3JShqKsx1kjUvCwO8YqSTAoHhJr8rT1s2qxJGJsN+Nmmf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10723
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 14:38:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16298

SGkgSmFuLCANCg0KVGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIHJlcGx5LiANCg0KPiBUZXN0cyBv
bmdvaW5nLCB3aWxsIGJlIGZvbGxvd2VkIGJ5IGltcHJvdmVtZW50cyBvZiBvdXIgZGVwbG95bWVu
dA0KPiBpbnN0cnVjdGlvbnMgKGhvdyB0byBnZXQgYSBQSy5hdXRoIGZpbGUgZnJvbSBzbmFrZW9p
bC5wZW0pLg0KDQpPaywgdW5kZXJzdG9vZCB5b3VyIHBvaW50LiBSZWFkbWUgZmlsZSBuZWVkcyB0
aGlzIGtpbmQgb2YgaW5mb3JtYXRpb24gdG8gdmVyaWZ5IHNlY3VyZSBib290IHVzaW5nIHNuYWtl
b2lsIGtleXMuIA0KQXMgb2Ygbm93LCBJIHZlcmlmaWVkIHNlY3VyZSBib290IHVzaW5nIHVzZXIg
Z2VuZXJhdGVkIGtleXMgYXBwcm9hY2ggYnkgYWRkaW5nIG5ldyB5bWwgZmlsZSBpbiBrYXMvb3B0
LyBhcyBtZW50aW9uZWQgaW4gdGhlIHNlY3VyZSBib290IHJlYWRtZS4gDQoNCj4gV2UgYWxzbyBo
YXZlIGFuIGlzc3VlIG9uIHRoZSBNLUNPTSB0aGF0IEVCRyBzdGFydHMgV0RBVCAodGhlIGRlZmF1
bHQNCj4gd2F0Y2hkb2cgb2YgdGhhdCBoYXJkd2FyZSAtIHRoYXQncyBnb29kKSBidXQgb3VyIG1l
cmdlZCBkZWZjb25maWcgb25seQ0KPiBidWlsZHMgdGhlIFdEQVQgZHJpdmVyIGFzIG1vZHVsZSwg
YW5kIHRoYXQgaXMgbm90IGF2YWlsYWJsZSBkdXJpbmcNCj4gaW5pdGlhbCBkaXNrIGVuY3J5cHRp
b24gLT4gcmVib290IGxvb3AuDQoNCkkgc2VlLCBzbyBpZiB3ZSBidWlsZCBXREFUIGRyaXZlciBh
cyBzdGF0aWNhbGx5IGxpbmtlZCB0byBrZXJuZWwsIHdpbGwgdGhhdCBmaXggd2F0Y2hkb2cgcmVi
b290IGlzc3VlID8gIA0KDQo+IFNvcnJ5IGZvciB0aGUgbGF0ZSBmaXhlcyBmb3IgYWxsIHRoZXNl
IHNpbXBsZSBwcm9ibGVtcyBidXQgb3VyIGdyb3VwDQo+IGp1c3Qgbm93IGdvdCBhIGRldmljZSBw
aHlzaWNhbGx5IHJ1bm5pbmcuDQoNCk5vIGlzc3VlcywgSSB1bmRlcnN0b29kLiANCg0KVGhhbmtz
ICYgUmVnYXJkcw0KU2hpdmFuYW5kIEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogV2VkbmVzZGF5
LCBKdW5lIDE5LCAyMDI0IDc6MjkgUE0NClRvOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8
qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lw
LmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogaGF5YXNoaSBrYXp1aGly
byjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDv
vJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPjsgZGluZXNoIGt1bWFyKO+8tO+8
s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29t
PjsgU2NoaWxsaW5nLCBCZW5qYW1pbiAoTU8gTU0gVlQpIDxzY2hpbGxpbmcuYmVuamFtaW5Ac2ll
bWVucy5jb20+OyBLYXVmbWFubiwgQmpvZXJuIChTTU8gUkkgUiZEIEYgU0VDKSA8YmpvZXJuLmth
dWZtYW5uQHNpZW1lbnMuY29tPg0KU3ViamVjdDogUmU6IE1DT00gZGV2aWNlIHRlc3Rpbmcgc3Rh
dHVzDQoNCk9uIDE5LjA2LjI0IDEyOjA2LCBTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNp
cC5jb20gd3JvdGU6DQo+IEhpIEFsbCwNCj4gDQo+IFRoaXMgaXMgdG8gaW5mb3JtIHlvdSBhbGwg
dGhhdCB0aGUgZ2VuZXJpYyB4ODYgaW1hZ2UgY3JlYXRlZCBmcm9tIA0KPiBjdXJyZW50IG1hc3Rl
ciBicmFuY2ggaXMgc3VjY2Vzc2Z1bGx5IGJvb3RlZCBvbiBNQ09NIGRldmljZS4NCj4gDQo+IFBs
ZWFzZSBmaW5kIHN1bW1hcnkgb2YgdGVzdGluZyBzbyBmYXIsICpCYXNlIGdlbmVyaWMgeDg2IGlt
YWdlOioNCj4gICAqIEJvb3Qgc3VjY2Vzc2Z1bA0KPiANCj4gKlNXVXBkYXRlICoNCj4gICAqIENv
bmZpcm1lZCwgaXQgd29ya3MgZmluZSBieSBhcHBseWluZyBzd3VwZGF0ZS4gDQo+IA0KPiAqU2Vj
dXJlIGJvb3QqDQo+ICAgKiBCdWlsZCBlcnJvciBpbiBjdXJyZW50IG1hc3RlciBicmFuY2gNCj4g
ICAgICAgbyBFUlJPUjoNCj4gICAgICAgICAvYnVpbGQvLi4vcmVwby9yZWNpcGVzLWNvcmUvaW1h
Z2VzL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiOg0KPiAgICAgICAgIFdLU19GSUxFICd4ODYt
dWVmaS1lZmlib290Z3VhcmQtc2VjdXJlYm9vdC53a3MuaW4nIG5vdCBmb3VuZA0KPiAgICAgICAg
ICAgKyBJIGZvdW5kIOKAnHg4Ni11ZWZpLWVmaWJvb3RndWFyZC1zZWN1cmVib290Lndrcy5pbuKA
nSBmaWxlIGlzDQo+ICAgICAgICAgICAgIG5vdCBwcmVzZW50IGluIHRoZSByZXBvc2l0b3J5IHNv
LCBsb2NhbGx5IGNvcGllZA0KPiAgICAgICAgICAgICDigJxxZW11LWFtZDY0LWVmaWJvb3RndWFy
ZC1zZWN1cmVib290Lndrcy5pbuKAnSBmaWxlIGNvbnRlbnRzIHRvDQo+ICAgICAgICAgICAgIOKA
nHg4Ni11ZWZpLWVmaWJvb3RndWFyZC1zZWN1cmVib290Lndrcy5pbuKAnSBhbmQgY3JlYXRlZCBp
bWFnZQ0KPiAgICAgICAgICAgICBmb3IgdGVzdGluZyBwdXJwb3NlLiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgdGhlcmUgaXMgbm8NCj4gICAgICAgICAgICAgZGlmZmVyZW5jZSBpbiBxZW11LWFt
ZDY0IGFuZCB4ODYtdWVmaSB3a3MgZmlsZXMgYXBhcnQgZnJvbQ0KPiAgICAgICAgICAgICB3YXRj
aGRvZyBzZXR0aW5ncy4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgbXkgdW5kZXJzdGFuZGluZyBpcw0K
PiAgICAgICAgICAgICBpbmNvcnJlY3QuIA0KDQpQYXRjaCBzZW50LCB0ZXN0IG9uZ29pbmcuDQoN
Cj4gICAqIEFmdGVyIGluamVjdGluZyB0aGUgc2VjdXJlIGJvb3Qga2V5cywgdGhlIGJvb3QgZmFp
bGVkIHdpdGggZm9sbG93aW5nDQo+ICAgICBlcnJvciDigJwqSW52YWxpZCBTaWduYXR1cmUgRGV0
ZWN0ZWQuIENoZWNrIFNlY3VyZSBCb290IFBvbGljeSBpbg0KPiAgICAgU2V0dXDigJ0uICpJbnZl
c3RpZ2F0aW5nIHRoaXMgaXNzdWUgaXMgaW4gcHJvZ3Jlc3MqLiAqDQo+IA0KDQpUZXN0cyBvbmdv
aW5nLCB3aWxsIGJlIGZvbGxvd2VkIGJ5IGltcHJvdmVtZW50cyBvZiBvdXIgZGVwbG95bWVudA0K
aW5zdHJ1Y3Rpb25zIChob3cgdG8gZ2V0IGEgUEsuYXV0aCBmaWxlIGZyb20gc25ha2VvaWwucGVt
KS4NCg0KV2UgYWxzbyBoYXZlIGFuIGlzc3VlIG9uIHRoZSBNLUNPTSB0aGF0IEVCRyBzdGFydHMg
V0RBVCAodGhlIGRlZmF1bHQNCndhdGNoZG9nIG9mIHRoYXQgaGFyZHdhcmUgLSB0aGF0J3MgZ29v
ZCkgYnV0IG91ciBtZXJnZWQgZGVmY29uZmlnIG9ubHkNCmJ1aWxkcyB0aGUgV0RBVCBkcml2ZXIg
YXMgbW9kdWxlLCBhbmQgdGhhdCBpcyBub3QgYXZhaWxhYmxlIGR1cmluZw0KaW5pdGlhbCBkaXNr
IGVuY3J5cHRpb24gLT4gcmVib290IGxvb3AuDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSBmaXhlcyBm
b3IgYWxsIHRoZXNlIHNpbXBsZSBwcm9ibGVtcyBidXQgb3VyIGdyb3VwDQpqdXN0IG5vdyBnb3Qg
YSBkZXZpY2UgcGh5c2ljYWxseSBydW5uaW5nLg0KDQpKYW4NCg0KLS0gDQpTaWVtZW5zIEFHLCBU
ZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=


