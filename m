Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58957C83F12
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:57:57 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.49])
 by mx.groups.io with SMTP id smtpd.web11.8264.1693205869655053155
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:57:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fcSJ7RCv;
 spf=pass (domain: siemens.com, ip: 40.107.249.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOIuSMcQPom7TZSejR2RWDbk8X3AgX38+egHGdWxeK94Fc1fJYgQq0bViMuDDXGX7pJkcqUZddSTJR2WawIAejj10YYc6YcJ5Au3bmQyZvSwIdTSAe6OfXq7Q4EFhEJ4LrQ94d4VEbfXd7Gzanww7MuGnMI2iIAm71VmZ0oH8qZaSs8wYXF0jhq8hQ6kxHeSNwbscDX+sGox03QYt+HSQrHRtiea+sYPIaM6sqU7SrXkjvtZ8jPbkelKoRG7XxruIXJD0erITIHS21WG2hQr8ta5Qew2gEeOTLmE76MfCy2ClTP0krma4FpNWXeOP5y657AIcZkbBpINtQ6IlZ1ToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI0TvVeYi6r7RJVMCEaAsldewjO3OCsl7Wkqk4w7JVU=;
 b=oAxdAKmVNSZ5KQ06tyKnrUvhv/WYK9QyixCUDePee8nCmdhCV67aVaCdiTx5qXL+/GmvVqQ8NITH2G3PNiktUJG8wrzjXxVCPfo08h2CqVcGg9bCOP4NlfmQOeA7vT6VY6OxKV54u/jLST0eBopvGCgt33o1Fi8LaCtiO4fNxLALxqN3vLbes0NJRZDLEyr3UtBd3OxwHedbEnN02EMzVQvVrTDyAZm3BNc40coT4rf4XPXhSG3nX6EgMEMSsS3GQBWuS4SKxdTWSgA+r/KvEXgvxecOdtEPWg3/CLZCIPIJpBtXV4HWOLDEjJTuLFABTQFj0lcn0/ysx07Ne7CiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI0TvVeYi6r7RJVMCEaAsldewjO3OCsl7Wkqk4w7JVU=;
 b=fcSJ7RCv7n3LReJj9/frn/RomfvG6riojN16o5A2bRR/Bfw+LOEm7zRVSlrvzxQSjJERlClCkI3vHlasP/3XsHCuj5MXXkPCIJu7B9H2bm/YUW/7uRyFcSYzDMZVq8fy6CmVUCxmXqG0bG2GopYTP5YaC4IAHVIezVwsopgU4ocF0GjF4ItOQWdV0iOzt4Bd8JBu3ff+Sf2EIAHvrMz13Xm+mUrrkrdt//GCTOHfXLtSl0NfWSmDyP7RWO3JkEm3tXXLMa/kMIcGNgRojt/DHe2bVQF9mZ019dF2hjSjiMb94SQqYuN45GNzbIX5gydCRRw1nrRQddKeu3y2K2fYkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:57:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:57:46 +0000
Message-ID: <71e71eb9-d085-48f2-9b4e-e15f0fa67916@siemens.com>
Date: Mon, 28 Aug 2023 08:57:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-cip: Update to latest releases
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20230828020158.1788420-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230828020158.1788420-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 52722f2c-9f61-41ef-986b-08dba79415ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rSl6AJhSUFfDPY2wEDRyRYfJqXyTPjQdDb9BBChlUzR3l31kz8zGCQxJa7vw7dfcPsP/WpU0MzBrfmqCJBHMaGnesl8OvESGKOzbzuPJMrhSXLH17DHoYce5NoTjz6qmwdF8ckoIoQrNW0xStAAOfZLKtcA3IQ0lM1GRDVCgand6QylWe84zdRsixv0sdtWjU4N/JKwSHLxBGDClI4xXgx1U3032SL4l+PVzHWghefGWKM/48qNJ0XqG+syg2+zpaweZ2jWpQaPnP3OXyA8qUqXTUR9xd1rit5KhfGNx3Ch7PEwQpRr41GJolvwxUIXH2/fg9StyuLLaGPfkxA32enYWdiRN49+rCo5q9XRpa9b8UATD4r6HQbBAnA1TzFzRFhcCug4sTHwOz977JtvfcQr25kNmOd6IXgrjdHTUTdzEArpZ0j1WrFc2ype5OBLFEOl4DAkMPkHKs1BRATTaBKTGUTgEKqSZxbT7zyuLLf9gN9EOkTi1e+SbrQ6FjHqiLfiCwM4raNCagsisqrXEoQkvXuJzAEop4H1epB41zgUsYfwi+AdYBUyN9i+GOzVwMJuc6F3pqBBsVuzBX8VWUwrl4gRHXGAkI+7Y1nbuTsMj+G0FCcH3UcmzJWhobiZkwpHgJ1P2h7VqLjuBKTf2/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(5660300002)(6506007)(6486002)(478600001)(53546011)(83380400001)(2906002)(26005)(6916009)(66556008)(6512007)(44832011)(4326008)(41300700001)(316002)(66946007)(8676002)(66476007)(15650500001)(8936002)(36756003)(2616005)(82960400001)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ti93djh3bm9TZVpBMkpQSTdjTlp5M3ljdmtjN0lFYlN2UVo2MWlreWwwdHl4?=
 =?utf-8?B?Yk00eHQ1NjJ2OHZYbjlWQUJkeG0wZVNYTWdYZStuVFM4NW9JL1dCZlZJZHlU?=
 =?utf-8?B?ZkpMbkdZQVczandKYngvdzlKZStNenV2dWZ2WWc0aldMajdjSlFGR05JN0hL?=
 =?utf-8?B?c0tMeHo2aFFTQ0NjaVFiNWNVRENjWUdCNkhZZCs2UGRXMkVSeDcra2lhR1NM?=
 =?utf-8?B?NCtJRlRicmxPa2d0VExxMTMreEU1MFgwWW92VDJqczU5aklxSG5TRGpZdWNT?=
 =?utf-8?B?YU9vaTA2d2tsYjkzZVp0S1d6NFByV0dheDhIUk8xa0pvc3BvT1ZBZ3pkWU1z?=
 =?utf-8?B?TG5lc1NJb3orR2JPNjZ2bUFidlp1Vk9QNWxWVHhnWHlqUEJ3bGZHZDRjRlhI?=
 =?utf-8?B?R2lJaURVM3R4K1p2cmFaY3VuTHNWYUR1dEpDaEJ4SFBrUjBUanBSL2YxaTB3?=
 =?utf-8?B?L0JyK0tUa0tLR29XSlJuQlJoTFF0K3hHN0pETzBjMmswUFhYZzhqaGZYYWJq?=
 =?utf-8?B?TDlvTTN3eWFlMzFsV1ZTb3llZXIzZXJMUHBRcE16T1REbjBjZ1hmcHpUWGRC?=
 =?utf-8?B?R25SNHlPbVF4bWFqaVpVV09paEY4am1kRVJ5dVMxaXgySUJsZjlVcnJJdWVj?=
 =?utf-8?B?UnVNZUNvMUt2OTF0ZXpqZUQxYjNkNjdoUjlMZlRmL20rN1hkZEZJcncrM0dG?=
 =?utf-8?B?TnZKM2c3akQyTVVmNW5nQXhoQVV6Z0ZKY01SUHNmaklrN0RQUTB0NzVnWE5k?=
 =?utf-8?B?dGZSeW1uMXNBWUd3VGxzdHFGZWtTWS9iekI5YWszR2VmRWdGS3lWRms5OW1N?=
 =?utf-8?B?Mk16ajNjd1F1Z29WeURTNnFFeTJNMitRT3N3WTF2aVFnWEZSK0k3ektMQThz?=
 =?utf-8?B?S09ZazlENDBTZFJMTlA1N1NsWW9RN202bkFxRzVZTHNWOFc4TXVUc2c3TnRK?=
 =?utf-8?B?SzJIZkk2TTRJcXlpR25zL1ZnSm9jd2VLSERDK2o0STZ4NXdMU1puc2VzK0cv?=
 =?utf-8?B?T3kyU0FveEhoZmxjb2wrN0xIdkNKUFJhY2xjZmlqNVEwdVB0Sndzei9rQTd4?=
 =?utf-8?B?MVQ5aXFmV243VUkwclRPQy9LMEtGZlNEOHhDd3QwZGFOVVo5eXJuOTh3OC92?=
 =?utf-8?B?QWNMNjg2dWljUldQcVErZnFER0Q2VVhlV1o0bTU2RHFpUjhDUlFQU2c4eURG?=
 =?utf-8?B?K1doellINnEydzhEOFQ5WXV4RGFYL3VMOC8xaVhjeVBuVHZOV09CMGVTYmNl?=
 =?utf-8?B?TzRlZWRackNTN090ekZlVFZPdGoxWkJJMXFxNWxHNDNBTVIzYU1VNXZIMnc2?=
 =?utf-8?B?UnAyTi9QQXpKbW1iUndLUzAxSzBkMEFEU1dXY2dyc0N1MHJ0Y0ZpNVlOb0F4?=
 =?utf-8?B?bzl6OHFoa28vSWJZM0pmMHpmS3FEL1JZaWdBbDZwTW5OYmlvWGJGQXZPVHZ1?=
 =?utf-8?B?bllKK1ZGM2pMaVlySE0rYTAzeldJMkZQVU5uOHd4Q2RIQmVhN1QveFk3WWZS?=
 =?utf-8?B?bDVqTGgxVGxiWVRESkxXcEw4cUsxSmh0UllNNG5JRW5iVnJFbmZpVUsvdmxT?=
 =?utf-8?B?UWlNbzhPL0xaNnNCcTVPeXZkb2t6NkliVExINlRGdUF5WDhhaTNidGR6ZDQ2?=
 =?utf-8?B?eU5YWGxzaTlRSzRZVWp5YkFCSUlQc2ZBWnBudVdUb0pyOFU3RlVYZTdHU1di?=
 =?utf-8?B?WThZRVVDY0lhNDVCUHBmQzBqUDhXYmdhb2w4eWwrMzJFUkE4aFFrY3JvL0cw?=
 =?utf-8?B?VitYcGRkQjFJaDluWUZndlU2anFaNElEbzNaUjlpeG5uL1lxMWVSRHdIWTVk?=
 =?utf-8?B?cCt6RmIwNTFSbkpiNUpJeEkrWUtjRUNqbUNXYlFCcm9DUld0d0MvQkJueEY1?=
 =?utf-8?B?VTArT2VHR2lZenFEclFVOEtHcDZyME1uNGdVZ01VT2F5cVFNdkEvUU1hU2wx?=
 =?utf-8?B?MWk4bEpwQUd2M292VS9IRjJYSjdXc2dhMFM2emg1NXBGOFJ4Mm9KUVZLK3Fp?=
 =?utf-8?B?elJ5MEUzVUNnU2s1OXhzVVFkOGxRQWRheDB5M3hPK2M2a0NqTjAvdmhNT1lT?=
 =?utf-8?B?Tm9HQ0lncGFHRStjbTVrTTE2UHRQMkFqbGtJWFNseE1sOUJCUTJrcW51RTVH?=
 =?utf-8?Q?R/ayZu9oqUnfg0/uPGx7X1a79?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52722f2c-9f61-41ef-986b-08dba79415ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:57:46.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glAyJa+kcwKHZapzaaeYMfksi47eYTUo+05pxdlx2YpiV0P+GXvW2VJoTKs+k8drn7cLzRUY7f414irwufhhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12879

On 28.08.23 04:01, Nobuhiro Iwamatsu wrote:
>   - Update to 6.1.46-cip4
>   - Update to 5.10.191-cip38
>   - Update to 4.19.292-cip102
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  ...inux-cip_4.19.288-cip101.bb => linux-cip_4.19.292-cip102.bb} | 2 +-
>  ...{linux-cip_5.10.186-cip37.bb => linux-cip_5.10.191-cip38.bb} | 2 +-
>  .../{linux-cip_6.1.45-cip3.bb => linux-cip_6.1.46-cip4.bb}      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename recipes-kernel/linux/{linux-cip_4.19.288-cip101.bb => linux-cip_4.19.292-cip102.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.186-cip37.bb => linux-cip_5.10.191-cip38.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_6.1.45-cip3.bb => linux-cip_6.1.46-cip4.bb} (65%)
> 
> diff --git a/recipes-kernel/linux/linux-cip_4.19.288-cip101.bb b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.288-cip101.bb
> rename to recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
> index 44f1e2d..8b1d4b3 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.288-cip101.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "6d737010f07b27838247880e7aa4699bbf881b587f5b5eb6cfbe98bd523c7969"
> +SRC_URI[sha256sum] = "106b3bcf4b3cc8b4ed25995a843839875e5fbbaf3b533df9d666199314628e31"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.186-cip37.bb b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.186-cip37.bb
> rename to recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
> index 06ad14c..cf66e55 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.186-cip37.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "0a0eafb33490fbf6116c69f65846745dd0cb288119889ed87d336447683d46bb"
> +SRC_URI[sha256sum] = "cee2c13b4e7280e6eb92746d14ec2b5e0e76c3842808de4348765e33b9e6dd39"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb b/recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
> similarity index 65%
> rename from recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
> rename to recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
> index 8124f1d..fef2d05 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
> @@ -9,4 +9,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
>  
> -SRC_URI[sha256sum] = "bef9588c018ef583303b288baa4eec3b0fc8a723058d52da7fd2fa27d6e619d2"
> +SRC_URI[sha256sum] = "691c4e52281e47d324c4c9b840cba7050e42147a05342ce4cfe1ece40fb9c27b"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


