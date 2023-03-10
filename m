Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA85C64EC4
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 11:44:09 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.78])
 by mx.groups.io with SMTP id smtpd.web11.17100.1678448639246213748
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Mar 2023 03:44:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SU+R+puj;
 spf=pass (domain: siemens.com, ip: 40.107.8.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewTMRAvZ3DYsbUl9PbHdlRhF1miDwbxhTCf9M8luVHLphUFiCwUJFeDnpWXXj2QNbpLXwGO26HSowr1jrZIdAap1OJ3pbz6Z1clI0qKl6x4Lni3t+QXqspN1kT/lXWf5A8/BGzG+H5U9jCN20IAOV1NIpSvW2p6BQeY2TY9cgCdL+jDL1wcaux2DPwLuaA/LRjvccr2ylhtUP6/MFWagFetst9LNWcr3Uv6yVs3qibTTc6IkGsqqrAJ9sHmGdyF3RlqDe3m7Lzc4xqXCiZuR+5jTAdySAjJZlpRMVSGMD2EIhSEUN83Gj5rcN5xVUe3xJkeKjIK7fjdbfABEmZ3s/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHAoOq4szjA+XDcXSlR9voA/UDD3uEegKzt4kiH2MU0=;
 b=UtJ7I6SYmQxaAuk5mdoSLs9oaUcfIulhorJCLKBVFux5jAwY3V9danh8ma8IDt3Gqw5+TETzsDdi0mOFYw3DMyLwtmPWXKIvdXQD+hw+mu7VovzkGpKN9bEiAfYdPih+/QhzQQmEuUmTHescy3ju/eOGrm84txdIkS5G8RWC9V4NjkW4yRre2rmc2wQ6tbc6CVmGTlLprxP536glOTEJ7Ar5CiQ2SOnahFjTyHR8Ljm5Dw9txXys8NjN6AwF/bcr948r3SdlZrCYrZKMY4sg6T6HPVVcjb/5+FZECuMpiY+LKg5Syzc8+ElIR/TeihedYDpsYRC6tsxlSwrDlnHvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHAoOq4szjA+XDcXSlR9voA/UDD3uEegKzt4kiH2MU0=;
 b=SU+R+pujMTockf95Jv9FJA0RuI45/xEICRxxCeF7NcfYy9eQdSnYyIg7gV16D6d2GuH/sIhwnxP9iOu8JCznHRgwmvxTQ+amRPa6v2lAU8veQWh02xKLyBUvR1zNkGz4Vey3l3D/e70EVh5oaPS2TP+EL0MMVHV9KvFpSXxOaCHjl1ahm7xbyEUtXvJyeN9lhpgmnWzO0Y29Vk7XmbxQMHEaTXQkIQHGodyAUh3nA4Imw7zu2Qv8W9+dvLiwncAhjHUehj+H3/nyB9dBnVXvKqlx/5RsuDHowhXWXE/vBwVDD2jDdOqLyf6Y4JH6xT2k1bcrYnokEDJtEfOioZj4vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 11:43:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 11:43:49 +0000
Message-ID: <0275387a-2c4d-164f-7746-d61abf40c6e3@siemens.com>
Date: Fri, 10 Mar 2023 12:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Content-Language: en-US
To: Amy Fong <Amy_Fong@mentor.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp,
 Pavel Machek <pavel@denx.de>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat> <20220110175519.GA3396@duo.ucw.cz>
 <20220110180635.GB3396@duo.ucw.cz> <YdyTRgrErYXoQzti@cat>
 <20220111090218.GA22781@amd> <Yd2XhiWzYwTbFp/c@cat>
 <20220111175356.GA6859@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220111175356.GA6859@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:b0::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a10040-d4f9-4c98-1eb0-08db215cb6c2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
 mYv/LcfDQ9jzGY1D8hoNSFZ3ZKP5w0EJRHx7b+Llp1ExYpBo8T1RK/+kadY9btZLNsPqL4rCq1oSHnWpS75kUASLFogA0YTjsxA/WeTNPH7oIkhGObMibZsXNeaMELoXX+5hTC+wk16M9kb2qEK3fnY0EqbCE/AC2gWW6AVismKn6u2WPxcZgBZNtImwwRH8UBM7E4g2S/Pbvx1RfLnHMW2m7pAb8sd0tvpgh4M9NbOXsi3n5lUM7SECi2STxndLvOybbs3iawZkqbqtHue4u2hFZxqpzxT+GJQcSwspKBraRBeegyC7lx9o8/6c7/UIKzhfh8ejBLE/BC8PC4CRcwSuAGiwGnUy6BBORGENOAFe5Yhz1Z+XNbjQgCRCaXF4jT+7OvUCOcxBpW7q3vX5A1ZyVjM3xoIgPvk1G1n7FFDyFdy4MtfrYUBBW5PbKbxou1/W0yLaxok1/GwOMqhUzCkv03F1tvZDFdddjJub8v3HJKRHOHNi3zinuHUEbgpfLhL42QiMoCm/pDfTI06ZNAm0kr+uvGHL7wX9DZIZgO9ndRuH4+b0yCvPsHriD4vpJdUJe0wsKGFvKLsGF76zsOa7jHlJwfXsyzSly2smN0fRoG4mA0bMBy5/UIEhERQjSxYwvwV6MixANDRiIws0gDSiL/4e7euXuXAK4uJO3PqhwOIyWxw7G25ZV59aPfEFJRNEQMs+bQWuphZFs9fWnxh8IWt38t82GdpczZKYR5U=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(66946007)(5660300002)(36756003)(4744005)(44832011)(41300700001)(186003)(6666004)(6486002)(26005)(2616005)(53546011)(6506007)(6512007)(66556008)(4326008)(6916009)(478600001)(8676002)(8936002)(66476007)(38100700002)(86362001)(31696002)(316002)(82960400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?bi9aMmlJUHMwSndmVzNIYzkyU3NEN2ZmcENxUzZpUGhxOFhJRzJlaFpzWk5X?=
 =?utf-8?B?MzR3QjUrYTVYQUk5MVhySjR3ekVRWjNoMnMzaWZTd0VyM1p2Tms5amtGbEtq?=
 =?utf-8?B?SnVUSFBNQjBiaU9sRzFTQkpmc0tSUWJaOTFTVzErd3FGR0hjMW5hUzkzc2x2?=
 =?utf-8?B?OGtIZnlRRlJIcEhvdHBNMjRpdEsrVXZEN1NsN3FkUFZlcjJjYmw5cnpMcHlV?=
 =?utf-8?B?SFB3R0tVMEZrT0JpUXkvU01acWVta2Zocm9HMHh6TW5UcDJLWXNzc1gwZjUy?=
 =?utf-8?B?TDQzNzRlMWNMT2dJMDJpL3ZUUWRlOVZ0YzVWdU5CdE5LS2xaYVpabkxiOFB3?=
 =?utf-8?B?czFBTGV4ZUxyVERqVkcxbmZ0c0FrL1Q5WS9vcUdQbUdoWTRWbFROUWNLaVNi?=
 =?utf-8?B?WWVxaktWeDVSOTlTVmxYa1h2NjVuZHdLRGpKZGMxUHd3VDd5MVdsQTFERWFs?=
 =?utf-8?B?eWpGRGtGdllOYTdGTEk3Unp6UkxZU3REMndnZUVZUVQ5Tm1wa2hJdkRFbk5r?=
 =?utf-8?B?a0pwSzd6NXFvNWdjbXdlVy9iUXhXdjAwQXowNEplanliazB3ZTYrRnhOYldj?=
 =?utf-8?B?U3ZWQkZUNnpnS2tTeHUrdHUzTVZKQ09wUzc3Wkc1bmFEaGR6TTNoOEVkQU8r?=
 =?utf-8?B?SHhCU2dpUFAxV0dGQlAzR2cvazFyWVU0SmgwckZkWDdmNnJ2N0NKK1hOdFRG?=
 =?utf-8?B?Tk1Xc1loM3daKy9nc3VvQ3VWQnRzd0lmNGtrbVYyTDZCMkZSNkgwa0lFN1gr?=
 =?utf-8?B?TzQ0NzdwYW1FVXZ1Rk02YTUvaFpPblhEZWkzWnRaZFlLZ3lyeDJVOG5MbGxi?=
 =?utf-8?B?ZFcvOGR0ZnhXQXIzNit5cVQrQUo3MzBVYjdoR1NxNmtTejJHWENPNXUyMDZU?=
 =?utf-8?B?cjFKU0gxWWJFNUtiMk1hdzc3c0liK2VQcklqN3JtTmNiQnBNd2llWDRQR1pw?=
 =?utf-8?B?UVVvQm4xMUZyR1Fhd1hDZUQrbWQ2UHR5RHdLcVl3REpWWTEwV0I1Q0pPemRO?=
 =?utf-8?B?bUQxWktwSUNjODcwaVJhSG1NclV6eHJ4ZXVnVlVhaDBCVitLMWRRSDd3SG5J?=
 =?utf-8?B?WWI2MC9aWXVMa2VUME83V3JmU0xTeHRhK3h6S20wTGZ5TXpHdDRtZlBRdHdi?=
 =?utf-8?B?dmJMUk5ldUQxQ3lBTzl0dm92Y2t5R1l4SnNDTlZYcmF5WE41MkV0aThSQWUx?=
 =?utf-8?B?U1dhQ1JoclEvbkZLNHlYY2JnUy96YUhDOVo2aUUrZXZqeFJhUnVZRVJVR3dX?=
 =?utf-8?B?ZG9YT2J3aEc3SGpyNjI2NDQydU56NTlvSmVaM0xZczBuWTZhSkxrNzV6M1B4?=
 =?utf-8?B?RWFiRkxnT1pEZFMrSDhNZHAyTkNEd1dmQjVwNWpBQzB0WXU2UG9ROXRPK3Bk?=
 =?utf-8?B?aEoxNVdJdHlhM0YzMG4vblFkWlU4QU5ZOGpWYjZQZzRkQmtJUjNYZnFMcjNl?=
 =?utf-8?B?RnpGTE5SZm51TUx5ZGdXdnlxK3NVdXdoakI0QlcrTDNERGl6S3dKTEFleVB6?=
 =?utf-8?B?ZWQxSFRscnJsWFlVZXB4U09ZTTVFREowcldkcVBrVHZ3Rk1BUnZBWmJGUjla?=
 =?utf-8?B?MkMvVFlHaGZLV3hsYnByN0FMalV3YndYR2pabk5FOWxSRFdhMUVQUFoxNXdi?=
 =?utf-8?B?dDhNUTlkQUZTcmsvVG5zVjNIV25ic0RqUEVDSm16MWVOa05pTnRlZzBWcGNB?=
 =?utf-8?B?RE5xSklHSGxLUU8rL3N5YmZ4dDUwWnJLY04rZGtTMTZoTTYrcnB3MmhRYnJC?=
 =?utf-8?B?Z1Jwa21JSFVydVJ0QXVpRmN5ODNJRlArcDFCTmxkKy9sdXRVaXpIZTBNLzgx?=
 =?utf-8?B?b2tCSC9Nb0VtQm5KTG9Vc3NnbFlxWVVJQXA1VlZpeCswYTJvTFA4VjViSkpZ?=
 =?utf-8?B?dkE3b2FCREljbzY5R0s2dDRNSktGVTkrQnVqQk1maytDcGlrVXBxeEIvS05S?=
 =?utf-8?B?ZDY1UTRRYUs0SFZXK2poOTlzdmpHRFlpSlhnbE1RN1hHczcweVk3MndrbWdW?=
 =?utf-8?B?eEJGYmQwWk1LY2svalZYZ2V5ZllnNExvblVtOWo4RUhESUFmSFp2UjA1ODJh?=
 =?utf-8?B?MkFCdG5zQlhuVGJ3SzlxbjVZbk9BVzlrdmMvVjVJdmxuTWo4VjhrTmtnSGg3?=
 =?utf-8?B?RjNIMUJPVW1jRHRHMXVHSSs3S3haaitLa01sTWhWZWpGVmkyZmtSZllFQnlS?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a10040-d4f9-4c98-1eb0-08db215cb6c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 11:43:49.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNZykRYWQuDFbAA/vby66RrSlGbsCFExusv8YeQQDZ8Qw0GM7vExugg29jEZC+RlW47Tl4DpqhA/ehJ0EAkJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8093
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Mar 2023 11:44:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10974

On 11.01.22 18:53, Pavel Machek wrote:
> Hi!
> 
>>> Is there reason not to submit it to stable? You are describing it is
>>> as a bugfix, and Greg takes those. [Advantages are a) community
>>> review, b) less patches to maintain for us, c) bug fixed for everyone,
>>> not just us].
> 
>> I will submit the patches to stable.
> 
> Thank you. The patches look good to me. You may want to include sha1
> hash on the first line of changelog as
> 
> [ Upstream commit c1833c3964d5bd8c163bd4e01736a38bc473cb8a ]
> 
> ...as that's what's usually used in stable AFAICT. If they apply to
> more than one -stable version, you should mention that. Feel free to
> Cc me.
> 
> Thanks and best regards,
> 								Pavel

A colleague just pointed out that we still have these internally while
4.19-lts is missing them. Did you follow up with LTS on the series back
then, Amy? Was there any push-back?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


