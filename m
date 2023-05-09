Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B6C7EE22
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 06:22:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web11.25373.1683613316542619790
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 May 2023 23:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xx0FupXc;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Usuys9drzTy3C9/3b3fJhWDLS+xp4lpJdzIHUKfX+21BPrSHiYXOlcVmDXyu+7WDz6/+vjZUqI6wnZh32CsdY5NGmAkRZ+SWXKleyVrNLutD7Ob+QwKpVobNpCicm9fZQJACMC6AlsNW4cNAmKQeXTrL3I+QeskL9tKhRMdAzLZygZ7Z+3DbbYlntfef9c4KCC8a20bgJPFTD+yTZMHDU/jKXYeZW3W6i1X2sPHsmluEmbVahsP40h42/sfIxdMVpNpm245EGLd+qT5PDaMqRHhdOlXzDbCdLUh4FDbVyBuOc+z4hMyFYkqx1FslSr1hhyvxZk1VgO4Fs1oSpUuZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTLuU7Y4ry9BjyKna7OFZgoYF+ZOwJMF7roPfRYH4E8=;
 b=YCwTSt13MXF5lIwZyQ2dbiK5xTjo+aG7259xVzO79Gvd09i7kG5Nmy/sTlG/p66pjT2PE7esFbGXFZGvJnU9p5s+eBj473YtXLhOzwrU8wg3AP6ABwRIEu2RE+vT6kioBULz3DFIFSZ0kEInG81JS0r7DU4ivOBxER0cddqcwQ4332TDQ4VSsZeh1ra0p10dxVNe6NHW6OdluKAtqiPCjp0WT8hEMsQj7pevAM/FWi0xh1SqURZTMa/9LBLc4bkkISKpkzU5HxsukkVyDH9akDVFjotGgt36kmhi34KuZwy3DaFY7ZDQ5JKC6fgoflHuQA27hG36CAoDXYgYvPn41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTLuU7Y4ry9BjyKna7OFZgoYF+ZOwJMF7roPfRYH4E8=;
 b=Xx0FupXcC2Az0L4CkoTCNnKysouBjeIKCb8kaFgerVgY/A7FB1qY+LzvH5TRQghxIWKuNwBhX7EA2E61qf+Jm/qZq2/Nx1pGJQNuJMu3LG9Ag84WPgWgB0l5kDuH86nvXvQbfw8sIzn9iReQ696yd1rR+viA5FxhOG8pLACNzAL7Q94YUqTzt9CXr+Tc359WyjVfk7VZ6PsgX+7ouPS5MGBwFDIZfKVMEff/yrqFDwbqrlA6HAmmHlrhD7ibAzo2NpYaBC1cYXBCxBnR5UKINBPQMovXL0Tn0JihiCBAoJJaYcZwA3acKBfqb16A6Af67QCsTJrQiP0glRl1DnKQrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:381::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 06:21:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 06:21:53 +0000
Message-ID: <a030f206-30b6-b2b1-5e66-9dfd796e5d5f@siemens.com>
Date: Tue, 9 May 2023 08:21:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core] image_uuid.bbclass: create /etc/osrelease file
 before do_rootfs_finalize
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230508154031.26473-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230508154031.26473-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b0dbe7-7b52-49c3-fde8-08db5055ae8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/EJ3Kxm0EiotLDJ/g5U9xAc1kAiMcSRioo3tbzhA9R/9uBq8anWHw20fYPgCXxlICmU1sA7MNS7o3Rwx5gDrxzlyjTKns2dKd7my04BkDphwSima4+MzD7ztajnlgP07GnD711fDulI8oCmDmyTUEeU064lc/8XWz6i2LcaloYvfJtqPliuX43BA/iWd20qUqgG+kY8LADnHkYlVeQWDDRYTIMuD6/6qpgxBVAxUp7XWKfKckwQhuT57gMdTRrQwtR+guo3NVpJe2fpk1D5KtOM4XHDa6IKM7E37Q9S4lhHstDP2aVs5pMhBBBgvHZO2K+MYDduHHf8zk7VzTCRgaGDWXDg7xKsgXFiNRYRe0oazv988LaT61/CdK1sS549+BgKiTQXcE1GcjWsyjF+5R2CEdG6juNoT3PldBae8FnXCmAUkY+rN4pQfNRZrV4X07ga+nMU1+tjzqsH0h9X4ZxZsujUVJOM2BzzDrhDgVEHAFOTHVaiFJPfq8zbeKded7lHbzElGcxIMjATbA+hPxlQr1ZWvc6km1X2XTu4Gyv7E9GKfu01JuQKxYb9msgd0y2uv08kWVGYAhnWW/PyEZ1pRNhuxzn0yKoHBEV+fO6609gRBmJdO0U5n8gadA1Cos9ALygGrFN/pP1m6NMiSmgGcO2vPEGp7+0EJBdNlbuk6XjNOiU5kwZTJn3bYQHqx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(31686004)(66556008)(6636002)(4326008)(66476007)(6666004)(478600001)(6486002)(66946007)(316002)(37006003)(31696002)(86362001)(36756003)(41300700001)(26005)(6512007)(2616005)(53546011)(6506007)(6862004)(8676002)(5660300002)(2906002)(44832011)(8936002)(186003)(38100700002)(83380400001)(82960400001)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WW4zanZrZFk4MzJKSW1JanBvUk1kY3ByOGdnZDRaWGpVVVRWWmExSHNabVJq?=
 =?utf-8?B?YWV0YUNqaFZnbnM5VGRSbEhyWXZaYnVpVzRTYVBCdFZLK0JjTUZta2psWUY0?=
 =?utf-8?B?T2hTcnpwTVJWQktNVEdKRGZFL0tlZXJWRk5kWEVqQUl3Tm0yUk1ZdWJieEVk?=
 =?utf-8?B?QVZXb0g5cjR0bmUyOXQ1QUJNU1kzU1dHaWtwU25CK0xuQVdra3F5REVidnQw?=
 =?utf-8?B?KzB1KzEwWWNtbHExM3hxbXhKblNIZ29hemRVVnFtNjYwOWd0MEJMazh4MnZz?=
 =?utf-8?B?WUhxU2VuaFBoZnBVR3Z2c3gwMFA0MG1LSmlONEpiVHJlQlN3TDhRUVRTWmk0?=
 =?utf-8?B?YUxFV2dDeWRDc2NkTUlVZVlTSlcwQzdBd1BUQ2FiWkZtWlphaHFra0xWbUlu?=
 =?utf-8?B?MnV2TWxVekwvNURaeUNhTVBLUUd2Y2wrTWkzZEdoUEhjUElobDNYckNBZlp2?=
 =?utf-8?B?cUJyOHRtSFdsUmlTUUJGL0Rzd0pURHN6M3dzUEE4YUxJUkxpa1JVSGdzQm9h?=
 =?utf-8?B?WkdLYzlaelVzeTZkemEreThPdDNvTmZMUXpoZFd1WDFlMXVuY2FQcjgzL1FR?=
 =?utf-8?B?VlZIektkbnVxR1dxWUYzWWpmWFA5Y1FiNDBFaHJ6UDQvaThWOEJxS3RqaUhV?=
 =?utf-8?B?anRvczlYazR3anB3VXIzS2RwK0hJMlpocjRQcDVNMlMwQXcvcmdiL29GNnNI?=
 =?utf-8?B?UUJwWmtXeHlGM0g0c1hqVWh1NXJXczFLZWdEdTREYmY1TTl5OGFjeUtLbUdE?=
 =?utf-8?B?U1Q5K1hYR2tBbmI5Rk1mS0ZPaEFOOFMwa3JHYWttc3hBRjQxVHBYSWtLN1lE?=
 =?utf-8?B?SjB5b0JOZHQ0TkgwSE82LzV0Zld5WTlMVHpROWt0dm0xTWtzT01QWGFTengz?=
 =?utf-8?B?aXFzaTBzN05sQWgzZU5kME5XZno1RTgvWE9jamJmdW55cjBuODJwNEo2R2R6?=
 =?utf-8?B?YjdjVjBKN2JyUDd2YVA3RU9CaFdPWkZQb2ZRNDYrYlVhbW1QTkZyYnEwaElE?=
 =?utf-8?B?YkJVL00xaUVycTJTdlBGRjBXd1YrVEN5RjJKUDAybmtNVlRlQXZxYU1TbnNa?=
 =?utf-8?B?dDl3Y2ZnQ0wrd0ZHOUFtT24weFdmOUtPd0tGVk5IQmlzdFJ0ZEM2cGVwb2Fz?=
 =?utf-8?B?REdOWmlSVHh0UW9xQ2dUWEtnZk9TbE9lN3JkaUVrbHlLMUhRaTFSbnMyQXpy?=
 =?utf-8?B?MnBrVXRXOGdlZ24xYjZEQTdqeDEzUmpKdVZweXlhU0U3WGJDTklXa2FHNTlk?=
 =?utf-8?B?WjBIakdzd290RDFmb1p4Y21CVHhidGh5NEs1bHJjSVBPY1RUU2s1RGdRWFcz?=
 =?utf-8?B?M25tVmFHMmU0dnBVWHBzOHlGY3cwQUFDN1lDakRFVGhLUVFHVHllRlQvTTBx?=
 =?utf-8?B?WkxwSVV5RHdtWkE2bTdFUUF1VmROSnRTMHJFSmplQUFSUDMxWGxnMGNET0JS?=
 =?utf-8?B?Z2ZHazRuandaeGhaKyt2M3NRU2RNTGhSZ2Ird2hCVFNKd3RQbjVCN3hNb2JN?=
 =?utf-8?B?Vm1rQWhPRDFXUW5aNG5HclZaVm9pc05IMG9sa05QTlJwb1RxTjNEbW13NTVu?=
 =?utf-8?B?Qk9mVm5LL25RWGh5OE9LdEN3MGdNL3dZTHJyaDNqcmovTUNuOFZCNDN2T1cx?=
 =?utf-8?B?eEVncWF4bkxOaVdzcTl1NStHMkJPdDMyVzNzdGQxek56SDdGNllsdENwQnBZ?=
 =?utf-8?B?WWEwNm9peEJyeXZET3VQbUNISjN5SzBhV2pZWVpOWFBLZ1dSRW84ampUZStp?=
 =?utf-8?B?NEN6Zk45dFN1cGtmdnFDQkl3Y1BNQ20reVVnK1hWYzcrMEVrbE9Gakt0ZFRN?=
 =?utf-8?B?ZDk4OVMzTngyOU5sK1JZcURwMDFHRnk2bWhvUVRxSXNjMmo1S1M1QmlaMllI?=
 =?utf-8?B?cFlGbHJORk1EY3pqcHBVVzNoZ1ZwUHFNdEcwVXhHMGFXTk4vVkdhZ01Ddk90?=
 =?utf-8?B?WGlXd2tZalFXa1NubkFvWDZDSkJKaHVVOGRYQnNuMS96dFV4dGtRejhZSG9Y?=
 =?utf-8?B?dEpzQU9PRlFUelZ4aks2QXJxRFo4bThaRXN3U1doT0pvL1JpbVI5QWwvZUdQ?=
 =?utf-8?B?LzZaN1EvNmI1THVuV2NPVFE2NWo1Q2x5ZG04NDlRUlFYUXV4czd6aGlhcHBp?=
 =?utf-8?B?ci9rSXkwa3BpRGZHNlBXS3pPMGtBYVROTzd2MDE0cXB6Y2VhZXFMRTY2a0pp?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b0dbe7-7b52-49c3-fde8-08db5055ae8d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 06:21:53.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVSOTem7DXlVilurOZAyIwPCaKlXx7D5SEmC977Wii4PlVp06pww0x2dmSPKvWypWtQ62FSCyOh20QNzjJgEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8068
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 06:22:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11419

On 08.05.23 17:40, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> reproducible build with swupdate target is getting failed due to the
> `/etc/osrelease` file timestamp is not constant across builds, it is due

os-release

> to the file is generated after `do_rootfs_finalize` task and the
> timestamps of the files are made constant in this task and so move the
> task `do_generate_image_uuid` prior to `do_rootfs_finalize`.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  classes/image_uuid.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 2bd530f..9ffe14d 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -54,4 +54,4 @@ do_generate_image_uuid() {
>      echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
>          > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
>  }
> -addtask generate_image_uuid before do_image after do_rootfs
> +addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_postprocess

Looks good to me - Quirin, any concerns?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


