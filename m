Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD16C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 09:53:05 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.99])
 by mx.groups.io with SMTP id smtpd.web12.8748.1639648382742687280
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 01:53:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=liX3CVnx;
 spf=pass (domain: renesas.com, ip: 40.107.113.99,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYvoSezKOl2278+7SCzwNKUSclCSFfgFdWC184f7TzM35TtAFXeAI9tkpENmVt3kGk4Xp7LqPe2KEC2AN9zIdpZiU8YAeaY/QWr4VsFgaDAn2sDwSGlvYIyHVBn17o3WDAwyWHsIvldK3NPlG2soa4sTemp7x1KPzZ+bqjvm79FRuzPLsLzbgoIJn1K9Xe/TaphmW3WHnYXX4xZnE+IT4Ay8YHRfDIHP9FEM6WRP8Hlx6MfQua/xsUXjxOZqq/XOHoN7viUbQog4K5gyG7fIqDT0Zl2NUjOTyaH14qAppOLqsTuIC0p/HaAy2d8+VX9n3n7roQw4kFoMfoXH3Mm1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZstpMT5QHhOXNkANwhPmIFXMr2gQ3y2qqTBMV4fLRs=;
 b=KWSE60aSb995g36lTHuaXjqhVfYpwhxFiIn9K+EIWrPpqmGc1KrTJQ/bmby4Cg36NcGS/zNF7Mdht3pOSCussJz/YliKyTrotNzR+1S/0yRu4GxD0gZRswa0RHwIsNKfstEvpYNwmFS2e3btFnEyz4DTtYx1BuDCw5lHpEh4Q8JnKEbkkkWf+f+axhoEVVaWYACVpc48AraXMipOChiZnHRPNiGAd/j3uQ2bOH5/w5H7GVJAayIK7uy3ezGxo2aiAij+nvY7gASCqNx8J2aaj71+JLK5lvK5n/tDDO4agFitS6kS1jsIHT59djWdqZOjO/RC2mGz4eJKefVpLwEKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZstpMT5QHhOXNkANwhPmIFXMr2gQ3y2qqTBMV4fLRs=;
 b=liX3CVnxzWipUQNBZqI8l6/cg0d/ZYeIPvL42hCAcLKDMo1YvciZzcAZTPaeQdLzzT+rf1g9BYRIAOO0iHirtvP2pdd7DS8GFOT3yw2QjCgw1aWPAPZCYrbgklLurQAWn0UzVb5HBiU8FjhAh1PglV65rQBl/MD5lCqSSL/zlwM=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OS3PR01MB6871.jpnprd01.prod.outlook.com (2603:1096:604:114::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 09:52:59 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%5]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 09:52:59 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "pavel@denx.de" <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Index: AQHX8U0yXDMWkTY9nkegXZHak/5YsqwzVAKAgAABXpCAAPMRgIAAmbvw
Date: Thu, 16 Dec 2021 09:52:59 +0000
Message-ID: 
 <OSZPR01MB68774C867A33E8AB5B82EBC9B7779@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211215100537.GA18047@amd>
 <OSZPR01MB6877AA575BACD21ED96F9B53B7769@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <TYAPR01MB625203ABE988E764E38A8C5592779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB625203ABE988E764E38A8C5592779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92326378-6922-4e2d-0afb-08d9c079d7be
x-ms-traffictypediagnostic: OS3PR01MB6871:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB6871A81E76194831EB635E99B7779@OS3PR01MB6871.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lTSHIb7F24oZbdQsy+gtcvUh4hyP8biVGf91MHPLnop9om7T2uDi1A7WaAxCCfWZFi/t2TRV90KtJGBvEwOcb959fb/7m5VFp7gfJVNQKRNxUtmBEfGEHFyQDcE/KRMd+GB//GSGmpeVIJaIfYH+2vHEuTOwoPAMrHSvvJLBLGQCyHjL6g7iQyfwze2FsRYjl/GOJt6xyQQanKOvGoASIOq+TvD0ryZh3rFLVY42hrLv8WXcZX2+YCv6kVmiKJgqj7ewgu9WtRA6uW5J8hxuuf+BCE/ntJOSGqIV2QZXJb/4j60NVrRYhYxivxfqOtR1gRzb7Aly2jboFz+gCGuIubLUC9tdwE4iZhaJgVyFm4Tg7649uBPvvco1sGD0JVzULIc5iciOGHOpuc/cldNTBYMAT1fUU1O0So68FjpG8X/M7ZMtF3KkdDUVWNMoAIYoW5bqaeXjZrJBGNi8iKAOOWqx44JGQxprA+10fxsE0Nph6YXz6sVqLuc1lZDeHQmMWsE/HtRVX/ZF1If+QlDt3oRhn7Hom4bWd8PaYljyRSXs4AqrSOD42UAVAIJcMzzkSfwyFC2jDCAqY84vF0WKZ017Je+Dq0lh+LQ5b7dUdvjkDEHtFhiLJniCJU6qBhpc0yOsTqJtZJ7f5OBfztB1fxB+vZAk1pPirJdGBTH3RoNzg6yjpjYosb838aa8+yh0z63M1Ea/2TZdRIDlOxo4zg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(54906003)(55016003)(7696005)(38070700005)(508600001)(38100700002)(26005)(122000001)(4326008)(110136005)(2906002)(52536014)(86362001)(5660300002)(8936002)(186003)(8676002)(6506007)(33656002)(316002)(66476007)(107886003)(66946007)(64756008)(66556008)(66446008)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QzFVeDAwZnptazBqWTZwdlp0aHF5VWJQem9ZQThEWC85VFVMeW9zWFYw?=
 =?iso-2022-jp?B?NUt4TXZxZE83Y0pXMHBrSFVwTFJqZ21SSTFiSkwrd1ZhSmNocnIwYlN5?=
 =?iso-2022-jp?B?M29qNmR2TGJvVEt2bEFId0hGc3N6T1RVcTNxWUtvRjR2QVc2UGk4Mmgy?=
 =?iso-2022-jp?B?alZHQXRIczFNMm5EYXlSVFN6K2NjM0M3c3FiOUZ5cTJMNUYvR0kxWnpr?=
 =?iso-2022-jp?B?dmhRTm0rbms4eEhvaWM5QTRwYXNtK2pJd1NDSGE4T0pVOWdMWHZNY21B?=
 =?iso-2022-jp?B?d1NrdHpHNkxZZUU0WFBJbi8zUXYyU2wrUUFGdFhBZ3FsSHhTcFQ0UjFz?=
 =?iso-2022-jp?B?dlRCVmpDZHhBS1Bvd1FUYWRVb04vSDhIWUl6akdjUW8vVlVBbC9DS1ZQ?=
 =?iso-2022-jp?B?Z0JWeW8xNllrbGxoNlBpRWxKUVE4VlNNZDQweGxiZzBxOUx5aW84Qk14?=
 =?iso-2022-jp?B?SU04WVVjeDFENGp4Y3FJb3lCT2FsMlpZZ3hmUHFyLzBsL1BQZWxEcFdw?=
 =?iso-2022-jp?B?WWJrSjlRaS9OM2lYN3F4eERldTNFK3BjQVJyZ3Zwei9LN05RKzhKUUNR?=
 =?iso-2022-jp?B?OHNtajBOb3RQZjVCK3VKdVNxSzZSaVk1VDk0WVQwQnh0amcwZ2tVMjVV?=
 =?iso-2022-jp?B?ZFNoSWxEM0psR3R2a2VxeUx2b1B6K3dQOEsvUG5MMWxpYXJYcnpZd1lK?=
 =?iso-2022-jp?B?Qkh4SHNsV3k5SDhoai9RYmxtTzMvTjF5bkorTHBsQ3Ara29KMWJBVGIx?=
 =?iso-2022-jp?B?eXNYREV5eDZZV05vVE9jSnNPb3NrWGtleGEzNUVWVXFJSkd5bTdadzJs?=
 =?iso-2022-jp?B?bDc5c3lkZ0xKbEJ6TWVuRFZ4dE9TRnFXMGs5aHFXMWt1SVlpRzJkcVRC?=
 =?iso-2022-jp?B?b1lzWXpOZ0VSVy92Z2xBOEpkTkxqYUowaUZlMGJxdVYzZStQR2FobGU4?=
 =?iso-2022-jp?B?ZkQzOGNIS0E0cFNTZVdRSnJYRGtRTkJuZG9DVC95ajJUWkh2dVhLQWZk?=
 =?iso-2022-jp?B?WjMyL3R1TEtjcEhTR252c0lSazF3d1pIQTRLdnBNWHdrejFmVlRYTlJs?=
 =?iso-2022-jp?B?U3IzdDRPUFZzMlQyVTQrVEpMZ3ZNaXo2WS9kcTZjd0MvMzk5UWNyeUt5?=
 =?iso-2022-jp?B?eTI3NnhGR2w4eThtS29neDRyMFdsWjRPS1JHc3YxSTQrcXpWVnl5RzB0?=
 =?iso-2022-jp?B?SFRsQ004b1kwQ3IreElvdzRaVW9ZUERQMy9mWnNnMG4rWHhuVmEzcGNj?=
 =?iso-2022-jp?B?WmJ6UThEQjlYZXJzdDlWa1dIK01JZGtGZGtVYnEvZm9IU0cwcnA2dWR6?=
 =?iso-2022-jp?B?QmRqK3QyQ1lrR29ZNmYwUmNpVFUwSFM2L2tEdXl3a0I2d0oxUWQrTVUw?=
 =?iso-2022-jp?B?b3VtbTdxYS91YXZEV25jWGt4aUFPZCtXY3o0ZUxWN1FjUmJuQUZ6VGJJ?=
 =?iso-2022-jp?B?Z0ZJcmozNWpZOHlieDFqeGFVZnlZNjRVczgxelFkTjBpZW01QUZlQXAx?=
 =?iso-2022-jp?B?MC9LSXd4MFYzMU1ZeW51dmxEUmtzU25mTXh0YmpJMENpM3Y5VmFyVHFk?=
 =?iso-2022-jp?B?eG9xVFcrWTAzeGdFSzdkMldqZjRRQmtKVVFFSGRlRmQwWk1PeFlzWStF?=
 =?iso-2022-jp?B?UDl3YzR5WGRSczVWcDlBRjlzbVZuOVFEMXZ4Qlc1cHJkK016bklQRWQ3?=
 =?iso-2022-jp?B?V0k0OFJWcGFtU21SUmU0NU9WdC9mcVRBTkxBellwa1pGcXJsT2VOcDVQ?=
 =?iso-2022-jp?B?ck12clgyKy9KSERNcXE4ekkvZ1JMM291OGNxMzJsUGtwb3NJSHNoL0pm?=
 =?iso-2022-jp?B?KyttRFFKZ05odEZ3TDF3bzEzcSs2THF1MVJBbmV4UjlKbjYwUDY2LzUv?=
 =?iso-2022-jp?B?bllLNTlRcjVQNTA0QmRXWHAzV0FDUlhESWtIS1pTNlVhUFV5TmZ3bndz?=
 =?iso-2022-jp?B?eUJac2F1UWFwSGlIczRQU05WUUJXdVNSZ2ZTSjUrR2F5NUxteGRZeThu?=
 =?iso-2022-jp?B?cTExTldsdzc3RmtFQ3AvZS8zMU1QR2t0VDN3Z3lPODA5bFJIQ212N1Qx?=
 =?iso-2022-jp?B?VFMrL0hFdUNyMnUvVjZsajFiQUl4UWVid1FMRzl2WUpyUU9HdXdQS1l4?=
 =?iso-2022-jp?B?RWh0aS93N1UvSUpRVXo5OEtyTWdsYjZVSklVNyt6MFNqMGE1SmQ3alJu?=
 =?iso-2022-jp?B?VG1Va2tmQzlPZzZHZldQRTVabStxWWQ2R0w0WTdpKzdGRkxaSjFlb1l3?=
 =?iso-2022-jp?B?RWRtTWc3UnpvemxyVzhFbVdVZTJ1NmE1UWdZUDRHY2tvTWdQQ2RZdElx?=
 =?iso-2022-jp?B?bkRjb0RTa2RUY3JRbXlPYzB5ZzUxUmtPbFZheWxRckJGN2JuanZtZFJv?=
 =?iso-2022-jp?B?NTRyM3pCYnpRL2ZiWjdTVXpGYzMyZmdhM2VuOGpvZ3hWTVg0U3c2TWYw?=
 =?iso-2022-jp?B?TXp1c0JBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 92326378-6922-4e2d-0afb-08d9c079d7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 09:52:59.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 uU7HMZCxmH3qp6BSF6EGYJ2JEiVKpK2ec2uYMSsn2jAsQugcHG7RsGHk1NeOvUgIFll8BiQZrbP00+A93sNnkE9jZ11ujhNEo2+tPVynO4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 09:53:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7120

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 16 December 2021 00:40
>=20
> Hi all,
>=20
> >> I have reviewed patches and they look okay to me. I'll proceed with
> >> testing.
> >>
> >> Do we have suitable board in the test lab / is there plan to add one?
> >
> > We don't have any boards in the CIP labs yet, but there is a plan to ad=
d
> some.
>=20
> I think I need to add the board to LAB first. Of course, source code revi=
ews
> and
> build tests are possible.
> And If my understand is correctoly, I think this is a new board that is n=
ot on
> the
> reference board list. I don't think this has been discussed at TSC.
> I think it needs to be on the agenda at TSC, whether it's a reference boa=
rd for
> the 5.10-cip kernel.

We are planning to propose it as a CIP reference board and we plan to add s=
ome hardware to the CIP's LAVA infrastructure.
If the board is not accepted as a CIP reference board, we would still like =
to add support for it in the CIP Kernel as we have done for other non-refer=
ence boards such as the iWave RZ/G1E, HiHope RZ/G2H boards etc.

Kind regards, Chris


