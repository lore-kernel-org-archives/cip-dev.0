Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDBC47091
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:12 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.102])
 by mx.groups.io with SMTP id smtpd.web09.26378.1650865949218942368
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Apr 2022 22:52:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=h296aCp5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.102,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJdore+bzn/WAqn8CX63pLvUGuEmFsWQ+qvF4Vx2c9sQWozxx+VsQleW9RqiQQen6bRappTz7mdZR1pal1Ae9zmBmdms7tdP5HrQO62DhmGWXa9pGFV0B91skWktQLh7sD0fh4U8cVWX1rO1xg4MuXDuXAHW21SdQGyeXxK7R4g2B8ageKWBapUZxHpUBrtiW5zxQDSlOGBtfOVxKK/fhMY/UEmp5ZoeFImJuixeUd/iu5ISAG5Ax4dIZygDliy5cqTGncFrlkZUBSEdBt5sI3/N4YFAZQzaZpG7JEYpLmKdis9MbpCdmmGNmWvNfVEvXVd9UHUGtNfDwUBtC+//kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjU3a+j+/jjQEDQmxAgK8G6X3/WXLC+URoEp6X3tZWA=;
 b=LfoQUcSYBff77RV9LaCY6BcTctmEgjqMNFWOjC2IHD2m2nktpX1T9hQT+JAaSQrJiihazLyOeav0ZGoGpHBalPn1puA7apdu/g15hZs64+ceek89zu0bRySYTp7cIJr8vKlZ9WV6KriZx2x9BJdhpKWlLsiWD0jWxFFPaOk3OvoXnjA+QxSyuY9HbjGb7CCe3Y94xw5+8Vv3SKQtYHYNnIg8B6KwsgPNztPZhiuJurz3kD95UeutFpkvsytc85iJWLNltHFckwfLukab54+ZXSCawyuOae85NhFOl2DZqpslMp9TNeIRBHnRVwB7OKh1wdsnNkOyheK5rowAxI+TMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjU3a+j+/jjQEDQmxAgK8G6X3/WXLC+URoEp6X3tZWA=;
 b=h296aCp5w8gAT/wDmFYQb+Nhbbb4ErNk3gsNbKZFLeFMA165lbYG3z5eGNr6pTIVgCYxP1fIDb4v26aIIfc0KQKccolc3KpOdPTMGDYuGbxFJO+EVuygQBJS7f3Qvw3rljyOxsh2CNtc5jJx/TkRKkFKdxuvnXraUaPmoI/4zkk=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS0PR01MB6052.jpnprd01.prod.outlook.com (2603:1096:604:cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 05:52:25 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 05:52:25 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Thread-Topic: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Thread-Index: AQHYVP53PzDhpsg+5kqJFwxgPIQK36z5r8LQgAZ2Z4A=
Date: Mon, 25 Apr 2022 05:52:25 +0000
Message-ID: 
 <OSZPR01MB70199C4F3166C40240BFD058AAF89@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB9420C80542707FC4B160E5E992F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420C80542707FC4B160E5E992F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e00776f-0ea0-4161-745a-08da267fc617
x-ms-traffictypediagnostic: OS0PR01MB6052:EE_
x-microsoft-antispam-prvs: 
 <OS0PR01MB605237A0DA21D360DCA517B6AAF89@OS0PR01MB6052.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qKrBNiczHsEZdCGibYvV+Zkvz027JughRR95mbLjchqqJQcAtPLaJIwmwG+w/lc9tbBN6uQqtxDORz9usc0PRRcrlEMR3ItevwCpQP3QVup+pwRsWMEJ6208zDppDueuePmq1wquPCTgCeIM0/2o6emLxbms2zAyHbYCA4dJXHSkU0D/zcYBp7MZh6bobd2pvF4LLl7BoZR9jM7PG89gtxsqIoKSLrNW+/x8CBstlx6QRjUxQJpTqxkgnjMnapdW9UcLlgbqkrLKq/DYwOI8n3cxyeyBXD/snvoDruwIBLnc9KpJIoTAy9310YTWAC5u8cFGNBYAesbx+pu4binZHL7X5wzXkrl9s6kgRc76yxbk20gZIQq3btghVxBzi0/MvLaLQ7m7Ty29IFW/VK/3kmR3c4EA8kVQnaFtk7ziJ+FUe54mDopmiWF5S+gUv+glcNMnuFkb5z5uO777TGDS8YT+8qSuUnWXAnHuzooFJTKMLVwPMtim6ntxa40Kw8ySyr4/syYLv2gEkPf10HCaTtrUqzYD5x4vG9BDOxwv/TQqhpKxBbxHWHKJGTXzZyf6fvc3oPHqirCLIrEDWF0cUAI+d24/2pz6Tof3tvR07NYemTQWNWsPA38GCq5DWuk0M/h1wu1pp5+YVvPSi2C0gEIjOki4kKSvHwTAcz2aqQ47PEPP+ywjEpT2cxUUxW84jw1qooRxCsdpYjqt0nHE/Ktl6pbLVtnADv1yGsQvs5/6KMliBDLm/4cT/oUuupeKxkyK32XrgCh7zWnaiK7Y8wEpkrpR9Yirw6H5IGuKpsA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(55016003)(9686003)(110136005)(5660300002)(38100700002)(38070700005)(52536014)(83380400001)(86362001)(8936002)(66556008)(64756008)(66446008)(66476007)(8676002)(122000001)(4326008)(508600001)(107886003)(186003)(66946007)(76116006)(966005)(33656002)(316002)(71200400001)(45080400002)(26005)(7696005)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SHByV1YzT1E2cVhEdEpnYlVMRzVsZUJUL3dtbDVhcG9uVkNTTlhBSlll?=
 =?iso-2022-jp?B?ZGUrOW40Y2FDUGNCa2JDWjd1TXg0ZElaWG5wSjlNMmo5UDBiV1Q1OFB2?=
 =?iso-2022-jp?B?OGFXOEtPV0V3cTZRRUxFdUNRNTVrbEh1WDRFWGZHNDhOdGJWREdJMkY5?=
 =?iso-2022-jp?B?VDUrbHlLZXlQWi9mYmlJeGlYeEU5ZjJtYk8vc2wwNlZzOUo0MndFbU1Z?=
 =?iso-2022-jp?B?REFRcmZOQk1rNXRpSVdNODVKV3ZsMlhGZEtzUEVrYlpmSjlVOEdGSnc2?=
 =?iso-2022-jp?B?S2RhRzdObWxYYTZFSnhxUG1RaXA3dlJaQ0RScEZpaUtLaGJJZ1Fhay9r?=
 =?iso-2022-jp?B?SU1XcFpLVjJxVzAyZlc0QnQwM0l1MDBCd0ROdkQ5OXU1TTlyZkJzVkhP?=
 =?iso-2022-jp?B?Mmo5dUtIK0NiOVh1R3BET2ZyRVIxcTVQYkVDUm15QUVtbldKT051ZnBy?=
 =?iso-2022-jp?B?NXIzN2ZrR1poNDdORXlRSGM2R0ZWdlcxT2JpVWxjWXFpNFFYV1FJWEpv?=
 =?iso-2022-jp?B?UCt5dHhsaklUUDNoY25PTzhiOVN4ckFJZVZWaGYrcTRaeFdQVFFIOFZi?=
 =?iso-2022-jp?B?WURQYjdnQkZkcXFHU0p5dWNJdlkyVlBuY2tiMWQxVUVIcCs1SFpta2Mr?=
 =?iso-2022-jp?B?YndoYkZpa2Vydi9zbW54Uk0zdTJBTXgwOWRRZFhLL1VWTFlURjNYT2Rt?=
 =?iso-2022-jp?B?QVJWUUIrUEIyNmZ2UEkwR0FwOXVKTmJKOUZNOGwvazFtZkZCSnBjRDd2?=
 =?iso-2022-jp?B?MFVvWnhPZnc3cUhMblU2aWVDdnVGa2o5aWZDYWJnajM2amdKbDZSaWxr?=
 =?iso-2022-jp?B?UnVlSnVVVHIxSnhseHErcHE0RVRLVVlhNENmMGNhRHVyWGI4YjBLajJT?=
 =?iso-2022-jp?B?UFJ4UHRjN0lTdUVDL1ZMOTIwZWYyN0k2OHZKeUtiNUphVWE2VHh3YTJJ?=
 =?iso-2022-jp?B?NVZ0cGJLVjZqT3E0WWNxUWJnOGNMejFreDVScWhjbWZEOWpPREhYVTI2?=
 =?iso-2022-jp?B?RExKSlRJaS9rcitKdTY5cVVOZ1lQZk9ZUEhpZjZMM3VDUG9LY2l5UUxW?=
 =?iso-2022-jp?B?VlMyaHoxM2kwSHpMNXg3dXY5MmNUeDhmZkZ0a0xUYWxOVWNjdjJVbXB3?=
 =?iso-2022-jp?B?Tk0xakl1bWFYbm9yWlROWm9TVTY4aXN1T2t3TktEc2g3RVY4enRjM3pk?=
 =?iso-2022-jp?B?b2hhVDhLUFZKWkVPeUxyaG1FSUxtclBxcG5tb2JkZHdsdjduTTFXVzFH?=
 =?iso-2022-jp?B?WW9NZ0lkK0UzUVhYMm0waGtZOHJ6K0tUb1cwaFpKU3NabVdxdkw2MEFq?=
 =?iso-2022-jp?B?SXdrUzJHVkdQRmlTU3RKWEtnZW80dGluWDVZT0N3RWJad29iTi9pTmtt?=
 =?iso-2022-jp?B?T3dXT1pZNjkvcEJmTFllQmR3dEZxSVpFRDRtZXBXSDkvcVFpTXNNbWNW?=
 =?iso-2022-jp?B?Yi90bFJqQ0RBL3RWR21lTGg1UjFZcDFBVVhIeTRhRzhCa09JeXBPajUx?=
 =?iso-2022-jp?B?dXZiejAyLzlkdlRCWUp0MUlFY1gwd2pGcUNVelRTSVZ4dmpVVk81N2N0?=
 =?iso-2022-jp?B?VEtYMzBDa1NqK0tsZURrQUtiaENRMENjQ3dadWpncHN1OTU0Mm4zSzZW?=
 =?iso-2022-jp?B?L0NuWG44bUVyWVA1YlQ2OU1SZDduMzVGZHhCNG10d09UcVB2L2k4ZGF3?=
 =?iso-2022-jp?B?MFlYL0pNc29zRmpGQmFXT3ZGdHY2U2NVQTFzZ3pYQnVPc1V6TWVvWk90?=
 =?iso-2022-jp?B?WEU0UXYvQzlvUytuelF4MG42WnhJakVVWVRCd2pqZTBZWmYwZkJ2YU9m?=
 =?iso-2022-jp?B?OVhnak9FcG81VnRST2k2YzFCVFUwMFlGZCtkVFhUOWNuZDFTbzBXODFM?=
 =?iso-2022-jp?B?UjkvNWVaUkRBVUZzRGZDY1lhdmRRRlZJdnVGc2RJbDN5UjUxRzdmRG5T?=
 =?iso-2022-jp?B?QXg3a2JQR29FUVJQZDRYTVh4WUNoaDF3NEd1Zmx4T0hKUTdTWmsvVVRY?=
 =?iso-2022-jp?B?Yk96WW1pOUhXU21KVnZsYThDTnZFVzlPNUJxYVhBNHlZUkdVVVhQei9l?=
 =?iso-2022-jp?B?dzBWdnpaamVNZGw5Qk9NYWhxZEJNNlBIRHBsVVYrdDVNVnVEQTdRb3Zs?=
 =?iso-2022-jp?B?OVBMbi9DNlFGMW83NHR4NE1XSTZSMnlNOVl5aEpUbEJEMmVzOFYzRCsz?=
 =?iso-2022-jp?B?Q2VaMkhGU0pHak9mSGNzQWRkUXdkYkNlN3RDMkpyYndkNERlc1BFQ0tM?=
 =?iso-2022-jp?B?ZGJJZys4cVAzTEZVOERIWmVJTXhqaUNrSUVaRENrd2Y5NlRJVldtTVpE?=
 =?iso-2022-jp?B?dDliZWJsdXJpSVB3bEgwekpkcnlzZnZEbGZqZk1oU2E5V1dXUVVLNm9U?=
 =?iso-2022-jp?B?aUZORGlYR0Qrc3JQRzFpU2lNcTIySFAycXUvaGRBMUQ4L1I2MzlJQjZw?=
 =?iso-2022-jp?B?ZTJ6bkFjV0ViR2ZKdkpIbGhYaXFvU2dmYmdIc1lTbGQzQ29UT29SQ1I2?=
 =?iso-2022-jp?B?a2FFdFdvV0RBVUFMUHVNQk1raC9scTQ0VXIwZXdOTEpxUlI0T1JaWWxL?=
 =?iso-2022-jp?B?bUFISTNXdVd6Z0g2T0lmNFYyU2VsYnBMVWRVMw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e00776f-0ea0-4161-745a-08da267fc617
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 05:52:25.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 NbYJiyaK9Z8VuF86eiL/QNnFYu65olX4aNAvpVble+dkNoO7zlVBbzFoEH1Ua/DS5WFF9Z3OuVhQfPcN3AW3um6OQOvbJ/GUDyJLawOQdsHCfZ1eXnvzRq2k6tE1KP4M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8192

Hi Nobuhiro-san,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 21 April 2022 04:26
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-
> dev@lists.cip-project.org; pavel@denx.de
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L
> SoC
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Thursday, April 21, 2022 6:34 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#S#W#C"~=1B(B
> =1B$B#A=1B(B
> > =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel=
@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L
> > SoC
> >
> > Hi All,
> >
> > This patch series adds sound support to Renesas RZ/G2L SoC and enables
> > SSI and codec on Renesas RZ/G2L SMARC EVK.
> >
> > All the patches have been cherry picked from v5.18-rc3.
> >
> > Sound support patches were already sent earlier as part of bulk series
> > [0], but due to some review comments the patches were rejected, now
> > that the driver is fixed upstream, re-sending the series with all the
> fixes.
> >
> > [0]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Fcip-dev%2Fcover%2F&amp;data=3D05%7C01%7Cpr=
a
> > bhakar.mahadev-lad.rj%40bp.renesas.com%7Cb4ee1a6285394d44892508da2346a
> > 0d8%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637861083493803991%7C
> > Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dtb4S87F0MCvezWQFTwYhtfUN=
P
> > ErdCwkz9JsE%2FWJK9qQ%3D&amp;reserved=3D0
> > 20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>=20
> Looks good to me.
> I am testing on
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.c
> om%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> %2Fpipelines%2F521117833&amp;data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7Cb4ee1a6285394d44892508da2346a0d8%7C53d82571da19=
4
> 7e49cb4625a166a4a2a%7C0%7C0%7C637861083493803991%7CUnknown%7CTWFpbGZsb3d8=
e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%=
7
> C%7C%7C&amp;sdata=3DhAsfuV2fT66SH6cFpfI8cuUQMO8QVozG7EVlYAhMRu8%3D&amp;re=
ser
> ved=3D0.
> I can merge it if there are no other comments and test is successful.
>=20
Looks like there is one test failure, pretty sure its unrelated to the chan=
ges. Can you please retrigger the failed test so that this patch set gets m=
erged in.

Cheers,
Prabhakar

> >
> > Cheers,
> > Prabhakar
> >
>=20
> Best regards,
>   Nobuhiro
>=20
> > Biju Das (16):
> >   ASoC: dt-bindings: Document RZ/G2L bindings
> >   ASoC: dt-bindings: sound: renesas,rz-ssi: Document DMA support
> >   ASoC: dt-bindings: renesas,rz-ssi: Update slave dma channel
> >     configuration parameter
> >   ASoC: sh: Add RZ/G2L SSIF-2 driver
> >   ASoC: sh: rz-ssi: Add SSI DMAC support
> >   ASoC: sh: rz-ssi: Fix dereference of noderef expression warning
> >   ASoC: sh: rz-ssi: Fix wrong operator used issue
> >   ASoC: sh: rz-ssi: Improve error handling in rz_ssi_dma_request
> >     function
> >   arm64: dts: renesas: r9a07g044: Add external audio clock nodes
> >   arm64: dts: renesas: r9a07g044: Add SSI support
> >   arm64: dts: renesas: r9a07g044: Add DMA support to SSI
> >   arm64: dts: renesas: rzg2l-smarc: Add WM8978 sound codec
> >   arm64: dts: renesas: rzg2l-smarc: Enable audio
> >   arm64: dts: renesas: rzg2l-smarc: Add Mic routing
> >   arm64: defconfig: Enable SOUND_SOC_RZ
> >   arm64: defconfig: Enable SND_SOC_WM8978
> >
> > Heiner Kallweit (1):
> >   ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()
> >
> > Lad Prabhakar (7):
> >   ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv() recursively
> >   ASoC: sh: rz-ssi: Make the data structures available before
> >     registering the handlers
> >   ASoC: sh: rz-ssi: Drop ssi parameter from rz_ssi_stream_init()
> >   ASoC: sh: rz-ssi: Make return type of rz_ssi_stream_is_valid() to boo=
l
> >   ASoC: sh: rz-ssi: Use a do-while loop in rz_ssi_pio_recv()
> >   ASoC: sh: rz-ssi: Add rz_ssi_set_substream() helper function
> >   ASoC: sh: rz-ssi: Remove duplicate macros
> >
> >  .../bindings/sound/renesas,rz-ssi.yaml        |  118 ++
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   98 ++
> >  arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   79 ++
> >  arch/arm64/configs/defconfig                  |    2 +
> >  sound/soc/sh/Kconfig                          |    6 +
> >  sound/soc/sh/Makefile                         |    4 +
> >  sound/soc/sh/rz-ssi.c                         | 1078
> > +++++++++++++++++
> >  7 files changed, 1385 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> >  create mode 100644 sound/soc/sh/rz-ssi.c
> >
> > --
> > 2.17.1

