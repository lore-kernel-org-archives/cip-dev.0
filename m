Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9750BCA0ED1
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 09:24:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.18543.1755163440001453277
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 02:24:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 57E9NuJc727738; Thu, 14 Aug 2025 18:23:57 +0900
X-Iguazu-Qid: 2rWhyCKR9oXXQz94KG
X-Iguazu-QSIG: v=2; s=0; t=1755163436; q=2rWhyCKR9oXXQz94KG; m=Og44h7/osQ7yUQwEDHYmOgkQf0uFyxwGPl8/igpaQ0I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 57E9NsTv2286531
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 18:23:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DETMmqSkGyvBrJQDj6TRzVeK7Yxm29QfGGjLuMaT6Xwp5EoaRyn+mEY36qTYGEG2dOpk4ylxe4cDvarTcnWS3p4hy+XSJ4xQAA1uPZOLMXz0elpL1phRcJuVIirHd0p0vb1p+22rxGp+7X8prXgD8kL3swxQdQ6M+LeSmXeErdheR9jTc2PBAA2pe3Ge2moJ92OxRxxZWkEogGrIk+yF4AUnPdoVggmfy9hjUCmTyNu+cWVOTiks+WolYDjyUV9E1U7B83qf73RT/0TCC+vvUgSLi5x35TjM72TUjIbLwo7w6k384Yy7lEbo6pjBfa/n7UCkUoeNpi3JYxGhPl4OGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DP1Qu3A4wIrlFqUCcjA0XWU7/x2W8mzw//coskr2lA=;
 b=CxoM3vtFcSYgooo1tYhFAX0SWbuXQaTFZtyVyynCy60BunlnUNTT820ZdwNMJYGGDnWCCl9W31C7Gl7FOkjbKiy/vBJz0erLzT1rIz30vpqaDMaP/eN5aH4KZhVO7MkyBJbbQNc56qwHN22KnZ035Zzudzyl70x83JDJA+HeDENTwGHOc0FYTj881O9905w1SvU1QLqXIcdVktLb+CITWzzSbFS8ItBBoVjk1LaqhpCeNubf1qC6ROlkbLiunjbzoCema8PmySZ4EQBcp/FI4DvwcsbG3rhNAvsNPkyglkms/mZyzIXK0yQ20rk/ENirq9uDGOeSfQZvo1s8zRj4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <Adithya.Balakumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: File server for zchunk swupdate update
Thread-Topic: File server for zchunk swupdate update
Thread-Index: AduXPMDwGbkQ98swTHSVcGfABwDcxwFaGtzQGPn4QcAAJoF0YALvsnIA
Date: Thu, 14 Aug 2025 09:23:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075E3A4AF38A22C09B97577C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB11075908DA987ADCDE33DD899C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <OS3PR01MB58966EB75B7DC1FEB3851792B7A42@OS3PR01MB5896.jpnprd01.prod.outlook.com>
 <TY3PR01MB1107501396B71E71A49B7A7C8C725A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TYYPR01MB15132EEA4A10F3951E90237E4B724A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB15132EEA4A10F3951E90237E4B724A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS3PR01MB6119:EE_
x-ms-office365-filtering-correlation-id: 3382602a-97ac-4226-fa01-08dddb144901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TEo3WXlSMU5FMjVseUtFQ3U4MGQrU2pWcng3SG9HUm11Y0dXcGVqZUxI?=
 =?iso-2022-jp?B?YUk2TTVXMnJKYjQwWEZndlhVODhid1VxRllBWTVvTmdNWnlyc1hkNDJz?=
 =?iso-2022-jp?B?S01xK2phTmdPV0g4WWlFQmxCbWZBUVhRL3hwZnV4NklML3kzUm81Ync1?=
 =?iso-2022-jp?B?ZjFhNm9VQWhWbUM5eXJEbTJWZW1JNGFnWmdpZXh4TmExaldQSUJHVktO?=
 =?iso-2022-jp?B?bStpd3poRTQ5NzFKMmtrbFZ1cHJ6aDNNVDVHVUloUXVVVFBVb1RNSTUy?=
 =?iso-2022-jp?B?Y1JHVWZEWkZ1ejdpNm02cjU3QjN5R0tPSUdGN1RKUzNYb2h3djh5RVZM?=
 =?iso-2022-jp?B?SXRMUG9mcW83Q0NsdnNuKzByV3AvRHNMdVNvUGhLaWFwb2ZrNWU5MUVr?=
 =?iso-2022-jp?B?MXFraWlQMkpVTVpCSmt1Z25lUHZMdlAxSGgvMEZSZ1NoVVJZV2hiMjU0?=
 =?iso-2022-jp?B?bUd1b1NDbjJoRVJBMDk4enJJS0F6VlkvVFQzNmxldVZPekZIOUZobjFX?=
 =?iso-2022-jp?B?b2wzRGR5NFZObmQ1TGczNWxxS05GcUlmNDhraWtEaDRkbDRJRDB2V3dR?=
 =?iso-2022-jp?B?WTh3RXlNaitQOWZNMTkwMlYxV3BmR0p3dXRQc3VkdlNuMi9LNHVwQVZK?=
 =?iso-2022-jp?B?NTdNaFJxTHBObDB4aXpTYzlNQXFLcTA2TXh1NHBqZjhKaityVUVrVjdR?=
 =?iso-2022-jp?B?NjRLZTREY3NlaXorUUNHSDRvTUxUNHBWOEhodnduVzdjcTQ2Rmt4cTFP?=
 =?iso-2022-jp?B?UWU0REZNNTNWaytqRHNCUDZ6dVZZa0tOakVXZGhTbW9YVjV3UFhvNktZ?=
 =?iso-2022-jp?B?czZiS3JWWGJERnNQc0g3VVJBajE2ZFJGeGsvd0NiRTR1L2QxeG1ZYXhu?=
 =?iso-2022-jp?B?NEs5THZnVGg1VTBKY0ZmMFRlaXN5REkyQ2FTZ294ak1KRmcxWWtUWkNk?=
 =?iso-2022-jp?B?c2wxbXdLQ2xSY3Rub1p2N3FUNzRENVV3cytNTnpzV2xUdUxsdERodzRt?=
 =?iso-2022-jp?B?RWZwUTlDcmlhaHpIOC95MGtDVmZlUC80alhZRGVnMENXblBsMGU0Tzd5?=
 =?iso-2022-jp?B?S28yUkZ6WllEM1R0bEMxUHB1VmlydCtMbmk1UXk2UVFScnJVTkNWQnlk?=
 =?iso-2022-jp?B?N21ncGVGdC9sU2svRnlXeHZQcTY3UTBVeVAxMUJ1MmM0aW9HTHhvTDdL?=
 =?iso-2022-jp?B?d05FSzVsSDlqSm5DSFZQSm5xWUlrcHBxdE1BcVF6UWxJYVR0L0lCM1Q3?=
 =?iso-2022-jp?B?ZXpaT0Zrdkx4ZEludEZSWkV2VEdFYTl0UHpBQlNjQU9ZcThVY2t4aVFP?=
 =?iso-2022-jp?B?TzVWZkQ4SzVMd1hZWElWczNOa2xKdHZmTXNiVlhrSXZkc2QyaE8xQ3Fp?=
 =?iso-2022-jp?B?M1U0T3lzckREWHJSY1RoK3BpTU4rbDB5KzQ0UWZzM3ludkFuK215dEdH?=
 =?iso-2022-jp?B?K2s0VU5NMHhHYnBUcS9IV0pBdkV6TUdwMkVoUEh3bTF1RGVsYi9GdFB6?=
 =?iso-2022-jp?B?T1V3ZUZSY3lyUER5TUx4SDlEWkc3QXYyalo5b1cvdyt5Rit2OTZ5MGFr?=
 =?iso-2022-jp?B?VjNmVUJ6ZnVmcGwxS0VSdUZmTk01QVg1emhIVFY2Q1EwUmR6ZjRpdUVi?=
 =?iso-2022-jp?B?T2VwM3F5V1J1UkR2bjExa200NDJERS9TVTR5eXFaa3ZWR2ZXQ21hSkxj?=
 =?iso-2022-jp?B?ZjE1ZHZBVG96Y3QwbWRNUlBVUzBub3JJdGhtOGc3ZjJKdFlwako4Nzdk?=
 =?iso-2022-jp?B?UGR0UUdmZ1Y5NlBmUjJqa0JZcGhReVpRU3ZlbGZqNWptNlhNVlZ0Z1M0?=
 =?iso-2022-jp?B?NTJscHdWNWJ4Z211R3BUNzNaS3kxbHdyUTUvWE9lblozakc3a1FYSGpL?=
 =?iso-2022-jp?B?a3A1cGxOVWx2U1UxRUVWTHlyMm42SXAveDFaS2dWOHZzRnZubmRqU3Yr?=
 =?iso-2022-jp?B?dGJGSWdtdlNyRklINlhtdzVndDV5eFMzVG1YYjJ1VDFld1Y0Z0xiZnNP?=
 =?iso-2022-jp?B?Z1BlZ1BENXM4dUw0OXFYbGovSUZNaTRyc2xJZWcrWmxyY3kzaElUUko2?=
 =?iso-2022-jp?B?QmNBelczYmhhbW5lU3FkTy93T291WW89?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cTU0WkNCaEx2QjdZMkNaVlgwN1V5R1czMTlhRzc5czVZaVpDVC9QQWJS?=
 =?iso-2022-jp?B?MVB0UGVHcEQ2NWJOTU5QaHF3MkNWRGs2dkxSbytWeHJ5dFNDbU1oQVdo?=
 =?iso-2022-jp?B?Vm9DUDF1QUFDaTNHLzRvRjMrRjh3eEpLaWx1Vm1YTmZJMTJ3d3E0TWZ5?=
 =?iso-2022-jp?B?ek01RXdRbU5tVjRrdzJxcDBFK2VtYUtGcGovVWJ1VkJGaHdWc0dVMWFq?=
 =?iso-2022-jp?B?ejhxWnEvYnk0YUp4K1NTcmloYzVEOW1wQ2tNMFNMZXU3T2hFUGd2cEF3?=
 =?iso-2022-jp?B?KzY5QVFJdHhqYWtSb2w4OEI2M2FURGRibUNhUGUyWjkrTUxWZVZyVDhP?=
 =?iso-2022-jp?B?c3o5OWw1Y3dqT0Y5TnhncDUyY05NbG9ueVF4R3dqRDJibWE1SGxOTS9I?=
 =?iso-2022-jp?B?TktSSkFMNTJ6c25rYkZYNzlaNm5POHdGR1A4enFCUHlJOWxmTjQyWEFR?=
 =?iso-2022-jp?B?eEVUUjErb1dmckJoK3hlTGs3S2VtcnB5SU9rSFlkbzNpSTFnc2NTMnJt?=
 =?iso-2022-jp?B?UWZ4NEg2MU5vZ1IwbTEzN3N5K0ZyK25ETFVNMGJoOG1OUlY2ZENnMEp1?=
 =?iso-2022-jp?B?RjBuZXZ3TENDRTc4eWJ0bWlyajNWd2VSM05qa1VESzFlbTZzbFYzNGxr?=
 =?iso-2022-jp?B?dUtBV05xTTVtb3dDazhLUEczc2xRZlNTRGpTZWRKNU1rSTVzeHd5eHpM?=
 =?iso-2022-jp?B?U1B5YnEwcTJSbmljWGZhaEZmUjFxTFZIcy9JTythN3FUOTJ6MnE2K3pv?=
 =?iso-2022-jp?B?b0xPUlRzTXJjYjBTc0J3KzVjYlVibHplVkFibDVyZnFlaEdhMWJ5R05p?=
 =?iso-2022-jp?B?ODgydzdNUlNzSkpUWTJEMVBpOGxZajArYStQVnNzaUZVRUNDVXhOY0xK?=
 =?iso-2022-jp?B?SVVMRnBmWURwbTZlbEVodGNyYUhJUUFUdENJc0w5OTAxYUhCTVRBajlz?=
 =?iso-2022-jp?B?Vlp4S0tKT0JHZWJZY0wvdGE5ajJMaU5ZZjlqWUxDQ3hUSmdRY2JtbDd2?=
 =?iso-2022-jp?B?dWo1K3dlcE5iQXUwRTZoMWZETnQ0VXZWaU1kUDFmL2g5Y2twcGRrcXRF?=
 =?iso-2022-jp?B?RDRkdXExUk02c29Fa2RYOVlFUG5EWjVrMjc3Uk1NcnhxOWlHSVBwSENm?=
 =?iso-2022-jp?B?UWRvNHZBWXVrOTlWWnBEZ0hobUs4QXVHU0FHTjduUFBDaS9TcTY2d3dh?=
 =?iso-2022-jp?B?ZCtMbHZQSkF4Qk9zRG9iZnlRT0JrclBMcEd4cWd4VUt1aVI0K2ZldkNa?=
 =?iso-2022-jp?B?TmhId2lBbW03aVVETFJtZVRydXFTRi8ySVI4QTlubUJFOFBmSUhsQ1BY?=
 =?iso-2022-jp?B?RWN6eS9hdmNJUzJaV29EVkJTWUZIN3psUU02OGxqSUN3QzVjRXZOOUR1?=
 =?iso-2022-jp?B?T3VZMVhlTTM3elF5aDZpWGpHVGZHOW4xYXNYSkFPMWsrQnhJNkRBdm9u?=
 =?iso-2022-jp?B?SXptYnpmUG5Pdnd1TzFoZExvT1R6QXR2d3F6YWFzc09LTGJtbS9iazlD?=
 =?iso-2022-jp?B?SnNmQjY2a1JNeVN5NHJEVDJsLzFsUHdoMWtJMzg2SS9EUkFxVmJjWGUx?=
 =?iso-2022-jp?B?UG1lYnFoNDZIc05NL3U3QkVuaFBLSnY0TndKQ0NuMHlDVjdWems1RzQw?=
 =?iso-2022-jp?B?cGhscmUzNkYxcmFrdXRrTkZsTlk0RGpDekUxTTlscHg4K3pTT0pYWGw0?=
 =?iso-2022-jp?B?cjRTZEVkS0Jpc3RrRENlbi9YMDFwSzJLVUlZUS9GOW5HMjZPMXhPamFn?=
 =?iso-2022-jp?B?OGJpNlFMSWs3c3lQUTkrQ0xLdXZoRDkxOGc1eXVzOEhuSWZtMzRIN2hq?=
 =?iso-2022-jp?B?b0lCcVpUN2IxT1Fwb2YxdW9oS3NTRFF6cElNL3ZsU25iQ09DMFRUbUNU?=
 =?iso-2022-jp?B?SFlOV1dISWRFSFk0TVdZa2VsQUJrL2QyUmI5MFUxVFdhc0NQOGFuUHNz?=
 =?iso-2022-jp?B?YXFZcGVQMmR2WEpwbXVZdEVPZ1p0M2pGaHlWVllockRqQmYrNFMvSzZT?=
 =?iso-2022-jp?B?V1JlbGJWS2grc3hZeGFzWlRaQjk2ZEtycklmUnA5K3ZiaDB6RTlDd29w?=
 =?iso-2022-jp?B?KzFBaE1WQTRGZnhubWZhaUk0VUhzeGNDeUxBdWZRL3JWUFF0SWdyVUlB?=
 =?iso-2022-jp?B?SVMyTUluaVRJTWxNUkIxbDFsZTljeHVFcFpWWW8xa282VjVYaWdSczBG?=
 =?iso-2022-jp?B?TEUzSkRUQmphN1Q1Vk1QUzBmN0lRQWp3bi9MTmlRY2tJdWhQeXY5eDE3?=
 =?iso-2022-jp?B?UDAwTUM1VFdaWTRsd0wvdXJLUm13V3EzUVQ2TVhmM0FCUWlwbFFoRU9N?=
 =?iso-2022-jp?B?R1dIZzI4U1hIdXczZGN2V1FtaXdhSEVvQThDZld3RFJYZzJjUEh3Nm5O?=
 =?iso-2022-jp?B?aDlSZW89?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3382602a-97ac-4226-fa01-08dddb144901
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 09:23:52.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgAkG8X/T2Wwf7j41p14dbiYU72ureUHYV4IFBXJpgMkLIaprKRPPHoLQCRc+YomnonEi/4oUr2n7H6kPA/vRWYRLa3Sf8yUW4homcSlbyKQ/TgUiFzRDzhxTnDr2qxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6119
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 09:24:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19739

Hello Chris,=20

Apologies for the delay in my reply.=20

>> So, Is there any possibility to use LAVA master server as a file=20
>> server for zchunk updates? Is it also running in AWS?

> Yes the LAVA master server is running in an AWS EC2 instance.

Okay. Thanks for the information.=20

>> Basically, we can configure either nginx or apache2  server in this PC=20
>> and use it for zchunk updates.

>Yes this could work. I assume the CPU load is small.

Yes, load will be very minimal.=20

>Although any of CIP's EC2 instances could be used - it wouldn't save any d=
ownload times if it was the LAVA master because it's the LAVA labs that do =
the downloading and they are spread worldwide.

Yeah that's right.=20

>You'd have to open a support ticket with LF IT to get it sorted as we (CIP=
) don't have admin access.

I see, thanks.=20

>Assuming that GitLab CI is driving your testing, this would have to be don=
e here.
>1) Upload .zck file to fileserver
>2) Embed the relevant download URL in LAVA job template
>3) Submit LAVA job

Yes, it will be via Gitlab CI.=20

>You'd have to implement a mechanism to support multiple different versions=
 of the .zck files on a per-LAVA job basis so that the file you need to tes=
t isn't overwritten by another.

That=1B$B!G=1B(Bs correct. It also depends on how we implement in CI.=20
In order to reduce the cost, we can make the zchunk jobs in CI to run weekl=
y or daily once so in this case we don't need to maintain multiple copies a=
t EC2 instance. =20

If we choose any existing EC2 instance, we just need a storage space around=
 600-700MB (.zck files of amd64, arm64 and armhf) in EC2 instance.=20
So every time we can overwrite the same files. we don't need any additional=
 storage for this, we can use the same storage associated with the existing=
 EC2 instance itself.=20

As we need to upload/download the files every time, we might need to consid=
er the data transfer cost for the EC2 instance.
when I checked some details about data transfer for EC2, it seems the inbou=
nd traffic is free and there is a cost for outbound traffics.=20
In zchunk case, SWUpdate running in actual image requests only the missing =
chunks from the file server (EC2 instance) so in my understanding the outbo=
und traffic is also very minimal. =20
This way it is cost effective to use the existing EC2 instance. I will disc=
uss these points in the CIP core meeting and decide which EC2 instance to u=
se for it.            =20

Thanks & Regards
Shivanand K

-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com>=20
Sent: 30 July 2025 13:31
To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#=
T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; jan.kiszka@siemens.com; balakuma=
r adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O#S#T=1B(B) <=
Adithya.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
Subject: RE: File server for zchunk swupdate update

Hello Shivanand,

> From: Shivanand.Kunijadar@toshiba-tsip.com=20
> <Shivanand.Kunijadar@toshiba- tsip.com>
> Sent: 29 July 2025 14:46
>=20
> Hello Chris,
>=20
>=20
>=20
> Hope you are doing well.
>=20
>=20
>=20
> *	I think the CIP core group just did something similar for a WFX
> service?
> *	You could go down the same route for zchunk. Either by using the
> same server or in setting up a new one.
>=20
>=20
>=20
> In CIP core/SWUpdate regular meetings, we are discussing alternate=20
> options for hosting a file server for zchunk based updates.
>=20
> In case of new EC2 instance we should also consider the cost of the=20
> instance.
>=20
>=20
>=20
> So, Is there any possibility to use LAVA master server as a file=20
> server for zchunk updates? Is it also running in AWS?

Yes the LAVA master server is running in an AWS EC2 instance.

>=20
>=20
>=20
> Basically, we can configure either nginx or apache2  server in this PC=20
> and use it for zchunk updates.

Yes this could work. I assume the CPU load is small.
Although any of CIP's EC2 instances could be used - it wouldn't save any do=
wnload times if it was the LAVA master because it's the LAVA labs that do t=
he downloading and they are spread worldwide.
You'd have to open a support ticket with LF IT to get it sorted as we (CIP)=
 don't have admin access.

>=20
> However, we need to check how to upload .zck file every time to LAVA=20
> master server pc before the running the tests and also LAVA jobs=20
> should access this file.

Assuming that GitLab CI is driving your testing, this would have to be done=
 here.
1) Upload .zck file to fileserver
2) Embed the relevant download URL in LAVA job template
3) Submit LAVA job

You'd have to implement a mechanism to support multiple different versions =
of the .zck files on a per-LAVA job basis so that the file you need to test=
 isn't overwritten by another.

Kind regards, Chris

>=20
>=20
>=20
> It is just an idea so I=1B$B!G=1B(Bm not sure whether it works. What do y=
ou=20
> think? Is it possible?
>=20
>=20
>=20
> Thanks & Regards
>=20
> Shivanand K
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: 24 March 2025 15:46
> To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST)=20
> <Shivanand.Kunijadar@toshiba-tsip.com>
> Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-t=
sip.com>;=20
> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I=
#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>; jan.kiszka@siemens.com; balakumar
> adithya(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Adithya.Balakumar@toshiba-tsip.=
com>;
> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsip.=
com>; cip-=20
> dev@lists.cip-project.org
> Subject: RE: File server for zchunk swupdate update
>=20
>=20
>=20
> Hello Shivanand,
>=20
>=20
>=20
> I think the CIP core group just did something similar for a WFX service?
>=20
> You could go down the same route for zchunk. Either by using the same=20
> server or in setting up a new one.
>=20
>=20
>=20
> Either way the only people with admin access to install things are the=20
> LF admins.
>=20
> You can create a ticket with them through the LF helpdesk:
> https://jira.linuxfoundation.org/plugins/servlet/desk
>=20
>=20
>=20
> Kind regards, Chris
>=20
>=20
>=20
> From: Shivanand.Kunijadar@toshiba-tsip.com
> <mailto:Shivanand.Kunijadar@toshiba-tsip.com>
> <Shivanand.Kunijadar@toshiba-tsip.com=20
> <mailto:Shivanand.Kunijadar@toshiba-
> tsip.com> >
> Sent: 17 March 2025 13:57
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> ;=20
> kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> ; jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com> ; Adithya.Balakumar@toshiba-tsip.com=20
> <mailto:Adithya.Balakumar@toshiba-
> tsip.com> ; Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba- tsip.com> ;=20
> cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip- project.org>
> Subject: File server for zchunk swupdate update
>=20
>=20
>=20
> Hi Chris,
>=20
>=20
>=20
> This is regarding the zchunk based swupdate verification on LAVA lab.
>=20
>=20
>=20
> The zchunk based update needs a file server where we keep .zck file=20
> and swupdate requests multiple byte ranges based on the requirement.
>=20
> In manual test scenario, this has been verified by keeping the file in=20
> Apache / nginx file server.
>=20
>=20
>=20
> In LAVA lab, I also verified zchunk update by installing Apache /=20
> nginx in CIP image itself.
>=20
> In the last CIP core meeting, we discussed to use some container to=20
> host the file server (Apache or nginx) for this purpose instead of=20
> installing in the CIP image by considering the package size and maintenan=
ce.
>=20
>=20
>=20
> Do you know any EC2 instance where we can run docker container with=20
> nginx/Apache for this and should be accessible to LAVA lab?
>=20
> Or do you have any other ideas/place apart from EC2 instance for=20
> running container?
>=20
>=20
>=20
> Please provide your opinion.
>=20
>=20
>=20
> Thanks & Regards
>=20
> Shivanand K


