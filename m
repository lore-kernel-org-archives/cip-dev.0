Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7432E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 12:44:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.57])
 by mx.groups.io with SMTP id smtpd.web10.36067.1733489082525958864
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 04:44:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gLFJlDPs;
 spf=pass (domain: siemens.com, ip: 40.107.21.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOrs0lVgakKELNIUTYRBlpFxdBQPhKuSi+AbLhMLPUIBimJUy+LIUx6vtDSXEOA7yuJFko9ap2T7YWfegw7W3gAxrAZFrAVVHlwJzD0akYzUfKlJC1otLqyHsDx6xai//siZRZnxem05jmAtvzxFshISl1fzFyXtIjJpKiQL/Aj83/u447ZXYfOIjXCojNOUlQ0mJORJQXmqB3xBDi0tZ1kMbNgkO8h8BA9DB1r5Va77lx7lrXQ1OvCIKIX4xlzipmNFkAHT6RPqPgyrGQ0Y95P+KhAiHaC5fyC6QxJNXVIiw1gBbbxCO4BTtr9puHdnVvbdX0/1neLgg+27UdrVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeBs82aNPwsFJUCLXNm1VnZ4GwRR/FITRX+0ATLv5hU=;
 b=cns5v4nF81JITkJQ3WyGhPqV2yJpOUtFtPvQppaUaSOHA6dOFkKx4NfVBfoSduja0t3xbC3b8yZOJY6d6KMQ7VwroLeAzw9UMPIy29WPsqHwWKhpnwQMEpm4pCU/ZqgfI/rRW+eoURmAfTih5yGXcHPkdjLT6d266FG0wIHO04li0JUabmS1tyEROMsXQP5nTFXQ5WiN7rX+LpcPYtiIeijnR2Vbw5wjNBxkRZiwEdgYSBoXzGhew57UPoD76h4MTAuQ+bQHooXFl6N/W3J9Nib6q2G8gOmOfALaTD/igQ6X4VRdXP/jj0B8QOKJeD5/OjwMi8HBYXNBNOGnuhs4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeBs82aNPwsFJUCLXNm1VnZ4GwRR/FITRX+0ATLv5hU=;
 b=gLFJlDPsBhsDBnibG72JjJhix6Qyt5ASwrjp+IvVFaU6jKAUA1QAr0KLvLarcqtQ5sCHksRgY2tSQq4xo9Cosd0Fl5uHZooFVzoacP+iWJaQrp9w9/1RP9pndOkQ2xJ44Wib74mA8q8aAi9pRhoxcZykdP3sOx5DaWc4u8mg8nH5hgVoztq3BXk442PpUIg9N0htq4VmOLtKKuePlcB17jmYSJZfF+7flP7oXFCeIahl8twc8OB6iKtLODlW/gI5cNorJO4ptTD3yfKJ9q8hKJ9EIqyqXge4f4WDReMAQ5wCwtP0WR59LwAFmBqnkBrcyDjfeB/ASO5NSX/t5xW5sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.10; Fri, 6 Dec
 2024 12:44:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 12:44:39 +0000
Message-ID: <f3a8ce77-8728-44e8-a554-10c32ef7b68e@siemens.com>
Date: Fri, 6 Dec 2024 13:44:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Update isar revision
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <155e2bf8-3a8f-4760-be0c-fefdd0bba180@siemens.com>
 <TYCPR01MB9669290CAB5E0F4DC7E468FBC4312@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB9669290CAB5E0F4DC7E468FBC4312@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 029c40d1-1e6f-48e5-d7f7-08dd15f3bfad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a4sHTDFhoxf7XyWYxraKkcs4Je8Lg6lAeUUgRXnnpUwoPDLl3A2Z2PKH10WJ?=
 =?us-ascii?Q?BORVB7PCRE+M5YBwJjElD6P5plN7PrW2oRzushVBYMre/91cPn26mufYbBir?=
 =?us-ascii?Q?fwvwEvK9paJuR8MIaRFTXHxujKfUzikmn9BRH2Io7rvxKdNozieDw+99YTaF?=
 =?us-ascii?Q?boJ0hJZvyVBiMMI1mibrPRZp3fsXloSk7+/TFvKY7PuVBybm15p394/aFHTm?=
 =?us-ascii?Q?NW8cFwTxqKJt1Ied07x0ZpTEvqwkpqqb6HfvKrvVtQDM0kYXREb6+oltZZEI?=
 =?us-ascii?Q?PakY5X3F6UPNfwjNQQazK4tFsaVCMRW8mT4eTfry0GlfTaoxNRyJD0/cTXGJ?=
 =?us-ascii?Q?/atqFBbns1MFohNzPA4soOss4qlqrLlfSdJl+GNrVkbU6RuOWddc2o4Cz4W9?=
 =?us-ascii?Q?+vPROzN1wAZY7Q1aKjynTOjNZpn194jYJ3NsfM9/1CR8p/dtaphHG9T824mg?=
 =?us-ascii?Q?hL3+Tmr0uFK5T+g6Q6zqxJLhR0ogXsD1xG8+S7i2w4fNkCtkgjLx2wC7euZK?=
 =?us-ascii?Q?VA7TNauTVZ1VSCLsZI4/Wy82P53hRqhPNoHj7cuNuYHDocZvKtsTQDK9QJsv?=
 =?us-ascii?Q?BJDaqZoSXgI+pAnpMlv5h0rGWpXVYqW/OpZeEDurEBPoasIHtSOS0EkpezRC?=
 =?us-ascii?Q?ucHqErGOT2zfp+Sj4f2Dugv64wITods8gbKiOSweaksYU+Nhe+fQADcsBnS8?=
 =?us-ascii?Q?Hq/4sh44896T7wfflDCWUddGIlhgItg/EoCVos4H6heV9DdGSfZOCL3qY5pK?=
 =?us-ascii?Q?kgbkPtrR7raG+utgc8YWpMLrKWR7D0CSxdxfebw8HWJUUof3DJlsRzaCNTrY?=
 =?us-ascii?Q?d2u0FObUaS6E7goXpzhJpHdRIADOl8QSNEoh5BHnUCZpTYqyJnUQiupAIm9h?=
 =?us-ascii?Q?nqSSiRq9dcM8eQB4yy1xrQSFys/0GdNQ+hvw9hgdkaQ0/IJDJHxPpIF2iyCi?=
 =?us-ascii?Q?u0OPwAUR0ss1HuCc1E23m6wsDpSTftpEooQvBI+r3QWbo/KSerr+JZFEjtAt?=
 =?us-ascii?Q?XPZ3tmACDt8Q715XIC5dTzL1TKutcGVvVbdb/s+pbYXZUUObNm1hwisXo/q3?=
 =?us-ascii?Q?CvQYRjIT/i6+lPLnRwiO6ow5MZNbRMyWZEmLOWTydQxMX141ONRGPsjmtF9K?=
 =?us-ascii?Q?P+TpD0fUQIkR5MqCqFPrK1GOlp6aCnbieHHmhZNGvf2GNkqIh4EnLVjPP6vb?=
 =?us-ascii?Q?mfo2ZpP9q+uAYCQZ0BuJ4RflBx0ghe1jdlv4YdjdNb68Lwq3P1tBd00aUYvC?=
 =?us-ascii?Q?2vimu8xuLV7/iIK1IACTDy+NVzdENTGtFlHq3Q3EOz4g4ouEVO70gJ/9SY2u?=
 =?us-ascii?Q?hjY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W7STaaVhrnHzEeCvhmLAEqWgoNn9HWSJfNgyp1Wayllm2rUpbPbkKFMzNDeg?=
 =?us-ascii?Q?ndxa5/JwhcnMW6SrPpdfzMbJx4lYidbge39Rb1eWaxb4Y2tG52+CSd3ZjuQm?=
 =?us-ascii?Q?yGxrC/UulUgi7QlHvqNLODvwt0fZZqwhttHLCSnxg294euvJTw4mVwxiv8J/?=
 =?us-ascii?Q?Npi1dSlWOFjabY7iIkf9ZwP6n3xe82QjAZ18/SeqydaPHS/7fZxNZYSKhhS5?=
 =?us-ascii?Q?T7CvyBSazRqzuxBtgRaztHpaZpLcpM+nPvZcaKFDQIpcIzVDkgl0ZQeDP2Lx?=
 =?us-ascii?Q?H2WuF20bSEjNMmHI2RIgIXgPe5etmK+K8Nbqrlw6higAK3mObjLdupI+Svhn?=
 =?us-ascii?Q?PS35R1CJ8uRF4RIiqt3Wj+c7MjkwkhjUcbxIDmSPMIZ7NRMscKRL/FRDZuG/?=
 =?us-ascii?Q?X1vCoWKnuKcuXyWJyltslHQ3nISoVKVHxIfaVL6uBNuq4inH2IrkfeHjuskX?=
 =?us-ascii?Q?BstJ8lqHMU4NGZMRrueJOPFDtejZ4V0QMhxGHSenpWpnMwhWNFQHJPpXkgC0?=
 =?us-ascii?Q?Wzlk0J6CaUKMucoGvIQBOa/6nBBh4iDdnqjEJswLvGREdvalmdw8m1QOHZBa?=
 =?us-ascii?Q?EBFgnYYhpz9v5QdnfX0rQ9kO0VoHP2JUt0jiGxpAEHXdRPc/VGWqtoCNu0JA?=
 =?us-ascii?Q?nimo8M4Y57YtNUFHZglcoSZRdbYWwTYE3wsSb7hohb5zZHR4mhAhqvaYOE78?=
 =?us-ascii?Q?LNzyDYKaY07P7huvH85YynpgwOL/JzKbD3g0mvvTn2gfe85CpI/1SidVQRzp?=
 =?us-ascii?Q?dxl2gi4sw19tagF6v6JThbuA+BzmB+bhPP+b3Kxm5cBF3NhoTjx9N0OVnzF1?=
 =?us-ascii?Q?tkDxVzzC1I8TYqweUiVFA0PnkO+6bFiXTRQw6vXCW6XNIil1BYAtzHblMNKK?=
 =?us-ascii?Q?T4hC7gQ2yJsFp+tdhnP3lMVDierOVVtpgnLMRXNZ8/6xT6KnSM7prhCst9A0?=
 =?us-ascii?Q?+6uCziIXYWdiquHt/TgNtqO1vgdxQFY14RY5cw2heQB1YUhzt1HQNXF/lka+?=
 =?us-ascii?Q?CDkt2vaBBhCcaFaTYCz+o54wr8wBfw2IqMcRvtHs4T8IUcNsdxfAvSGfcVYt?=
 =?us-ascii?Q?iSsUnS+cWp2EWfSXESR+ldf2mMCurSZpcgFMYXb4j56jkm8inLEv0Pw5/gpy?=
 =?us-ascii?Q?plshDasMG2n5FkAR6iI9IE+GCaW7U8+Z8fCx9bw/EKkFMXAnfT4Q+/gkHv09?=
 =?us-ascii?Q?eKrYKCUdA2U+bPHrEL4RnXXphOOEHaiYi5r2dBmKRU8tWD4QYB5oNTZ+eP1h?=
 =?us-ascii?Q?9XCNeDh9EFSMFJiH/6SEGc8pgtFHq4nN2Sta6yBt+vqNvnWYpA3YDynWb4Wf?=
 =?us-ascii?Q?rd5TB1pfwTk0Q4WhTKMzyElfH6vdkoT9JP3G/59BBkm7ZcPlDRVhmJ4QHeFf?=
 =?us-ascii?Q?UKpFiw2/KJxSiCrqLHtbZYNNsq3vOAk+RBfvbHQtKYrjXIPkz4gi2Ae8KkG/?=
 =?us-ascii?Q?44SWrjLF2cyloK3D31T8jPlXN4QNVTA/HBAELYZ2dMyCGg/q9TjWakJ4RCVx?=
 =?us-ascii?Q?P/uVuJpZgAQolWw6WUbt6VqtvamEmv8dBF2E7cl+A9OM11VnPnOhzf9naeV9?=
 =?us-ascii?Q?Ym+5yUZ9nVaZYyHHXaLepdTu1LJjh+384uQU/8qA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029c40d1-1e6f-48e5-d7f7-08dd15f3bfad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 12:44:39.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdT++zxTSF5nVvJ4fUfBp/fviLh2BfsfoYfbVLFLoyYZwqApkJPEvi/HP25RQ1Z3iuljohBXGYptg8LVVoWA4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8564
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 12:44:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17366

On 06.12.24 13:38, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Thanks for the patch.
>=20
> However the recent reproducible check pipeline run has failed due to a
> problem is with the qemu-arm image.
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> pipelines/1576628108 <https://gitlab.com/cip-project/cip-core/isar-cip-
> core/-/pipelines/1576628108>=C2=A0
>=20
> The qemu-arm reproducibility also failed in the previous run (1-Dec).
> The problem seems to be that the arm kernel is no longer reproducible.
> https://cip-project.gitlab.io/-/cip-core/isar-cip-core/-/
> jobs/8566485827/artifacts/cip-core-image-security-cip-core-bookworm-
> qemu-arm.wic.p2.diffoscope_output.html <https://cip-project.gitlab.io/-/
> cip-core/isar-cip-core/-/jobs/8566485827/artifacts/cip-core-image-
> security-cip-core-bookworm-qemu-arm.wic.p2.diffoscope_output.html>
>=20

Yeah, also saw this.

> I am yet to investigate the root cause of the problem. But just
> wondering if the problem could be because of the move to the merged
> kernel configs for arm?
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> pipelines/1576628108>

Would be worth a try, but then we would still sit in front of some
larger config diff. Any idea which kernel config switch could negatively
impact reproducibility?

Jan

> =09
> Pipeline =C2=B7 cip-project / cip-core / isar-cip-core =C2=B7 GitLab <htt=
ps://
> gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1576628108>
> Debian/Isar layer to generate images using CIP Core Generic Profile
> packages and CIP kernels
> gitlab.com
>=20
>=20
>=20
> ------------------------------------------------------------------------
> *From:*=C2=A0Jan Kiszka <jan.kiszka@siemens.com>
> *Sent:*=C2=A0Friday, December 6, 2024 3:18 PM
> *To:*=C2=A0cip-dev <cip-dev@lists.cip-project.org>
> *Cc:*=C2=A0balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <=
Adithya.Balakumar@toshiba-tsip.com>
> *Subject:*=C2=A0[isar-cip-core][PATCH] Update isar revision
> =C2=A0
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Brings two improvement for image reproducibility.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> =C2=A0kas-cip.yml | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kas-cip.yml b/kas-cip.yml
> index abdf92af..1c868afc 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
> =C2=A0
> =C2=A0=C2=A0 isar:
> =C2=A0=C2=A0=C2=A0=C2=A0 url: https://github.com/ilbers/isar.git <https:/=
/github.com/ilbers/
> isar.git>
> -=C2=A0=C2=A0=C2=A0 commit: a6171856de84da3deca1355da7aa9c09588e7ea2
> +=C2=A0=C2=A0=C2=A0 commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9
> =C2=A0=C2=A0=C2=A0=C2=A0 layers:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta:
> =C2=A0
> --
> 2.43.0

--=20
Siemens AG, Technology
Linux Expert Center

