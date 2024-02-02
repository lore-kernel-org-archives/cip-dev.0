Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F6FC48291
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 09:50:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.83])
 by mx.groups.io with SMTP id smtpd.web11.19425.1706867442571321449
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 01:50:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zbZShOl8;
 spf=pass (domain: siemens.com, ip: 40.107.22.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJcL/lOMPlleRqJqjrtpz6+nIufgrGQ3/XKaotsU9n05qVyAcjxYTnURH29EJQj8SFS6Qfmr8czbcjQdAwxQb37tiyuJWCxbRalG1xB4+TbgpdQL8FGc8dPvwUzA+x03iDltUFvh0DdZeBPhHekui3e6LSr5NbgwGoVwFgo8icLjZVo15xZqr/Hh5QDES+sqD5DAId+v2ZcDTsM10wa17W8TNAZXTgnVm1TQG7VLQItxTWje/rDiALOswEB/ASynk9Ch+7W1ODubIsswq9muKTy61AQjTxmAYcp3uBQxhUf9ixahNxpenYmtXo9weCj1hA6NE38qWYLPDZk193yUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZyxfx9FmPAx50N4Z+3a4qTEbPppaTSR4TI65rVUaoM=;
 b=YCnEeIKTM3wSG1s+1YVXIsPXDli2MhrZAakfkIckUpy6nMsBiuUhsGNiDna9Cj+CgeQ8HdHhW+OmdGptAqbp9eQ6U+ReYThpUsC9uRQNNXJm3gQEFGzymBK9qcFwVDkSAFsirC9xoFA4ah6DPsC8ZEGwIqvEdc0MMwm3FKXlePZBtvgS3gbXtKplxEQ/7PSzVGcZ0Hp2umtUja2gHtta9lkJjHVnvJuEBNKt3ywexn4ZQz1YbO1+r7hzb0R92EZeWwLlJ4IJvHbyxKcrvmx5kfKMVe2tUU8gch3HXXcs1OB5N1mMnowgZPFc1l2clYaUGlxwY+M+yYo/IfhQ1HRdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZyxfx9FmPAx50N4Z+3a4qTEbPppaTSR4TI65rVUaoM=;
 b=zbZShOl8D47OmfoR3fUOmjM2Yi9B9ZZiQ/0I1Yj03WYrV4KCTsD2uIGagGZVwBzu3G3l8xhGbtYfUBqscSF70CDSdS8/YQ4/0CfhZb0GViCXv9kOOn6ruXjdY28rT/WMpTUZRMkXFZqUvNUwgIHOEtY3m+EGKf3eyWYbQewqKbgP7vnbuNYRm+CrC6imQBqwIza2vzQtYipdXGkPFNZEiq/eGSQyZhPlgdW93bBa14UDQIprqEzULwmV8astD46/8MpAR2jKOYrll9RX0PiLg501FwCFNRen48SFzEzS8EgNSJJnDKLUFeuD5cV+DoGxL4/DjhHSkbxqiYi5osQUkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:518::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 09:50:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 09:50:38 +0000
Message-ID: <9eb92f4b-8bd9-4fd8-921c-e37966d2da39@siemens.com>
Date: Fri, 2 Feb 2024 10:50:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Glitch in isar-cip-core build
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <8bb73c06-6bcb-482a-bef5-7f45e8902c31@siemens.com>
 <582bb82b0bca7f4157fa9968ddbd9d7ee81a06ad.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <582bb82b0bca7f4157fa9968ddbd9d7ee81a06ad.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c08c852-b1df-49e8-ad85-08dc23d468cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O8wpY4Tcdsc2acrHK4nBpKcPC+W9IVSiMPM63c7dg7LxEKFBQL49v9tTprcCYrM3Pi8V5ur7XYFKIpKWLrJzNS8wd2UIn6FLwyydXhJ62H6R8q/rIyxnqB1/wNKzsyby4/5J0kBJR0KaMS3rt4xry+znUJFyi1itt42zHt4swwCqV5lQKCKQaN77i3dyGcb0d/GOQbk/8SZOUVIpVSs2AqpLO6jfCqwu0HyNOM34txe8ko9LIT3nEpvVurVN4hC0DE1T79nIOWEVr3fi8fMqZqWJ/aJEtUEwtJLgGZZFYNtqmtdvFFn3X/Y6jryPSZVLbr1ZwdvncFW9WuS4bkPfiSvmEVM0psEhXj59MVFGbMOnPC77+w9oOtnIbDyE97usulfdToBjKV17h1Ot76KQSWeu8KG2a97O7VhCkq75EWe26G0x5j89FFQPtNu/3j/dJ79e0qNUDFVN1actCdoZ8hHf/0Ftbw4xDP7VFsNiwLnNPJC9QbFrz+5IRz86hE15QO5EbIfYZWsGFQNkIe1LNY7lwS3IveHsJyYxU5vHZWC+eVoqjO4pL8NO9tnSah2jfFa8Uw2fHr3kRHkTS/8zzRb9t6SzmFnuHcTtOnV9hJJiPN88l6vzwiFpo56v88L3QatjUaZwhXGHe/X5ngpZTQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6636002)(316002)(110136005)(966005)(66946007)(478600001)(66476007)(6486002)(66556008)(8936002)(8676002)(6512007)(26005)(5660300002)(2616005)(53546011)(2906002)(6506007)(82960400001)(86362001)(36756003)(38100700002)(41300700001)(31696002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GIToCG/FrrS+/AVnZo1olivsN2UjVGoHnMrnuNZBR15/cRcG6L0wbimjBul2?=
 =?us-ascii?Q?GyFoxAmRWjrFwJs5f5nJUnmm7Kf8ZzZ4jsfTMEwrFalSYOcR/Yt3Ag9M7u+I?=
 =?us-ascii?Q?dXhwULYJ/NVhFLy0+f8TZ4W8D15XEj6umwOTwmA77a07alLj6/3wj7LBlILS?=
 =?us-ascii?Q?r0zSLmBhXt6+wnlc6jz9j+lIZuPr+KuqXxZdx3WJqE5O5uRm+H6urYKfU6yb?=
 =?us-ascii?Q?miVB342sw7TOgcILOFHYijOV0uYZPy9qCKsGRnrxr8ThVRoIq7yEH4/vm8AV?=
 =?us-ascii?Q?CrMCQRd18c9XVxgb1wb8UtoerWH4kr7vLhSSGBQfJjSq14GnoElQ10Y/naC6?=
 =?us-ascii?Q?C8H1nUAiL5xg+xtTkKYQ/GCAFlhRaBuOMszQbz1WyWxji89PwzZlGs1mIiGN?=
 =?us-ascii?Q?wJcFrO6xJmKt8UzS7zyCxITw9KsO+fdowqndaJEYvzFzxGpVQ2XjkZpjIRyI?=
 =?us-ascii?Q?pRti792irAlFPYChyjayQLBIooll06iv3jUZGj8W7e8FAEbekEHdg8C4pQou?=
 =?us-ascii?Q?zib7CthSgw+6sXvmEE3lI6w2TBw9LoGn+osxU8Py50hYeizp/zZyABqe7ZtF?=
 =?us-ascii?Q?MQ4dG14rbxU9YNvhVXTtQJDHI/OuL2tOZ2SCgeoPw2a3mqkKLvPBjdeJOvqK?=
 =?us-ascii?Q?qMTEpLSL3P6EdGeDbFuvpXguBkYuRPwqD5+ROp0gj1+RdBI2xoywQCGWQD5V?=
 =?us-ascii?Q?ogyW/cFVOiIO/u+0opT4f8K5MEltXMkeP7HDM1A23MAXuGFn4AX/PKA2Z+/v?=
 =?us-ascii?Q?U7LXWNK5eAWyWAF6zdh2LFeopRMHzpCBaxS0KjuaLjSz/Pd8PSC0LxunNcsd?=
 =?us-ascii?Q?Ts5aq4UgY09VzmlDNwNtn3jzlANA6kI87WosXRS0w6ZpPb6x/Zf6RemRUOPp?=
 =?us-ascii?Q?UOMchHvGdBaGblDmAlUrakSUR+QCKU8kJUtWhvnrcQ0DRaTsQg5PCW5OdQ2H?=
 =?us-ascii?Q?YG41VfdW/+JuEnLBGUPTd3IdJbKX8QSrJxRia6gO+7D9XwS+5CC9bHz6chZx?=
 =?us-ascii?Q?ZoYI18pJXNtfIGFPUqR5pwFgq8nEewxRlncEprs2rMQ4ZF4SR3uGvY/oOkQd?=
 =?us-ascii?Q?suwJ3ug+tBSGhI8LGgnK5JjuYUQJg0m+eT2NuthwFrdMpqXTeT0ujZzwlJJc?=
 =?us-ascii?Q?2/sUnijph7ziTNyMjq0/zHHl2AmCJLUk7P36lI1HpVbJLLFIIZS3D+VSFJpN?=
 =?us-ascii?Q?ntaoC38Vqn17BkSgiHz+WcUk6l5A35lI/7BwmBJQi215ir/z2GRuJFabB0qn?=
 =?us-ascii?Q?SJcoh4niwbe7//ndHLm4alMTG2Ddvfou3t374gCVjmmei+0R9jUDuw/pLqBv?=
 =?us-ascii?Q?2SVsPJyoPEskIeKFjKrMV7iOIdDIfOleRQGorDNOrlp+uJ06RYGK9EhjBsYn?=
 =?us-ascii?Q?xg1tyQh+PE2z3U/044UIcWZzwHKKVVSKMZvnS3v/4dyOQIM8anEID3DVy4Fw?=
 =?us-ascii?Q?p6yggtBATVsoqfeUQUNqP7/Qe5qVrVyyXPTskIgQuslmNiyvDvtcvu/hUHA1?=
 =?us-ascii?Q?rwTt6u5mJTItss9t7Rur7Q4o1Jo+N7UUZxo9BDvFgwYCs3uDt/gZg5OeGwMo?=
 =?us-ascii?Q?iEmmYQXFR4bvl3PwlYJ53huH0qDtpDyW3eRr4zbpVktk8+ttqHdzxUpxZZdS?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c08c852-b1df-49e8-ad85-08dc23d468cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 09:50:37.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbdLu3zv08eUqftcxYVbjRDYvZkKEYhpew0bXNMO8l5oV10ksCXAwIe8e2P992u/uSf4amVK2ZpqTkNiW6J2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5917
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 09:50:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14605

On 02.02.24 10:07, Moessbauer, Felix (T CED OES-DE) wrote:
> On Fri, 2024-02-02 at 09:47 +0100, Jan Kiszka wrote:
>> Hi all,
>>
>> was about to tag the release, but now this:
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/6079744871
>>
>> 2024-02-02 06:30:45 - ERROR=C2=A0=C2=A0=C2=A0 - ERROR: Task (/builds/cip=
-
>> project/cip-core/isar-cip-core/build/../recipes-core/home-fs/home-
>> fs_0.1.bb:do_dpkg_build) failed with exit code '1'
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - Log data follows:
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | DEBUG: Executing =
python function
>> sstate_task_prefunc
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | DEBUG: Python fun=
ction
>> sstate_task_prefunc finished
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | DEBUG: Executing =
python function
>> do_dpkg_build
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | DEBUG: Executing =
shell function
>> schroot_create_configs
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | DEBUG: Shell func=
tion
>> schroot_create_configs finished
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | DEBUG: Executing =
shell function
>> dpkg_runbuild
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | sbuild (Debian sb=
uild) 0.85.0 (04
>> January 2023) on runner-wjyrh54g-project-10191315-concurrent-19-
>> od3c74bz
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - |
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - |
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | | home-fs 0.1
>> (amd64)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Fri, 02 Feb 2024 06:30:44 +0000 |
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - |
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - |
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Package: home-fs
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Version: 0.1
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Source Version: 0=
.1
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Distribution: isa=
r
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Machine Architect=
ure: amd64
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Host Architecture=
: amd64
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Build Architectur=
e: amd64
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Build Profiles: c=
ross
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Build Type: binar=
y
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - |
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | E: /var/lib/schro=
ot/session/isar-
>> builder-6dae8870-44f8-4bab-a37d-8801811b384b-19385-33c2924e-dffa-
>> 4784-a2b9-07c7ab49096d: Failed to stat file: No such file or
>> directory
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | E: Failed to crea=
te build
>> directory /var/lib/sbuild
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | Failed to set up =
chroot
>> 2024-02-02 06:30:45 - INFO=C2=A0=C2=A0=C2=A0=C2=A0 - | E: Error creating=
 chroot session:
>> skipping home-fs
>>
>> Likely nothing new, rather something rare, but still: Anyone any
>> idea?=20
>=20
> I never saw this before. Could it be, that we temporarily ran out of
> disk space. Did a retry of that job help?
>=20

Yes, it did.

I don't think this is some out-of-space error, rather some setup race.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


