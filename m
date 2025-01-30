Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD047C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 08:52:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.11609.1738227159608153522
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 00:52:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 50U8qaA02717606; Thu, 30 Jan 2025 17:52:37 +0900
X-Iguazu-Qid: 2yAb5TJleaJDZfwEuS
X-Iguazu-QSIG: v=2; s=0; t=1738227156; q=2yAb5TJleaJDZfwEuS; m=4XZmrscgmyYkCXVOTenT1JFD9d6TM0/rYjhgc3MWVS0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 50U8qZ1I1999809
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 17:52:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqriwjB76990wOBnaT5W02UgjBXNVkfbFSdaIiJGaRbyNjM3gl3g31SbNuLkpQFrsc6W6A9Rpj+pjSSRZIeXrtMxOt+rzQYgQpa9uQtJid8q0rHbuvk0E70iHQhzpYE7n8sg358+F4YJDMHeFJqJwLb9qO6VWe7ltWoN0GEutdxDa+N21QGBsepqycZN2hmkbqZj3nZH2q/AKP/fLl8AbeSF1Gtd4mudGnODra+Bese/gxTcyrolwTy2qnN/R2zDdqUtfArGLSZVJ3LzF7z/cHAoLDKNYCAYnoEWYoN01OcCuaScvxiOpzDV3+AEz5CzN9jqFVFcUBOCP+65tqQxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR0JqFOGY0rEkwyeiUa9egS9abVdQ864M5S0nHJHHlQ=;
 b=cL90tbKV2XVQHY/u7eCMLvYkDxMq4SPIA4BYAGDo0TldbeD6vzOw1b1Av0g8BO+SVXGkjmZeqn5MW/3JuQdvvehvxB3l2kM4Dv22o7484Y0BxL1O/7TWAtB+KCB1hGkR61ZeYO9Z4wp/oHcVtc1Z2T1hAarNlnxWPH4ZLKUO9m+mwyghbStONQOQO282CsJ5h6+Wf67J2cu+ISIUpyJxK2TRDvZs2sFFjo3xp73jQOYrWaf9TxJKL6kjipmkpCIPY3ufJVlkugXan3/qEcAOC2JCJSiH2N4vGIt0bNEX7M8IgSGko5BeQTkOVOo25z6ltcR4PwoYTAnzA5XtlOc5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Quirin.Gylstorff@siemens.com>
CC: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security:
 add curl to download LAVA overlay
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security:
 add curl to download LAVA overlay
Thread-Index: AQHbbmMZtzjdjBI/2kaUtODthJ5QdrMvCeIz
Date: Thu, 30 Jan 2025 08:52:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61036828512A1860892182A5C2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124132246.64738-4-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYAPR01MB6027:EE_
x-ms-office365-filtering-correlation-id: c4924d0a-92cc-4a94-2f5e-08dd410b6fea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VXV2akZWOGZXQVhMZENqd0xiUTY3WmpwaGFtSWtxaFVwMGhmYS84azZ4?=
 =?iso-2022-jp?B?aXh4SjlSa2hYM3R1T2Q1eVFmMGpMT296eWV5UzVSRWFTbzZDcVAyUzVh?=
 =?iso-2022-jp?B?UWJOVEYra1p4N0tXNUhnQytGMVlURVZ6dVBzLzB1NHkxNlBhNmFtSmNH?=
 =?iso-2022-jp?B?Y0MxM1VtVVludU5OdnhiZG45MUkxWDZFQlFYU2x5MzU1TjJnSlI3Q2lh?=
 =?iso-2022-jp?B?VjIzUElxY29rT1ppZ08wZTN0V3hmbmpYWVorVkR1dnZjN2NCSUg5dlF0?=
 =?iso-2022-jp?B?eU1oK3F1aTJxem4wcFpTTkNpWXE3R0gvQnhWcThaWnJoUTdQd1JzUnFZ?=
 =?iso-2022-jp?B?OTdZK3ZIM1g2ZXc3TXZWSUt4VFZ6TXl2NWpDTjRnLzZ6NXdaNVFyN0wy?=
 =?iso-2022-jp?B?dHpKQ1NrMHc5MXJpL09MYmVhYjZQcmR5ckR2bzc1OHBmQ0R4bElEY2xK?=
 =?iso-2022-jp?B?TTQ4OFFWcWVVY3VJYmlHWlRpdjFkak5zaXVwLzBwem9WVjdtMnhOcEkv?=
 =?iso-2022-jp?B?ampIQ3o3b0ZQbll0SXp5RU5DOUUvWEJ1QnBMenZ6TjFyQ0I2Q1g5bFhN?=
 =?iso-2022-jp?B?aFU3a1BZcmZWeW5IWVRRNWd3UTVlUGpvdHN5d3pwVWlxQjVYZWtTdStw?=
 =?iso-2022-jp?B?czNKNWtTQi9vcFdONWJwc1ZNbmdzK0pVY0g0OTVwQjdsUGdyQU8waHRC?=
 =?iso-2022-jp?B?U1Z3ME9SdDkxRFBWODgwOFRLaHhtUFJHN1h6bmt3cUVNbVdDaTJjMTFa?=
 =?iso-2022-jp?B?ME5MdGlGNDFnalY3NmJHSVRVUWx3d1BxU3BWalEveUlKRW85SFc0c25p?=
 =?iso-2022-jp?B?TVJBRWVJRkUwSTlldGl3a3BQWkZhTG92MGViQ2tmQ3hBcGtWd2pvbHZ0?=
 =?iso-2022-jp?B?eWM2QlV5NVZ2ZStIZTFrS1FnTVJSaHJyUHFicnMrcUtkR0w1SlFwYjZ5?=
 =?iso-2022-jp?B?V3cwaGE0RGNCc2YzM2hpR3RTL05RZ1YzbDVEMnRTMG1ZRVNOTWY1OC9s?=
 =?iso-2022-jp?B?bzdqclNyd2FrMXozWnVxN0dwc25KVytXU1cvbmpBUkVXRHJtTXNvVjl1?=
 =?iso-2022-jp?B?SklKTHo4ZHdRSGhMeExrdkVUSG5vVFk5UUN1cGRFYVNFMXltK0FJODE2?=
 =?iso-2022-jp?B?ekdjbkhFcDlRRXg4R3p0N0Z2TGw4NmVaY2xEZFpPMlRuOWpyQzdscWRl?=
 =?iso-2022-jp?B?VkxGWTlkNENyMWRQUE5uZURoajlxN2VXQ2xXZ2lZM3o3ZXZ0MFBqblJS?=
 =?iso-2022-jp?B?K1pFSnFzQXBiWWhxSlFCam1JQWhsSmErMWxnbndqcUlsQXMyeG5PdzZF?=
 =?iso-2022-jp?B?MGs0RHY4L0lCYmV5YXFGSEdRcXFRT0JWSFhJRFNBNTdNTWJUK0YxNzdJ?=
 =?iso-2022-jp?B?TGMrdHQ4UGl5V0JEUE1JR3JCaW1tZmZZem1aVWdRcnBrKzNQbGQyZG9u?=
 =?iso-2022-jp?B?RHFqV3VQRE53RFBsWDFWaWJ1ZHZZRkNvK1F3RkorS08yeW5RaDBiRVRq?=
 =?iso-2022-jp?B?TW1VTHlIOTRqbVM0ZklMU3Q4R3JLdXpFR0lBN0RyVS9USExsRk44QlRT?=
 =?iso-2022-jp?B?N1J4Z1pzYkppZGE0cDFHd1Z6M2VIbWRkV2Z1bjFOZnpLT1MzM3NKM29o?=
 =?iso-2022-jp?B?QnpqMEEvS3NRcnZQeC9aTVZRZThMTjNmOFlNajB3aUJMc3IxNStYWTlX?=
 =?iso-2022-jp?B?UHBPMEJjM09tSDVBMkZyY25KbW1QMkhFVFZZcmVMbERjazY0V2E0ZVRE?=
 =?iso-2022-jp?B?NUY2clR5L0NMVHZxUTFkZkpScS96eFZwYnl1SWlDS2tSTlJtVUZsNDlE?=
 =?iso-2022-jp?B?bCtIOGZVVzNxenZYYlBXM3FITVVvRDUyRDVqMm9WdEZNZDR3QkNGazhY?=
 =?iso-2022-jp?B?c0s4a3FhQy9KZHhZNDRhcmk2UEhKaktMNDgxMHRSTWZYdDdnT2RCVHpC?=
 =?iso-2022-jp?B?MVhTemZXbGlWenpnOVh6aHdVb1dMQ2o2Sk11RXBUS240ekgwQ1FHYVRK?=
 =?iso-2022-jp?B?M3YzaWY5ZUpjUys4ZUlObVkrNzFOS0pkbmt5d3VGZzBOZENtVjJySXpM?=
 =?iso-2022-jp?B?M1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L2ZoV1R5cElhSTdXdC9WMzVpNnd5TXZzSDhWZUdpNjBoZXRjT1lubDdB?=
 =?iso-2022-jp?B?amxFOERNMEVjQzJ3NGpqditWMUdKZnFvUmdLeG1tKzR1OGVHelhNQStm?=
 =?iso-2022-jp?B?OWZrU0Z2MTRCeThKTlBrcGFYVC95MnBuUlFRTDd2cUlZREZYaW8rV0pL?=
 =?iso-2022-jp?B?SFVINVJZY211NjRWd1F0RFJaelFOejBtK3RWRUZUWEpzRC9ucisrek5Y?=
 =?iso-2022-jp?B?WkRPRG03bkNsZjBjZGZ4aTdMSXJzUUNINHhzY3hPd1lPNml1ald2NTcv?=
 =?iso-2022-jp?B?RVh3dm5QaTRuaSt2d0VQRzNOV0VqcGhKMmR6TDFOUHI3QnViZXZxaXlQ?=
 =?iso-2022-jp?B?OTBCeXNzMzYyQXloRFhyOU9hcEY3aDBWSFFOU2pVUFB2RnMrRXhQMFFK?=
 =?iso-2022-jp?B?OWhlT2cxN1J1c05OekJTZ0NrVkhqc3UxdUcrS0gzNVBiNW1JamFPR0lT?=
 =?iso-2022-jp?B?Sm9zeDFyMGFDWVZGVVJ1Q3lHRHVYZVNpblJ1QXF6b05hSkE0M1cvSjZD?=
 =?iso-2022-jp?B?clJkZHAzczFBYjBRTkR3SThLUVJ5aFBiaVNiTkJYanlnSDV1YnBsZE5V?=
 =?iso-2022-jp?B?ZDJybmlOTjFzOU5Ca2xOd1plQkdZSU5mSm5aMmNSd1dWaXRVNUJFdGxz?=
 =?iso-2022-jp?B?VktEWVN6a2l1SWpHaDZGQkt5RXVGQ2tWT2tlWjJjemN2bmdjUmcvbVBo?=
 =?iso-2022-jp?B?MWt4bmFQZXFoelBXTGZ0MklUYWdTK2E0QXV2dE16OVJMejdNQnd5dUhY?=
 =?iso-2022-jp?B?VkNmaTNhY1phV2NMZlZqQmpXQWpiYlNuSnJBVnRQTUhNY1I3TFJnTm1M?=
 =?iso-2022-jp?B?SEUvMW1oanc4dmRnUXBIUStLMkZtWkJqTTFPUmRacVRsTEs0NFhxd1RI?=
 =?iso-2022-jp?B?NXRPQXhYdEc3SGR0NmhUWThJSWFQd0hTekU4OVBKSG1CclhEd3dkbGpP?=
 =?iso-2022-jp?B?MlhTU1FhL2tLMit5VTFjbzlta2xkZ015WWtDTFJGZUhSbHlCb3Vrc0pB?=
 =?iso-2022-jp?B?RXF0dU84aTdiVEhsRThDZWRQL21GZlhHTmF1dllEdFE5Si9IeXJpck82?=
 =?iso-2022-jp?B?eExyYVlZZjVyRS9PRktDUVM3VXAyNVNkT281R1o5eEdJbGRRYXNwUm1T?=
 =?iso-2022-jp?B?UXBtc1lpckdLNzY5OHBTZDF0WnhRbjFaMk9EUFJBZHBxYlZLK2hWcWpS?=
 =?iso-2022-jp?B?UFlqNTdQZzVwMG5makp2TldzOTVNRG9Td0tmOXRqVWxaMDAzdktKLzBr?=
 =?iso-2022-jp?B?TDhPbVpKSk1mMFByN1FHRU5sODM3U0dneU1DN1hNLzIvejdOSnJUZkMz?=
 =?iso-2022-jp?B?enlnSGRpbHduMnBjbm1yelNNeDFBSU5hZ3U3NGMyM1RPU3J1VzM1RytP?=
 =?iso-2022-jp?B?Y2l3NHlmNTIzdC9TWlVaUW5zYnBqWmFNVDNqb21IcUxEWnJxWTRqWW02?=
 =?iso-2022-jp?B?RE9ERVRsZEVJeDBibGN3Um5HaVJTVkFhaG8wTkRqNFQxN2pBNmlEbk1D?=
 =?iso-2022-jp?B?Y1BrcllmZzdIaDdEcU92azQ1SGlYTXFZOTFONGlLR0p3dDFpYzFzbmpB?=
 =?iso-2022-jp?B?NVM3VlNoOGxzaVlheEZvUW1YUC9RZSttaCtKWFFHUEpUK1VDUFBFK2pC?=
 =?iso-2022-jp?B?Zk1WSDEwRHljbmpRUEg3ZnBSNllxTm1oVFlMRkFmc2FMc0QwaDhnMDRh?=
 =?iso-2022-jp?B?eHNVSlhzY1NWY0VDUmZQK1hGQktqUnBKd1REYU9CU1RSNzMwMGZFNEpt?=
 =?iso-2022-jp?B?Z29ZL1dQTm9raHlIOEpmdmFxd1hiK3duTDJXVFVzZWVpMFA5MFdyeWhn?=
 =?iso-2022-jp?B?MzBqMngxcEtVR0RvQTl1UVB4Sy9yRWhBd3NQYjN1VjJtWkFiUk50MGtJ?=
 =?iso-2022-jp?B?Z3VOcDE5QzNid01CKy90WkZiTVY0RmRpZTg0N2ppa0pUU1gzSFF6d01I?=
 =?iso-2022-jp?B?bzZGYVlKOVdiWDB1TVFsNjZKeHNSK21aWUNlY2J4RWVTWExBQ2pOd1ZF?=
 =?iso-2022-jp?B?bGVVb0VreUZOUjlBZWozMmtZNVRvQld2YURwQlNTTmI5cE5HZEh1R0d1?=
 =?iso-2022-jp?B?aWk2UVM5SUZjZkhOSjMrdnF3dGhybjNhSHQ0d1cvaFRLNGY5U0JXUzdZ?=
 =?iso-2022-jp?B?OVl1SStYKzFIaDFteWgrSTkxUmU3M203QjBtT2xIaHlFM1BOa2tGSjdQ?=
 =?iso-2022-jp?B?cHlmQ0JyUDdMeFpiOU1ZZm80bnA2d05vaVBSeSs0L0hML3UvZ3N1SGt3?=
 =?iso-2022-jp?B?dTEycnREZ1BYMVlDWjVTTUNVTVVsZ2VrY0c1YXR3RG4wYWc0WHYvcVZp?=
 =?iso-2022-jp?B?aXVpV3J0d0M1QlkzU1RFRUhRcHVNL2VML1E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61036828512A1860892182A5C2E92OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4924d0a-92cc-4a94-2f5e-08dd410b6fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 08:52:33.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eZDqqwps0XEKPHJg87mzqtd6X7axdt/boG2le6vxV2JNigq7O+rhz/XxZNQxCKRS9PG/erdy+bckVBy9GL4SAZW7OMPH+7xipyA4Goiar0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6027
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 08:52:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17690

--_000_OS3PR01MB61036828512A1860892182A5C2E92OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

Including test extensions to security shall make the artifact name cip-core=
-image-security-cip-core-bookworm-x86-uefi-test.wic. So, the artifact's upl=
oad to s3 shall fail<https://gitlab.com/cip-project/cip-core/isar-cip-core/=
-/jobs/8943849473#L2128> due to current logic mentioned here<https://gitlab=
.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts/deploy-cip-co=
re.sh?ref_type=3Dheads#L22>.

Regards,
Sai Ashrith

________________________________
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
Sent: Friday, January 24, 2025 6:52 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; jan.k=
iszka@siemens.com <jan.kiszka@siemens.com>; cip-dev@lists.cip-project.org <=
cip-dev@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security: ad=
d curl to download LAVA overlay

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Lava generates an directory, in LAVA called overlay, which contains
all scripts and tests of the test stage. The Device-under-test
needs to be instrumented with with this overlay.  LAVA provides the
possibility to download the overlay via http or NFS. We use curl
to download to the overlay from a http server.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml   | 3 ++-
 kas/opt/test.yml | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 686ce48..d63ef2e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -65,6 +65,7 @@ default:
     - if [ "${release}" =3D "trixie" ]; then base_yaml=3D"${base_yaml}:kas=
/opt/trixie.yml"; fi
     - if [ "${encrypt}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:kas=
/opt/encrypt-data.yml"; fi
     - if [ "${watchdog}" =3D "disable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/disable-watchdog.yml"; fi
+    - if [ "${test}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:kas/op=
t/test.yml"; fi
     - if [ "${swupdate_version}" =3D "2022.12" ]; then base_yaml=3D"${base=
_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
@@ -250,8 +251,8 @@ build:x86-uefi-secure-boot:
     extension: security
     use_rt: disable
     targz: disable
-    encrypt: disable
     watchdog: disable
+    test: enable

 build:qemu-amd64-swupdate:
   extends:
diff --git a/kas/opt/test.yml b/kas/opt/test.yml
index 4a60ad4..b23f437 100644
--- a/kas/opt/test.yml
+++ b/kas/opt/test.yml
@@ -17,3 +17,6 @@ local_conf_header:
     IMAGE_PREINSTALL +=3D "rt-tests stress-ng"
     DESCRIPTION:append =3D " with test packages"
     IMAGE_FULLNAME:append =3D "-test"
+  lava-testing-add-curl: |
+    IMAGE_PREINSTALL +=3D "curl"
+
--
2.47.0

--_000_OS3PR01MB61036828512A1860892182A5C2E92OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Quirin,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Including test extensions to security shall make the artifact name <b>cip-c=
ore-image-security-cip-core-bookworm-x86-uefi-test.wic</b>. So, the artifac=
t's upload to s3 shall
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/894=
3849473#L2128" id=3D"LPlnk" title=3D"https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/8943849473#L2128">
fail</a>&nbsp;due to current logic mentioned <a href=3D"https://gitlab.com/=
cip-project/cip-core/isar-cip-core/-/blob/master/scripts/deploy-cip-core.sh=
?ref_type=3Dheads#L22" id=3D"LPlnk877165" title=3D"https://gitlab.com/cip-p=
roject/cip-core/isar-cip-core/-/blob/master/scripts/deploy-cip-core.sh?ref_=
type=3Dheads#L22">
here</a>.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quirin Gylstorff &lt;=
Quirin.Gylstorff@siemens.com&gt;<br>
<b>Sent:</b> Friday, January 24, 2025 6:52 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;; cip-dev@list=
s.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;<br>
<b>Subject:</b> [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-secur=
ity: add curl to download LAVA overlay</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Quirin Gylstorff &lt;quirin.gylstorff@siemen=
s.com&gt;<br>
<br>
Lava generates an directory, in LAVA called overlay, which contains<br>
all scripts and tests of the test stage. The Device-under-test<br>
needs to be instrumented with with this overlay.&nbsp; LAVA provides the<br=
>
possibility to download the overlay via http or NFS. We use curl<br>
to download to the overlay from a http server.<br>
<br>
Signed-off-by: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br>
---<br>
&nbsp;.gitlab-ci.yml&nbsp;&nbsp; | 3 ++-<br>
&nbsp;kas/opt/test.yml | 3 +++<br>
&nbsp;2 files changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
index 686ce48..d63ef2e 100644<br>
--- a/.gitlab-ci.yml<br>
+++ b/.gitlab-ci.yml<br>
@@ -65,6 +65,7 @@ default:<br>
&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${release}&quot; =3D &quot;trixie&quo=
t; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt/trixie.yml&quot;; fi<br>
&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${encrypt}&quot; =3D &quot;enable&quo=
t; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt/encrypt-data.yml&quot;; f=
i<br>
&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${watchdog}&quot; =3D &quot;disable&q=
uot; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt/disable-watchdog.yml&qu=
ot;; fi<br>
+&nbsp;&nbsp;&nbsp; - if [ &quot;${test}&quot; =3D &quot;enable&quot; ]; th=
en base_yaml=3D&quot;${base_yaml}:kas/opt/test.yml&quot;; fi<br>
&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${swupdate_version}&quot; =3D &quot;2=
022.12&quot; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt/swupdate-2022.1=
2.yaml&quot;; fi<br>
&nbsp;&nbsp;&nbsp;&nbsp; - echo &quot;Building ${base_yaml}&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp; - kas build ${base_yaml}<br>
@@ -250,8 +251,8 @@ build:x86-uefi-secure-boot:<br>
&nbsp;&nbsp;&nbsp;&nbsp; extension: security<br>
&nbsp;&nbsp;&nbsp;&nbsp; use_rt: disable<br>
&nbsp;&nbsp;&nbsp;&nbsp; targz: disable<br>
-&nbsp;&nbsp;&nbsp; encrypt: disable<br>
&nbsp;&nbsp;&nbsp;&nbsp; watchdog: disable<br>
+&nbsp;&nbsp;&nbsp; test: enable<br>
&nbsp;<br>
&nbsp;build:qemu-amd64-swupdate:<br>
&nbsp;&nbsp; extends:<br>
diff --git a/kas/opt/test.yml b/kas/opt/test.yml<br>
index 4a60ad4..b23f437 100644<br>
--- a/kas/opt/test.yml<br>
+++ b/kas/opt/test.yml<br>
@@ -17,3 +17,6 @@ local_conf_header:<br>
&nbsp;&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL +=3D &quot;rt-tests stress-ng&quo=
t;<br>
&nbsp;&nbsp;&nbsp;&nbsp; DESCRIPTION:append =3D &quot; with test packages&q=
uot;<br>
&nbsp;&nbsp;&nbsp;&nbsp; IMAGE_FULLNAME:append =3D &quot;-test&quot;<br>
+&nbsp; lava-testing-add-curl: |<br>
+&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL +=3D &quot;curl&quot;<br>
+<br>
-- <br>
2.47.0<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS3PR01MB61036828512A1860892182A5C2E92OS3PR01MB6103jpnp_--


