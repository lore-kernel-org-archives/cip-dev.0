Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD913C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 17:02:18 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.3])
 by mx.groups.io with SMTP id smtpd.web10.41432.1721926935949593050
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jul 2024 10:02:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=UttLyoDN;
 spf=pass (domain: renesas.com, ip: 52.101.125.3, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMcduLeziQc6GXZXLOl/rX+3oAxz/ZAqCdDWBzf/xlraKQfu7H60iugA05EKvZxxMjO0vdJxW3ivGTmTbXhzj+0HDwMj8nXTybWmU2rdnIAMpF3xZszdPA3I/XpGFgTBbA4TVHs3/oxpFsKCHJiLpTWXNscCHBN1ELP28YX1kc4Mnru6JcI5B6BZKfUVPx1vMAp0Ysuf7akzOuA/oGGv02zIVX8lDM7tRjo2rRAap4BFJz6E5pX/trwvBJkQyZ1WBjUfUpdKZb03YMxLl+7aZAahQcSVXek8/OuJnsk9maZpi1wc2fiIHz0etgobhLynjJSWnmJtALf9riivncimhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzZiZ4h0I8YKSHETBoANAaCQ8tf/f48jLezoYxem7wk=;
 b=Jfw6Qop8zW1jameI0zOVqYC85bMU7EiOJdOoXvkXXeliUcv1VbHc9+5s1et0j1ul2dj7cFx5UOb0x5I44aPv9xpRzHHp7emkWNT6a0MiBVtQrIqgNf3uYRU4B8d81uxeloQwCp63Nb7CkfXpwyutLCgRxYnd93crfxD4tyB8EthienfLoTRULGzTAN2G80j4cfIpVV9fli7fUdypQHtKedNkAf2Qvp9i7yJgjCXGRJerbjjWJ7HBPBk/I1LsYf6/n0xSAhPTVYwFnm9nmHoxdlBaEZTfU5YUCaxgzrvYA8jSj9W0Q26hNWSxpupAdlZKBVp0URR0Oiev+DCnD/ykBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzZiZ4h0I8YKSHETBoANAaCQ8tf/f48jLezoYxem7wk=;
 b=UttLyoDNI23wqRMdmi14NrkuA55fNp526/pSb1q+UjHYalCQ9q/SFjwk82wDrig0nsII96q5BRDCkAdmh0m0xtXfexXQhLS4mlgOPMvCZ4/SghheDnDmRw+Z730OqrUxzsNx3ng5NtpqYWruomjMyfoYncOYOa0ENo3nB5nrfxo=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TY1PR01MB10786.jpnprd01.prod.outlook.com (2603:1096:400:327::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 17:02:11 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 17:02:08 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: Sporadic failures of swupdate tests
Thread-Topic: Sporadic failures of swupdate tests
Thread-Index: AQHa3oxAzZtSl/BbV02mWx2BKqmCqrIHagjq
Date: Thu, 25 Jul 2024 17:02:08 +0000
Message-ID: 
 <TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103DC424B825831970AA3F9C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103DC424B825831970AA3F9C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TY1PR01MB10786:EE_
x-ms-office365-filtering-correlation-id: 902db56c-7a28-402f-073d-08dcaccb84cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aSsxN2JGcTJtL0RaMjhrRTNEb1c2ZHBJeWJBbTh4WGtVZmV5UzRkZ1pu?=
 =?iso-2022-jp?B?K2M2aVdSYXdEVThUVmM4dC8xSjRMRHYvYTh3SEQ5bmZvN2dVZGhrOU1y?=
 =?iso-2022-jp?B?L1BuN3FyNDJsblllY041U2tNdGdXMTZ4VEV0ZnlwaHFDTm1YeUVLNzRs?=
 =?iso-2022-jp?B?TWFYMXhpOURmeGEwOG1vR1BSV1pOV251U2V3MDBQT0M5WTFGRDhJV3dT?=
 =?iso-2022-jp?B?N3ZBVlh5bEFmVmg1dWVWamp4VnUxMll0eFY5ak5kMWNqZm1sKzl6dGd3?=
 =?iso-2022-jp?B?OExHTDFDVTgzTkVSai9IRDdEWXdmVTV2UXlFcHBCWm1nYUQxNDdVeStQ?=
 =?iso-2022-jp?B?OUNnd2JyUEx6VEV5S0psT2JiZWtzQ0t3R1ZyVEdoY1J2NmtWLzgvOGlH?=
 =?iso-2022-jp?B?cjA5elc4V0ZrbjVxNmFQTlQ1QzVYWVlWb2RSOUlTUHRZNFp5eXpDYVJp?=
 =?iso-2022-jp?B?OFN3ZWMwUjdvQTNmUUlXQzZTcm94cC9MUVlqeVV6YXNuUm5CU0FtL3Qw?=
 =?iso-2022-jp?B?ei9YSTBRaVdMYTh6OHRaQmhzSVlFOGFua1g1R291RmxDWENBc0xVdmRm?=
 =?iso-2022-jp?B?cWhkV29vaFhVWkpRZ3lkcU92RUtDWWZJM08yYjZYM0J6elpzbU9VekVy?=
 =?iso-2022-jp?B?NFZYQVk0QjB1dHVvUzFpQ2tXU25TRTBnaW5IbWtpVTBzYUNlSERtQkNv?=
 =?iso-2022-jp?B?andCYXpvUng3WUZqZTdQdVRzNGtnWmpycTFxNzRYWUpFQjNhYVFER0Fu?=
 =?iso-2022-jp?B?RS80Y3BPeTZBN0UwRXA1LzdObEh2clk2aDN0SE9FcTJPYnB3dTV6aWpY?=
 =?iso-2022-jp?B?TThxNHZNaGhHbjJITE1ha3VPNGVENHdYT25YQ2I3bWFRTjN2SVNmdDFO?=
 =?iso-2022-jp?B?MDBsRG14aFpUZGZuaGFjbjBDSXhqM3EwYTVYQ2tCRytTZXpUUGJxUUhi?=
 =?iso-2022-jp?B?NDRpYkpDcGtWR1Z6U2NRbVdUQlJ1S1c0ZklYTnJkdjlBcHVlSTNTTVI1?=
 =?iso-2022-jp?B?UG9VNURzWVBxNXU1Tm9tZm5MV0wxeVpJRzhnR2RWNzN5WWRRdU5RTkl0?=
 =?iso-2022-jp?B?U2hvcFMrY010RFRaamhGdXl6YWk4OWtwV2taVmtuNDc1cEh4RnhZMUtz?=
 =?iso-2022-jp?B?M014aGlramtDYm1VVWJubDQzMmFYR2ZrMmI2R2xoVVBqOHhrRXdBb2NU?=
 =?iso-2022-jp?B?SUZDdjg5RkVRMjBVSm43Yi9VdFRMMm0vS2pSZ2traVpoOVJzcmFsY2Vx?=
 =?iso-2022-jp?B?K0hoRmhwbnRyTVJxak85MFRvNTQyTHF3NHNiMGVUOGNKWVFtQ3U0MUJV?=
 =?iso-2022-jp?B?TUtpeWloMHdFdnl4UVQrUDkyMnhUWlhpekFiWG1va3Avby83SE1GOVRx?=
 =?iso-2022-jp?B?bGpEcVhFR0k5bzlUcFAxV2ZaT0xHdDRCUGYraUFkbW9ZaFhITzZnREFt?=
 =?iso-2022-jp?B?RmlGd1BlbHh1ckRJellURWJtbUZFa0RCc1ZmSUZpY1RTOVNVejgyR2Jz?=
 =?iso-2022-jp?B?SGpmRVphanhNQWx5RTdzZ1kxdG1JVEZ3UWhkc0gxV3ZRYVNUZFFTUTFU?=
 =?iso-2022-jp?B?aCtJWUtYSzdLWWw2WUlzTlZlUkhOUDZKMXRWZGM1YWp5TXhtZnRGRWpk?=
 =?iso-2022-jp?B?MllOaGRCR1kzTUJzTVNqTVBSQVAyVUFkTWkrczR3UDBGN1FOcGxtOHZp?=
 =?iso-2022-jp?B?QmlRQmtjMnFtUW1NZ2FqVTZieHdXWG54bVJUR1VYWkZ2NTgvblZocE9a?=
 =?iso-2022-jp?B?cUtmdjZBa1R4eVQrVlVBZnZiT2ZaUHI2TTJTR1oxUXBaZG4rWmxiejV5?=
 =?iso-2022-jp?B?VzJGSWd5UWVlMStRN2RDZVhIdnFvY3hVYU5VUWpDdDJRZ2xYN2JNS1ow?=
 =?iso-2022-jp?B?YnRCL29zeE5JNjZ6MFd2UC9saVo4RXdESGpySnhJT2NkbFlFUEtieWhE?=
 =?iso-2022-jp?B?cCtMQmRBaGNwU3RhY0Z2ekpwZjFubkJteUFOOWwwQWIzbS9NQ0plNDZV?=
 =?iso-2022-jp?B?UT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YlVlUjdIeXFTcjZ0dXpTK3JRRE1hckpOdkJwNXQwcEQwMjRROEEweWI2?=
 =?iso-2022-jp?B?ekk5VXRVdFJCM3JJaXJpQXRnaXoxRGRFdmV2L1Y0UG42MFNZd3dPRE1P?=
 =?iso-2022-jp?B?S2RrMnlUSGZKV3U2NlEwN0hkUGk3TmN3Wkw3ZG4vR2xlbE1OQ1hiQUk0?=
 =?iso-2022-jp?B?SDVkTEVBL0dETUV5SWs3WVdYNFR0am43R0RVdjR5MWZ4WlhrcklxNzVW?=
 =?iso-2022-jp?B?a0Nhd0g2cHFaOUdkbkpZN0ZoSzZLelZHMFRkVmtXQVJwT0hhUU9ISVo1?=
 =?iso-2022-jp?B?WXBHczFLTGtrclFiUVlrYmVnTnJUV0RGbTFOVFRqRDJQUnRHRmRNditQ?=
 =?iso-2022-jp?B?cytJeUR5R3dIaUxrU1ZsK01abzlkbUIxSC82bEgwRTA2RWU3elZJbDVL?=
 =?iso-2022-jp?B?cW5KMzBPZ1MzZ1VidUlwUHQ2MEFzN1ZLa1NVRnM3Q21uMktqUjMwQXhW?=
 =?iso-2022-jp?B?QkRJYzcyN21DNngwZGQzc0o0WjRDc29oWGp0M2JZYkFDdDlkWWhMME9J?=
 =?iso-2022-jp?B?eW9XaGhlNGVCelNoSWlzUk1MZnRCbmV3RjhYSWxxWlRuMnRhdWtkNVl6?=
 =?iso-2022-jp?B?ME5LK1pmSHE5eUFaZElsdnVBeWJWbmEybUJ6TUZOQ2RmVVUxZ1l0SGsz?=
 =?iso-2022-jp?B?bmdhQUZwMVR2V04yeXJjcHBZbjlEd1lrWEM4SCsvWWhnQzM5dFRBYmhm?=
 =?iso-2022-jp?B?eldzSzc1UEoySXhsaGUrV1MwWEUyekhrNWxKVkluVmZpRWpYVnI4Z1BI?=
 =?iso-2022-jp?B?UXZtalk3bExBZVpRbDU0RXRtUVV3Y3c5d0NqTmc3N2xxd2h2Y1o4c3Mw?=
 =?iso-2022-jp?B?SENBMHJCUm5ueTNoM05leTMrbm1FM3JSUDdKZDNxUWV3TEdtdHRlMCtt?=
 =?iso-2022-jp?B?QmpTekhDS2JSZzNrbDBLZ04zbWtTL1Uxa3JOMkFUazdrdTNPQk9Ic0cz?=
 =?iso-2022-jp?B?c2thS1RibHg5MTRldXdsQUZCZVR4U0kvWkhGOThUODRabmdzMEZTMnlO?=
 =?iso-2022-jp?B?M3VWNVRRWlJDcms5d2VzM2xCSW53bWs2YnluaHJvU1VvTFJqcitMam02?=
 =?iso-2022-jp?B?N1I2RzRwenFXTHlhWnMxdjRQblNsVUw0dk42OCtzdmtJVzlyb1NZcm5j?=
 =?iso-2022-jp?B?dThDRVcxTno1cVM3anE2ODVWdzFuTVdwN1BDdjNud2F2alZiUDFsUkxX?=
 =?iso-2022-jp?B?OVc4R2VRbVJOY0p1ay9xbnZXTmFScDNraVVLemV0aEpYMVhRS2E5SlhK?=
 =?iso-2022-jp?B?eTRTRDREYis3bVFyeVpuSUNqNTBNWm5qMkYxSExpMlBHNnVsQnhzMVRr?=
 =?iso-2022-jp?B?cTFSbm1HV1pYUUxnNm5lWGhkWldZSlV2WE9aNU5MRzUvdlJxd1FjYkFT?=
 =?iso-2022-jp?B?V05BdTh3ajV4WnZrNzUvWXBTSnhzbXIyY1NUeWprRGpWQnZNQWxCWjN1?=
 =?iso-2022-jp?B?RS81ZnNFdDFPb1FlbXlMcllkTnhoWnVUTUgvZnl0MUs2dmt4a2F6dXlq?=
 =?iso-2022-jp?B?ZXRSNzRQYXY5S2k4aEtWdXB3TjlNL29SRGN1MTZ0bGlVdVVDd01XRCsw?=
 =?iso-2022-jp?B?dU9aSzhTd3NuTmp5cHJYazlpNGpmek4vZXNWZzZLbThhbmZHWWE3aEFH?=
 =?iso-2022-jp?B?UkEvaEJMNHNtTTJka2hXNjNocHlxM0ZxUGplZG9DSlU4SExjRWlPWFR0?=
 =?iso-2022-jp?B?RVNwQVhieVh3MmF0a21LcjZZNFVPNUVINFh0Q2dsRVF4MUpRUWRzTEx1?=
 =?iso-2022-jp?B?cGVia2ZlTkxUYnNnV1pYc1E5SVZSVVAzc0NHNDNOZVQ2SFVQM2xzVnFy?=
 =?iso-2022-jp?B?Z3BBaFhLSVdCNTJmNXhUUjJ4d2tna0FDZlp2YzJwVzNiNmFXOHI3SThY?=
 =?iso-2022-jp?B?ZVJnVjhHditTZ2w0Wmp4NEUzOFNieHNwOEc3VDYrQzN1TExhclpLTTBF?=
 =?iso-2022-jp?B?QTkzakVWeWxqdTFWS1MzamdEc0dBRHVnUDdsd05udzJiVW42TzUweWVP?=
 =?iso-2022-jp?B?YjdqLzBZSVFpSjBvNUhjY2RFOWJyenVIZ3VWWFhwYmQ0amlPZkl4Myt4?=
 =?iso-2022-jp?B?ZkxWQmFHS1hUZWV2NHNwK1BlUW02czc4YjdwQXVMeEZ6UDBtZE5uMHRX?=
 =?iso-2022-jp?B?blhiUThPb2JDdlNxRTBBRmxkYldUYlpCR2d2QUk5L1ZuZTFWOXhNZndl?=
 =?iso-2022-jp?B?T2R6dXhiR0g5Z2VCeU54eU15Y2pVK0hmbDVQUGJqRkhOWHoySXh6YnBm?=
 =?iso-2022-jp?B?ejdQVE9zUHVPUytRZTRNekxZaWt3Ylp6SUNDeDY5S0F4MW8rU290dERk?=
 =?iso-2022-jp?B?eE5PSVVPVjFmZmo2WGFVLy9LTGlhM1FVUW1ZUEJJSGRzb0ZuWndacWRB?=
 =?iso-2022-jp?B?czNMVGc9?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2TYYPR01MB12402jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902db56c-7a28-402f-073d-08dcaccb84cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 17:02:08.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1zDKxvZY0xjnc9RO2MUgEQjdGz5Ri/6W88qCgbtbI/NDcUXQWUdwtZqAUyrp5fm+qp/nGkTFk9s545ur8Y8P0sngPCV9mTJP1OCRbkqdtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 17:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16626

--_000_TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2TYYPR01MB12402jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Sai,

In your email to Jan earlier you said that you've seen these issues in your=
 local environment. Is this local env also a LAVA environment? Or is this i=
ssue also reproducible outside of LAVA?

Thanks, Chris
________________________________
From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Thursday, July 25, 2024 1:14:43 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; jan.kisz=
ka@siemens.com <jan.kiszka@siemens.com>
Subject: RE: Sporadic failures of swupdate tests

Hi Chris,

Currently Swupdate, Secure boot and IEC layer verification jobs are running=
 in CIP LAVA Lab from past 2 months. Recently there are some issues rarely =
seen while booting the image where the system is being reset multiple times=
 during boot process leading to a timeout error. It is not like that partic=
ular lava slave machine has an issue because the next job running on it can=
 see successful boot. This situation is seen irregularly.

For example, In this job  https://lava.ciplatform.org/scheduler/job/1164400=
#L1667, it can be seen the system is being reset multiple times in the midd=
le of the boot process, finally leading to a boot time-out error.

Do you have any idea about this ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Thursday, July 25, 2024 11:46 AM
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: Sporadic failures of swupdate tests

Hi Jan,

I sincerely apologize for the delayed response. I observed these rare TPM e=
rrors even in my local machine during development and testing with security=
 target even though we made sure to run one security target at a time on on=
e lava slave machine to avoid any TPM related conflicts.

Currently I do not understand why system restarted in the middle of boot he=
re -> https://lava.ciplatform.org/scheduler/job/1164400#L1667 and this rese=
t is happening irregularly at random times during  boot.

As of now I believe it has something to do with the state of the slave mach=
ine on which the test ran in that moment. I went through the list of all th=
e unexpected failure jobs till now. Some of them came under 'LAVA Bug error=
' and most percentage of the failures came under the category in which syst=
em reset is happening right in the middle of the boot process.

I will discuss this point with Chris, and I will let you know the issue as =
soon as possible. Once again sorry for the delayed response.

Thanks and regards,
Sai Ashrith Sathujoda

-----Original Message-----
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Friday, July 12, 2024 7:10 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Sporadic failures of swupdate tests

Hi Sai,

where are these tests actually failing? The also reporting that they are un=
able to clean up the jobs properly, but we rather seem to have TPM errors:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477317
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477318

Retrying them sometimes "resolves" the issue. Can you check if there is a w=
ay to improve reliability to avoid any false negatives? Or do we really hav=
e problems here?

Thanks,
Jan

--
Siemens AG, Technology
Linux Expert Center

--_000_TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2TYYPR01MB12402jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
</head>
<body>
<div dir=3D"auto">Hi Sai,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">In your email to Jan earlier you said that you've seen th=
ese issues in your local environment. Is this local env also a LAVA environ=
ment? Or is this issue also reproducible outside of LAVA?</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thanks, Chris</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sai.Sathujoda@toshiba=
-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;<br>
<b>Sent:</b> Thursday, July 25, 2024 1:14:43 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;<br>
<b>Subject:</b> RE: Sporadic failures of swupdate tests</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Chris,<br>
<br>
Currently Swupdate, Secure boot and IEC layer verification jobs are running=
 in CIP LAVA Lab from past 2 months. Recently there are some issues rarely =
seen while booting the image where the system is being reset multiple times=
 during boot process leading to
 a timeout error. It is not like that particular lava slave machine has an =
issue because the next job running on it can see successful boot. This situ=
ation is seen irregularly.<br>
<br>
For example, In this job&nbsp; <a href=3D"https://lava.ciplatform.org/sched=
uler/job/1164400#L1667">
https://lava.ciplatform.org/scheduler/job/1164400#L1667</a>, it can be seen=
 the system is being reset multiple times in the middle of the boot process=
, finally leading to a boot time-out error.<br>
<br>
Do you have any idea about this ?<br>
<br>
Thanks and regards,<br>
Sai Ashrith Sathujoda (T S I P)<br>
<br>
-----Original Message-----<br>
From: ashrith sai(=1B$B#T#S#I#P=1B(B) <br>
Sent: Thursday, July 25, 2024 11:46 AM<br>
To: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
Cc: cip-dev &lt;cip-dev@lists.cip-project.org&gt;<br>
Subject: RE: Sporadic failures of swupdate tests<br>
<br>
Hi Jan,<br>
<br>
I sincerely apologize for the delayed response. I observed these rare TPM e=
rrors even in my local machine during development and testing with security=
 target even though we made sure to run one security target at a time on on=
e lava slave machine to avoid any
 TPM related conflicts.<br>
<br>
Currently I do not understand why system restarted in the middle of boot he=
re -&gt; <a href=3D"https://lava.ciplatform.org/scheduler/job/1164400#L1667=
">
https://lava.ciplatform.org/scheduler/job/1164400#L1667</a> and this reset =
is happening irregularly at random times during&nbsp; boot.<br>
<br>
As of now I believe it has something to do with the state of the slave mach=
ine on which the test ran in that moment. I went through the list of all th=
e unexpected failure jobs till now. Some of them came under 'LAVA Bug error=
' and most percentage of the failures
 came under the category in which system reset is happening right in the mi=
ddle of the boot process.<br>
<br>
I will discuss this point with Chris, and I will let you know the issue as =
soon as possible. Once again sorry for the delayed response.<br>
<br>
Thanks and regards,<br>
Sai Ashrith Sathujoda<br>
<br>
-----Original Message-----<br>
From: Jan Kiszka &lt;jan.kiszka@siemens.com&gt; <br>
Sent: Friday, July 12, 2024 7:10 PM<br>
To: ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;<=
br>
Cc: cip-dev &lt;cip-dev@lists.cip-project.org&gt;<br>
Subject: Sporadic failures of swupdate tests<br>
<br>
Hi Sai,<br>
<br>
where are these tests actually failing? The also reporting that they are un=
able to clean up the jobs properly, but we rather seem to have TPM errors:<=
br>
<br>
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732=
6477317">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/73264=
77317</a><br>
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732=
6477318">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/73264=
77318</a><br>
<br>
Retrying them sometimes &quot;resolves&quot; the issue. Can you check if th=
ere is a way to improve reliability to avoid any false negatives? Or do we =
really have problems here?<br>
<br>
Thanks,<br>
Jan<br>
<br>
--<br>
Siemens AG, Technology<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2TYYPR01MB12402jp_--

