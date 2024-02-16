Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF71C48260
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 08:33:48 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.78])
 by mx.groups.io with SMTP id smtpd.web10.14529.1708072423709308086
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 00:33:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g+wE+VNl;
 spf=pass (domain: siemens.com, ip: 40.107.20.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcam/erpoIB4IIU7QP1XVrc+hhZ6ZYNdZ6sRO/dYfT610KjOFAsProe4G+0iXAye3/5iAUH/nFWrbAyYIIiTgvvE+WPbWlwYU17vcN38FG+N6dT7NKKYNiMDl3rbPOfdbigvymazJ/bMgu7oEyHI0G9EhBYlkgGQy8e/9NrspJgwqQwbujxcvnJTcoZ34KD4Msp0X9WMqC+q9raEnriP0Yq0SNTLrYhOLdWC4fJGXdtm0uQX7s6ec8ZliRT2cuUgvGb58DzZIcGL2JF4f+Zcc3pAZg0hVW3Q/Zns2xJm8mK7X8wUyXhqR5m0wivostl5UxwkyoXsKVdB4/remlXKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlmZTZTyTpL0xMi+n9i1GwijD+Vrgl+9w3xfCYIM9Hs=;
 b=EZJ9XW1T7zXiOdykVH8q0YaOkjddEVl9wkofMP1WIIO25dU/RHAT0La+gJuVGN+REH6KLutRH0uEhDNChTyedCyfSe6pouasCDW2ZI8IP7kBZ7mWLzO94W9LeFSwBdcsoC6hHTjO0vuB8PijbqUqOkukCWMIrxSXyQl/gys5qbqGHIGIZOUvLOwbPPQdVeCcokcHiq5KlFiTxIrQ0qaOVCDRKj5xjwfzXdTFmVJ7WAmEpVrw+hZt8HDtnrluLXeGwpckzg4fy+pqXQPq2mH9cci9zfA86uAaCCMmt/JDFI7vFUR7/XoC0REs2vFMf+0sOhk9kaURjz+C/gHCq2GFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlmZTZTyTpL0xMi+n9i1GwijD+Vrgl+9w3xfCYIM9Hs=;
 b=g+wE+VNlLUCgd7/HhgEaZIXVXWzIhBLTchAI3VCwm+B67zVwYUVO424W8d8Q9cORp3yt7wh8rmEDXCw7kiu7z+HB91bXRezVJ7qqVt1b9sMJCkMpcwI3Rjsqh//vYrkeZ6/pRMvvOVA92ugrE4rWrln1G7p7ulnV44saOzXxDXZl6WKsYuCR0R6u6+bm/lHfmoY/okWfjAymM/wvvQKo0k33bnynZjtRsVN4Fc/QNGrHYciq8sg/4TsPXeno2XNGycIJtSQg6qS1s3reIW2mt5qNLFa5NTyXphEm4+rcs3Yaa8uLStFHofkwOW2yqztikoyv3VZJg9aIJDQMiBbxcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 08:33:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 08:33:40 +0000
Message-ID: <bbabd895-880b-4bc8-b297-084bffa1ec72@siemens.com>
Date: Fri, 16 Feb 2024 09:33:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/3] Add SWUpdate 2022.12
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e4a2f5-9340-4d08-a456-08dc2ec9fa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Xy7b0ClkrXl8O8/agD/anKrSw9Lh9SkAPWRGiTCEHMFM10nS9oPwlve5j8h3Jq9apaGXF1LX5g7LKGcurR/SrhvvuBiv9mZTCaRkT9RFClmP6NkMkLW31h2pLtTmn/gcJGN6jNt8d4UBxveBqewPssr6Nna2oWL94eu20g+EbFoUhgs/6cGwG6s6rfA8lkr9YFn/jjj3aN0soqBHJU9pexQb2FjvuS4vRZ9I6WD7s641sHO0eqGVTuY5QeUcnE+HWDHoeq8nuDikYkeMVGZTtFifsrpotsMtYh01kjOxZEHxCHoURdWzDvcIQPlEwQ5jfAGMiUkFM6EGY3mVLPAXzA6CrkTgGRfXMt+RZ7Z+9h3awm79WnMigcGEnDfZkDwJZwKNaxrODgf6VWIYrnhn4QKi/D+X02aJaBSbWweep+cFMCX1aJTC27/5IHxrsY9E1fKmNQqFxMZftLfiSxlFonBYirjQlwUbKCpLl4Ivr7zhaiOoK5e06oXoFSZ68QzzNCIfMlaZRJUNI7ydG0Swznsqv76NlS4fTKvPce01SjKAbNAkRZ1myONJAQg9X6ek
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(44832011)(66946007)(66476007)(66556008)(8676002)(8936002)(2906002)(36756003)(86362001)(31696002)(38100700002)(82960400001)(83380400001)(316002)(478600001)(53546011)(6512007)(6486002)(6506007)(2616005)(41300700001)(26005)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFJDUkRwTE1aVEhLR2RmOWI5dGU4S3lmZEYyM20xTyt6OEtPRGJNSVhncGY2?=
 =?utf-8?B?WTVvWjkwR3F1Y2U4ZFRhZVdteWJVdTJiaHozdFAySHpQYTVrYk1tdHpUTVNY?=
 =?utf-8?B?Nm1ocnA0WlRjbTlKb3E2Wlg2Vk1FMk9TVzlRSUdYVUFzOW9weFlkWXllSFBM?=
 =?utf-8?B?SW82SHNHejdsZVd1c25zYTVaMW5ySUsxSnhwb2xlaThUQ1c1NlM4U0ZlMXVX?=
 =?utf-8?B?RG1LekVpclAzVmdtbjFtL2VueGhraWpRMjlVR0ZBZWFxTEhFeW9DU1JKMEhO?=
 =?utf-8?B?b2tldjhNb0ZVWEc3elRBQkkzb3ZQeW1rZVk4b2dOUjY0TkIzNnVqS1Nzd2hL?=
 =?utf-8?B?WWZCNE14RU9CVE5oUVJ1QlBvS2JUSmZmaHBUR1J4YUtHdWFrVVZUbHpNTVpK?=
 =?utf-8?B?eXJqcm9KelZha0s0RDY2dTBpcWtIU2U4ZmJvZHpxazFIcUR3OEdHblErUkdB?=
 =?utf-8?B?ZXlSMjcwMEdTTTEvTzkwQlVvbGU2V01KTUhNdEt0YTNGRFVJL0d4a0lCcHhl?=
 =?utf-8?B?TjRSczIreVgyamJidmhsQkt6QXhOWjVzb2Q0bzVicXlTNjA3d0RSQ2Z0ZC9U?=
 =?utf-8?B?b3JXSFJ3cGJDLzY3aFFIa2FuRVFzc05rKzlraTQ3TFJib1hnSFBnRU51enA4?=
 =?utf-8?B?K3hjUGhERE9aeW1LMjZqSmhWRGdQa1daT0FTVSsrbk5XM1JyZm56R2RxUFV0?=
 =?utf-8?B?a2lra3lKNnVNV0h0d0wybDlNMlMwTGlLZW5BdFBXMWZ4Lzl6akF0cDU4WlVy?=
 =?utf-8?B?OGhHR0NqZzA2c1dSbUg1WXpxRWVVYWRqU3RDZm5JNFF5VEE2TnBoYWFlQUt5?=
 =?utf-8?B?R01LRWI2K1RhUUJsMlhrd1RhcU1MeTVZUWpBR3pLaWMxZjJNdXpUNzZSSW8r?=
 =?utf-8?B?TXZPOGc3N3U0SEZlclZPQUlnTFlZQW9KeWtuVmlhV0FkdG5zUlpIcmRhNXFk?=
 =?utf-8?B?L3FvQndUOEFhY0U4UTNSN0llWTRhOTBWUE95YmY0OVByMm15aVVkdjVxZlYx?=
 =?utf-8?B?YVpSdml3VEdNVks2ZW5UeFloYmhNa0VLYUdEZDE0a3dQam5JWFBGWlVlSEdO?=
 =?utf-8?B?OFRGSEZacFpDbjJUMlF6RFkrQmNhQ29oWEw1M3J4TFRZalhqVFg3MVk0MVN3?=
 =?utf-8?B?UXZ0WUxTQnRpMVdhZHpSZ0xpT0MvL3hlNHBXd29XdGdMT0ZKSlg5ZmNRWjRH?=
 =?utf-8?B?d3pGdExEY0dLYUt1bHlJWjBxOFYwQ0FVekVGWmZUQjJVdU1SUGNnT0VDSm4w?=
 =?utf-8?B?bVJJSmVzcDArSFRjeGRleEpOM3Zpa1NTMENIa1l4eXBuaGNMMjRUY3pnSVNT?=
 =?utf-8?B?b2FqOGQvU1JBRGdCTzdoSU5TQUVwSWR3bHRiZ2JkOWlnbitUQVdzTFNnTG8v?=
 =?utf-8?B?US9HQk8vM2djZ2VHYTNKRTdIL3NHY3h4ZUk5N0Vnajl6eEI4M3pJbTJpbTBO?=
 =?utf-8?B?c05KMjNqOVlXT3hOTjd1QXE4MzhMcjR0bE1qS3FaMlBLT1EzbGhHSjJmaFAx?=
 =?utf-8?B?THZacUd2NVZiS2RTbk9KYlhoZW9ORnR1dHNLK014Q0I5bnN0WlJYTDdzeCtX?=
 =?utf-8?B?Z2lLUFMzRGdhN0xwbWVKcno1L1hyb09EeTd6SE5hZnBYNVBNV0wzUy9ZK05N?=
 =?utf-8?B?djJDRXBnZUtUdFpkZGtCUlN3Z3N3YTlhVkNIRkVBb3VOZGgzS3BIY0hUaGtu?=
 =?utf-8?B?b2ZnQ3pqTm1QRUNyNmZlc0NmR0szMU8xakNHMlpBcFhoS3dKNlpPN3dROGZk?=
 =?utf-8?B?MDdEczhQVjRpZm0rREkyVkhtb213NURSSC9rQlMvOHNBYXVtcXVxQUpJWVF2?=
 =?utf-8?B?KzlxczJPWVY1Q3RxcXZsM3hGTHRSaEhsZC9VNENsNXREbEpGY0hsd1JYMUZF?=
 =?utf-8?B?cy93RlIyNWZKQWdWaUZ0aEg5ZkQ2WWVHY3VtZGwwRm1KOG5CbVNDQUR2ZWli?=
 =?utf-8?B?UkFkcHlNRmE3ZXUxRkE3YW4zNTRrWW83RGdoQ0V5N3AzNzlYd0VBY29lblF4?=
 =?utf-8?B?T01ZNEVEZU9YM2F4SllGTDZNTEdzb3JCNDdxNml1TTNqdW5KQjRLdlQ1Zm0y?=
 =?utf-8?B?VFlBQW11UGthTXRUSUg5a3NZMENpOGtZbUJOajBJQU1kRTJLYnNoanNJV2FJ?=
 =?utf-8?B?NTZIVEhIZEkrN3VMMm1sYWVOU3p2R1VnT0ozVmxhTEMyMm5BekpkbnIveHZa?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e4a2f5-9340-4d08-a456-08dc2ec9fa82
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:33:40.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPS9q1MwphBsTL9aor7+AAjXt9TCTOOpVuJIbQwA2uxnXmLTuaxlk77rz/+Md0slySPKLNDQP7tU8BJ44zudfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 08:33:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15012

On 15.02.24 16:53, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> SWUpdate changed the API for the Suricatta lua plugin with 2023.05.
> To support released legacy application which use the old api add
> SWUpdate 2022.12.
> 
> Changes v2:
>  - Reword commit message 'add SWUpdate 2022.12'
>    - add information from salsa
> 
> Quirin Gylstorff (3):
>   swupdate delete unused patch
>   add SWUpdate 2022.12
>   build swupdate 2022.12 for qemu-amd64-secure-boot-bullseye
> 
>  .gitlab-ci.yml                                |  4 +-
>  kas/opt/swupdate-2022.12.yaml                 | 22 ++++++++++
>  ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++++++++
>  ...ch-to-add-the-build-version-to-swup.patch} |  8 ++--
>  .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 +++++++++++++++++++
>  5 files changed, 97 insertions(+), 5 deletions(-)
>  create mode 100644 kas/opt/swupdate-2022.12.yaml
>  create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>  rename recipes-core/swupdate/files/{0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (94%)
>  create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


