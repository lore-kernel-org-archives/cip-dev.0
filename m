Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02BCC47074
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 12:38:37 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.72])
 by mx.groups.io with SMTP id smtpd.web11.27875.1704199110801054053
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 04:38:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a2hcZFi+;
 spf=pass (domain: siemens.com, ip: 40.107.13.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCtK1gRIJ6LpuTLKOxUxHqzPA09lmA/b2b3eAC7EC1AbFuFcJqo172uHJMl3KowNNPywj+yCMBo9Ze9HY3rLbQ298rf71rdC32Ae72njhR15qsIikXvXDG+eFBER0YfYvZ+D0VX90h18ymzGGs/abKaXPGA6DvsxIS93EoxjcE663/wFgLV4XKG68UsWuI497rGKlxTgX/Ctujx8c5MtLKb1vUvPjJl9NvfXr9d0ILqBRo26znoHX60weM3yr2HLj7QVjfAcChBPv4aIOyChpuaCGWMSS8wJyUONQucYJ5bWyqTyLdBiwcD9tXTrsHtzB75AiUmnNtKnYXNj2B1H/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RkXaPtkIx7yWqxT9TXyiPH1+MC6abIRuUvOa2/tNos=;
 b=BMkgA3/SkLHSisJErN2mmf9pW9Q0HkWR34ftuPWRCZsDYk9oFVCBMd7ym+9XrAXT/lYaR/FzYOhWQR1DI3zvNV85sJjiiGKTFeEmkmgFt/c1yWz+Veu2LL4+5RBA/rbdL7akJ6NYTqYUydB9tQulB3bw7dnjuhpXVS55dCP9XMKNYpDy6sT1bntVSHSz/YUkGbntxWJ8ftVMB9MtXRFxef+HsQO/D7f/J5W7bqzXNvcfnRlg6A+ETwsCsWsjJBkFz1WUqHBUZX3GMkm+w7cesF6SUg1hN5lfC/KmnNqVGCJupm7nP8VDxhZJ4zeHbjI0d/65PyUR5NmOU1dQ/4B40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RkXaPtkIx7yWqxT9TXyiPH1+MC6abIRuUvOa2/tNos=;
 b=a2hcZFi+kStf+V4EMwYDNHDSd/Kl8iuDWIAStkuKM+UAP+EkeehQoUxCX3KO5DYNIkWn4Dedw2YIn3yv5F5lX6ZgCxSqqo9K0jI/yDqoGT69QRpraMzjBFxa8w3bkpk+Wb377ijYkEIZUNZ6uzv4NIamFTYCmw2jfNO/fcAYa22diu34AHO9G1H6l5xjbph4A+OtBU3/xFeTlsrEvjl7SLZawQd1q5zZBUz8hv6GHo7WYZFoGmCs07iC3awBcXsNoM1MFDtGoyfKiDlskvbFwPNYCwvizNAo9l2q/IBuTh0OV3peM2x2dK0EylZbGAAdvqN37UlDCucV4Ge6PFRzOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:38:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 12:38:26 +0000
Message-ID: <0731166f-792c-43e8-9a12-8d9abc88549c@siemens.com>
Date: Tue, 2 Jan 2024 13:38:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v3 1/5] efibootguard-efi.py: copy
 signed ebg binary to DEPLOY_DIR
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
 <20231229123111.400555-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231229123111.400555-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3881:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4aaf3c-1c11-4252-0964-08dc0b8fb77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vlJZlW/mxT568yoQQK9SjIZk6mQyadYql+4xO2BMPjS/8XbZrn9mNOvfsaHqGLHVUcHuTBjrlJ/XOwSubz3AjHv3ABZ49EXZOcgJvh7LYfCWhdXxaHRiSEQKDWqUPRu/ZofGogRCW/gP//g5PjmTIf4KGXylaHvEY07sk7DTIHamP35ESa5yjzCPjH6UThXXRo2J8DQKFVihKqicYvvUAraG8tKAyke1ahgMVF0WWOBFbm6qYpKFCSSLu/tGnaSEJWLOhhjGCgVfxybhCGTT2GW/YBlvm+WN9sMZPO9FAr3sjsqcFDZ3kJW/LYci3L8j8U83FBFHWMJ76telYUrkBWUyjZoKR99NWSWHL6z+znGMr5o8jCaeSu8CBxIRWbOztNFwELTdXgGxVQWFjoVamaI6Gg6n0kslNJqVOQxB4V7GXLnt1AmZAtkg2qAiLBvYS7AttZNNEMobZchB1UQkwikOJkahXtuo4AmnOTT4eXc6+rLSZAyEseBeN3gAf226dPHCDcbMcjlMCenqa/L4tNiMhnDrwoVQiHxoreqHQMvXho8s3P/JKbaeOBZ0oz8Jp2uO39O+y6D/TOXCIMlFb9NdhQHIeoBN9H/1fBIfMJeclqoZ8mOtvqobD1yBYsQJnOiVpCDZWgMYzqeDK3Qldw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(38100700002)(82960400001)(8676002)(8936002)(5660300002)(316002)(2906002)(478600001)(44832011)(6506007)(6512007)(53546011)(66946007)(66556008)(6486002)(66476007)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VFBINS9waDJFNGQ2ZllIa0xiV1VPS0JTWHl4QloraXJGSHNubmZxenpqeEJF?=
 =?utf-8?B?Z29ud3lwL2ZXQlhGaVNzWDBuM2hCaTJSWm9KZlVwNkFiZjhkWVdRcWdnaWU5?=
 =?utf-8?B?dzZleFVsQ3RscFpnR0hjRlA1dWRPL2c2Ri9VT09MdENlbU9tM2tTL3Zpc1BQ?=
 =?utf-8?B?SUV4bStyNFBxc1BEcklZS1I1NzFFblM4SlhoVFRHTTl4ZGFEZnhHTUxnZkdO?=
 =?utf-8?B?ZDE5SE9yd2d6ZjNPUmdHZGhlMjZHYkt3SHppY1BOdG1Ga3BHSTI3SEFFakph?=
 =?utf-8?B?ekhWWFdFaVhXSS9ENFY3REU5VjVkRm9Ub1BMS0YyUGZDR1hRQzFKR3MrUEpa?=
 =?utf-8?B?M0dUQWcxeE1IRDlTSlNwK0NhVGlBQ2hhRm5mQWUwR0ZmNkRWMUFzeDY3NjJ5?=
 =?utf-8?B?ZTVzT1FWdklMK3VldFN0WTlua0ZzTXZHU0NvTlFVdzV1MmVvRm9icVQxVmZi?=
 =?utf-8?B?UlVibFlFL1dqb1NUZGt1am1ra29FK25DN1JremR0UWpxbHM5MGVhbzdBc2lw?=
 =?utf-8?B?akxBMjVNMmlCbDZwaXpoT09uSE5mMUFDMW5yaEsvOG5yc01GOEdhSU1tY3Uv?=
 =?utf-8?B?VlJvS0JSbnltRXlLbHVPRTBjRU5yMkw0YUxVbUxZMTVjbENXREhSZStPUlQ3?=
 =?utf-8?B?ek0zbFJBUHBxbUhqZlcxMEtzRWE4RjNLU01STENmdGQ2eEtrbmh6ZlNQbmdF?=
 =?utf-8?B?VlFsWXJQRlU3WEEwTEh0UWlIVzJVSE5wUy9TQzV5aGpaV2xBSTl1d3c1SFNw?=
 =?utf-8?B?RXZzQWJpMDJvK1NRVFhQcDFXYlhXQnFHZGxZZE5TK1pmUmI2blNUT0tIZzFz?=
 =?utf-8?B?ZVNNYjJxOGtEV3ZRc1ozQjdEMGZjVUFza2NHekR2OWtUSHFpa0tTR0t6SnQx?=
 =?utf-8?B?NDRLNng2NUhSaFJxUjJldEdNT3BtQ21OR1hUOFlOTVJUMnJvNzlSakZzZ2RC?=
 =?utf-8?B?dVR4V2huZkZUeGZLek1OdlI4c1FodjVPVnA1L2U3L3JaTDduYVBLd1NYaVpJ?=
 =?utf-8?B?SnIwSW9NZ0t1eXY5T0lPVHFFN0xlOEd1ZmtHRUNyRkt5UlQyelgzQnBCZGRw?=
 =?utf-8?B?U2ZQZXNjeHAzSzBwNitVSGlTTzFxWlhiMnRndkYzYS9JUGFFdmxJQmJOMm1I?=
 =?utf-8?B?WUUwUmZUU0V5c21HRjNEWE8xM1RvcXV5RUoxMGlsQ01ia2tHRm4xRlI1bXNv?=
 =?utf-8?B?Sjk1ODJ5eDFtNVR4NmVwMGV4R3dxUW9uRklnOWs1RXRUdEFWRjZoTzh2dHZX?=
 =?utf-8?B?ekJjazZ0U1B4M3doczl3L3lxK3VTT1NTL2gvZVh5SDExUGZRcE5UU050OUJr?=
 =?utf-8?B?MGtCNCtGWm80Q2FoQmNlbVhHQk1PTStWU1RNdFJmeXdWVUduWGFSWU9rWDA5?=
 =?utf-8?B?VG9pVm01ZCtpbFcvMzlMTGdiV1RpeGYxTjkvb1c0ZWR1OWdLTzErTG5HdjRC?=
 =?utf-8?B?TnRwQnZvb1gvK2oxWnE2Si9McVlKQUNVVmdYQVZIRWFTd1lONGEyNmM1Z0tO?=
 =?utf-8?B?d2VqdEJIK2RiZVJiOXl4OHlXYlR1YVhGS3VUL1RLWFcySVJ3bURwcjF6aXY1?=
 =?utf-8?B?cE1UK0hxTnFuekFGWVc1dCtNaXA5QUJ1dm0vcHRTY3hremNIcDJ0MHM0eDUw?=
 =?utf-8?B?enpDV1BRYXd3THRhTWJ5bGZOR1VSSkxKYXhndFZ1bEVjdy8rOXlzK2FiUHY1?=
 =?utf-8?B?N3dLMThxdlQrdDkrUGtZWTZ3VzEwWTdTUmN1Wm11S2pSMnRueDVQYUE4Vlp4?=
 =?utf-8?B?SXFwRXozZVdrNmdTWDZYY3V6UzJ6OUhpYUN1Z042MHNteHlGdktQRjAxc2N3?=
 =?utf-8?B?K2pZOC80cFBOR2VqeGVoUGd0anROeWZDcXpGbU9UR3h5cEpUcFd5L3hEQTJi?=
 =?utf-8?B?bVNWSnRucU5QQmJEekNLa0RPUTFjc2lJenEzWnNHVlRONUUyMjV1UVVTVTBn?=
 =?utf-8?B?cFFnVHhVMm5lUFJVZ2RUOUxudEMyV0lMcXdUQVBBQWUwVlUvdFhPaWNsZ29q?=
 =?utf-8?B?TjBUZ0dmeVNZaEZWK0Q4eWp6WW9WT3hRSDRCWkdWTGlBS0U1OGRzZjFpRWlu?=
 =?utf-8?B?M3M4RCsvMmNkNFh1RDZ0QWduOHB0ZDgzMnlZL2lrWUV1NDdhVjg1ZmdSaFJ0?=
 =?utf-8?B?UUxlY2hvOGk2L25MRWhNUE9sT09FVUJYL0RVeGp3eFF5YzVvczRrNlZwRFpF?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4aaf3c-1c11-4252-0964-08dc0b8fb77d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:38:26.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJh1hzQvUbvDJSFVraXPJFlgQXMdliB2SlxwYvXbUqkkCwIvVBjQux4JbUL79gsD+ZGHCl1drdFDVUMsc1R0Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3881
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 12:38:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14225

On 29.12.23 13:30, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to add the signed ebg binary to a swu file for
> updating the bootloader.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-efi.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 86a22e0..f40b706 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -68,6 +68,12 @@ class EfibootguardEFIPlugin(SourcePlugin):
>              "riscv64": "riscv64-linux-gnu",
>          }
>  
> +        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
> +        if not deploy_dir:
> +            msger.error("DEPLOY_DIR_IMAGE not set, exiting\n")
> +            exit(1)
> +        creator.deploy_dir = deploy_dir
> +
>          distro_arch = get_bitbake_var("DISTRO_ARCH")
>          bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
>              libpath=distro_to_lib_arch[distro_arch],
> @@ -90,6 +96,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                                part_rootfs_dir,
>                                                name)
>          exec_cmd(cp_cmd, True)
> +        msger.debug("copy {signed_bootloader} to deploy")

Is that message really useful during debugging?

Jan

> +        cp_to_deploy_cmd = "cp %s/%s %s/%s" % (cr_workdir,
> +                                               signed_bootloader,
> +                                               deploy_dir,
> +                                               name)
> +        exec_cmd(cp_to_deploy_cmd, True)
> +
>          du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>          blocks = int(exec_cmd(du_cmd).split()[0])
>  

-- 
Siemens AG, Technology
Linux Expert Center


