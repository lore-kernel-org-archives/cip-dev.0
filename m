Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA31C004D4
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 06:33:22 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.63])
 by mx.groups.io with SMTP id smtpd.web11.9802.1674023595856723564
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 22:33:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=f246QN4O;
 spf=pass (domain: siemens.com, ip: 40.107.22.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVAaS7rATsgWcqF59QyPhz8Fr52Tqlr8fvxhc2GdxHlNI2E02IOWdngWHZ1tb/Oh6+UkqlBLwvwZSwb6d/K9KWyZQ+kRTTpj0obqFcVanukJisu7yuOmcwgCxsf64rc7fTjgdTI6/jpPSboLrqZLDeFH27dn2y5r6q0MlP/s3XPNI4FsZ9n8YevPD5NOdzVeKn2RpK4FMdB052Uh/dcrr2+E854O9flaiDnGs43tRoQCcqPfE6Wxmdp4sIM5PqMcRCy66d0LoyiSuf2uAr3Pb4v0ao6yKMXkXqG4O5aVN6IkpBUF9lIt/LrEC8E/zmBjgrmjlE/UvX0UOiPKh83s4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAqwUYjJQEjQeYkrpEdOgDN8DmZbJ4RM6KbMIDxeS0c=;
 b=m0gzIYpjN/+sbUOzt2tej4Tx8eNwhh35PZ2Bi7JHsURtXvRDMYvpS+fRZMN4ux2C7UVMGnINVbQWbi9w2ofvezpsx3luPLNY85q1pDTZO6dZQzfImFcDbfnNzd5qySbs5Lh+/cGCxMKP3TtqSm8knwRbHJRvSL7ItismY7C6jeFJa05uQXP0V0GwRNN1vhwbmoOAAl81s7q8DKWg6E/2Nbh0f2KUipgZo/63Ga75s3lxz7aMTW7QIbFLSuBOmdaT9U+WTZx5QM9L7XHWXM9dINOtTDrqL5ORbymtfmq/TxS3/mfLGC7/L1/Ka0iVcL5saxwIo8ANMJnO7zmL0Eo/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAqwUYjJQEjQeYkrpEdOgDN8DmZbJ4RM6KbMIDxeS0c=;
 b=f246QN4Odyr0or6/WLY27Zj0klDOHWAtoFzcZfqsDPxKa6vYLqYXtzrC2D3wLwk+nFGmA00ed4xBCjylVINch4TEId8oLsIzogzUtAvbTpwhbpvXeEef96SUADSejV/EqFqYX3w2d2g0BdXmG6XiWErC1mQ8eIX4tMWCr+9uP8p3pHB6xhmdF+eqWxzdn4behR5082UgVa2U9pehts3XSJ3FfiYRDF+ER1aqOzTVUthZRAdNpMocWtwHgiR89w/payjMkpH6wqaQncv1CISJjQgooU/QreRrn2TnbpBIIVbhlCTk2ZS+ivEiSI58xNb6DGJ2GOVNlsuMAMgVyBE63A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 06:33:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Wed, 18 Jan 2023
 06:33:12 +0000
Message-ID: <be4549eb-41aa-6858-ab6f-117abb5fdae9@siemens.com>
Date: Wed, 18 Jan 2023 07:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH 1/1] only copy "A" version of rootfs part
 for ab-rootfs
Content-Language: en-US
To: cip-dev@lists.cip-project.org
References: <20230117170435.4exyxyedtpskiejs@cosmos>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230117170435.4exyxyedtpskiejs@cosmos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: fb48746e-c9a5-46fd-8b5e-08daf91ddf8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	23RlRYV20CiI+zQgLtzuBWRMedZSO3LEvQaKZImTRB1hpwJ42vbQW6cJv/SIoPGQ9V6lFtxzcC+6cL++OcI7NZGsRBwirebyWAZlp86yC4TIpeHKGzi7ergGSKHYoSrlBqY1sZxGY8XbsMlTHBkVcsTyG3+ImjsMJzMmtmBDA8mW7WC5kaK+HuuURVtkUjrMJqsJZOdLXDGalP1pnSc74lo7gisFN0V+HEIjFeYXTRaitPGTSGS+wWvhO8OqdXetsk+4mOjAf3N/IZlnENF+OnSeJqiITt+A9HfaCcUvRUjnXdexDQxt/293z6JfIdsR17UhbBGZ28dF2cQuBe3cNx50SJjtLdphzId1p/tWgTkuDp6N+4nUff1jtRBbzgwfEdsRJtG0vroxqthp1i9/ZIvbnDaDjh/d91lKGjOhSp1ewL/GWjZtUHjVaydIg6ZqBPBT0+xKl1SwDuqO0seAIv9idSWA6inourzFkm0shAl+0LID5DvRmHgnedwPFgHtTVJplkZ7z4WewPE9qVdzusbWd5hBR/dOzQ82ZHEzfE3zy5gwyDYjv4Gid0YjAx/8Ck0LIe0h3VKZmolUEWl9oG/QfLCWpv6AuhZ2owhgrZL6QfNUk5wF+7T0+vBfSZ4AkFOcdywxpFbCNvSrk5LMi5tU0jyBHTtPtdXUCy0H2OBULVGSbt1DQohcZDI5lLrWzA7Wl6buMj6z1vu4LBl2s2rDRIu1jMp7erF3Ciaen+0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(8936002)(31686004)(82960400001)(6486002)(44832011)(5660300002)(66556008)(26005)(53546011)(41300700001)(31696002)(8676002)(66946007)(66476007)(36756003)(2906002)(316002)(86362001)(6916009)(478600001)(38100700002)(6506007)(6512007)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SlZcRfV9dESTOTE1QoaD9H3rNKCaHpE4zmDdmCa/iGZb3i3uHqume1DSESUa?=
 =?us-ascii?Q?mvy15jb02FTrrIKrV7GutjEgPMQPCC/h9G3BpQDjds/zDKQYdxMe5DBSUUUs?=
 =?us-ascii?Q?b+05FlieCUF9iTv8eBsgbxdxXPOCze2EnGSCfxNLck1MT/uW/To5ZUgrem7n?=
 =?us-ascii?Q?j4FuuLFkc+qG8y0gmN37BWbWwQSlGd0xdgU1PY55RuHyjFfhI2Clv0nWwNKs?=
 =?us-ascii?Q?poJ92dB9utSJyEHAdyQ2KUqvR7eSpr6VhHESdO9gtDt8XxbHvR4scfEaYiTc?=
 =?us-ascii?Q?QZ+mvd4wg6XdTWw8PQ+9zYpHyhAlaNUd+8uGlYKojR0pXDZ3qf81lbCIh1sC?=
 =?us-ascii?Q?Us8Yr5BY0LWES6J3GqhRhD99f7HhRHI1QgkquU3HVfDjSzPcO1xMXJ4/YMq4?=
 =?us-ascii?Q?GOWUzERzxzWcw1TzKPCLykGr4vNqpKvn74hskROgdLVMczYrkVTgx1DMvAdS?=
 =?us-ascii?Q?FX/AZi9L6zZ+dh04q/qxMwCwwL7cC81iI34LLqMgHE3Uhu29XPZ96c96c94z?=
 =?us-ascii?Q?8otNFBdp2qavzG84k0lkhnh4hka50tqVLTJ6obGGlRmQ+zKfJdGZiSRRzsWJ?=
 =?us-ascii?Q?revnwJ+S1i8WGeoBKSzrNlBuY2fNGiYxvwl5l96FFbHiwt+USN+1tEotidDh?=
 =?us-ascii?Q?MOgMsYTnicQd5uOnWIF32fJ438jNgUk6DvE6wYzNa18Bfvzl6ooaxbjk0SJk?=
 =?us-ascii?Q?077R0Nifq3obi21s+073mpu3CYDuzjnuW68vZUuMMP69A7LgiahY0/NOT/3u?=
 =?us-ascii?Q?dA1bLR/xIRh2BiL++mj8S3o4lS83N8C1g/wOKOml/h81kjJtvrYK/omT7AiP?=
 =?us-ascii?Q?SYoGOCzJf/IoyhZ3VDXXUUBein3CR+SnXlI5PD3YJSnirXJZB1FkNTwihw4y?=
 =?us-ascii?Q?B+QsecugW61NyqQE1YB8nhpFrmE47/CJ9Kz1+zU1DK3kwgejk8HSi2zwAJJ5?=
 =?us-ascii?Q?Gm04DEMZSQNt0j8JzoEubcSAp2pZs+QpekpWumvz8FrrF+pMw10zBi8Nrb/A?=
 =?us-ascii?Q?3FWiL936gbvpYzO1xkgXqefqKFhS1wD1pM2+EXHVNaKhTim34uYrYBlQqoFL?=
 =?us-ascii?Q?CbXgxLGi7B9Pw+BwjJQ5+P8B7zpqFwo9hHTsTtt+nX5ecIqHrAeYd7JMJLiK?=
 =?us-ascii?Q?5DNGuJxzSfxsbsoAh6Q7YMHSNsprFZyIKwZpGsmxvTN/YdbKBc6lVMYBwep7?=
 =?us-ascii?Q?ZVUOHY2wU67NMzXpLBK6iH6C/eCPoCkzd8nGMCVQzVc7cqyD3x/roQm6BXpO?=
 =?us-ascii?Q?ez8JY58Hzwdd0ZZlaOLtDe+J+4vUXX/6vFf7EOITSpd3Sto6XtE0MLXrJX/R?=
 =?us-ascii?Q?tqxtFK4+CgdprMrBExbfrsa/IG36WpRwTZHC/rp54GrRSuWSxk4NqYcZNMZR?=
 =?us-ascii?Q?o6/z0JVnxp7tp92XLXlfYmlxIdLVUh9//E4DWSVJGN5IGXpjdaQGodEFlqqq?=
 =?us-ascii?Q?FwDreMMVRJEQ2Afj0kVRL/2nJy7LobYAIQWecm6K4P6zWsY9HA28FrFno1qv?=
 =?us-ascii?Q?0S2xux83ynEgi2peWqchUhvhkTUqzx+8EEV+CweO6EvEVEKhTCHSjNe0WmrA?=
 =?us-ascii?Q?gYSc3f0nMaDux/m3qVrhYmgr9VCaANtuPiQcVBdf940AWN78lInr//sruIlj?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb48746e-c9a5-46fd-8b5e-08daf91ddf8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 06:33:12.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPUViNG4JyMw1TfN/Z988LThkQlxoxKNgPjBh5ZglVLFMunp3TKQ/ggLOaAQibzJF9DJkyCM8iUCCehMz72rUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5857
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 06:33:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10381

On 17.01.23 18:04, Christian Storm wrote:
> Hi,
>=20
>> On 03.01.23 13:31, Felix Moessbauer wrote:
>>> For swupdate images, we currently copy the rootfs to both the A and the
>>> B partition. However, the content of the B rootfs will never be used, a=
s
>>> the first boot always chooses the A partition. And after an swupdate
>>> image update is performed, the content of the B version will be
>>> overwritten.
>>>
>>> By not copying the squashfs into the B partition, we can shrink the siz=
e
>>> of the initial image by half and also cut the flashing time in half.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>> [....]
>> Seems reasonable, but I might also forget right now the original idea
>> behind filling both - adding more folks to this discussion.
>=20
> The original idea was to have as much redundancy as possible and be able
> to use B in case A fails =E2=80=95 given a proper deployment and ability =
to
> switch over, though. A and B are initially identical. So, if you don't
> need this ability, then you can save the image space occupied by a not
> used B, or sync over A to the empty B slot on, e.g., first boot, to
> save the image space but still have this redundancy, accompanied by
> a "window of vulnerability" while B is not (fully) synchronized....

Then I don't see a need to keep this duplication, specifically as we
drop it anyway as soon as an update starts.

Applied to next.

Thanks,
Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


