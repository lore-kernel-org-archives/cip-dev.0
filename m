Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEB4CE79AC
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 05:39:50 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.48])
 by mx.groups.io with SMTP id smtpd.web10.30495.1695188384627170385
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 22:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iYuHiRwF;
 spf=pass (domain: siemens.com, ip: 40.107.8.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtWXa8z4qNfH3fUZ6AnEDwXuKAFQpfnm/WSb42Xg71Szbngw1QTfLtYpOklUJNb4RSMtdjdTVWOzgKLgkIeR0hep/I8Z0kF2hKvB+61OpicyM0lpit2ktquF8P9aa+q3GdFuNpcSO3yymeR/GwR7LDAx7FL0m07itaK2/rDzZBzaKSuma8COZbHs3orbq9JODR1D/QFZR0WcFDi8h08RrmHuYNKVY35M6VJRgentHcEmRAuBFgpmNx275ib2qy5UqVKNdKoswk4v5wNJj11GQn91y6R3cQVFiV1RKJJDuHfY7uCcN0RrY/fz5RRaAZI1TnmmuXUiyx57DevK10dHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMuhkVpSVdMenwabcteX4XifdHdOU6zVYf2LR6MvZUs=;
 b=Vb5jkVMB3EWGoM0Q2nkajiyIE1eESYXaegt5pgXw03y0jarqWWB2RNGpPR5CDfdbCWC4ep4lyU7XoYjLKegDxj8Qbaugpw2ekuthoOzU1k57OLnsmgD4BHa4KMplOoFuHH9/MpcJAwPT3THsIMzW0qi8OdE8ltkJDA2s+Jsi4OagXNNYOwDXsK14gfMh67uckng4i4JZDXcPGRE1oaOIkKEiC2S6bC1Bb3k7OUD+jiZnyiOd5+GHv4B0zFHolQ7STiVhp15/QqvB0Fg/ps1brryGpXWdPf/Ew5c+3ZpnyCPmwTp9KPqstiZzQhanxNbBxSqLjqlOfX/hT9vDDnUiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMuhkVpSVdMenwabcteX4XifdHdOU6zVYf2LR6MvZUs=;
 b=iYuHiRwFfwQ3oxE+0zkXg8dS3b8HqFjLtD6gRH1sQvZUxUX2KPc/t+BFtslaQaoSyGFApbguFib6K5SoDTMA6TCJV4CMjdfq7OVB1Xmk2Zd7H8Te5yfUKJ5l46HLXmKV591cBxHPcDdzxO7ycXSavQ+JeUDwO/hwe7y9D1T+0MiIxEieLZyJQ9okp2jd/FlHRa786mIkBeXLgRwYR5rHXWoEIVb4a29oyMk+EtQQcdhHh7uVUsBv9jdWb+GLyt9SRXMcqPX7Tqxk0bZFjemtUDkv63IojNEKjyqh2n8oKjj843nbvNWERR7jgKJ2naVOI5FWOz+avZtLYE6XiwfRBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 05:39:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 05:39:40 +0000
Message-ID: <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
Date: Wed, 20 Sep 2023 07:39:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v5.10.194-cip39
Content-Language: en-US
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Cc: pavel@denx.de, uli@fpond.eu, masami.ichikawa@cybertrust.co.jp,
 Chris.Paterson2@renesas.com
References: <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: dfea38f6-ecb9-4f63-1aa7-08dbb99bfc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q851INWjVh88cM5eQ3Gxyy46NCgh5aAn9LadaZzTLxQRrqKCYJvXJ9rJoGfXiKps5TVfIMx2rB2XZn+XbejhkQRvmsWRqEwAtMKTsYwlMsx7cYRUJne5PnjxtSuntt0TLcizBUtmkY3eDtzwqJIuZ0WNT2YLfx7sKcxtBV+ZFG5QKVaOb7uN2W0RJqHEYL4+PA14GNbU21ZYxeSZVxBUkw82Divuq/TvqUKHhpd15R1u50Y2GkdE4HkYNWRGDsc57IkobaaVcmUR4kMsCFl2V9RxHOZ7tLpCSl3/XSsx6uzv+08s0Hc5/Uj7bRccSPsrv7Ftk/BzCHWcH2W9S8I7ygqRLBG58mK4YbJCrUJPrSsUQrXCu4fHieQ7ZBQoIsUmECq3VOGfqMZpPML9U2i84ZWzIKAzKWVyVRsz4yQdB9Hmz29TBrbMV2pi/kybZ+q83BXfy8026+dnFfdeLA6ZWlJ+a6tCiOxYm7k4XTz+t1Wk5Nsh11nhD3AcTTckjlLTWm0Z3V5PW7nAdE/XQJZaOy2YHckyws3OgA+hhcnZMmu+lmdJTw6luajRhWW7nsiKvUzBX9Gv4clAxO3TGsIZVNDqv8G0BAmf5L+7Xl7wVz5yd7wUSoH9FNqgobMadUY2WbumtIl3gOsy0SF+A2oX8w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(31686004)(6512007)(6666004)(53546011)(36756003)(31696002)(86362001)(82960400001)(38100700002)(2616005)(2906002)(4744005)(5660300002)(966005)(6486002)(6506007)(478600001)(26005)(83380400001)(4326008)(8936002)(44832011)(316002)(41300700001)(8676002)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2hKVUd3WE1CSXYzOWluK0ZKK21hUU9IYWZLM2cxbndqSVFuOVRoYmEvK0NT?=
 =?utf-8?B?amJaVUNzVTIrcXR4QmNtd0VyL244ZUt0Z0F4K3ovUkdIRXFVSFVzdTViOUdN?=
 =?utf-8?B?dzk4U2FVZ1dOaEFVTTVvbmFxZWI1ZUJUWGdYOEt5dS90bWFxRzlFS2RtN2xP?=
 =?utf-8?B?TmJUalRwNTZrTm5qVmJHZmc2Mlo4RDFJMTdHOXBZeGxHUkFFQTU3SW1nUXl4?=
 =?utf-8?B?c1o5K3l1cXpIdjJxT29ZV21iQWtreVNsQ2xXWWkyZkg2RUtUUU5yQ1pvb0I2?=
 =?utf-8?B?MUNFZEZYWDBaSDl3Q0c2Ry9qWXhTb2RoWmh4dUJESVp6THBnNXBEd0JKSTBU?=
 =?utf-8?B?V3JZb20wa0RWWVN6WWxsTEVhbVpJTjg3cUFpNjJud1grbGlBUmxiUWpJVUM2?=
 =?utf-8?B?M3paaVQvaklkTUFFQkZObmd4VzhOdTVySTlFbHpPcW5ybHg5MkpuaGNySE5E?=
 =?utf-8?B?ODAzZ0FUYk5BTU1qRE5vTHdSa2tMK1AvTUIwb3dUcW9lc1hxL0lBVGNKYndu?=
 =?utf-8?B?U1dtOUpRRnVYaUVTL1QwRHQrTDNIR3N1R2M5eTBoL3Jha2dDbWVKRjI2RStV?=
 =?utf-8?B?amcvaERkeGUzUVNyem5hVDN1TmxsNDh6dW1waWFhSTd2QWYyQUQ5NEJUYjBV?=
 =?utf-8?B?NGppT2pyRzZzaHR0c3NKUUNSYTVPcmRRNTk4UDZtVTFBL05GSjd5UDlibnY0?=
 =?utf-8?B?TDRlVlliR1VCb05FYjk5VmgzNW91NjI2dnVsdGNidWhEZEdPTFRZblIreVVM?=
 =?utf-8?B?czdGNVE2UXlvRUJSTlY1eU5uVElKZzNmNC9QMEVWb3F6TVNUVWZHUE9iY3Yx?=
 =?utf-8?B?em9vYVJlOW5tVGNGWmEzN3B4UWtnOURYNUxGcUJvTWtNUSt1SlR5eERxSEZU?=
 =?utf-8?B?VUo3T2VCNFVYTHNVdmVQZkZ3WWoyWnYxYkxDUGVMbVFFZTRXV0s3RitDRkk5?=
 =?utf-8?B?ZWU1UXg4R0Mza3psaStZb2xyd0k3a3JhVE1Cc0RVM1lSOEpwZU9HZUhKYUls?=
 =?utf-8?B?aFoxREtGWk5XR3BUdWVwL1RPTHJ2bXFTVVJFTTdRZmxkSHIrd1VxdXI5VUw5?=
 =?utf-8?B?ZzhXVytHdzJwQnNQQ0hkekNXdVA4b252R3AyWEpwV2QycUJvZnRvV0JLNWVw?=
 =?utf-8?B?U3JNbkxMeHYxS1hDWFdnS2ZiVDVwZjFLSEh6cGRpa0RYZWprbEczVXQ3cVdH?=
 =?utf-8?B?VUt6clpVcXVVR1BQL1lHRUFrYndoY3R0amlyS2V0S0xKK0ZVUlN5MXovbWtZ?=
 =?utf-8?B?bFhrVHpYWG13WVd6UjNsc0Z1VytjOG1XRW5ZVlp0WHZWTnlQTStQczVKTEpk?=
 =?utf-8?B?ZG5xaDVLenh5VG1Ea2xHM3k0RTRqRW0wTjRrY3AwVzgrQjlMb1RSM25UaTZI?=
 =?utf-8?B?UXEyajFGYU9ESUhpUTA5UzZZSy9ic3ZMTkh6VjRhc3ZUWVZ4L2tvTVpld05J?=
 =?utf-8?B?ZDI5a0dOVmE1eDVBbzVNR2MxemF2eE9ZQXdrMTFlNFJPeTUyVGJsOFdZRDMy?=
 =?utf-8?B?RENlL29Lakh5d0F4djNOL2pPQXVwaW00OHFkV2h4amNodlVFMGJGZE4xZDJW?=
 =?utf-8?B?QjhOM0krRllva1pwajFabmZRR3BUdE50MFlObnd1RC8xcGJEcEhRa2VOQXFs?=
 =?utf-8?B?M2xIR1B1NHNtY2U1UFB6SHRUYnJUL2tVTlJDYUQrOHFRUXNiUVN6UEk4bDg3?=
 =?utf-8?B?T0l2T0pRRjBFZ3ppbjVxSXlqMldBUEFwTWVaS0tPeU5iSEZOWCtOa1dYVU1x?=
 =?utf-8?B?cDQ3U0NDRlpGdVdpSDdESVpmN3NxU1dwWTdmbGh6OEpGQ2FRc3Y5VTZIVmVy?=
 =?utf-8?B?YUxGOTFSMEZDdUdoL3NpaEdCRmhyMTRzSGRtdEdKQTVPRVJYd2Fmb2JreGdQ?=
 =?utf-8?B?S0hITWZlaEYvUGc3OVEyRCtWU213c3pndzU1YXRpZnRGL21CMVNTNjMzeHUw?=
 =?utf-8?B?Wi82TVBOUVlYZE5mQkViSjhzb2JKdWMxQTVka2NNQW9tZVo4bFVtdUlTbkhq?=
 =?utf-8?B?OCtIZ2V3V2FFZTNEc2ZqRnptWVBubGFIMSt5RnZuUWhSZDdOUlk1aEJmSS83?=
 =?utf-8?B?dXRhNEgxdktkZVlWaTdDSHVnaWE3cUJKa0RUMFhqdGdsdTRxdDNTSEpzd080?=
 =?utf-8?B?MjNWRk91YVUwNE5sbGV0cjcvZEszTlZnVG84RGRUNGVaTndxUGQ5cS9DUXBo?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfea38f6-ecb9-4f63-1aa7-08dbb99bfc2f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:39:40.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ1UUSwGcDW+RmdC7lzMEF1o3aQARqsXJ4HAfiTZekn2wy6shxfvBL+ZYPkvL8xWbupDRwxCYCl/VU3ZxMxB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7533
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 05:39:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13173

On 19.09.23 14:07, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi all,
> 
> CIP kernel team has released Linux kernel v5.10.194-cip39.
> The linux-5.10.y-cip tree has been updated base version from v5.10.191 to
> v5.10.194. In addition to updating the base stable version, this release includes
> bug fix, RTC and MTU patches for Renesas ARM64 SoC.
> 
> You can get this release via the git tree at:
> 

Please don't forget to feed
https://cdn.kernel.org/pub/linux/kernel/projects/cip/. I'm seeing more
releases there, but not yet 5.10, and there are more gaps. We really
need to switch our CIs to this source ASAP.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


