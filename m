Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28ACA0EC0
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 18:19:42 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.71])
 by mx.groups.io with SMTP id smtpd.web11.3220.1754590775144760624
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Aug 2025 11:19:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YIN2vkjR;
 spf=pass (domain: siemens.com, ip: 52.101.69.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsRKM6MbpAAXb4f1SeMj2pZtiFOUFXbWkl+VdyzqRAT4zZJ2mOFlvt5m+zXssEe2eBZ3jacFBUROH7WVEfxYF7V2IZOB+vJNd9HOvzTr7OZ7+9kBZ3BerFEwvno9+KH7BgcVpxDwQU+mNhRNLiF05Z8b1p94VhklWryza6m3Z8vVSp19A37Q/jr6a069yhCz+e5BqVcLL+odHEtPNSKk36e7Al/3eun/0cP5wXJ+pqQYugce9MLoSgWGmNi6GSMl51OjQqZUXi3f99Ol0WIF3odRt2UqQBaA003RucG1oXaSAMbLKTLQ3nsmKoBFMcGQG13/EBciwr3szSdgDhSMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go8KrHAOb6O3QinG4W6XnXTPGsa3zI5kn5m+1ZRl0lY=;
 b=sHfFVbuzwMkoSRRGodD+2AOC7k/sU3tafGLdevcRY6Bi2HYcPybIsGCS7casksSha7eNa31h23tGKErESr9L4pMJi1UkGv3WDhnZ+L3LjGgC298gvSeH68/wO/MXIO35k0iSNCHBktg5Lre4h2SWcv0RGY0xOwmRZHebywVh4SG5UJeExSVYq1+D8yyZJCz/TN0ouNYyKe2zdR+f/um5wklMZqiV9wUW08m/FJmz5PDHA2ATABggz9Jiz8v5G7qPScINR62WZ7KkFTAV0xlSXApL4Xz8PCOzJfYwmLem7E/4FNfPyhFSVHqBravNqLqjtH9xnnHkAEwcE85eVg3IpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go8KrHAOb6O3QinG4W6XnXTPGsa3zI5kn5m+1ZRl0lY=;
 b=YIN2vkjRZm0tnk4Iuxm5VdPo+s/5o8Gs7j7yuxgRGiUk8zof21W2p7uH8jGSCOXhnj2cNLhJ4hOoUlrO+3dwjzAj0xAqexNkc+5Vrw53lAY4Y2yDnunwSY8PNKuufYG5FekDhtRgfEUOJfazLUAbb9ObodasOUsxUBSMbu4nPew1xJpqgvtDtCI8pwP91PVE+S1X8m6bHNh2AIWDd5t6vGj+YOfQoNZ5ovI/KAdfQmRNtXHBhO7I66tT3t434tYgsxj351y4YesDjJVBpfua4bPznnM1Ypn1ss4JLk+vc3CROyUBnhR1i72vKUNoXWFSYROynitZfZ1bz0kra1Pl8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:576::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 18:19:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 18:19:31 +0000
Message-ID: <d25b4c20-3302-4a11-b648-b81d6cf1181d@siemens.com>
Date: Thu, 7 Aug 2025 20:19:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] Remove credentials from console &
 document them in security README
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250807090941.3393503-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250807090941.3393503-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe95929-23be-4614-0b89-08ddd5def40b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VENuL1JzR2VzbjVzNjFuelVKWjVHeFF4WWc3VjVFWENSdWJXWm1RMEpnWGFt?=
 =?utf-8?B?T0kvdFp2SlJhb3VmVndMOTRUN2lSRjg3ZGJFRnZXakkyME9EdUs4NXBFNFF4?=
 =?utf-8?B?ZDdKOEpKYncraUNQaElWS3E2eUlRNVl6b1FEakdFa2Vrc3I1RUhQUUExVXJq?=
 =?utf-8?B?dHZ4Tjc2cE9DbDhLRkFaQkZVQlJzS1hCdVZvUWp4UUlZd1psV0RhV2tQTDVz?=
 =?utf-8?B?dkNyQ0Y0dGRJT1lhMmRiekV2N1VMa1MxWnd5ait2M3A5MlRHS2VsQXU0QTFU?=
 =?utf-8?B?RW9PdUxOeE5YTjRYZVRUeUZsZzQ3ZWo0ZnBhWlFydHBSM2F2Nmp4VmsxbXlN?=
 =?utf-8?B?YnVuTjI0eXoxYklYamM3ampMMi9LKzZPNERFUmlRTXovNGhiaVFNa3JqOVZL?=
 =?utf-8?B?bTdib1RKWWZDS0doNjBab2RrYzdubStHTncyTXhFZ2ZkcW5IZWNzTkxncUk4?=
 =?utf-8?B?b1kwQ2xxQjdwSVF3WUFVYWlUTkRIeXNhMlA3WW1PSUJHTlFSUCs4L3ZMbTdo?=
 =?utf-8?B?cTlFdk9mNmNsMTgvMVpacnVYYjRLN1dPZkgxMllxTWhUd2FRY3U3N1gwMVZK?=
 =?utf-8?B?c3NlMUZHUEs1YmR4QzljdFNQQlhER3E4OUtja3ZzNk9oVDJwS3VWR0poVHgy?=
 =?utf-8?B?bGJIM0pHY3Z5SEZnR2MzSDFoczR3T3FKdm9TVXltNEdVQWZ0SGVWL25OWE44?=
 =?utf-8?B?K0NDbFVDZWRlVUtvUlhURnVrcndLZUhXNWpCbDNNUzVLbG01QUJRVUlkMnJw?=
 =?utf-8?B?SEkraDZsY21HYUErQ045OGZ2eDFicFB1MFpDZW90MjVadkRuR2hjTmJFRXo5?=
 =?utf-8?B?Wk5lZ0tDT0lvaGdlRU5kcWdEbDdMRzQrY1dGLzdTVXNJWHdNNzNXeUQrWGs2?=
 =?utf-8?B?eEtwL0c4Yk1OelpDUmp5WURwaEtTcjdaMWhwRDFmV3Q4MitHV0NOd1BGNUFH?=
 =?utf-8?B?bXNLV2RJY3NWMko0QUV4aGlHcyswVTNMdW1LNTUwSlJJb1JPdVZRWkh0bEtS?=
 =?utf-8?B?ZEFGdk9HSGhuN1hoek9jSzgrMnpoYmVzOUQyOWEvSTg2THBhNUhKMU9HcHBB?=
 =?utf-8?B?dVJjVFJzU1ZRLzloZmE2QVZpcHM1RTBPb205TFVPQ3phQnZOd3F4eHhzN0dm?=
 =?utf-8?B?ZWlRN085dXJqVmJpNkgrT2wydWcyWWtHL2JZVVRTYnN3aytvZHZBZkV4dEhV?=
 =?utf-8?B?bXZxczFoZW1yclU3WTVVZCtoc0dxaUtUeHQyK1NkUE5JY25VbVFmTzZwVmtl?=
 =?utf-8?B?QmszbE9vV1NpQ09yN3dIV01HTGxteW9STWxiQzkwMkVLdFpxUE90ZmszYlZh?=
 =?utf-8?B?ZzdlWUdjOTFncXFxeFhndWRqRmVVMmsxbzgzS2ZJUzdJWFVGakJLc1p5RE4w?=
 =?utf-8?B?WE05ejBkdU5ZdGxzSTNyYWxXU3hGUGJ3NkVoa2tqT2FFVEhJdEhxbnFwbUdK?=
 =?utf-8?B?YTB3THJUV0cwZlJGaUZRK0ladGY3TklRa2ozR1h5R2NLUjNmcjlOY013eCty?=
 =?utf-8?B?S1hrZjVwWE9mczRiK05oL05iVit3TUxNWFFVQjg3Q3NaK2Y0YWdxaVVtYUhw?=
 =?utf-8?B?Ykp1bnVIcFFIQnBDcUw4Rk14RUhza3BBQnpoVkpHWjR1eUZGNXZwMm0vUTFz?=
 =?utf-8?B?YnF6UnBndnVnSXZ5ZFlxTzlFd1dTZDVWdmFHUWlIRzRIaTl0UzJOSU8rMkN3?=
 =?utf-8?B?ZjJ5am8wOHRZNlBuWW9jZjJqcyt5K1dmTHhUaFplY3NRdFVpZUZCc0tzNER5?=
 =?utf-8?B?L2VqbEVSc3haa3dTdml3bTVZdGRzbmNGb1pXYWg3eCtRa2NOakVhd09pTnpi?=
 =?utf-8?B?T3QydnM5Tmo5RUVXUTluSlM4UE9wUUY5WDUwMmthd0YzZUVNYjdReVdNQk5l?=
 =?utf-8?B?eURXNzRRTzNtbWRObXAyTk91SG9ac1U3VTdtVk9qWGl2Qmtab1IwL2c0Z1Aw?=
 =?utf-8?Q?XZhU5yQbgIU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekZpYm1pbjlxUFNXSkkrM2ZSU093ZXYwcWQ5SjdOYlRwVG9FbW5WT3NZUUVh?=
 =?utf-8?B?Ulg0dmUvQ2w5VHUvMzN4ZFNXMzVkaWhuOHl4aUNpY0ZkdGdzbDVIdWsxc1lF?=
 =?utf-8?B?aVhMc2ZLd1dpYi9OZFhNRmJBdXlDMTZycXk3VjFSbmNzNVBtc2x4eVNQT2cv?=
 =?utf-8?B?TzAxUXhHNDRqRVQybUdmUGNReE11WkdaWTc3Z1Q0NjVIMGRVU3YyQTBISXJ3?=
 =?utf-8?B?WHVDTEZNK1RIbXNIZWQwL3lMbENTV2FEUUk2SWVYaFJrN3RCeXJGYlJzRFNE?=
 =?utf-8?B?SjFHd0dmUHpWc085a2dVei9zbHNWYUNlYXB2RDZVYzdMR1daU2ZudWxjWjVM?=
 =?utf-8?B?VUtYTVE4c2dQcWZlckZVNG9xVVVkcnh1d09JVTBybVFteU5seFJZMWxRUEUx?=
 =?utf-8?B?U0x0OGZDSEtvdmRMTU9NdmdsWHlHb3RVMUdQMmhyWWx3d25qWFhCNDdERTY3?=
 =?utf-8?B?TTNkY21kcTJzbTlsOTZYempqUkFsZ0Z3L3R4YUJpSWxZRGRHV25tM0xkdnFN?=
 =?utf-8?B?L2VWS01WTjA4NDFyUTdORlhzNHBZOE5BNUxuYkRYZXpiS1FlZURPUkxkZ2lx?=
 =?utf-8?B?S2FEekY3dVdZc3VKUndnTG9aTkQ3VXFrSUp6dytzYkxWZDhSUnk1RStCd1ho?=
 =?utf-8?B?aXN6K3IvNzNtV0FYZ1h5cFhZcWxHUy8wNWQzTWtwQ1JLLythVlV3V3FnL1ov?=
 =?utf-8?B?TlpzWDQ4c1hEYUZqenRmVkdXNWNtaFloYXI5eGxNQ0FicXN4U1BYWFJoNE5w?=
 =?utf-8?B?aVNVQzJ0U3RUWkZGZkh3R0RjZ2pLa0JDN3FvWGtsZzErbnphbWFZSXU4MUo0?=
 =?utf-8?B?Rzd0aDh3NEtwaHFZMnVSUlpvR3BZcjY5SWJZbG1kNk8vNWI1dEFxWmFKQUhL?=
 =?utf-8?B?eHI3ZXprTWhuOHl6VFhmWmMxazZvS3V0d2w1d1dpSEZYNHBic21uYkY1bkV6?=
 =?utf-8?B?L3AwbGpzaDQxNDh4WHFrQ29PQzZYekJOVzBMUUJCL1NxL2lVeEprQkp0YzJl?=
 =?utf-8?B?ZFErZDFNR1Bkc3VWWW1aMVVvMlVEZUlTTnpuMHIzbk93V3BDczdXeTF4ZWJK?=
 =?utf-8?B?YVd5eEJ3dkp3dGZ2UGZNbzN2VURXRUtRQ0xJNHdveGc0RDZVNTJvVjRQb3Mz?=
 =?utf-8?B?RHhKbDEzRXdSeFRhc0dmYjkvN2RMQ1k1MHNUaktSM0VoL0ZmWFBieFltZzBH?=
 =?utf-8?B?T05Mc2dCSE53eWRyMHk2K05veUxLZlFva3NqR2ZLd0NzbHlVaVhvbWVuK3hJ?=
 =?utf-8?B?MTdqUzg4YVZUT2k5d2M2cmRmVUJicytnSkVqNFJ1YXpLTVZ2TWhjTmp1dHVI?=
 =?utf-8?B?RE42dDlWOENVd2VLMzZVTFRBTTRKb1FqcjZJRis5TnFxME1KRGdTeGMwMzMx?=
 =?utf-8?B?aEUxc0RuNWw1bW85QmtYRW9HV1M1OU0wWHpjeDBuczNWblBqSzdhOEVNUU5F?=
 =?utf-8?B?MDFqb09wWnMwMUJhRVRIWDlkY2xpVnErR25lVm1vK3E1djRvUitXMlJqbVRl?=
 =?utf-8?B?ZElFQmoreDJVcmY4Vmw1Q1dEQTVPcE5nTURENC9XbzY3Q2lTb0o1V0FqNjE1?=
 =?utf-8?B?Vm1SdHc5ZElOaTBOeWJoOG8wVDNhVmVaUmtmVWRvQTF0ZkdTdjFRei9WOGMx?=
 =?utf-8?B?VkhjVGY1Q3lmSnkvOEZGSHFHSjZEdjBKN3dIRlJLM2plT2lYaGwxczJCRkd4?=
 =?utf-8?B?czNCdUZneUpBenhUNkVvbnZIZXMxVG95c29yUjBwR1hOWUFJaWIya214OUU1?=
 =?utf-8?B?QUJOa0V5K1poK044TGF6ZHZPQ3VKSlVOVytBZmszSVVPSk9KVCtKWDZVM3ht?=
 =?utf-8?B?cCtpUkZtUlZQRk9aYmVyVXQyWmNVSHI0QnZPOUczaVhTUSt5WXZvSjRJRXZp?=
 =?utf-8?B?M1dnekFUblpjUk01bzRmazBpNHQ3QWF2QWRMTllBc0lmYUt2bzdySDdtdUdN?=
 =?utf-8?B?MnpEY0FhNkNwUlBuZ2huSjB4S2dDUEphUUdRUjVSbDFOU0drMnlIYVgvTlVR?=
 =?utf-8?B?ZFFVakl0ZG1PK0k1UWVqbm8rdWtHck0zK05KMHFMZ1VlTmU4MXE2aERYcVJ3?=
 =?utf-8?B?ci9uL0h4UFdDWmtlUGdvM2lpTWtMeXo4eEtGaVNQM1ZNZHNacTR2TlliUmtl?=
 =?utf-8?B?Z3BtZCtUbUErMUtWejVibEVUcUg2RFh0Tk5uZEFQTGtUZlRRdDFzTWF5Rm9q?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe95929-23be-4614-0b89-08ddd5def40b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:19:31.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdFPSdP3TCG3chRS6aibCDWDtvNkzUxt/tsPiMQSl07DNRixRuIWiEt2eCh43y+wyieDqYn2CL1FZZ711TXcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 18:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19710

On 07.08.25 11:09, Shivanand Kunijadar wrote:
> Add the information about credentials and a note in the README for
> CIP users about not to use the default credentails for production
> images. Also, provide the reference to password policy document.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.security-testing.md                      | 13 +++++++++++++
>  kas/opt/security.yml                                |  1 +
>  recipes-core/security-customizations/files/postinst |  2 +-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
> index 213fc82..a33eecf 100644
> --- a/doc/README.security-testing.md
> +++ b/doc/README.security-testing.md
> @@ -26,6 +26,19 @@ Save & Build
>  host$ ./start-qemu.sh x86
>  ```
>  
> +Login using the following credentials
> +
> +```
> +username: root
> +password: CIPsecurity@123
> +```
> +
> +**Note**:
> +
> +The actual credentials are injected here [kas/opt/security.yml](kas/opt/security.yml). CIP users are strongly recommended not to use CIP default credentials for production images.
> +
> +Refer [password policy](https://gitlab.com/cip-project/cip-documents/-/blob/master/user/user_manual/user_manual.rst#password-policies) and set the password accordingly for production images. The actual password policy settings are defined in the `postinst` script of security-customizations [security-customizations/files/postinst](recipes-core/security-customizations/files/postinst)
> +
>  # Copy security tests in to the Linux image
>  - Clone the cip-security-tests from following URL
>  ```
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index 8a875db..2ad53ea 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -16,6 +16,7 @@ header:
>  
>  target: cip-core-image-security
>  
> +# (Warning) CIP users are strongly recommended not to use CIP default credentials for production images.
>  local_conf_header:
>    root_password: |
>      USERS += "root"
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index daade83..15be659 100755
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -6,7 +6,7 @@
>  
>  set -e
>  
> -echo "CIP Core Security Image (login: root/CIPsecurity@123)" > /etc/issue
> +echo "CIP Core Security Image" > /etc/issue
>  
>  # CR1.7: Strength of password-based authentication
>  # Pam configuration to  enforce password strength

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

