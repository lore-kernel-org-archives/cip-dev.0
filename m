Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83801CA0EE8
	for <webhook@archiver.kernel.org>; Sun, 14 Sep 2025 20:04:01 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.43])
 by mx.groups.io with SMTP id smtpd.web11.16769.1757880233872873586
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Sep 2025 13:03:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WyA6YXpL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.43, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obmwP2TWbqSjWj2HB3bKtYnUrn4dYZnj4BbKcGhSNq2+BFTn941vAeIgNrWMKVBtu4iEdQyyh4jHWUf6225OHJfuWsJkiuCjo4AmVPLOKSZbv9qxy3fk7j5svsGAIVhKm7eqRWaDFdEQmX5SVLWf77IxI5bC7j2oj7yqFhMCY/GJcHHpd49w0ofnyU25k2hKB5ycQFSU7H9eIii2iYy8+9XrBVGwojcd1GcmC1R52Z+Wu3acn9IBWgur2DjuVUztt+wDG6i85rT69pUuFgZYZ6y9sqYqfNNAuaSNPCtmOzWs0v2MAo0ePGSQcKa0l1//LzB8bAGMqIN2esR5ydKw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpV4i3FRnuSano8Kq0Y15UHsOpWrRZ3uuLyZPdQqZhs=;
 b=pe1LlXeg3XnoR25b0NXJPuY/td4itYQrd1B+V5EGTVj2hfBsPK9Jbm2jwOzjGDaKlehIXzjTObGgE+T0DARudwdLP6uPPaewj8G3x3I73sBgNiQCalNuXZETVi2HqBLrslVkKSzdb8m+f2DnGLtff5lHBALXdqnlAOq27JxpOe2cEP5lYA+sy7hpkBZKBvTs9spUT2gEoep2hO9D9pLe56s1vqHF9Gb1rOKTNIe5g3MNZaHUuCNg4r81PypZp+u/z8r3jp3cYx8QPw99kJhoskUb7OK6AY0ZQmynpNEieUcJfl5VwDcNqwUwhfr0F5RU6skaNM8BHt/vtGVnhzk3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpV4i3FRnuSano8Kq0Y15UHsOpWrRZ3uuLyZPdQqZhs=;
 b=WyA6YXpL+8AwnBQEmSxpJCf9V41zOSKjEHL+wctu6tSbvdzrQ2Nk7/3WKtr1sSg7i8dQ9Ux6m5v+zaM9o9JC2vCCtmNgGoaRxNwsu6K+cFQh3DjrKiTpMBm5Y9gsA7l6BAu2TCzND2VseyCu7iIjJPwVgfFlnsxuBhlS493yo8w=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TY4PR01MB14650.jpnprd01.prod.outlook.com (2603:1096:405:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Sun, 14 Sep
 2025 20:03:48 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%6]) with mapi id 15.20.9115.020; Sun, 14 Sep 2025
 20:03:44 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>, "uli@kernel.org" <uli@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Topic: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Index: AQHcEdpAOtOsp6RkJ0itXKZdfyV4dbRuCnQAgCU21bA=
Date: Sun, 14 Sep 2025 20:03:44 +0000
Message-ID: 
 <OSZPR01MB7019FA6A5FF05E33976274BCAA0AA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818DA61316867E1E352884BCD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818DA61316867E1E352884BCD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TY4PR01MB14650:EE_
x-ms-office365-filtering-correlation-id: 6503ecab-4c8b-445c-b42b-08ddf3c9cf24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dnJOVUFQeW9QYitUTFk2aWRzTC9RZ1NXbk9sU0VTWlZ5M2hLOFNNQWxs?=
 =?iso-2022-jp?B?UDU1ZTA4Q1VrdURhRWFCWWdoam80a1dJZ0VHTGRiNHc3YXJWazV6akli?=
 =?iso-2022-jp?B?eVZXQzhxOXJRckNqdmlpaTFmZzFqdFZ6cVVIT01pNFYxVzArS0pLSkND?=
 =?iso-2022-jp?B?b1hhZVliUVR3UmZRUjlmYnRUQ2tqZXREMCtoRUk0eHBST2M3RzZaUXgy?=
 =?iso-2022-jp?B?VTJESHJQQU5MOHJsMmI1VzAyV3BIcXNyOFllL1dISzRhU0lTMU9tMFJB?=
 =?iso-2022-jp?B?QXF3c1RNOFI2T3hUdk9scEkycHQyb0s3a3NCNTh3ZlIydFk1MTV6Vzlq?=
 =?iso-2022-jp?B?amlQQitQMjNTUkF2OWpOc1I3R1dMUk4rZHB0c01xQjBJSjZXbzhaNnIv?=
 =?iso-2022-jp?B?dldaOWlJNDRsZmZZek1GQVQ2Q2ViVVFZaUhpYlV2eitncFhrckQ3Z2FN?=
 =?iso-2022-jp?B?YXhSSmszSlA4OC9hRlprQmVZWE1GQlpTaGJibmtFeTN1cTJ3ZUduL2Zq?=
 =?iso-2022-jp?B?elNlUE04bGYvR0VERUZXdk5hOE91YTVpRHBpdmlFU2E2S294cjNxM0VD?=
 =?iso-2022-jp?B?RlZrS1BFcGVVbzZOZS9xSW8vNFhXY3RONUxmNkRmdnlzY25lYUwxOHpv?=
 =?iso-2022-jp?B?bldJbUtWNk42ZzNLY2VabFF0eXpUNTlFMGZNOHJVWTJXWW12SEVXSEhZ?=
 =?iso-2022-jp?B?TjdhR3NxOGl0d2FxdWxCTnFwWks4eGQxMkdITG4rMDI2T2E4Q1Fwa2JX?=
 =?iso-2022-jp?B?akNEYWJqR0NmNjJmdTkvZkpCeXNwZm9CeUFiaTM1YmY3YklnMHYwRVFi?=
 =?iso-2022-jp?B?dTFlSGVkdHltZGVreGRiYmIwbENoa2g4aWtsRndpZUxZbC9aQTJWMGVL?=
 =?iso-2022-jp?B?UnZZVmR6QmRiU2ozRitPcnQ1SlZJOHpFUXRhNGpmR0lOTFFmcUhCQ3hj?=
 =?iso-2022-jp?B?QVJFaDdZdlk3RDRpZGFoczQxTzhFVGpkUktVUFdrTTU3NDZQbFJBZ1hL?=
 =?iso-2022-jp?B?TDF3YVlOcVl1dnR3b214c1ZjOU04emttT1VjZGZUZjNSVGJMbmRxb1o4?=
 =?iso-2022-jp?B?d1BhSTJNamZLM2xSY3E1RU5wcGJsNTAzVUwrVGRFMk1JdVpnMXZlZnFq?=
 =?iso-2022-jp?B?UFA0ZHBMcStOeUo1Nk1XY2JGb1hHbVRLbGUzU2hEV2lLSy9hb24xdHQ3?=
 =?iso-2022-jp?B?R1U5bFZDbitad0p3ZHJSVWQ5cHBJUzJiVVVTSnRFZUdrUm4zTzMwQUV2?=
 =?iso-2022-jp?B?enJVS2pFZkFEa0pjMjNydGpmQUhNU1dMZWtVTlVtU1FTVjFtTHVMVm5h?=
 =?iso-2022-jp?B?OFNQcGlLLzZKNTNBNStraTg4Mm0yQ1d2MC9ZQnowMzV1OGZHSEhjbGxW?=
 =?iso-2022-jp?B?WFF3UTdPdk82cGVXdzMyRTRZWVJWQjd1MGVpMHNIS1p6NldsVXY4N2tk?=
 =?iso-2022-jp?B?MHordXdrRW9vMjZSMTNwdlp2YjA2SHd0a3htRzloSHBLcFRleGhPeVY4?=
 =?iso-2022-jp?B?WEsvU2xWQ0p0Wm1WREN1bVlPOERoaWZXV0VTZndUWTg5eDJVNDhWSFBl?=
 =?iso-2022-jp?B?SWs5RE1lUUthMlpndU56R01weWVhSk1uY3FJQkFpZlYvOVhRMFhsT1Fn?=
 =?iso-2022-jp?B?N3BvUmdXSnFEb3VIc2l1T01rZ1V3bGt0Y01oaWpjSG5pcU45NHByeUcr?=
 =?iso-2022-jp?B?dWVBeGd1R0RuajVwaWR3L2ZxenVORDlBYUtCem1yMTY4RkMzaEY0TXFT?=
 =?iso-2022-jp?B?RklIQzZhZlRiVXp5NGJpcTdEU2tNdkozUHpBU0wzZDAwTWFDVFpqUWln?=
 =?iso-2022-jp?B?WjRyUlhTMWRWbDAwQXBudmh0L3ZnelBOdm1UMktGUTZkVHBLbFozNzNQ?=
 =?iso-2022-jp?B?bTJUMm9aZ1pxZzNoUzJFTmN3K0NwOUd4ZEtnaVFZNkdYMWYzRVZoN3ZV?=
 =?iso-2022-jp?B?b1V3d1pFUE55bkh6VnFHbzZDSzZoUkhvNGIxUDhlZTE5SEVybzBtTUJ2?=
 =?iso-2022-jp?B?eWtjSVBVL0thU0dFeEw5UmdEdmJ3VFF4NVptQVR1RUtXcDVoZnFnbkF2?=
 =?iso-2022-jp?B?bWQveVE2UHZ4eVoyK2gzRGdoV1JSdlk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WWpSNHdJYzdVUWhTTXJ6dDdsZ3dNSkVOTGJER3JRKzZVWDcwYXZWRWJj?=
 =?iso-2022-jp?B?TWZ2L2xzTHNIbThQdmY2NEJtQnV1TlBicHpxS3ZONWR3Q3NENXkvVTRn?=
 =?iso-2022-jp?B?ZFNlUGZuUDAzTWxhR0RJK1doTEcxcnBoMXFrU3RFL3F3NjVvWkJsRmRl?=
 =?iso-2022-jp?B?OXFpQ012QmROOWxZQkVXZmVoL2JQSzlKb3RoYWp1UW5MN1hXd0UweGxF?=
 =?iso-2022-jp?B?ZGZMNUFEYzVHSkFXWlJyelI2QkxMUFZHVk4wRjQzY2d4ajFueDBQTXZu?=
 =?iso-2022-jp?B?VDlKU1JFQW5haU1aRzhDOFc3VkJvaDBWYy9YU2N4NlVSSGd3UUNyNXl2?=
 =?iso-2022-jp?B?WWNaSjhRcnhpNHdZK3JSVnJ5MXlSbWNVQkZrcHN3RGhadm0rLzJpdUZN?=
 =?iso-2022-jp?B?bzFkaXJQc1lPbzhMWWMvN0NFQ1dRcmxjSEZ0eG1UdjVmRjFxV2NsYkZI?=
 =?iso-2022-jp?B?V3o3cVJKY2NGSllkTFkrbTdRK1l2aVZVUWtHQlNNWU9yVHpNSXc3dTl2?=
 =?iso-2022-jp?B?ZkQ1MTF0UE9hTnd2Rm5qaURHRlRmMVVMNmx0YTA5ZCtQSFpFaWdxa3Zk?=
 =?iso-2022-jp?B?M01UMGEzMlhFRTRwQzdsS3VFS2dHV3dDd05HdzQwbkF0a1BmU2dHeHJp?=
 =?iso-2022-jp?B?MHhLZG9wbFMzNVFlOE5Ib1ZOU2tya3ZSUElKMnBxc0FXNGFnb2hNZU9W?=
 =?iso-2022-jp?B?S25ZMWxkTEZkZ0NDbTlxVytHNTEyL0J0bm5BVjRoQXExNUFBMnRZcXJs?=
 =?iso-2022-jp?B?R1RiSWJLa1JHcWpuaTNITDlTQVVRZkF5L0lGaWJiM2lCS3JHalgyUVQ5?=
 =?iso-2022-jp?B?d1pGN2wvbzM5MnF6bE1WZUVnalZWUTl0UzhEL3ByVjdNdFBYVTR3QkJT?=
 =?iso-2022-jp?B?YXZneUZBVmFCVjQ5YWZCbXA4dHFPamZ3TG1sTjAxZW00L0YxU2JPWUdk?=
 =?iso-2022-jp?B?S283NDhsZGhSa0ZyMmNPaTVHaC9FamMxNXJRc0JDcEhVK1pBcjFoNTBI?=
 =?iso-2022-jp?B?b21nY3dRSVJoK3g5d3NZUnpWd3Z5TDlVU2JOTjNYOHhMV3VqdTF3UXRN?=
 =?iso-2022-jp?B?eEtoblExN3ZRdEc2bXFxSFNyV0dtWVkzVjNTWm0rdHdEbUlsWUVaU1da?=
 =?iso-2022-jp?B?RVRlTmc5ZHNGdU0rVkZDc3FEZmt0S3RDSCtxTWdVbkNwenVwZUI4cmtT?=
 =?iso-2022-jp?B?VU53bXEwNm0yZWJCQUtFeHM1SWVDbVExYTNEUGpyVHc0em1TTjdWeXda?=
 =?iso-2022-jp?B?UzBxbFRCak9nWm1yaW03QXlHM3Q4V1l1aUh3Y0w4bmJ3NFdOSzRHRkxT?=
 =?iso-2022-jp?B?RDhBSXcrOS9RS0J4VFZPVHhEdFdpcTNYb3pJVDJUbDdwSTdobEs1UFlB?=
 =?iso-2022-jp?B?V0NJWWNtaGowZmQvbU5BQjVkZEs2V3FjNVBibnhHU1JoV0xTUXdJR2lP?=
 =?iso-2022-jp?B?UGRzUWNvRnI0eDZRV1M0OWxLMERtNUZieXljb0w1T3d5Uzk5UVVxZlM5?=
 =?iso-2022-jp?B?OUxkRFVVU1diMW44UXZMRjJrOCs2djRxWU85a2VjNWtFYThQV3VZcjNi?=
 =?iso-2022-jp?B?UnFYOUZsY1J1aXJlV21TdFBvUFVWYU55UkluK25XRnhPRlVuUFFHY3pO?=
 =?iso-2022-jp?B?SWVhTmdCSHUza0JTdnM0bmNHRGRLQkwyWHZ4L0tCL04yems3U3BVYUw2?=
 =?iso-2022-jp?B?NnFaV3FqU1VEQVk5VVI4YzBlRERwdUpGM0swMm9hcy8zTUNDbUFoTm1L?=
 =?iso-2022-jp?B?dkFvNTMvQUV4dVl2RU0xM29tU1dscUdCRGZaV2dGZWFRdnhycXUrSnZX?=
 =?iso-2022-jp?B?aGhkRUNPUFR2SVhLOHlyMXFXZFpXZnl1a1JyTGV2NkNpVURiWUxaN2dj?=
 =?iso-2022-jp?B?RC9nemtaSUZrdzlyUUtoV0tMU3dYN2tvQXQyRVJCb2ZLNzc4VEhaT0tj?=
 =?iso-2022-jp?B?ZjAveVFqeVdhSlR5SkxiS2pia3pDcStndTEvWHJzWU44NjVWODhUNVQ1?=
 =?iso-2022-jp?B?bVdyS3NaS252dFdubDQ2WTdGbC9LdzRNdk1FTlVUbEVBcGFSRzNTNDA1?=
 =?iso-2022-jp?B?QmV1OWNrVEJITkFSKys4OWJrME1QMzExNXlOVXBRK1JmU0lFVXhJWnlZ?=
 =?iso-2022-jp?B?bWF1ZGwrNzBOMXM4NG1id3FzZmpEZG10YVJ6MElFc1RVa2NBRjVGUjc0?=
 =?iso-2022-jp?B?dktRNW11VFJqeUk3TkJmRmxjenl3a1o5QU16bndGRTRTWlNYOTB3cHR6?=
 =?iso-2022-jp?B?MFRLUjBSdTI0eE9SY0I5MC9LMVVhbXdMZmQzTlZxVVlGOWVobFFKS3Bu?=
 =?iso-2022-jp?B?SWFLNEFOVFF3cFRtMzFwMENOOGZBS1VFZDNIS1ZIelpBdjZmMGlYYjBi?=
 =?iso-2022-jp?B?Smk2Yzg9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6503ecab-4c8b-445c-b42b-08ddf3c9cf24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2025 20:03:44.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWbOhYGE7SGje/GIDqpBLRQtqAPzXWmt3YtURsZ9rMY2wxqxfDALPt49m22qexW6+/5BkZAcujmFnnsdozxcnUtLOZoLYnG5TXLo2eXMMqW9Mu1Qp0fG1b+axF8DJn5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14650
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Sep 2025 20:04:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20049

Hi All,

> Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> notify_hotplug_work
>=20
>=20
> Hi Lad Prabhakar,
>=20
> > -----Original Message-----
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Wednesday, August 20, 2025 10:56 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> > =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> > <pavel@denx.de>; Ulrich Hecht <uli@kernel.org>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> > notify_hotplug_work
> >
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.
> >
> > When performing continuous unbind/bind operations on the USB drivers
> > available on the Renesas RZ/G2L SoC, a kernel crash with the message
> > "Unable to handle kernel NULL pointer dereference at virtual address"
> > may occur. This issue points to the usbhsc_notify_hotplug() function.
> >
> > Flush the delayed work to avoid its execution when driver resources
> > are unavailable.
> >
> > Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of
> > work_struct")
> > Cc: stable <stable@kernel.org>
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Link:
> > https://lore.kernel.org/r/20250225110248.870417-4-claudiu.beznea.uj@bp
> > .re
> > nesas.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > [PL: manually applied the changes]
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
Gentle ping, this patch has not been merged into 4.19-cip yet.

Cheers,
Prabhakar

