Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C8CE77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 14:37:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.70])
 by mx.groups.io with SMTP id smtpd.web10.106780.1734532621978456318
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 06:37:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LOzR3pO/;
 spf=pass (domain: siemens.com, ip: 40.107.20.70, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRl0vUI4AocZCAIi1/ncyTu3L6BUk8GiwYoBG6AEpIuT3Xt3oOlC6BJ85rjbaGrnbh1cwNFalw+c3K3EnXegRrfY6gRqinT2atpLw6OGmeVTAmt1ufzfrXe3KfnKLUEH8HNBejcwz36uViwZwcY20F/p0OmL5IfGcq/PDT7VYsyUEq30C00AbhaOl/a3yV4ix+wAg6Hz97DqJAddKGzIHPPw9TPEKChLSiv19iVzuMJKZN46wta7XXlSYTrn9Duw+ngQ0AJ/aOdT0k0Nan9lv9XZSKlvQ41/SDNYQPc2E1nabU0MlVldiV4SBmMEbb2t3xZ+WuIoYMDcsip+771DHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13lKHPziVXl/iyMR3DJP/e0/0HNc165sfkShQD5nUpo=;
 b=dVrGAyCsJ0SydxHHidvMKNCR/DOArZBgxISBxxtbcjyucf5+S/G4mIx5vw2V8g0nLmRdVAH9AUQl+P7R/u10GckJzhem3dwJgYErQhIXvQAVRj413xJkHihdYUXXYrgK66oUax7WpSwUBEvN/tcisXC/p6TnpHOhYWzABTqLBLlttQZ8d+BbDdGEk8dtUWL+BDF0fgQ99whb/5Dyw5sHsY+UK6eK1DbHyllINQVYZAfctELz2x0Pw0GFh+t58QQN1Uf815CohROlXNahBNTg48olNSRqurS4zsrwTPQQcs3tZtmM+DjOefNnvkN34MvFHDpAyV04PFTJN5+l+Z5KUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13lKHPziVXl/iyMR3DJP/e0/0HNc165sfkShQD5nUpo=;
 b=LOzR3pO/cwZO4kdciPIQZQONKDWiX4sCn9cMB7uTskGQMxi2Y0u7w7ljPcTvIERxiq6tKfc/RzTMXC9Du9Os6ZChNlOYE9799jxBi1AJI4Bxj3LX8t+P9lap+VXDLEUe1rwQ8CU+lSMIM3y+6GNCw7HcpZ6zmv8apkfgdVNj3tnqZY2P+6TpGF5kfAdvEGNZDW3J/m9C20ZgOXCscAbdXy2Gun0ZIPRZGa9DjqhXJSfZ46BpxN3aT3RgEZyJ2e/MYrMahAjLJ4MXFLjWr8IgcLPyAtT/Gx+BlgP8iqxiQNJsjCU3eOr8dIJT4B/6wgTIP+3PMSLksVbxiA5HZepaQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB8947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Wed, 18 Dec
 2024 14:36:59 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 14:36:58 +0000
Message-ID: <473d7ab6-eb73-44d8-8611-ea7bb0aa3026@siemens.com>
Date: Wed, 18 Dec 2024 15:36:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Issue with the latest commit from master regarding
 initramfs-hook
To: cip-dev@lists.cip-project.org
References: <2bbf9009-2fe9-4227-bc1f-829fed0c1042@siemens.com>
 <4730.1734456194616280646@lists.cip-project.org>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <4730.1734456194616280646@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ba560e-a8c9-4e72-7f39-08dd1f716d35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZkV6dXdiZHNjUVpKV1M2SEVOaXNiblB5MDhPaks1TVVGM1g2aldVTyt5QXRB?=
 =?utf-8?B?NUMzaWg1VlRpUklOSzdpUHV4cFM0UE9YRG84OGt6akxZemg3VUJzanlNNGl2?=
 =?utf-8?B?Zk9IazF6aXprUkpTM0xjU0VWakFlUXl4ajM0SUFJU2NXYzA2NzZlMGwxUHhI?=
 =?utf-8?B?L1FNWGZ4cUpudEhyWlo5dnk3aStGelEydXNDTiszL282Z2JsNGQvNGtjWnF5?=
 =?utf-8?B?ZEZxTy9KMlNVV05WeEN0Q2t3eDhadlU3Tkx5S2s3aEgxMEc3Vmh1YnE0MmM5?=
 =?utf-8?B?aTVUZ1FFSitxUUc5aVVKeWZjN09ncDRZUnlja050MUtoY1gxTjlzOXhoS212?=
 =?utf-8?B?OUNUbDUrK2xYb05UUFVIcHk5VEtyMTh6RHkrVDRDcG5xckFUZVphQTcxQ250?=
 =?utf-8?B?QW1nU1dkS203ZThoZnFhM1MwZGo2eFFJZzRXMVNUM2J6ZDYxdlF2bjVqTVZY?=
 =?utf-8?B?Qjh2Mko1ZkVRNzU2V1QyZUN4NjI2ekNDclkvaWtrV0ZvT2NOV2x2Z3J2azlo?=
 =?utf-8?B?blFMSTN0bllVVjA1eUpyMzZhUzYraGVNT0hPNmNQUGxydExFektnaHJZY3Yv?=
 =?utf-8?B?Y28ydVdZb1hMYXJKKzBhUDJma2Q1Smk2NlNVcTc1RG1RaUo2aXFacjNoNDdx?=
 =?utf-8?B?UnVCM1ZDUkdGSGhnN21BNDdMcS9TTFFqZkNPamdIbFlDK2pQblRmMVlwdWx6?=
 =?utf-8?B?OVVvSllXVGxpYnk5Mk11UWluN24ySVJJc1kvSE51Ny9DVUVsVlN5ZXgvNW5M?=
 =?utf-8?B?VXo3aDcyTk03eXBnaHg4ZTFiUzlCeWZNN2lRck5hZDlBa1FXWWJ0UjlCVHk0?=
 =?utf-8?B?bW9KUmZETnpWM2VTcDVhU3hHak40WUNoV1AzU0Y2V2QvQy9RZDFvTHZLdnQx?=
 =?utf-8?B?WDBrMDFRamlkUnUzUW9EWDlKaDJpbkdBNmsvdDZHcUk5M3FqdlFIbldYMi9o?=
 =?utf-8?B?OWErc0ZKdk5jS2hmOXY2bnVIRlVtSGpuU1kwUGwyQ2QxUzl6emo3allIYTV2?=
 =?utf-8?B?ZjA5VGJ0QW1jVnBsYUI5d21zSXNGN0VHc0hEYVFVbktudlRnRVU0bnZ4UnhN?=
 =?utf-8?B?YWhralI3OGpHcXkvWnhGK25KYnMrZHNTKzYwaUs3TmdCRmZkQ1doQU1sMTgw?=
 =?utf-8?B?NFIzSUg1WVpKRFJYZVkzWStPWHZMK0ZkdHBSTnJRM29Ibnh6VkVxWmdaRU1P?=
 =?utf-8?B?Z2JEZ1ZWVExvelpCRXlaVytxZWkyZWkxZWlHT1ErWm9hYXVMOGtnS3dJajBM?=
 =?utf-8?B?ZHVtbWNFUVNvTXo2UjZaWjhWeDljOUFqQnZ0SHI3bHFReXV3VldJV0IvWENm?=
 =?utf-8?B?SDVwWWdyaXNCYXJVcys3alhiL2xlSlBVSnBqOHhxOVZ1THB2Q0haamZ3ZHNv?=
 =?utf-8?B?bEFpTm5iVFo3c2cxREZRcFFyemR0VzE0enhmSks0NFFpMW1YWDNqYXE0YXVM?=
 =?utf-8?B?ODFDNE13Tmwvc0JRdmp3THMwNm1LS1A2TXAxeGxCV2llN2JCUTdjcTZNRVp3?=
 =?utf-8?B?ZDBXMHN6K05uREZpZ0krZ1J2OWMxYllDK3UxckpNVjdsdDRGMGs3R0FBK3A1?=
 =?utf-8?B?M1V5UzVnVndUckF4bEwyOWpjYUc4d0tPZFNOUFNyQ1F6THBkd2RRWEJ0Tito?=
 =?utf-8?B?Z09iQnZwWDVnM2Z3UWNhMWgyRHFNS3Vjd0xmRms1UkJvekMwUlZVMGxDUit2?=
 =?utf-8?B?WWNBUUhocUtBOWg0Y25JNXF2M1NNR2d3eWdMZmc0L2VGZmZFYlIvSGRVL2Nq?=
 =?utf-8?B?ME1tbE1DWDcwcEgyN0t2ODdTd2w5a0JYd041N2hiSVBzbUM3bnpEYmZDeFBt?=
 =?utf-8?B?T0p1TmhCREQzb2RKeDVyZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUQxUUoyU0p5MzdvdFJmVUlZSVFlTlFRdzd4Q0ZScVF4OUcxbzZjbCtZTzJW?=
 =?utf-8?B?TkVpZ2xuVnF1dHF1OHRkZzVoc2o1TUVyWU5RWEs3QmRPeXBqdHZ2WEVYUG1G?=
 =?utf-8?B?ZHp3ZUVJbllha2tUODE2SEQxZmltWldtNEVXLy9tcDdSbzlmN0ZsMGVXUW5r?=
 =?utf-8?B?SUZPTUVXaWc5b2V4VHZVM1F0Ti9RdWszTmdKeXN4SUJuak1DTjdmWUVMQW5V?=
 =?utf-8?B?Y216Vzd5OWhMcEY3d3gxMzd1VXBpckw1dEo4TjZ3akUrK2Y4UGYxRDE4cllG?=
 =?utf-8?B?MmRjWDdyU3lxOUY2RVN1SzJLK1gwNmhNeG1CMXRuRFRFMXJ4UmRacWlZVG1i?=
 =?utf-8?B?VFFoaFRqaytNam5sNWY5ZVZnbEI0ZVdZR0wxMjR2NlRrUERDQy9LT29mTzVn?=
 =?utf-8?B?UHUwa3BoVGhmR01WRlJUaFRHdmorSGtJL3ArNmVMdGxZVmRvR2xvWEVQN3M5?=
 =?utf-8?B?akRxNUFvdW0wZ3dldkt1VmRaOHlLNTAwUlJteEF4UW8vS293WkNzVm1VUkdO?=
 =?utf-8?B?cFlDMlZ4M1RMbFlLS2NYdS9oWDZ0OTQ0ZVNEN3dERVNvZGVoaFRrUENEMHN2?=
 =?utf-8?B?RVRySVJ5WnVyb1FPSDFxVWJWNDJkaVd3cVZ0aEJTNnhQaE1DQlM5eFkyZjg4?=
 =?utf-8?B?cmpleG5Wc2hIdXk1NzNKUkVkaTJUQWhxMEs5WG9RelRXOHh5SnBPUFlhOEc0?=
 =?utf-8?B?WlBOSEs3ckJGYjZRRVhZbDE5cmExNDdSaVZvQUdsRDRtV0xUbUhWcURkQUhl?=
 =?utf-8?B?dTVJZ2QvRkVGcFJ0VS9iZk13dk1iTjVSbjRKM1dvSWtUdFhEUnFSLy9oWHA3?=
 =?utf-8?B?amQ2SjBGR3V5Qm5nK0V2cDAycW56Y1RGUzRkOElOd24xWUZ5djJkVE1Qek05?=
 =?utf-8?B?a002Z1pnUzBjcWh0dUpCZHd2WVF6TjBla0dxWHRiWmw4ckxOQ21sZWpIekFH?=
 =?utf-8?B?OENQTUJCMTNxUUtPWnpqNjdJSEprSWIyUGg0MzRPOFF5eEtVVnFqUlcrWnBa?=
 =?utf-8?B?S1M0NEJDbGRNTHFncHEzNGxtOW1VYk50OHJ5RFc1blo5b3NzcFE5OVF3WGFr?=
 =?utf-8?B?WnBlSkV2cUxtZDVvVzZjNXlrMEdWRlJEK0RISHc2dXViK0VBVk9SbzVZMDdx?=
 =?utf-8?B?dktEaTBLTXVNL2Z2ZGljZXNnUUU4SCtld29rL3B3MnJHQ09VRFh1T21pQlBV?=
 =?utf-8?B?cVdGYy9MZFU4Sk9OdjJ1Vy9zMlJ2VklhSS9ERXZWcXFock9PMjgwTjdiT2JQ?=
 =?utf-8?B?YU4yaFk5a1Y3Y3JRNWYrNFlONDNGNmRhWjRIM1RHbC85dm1wK3pPYXpON2px?=
 =?utf-8?B?Q0VOc0JKaTArWUszeno5WmJtTFZNUHpDSTh2RkUyU2dmU28zV09hemVYRTJn?=
 =?utf-8?B?b2MwYnZBTG9zK2NQdHlrREl4b2xUaWNMM1VtNHMwdnVDMHJYWVI3ZnVEdHpQ?=
 =?utf-8?B?NUczU0tZR3FPUWFLTHd6a2ZJQlprVUs0Q3M1NUJKUjJWUy9BbmRVRlBZcXV3?=
 =?utf-8?B?VVF3aWh4TzQ2QzlhcEh3aVFyMi82aitiTTgrTU02Z1V5NjkyMGxMV21hQ05l?=
 =?utf-8?B?S2hlRjYzQ1NXa2tUdWMvV1d3cm1idzUyNi9ScW9CNTdONm5rcnI1aTFoOWFj?=
 =?utf-8?B?OTRmdHFka3gvbGUwVjdON2FHRGhweHlXWjNjSVk3R05OU1A4UHVVNnlVZDM4?=
 =?utf-8?B?T1VSNllGeFk0NEc5N2FGQ2JPZmRjTlVDZ0FoeXFQQ3FYV0ZlRDVUS2xoNjV4?=
 =?utf-8?B?YTdvam5yQ3hNb3cwYm5ENjhZd3ZHWVVkTTF1dC8vdExmWXZVek8rdFQ1SWVp?=
 =?utf-8?B?TndTSXkreEIxdzFDbmNRdWo3SlJBR2ZyelRIQkhmZlliRkdNdjdXYWFIekhJ?=
 =?utf-8?B?K0dZb3dIZVR6SGh4b3JYWFA4Y2plNVhscDZMS1NMbzFXaGZJVDhHTnZjQmhz?=
 =?utf-8?B?c3dnbVVUZEpHcDdFN3dJYVFUZEtWUDRocVl4VTM5elZqaWJWcHVIcHF6bDNS?=
 =?utf-8?B?dmpOQnNiKzUxWWN5c1FXam1HWDZGbERpNjVDZGhOUzZuYkhDWVdLSENlN2dT?=
 =?utf-8?B?bnNoSE5JYWpheDBMNXNDWkNPeTQvaVIzVGkveTBiOVY4d1V5NW5hUzVHcHBY?=
 =?utf-8?B?NXVWWEFnTnp6U082TnZoeDREQkhZMzZHbHkxRDJzOWpESENtYUx4SWdZVVlR?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ba560e-a8c9-4e72-7f39-08dd1f716d35
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:36:58.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhVQFy0b8Yh6MJeFNZCAXepQ/LpWk21ohwMR/6DxenC3+1vu89UXlgb5qOnTbWd4lBt+Sfh3FHb+NHzUuQ5S518xHjKk4T3J+bXsL6omUvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8947
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 14:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17465

Hi John,



On 12/17/24 18:23, JohnW via lists.cip-project.org wrote:
> Thanks for the insight. I see the updated isar reference now.
> However I do see some issue when updating the isar version in my builds. 
> I am seeing the following
> 
>     ERROR: Task (mc:installer-target:/home/ubuntu/workspace/john-
>     sandbox/build/../meta-test/recipes-core/images/test-image-
>     base.bb:do_rootfs_install) failed with exit code '1'
>     NOTE: Tasks Summary: Attempted 298 tasks of which 235 didn't need to
>     be rerun and 1 failed.
>     WARNING: /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-
>     bookworm-amd64/test-image-base-x86_64-sb/1.0-r0/rootfs/sys left
>     mounted, unmounting...
>     WARNING: /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-
>     bookworm-amd64/test-image-base-x86_64-sb/1.0-r0/rootfs/proc left
>     mounted, unmounting...
>     ERROR: Command 'sudo umount /home/ubuntu/workspace/john-sandbox/
>     build/tmp/work/debian-bookworm-amd64/test-image-base-x86_64-sb/1.0-
>     r0/rootfs/proc' returned non-zero exit status 32.
>     WARNING: /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-
>     bookworm-amd64/test-image-base-x86_64-sb/1.0-r0/rootfs/dev/shm left
>     mounted, unmounting...
>     ERROR: Command 'sudo umount /home/ubuntu/workspace/john-sandbox/
>     build/tmp/work/debian-bookworm-amd64/test-image-base-x86_64-sb/1.0-
>     r0/rootfs/dev/shm' returned non-zero exit status 32.
>     WARNING: /home/ubuntu/workspace/john-sandbox/build/tmp/work/debian-
>     bookworm-amd64/test-image-base-x86_64-sb/1.0-r0/rootfs/dev left
>     mounted, unmounting...
>     ERROR: Command 'sudo umount /home/ubuntu/workspace/john-sandbox/
>     build/tmp/work/debian-bookworm-amd64/test-image-base-x86_64-sb/1.0-
>     r0/rootfs/dev' returned non-zero exit status 32.
>
can you reproduce this? After a clean build.

Quirin

> I think I've seen previous message in the email list about this issue 
> but can't recall if there's a resolution.
> Thanks,
> John
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17439): https://lists.cip-project.org/g/cip-dev/message/17439
> Mute This Topic: https://lists.cip-project.org/mt/110102139/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


