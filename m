Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD257C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:42:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.71])
 by mx.groups.io with SMTP id smtpd.web10.81128.1718696522045518839
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 00:42:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fUrPdcaX;
 spf=pass (domain: siemens.com, ip: 40.107.21.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U71xuLpxYrz0afYLZKUfPygyVurJoSDtv5QzgRElKfZwrOlz6O8yD+hPw9xtqRhZYFetlAoqVHReG04AOSdXZ9CPnWbCFNwR6KSrOtNI0R4NGJidZcCraKfLsaInUx2sdvcEUcJVU0huwCLgZJVvvtLPxNa4m1loXRGdWdyPig8llrpnbu8XqXmIIBzdwt1JnpWB86iWvQbAks0bD/YMMDVzCQAIRG7WwgjZ+05evjOTAmGkbNQ9IbyssuxtBmX5rE6rz9SvBYGkjJgtSIKxgvoMmNd++A8N2enofOvAUnn/T314jhpXYN3Fy3WJ4W5ipzXJoE6ZaV7OS4dDZsf/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXsAkJbUwHahDzx3XcPVBGQ/5AeXiFcgXfu1byhupOs=;
 b=fmR/GSodq8F+cFBGQCA6EVQs/SkVK190DJDbQYcpEKKZ/kvWSvzltzhd7LoKxBFO892adtv6YS+nK54hEsyisAGoP4uH6iaqhxHxpBpXOutIpz/HrMgoki32kOiz4kVE7mM5s5YC1iXK2Ikhsip3Wvcbiih6pA+GyvLBTjtDFU1vHshkbvKZFNJnQ7/i9NzJmX2BLKX6Vrz2tIipeVXbdHkJFpESlnmUrT7knJSFmv0/vI28JyUxHr7ZCkD+umsFkqN8ycFhdWiINA/hZkUDO6cub/RFnNy6Xxi1pn1w/WxRKwsLqbZoRvZLR01kH1Jdmw4IsLR03QLBCCg+qK6lxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXsAkJbUwHahDzx3XcPVBGQ/5AeXiFcgXfu1byhupOs=;
 b=fUrPdcaXiMyZX1TYpbx3MYVbK55MuiW2GSh3nHUsytIi+acFMsGLtpD8Y6YD0Dm5bh43b+2YVAhZzWRXLZJ9h0YRaWpxKWBjcs7m25/nnydJV/B5spAGd9YsSskeNLYSL/8Fg7FDLJ8SFTiZSJc9hjQCt8FeURAyLRKb4ukgux7BJvpGs4nIo3dhdi/2xJsghdwdYVZIpZseL21vCrSu2ZLmeeYVc48/TeudDtKCfPkAPxP1SSGBECXvAw4mAYZCVGIyV6SXxivpBo8isMtTauL/fOHIL9KhpDtt6q7GkXdI3Gxh7JoiqnhUn1hO7P1Zml/c/Zwx++IdD20P/oqHeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 07:41:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:41:58 +0000
Message-ID: <dfba190b-6ddb-494e-94a4-6cbd273ba3da@siemens.com>
Date: Tue, 18 Jun 2024 09:41:56 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] scripts: Address shellcheck warnings in
 submit_lava.sh
Content-Language: en-US
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: bc66bc13-1e2e-43a3-9adf-08dc8f6a221b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VU5XRkZCSUpyRWtrLzlid0hPWG5VeUhVS2x3dkY4VHZyT0dreTdYZzg1NWFv?=
 =?utf-8?B?RFJDOGRJME92NnBOeW1uZUwyb1Joc2VpdWw5VkhQKzRXNnovbkI5dm9pbTht?=
 =?utf-8?B?aG44VHdEYTlmakRkSVNrdHdBQ3d4OE1VOUs4cXNGNEhWUHVubFBTMCsvaks5?=
 =?utf-8?B?alIxZnNIK0cxYm5CR3IzOTZUdWt5Ym9PUjdYRDdIbEl1MTJVUk1jOWpXYzRC?=
 =?utf-8?B?Wk9ZU0x0U05hNjEzWG9kMmQzSG1ZMEV3RnUzQXZZcEdPV1hiMVlvbTRRREE2?=
 =?utf-8?B?Y1hCVzMzU1hneHl6NE5BV1FzaG5XZTdOYzdkNUswT1N2bmtKVGVnZXE3QVo3?=
 =?utf-8?B?LzVzWHFtNDJnY2ZXTGZ4b3U4SWQrMXgvbkhTaUR1RmMxZ2c2OWh3SytXVFQ5?=
 =?utf-8?B?MXp5S1Z3R0IxcHlhQUJ1Z0RuNVloaHh6NjhCK0lSdEllSVYwVVUvQzV6amFX?=
 =?utf-8?B?a2J2SlEveEZ4MXNETUNmVklJV2c1dWg0MVBVQk41OVVYR1AzNjBMZmpCQmUx?=
 =?utf-8?B?Z0lFTTU2eHFIcVZLeVRNdCtyM0twd3NOZXI5bW1yL2tic1NCNGVHRVJFRXcr?=
 =?utf-8?B?Q29pZUsxczFySGFEeDgzNzFvMEJTUmVIMmI5VnNGUk56SzB3V1psbWQyVzJE?=
 =?utf-8?B?b1hlQzZ0UzF4eUhTNGRvMWdObGV1cnd2ZFdlTjh1NWFOek9WcGlrdmE1Qy8v?=
 =?utf-8?B?SVJJaWhDQUhHVTBqakxONDg4VlZpOEFBMmpQb1QvRWRDcWQ3czhxdHBZdWlT?=
 =?utf-8?B?dEN0bFFLczQxYUFZNi9iUCtUYjhsM0dLTXlidHpDNmZpS205dUUrMFdEWWhj?=
 =?utf-8?B?bE1PUGJMSlNOOVlvaFQ4Tk9UWHc0WGVsZjZmeFBJTWNodDJIbmxRL3pWTWRj?=
 =?utf-8?B?d1d4RTliWSs2aEhVbnBDbTQzKzBSVldwR210Q3dleHB5U01pdlhJc1U1c1Jy?=
 =?utf-8?B?cldvWVVxSG5HaDRlK2ZkQUFOQSsxWmU5dGhjL1BEWkJvKzZpSzlGU3UyRXRp?=
 =?utf-8?B?QXVDRzJTSVVQZGdrMWJKZDhVZldRME95NTJCN3JRWFFuY3ZMNXEvaHEyck9t?=
 =?utf-8?B?RGFrMlNYN0N5eWJZMDRvSXArU2tUOWVYS1pTWGJVc1ZJZVdiZDBHS2JWczZG?=
 =?utf-8?B?WkpjenA1b1EvcjVSQ3FMWVB3eTljWHdDMFZuRkgwOHJqZ04xeTlySWtMT05h?=
 =?utf-8?B?UFl3bVFsUFBuRGJ2M0xHa3JDODdrRm9KdmtSVys3aEE2TWZFY2N5dHh4ajNl?=
 =?utf-8?B?d29nWDkvem5BSHpYNHlyRm5pdGtWQ3hTU0l6aXBZQkdoM1YvM0pDQVc3T3Y4?=
 =?utf-8?B?dTUyRGphNEJyUzczVkNvSEdGMzk3cllnYzZKRzBPanl5RG5BdmJ3SG1wcDJq?=
 =?utf-8?B?R2FsaUFHZ3JZa1lZWHZNSnVycGRDOVpUQ0hyZE95VXErTVBCaTdYVjkwZ1N0?=
 =?utf-8?B?OURSeTFlR0NGSDRKN21XVXlRUkdBSndhQUpLT3Ryc3JFMWw0MmtvR2hneDJC?=
 =?utf-8?B?bXJaMnoyQ2tIVVJ4T05zVGtTNWk5d2lvT3d6azNnRUcrZXNwN3dSR0ZEc0Rr?=
 =?utf-8?B?ZGgwdDZBM2dPemdLbTRtV0VmMDg1ZVdNNi9sQUh3VTZBTFNtc2c4SGFYUk5s?=
 =?utf-8?B?TGJUWTRZM0pJbGhRZmFZM2ZUUlN1NTgwK0RWMzV1b2NKeHovK3VQUXIvWmh2?=
 =?utf-8?B?SkJZK1Y1U05TZzlUZUdDUHZhbWZoYVVHSlZjdERNdXI3SVVjUDU0NkhUK1lz?=
 =?utf-8?Q?uDZapOLpaOOuZiKgvG3vjSNJyuOEn3RY8vwdrRj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bisxQWJwcUtEQkVZUUlXaHhBMU1nV3lrdS9iUGtxL2x1aysyWmJlbjZXT05p?=
 =?utf-8?B?NlZXOTR5NllTQ200OGZDb3g0ZHFnODZTdzlIVkJQRDdyWnQ1TGt1THhBbGlW?=
 =?utf-8?B?Z3FxajhVNk4wb0k0LzVrOTJqRHRUbHFrcmc3UXh3WEg1SHh3cXVzejJlaXlD?=
 =?utf-8?B?VFRZcWZoUVdCZDZ2MTE1NlY5TENXdVlHK20vbEhFbGRQcjdtTzIrR1JZT0Zq?=
 =?utf-8?B?MTE4Q3A0aG93UjREajNqN3FDVlcrak03V0tNR2RTRUhGQTFSOWtndGhkUFhm?=
 =?utf-8?B?Z2c4MEpUdzRNK2NmcHdYc2ZsM1lVcmJFaFduL0x2T0p5dk1UMUlwcUkxZU43?=
 =?utf-8?B?SE11T0dscG9KQWtUOWt4VkY2ZVBiNWZsbFQwTDBJckxNYnVrU3JRM2I5Ykl4?=
 =?utf-8?B?eTRWNE1wTVh5Z0FaRGpZcHd6QkpRZ29wb2c4RTBHbzVjTEtaeVdiSmgvdXRm?=
 =?utf-8?B?eEt1MXhLNXRaWTErYThmKytFUisrWGlUcTl4by9GQUt6bnZBSGNXdkRmVEtY?=
 =?utf-8?B?dFBUdUEwWjY5TzB5aUl5bWFQMndhNkR1dGN3b0Y5bU9PN2JnMk1IeDhKalpq?=
 =?utf-8?B?YVEraUxtakxPTFYrYk9MWFdaVXhRbkV6Z29sVEw4OVVqbXUrK21EblNxVFpu?=
 =?utf-8?B?TTFFWGh6TTBIYTk2ZjlpY1BsUitwd3ZodldMSmFKYkZKWTlZcUZ0ZEphNTR3?=
 =?utf-8?B?VFBmSFJ0V0k3QlNkSlA1eVRKc0I4blJGcnF6ZEo5TC9hWUdpd1VPeEJWWXFJ?=
 =?utf-8?B?azZFeTBmTFNkd3I1cERTMmt2RWlSejdsajdrYmFFcjVaMUNhb3Fja2tOZ1Ny?=
 =?utf-8?B?VlphVXlGbFBiZktXN2FzSmZ4a3c5L0d1UUNBSU8rYnJGUmRYZjBlYkZHM2hZ?=
 =?utf-8?B?UTJUZi9vVXRzRG5jZjVsTGFjVmw5YjNyT09rekl1dVhPWkUvdGt1L2Rkc2RL?=
 =?utf-8?B?ZFIxTWNyRzFDcVhsbDQ2YWFkcTV5eGM0YkNvTTg2UFJ2MnN4S3hvZjh1Qm04?=
 =?utf-8?B?VUJpWUE3MmFvUkpQZzF2MXlTdFhaVTc4cW1BT0Y3TzIvTjYyVitlY2haUWdP?=
 =?utf-8?B?T1ltT0Q1Y1MzQ2lUWlpiQ1lLLytTQ0pxUG9rTkcrLyt2SFJ4U1J2TGRDYWxo?=
 =?utf-8?B?bVJkdktaZWhFaFdGRUY4ZlNmN3lJUUEyNndWRVoyUFl2dFQyY0F2MUlUaDdO?=
 =?utf-8?B?bVZnNGNVSnpiWStna2JnRUxCdnFvSjBFZmlJVHNhOE1sUG51SzNxM25SNENx?=
 =?utf-8?B?TjF6ajRRZVdJckp0OUpqSDFvZEtRU0JseFQzbFVibHFDT0RiQTFaaGxkSXVW?=
 =?utf-8?B?dDNhSWJ0bk1oWUhDdGlySFVFRWRaT1FqZ1A4em5nMWtvMjN4dFdad0N4V0xS?=
 =?utf-8?B?LzdXbVZoYlRydHRaL094WnpGbk5Iby9FVmlDbnRSZThyeXF6S09iUzlGRkw3?=
 =?utf-8?B?bUcvMFErV2tMWjhmYmxGWkdBc1lTNDlhOWVQR2NpSnRvRWd1QkJUL1BXTUox?=
 =?utf-8?B?NEhPdUo4aFJTSkZOZVE2Qk5CUitNWGRyMEtkVmRLN1FhWkt1S2o1WXdLVElo?=
 =?utf-8?B?a0pTMWZXSm4xckxFeUtUZHBadjBuUDdrdVRRcCtiL3J4dU41eSt4WXdTUjc4?=
 =?utf-8?B?SS9HZjM3YTZFVVh4WVZ3bEdxeGg0NjFWYkNWb1d6UjRGQVFQOXcxMVJoK2dX?=
 =?utf-8?B?eFJERnBkTk5lTy91RkVpZU5XbmZqc1VNVjhRc2NqcUpWMVdBbjdSZUlwaktN?=
 =?utf-8?B?ZnE3Wm44TzFnb0lmZkgvUE9GT083Zk5Oay9WOS91UXA5ODRMd2gwWHl1dXFP?=
 =?utf-8?B?eEVTWUYrOTdpYktYbTZUdWtSbGIwNldEb3YwRWh4b053K1d6S3R0YU9TUWRm?=
 =?utf-8?B?OWlvVXNRYzlUMU5QaE95QkczNWsrL1lad3BRbnhRVFpFRmJ3K1V6TmVXeWhv?=
 =?utf-8?B?RVZ0djgxUGJMS25jY2I2SUZhWFJwUlRXTG9HUmZNd0JWS1Y4YnUrRWY0eGN3?=
 =?utf-8?B?TSsyRkRPelBaeUVVZVZmaTZhRnNNWGcwTlJmcGFPRUxzY1dhSmcxREgzbGJm?=
 =?utf-8?B?dW8yQTBBZnhVdWg2bFJRbDk2UlJlZW9TS1BlR2k0OVRyUDVYNWhBL3pEMDlr?=
 =?utf-8?B?TTRrcnlrcEhUWmUwcWtjMlcxMHd2Yk5xMkIzVFJDSk9pSlFicjJrb1g4bXNH?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc66bc13-1e2e-43a3-9adf-08dc8f6a221b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:41:58.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TT744pDRwq/cPb/EtpGHpcx0gvdg7sVi6GpItr8xqmi3drwJPAxDfOeOHweR8b1PjhGe4v+h10N1/XyE7ZyExg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6715
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 07:42:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16279

From: Jan Kiszka <jan.kiszka@siemens.com>

No functional changes intended.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 69 +++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 9cf2c580..b2810e0c 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -54,13 +54,13 @@ add_firmware_artifacts () {
 # The created job definitions test SWUpdate, Secureboot and IEC layer
 create_job () {
 	if [ "$1" = "IEC" ]; then
-		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}"/${1}_${2}.yml
+		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
 
 	elif [ "$1" = "swupdate" ]; then
-		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/${1}_${2}.yml
+		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
 
 	elif [ "$1" = "kernel-panic" ] || [ "$1" = "initramfs-crash" ]; then
-		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/"${1}".yml
+		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}.yml"
 		sed -i "s@software update testing@${1}_rollback_testing@g" "${job_dir}"/*.yml
 		sed -i "s@) = 2@) = 0@g" "${job_dir}"/*.yml
 		if [ "$1" = "kernel-panic" ]; then
@@ -71,7 +71,7 @@ create_job () {
 			sed -i "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" "${job_dir}"/*.yml
 		fi
 	else
-		cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}"/${1}_${2}.yml
+		cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}/${1}_${2}.yml"
 	fi
 
 	if [ "$1" != "kernel-panic" ]; then
@@ -79,7 +79,7 @@ create_job () {
 	fi
 
 	if [ "$2" != "qemu-amd64" ]; then
-		add_firmware_artifacts "${job_dir}"/*.yml $2
+		add_firmware_artifacts "${job_dir}"/*.yml "$2"
 	fi
 
 	sed -i -e "s@#distribution#@${RELEASE}@g" -e "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
@@ -88,7 +88,7 @@ create_job () {
 	# Target is recieved from gitlab job in form of qemu-"architecture"
 	# In the template context field needs only architecture excepting the device type
 	local arch
-	arch=$(echo ${2} | cut -d '-' -f 2)
+	arch=$(echo "$2" | cut -d '-' -f 2)
 	sed -i "s@#context-architecture#@${arch}@g" "${job_dir}"/*.yml
 }
 
@@ -117,7 +117,7 @@ submit_squad_watch_job(){
 		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
 		--form backend="$SQUAD_LAVA_BACKEND" \
 		--form testjob_id="$1" \
-		--form metadata='{"device": "'${DEVICE}'", "CI pipeline": "'${CI_PIPELINE_URL}'", "CI job": "'${CI_JOB_URL}'"}' \
+		--form metadata='{"device": "'"${DEVICE}"'", "CI pipeline": "'"${CI_PIPELINE_URL}"'", "CI job": "'"${CI_JOB_URL}"'"}' \
 		"$squad_url")
 
 	if [[ $ret != [0-9]* ]]
@@ -135,12 +135,13 @@ submit_squad_watch_job(){
 # $1: Job definition file
 submit_job() {
         # First check if respective device is online
-	local job device ret status health device test
+	local job device ret device
 	job=$1
 	device=$(grep device_type "$job" | cut -d ":" -f 2 | awk '{$1=$1};1')
 	if is_device_online "$device"; then
 		echo "Submitting $1 to LAVA master..."
 		# Catch error that occurs if invalid yaml file is submitted
+		# shellcheck disable=2086
 		ret=$(lavacli $LAVACLI_ARGS jobs submit "$1") || error=true
 
 		if [[ $ret != [0-9]* ]]
@@ -151,38 +152,31 @@ submit_job() {
 			echo "Job submitted successfully as #${ret}."
 
 			local lavacli_output=${job_dir}/lavacli_output
+			# shellcheck disable=2086
 			lavacli $LAVACLI_ARGS jobs show "${ret}" \
 				> "$lavacli_output"
 
-			status=$(cat "$lavacli_output" \
-				| grep "state" \
+			STATUS=$(grep "state" "$lavacli_output" \
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
-			STATUS=$status
 
-			health=$(cat "$lavacli_output" \
-				| grep "Health" \
+			HEALTH=$(grep "Health" "$lavacli_output" \
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
-			HEALTH=$health
 
-			device=$(cat "$lavacli_output" \
-				| grep "device      :" \
+			DEVICE=$(grep "device      :" "$lavacli_output" \
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
-			DEVICE=$device
 
-			test=$(cat "$lavacli_output" \
-				| grep "description" \
+			TESTING=$(grep "description" "$lavacli_output" \
 				| rev | cut -d "_" -f 1 | rev)
-			TESTING=$test
 
-			submit_squad_watch_job "${ret}" "${device}"
+			submit_squad_watch_job "${ret}" "${DEVICE}"
 
-			if ! check_status $ret; then
+			if ! check_status "$ret"; then
 				ERROR=true
 			fi
-			get_junit_test_results $ret
+			get_junit_test_results "$ret"
 		fi
 	else
 		return 1
@@ -195,6 +189,7 @@ is_device_online () {
 	local lavacli_output=${job_dir}/lavacli_output
 
 	# Get list of all devices
+	# shellcheck disable=2086
 	lavacli $LAVACLI_ARGS devices list > "$lavacli_output"
 
 	# Count the number of online devices
@@ -213,6 +208,7 @@ is_device_online () {
 validate_jobs () {
 	local ret=0
 	for JOB in "${job_dir}"/*.yml; do
+		# shellcheck disable=2086
 		if lavacli $LAVACLI_ARGS jobs validate "$JOB"; then
 			echo "$JOB is a valid definition"
 			if ! submit_job $JOB; then
@@ -246,6 +242,7 @@ check_for_test_error () {
 # $1: LAVA job ID to show results for
 get_test_result () {
 	if [ -n "${1}" ]; then
+		# shellcheck disable=2086
 		lavacli "$LAVACLI_ARGS" results "${1}"
 	fi
 }
@@ -287,7 +284,7 @@ print_summary () {
 }
 
 check_status () {
-	local end_time status health device now
+	local end_time status now
 	if [ -n "$TEST_TIMEOUT" ]; then
 		# Current time + timeout time
 		end_time=$(date +%s -d "+ $TEST_TIMEOUT min")
@@ -295,7 +292,7 @@ check_status () {
 
 	local error=false
 
-	if [ ! -z $1 ]; then
+	if [ -n "$1" ]; then
 		print_status "Current job status:"
 		while true
 		do
@@ -303,31 +300,27 @@ check_status () {
 			if [ "${STATUS}" != "Finished" ]
 			then
 				local lavacli_output=${job_dir}/lavacli_output
+				# shellcheck disable=2086
 				lavacli $LAVACLI_ARGS jobs show "$1" \
 					> "$lavacli_output"
 
-				status=$(cat "$lavacli_output" \
-					| grep "state" \
+				status=$(grep "state" "$lavacli_output" \
 					| cut -d ":" -f 2 \
 					| awk '{$1=$1};1')
 
-				health=$(cat "$lavacli_output" \
-					| grep "Health" \
+				HEALTH=$(grep "Health" "$lavacli_output" \
 					| cut -d ":" -f 2 \
 					| awk '{$1=$1};1')
-				HEALTH=$health
 
-				device=$(cat "$lavacli_output" \
-					| grep "device      :" \
+				DEVICE=$(grep "device      :" "$lavacli_output" \
 					| cut -d ":" -f 2 \
 					| awk '{$1=$1};1')
-				DEVICE=$device
 
 				if [ "${STATUS}" != "$status" ]; then
 					STATUS=$status
 
 					# Something has changed
-					print_status "Current job status:" $1
+					print_status "Current job status:" "$1"
 				else
 					STATUS=$status
 				fi
@@ -353,7 +346,7 @@ check_status () {
 
 		if check_if_finished; then
 			# Print job outcome
-			print_status "Final job status:" $1
+			print_status "Final job status:" "$1"
 
 			if check_for_test_error; then
 				error=true
@@ -365,7 +358,7 @@ check_status () {
 		echo "---------------------"
 		echo "Errors during testing"
 		echo "---------------------"
-		print_summary $1
+		print_summary "$1"
 		clean_up
 		return 1
 	fi
@@ -373,12 +366,12 @@ check_status () {
 	echo "-----------------------------------"
 	echo "Submitted test is successful"
 	echo "-----------------------------------"
-	print_summary $1
+	print_summary "$1"
 	return 0
 }
 
 set_up
-create_job $TEST $TARGET
+create_job "$TEST" "$TARGET"
 
 if ! validate_jobs; then
 	clean_up
-- 
2.43.0

