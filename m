Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682DC001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 10:58:05 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.79])
 by mx.groups.io with SMTP id smtpd.web11.14452.1691665081502788370
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 03:58:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qDt15llR;
 spf=pass (domain: siemens.com, ip: 40.107.8.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGO7sK1xGcGVR48vGoyQxWXninMxirUHdQLD4p/2VkkcMtjnPr6Vx26V5HLC3iR8HJJuVPbgmY5VydvvD42DlYzUfTCfA/+j5kW0Ssz98puHdvWlXFyZ7YILQ44qmV3tZ4CPv6MjJUDBtulTv96aBZl3EwkbuqORb9c9mO93mJOIATycNI+KVP/eESW5uZoMJT3wQBvo8PY6dlZJDQmh1j+gXDjbnrZ7nN0F7piwstmGW2RxxtsTm5GyK5YQNK261bKufaINbjhBM0MRdTYQ8rGaBIqvVrLNZT8xvzLfqQ83Uh73zZ6j3zNhlKyNCAxPvqrp7WfByG1kP/nGauTnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t37v72GB8MwckdlsxNRbLW9bc4wKS4jtxd4wtEjGOE=;
 b=bo0y4fo5/krsf2jYSs5Km0eD8Gh+ASEcqWliL61k2xEOD2rSbJTFbomNGQ4yhldofbq/T2c4BHQTukszZkyYAiSBTkFylVcyGPWAQQycnZrZ65ORNmLeY5eufPRBHr40eqTgLoEEYsdExPVK7Ur5RhL3ZM5l2KSxK6N9OrLSYnwJzf0lnDyH7wpuSDIyqfhra3GQrtrqIkO5kdrYM3tPPOp++cl1UZ9k6Y1axHE3Yhwe+uMA/5fRhfvGVb77+MlQ6VCtDlCkjR7X0oZF3g4ol4HqbyV+W3MGYo967a4fi+RVwUrnFqlVG8XzXMH4eU1RTq51eCy2CiutXBdKzEnSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t37v72GB8MwckdlsxNRbLW9bc4wKS4jtxd4wtEjGOE=;
 b=qDt15llRwFquFM4lGZ/LxjpA3NxBkKc7llLj+X1uApsQQvu0TnPyDF84fWt3IjHXLKpxHGMoFJ9ssWEsGBa/26Xh/Li1aRrz6FCblVE05pb8NI4W7XeRxygsDT+o3AV06lpd3AR8a0ylUhHc3Xuiz3rqdr6Ex0W4bD8OZIxXP8ds3XAscOt8yJBgPdU+fnFLxPLuGLEd59ylyzZ4IHMPPkyRA45Eg2eqP2lPqtk0u2sivENneJrkLSlwiDkh4ufe82xAxOuxiCD3n+opA3ZzLsGbarFUlVRI+TGzX14ksm2LcquwrmSNEDIA2NMiEPZ7/YEdEiuo8bhfQv087xZI/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:57:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:57:57 +0000
Message-ID: <e0e2f681-f217-4354-af8c-69bdd426b678@siemens.com>
Date: Thu, 10 Aug 2023 12:57:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] recipes-core: ltp: Update LTP to 20230516
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20230810041948.814121-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230810041948.814121-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3d518b-55bc-4977-f0f3-08db9990a814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bJ0e9ASYy8Ai6cm9NWHbrQC1lH5kPdSuG9Ib20eap3hxry8NVa2LaVK1VO09CmrZDyv29tD7z7A1BOm1xVVrKGYJB+SinZXO/ptgK0IAntSlsJqe8fpnQoWgkv8dOlkcZxvoqZnfIptvYBSSqdlXEcOwGGqUG99rGLbUWKlvJnS/nwfNdnrTtJbID3n5ishDPLc2hCbPtQHGNE/mbDLUb3aV7cfRARIkaGpMTie3hxT4fbIBEM1YCQJ3/Qp18h6fxvszz2ZExosOZj6iIuT1IsEovjH73WjnOUuxYW+glnCubUKmS3w1ghBD1LvuawJJZ2rdgOnW7kbOZ6SQgCDQ2EjDH0U1AOauB+jOWNBTZ53YpfIjiM1+ad9tLVOjVxpqjdnVDu5iFDdbyVTwyTeVyv/PjA42Cng5+liS2lUgv92XP9ioQTEHMOKCkjAhend+Da+03Y47ilmA+qjIaWIh+HJk4tjLYRqrL/ymwGT/M6NKsbEIjRJnR+FAHxHq+V08X7rJ5pnTdxR3zLLGqazPf+/CPgdbrOp+GZRaAIz21PnLJll35hc/mUqdoSZ0eJ0q43DE3dM6lDRzVO0VSkEzPM1vApNsGy0gwbAJ5z9hHuLqN7rjEyyBGrwJPIuny3ME2Bjsy2jla/WI0Nl4DREELA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(1800799006)(186006)(31696002)(6506007)(53546011)(26005)(478600001)(86362001)(82960400001)(83380400001)(6486002)(36756003)(6512007)(2616005)(4744005)(66946007)(6916009)(4326008)(66556008)(66476007)(44832011)(316002)(2906002)(8676002)(8936002)(41300700001)(31686004)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzFINE5UVDZ6Qkhad29WT3h2ZE9GOGJhYUZXUnRLeFlIK05OQ3V4UXNlSEpD?=
 =?utf-8?B?cGN2T29kV3ZYL3VxblgzOExocXBPQmZ5MHZHc3YxVkdSVk02OW5iTEFJeGEy?=
 =?utf-8?B?UlFDSm15anBnY0ZET0U3UEI4N0VCRUNZc3grbWFSUmk3OC8yakJlU3AvRXRw?=
 =?utf-8?B?STFYeXdXVEg3ZUloTkFMTGdYalZkMUNXNXJnS1FOc3NvaWxKTnFTVzV6aTVB?=
 =?utf-8?B?UyswdEQvaVMzYkdzYXZhSU1WZDFNRVpTdkc0T1NxQmVPZjhqVTljcUlab1NX?=
 =?utf-8?B?WnRPWFRvRDRGOW1MZjd3U0kxMU1iRmo2YXEyaTlIY0FBTXl1UVVJMUdKL0xs?=
 =?utf-8?B?Z3p5MTZvcFBwN2lzbVdxNCtRK3hLcm1UMTczTFh3RzNKdC9DN3hBUFFCYUF6?=
 =?utf-8?B?RnZJdU52cEhkVmxSdXFPQUw2clI4Ly9sTUZreXVMYmtxenY2d2Q2SHFSbGlI?=
 =?utf-8?B?TFJXeUY2Qk5YdUVuWlJ0dGpraTRVYXl5YnFKRkJQQ3dCZ2ZkcUxTS3JscG9J?=
 =?utf-8?B?RU1WOXgrS3lnakN3QWZNRm8zL3RoZ3hGd2ZuczVFQytkcmRXNWhRUnNqSytn?=
 =?utf-8?B?cWVyV1h6VUUrRkd5cCtzdVg1dndlMWNWL1UzcXVUcmQ5cDVhaCtKOWRSclp6?=
 =?utf-8?B?QUJHdHI4aTQ0QlQyUVhNVEdCdXFMRFZNWG1wdSt6V0VjQTBQQ3BSd2ppL1pN?=
 =?utf-8?B?bldYck12ZUNLOFQxWjFjWGVVNDdSOTdjT0pHTTdOTFVKajNRMndSSDN2RFNS?=
 =?utf-8?B?OEZ3dUZSZjNQWXYvdThVUng1bmlRVVZZMyt3Y2ZnTXhuVjRxN1RnN0RFR3dT?=
 =?utf-8?B?bU9HR1o3MXZnQlRTQzJuSzFWWUNXTHFpQVRXZFJkSVJvUElVbnJCa0hScEky?=
 =?utf-8?B?NVQyNmgxNW9vUnFJRXRzbFFZME9CRERnMFg1K1hSRnFUeDNmM0JZZG5KeldK?=
 =?utf-8?B?ZGhmOXpoaysxRXhqa3VXZExJV0RyRVpqOW41RjNhZHV0RHl2NkZENnB3aUR1?=
 =?utf-8?B?QnRveXhYTlRXcUp5N2ZZbCt1MEp4ODRPcFhvbHdQZmMyWFpkd2RsL29ocEs5?=
 =?utf-8?B?eThsZlZnMW9ZZW5ZVGcySTNNUTduZ2g2akRCSUNWaXA3UUF3TEdBQkpHQmtV?=
 =?utf-8?B?Q2hqN1BYdlhlcmZVMkhueTFOQlltZFVmOEZTMXhIWVo4dFNJd01xbWtXSHFa?=
 =?utf-8?B?aDE2RTNvWS9VakNTaFpoaHpPU0xJSWpmLzJHSFIweTJmZzFiWWEwRTlZdlpW?=
 =?utf-8?B?dmxOTWs4MFNXcDd6UUZmeWFvR2c3VlpzNlVtNTk2RlNEc2lWdFV6Q2N6Mklu?=
 =?utf-8?B?cU03cUc0M085QjJYRGdkWUErWDc4dDZUNWlWcHRqTlhhZi9kYSt2eFExOTc3?=
 =?utf-8?B?blZOcFdBdmpnVERIZVp6L0wzWS8vU0lwVXhDdUcydXhFaDdCaFgvT3JNbDNY?=
 =?utf-8?B?eUtlMzhUc21XellaSUx2Y3A4OVBndjhYM3dSM2cxczRqNk54V2VZWmlpT3RL?=
 =?utf-8?B?NkxEeUswN2R3WEp6SXFjbkVsRHlrRlNTR2dBUE9aUWwyejNCSUxqVjhRdXd5?=
 =?utf-8?B?Nk11M3p0YW1OanNKSXdhRTNYTHVDSFBvU3ZzbC91bkJGbENnaDJPVjhGSWw4?=
 =?utf-8?B?SXV1bnBsRVlmVGtodlJNNzUyODBabWIraUx2am45Z1ErV1JseDNaSGxIaUZp?=
 =?utf-8?B?Vm1US2hDUGtBWm9GQkdPdWFjR1A5NnNlaUZBQ3Q3ajg2NUo2OGJncTZ3RUJQ?=
 =?utf-8?B?cExuZ0NNSVJ4M0RIVTk4SFVLcit0T0N5UHhaelJ3Yk5PM3FSSVl0b1lSK2RU?=
 =?utf-8?B?ekVUMUdkWGE5dU1lRHp6VzdsN1hJRTVqQWhUZnpzVDE5Zk51SUFKSFpPcEFB?=
 =?utf-8?B?MzI1eUovZlBWVzV5S0JRM0RILzg3cno4UGhQUnFFbEx4MnBiU3Q1M1BmSE1O?=
 =?utf-8?B?UkxkTW9mK3M1NXh0cG1YR0xqTk4zYi8vVC83UnNTbTVwdXJrOU1DaklRMFVo?=
 =?utf-8?B?Rm5wUTJmNllYVmNDTXA4b2hxQ2RNWlc1STlWU2pqOE5uZmZ3T0RJM0IyNHhG?=
 =?utf-8?B?K0RzWS9XY0xvZ3VPa3RZaU9OTHM0R3ZlSGF5QmdwbkY1Mm5KV1R5T2ZlZXBa?=
 =?utf-8?B?RDFXZE5JYjd6d1lVN2hXSXFHN2RoRlJ3ZVJ4TGFOS3ZaSlRCK1o2b0hmUXFR?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3d518b-55bc-4977-f0f3-08db9990a814
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:57:57.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6LiGm/jWeaZKahR+0Sdyuh3AG7u6Qhs7PnWIyBjzAiHHi1UM3mHXiy2g8nUFBU72FGXt8iT7U9LyGsQ1Z/5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 10:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12595

On 10.08.23 06:19, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  recipes-core/ltp/{ltp-full_20220527.bb => ltp-full_20230516.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/{ltp-full_20220527.bb => ltp-full_20230516.bb} (69%)
> 
> diff --git a/recipes-core/ltp/ltp-full_20220527.bb b/recipes-core/ltp/ltp-full_20230516.bb
> similarity index 69%
> rename from recipes-core/ltp/ltp-full_20220527.bb
> rename to recipes-core/ltp/ltp-full_20230516.bb
> index a99f301..943340f 100644
> --- a/recipes-core/ltp/ltp-full_20220527.bb
> +++ b/recipes-core/ltp/ltp-full_20230516.bb
> @@ -11,4 +11,4 @@
>  
>  require recipes-core/ltp/ltp.inc
>  
> -SRC_URI[sha256sum] = "d635afb5ec7b0de763ab50713baf9fbf65cf089da6e6768f816e4a166cbd17c4"
> +SRC_URI[sha256sum] = "d78f4bdd5bdc9e91357631954affba7e66190a2509c369b59f55efd190268956"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


