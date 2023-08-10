Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DBC001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 12:24:56 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.81])
 by mx.groups.io with SMTP id smtpd.web10.15737.1691670293235927686
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 05:24:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=B2+vZv7H;
 spf=pass (domain: siemens.com, ip: 40.107.8.81, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJogNEkCudTU5IrjHuAR4w8ZaCx+J184CD2OWfnTSiXbz2ADyTUci2evY0REAFKa8nwUjajEjKxX+8MzwGKuCwXKMLyPra+C1l+XEhTawE0+OhTl87lO5VJXrvowL/S1jF2CuJ7CUZHTDPlMiu2XLd5EvFhB3xfKKVCA5qC4DT/Mylhqps7E6Lf7fTnacUtTMjMwWZSf9ZzyUdLU4fS1g+rvDQG3aJeAAsY/7pu3P/+0bZEE8A7IkgC+tG7B3XExon7/UT5X2H5vnNAa0QDKexRPoeVA7J2fIwyFXfP3dmSvPb1tMJdqEj+U2+CYIeFJZXLDy1bZT172MRvFR7Q5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNEzNX8O+zl1HPrUezhfO0qhvIW9/FIh4K/UN+VuXW0=;
 b=ofkSVkjlDRuLGLc8lfjsr7k1v1gDnIgtw4STWULVOsdexN1bLYPL4pLOV8ksc9IMMAswsUB2NbUvwJtFdCL7S/56s6vKe9XAsiGckJQFcSWIKyVWSSv2fJqAE77I9AMoly+AIn6bARJLhthZKkHmPczMaS48m8C2JwWpx31HR+a9bALBQGBEQ59OIaMf2C90QT7ONOfCJUBQT8Jdb6iec00AiytUkaew5AHztLd61hyC4gkhjS6hYQMLi/BXZJ4rHva1ulIYLIpvgKvF7mV8e98lVRg1fhPjobAmV1DuGKht6oCc3b9utpmPBtLvCOFMuU7w4PWvmnEWZondryQbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNEzNX8O+zl1HPrUezhfO0qhvIW9/FIh4K/UN+VuXW0=;
 b=B2+vZv7HZZW7DtIC8LUvFxELw8MEqFB/40t/oGXPVRAkugSD8NEZ6sFJvnU6QyPJ9ubf6N+Za8qdQenoYUxT2u7hwHbV5+UI3/CH7WaFg7U7Ne8/JsMLa5o8zwjbBjwswngmRFBvpA0XYiqZSJSEK4gWByc7nLts1RZDfRmRyAONqkySgXAdNjPas4x1P1TGZj54yU/k304ojP2DLXxwIfL1bLvqck2NYmJxRuQN98DvHeVI8iVe5ANDUtPsPd1XuZuY7sqjGmu+7y+2vSc4ls2MJmOQfSSMTrha+RRozm11lQA+OpsI2YN957bBwa6HNg35l0ZIf/npIhOZ8f9Q1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB6199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:24:49 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:24:49 +0000
Message-ID: <0f9a1c76-82e5-beea-76dd-b32b8a995e61@siemens.com>
Date: Thu, 10 Aug 2023 14:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate-handler: Add default
 config to fix u-boot build
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 "Moessbauer, Felix (T RDA IOT SES-DE)" <felix.moessbauer@siemens.com>
References: <20230803102401.564807-1-Quirin.Gylstorff@siemens.com>
 <674bbcf8-8246-4faf-b80b-f5f672315492@siemens.com>
 <81ca5a8d-4b57-c71f-651d-fd5e01176661@siemens.com>
 <73ae4d03-8556-4b9f-87a5-17b7302108d9@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <73ae4d03-8556-4b9f-87a5-17b7302108d9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4ded0c-aaa9-4d3c-4665-08db999cca91
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RhBgTW1Ip8z5yHQgQCHlnbvXECD1C/7PWq8Rh6FTI9NOJhgBwqTy2VERui0tdgw6nEvqRI9lnAQa5tCxWfVKxCP/NNmDyhKj64D7dR7g0+8pqvhteqmWymKP01M7bsd1LuStMXNvf7S7zZ3yIZY04zdpAB+uAjimfQpnmPOkNYeAis7R6zLrGyhXuiQbTdPyR++Z870DjbciN11f51jAi4+x2ssAtaePoIlW9R4GxWf81eOIu8FPNGjojWY8XbIMuUEeGtrTRxfrzYmb07YgaLUuwXouoVzq3s74JSD3231mndUenesH4tlqRx2bODSZr0++D8xrFCp14aR+/zksmmcdlfNJEFefPEcMKGhij0dPdkGn8IR5m/sgW88M1jVN12GFhwx/eq7AzrIcOXsNerqxoawnfJBxssDScCoU7y2OGMS6lgwBisXz7LthvyhL4LOkZjX1ZcJWK7x+60z83mM42qvDhZITSuxKhliUoOz+y1WRKikL1hK57gJcz9uJQwgQViFPAGVSMAYFfbVJJsSpvi0GcV7e+SYpfBeBfq5EWk/d9Un4BGWpwjGtdza/k0x+FZxY7O/J7GnjL0MQ6mTTlCx8SgPDdAs6aM3TLAKEv3oSVaqe20pXL12MpRjnQQLBPKhQGUO75FB5FKxLbA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(1800799006)(451199021)(186006)(5660300002)(8676002)(41300700001)(8936002)(316002)(6636002)(66556008)(66476007)(66946007)(31686004)(6512007)(478600001)(31696002)(86362001)(2906002)(6486002)(6666004)(82960400001)(6506007)(53546011)(36756003)(26005)(83380400001)(110136005)(38100700002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UP1w+vm7V/crxZe777I+f4s/peUJur1T3QN0Q4nlSGrUiP/MwnDyQWXzWri/?=
 =?us-ascii?Q?6/RkdISU4N7GFzM7FSrpg5k0y5TvYwsNrACQVQqZ+PY3Xs+UGZFHZLkK+hYp?=
 =?us-ascii?Q?fTUV8Tzed2r7rNxf6H0EXlGx3K4CHpmMdrnymy/9Ux0+u4m5lyO9UXa/BEHR?=
 =?us-ascii?Q?35RmFHCFq1x1KOSVrZPr1TLuJu1IKt1NTaPB1dS3y/5V6fNLY4wIfSf6dtNl?=
 =?us-ascii?Q?q45XjXLOehz5RdOfiPwzgbuZgSeHfp9uAHC8ryodXZ3ddMiowLQ6or6f2H1t?=
 =?us-ascii?Q?Wiijx/5xga+bUQl/Oj+veRDjYBwYz0pCtF4M3+wQgejNMpt95Hrt0G/Z4o6f?=
 =?us-ascii?Q?iugfQLqPYHdmkjCVWkhBSw5yceSQxyzyVxHy7zBAP19+MGm9L1qBalUpNJBl?=
 =?us-ascii?Q?2dSuVLczZjVYq2S2U5cRFxm0HNe3K8T5skz0G5UTCmXzETlBp+ttJShAGZK+?=
 =?us-ascii?Q?iXrk3pmGXl7nwxAJeo7wMHDTQE99FyM+dd3oTA7kPqYlXCe79cPZuQuDr33n?=
 =?us-ascii?Q?aOhrfJ4VEaJ/aYojIfKv+C1ss5GuqfYoV7NyJmOm8CE0QZ5X3LUy9u595pGu?=
 =?us-ascii?Q?cBFD+6Kilvu786wnRhFVUzMapZ85/gdGuv+lb0az5VITAAlt1PLZ+UaYGo+E?=
 =?us-ascii?Q?fbSvUZboPnaUXSVlUeTSE/3NBUbA4d9DHnHecmV3zmZMNQjCfDemdRKeqwJK?=
 =?us-ascii?Q?A74glndrBJRAOojLcc1kAcJXWHWo2UZt4ebOAV/I7uFt8/scoeF6ulee5G59?=
 =?us-ascii?Q?hsIlruzHJM2k+akUgyFFHYDJ85NmLyj/j1ftNBOF9/5u0QlHdXksoGk80LfB?=
 =?us-ascii?Q?mrVFFz+my5gM21SHcqSJGwuc8cvGmhBAUZC+8UepshT1Za9ZfEGssh25KopD?=
 =?us-ascii?Q?GWISwEEQ4wkJiwybwscZmkLVVYPTuMuiHy8pH1uHS2QIVodeD99CtZ0UZY5n?=
 =?us-ascii?Q?26RcAFYeoA+nKLyiUaZ9jsbCbrdMfUIk0lvF3r8XRHZ5Th9mgvm9PCRDvCJ7?=
 =?us-ascii?Q?mMYVm90GJpXVaQWazS3asAnWl6zJBwhpBnNSHf9olA7wWHWkxhhksnpNKerT?=
 =?us-ascii?Q?oOJan4anOQGW8CoDgcACxC4X8SfOM6GkP7JS5JHJl/62CEXvx9kQWKiF8RlU?=
 =?us-ascii?Q?0vFuCSu/u9ZF6XT64Dx9rZOw9gZnPjU3gXOUcbdLkGT2ksPD+UVWhhuUHpEJ?=
 =?us-ascii?Q?1vZJ7RWLZihhgLLMXgrC/0bxVoT9PKVeXrhkjUw2sKHz8Qy+jAfEgzJ7T38Y?=
 =?us-ascii?Q?cV5fJpzbtQAPMqE/P1KwrS3ZnmuD39HpkuFtmlJXkwxA0FhSIo2KiJF2nyl3?=
 =?us-ascii?Q?9LQP4TiY5hOc0tTg64afO9t5ECYfPKNBZQSkkDJRuWSBV7EB1GdpQgHclxDq?=
 =?us-ascii?Q?KM+cBH1dQrvT/7TeXNi0W7g0V33bzPiAECYIWzQtgNfdnPIdyMqTJcupEk4b?=
 =?us-ascii?Q?+JUKq/Ts5J+VSEe4+pVcYW4aBFccCNq857uZNk0XZwx0kgP2gybO04BObWk4?=
 =?us-ascii?Q?ubG4GZ+v0wTagG39f33N/74r/YujxwTZm593J/sQ1rP4uyc7oP5hCJ001ubO?=
 =?us-ascii?Q?u2kTXMr1HmxFxTxY+lNhLd1i8Gfbz4vXkB8JNZG1ToQO8qAzka6LN21hZpzQ?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4ded0c-aaa9-4d3c-4665-08db999cca91
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:24:49.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDc6wZVzy5J2dyefg5bfAN5Z8+96GNwfrNIEwUUGGbiF0ErXnEpnoECF+6ozEULDSGRoA+tdvBKfB3XmpUCj5qTIaMzuLovmWDwMzB+Szlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6199
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 12:24:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12604



On 8/10/23 13:36, Jan Kiszka wrote:
> On 10.08.23 13:26, Gylstorff Quirin wrote:
>>
>>
>> On 8/10/23 13:01, Jan Kiszka wrote:
>>> On 03.08.23 12:24, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This adds the missing configuration file to allow to build with u-boot
>>>> as the boot selector.
>>>>
>>>> It uses the getroot mechanism from SWUpdate to select the update
>>>> partition.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> CC: felix.moessbauer@siemens.com
>>>> TO: jan.kiszka@siemens.com
>>>>
>>>>  =C2=A0 .../files/swupdate.handler.u-boot.ini=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 ++++++++++
>>>>  =C2=A0 1 file changed, 10 insertions(+)
>>>>  =C2=A0 create mode 100644
>>>> recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot=
.ini
>>>>
>>>> diff --git
>>>> a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-bo=
ot.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-=
boot.ini
>>>> new file mode 100644
>>>> index 0000000..0e6df08
>>>> --- /dev/null
>>>> +++
>>>> b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-bo=
ot.ini
>>>> @@ -0,0 +1,10 @@
>>>> +[image]
>>>> +chainhandler=3Draw
>>>> +
>>>> +[image.selector]
>>>> +method=3Dgetroot_rrmap
>>>> +[kernel]
>>>> +chainhandler=3Drawfile
>>>> +
>>>> +[kernel.selector]
>>>> +method=3Dgetroot_rrmap
>>>
>>> This is not being stressed by isar-cip-core, is it? Do we plan to add a
>>> target that uses legacy u-boot script-based a/b switching?
>>
>> I had one request by downstream for supporting u-boot with suwpdate from
>> cip-core.
>>
>> Without this file the swupdate-helper will not build if U-Boot was
>> selected as the bootloader.
>>
>> If there is no plans for legacy u-boot a/b switching I would propose to
>> remove the u-boot code from the swupdate FSTYPE.
>=20
> Well, if there is more than one request for that feature and adding this
> file here would be the only reason for downstreams to override our
> swupdate-handler-roundrobin recipe, we can take that (as "not tested").
>=20
> How would the situation change if we get the handler merged into
> swupdate upstream?

The handler it self currently doesn't provide any default configuration.
So it could also fail.

Quirin

