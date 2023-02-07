Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19D0C64EC4
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 13:37:01 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.45])
 by mx.groups.io with SMTP id smtpd.web11.83459.1675777012306696972
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Feb 2023 05:36:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X5N0Lv4K;
 spf=pass (domain: siemens.com, ip: 40.107.104.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/VS1sDcib2mOd1u+x8xQYMAHX/MGlWriFdgwmzobyziPsOuxmVPrKirlYA56w5t8O4FidRSsOq3SM6o/8+HZMPvTSMxdVSFIrVzRgwD9+U+TGJ3UhiDL/blgeSCnKLc2R5hcmtVRV4mAwRaMC52VIEA6WMrAHHjYtFUvSVIhWK06w99/JjO2wq5MA5OEq/3E9zoG3TyRqAxuMxVwfFWP8zPvJWgurnC19/8cb4IXhmaaPDvIIMMlr2mY0MZiBjUp5/jt9fEQtDtQ456vDyR97PpjL0WSjU1Q2L5H99SDFy1jy2LIh8ABbqY3a2u/AwZ7U9wFHxE5aAzhDKv7Wh/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfqnYAvxVROlzUWyRsvOTPssviWvKdRTqoo3nNWjybM=;
 b=B6Hmp0Hd4QNpAWDIdQoDuN6FljPNHjIv1oEXfoOIvXbOjlH+Te6lg/fu37Ds1KSjrGgbxgG/eHHn6mcQpESbPCK5Pk1XgA+u4j/EUbveenpkV9ecH8Pak/EYlXCL3u5fc2icqai4ccGzEX9KXARq5P0NAYPZ2s7HYWDP2w7ShoBlr/ygtxhL4NcDtJ7JS2fmFDxZcwJlKrjC/17UiVPc22IR45LE5CHUmDXMciAxwtSLgmpnbimc3Lrt1dDMH1gmDXcaVvGl31SbmXhB2S/85/fceEc9QT5Zj5VjC7kFYGpz6IiNhu2LQy5xXjjkGJO3WDj4z5TgEIGc+itpwSy0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfqnYAvxVROlzUWyRsvOTPssviWvKdRTqoo3nNWjybM=;
 b=X5N0Lv4KMF00CB4QdlzpKQiPxTg+w0RVlWop/1xHt16Hpcd4TQlIaMtxZdyFZI0QNGACSNgKZjJMJSPHP9MsxtxMBa4zg3PToz8hPxLCY5j3fZb762kp++i+oTma9HjXL23MRdeTnTMWWeUUfIKp8hiIs5kw2QhpRF/4mn20RvJD4dVwvh8Luq8hYjlzGrrp8FnAWuFQqGyLEju9O/+pr4yGzpM9bpvM4L8cH8gSmdCiO12PTMbBrIgSMj9zKyL04lEdkbmNxcLJmO06oBGCoEgpWRp190GfMOB0rO0fel6P7eH+vlg22tiSexbzFJT0MWqp8n02SMfvGdjgwcZ6+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7695.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:490::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 13:36:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 13:36:49 +0000
Message-ID: <fa1101c8-7e40-3dfe-fe69-cdf047f07d6b@siemens.com>
Date: Tue, 7 Feb 2023 14:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] conf/distro: Use cip prefix
 and snapshot postfix for sid lists
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230206082541.15361-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230206082541.15361-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 125eb3dd-7cf8-4869-d008-08db09105d8a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WV/I3IltvBYX0lIqi9+V4tyIy8UhdgfUpZ/MBIW+BDSQ7P1bWWnpgL9pA2zZYrAGceNPol4dz7WqGN2ylHESHhFwweyfNeGIvO+fdVDsjcaACdBX5YmeNF5YJITOVuKfZJE1D2aPFb/Ba+9/PzK8Xcywe9Ido5VZenSUrlMiMqz/pki3XbeaI3ambmPDCJQz+sijwa3SyBbHzSOlasLKe/OhRju9AYIp2em9m0HNoX0cmBEH25WTFvs5B67+A1nkYr695MWXy9x6AD6sB9dVQ7feJDwELsG8beuBvzbffPdLZQmtZKGTgxk+usxQ90b1O5rpWq7rTXtTixaHeg63BVfJmP7KZhdAGxK9Ez+Jq+2h7mCb9MN9RILhpZLMXC6x4KdXPwWt304TF9t4OMgpqsx0H8yHk4e2O32fUA1zTVKpSAaYU8kgfMVVf9bBWSONjAgnFO9rN9SfeXD7eWi1WWwvRsZYOMlaZd3mVbus811iyc5/lDPdrELZKvjjeb8zizej8xmMyumav2jtweO3wnHVSi6rpVFRLSiInNB5bwz85uoyO+gMOab/iz6EH/b8uJcFrY03F1KgsizCH56CwhSzQtg4gbmMDkqGFihVrDfO4FgJgvM7HuLrTtt999kbFeORwcdOcdd+3RoV3RQ+jlKdUHDV2CAiXMYBMIPM/AM0wWVlR8izWMzIf1AUyprbD6xGErXFbtGPZWCvm/Zte1pSgq/aa/XbXcM7allZug8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(31686004)(41300700001)(316002)(66946007)(66556008)(8676002)(8936002)(31696002)(86362001)(82960400001)(36756003)(38100700002)(186003)(6506007)(53546011)(26005)(6666004)(6512007)(6486002)(83380400001)(5660300002)(66476007)(478600001)(2906002)(44832011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzN1ZmtTdHcvYzlaVUhtWExyQWlhenpoMGhnUUl6ckpRNEtLa0NxMHVCZVFH?=
 =?utf-8?B?aTFBa0ZhY0FUTCtYTHFKd0hVUlc1TzR3MlhseWZYNUlvd1hmYW9IamhNUERi?=
 =?utf-8?B?VUNwSnp5NFZCc1pnS2I5MkNUN3R5ZlBqSWlKVjJUMUZ5OFpoeGJlYjg5Vmts?=
 =?utf-8?B?b2V5bGxtdlB4M2F2QSt6VEpiQ1VkdHphK1RsY20vbVNuZlNHQ244eHpxN1dM?=
 =?utf-8?B?Z1IrL2hHL1JHNjVzeHNsS1M5WDExY2tWSWd1RWJweXJiM1IzN2JzR0NaYXVS?=
 =?utf-8?B?enFDeS8zbThRUEJnWWFYbU82RWVBWTJSeTVUVVB0ZXdvM29uaVJReVFoYkp4?=
 =?utf-8?B?dlVLbW9XSzlROVRlQUpEaFZtVHZrY1F1am1HK2M0c3IvRTExY2pjZ1Fyb0hr?=
 =?utf-8?B?d2NRQ3FWMU9HR3lhUlVoSm1MVVZSWUEvT1hwZGhJQU05bEZwTUdKYWo5bGU4?=
 =?utf-8?B?UVl2SG1sQVlSUm1GTHlUR1N3YysrWUJ1SjFXZWoxQ2RLblpjMFZNQmVhd2FV?=
 =?utf-8?B?UGE3aG9FWXJMUkZEOXZEUngyMnk0ZkpXTVF6UlpNNVVFT3FES0ZZdU9nNEND?=
 =?utf-8?B?dUZVTklqR09yTDUreXRtcmx3Zm5OZlk2dkhwajVwYlk5Yjh0VkRXVlM0K2NQ?=
 =?utf-8?B?WFR0WDBhdTUzNVYxNHQ2MEhZVHMyeGNlT05yb2ZCeU5BckZlcUdQcUt2S3pu?=
 =?utf-8?B?VEhkVUVTb2ZQOEF6a1duRTkyU2JNcWdJZmtucWlTUW82czdjMkNNN3lHWnRF?=
 =?utf-8?B?QmZXc0pwVjBHVHdTcDB4U3ZYUUw0Y3JtaGNYa1QwenJXNXQ5M05EcDFhRHF6?=
 =?utf-8?B?bTR5K3Iwbm0xTjlpRCtXaDhFWHJyMkY1aGU1amx2ZHdaVVFXdlFwSTkwUkZH?=
 =?utf-8?B?M3YyU05IaFp6ZTBSdnNTc0ZJbWxnQVhzWXhHVWREWlc5L0prbFZDRkNQeFNE?=
 =?utf-8?B?QVNuZWtYL2UrTGZOK0FjMnpwUzhIajc0bURVSkd3SXhxRlBxSkIvNThiOEtp?=
 =?utf-8?B?eExYWm8zVGVMMUg1eEIzczY4bHpzUms4bVljUmcxbHRSK1FYQy92YXFFSCt1?=
 =?utf-8?B?N0MybTNrZ3dTZ1JtUkZ2dFJQOHB4czNmTkF4c2FpRStCTzdWZFF1V2llKzZj?=
 =?utf-8?B?RE5xNmxmUUwwbTNiTlJXNTc3K2ZXNTV4Ry9xRmVUcGRGeXRFVC9CaGJWUEs1?=
 =?utf-8?B?dExQYUVWRjhKR2JNK1hqZGk2b25pT0xWanN2bmhzMHorTHRwek1DbDVOc3F3?=
 =?utf-8?B?R2EwWjFIR2ZpNHpTQTdxSnZGQ0N1OEhzcWVSUHNJUkY5dFliR3cxUmEya0Jh?=
 =?utf-8?B?UVhIY1VIUGQ1blJNWFVsRkRZdGlSMittcjg4VXFwdmxoeTZkd2Exd1d4VFJK?=
 =?utf-8?B?d2lSMm5MNWYzQmxSVVE4enRkaEorMUZyU1lFL2diVDRLQzlmMkZFa3NhOUlR?=
 =?utf-8?B?ek8zV3dJVkhFeEF2N1dFU1hUU2R6a2lKU1JQVXhrT2ZsaTZMdDBEYk50eWJp?=
 =?utf-8?B?NHZsTFU3OTRKY1NIeG9FNzAyd3ROTkc0MjJaQWd5R3hncTRnKzh3RVUwNUlY?=
 =?utf-8?B?Z0RoSG1tTmZ4T3ZrUmp4Zkh3RnJOMTkxQVRnazlya08vQUk0VzhEVUZlUWd0?=
 =?utf-8?B?TTY2Vy92S3B1bjA4MTlXVE9wRk9Ta2hBYXVRc1ZMbE9ieFZIV2dGblcwYXc3?=
 =?utf-8?B?bmNZUlhXNG9sRE5zSXl6WFEzZ3VLTG5pbFN4RFhyUWZBTmdYMnh4N1pUK215?=
 =?utf-8?B?S1Y3THR4cnEveUNoY0lWM2FMc2QwT016VUV5SjIwbkc2WGVrQkhETXMrSjNN?=
 =?utf-8?B?MUQ2ZUc3VWdBbFZYQnhvd21jNURtczc4UDIrNDR3SFN0T0VzY1lxRzE5UHhK?=
 =?utf-8?B?b3g5cFYxaHZKTG56ZHg5Y1hGYUpCOE9WUGhQelZvS3FJQmtqd1RVcVRyR2J6?=
 =?utf-8?B?K2tjVW03S01GQUlsZVloT2s0QXU2M1RNOW10ZmEwbDNxQkFIN2xCRXpJVCtj?=
 =?utf-8?B?UkpyMVZ3N2FLUjhSYnlHRjFGaHVNNkpCeVpDNkV0dGx6YzEycFpjM09RZFZt?=
 =?utf-8?B?KzRDOTd2QU9KU0JCQThweTRHcHQrVmc3SFlYWXhwYkhjUEpzNVJtSGVIRkFn?=
 =?utf-8?B?WG9wTXlkYVJRU25VRjZ1VC8xRC9Fclo0SWFSOW05M2ZTa0hQcjFxOWhjU1lZ?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125eb3dd-7cf8-4869-d008-08db09105d8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 13:36:49.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //b4KiZ3HXP+mYqd60MPi6PCBtmrrhyB6exaTyIRabbQpyoG7L4i8tMBRms5waxuYN2H1ohT/bXJUU/89UlDjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7695
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 13:37:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10627

On 06.02.23 09:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This is done to avoid infecting other layers with the snapshot version.
> 
> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v4:
>  - Restore and rename debian-sid.list to cip-debian-sid-snapshot
>  - use squash to avoid wrong file assignment in patch after renaming
>  - Replace Variables in *DISTRO_APT_SOURCES with names
> 
> Changes v3:
>  - delete debian-sid.list as it is not used.
>  - add missing newline
> 
> Changes v2:
>  - split renameing into two patches to avoid wrong patch
>  - add missing newline
> 
>  conf/distro/cip-core-sid-ports.conf                            | 3 +++
>  ...ebian-sid-ports.list => cip-debian-sid-ports-snapshot.list} | 0
>  conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list}  | 0
>  3 files changed, 3 insertions(+)
>  rename conf/distro/{debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} (100%)
>  rename conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} (100%)
> 
> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
> index 0b369bb..c5d1cc7 100644
> --- a/conf/distro/cip-core-sid-ports.conf
> +++ b/conf/distro/cip-core-sid-ports.conf
> @@ -14,3 +14,6 @@ require cip-core-common.inc
>  
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> +
> +HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
> +DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
> diff --git a/conf/distro/debian-sid-ports.list b/conf/distro/cip-debian-sid-ports-snapshot.list
> similarity index 100%
> rename from conf/distro/debian-sid-ports.list
> rename to conf/distro/cip-debian-sid-ports-snapshot.list
> diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-snapshot.list
> similarity index 100%
> rename from conf/distro/debian-sid.list
> rename to conf/distro/cip-debian-sid-snapshot.list

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


