Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102ACC83F35
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 17:24:31 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.42])
 by mx.groups.io with SMTP id smtpd.web10.538.1693502661277833381
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Aug 2023 10:24:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tjMuEYwt;
 spf=pass (domain: siemens.com, ip: 40.107.13.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9WUkI9Tv2XpkHaK8FGRGPEDMiZELGcCfig+vAoE9dm1KgKrvuDL9l+lmmgVrTpbN+a/6hFlaL8L0bCJNA3nD5yZOMaOZmIHqpkxe4Mfw4XiKI71uNxdoIgV0+SqpTvnEYzZs45X+NQqSrNcy8GaZ+LwL6XYjfXjU6LtCl6tlqmg287N9BE/1UypsBi7UgKJzhF2gRvdk/JTa5uosYTB+fr88I8xUiOXNMIuAcol+XEpy86rUtXkFtPYKnjVcFxVzmHr8BwW/fAWtixZgpapFGRsR77hU/5Gd0/0vuvdlpxg6Vy9vFGEdrtfRP9Ew4eVSq/+IsKOZZNmwXiUrSlcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJffX4JsoX7jBEMuxsQrS91byoinQ1MdAjai8Es0VLI=;
 b=Njb8luT+K3KbpaHjfh64rZxlbplqcI+zxEV1qZUSyeq32/irfAnkiJ1NbmgD+ehgAvHYCgY7WL8uvFmZns+6jzqPOn1/CwR/UWaIzstmdpnwnUZYo+c91xuTcH2FZZ0O01NjgF66FaQe2vVWnWrckFxZZM7mcynwudTj3rYY9TRc59IKG54wkJIicKJPdcAE8FIOu0ZTB4PWTaQ7gcDfd9FrinP/IsAEDVuM/Rne/c6gQvrWVxaRhhYGXCijR0JPi1WVsbnveXUABoEpR3LWHnA84GYMYLzLJAKjBOsRLvWgbaej4XKFilkm6l1z9j9/nHW4YtAzJAdm0I2oqRcjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJffX4JsoX7jBEMuxsQrS91byoinQ1MdAjai8Es0VLI=;
 b=tjMuEYwttnmAK6A/B2uP1KtItm88i7Jrr8EJuVvHOyP+KbDBSkKfud/sZ6ubT36eODEum3IU1qs+p8wcvTttxCw2/+nYx30FO1gb2ycm4NYTH6gutp3wQ2BaS4wh9bZCbau76PvG7CDEnxpFdcMOrmsxsrPWZIMOONno59Tu16SQ4jniPUbKkUM35iGlCEtr12gVHqgY8gkuibeKZA8KP+5cD4BCal4oc31JFEEZAlnLXX5DSicfG+SC6mrvNPX7GKWdJ4ewVsXRJGpkEbAcVPYHgHquKYVLXRLCMFLZHTD0MUt8nqDkmT1K3nqog22MRVfJPuwSVkFcv5ai14rNOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6844.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.38; Thu, 31 Aug
 2023 17:24:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 17:24:16 +0000
Message-ID: <d25f6c8a-de64-4fe4-812e-436ff02cd4ff@siemens.com>
Date: Thu, 31 Aug 2023 19:24:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release
 variations for KernelCI
Content-Language: en-US
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Chris Paterson <Chris.Paterson2@renesas.com>
CC: cip-dev@lists.cip-project.org
References: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
 <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com>
 <CANgtXuP_=UBMwaVu2UOwnzmJpQPJdsJh2tJKqDP3LCoWy_Hbkg@mail.gmail.com>
 <1c4494da-028a-449c-b796-280fee653bd7@siemens.com>
 <CANgtXuPZd9zzQL=TX0fgX3-A+551iFA4wcW98U_0-FNkUokB_Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CANgtXuPZd9zzQL=TX0fgX3-A+551iFA4wcW98U_0-FNkUokB_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bec6d9c-f828-4516-c9ee-08dbaa4719fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	roT0UDA0XkcGxZksRuuqmBJ0mvkqFCGiCcl+h1JcbKPjlBR2vqn6fzdy+2Ifd4wp/nUYLXDYwU9/U1GfbMeT6VzYsQSP422SkTQ8U79/eBMZLoWcC2yr3hhzk0HSvGul7JLm6j5xsU47XnZwBkMNsvvHylh893jXPj5OUNQ3zQ0LhUQyrWRNOGLsGwUvnjq865tX1n4F1koYlj24ynvpUEa9+c8SRDDvnSG4VQIWBUfxtqgxV5GymNxqhN1l/3LPB2nO9aNzVormErTULSMZ+paZW3rH2hJiFFeI+jdAE0cjMYsHc2mVocy4DwCzTlJyhT1nDgenh07IwGhKp2N+sjx+Mh94vJoB6mQ6KJUb9TBva5dqPqzERm1N5IdegFySoZ7GIWryI6SkyySDXLSzDYP4+12HRsAiD1It4iMrdvxOJ6utdlhGDO2foVt2HCV+o1xQMWGizsxKmeB0XJRw3E3T0wGobAwY0bkzP+4DcwWjvaC0Lvtsd6r+At20EV9utp4iivH6rNpaDRLcDKKrs90W1V8UFtANBHR7gOGKK2VHsCyfr+groQAIVdZu5QlqZhp26h9e8HH7Hn8igd92CFlPk1/Y8Y7Q0f86+dwSL1lqI1L+6/XKtLMn6cPOwh5mvHqjcozNHYq8PymE8wg5Sw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199024)(186009)(1800799009)(6512007)(53546011)(6506007)(6486002)(31696002)(86362001)(2616005)(4326008)(41300700001)(26005)(36756003)(5660300002)(110136005)(44832011)(316002)(82960400001)(66476007)(66556008)(38100700002)(66946007)(8676002)(8936002)(478600001)(2906002)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gYCxG7nUuQt+e4RvXvdNgnHuT88C38wAs5QUbACswbe9/yMDhsb4tfljOzgw?=
 =?us-ascii?Q?bzGyTO4jTxGokm/Esr4jXL94NtJqCcSiup2os7w/B3fvvFexsK5DFgPo0x6E?=
 =?us-ascii?Q?yKEBh5m55rOL077zdGKLSOCVtl128wYb2r19rq5E/MeWJv5X0hgb+L8yULSk?=
 =?us-ascii?Q?A6Ab+DdtOEh04Z7Mscg88aEM6s42xjY1VlK/8PBhm531biFTFnegEoWZ04lj?=
 =?us-ascii?Q?dNJQ6tofvgrZ5wSrhV43KQrEmvkxWIdjDcY09RqLr4TQbn2BfXvcaE/oPb9V?=
 =?us-ascii?Q?OQQpm4bUCONgNcKZSJa5Y2Cs/etwJpAWQTN6azkg9d6sjIJKeeRRNZxGNaPC?=
 =?us-ascii?Q?juER4zQJ00VVPYaNOaEFiyhAM3Dktot+5I6ujQa3Y9ozKzPcp6mNuHKzVD++?=
 =?us-ascii?Q?E69WsEXsvnfhLYIxmMGOqbglA+bKR6MBn8ErmDJ7+1fHr/z9utoTbBcYuI9z?=
 =?us-ascii?Q?WrEdQFOCyCiZXMgMEuGiK0AeRPD/IcxDTAE7A3FB6PSijx0R4oNxlbcZaI/K?=
 =?us-ascii?Q?MI0S35hxIoPulnYA5yN1SKOj8ZJ+QopS7g1I1UG+zOBEf6rFGvcN7Zfg87RF?=
 =?us-ascii?Q?mWp4F+2XkHADqvZLpP8xRacUetpaihkb01tGahMhYaXicTnW1S+iy54QqGxl?=
 =?us-ascii?Q?2YkNMwWG58cW6TQIBbAGxVfHcwVbpjeRndOnfzaWVr+GMJ5tAX89d2FvfRQZ?=
 =?us-ascii?Q?FsyA+C9xGniyjKlUcOUz545CxwApu3QLdpseaipfiPwy8YRunrnZ+5Hqe3xG?=
 =?us-ascii?Q?lEv2XXmuFvMv2WFGNO4RQnUpeeglirbLwwhgrDvgqQ+D3k4naGT5aYH0vbEr?=
 =?us-ascii?Q?zFSC602JFcKzxOCbLrebVeUi8uf+f0Ks55mDG/dDSe8bgOfB9vcShP3BE2oS?=
 =?us-ascii?Q?nBE6NKclB7DHk6edP3RW+oWb9cEaslqqHZOYu1+IlVeiwtL5dKUfikuyS1Ex?=
 =?us-ascii?Q?z+dPa7WA6CsWqhTXHPo/HRzuJovoyP/zGqwtNnUUwC06CrsOjM2d8MBWLnt5?=
 =?us-ascii?Q?H7H1Yf/HKby+IAvwj3KzUv/pcHpiUwdLn963H9FR9VHD9s97JXyn9qm/c2tb?=
 =?us-ascii?Q?bbcyJwHqbjIPzRfZU2T1M3airisyN5eWkS2Dedq6c9c3Sb83vaeSPei4zW9l?=
 =?us-ascii?Q?3ZbLq3s3p62frnqmnmq/RSah1MnOwmQTetqfHuIQrX8O4cu3ZPIgbfZn0n8Y?=
 =?us-ascii?Q?fq9EqTEtM89UfL7IsSfkJjM1IJnZ7lGG9NkT6XJMLlntlg0/qRjru+ELg2En?=
 =?us-ascii?Q?YpPxAOevpRi5o71BrOz9+6SU9/jQhE2UTYfh/UQ6HqmqJ6h1MZ239L8Ulp/6?=
 =?us-ascii?Q?GfZyKvxc6gGlJjEqaUHGYVOM96BdhQY452UDTup67WRPuVK/ZvhQCQK3koh7?=
 =?us-ascii?Q?pyD1KVsk3qZOtnWQQCR0NJ/jvBbWSwM4nrMmCG5ve3S+6+EzZhEIqOlPvZ4o?=
 =?us-ascii?Q?S83/IBVIExRoaBEo2gErnw/oz6fUiosBN3ZwFWfn9Bnw72vd2v7qJF+8kFBt?=
 =?us-ascii?Q?+jG687PsNwWe4PTh0/OpK85MqSsi7rwayikcv+WdyIZN3ol036m62xN9qfXP?=
 =?us-ascii?Q?ScVnyD+shSsiawzFKyLXZUGWUT41e/z2WUOeGYq8GAnggczTbbkZBD6fNpTH?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec6d9c-f828-4516-c9ee-08dbaa4719fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:24:15.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbpaMteNIxD8hJ9WF2Uryd/Co72fg/0puxyh/oZ35rRJMCWrSSm72YLROUT4dA/2ol1CqtlDM8zIYFOD+tkWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6844
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Aug 2023 17:24:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12931

On 22.08.23 05:38, Arisu Tachibana wrote:
> On Sat, Aug 19, 2023 at 8:53=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.co=
m> wrote:
>>
>> On 16.08.23 16:40, Arisu Tachibana wrote:
>>>> Happy to add that - just wondering if adding those two targets may all=
ow
>>>> dropping one or two others which are implicitly covered by this now. D=
id
>>>> you check that as well?
>>>>
>>>
>>> sorry, I'm not sure of the meaning of your question.
>>> could you explain it better? what are you willing to drop?
>>>
>>
>> Our CI tries to cover representative combinations of isar-cip-core's
>> configuration variants. We can't cover them all - too many. Now, when we
>> add these two, later on also for non-x86 archs, it is worth to think
>> about if those obsolete other CI targets without creating a relevant
>> test coverage gap.
>=20
> Can you specify what targets do you retain obsolete ?
> are you saying to skip amd64 and do only the non-x86 arch?
>=20

I'm still scanning for optimization potential for the mentioned reasons,
that's all. If you all tell me, we need all the variants, then we need
to build them.

But looking at our current CI set, there also the test images [1]. Is
there a chance to consolidate them with the kernel CI images?

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab=
-ci.yml?ref_type=3Dheads#L160

--=20
Siemens AG, Technology
Linux Expert Center


