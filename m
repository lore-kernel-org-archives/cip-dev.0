Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE84C7618E
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 12:00:48 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.78])
 by mx.groups.io with SMTP id smtpd.web11.5971.1682510442214564790
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Apr 2023 05:00:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OORV+LBn;
 spf=pass (domain: siemens.com, ip: 40.107.6.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUTzXfKnLU6aaTJ3EPSHM7cmfaCWBx7CGTXP6LagGmrJuP/bQJhCyqJm8aClPks7y0lLujrxXbSS040n9wScNUN1MyOzQXhZVYCObMg/3SPqA/AKpXgdoBTBqfktbp1j5gDhbDSCdvO2GjfK89fYsxvUpw+tAxWiqxIus2JCM2lrWy5+uH2x/gCwlt5w6Nuv0/NcknQs7TnWvK/H3Ag/GGPSjUxFRazch/NfRDpDfG55cWgoTCKUC/yzdYLzyIsrwSStrsfvAP+oRs3QH6LiMirMSPB1pnenGCq2WXAUJSHveXSfKEJ7EYcjdjrTOD6ukBS6Z3AcvLqQyH2HtaSi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di/SFuAHC+JwQzFB+yBtwSmmplh5Cmzy0NtyG8XZ530=;
 b=ZqwW2i0LAFHQb6GyccH+RmEBbb1LFwVPuYs4J+c2O2VTtPQBBxI632H/UF4cL+Q5s4pNIsMg+N8xrovghAk0jY2ZpdImOlEumdlS4oUK3HEATMV67+6RFy8Zt8sarI0tmr8tbZVYivNHrit69r4Gl7u6C1/H+IUyYrXbpL/8DPiymBuPzSIZEQ3Rxz4OwltA7zbLSlBaWNU3qo5UdOSoqTs3/qmIypDAKG3bzZZzvjy/NGa2bFUj3cQ7NhYsrpsZS2+cXgKKL5ehsbokkJhvKo1jN6qex5csjHPEdTQFRRsRNZcHxkDWyK8unF0+mI022XOrfzUeNeYPSdR4mBa+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di/SFuAHC+JwQzFB+yBtwSmmplh5Cmzy0NtyG8XZ530=;
 b=OORV+LBnerUqajgLG7Q7llYkWgAEs92StHnBe9Iw6XXW/nEOGJybeCf9Ia6dyu+MWcQ9G7CHtn2DdEuniOJEqErJLG84q/CkN5lOOs1MmXSv4JUZVvlJHnDFL1z87ACtWE8HdZpqVlYkyedmM0LGMGJKSR+vR7jgLoVwrvvbXfqCjRQyCqrhiJThhtPIH+QrOwMJOxjEzjmAZWk4OGgPnpaKRcYeEEAdcwhJgdkglyHdu2lI7uZNzWFiugp+uQC2fKNxy5WuQsVO2XODExeJ6pSjgXuU68UNDsto/usE+B/umNWIg1AwhU8deFk1gJc9kPzo+yEd3VkiaaDpHH5sJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:00:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.019; Wed, 26 Apr 2023
 12:00:39 +0000
Message-ID: <dbb31b57-7d5c-a64e-2f54-965c048a7acc@siemens.com>
Date: Wed, 26 Apr 2023 14:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 3/6] linux: Add missing kernel
 option for LUKS2 encrpyted partitions on buster
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
 <20230425104835.655946-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230425104835.655946-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cb55b1-30da-4000-01fa-08db464dda51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M8qPaIxR+9B2iBsBd9a7pkUa15Waw8hnE6ftY5z9x/dTEj2mBUNbJtw7S9wWMParm39YgX2EtCxZKwdzIaf9EYEldFbIi3n/z/4TM8zEdTLr1+g4tXaX0pfzVIzeLaOq41MCcIQVbGgGj29fsXL24VrbTZtVBRv+PYa9bCpdKCzCwmhhV9suRjNhHPGQJv55Mlv2S1WyBa1yEnhUwXSU+p+RhW7hOEU9Vftff7l/Spw6Vhh+shZzFblA91dzcS6otFv30UuDm/SQIdXNb0aGxY11eZ7+3O5gk74AKX5VE88Oq1WgJ/cn2tIvxDJrqsQ7Qo+DanQ5QIdK6SZD6TvhXVFbhhaavpKMnAjEt3CBrKDrEWQS5WL4uE5yy9GmJDvAZFrWBj4sJ//1fdFYLN3d8jR0BhRFWsmvzzXvS/qC2nlJ4HvaFqST/lKrE/sq9Zou4Flk+BcYEenCAWvUeN2uPAVb1bpWPrgukbJXdzyBaT2wshrYn7FfYYb4PfG7MEkUL2f594EdRqA0HhyfNDXabP4CO1Lzv7o6SAY1zDcbtMKNvijgD3AzVGCwuOfzzAbAJePbYDO4wUacnIxX5ChXEvjPhEhSe3SnU113vf2iScru6DwEGItxFV05JL3NC7RdcZxjEa31vAYbeKpVgS+K0A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(38100700002)(82960400001)(6506007)(6512007)(26005)(53546011)(186003)(2616005)(44832011)(2906002)(5660300002)(478600001)(36756003)(8936002)(6486002)(31696002)(86362001)(6666004)(316002)(41300700001)(66556008)(66476007)(8676002)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGJxQ0pxSFVGY1VaUno4Rll4L1BoOElmUk1Bc3JhT1BLTTlyRzJXajZXdm44?=
 =?utf-8?B?YXhPeUx6dmZ5dU8wTVRYVXBVRE1jRzJqa1lGdndoS0ZXSFJXNjJxRGh6RGQw?=
 =?utf-8?B?VmorL2Fld0h2Y2xWVlYzV3h1akhDWjJCMUtsSEZWNXBFZm5GRG81b3hsdDQ4?=
 =?utf-8?B?WDFBOWFSNTA1U094UFpWNml0dHNHMFAzTy85YXBxSjRiMUxnYnlIU1JlYldh?=
 =?utf-8?B?ODlLVXNVckp5b0doTHY5SkZsVW41SjdUakZqYXd3a0laQlh0RW1nbVFsY2t3?=
 =?utf-8?B?aWJSWk9MODR1Ui9DWEZpYmxaQlA0OWJQMittdGhlUkdiZ2h1ejd2UFVXVXBp?=
 =?utf-8?B?bUE1WFB5YXVHMHNzWjlaS29RcFN0TFpFU2g4b0ladU96Z0dodStaOVg3Qksw?=
 =?utf-8?B?TndvdGlJMFBwYTU0alNyK29IN3NGVll1aFgxazNWTmVkVTMvRVdkUTFSbjFt?=
 =?utf-8?B?ZEd1MnV6RldkYXVOWFNxYTE5bGlDSEVFZkYvNm5ySklvWlY3ckV2RXJ4R05a?=
 =?utf-8?B?cmhrM1ZDQnlyQWQ5UUM3elZqT0JkenJxaThaWUZTREtLWHVsbU5jQTl3NnBl?=
 =?utf-8?B?bzV5UTJpMVBSN0kydDRVaXZ5TG83STlrWkUxVmREV1Btb1Rla3dON2ZoVUJQ?=
 =?utf-8?B?U2oxN2NSZnAvOVpicWFURjhRc28zRkxPOTdDVjlmWEE0ZDMvYlVmSmkzMmVP?=
 =?utf-8?B?RjFIREppb0ZhSlBPZmVUa0RNRmZybDd4Zm5zSy90b0x2d2RPQlRVMXNSVkQw?=
 =?utf-8?B?NFV3TkVhMWtOcWd0bFFFSVdHY3NEQjJYTHBWU3dab2FPUWNiNUVkcndvamI5?=
 =?utf-8?B?NXRESXBCck9nMUttck8rVnNYeWI3WHptY0VBRjR6dDZKeVN5VmlMb2xYZ25S?=
 =?utf-8?B?MVJySlJrZ0dlbDZ0eFZUekthSkpPd0dwYUYvbVUvN1pOTk90VHlVcGxJWGRI?=
 =?utf-8?B?VXh3UERIWHdaQ3JJd0Y0aG1qbmlUWm5nRmNNeDYyVkpqcS9TYnJobDNHN2ZK?=
 =?utf-8?B?ejhwSk9OS21qN3lORmtBQ2JTYXZIQ1NuK0JJSXdpLytUeFJySWJZV3ltRGtG?=
 =?utf-8?B?MWFUUlMxbERIVlVPWUdrRnZ5WGEvMnlGc1hWVWJiZlphR1RnYXBHTTVYaVlw?=
 =?utf-8?B?NUV3T3Iwdmc2clhJSzRad1VyRzVJYnM2NHQ5R0pEaXdleGF5SDc1ajdvZHBL?=
 =?utf-8?B?RWVxc2dXRWI3ZGJJTjZSQWlDSEVHV1N1c2ZScUNtb1JBWWNXdVJKYU1xeDB6?=
 =?utf-8?B?QTNkYnJSQVF1UE9ndVhNR3ZaZlQya0ZhNGQ0ZkpUZUNldUN1TUZNZkdPQWJE?=
 =?utf-8?B?a1pXbjZtdlBtT082MFZvQTM5NzBOMExiemZ0RGJaTUtrV01mUFducEpnSmxI?=
 =?utf-8?B?enNHejFtNWUxRmFjLzYrcEVNVzlQMlRIcnZMNENLSFp5MzBLQW9DZjFLS2Iz?=
 =?utf-8?B?NHdZOGMxSW5POFNadzRvcFVFZCt5cVFYK1V6QS9mbXlXb3Z1STQ5azYxdlpq?=
 =?utf-8?B?WUZYY3h3NUNIbzdRR09QVy9jc04zSGNCQnpzaGZIWE9hMFh3MTRnOHBrZDhG?=
 =?utf-8?B?YTZPZG54dkxJRXFFNTYvMXIwbkp5Mkt0bCsybmxRdUNqT1FLaElvTEZUWHFt?=
 =?utf-8?B?dkM3aGdMcCtDR1NWWjVSN3BNaDUyYTdBVERXTnB3VzRJU0ZPVW9JemtyOWw5?=
 =?utf-8?B?d2YzeGRaeTMvczJXZkpLWVZsUS9obi9jZ2FGblN3MlpMMDVUYkNod25YSENB?=
 =?utf-8?B?SWVrSXFHblNMekpHTU12WnJGMW55blBHWDBxdGJjQnZXL1VJQ3hxZWlnMlhS?=
 =?utf-8?B?K1AzcWRFKzFvUXpob1MxR1VGenViZFErN3RMRTRGQ1hzUEhGNzlmbW9PS2sy?=
 =?utf-8?B?bnAzbWJ4c09zd2s5RTBYWkRNWU1kQkxGanBhWCtZajRyRFFWckJ2V2VLaHdn?=
 =?utf-8?B?NG51WWFhQ2tqV2N4cWRQNHBHSU1kaE5KTzREMGt6QkR1RWdLbThaYVUrOXdS?=
 =?utf-8?B?TXhuN1h3Yk0ra2xpdzUvMmprZXNJNVJNc3QrclQyV1BjZUNmcmNsL1oySjVP?=
 =?utf-8?B?TW9GVGVwU0FDOGNlc0x6VWZhQUcyZkVvYnNxWS92K3htTjZmR2lIa2liTUlI?=
 =?utf-8?Q?13XgSNaMcw4yZ8QKljfSxzIGs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cb55b1-30da-4000-01fa-08db464dda51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:00:39.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyGXQe68kVBNe8aJ72nVnH17frpkfhGdT6Xsy38zjZhLq4IXyZcy9k6+Y9IQ91N44j5sQjtrUJhfJZukmqBvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 12:00:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11353

On 25.04.23 12:48, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> cryptsetup uses the user api of `CONFIG_CRYPTO_USER_API_SKCIPHER`
> to generate the keys.
> 

But why does this only affect buster?

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/files/buster-crypt.cfg | 2 ++
>  recipes-kernel/linux/linux-cip-common.inc   | 1 +
>  2 files changed, 3 insertions(+)
>  create mode 100644 recipes-kernel/linux/files/buster-crypt.cfg
> 
> diff --git a/recipes-kernel/linux/files/buster-crypt.cfg b/recipes-kernel/linux/files/buster-crypt.cfg
> new file mode 100644
> index 0000000..e3ca518
> --- /dev/null
> +++ b/recipes-kernel/linux/files/buster-crypt.cfg
> @@ -0,0 +1,2 @@
> +CONFIG_CRYPTO_USER_API_SKCIPHER=y
> +
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 2d878a1..762a86b 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -24,5 +24,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>      }"
>  
>  SRCREV_cip-kernel-config ?= "0188d9a54615767c00b77116146409edfa35497c"
> +SRC_URI:append:encrypt-partitions:buster = " file://buster-crypt.cfg"
>  
>  S = "${WORKDIR}/linux-cip-${PV}"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


