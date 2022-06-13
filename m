Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188E1C43334
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 10:00:46 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.42])
 by mx.groups.io with SMTP id smtpd.web12.4016.1655114438035509474
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jun 2022 03:00:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X3AD4iLs;
 spf=pass (domain: siemens.com, ip: 40.107.20.42,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUwiHK0xrzQ37VCmK4u5z9L1S/ABuP9MRLUXkkhNeXxi0Aq8sjkZqBB1e4ATtwhlLWAFLwsfu4bWcyjQdabC/QQee6fAahoYpKxvqmMoaMfuZokIouHDPri7wmEJcUq4Dh1Hw+H6WiDX55ZstJgJuMn+03Be5d34ZfGKbptKARss+RHOEWoE4jr8o7ukLy/DKTN5Z3w3vz4ZSoIdBs0cYz6DYjKEY5gMIxjj+nzfSjWud8mazcrSjMhIo+DPiUzhvIxcslwMJHacyrXI0fJNiPvl+6e8azg0Uqqfw+rCB7GNXmr0I72Ke3hVcTEPsAZkGTcBVlVn3XrCVj9Bs0h9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6y34+eHFTxTckIltwc2qroQ/GGsaKU5LwkQwUj81Gs=;
 b=kgMUSf+inRj1tlNyprSKFq9zJVQRhOTkLHW3HsA1FQq9PpPmwkILy0KkvfGHliz3JGhlWh+fGix9oFioYtQND+J0hYsi1NyRCbK8fFPcmTbXcrlDV4c199DMpgYk72UONtzob8iv+pyzJj1cn9zy/V6A3bTnPdmWFF7n0f5AOrrjmoIHINdaCCSBXn/6iseK7j9MX/ZnUMvC7gm+TzXOySxMADwnzvlF527yHJ9LnWhHQtGh+tVg8QGyaBooo2njYxZGHslttSwXaPAM7DeSsStX9PBSpKdc8Hu9h1UERF/1k7yBD8zLPnm4O9HB0Iw8vqo+xE+rYcJ21NYda+BFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6y34+eHFTxTckIltwc2qroQ/GGsaKU5LwkQwUj81Gs=;
 b=X3AD4iLsu9Qon6w8nOWGfgYMP6LbPi2HokDoUSRgFnOQvEBpW9WJrJDfpfyFfJdexBR0bLzVG/hTXg+vOaVOC1DYhk1UFrQM9xK5c4FWZIIzeztDUPHPCvR3Ui40KRxhq10Nk3XvD9wKS2ljCoOt/oB482YvOm8P4KvY2XJTuhBGJPzZI6DHp60rZz1F3nO7+whAQggDr8X2wfnMriD/YdjXrBOLV3w+dTmiYISJTqEkOf49WxTx+1fAzMTcIdFf/AlyCqNk/74QHJFvBIHBFh9oVtOeuGn7aR6t+LjwzbXvYjJ+VE+FuoCTFJYKji8HFyi5iXOLUKXrqiMD42JjBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAXPR10MB4932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:202::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Mon, 13 Jun
 2022 10:00:35 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::466:c3c0:acce:4c1f]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::466:c3c0:acce:4c1f%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 10:00:35 +0000
Message-ID: <cff04e5a-4cfb-3b79-b2e3-941defbcb4ce@siemens.com>
Date: Mon, 13 Jun 2022 12:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] .gitlabci: add qemu-arm64
 secureboot and swupdate
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
 <20220610072524.910925-2-Quirin.Gylstorff@siemens.com>
 <de736daf-c94a-55dd-7f1b-bf0a284af6e7@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <de736daf-c94a-55dd-7f1b-bf0a284af6e7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0066.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::43) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75ad4471-6bbf-416a-db69-08da4d238f84
X-MS-TrafficTypeDiagnostic: PAXPR10MB4932:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB493215F329050F1A7F81380581AB9@PAXPR10MB4932.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	guBPxbv1R+rAbWa6ANG/YMuSwyqji4V3Ddk/LgLWeDWtdSQfcal5IsmXV0+pWpPM+QMuJ9UIhHwggeiXruU887o5jN1krZBZgO4E2rwTxJRB4s2Idp2Or+cgWfGsCdibeA6oogjNWPLFpmCM0319jJlLjxiWC9DMQnbKTA/TgfGjMgauP7MWZmHTBsIFOEL0FDuuoAocMZ/20cbWgJxkPI2+5W39nXjqnD9smu/ZxCbA5r/sJmyOAh1TPGrpaMTOqhxmWPf+Bvc1Ru69ZiHwgVVFgr+nchKUnrJawGaHjjQEpMAiYgj4Bg6i4QJ5ODgZhz2nKZtcVIrcAWejb2D+n+xEaRK1ZvN38n/K9bNgQsdG7nPz37M4x/spnaarudA3l9rwRfqSRIj2D/vtZJjjQsnji+Q7ZshDbnRkpkbzK5ymsPsQeuYiEbZbE3io7Vmvp8S9/Qe8l2L4pFDJ8y195WbKDuBG20KrsvmeFx/CHBEjyHLSsMDPBQQyCQwzFD8mCr5aTH1vsyrf2BFUkdUBS8Mw3d6QPaFZ3IYqg8Yb4k2MT1qKEbVvOi9ytjHaO6bd5SKiqvumbRUc3YtALPQ0++dnZE1ktF/uN3fLR5oY2PJqV6LMlDyXp4/JKEq0hUrBsVk8C1HMdHxcQ8vrDfQqDqgAEXKgSFfbKvfm6bniqLvl0KgL1jD1UDMgBA9w2kHcW5Q2OZoDJr586LxZzvqBMhDzCPludj0DEvBmkCmhPo0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(83380400001)(6512007)(186003)(53546011)(316002)(26005)(6506007)(36916002)(31686004)(36756003)(5660300002)(2906002)(8676002)(508600001)(66556008)(86362001)(8936002)(6486002)(82960400001)(38100700002)(66946007)(66476007)(31696002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVpjR1FMbjNvTGcvV3g1T0ZXUWpZV0dnaGh6ZjJhelpueVRVVkErZFBBcUd0?=
 =?utf-8?B?NjBTNDZFeTdtTmlyOTdSekZOTnAvVUVrWGZMcmluaVpnMkdTMDgzQXJVNFY2?=
 =?utf-8?B?dWErTzF6clpDemUyK0RvaENWYjJYOVVJdGdYV05JZ0lCV3FmeWU5QmtGN3pQ?=
 =?utf-8?B?TkVBVTJjUlp1bWlLdkVXZEVGaGg5RWVLQzQyTjhoYkF4VEtIMFl4eTlIbWx1?=
 =?utf-8?B?QUtVVGQvMWZSUWNCazJNeHc1SkMrZUpNcXRBd2M2clk5SGk5WTZJK0RtRXVR?=
 =?utf-8?B?dkNQQlJQcUwwSTA2cGV2TC9Jb1VvQ1JzdHNVUEpJL2R4a0NyS0s2NnZrRE4w?=
 =?utf-8?B?cmFkTkgzbjhEcERMbG82TnZ4SzhYWTFteHo0SVdneVlHQmhMdHdWWHpBUnhH?=
 =?utf-8?B?UVAyMzJPSjRBZUdqdHVvZ0I2SXdBUXk4dnpGQ2NvbmRHSjMyb0o2UmRRd3ll?=
 =?utf-8?B?MzMrY0N5bHFoYTlBUnRnTFg1WVdJbUVRdG5oZ0hBdE9uMUtVRzJONC93TEdD?=
 =?utf-8?B?Zm54MFZwVzNQZmhNUWtkdkIzU0FCYlpMTDV4a3lpQ0dpY2dNUjhvRVpKTjZk?=
 =?utf-8?B?cEFvMjREakMrTnhxUnBDRUt4dzJSUmV0WEhVdnpPb0tUQ3FxNXRGQVh6S2FR?=
 =?utf-8?B?ZndWOGFuemtNOE9QTGh2VHJrRXFKY29kOXNDTVVvc0JKMlRDdFM0RWZjQkNj?=
 =?utf-8?B?ckJneE5UcGw1d09lT0hnTDVUV2J4Y3NHY2UzWEJqdG5Id2MyODhjdGRJUnNx?=
 =?utf-8?B?ZmIrcHNsWTVsTkErZFhEdFdJVVhCRjlkeCtsa2JZblNxRG5NNG4waDd5clBp?=
 =?utf-8?B?L3VPcW9CWVZBUTNacWpIRHB5RWVBelFsRXN1K3A4bTdQcmtXM2NlU2hWaEhR?=
 =?utf-8?B?SXFXbm5jNDlsWWRuQTZ4eWcvZHJFWW1Vam1BYlNzVTJIak83dDZYRU1mTXRS?=
 =?utf-8?B?T2g2aG5nOXhWbFJ0OExHUUpaaTV6ZllaWEc3amo4Z3AzUkY5eWRnQnNjQ3BZ?=
 =?utf-8?B?aE5zQ2Z5c1kxa0N5Z3JaV3hPUWQ2VjI5VFdyUTF6WE5lVU9zQnFUSzhsNjZa?=
 =?utf-8?B?NVBvS1c2aWZqendDZENYS3RsNnY4dnVpVE1aNzZVeEJ3QzVlMzZoVXEvMUQv?=
 =?utf-8?B?cnRMSHpoRDNkcWQ2TmhSSjdGRmcySHd5WjRuMEdpSUxybzdrQThLQm9xUnh0?=
 =?utf-8?B?TDhlZkQrL0YrcW5wN3Z2dkpuZ3NjZVRkL2FSaFlpUVlpYjM0aitzWVQ3S0Nk?=
 =?utf-8?B?aGt0czdOa0ptQjJBbGdhNURZRTBna25uVGViSlpOanhwWmhzVU1tMEZTTUNy?=
 =?utf-8?B?UWp0RXpxdnR6TmxsMnFIWlRkMzFRbFM5TzBSYW1CMVdod25XZFRDZitwRUVw?=
 =?utf-8?B?UGpZRWoybUJyQXY1Vkh1NW5yaURPc1NITUNUR3llOHJSSGE0TUhaOHhodFdW?=
 =?utf-8?B?NWJxSVZwY0FtaWM1b3ZCYzFkaGFXVG9zSHFCOFowcHBNODFtdHhEN28vcEJa?=
 =?utf-8?B?dWRENjZtclJVa2hxdVRmRnpLQy82UXdTbUJ2dk4waFNxb0N5cmlqV096bXBN?=
 =?utf-8?B?d2kxVWRwdXg2MTQwM2RucmdBcndOYm0yQTJRY3pBNzAvNFQxbVhwUm1pOXN2?=
 =?utf-8?B?SnUyNXZCU1VDTEExbjc4VFJRemNFTFYyc09TN05xNHRqMVh5c29VZy8vbmt4?=
 =?utf-8?B?TTZJdElEQUYrQ2h4QkZacWp1UGNNRzN0aFpleDNWQzdPUFVuOWQwY0RWa2xU?=
 =?utf-8?B?UFBQSm5xVFZRV1N0QldZd3A0SE5MTkFwOWRzTVBaTURWalFmNXExNVFlYlND?=
 =?utf-8?B?a05HMjRFV0t5cXJVbTh4eGhQa21XNGF1ZWJLeWlqaXNUQWJFV3ZoVDdPUjhZ?=
 =?utf-8?B?U29Mb2VFWkZFcHhOUVc3ekVHRzVMbXRqem9GVWc3RktHbXoxRE5sV0RLTkt1?=
 =?utf-8?B?RzNacEpJMUo5YTR3K042MUdxeXMrK1p4NXhuMnZNdDNHUndvc2d3cnozeE5L?=
 =?utf-8?B?c1JVZEJ6ajZCZks4N3BsSzlCWUYyVDBEdUVIVHYxQjJKc2cwU0ROR08vVzha?=
 =?utf-8?B?d0RHeGNyMmQxQUNFc2pIYS9Zb1NlS3V4NmpCemdvTTlNY20vQi9xcjJPSHlO?=
 =?utf-8?B?bEdmVzlyM0xMSVdMVTlVMjRMZjlOUHlnRjRMdXhCWUtrM2RUejcwU0ZkTEhD?=
 =?utf-8?B?MlpzTkhUWjhBaUIwb0VtTE5JT2kyaXhtc3RuZTBpN1VOMDFUbEhuSnczbTJh?=
 =?utf-8?B?Tm5rbit1OTBTbXNna2t4VS9lVU9jcUF6Y05aVU5GamUwUi9kbVovZENvVXpn?=
 =?utf-8?B?YUErZi9XTGVRZEZvaDhmZ01haVprUkM5L3hNZmRucnJRNStjUU5ESlpIZzdy?=
 =?utf-8?Q?gXyKeOR4wcvQ0pL4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 75ad4471-6bbf-416a-db69-08da4d238f84
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 10:00:35.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 XDW1DCDLiMWSuj+YeaSQVuBw17eAhBousUoysAgFkOymHPReamCaVDcBJFpZBAKOdkVuNTfRPbgWm7Kd+GnQ8tuchIIWjg0fSxzoADC/0fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 10:00:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8549



On 6/13/22 11:30, Jan Kiszka wrote:
> On 10.06.22 09:25, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 8545a66..23ab1cb 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -218,6 +218,29 @@ build:qemu-amd64-swupdate:
>>       targz: disable
>>       deploy: disable
>>   
>> +# secure boot images arm64
>> +build:qemu-arm64-secure-boot:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: qemu-arm64
>> +    extension: ebg-secure-boot-snakeoil
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    targz: disable
>> +    deploy: disable
>> +
>> +build:qemu-arm64-swupdate:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: qemu-arm64
>> +    extension: ebg-swu
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    targz: disable
>> +    deploy: disable
> 
> I think we can skip the second test. The non-secure build variant is
> already sufficiently covered by the x86 build, and the non-secure u-boot
> build for arm64 is not too special.
> 
> Jan

Ok, will send a v2.
> 
>> +
>>   # bullseye images
>>   build:simatic-ipc227e-bullseye:
>>     extends:
> 

Quirin




