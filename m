Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A93C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 05:11:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.6297.1639631499531890760
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 21:11:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1BG5BKLd027693;
 Thu, 16 Dec 2021 14:11:20 +0900
X-Iguazu-Qid: 2wHHWT2Ba2QHTQIhNX
X-Iguazu-QSIG: v=2; s=0; t=1639631479; q=2wHHWT2Ba2QHTQIhNX;
 m=LBA6f1Y4nDjJLyhMe0Tqt8BbtiFKb3T2xvdtt8jWzGI=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 1BG5BHCd019774
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Dec 2021 14:11:17 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 08381100280;
	Thu, 16 Dec 2021 14:10:48 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1BG5Allt015417;
	Thu, 16 Dec 2021 14:10:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kq914yJ7TJ+KDK+gOQ8w/pJCdkvDc6IxPns7DP8XKOqTZUqPLqq091ouGW2OdrXGUHwqSrQHsz5XTsG/ZtJlNmivHms0+rzKJaroQL1bpPYrIQNPL8Xy+iiV7jq5TPgKWfxKRw3rZLRvDXj29pekvXOwGtp8X8RfaVvbtFWwxWoSJptKcKVUZtj4EwbgddzY4u6Vi6SeYKYxbt/8R8Qe5/NIVC5F6xiJSIRQ8kk2l53FwuymAGQ6SzRgDwyRHfmwYnFpXYDPD0kAZWJKQORWE+WcG7Zhh77eJOSU2DKgYuIwbatmgwOKpl0g8PYSp1epLFRitpzb2UGVFztC1dXBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIRotfnTQjcevqcQJyfBsa3TyPKzUzVynlMJtVNi5bA=;
 b=jMuNQGGvspUjJm3gQ58WoCUawXdk1EYI7kMiVAeimaPR4uzNtvSbfDcDZIDexBloa0BNmhvpWI1ksuuLdaWSu2P2QKKQwFqmXkc+wdnrV2CtIvNbnD5uCQ7YXqWKta3qrc9Vx70QiQkGSF6dI5t54wQkQ7hD5ofOJGWSSnkLVtamz5KmHVBa3y/umQL6a3j8cJ45EmOHUQbLNTQLVi+EddsAeE8wgCv8NwSGFov8blGEiOrIKF9NM0CtMNu6bR7cKRpacj/zxImGyLFLgdx33SbbfhtW0I23ApMava/HSI8bUz1DfqJU5I/QU4ODDlRj7+YJgLdfTBFnRVIn8IThZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>, <uli@fpond.eu>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification for
 Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Topic: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification for
 Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Index: AQHX8U08XT1uNy8MwUSTHJk1/2W6Aaw0ktf+
Date: Thu, 16 Dec 2021 05:10:45 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252F8B94A684EFA61315C6B92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 93c7f8d8-5231-ce30-fbe4-8b41ea71e337
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bca25fd0-d91b-4005-86f8-08d9c0526a52
x-ms-traffictypediagnostic: TYAPR01MB4718:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB47182B44FBB8806FB565EB7892779@TYAPR01MB4718.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Z1MCWGx4oeyydleynm093Vt5DI4B4W5lzimf5fs1smW0Df+bJg5m/H5+lD53/vSLA4tTJRENTDS8fowSXqqs1Jr85z68giWj3KYh2HVFSUYf74MnjdOk+dT1gHinHpOCfTjf5HtOPNJ/FjsMsirg/xxbXM3RNRdvyxY+YKoUrjjnycIwl/+x75i4A0hQglzTYt+z9Vni1WMJpD4uY26kVEfEN5BR1AsEHG8kdkb/qas8NHvHZl7p+2D+zP6obBfLuWj559k8BDJr2wRlZBluzIKzCYrjif/MBQ2AbJcodlGhul8LCrIsXEl0yjwKMuAzvq38Qrec3PW2Rb/BXEBDtO8KoApO6+l77geXU9vCQ4VTKiGdLpfzlabRgUOc0w5JeZEXX6on/J5rSIhXQpQzUU4SHYbmVKmN7bLfis9R0qCr1SFDWmWonpJf0K5YSed2ExvFNjA4tQzoMowFV787Egm+cfK5IMX64ufALKqUmsLuzSebFuTb1+OSbAMePTWQOUj6yOqDg54tyHTOgCLyKLk7NhA5sPFvoOSsv3CsPSEnIfwqEEZj1veJB+Z4Fzc/xT3hHYpZS9K5Fm8lS3SQHy5kuOaKdrOqDEg5136GMrxhWDEFt5cGb4ZJPfGb9TrN7AGo+ZkwHL94lU+YxQSbruY7qEDWaEXeWqY0QCP2bibk8uQLx1AGn1pyvRAtj+1jM1VoQO2xZU8eb+5b4QNGAakOEWdF1VP15rRxkuMIVTf802IW2VRIX/i4Y/puBurW4m6QG4nnJP/2WF4piJ33Nokd8hUr/ANDNkzWAA7Ual8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66476007)(66556008)(86362001)(66946007)(66446008)(8676002)(5660300002)(76116006)(55016003)(83380400001)(316002)(52536014)(8936002)(38100700002)(26005)(38070700005)(122000001)(186003)(966005)(7696005)(71200400001)(6506007)(4326008)(110136005)(9686003)(508600001)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NE4zQVFUOGxNTjNlbktSYWU3MWxHNTVFbkpVK3M1QU5RcGtIZHFnMktY?=
 =?iso-2022-jp?B?d1BadXhpSFdtOUVjb0o0bjg1Q0FaVW9CWHV5ZWM0NUtYakM5MjkyTjhh?=
 =?iso-2022-jp?B?aDFtMTh0bk9ZMmxKWmVNVG03RzJ3UmxnNWhQZUpHQkpveVA3SVY3S3V1?=
 =?iso-2022-jp?B?UjE1Y1dWcEdURnNidlo5ODZOeHI0a2VkenVPZDRJSEFHNFNkbHQ3OEdl?=
 =?iso-2022-jp?B?Vk1LUzk0NXlZKzFLaXpFWjZla0JENEdLOEZyMUtyRG0xWW1ZSFltclVs?=
 =?iso-2022-jp?B?bFRqY3BIVDNnSGp6bUdEbWdmQmk4RVlqU3l0bStCSWNLK1A4M1hDaitI?=
 =?iso-2022-jp?B?c3lMa09IMjdNZzdIRnEvdi96aGQzYlgvOVBsbGtxQVFBUXRBQWtmTmRm?=
 =?iso-2022-jp?B?ZGJyOTgyWGtveTZ1SUVVK3BEYlQ2YWduTVdFZUsvcGVMYkRFYjd2TXlo?=
 =?iso-2022-jp?B?RlhjekQxZ21PQWFaUUNEYis3dTI2WEI1WnpKeUF6NWNCYzRrOGd6TTBX?=
 =?iso-2022-jp?B?OEtMTFduWWVtSHdlcUpWSy9ZSy9uTHoxSUNSRGIycWFxMFFPTG5SY0Na?=
 =?iso-2022-jp?B?Q3BvMWdjVm93NEJjdnNGQ3FFU3FINUhnWU1aKytOZzdlT0Q1UkRHOXp5?=
 =?iso-2022-jp?B?cHIrN3crcEhuVmtFVHdPRHNCc2QzRmNsY28wYWF0aGxIYmVhNkVEWUs4?=
 =?iso-2022-jp?B?OHBsMDFsS2Z3TVlQYkF0S1NKaUF1dHI2UDdxVUkxU2d2MkIvQXZmVGQ1?=
 =?iso-2022-jp?B?czBGV1E5QnkwMUpXNFNVRU12SmV5T0ZJdWxsbzVTY0lMVFlHZUtrNkhj?=
 =?iso-2022-jp?B?RlNGRkpaS1VCU1QyNjlRQUd5Y1YvQkJKelUrQ2txSmdDejB5UWpGYjU0?=
 =?iso-2022-jp?B?QlFFblJPT1ZKRDF2VVVVTG9mbEloVUIvcHJzalEwU2dhT1dtalh3UEwx?=
 =?iso-2022-jp?B?ZTVFaWxRcG5yOU5SL2tnL0JVN3E2clV2eDZQS081c1lFaWdyRGkvTFJw?=
 =?iso-2022-jp?B?UFN2UXBHdnJGNWo4b2h5T3IrN1M0NDY1d0NSRm9HTVJYZ2tkUlkzR1hJ?=
 =?iso-2022-jp?B?ZGZqcVFadzZmSTFmeUVpZlU5U2dMU0tNOXhNZkVqeWQxeTdDS015bkgz?=
 =?iso-2022-jp?B?VVpkRzZrbU4zMitKR0JzQzFQdER4bEc1S0kwYnVUWU0yWUpTVmVnTVF5?=
 =?iso-2022-jp?B?NmFjUm9TenR2KzB2bUk5N2NUdVNob0tkZFVZV01IM1EvZlA2N1BZWDV2?=
 =?iso-2022-jp?B?aHVuQlBWQks1UDBiQy9LTXRJTTJuTk8yTHRiTDc2endhRzJCN1VQSlhj?=
 =?iso-2022-jp?B?dXJCOEwzYWFRbWV5M29HNm5YZmxUNmMvRG9JVGFYRGxtcm5jUlRkKy9I?=
 =?iso-2022-jp?B?WmtHQm9wYk1vNTRVdE9kNW1JQml5TGMxVVoxc3BVQ0I4OUZOS1g4UEN6?=
 =?iso-2022-jp?B?Zm91UVVhR2ZIV3VQajJlMXY1bVg4aC9helNxSjQyRWNyVllQcDI5RVhz?=
 =?iso-2022-jp?B?a090YU1BMzVGeGs0UVduTjdaRDY4NDUvM0J5cVhHekRYNWE5TTFJcGRk?=
 =?iso-2022-jp?B?NUwreCs0cjI0aHdOaEtxY0lERkY3Skp2YWpaeWtXc0FRN29hcURiNjNj?=
 =?iso-2022-jp?B?bXB1YUdLQ3NJUEhENndzT21VRUxOb296N3FUZDlxQzQrbjlJWnN3b1FC?=
 =?iso-2022-jp?B?M09HbTF2R3ZpendEdTUrejRXR1QyR1huZnZqYlFTa2pJdWZZZUZMbXJk?=
 =?iso-2022-jp?B?YW1aNnAvblVmaU9kUFJVUG8xVS9RY0NMeU8rZXh2Skc0RzBuQ0tQNHYx?=
 =?iso-2022-jp?B?cmsyWXNIbjNBWUwvcjNycUdOUWF5Q3FpTHliVnpvbkF3TGQ2ZFE1Z1No?=
 =?iso-2022-jp?B?M0luTTE4RXl0elVmbnBjaHJ5bWFHbG5MdmRVallMSVNkS0s0S3gwQXdE?=
 =?iso-2022-jp?B?ZnpJUDBJMDY1S05Bb0RaRUpLQ2RDSUcrREdMTWJhL0hDcG9Na1JjbGRp?=
 =?iso-2022-jp?B?emNOSXhsZisxd1JTRjV1ZlN6YXpLQlZmdFBDZHp4YWE1dXpJY3BHdldU?=
 =?iso-2022-jp?B?WjNGRmFaMVRBSzRkbWt6YjR3SjNkbFJMc0w1eGswTVh5NE5XZ2RVeFZk?=
 =?iso-2022-jp?B?eTZDZzV6Q0RSV2RXSGNBeVdYU3lTRUwzVGt2TnRmeGFaUUxGSnhQWnpO?=
 =?iso-2022-jp?B?K1FMWDU2TFVxRVJnY3dCQUZFb3U0MUxGbERpV0xzaUZFTVdiSHljUnRt?=
 =?iso-2022-jp?B?YTNzbndmWWhGc1hGYzl6b0RXbXY4RFAwRnlXbUoyMUZZSzBwdHp5Tkdw?=
 =?iso-2022-jp?B?eWdVNkx6azlNSjZyMS9qSWdaN1dFMFdQbHNqTGI3blhjYTYybkRENjRD?=
 =?iso-2022-jp?B?Z0hnbmhBSDR3TmZBNUlsdjcxbVhVUXFwelMzeG9KOXhnOTJhZ1lKUUpl?=
 =?iso-2022-jp?B?bjNSYkpua29vamxQdnk5ZERCNG9KRlRuSDl5Z05sbFlxQWRtaUJPL0xF?=
 =?iso-2022-jp?B?ZmxuK25v?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bca25fd0-d91b-4005-86f8-08d9c0526a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 05:10:45.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 /27IBt9at5CoowyTrMjWp9l45VZwAj0e2/uDI5QPEUaD45rphQyrlbPL1Av7Ieh9QYG8KE5icbAgzYk/Nr3v283jLDsOEvVcUBIykDJNyVQZL3BkJxLS2X34EmylOSUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4718
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 05:11:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7113

Hi!=0A=
=0A=
> Hi All,=0A=
> =0A=
> This patch series adds initial support for Renesas RZ/G2L SoC [0] and=0A=
> Renesas RZ/G2L SMARC EVK [1].=0A=
> =0A=
> The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit=0A=
> DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video code=
c=0A=
> (H.264). It also has many interfaces such as camera input, display output=
,=0A=
> USB 2.0, and Gbit-Ether, making it ideal for applications such as=0A=
> entry-class industrial human-machine interfaces (HMIs) and embedded devic=
es=0A=
> with video capabilities.=0A=
> =0A=
> Patches add support for the following:=0A=
> * Documentation for RZ/G2{L,LC,UL} SoC variants=0A=
> * Documentation for Renesas SMARC EVK=0A=
> * SYSC binding doc required for SoC identification=0A=
> * SoC identification support=0A=
> * Enabling ARCH_R9A07G044 in defconfig=0A=
> =0A=
> All the patches have been cherry picked from v5.16-rc5=0A=
> =0A=
> [0] https://www.renesas.com/us/en/products/microcontrollers-microprocesso=
rs/=0A=
> rz-arm-based-high-end-32-64-bit-mpus/rzg2l-general-purpose-microprocessor=
s-dual-=0A=
> core-arm-cortex-a55-12-ghz-cpus-3d-graphics-and-video-codec=0A=
> [1] https://www.renesas.com/us/en/products/microcontrollers-microprocesso=
rs/=0A=
> rz-arm-based-high-end-32-64-bit-mpus/rtk9744l23s01000be-rzg2l-evaluation-=
board-kit=0A=
> =0A=
=0A=
=0A=
LGTM. I can merge this seriese, If there is no objection.=0A=
=0A=
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>=
=0A=
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B15=1B$BF|=1B(B 9:46=0A=
=1B$B08@h=1B(B: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=
=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B); Pavel Machek=0A=
CC: Biju Das; Lad Prabhakar=0A=
=1B$B7oL>=1B(B: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification f=
or Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK=0A=
=0A=
Hi All,=0A=
=0A=
This patch series adds initial support for Renesas RZ/G2L SoC [0] and=0A=
Renesas RZ/G2L SMARC EVK [1].=0A=
=0A=
The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit=0A=
DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video codec=
=0A=
(H.264). It also has many interfaces such as camera input, display output,=
=0A=
USB 2.0, and Gbit-Ether, making it ideal for applications such as=0A=
entry-class industrial human-machine interfaces (HMIs) and embedded devices=
=0A=
with video capabilities.=0A=
=0A=
Patches add support for the following:=0A=
* Documentation for RZ/G2{L,LC,UL} SoC variants=0A=
* Documentation for Renesas SMARC EVK=0A=
* SYSC binding doc required for SoC identification=0A=
* SoC identification support=0A=
* Enabling ARCH_R9A07G044 in defconfig=0A=
=0A=
All the patches have been cherry picked from v5.16-rc5=0A=
=0A=
[0] https://www.renesas.com/us/en/products/microcontrollers-microprocessors=
/=0A=
rz-arm-based-high-end-32-64-bit-mpus/rzg2l-general-purpose-microprocessors-=
dual-=0A=
core-arm-cortex-a55-12-ghz-cpus-3d-graphics-and-video-codec=0A=
[1] https://www.renesas.com/us/en/products/microcontrollers-microprocessors=
/=0A=
rz-arm-based-high-end-32-64-bit-mpus/rtk9744l23s01000be-rzg2l-evaluation-bo=
ard-kit=0A=
=0A=
Cheers,=0A=
Prabhakar=0A=
=0A=
=0A=
Lad Prabhakar (7):=0A=
  dt-bindings: arm: renesas: Document Renesas RZ/G2UL SoC=0A=
  dt-bindings: arm: renesas: Document Renesas RZ/G2{L,LC} SoC variants=0A=
  dt-bindings: arm: renesas: Document SMARC EVK=0A=
  dt-bindings: power: renesas,rzg2l-sysc: Add DT binding documentation=0A=
    for SYSC controller=0A=
  soc: renesas: Add ARCH_R9A07G044 for the new RZ/G2L SoC's=0A=
  soc: renesas: Add support to read LSI DEVID register of RZ/G2{L,LC}=0A=
    SoC's=0A=
  arm64: defconfig: Enable ARCH_R9A07G044=0A=
=0A=
 .../devicetree/bindings/arm/renesas.yaml      | 18 ++++++=0A=
 .../bindings/power/renesas,rzg2l-sysc.yaml    | 63 +++++++++++++++++++=0A=
 arch/arm64/configs/defconfig                  |  1 +=0A=
 drivers/soc/renesas/Kconfig                   |  5 ++=0A=
 drivers/soc/renesas/renesas-soc.c             | 33 +++++++++-=0A=
 5 files changed, 119 insertions(+), 1 deletion(-)=0A=
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzg2l-s=
ysc.yaml=0A=
=0A=
--=0A=
2.17.1=0A=


