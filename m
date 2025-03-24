Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD9C36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 12:53:22 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web10.38611.1742820798402926749
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 05:53:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gV9KUEhO;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH43oo8vGUBCB8jmmykmCIV1saack9giwXgADfvDDIw+x8IEyB2av7F8X0iX4a7nsa4RQaE0SF/6RIhHHX8zTLz76yBiICNtMbEpcFTBi/kdpWEMy3E6MaKtFiUR21uJBV1y2NJiCZfF5Xcpp/Y74Unizw8UMP4XYLo1hjOmNq0WgLo+QL7W68C5ccQfkHSDi36TkBLTvIN6/juf1fpBG/v4jrftOZTt664U91IZ2dGR/0LRcwBgCKSeg8etrBWfl99JFRqLkeWlBYqsqRhvobb8sNNagpep/CRotLJ9kqJhrU/8TBzFIO4BFfea9kKBg9nKkJqmU6dbkDB3viWiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNZd5PVWnI7kwqDCQhtZcqYzk2PuQHMrilv3hTlcXt8=;
 b=HMjAXsr7Nzwl332hgu6LblSwzp8IpaUxGBtLrE4GZ55e5JGw1PCWRNfgbRIQYrGE0hhgwzWWm+zDWjpNpOCaOnmWNZAreBqUSletQ4WwIlCvW9GNE74LcFcUQkYFbowpNPc9BqXmNt8XZYBfJXbd8YuBlyR3Gs1BjGpPTCHa4Jb1fp80Xc9UnqUkT1dEQGIV4GUc6m5ouNsE3X0GZcsTsjvZvr6lYCow7nKR0AQLOxbtKTtzMnmJ0MiQ/VgGwzvgIo8WcHloMRaRbiWX+MVn4VZ+VCwF1gXBGxdga415r0gguLNVzii131zx7NwOVOCRcyGWCWNKIMVj/kPWHvLHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNZd5PVWnI7kwqDCQhtZcqYzk2PuQHMrilv3hTlcXt8=;
 b=gV9KUEhORpcYkboEEZVzjC6jLemSLo6L6AnMLTXRPptvJZhbgcXiXFWwkRpwPU8YU28OLbMk69KgwtIU/cx/9kaVkfCuHiTj3qZ6nYIE0ixnTnHm0z4Z+4iB/UoFUDuBfXJLMX/uKxC9IvrfVOMmVoyfg8VHiKJOWVkGS0aEKLkMd6U9rzWJf9Vw3ZccTyhcezV23f4guHN3juBTmjwbAidaTvrIpJivUj6mpZdn3D4PLv1pYfif4U5w0EspehLKJhjDyFDUH2jj76dePUwBs9nfToq3HfONCtIVJhrY9xeExy2D5Dxrtlq3KVsyXvrJw2AVw0w/ocMWbTfXi+Ng8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 12:53:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 12:53:15 +0000
Message-ID: <0109c46e-fc05-452e-b455-5839cce2038c@siemens.com>
Date: Mon, 24 Mar 2025 13:53:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partition
 for qemu security targets
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 quirin.gylstorff@siemens.com
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250324112155.3051460-1-Sai.Sathujoda@toshiba-tsip.com>
 <37053ef1-be2b-442d-b4a9-9da99e75671f@siemens.com>
 <OSCPR01MB14838A47CBFE9609D5FF0D806C2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
 <a1270914-e11d-471d-a63c-77dddcb958cf@siemens.com>
 <OSCPR01MB14838F9000A2E15ABD469B47AC2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSCPR01MB14838F9000A2E15ABD469B47AC2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3756:EE_
X-MS-Office365-Filtering-Correlation-Id: 70749974-47a8-460f-3684-08dd6ad2d7db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dZoVBvkVuO9d3CcGj5IiVLTQHFRbEvWyyKIyx+KKIuMRRiaAJiACiuFFD+2H?=
 =?us-ascii?Q?YqUITMDot9g5Rq8kAquGXXvy/PrTouQ6xvZJfsCrJ96fIgLmGQwKicZrspEj?=
 =?us-ascii?Q?9yne+VJjvJbfMf2QyTXvuZIU+h2AQyl7yura/7vAkpKp9Puc2RES7SXN/AM6?=
 =?us-ascii?Q?unhDXeqo095Ps5x/3HS9reEY0+VJH01Gm6WPpDp2p7s134anJ1V9i0Bk6im7?=
 =?us-ascii?Q?lb8rTF3R2t0c0LtPM0DtToQr+AWeq9nSRtyHYbVEM1i17/TP81GTZq0Ut3qQ?=
 =?us-ascii?Q?tlqE2avBs9S0+HKryymbTTAQwphTRE03pFxmNph7H2sRf31R9euE9dGtKgZz?=
 =?us-ascii?Q?e5bB77TAiDa7z8H7Aq4jaPfKWxwfu7SC+MOd61oi/MDruAse3ZRv7eCZuX/c?=
 =?us-ascii?Q?irNbfv+OOrS/BHtGkUcQ1r0bXoPozfjPvokfIeRBCD1/zTk+5JzhUV/ypgiZ?=
 =?us-ascii?Q?WlC4eIEznHJ4+nuAppNjbElkPXBGuLohmQxzFlw92sPpj8Gr4BEUSuvaXjOQ?=
 =?us-ascii?Q?NxeXPpNo7gQNWycDuN4HzAy6GDHassB5kXBI1NciyM9DNtjA4CO97LVdB9BX?=
 =?us-ascii?Q?JpccQgwOOBQBbacaEo0rHk3CmK+j1pGz3CKCeYdQ3xgpleyj5qGGVgkySrEk?=
 =?us-ascii?Q?Lai+N8PAQKwnk9vAPdeUF+sEOXaFzs2ViGc1EBQEr9GjtnC2gK4YtuIBfy2q?=
 =?us-ascii?Q?Py3PxeVhAe9dFwV5f6hmvuAlPgKBEfvwh0OPFn2LFruHmeQ0cxZy6uPtP0s8?=
 =?us-ascii?Q?uu7cnuqUMkn/p6v9PdNGXvCTErfKB4jeI44gV1jawDpSlnZO/JA0T5nFubW3?=
 =?us-ascii?Q?kNU/iLqcdAGTt4yGL4Z5UjJn9JgwgW3j3J/0nMYjYGmx7MXFYs+vRUX2dt9i?=
 =?us-ascii?Q?33ckNKMWLl3y3G6yfJ58pSLw1T0r5lIJnPjKhHEVOZacibKH83SvfNkrtnAh?=
 =?us-ascii?Q?gYbfhuXg1i+C8fCjGN63TsUZTVs+1EmGvdmW7yg3+zDfuY2nw+Jxukyb4B0B?=
 =?us-ascii?Q?1sVOvRZmJQv83vexXpwy0yXIBEHaC+rArdhkOiH2e9JGvfWQRRNUmY72BlMT?=
 =?us-ascii?Q?LZxXEIbAnSYMqQCEiffBxJbzYe9FnfdYi5ee5ck5GUXHQ4Y+jG6x3iww5VQ6?=
 =?us-ascii?Q?qYoyyjtzbVAmY30m5sO5dYvkF6O2I7e1z50/PhOKxudUlO3+4ZcdiR6Sdp1q?=
 =?us-ascii?Q?hio5fNfEiBtEw7W/aStftPUObciKq3ZbIxP5tTHYBTuXiO3s2EaXY37zE/qV?=
 =?us-ascii?Q?+7DWxg5fyLuxUki8vjwY5S8gN/xaFzfqEeVdUPuPkroT7QEqrxML0ow4I1Su?=
 =?us-ascii?Q?Tz7PFIU+P8usVpowldnSPFdCF7Q/6EllUeLGWDqoWa+fCnATQ+fx+eOaewPu?=
 =?us-ascii?Q?GZpIr6bwStZpb44uDDExdvG8KcLO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SnhK9XkpPDIDHIykJCHFdKNv3vE/O6qaMz/ETlewPnGblzxDvFwdo8mobIUG?=
 =?us-ascii?Q?Z7pfR5ySG2uGY9t79e/oB4gMo2eHkwmm+HaDgn+EgHcdTGyGRf5Iih7I2YH9?=
 =?us-ascii?Q?Vmt/fZ7sQNfLccBccOaVjCQBcyI+xcHxgS0kzv86sH3H5jEwce+vL95fg8GN?=
 =?us-ascii?Q?Bl6VrM1PxM6wU9RWGesJj2yKGILcl3pq0Cj7fDJ++kH1egZYonjSWBXyCr2F?=
 =?us-ascii?Q?kLQDVr0XcgNc6/nVBtecabmur/bxm8GP+8oGQhxySTPjlrBqdWIF8HWFoUxL?=
 =?us-ascii?Q?RzR2VQ2tLogCvwzqw+haxbib1IACGE+j6wHJIJhps8rQJJmWWsXB1mYa8VNB?=
 =?us-ascii?Q?HtpG55JCWpHSEtXsWDsK4bbFdHM/kjOgt23K/KY40iW16yz/Cj+YiFygki/G?=
 =?us-ascii?Q?mD6N2ZFU3Za7WQzuQvkp38IRVsKjoevyyyeZW2cg+RfVjOo34t4upcm1AVLT?=
 =?us-ascii?Q?7dMa1mCzfO6nKJLEUfCPiunUHpUA2Ce19Cd7V/kxVETLyUpRh+fbmKEtqXcs?=
 =?us-ascii?Q?aWu7uUAotbfjuqUHviRRdDGzXDGEPQm21gChD9HIPlCZ9FUxRXtqv5ye2nqo?=
 =?us-ascii?Q?EL3MFc4C5WGd+yCwgOImqlCL4amsArqFwMbzteaPwmmOzZtVuXm+SWbfE5sZ?=
 =?us-ascii?Q?OA2cRVqiQJX2LDleNhOUZGvC4W+8y9uopaPObapYoJLQOMglTId7PBMJhKIk?=
 =?us-ascii?Q?pkl13TPHzdjjMH8Z1Sm7YYYsPVdLYsqi2YKvMtxI8PQPdhNCBxaxiL2mMRs7?=
 =?us-ascii?Q?jJmWEvxaPohICoVcJ1YECKcfZwFdqDoR1taE2zP7X6Q6MAxf5NcAfXvUs5e+?=
 =?us-ascii?Q?sDNGaFAa84DV6SYdmViR9Qn/xswpmGuKM+/bgzReDt+iKZoqfbCihiVzdYal?=
 =?us-ascii?Q?uk/Agcr0ZeEIgMNeSyqrNZparS+JvSln2l26WQ7NeuoYKmyXv5t1rwzYqSYf?=
 =?us-ascii?Q?uHaRU0XVMGoqWV0zOJnfr+miO3r5wMb1tKEalge7QldJkRph74WgeSIGx1vi?=
 =?us-ascii?Q?ScSoY5yTI811FzyqPZ9K6+y8QCmCekct08d2/D5IISYiD/xKbAGzULTpX5Ip?=
 =?us-ascii?Q?yjLjjs4elPe87u2ZscepojAnCEmjMg+0apgMYazGVEsqgH3C9GHqCriTI3MF?=
 =?us-ascii?Q?+mx0AGTGzw/6gChTokx/BGRLaLjM2kGnRyIMdwRn+vvTl6Ps+Gd1p65rBBsb?=
 =?us-ascii?Q?e379T2Wd8IdUhfS9YMq0keiPof7vZUWVBqeNmYZY+hVHZ6cq3u57qchReahp?=
 =?us-ascii?Q?4glzMgDm2spEGpGrMPaaLZ0BJBl284Pd3C+Va/sryb6khItzY1gd591ZvbaG?=
 =?us-ascii?Q?QeBzKjGKtOnFYSTN8yRkx1kvnNX3d776zyoD4bKW8bJmG2K7vQsBFJbXMFc0?=
 =?us-ascii?Q?zYlQxbM87HqsPivx5MAQjth1g1FPiZiRq2hb262tsGLB2K97VAyM1R+6yiAi?=
 =?us-ascii?Q?fe5dhX86LDxv7uz9zRUQxY+r7V+QIvPlQT6nL/rUJuQn7eqJ4EI/5/qf9//P?=
 =?us-ascii?Q?lm4LDYFVygX8a71I41IgLJ8aojh0He1JpkNoS4YEwV0DTDon2KvkPwS2se2I?=
 =?us-ascii?Q?Uc+5zgJylaAIgx573t+jQCEr4Z1La2XAIebJ8MGW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70749974-47a8-460f-3684-08dd6ad2d7db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 12:53:15.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJR9X2newlyzOqGgu9aB/1XFPrlFjRJndjJlrurWW9iKX55bVw49I2QYB0mk1WNtOoEMY56xMg7cyeoQ03k9xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 12:53:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18346

On 24.03.25 13:03, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> There is a possibility that this can be limitation in aide. From the
> test cases perspective, aide is not detecting that the file has been
> modified after an aide check if the file is created under a sub-
> directory in /home. I am looking if this bug has already been reported
> by someone.

Thanks, please help clarifying the root cause.

>=20
> As of now to handle this, we can either add home as a separate partition
> and run the tests there or change the test execution directory to /var/ho=
me.

The latter would make the tests depend on where we relocate /home which
may also change again - that would be bad.

Let's turn off the separation for now until the real issue has been
understood. But this commit here should be considered temporary. I'm
augmenting its description.

Thanks, applied.

Jan

>=20
>=20
> Thanks and regards,
> Sai Ashrith
> ------------------------------------------------------------------------
> *From:* Jan Kiszka <jan.kiszka@siemens.com>
> *Sent:* Monday, March 24, 2025 5:24 PM
> *To:* ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <Sai=
.Sathujoda@toshiba-
> tsip.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-
> project.org>; quirin.gylstorff@siemens.com <quirin.gylstorff@siemens.com>
> *Cc:* dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <di=
nesh.kumar@toshiba-
> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
> <kazuhiro3.hayashi@toshiba.co.jp>
> *Subject:* Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home
> partition for qemu security targets
> =C2=A0
> On 24.03.25 12:35, Sai.Sathujoda@toshiba-tsip.com wrote:
>> Hi Jan,
>>=20
>> Across all QEMU targets, the mentioned test cases are failing ->
>> TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1
>>=20
>> All three of them are related to aide where we explicitly modify a file
>> and check if aide is able to detect that. If I run these test cases in /
>> var/home/.. Aide is able to detect that the file has been modified
>> reporting an integrity failure to journal logs. But if I do this in /
>> home as working directory to run these tests, the changes are not detect=
ed.
>>=20
>> We can also change the working directory to /var/home here, instead of
>> deploying separate home partition here -> https://gitlab.com/cip- <https=
://gitlab.com/cip->
>> project/cip-core/isar-cip-core/-/blob/master/tests/templates/
>> IEC_template.yml?ref_type=3Dheads#L74 <https://gitlab.com/cip-project/ci=
p-
>> core/isar-cip-core/-/blob/master/tests/templates/IEC_template.yml?
>> ref_type=3Dheads#L74>
>>=20
>=20
> The idea of linking /home to /var/home is that it is (widely)
> transparent to its users. What is aide exactly doing to let that fail?
> Does it reject to follow symbolic links? Why?
>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

