Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60517D111A8
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 08:13:08 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16464.1764576785541705480
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 00:13:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kCmm0YhU;
 spf=pass (domain: siemens.com, ip: 40.107.159.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0DT5fFE7k0QbALcV9dz4cSjugEFuoI0FFdK+9yX2BOfH939xUbwtDEpE53HwjB8R+ikrbTuv3OfKMjnvA9bPPwlLZo50ioiSEuaHDuEMmsfkZqFJw0m/6zBCO9G//C0Fb6x4ww7lWHLs4GWbWf3QzLgVCylaDO/zKhV6SImjUMi65VsiM9drRfdN7eDV0vbBC86D3wMEKIVu5HdWSzoiuzWIobydkjiJ0iHj5kuVHYSaID+3xrRpwC92KO3VFQ4xVX+Pa29jPU6h0Mv0pjll+gqg5yn80nS8vVHKt5GR8GyaTrKfpGU1VI6/nMZW2zeKrXz0AnmPvpo2CfPKS9gWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U5rkLz8LIK9BEl4Nj76UD65ZsFMwxfIropVx4Ef92M=;
 b=CFtDAT6/k0Y+rNJ8WyWpCPGI5Ha7X+0wIVVjJKGGAGSnaSYK3YvayTY0LIjhWD2tnb1XjNaqzYtigAFdWztjR/GFRzlSgZF7zYZJXhXzZJy7X2Qgh9vgOZUJWYEgWXJ8FC8UuOsi2ZerWkoq+8HG/1P6RVkk8lzm5IQ7Z5bcHEVOpKP+kPl6hP5wVKkkZRFOaugrjptnoPL6WDiQHOAxHvc9m6lkr6gzKVgYx8dYwC3Xm2cEc6lwUZ9Laaldr9GwJtw1vsiXxGjTwFDPnBF40kyKRQE2FctNRRwJ1OcDzUPF0IR66myTYDkdyZQgi9QKSI24mB5v2ldW0CmK0hqwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U5rkLz8LIK9BEl4Nj76UD65ZsFMwxfIropVx4Ef92M=;
 b=kCmm0YhUnMYcsqmNDjvjvwamfP3bGObL2bCvMjigF7E/Cs3LvBTI9HEmnPpMq3UnzoO/UpdcsCgjycnYsyJvz2vVfE8CFEAhw6rU29qm6KwjjAIMkY2SOwq2/vVh/KYlMWOPnD35KVcz4c5DNGwGErry0dEPWkTy57aZuby5vlOYFEdj4guF8WH388867MXEaYWUC88fG+o4EdTciAA5VRpGHBHYPbJ8qw7tvi8Vjv9heKeAFO5Mp/6rzrTecqf9BkYL0Sn0AZq5FZ4tMSKovUtrL0KU9u3xZxbUXuwpNCZXGsh/LPH50rraBnGpjEsn4+ZzwZ4JzVNApT8cmxMt5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 08:13:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 08:13:01 +0000
Message-ID: <0be260cc-5c4a-4118-9253-55d54d5ae439@siemens.com>
Date: Mon, 1 Dec 2025 09:13:00 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Drop redundant DPKG_ARCH statements for
 dpkg-raw recipes
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f994929-dbd1-42e6-ae90-08de30b171dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WDRpdVg2YXZ6RTY1RG5UbjdDOTJic1NPWjRkV1RCR3ZqbHo3ZE4wT2liWjNr?=
 =?utf-8?B?YnVTS1phT0ZWZzZhU1o2SFRZeWp0WGMxbytxK09YVHJWNDRlUmtMZk1oTFlJ?=
 =?utf-8?B?dlhBWGVmSEVQYTA2dWxnOUNhOCtaaWZ0VWtoTXZUVmJ0R0pBR1hTalBGeHJW?=
 =?utf-8?B?eXUwS3ZmcVhWYWZyNHA3WWFMaVpaTEFOcUEzcWFrZTV1aTBlWjFReTV0YW0x?=
 =?utf-8?B?a3NuWlpLRUZBdUtPVjZuYUhrQzJscVdkVkNnR0pwUXd3aEJqdXQ3aC9lRlRi?=
 =?utf-8?B?OWhudklTbTBnenZYRm1lSnRxOE5JaVF5T1c3SjJpb0g5NkVOb3F5SmtDbVUw?=
 =?utf-8?B?YmlPVVFRYkVyWjJQKzFnRzRQNmkrVm5tQ3FsUkxEWmcwQzAxdWVqSTRpbVM0?=
 =?utf-8?B?dHFaUEU0Nm9lR3lBbldyQlBrcnhtclczNEl0Y3BTeEhpeDZmdnhjdFVRMHpL?=
 =?utf-8?B?WXJUeU02em1YdjBGUGZDeXRmZ2Y0b0lVcW1YUmpQS250dWJzemJiT0FQT3Uw?=
 =?utf-8?B?RFhHaTVXZFJKOVhkYkV3akM2bUNkdW4vVVBEeVpCdld5dXdRbmxkR2ZSZUla?=
 =?utf-8?B?aGQwMFVMNk1NR0hscEpLL1JLbTZSRnU5YzNsbHJ1aWRPazVhWWtLS29URjlJ?=
 =?utf-8?B?ZFVFSktFMkxYTmJ3RXdWRHVWQzJkTGYvbFBaUmJUcldqVm0wR2NhVHRrV1RQ?=
 =?utf-8?B?QUh1YysreCtYUkNhLzVieDBFMXQ2V2s4KzBvOEQvL0JOMU5Kc1ZaOUpxd2Q4?=
 =?utf-8?B?QTk1WCsrdWZKUW1jUHNmVm9OWEFSeHd6d1A5aFFSdHBMYmlVc0pYckxTbCtw?=
 =?utf-8?B?dWxhZUU4OXJPUVJycEpZdVpNMmx4QlNFTERjTnhXLy80MEsyd1lHYmhDdEV6?=
 =?utf-8?B?V3FlRENDNmNiRFBUdEs4Mm5uaWRBaVM2RGdxdVhscHhHVmt6WGRNU2tWYTgv?=
 =?utf-8?B?ZElOQlpJS2cvVnIxbHNHMlRydFNmdStaOUV6MHdNQ1QzZ09JYzdIYzJDVUlz?=
 =?utf-8?B?TmVMS3dUelZSbkoxZGRBRTlXMFBXdjltQzlTVy94ZDNIcnQrdzQ0Y3FodStw?=
 =?utf-8?B?dTE3TUZDNWYyeEFrVlhYa3lwbTNlam9vY3N3TUx5cGxidnRyeVNhTnhZWG1G?=
 =?utf-8?B?NXdmU2NiM295RlB3a2s5WHNWZE51K0o5U0FTTnhhOVQyZ3pHb1IxRC9sM0ht?=
 =?utf-8?B?ZTRpR01zcXQvZlhuckRpMDlEdkkzNVovS0xlWmNDNWNGUk1Nb3ltZ0hUYzlw?=
 =?utf-8?B?R0hqbFNYTVlYYzdlbFVkOG85K3kxeEs5VGRXZmdEMkFDSXhnODRJT3NjTnhE?=
 =?utf-8?B?ZnhTZnlmN1pBTnk2bTEwWjBuNC9rQkYxdmxuNlpjK0VqR1R2R1ZIU2hiZXAr?=
 =?utf-8?B?U3VYYXA1cHM2S3FseU9LQXVNMlRGTFdsd2ZQUUdRMXVPK29kRWQyalMrUm5s?=
 =?utf-8?B?bEE5OW13cUN2blFBbWhxeGR2azNBM05VYmw5eXRXYXJyZms5UHJXNVkxc2FM?=
 =?utf-8?B?L0hUZDdrNmhPRGFXNE1kQ3JzL2ZLaXdqYTlsWnBYTVQ1bWxDOFpmUFZJWHVo?=
 =?utf-8?B?OFRRbEZEcXd0MGdPb1RpY3NDeE1BMmVpb2NKSkF5SzFlQmxaQ21BSitDRGxN?=
 =?utf-8?B?T2RVQTJzLzcydjEvRjI3T1NEMDhxUllsTktUYWttZ24vRlhSdkk5bnlVYTQ2?=
 =?utf-8?B?QUN0c2dFOGJxQjRGbE5tcVVwZ2x4Q2g0YVE3eWFsNGw5VlVob3puQWRQNVpt?=
 =?utf-8?B?R25tdWQzVW54ajB6dlZNZlVzcnRPZG1jZklxcDBjMWgvb0p2bmtrdEpScnRz?=
 =?utf-8?B?b0RQS3JNOWwxa1BseXRGeG81NElyYkNJUy9ZbWVTSXU3UWRtRGkwY2R6M3VD?=
 =?utf-8?B?NHhiTWF1MW1Wc1Ztc29idCtkRkw3cUNQcjI5YndPZnRUSzdQYUVvZm9UY3I3?=
 =?utf-8?Q?d5PTEnGWUOtNyPzbY3V41oWIxhIDAIeb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWNkMkNvb1dSTXZjKzRvNHhzbVBwQ1VZMnRBN0d4YlUvNkhpWnlWVEVzOTVi?=
 =?utf-8?B?QUE4RjB0d1VoeVBXa1RVTStjSURzU3RHMFVHalVqZDB2YXpUT1hBdlJKTmtR?=
 =?utf-8?B?YVhKQURlT05pZVpuRmZXeUdkdUFKRXdtZXZGSDBSaXp3Sno1Z29pOEZFenFC?=
 =?utf-8?B?NW5hbUptVnljbGFyVlRSVis5K21COXo2eHVHaTQrOEx2THE3c2cydzQvNmpj?=
 =?utf-8?B?ZUdRQXd4bCtxMjNZWVcvTXZUcTMzZkliYmg1STA4MXAzM1RuWWZUVXdoVnlz?=
 =?utf-8?B?Q0FxSWhsUUZaNitGSzViYTRlMGY3dll3SkU1bmErTlZWVUwwbzdUYlhINzBQ?=
 =?utf-8?B?ei82OHJQblhlK1NyK21SRVdnVGJpMVhLT3FDcjBnWmhSLy9kYzluN3JOVmJY?=
 =?utf-8?B?VDk4RDYwTHI5dUcvZUlhUXEvZGk1QjU5RnFYSkpodGl0TVZxcTQzbm9rSWRT?=
 =?utf-8?B?dkdkQWpxajUvVjZwYzRjUGJyOUFiTDJQd3U4MEFWaEV6RW9BZjJaRUZxcVBk?=
 =?utf-8?B?Z0xiSEgvODBTMnhZTWpSaXJlZVZkNFhMck14dlkwYUcwaTFKMlRsWU14Q1VQ?=
 =?utf-8?B?YXUrblY0MlA4MWJoUGpDekJ2QUlzYkNEbTJVRmlQWUNNSzlhTjZidk9qTDF4?=
 =?utf-8?B?ZGEwRWo5Wk5MY3F4Nm4vU291ck9mOW8wOTh5N09Ua2hhZTdES3M4RHhKMVpG?=
 =?utf-8?B?QWRjdDh1cmhnNWRMWHpXQndpTWY1SFlybW9BekF6MzlueVVxYjFoenJXblZT?=
 =?utf-8?B?L2FwL04xT0NhVjlRdWdoUGpwdDJRS0x6ZElhZWdpNUw5SjBxZVVCSEpUdms0?=
 =?utf-8?B?TFk5QkJ0TUpSeVpCSVdpYXIrclF4bUlCVUtRNXhtNVRsTFBiZzV2eXRrZjJp?=
 =?utf-8?B?emxWOWVya0tRNFlHMjJoZzZ4V25HdkRUM3NHNG5FT3hYcGVpQ0o0RW05bjd2?=
 =?utf-8?B?dW5rL3FTL0M5SE9SMnM3VUY2UnhsZjRXY3ZCTDA0ZXFhK054SFkybXI1YUNs?=
 =?utf-8?B?emtaUVJzeHYyTWJkTU5RUjVXWENseGRYRTU0Rk8wOGxHbituNUNNOUZKSmhP?=
 =?utf-8?B?ZjFJdExMUVlWeEVIempBZ0FYeFRIYU50NDE3Z3RaRThnR29HQnV2bFh5eWIr?=
 =?utf-8?B?b2VJSlIvNGxYZTFwVjFEWUVUVEVUbVQ2eDlSdTN4VktHRERYMVNUNzBncUth?=
 =?utf-8?B?cExKN2JhVkJCTVhWa3lHemMxSXpQeTJJclFNdGxsK1RzQVNGZ0JCeStxWnpM?=
 =?utf-8?B?a3ZwMngvWVVXdjllY1FuZWJ4aFlNSk9tYU9NL0xHeDQ2eDVGV0txRTFpa1Fo?=
 =?utf-8?B?UDVOM1dncXZwbEFPMzJud3JqSnJpa29qOVFpMFhXUFE2Rk9tT3V5TEhlaEpG?=
 =?utf-8?B?VEVlbmc5S2c2bk9weW40UXJrR2dDaWJaUmRMSVlxcmswNVdVd2pKcHlVd0Fr?=
 =?utf-8?B?cXYveWh3Z1Foa254cWVuUTFvOUpUa0w5Z2VmMUY1cFVHSnU5VmthS1AzOXlE?=
 =?utf-8?B?OVRzNGJRbTVxVEVtamFJRG9sV2pHZjlXa1lpZUQ4TUdCeDBvY3RMQ1poRFEv?=
 =?utf-8?B?amlEYVFWeUV0SkVLanNOMmZxM3N0SnJZdmYrdWpRYlNtcDl4c1QzZ2F4dkw4?=
 =?utf-8?B?THQyYXdPcHpxdDJRbEdHU3FxUG8yVHpKOUVWSmlYaDNveFVrMHpzNVozb1pY?=
 =?utf-8?B?SGsrdHlxMzFPMm5jb2FENUtFbTNYa3JiVTYxMFJDTlYvNmRnS1pVVTVSYmNR?=
 =?utf-8?B?M0RNT0ZVWW1JclhTTDlXS3lLRW1yOTRaS1BtcGk5Wmt0YVViLzN2NmhJbCs3?=
 =?utf-8?B?WGxZaEpkZnVJYVRpK3ZlbzBod3VIb1FVODR3dHRmOVo3QjB2REphSSt5K2Zq?=
 =?utf-8?B?SVBpcFNqQ0NsVHhpUy8xc3FpTmVWUktoNjZuVzhNZEVucGVuOU5rWEdFaXFF?=
 =?utf-8?B?aDUvY1ZJVnRDK1FSV0hBcy9PRjVRM1JYSS9KeFhnRjBGbWU1SUJwTjdtZW44?=
 =?utf-8?B?Z3lKaHllSTZOSWZvWExNejJuZWNnWmNlQ3pLaDlVdEQwUlVqUGQ0VlBIdzB1?=
 =?utf-8?B?Z0Z3L2Z6TnRWZTIzM3lxcG1pbFZRUFFiVGREdDFocHJGY3NyMzFjSDFVd3RE?=
 =?utf-8?Q?+ahhqeZCS74Q7rcXsUqr7mWRY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f994929-dbd1-42e6-ae90-08de30b171dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 08:13:01.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jW5ifmr5/7lDV4MQulzMc6c/GrtZX7udYWyVg3d1TGEn6aTIq0sfER+jSKPiWY8awf80u25F/R3BeCo9/S4eEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3847
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 08:13:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20777

From: Jan Kiszka <jan.kiszka@siemens.com>

DPKG_ARCH = "all" is now the default in isar for dpkg-raw recipes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/immutable-rootfs/immutable-rootfs_0.3.bb          | 1 -
 recipes-core/move-homedir-var/move-homedir-var_0.1.bb          | 1 -
 .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb       | 1 -
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc   | 1 -
 .../swupdate-certificates/swupdate-certificates-key.inc        | 1 -
 .../swupdate-certificates/swupdate-certificates.inc            | 1 -
 recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb    | 1 -
 recipes-devtools/swupdate-signer/swupdate-signer-empty.bb      | 1 -
 .../initramfs-cip-functions/initramfs-cip-functions_0.1.bb     | 1 -
 recipes-security/fail2ban-config/fail2ban-config.bb            | 3 +--
 recipes-support/factory-reset-helper/factory-reset-helper.inc  | 1 -
 11 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.3.bb b/recipes-core/immutable-rootfs/immutable-rootfs_0.3.bb
index 85f61841..3be1482a 100644
--- a/recipes-core/immutable-rootfs/immutable-rootfs_0.3.bb
+++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.3.bb
@@ -20,7 +20,6 @@ SRC_URI = " \
     file://${BPN}.tmpfiles.tmpl \
     file://95-disable-package-updates.preset \
 "
-DPKG_ARCH = "all"
 
 IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
 TEMPLATE_VARS = "IMMUTABLE_DATA_DIR"
diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
index f412a8d2..608bb693 100644
--- a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
+++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
@@ -12,7 +12,6 @@ inherit dpkg-raw
 
 DEBIAN_CONFLICTS = "home-fs"
 SRC_URI = "file://${BPN}.tmpfiles.tmpl"
-DPKG_ARCH = "all"
 
 IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
 TEMPLATE_VARS = "IMMUTABLE_DATA_DIR"
diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
index 83289d4f..57ad1be9 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
@@ -16,7 +16,6 @@ DESCRIPTION = "Signing script for EFI Boot Guard setups"
 
 DEPENDS = "secure-boot-secrets"
 DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
-DPKG_ARCH = "all"
 
 SRC_URI = "file://sign_secure_image.sh"
 
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index c1fc12f8..5277d9bc 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -11,7 +11,6 @@
 
 inherit dpkg-raw
 
-DPKG_ARCH = "all"
 PROVIDES += "secure-boot-secrets"
 DEBIAN_PROVIDES = "secure-boot-secrets"
 
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index bcc8e2a4..2abb9634 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -13,7 +13,6 @@ inherit dpkg-raw
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
-DPKG_ARCH = "all"
 PROVIDES += "swupdate-certificates-key"
 DEBIAN_PROVIDES = "swupdate-certificates-key"
 
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index 43668db8..344775dd 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -13,7 +13,6 @@ inherit dpkg-raw
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
-DPKG_ARCH = "all"
 PROVIDES += "swupdate-certificates"
 DEBIAN_PROVIDES = "swupdate-certificates"
 
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
index 17e64adb..44bbd0ae 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
@@ -9,7 +9,6 @@
 # SPDX-License-Identifier: MIT
 
 inherit dpkg-raw
-DPKG_ARCH = "all"
 
 PROVIDES = "swupdate-signer"
 DEBIAN_PROVIDES = "swupdate-signer"
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
index a999182f..fde9cb46 100644
--- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
@@ -9,7 +9,6 @@
 # SPDX-License-Identifier: MIT
 
 inherit dpkg-raw
-DPKG_ARCH = "all"
 
 PROVIDES = "swupdate-signer"
 DEBIAN_PROVIDES = "swupdate-signer"
diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
index dc013a09..d497aa4e 100644
--- a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
+++ b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
@@ -11,7 +11,6 @@
 
 inherit dpkg-raw
 
-DPKG_ARCH = "all"
 DESCRIPTION = "helper functions for cip initramfs-tools extensions"
 
 SRC_URI += "file://cip-initramfs-functions"
diff --git a/recipes-security/fail2ban-config/fail2ban-config.bb b/recipes-security/fail2ban-config/fail2ban-config.bb
index a0f72feb..87d14975 100644
--- a/recipes-security/fail2ban-config/fail2ban-config.bb
+++ b/recipes-security/fail2ban-config/fail2ban-config.bb
@@ -7,12 +7,11 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
 DESCRIPTION = "Basic fail2ban config with systemd as backend"
 
 inherit dpkg-raw
 
-DPKG_ARCH = "all"
-
 SRC_URI += "file://systemd-defaults.conf"
 
 DEBIAN_DEPENDS += "fail2ban, python3-systemd, python3-pyinotify"
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper.inc b/recipes-support/factory-reset-helper/factory-reset-helper.inc
index 7117a537..56ac5b48 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper.inc
+++ b/recipes-support/factory-reset-helper/factory-reset-helper.inc
@@ -10,7 +10,6 @@
 
 inherit dpkg-raw
 
-DPKG_ARCH = "all"
 DESCRIPTION = "helper script to execute a factory reset"
 
 PROVIDES = "factory-reset-helper"
-- 
2.51.0

