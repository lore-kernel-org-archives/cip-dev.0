Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D5C678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 07:22:14 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.53])
 by mx.groups.io with SMTP id smtpd.web10.18144.1677828129661182402
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 23:22:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fHdbtvHg;
 spf=pass (domain: siemens.com, ip: 40.107.13.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POMVAYDIfydoRdcG+m0DnhBO5Q2WiRxEFLPpdVsyHXKKVhzpU+TpQhQwdirisVZadZn3hErEWN2/wrxEVhYIIlV4ToYuDjmtVH7AkaHnTkbAUbzODG59oQ+yzzpiEiFfI7csPYzpDsMhSfPFvbrpI3yr7stzAUKsWK18RdLHgf+v0+KufuH5+CWOBZMGz1SC3Z9Or2pVVWsFe+kWF0dQamvCteh9Do2nuxQTJUhZ85JgryjupDLqt4yawAPAhvuV8SQGxH8LrgcnOMEIzcGdGbgMTKSsG564UNWTn1xQekiJKu+kVFVmzHTrNX7b2B5eZSwd/V7VsBudm4To4/bHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZon1VUjgtt7kMWAl+9KPIYNRuA5zNcKr3SznvfNhQY=;
 b=Fonxd+I+ZaaGdYyS5w6gPnVk7X0CiCReBbLMx7Db8TeEpt3GsXTR9Gft+gXZcvmqYHujykwpZsrs443y4BRneN55SrSXkVxWzHLc3yfAtcgXIK0uD1Kyyvgdp+JlTFJWCuCJqXAIXqVxcaOJAdS/iR6AyKPGX5RNNh5+uKmo2cSy1DIyCT0O75/ISOX29PJStD59IdHQNM0GRgJhyn1WjkJB4Bl59xjhEQoXzHGfSwfcimMSu6SKTx3ObhoGV4oHzdfVKYbbLIpPOIVTBHL86IDP83c1w9P4CbgMH7Cn3PkExudrGOtYN94EzWOp4P0ZlW6Z9VgqEBvYxDbk9sRvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZon1VUjgtt7kMWAl+9KPIYNRuA5zNcKr3SznvfNhQY=;
 b=fHdbtvHgNiVD+euUM2C+qMInguV+JlRFaDpnJ8U0KOqrOPcKFD2D935+dMjscJJktMLLcMKNfO8o7uG3FLGEu5k/JR9AT1IPkn08ot7KX+ZEHJzSj8K8sC6YBzLGA6wxwrr0GQ+9KXK3HOdAdqGHxUoPG4V3VBwNXeOrs3T3fB+Fr8r05OJbIiz9NkWKFzvKrHakPzf8A0SCo4vyo/yGOxTyV4pycrs1dQeexR1M8cUO4hTavaAgDkss5stbAHlUL9Xg8klK0lT+QQn9nJJTxJWCaFyw0hJbs6CaQo4xUeQE1BRatU9rqw5HZxT5u8BbDKODDy2jKJzgIgJbsnfLGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5634.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Fri, 3 Mar
 2023 07:22:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 07:22:05 +0000
Message-ID: <2112fb54-ff20-18af-6b49-60cf48440c20@siemens.com>
Date: Fri, 3 Mar 2023 08:22:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v3 2/9] update cip-kernel-config
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230302152659.2096307-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: b32b0e7d-ffb1-4ca5-db36-08db1bb7fde7
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i1H1/3Y1d008MsYWOXwe08Z3gfUsc26ugefzeSmIhS3OlSQord9se8TmIPCsqfMrlzSBeXa/P6+Ri3MPCIoK/Y+0RajKfcpHR1Yv2q1j3v8NA/X+8n2GuX9O8Mq3Bfqo4IqJZ0SkQVAPNov09WHpw0b+VgllgxI4tYjELrxtQ4tHAJlHwmO3QUGAFuWjDFbAVPlAlgfVZ1XdacX+Xh5l01TGHhPvNKo+dLSCgWiTpOeMdLucFko/+EIa77+wI/wtl1hn/jRf/UAbcM6WF597WvV0ALkTs6bnL9SrQwFq/5w3vJiKy/Mz9IDiYHHktKfZK0H6qO0Gdf9NU95w7r/iJPmdeKEY0Lhd1okbmn0eciswLk2XnIM5k+cnPg6+dPIB1VUEousxJFmVlEWpA0DPue5tKY5sxmeG0CmncvyI0ELwGN53O+7ueB9YzSZSs3Cz48EYZpZ0JRiLLlYCqbTF1U6n/4hMyQsPuSlomuPjvqIcT3ZjD8jzV1MoNiN3te+iuVx8e/OidLcqQOTeQhZTbOhIpA2QCGh2+Qen/Re17alZYlF3Tmm1/BQFWfrokaKwzg4c6GKAda9uGVuY1H1P+/Tnb1WgNrYV1EII8pclvdVzqGZ0gn5Jq4SuWCRda3Ll2hIdvLeDSGVsFjpoez1VgvbXJWtzdjctIUFz3uQrTK3PTxfFaSsxowVXEZt+Xg+248wBqHLpuSMLGUkJ3sMJFif0owkwssuM4TgnyXEPRt4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199018)(316002)(36756003)(83380400001)(86362001)(31696002)(31686004)(6486002)(26005)(6512007)(8936002)(5660300002)(478600001)(66556008)(66946007)(15650500001)(4326008)(8676002)(53546011)(44832011)(6506007)(66476007)(107886003)(186003)(2616005)(82960400001)(41300700001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTNWb0luS3pWTWNFY1ZrajlzcWQ2aWh0K29FSXU5UndUdk44WC9sL1Fjb21H?=
 =?utf-8?B?UTBKaHBuRHNvYlV3L2hnK0ZZQ0xvOTAwdzMrVS93M0hyQ3FkeVNVdHY5NytF?=
 =?utf-8?B?aEpIWmlrNE9JazhOeWdGc1liV3ZSbUUvTisvTHErZkdkMDJKTUoyMXpUR0o2?=
 =?utf-8?B?U2VOWnhKVGtaR2Qzcjg5bElKUngySE1XTkE1em4wdVhuc0pYS2toRmtOYWJy?=
 =?utf-8?B?VG52YW91OHgxSldETE9aSWxsZGlaK09VRzVHTGw1ZU9WZU1jdUE2aVVMc2Va?=
 =?utf-8?B?YTBmNWhwdExxaXpNNkJUT1UzRXUyRkhWeUEyZ3VJZFlGZHlIQkZvajd4V1VB?=
 =?utf-8?B?UWJodktxdGtsN09RS0J0TExWbEJPOVhnMWtwNGFUYXNZR1BWYkZpTXlHbHRZ?=
 =?utf-8?B?dzdWYnhWSmZxcDdFWGt0QnRBdHZMcm1xS29qa25VVE1ScGxRbG16d2xwUmxG?=
 =?utf-8?B?ZFc1ZGNuT1BqTXczWHBVZU05VmQ0bnFUUVZ3azIrQkI5UWkwWWVjb1JzQlgv?=
 =?utf-8?B?Z3JMNXNXRkxHcVpYc2FjNVozNmhDbVRaMjN6K2JpOWlsaCs4T3JTSjhEY09W?=
 =?utf-8?B?REdib2xFLytuZDFSeHNWVlV6d3NIZjFMbC9IbFN4eHRhWFFCd1R1Vm1SRmlp?=
 =?utf-8?B?aG9NKzhZQWV1Y1kzMXJCOXRNaGRudUtkZ1krWEkrdnVONFpoWkFkVnZlbGtG?=
 =?utf-8?B?Vk1sOWFmTmpGU0ZhT2sxWUlDOWRLYVVZZkROMzRBK1hwRHdjdExCMnBNSWFH?=
 =?utf-8?B?MVpRZzhyaWdINDRlRjJoZWdFalZnQmxUblozSFJwZkY1dUdzQWhCaFN5cEpS?=
 =?utf-8?B?NU5od3ZGNFJld0Flam1tazREK2dOTUl4cWhrcHByNkY1Um9VTlN6TWcvUXFJ?=
 =?utf-8?B?UkU2eFh4MFlwVXJlUHM3a2UyMGNBUXQ0QlhkNldrZzJMdU0yQVBCLzBUSFVq?=
 =?utf-8?B?cldjSndKbjV6NDB1bDl1U3pNdzhXN0hTRjcySEZkR1VwNDU5WGgvcnl5ak81?=
 =?utf-8?B?eGNrQnNCVnZZL3F6WnFpcFlyOXRLWnV6Q3N5b1oyaHkzRE0wT1dnem92T2Yv?=
 =?utf-8?B?RVUzOWNyaGV2cklaaHlvdXptSmxwTDlXQVlNdTkrVkpTR1RjQTFtMFNhdmxr?=
 =?utf-8?B?TjBHZng5blRmUk5EWmhiOXdDNU1qdk0rTWc0Wks3MFJ3NGpSaGlGeDR1bUxS?=
 =?utf-8?B?RUcrTDZVZDcwdDk5Slhqckx3NXYrRVdIVHdkU3NPZi9UNm55NVFJZjdIa3Jx?=
 =?utf-8?B?N3hyakoybmY2RnpvWFJuVnhOWDdTTHJDV3lYNGw1bWpYa1NCTGxwMUc2SitQ?=
 =?utf-8?B?a2FkcjZjdUNMeGkxRC9FTG1nR2R4Y3pxa2tFWkVoZEYyK29HcjVEYUFJNkNK?=
 =?utf-8?B?L3Jjdi9rRHNHckhhaVhSVmZtcVIvUmpSYm16UGg2VGJSa3Y3TzBtZDlBd3lm?=
 =?utf-8?B?MXBCV29JRzNHZTR3Q2UyY1d4Z0JZbERVYUQ3RmxXa0tYZ2R1cnB1YzkwSlRJ?=
 =?utf-8?B?VlFmMHRpYmY2WjA4QlU2WEoxQ1hlaFI2ODVNalBWelE1dEhIV3BxTktuUFZU?=
 =?utf-8?B?MEFPQkFPU2pZZGI5czc5bmhGMTg4dmo5SjhONkVibHJtS2pzeW1qTkRObXEy?=
 =?utf-8?B?RlEyQkpEclhXalo5NkExSjRFR1Rvb2RMVXUxK0ZNbEZSRVZGdHhlQmVXNlFt?=
 =?utf-8?B?dW8zMnBiL0oyQ1pFMng0YnlFUmRVYmNKZ09PM0tlZ0VhdkRxWm1QZlRTUXBB?=
 =?utf-8?B?UlY5b3F2TEVyeTdSd2pyK1I1Q3lLMXhodFMzc21GMTh2bDNWQVpHUklLcW84?=
 =?utf-8?B?V1crQnBRQUJreE9mWUpuODlqSDZxaUo4c1psa085dS9ScERqdE0xT1dhYVJp?=
 =?utf-8?B?T082UktuNUhXR01vNXNJbVMvUkNaY1E2ak5vREVBU1N2U2FZeHc3ZXE2bDFw?=
 =?utf-8?B?UzZkeEZiSDhCTXZBZFBIRXpmMU9Uam8wL3puc1NxY3JFVE1sckdaSHBnb2Nh?=
 =?utf-8?B?Wkl3SHgycGl3T0M4NmlXTFJPcU1sYUZFU0pQMS9tQXpSRC9mK1V5MnE0L25O?=
 =?utf-8?B?azBQelFERGd4ZFBDc3Z6T1RPS2w0V2h3alZ3Ym5jNGhhWkE5MExMUHZvRUZM?=
 =?utf-8?B?NEpnQmJFc0FJSS94QVBCcG9LR2w1N3poNExLZ3VPWFNhaXlwVS9nb0M0YzIy?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32b0e7d-ffb1-4ca5-db36-08db1bb7fde7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 07:22:05.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuFnogtUWlsXnVS6uxY/S3CeG74H2NK+5A+cfPxMu+SdU7WkmO+TxeOcI8XXb/ng3jKaA50Oocka+S0F9KclEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 07:22:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10894

On 02.03.23 16:26, Felix Moessbauer wrote:
> This patch updates the cip-kernel-config revision to 3515389 to get
> support for qemu-riscv64.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 7148a98..6dda973 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -23,6 +23,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "ce52837418aea714e780e0cbc8afb9515c12cc1b"
> +SRCREV_cip-kernel-config ?= "351538952cfa7c6336e83bf66ca4f3bbdc06f89b"
>  
>  S = "${WORKDIR}/linux-cip-${PV}"

This also enables TPM2 for qemu-amd64. I'm extending the description and
merging this already.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


