Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA4CD5BA4
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 12:12:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.6727.1695125516780100828
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 05:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38JCBsX3286537; Tue, 19 Sep 2023 21:11:54 +0900
X-Iguazu-Qid: 2yAaLCv848dTOeUL1V
X-Iguazu-QSIG: v=2; s=0; t=1695125513; q=2yAaLCv848dTOeUL1V; m=tcR5ydzXhkBAQU3PywuyGyu3XdINxA+mIXTfSfyH2qQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 38JCBrwX1944199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Sep 2023 21:11:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY55g7yqD6tBfHNFrJvK6+SJ3+O664OqJ9mU86AXRqB7YSY/0Jd/dWagxu/aQamySYv75/7eIbAkj/H5ZW8PGINwXBgfKQj+pz57FqYWW2w29IMxmys+NvmdO5P92aNQKkRpS37bZ1ZUBQBX0YOR4lwxb/cVk1+GFLNKCuSCh/lat1MEVd/ESXvqlAr9CYW2fQKPoK7sKbs6s03iNqXPebf1FhTk/FJKZX/W1X17LrBGpC+VQP53G26YzFd3IUZq+n7Rw2QtK7ybZgXDQradzQu4bMzdxzTjYK6zlunCBZvnXfhe7EtlVDj45pBD4+K9QL5GuyBaF5ZNHCMIy/EQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR9hrRQx/KHHomwx8fKGLraQX+5/Fq1Qq0CoAxH9bE0=;
 b=j6x7DWf8gvNVAQnWUTzWxSDQrNQ2tsSChECxD8HSf6AsWr8y6UkYOkqpe33CliYkeXPJ2/pZgWx5LOD5ceDcOPb776y783DJ/E4DqJ/X59DX8X4u1Jz/LqyaMT0KokPNMakKQoK6biveuaz1EPx7ijUqXY+QeBmYBULOYw6pqmr0rnAWyt1P1lbPax0Zj0B+dFThCCGnKwxn8+QTCbOYlniIojBVWfeHGe8hG4t8UY85FaMRiB0aTAbRJBV+Jz6nMn+fzH6RmoepHDd4NLmoJbc0qirUNzREqXNs1KqZ4DkYCd5xneADbTpmFR1Ak+hh1RDuxFgNWYXp3LK/qrQ+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-kernel-config 2/2] 6.1.y-cip/arm/qemu_arm_defconfig: Enable
 TPM-based LUKS partitions
Thread-Topic: [cip-kernel-config 2/2] 6.1.y-cip/arm/qemu_arm_defconfig: Enable
 TPM-based LUKS partitions
Thread-Index: AQHZ4k2oi5n6xNfxWkGyyv4RsxleZLAiICQA
Date: Tue, 19 Sep 2023 12:11:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94200FF1D4C3A5CDE583447F92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230908121152.502670-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230908121152.502670-2-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230908121152.502670-2-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5904:EE_
x-ms-office365-filtering-correlation-id: 1f22e350-e365-49c4-8aff-08dbb9099a47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DqU8WVz3VxblQinzsa8S4Wn4D9N6PjMD9hvk4ygsquIIobgC4syhQACm9SkujV5myJ7bnZeYjA4YCREQQdPHc/92eddolsYinZ24c1gEX6L5V4HaL56JqcMVlYgUw352oK/pLxEAtCwePjwHd1twuLGKa+axeyAtDG219THpYIcT5ZjGzD7dCxBOPUhO7UJGRff2IBJrHs2qrrIhkUl8I8tVZV0fmsZzmBRAJD5Kw1OtQHEnuKfgL0lt3se4Zas6GjWO+4ZTTK5r+RhCXhRMuNfGpIrvKl4LAR/p31qsH4VMJY/WWPeuUdAPjmbaqPtGBZM1Q1TCiAbfVJKVcJlFEw4MufoMB+40YVDEZVVsJ3OMy7gSrFI3vgQGpLF/pLYTKIhVpQOGjHKm00gopfgx+HoQLYxe2YrG7yibr6G5Ca9twQ8kprkNaG47lpA5aHO87BBbuv3UhNvPsvPWEGJ0wpT8L8zOt3cdqKtmjUStuFVBSHCVwV3N9kgNLCYlRIKjSQM0JZg/x7AbM1mEtXfBASqv2piL/VNinjnbfpACAERZgsmi3FgYYyHpbJ5ObC7M6JSRVmpfofTl5isBSagQb2D7tOCGtW4+Jvgqq8DafM2y3JIqfvhVDsTp4pEUHpiju4RL0rouq9eSnGGn2ZgWWw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(55016003)(71200400001)(122000001)(54906003)(38100700002)(8936002)(4326008)(8676002)(38070700005)(107886003)(33656002)(76116006)(53546011)(110136005)(9686003)(66946007)(41300700001)(64756008)(66476007)(66446008)(66556008)(86362001)(316002)(4744005)(2906002)(83380400001)(5660300002)(26005)(7696005)(52536014)(6506007)(478600001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bHpWU2orNnM1U0VpbWNCYTZtY2VrRGlyMFJzZHcvR3UvdFVtalkxNnpB?=
 =?iso-2022-jp?B?WmUxWmFJaUhKNUtxMFJhekpIamEvSXBFY3JlK3RsbE1TUk9INi9VbGJJ?=
 =?iso-2022-jp?B?K3ZNM293eEtBb09ybkMvMWl1Rk4vczB3VkdwVitoU1o0bFB4WFozeEYv?=
 =?iso-2022-jp?B?M1BhWjJLSFNjcHhlTE5lbVFyZnJ0OXRwTkFLN2lJbFRTR3BHR2VPalhu?=
 =?iso-2022-jp?B?YmpTT2FHblFvTUgrZjZUMytNQVdudXhNT08vMEQyanVLMXZUOXlSTDIx?=
 =?iso-2022-jp?B?MDJNRE1nUEFYNU5GeU0wdEFadTE1Z3NKSTI0VFVzQWF3S0taY1JFazFq?=
 =?iso-2022-jp?B?NHBuUSthaUpBbWNrcXYwVjlVMnhHNEd0UjRGS1dOdEpKQ1BBR0NXM3Mx?=
 =?iso-2022-jp?B?VzFxUGtvaFZONDZZcXRyNHF0NEJCOHl3eXRBZ0wrTnVGVlZDR3A2WU44?=
 =?iso-2022-jp?B?ZWludzR4aGpBRXdRT0hwMmtLS0hiYmZmYkN4SUFMc3JwaEJjS0R2MDB2?=
 =?iso-2022-jp?B?VmdFamN1TzNOVlNjeWhBRktDSkVRN2lDbzRRWTdDMzBSVEg1S0hnZXFi?=
 =?iso-2022-jp?B?RU9qcjRHSXlBSzJKUWhHZFZvNml2UVY3dGkwTVhuYXR6dVhyenovejEz?=
 =?iso-2022-jp?B?cVhwVGp5dzdIb0E3ZzRyQkE0N21mSSs1UktMZnYvQVF5R0tkZFYreEdI?=
 =?iso-2022-jp?B?aGVudGZGd3JURHlpU2ltcmJ2Y3FmdDhjTnFmYWVXRmpUNnlPak9CZ2p3?=
 =?iso-2022-jp?B?cmxEWG9icTNDTUJjZE5qQ3ZMa1RSUDAyT0V0QStMZ3N2R2pGb2hSWmNo?=
 =?iso-2022-jp?B?VC9pSWdkZFhaTFVXWjEyMmdVMmZBY25PWG9iSllBVlhFQzV4M0Q5VHFn?=
 =?iso-2022-jp?B?K2RNRkdrVUF5TFJIYXp6ZkQ4YlpydW0wbWRZbC9wQUFzY1FzUHgvNVpP?=
 =?iso-2022-jp?B?RGk0aitoV1dYdjIwQ2xMR3FXUmx1cExtc0NVTXROS2F1T3V5bnBzeFdS?=
 =?iso-2022-jp?B?QWhWQ2doaVBUeTRldmhwZ2dKeTdtTEVlbjFDU0JDMHFudklGczBiaXRR?=
 =?iso-2022-jp?B?M1hkaGxRRjVtWmRWam4wMXFsalBXM2VwUG1nZUdFeTdMOUhEWndyY3ZW?=
 =?iso-2022-jp?B?WjNPZ21BbXA2dXhlVU4weHpqdDNvRzNMTUp1QnA1R2hnWkZFb3k0Nms2?=
 =?iso-2022-jp?B?WE8ycnRtRkJMeU5EanNzY05SM0hxSWkwNFcvS0JacC9wdm9QRisrWk5W?=
 =?iso-2022-jp?B?RHd2SGJTdHFZOFErTTFUZmxTemJQRS9ZZUpYWS9ZZnRLbGxXOWFtMFJw?=
 =?iso-2022-jp?B?b29JTHlXbEpXdVA1WVRGSjlzUFY0VWkzL044NTUvRmFTWHBqNXp4UUdn?=
 =?iso-2022-jp?B?anl1TDBEYlduQnljT3o1WXV5b3djSkVSMHBlYUNmc3NqV2VWa3htQXpI?=
 =?iso-2022-jp?B?M1paRUV4VUpjTUNwZ0pBK0hETW1Zd296ODBHVWdmRndEUTV1bC8veHJh?=
 =?iso-2022-jp?B?bWE0QWNFM04zUm9pZHhMRTlESm0wcEZZUXhxZ21NYmNiN0Vzd1p4VVVK?=
 =?iso-2022-jp?B?anc1R1NuSlBGaGdUa2Q3dGJSK2dUb0VxdXRjbnBZRmxQbkRuc2tjcldG?=
 =?iso-2022-jp?B?MnBpUDhFZW9aWXlncUlZSlE1Uzdlc2ZYMy9zNlkwOEk1dGQvMDVuT29W?=
 =?iso-2022-jp?B?VG8wR1JnV0Jncm9iY3Y3RjhTSktIdTE3YUZWemJscUhkYnRvUkJDMS8x?=
 =?iso-2022-jp?B?SFpMMmZnNXhjd0ZyZmE4MzltclowMTJpbWg0SzQwYW1sTnR6bVBuZ1hE?=
 =?iso-2022-jp?B?SlFXekl3OG5POTljSmN1eEtlemlJUkVSdERUd0RQZHBLN0ZYamlsVzFp?=
 =?iso-2022-jp?B?c3hXY1lsaDM1cTJlNXBTYVZzc2VGZU9icXFCdDZqNVd0R1dGc3hTRWJF?=
 =?iso-2022-jp?B?UURjeUxZVE9YYUhxY01iRUlDTHVmQllqRldmK09kZzZXRUx0bE1oWFZH?=
 =?iso-2022-jp?B?Rmk2YUVIUjBDRTI5TXZBT1RrSjFDVzdHWHVoc3VCL0ZCR0FZbkpwRTNt?=
 =?iso-2022-jp?B?RWMxYm41UUF1bCtabklHa1piLzZzdEhOQm80NTZiemZRb2dwMjkrY0tE?=
 =?iso-2022-jp?B?SkRGSDBBa3JrdUtMTGtKMWFic3MzK0VIV2pnUEgybndKVDMxR1pIUkZt?=
 =?iso-2022-jp?B?dFNxZ0xZWGNOUlFTZ3hXcUNvd2hOYkZtZWZremorcGRXR2g3TUhLdlJ5?=
 =?iso-2022-jp?B?OEJqdm9KbGxvdVRmRWorNzRjbFZmenU2QmhWQkJQVCtxOENOREhyRFpx?=
 =?iso-2022-jp?B?SFFtcVY5eWFWZjdET1Y5R293bDkxNEFhckE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f22e350-e365-49c4-8aff-08dbb9099a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:11:49.6831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAHv5IIj7ej8TsG1ezTtnsq3SuOcQ9CyxIYeP0yTP8fJBGufeL3t/ToqSD+yt13K44Gh54nZ9FLOfO5glIpuv+Vu23jBVHavwjYb1oHmQ5CpHmh71MwuDbMVkmY8Hx+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 12:12:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13146

Hi!

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Friday, September 8, 2023 9:12 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>;
> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I=
#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-kernel-config 2/2] 6.1.y-cip/arm/qemu_arm_defconfig: Enable
> TPM-based LUKS partitions
>=20
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These configs allow to use LUKS encrypted partitions with the passphrase
> stored in TPM2.
>=20
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  6.1.y-cip/arm/qemu_arm_defconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied, thanks.

Best regards,
  Nobuhiro


