Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B810CA0ECF
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 07:50:25 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web10.19980.1694505018476487011
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 00:50:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GypU+TLP;
 spf=pass (domain: siemens.com, ip: 40.107.21.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWxu7eI0eSjX8OQ9wMuWFmPuc0pZSivGDkoRMGxaWYSoqHEyeAMWXB09/p19Ix1KEdXWcMPg9Tgqr03VWrb1jxt1xGLCj2I4KAo94GvBqaXmJi+434Aa0UvBWdt/i/oUbKb5oKwAtuyCMrszaqsQ6kAu1sQiwR20WCh9s0M4Td8d3//vlT9vespiZRKHSJMMFykBxtE3MRgXDSZc2w2tR2FTn+g90KKfUleDmIr9qAcHQZxrtVpb0wIiMXriRIHQ8sNZF7/Po8uFUXGoY8fkMDLjjn3pDobSd5Ao0M+BptfKGBgta0YnNbq4F13eEizzoiut1n+mtV1rnjtfxywEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHI0Enf1hH2xcmXyHbSVXcjWQvOI9dr11WgxmN2RnMc=;
 b=ehiIuY6/cPKhbFEs87XExx8YCQhCLtAekyPD8Ituf+S6ZTAN0XBoPYFVzYklnPtkALy0wr5woa+vwUePA27Q6oKeEL2Gc0MV+kGwm5TjgJxlwdPuh4ge085pGQ+GuVeakpK9vs4C6wqU2Y2EDM2DVjpaqBNONNMVX2iPRGwyubsEm4K7vcfOHYCkFW+hQiOKJ4Jp4SFdLfpSuoSs7vqFgFULEAMaqJi+TVHJ9bbVEu3W9+hXnnoM+HVcjHwawu0FO1D23zP7VC+1/UFuCXJyo9S9Q6i5jOx01yMlwiWhuf0xnXm+nCo0H57YygDOpyKLf7Gdxk23einViUA4oWzIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHI0Enf1hH2xcmXyHbSVXcjWQvOI9dr11WgxmN2RnMc=;
 b=GypU+TLP/qOXhPmoa4gCJi9OVR5W3TcipVOpJdsdRxFVXOMPLd9brwySB3EfJJlx1ti0BMfWjacbAzWgR/Z3AIIX4pez5J0jLxorDPk49HRlKYf5a58s8ePBDI3EKyRggnQzuN6FHQPdKy4zN1v456+GEco8eU2KSjbwd9FyV77CQ1mTjscyfN+N+pYjm3Uk0GFgy4AhhR9HiDxpvXQR8HDzMng5sXd7rLAjplG1IO5T34RzHTROd9N943/Bvfl6MQwX7nnkga80b1sXeCEiQcCLAXbujCVsbhWH3Pj0hl6DYMCbeAkaNxEG+uDC4GFx46pp5XjIRQxv+ggy7ZHknA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 07:50:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 07:50:15 +0000
Message-ID: <1729ac64-b891-4dae-b723-1e009c92d66f@siemens.com>
Date: Tue, 12 Sep 2023 13:20:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
 <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
 <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
 <OSYPR01MB55422F888CB0CFC373E89496A4F1A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB55422F888CB0CFC373E89496A4F1A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ebd998-6a53-4776-c887-08dbb364e65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qMAHzQ6aYP2m5wS6xqIvp7RXa7QTS42cwkPIo6h2Rr6ic8qPC+dqgt87r//NDu+Du5Ema1Yt3Q7QWcXH7cXrD1ijeUDej9yzmo1urjxHBYMoHDziKC6pm/09EF3XOHItLegIqSpGvN093cjZuniPAh8T1yxR1j+KGNKs1Slx4Ww592BzrDhIeiCtIcgpz7roRhlnsdSUlD+XCPCVhyUBs7WLMdrNl0isXrHtKrxmg6jz9/T3eSzkWWYDTt9bP++Ki+fQa5d2oqG1W28SKbnsnACjZBfWo15ecM9JfGofzltOFsDD9/Rg1wJH33YkzGtMZV7ALNdDM7Nl1AJCCr2ukv4eqPos7r48K532EMx1/iaW0PED40sV6T79WK0tU2LrhYBsAIai0Tza9BX2Kl5p4nFzAkrDUylow5dgZfBxLUNX5X6FMI9uBpWsHxVrKkNCzs7zUNLp3zpHFTvMg0e2zaJ7jCBlpbzFtQkK3pPXQQISVAwhCbOnuYFG6gPRwSU3t9TDM7vr3Cj2vFhmKj5sorKgVsHKKKx3zwBZvVN8pCfaMwDkV78B3qpF3depbSZ7TK7hr0KTJFoJ1lt7nkyrng8a4nNW4DYq5zAIHNOMqN+jyNrBJ1vtlk91G7jSHXUXoXRO7eT61PLOJpLeZtK6nA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(1800799009)(451199024)(186009)(26005)(2616005)(44832011)(5660300002)(4326008)(8676002)(8936002)(6486002)(53546011)(6512007)(6506007)(6666004)(83380400001)(31686004)(478600001)(316002)(66946007)(66556008)(41300700001)(66476007)(31696002)(86362001)(36756003)(2906002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G/jwnHWCy0cRhMHJ8MOSz8VcuWRT4+w6W47BMRf6lLKRR34txOjOyGZMnmwI?=
 =?us-ascii?Q?WkAqRdUWVQFOnixvRfL5eggx0qo2bxQW4NuK7l1ygEgJcHNZYZYPmMSim0lJ?=
 =?us-ascii?Q?pfwH/jOQC9m9/GIX4r77jDTQUqjtD9d/AU9rm7kNxCDdBiVQsRqhRtJrr35Z?=
 =?us-ascii?Q?+7ZxOh1PUTo6YXXbx31vsSiu/w4lgc6N8zG3aHq1PmMH76DQJ8sSO/7Z/0b1?=
 =?us-ascii?Q?lQEajQXjob5kR6o9DC2Cmr69HZANizAwKcQ9e3Xi1GBdHR+qn7Rtv1t0FKwX?=
 =?us-ascii?Q?osXf3+V6ns4BQaSQgjs1uKsoV4M8G/J1MSYiktKcLgpi8wYl441lxgrV3mbg?=
 =?us-ascii?Q?ChQgGGHL8uuOhNW2EyIPoofTe6y9yF40oW/MOkJUIOb7rbFPe+5R0KJ4wkYi?=
 =?us-ascii?Q?MP54VxQqHRM5LiYvPMQCNFaDyaRAINAjFvjD28bj2fOfZ5LH0zcJ/dEPpcjf?=
 =?us-ascii?Q?4fHNA4ng5067cfyiodM2J+PvONTjEoMH+HUSUCVhgeb8D4h6KvDPAJbdoGVq?=
 =?us-ascii?Q?T4XE/XhnA9p9h0WAUD3UU3fEFGYTQ+En2vHkFFa7PWgi1f39QfvAzvffJpzX?=
 =?us-ascii?Q?+E7Saf1ISQHKhFi/xDcqeh3cgEk5AbQfMMEsIQIfFbFib4SOBYbFx1I4j2qK?=
 =?us-ascii?Q?RWfqf9tgaAR8HRJmTxtBySBnIHf/HHQRJBvF4PRfR7fk0dS6D0rrHuZ2JtvD?=
 =?us-ascii?Q?U5967Mt7qd9bRX2l/zfDMPoQ9KaWJPuPHadm7nS1Un/7hJ8WgTFT1i+YarM4?=
 =?us-ascii?Q?gyUapXlYdGQWTNY1TwG2+oMXIALYUzOQiO9ay0jWZsPVJrUpr2VsRSIP92wu?=
 =?us-ascii?Q?8zC5/0GyQqM1Km2WP5NUtQOk7Ppwtu3Qn6zjhYYy4TYEBLeXBiLA7MzbhEtV?=
 =?us-ascii?Q?aFReeks93uvwXHZ8g+e5aZ+vNeY5BoXUl2dhL9HgjDiaKyLIJFKbIKdBvSNl?=
 =?us-ascii?Q?OkuAvn1rsFd6eBeujWMlSxNOSOzr2L00W0pkhHg5r99YNpUGOEJx01wZ53iq?=
 =?us-ascii?Q?GZtMVRVLSmVylVCTsj7w9Q9OHwV+/N+J1lpMvJSCBVECGyMymw6g8jp16/9q?=
 =?us-ascii?Q?7aB3gOjnDpYFz23QZOksp32Ni1Sa1PGtZYxRTuKYfHVY0TKqIrKEINSqj1Pr?=
 =?us-ascii?Q?0z6ft0c7WCubeekrm+bqFV+H80tFL/5MM8F5L2536RyO+KSIzdgQW1RJhl2b?=
 =?us-ascii?Q?jCPObI0nJcStcS6A0aqWGR0rLZMTWEGn4DgwfrkAoPSNiKK07tyOyOMC38Lv?=
 =?us-ascii?Q?YarGDdj51zS/gZ4QsSZgjdpU8lficwk54rD6kuHjACR5Nx8VlwV7+iCggf43?=
 =?us-ascii?Q?sTm/N72l8LIQBm95n9Q19jPphyEQcoS97fHNbJU99e5fVDSsXwEzWn/J+MWu?=
 =?us-ascii?Q?zMrPGpQLgDWyALD3Ni2JW4AWuLt7dnMumuoCwf7Nt3jqdIEIzl3Ez5PY6mIF?=
 =?us-ascii?Q?/dg+Ri2FSELr2UV0NsbaXu1AfkCenKuzMDSSIVhaOxMY6IFK/FqXmVeF3Opc?=
 =?us-ascii?Q?M5DSFSEJ0Tt/3xF1aC1snPqTktfm0Q1BuLgik4O5bUB3zCr6d100yLXtTuy2?=
 =?us-ascii?Q?rzUApuLnQbKZixJWUJ+TIoeiopjc1Tof4/tFwE2lByjlJ0OOuCVle4iWUKv4?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ebd998-6a53-4776-c887-08dbb364e65a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:50:14.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQeCGIRTfGinJuizY6Gxz1xe1CgIrncIiXZOf2n/D6QBxQOtph3Q0BqbfzfS3u6E8ydjr64vzrQrGLC2Bz9qEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4072
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 07:50:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13057

On 12.09.23 12:22, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, September 12, 2023 8:39 AM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB tar=
get
>>
>> On 11.09.23 19:01, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>
>> Which additional aspects of reproducibility does this target test?
>=20
> It will try to verify additionally beagle bone specific files like MLO, u=
-boot and dtb files.
>=20

OK, so this includes firmware generation, understood. Does it also
include something that is now checked twice by other targets? I.e. can
this supersede some other target?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


