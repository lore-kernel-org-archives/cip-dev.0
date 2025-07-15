Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A40FC83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 16:28:52 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.21])
 by mx.groups.io with SMTP id smtpd.web11.123.1752596923984584215
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 09:28:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YMqhuOXR;
 spf=pass (domain: siemens.com, ip: 52.101.66.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKhYhthZd4Fn51pSLZl7YSE9tCHKKTsoYeucCLOcYfV089LqwGheSvPRLX0LNu8Vz4/REWTJ3keCF1vxUWK4xJqB/gKwW2Jo8bi1NpscKuIfCvtSpRHnLiKgGf4/YBAKaGv/u5RvDrvcldYbsL8Fkk2+0C53+9G9DX4hLJEPiPgAEKUaulJcGSU8+ROp4HrQ/C1SWmL/Ypv8ZBCB+LD39xJVDOrtwRXMUOGHChw3HYCov5MNemA4R8z3rbf4YJsYs+wE3lg71AkzMCrhXJzZ04xLiY2zBGNwnThpLYRMRLNUz9JSGoP1igwjEUbz+Bcts0OXE5F0rDtc5pI4Qd1mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BdWbNFstHmHR32Xk5EagZz46q9AiTdJS5DLDtltvvE=;
 b=cMXjJNmb4OpnMAeqdNPjEDBkATF7KOdR+KFWvVaT2JGyG8n7zxnzfmjz7SL87tCTomV5QppkqNVu7mPooy1Y10rgRi77eqR3UMet0N1P4HykGfoONePQIn+4yKYJ+K7yztxtImQRxMZNSrhLCIXnvybLHhduo3cam5+541GkUH5btPDOxHHjxnODIkDrYpPH7PYc6bDoogGcJwu3BescRbWGk5l6uJtfymWLOYGbCsS4P4442zMjpmfp7IwOifTbSV8gAfBr+VfqQiupzbGCilOb2+6xdS9huK1hnDpEgQaI46b7XXyyEAHiTTSple5MONaVZ/l09SlEsbKzP/RHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BdWbNFstHmHR32Xk5EagZz46q9AiTdJS5DLDtltvvE=;
 b=YMqhuOXRwuyp3nzlZAXdnVSXkQd1ggC5f3e49p8TVyoRNVoDrLj677/HKUiBrsrK4Foid5nbQAnDJ4YE+p4w4WfRHfs8pvbxgVGkTBusPFN69fNmTrS1IkUgRZkisroA53eLBoDiVubE6ymqtAYvXcWkwOUTuZyt9XMci2Q8gLLoeYhGii5/OQN6xS6A8eCrDqF8hp2DhVAbM/4pwOrY7w0EFoNA7x42Nfx1CdKnec7bYbx17ZhD6JuMf0UvQjTC3LrsYdRSgsIC9hbxTztdsMQKL2vzieOa87L6aEMjejnQOFjAIc/QRKXCY883uAL4494kt10xfJ9PSLjhOD6/Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:538::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 16:28:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 16:28:38 +0000
Message-ID: <c89f2459-5841-43d4-beff-fc25c9bd6520@siemens.com>
Date: Tue, 15 Jul 2025 18:28:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v6.1.145-cip44
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
CC: pavel@denx.de, masami.ichikawa@cybertrust.co.jp,
 chris.paterson2@renesas.com, uli@fpond.eu
References: <TY7PR01MB1481892C3F332A8DD99DBE2989257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <be2c98b1-61de-43ef-b86d-63a17ee578b0@siemens.com>
 <TY7PR01MB148189F17388801D22C715E0C9257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB148189F17388801D22C715E0C9257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0470.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b85c86-acf5-4470-6025-08ddc3bca751
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xr5edj+KAPB3TGba4pVhDy+wHXmAY7peMwtlpRtX6xQ0TySfPTaVHomyMhy1?=
 =?us-ascii?Q?hZ157Jr4FuP4E9xzxCb0fyhIlPsokXLn4vmBavF8dFP38iPh+JXeyUVTWGr+?=
 =?us-ascii?Q?X1YR2d1NRQL8/h/B8LtLsku9WNhsyGmembcPhhlB/W/Nct2SuAuyJmGs+2x6?=
 =?us-ascii?Q?TpNgJPtmcsE8gtazpT7D0Wb+GCw7rw29Uyx3MIKqfURPiX8LvMRUDBYRZ66x?=
 =?us-ascii?Q?S7ZAE6ylRRQIG7PnVeUxzNwU+YC/qp+O0u82MCJ1kujPCxoBTU4mnh/LHVW8?=
 =?us-ascii?Q?CheYnhHToPn9q0LGFKRUvn3wuUKW2qXMTf8GoE56/WOTygBKY5B50rUwouYw?=
 =?us-ascii?Q?EW1DrjXGD0X0gVm6k4t+8TsRovMlgBWEe3OF8Ck0+g2CkhJrpj2Qg5QytG8Y?=
 =?us-ascii?Q?lzdOkWK9sCX9nsyyitT4lgrq0fyI9PFXuWnL49wVu3tcGFb7/PENDwOkoCno?=
 =?us-ascii?Q?qg+Vtd6LJr2ZZ7pNrrqhB61IE+BUhlEeoEJ2ysGvTwgyxnH51NfCUWcJQjXD?=
 =?us-ascii?Q?N5wAEQKDTdVew2fuNB0pG8A+3FTYnjDFYi3rRtx08BI+KS9+cII1RpcAg032?=
 =?us-ascii?Q?TPI4Ndx8up+weDCTH0jd8Lf6c0fGpRb1O3mDPj2IsqjJ62iIsRYItb/eX7a9?=
 =?us-ascii?Q?f95Yn/U3C7SFsscWFdAlIegavncRZmmz6u4QKAFtxHAAQvl30PHHuai4Iqbf?=
 =?us-ascii?Q?YzoQy8T9tZqI86z1QdvoleVS8kQcy3+tiuZfhXGupq4Abj0LLVBd3wSM3dHz?=
 =?us-ascii?Q?gcNLRCtfq+Os/YXoU/WvI3QlVpmLG9eUWwuJuhPjzkbfUlyF9QU0QcNbSLnm?=
 =?us-ascii?Q?mnVM+5jSN7MLy/VqDJQ403BsaiIYPRX4pZsMUHoyxOAtQbVH3U4FTtOomiXu?=
 =?us-ascii?Q?ZKjI6dcFIzvNggE36u5V24qPRyRZBT0AwBealB5N6jvTMIxAop4r9g0dugod?=
 =?us-ascii?Q?IZ9IofLqFBRgrPLcHf2Hv8HbXVwJ4blChOPwDR51Fxxf+uRL1kDrm5ColjJZ?=
 =?us-ascii?Q?AdzGMSYdtSSw5ZzNYKJol/uqUVCARg+DHtVqe79X/g+vjCy8S3tBCSxhqElO?=
 =?us-ascii?Q?3rpodQU7TRHWd9I343Te4oqcKT1e1IkZngLV6Ch2ETFinx08J2Tuai28xkMe?=
 =?us-ascii?Q?S0WjLRU303VwaFDXQSXXFIpfq8g9oAYRq2qihZlAiMqq7Wx6pq+zBxvzNy41?=
 =?us-ascii?Q?iOVwDvsgHdF0zwdmCk01b2aPRSLuNyNQocVLeSM8UNdxycbCDPvv742+PjsR?=
 =?us-ascii?Q?TwlwwbDjhQ7B8b4zmSzye6XlaIZbmYeHQEy3zOZLBXtgI8NyZDElEUXhH2Kw?=
 =?us-ascii?Q?MauwWq9gd6VmyPmSSOzl2FS8nzIiVvkWZEd3l1zmYXo6oFoWsIfHigNlIUrf?=
 =?us-ascii?Q?0mN8wdcYmuADMekbnT4fVkkVEbLmaXkLbaFhS1Gkaw0lTm/+kcqdid6QcaVu?=
 =?us-ascii?Q?VY71ksBZDiw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NQh7jciMWANSD4+hA5802TwN2HEX5vQVbBkI1pYgusISi9P//2jF77zi1d4R?=
 =?us-ascii?Q?i4SgDQCoSsG6lT18d3mFHpWCsd+xXlTn+TxClLZ+ATD7bxiNEJiBqkAr6q6f?=
 =?us-ascii?Q?UmPVYj4hTmQZeeF0ym9+LxFq7Xq0I3LoEqTnbtF0QCcHwr9cEBuoLjLkS6fP?=
 =?us-ascii?Q?OnsqBet6KnpBtHdB8LqoujPCt88fqynWZw8h1xTikBXdcV8ilCWoKUe5jEi8?=
 =?us-ascii?Q?wBcnrOciLy9GuOP9Ns5BJgQcEnzLtAmx7VgDGInQClWUyms5xf21I8d5DGP/?=
 =?us-ascii?Q?WVBpeGiFVm7qP2b9TPJEhwOiQw1cyEbu7yQfNpG0Rm+VYvqBZvDSXqxanxLX?=
 =?us-ascii?Q?/ge/H8zBp3evlkNwDi9AA4JhOhie+FIq755RCupfyVvT+UvmlCh8TZZ2lo9G?=
 =?us-ascii?Q?xh1oNacRNJwUrcu4Nvg4bEL3mhIdP09K93gga7kVm5b6IwCIkWmQcTztXOVV?=
 =?us-ascii?Q?Lo7Aiykha74M16irE1VCyrqS5fM3rmWID1XWU23iVIyHvhbA7L5atwzr1QzZ?=
 =?us-ascii?Q?Z8lhpZnuIxe3Lhfotp6i9PXfWdQXBvBmdg3vUaIu4cxcvlsXJs5Tdyl/e2CA?=
 =?us-ascii?Q?HFBqxkqu7RseM5easXkYI6pqj9Nq9+RI/1sf2rJ2bAQGc5qD+QbVzWeSxW2R?=
 =?us-ascii?Q?OXQU7Fv9w5EYFHMcTGad3MCzwgqsYMOorlNePk74FF+X95kiqSIhLlNyezkn?=
 =?us-ascii?Q?KP5iDm0yh8mabw8fdSkyMka14/o4crKzzCZKAwoVN5zqzQW8r0uNp9D2tK3v?=
 =?us-ascii?Q?v7CxUzmwPrNAkUwh+sw4OFJVkNSE4OtnAILrHDL7J/kZpqLHhVnaPIdlYFbZ?=
 =?us-ascii?Q?AbQcGFhVZSY2T6B6mvC9lYi8a5txtDylL7HwedFonqJGgfjuzAnY6rgwHp4N?=
 =?us-ascii?Q?tgqeYikV2HKFIDKUumdFjc90he1BFjlhivWJo9e/p1nuBGqsb2APSbJbBJke?=
 =?us-ascii?Q?UNSO70OAXqWDl3sWe2rThcRNqeal2dV7lK0Uy4TS1zukUSH0BanyH0TAlDC2?=
 =?us-ascii?Q?wpT8RM/lv8HgBisxvUYPJHC+9FJoKqyOj7dhwQA8tXPeDmqkT2jKhdcwJkpI?=
 =?us-ascii?Q?gKOhUvgVaCT73AdZpFriScbAZOZcTvhEH4QR0DstFhPcNzP9TKZnZrJHbQ0b?=
 =?us-ascii?Q?eE+Ato6fQGh6maATHpSLJ1O2jBtbiqYMF8kCK39PSIuSB+2blfLCtfUorYYZ?=
 =?us-ascii?Q?JF9HK22IXyJ9RGQB0IMeDMNhaZBDB2GjF9ubzbTuEdbQYXzbDEWXry9FBGfS?=
 =?us-ascii?Q?RU1SN0LwqD0ICHOMq1yWQXoFUjBADgA9nruVL5ILTt++V/hbwZHd65mk8SPU?=
 =?us-ascii?Q?W211egqKINVu6VDDCraEFBYDBubwDPh6M8MHEl6wfcurtMMqg8VekMTL3S5S?=
 =?us-ascii?Q?YOM5YLRWyo9uAWzDA+1EQ0PGk0oFMCMnhbKjHDHTdTvwOE/5ec/mUozf4ow4?=
 =?us-ascii?Q?Hn23xe8kj90UwW0fCuWf5VNh4C60hcrCnEd/OFZC8Q3DyZtkYym2f6owWVwm?=
 =?us-ascii?Q?BdIc515i2W7FRjkkp2mFOfBksnkq4WMnB03jEwYC509j9qCtxZ77Gp3EjqGi?=
 =?us-ascii?Q?OeeTrjgQPGdjRzXKxhEp4MxnJCTETtXysKRZhZa2REbcw94+rQ6BELZ15DiV?=
 =?us-ascii?Q?UGCkiSN+ibtjx2agh4Lz1CITp3PipdogVUr8y7wf0mc3EuiGMI9pzqWJ8gKo?=
 =?us-ascii?Q?6IO/TQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b85c86-acf5-4470-6025-08ddc3bca751
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:28:38.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z06gG6GW/AEobzcD3yMoaB3ikgJAqZz30uMkPBXOKZiIclkxBz8apuzGIAV0miTPXEeSXZMpEOJXNGw3SxRraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6029
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 16:28:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19544

On 15.07.25 16:02, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Jan,
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Tuesday, July 15, 2025 10:38 PM
>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=
=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
>> Cc: pavel@denx.de; masami.ichikawa@cybertrust.co.jp;
>> chris.paterson2@renesas.com; uli@fpond.eu
>> Subject: Re: [cip-dev] [ANNOUNCE] Release v6.1.145-cip44
>>
>> On 15.07.25 10:06, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>>> Hi all,
>>>
>>> CIP kernel team has released Linux kernel v6.1.145-cip44.
>>> The linux-6.1.y-cip tree has been updated base version from v6.1.141 to
>> v6.1.145.
>>> This release added updates for iio, clock, mmc, irqchip, and drm on Ren=
esas
>> ARM64 SoCs.
>>>
>>> Information about this release is as follows:
>>>
>>>   v6.1.145-cip44:
>>>     repository:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>>
>> Is there an infrastructure hickup? I'm not yet finding the tarball on
>> https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.1/
>=20
> Sorry , I forgot it. I ran the creating program.
>=20

Thanks. Maybe script this - or have at least some reminder [1] in the
existing script of this can't be covered automatically? :)

Jan

[1]
https://github.com/siemens/kas/blob/32f59530e210fd34e56852da56d26e51431b9ad=
4/scripts/release.sh#L76

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

