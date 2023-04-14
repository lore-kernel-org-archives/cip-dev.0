Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1388CC77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 08:25:30 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.83])
 by mx.groups.io with SMTP id smtpd.web11.4397.1681460720186721385
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 01:25:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p2SS1PP7;
 spf=pass (domain: siemens.com, ip: 40.107.15.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEJ7BCJUspdQo1qa1heN+qiljwFxAKU11hOxNlsqWh6bfDQTsNaQqlOycjoeQjkYrW5LMVd8Gdr/4fjyMIqu0r3pC3Y3Pm9J45x8DOIvcPsr7VN0i4r8Q7sI/6XEV4I3vaIYdH7slMZ3kEa5/LIOvkfsA+w01AG7+qQVVHMjfwHuZr51HzvpLIf786045JJFjzzZ8F/oJfjFjEW49n0G0SsJYnG8jdd6wWN24RtXGj6M0OL3wyj8men+sdSDKjb5SjEAJGgOw3khH3+SqJKDaEopdM2IhXjOMYooJv7gGOEgkn7ncFD/pjPp7+W4tYI8J0eces0CzwyTuSe4hCzq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ISmasZcaGAHb7qfQO+AYk9rYpPG2oLtrhkyy4YjPI0=;
 b=MHRHdPDplT3mIU1/wGeKAiudw4x+w/2KoQVoN6LFjVjjTJQkCpjxTGgK50gTctUYtYhXA1U875kqvWT+jDsIliqAVZXs7tkRB7Kx5VDtQWgpbYwiMi7z5Z4YW31zxsPcUYFVeDOl9ytbQLD7iVyv19qGcB47FLBRTAwNmiy0HhdZEt+wLpCtg+x91ATNF0n2SRW/X7LtxPPMaVorKg0YOtD2f7w2a0oT1RozgmSGb7tfOa7MFL6kasdGc6AHRzGobdWxsdSoX1DXgPP0KuWTq11Ytzs4SiD4C4/t1CLFlUcRlW+1Oi68yuvYVDeV7Dv2Ez0ApU7dIiJdiEpDmPJmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ISmasZcaGAHb7qfQO+AYk9rYpPG2oLtrhkyy4YjPI0=;
 b=p2SS1PP79D6dUR1NoHDaNiql8zWbyvTmrY/wyc/bpHZyZtboCw9+eFa6oWrStN5JCdirNDQej/iyKAhSM5nVgR2GZc4EcjPBWQxU1d61UqfXoaZJzPSFy7kdgDNhWcOD2+d1y7h2UO1DJLY/8uob52y78TpW4fwai/DBLMe817hW855gP2o56zIcps4H8yBBBfOHLxAk4hAAVQpMZAmtwIZK2qd5AVyFghQoEbx2+XfKuMyUtcZ7AMzZMIJKFuM0okhG7tSfurEIvHjjxbJncBuPH5vx/wZ8h7oU7xJW3nvkpP6eQYOm+T4N1zmWxn8U/tNNB52SDnkdnmYclpt4Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7758.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:632::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.25; Fri, 14 Apr
 2023 08:25:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Fri, 14 Apr 2023
 08:25:17 +0000
Message-ID: <7f07bd88-a0e2-a508-f051-4ea2982c5780@siemens.com>
Date: Fri, 14 Apr 2023 10:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] add support to limit resource consumption of squashfs
 creation
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com
References: <20230414030912.189746-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230414030912.189746-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0035.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::48) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 24393f60-beb3-4076-18ea-08db3cc1c74b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IrzLXN/3EkwhBraUJP1MdlpFVZPoGTNFf0czyq0jBAFAVjfIYZjBIIAPQGYAKUtwnvkT0hsYz817JzJ4isH5t6wYxgVgd+befQYkehZXFYazKZJlSiAPjd+7ZCJ1g8u//DfPPffXUlNhDMo5OEA3pfIEjITUSKk+REdphOU9EokUs/XdgZHwvhJNYorTJxO4/QPJjwG/iUFZx6CJeC9GPW/+VIceamq/fwkTfUITrYpG4PiN2L9JvccII8t76pdWzFwyh7Xfm9DNoR0j2NRsIzTlNVs9XMa++XHblMnJW4/GmdjJr5SzF80D9DNGJKHs9iH2BJjOyNdwQZp+zrZBkUYb8KgSMpOo1b2oVb0Cdu8LT0nvmZaMQaPcVaqOIacBXlwdPmzlj3XrZDHT6jV0tcJ+CQH6KxteeUfPRR204qMkOTJDOPsykl191/bhdXw4Ssx4ihHVVDeNs6C5iViYgRMK3yIIeO6n7diVFM8c9elyoqug7uyZeKHf0YGM4WCLPs7+DzPD+g9eKGDWw1/GqZLLedshzv0irPpQk4u60Om4BXR5F0tigrLPrjCCz4+phEEbyAlb9pt/Hfv1rcyvW+TJ4sbGFKN207Muk+piQCAf/BT2khbOljRgNmuFkTc/ppn+xqW/o3Z1B3mDauAvhA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(6486002)(83380400001)(6506007)(2616005)(478600001)(6666004)(26005)(186003)(53546011)(6512007)(316002)(107886003)(44832011)(38100700002)(36756003)(5660300002)(82960400001)(8936002)(4326008)(41300700001)(66556008)(2906002)(66476007)(66946007)(31696002)(8676002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTJ1NVgyWmNlQm5HTGNWK3RSQ2xJUmk3TUtKeUI3Mm51Y1dNekNQNVFoSWpl?=
 =?utf-8?B?RUVoaFg1aCthOVdNZE9vajVjdERLVXNXRFZrZmoyakRUVlNDVkQra2FyM1BK?=
 =?utf-8?B?OUg4bGxTOVJQU3g3a2N0Skd3aVlsZUJnQmJtKzFMbE4wQk9tTzZwKzB4U1gr?=
 =?utf-8?B?ei85aWNhUUxjcTdsNEhuN3prMm92K3pPSmlhMEN2TUVITG8rV0F3b1RCb3ZW?=
 =?utf-8?B?SHk5bkJlc0NIazZ2Nlo4dTlvemdpYmVLZU93NElOSVZReWVxOGZUVnd2OG96?=
 =?utf-8?B?TlgxUVdnTVFkWERMeHJSMmtwYWN5WnlWdWZaVFNTdStMZU9VdTN0QkhheGhx?=
 =?utf-8?B?QTkvNE1uZDc4clAxZ0NtZkpOUUJYUytYb0NGcmxpODN0dTVEcEk4Y1VSamNJ?=
 =?utf-8?B?WkdSV3NvQWRvMlVxQzg4SGNPa1N6ZWhnK09NNDgyT3ZpZDFOcVFjSjdlQWxJ?=
 =?utf-8?B?VG5uVWZScnJBekNvcVc3Z3dGZVFuR3ZBUVM5c08wK1BmYmxiM0NRSUxlQkpy?=
 =?utf-8?B?WnhXRGhWRmR0YUk0em9xMzJvNnkxbFgxTWJ5YVljbUR5MGRmeVVsV1YvWm4y?=
 =?utf-8?B?bU5kTlN1a1crSHE5bGUwV1RXRGJXYitFSjMrS293eW40ZUo0cjJTRzNRM2pt?=
 =?utf-8?B?TmV6M2REekZYVGhXSkYyNkc2YUl0MjhsWFN6WEtaZGVkT3ZIMElGQUVrcFR4?=
 =?utf-8?B?R2ZJVG8yTlYwWXpUSDBuTk1RSkt2cnd5SDdFT0l5cUJFcFAvbXc0c0lOK2Za?=
 =?utf-8?B?ajFNVU5RUEVjTkxCMnNKQURkZmJzbUtrZHh2MUdaK2lTQWRCaUhpNldRSDRB?=
 =?utf-8?B?U2UxTGJFS0VyVUwyTXNFNmRmRWY2NVZyK29qNzhraG1NV1laYVhrWjZPR29l?=
 =?utf-8?B?bWswRWhVbzVETGFacDJreGFnQWI2L2NVclNUbkRNVWtkanIzYldYWVFEM0Zz?=
 =?utf-8?B?b251aDBIbVUyMFJXNkwyT0ZuZzlaUk1HZDF4cUI0WVU3UENQSUhFeFpSODU5?=
 =?utf-8?B?dU5sWUN5WFMxaTdzVDhXaVdxZWZsbTNZU2VjWWVkcHhjUjZ2SDFVRys4bUdl?=
 =?utf-8?B?TVpOaHJNTFJHZ1FNamxLSlZKQW0rb0ZrQXFtSUgvT0h0ZUwvYzlGbU1GSUZs?=
 =?utf-8?B?Skk2REhJb0FSRy9MQTQ0bVA0M1ZkeWcxUFd1TGF2UHZzTUFmQlQzc3JaVUZJ?=
 =?utf-8?B?Wm5QN3MzckVCVUpRc2FBMk41a0lEOG1YdDZxRjJLZXJPNHNRZDVvN0oxU1V3?=
 =?utf-8?B?Unl6SmZKdlRJSHp3SE9GSk16cGhZaVpvMFMwNFJPN0F5RnVWd0ExSVR5YjVZ?=
 =?utf-8?B?UVN2VVoxSFZuVk1TR1BvWDY1b01kRFlGY3dWZ3J3aGlOQzJadDFON2d5UjRp?=
 =?utf-8?B?YmN6eGg5bnB4SWVBTXk5dGplNVRNWHFKTEthdjNsS2s2REhBVnFiYlY4b1I0?=
 =?utf-8?B?TE1RQjlIcStOQmYzUHA4d05EMnF4YnZmYkRpSWkzbkR1U3FKU3BCSy9qQ1pj?=
 =?utf-8?B?QnBUS3RGSVlaMGVHZFRSWVIwaWZyNzFuSlJ0Y294MmZYVXg5L3poMlhEWkpM?=
 =?utf-8?B?UWM3ZHhRYUl1QlR1cnY1amwzbi8xZCtOODJKWmlFOVordTU2QVd4endvc2tV?=
 =?utf-8?B?TVNNNDdyUmRnamE3MVNsdjNBbE9jK1I1T24wbDNjQnRtRjJkVVVnNXJhbEw0?=
 =?utf-8?B?dDc3Vzhwc0xTd2RSaVU0Yjh5NWtvcDd1OTBoSzJRV2hJcWtDUnNUMG85UUNC?=
 =?utf-8?B?dmRhekRBeXd5ZHhWWkcxbzZQTkQvZWpoTVdNMGNXdWUyUGNNeDBZcnVXQlcr?=
 =?utf-8?B?T0RrQ05wWThkQlBiNVEwMmlIRkkycG53cWtMaVZmbjJRY3pkU0hLeFN3Wjc5?=
 =?utf-8?B?di9qOHhVeWtIMVFacElWaVpCbk9DNTdhS255cnliR3E0TmIwLzdXRnlsdjdM?=
 =?utf-8?B?SXhaRWtPSXhQajArT1IrSDYzbkFRYXozaitwUjJjWmdsRVNzSURrQS9leGFW?=
 =?utf-8?B?SEJISHkxTkF3M1puRnQyN0JMQndtanQycVNnRVo2UWpMSkhTdm12bS9Pb2wr?=
 =?utf-8?B?VDgrWVFUMVQvdVVZY0xXdWZ3SEthQmg5ZDZGRkkrRjdNdjhSRDN1SnlYNjBC?=
 =?utf-8?Q?zM4g0B5sFHFTUF984rdBEVbyu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24393f60-beb3-4076-18ea-08db3cc1c74b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 08:25:17.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXuFzEwWHGKZAsuPbbwHDmuZEvFmJFjknv+u1mIOChmR32w+GKxwJynRxRre2q0ylEyl6hfsMNyfOsksGp4geA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7758
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 08:25:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11201

On 14.04.23 05:09, Felix Moessbauer wrote:
> This patch makes it possible to control the number of CPUs and the
> memory usage when generating a squashfs. The variable names used
> follow the imagetype variable scheme.

The motivation is missing in this commit message ("why", not just "how").

Jan

> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/squashfs.bbclass | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
> index a06c501..b14768c 100644
> --- a/classes/squashfs.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -15,6 +15,13 @@ SQUASHFS_EXCLUDE_DIRS ?= ""
>  SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
>  SQUASHFS_CREATION_ARGS ?= ""
>  
> +SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
> +SQUASHFS_THREADS[vardepvalue] = "1"
> +# default according to mksquasfs docs
> +SQUASHFS_MEMLIMIT ?= "7982M"
> +SQUASHFS_DEFAULTS ?= "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
> +SQUASHFS_DEFAULTS[vardepsexclude] += "SQUASHFS_MEMLIMIT SQUASHFS_THREADS"
> +
>  python __anonymous() {
>      exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
>      if len(exclude_directories) == 0:
> @@ -31,5 +38,5 @@ IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
>  IMAGE_CMD:squashfs() {
>      ${SUDO_CHROOT} /bin/mksquashfs \
>          '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
> -        -noappend ${SQUASHFS_CREATION_ARGS}
> +        -noappend ${SQUASHFS_DEFAULTS} ${SQUASHFS_CREATION_ARGS}
>  }

-- 
Siemens AG, Technology
Competence Center Embedded Linux


