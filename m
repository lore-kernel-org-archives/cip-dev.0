Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C45C001DE
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 10:34:35 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.82])
 by mx.groups.io with SMTP id smtpd.web11.14174.1691663673017511459
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 03:34:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cKKZK7nF;
 spf=pass (domain: siemens.com, ip: 40.107.8.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiixRcxZmYWUWcAQlgRYTrfP+3l6Tke1TNUlia5yCU5eO7/BLt/z2qprDII8RMw4kdGPxke+bBM0S6ZP6MtWvtetAXklY/ako9TvSyRS80f0wKJFziz1st9GL+sFmgyVv3KymEScTmbDM6qvjz3IqxlPLyjC1QhUCPr5rSUlcsOGpt4f/gWSFKQT0dcHfFcxANAEkaFhQkRcos21t4PKADoAeZ4yP60H41spzCgnDD/Bwn8xA85kyq1rpfxMmEQb51PtGGKPGc0oQWX0Ape4UT0d+pWLs0MZVaUB8Pc3OL3q5zeNUJC5fz+eGhr8mADaj537DXdIPoaMEWrOqBXiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6UhEf3TrMlpm/FQp03zqkcSuy7ri2FUCwgWNlWlvFQ=;
 b=IrieGcYTKE6tnIywgln18qmHbl/r66rk31i2jwcnhnSG2IANOy0YaOBKQZ3FmFnDxcgBHz8bPvjo5VRotEaTm+n0JCGTEsdZ7YaXoh/tysr2hISV2u/qRqwXGBHQO4kUaEeBLZDYSqAeuMLJ2eet1+Dfn1De1O7e7+moHKFL3PQrQ1V/OYZDUxljZD+qmkJpqdVd/XqiM7rZlOJRvuaJe5gi2GWQkQGW+pdNyHkPUBQh+Gd2gtEgqDhBW+mf39Rgem07vrRAUesUmvzoePZt1Yha04ofAzB5kNyTEcRyYYVVS4hOB3RM3alAoVb5Zd2rYDhd/qRE2w7Jmia6NmBfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6UhEf3TrMlpm/FQp03zqkcSuy7ri2FUCwgWNlWlvFQ=;
 b=cKKZK7nF6ZxSK60kPObahHK3DWxPXJF0nSW9JXSroZkC9qoGxaDHDX23aNWg1m2OemUqM5IA+qi5t2O0MIaElSJB/G854XUsomz5p6D0Mu+Z/XXQQUqvV2zMavcp3rrhqQpEk68cKIWDKUcv1YRK2rciaa55CfgIyaNsVmYYN7s2N1Rn29Dg0MZNikOFer5XWRVsQjRuVffRk1Q6wp/fk1M2qh9x4D2fY1B5/PPaTkpXakBBF/dEdwyj9YoXeRlJc85pBEgoq1zn2M3l7cX6fQq6rLtHgz30+FP+7Pp/LIDMZVmr/ZK7+QxOur3WGlRK5Y3m+cQWLkLsHwvukJptzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 10:34:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:34:29 +0000
Message-ID: <dada78d8-aa43-470c-bdb2-d55c7f90dbd1@siemens.com>
Date: Thu, 10 Aug 2023 12:34:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/4] initramfs-crypt-hook: Check and repair
 filesystem to prevent resize2fs failure
Content-Language: en-US
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-3-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230728143320.3891194-3-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 028df6cb-90b5-464a-3b21-08db998d6087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qJsaaj15WjFs0UQ2NIy8MrNdsM/0yWbCnD92+LSaGo/Tq0F9h09aU4yASvfo1JpuTuO/vV7ctj/YuIPYmyyi7a8vcOYsFZkJIv3W3DL8OTVd329OyC+OcAnt8XxPNU4WWZ/E6GxcpWpT25Mom7/DcPZhmPLr4NFpFSu7qbuN0wLifI7SgLNmn6ZJHyJ2VoYz7PIQgBpeKaSRdI9ADp4OYhY/vU6aUrOSR/y+tx2hW3+bkiygjhQJktr083doKdHnc7Kot1UKxEpnolqY8lolLRN/RKkSA1QH2pV5v7840yG5nQdiX7aysnol2KMJD6+yc2zNn4sznBvPIF3qKkwi9JyURcpVc+pgt2Ms05m+emnDE7XSWj+We2dX/BjqOwe5NIwcw61oQAMOz3kfitVEOmx5Xt2ZtGNi7TsDKAeCPNsVzAuIthS5KKMojWHW2cHd5uPOK6XdK37e24h46DyUix58l3TPa0Zf7QVEkGkhvT4iGsqQ7CIT1ObVyjsUh/BGP7uavCoW8WpJ1MkSaT9+WmozDVRJU8B9Hq+nf0jnkahc1Pf1bPpAVsQ+w5yDGdyUxp8jhC6YaPLaMWRQg+vI3/+Y08P+4NNzBBfiLHgZm415LrDAaCJVFKVU27xCOUWiO8/ItvRNb98EQz5tqRijGg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(1800799006)(186006)(451199021)(38100700002)(44832011)(5660300002)(8676002)(8936002)(2906002)(82960400001)(86362001)(6512007)(6486002)(2616005)(54906003)(83380400001)(110136005)(478600001)(107886003)(31696002)(53546011)(6506007)(26005)(31686004)(36756003)(4326008)(41300700001)(316002)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVZ4VmxpM29nRXZLTXNRM0tSRWtBcEVlRktGaHI4YVFOb3pxR2RyQkFkRzYv?=
 =?utf-8?B?RHV3VS9UcnZpYkJ4MndtaG5pSG0ydWZjdGd3d0FZZ1NZUXc2M29sa3l1V2hV?=
 =?utf-8?B?SW1YWENOVlVtT21UdjM3cTNSTVNkTGRCa1VXMGFMY2NjSkhYcXM3Q3IwdHlY?=
 =?utf-8?B?TmFONDNtNVN5VkMzMnRjT2hhOVQ2NkNaK3IwejcvY0JlcnF1V3d4UGh4VTNP?=
 =?utf-8?B?YjROVGpKYUMxTkxVRitUU2xxMml5V1MzZ1paWm9ZdVdjODNLZ2xjZEdVSWdY?=
 =?utf-8?B?aWx0UFNSVytRRjJZaC9qQXhCS25Ycm5uNzRNYng4MnJoemxMdUFveUFtMTlQ?=
 =?utf-8?B?bW11YnFyQktidUdhamRCMDNVWEtLMDRuU3NLTUFQS2xxdlRJV1diVDFCV0ZR?=
 =?utf-8?B?VnRRRmtNeWhDQ0hHUDJEQ2Q4cHQ4ZjR3aHFQTkIrUG1JODJXSlF0L3Jmb1FF?=
 =?utf-8?B?Yi9RQ3JoVTI5ZUR3bGVnekxLZU1RSWxqQmp3WXVLZnVMS1dPQ0tWZXI5NUds?=
 =?utf-8?B?VUZDSkJuR21DM3c3a09hM0FpZ2RsVTg2dEppUEYyN3hXVFRrbnV6dVhETHdp?=
 =?utf-8?B?Uk9EdThhb1E3MzJwYWRmaDZqUE54VHh6elFYdEFWeUZhY0VWUDFMZ0pxQTdF?=
 =?utf-8?B?dHk4TFliZVF4NEhHSTFlUVFPUFh3NFpHSnRKRmdzVHk4OERTRDI3aDJoY3lU?=
 =?utf-8?B?SkRRM1Fyc3lZUUp3dGlSQkl4NTI1NWlZMlhnZEZhK1ZLVitmaUoyaERXOXN6?=
 =?utf-8?B?ZFFKMkYyamRwVFlpYm1PNWo4ZWxETUhTTTdsYldXRXdEbjdLTVBUMmNWQnhW?=
 =?utf-8?B?dnhxT0JxdEl2cHNuWlEwM2l2Z0lkdFQ0QzF4djVHY1hLTFd0WFVOaXdhVlo2?=
 =?utf-8?B?cGxGMFdGcnkxSGlzMHNVdzhwWHplN2JPY0JIemFLR0xuQUcrSlhaaC9HWmpM?=
 =?utf-8?B?eTNLVlFaZDBBY3E0UzRYRXFoU1RCTTBSV3pCVXRIRUpZRC9SUGFoVWNFLzlx?=
 =?utf-8?B?WWVyeGRBMkorMDRIYkFRWXZVOGw2WnBnOFkzYkwxU29nd1lIWGU2NnJjMXBF?=
 =?utf-8?B?U0dQN3F6cWJwN0l5ZkEzaFJnU0JtVzFXVTI2Z0Y4Vm9KUDRiNVNoZVVnaG16?=
 =?utf-8?B?WFhETkdWU2lUQWhQbjM0elp2bTJBUGFBYWtCU0o3RDZwRWpNcndWTU9wTXpB?=
 =?utf-8?B?cEpWRlFPNUlhSmtWSkh5RDlockFLTmYwb2ErSTV2a0ZHRWlWc3ZYbmc5SjZz?=
 =?utf-8?B?TWRuN0huMzdBZkVFM0tnb04wcG10Tnl6WFhDckdocUQxU0JRbEw2VFRIcW1O?=
 =?utf-8?B?SE9KZzZtUHVaTlh2WGNRMFcvZUxQWFBXVlIyQ1c1eEhLZVJ0aldKQUIxd1lj?=
 =?utf-8?B?R0N5d3orSXlGRlVJWXNCTFNlSnFmb3ZmM3ZaYXdlV0xINjFJeU14NUs3SnZI?=
 =?utf-8?B?WmY2YVVhMHJLbllMcDFlTkJvRm9SQUw5MEJsb0pka1Q1V21qaDRQZWsrNktN?=
 =?utf-8?B?TnNyWnhYd2xkMzJUSFZ6K09DMjdoQmZNQmM4Z3dhczdkT2h3aWlyU3NTQjcr?=
 =?utf-8?B?Yk45TWxlN2k2TDkwVzJZdjJoUG8yOW1wSU1YVTJMQkVaTXN2NlNMYnNVbXlS?=
 =?utf-8?B?bDJlcGZIS2x2Rk4rT1RoWmpDQ213QzZVeGpjR21pVXZ1c0JyUHpCWk1Hb1Jz?=
 =?utf-8?B?VGZUU2xnMFA5Ym9yMXV0dE05YkJOSllPVEN3c3p2MVkwYU5pTlZvZW9UeTdl?=
 =?utf-8?B?ckJETGYrNXlVcmVOYlhITmNtb2prYldDQVZ1UWh5YVBTOWFXWXNLZSt6MXdE?=
 =?utf-8?B?UkZxbVVaWmt6Q3cwNXdaTlVkbmdlRkpqZ1M3cHh2MWRENlNicmF0RlYyZ2NI?=
 =?utf-8?B?YWh0WEs0QWZlck1qajA5Wkw1emI2aks3Zk40UkFDK25oQ3RHemJDZUZtenZL?=
 =?utf-8?B?dzQ4dVd6N3p2b0JlUFhIZU1Gb0xDVkJqUzVNT2xOTzVuNm1nbWhWckcvK2po?=
 =?utf-8?B?TkR0THlob0o3YzhuUGhkOHNtSkZEWnZYMUVRY09wSzg5ZTFNMmpBeFVqQ3lT?=
 =?utf-8?B?NlIxTkd4NG5ZVXhYeGNHUmt4clhMc3ozTW1ralM4Z1IrU3crRm5qK2xYclhB?=
 =?utf-8?B?eSs5N09CbmFpRmVDaEZ2Zjl6YU42czEyREd3MTliSGt0UjRIN1Y1bGthM1Zi?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028df6cb-90b5-464a-3b21-08db998d6087
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:34:29.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIh7pPnuRqmydkUmzdRL4qgQNEHlHQ7w0fPxNeCjjNGbwHheAksyrdpKV1lwDfze/yjxexa6/XNldxlHuflu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6113
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 10:34:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12590

On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
> This checks and repairs the filesystem first to ensure that
> resize2fs will succeed.
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.script  | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 83c3238..b32b2f2 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -87,6 +87,7 @@ reencrypt_existing_partition() {
>  	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>  	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>  	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +	e2fsck -y -f "$1"
>  	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  		panic "reencryption of filesystem $1 cannot continue!"
>  	fi

Why is that needed? Conceptually, we should start with a clean fs, fresh
from the image build, resized on first boot.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


