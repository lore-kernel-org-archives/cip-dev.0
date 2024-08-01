Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F3AC3DA64
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 08:33:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.63593.1722501185155389447
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Aug 2024 01:33:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4718X2I8475834; Thu, 1 Aug 2024 17:33:03 +0900
X-Iguazu-Qid: 2yAbzzeqWLqBjAaxAB
X-Iguazu-QSIG: v=2; s=0; t=1722501182; q=2yAbzzeqWLqBjAaxAB; m=DWhyU49ipbe8NlqI4aDaexnXF9iEeDje6kRiHWLktnc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4718X1Pq3718582
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 17:33:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+SOddg0Mv7cd/+VbyItOwWefgpwpqYnFRgXeJKUW7mzB71Y34BLnHPh28mhfab1ztrdW8dozx0Tny1O9876fSuMV2FQefsn/R4GB22JMvmIAB4pzRDY7DyQwl+w7NaXIKBjbEq/e6HRfxazKk0F+SSbEk43zvX2kzMAgANG6z5LjeB39vWZEcUVAwIAYVGrBw+NgbLb+jDvrqchIjoIxJVSNHNIrg1fiitcf3f78/a8gJY0CQCMe0t9R6nOZ8mJYAtH9JQamyLzdxyaVUBS8Ew/IwDaAuHm34UM64wj3xqWMxaOGjyH6i7EoLv64r3mWgZL5WAXATXi17biPP7Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDylIiIQ8NzMqbACqiylAXNg8fJdNBxd6Ugv+6GvpH8=;
 b=pmkICo3BOOCFgQZeFRaoz39L0oJzW41DkraALinh+pxIvuUrtIzL5tko0mD0Z0EnSIMIhB4w/7j/0yEq32j3Q/57VKcBIWMDWvKppxq6Fy8cOHP/M8Grg4PJQJpTlXThfChgA6EOq+vCwntGzWlg29GoVeswA73Nc0oyRMrCRv3WDYY4MLnI+VMyWHck1He1dw+39ngO/iMGMseFqraZ1pC+yQ41dtZnQxvNZB23GIRR8vnCHGWBj055KswLnxHxnGfkfsgvIE6PEtqwSIb+/XnoDX/OcsGcSD8HiR0SXNzoS4ERV0NlZTDF4DDMYEPSvA2e45t6+KmTfZZojZO+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: Sporadic failures of swupdate tests
Thread-Topic: Sporadic failures of swupdate tests
Thread-Index: 
 AQHa1GEaJrvjQ9LEBEqUr/NOQi8XF7IHAL2AgABrsFCAAFOUAIAALcaAgAd39YCAAsqfYA==
Date: Thu, 1 Aug 2024 08:32:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103BE1BF1587327820363A5C2B22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103DC424B825831970AA3F9C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB61039127C5BDFEAD794823B0C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB124024682FB394D8028018049B7B02@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB124024682FB394D8028018049B7B02@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB5839:EE_
x-ms-office365-filtering-correlation-id: c8413026-4b75-40f8-4e8b-08dcb2048c4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZWJWZ25sa2d3ZncwLzZ5cDQxV0N5ME85d282bTVBeHI2eFhwSVZ0NlpG?=
 =?iso-2022-jp?B?c2VBNnp1OHZjeCtQMDNJQ1ZrQktRaGtIakQ1V2I1cjg0TGhNYndzRm5L?=
 =?iso-2022-jp?B?bzcwaHNVMkQ2ajljcERBWDVBL0RwU3dycmllSWtneGNvOStIVG1vSkJn?=
 =?iso-2022-jp?B?NkpCd1BQMEFMNTRBbmhROE5GT2pkQjNmbDB3cHpRZGhRRW9kaVduZEhN?=
 =?iso-2022-jp?B?TnBkY2M5YlRaWk90ZGQxTkZjSDVDU1NXZzI1UEhoOUNTOEcxdzNvSElJ?=
 =?iso-2022-jp?B?bTFTVnhXNU9FcXRTcHExT2VZQUNYMDk2RE9YYzVjcFlMRDIyYWIvNEVv?=
 =?iso-2022-jp?B?WGswZHJTalRkbFNkMlFaZERyMERZZXdzRWJvVEZkSm1GNFZlNUZXRU9M?=
 =?iso-2022-jp?B?V2x0b2hVU3hSdDQzN0l3TW5tbXJOZVdOMGNzYlZqVDR4QnNEckNUZG9Y?=
 =?iso-2022-jp?B?Z2VndFJGOWc1VmpodmhxYlRuQURsUGQ0dUZkYTZGTStjK3o5eU5vV0lW?=
 =?iso-2022-jp?B?NTN3THd3L1JpemdRdnh5b3pEWFBRcjE4YlRkdnpZaXZDcTFWWWx4Lzdu?=
 =?iso-2022-jp?B?QUJIWDZyWU1RMERKZkZOK2NaQU5RZjRwWDA4d0pZLy9CdUVoejczaisz?=
 =?iso-2022-jp?B?M2t1YzNUMmFuYWpJeFhyNDR0THRJNUphWXRHWjJHNmNxVDZiYzY2L2lq?=
 =?iso-2022-jp?B?OE04Y2Q4Wm9aZDJncFo3eU1yZUkyd1RZUGJZYnBZU3FUa0VsdkI1Tm5Q?=
 =?iso-2022-jp?B?a3k3bnBVb3A4Y3BrcFRsRVoxZHN1MUFJc0dCZ1I0azN5VitncnpJN09l?=
 =?iso-2022-jp?B?UzNjRDVwQzE2ZkhDemhDcVZhR0lTakdSY3QwM1RTKzVCTE5scDFGeTVr?=
 =?iso-2022-jp?B?b1BtaTB4ek0wNldrUTBXMW9XYXk1QmNHSFI5dzZNMzJOVnN3SS9XRVlN?=
 =?iso-2022-jp?B?bnRtQUE5eTcwN0ZIRTl6b1RMSFFXMkc4d21EMGJNK3RWZ01NbUFuMGtt?=
 =?iso-2022-jp?B?b0ZxaEJhTEJGU01GSVp4cmF6aEVGN09yWkw2VjNLSW1qTysvbjdOYlRB?=
 =?iso-2022-jp?B?Z1F4NDY5UFhXdjBITmN5alVEMEJOSGJhM3BDWjVVWlhmQW54TldsMmho?=
 =?iso-2022-jp?B?WVpJTGNXT0lKZ3Z2ZDlHZENjYWEvd0J3c2k2b2NaOWxwNjhBTUtPUTNK?=
 =?iso-2022-jp?B?NEhtaU1UeVpVaTl1b21obng3MWJ4ZW5ScEJIL3NBYnpkeGZMTlV1QUp6?=
 =?iso-2022-jp?B?am9yYlcwS3B2enFxS2tlZFVwNWM4RVZRQ2dxV2dzR1FVbDN1YS8vN25p?=
 =?iso-2022-jp?B?M0tWbWxLVlF4eDQ1TFdEWk1JWmhYdTNoWG02cEFRUGoxMjRCL0xiRFU4?=
 =?iso-2022-jp?B?T0tZS0ROREZVclZ6TlA2enhzMUNQZTAxdE01NzhnTmVicHd1dVFwRFA3?=
 =?iso-2022-jp?B?MDBxaDB5N0k0djA5Slg5RlNjMkxmcy8wY1M4Q2Q1THFHU0x0TlBkTjk4?=
 =?iso-2022-jp?B?ejM2RGZTM2gxanlUWVVDN3F0MW5EWW1pZFBDU2dRL2h2UmxQWTJhMXpl?=
 =?iso-2022-jp?B?czlTc0VIRXZlRlNvbm5RbXNDVlVBUjdGNUUrVW84TjVXbk1sb05pK1NX?=
 =?iso-2022-jp?B?aENGNmIxWmhMcW90dEw4Zmd5eStSaEpTNlRNV2M2OEZPYk8yUjYwcmt1?=
 =?iso-2022-jp?B?WWk1L1pMb3F6Y05NeFQzRGlKYWFIUE0vbUQwNkNxd1dDVWJMSlRGdUcy?=
 =?iso-2022-jp?B?YTdnNFFhTm5HVWhJdG9uSGpxRHM0UXBjbk5Ud0J5cExZbE1rd3d0VEp3?=
 =?iso-2022-jp?B?T1owTVB3OU1PSlNQOXdIZWtkd0I0SHVOc2FQMGRRcVpRSDcwc2FmTVQ3?=
 =?iso-2022-jp?B?Smg2SndFdlFEeXBvL0U3TGVkTkFQdVc0elJvMktDTWVpSFJKaENGd0lv?=
 =?iso-2022-jp?B?QndsWWNqVWl3ODdoOG9MS1hnU1k2ZG1WZngvb0xoQU5DZWc4NVRuVkdZ?=
 =?iso-2022-jp?B?TT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?THpNWnR3Ylk3QXhoV3M3aFNaOU5Wa0ZubFlBL2h5eUo4WEZDaDQ5bVpv?=
 =?iso-2022-jp?B?dVI1ZERZYnFrMnVYTkdScVhaNWZzd1k3U3ppWmcrTENkaTIzUXRZT3lT?=
 =?iso-2022-jp?B?STYybFJPaXFnQm1ocmhBUEx1L21BbGh5ZkN0NnJITXJiT0RoUU0zVURR?=
 =?iso-2022-jp?B?b1oxWm1iSlBoMUV6M0htMFVWSG5WdW5xdVBLdUQvZ0NTWkU4cWI2YUR4?=
 =?iso-2022-jp?B?ZFFZTFVRUm1QZXg4ZGlCVHFobHhTNVhmb0xEYm9idG10d0FOcmRUVTJP?=
 =?iso-2022-jp?B?QWt5a0s1eWkxVFdTbkxvVnhORGRnSk8vTm5Gbi9FR0hLQVJldWxJZEZQ?=
 =?iso-2022-jp?B?UGc0NWUyeEUwWlJaZXJlU1VtOGoxRXUyTlA5Qm1WVTV3bG1Md3VOT0Y5?=
 =?iso-2022-jp?B?c3pKOVJEanN0eXNiNHRaQlAxc25qeWlnaWJCQjlWdTRIVnJIdGJLcCt4?=
 =?iso-2022-jp?B?VUMyZGtjRHVvWjZVQnBCaHNsLy9McTBxSTAyUENoalgyUENlS1ZJOHRC?=
 =?iso-2022-jp?B?M1ZXZS9EaWN6bzdsV0haV0dIMGo5cWYrTnFEbU9DTW1wSnVROVZVTnFC?=
 =?iso-2022-jp?B?MmZOd1E1WlUwamVBZHVnZU9BTnZaOFNNRHBBUm82d0krQTNTa2FwQXdj?=
 =?iso-2022-jp?B?ZmNwRWxHa1JmUHBZekd0ZEpUSEdQVGFONlJ5NzVmVjVsNWtXY3FNMUls?=
 =?iso-2022-jp?B?YXZGaitiSTdDOWt6bW41cGR6Q29BU3JMTG84NEtiSm9acW5JRkdxNG9y?=
 =?iso-2022-jp?B?S0MzZkYvZW40b082UEVUcnBNV0hqcTZ6RGNVcUR4RWVmQy9IdFpPbWRM?=
 =?iso-2022-jp?B?YkhIR05NNGh6ajE2UVlxQ1BXM2JpOVBPTkVaN1dkR0gxamxZR1c4Yzdm?=
 =?iso-2022-jp?B?L2M1V2kzQWdlTXFmbkpONmw1dEVQOTBIcXlybGRLTGdBM0syQTdOYlRy?=
 =?iso-2022-jp?B?aU1jQnFNVmV4LzZnekk4cS92ZGRrNW56UGpWK05LaXppSEJESFk5cFYz?=
 =?iso-2022-jp?B?ZFhyRGRTdHNvdTR2aTY2ektlYUk2SG5FcW1STVJ6dWYxZ1F1eW85ZFBy?=
 =?iso-2022-jp?B?cE9qZ3JWMTMzY2poeExwVUp2YlZ2UkhSeGRMZkJRSldUY2dxUHRvSUtN?=
 =?iso-2022-jp?B?NU1jS3RmR3ZkR0N2STFPa2JTRjhabjNmSFpDZWF1b1pnQllPWUdkUVhN?=
 =?iso-2022-jp?B?K2N0aVc2Yk9jODZlYnNkUWpiM2JvVHoybXloUEtQMlV2MkZlVWFJOEZZ?=
 =?iso-2022-jp?B?T21DeDhHY3oreWJ2aTJ4VjVVVmNUTnVIZkozRFJaa3BmWWE3WERYUnor?=
 =?iso-2022-jp?B?bUlwY1ltSEg3UWpqR1NqVHQ3ZDhYRDV6bUk2ZXRNNnM4NHg2TXkrK0hp?=
 =?iso-2022-jp?B?YVJ1WU9rbW5OWFE5T3NzLzArOVFXdldOMGlGa3ZoV3RtTTJQa0RoZzNo?=
 =?iso-2022-jp?B?NGpQbzRhdkNHNW9NSTRtOE04MnNjcFVVbEk1bmFyNmpudWxHMW1ubDhw?=
 =?iso-2022-jp?B?a2FjMTlwWlhveUZpZm9xRTBvcElLYmF4YURiMXFPQUJuTnl1dWpUdXBp?=
 =?iso-2022-jp?B?NGpGRVRDM0x4QjJKU1NUUVA4bmd0Ui9ScDFCMmlJOGFzOFBEeVZnNzg5?=
 =?iso-2022-jp?B?TUI3L2I2VUlhRzZqQ2xIWkZPcmRuZTBJUVU2WVRBOTVyQTBpQlNwUWFK?=
 =?iso-2022-jp?B?QTBTc1Y5Umkrcm8yeEwrVEoyQlRFa2krUDdPK000Ny9YbkIxRmlZN2hH?=
 =?iso-2022-jp?B?NDZhNmJlbHpxOVE4Lzltb1RaSjhhU3RGZnl1T3BSYUVqZ3A2ZHRGdi90?=
 =?iso-2022-jp?B?VDVwcnMxQUxhMEZkN01VSFlqVjlmZk93c3l6ZnFIRmZDakZKbHgzb3Nv?=
 =?iso-2022-jp?B?Y2xCZVhnZTBOMWlGU1A5Q1Z6WEJYejVEQWtvT3cwRUNBVDF1NEZMd0pS?=
 =?iso-2022-jp?B?TUJpdlVyQW1LRllCL2M5L3p3SU5oNWhoNFhZL2UzM1o0YTNadTh6TDEy?=
 =?iso-2022-jp?B?VTN2cEdTeUc4cE1DOTc2OEVXZWdVYmFmT00wcXZHMzJOOGZzZVBDNjdB?=
 =?iso-2022-jp?B?M2VaU01IVjR0N0VCVHJ0YXNIL3ZUK2NsR1JNQW94NkVoNDU5QUwyTmVu?=
 =?iso-2022-jp?B?MmZLMGt4by9razA2blI5b2w5bUFVblloYllxTlc3dzFmQkpCK1hqNWxP?=
 =?iso-2022-jp?B?eDFPdmJ1aFlOTkIrSWUyY2p5ZEZscWplTnJaalhlOFhwK3RwWnhVeDMx?=
 =?iso-2022-jp?B?RitHZlNuVE5ZZHk2cm05bzg4RVUvRTJWQVVaREtVWFRCRzRrcVBYVG54?=
 =?iso-2022-jp?B?bUloRk13b0c5WjhiOXF1bE8wSWFXd2lWelE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8413026-4b75-40f8-4e8b-08dcb2048c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 08:32:58.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTpqe7vu9ucaLhH9fnF6XDS5YbdXUCO+Pf4GjuSh8rf8YJUY+YGVRjcePsglsg+DAt0T+osenexL2edYuhhmA5BeOH/sAHQFfIYobJeT0Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5839
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Aug 2024 08:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16702

Hello Chris,

This issue is seen not only rollback cases but also in normal software upda=
te scenarios. Example: https://lava.ciplatform.org/scheduler/job/1176650

I see this issue happening in denx and siemens lava labs. I guess there is =
some environment issue in their lava labs which is causing this system rese=
t.

Regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com>=20
Sent: Tuesday, July 30, 2024 7:19 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Subject: RE: Sporadic failures of swupdate tests

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Thursday, July 25, 2024 9:01 PM
>=20
> Hi Chris,
>=20
>=20
>=20
> The issue I have seen in my local environment is regarding TPM errors=20
> where sometimes I was unable to boot due to =1B$B!F=1B(Bcan=1B$B!G=1B(Bt =
decrypt /dev/sda6,=20
> rebooting due to panic=3Dboot argument=1B$B!G=1B(B -> https://gitlab.com/=
cip-
> project/cip-core/isar-cip-core/-/jobs/7326477318#L124
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-
> /jobs/7326477318#L124> . My local environment is not LAVA environment.
>=20
>=20
>=20
> The actual issue which I was mentioning regarding ,
>=20
> >> For example, In this job
> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667> , it can be=20
> seen the system is being reset multiple times in the middle of the=20
> boot process, finally leading to a boot time-out error.

According to the log there's no input from LAVA at the point of reboot.
The log is all green, which is showing only the serial output from the DUT.

So perhaps the qemu machine is rebooting itself?
Or perhaps there is something wrong in the LAVA env, but it seems odd that =
it's only occurring for the rollback testing test jobs?

Have you ever seen this issue when not using the tpm or swupdate test cases=
?
We need to narrow down the specific environment where this issue is seen.

Thanks, Chris

>=20
>=20
>=20
> This issue is occurring quite a few times recently and I have never=20
> seen system getting reset multiple times in between boot process=20
> without any trigger evidence even in the logs in my local environment=20
> while working with CIP security target. So, I suspect it might be a=20
> bug in LAVA. Do you also think the same or is there is any known=20
> limitation causing this issue ?
>=20
>=20
>=20
> Please provide your opinion.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda
>=20
>=20
>=20
>=20
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Thursday, July 25, 2024 10:32 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
> Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
> Subject: Re: Sporadic failures of swupdate tests
>=20
>=20
>=20
> Hi Sai,
>=20
>=20
>=20
> In your email to Jan earlier you said that you've seen these issues in=20
> your local environment. Is this local env also a LAVA environment? Or=20
> is this issue also reproducible outside of LAVA?
>=20
>=20
>=20
> Thanks, Chris
>=20
> ________________________________
>=20
> From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-=20
> tsip.com>  <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> Sent: Thursday, July 25, 2024 1:14:43 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: cip-dev@lists.cip-project.org=20
> <mailto:cip-dev@lists.cip-project.org>
> <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org>=20
> >; jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>=20
> <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com> >
> Subject: RE: Sporadic failures of swupdate tests
>=20
>=20
>=20
> Hi Chris,
>=20
> Currently Swupdate, Secure boot and IEC layer verification jobs are=20
> running in CIP LAVA Lab from past 2 months. Recently there are some=20
> issues rarely seen while booting the image where the system is being=20
> reset multiple times during boot process leading to a timeout error.=20
> It is not like that particular lava slave machine has an issue because=20
> the next job running on it can see successful boot. This situation is see=
n irregularly.
>=20
> For example, In this job
> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667> , it can be=20
> seen the system is being reset multiple times in the middle of the=20
> boot process, finally leading to a boot time-out error.
>=20
> Do you have any idea about this ?
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
>=20
> -----Original Message-----
> From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> Sent: Thursday, July 25, 2024 11:46 AM
> To: Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>=20
> >
> Cc: cip-dev <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-=20
> project.org> >
> Subject: RE: Sporadic failures of swupdate tests
>=20
> Hi Jan,
>=20
> I sincerely apologize for the delayed response. I observed these rare=20
> TPM errors even in my local machine during development and testing=20
> with security target even though we made sure to run one security=20
> target at a time on one lava slave machine to avoid any TPM related confl=
icts.
>=20
> Currently I do not understand why system restarted in the middle of=20
> boot here -> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667>  and this=20
> reset is happening irregularly at random times during  boot.
>=20
> As of now I believe it has something to do with the state of the slave=20
> machine on which the test ran in that moment. I went through the list=20
> of all the unexpected failure jobs till now. Some of them came under=20
> 'LAVA Bug error' and most percentage of the failures came under the=20
> category in which system reset is happening right in the middle of the bo=
ot process.
>=20
> I will discuss this point with Chris, and I will let you know the=20
> issue as soon as possible. Once again sorry for the delayed response.
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com> >
> Sent: Friday, July 12, 2024 7:10 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> Cc: cip-dev <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-=20
> project.org> >
> Subject: Sporadic failures of swupdate tests
>=20
> Hi Sai,
>=20
> where are these tests actually failing? The also reporting that they=20
> are unable to clean up the jobs properly, but we rather seem to have=20
> TPM
> errors:
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732647731
> 7
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732647731
> 8
>=20
> Retrying them sometimes "resolves" the issue. Can you check if there=20
> is a way to improve reliability to avoid any false negatives? Or do we=20
> really have problems here?
>=20
> Thanks,
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center


