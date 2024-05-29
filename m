Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA20C25B78
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 03:05:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.4939.1716951930009527972
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 20:05:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 44T35JRk2015601; Wed, 29 May 2024 12:05:19 +0900
X-Iguazu-Qid: 2rWhNMNecsLQCVHEKF
X-Iguazu-QSIG: v=2; s=0; t=1716951918; q=2rWhNMNecsLQCVHEKF; m=A9/iUn06sxvl+STgrWafwpEabEJ5AiTQAqnEAwfVxMI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 44T35GME472876
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 12:05:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1pW33oSNhVN0hQKjbVZqVEr7Bg0BVZvI4i5S4VkBHD0kyxwnIiPOiKqyelhD/pjjfXJd4bxuJZGi9zn3vREQgE/8HnrTYPvs9DBl0qas8zoaOcAI95Fb5yGLFP1LR+hW5aCqVsoTxbZxj0wrBx0N7HcKRXRyaQGSKX5QUgMKH6uYl1JDp5xlZm88xeCGgqiGrr+RJVp13YKMAvk7kJmWalMsTAYqRgMcdjfwszXXC5rmyIkixQHdYbJBhtSpNzbPebVem26pZD8Ck8y/bQlDgHBlB8zfNxdiC6QNyvV/8gTk+yHIT2MF0Vzqxjwv0yo8g6FX0I3/Y5/hqXt56f0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn8fV1CuSiel3uYk4niG6FR6L+Y0T86E2V14Ow+zuZo=;
 b=VqjTj2v8O++NCzfoWn36GjL+rGAqUIHqi2RY5/tyZ1Ir6n5KqaBPJ/cRl1XnzklCT1JeJxcm0jJ2Y7zTkElOBU6rQ3PmBSRnXHLKurjytDMe+SALNUwxQsL7x45QqyPiy1aotOuPzXk3wtF5b+Fcfd8bR1IoNKOMSlQpxasLq7c2qSI78Ve7rxRVjyKG8pTIWSkYG1C7hbpC4565810pI7o8fknpc1N5mku2spf7SvFloS87XO/E9U9Kr/7NtfIMT9+YSZgJiVOPIDZOE7Gx368F7VGjg85yzb6BDmARjLGSj+I5tdwlOGQKC3GiRpmuSNWLVyMBzynsBs65Sf966Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <hiraku.toyooka@cybertrust.co.jp>, <quirin.gylstorff@siemens.com>,
        <ch@denx.de>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: 
 AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBwADL8pYAAAIHQ4ABsGuiAACP4ZqAA3sUFkAAKdJigAAg7sHA=
Date: Wed, 29 May 2024 03:05:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610346D0E4F8C5550B3EBB03C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862221FADD6EE25E032DADBB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610353B51E2D66C802A5104DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB1186210AA7A8F762825C4BD44B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103AF590A9C795BD550C65BC2F12@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862B2E811EE59BBC4A0CCA0B7F12@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB11862B2E811EE59BBC4A0CCA0B7F12@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSRPR01MB11662:EE_
x-ms-office365-filtering-correlation-id: 34a3b9fc-4b3b-4c3f-e234-08dc7f8c2905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WFp5VS9wbWhQT2d4a3c1WGEvWXVWaUJITVQ0V0ZZNCtHeEJBRHpXdEd0?=
 =?iso-2022-jp?B?OXdTbDZYYitBUG9odXNoblRsbEw5bjY5VVV4dzFDNTNTTWdsSUMza0JH?=
 =?iso-2022-jp?B?eXVmbzcrMGQ5WGd5WktlYnBMcllOek96ZWNPNnVQdjZSV2VxbzgvdW5T?=
 =?iso-2022-jp?B?bmxlcWVnVG1UbHYrb1k2SkcyTFBiKzRGRkk2ckYzdnlqVEdTQXg2OC9u?=
 =?iso-2022-jp?B?RDdsYmJFSzZ1eE9wSXllVWdsQU1xeDUvMUdMSTlBLzZ5akE2SlNYbDZ0?=
 =?iso-2022-jp?B?bDZHdFhKUlNwTVF3NVRNYjhTRS9nL01sTFRHZ1d4K1Q2M25ybU9KOHN4?=
 =?iso-2022-jp?B?MEJmdG5vcGYyL3VZVGk1M2tNb25jSjRkeXpOWHJPQUtnSkhRbmM2S1JU?=
 =?iso-2022-jp?B?cVYyS01DNGY2cGRodlJnL3dydDVlK1ZyKzVOajdESHRRdHlHN2UwaVNF?=
 =?iso-2022-jp?B?YTlNaWdHVDVxR01ITkVsR1B6SzhWZkY0b3ErUVVUcWdQcUJUeU9ML3ZH?=
 =?iso-2022-jp?B?enZ6UVVDT2RWbzNnQ0QzUzlFRG1NZWhXM2xqcHpRYzVDQ3krNnVLV1Fh?=
 =?iso-2022-jp?B?L2MzNDNOdDFsVzZXSCtyVkZuMGpkcnhqdHo4MzkzeC9VZDBvY2lGTWpC?=
 =?iso-2022-jp?B?V0R5OC9FK1Fsakl6djdncndPN2E4NWRJUjhYWVZ5T2JlMWF6QkRXQmRl?=
 =?iso-2022-jp?B?ckd5VUkzNllNa2pWUmpLQi9kM2M2UzUxV29zUUFTSmRMdUJYL1U5YUI5?=
 =?iso-2022-jp?B?M0tmSGdSNTRKVVRvWkdkbmxyZCttanV1KzZDeHZsVXB0YTZMMlFyc2Vu?=
 =?iso-2022-jp?B?NjBOL3pJS2RoR1F1VnBaZWJrQTRGaTROL1ZGMkt4SnFJL2tvTTkxRWNF?=
 =?iso-2022-jp?B?cnZBVHNRL2UyMXI1Q2lVVFI3cEFXRVZqaG5Ocm1CRGN0Yk9IcDIxbG94?=
 =?iso-2022-jp?B?ekF1cXRIcG5JaTBuaHNPOVovU2xza0xpUk1pY0hSaU9XWFZZanhFK2cv?=
 =?iso-2022-jp?B?ZndUNnl2b1pTUmhjd01IZ0w2cFRMczlrRTRLdVBRbzFxVzg1d24vRHNi?=
 =?iso-2022-jp?B?dmVIVHdIcnhDbnJQQUJ3cElsaFN2eE1nbFBsMHNxN090NTlkWmxqek1q?=
 =?iso-2022-jp?B?ODh4cmxJY3h1eTdVb29kWnU0WEQ4ZFg3T2oyTGk2YVRwU3hMNUlUTk1Q?=
 =?iso-2022-jp?B?VnFIUXNqZzZYWmh3S0tTcmFzd25iYkc3Qld5clVyM2dqUkpuZ0FKNEJI?=
 =?iso-2022-jp?B?enFJZkhscGs2OEdJK3g0SmJ0QXFvMld1VkFBQWZQSGxrOEZzOTBRYmha?=
 =?iso-2022-jp?B?VmYxUFJBTDJpa1hVYTdESmV3aUlHblZUN0ZDNElIaExkcG1yNVU4RTNJ?=
 =?iso-2022-jp?B?MTY2UEp0NWdXb0haclU4VGIzL09scXV3R0dFdkNDSzB5OEtmVjNGSXVy?=
 =?iso-2022-jp?B?ZDhzRnNNdlFObFg2cDlXRFYwNDhHaTJGRk1rY3hwM285N3pncmZYUmlT?=
 =?iso-2022-jp?B?eDF5ZzN6bkhlVXRtSEgxNWplK01tamJiMWgxZGRSWWxqemhhZVVObER3?=
 =?iso-2022-jp?B?VFRVc1RpeWFncnlaU1pWaXBoZWFmU2VpSGJ0L1d0enhlS1dEcEZXRVdx?=
 =?iso-2022-jp?B?VkFzeUVvVEFJZkNGQ3ZBakh2VW9XemlkZjdQYUVvQVJVS2wxRzBubUFl?=
 =?iso-2022-jp?B?S25vZmYzMFFQSjYySlhiT0pONHJWQUZTM3JRZUxTR3hCdXRMZmVFS282?=
 =?iso-2022-jp?B?ZkN2R1ZmRjNNVjI4WkpZeG1rM214b0RSQkJmU2svejBPWTF4alNRU0t1?=
 =?iso-2022-jp?B?NTd0YWIvbWx3M3hmMUdqTWR3a2VlUUVqVk9IMlBaOW9nVkZPdEVFS2l3?=
 =?iso-2022-jp?B?K3M2Sk8zUTBwR211cnl1SEZtZWlRPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WkJnSmQzeCtNM0hDaUlhTUwvUmRTR0daS0YyYzVvdlE3S1RCaFF0ZW9u?=
 =?iso-2022-jp?B?NDR5YTVRcG1sNk91T2NIL01VbmhXRkVuZndGdEZSdGU1WUdHNEVsTHdw?=
 =?iso-2022-jp?B?WURXMDFwTFpZQkg5a1ZlNUR3RmhEVjR1eno3ZlFVSjlmbXNTbnVEcmNZ?=
 =?iso-2022-jp?B?Y1Bza3RZV1JDVktnRStUUXZmTGVGcThKeFp6NUhtMEdQU0IyYnNjVVUz?=
 =?iso-2022-jp?B?YUpYcXpvdFJwdkF1VnNjNnNZOFdXUEZRR3N5YXRRcTZIWWt0Ym1SSmw1?=
 =?iso-2022-jp?B?alg5MGsrR2xNVUFhaC84VFZ0YVAwMkIrY2R4bVpJNGRFcVhVR0w4NTJr?=
 =?iso-2022-jp?B?QmprN3plbk9XdGRnMEp0TWpOT3Bja2JGTTg4OG4zaFp3STlOYUhLR2Rk?=
 =?iso-2022-jp?B?WXpGVDEyeFM4Uisyc1hKUmRESTVoV05DdCtaamhhTTJiOWl5TE1TVnlH?=
 =?iso-2022-jp?B?Rk93dnAweVpFL1JYQWFJSjNwM2NyME50YVZlMzZHNHZpWGdOaU5WMWhv?=
 =?iso-2022-jp?B?Sm9YSUNPdFBDUUxweGtWcUZia0pBUTJkcXJxTXJvN2VYQ0JadUtwdFBW?=
 =?iso-2022-jp?B?NW16Z2F6QVlhaWk0ZmFFN3FDZFA0VXI0ZXUrcHRDSG9NQ21ZTDVXMGFm?=
 =?iso-2022-jp?B?S3k1SVg0N3NCb3M1ZnFZS21lNDFLOVhTWks1YVQ0a1FXQ2Z2WHNwMitY?=
 =?iso-2022-jp?B?R0VvV1V0RXB3MnBZbW9GZ1FJYkZXSEFvWDRQaTNpbWE3SlhielFzNHhw?=
 =?iso-2022-jp?B?dzI2dlFCd3pYVUhwK09vRG1TRGZsb05GTVQ5d3ZXVUdMQkJYbmJkUzI1?=
 =?iso-2022-jp?B?Q3RpbXdIaVFEbDcyQlgvNWw3aEd0RkpFY2hOY1ZHcWdFVlFZdTR2clhW?=
 =?iso-2022-jp?B?VGdVSmVEaVVPRXlKZGZTaFJVK0lTQW91cmpmaS9mVGdtOHBVSTZTejJw?=
 =?iso-2022-jp?B?cUd3OEQvZlkxdkl6UHV0akpRUDdBaXRXT0hRYjhzQkpWa0ZTcUxGOEVh?=
 =?iso-2022-jp?B?Vko5RDhqY2pjSXNtbnJMTnhyZXkvSTZFQ05STmFRbW1EZmsrMEk2VHdn?=
 =?iso-2022-jp?B?Y25ZVHFsS1FGbXFUMjRCT3JsQVorcm95YUtPejFhSDFzUjQvYkNxRnE1?=
 =?iso-2022-jp?B?U3orRzZ0dTR2NnEraGNvQXVDbFdTNE9UaWQ1Zml5TWZ5c0VROE5sNXRk?=
 =?iso-2022-jp?B?bGdKblRITmc0c1NOZ0JMS0IycUtGQmZDdVZQVlo3a3dKMlhJdStjVVp1?=
 =?iso-2022-jp?B?OEFYUWgvYWtwZTk1bUtzd2lFN1B4NGtEMU4zOHVhV0xKZ3cwT0owU2NN?=
 =?iso-2022-jp?B?c1JNVUpPTGVpZWdzdlMvZE02ZzFhejlzRUhLTUhCUTBLNk9MVjVvdXpU?=
 =?iso-2022-jp?B?NGVLZkRwWEFUbzg0MEJ2L0I5RkEwVjByUmV4YVc3MDBYVGhBSDh1bWpo?=
 =?iso-2022-jp?B?N3NsdUk4eFVnK250Z01PMUhDaWRFRHEwQi8yUW9aUDFEMS93ZHRuTTM5?=
 =?iso-2022-jp?B?U2pjd0ZoaTJ5VFV1RU5UMEJ5aWZBQk9oSkJhTllYdXNuR2JOZGdKQVp6?=
 =?iso-2022-jp?B?dTUxZC8rM3dmREozN0I1U1NwVGdYU3cvZ3dua1VoSHp6UHpncnJibFp1?=
 =?iso-2022-jp?B?YXcrdlJ6cDZUdWtuUW5OQk00dHZlWGpza1ZmaGlrNkcxSFBDMlJxYVo1?=
 =?iso-2022-jp?B?RVdzbGxza3pYSlcrN0lwN1lyR0JzQVJaNkF1cW9iR1pRYWtBM1lmeXY5?=
 =?iso-2022-jp?B?OS9Id2ExLzJiRGt2aGE3WkhyT3BpTTJPam40VGQxVkQwUWc2VmtubW12?=
 =?iso-2022-jp?B?SUhmNkozMFJWd0xMbkJwWDZwTjVVSDAzazQ1dEsxTS9mblNMTG1pM2ZM?=
 =?iso-2022-jp?B?K3IybWwrbElHaG5wdXZqRVhVU1k4VVFNUVFlYkJrVG81aEp2K2tncjVx?=
 =?iso-2022-jp?B?MGt5R3hzekkzMUc5cDRrbVhUaEhsTnQ1eHpPaHpCZWQwUkZ5dVhxcDQx?=
 =?iso-2022-jp?B?QS83bVdOWVdOYW81WG5BL0dZRHZjQ3NMWnB5enNqRHRHV0NyZjJCYndE?=
 =?iso-2022-jp?B?Yld0dlc1NUN5Wkl2SUtjaFRrcllITW54NjRLVDBhNXNDOUhXbFBzRURw?=
 =?iso-2022-jp?B?SlFQc0c0cDB2ZXgxUHE3R2tCVVJOa2JSOGZnMjI5NVFwTy8xelRvcFcx?=
 =?iso-2022-jp?B?bENRb1hkMWRFcE4zcmlndHFSQ2dEVXlWM29oeWw0dklFc25UT0YvWG42?=
 =?iso-2022-jp?B?ZXY1Rjg3WW93L09FYTRoUUJzKzRmVVRRVFdHQ2dtS2R0UU1IdlVkcDhw?=
 =?iso-2022-jp?B?MWR2NVQyankyTkpQZXFJcG91bmhvMmtTa2MyeXFmeDkrZ1ZKaThSTXF1?=
 =?iso-2022-jp?B?Mis2a3F3d3dpUndLZFJUd2YvRUlFT29LQTRmRGljb1ZYSUpEVU9xamh4?=
 =?iso-2022-jp?B?Nmw0cWZ3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a3b9fc-4b3b-4c3f-e234-08dc7f8c2905
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 03:05:13.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: II5TotYvNm89Jz1jRiCwEKbFYtOOEH+PKD2RRx2CVvlDMe7X9TAc2W890RY5UnApn+3Hv3nq/dsH5tUstxmoCRYpVuv+/HB6YgeKIDI4e5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11662
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 03:05:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15978

Hi Chris,

I understand your concern that we are enabling only one device to be capabl=
e of running the swtpm jobs, so let me create an MR to make every QEMU devi=
ce available to be capable of running the swtpm related jobs. Anyway, we in=
cluded this mechanism in swtpm_start script to wait until swtpm socket is a=
vailable (which implies that the other QEMU device is done with the job). I=
 did not do this previously because of the limitation that only device per =
slave can run these jobs at a time.

But considering the situations that the only QEMU device capable to run the=
se jobs can be down because of some reason or taken by other jobs. In that =
case it helps to have both the QEMU devices capable of running these jobs s=
o that the remaining device can take up our job.=20

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)


-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com>=20
Sent: Wednesday, May 29, 2024 4:43 AM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayas=
hi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Tuesday, May 28, 2024 7:23 PM
>=20
> Hi Chris,
>=20
>=20
>=20
> Today while I was testing isar-cip-core LAVA job trigger pipeline, I=20
> noticed that the one and only device (qemu-renesas-01) which has=20
> custom device dictionary changes to use swtpm related scripts to boot=20
> CIP security image are gone. LAVA | Scheduler | Devices |=20
> qemu-renesas-01 | dictionary (ciplatform.org)=20
> <https://lava.ciplatform.org/scheduler/device/qemu-renesas-01/devicedi
> ct> . Because of this none of the QEMU devices present will be able to=20
> test Swupdate, secure boot and IEC layer.
>=20
>=20
>=20
> Chris, I am about to send patches to isar-cip-core to trigger LAVA jobs.
> For every pipeline it must run 11 jobs on CIP LAVA QEMU devices. So, I=20
> request you to please update device dictionaries of only one QEMU=20
> device in each lab so that we can have 3 to 4 QEMU devices able to run=20
> CIP Core jobs and this also makes test stage runs faster in=20
> isar-cip-core pipelines.
>=20
>=20
>=20
> I have already created an MR https://gitlab.com/cip-project/cip-
> testing/lava-docker/-/merge_requests/35 <https://gitlab.com/cip-=20
> project/cip-testing/lava-docker/-/merge_requests/35>  to include=20
> required scripts in all CIP LAVA workers. I mentioned the reason why=20
> we need to manually update the dictionaries instead of updating the=20
> dictionaries of all the available QEMU devices here=20
> https://gitlab.com/cip-project/cip-
> testing/lava-docker/-/merge_requests/35#note_1921132805
> <https://gitlab.com/cip-project/cip-testing/lava-docker/-
> /merge_requests/35#note_1921132805>  . Please have a look at this.

I'm still not happy with the approach this MR is taking, but as you need th=
is functionality working, I've merged it for now.
I've created a follow up issue and assigned it to you to look at when you h=
ave time.

I've also created an additional MR to add the functionality missing from yo=
ur own (we need to add packages to the LAVA slave Dockerfile).
This too has been merged.

>=20
>=20
>=20
> I request you to consider this as high priority because we are working=20
> to enable this LAVA job triggers from isar-cip-core as soon as=20
> possible. We will not be able to test if none of the QEMU devices are=20
> able to run any of the CIP Core jobs.

Lab-cip-renesas and lab-patersonc have both been updated to the latest cip-=
lava-docker version.
One qemu machine from each lab should now work okay for your testing, but p=
lease double check for me.

I will ask the other lab maintainers to make similar changes their end.
Once done there will be four qemu devices available to you.

Kind regards, Chris

>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
> From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> Sent: Friday, May 24, 2024 1:15 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
>=20
>=20
> Hi Chris,
>=20
>=20
>=20
> I updated the corresponding MR lava-slave/scripts: Add scripts needed=20
> to run for booting CIP QEMU security target (!35) =1B$B!&=1B(B Merge requ=
ests =1B$B!&=1B(B=20
> cip- project / cip-testing / lava-docker =1B$B!&=1B(B GitLab=20
> <https://gitlab.com/cip-
> project/cip-testing/lava-docker/-
> /merge_requests/35?commit_id=3D6642a2390ead758ecbb8b096c62c4c5d4fd504b3>
>=20
>=20
>=20
> This MR only adds the scripts in the workers. Updating device=20
> dictionaries on only one QEMU device in each worker has to be done manual=
ly.
>=20
>=20
>=20
> If you have further review comments, please provide them in the MR.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Sent: Thursday, May 23, 2024 8:04 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)=20
> <dinesh.kumar@toshiba-tsip.com <mailto:dinesh.kumar@toshiba-tsip.com>=20
> >; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> >; jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Sai,
>=20
>=20
>=20
> I can update the device dictionaries, however each lab would need to=20
> update it=1B$B!G=1B(Bs worker docker image to include the swtpm*.sh scrip=
ts.
>=20
> Before we do this, we should really finish and merge the corresponding MR=
:
> https://gitlab.com/cip-project/cip-testing/lava-docker/-
> /merge_requests/35/ <https://gitlab.com/cip-project/cip-testing/lava-
> docker/-/merge_requests/35/>
>=20
> Please could you check the remaining threads?
>=20
> Once merged I=1B$B!G=1B(Bll ask for each of the workers to be upgraded (I=
 only=20
> have access to my own worker).
>=20
>=20
>=20
> I=1B$B!G=1B(Bll remove the swtpm-jobs tags I added the other day, so at l=
east=20
> your pipelines don=1B$B!G=1B(Bt fail ? they=1B$B!G=1B(Bll just run slower=
.
>=20
>=20
>=20
> Thanks, Chris
>=20
>=20
>=20
> From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-=20
> tsip.com>  <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> Sent: Tuesday, May 21, 2024 12:05 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> ;=20
> kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> ; jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hi Chris,
>=20
>=20
>=20
> Thank you so much for adding the tags to one qemu for each worker. But=20
> the device dictionaries for these tagged devices need to be updated=20
> with the below snippet. Without these changes we cannot boot the=20
> security image in LAVA.
>=20
>=20
>=20
> {% set user_commands =3D {'start_tpm': {'do':'"/usr/bin/sh=20
> /usr/local/bin/swtpm_start.sh"',
>=20
>=20
>=20
>                                       'undo':'"/usr/bin/sh=20
> /usr/local/bin/swtpm_finish.sh"' },
>=20
>=20
>=20
>                         'manual_kill': {'do':'"/usr/bin/pkill -15=20
> swtpm"'}} %}
>=20
>=20
>=20
> Just like it is updated for this device LAVA | Scheduler | Devices |=20
> qemu-
> renesas-01 | dictionary (ciplatform.org)=20
> <https://lava.ciplatform.org/scheduler/device/qemu-renesas-01/devicedi
> ct>
> .
>=20
>=20
>=20
> Can you kindly update the device dictionaries for the below =1B$B!H=1B(Bs=
wtpm-jobs=1B$B!I=1B(B
> tagged devices ?
>=20
>=20
>=20
> *	https://lava.ciplatform.org/scheduler/device/qemu-03
> *	https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
> *	https://lava.ciplatform.org/scheduler/device/qemu-patersonc-01
>=20
>=20
>=20
> I will contact the maintainers of isar-cip-core project regarding=20
> CI/CD variables.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Sent: Tuesday, May 21, 2024 4:24 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)=20
> <dinesh.kumar@toshiba-tsip.com <mailto:dinesh.kumar@toshiba-tsip.com>=20
> >; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> >; jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Sai,
>=20
>=20
>=20
> You need to talk to the maintainers of the isar-cip-core project to=20
> get CI/CD variables set there. It=1B$B!G=1B(Bs not my project so I should=
n=1B$B!G=1B(Bt make=20
> such changes.
>=20
>=20
>=20
> I=1B$B!G=1B(Bve added the swtpm-jobs tag to one qemu from each worker. Ch=
eck the=20
> =1B$B!H=1B(Bgreen eye=1B$B!I=1B(B on the right of this page:
> https://lava.ciplatform.org/scheduler/device_type/qemu
> <https://lava.ciplatform.org/scheduler/device_type/qemu>
>=20
>=20
>=20
> Kind regards, Chris
>=20
>=20
>=20
> From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-=20
> tsip.com>  <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> Sent: Monday, May 20, 2024 11:23 AM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: cip-dev@lists.cip-project.org=20
> <mailto:cip-dev@lists.cip-project.org> ; dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> ;=20
> kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Chris,
>=20
>=20
>=20
> Any updates on 2nd and 3rd requests I made in the below mail ?
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
> From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> Sent: Wednesday, May 15, 2024 4:41 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: cip-dev@lists.cip-project.org=20
> <mailto:cip-dev@lists.cip-project.org> ; dinesh kumar(=1B$B#T#S#I#P=1B(B =
TMIEC ODG=20
> Porting) <dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> >; hayashi kazuhiro(=1B$BNS=1B(B =
=1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> >
> Subject: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Chris,
>=20
>=20
>=20
> Hope you are doing well.
>=20
>=20
>=20
> Sorry to disturb you with these extra things I need on CIP LAVA Lab.=20
> Let me consolidate my requests in this mail.
>=20
>=20
>=20
> I am preparing a patch to trigger LAVA job definitions from isar-cip-core=
.
> Currently I am working on that in a custom branch. Before sending that=20
> patch, I have created an MR to update the cip-core-ci repository which=20
> is required to run the test jobs in isar-cip-core. I will assign it=20
> for your review soon.
>=20
>=20
>=20
> I will be able to send the patch to add test jobs in isar-cip-core=20
> once the below mentioned things are done.
>=20
> 1.	This MR needs to merge build-bookworm.Dockerfile: Include lava.sh
> and templates in the docker image. (!3) =1B$B!&=1B(B Merge requests =1B$B=
!&=1B(B=20
> cip-playground / cip-core-ci =1B$B!&=1B(B GitLab=20
> <https://gitlab.com/cip-playground/cip-core-ci/-
> /merge_requests/3>  which I shall assign to you soon after some=20
> internal review.
> 2.	I need some variables in isar-cip-core CI/CD setting section like
> LAVA_USER, LAVA_TOKEN and SQUAD_TOKEN. We don=1B$B!G=1B(Bt have the privi=
lege to=20
> do that. I will mail them to you personally. Please hide them in=20
> isar-cip- core Gitlab CI/CD section so that I can use them while=20
> running lava.sh script.
> 3.	Since we need to run these LAVA jobs when pipelines are triggered in
> isar-cip-core, I am making changes in such a way that pipeline keeps=20
> running until all the jobs are done and we report the health as a result.
> It will take around 120 mins to run all the jobs. We have only device
> (qemu-renesa-01) under lab-cip-renesas. So, I request you to please=20
> add the swtpm device dictionary changes and swtpm-jobs tag to only one=20
> QEMU device in every LAVA lab you can access. By this will be able to=20
> reduce the pipeline run-time due to simultaneous runs.
>=20
>=20
>=20
> It will be very helpful if you provide your support with the above-=20
> mentioned items.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)



