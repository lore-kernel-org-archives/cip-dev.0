Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8989EC021BE
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 03:42:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.55.1740541344601835852
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 19:42:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51Q3gLMv3106504; Wed, 26 Feb 2025 12:42:22 +0900
X-Iguazu-Qid: 2yAbuzQy1BPPlDXhRf
X-Iguazu-QSIG: v=2; s=0; t=1740541341; q=2yAbuzQy1BPPlDXhRf; m=Mi6xo4r7I/oqD5BGzKEQPLIfUF2NDVRKWgRUy1b2qW0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 51Q3gJrH2826927
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:42:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmLOqkeIeWZdvnkT4HVdGY7B6Kp3j/6vjhWnzvT88p+kfqKreslCe3GRQOMDRSbBQfv3Oj0XgAwv0oi4g1VDCEVBOD2ulh62Dd8Q77KEsTfkQvBHr0se4LesLNaCu890fveSE+PmdZtQ8smbTk8PEtXVwumIUL8mbe2bOEJL1221baf9COQjfXmy98ZPOQYQhQSNejsC5fRlc9WBRlmlXDC9NyIjFjQjW1i8HeVrxjuG0DUz/8tbEcO9+7Y17FVT59sF64qN2rBrAMndC8kLjd1q/uFGwkcSDI14GF1LarNMBAyl1wmaee7x2KBos+ksPpdxDGu5tWowo41MiCiRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9ZjRMBssI7eHx59wVX3LOL4KNEx7Ffo07U4R+DmtO0=;
 b=ekRk3u0+oTdHiAg6wgJH64kii2uTPIGj5DBIriihi39nYEffqiks1kF4lQCLNF04EfeS9x3YxlyFp4fVoXeM/u7QA3TNsUM9XAK4Hu3ISXwHyXMN+oJXJjUKYEbfYLgklzgKNI2lmWg9z6RHNoGfY2fbf3oOIuvtlqEM9VNdzhHCRw5AeRG0D8IghaMq3FsUyB4Sf6McUOI7hHasUyxR5Xl4Okt6pb9FV9W7RansWyeiZTF6mXquL4HpPrFIRhdGNjAUTfcFQxmrMCTix9uACZ3YvVaG5WdSVEcgus9//9XJr+yF9IF0F/IE9HKkVe7wkzLikPzadW9SVeht0kLLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core][PATCH v1 2/2] scripts/repro-tests.sh: Update
 script to check wic file reproducibility
Thread-Topic: [isar-cip-core][PATCH v1 2/2] scripts/repro-tests.sh: Update
 script to check wic file reproducibility
Thread-Index: AQHbhpmGoEiTLRQ6dEmMv4j46W/BEbNYOyaAgAC310I=
Date: Wed, 26 Feb 2025 03:42:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB966938F0C625ECE9FB7544CAC4C22@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
 <20250224090052.260495-3-Adithya.Balakumar@toshiba-tsip.com>
 <e7b3ee17-4f04-478d-9631-ba8c05a019f2@siemens.com>
In-Reply-To: <e7b3ee17-4f04-478d-9631-ba8c05a019f2@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS3PR01MB6902:EE_
x-ms-office365-filtering-correlation-id: d3390ac7-48f4-486f-9f73-08dd5617917b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UDFhbncwcjZKZGpHWnpFR1dISTJiU1UxWG9zUDVTZHMyZUd5WlhjUWVk?=
 =?iso-2022-jp?B?M1dVZ2gvY3VMbi82UkVxdkpNdjJVeDBtMG56Yml2ZzEvM3FNWk5wQXFL?=
 =?iso-2022-jp?B?MmlWWVpFeWJSMVVKMHdQM1hmNTRKNHI3K3pnWkF0ZkhRc0xxVVlGR1px?=
 =?iso-2022-jp?B?b0d5Y2hFa3lpUjB1TjNRbGVLTTJIcXIvZjMxdTVWa3R2WEpDT1phSmda?=
 =?iso-2022-jp?B?K1lYakkySUFlMWRXUFhvLy9aTklmU1VyY3VIanRCNFJsU0FETG85d0NO?=
 =?iso-2022-jp?B?TDIxUE02M1Qrelp2akgxaXQ5amh1TnNqRkFxeDh0NWI4NHV4UWdFSnlV?=
 =?iso-2022-jp?B?NGNoQVpFanB0VGZhUExyeWdkZ1lZWkp3NVppaXhTS2Z0eiswSE9MNit6?=
 =?iso-2022-jp?B?ZDQ0VUJOREtlU2hFQy83T0hxVEVmWUZjUUhXMTBjTGlSdm50WlQzSU91?=
 =?iso-2022-jp?B?RHBNbTQwQ3haR3JpNms0amVMeDhZWmlGTk5hU0lTa0FMTkg4SjVWQTlC?=
 =?iso-2022-jp?B?UytUb2NXNFpWbk9xWVNzYlJsMFRJU0liQ254RHdKQWMra1FzcFN0bklu?=
 =?iso-2022-jp?B?QU44anp4R1NOZk0xTzNoRlBWbDB0R1dJY09wVUV0OVFDS0ZkOWJKYzBk?=
 =?iso-2022-jp?B?cm53UFFuSDVOL2puczlpTEovQ3hsV0ExK002YW0vVEdQTHhBOGt4eWI4?=
 =?iso-2022-jp?B?OTk3N3RkWkJ3cGJQYkJibXUvejhmS21McnFMalVXQnZyd1J4NHpLZDRI?=
 =?iso-2022-jp?B?cWI3ODZZRmtnN090aHFCT1hXKzBEQ2FqajZEWHZVQ0FzT2QxNERoZGFD?=
 =?iso-2022-jp?B?a25sZUZ2U3RUVUxrcDZxU3IrditBY0M5WGxRd3NXZnFycGxnUUpTU29S?=
 =?iso-2022-jp?B?Q21ETittdmZydytYSThVZGd5Y0JVOWllbzJZb3F0NUhDaXVLWFJuN1Iz?=
 =?iso-2022-jp?B?Wkl1Sjd4ZUJsVlNYTlpxaUFLMXpYUlZ2TU11RnZOaUQ0UXZYWjMzc2pF?=
 =?iso-2022-jp?B?Zys2Z3JnMjNudVlRVS8xV211TTZrNHV1N3FRaFNBUHYzOUZ0QlNyMEgx?=
 =?iso-2022-jp?B?K2Z4SnlwTEttYkxvcDY1WWVyelkyUUx4ZHcvaDYveHNWVE5GeXo1R0JT?=
 =?iso-2022-jp?B?LzlIckY5TG1JZU50YXpTSUEwbkpzaVA5ZHJ0a25WZlNPem1obE53ZWpT?=
 =?iso-2022-jp?B?RTNlLytUNnMzN2kyVHNHcDlOYnFSdGdMeHVjaHd6djh6ZjhDWDJzQ3hq?=
 =?iso-2022-jp?B?MHdlYkNMaE4xSjNiNFF3ekkvT1ZHSHZVcFYrcW9GUlB5dHlZSGVFN1kv?=
 =?iso-2022-jp?B?THlCeVdYaFdySjdLNVZ5TlFtdisxTDlyRkJESHFqMElaazV4VEdDaWxT?=
 =?iso-2022-jp?B?TVZKcHBaUGVYempTNVB3RndnbVJWUnFBWXNaSFBsc09kRzhlckh4bHgr?=
 =?iso-2022-jp?B?S0JHS0M2YkJSS0lUeENSU056NnA3ZDdjQ0lTT1Q3TEZYd1oxczlvRzBu?=
 =?iso-2022-jp?B?L0Ryb3htTGhhQlNvZXEzZnBoeXJLQVM1ZFgyclVCN1RyNWFVTm84Z0Ju?=
 =?iso-2022-jp?B?NU1SRHQzNkJsL2E5eVRXZkpQOU9lakFlVjY4VzZ6UmQ1VG9vOEN2L1Az?=
 =?iso-2022-jp?B?RktXOENkN1dFaDBrM3AzSitOT0VhdEQ5UXhic2ZQMUdKeUQzdFp6aDBy?=
 =?iso-2022-jp?B?Z2Y1OVc4Y0kyZ0dBZ2pWQllnWk9Zb1FTNW0yeVdYR0d5MTJ1MHZ5d0ty?=
 =?iso-2022-jp?B?VFBJc1hKMUZ3L3FaMVQ3em9FM2pMSFVPT0hBcER3cmpLaXdyQU41cGhU?=
 =?iso-2022-jp?B?QmNFRW04VjdqaldTd3l5VStJb1VzdUllbnVYNXJQa3R1UEJLT1ovNDZB?=
 =?iso-2022-jp?B?d3hudzlKNytobGY4cW5OUkpNVTZ3N3FRaVlOUWlETEZ0SC9vS2RxTjVF?=
 =?iso-2022-jp?B?TjlJQnFTSXY4K2RlQzhmVmRYaENLSEVyNlNzMnRSQTFXLytZT01WNHEz?=
 =?iso-2022-jp?B?aWhpaXd6MndjcDBmR1ozWlBkOS9aOUJTcXBkclRUdmJyWk8wNURSSEtw?=
 =?iso-2022-jp?B?TVNFOWtqc0RQUXozUDBJODRPZFVNUDhyWnIzZ1JXZmJlaDRPZm9TRzNv?=
 =?iso-2022-jp?B?ejQ=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cmMvc0JNMmVoc09HZ1M4aHFqNFBIZVYrMDVKdWJGUEQwVHcwS2NFRGtY?=
 =?iso-2022-jp?B?TWZGU21VZzN1Ky9FTXFTR2oxQTB5RDEvd05XUVlZYXYvd2NxVHV0eDFq?=
 =?iso-2022-jp?B?Mzk5UGdJa3pzTlAvTGtOOG1kSXQ4Y3R6dTBsYmcydWMzcTd0ZTNMVTFw?=
 =?iso-2022-jp?B?a2M0QUhBVEtpQW9kbGlIWTU1NTcwbFozZURiTXBaN1lyTmlEZDllT2FK?=
 =?iso-2022-jp?B?Y0QzT0ZJTDdkZmpYandBZy9RazdSU0p1TFh0TnBZaFd5aGFXbWVYVWEz?=
 =?iso-2022-jp?B?K2ZpRnRjTWxVK1RROXpSejRtbUNySWJrdFNSODdvb3E4VEtLWG95MGpm?=
 =?iso-2022-jp?B?T09UTzdhck1KdXhWTzVXTFgzV2kwUllsS0MrdFlTZlRBSVU5Y28yWXpT?=
 =?iso-2022-jp?B?SFlBTVF3UHhQUll2RjdTeHptSnlVaDl1aVF5enhxR1NpSThFeXozUktU?=
 =?iso-2022-jp?B?ZjZPTXJwaGNNazJ6azJKdG5NZVRuMkt4M3kwQ2JZQjZYYlI2YlMrd0RM?=
 =?iso-2022-jp?B?RWU1YTVvSlYySDNSVm1pU2Q3Rlk4UmhKbHJLZmUrVEN6UzlrdkJISm9F?=
 =?iso-2022-jp?B?RTJSd3l1RmNMdURvRFVEUjQvSC9zMTh6V2FDaWplZW9uNjhJWjNKYmp2?=
 =?iso-2022-jp?B?aXRlTDhpbVl5ZVdrbFZwdnpvZzFDOFpneUgxZGh6blR6Z2N1clBoUXI3?=
 =?iso-2022-jp?B?SHBqaCswbzZ5SkJJM09aR2x5M09INzREVlFKT1N0eUlDNjlpUGx2Lzk3?=
 =?iso-2022-jp?B?cTcxQm4xMXM2UlV1SWV6bExHTGcvcERzVUFMYkdQY2JlQ1JLVFgvOTRq?=
 =?iso-2022-jp?B?cHJjcG9uTjVUM0JNVEdpYXlXaEhiTk1iZk5sdlV4T0tSQ280bzZmazMz?=
 =?iso-2022-jp?B?UFZqTTJyWlF0NGYxWVEvaGptK2pNdnBsZXBsRFNtc1dZVjBSaDBjNGd1?=
 =?iso-2022-jp?B?OHY3NzNtdmZuNlZ0NmNtYnlNclp1aDV6Vm8zaGtlNzgxQks5WWhvS3d0?=
 =?iso-2022-jp?B?OGV3ckdmT1ROSytURFE1cndOZVNIekp5dnlRRXo5eVZpbXVBcThVeWdC?=
 =?iso-2022-jp?B?WjlPdXF6bGFpVjFZUTBUYlVuUVJ3TVBRTlBhM0U5bFNpa09LaFBBNXVV?=
 =?iso-2022-jp?B?SG02R3dJVDJSaDNFcE5kY3dGY3JsQmthYkRqc2JwY0ZNcXBzQjhsMVhs?=
 =?iso-2022-jp?B?OEx3UnpDaGdab05HMUpMdnpmbGhCVWJJWHNwTEZFZkZSTHF3UituRTQz?=
 =?iso-2022-jp?B?L0hicXdaOUFBWXJHUWIzaGNXTW9Cc2xMK3c4N0cwSU5UemlmQm1VQ29z?=
 =?iso-2022-jp?B?bjcwdHNNS3p3cW9adHV6a20wNm5YVkxLVHhGNWhyZjBGSVYzc3VudXJk?=
 =?iso-2022-jp?B?Nnp3dWIzTjk5bUJQeFhSZ2xIcGFhUWFWR09DWkJ5Qmp5b0owTXdXUVQw?=
 =?iso-2022-jp?B?SzIxQUt4cVpPRC85TUZ0UFk5Rjl1WlVqQ285UEZ5SmMzbEVFY0FoU04z?=
 =?iso-2022-jp?B?N2lWU2xxS0wxQldTVGlRcGpqdWlHNzNTZExsbEhmV2hReHpqMlVtZ2ZS?=
 =?iso-2022-jp?B?ZTNwQU9pVlYwMURHRDZ2WDU4c3k4dVl6TEw1UG42bkZpNXZXWWJGWVho?=
 =?iso-2022-jp?B?N3dybU5Sc3VBV1lrNWV0L0JKUUtTRjBlbGlBTi8wa3hSZHhJWHRlZSsy?=
 =?iso-2022-jp?B?cGxUdXhhWDlrQk9WRWZiTFBnSGxlNUtGUU9WZ0VDY0psaGJDUU5jenUw?=
 =?iso-2022-jp?B?dE56ZXF3cVV0dVhBWCtwaG8rOWhFc1Urbkl3WG51MXZrRlZyYklBQ1Yv?=
 =?iso-2022-jp?B?T2YrM0srS3NjR3NoQXBmbG9uR3hEby9zWkkwTjVDUDRsZzJLKzRBMDVt?=
 =?iso-2022-jp?B?K1hjS2dFZ2VQazI5dmdwdG9JOWNwWDEvWEhaMGszWGNVaVBhUkhhejR2?=
 =?iso-2022-jp?B?VkRzQ0orM2VMNjlvbTNKUzRNMWM3OXpkN013R0cyN0pUTlJIL0pRMy9Q?=
 =?iso-2022-jp?B?dnhxRmhhY3lJUk9XaGZBd0NTUXhNc1R4ZW8vdzArdGhrNWJBczZna2Iz?=
 =?iso-2022-jp?B?T1ZQQjI4Wkt0Rkk1NnZuMUpsUkFwQ2xvbzhHRUJUN1RPR0c3WXZaNGhE?=
 =?iso-2022-jp?B?SityV1BISjdsc1c1VU1rVTlSMFBmWWgyTVgwUkxaNE1RNUVXU25jMUNV?=
 =?iso-2022-jp?B?WHBMV0VPRUFpQlB3eGh4UGJWeUxqT2tBNHdSWFRJTlROZVZtN0hNcEcy?=
 =?iso-2022-jp?B?alNQNHRiS0tmV0VCL2JFd1Z5RTdTSzlYQjBsVURXeWZidUlvcEE5azlC?=
 =?iso-2022-jp?B?VmpZa2tDTzJCaHczbER5SUxPZitJNjJpWnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3390ac7-48f4-486f-9f73-08dd5617917b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 03:42:18.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdIw5jFI+ErR1apeXH3NwGKfhmXhDvEx6Rlf2J/uwrWYmSACOscl00bskGG+/lbsupFwONmENl20k02LcbXNcETDjhv3hVqNw03dhJMpXbGJtG4SvwZjYOx8Y5tr9Go0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6902
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 03:42:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17911

Hi,=0A=
=0A=
>There are also some more warnings (info/style), but those aren't new.=0A=
>Still, bonus for addressing them in round 2 as well ;)=0A=
=0A=
Will address them in v2.=0A=
=0A=
Thanks,=0A=
Adithya Balakumar=


