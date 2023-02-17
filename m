Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A70C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:33:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.68])
 by mx.groups.io with SMTP id smtpd.web11.9175.1676647991026979624
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:33:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e+OMqanF;
 spf=pass (domain: siemens.com, ip: 40.107.20.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0frs1rFdqOHbSxPPmv1gT+tLxum3eZ3hbZ2f5I9xaQg8SOjKvJtE+eqQ9SloC6d+j7NP72j2ykewMjhENmj4JlPGXM6MMyPmUICpGfSys4cGWCDXBb5K7w67tBJ/9HMbss0qXBLd+c1gW15czkjEduEp0PS0+ak2ctzkTEQlWB5owzwzqqwda4f0zHjycN6mN6oz+4Vu/Q2EWf9iia8V2V+ZYDt5midOufXL62+pFAaGrFBdmPRDKLB0Gllk55qRa3uNONvRclYM7xjlBPaZUnG+Tfr7TS1cI9K4Q4tEFxbQZxDNcQKafXJPkfOVhXKhU1vVjoiGjN0Pbtb/K02KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX8FMyPSLg2N60PZZyJJjCM+d/E93K+b+2CqiW3yeOs=;
 b=RBzNxQxgijZHrlBBznb8S7Um4bZTKLRceCq06Esu4xGOXxMSn71uYttxITkTbC9n57So9ap9fOOn9h8LDk7tdmnjdjsp7aen3N4Yl2J8muRi3fcJHS1lYRUg92VefortnY68IDDbTY2yWhVmALuWeip7KZ/EpX2oislolCY6y3lMNBZKajr2mNS1epva+cCJzRKOoOEhgos4umT7/bQtY6+2dMlFuIfs+yis4xNMcipdwZdLA2W3FgOYP3lNXs2j7Y5QABZmAsXNMgIzmNDgStsguGVm8xeBnqrg348pBAqoJkXaz+5teuYrAesqRW1q68RNjeGl/vzPwnueF1siVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX8FMyPSLg2N60PZZyJJjCM+d/E93K+b+2CqiW3yeOs=;
 b=e+OMqanF+VdEsnSrIEt1opWUkWQh4opw0i06M5gqN5hCxDx3y/opublPEynPDDDxQEx6dSxmA2zjxZ9wNCyiCr/J4cQbDdjQUl5tVIBSxMfWiSiQeZ7pjgwytDN7vjdj/CYmib3kaB0O/rLYykaydG/S+kt7sU7WL+RY/mm7ojb8TI6pRgXr+YjOwvXhHqnhLbLaK6oEWlvVvmXxy6cy09L78WxrBj302KYDfhjFzSAl/HYOAjAN1anr7XxEdeJ/cHThb4bJ/EfCagIargT+PifwS4c86qMT6ZTQKe09gsXH4EVEIPOFkvaHFhtgpML4YH2PRVeHDQSx3n6xgGaEVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 15:33:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 15:33:08 +0000
Message-ID: <86fa2631-b3d2-a667-2aee-a23f1f8f92d0@siemens.com>
Date: Fri, 17 Feb 2023 16:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] .gitlabci: add riscv64
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
 <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:610:cc::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f9027e-3e5e-417a-a839-08db10fc44f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HaM73w0Vfey0qXWkG2cghiptvY5UB0EQFDx/P+MT3EeFifmIMjKTb+6mNLQQ5FlZKxclt4JBbhVoBvHcBwlE197LXLLyb8FBxB8f+CAsygfss50xYBLFN2sRMkKUrQc+BGxvTVGYlcp6FEqj66gIRitPGYgkGRvWDghdjXnBRcUqWvDmE3sy5TbUzKQDdE+I7JR2y2uEVjTnIJZSRd6Ws44bT7wLkr+rfFPTlFUqIbZj811wu7tKu5I7NeNLs1QZAXcFMGWqkpJx+FCnW0gBQ7j9oCfBs5D5ac/IYutHQvHJ2O9wX7BK73pj3XHIBp/r/6nm8V/apBkjI4shQ0OjIy2gu6u/DR9zFCsA3elz0mE2gUnNCL5eCp6wniaT0FZ0RMIum8lUgHgBEfdNITrTWruee7QfXlVi2MdnTR33umIf6B0r4lQyO1/Oczp1h9u42QmE5tDaZmmXUiull9VROGPCj0KXwF/1ko3+uAnSOLxGZ1lFt8gcrCbjHbycT1nhECYWqMFQsBXL3KJXoPDZVQSwG3TsGUYtbm3N4ODIYXfCSTBP71wr3T67StqAbJgBiT5R8bGuoOSkolgb4CdCQvsmKl8QLmvnom7rcVOin6gQYDK0ofXAL3D1eift/3WF814659rKJQ1TJOm55UHn7MyhKc/4RC431ODDNwVWO2O08uplw8lIiKQmKuzKf/GmobHoe04kSQodiDHXhvOeYiLMMXIVPQv4HH9x2pdzItM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(36756003)(82960400001)(6486002)(38100700002)(478600001)(6666004)(53546011)(26005)(6512007)(186003)(2616005)(31696002)(316002)(8676002)(2906002)(66556008)(66476007)(6506007)(66946007)(44832011)(8936002)(5660300002)(86362001)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUttUmJ2MVJycXk0a29peDAvNU01UEV3Vm1QdzZudFM4Zk50VGcrNGJuTWcz?=
 =?utf-8?B?MGVSWDFsNUhNVEoyMjQ0SmswaGg2czhjOU9BWGRlSjBmc085R25ud00wNWVP?=
 =?utf-8?B?cXdQZDFIVW9ZRmpPY094VlZLZjZYZkhrSS9lTGI0djNNWXQ0TGtPWWtXazU0?=
 =?utf-8?B?Uy9LbEVscjdPSk11YmJhbkxOTTFNYnJsaG4xdlVxeEgyMzlRWnE2bWFQYjVj?=
 =?utf-8?B?cTJNeHhHSkpDc1QwNStaUEN4bk5jZzFrMGNOS3BSK2p6OTRIc1AzSC9ENjZu?=
 =?utf-8?B?a2VRczY1dVVpZkdlTjBCbit1MUFqVkRiRnRVb2RuWVlweExRdUlFTjVtNlU2?=
 =?utf-8?B?RzdQbmNIUVMzTE1walloTWwvNUxISDV4Q3FsOE9EMWUzM0NVSENJd01UTWFx?=
 =?utf-8?B?NlNDbTM1U3RXZnBySGJNY2lFUTBGaUJ0QjdEcG0rdmNVZklIMGYxNGs4dHlC?=
 =?utf-8?B?Y3F0bjVhdUlGRVhBbWg2ZE5abnhaZTNDZHBoM0FhSkNtR3VVZTk4SUJPYmJO?=
 =?utf-8?B?ZFo5ajRSNk03SlRkdisrK3RNNE41T1dsb3JNM0VaTWplRUxiSWpha0pwdWRx?=
 =?utf-8?B?ZFhPVThUWXhqdlNra1JHSkZibVp3T1dVN1JpTWREbC9uRHFMQXZ6YW54SEFr?=
 =?utf-8?B?cEkrUDUwQ012RTlNRU9FWDBRYjNIbk50TzAyWTIvNXRkRlhrb0tvdzZ4VktC?=
 =?utf-8?B?eExSSU1weXBIM2E2WmJRbE5xMTVFZ05OanorR1MvUHh0aWRSR3FoSUljU1dZ?=
 =?utf-8?B?cU0wYm40VGwrSkxra3AzRWNPMm02NDcxSXZNelZuUlNlK0lDMHVWaW42eWNG?=
 =?utf-8?B?Qzh6ZnJ2bWFtQWZuNXJTRU1VdTRzdXAwY3RtRUNidlpPMDV0eXgrY1h1WkFK?=
 =?utf-8?B?dlRxTThYT1YrNHpQb0hXYlpHaUdFZWpMSEJzMVFyNjRUWmpmckl4N3RDTGhC?=
 =?utf-8?B?aXhoMXVCdE1EVCtQTXVwdHlOZTlmdmg2Q01GUUVyK0FFamF3eTZmNmJ6Qnhs?=
 =?utf-8?B?bmZ3cVNGRnNzMlBNNUtuWDdsbG96OHVRaU0ybmZCL1hpSTZmcXZKeUU0aGxj?=
 =?utf-8?B?amYyRGQrVTNLa1d0SDlYWHZCdzBCOWpmZUJ4U0RYTkFaZUwzazZCUnZrS3FT?=
 =?utf-8?B?enBqUU9rbDJFUHVkZTRPSXhHVG5Sam1vMnliVGFlZWlaQVR6NW5RSFlEVHdn?=
 =?utf-8?B?eVMwZDVrNmZPVzc1TW9ZeHBGcXR5NHg5Q1dvbm5KRE5VeVpzRkJ5eFpnQllw?=
 =?utf-8?B?OFlsVWVkdVpYc1RaREVTNlZUeW9iL0tVTFNrZzFTOXk0ZWRCZU1aWURSSnRv?=
 =?utf-8?B?RXBaTFpzUEY4MitxWU1tOGQvRUxWVlMwQVlMakV2V3RvNEREN3E4Z2lsYWEw?=
 =?utf-8?B?Z013NldJNzJEbkdLZVhMWEo1TkFjUFQ5Yjh4R1lrUFU4QnVRdHpQM01mZjhu?=
 =?utf-8?B?UUdLTk1EME9LUnowWE9MSElLN04yR0NJL05hL3B6UDh2Zll5NGdyVEgzeTFv?=
 =?utf-8?B?emdxaVluTk9MdTdYTmJQa0NIMk52L01yZEtxcG1qdE4rMGsxaE9adGx6amJt?=
 =?utf-8?B?bGtLY3FUZWp0NlNQYUZieWk4MHh5aGNLWThnaTNOREUvakJQbitPYlZNbXlX?=
 =?utf-8?B?UytKRGIvR2w3UHJCSHYwRGxsbEpvZjNJMkhoaXNnTkZnaVR0djFaaHd3OUpi?=
 =?utf-8?B?bHg5Qm9NUENRclJEMUswelBQeEhmS21iRjNCOW9oMDBWdVZsWFNjcHV1d0Yr?=
 =?utf-8?B?TlZHMTNQR2QvVXBlNmRKbjlGTEFBUU5YTkNpd1lJU0NaVWYyT1oybEs1NlNP?=
 =?utf-8?B?L3ZWL0JkSWt4OVYrQ0tGRVI3cDh2M1dpc2hRRUNjTjNQdnhhL2J1ZXlXZk80?=
 =?utf-8?B?L1AzMFlkMXM1cU05Vmlhdk80c1gxaDhlQlB0Q0U2NkhrMnlZdFJpbU1wZ05Z?=
 =?utf-8?B?VWJ6MWxzSEJDMTlLL29DT2RENHNvYXhjZ1dVZHMzdzRPQkIzT0ZISkxvbmNP?=
 =?utf-8?B?MjAwSlNzSTdtLysrOUJnQXRybUNEektpQ1VzWU9KWkV0cHh4VDkyNkQ2bzk4?=
 =?utf-8?B?NjYyN1Q3c0VqMDNkbGQzamU0Z0kwckJNWHg3MlVyZU54Wk8xSzVGMDB0OWN1?=
 =?utf-8?B?dUdTbzhLYStGbmhjb0dFYTAzNkE0bEtlMVQ4L2t6YjdNTkwxczdUMjdDUzND?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f9027e-3e5e-417a-a839-08db10fc44f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:33:08.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfAVWiNruUBEdrBb02sxYntYK6ScY1TjOzGbUNYQFlhVU+uLKOr7W1Bu1PMvhNNSYrwnW2i58+RMNMIT/43D+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7193
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:33:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10734

On 17.02.23 16:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 311702f..95adad5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -38,6 +38,7 @@ default:
>      - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>      - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
> +    - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> @@ -326,3 +327,17 @@ build:qemu-amd64-secure-boot-bookworm:
>      use_rt: disable
>      wic_targz: disable
>      deploy: disable
> +
> +# riscV
> +
> +build:qemu-risv64:
> +  extends:
> +    - .build_base
> +  variables:
> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
> +    release: sid-ports
> +    target: qemu-riscv64
> +    use_rt: disable
> +    wic_targz: disable
> +    deploy: disable
> +

This will run against snapshot.d.o, and I'm concerned about both
duration and stability of such runs. That's why I left if off so far.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


