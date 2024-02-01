Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA2C47DDF
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 12:09:21 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web10.13923.1706789352342813406
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Feb 2024 04:09:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=CsT4GIba;
 spf=pass (domain: renesas.com, ip: 40.107.114.91, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDiFfCCCGzhED3AtJX/WehNfNB22adacM+kdSI5gRNOxK0hdFvur1Fy6K784Qp0TlVjf9rT7VmYPAeANVHY3uzpbJNycCCUTNveLmY3tpZUK+d0YnbnH37rhKE8FJaVYIYphKmC0Jlw+Rs0kl/0uypR9lZIATsLyEy2NgkRAokVCT735XgduFSWFfZM1jUNn4YZY/GvrxEHjy7iH2NBVESN9lYqpc5Xfscwlm1R9wH6LrospN1DqQ2x3tg3otr2w9EZevGKYtQjK0nCE5d91PH4uJYGWbBC6fOYulvq6/0WAW+KXzv1S99HBeOeruVQGsWdMiUApXYvhLz1GnGKkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va5fnXwmbMEiy3A6Aiy6qG8+TnesPm0MzrYiWNCXgpM=;
 b=mboVM+qFshvInoIivCgTXyvbqUOysugQGOy8Zcntb/2R2Q+BFH5shTnTUlNhLqW2VjKYKWJGplDWMqVLc1ji9gGgPIotBC4a+RHIQQwOS0jmd1aNRI9PJcu+JuYodSmEPO9bDhUh89mF9Ld813ZEkIu8yZ7GKBUE0DpF93ddaAiI6hkcOwuBQzKACtQ7yUs16GBi1cbNecRLHp1fHdc5tYMPjHWDUEb7qxl9ufzj/S2fpECUpe9msxzmQd71cPtjK20bTvFRSYLbh5Tmz5v9+J+eyCx3zIcX3bPujq9KN0F5nD+EZpSiWParbfbpFb7jg2PA35sWy3kzcoOkzqOUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va5fnXwmbMEiy3A6Aiy6qG8+TnesPm0MzrYiWNCXgpM=;
 b=CsT4GIba7egVfLMJ7nTRl7G2Yjx4q0xbPhBDgzWYME0LZbxHvcSr4qfbwD86WE9KJ8A3X576khJ2UKyZvJ2Uc9W+3jNc/VAGtX3uabFU6yj9IhoytPSkseMFI9n1RSYqsLi6O4eG2QHhr6FGn6qcPSGiTTiyuDXqyIuB4zMWEww=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB9488.jpnprd01.prod.outlook.com (2603:1096:400:190::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 12:09:07 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 12:09:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas
 RZ/Five RISC-V SoC
Thread-Topic: [cip-dev] [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas
 RZ/Five RISC-V SoC
Thread-Index: AQHaU7u0Rqb8zNCufUy6pLjVH3/UxrDzy0MAgAGSayA=
Date: Thu, 1 Feb 2024 12:09:07 +0000
Message-ID: 
 <TYWPR01MB11862A13E11600A2B297CAF82B7432@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZbowIA9sDtDExkBU@duo.ucw.cz>
In-Reply-To: <ZbowIA9sDtDExkBU@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB9488:EE_
x-ms-office365-filtering-correlation-id: 7f1075d4-d4b6-42d3-5155-08dc231e976f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 g1xhEztNsfbzMvwx6HC4ekMN0rqup6HqqLVU9yqe4XTHU6msUrwYR1GmrlXjT+hY8gW5mKpmdM96YPU6RDa0oT8O8BkEJtOw+KSvkZTdG3t0TJqN7miHZdeoHUE37nEnuL2nPg6rGLBqZQHwbpIHdIznqjyVkwkgZ/xzL0yaw4UMdDqguZZDopsfSFy354MZoC77piy+1c66T7etCB3C6QptCsOCmgfEkQu2yA/scD7HwUgv6847hUboEaX+BNQntQS9+KgUsxc71/eHDLJc5XaPJXyQwRNYz2ai0yVEuKsvVOvGP4N9xpKIHWwZofoAOSLBzyW8/OafGc99sSDO62kynd4Cn2NACqoZe9MgzhvZkCeXMsUEV1OLF7ZMOvfMGYXjNB3rGNfkP1n3noneog7seoxFubtpPznLNYLLSgDSi6aYfgCl5LsumQrfioGApn0X1PsVMvK47IIHPxmWsbJ6tfh5qNUdYhhaKIOcKdJSMas01m1u8r2mNpQszK0nMnIcfCvd8HmBCqm6+mypKhxhdflkcClXr2rQG9Oz+ZUnH449W9QAzfEsSQLSguWHJ9sFTq4+fdhoh20DCD1kAtmBUbn9uIL7Vhw5EBSthzQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(55016003)(26005)(41300700001)(107886003)(64756008)(966005)(54906003)(478600001)(316002)(38070700009)(9686003)(83380400001)(7696005)(6506007)(71200400001)(38100700002)(122000001)(66556008)(66446008)(33656002)(66946007)(66476007)(5660300002)(86362001)(2906002)(76116006)(110136005)(8936002)(8676002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?qm9EXE6/YsP85Gu1n8VkzFfKewB14DFcqH4WPtRr9Qr2hHtKRYMK5EFg?=
 =?Windows-1252?Q?TdTg/PyJigIFoUlo61+GUV9ywLBUCzFhvopBRjv9c9A6R0FC5VLElUSb?=
 =?Windows-1252?Q?iH+8J2/qB9br72ps4/qR8iQNe+BVmdvzIbm6SelhkO+pYKwyGZwjKHB2?=
 =?Windows-1252?Q?H2VXCL3rwgbu46xFYkiL5lxBLgzWgS6OZ37meLSrisyLG40DlaVDfvaY?=
 =?Windows-1252?Q?LqQxfbkWcHyJABk8FN2VaO1KgoS7tnRNZ2YTTKl7V/eCdfIws4vkc3s2?=
 =?Windows-1252?Q?H7i7QoWc+T2P+xZeTGUIGxgDngmMokNmhDh4QG1kxN5fuepcSZJGIIAq?=
 =?Windows-1252?Q?CUERF49LNIfzitHth/j/F1nv4rBaBCVj01umYZaYfF1/jvVk1CLM6yP9?=
 =?Windows-1252?Q?Jf28O1PN6oeVSaf+SuhpmfKUG04PR86sA5NpFJNG3o7OPfAoAMZYUz26?=
 =?Windows-1252?Q?wf0Br15s/Sl3fyl4yYI1P0bO5QER0NpANcN7FuMG8cz6tuXNaSJYa/C4?=
 =?Windows-1252?Q?SpiDsDbFtZ4N2KlQXgBAVG+kDwej70sjD0fBalytIzqsW662Wj0vNChX?=
 =?Windows-1252?Q?SqRbXcucFq0PpXaUYoZqxmzUyqHPQX56yyCAQCkYiJbDx0DZKfmctzoA?=
 =?Windows-1252?Q?bk+p/cEkHHXiucRoNJEG8IsGfnJ/EYoOay/0rT/nxIjex0v35MN7+cb9?=
 =?Windows-1252?Q?gXcUvfoP4my8HYVEaU7rz2ch9/LNwG/oT2knxFfLAPNnCM7mLPwjA3c3?=
 =?Windows-1252?Q?5OzPEZDoOfgmbOmUh5MM5gynhrzC/YSE0huEDMc+34Fq90ukAEpSi5jx?=
 =?Windows-1252?Q?qdzJh5YR0//YWyDlmWVJkK295dRs2sTzl4o1j+YTve0oqqishnK8m9Mk?=
 =?Windows-1252?Q?yr3KAy6ZhnVpuTgie9aHnfwsj0DgLLjEdbQh39j60LxoTz3c3RJQFC+p?=
 =?Windows-1252?Q?PT7eLM94LAA0A/viAy0GvX6ec98VzMaPv/h8bUYwCfcLnlQTAFYX1BJh?=
 =?Windows-1252?Q?43meQ3eiIqD6Zx+Omr9QtHD3mOJ9DK9U+GsG/Z7qN7DOgGgnVtg7/fFT?=
 =?Windows-1252?Q?IaIf6zwq27jO8vRm8IENRzxRyBVhRjgGjOl9MznR4A1EgNGrzNEd1C0g?=
 =?Windows-1252?Q?hI0RdAVQNWEKdg6BC1DkydJEUrc47CeoD1GUYOAugz06Etj6p3UicWrg?=
 =?Windows-1252?Q?Ifdjr9DfOc2+TiQRV2ctffX3QnJxZzcgUI76ZR3+vy4P+eq87yXPvEvM?=
 =?Windows-1252?Q?mBzGmW18fqjkzRplwINAVPSPGgDkBGnJnzdq92sOdR0WvlccPw2lb24Z?=
 =?Windows-1252?Q?c49NdiTa+gkmgSdi7f7EeRVJJ+snN54dPlgUZXI1RlOB0qAJeR4yxqxy?=
 =?Windows-1252?Q?O3mmx5WqWny++GfI83dM+9DlqPiAM+zbCAsoJwFDE1YZCFp8ST+4jz30?=
 =?Windows-1252?Q?RNXEWisadifz4chcpvPdwOKzt6MTgAEsG0jbwzyyLptdEcxOzK2gpy0J?=
 =?Windows-1252?Q?gs40+Yjlp1k9cCO6wVhMWpofQD9Enuh51HIIRNjj8t0b5u3vgXCWnWeo?=
 =?Windows-1252?Q?uYGuHkR3k/aATwM5kTQeCbKDlteLgkDXVJ9pzQKXGdpvfGBYPnSmB85E?=
 =?Windows-1252?Q?lrXjd43ydjS5fOnMAoNnLXesEbq9XCL6oYoNGY+RyjgtazcSlfQoamx8?=
 =?Windows-1252?Q?B8Tp6siPiWlJdNP7UT1y+j/f1dBf8mn4g3aMOdcgrETqMIPGfU3B4Q?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1075d4-d4b6-42d3-5155-08dc231e976f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 12:09:07.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXyDH63i82R+SUr2MeJNGm6FdkJFzvXnIwTq/WAv9EVfc0DlN21PQyL7HPY66VJ+4bejaDXsVTwJklc9EFEwxwvHZJO4aty1zYKQdRbcg7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9488
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 12:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14579

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, January 31, 2024 11:34 AM
>=20
> Hi!
>=20
> > This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> > support for this SoC has already been added to 6.1-cip kernel.
> >
> > Sending this series as an RFC as,
> > 1] Support for Global DMA cohernet pool is added
> > 2] As support for non-coherent DMA is missing for RISC-V core,
> >    required changes have been added directly in ax45mp_cache.c
> >    (ie patch #26)
> > 3] Patch #26 has been newly added, rest of the patches have been
> >    cherry-picked from upstream kernel.
>=20
> I quickly went through this, and found nothing too crazy. But as this
> adds whole new architecture into 5.10-cip, I guess I should get

My understanding is that CIP is already supporting RSIC-V in 5.10-cip, as q=
emu riscv64 is listed as a reference platform for it [0].

[0] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting=
/cipreferencehardware

> confirmation on the IRC. We'll also need to add this (and RISC-V qemu)
> to 5.10 testing.

I've done a test run for build&boot testing for RZ/Five [1] based on this M=
R and it's dependencies, using a defconfig [2] provided by Prabhakar.
If accepted I'll add support to the official CIP pipelines.

[1] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1160504=
705
[2] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/c597a7df97=
6d7dbbfe82d8de26e75c1f78c94f24

Kind regards, Chris

