Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2E2C77B7C
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 10:13:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.41])
 by mx.groups.io with SMTP id smtpd.web11.7731.1685182372706180771
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 03:12:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vaGX1lh3;
 spf=pass (domain: siemens.com, ip: 40.107.22.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d46v8l5hOxQOOOHYSJAa7rVoFWUC7DpvNZKGZ+YfDZ0i22vsmNEDM7x+6L4Kh9lBf0I3wZgV1gWscC5M04zBXgSQ6v1lpvIgeZFN5znabXWbKZQmDbN3E77HKyUlIEqZMASRE7oPwSHA1bNi6iaDX9jYx+Go1CsDnbyoXiNQlzj16q/LovFuTXwdVzE3M8BnSPORs9glgDV6yR1ufK3f4LxFKPeh7pdR/jWCIsnQqqj2YdzxJpIEV8P0TPraXaP8q+C6hCEPq+bY4bLoAq6afyLoXvx/5ZIzQ4n/QA3jFawJO43zIHhp7aiSDM1Nri/sQCZHa5BXevs4+cLLFpDi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shxuNZGhE0CApd2i3DuH907+XwyW5IQKGkIJc8Pk1Hk=;
 b=JGtcNwfTu6evKghqwmJMI14kedH3UwpP20RsfEuCg1Bao+QR/XlWDbH83J9kHEta8Qi51CAjGBaqKxSI8PgvXDcLAoba03MJA4pkD9HGUmWyX+mrAW6zBH7QRW0xP097GbramtfXMFXcYqhy979s0QFhvfZrZpG/f7tb9oPE/CLjnPlc9CuzJZ1+tdxLA/IRirfr6RhE3w1qyZW1fq9SkQggu/aJsEt/5mQDQUCv7WrliE7S2ylVGU8hT+fsmsd7Q4BLBPPzAGyd+0ZhZgKIb5oEICZq+ak+jl0XEOu3gGXZUV0erkz3oAGIu5RZrtE0XfCZU0s2wuAn6SwmRUn2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shxuNZGhE0CApd2i3DuH907+XwyW5IQKGkIJc8Pk1Hk=;
 b=vaGX1lh3uygufYLyVA5tUvYpPVj+cqn+VK/oJRGGttXfzUWS8t1IL66E4a4SC1tWwwNqOzfT9f8t/8c6vFurDqqw9gebmnz7o5es3Ty1MSTXWprNS/OVwZDmaOReG6fbiOawcu/D2FwC74618+UG+ABS6+eK3OQWy7PYqhmAw2zbr2Q/pv+AjB9QdNT3S/5tODe5ZX7EmuO0IOKRg9YMnim4IR8BqBuQlVydAHvRYv9Ug+Vomhl7Y2wtNX8eNxunn5zsUJ7gEEc/9PBkBpwsiJfrgEdL2cQlqX+Ilq4qIKE0CgiDFSYKyUBK0AO+T8cMbS52Zxcs0TNo8AYPKX+Utw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:470::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 10:12:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 10:12:48 +0000
Message-ID: <08c65c19-508e-0f48-9d4b-9078ff0ffe66@siemens.com>
Date: Sat, 27 May 2023 12:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH 0/3] Various fixes in SB workflow and docs
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: meng.ding@siemens.com, chengshu.mou@siemens.com,
 quirin.gylstorff@siemens.com
References: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbab8d3-c272-445a-b4e2-08db5e9aeb30
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	klih9owCjge6xL9LZGjSpiyEjd9nhYn7ujxZjLMKe02ldHYy7pom9S4g192+y3B2ibY3xUqZQ3AbRUn7JY7Da3CfuaKjchvAFbE9/vpzOO2fk7S723L4DsECRK6gahTMSn9l6bi1jjorYDbjOZYZjj6rCxJU3PdT147RdW6bqdLIMTdESubfy6mE7Nlw5OsfqnOU/JFjEsOGV4AmHQ1RaBhPeT6m6TOlr3QVv4EVMExLto1wFRL6YT7QmkPx2WbEo9Ms1/YfGDWcpq27GVS/1JXmwXB+SwkmI7wDS3zgVp7hlHkY+ueeXLBV4wL+4LVfltTVc9SZeU4RLIR+jM6AoMz3Ya8iTMCkXr+L0OhltOfS6xvGk0X/DH+u4d7iYuxY5e18/ayjRKX1nLMZPcC05Bdp1k+QQRO7Mr99lDnGj9Q5tV5KDkmZ+HUTrgZoqbISf3Tt9aYd/uTpR2vKoSaLyf1Oc04sUleA94cMCRJJkyDEKY3g3NMTgEmkAvcs1J9jGnHUcZjjy8KknyUJNQ/4M5nFiJX/iJVs/SsSefdPfqj+3m/74eNBsfrlTvMl3SJeaGLJyTgNaxJ1WnTSsdtPC50p92aQvUHjuBA52RPRxLBpsJxmMSx7OaBuRA78jOrYaUjCovnqLZhcQdzO6dXD6A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(316002)(82960400001)(6666004)(38100700002)(6486002)(41300700001)(6512007)(478600001)(6506007)(53546011)(4744005)(44832011)(107886003)(31686004)(31696002)(186003)(2906002)(86362001)(8936002)(8676002)(4326008)(83380400001)(26005)(5660300002)(36756003)(66556008)(66946007)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlN4UjA5WXgwYlhoY2ZlUjlaVHpTVXorZkhNYWpWWmd5YzBFYU9xRHA4VmtR?=
 =?utf-8?B?NGhEUFp6TTA2L3I0QlFqMGRveDZKbkxNQ1NzSkI2bWRTZmJMMG1ITjdqbkdN?=
 =?utf-8?B?cmdremxCN24wSlZIVU15NlFacWFBcFNsZURxbktNOEtuc1N4SkZTTzRRaHZO?=
 =?utf-8?B?RklIbVc0Q0JZS3FuK1hEcVd4TmJUcGVoMUR1dVpzcHZvZWhYUFB1TjROLzAv?=
 =?utf-8?B?ckU5SWVhcnVhQkhpN0hyTE1VbGdhY2JPSlNUZjkvdHF0aVQwOW82cDhCL1FE?=
 =?utf-8?B?SFJiVk5kek9VZFRBeHlvd093enlWTVdkdVd3T2UramVibk5raWVhY1NpMUpw?=
 =?utf-8?B?Q3ZtL1VVTEJCcVVqK2Q3cEUzc3gwejJBeFYwU3BEVEU2Rjl6dXNodXFWbnY2?=
 =?utf-8?B?Z0dnaFk3d3pvS1hkTmI1Y0NNbUpUcVNNTUR2Y0djdkszZmc4Z1duejVSRFlW?=
 =?utf-8?B?djkwMGxzazR3dTBCWnQ5bkd2VHN2bkFwaGpibVJoeWdrN0dpNCtJZVp5dzdY?=
 =?utf-8?B?WEJ1VXZiTlZ2Y2R5MDdQUnpaUXNCcEhIYnlFbE1aSG5QZlhVZTlBSEgycXBF?=
 =?utf-8?B?dWE2NzQxQkdKQUE1RVhBcHNzS3VlRVp5NnFkUm9iNUxDdXdmSGNMcHZveXFa?=
 =?utf-8?B?NWlKaDYydG53SzVJV0phbmRtRDZkSWxVeXhBbXNpVHlpOGxqbGJXYkg2RHBt?=
 =?utf-8?B?UHE5K3E3RlhjU2w2N1B2RWNZTGRuV2x1ZEZiMHVqMFlNbkZRVWJJOFlQeTB3?=
 =?utf-8?B?Z3ZIMVZjWUErdExkUWt3VHJWZUpNQmxUVWY3S3FEWXdMN1ZkMHhPWE5ZK2tC?=
 =?utf-8?B?TGt1RXBYd013OS9Uc01ZUXNYOUZ0dlJRUmg5WlNSWjZSNFJUQytSb2ZoeWF6?=
 =?utf-8?B?ODkrNUZzcHJ6K2dKVXd5eWJYemRzWFJGcTdGbHA3WjA0N1YxTzRUUXhoYTAz?=
 =?utf-8?B?Z0lFVU5ud203T3dyb2tvSEI5VVVPMmVRUmZTOHViMDBPNys0V283b2pHcC9x?=
 =?utf-8?B?RTN2QmRwNVVHU1VydEYxL2ZUQWpReDJBY3E5c1V6RE9XdDMxby9uU1kya3Rl?=
 =?utf-8?B?akdnazNWME9rWGd6YmoxOS9ia1RpdnlTR2E5c2N3eEZ0eGVlQlBhYUR6YUFp?=
 =?utf-8?B?RjZUbmF1VXpZRGRLY3VtajBPekdTcHM3YVUwa1FUR0s2VXZnV3BwSXp0RG0w?=
 =?utf-8?B?SEttSmVZZmR1eDdWYzFtTXIwNEdQd013Mmd4amZYSTBEeG14ekRybUMxY2FJ?=
 =?utf-8?B?eWpvL1pWWldtemVCYndVMVlUaGhoQnRwMHU1S3hDMXI1NEEvQUEzR2pwcW1J?=
 =?utf-8?B?L29pR3Z4QmhnYk9pcGxJRVJ6Umt2dE9hdWd5MVdSR3RWUllYWnd5cGVsaWMx?=
 =?utf-8?B?QnJxenBFL1dScjFoSFA4WmRxWG03YWdFMzJQNWpaWFd1bDZvb21YekVRZnEx?=
 =?utf-8?B?REhJMERiVllUbm5OeWhrOStTNmg5RlkwOEF5UGMyWUZhbGtMaVg4aDFUdm9W?=
 =?utf-8?B?akZISlA5ZkprVzZuUDN0NTFHa1V4SXJNUjdTa2pJZXBQdGpKZlhKSU9zSWVm?=
 =?utf-8?B?NitiUFhxUXZwWFRvdnZsTnJFUlg0Njc0dk9EcUxpZ3lZYUNTa2xvdmFWa0Ux?=
 =?utf-8?B?UXdRSy9mcGpDcHJRL05ETEFnTENvTERBN2E0UlNhb2NydE9oOVBwSFpIMEx0?=
 =?utf-8?B?dWZvMk82cU0yMUtEb1R6Zk9YbENJUktIWXR4Wm1Dbi9qOHhHU3ovS25wV2xS?=
 =?utf-8?B?cWU3WUYvNFBmWE1JRi96NjVjc3RhN1ZSZWRVK3VYQWs2YTVoVnIzSDUyTDdw?=
 =?utf-8?B?U1l2OUNySnpoM1EvZE1RNXJMQ2pRbHZjVkRCMklCeXBnSXJpVyt2ZVR4VStm?=
 =?utf-8?B?cWQzd3Ftd3ROQlJVM21neGpWdm9WcnY4T293SEkzWnZzRjBudmhHa3dwNFNM?=
 =?utf-8?B?UXRaR0RtRGJ3dzZlY2dXaU5NcGhFN3JQSlgvUlJyMVhGUjZhc1VuMUhjSWYz?=
 =?utf-8?B?Wis5OVJkSUpVUFRhQkRpTElLLzRRaXdWQVk1aEwrQUZMOHBzZHJpZ2FlZnhv?=
 =?utf-8?B?QnM1Ylc1VTVTMWFlcXhNejIrcldWVmxkLzgxdnJmYi96VUZFbzJFc3hSYlhu?=
 =?utf-8?Q?9A4OuKHAK33YCYUeV8/fTcpJi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbab8d3-c272-445a-b4e2-08db5e9aeb30
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 10:12:47.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd9Yx1EnJkL5UbjsUXLwjrVfKQwKhyJb9rvrOBCH6FGvCpDptX58SUb9Uc6+mZxaE9eBgJ3yK8Ps4ykNbajT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 10:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11660

On 23.05.23 07:18, Felix Moessbauer wrote:
> This series makes the provided example in README.secureboot.md working again.
> However, there are still some aspects which need to be fixed in the future:
> 
> - Combination with SSTATE_CACHE: This might break the verity rootfs signature
> - rebuild with different keys: The generated linux.efi is not updated
>   and also the old linux.efi is put into the image. By that, the created image
>   cannot be bootet.
> 
> Best regards,
> Felix Moessbauer
> Siemens Ltd. China
> 
> Felix Moessbauer (3):
>   fix(start-efishell): argument passing to qemu
>   docs(secureboot): fix logical issues in example
>   docs(secureboot): make markdown better readable
> 
>  doc/README.secureboot.md  | 74 ++++++++++++++++++++++++++-------------
>  scripts/start-efishell.sh |  9 +++--
>  2 files changed, 56 insertions(+), 27 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


