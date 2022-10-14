Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACDBC433FE
	for <webhook@archiver.kernel.org>; Fri, 14 Oct 2022 08:26:17 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web08.4948.1665735975196989842
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Oct 2022 01:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=M+QNB9Tv;
 spf=pass (domain: siemens.com, ip: 40.107.22.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+NmxWoe3aXlCusJ6UfPE5OYOjGxAx1IFcr8ArnmCxJhq4UmZJaVn8GfqFX6dGo5b5wXvvG1VC6vMqN4h6Oka0TrfFlxdTgz2x3ja9MCsZUSS3f4pn8Qb6rDO2PGhC+j0ftXJlGmzLRkhpwiV9dJOVFUVq17f6po5ec4wepdZm09UWi3v4WqKID0ERFua15ZEv0VV2ZYfB101DvKavvby9o3DORXNN2fsJDWpCK9Y1CCjyb/vP/mJ70ycLPHhJ2Hyl1bFEpYyD6KZCSRlAnzLsPoKUsD920HzCNL0h/shZ0nXqGbs3sj7ucQuSZKlyJCrlurlwpY4fpX6tb4Y1hNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYkK/Yujw1g4XK0F3zMlDL/8mDXOVP2CzcA/duB+gXw=;
 b=LhNEPYxNXKLS/pRQ91ZUd4oM6znciQjjXPLIehl8Ze/ByePVMzbwL0m7Jl8je3+a5uv9f3sinYiO1tqOdu1JQuh3bqrIVSCAA82lpbuFQKSKDVkH2NvmTVS0i22Y0TRgVQAd/UsTZhwbphQMJoAVfEqbdysi1ukQEzYl6rb1SvZq5EI1+abmuogpNB2R+W8bsCuzcswBbFz24N7D3CY2zqx/MderQtpWXRbDYr31EbJIkYj43pOI2P3Kks0ygiDsFf/Quvh2TNhsgJt7+2jBNNXqmxXpKxerTF3KauM/HYlN5LhVBCTQRwYOlzISrt3eEuH4cLwEPwFLUqW21shMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYkK/Yujw1g4XK0F3zMlDL/8mDXOVP2CzcA/duB+gXw=;
 b=M+QNB9TvXR9iQGyiYPhg2u7EopJ4kT045PQhptHBH8HTNw+DZYbz7C/w9sbCfbRuCDpIi+sd87Qm6uI6qcV1rtufIQa/e5NxfXg8yXJ4xROBRU3tSeTlDcxn/jVQuk58ZUC9+v2HPxiVAhP6oBPspEAcidUpAWT36Pxr5ItWKuUwxrvTcnZespASEKTlESu8JfnvMWKbcHw9Yz9DP0YM3tF+vatP/y//N8jemIihekwHixMzIW8z/isGBX4pDwdCIaNQbCMxj2n6DTmpC0zkeVjTpqa5ZpRAK/YxfP4kNaoPQ8zm+Zeb7TCa0/euGC8Dbd/RWBIyp9tayJpL0mHTIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB5715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 08:26:11 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d0b5:93d6:d8fb:3f55]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d0b5:93d6:d8fb:3f55%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 08:26:11 +0000
Message-ID: <34ee9f53-5f7e-0ed7-980e-70fa9474b718@siemens.com>
Date: Fri, 14 Oct 2022 10:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [cip-dev] Plugin efibootguard-boot doesn't support to specify
 root parameter with unified kernel image
To: cip-dev@lists.cip-project.org
CC: "Wang, Jing" <wangjing@siemens.com>,
 "Huang, Wei - Martin" <wei.wh.huang@siemens.com>,
 "Liu, Jun Dong" <JunDong.Liu@siemens.com>,
 "Liao, Pingfang (Marshell)" <Pingfang.Liao@siemens.com>,
 "Moessbauer, Felix (T RDA IOT SES-DE)" <felix.moessbauer@siemens.com>
References: <b6efd1ed7d0140faa6a308e6d428ee2a@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <b6efd1ed7d0140faa6a308e6d428ee2a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS8PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbbc22a-7084-453e-03f5-08daadbdc03a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5QfY4E+QrKpmucf0maL8B6Dwaon8bz187EPlziZXwQq6YSkvUsN95i/CAulHGrawo1irLYsHjyAiydKe35DAuOLtq5VO3o0D8oFH2ttT8J4WFNjhBchVdFdt6TNGghXSD/Prwn+vz8wlO/RV22w+b+Dppe/Sjdj9Z+hJrpyfIgRV/XQ1TX7BkYsHB4KhEaUS5B7zkLXx+G2dqCq+ju4kKI+tEir50xSYmRt/ZZdezq/gOcQ1YC6l1mRKNocnRDIi382NcxyA2+/UDQoEq0E03tsjusOTTJCBBTHdZAWC4wYEsRdZudOcVZUCptCKr5fb5+Dmt3D9UDxQjPkDGYapdrecMa9HxMNE3JwUgklsVKtmE3A2JadeopNtlRu6sQsAGxvpUJIHe4qqgboVESj6m4Z4dQhS/bU75P2fGTJ/iDaUM8XOCFg0acy4lHS+D8TCeJTHDZw8CX/quTx+BlKfSZ6uwky2J7mxNdej9vEOyb26KBmUhiAprB8kRth4P4IC55Qx1j3iXvvBQCktJROL3z1yuLflODPUUcCawaxyV/oUf4sV0VMpz30VPsR4YZyYX4nU25P4CO+wGIHYl9STIv8JDOC3FeKogQvokzc/SeYCUkdE38rhW2SbKLUt24x0P4de+ETbAgs1N+oRKOHramxYQDYgrT6a3tyHMXaP/7+slWu3bjDfzY0SOSUxMnrd9X73xn+AO03vQpdkpyVevjPVirXLNkiDqZb/3mXSUtCnhYYbuGi/Z+UBbZRB/ZnXqOV/uThz36TfL1nQhXG4v7zNfQBmWkAB7F0LfNAiu7s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(6916009)(54906003)(316002)(31686004)(478600001)(6486002)(66946007)(66556008)(4326008)(66476007)(6666004)(8676002)(107886003)(8936002)(6512007)(36916002)(6506007)(41300700001)(2616005)(5660300002)(53546011)(2906002)(186003)(83380400001)(82960400001)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jOYOkdWgv51n70K8EKlK4Pe6Fs1zDNlDok95E70M54nVSuhoo+N5R/322+pG?=
 =?us-ascii?Q?3E7bnmVevWDZIBmzWVsn4TkoO2jnQwEyEjOc7yvKm2UF+Y96DsfSOd1DGfYs?=
 =?us-ascii?Q?9Lg0NN0Ogdu4BFcADDMwc5fBfx9t8KjRwhPdINmr2Q9cQiUu8RFEkK+vfNYq?=
 =?us-ascii?Q?G2t13GNo70UF0x8cpbvdqcTnuh01ZDnQMxS+DTcRuPp5Cw7SEVoYyZwpFHPC?=
 =?us-ascii?Q?8KTxSEOIvutlopZadTWj9qv3/H3sgBwFaZVIeFevB5E0iCjyQVaaETAM5Bbo?=
 =?us-ascii?Q?ktmbcMFA39GqjqziFzYnzAFgYSh9RzvULvISclj690ZEkOPCk9bwiIQqG6+X?=
 =?us-ascii?Q?Jt1yzFk6BC8OhYfR9nRL9DTKXdR1kTREQoDgl8A8qkOFbbtMBOYC/YQtahuA?=
 =?us-ascii?Q?pha6EdMxI+JDJlw9wucPh/XF9VbOQ56kprCv2sW6M7JxwAp3kp2jIyfGQPdT?=
 =?us-ascii?Q?D9qSmjDF/9XJbQcOfA47ErLCHP1+Cvlk151L9EaEp/VuU5hkg2ar81bhRXZq?=
 =?us-ascii?Q?M1E/UEOjcDwexRaI/wppk/tHmjnLFIyyfoFKnY7BvnE+8WXpzCX9+IqD7rlP?=
 =?us-ascii?Q?UCNikfkLRqi0Ew5lnYCDjmW6ld81/ccqyg+vZcV1nGxqeJ4KTXheNQadr1n7?=
 =?us-ascii?Q?YpTUR4PZrMMJQNHx68yQj2bSXOUlaZFUpPyaQmxBBW3Ohm4kcsc3WVc3ffKu?=
 =?us-ascii?Q?dOUipDtjsJVIhx55bYU8EcSIrD8r9wiHxir0QuwhfU8xWRCkU02YMP2JIZby?=
 =?us-ascii?Q?wJzffDMxB2Jq7ve+UC4WhCeRKdPJzlcx+9GtKkW6pjTmwg38EcaMSxcqr0UH?=
 =?us-ascii?Q?h9o6mKuzawUC37G3n8Ckyjt+llD5XhgYXFw13hCjuX9WdmMp0/o7jyew2Fnq?=
 =?us-ascii?Q?ydJ4OWMz9y1insiND2ObSewITmauuEp1UzTuyaDd6tvdghb5EGpZCu6VZvfF?=
 =?us-ascii?Q?8gemyGLaZ5NQIpCR/CClCTuaIfmdPFGGPpULHS8vGutklcdU04z4P6gGFC6Z?=
 =?us-ascii?Q?7z1tjL1ARNre63/Q/ioSi2NuHPlDOgLviiMrzFRNbOpZPl/GiAYMwm3vg+I2?=
 =?us-ascii?Q?RHoQE5ID1mesK3XibO6XQDZJXe/DiUdLTsqC5Ob8sSAtl67tphkq1rkTUhV4?=
 =?us-ascii?Q?6rri3E6Apj+ZynACyj93wkAob3Bam26t8kdDiYflkiGlR31zxA289PBgfJgu?=
 =?us-ascii?Q?2vKf5gBcTQ5MoNqHRdQ32+2mLgQsHHNvLVwZyWMotFZYXpWzV+gjiog2FUAF?=
 =?us-ascii?Q?tPCehJQAp+grqM2rPM66GFl9lMtTRP7wiLeakb56mMT/aGmkrS+jjR2QhLpT?=
 =?us-ascii?Q?gBMn8quO4a165HY8UIc9E91DtvuSUYu/zYC+zJJLldugvPFb1tRMBdT+ES1n?=
 =?us-ascii?Q?9oPHD1LYXG6gaz3Fd1IUMV3Yk+BwtjJGNlKyatrVziCQHmdg8L2WdWW+tI5m?=
 =?us-ascii?Q?jWlh9JNXcnbXOtczRIf35xUXULNiNufQ2OnlX7A9JbXXE0KmmfaBJcvUy7O0?=
 =?us-ascii?Q?LRZnCKN47Jfen32O18iHrebkrD/XukruJy2PtWjctVmCvM0VY2GgSgN9xC1V?=
 =?us-ascii?Q?vFyIP/gMKlgyuQKGky728M1SppgajRFnDDE8e7strj8O5EYuPm1SUrCLDRCi?=
 =?us-ascii?Q?JSgUp6065bL7MeGQEAXafC3gGpNVINtIlFB28kKsPUh9+LKG2os+PJSvkV4l?=
 =?us-ascii?Q?6goEYw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbbc22a-7084-453e-03f5-08daadbdc03a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 08:26:11.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLV4q7VfjSqX/ZXz6mv4VrFVTkcqs5eg8UsAqhtRFceGjNXwafRKc4fLm/JwV22BdbVtIfGFeK+bKGxKt6dvi9DioDodas9yLohoe68hMpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5715
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Oct 2022 08:26:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9762

Hi  Cheng Shu Mou,

On 10/8/22 11:10, Mou, ChengShu(Ben) via lists.cip-project.org wrote:
> Hi all,
>=20
> I have a target image with following partitions:
>=20
> |- bootloader (efibootguard)
>=20
> |- system A (linux.efi)
>=20
> |- system B (linux.efi)
>=20
> |- root FS A
>=20
> |- root FS B
>=20
> My plan is to use plugin efibootguard-boot to generate linux.efi=20
> respectively for system A/B and they can mount related root FS. So, I=20
> need to specify root parameter respectively in linux.efi.
>=20
> After checking the code, I found that there is only 1 place to specify=20
> it, bootloader command with option --append in wks file. This method can=
=20
> only specify 1 root parameter.
>=20
> I have tried to modify this plugin as following:

Could please you sent your modification the next time as patch or text=20
snippet?


>=20
> Within this modification, linux.efi could contain its own root parameter.
>=20

> I don=E2=80=99t know if it is a right way, please let me know if you have=
 some=20
> suggestions. Thanks in advance.
With a fixed root parameter you need to ensure
that the partition you update is on all devices the same, e.g.
A	->	B	->	A
1.0 	-> 	1.1	->	1.2

For example this does not work:
A	->	A
1.0	->	1.2

The customer needs to update first to 1.1 and B before updating to 1.2.

In cip we have solved this issue of root fs selection by adding a uuid=20
or use verity checksum to identify the root file system corresponding to=20
the linux.efi. This allows us to update independent from the root=20
parameter.

Kind regards,

Quirin

