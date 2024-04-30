Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7936DC4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 08:07:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web10.10242.1714464455692758453
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Apr 2024 01:07:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=k+3qNv0o;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWAS23nCIHCLXPbJs6bMVZuWvRSwe/xeFh8SMZkm+Kbqdmj+ZEtBUKX2g71dEnj9Iq4yJ5t9pB//CqC5JIObvArfpXJdOfhKQGaP7/iMuxfUtwArrnkV++eVwprt8VvtHQtsbdv0JZNpRwoP7RvZMORpVov0vYarHGbt25tABbOwrdXmTKSOz9hlX9SIvF8RR/xtoHQlu8rqpmxy514JEq5FB6SQGSwl6kmVXGT9Us3cTsiJZxNNx3XeNHjxph9p/8QRZ5y9DwTeYW3SVwvIy02p59HGpz2I5W4L4YER84NJltEO3fzD0ef88NZoYYuyh+F9zuJAbT9wipNkCjtkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8dbwrBxRTy5L6Ud5Ot5hL+kziJQnwariSWmNLZTV7I=;
 b=Pbv6OoAAU3M5Gwd5TTMtF5deg9s1xCMolvwZ1cfFPnYKQuUeNARM/fjNRSn1IznKL70wXzA0s7JA1lsIBwZEyHqJbgZ7Z8Jc1GOF2lFdFKtggY/BD4cJhvswnsMOlolKozx+mn2coVBXMgnHt+SV+bjU1JEgg7k5PeoPUjbhAuRBS/acrPQRcTBpdv8D7kpZG2xbinwtr2V6iZgzVmPV1elEWhsnQ3IGHDtdMNtHSMLOD9QMklm+2vTuEexeDe2rNNJbRgLV23F/DawvFA9Q//fvNiBILyo+ds638pSjzQ3/iQb7cQ/hWOLx7YdlxaUCX8HOF2XgysDTa/2T/mTJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8dbwrBxRTy5L6Ud5Ot5hL+kziJQnwariSWmNLZTV7I=;
 b=k+3qNv0oWixgG9dbB7HxRRIX/lfhvzEGibhJVEAm2YAmMsujMCsvO4P3XH3lbFZnU9gq1YFs060GNSYOfKaDejed11e6eqineCELXh04p5f4tqM6HQFwdYQDEpCvBDf4orSEZwxAdZAcPwHupSXWJet2m4dNdVJJC1MwoxjK6UjPEwq1WS3Zn6tuRyHEXHKIStLRbRGEkUHVUoXzk2s9Vuc58VPL7GMCWGXKb2QSrHKYERAnXNj/JJE9Dnmz8lvE/0nV8wc9bClweAGWIWqKLb0UNAZw3TPeRz7xPuGFQpkx3jsFmxNwNc99awR5pPQcTteiH980u5WmUdLHa4kcGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 08:07:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:07:32 +0000
Message-ID: <a7be2c45-c48c-4fd6-8e19-daeb07896c8e@siemens.com>
Date: Tue, 30 Apr 2024 10:07:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Updates about cip-core-ci repository
To: Sai.Sathujoda@toshiba-tsip.com, Chris.Paterson2@renesas.com
CC: kazuhiro3.hayashi@toshiba.co.jp, cip-dev@lists.cip-project.org,
 dinesh.kumar@toshiba-tsip.com
References: <OS3PR01MB6103C363AE0853268133CBDBC21A2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <OS3PR01MB6103C363AE0853268133CBDBC21A2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 32eefea1-84fb-4cb6-34d8-08dc68ec9621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aigKJBPHeSOCV9TAfyX1+7F0RxclyFQdvIsgE7r3B1bG0ijrLlnnPnqKQPph?=
 =?us-ascii?Q?NN5krvo8jcJW6o/6iAGfUY9cCImbu3Yg4Rjqcgyp2u62VToRTC13u3v9Smt5?=
 =?us-ascii?Q?EwCQbly6SzAkZWpU2gjwL0/78hHrQeSzEat7OrnqswCMmi3M0vnAsXUB/rwV?=
 =?us-ascii?Q?sKJMvoM0BNheYcYNwDw4BiDtKscSlqLEXFXJRq+y9pN9OqtU850XWHPUT3yw?=
 =?us-ascii?Q?WJ3UKWs8OYo3USYyd9gg4bNQejgrsOj8tN2HefGBFI8JPIHLiF5zGBuPR4N8?=
 =?us-ascii?Q?x0EKbhbjdBvZxGoqJwpr78nnj0hOtHajCrMtgzivHKER1AOAdYN9hZCS7HlQ?=
 =?us-ascii?Q?ZXXLiE1JJ3iK1v0dSILPuW7Fw0I93Ret04FmfOZqi40ZGqzf5e9WAu2iRtzi?=
 =?us-ascii?Q?c9pSN+H7wQ19Z2usSgWmsunzmgbnU9OB2OlcD9AfKjF4ive0XGJY6hee3BFY?=
 =?us-ascii?Q?rbYfpSg/MfHCpa1vOoButZ4L0gEOQzGxY9Pqj+Pvf7DYWnRiVEsrcSOgXhFD?=
 =?us-ascii?Q?o6AhnYtslEnUBDNoTqWOeUFFRA/uYBe4Z46QhOzjSrsxSP2H8dzL5YBHksrQ?=
 =?us-ascii?Q?n1DeNWFgn6L+2W87XZlUAF9yU03ba9GXILgmQzhh64nab8SSM89DaC7q3xHZ?=
 =?us-ascii?Q?8tSEWXoRebq6d5WB4ee1YCVrQ1iAF7PFnOSxxk21VzHdQvlfV9OEF5cVRjVn?=
 =?us-ascii?Q?jXmFDvkS5jptyp860J4Sme79tuyhf53WfFzVKnUIyM3NoZbqo3j2ZpVYi+KN?=
 =?us-ascii?Q?b66a5PrV3uy2nvwTyiQEYbnQHXomiv6RbOAJTyu5gy5Xahj6moHGPNYGW8Ji?=
 =?us-ascii?Q?wVubeU9V1AW/pZUattiWTaIyXjmRAmltXA/hygtdiLXY92rIm+Yh9djORFJ3?=
 =?us-ascii?Q?QdaZdwWjpgyTjXdq4GPLHFTLHaaSCQqvGlVPm4CqdN6dG796d4FN/pUro+Zb?=
 =?us-ascii?Q?BBDmZ5xoyx0TTWoG6y3l4NzXc8Gv0vbjw1bxfpLiGvIuDcjfWrYrZW1J+l3D?=
 =?us-ascii?Q?O2iW3dZuF7Wnsj6uwgFQsr/bVXlOtgPo44Agl+DfMj3ZOlVFaI/gtX/0t+qi?=
 =?us-ascii?Q?L1C/Rv6SDHqQ2pQxuGpYFph4I2XBXCrIcQ9im77BmKLDXEZXf4dzmNpYXyny?=
 =?us-ascii?Q?V7q3LuU5FcWTah9O60PMksletLHONBzFdH/6x/5gj9hOsHnSc7UQJHmtq2CD?=
 =?us-ascii?Q?HvUmtMgnC2zeGU59G99UXqeiCadNvwP+e2aTm0hhXWo43QzTHwsCn2on9pi5?=
 =?us-ascii?Q?bh9VWp75iqSBwS4iNBr1HjUgOjTebYScX0r659POKw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4lGntrJH/i2b2WlQ9gM7xq5pep+QGVdxXEHo8MAbcKGOow2dtqqhNph1RDKC?=
 =?us-ascii?Q?vBmA0czz9DRmHLz1TMr/h8+jGDrPqR33ZvwB5HSJKvLXoEFnWCY7ninAJcPs?=
 =?us-ascii?Q?60OEBbNepK4jRrbL/gYvp3A1ak66sFzROboQP88bMsiYkO/XOHX/U7ShkN2I?=
 =?us-ascii?Q?SqdMTS++RONSU/EHdFAgjTFZFYpKb+oNaTinQvw/ypLwyVtzWM+d2TsfHY2Y?=
 =?us-ascii?Q?AFWB21sQPTf+N+gEkZQwQNhatJi1tKkOcZ/kVwp8Uap2Qxc/RdG4V+wE3a9D?=
 =?us-ascii?Q?9KZzSPFHkH4O52IuJgWKcIpc2KZWnJA1XoP4YNUXPG/KXQ9a/kyydF7ArfmZ?=
 =?us-ascii?Q?l7yZ3wvllvHvUCLymMb085mXE87oHHukRQv0MEirnHMH0BiRM5rpz0hfuIjt?=
 =?us-ascii?Q?Dw/LrF8N9XmKZuYnNMMWEOoEwof8jJUdI9oYzn/DTMI95LP+YWc0X4cGInBI?=
 =?us-ascii?Q?iKSERNKisDhxMWfdPO3YTDsUNiDlnSmszdRUP3khOCtMGxD2IGkUgAbZTDYu?=
 =?us-ascii?Q?aNuEALhCJ1H4Co7w+pgnL2DkRj+n+u93sczNpUN64qbrKmmfXEeH3awxPXMB?=
 =?us-ascii?Q?bFQWPjUZUsN+moQEnn3AomsBZsbPbWcLkGJXerkv65VFpE06lSW7iM/Mm00n?=
 =?us-ascii?Q?wR32gG31dq6ncpYV0KS9EUR1rE9JDgl11yexX8Fj7xeO/izdx+c9q+5yyyO0?=
 =?us-ascii?Q?YadLLYPyoSbDMrD7/F2u5NwZqT38v053/e8AKNIMcTMybEFRUFoExKho6eWP?=
 =?us-ascii?Q?T/croLpkdixZMVXFcSG5vguPYhn8BGlf1cqXzsdE7eFm7ivkkNKWUb9QaGVf?=
 =?us-ascii?Q?fRJb9EH/kRZYdF1ZsNviXz2Ahw0Cv2pwKuTYkmxJKtMtzcQ0XZtoqXzh/QpL?=
 =?us-ascii?Q?A5lTaEkyZibTmt3JsLVA8L69MPhJsN6S7sc4RaBZr7SAscmRESf1V7ldn8ZG?=
 =?us-ascii?Q?Anqm1EjCVF60LLzjMh/QTWYqIGU1du/G5S/y6N0aWM4Cm1S+maVlRfjUaZSL?=
 =?us-ascii?Q?aqEbzgWvcDvs3vum3jTOEqU6Ck84a2zmnALKmmW2cMuENxV/OzLvmDXew4Z1?=
 =?us-ascii?Q?x4bKvVuDTn3OnMCtPTajdKUqRGnqmc4hjdeaeqSXMVCd27JuFiAoiYnSGPTo?=
 =?us-ascii?Q?e8Bk/3d8pFEROLUcrejP6jcKJmlXu5b0rgCIdoyJlt4qGy3CQZprA4Ty/hqi?=
 =?us-ascii?Q?eIc7N9jkLArn0fzf06fDWWlgC0yA3aPAiZ38IOAbYTRsOCcI9YrUuLh4DgzZ?=
 =?us-ascii?Q?Rv16clftj9NwlssY+i4bMHCBFFVd02S/KUv0ys6MmHyPnuJYMlrrM5AxGzPJ?=
 =?us-ascii?Q?/wokfHTXD9SRirI38tUfOHs9MPpRHpoRpHjjJAyoYnSE9pLKyMUXc57Jy8OR?=
 =?us-ascii?Q?dHoxECapO6uq5V1UhwfI0Dbk5U81Av9e/QFbvRc8d0auSit/7eSZvTmf2jA7?=
 =?us-ascii?Q?ry8prMRMxfsMY/YTmevhACAxxWgZLKoQ5ATIIYXz2+axPoe2nxyZCgNX17ol?=
 =?us-ascii?Q?vxRS7FNqaE9WbMfF1e8ZXByNDr5xcuxS3FDSh9jdmv15boi/XiEbX3Dc+aR2?=
 =?us-ascii?Q?6HvTtEIj6eEiCo19wZJb9Rs8uEeeOdvaIjxj9ChNW1eov2tHZib4uYMS+ZLR?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32eefea1-84fb-4cb6-34d8-08dc68ec9621
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:07:32.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rKlAlmKK+OJX+Zngj53ocG4ncwCDcsIL7s4JF9zyBAf/gKbuggqgyUuNleYSX00k70ZaOwy1dGHGy2kUtndMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7559
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Apr 2024 08:07:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15785

On 30.04.24 07:42, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hello Chris,
>=20
> Thank you for reviewing the below mentioned merge requests.
>=20
>  1. https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/1
>     <https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/1>
>  2. https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/2
>     <https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/2>
>=20
> Both the MRs are merged to master. I created a weekly pipeline schedule
> on master branch which shall create and submit jobs to CIP LAVA server.=
=C2=A0
> Please refer the status of latest pipeline =C3=A0
> https://gitlab.com/cip-playground/cip-core-ci/-/pipelines/1272807912
> <https://gitlab.com/cip-playground/cip-core-ci/-/pipelines/1272807912> .
>=20

My long-term vision is rather folding that pipeline into isar-cip-core.
I would like to perform tests when changing code, not only after it. We
do the same in the Xenomai project, though there is still room for
improvements regarding filtering of what to re-test.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


