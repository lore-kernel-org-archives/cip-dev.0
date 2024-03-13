Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8766BC54791
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 07:57:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web11.11286.1710316641972002989
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 00:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=A8+g398x;
 spf=pass (domain: siemens.com, ip: 40.107.22.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leIMKZDa9tbw4F4jBEcQdmVe0iw96rGaM7zJX65JoowtBYu5W/Qhu49CqAAC5Yn+/JEdMzkSO1bjPv/9TXIAFeVhuHLy9Jrlduw/+m6CekKjFVoomhZBrcYCaqIabKVBLa9o2bT2Yh0qVr5x8gNIujgL6YlfmPYvIMawJTxAGpIQLQmHEL3svJMCMX8jtIbpEs00Q5okuKS8KPustikirwUFzLIO2a4/brO1zmh1znvIF8Fl/ZuMsSX2Xqa3xl/6lJgwZvmAJPBmJuyNYuHSujYBYVwiXg4oKm/3qRZu2e8K75GMptRAoGw+nUZOuTK0fnEUkzT5BxwxWCtGmMrEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGaQPSPRZVGjlLQiLIvaA3d5Ga1+stOjq3y9zj22DIg=;
 b=UWFuC5nZmA24CgyzKdpmtqqgfl1boeG/K+KHBQtMht2ZIxn2ZVIh1++e4Z1yqLZmecnwM6m0wVF4kmvXdBiO/va/l3wJoqewUlZubOyYLZsxKwbJSSUZsiQb0HhU8OZxETKt9FygRLDuH7wtzGDdwyX68n+ri65VPPgbLEU1eOkp5+/xt1KAzzpxQe1LdY4LlJrmPPIlS0BTNpIx6+AdUVydd7rTWpNz65C9Wq21HC0NxOyvFXaxNq9KGUbN2TDJxt4nOEuojzOwySjrM/9Ot5ZQT8rN71gFgOyjRuwR8L6doIxrYMi4knZNgKAa3sw+lsqQx4vBFwTyx/2N9WR0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGaQPSPRZVGjlLQiLIvaA3d5Ga1+stOjq3y9zj22DIg=;
 b=A8+g398xwz9cbQKCzQs7o77f2eEIdFqjqa1FMfZKhJyq5GnbrJKUeIajMz1uwANBxQP7pWIR3qXP7pn+rMU65TMtF5UkRWit3wV9/Yutw/eEKerpCGgJp+Fkd8mawrFfLmHyALH4AZBDacmR3hQ/4UVYhdNHNQzaGAdQ5BZIlVmI90r5nbg5u1iD3yeM3J+g2jX381VhaKzJNrQyNiy0QpytWXkDQExBk0an+BA/2Bo3yFb33ux/Q6p6m7mg8Sj4Y6yRiFomWvmrnq/XcNSFWqbvqH6nUDRVJTcTVuWXs0bjrKmPgdcTSeje6pdRBH5ZoloUAUZpx/z6NdkUpwBCPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAVPR10MB6988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:303::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 07:57:18 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 07:57:18 +0000
Message-ID: <56791b55-c6ba-4fb8-84e1-ad2ceead8345@siemens.com>
Date: Wed, 13 Mar 2024 08:57:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/6] Make swupdate signing more
 robust
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
 <66be0ad7-bcf9-4383-bddc-34bbbb000e60@siemens.com>
 <894ebcd6-aa83-4076-abea-2ba743536183@siemens.com>
 <127e08c5-2de8-41b3-ae37-6f0bb510dba0@siemens.com>
 <487f769c-d9c1-4071-ba45-71563eb0a411@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <487f769c-d9c1-4071-ba45-71563eb0a411@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAVPR10MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: bde42b71-165b-44f0-187d-08dc433334a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lO2dd8gxi9/bFURgK1tw8eoGlEEF2jGbP6GCsJjAVow37iozmgaeOp0E847Zj6NTy8l2qZm97VvfPvp+ip2dIFte6sPFtVicStiG5Skp5omu1t+GhAe9/CEDsmCXz7gSZg3zglhT3CjV7QXxJK5ZBjN+I0DFci8+8daS1wyFeL4+5F/Ryj1CkDiG9E8l7BE5YzUjVQApor/b3l1snd0jDL0PM/IK+EDgxb+htlrATrY2N7ztvdVNv8NInOklNBrfPF+dq/qqwRYtPmZOca/5OOiG2kySQQoyRGOcUVpg4vGufGaedvxEdXXQZs4g6c+a5a39SyGq9dXdaSXxryNzmw59ACbVBkeJhUWXq57QCZKH6PGl7DVjuub04etlyxb5dNMuxSLij4F3IRl09v+Ukvsm+eiilPVRwo+sFFbR18jLroajbiuKgAEl/t3OcBHAIERH1l7976Tbx6XH4GdoVGHkeKvKs4EI556os8jjiG8kAsmpH14BHb0Nw4LdWmsZa7W0bIvK/D9VjRYbI1JF6negtC2Gax5YgzTtamEUppATkARaGB8o3j1x0JOCaoqkxsI5y4v2QSCgOlSs9aabZyTesGfzdys2KcP0wLJ2pmQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QsO8QCZLAkn1WKHfqR8I4iFGMtMNpuP2PVb+IavPZMi5W/nXCoj/fHxOoJzM?=
 =?us-ascii?Q?60rk5S8m6YoyYPC+02ihUwsm0bQC+gGDfBIGjACOozFYIN30kG8lqfYtP8dR?=
 =?us-ascii?Q?oqcluV6jyKoG7dW0/Ihcc+rVyRhcYQ40zRnfn6piylkmv8lDUKVKk3nqp/CE?=
 =?us-ascii?Q?fQAa2mtxxnDecywAXLhK6IjNP69jDWorDMu3iVvGeLmyPIXHaqhzm4XI913K?=
 =?us-ascii?Q?mYauY1UuaRB7F1FIUFH7shDtnVpW2z8UFzKhppHQ9mD+JfCaI0ot/K3P19Np?=
 =?us-ascii?Q?+3D8AddYs5s33fTbik6rGV+hFH0waVB++cZNaVwoGFJfHaaMS9VCk6HNPnte?=
 =?us-ascii?Q?groWrfkvip5vLF3LG9wloaVv5pQapzQq8xi+UhlxMIksr5tw5YYQYUdhs6My?=
 =?us-ascii?Q?UKd61TI7WTe8hhFU9LYSNWaXwixRc/3TragaVD0w04zT3xAr1HfgcVgdKoTC?=
 =?us-ascii?Q?OYKmEPIuhmqPZEWirR2eG7p+FeemMBmYTWvJxaZlI8rCwXoH0VqwqPtQgFbi?=
 =?us-ascii?Q?sKp1V5bsp5q1oS8cricp4LoXqpb1WLphv3QT06XhhKDlmwjRh1DF3FwUUHse?=
 =?us-ascii?Q?FiXEdkDlg9QPW2wUzjPxZBlMFAJx8Q7CSB6alW3X6lDJxJC6bXdbPXg5WQ1W?=
 =?us-ascii?Q?h2aHWVMdFmT658GsBlsY7dQjJq2fhZVOxGgzWJ4pSRK4s/ekGa2Qj+4Emgmn?=
 =?us-ascii?Q?2ecMe86Mu1uzdCELeThAHrnFQ/JEkkWWUVp2kEXouLS4m6FEdjk8sh1ToRQa?=
 =?us-ascii?Q?q4SRTw7JpOVY3VjbzN+nTKcZvdjNseXnEP1jvbZ78X0jvshjn8Xb9RiWHnib?=
 =?us-ascii?Q?SHLSVusfmVX4NXQO1QwqQTxAGZhi9KclqUsnVVufB2drNUWb7OeJnW8R7gHz?=
 =?us-ascii?Q?+4xxjQW8AZ+rZ+/D34Yr7fRpL7RMMIn2t9O28LitWt+iV3M1B9MrV8sNTM8u?=
 =?us-ascii?Q?deItfYE56Ukx2ArL//RMlnvBIadt2HgNJuvv1qWPM09V1Ppc5+Nz7R4QQUI9?=
 =?us-ascii?Q?UagASPbZikEXyGeu0xqZ7PFpQ2zayqGi6+qWQrone7YtxGxMuFtykPKuvQ0c?=
 =?us-ascii?Q?25El4ywiQFGeG928KC11+N3kQSczCNf4A5AZEFBpyyLmGW8yGNQBPUHBOBq/?=
 =?us-ascii?Q?OjGFczyZGb/H9qfpESDpTrghsGDDDgCc4DmvZGbk+p/3LOy9uUrEv0WFK1iW?=
 =?us-ascii?Q?sZBGdFUphaJVJUUxvRaTEDzMy/UovesZsrkt1TbCVda6Ycg3WW7x8G2hBZaB?=
 =?us-ascii?Q?RVjjcrUF03wi0sXZ7ARmssp/o7AcHFsr8BOoBbbw3amS3C4XA1epL9069R3h?=
 =?us-ascii?Q?xsOgkpWMeqQ3I0O/3esQ1pRlBLjYs19Y5hLuxlS/649jPFbm1xV2Dpa7IG5C?=
 =?us-ascii?Q?zHFMiQYWTv30EdB5nstu78XwO91voqqIZDaDKLotE2SvR/0U6ptqn3+TXeLV?=
 =?us-ascii?Q?k48IpRHTgHY+QQCd++nvTfgMW2m6s/TOt22TyiUq32mecqttYqBfNNDjIEWS?=
 =?us-ascii?Q?CHgBzMjc0XI37hBRkWCEudbrQsIBEEEYdgKDy3Wjb+JyQMPv/AusVHBLhQ+y?=
 =?us-ascii?Q?upS6VS0sa8fbjhP9h9J4uD8uWTyMbd/RA0auvwEk6+wQ3G7Hwdobq9RFzprb?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde42b71-165b-44f0-187d-08dc433334a4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 07:57:18.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZUiinmYVaDcIa7/LdGLQPMoqK+D7H+1nYaVKbccXiSmXEBbeWTwhG4dUN6wDGU3FkfawSCXiEbgpZt/PEbzUmbB7gPPXdzCJIiF8TL6UFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 07:57:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15285



On 3/12/24 8:21 PM, Jan Kiszka wrote:
> On 12.03.24 19:50, Gylstorff Quirin wrote:
>>
>>
>> On 3/12/24 7:12 PM, Quirin Gylstorff via lists.cip-project.org wrote:
>>>
>>>
>>> On 3/12/24 9:40 AM, Jan Kiszka wrote:
>>>> On 05.03.24 17:10, Quirin Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> This patchset adds checks to validate the certificate and key before
>>>>> used in the signing process.
>>>>>
>>>>> Add also adds the missing Documentation about swu signing in cip-core
>>>>> and fixes two issues:
>>>>>  =C2=A0 - an error in the build logs of do_image_swu
>>>>>  =C2=A0 - Creating all existing image recipes by touching SRC_URI in =
a anonym
>>>>>  =C2=A0=C2=A0=C2=A0 python function.
>>>>>
>>>>> Changes v3:
>>>>>  =C2=A0 - rebase onto next(704353612238cb2ac1c16f29db6f314b60cd83b0)
>>>>>  =C2=A0 - use local variable to increase readability
>>>>>  =C2=A0 - add formatting patches
>>>>>  =C2=A0 - fix typo in commit message
>>>>>
>>>>> Changes v2:
>>>>>  =C2=A0=C2=A0 - Add information about cpio option in long form
>>>>>  =C2=A0=C2=A0 - replace cpio option `-H` with long form '--format=3D'
>>>>>
>>>>>
>>>>> Quirin Gylstorff (6):
>>>>>  =C2=A0=C2=A0 swupdate: check output of sign-swu
>>>>>  =C2=A0=C2=A0 sign-swu-cms: check if key and cert are valid
>>>>>  =C2=A0=C2=A0 doc: Add section about SWUpdate signing to README.swupd=
ate.md
>>>>>  =C2=A0=C2=A0 fix do not add files to each image recipe
>>>>>  =C2=A0=C2=A0 format: classes/efibootguard fix spacing
>>>>>  =C2=A0=C2=A0 format: classes/swupdate fix parenthesis
>>>>>
>>>>>  =C2=A0 classes/efibootguard.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 =
++++----
>>>>>  =C2=A0 classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 88
>>>>> +++++++++++++------
>>>>>  =C2=A0 doc/README.swupdate.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++
>>>>>  =C2=A0 .../swupdate-certificates/files/sign-swu-cms=C2=A0 | 29 +++++=
-
>>>>>  =C2=A0 4 files changed, 127 insertions(+), 50 deletions(-)
>>>>>
>>>>
>>>> Thanks, applied.
>>> There is a regression on next which was not there on my integration
>>> branch. Can you please revert.
>>
>> @Jan You removed a `\` in line
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/next/classe=
s/swupdate.bbclass?ref_type=3Dheads#L232 with
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/8d9e44a15=
4ee685dc2311b7248d5f269350d2fd6
>=20
> Oops, sorry, fixed now.
 >
 > Jan
 >

Ok that was the issue - the swu now contains all files again.

Thanks
Quirin

