Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622D9C282C6
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 06:51:22 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.53])
 by mx.groups.io with SMTP id smtpd.web10.16656.1741071076990971560
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 22:51:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jisUmuRb;
 spf=pass (domain: siemens.com, ip: 40.107.247.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUj+038MrV88/ze6zSwDVsB8XbUM35IZyN8N52pyKuOSgQq7G7IULpSU9hIWa14ASoYanbqtPcRb3q803WJv8WBEhlnNiSAWtFTtuPpdVCkVCnMz4lBg27ao3v4Q7/gzmeUNAQ0QHryCejiHjIELDzfFl3nhQjRYkAZ5SE/IPeMzNdmV3FuH/esSaqEyKC7+lIHrzhPAj4EuOIq/Xvz5IpeKzR+rrt1tpxqIMJs5W8exLrSMG3ljOuuEuPYFLnHvsB/0eK5tGHkXpdmj5iAP0xpnuS6Izr+01DZoLSVCvDMpQzPX+TJUP3/dl0MUkTZR7IVSel0RfdZ5r/mggioc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeqLG+p8y36ecGYpBeI+3ngqa7D9Jcz0x//HXBnxAPU=;
 b=MYAAfkHfmts9BHYxTMr7D5hWDlKFLgt9zQSo7OtskXufMjjmy49YsKETuZTa3MTwhOOKr8Om6MCmmiVJJftEno7KD+vKClmA8zg2YjC74fKZYMH0R8h+iBQ3bLpjL9PfsLjVuae5NnrQwLPb7Kx4qkrBxlNnKZsrUEvbSlHL8UyJwVoeshM88GODHGxe6f3acRzV6VutFdgWKSkj7DSFcENA3M/gDK2wwPW8KfbW8LgcXsQ+WIj9MlmKILvnNRcOslklj0/cRL8AA0mtVn9hBeRVWA62W82Ev+Xxm2HPVz5BZb75m/5nUAQ/1pinEaobuI5bAeSgFg456Wmelmri5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeqLG+p8y36ecGYpBeI+3ngqa7D9Jcz0x//HXBnxAPU=;
 b=jisUmuRbCFVkyiQbVr3Mn/HZjM7K3WqtaJhMQSkR/72/8ZEq4XyS5VcEue1gXPR6KV45nVSM0WmOLC8pzPX0M0p6FBxBczhvZ2abnoy9fRsY9Td4Sykv6lvPNhQPmHz42u0RkN4Sum148PR/QUb8H/HthdRUAkm2b8Gdtw+WXTeTqUfJDbZJ+En0WrU1r38yCbVjUlhvROAjG6SjBxwYZnbHWpZXXbGlqLZT/mOe8N8T+tzuPM0949So7V3UfHyZv7MSw/5nmkwTwzxyAPAFUDE/Qta7MFFf1JLm72BEulDqWtI79qyew/QFuJSlSu9eoA9MD8x60iMfmp7jf2R7wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 06:51:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 06:51:13 +0000
Message-ID: <c467e520-54fa-4060-860a-a9236990e0cc@siemens.com>
Date: Tue, 4 Mar 2025 07:51:12 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] swupdate: Avoid generating useless ext4 images
 in qemu configurations
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 72207fa7-1c37-4c29-0825-08dd5ae8f43f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Tjc1YTdwbWZ0akRncys0ZzJqQUs1R3FYNkUyS0QxUk8wUnJRUFNYMjFMdzZ1?=
 =?utf-8?B?TDQ5aDA4bG41bms1dTNmTVZ0WWNER3ptcCttY1gwckM5NGZpV3hvVWhkMlpX?=
 =?utf-8?B?OGJDLzJyT3JGbGNOR3l6UmM2VWI5NGpuZUwyVWNWWXJGQzZ6N2gyWHBNS1hI?=
 =?utf-8?B?Qi92ZnlpdTd3NVZpdzBrQm1vbVYwSUdYTWNpem9sSlBHZVcvRjhBS2lYV3Nx?=
 =?utf-8?B?cWpYRnVOc29KWkgwdGpteXJEM3FEYzdnaHpGeVVUM2ptMm9ZaEx5OVBZWEhU?=
 =?utf-8?B?MldOY3VVOSt6QzdUNHdhaDJPS2NLT3JybUlHc0V4Y2RpN2JRWjI1dldGQkhw?=
 =?utf-8?B?aXlhMkx1U25MVHZvMmxtY2RyOWFEbU9YUm1mbEUzTy8zRHM5QVJsRUJUZ1Jz?=
 =?utf-8?B?UDJvN1hRaFFiL3ZFdE10NnM2eHRMNnhNc1EwUnVYTkJxMkRpcmZLcXI0cFVu?=
 =?utf-8?B?UDZRK3NFL0ZRS21MZjVyVkh2RUtnSHFXd3loTGlHUXNSUTJ6czBMemEzdDRN?=
 =?utf-8?B?SitpSHl2QnhqRnFmZ3VVWjFMK01TS2lDMiswRGJsUnltVmdPYU5zaU5SVmdR?=
 =?utf-8?B?M1NWYVFseGtOL1luL1N6MnNla2ovZG16K2FKdkJSWWwxWS9jWmgxWXZrZWNn?=
 =?utf-8?B?RW55RVNPdUN1U2t5WitYMG9SV2FJSmVYRS8rQmVxT2xwUW1qSDN0SndTdHV3?=
 =?utf-8?B?OEorTldJNm5NUjR0MHNYWE9ycnY2OWU1Ny9QVVlDM2VkL0Y2MXVnRVlIOHJI?=
 =?utf-8?B?SHZPUVpWaVp6QzVldGJCc1ZuaXliS255ejJWSzEyakFCNVFOaWc0UjNQYXdk?=
 =?utf-8?B?eVJPZURKTVZoRXdCRDlFZm5lbkp5ZzdUNnpJMEVXTG9QRlhsVm94WkZwZGhB?=
 =?utf-8?B?OUtoV1hCYnQxcnVjY0FHMGcvNmpCemZHbVRnZURtZ1dnb3JrNFJLTzhzajJn?=
 =?utf-8?B?QVVTbk9YbG5wYTVwS1lKVlM4TER5UFFXTGFETWozRTJSNVRuOThpU1JQeFVG?=
 =?utf-8?B?T29mNnNCelZXNG9sbGVCdkZOZVhzeHFzYnh3bWcwTVRCcGxJMlF3WHBFTlcr?=
 =?utf-8?B?L0ZidjNjNzBnYjYyRVI3dWFuTzRrUW9sOTh3ay9YaHBhRWFPNWVlTW1zMTJa?=
 =?utf-8?B?RmdHdzhMbUkvbVl1TlZxYUdObFZ4THpEVzBBSUliaEF6NVFPSHFoQ1N4eFhj?=
 =?utf-8?B?N3pWUzR3UTRuZ2E2NnN1Y3M2clZDK21DV0s3dldVL1BkbG9TMkx1VXR1T1Ri?=
 =?utf-8?B?VFhuZWRwbGRVcng4RDdmSW5aREVaVWhhZDBGbWdEYjRhdUFiSmRGbm51eGZI?=
 =?utf-8?B?ME1iRzI0eWFJL0U0VGR6R2RIZG5IdTMzZEpUQ2VjK1MzSkdLNENGQ0dwaXhz?=
 =?utf-8?B?Z3hqK0dBaGpxYzBKdlZZQ0ZCenFORWc1NDB6VVlUa1lITjZWQXpJMkZWMStJ?=
 =?utf-8?B?dE5VU3haSDhBTnNKbXVwWC9qell0Y1VMT1ppNTRkUTBZaUlRT2xaR21uTm82?=
 =?utf-8?B?TndIQy9Sb01oclJMM2EwMi9wNUhvMFhUbFA1ZzA2VmRNbWkyRkduTTlyd09N?=
 =?utf-8?B?eDhFWmlnejJlUE1jRndnVXh0cjJibUUyeG56Q2lhbnlsb0cyV0o0UjAvWTg4?=
 =?utf-8?B?Vk5RV0I2WDFkdzE5SFhLdHI4WkQ3NWliMEordVlPMDQ4UG5zcGF2RmVWcFFq?=
 =?utf-8?B?M0NxaElmOWVZMDlkR2JjUnVheEJ4Szg3eUtVNGYyMkpidnB0eWVJUU02RVZN?=
 =?utf-8?B?dTJTckJMekhCZjhiWUdLM3BqME15aWZXODFWZ0IxWUEwdFZqUXV4Qm0xV1Fz?=
 =?utf-8?B?RmJnaXpyV0ZtY2dpNU9WSFcvcVZtSnNTNVJuRWtSRnZYN0Y3aDMyM1EvMjVW?=
 =?utf-8?Q?fUWg9mWoyhKX1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWJlbWxZb1ZnUDFRSTdLbHJETWNPZEFXUXRnVXNxdUNVbGl1R1ZvRE4vUVpV?=
 =?utf-8?B?N080UzQ5UGdrdHZtalVxWjdCR0JjVE5nbWVhM0t1djZTbWRnWGNkNkFLcDVW?=
 =?utf-8?B?dmlBYS9xZWlvUFhHNitSaFVLY2VEWFZmcndINWNSWnowWVJ6SjR6d2tteUNU?=
 =?utf-8?B?UVZsbEJWWEdwbXp5RG1pd2tvOFM2dDhMMXNSOFI4SlNLTGxaWkthUGZoc3Ni?=
 =?utf-8?B?bjNEMmpNQk0xMjJ6ZktYM2FOdE55ekN1TkZnMEhYS3JnTndyZDNXWm5PS0VC?=
 =?utf-8?B?UWhIWStZblo1Yk00OXJId2hDOVUzTkJha1VwSExRNWhLTlYveTBOWjNsZjV3?=
 =?utf-8?B?d0JFeTBQWHFCL2hFU25va2c0OWhwUWMvdExic3N0NEZOME5LTFJpUzlVS1Fk?=
 =?utf-8?B?ZjB0YjlTck4wZWFpRXJLRFQyQmN4dVhaeVVVbFZBa1pNQ29yQUhDYnIrRERa?=
 =?utf-8?B?TjcyS2I0OHc5TGZGcVdabHl6ZUJ0T0VOYldsRFVPMzJUYklhMVBEaVE5ZFlK?=
 =?utf-8?B?V2N0a2RiZlFaNzJGSFlFTHdQSTBiNy9adFNoamdFaVZOOW5yMkJqVnNndTZD?=
 =?utf-8?B?VUQybWpwRHRjTkFRYlN2OFovZTYwK0xtazZTTktHQkUrVGVaNWphR0FtMXVD?=
 =?utf-8?B?QUlBWVpubDVwU050RDNLWFFsK0lNdFduTUhHNGl5aTNtcSsrVUEwRFNFR1h4?=
 =?utf-8?B?UmxOc0FGMkRpeXdrT05mQXU4SzU1NGtiQ1hyRnhsL216ZnZyZnRKcWhVcDNj?=
 =?utf-8?B?NXROVGtEWUduMmJXZ2hqRmpLVllvbEFLSUwwVHJOREluZ1UwWjJqdUlEdFll?=
 =?utf-8?B?aXFvK2prNFdzaGxkOFRkbTYrSGhGSXpvSHVnZGljdEsxc1dFV1RpYkczbHBZ?=
 =?utf-8?B?RzI1azM3US9mcS92RG5sVlFpWlphNUN3M0NvZkY4NjduMWQwSEFwb1Fybm1i?=
 =?utf-8?B?ZVdRVGNyaG5wWTloNWx2bXQxUXJJOHppb2dHQjJFZ1VkRWJiVkEwRmtzUEJy?=
 =?utf-8?B?aVZCbU9GOWt2YzlWeHJxSFl1NUJjdmR6ekpqOEFxd0JUK0dZcERCNjJGU1ZR?=
 =?utf-8?B?Mkg0UHR3bFRoMlNJdXR5azUvVnVGcWJ2dUZyOTRPNjhZUTZNaWErZHB1UnVT?=
 =?utf-8?B?ODN1c0x5VktQZkI5WmJHa2xQeDgvY1V3Y3ZjbWQ1RnhmL3BiZWppWURrK0l6?=
 =?utf-8?B?ajRZNVlERXhrOHRKZ29INXVaQnp0WmtXMVVrTVNzbEJQYnF1Sm5URGZaa2VC?=
 =?utf-8?B?VE8ya1lhVDRtZnlhZ2JIcmc3S01qK09GNGcvbFRZMXJUbC9HNTRpbDdMSnZn?=
 =?utf-8?B?dTQwTTU3U1B4OWgyQ1VMSXEvdmRPNE14ZGUxRURHeHRBOWRBOFFxcURQY1l4?=
 =?utf-8?B?aVpocytzSy9mRW5ZRmdvbWd5bnkycnJIRm9DWG42SmFwVFlUUFUzQ1ZUWk8y?=
 =?utf-8?B?RXgxYlJSbFZYN1FVRmFLeTdoYUdmQ0ZiM2x5eXJPOU9hVzlKSE5JYUY1L0or?=
 =?utf-8?B?NFY2Qjl1R3c0L2F1MzNxN3BjcUUwOHp4NGExaUw4MTZ3SDFyRFNUVTdmSGda?=
 =?utf-8?B?L0tBRFVOVGd3SitETnQ4WmszcHc1Nkt5UCtFR21KWDkxZm9QOUxkbGk0WlF3?=
 =?utf-8?B?UjAzajFscnhFWEVaS2NJNmRDZzhyTjJ6ZXZLNmczc3BUQ3RraExEMzNsSE1x?=
 =?utf-8?B?ZVZHSHVGWTR3dEJyRGlqKzZzQ1d6Q2lyWWtOZlV4NmZDMzMwN0ZGUTJoQ2dK?=
 =?utf-8?B?RHExQ3pRTHVJME5jakgrdXpzekJvNnhoTE95amlLT1QxbVpQVG5NMloyUW04?=
 =?utf-8?B?YXV5S2wxVXZwam1tQmdlaUt5azhDcFRnZWJVTXdvSTVkSXRabzcwUTRZVUd4?=
 =?utf-8?B?WWtlaWMwUEJKQ0xXYVR6c1BrUm9Ic25DVmxPUjNtVnZ5dXZSZjRxVms5SUJ3?=
 =?utf-8?B?ekx0c2s1eDFlb1MxaXFKVVVkck5QZ041Y1lrNmYzQXI0ejhjUFRZWHg4Q2Vr?=
 =?utf-8?B?dTlFeE1saHhBYTI5TVE4V2NWU1VUeG5YTzdDdTQwdDl0ZlExRG9SYmhTUUxD?=
 =?utf-8?B?dDArbGFvYkRETTFRb2RzSU9jdmxSOXhyTHZ1WWR4UWtyeGNPbG4xc2pXTVRK?=
 =?utf-8?B?Q09SbGJpU0RMTXM0NjU3bFAwVFl5dWRsTkpuQk03a2NyUE5Kay9xWnF2cmVY?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72207fa7-1c37-4c29-0825-08dd5ae8f43f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:51:13.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzgjt5BhgsYzFGA/Hcq86Qfu68pofklZFCPa0wfYem2LiidK6IZn7sh0vr16gE5BboqrjgZ0Ubzo6bUX6cmGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 06:51:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18008

From: Jan Kiszka <jan.kiszka@siemens.com>

When enabling swupdate, we implicitly switch to wic as image type.
However, the qemu targets also have ext4 in their list which now becomes
unused. Drop it to shorten the build time a bit.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-swu.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 61a8eeef..5066040c 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -33,3 +33,8 @@ local_conf_header:
     IMAGER_BUILD_DEPS:append:qemu-arm64 = " u-boot-qemu-arm64"
     IMAGER_BUILD_DEPS:append:qemu-arm = " u-boot-qemu-arm"
     IMAGER_BUILD_DEPS:append:qemu-riscv64 = " opensbi-qemu-riscv64"
+  drop-ext4-images: |
+    IMAGE_FSTYPES:remove:qemu-amd64 = "ext4"
+    IMAGE_FSTYPES:remove:qemu-arm64 = "ext4"
+    IMAGE_FSTYPES:remove:qemu-arm = "ext4"
+    IMAGE_FSTYPES:remove:qemu-riscv64= "ext4"
-- 
2.43.0

