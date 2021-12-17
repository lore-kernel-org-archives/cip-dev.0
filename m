Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF3C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 07:42:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.3655.1639726965820338521
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 23:42:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1BH7gZcp007803;
 Fri, 17 Dec 2021 16:42:35 +0900
X-Iguazu-Qid: 2wHI0yQhPyVaym4ACG
X-Iguazu-QSIG: v=2; s=0; t=1639726955; q=2wHI0yQhPyVaym4ACG;
 m=kMCOsTC9pM/IG3kWe634IeuAMJr3a3cKTvir2CJI5/E=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 1BH7gXZJ027816
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 Dec 2021 16:42:33 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 5920710011A;
	Fri, 17 Dec 2021 16:42:33 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1BH7gXAk017402;
	Fri, 17 Dec 2021 16:42:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fydIUCAOFw6uyMbRV5H8jgHqkGhOoURbpVEJFX0xmmf+PfpO6/CDkV21qJwQ3aMuvVFXq2k9RVaM7kCjOsKGwOFcizTWPc30k12O6+tfbHCq13x0jfZqub37fp5ZYKWNntWiKqPZjvfPrRaDkfO3SKFSzyRWyoHhQyoRbYAM4nYJASxAr1MGOnKCWH0bff++jCL1IkcQnFcFheFSr8dKuw2h8WudUg1tPpnQM4jHec9Mw8eyKpU/NiJ9ly9esU3/kD6vn1VskvXud9L7LC5aJfxBQZ9e+7lKJ+VilYfrBeMdOUkofFUxQr1eQX40ePk8R3PTGFxy5cfDcdSjhrRLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9qCS9xCtf6TjOQfbCG1xl3zdq2+mhLlSi5NWkXFfys=;
 b=LQHYPiw/2YVqiihcbl2Njo/AD52oIl2kwXXRgE282l+1d9lebtyFZtjVmEWWYRsH27tcT7rdMSzXOFivLsbssYmQl22+6HeWenWXzvi/BeqkDXB0lDX2JVwMAU4Ygf/e9t/JE+viyhinyZUagdXXOpTJnGLGTG3yPTafWCL13mXSApSPdpb3iv8lXrrFI+45p+urVYgaBoCSfBMxoRzmx4nzJEymP3+toY8c34aGVTVoHFE63vKxaGQ7gt5vbr0S8oaXsT6AH0uIlEI1zZwV0DafGbVhh3PaE2j3RT5T3WM7hxGmA4U/UmhHFUsS6q09JSVvGh5wjgcqUDDKK9Wd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for
 Renesas RZ/G2L SoC + SMARC EVK
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for
 Renesas RZ/G2L SoC + SMARC EVK
Thread-Index: AQHX8nwlbA2Nulx1tUqAMTC4vbetRqw2S8HF
Date: Fri, 17 Dec 2021 07:42:28 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252CF2DE6303073564AA03292789@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a6a946d8-9d09-360c-3c1b-02c475db8d77
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb950587-db99-4310-2f07-08d9c130c6cf
x-ms-traffictypediagnostic: TYBPR01MB5440:EE_
x-microsoft-antispam-prvs: 
 <TYBPR01MB5440DD795C9DC36FCC6A6AF692789@TYBPR01MB5440.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 efPZ2ZS87Szwh33RgQBZvRMYdrwunz3McXNJaYcDyfQO3/6HXbh3FIXNqKXmyjFwc75LK12OXK6HRKHndfHU18UXvX1nV4TTCvRhFTSOHMOzyWHsRDQ3DbiVcDBFgRVNyRYOXqhVCAuMDbA+YDhCi5zokbEt10F30sMshwZv39nB2O6yRKIbTbpG08EegSKW0RosrNz0TzmMADVDe2OSuup+rXTfRa/3mTIj/vGqzO+mf99v+ulWXA1qJCqCnQ24yKO2rvNlY7VSHdpoGcr1N0N1fpt6FeLJ2RnDEBfGRMX2+QowS5wApaOeXTUbuXWKOfWfzVKiOuZ6NexJfePjpBhJWUchTbC4B/4aB35B81gutFwTaLl7GoqDbAzQ2GPXw5an/cuUJpurHykXhHiN2/I93ObVckTpRfK+IXkHLUZeY5LLnkqdJ2qho3hydzK/vDp8f+Gpsgmhn2KoFyHMS0jwb7kW6Zq+lIU8rGvgjNCut9+ebEEGpi46cFiJLo/5NJB3XIasbmzSz8i6sYkIP+w2n17pSkuhAKGhTv+bORSmzuNrdq3Z204a7vQlb8Ds/P1YZLzZytMIq9Wt4JTF46ZgElDouqzDOkyHooA+UYRJ4OR7qMbIgdRcbw4Unn+GCVrspFwnojmJ++ITHuDEksCuqXQTY00j3aANRd288+fd7p2dI25GrrOkh6TITpqzNznW0gQCmnPIqis2IBUv7s64M5bug1b6FO+ivUSl/mhL0pg/UFUpJbtmibWiQHDLTtyjU5I+MUff6BIG9TwGeEcphKwoupMpP0AvSP4yju5zA4+au3DnFUrXP0PDKtk2mjjPIATWYUEddqogSShcGA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(33656002)(4326008)(8936002)(122000001)(26005)(2906002)(5660300002)(66476007)(55016003)(7696005)(86362001)(66556008)(508600001)(8676002)(6506007)(38100700002)(66446008)(76116006)(83380400001)(64756008)(316002)(38070700005)(9686003)(186003)(66946007)(110136005)(71200400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RzhZSEtEMDBvUXowQVFrOWoxZ3F3S3pIUnVpb2JoTEdpUWdFcTkyUXRl?=
 =?iso-2022-jp?B?U0RkRnRyL2YxcXp6RDRuUU55dFdKckFBZnE5engrZndINFNMWCtOR1Jw?=
 =?iso-2022-jp?B?YUVReHVIZ2srVXZ0Y1NKa3NZTG5GL3p5Lzk2OEViUWRBNDV3bUpOUHB2?=
 =?iso-2022-jp?B?akFUTHY3VGRyTm5ZL1owNUJrWFNxdXNKSmZQaWpXVCtvOE5nNTQveHo4?=
 =?iso-2022-jp?B?VzJDTURJZ1dmbDRPMkZ6WDNIcEhZSGtTbVR4b1NoTkRmUG1QdmFkcjM4?=
 =?iso-2022-jp?B?elZnbHcyazl3Y1g4ZE9SQTlYVW5vK2FFcDVFd3JxdjMwbksvOWxVNkEr?=
 =?iso-2022-jp?B?YUJvTTkvWjdHckJTYUNnQU4yNmxEMjBZT2QxemhwSFFuMFoydHpRYVVL?=
 =?iso-2022-jp?B?bC9rTWl4dVE0SURQZWNnWnBEVUxXTjRPSlE3RTlzYmZkRlRjZFF4VjNF?=
 =?iso-2022-jp?B?dWdSR1QvT1lBWDlWTWlkTUVwNktlQ01MNVVqcWFpRDI3SDZITjFDQ1FZ?=
 =?iso-2022-jp?B?OWp1RGowQlBRcmRMU1gwcXhST3BJaElRVUpZeFVwd1JVRGxTMkFKVU50?=
 =?iso-2022-jp?B?UXF0UDAzK2E5NDNFZUV0WjdsMUNkeUZtV0FlZmxtdHNEbHlnV0sveVZx?=
 =?iso-2022-jp?B?WG4zZlJ2NzRZbytFb2FranZWRjRoRFdIZHlIaU9VRzZDUDFKUFc4bldU?=
 =?iso-2022-jp?B?dS8ycnZVY1I4czRYeXBsRS9JRlBNa2pBSDF5clJLc3c2M29yTkt6am5B?=
 =?iso-2022-jp?B?aUVmc3UzemRPTmk2OTdCeTJEV3VMYVg5a2FrNUZ4czV3RkJtN3g0VFFm?=
 =?iso-2022-jp?B?YkR4TnFZVlhpaUdwRE5lWERycDRkWGpPcFRmYnBNVG12YjJ3S01qeEgw?=
 =?iso-2022-jp?B?UU1MdmUyVkk2cEQ5SXBFRGVwUHNZTWpZQnBCUE12NFNUZkRxQ0dIS1Ru?=
 =?iso-2022-jp?B?anlyVE9zaGM4ajdOaHZUM0NHUDZ5azRjYTh2UFdReERGMmZGNzZDL0Ru?=
 =?iso-2022-jp?B?YWtyMnlWUkdGRjkzYi84Q2FFVks0K1I2azZCdUdzL2tSSjdSQ3M1NGJk?=
 =?iso-2022-jp?B?NHY2cTRuN1ZXS3NXZmM3Z3ppSTZKbTJJZ014a0xFNG44Mk80NHpMYmxB?=
 =?iso-2022-jp?B?WWtNMG1vakNDOCs3ZEY1R0FlaklFWndyckZlQ1FpYS90bFFFaGZsdHlk?=
 =?iso-2022-jp?B?elQ4MUJkczFXOGtCbE9yZFV5UjNaWUhDdkljYXd3bjlTc3VEai9yR2FL?=
 =?iso-2022-jp?B?QVduaUVYMTFnOENQdUgvV0ZjelQwZC9PajVIaEFNdVVNcUxRc0g1WmFG?=
 =?iso-2022-jp?B?VW1LVmNuZzUvekZ6c0tBOHFMQ0l5WHlPMjRCN2tlWDJ3NHF6ZUg0d0dJ?=
 =?iso-2022-jp?B?czdDUVNTTE4rVjVBYlliajFJZFRsVDl2L25HbllZREE0ZDVPYXFCckFR?=
 =?iso-2022-jp?B?V0VJRGZKdXBuRzFwK284dWs2K1JtYzhsWkFxL3BOVWVYTTdQaGdFS2Z5?=
 =?iso-2022-jp?B?OTBPZ2phbnYzZ1hqdzcvSFRsaEFNMjM2eDByZTdPdGhhUnFrckhFUVln?=
 =?iso-2022-jp?B?VHQ3aHZCYm9sT3IzTCszb25hT3M1aTczSVV2V1lxWTRQQlF6d0QyYnVs?=
 =?iso-2022-jp?B?V0JsTWN1U2lGd2I0ZC8xaFBQalp3aWVTNWZWTEhjbUlVNTlIbkpKSUxK?=
 =?iso-2022-jp?B?L1JLbURqNjdYQk9XZ2VLM0twK0RBbE4veHpwRXlhalNDQUY2bFFIa0cr?=
 =?iso-2022-jp?B?dndXMVBwNWFFK3RwaVhHSkt3RFU3NmVzQ21lSzlpaUFTdWdONTN0Z3Rv?=
 =?iso-2022-jp?B?SUhsKzdQY2FuZWFJUkZxbHdXOTBDQ0NBWDI2RzJld3NtNWRFQWkwbzJI?=
 =?iso-2022-jp?B?YmdpdVhuc0NkQmZmVnF0S21nQm9randjcVFQQXQrUXc1S3Yyd1huY1J2?=
 =?iso-2022-jp?B?THhmV1greHliVmZRL3VmMzlNNVdvMm5mdld0TmRoYVVsOFMzRnJpTDMw?=
 =?iso-2022-jp?B?TnZZV3VsallmQ1FrdDY3L2JsUHQveGhDOTJsa2NQY3hiV1VMaExlYlho?=
 =?iso-2022-jp?B?VzYrcUlFaWlDbGc5c2ZrQ1EwejdtdFYwWHhaWThrM0N3dndEZkY4WVFl?=
 =?iso-2022-jp?B?ZkpEb1MxTStnTDlEYzM3K0VmWTlIMUNSM3lSeXJ2RGxuM2dPd0RrbFl0?=
 =?iso-2022-jp?B?bUJFY0NpZ0RvY1N5MmdFZGc3c2tPMzJ3TURGN282amFYR3dDSkdDZjMv?=
 =?iso-2022-jp?B?NHhIZHVLdnFIWVhid1FjYXdVbThYZGlnWGliN3RJM0J1QXVJREs4WDBC?=
 =?iso-2022-jp?B?RDBWSzlqMDFLYVFMMklHU1lLaHhLSHhDVkRxQ2habExaZzdVcTBreHBw?=
 =?iso-2022-jp?B?VXZiQmRnTCt3bDFyUURKV2tkeXhXUWxVRVZIM0MreEdmM0QyTnFjY3gv?=
 =?iso-2022-jp?B?dldvdGpESy8xck85cHpXZ3Q4N0F6N1hHZ250SVJQbnU2eWkvTzNYbFMw?=
 =?iso-2022-jp?B?OCsxOGpS?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cb950587-db99-4310-2f07-08d9c130c6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 07:42:28.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 D9qRxpb5c1t+LFwuAb0vCG7G6aULztNQT/rcsrzyusARjUDcwpSmjQtmxX0RuYiqm/iGsWQdX6MXzWKlyJ9cpHM6g4X32ETRLEAgrOPqRHUtiWAm+Wq7Hlf+710DUV8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5440
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 07:42:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7169

Hi Prabhakar,

> This patch series adds the following:
> * Serial support
> * Clock support
> * Initial RZ/G2L SoC DTSI
>   - CPU
>   - CPG
>   - GIC
> * Initial device tree for RZ/G2L SMARC EVK
>   - memory
>   - External input clock
>   - SCIF
>
> All the patches have been cherry picked from 5.16-rc5. For testing purpos=
e
> MR [0] can be used.

I will check this series, and I am also checking the build.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/431663140

Best regards,
  Nobuhiro

________________________________________
=1B$B:9=3DP?M=1B(B: cip-dev@lists.cip-project.org <cip-dev@lists.cip-projec=
t.org> =1B$B$,=1B(B Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>=
 =1B$B$NBeM}$GAw?.=1B(B
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B16=1B$BF|=1B(B 21:54
=1B$B08@h=1B(B: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=
=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B); Pavel Machek
CC: Biju Das
=1B$B7oL>=1B(B: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/=
I for Renesas RZ/G2L SoC + SMARC EVK

Hi All,

This patch series adds the following:
* Serial support
* Clock support
* Initial RZ/G2L SoC DTSI
  - CPU
  - CPG
  - GIC
* Initial device tree for RZ/G2L SMARC EVK
  - memory
  - External input clock
  - SCIF

All the patches have been cherry picked from 5.16-rc5. For testing purpose
MR [0] can be used.

[0] https://gitlab.com/cip-project/cip-kernel/
cip-kernel-config/-/merge_requests/52

Cheers,
Prabhakar

Biju Das (9):
  serial: sh-sci: Add support for RZ/G2L SoC
  clk: renesas: r9a07g044: Rename divider table
  clk: renesas: r9a07g044: Fix P1 Clock
  clk: renesas: r9a07g044: Add P2 Clock support
  clk: renesas: rzg2l: Add multi clock PM support
  dt-bindings: clock: r9a07g044-cpg: Update clock/reset definitions
  clk: renesas: rzg2l: Add support to handle MUX clocks
  clk: renesas: rzg2l: Add support to handle coupled clocks
  clk: renesas: rzg2l: Fix clk status function

Dan Carpenter (2):
  clk: renesas: rzg2l: Fix a double free on error
  clk: renesas: rzg2l: Avoid mixing error pointers and NULL

Dmitry Baryshkov (1):
  clk: mux: provide devm_clk_hw_register_mux()

Geert Uytterhoeven (1):
  clk: renesas: Rename renesas-rzg2l-cpg.[ch] to rzg2l-cpg.[ch]

Lad Prabhakar (9):
  dt-bindings: serial: renesas,scif: Document r9a07g044 bindings
  dt-bindings: clock: renesas: Document RZ/G2L SoC CPG driver
  dt-bindings: clock: Add r9a07g044 CPG Clock Definitions
  clk: renesas: Add CPG core wrapper for RZ/G2L SoC
  clk: renesas: Add support for R9A07G044 SoC
  arm64: dts: renesas: Add initial DTSI for RZ/G2{L,LC} SoC's
  arm64: dts: renesas: Add initial device tree for RZ/G2L SMARC EVK
  arm64: dts: renesas: r9a07g044: Add SYSC node
  clk: renesas: rzg2l: Fix off-by-one check in
    rzg2l_cpg_clk_src_twocell_get()

Yang Li (2):
  clk: renesas: rzg2l: Remove unneeded semicolon
  clk: renesas: rzg2l: Fix return value and unused assignment

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  83 ++
 .../bindings/serial/renesas,scif.yaml         |   4 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 132 +++
 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi  |  25 +
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |  21 +
 arch/arm64/boot/dts/renesas/r9a07g044l2.dtsi  |  13 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  27 +
 drivers/clk/clk-mux.c                         |  35 +
 drivers/clk/renesas/Kconfig                   |   9 +
 drivers/clk/renesas/Makefile                  |   2 +
 drivers/clk/renesas/r9a07g044-cpg.c           | 142 +++
 drivers/clk/renesas/rzg2l-cpg.c               | 844 ++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h               | 176 ++++
 drivers/tty/serial/sh-sci.c                   |  12 +-
 drivers/tty/serial/sh-sci.h                   |   1 +
 include/dt-bindings/clock/r9a07g044-cpg.h     | 219 +++++
 include/linux/clk-provider.h                  |  13 +
 18 files changed, 1759 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzg2l-c=
pg.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
 create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.h
 create mode 100644 include/dt-bindings/clock/r9a07g044-cpg.h

--
2.17.1



