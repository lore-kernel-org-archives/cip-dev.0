Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8CFD6ACDB
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 14:10:00 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.82])
 by mx.groups.io with SMTP id smtpd.web10.72457.1732716594543134025
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 06:09:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=W3cZjLh3;
 spf=pass (domain: siemens.com, ip: 40.107.247.82, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMnj1IHWzvnUvH/oSjARCjbCT8vNYtKgRQPaY4u5cbPvzeyC1gI9DluLU486X2XtPxmUp3viW23bnGKskh/dXbDY5xdnGejkF7gdL1zdz1zhYLeLiMqB3wrRphOhCOsOmmNaOlQWoE7fDF1TTi0hUtC0jL98JA+PiWV7DMkUWpTJ+TAXc9q97c+ThHIGFH6I4qnSfYpFAOe+Uk5wGwRhiccAV5H2YHQRYrIHCa6rDJxw+elEXSLLOhX5fHHlAn1X0EFARon+sc8HUdnhkm2Ti51f08U5Qsacv0DZppoDMlt6xfUCJ7wqoSN2uMg1ysaZyse2FqYSGNyW+CwH6HECyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxG7OOV//vTSuP9229r/V6ngcB+TkD86QssdIHR+w20=;
 b=LzPfJIuzh7MC63y0kuKlLRzJOZctulPfYnX2VY8AWIJuC0ANAIDMtzooHvl7hRTClFvp51XO6LgVQN0BGpPSdRs3RjrvzI7VFxH22kY4Dhkk3cTIqSSunX4km8MYCvsnCZzz8LaBPRUfRygYbve9rnPEK+ik7JN3ZoeIp7XvBLnyVny04WaqHMsI9eaBWBAY1cInyxP3sytNAhc+WygVeiqDBwrPrg145L85qpS61dn6RyVbAffbFQzGaXw8LsWdugnb8eFj+9meH/NuhrgJoDdvPi4jAMGDFb2sWov4xBdm4ywYeZPWvz1Zj0CWbSKU3JyzyJKcTWM26jIpQc/nJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxG7OOV//vTSuP9229r/V6ngcB+TkD86QssdIHR+w20=;
 b=W3cZjLh3/J0yO7lBf3+BWjP9NbgQqia9sQlyGM4MepTCeRgLixvx0UviBMBDOwSnuf+KLfLMB+B4ish8ARCC+r0Zo/UAiLS4/PC+xefdYFPcE9xNf1qcmXKqxNSbjIQ8j2ris0jVEMrMgBGU5CkR7dfx9Dq6WqIsj3AHUMyUK3w/aI04FbOtnmLGsUGy3zA4mg6x5vbAHrsx7V+1GEExnm3J8A9grMpvEXQm/BatOCrQVpcVu7kChdHlgJsNy6QvKRp0JEj3uYsvtx27CKXLrjFLePGWb/T+NXyMBgGu602/5LVLHgzzqTV9GLy9OImOLP4R397xiJmRCpd3OfHzPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3768.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 27 Nov
 2024 14:09:49 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 14:09:49 +0000
Message-ID: <434bc0cc-a0b6-4095-834c-ddd6a3fb2b09@siemens.com>
Date: Wed, 27 Nov 2024 15:09:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
CC: kazuhiro3.hayashi@toshiba.co.jp
References: <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:610:54::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3768:EE_
X-MS-Office365-Filtering-Correlation-Id: e49fa5e0-2a8a-4393-992a-08dd0eed27d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dgWmzUOvIzLzy+rpRCT7XtIgvP90B9PMiY/R5NhG8Qhh2f4BpNNNGW8YKHfj?=
 =?us-ascii?Q?16v9l+LtnAec45PX+pwt9De0tUcVHfDKjsz/uMWPnQemkpafz6jXLe4+Kay0?=
 =?us-ascii?Q?GcojTPJn2SJHEd0nVtLObBbwfvCuq1rRVcA7H7XszgVAPIruOsGrJodHZp85?=
 =?us-ascii?Q?duMvid187fLPamENfFWWEtvSYXLzeNLjN/HtQYDzjdUksnMiuTfq9gXvYbvB?=
 =?us-ascii?Q?vLNiCtPvitDvbkiWE2CX7Eutp+stt2tzpha3HfOS+BadFF9wJ9/bjNELlVe2?=
 =?us-ascii?Q?rUNg56F5ORGS/aXpgnwSRoYCNYAbRA+hs0Wu7Vfu0Dm++55fg0cQS1w8khNB?=
 =?us-ascii?Q?P8VnOTCCVbnMQ4f06UvtAtkGkBiWEnsWrIyoGwfBmQonDb2a9OM4wj+L884h?=
 =?us-ascii?Q?LLMQT+ECnEtV5ncKKIVCFfNzLmAWl1XrIFB+wBQ0D1xUvlcQbWfF/wSr3Ub3?=
 =?us-ascii?Q?IX1eAs/czIOuZXW+Tx9N6ShvyuEBppt23ht0OPbfq/yBerAjeQuLdiOCpppZ?=
 =?us-ascii?Q?PbB6pstCoYb1c7krsTtJX+5KjOxABBL9Uk6WqjiJEprloUZTNOJosIvOnwSc?=
 =?us-ascii?Q?miUNZHz+AgoTsloT13dqz0gcVn9aga+P48HdlOp+sbRWanhNgT/qLeI5DNNk?=
 =?us-ascii?Q?guG+sZTK6A9/I9dPOtJbLzGjvnXxr67GU+HVKu/nfcNY7aQlguRxOeKRs4q5?=
 =?us-ascii?Q?3m92pbmJjI+jF31E+XljR2ftIzbLTic0cm7M8f2lX4z3rxCehi6QjV6jE5Er?=
 =?us-ascii?Q?ET+ednmjG/Tu46s59RCtoF6bdxAgDPgDLYeGx48HHapAM5//kgpqB2CMTxiG?=
 =?us-ascii?Q?0wh0cgf4fJxHyZ7SrK2/6kBNr99HC88aj95efm9hbXSg9bxu43rzaE8TRZ2Q?=
 =?us-ascii?Q?8dz/b8nERR4v7h9cbb3WJlCs37ixSm/8pzfceUxqnQ1NjeF5BLCj51RkPkXD?=
 =?us-ascii?Q?KpKmySxDGKBX3GqxeNqgbeeDViHVe2sZ5Pmi5kC/jB1lZSQlhYgapR/f3AvY?=
 =?us-ascii?Q?hlqVdTY5vJHAHZ1vvqBAEfqhmOtDFmrgLiO5LwFncpArIsWoi1b/v6kwKGNK?=
 =?us-ascii?Q?FkAeyjaMbfV/Jm66YeM0f71OnOClavqpqs3wwTateeBr2WxPACfm3wWGO01m?=
 =?us-ascii?Q?PImQy8INcVFGS+GoCNQz050GPbJmxUs2VwRKhhlFRm51RgD+OyQoSihpHe64?=
 =?us-ascii?Q?dudYHRhAYfKLB2i9Up4S7sHMI7/hJTkjclaAjnKGeObWd6YgYbhPjEuXriai?=
 =?us-ascii?Q?/7e8m26+/Ncm5i6bk7cZFaqh5QQMadclyBh2M+GSgqKGkembr1x581GLuBXR?=
 =?us-ascii?Q?x/8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Aq6pnsROeUNP8y0nWjeSRzwop6A0YlLhUcMQp3qI/jZV1pfDVbZKMpZJSuwI?=
 =?us-ascii?Q?IifOtepMfKOZms19r8pZh2sKR51RKopzWDBKpKGDE7mbOA9eKxMP4FsIzwTN?=
 =?us-ascii?Q?jSCOE4eZbtukZ+JPgq3xWy8Ld528fIlIteIlSKEPe3atRiSY/CC1pR6ezdhl?=
 =?us-ascii?Q?gWs/VqcBVeX9F9CUqfQcvBhEKWd0k3YnmGq0FxWbVH+DI0k0w19+DqUsODlD?=
 =?us-ascii?Q?IqmiUXFfaDdSzh+0j84VzqVwgX9lSiUK7UDwxhuj9PgiSp01c8nSabC3DnID?=
 =?us-ascii?Q?yjHZG01kYFGe+aFE0QWy/x3HNgKpCYU5Ucb59wnw8LHeCs++OqqDP7IYnjp9?=
 =?us-ascii?Q?9JDD57rNxoav/9ruqknrggPFE/vsc4CtueFm7BAhPRzegUfjPC/c3cZg2wMD?=
 =?us-ascii?Q?e86X/3J5lPTC1ZKXG+DvenrgzRm1BVt6P2caemfAP2RJ7BIQPmfPUZOpQXiI?=
 =?us-ascii?Q?+j6aPLY2GsM/zyWYxCHntysrM3lRl440OU+hWyU8mgfujN/a/I43kYbJYX7w?=
 =?us-ascii?Q?fe5ch9K5Mfv7MXxDeM4qMhDY/bng/5jpxNUD3FHr53yv8AjXmn634deHTG2g?=
 =?us-ascii?Q?g900mEFEAdFi+lCiBMl1ool/v5n/FJaqTO4XXulIcpI3eB2zmpeaykValrcq?=
 =?us-ascii?Q?nbXe3bQzfjeR8wnxMPDT1yfYl5L4YujzC+xW9XzEu5R1dpU2H+dk66dS7JCG?=
 =?us-ascii?Q?tt79ttoUPQMktJniTRVfAN3De+v/TA276P1e7dbdj1X+GJcMTwBpmf6b5qGi?=
 =?us-ascii?Q?4lv4hPHVp+R32BUjV8oOYSxWIMHVPlRkFZeLlwWzBmovBtaMzRl9Wbj9G5h+?=
 =?us-ascii?Q?/djBAuP1KfNrHnp3DX2ffAfGc9InWQVlE2CC/OP8Qrr+F7iEu15GYuUB4O5y?=
 =?us-ascii?Q?uPWcFaPVkX1SNYe0BddRh1z1tbiyhuO1dpm3PrMzlXxobCJcwuCEM+O+TnwR?=
 =?us-ascii?Q?TSJ9eQqr1aRzTJljIBeVRYZjjVz8yNJ4eGc7yDcp4df1OI6DS/oGNgWN9l0y?=
 =?us-ascii?Q?2GpHUoTZ9TMgXZM7N+DbCL1tVzXTw2sB12swKaV+e2PNUJ1Yl0984R6T4ZoQ?=
 =?us-ascii?Q?MsghQAmO7zh9kp3mXoyzmORPQs5TVHgAyglYe6mzmyCjW7ZM6P9ZGehZUP5o?=
 =?us-ascii?Q?0nuDwQIrY67UMlvcf6aN1VE8oQbbk+cy8/8agond9au9MlWUrmMCLEs8ul5J?=
 =?us-ascii?Q?W5pMVINeas4Cx/uQBFzPypz1nwxX1u56dpQPHtJ5imiBdp0k3zutc1dt7xzj?=
 =?us-ascii?Q?C5eTd1sYkpALO4S5tWgTi73lEzSgS1GFRKGl7gU0DdnzN6M4Hvo1HbB3GEpM?=
 =?us-ascii?Q?a/0epQ6bd/5TXW07MVEbjwnBnWLAhaau4xMIM5F7UiYrnKPd3xK4g1uEwPL8?=
 =?us-ascii?Q?W7fVOLpBsaDSE93Vv4mFN1CQpl3Ep6eUClYHmZe1Q4mKKYQyFhjb9VMrQACF?=
 =?us-ascii?Q?jShbzPvhyj2Fhl4Um+QXj+7u51bbEg8Eu4pHRcofAeUJI+L1MxzRBz1FKHAI?=
 =?us-ascii?Q?frbS34Qri8rG8rzvAjVUn8y+mCUK+/dL5UKxy38c8WnGQ0FR3MeEbL6Els4L?=
 =?us-ascii?Q?cpB7wAdqYUZUb6gCaJs4U87PsgnozRSVTolyN9G2jC+Xr3ZHAWpUKRPkc71h?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49fa5e0-2a8a-4393-992a-08dd0eed27d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 14:09:49.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjclcuAxKUiO1tJRZVPZSEXI7qlTQ0/jBZyjl+wojkDWriUTzwA05eKMuKgOwHDMxCxiQlVjiAQecq/B8rk3Ae+LeZhNUxZ9f4shlAaVlkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3768
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 14:10:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17293



On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:
> Hello Chris,
>=20
> We are planning to run software update, secure boot verification and IEC=
=20
> layer tests on M-COM x86 device in CIP LAVA.=C2=A0 To achieve this we bel=
ieve=20
> there are two main challenges.
>=20
> *Booting a disk image (.wic) on M-COM x86 in LAVA*
>=20
> We went through the existing job definitions running on CIP reference=20
> hardware on LAVA to re-use if any disk image is being booted on them but=
=20
> did not find any. In every job definition, the root file system tarball=20
> and kernel image are deployed separately to tftp. We are going through=20
> LAVA documentation to figure out proper method to boot=C2=A0 =C2=A0entire=
 disk=20
> images on LAVA.
>=20
> Can you please provide your suggestions on how to do this, if you have an=
y ?
> Once we are able to boot a disk image, then next task is to boot a=20
> security image.
>


I would suggest that you check out https://github.com/siemens/mtda. This=20
provides
  the necessary tools to flash a device over USB/SD.

We would need to adjust the lab setup for this.

> *Configuration of BIOS settings on the device's firmware to boot a=20
> security image*
> *
> *
> Basically, CIP security image has secure boot feature enabled, so before=
=20
> booting such image there are some settings that need to be done in BIOS=20
> such as:
>=20
>  1.
>     Enabling secure boot option
>  2.
>     Adding secure boot keys in EFI storage.
>=20
> Only after these steps, a security image can be booted on M-COM x86=20
> hardware. I am mentioning these steps based on our current experience=20
> with local setup. But I am not sure how to achieve this on LAVA.

You don't need to enable secure boot for testing - an image with secure=20
boot will also boot on a device which has secure boot disabled as the=20
image does not check the state of secure boot.

Best regards

Quirin

> One idea is to pre-configure the above-mentioned settings in the device=20
> present in *lab-cip-siemens-prag *but in that case I believe health-=20
> checks and all other tests running on M-COM x86 can boot only secure=20
> images.
>=20
> Is there a way to change the bios settings through some arguments in the=
=20
> LAVA job definition ? If not, then can you please provide your opinion=20
> on the above-mentioned approach.
>=20
> Thanks and regards,
> Sai Ashrith (T S I P)
>=20
>=20
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17287): https://lists.cip-project.org/g/cip-dev/messa=
ge/17287
> Mute This Topic: https://lists.cip-project.org/mt/109804627/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


