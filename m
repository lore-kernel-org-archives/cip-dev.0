Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1CDC7EE23
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 07:27:08 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.66])
 by mx.groups.io with SMTP id smtpd.web10.15881.1684826824628007752
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 00:27:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZT4EUyAE;
 spf=pass (domain: siemens.com, ip: 40.107.104.66, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji7WHFuImdgWTe7U0GlKlAWfPLn+TFkkt37pu/ERex+cJXlIJaRwrUtP28hSjg0dyVRnwG3gHkGl2EY5ZZi+dERFUqLEjreHbtcS6orizX1YTUJRReNWBB5wucfiUppxjV6kB5nRC/U3nk+eyKOuR0bg5uv6Lh8TLWvF0qAjEVL9MFu3Fh+VC167D1YH7hqn/pQ3/uTXD2k7lzkZQbMQUIV3nkRbaqeb4oOWSLRKmmqhT9Tv5++rNN0N8IiGbprtdGe3Vo0MnK3BFnaCKsXAwrcJiN/2CT+Te0e4xtXVFluuoMHlmJoRpNWP6eLSgh7BcDImDGbqII9XqZWuM/euKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuiVK80unqv5U5OoRTYBgpyEk11XWUDp2EltxIOVV3w=;
 b=Pb2nrBu4kQ0HOENQTNI7zrJhjkjD8GBIMrAyFjecQhZrfCeZPDRzGlRxodkfd9UciAZ6zuyFkX1G3EI6rj0lmiJuT/GwPCo+q69vUxNQp/FJ9Ynd57f53BaBbu89SDV2K6x6xfOtKEP7M2Txh6jfVTakI9bdIKozMgxlkSCOLKehAEoh7Q7zuhEHJm6JsYcbp9wTwZqvi7lfektl2/sQIVRg9XoXvCswaRJV/Lu3SgSQUXi6FtujM7TYlMR/RS3fUswkGKVSit6QiA7pJ00kNMEDD3o3X5Ywp3hr/z5z5BmFipeb3lfyuRzzj8sUZw7xBgzrqEShCWMJRgkaaibjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuiVK80unqv5U5OoRTYBgpyEk11XWUDp2EltxIOVV3w=;
 b=ZT4EUyAEt7ULb2O9rVgtzSQXFCDrXaufA9H6FR5FBkpD4rM8QzMF39uUmBdDTUNR2Y+xvpc/7oFjon5DxnXJzh4r72uxR08wji3hagDp5jx/ZcP1XM8vJ7vAycwUZ/bXluB8Qh2xbWzkfQ5Z3+qQigMYjpFqj9oDcG4xy4wzJEIfyYX7NvTZGkgJKN3oo2CX7J2kMacYRdwKZE7mGP5pnrRXTzGrp5v4qh1Fy5KP57tvCta0NUU1wo6D1LxM7vOJgnr5AsIxKGM0/XaDRdB6uUbKUwHEj8N+dg197H8ga45UGwtjNjqlQaZ7UwiS/Ia5sdQ942ZGEj+8luE865vKgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA4PR10MB5778.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:27:01 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 07:27:01 +0000
Message-ID: <3abe43e2-ffbd-5add-8d92-d778d506a57a@siemens.com>
Date: Tue, 23 May 2023 09:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [isar-cip-core][PATCH 0/3] Various fixes in SB workflow and docs
Content-Language: en-US, de-DE
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, meng.ding@siemens.com, chengshu.mou@siemens.com
References: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA4PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 947133f2-b368-4a18-d02f-08db5b5f19c2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rT8NNfAdKiQ8S+Cu+kIzr8YVJz/IJ2kiSbaWhqF4Bb9rHmA9YNu1+R+jpNWWIY4iPv8LIqwK24aU5QtkbMjA6+sIMYHhqBHxXLMrp32AOxo55HHKr3VIZchnphJ0UIqrTeUTkpCSpxOg7X0pJQ9uCs0ZrKvaoudb0W40VFVU6EX5w5KoVtRUFObD2yegNHCg5vxKNGGF3S2joATz6rxbYDRkLdnxVQ3Oq84DCjJP9Chh0CwKYCwXtdjiB/EiuNu5GMkbt8fEIPMn2ldBHfwHeQA4C2OrhkReMQd83P3odnaNZppUC7dRM7epwDKg57McZgYrVQh0hnNidyTv2Ls69qKvuU6+MTH5+xZhdnWHZdtwW3jS1nvDH57sicMmzs++E2oaFc3LpEUUQJkEC3Pl/JZIzgB78/Lu/Nqicin6B0MOKi+OiY4w6Tfk28FbZdjHRn4+xntLVSjBrKvSLEWYBSbOhpMwtKfWm0G7G1hDBDgptaJW4ZC/VZFZ8UFyJijr+8okfp2GHvviG7M77acapm8CJtjc2FlHXBdTZg2chsJkli9+s1ovG+8+3zDdRHibCq5F/kPml3ng1lKNjdmP56qoJ5DkvTws8qx3+7ofMS3fJ6RCyPG1hzY8Pt5EMEB7TNe8FCwJfS/WEyhE009Rew==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(5660300002)(8936002)(8676002)(86362001)(26005)(6512007)(6506007)(53546011)(2906002)(83380400001)(2616005)(4744005)(36756003)(186003)(107886003)(66476007)(66556008)(4326008)(82960400001)(66946007)(316002)(31686004)(478600001)(38100700002)(31696002)(6486002)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHJHSUY2Y01kVW45SEF3enVLM05HNlM4TnNDc0s3NkgvUlZWS2JkdzlWcTRl?=
 =?utf-8?B?enBEaXVDMnlGNWxlNnBCQ2RQUlU4QnExL2Q1anp4ejBTTXBpWG1DampzTU01?=
 =?utf-8?B?L1QzdUtKN1FxOTFib1NDYjhlMkRKTi9YcHJEbFYwdEYzK3drNjR1WVltMW5H?=
 =?utf-8?B?NUJUcVR4VGRGTFR4TFd3Z3NHYW01RVQrb01jQ2RkYlZ0ZXFYMVdpYkhsVi83?=
 =?utf-8?B?ZXhwS09pcE5YUjRjdW14U2UrNjFZNklYVS9sVXFlQUx4QVlMSjVQdFAvanJv?=
 =?utf-8?B?ckpDeXpLZVpvYlpOUTZraUJHVWR5ZmkxdlhuTUVtQzEzVFZjNXBrcVArb1N0?=
 =?utf-8?B?L0JjRll0MnNvZkZhbUR5RHcwZXJ1N3gybUhZR2E2bTVTK3RpQTRUeHUyOTFQ?=
 =?utf-8?B?ZVZzaGxYSFIzcU1yYWtUOXlOVzkyR3IySExCTnIxVnhXOTNuVDhmNFovOUZ6?=
 =?utf-8?B?T0x5OTJyYThtMTR1OW53dkJlNThEd29TdlhlWlQrQjExMy9TQ2ZZVS8xeURC?=
 =?utf-8?B?czVxVk5SY0FMRDZsMTgrSnV2NDdMK2tra20wUWk3Qy84c3phSGEwM0F6VktL?=
 =?utf-8?B?cGNISU9qMnZGaWlUbGUvZnNtY3kzeVYvZGcrVUxCTzFxdTg2dm5YdVJNVmF5?=
 =?utf-8?B?eDJJQk0velNKUzQ1QlNBUDJxeHFsUlpxbGJPTnFjdEkyYUpIWlJJVU55V01L?=
 =?utf-8?B?SkxZcjYwdkE0U1F3dHBIS3pqMEE1eWh0bmphb2lMWks1U1lhWXI1NTZPMHlj?=
 =?utf-8?B?cmE1Z1p3QVdLcCsvakc5V050bWo0MTJtQnNmWHMzTDZWTU9FZVIzczJZWWlr?=
 =?utf-8?B?Ky92cFBUNFZURUJzYVMwSWFsKzhrdmw5OW5jdjVpMnZ4REp3T0NvYVA2M09J?=
 =?utf-8?B?TWdLK0xWeFRqWEFDY3E3a1NtUFcrcTNKZEhTUUlySGpwWGs5NHg5L1RKMk1W?=
 =?utf-8?B?QWk2NXFsRGpRclRITi84U2JISFcxbXVyQ3JyelhFWUFTeVlDVU1pTkFPQ3NZ?=
 =?utf-8?B?UXg3M3JpanY0cUpnVUVhZW5JWmxmN0xKOVVoM1hMK0F2YkE5b0F2d0grbTZE?=
 =?utf-8?B?QXlkbVdWNE05SUJJQThhR0h1K21La0o5QUZkUE9NMHQrUzBwZHNWMmVLNmhy?=
 =?utf-8?B?R2JMTEFnU0EvZUptem9rZUpGMDY4RTBlTlUyK2lSc2p0anVQM2Z5MEhMT09x?=
 =?utf-8?B?ZDdDL2VUNlNERUlkQWpSZHZWYk1JcVZZSE1qaXo0ckJQNTk4OUlNUUoveWwz?=
 =?utf-8?B?WjhuQ05QV2xrdDFnUEJMMjZuOUtheE5IQ3g5SW82TjQ3aXhLalRxc0ZxdU5r?=
 =?utf-8?B?UmVyaHc1Y2cvTCtQYjlWMnFuSXUrZklmZXpJL0tLYXNoZVlQcFZpZWFjUW5o?=
 =?utf-8?B?Tm9wb3doa1hEN3JFTDdWZWEydnBDQ09QbWR5a1JWNmpMUXBLQmZzOW96MGNv?=
 =?utf-8?B?ZWZ5cTVsaDZxcEtyZ0ZJaHlPZGQ3U2NYRTltUkliUXNIS2IxMVQ5SkxQS2RV?=
 =?utf-8?B?TEhTM0pQUFd2Q2pNaTYwN3IyREd0ejN0SGtZcm8xeW94Y1pqdjRjMHBqalU0?=
 =?utf-8?B?ZEkxVy9lQkpLbTNoUitnRmF6ZWc4RDViOVVscVkyUmhQQlo5d1RvN2VPUmM1?=
 =?utf-8?B?R1h2cFhka0crT2k5RDE4SXZlK1o0MTdQbThZVk13MkxLUmttVlBsYnE5UGwv?=
 =?utf-8?B?U0QxZldqcEhvL0Z2Z3FmM3luWDIweWtkR3pPZ3N1OVhrNFJmZ1RDaTljaFor?=
 =?utf-8?B?UXZTSUZzMWVnUkRybFFGMmNWTlhacmJKS2tKbUd2T2ozUTNGQkZkV1c3ZFRj?=
 =?utf-8?B?MDg1b1FWVWNseitSU0s3OFE2Mzk3Q2hIaG1ndEdPaFh2T3JVVm9UeFNPWFRu?=
 =?utf-8?B?dTNFUEhDeXRaQ2xlRWtYaWlVQWxXeDh1TlE5Q1pObHcxeHZUNVV4MVY5M1VY?=
 =?utf-8?B?Smh1aGdXYTV5Y2RTZHdoUlAxZFZvaC9jeXVyT3ljbW1Ma2RUTVljRVAranF2?=
 =?utf-8?B?NjFNSllFSlJ6WGh1b3h4UjJ6Vm8vZFpmSG5XOW5ocERycEswMlRGWmFPRTlh?=
 =?utf-8?B?KzRmaGdXNmZtb1R1K0lrTGtFNFJnelZsdndTaU81RmFFM01TU0xNTS9iY1JF?=
 =?utf-8?B?b05OUFdwcTluQ0FPRFI1aXE4UVBJTWIxRGdKMnRIQlVFdDRURUg1Zi9nSVA4?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947133f2-b368-4a18-d02f-08db5b5f19c2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:27:01.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvH3S4HXVeGgpMw+fFFWz/PfUilQRwwponLfIlhodf1p14GvwIMLW5eWIIAj8TaJKeNhojKOq4MzZNJ/Y+BFbE6sutSNBCPBsT45bQ4TM48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5778
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 07:27:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11610



On 5/23/23 07:18, Felix Moessbauer wrote:
> This series makes the provided example in README.secureboot.md working again.
> However, there are still some aspects which need to be fixed in the future:
> 
> - Combination with SSTATE_CACHE: This might break the verity rootfs signature
> - rebuild with different keys: The generated linux.efi is not updated
>    and also the old linux.efi is put into the image. By that, the created image
>    cannot be bootet.
> 
ACK - Looks good to me.
Quirin


> Best regards,
> Felix Moessbauer
> Siemens Ltd. China
> 
> Felix Moessbauer (3):
>    fix(start-efishell): argument passing to qemu
>    docs(secureboot): fix logical issues in example
>    docs(secureboot): make markdown better readable
> 
>   doc/README.secureboot.md  | 74 ++++++++++++++++++++++++++-------------
>   scripts/start-efishell.sh |  9 +++--
>   2 files changed, 56 insertions(+), 27 deletions(-)
> 

