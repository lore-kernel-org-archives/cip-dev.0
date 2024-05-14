Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05960C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 13:26:54 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.63])
 by mx.groups.io with SMTP id smtpd.web10.15523.1715693210934913203
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 May 2024 06:26:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pFkSCprz;
 spf=pass (domain: siemens.com, ip: 40.107.6.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYvtNDANbX82dJXi+QDCU2j8OG9d47IM5JoCIN7lSc67rKFfwpAkvZIzxZqrw5hpA+14lhncSLkPIyAIPj/uHRryrVfwGJg8mbBjP4TT5rKGLO1GDny6/+QW6kxIaKDLUfcg7HfQvr3Cbj7RMGuSDa/McbDZ5UvlDXSdW+AF2JghCY3mSUjXzZW+yebEj1ZZIJXUq/to2ycuZssjMSw1HUMGI4U3LmK0SjgiLErtx7iitjvaACQdHHcEWvETaQthmWcLbCG4BHnFxBbLqUWacTToFkO7ZU/Ayp6Q6vkMEr/i2mcHYqIV3mltBieohBmT1PCndVHgZl9ItIm/tgltMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2aorIQ0iSk34MmkxtIdGcNm8QS1S4eyOQn99bgUuz4=;
 b=Igq9nB/cOyniioHZrCCl/Xbhz+4AbnqICp/wx3atgNXmxCofWoiHE+6jbZRIuIPB0L+KocgitrQxZEi47AlunWntlYohWhyzSsFy1aE7wYGYQTUzOAsGy73/I2bQxXFfBtzxDu8ZdKShVUyaszMEjJtniG9TBrvyBSC+BPG9XWfbyaB9HfSE+Wth1NmmSdTMeRZ/EIwaGG2chxTCNX0MPmbP3j9KSyqMn79Ha4nqpTjAB9QVo1H5er7LQxGMkdVLI6Q5U1OvLPvQCMgalrbQiT+MiS7mrUCkbDNXBTn7VKIiWLgYD5bad9CJFZMetcNLQcClAiZrvvNsg1KjeNfjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2aorIQ0iSk34MmkxtIdGcNm8QS1S4eyOQn99bgUuz4=;
 b=pFkSCprzmj7vA4tLaiLRRew2eSKDMF9fATjj4JY01iOSkf0TG9wa9axssN1WrO6zMcvoDDo+N8Ledu7/B7L5ZqG2diT3YR82V2a8UPwjjJd9nFceLJTqrAQQRUjsAHN3+bwiLxHgBaLhY2L3tZfU2y+Qnc021ly7spfXqIE0lvzFhZicFtaR0XjoHwdezOwRBc5bJGpmS7hyBnsHfG7CBtAYeUQGFn3gbQyI5A9KfrQCec6b5NksHzLwIW2CqyxwNQLDZ6HFqvPCacx4RqJLSrsKVQpDambzn6D42v9d/SDBmO6qAAgHyIcAy+VAkFw7fqFxN93qykLADz7dVorZPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:388::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 13:26:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 13:26:47 +0000
Message-ID: <2f21e81b-a87c-4d15-af8a-d50c201461c7@siemens.com>
Date: Tue, 14 May 2024 15:26:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v5] Update ISAR to latest version
Content-Language: en-US
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 276c5a24-4323-4a75-6860-08dc7419816d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ajFRRERRS3ErVmVMclpLNnF6M2ttQ1o4eFFjRFhtY3B3eTV3MzhwRE1JVHdl?=
 =?utf-8?B?SnVtaWJyWmprK2ZsdTMyTTV5VEIzeHdlcjl3Vjg5Nm9qbkNZelpFdERSR2Jx?=
 =?utf-8?B?akp0OEt1ck1HcmpxMGhqa1doTVhOTlpxT3QrOVVkcTl2M3FrbGN4dWtPdnBE?=
 =?utf-8?B?QUhRZEFOZGh6UCtxOFBmVWdXVDFzOUplRDQvLzJUS3NjTjhHQnhRbWtRSzJx?=
 =?utf-8?B?WnFyZFVIanJ1aktLTkV0THdUd1RxS05PV0xyUDlNYmpaQzVpb3Mzd1Fxb05x?=
 =?utf-8?B?b3F6R1RXVFZRQ3VybzN3eXpDaWl0dUFheCttWnBqaWtHZ05KMW9JbE40cXRJ?=
 =?utf-8?B?Z2NMVlVLVlVaVVhRVllUeFFZRmVCbGgxQ2NCWjhYVFQvbHRZUlNheTR2bGZ1?=
 =?utf-8?B?bldRekFkUFR3K29OQ3diaEJaTUhtS3MwT0NQUFVVL0E3QUlhQjUzaVdvMUZw?=
 =?utf-8?B?UVFNK1BXVkU0d1d4WFcrVXdHcG9sVm9VL3VtQXlnbnpuaWtWUk93L0ZXS0hw?=
 =?utf-8?B?VXliellUaTZPS3dzRFcvZldsTFhQdlR0akxKTHNlTkZnNjIvcldpZUIvbW5o?=
 =?utf-8?B?UGU1bDFXOUszWC9PRnI0dFdaSCtXOGNrZ0ozSlpXREEyajJCd0xLK2xzekR3?=
 =?utf-8?B?NWRnbU55ZjBUR3FZdTFZdmY4UXlUOFN2d0ZjRThnSUV2ZmhZWWlvSnZaR3Zh?=
 =?utf-8?B?QUpYR0YwU1l1NUtPOTh6SDFEdWUzb2huZGY3ZWdmSmwyUWxETGNVSEw5MFll?=
 =?utf-8?B?SXQzK0REUGQ2MmMyVnIrNTBiWjdTaHVsRFM2LzRBZVhrMWY1dTl3OG4zMUhx?=
 =?utf-8?B?cHk3dTlFOVFybjJhS3pkOGZhUzRlNlUrOVlPblY3NWR3dFRRVEJ2VjQ2Rk9S?=
 =?utf-8?B?WVgwUUlTVENra3J4elBIMXV1ckhmL0tydy9WQTI4ekFldWpyMU9xUDdKaTlm?=
 =?utf-8?B?encyeEFQSjdTTHZpV3V4Zk1EcW5nTjhkTzlvNG1mNHhaNUZxMkY2MzlUZ3Ju?=
 =?utf-8?B?T2xPN0RvWkUvMkxialB1V3JBNmFqWEpmRmQvd1AvSCtBeVBjclJhc1VNUnhB?=
 =?utf-8?B?S2pDZnViWExhTjRHS2NPTVlaSUpDcFV5QzFzME9JNnRMVFpsNG5qZWxubWgz?=
 =?utf-8?B?dGZsTDJJT3AvNDNVemhTbDBQQ3VGMUoweDQ2MXNDbTBsbzZoTktmU0RNWWgz?=
 =?utf-8?B?Z2txVWxva282Rnl5RWdRUThJK2M3WEhpNFFncmJxL3lIbXFSdkdteUhTMTBi?=
 =?utf-8?B?N2lDbmFUQkJiMkhvcWdoeXdKd25qZDJjQ1hXWUxxWDJVeUR4NzI3WlZORkdO?=
 =?utf-8?B?eXNtZlNTdU10RnNDQjFETW4zWDlJVXNJeTBERTA2bXp6S3ZqYWQvbWU4aDhs?=
 =?utf-8?B?NnBmVmpwYkR2VmFTU0lacVVJUVlCdXdTU0E0Qk4rSG5sM1ErckR6TzRmaXJD?=
 =?utf-8?B?OGNXWkk1RzV0Rk9XVTlibXEwZGxjeUdEMmwrYW0vSWV2S25xR1NISUpYRXBs?=
 =?utf-8?B?VkNrdTUzTTdDangxZjI2QkYvQ25BeHRuQ1lJT1B6MktFSUJSK0M3ZmZSQWhK?=
 =?utf-8?B?STBRcXJ4dGo3b041eTVwMTlIcU9wUVFyQ2tVaC9wbFRXOGtXVkRPZ05rYXZP?=
 =?utf-8?Q?batir/x6H+qTPKGnL8SXsaBczu1JHmUQER2Tueyy46Sg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dklTWFR0QTV2VE5qY3hBcFM3eldqTXBKY1g2blhYMzFKenRucjNsMUFqYU1F?=
 =?utf-8?B?Z3NHSXdzVE4weWJUSXlHVlRvcVBpVVZzY2dRWUNxbXprVW5yb0liZVVCclJM?=
 =?utf-8?B?TklCbjJoR0c1bU1RK09qRGJMYThqL1JPYU0wTGsvRjR1akg5djhEWDRXZUwv?=
 =?utf-8?B?U0dQU0pITVArbkdjRDhnT1JTeHpFdXF3bk10VmpqenE2eDV5WVVYODZTRER3?=
 =?utf-8?B?clFsbFRLY1RLSFFxNnFzNVoxa25uM2lESFdRMVgySHFVUHRudkkybEk5TzJM?=
 =?utf-8?B?YkZFQ29ldEZ5UEZvUThNdlBiVVZMYjFwR3loM2pJT2I3YjQ4UExiclJrK1p5?=
 =?utf-8?B?dTJMSkV4dVk0cUY2V2I0NnBpTWpLT2h1Rm1UbjRSc3RhRytPRE12VVlscXVD?=
 =?utf-8?B?VDJ3VDZUbDArdzl6MHhSYURYVk9oOHNJQnVyZWh3YTdTV2pINFNFaFc0RUVU?=
 =?utf-8?B?RGpsd05iSitEbUt4QkdjOUNOL2NGaVVYNnUvL0VvOTA4T0orZG1tTDlHY2Ju?=
 =?utf-8?B?QTlXbXZRTU8zL1dmc2pnYUpQaE95TXk1NStUYi9zTGpmU3NXcGt6UWNmbExn?=
 =?utf-8?B?WUhHLzYybDNKdUVJOTh6Vk9mN29aaVFRVkpsK1BxNzFJWXNQd0s1cDcrSW9o?=
 =?utf-8?B?SWtvNmhOd29yL3BpQ1pLbzZTRVZmMGljVFpiOW1YdHR2aklodXFpTVdPdCt2?=
 =?utf-8?B?OStJMnVoUEExd2dkYjQ2TUVCbDhxK0RuZWNydStmQkRueFNUeGdLWnFubHVt?=
 =?utf-8?B?QUJKTTJybW5tRHA2SXMwOHVHUjFKRldraXRKT1g0TFdRdDNsUDZNT2UzQzd4?=
 =?utf-8?B?alVhTXdXQ09yZGpFSEVRTGprbmRrR2llM0RGVG9XS0NYYlVpZUVKL2t1Tmdi?=
 =?utf-8?B?TUdJUVMzNEk2QUpVZmRDZzdveFJhMldpU0tpdXB2QW1xdVpySFJocEJFdEJX?=
 =?utf-8?B?WDh1UGpTV3djUVdZeHkwd1BBUVZUUE5Gdmc4cW5vWWt0UTlUcC93QWpMWWlC?=
 =?utf-8?B?a1FzZmd4V2liY01nVS9mV0RyV0VoMWdoTitvSjNDVXlIeEQwVWNvaEE1TE1v?=
 =?utf-8?B?REJxZVpTalFrUnptWWpIR1h3WDNoalRKN2pHSXQ3MTVZcVoxQmljVHJjSjd5?=
 =?utf-8?B?eFp6dUZVU2JLVWF2WGxLd0RsbFpJZjFpR2NyeXh4TGZ6cHVKN3FFdFRpZTh5?=
 =?utf-8?B?RmFweHV5L2pMQmRNbHl6d2s2V09EVzBxZG5pV0RMZi9nK1J3WldQRG0ySTN1?=
 =?utf-8?B?REFOdERlMTZFQWd6OFRuaW1HOGZ5WXl0OSs3R0lRMHBlbkVjempxbjgyOEhK?=
 =?utf-8?B?VTBtenpGWjZRYnRLTjd2Mjd4M3FFSGRxclk2OXhRenQxaUdSdnd4VXV4QjJW?=
 =?utf-8?B?eDRkSW5qbDQ2Ym9xZmk2WTk0MUVUVkp0QUtpbUZQWHZtMW51dHdDMUZvVExm?=
 =?utf-8?B?bHNxaVlxWXdqQ0JHbkQzVXFoWm43d2x6dUdwVWE4Y2RJdy9rK0hCWFV4S2lr?=
 =?utf-8?B?R2U2ZTRzRWRFbnViQmpZS1l2VGJvaU9iM1BPbUlXYmtUMUl2ZDFDVTlNUjNl?=
 =?utf-8?B?TGN5ZzY5ak9FcGRtOGZSMW9qdGV1TWhucy9wNHozTFRwS3ErdnhWOU44dkFS?=
 =?utf-8?B?VjFXQ045M2MyUzhjZ3RCVXpHV05IUjJhaUtVcGRrNmZZTHorcTJsQi9NNEhp?=
 =?utf-8?B?Q2NzbERRS0xFK3pqdElxTkk4MTE2Y3JGZWVSNmtXOUYrbXFuSXltY3pITTFN?=
 =?utf-8?B?T3FDT01ENHBZKzROTlRLazZwYTVhVFlmd1lRV1VNUysvWVgzWWE4TmFhSWlp?=
 =?utf-8?B?dW8xNTdqVXpSMEcrd254WTRObEVreEZRcFlBNnZiVUxkYW1yZk9iMXgwWmZZ?=
 =?utf-8?B?aThnaEUwaXhseURYZzVGMGtrRUg5bWdCYXNZTklvejg1cVQrNU5BR1hMNFZT?=
 =?utf-8?B?MmV1ZnlkdnlzV1BZS0FiZGRuRmQwRFk0Qkh2NmZBTktscjR2cTIwd1F5V1gx?=
 =?utf-8?B?U2liOGRhZDliNXVSVnd2STEwL1hWbGRKVE9vWGJUQ2tiUVFZTU8xRHFKc1I1?=
 =?utf-8?B?amdTYytadFJYY0tSeXhUSjFoZ0dQbXNPNzRqOVMrMHFmUjdDNWRld1Byb090?=
 =?utf-8?B?bmNFT1pXTHV3cEwwRlZyKytOaXdLN3pCREZ4TVZ4dEllZFBJZTFBUldXWHNm?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276c5a24-4323-4a75-6860-08dc7419816d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 13:26:47.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f2TzhCMYBZSS7DqyvTPP9au9uV7XqH0nfNJsQgwFKhCldSV3wBf91qfwrTIBT2ij+V7zzrIuVKFPEHQmEBDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6167
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 May 2024 13:26:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15893

From: Jan Kiszka <jan.kiszka@siemens.com>

This update requires to resolve duplicate "Provides:" statements in
secrets/certificates recipes (based on original patch by Rakesh Kumar).

We furthermore need to drop the now obsolete SOURCE_DATE_EPOCH variable
injection in squashfs.bbclass and define SOURCE_DATE_EPOCH_FALLBACK,
rather than SOURCE_DATE_EPOCH directly as this is now handled by isar
itself.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v5:
 - added new linux-cip targets to PREFERRED_VERSION definitions
   (reported by Quirin)

Note that upstream isar still has a few open issues with the new kbuild 
model. We are trying to sort them out, and I will likely have to wait 
with the v1.4 release on them.

 classes/squashfs.bbclass                                    | 6 ------
 conf/distro/cip-core-bookworm.conf                          | 6 +++++-
 conf/distro/cip-core-bullseye.conf                          | 6 +++++-
 conf/distro/cip-core-buster.conf                            | 6 +++++-
 conf/distro/cip-core-sid.conf                               | 4 ++++
 kas-cip.yml                                                 | 4 ++--
 kas/opt/4.19.yml                                            | 6 +++++-
 kas/opt/4.4.yml                                             | 5 +++++
 kas/opt/5.10.yml                                            | 6 +++++-
 kas/opt/6.1.yml                                             | 6 +++++-
 .../secure-boot-secrets/secure-boot-secrets.inc             | 4 +---
 .../swupdate-certificates/swupdate-certificates-key.inc     | 4 +---
 .../swupdate-certificates/swupdate-certificates.inc         | 4 +---
 13 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index bf72133e..b39be0cd 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -31,12 +31,6 @@ SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
 SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
 
 python __anonymous() {
-    # Set file timestamps for reproducible builds
-    source_date_epoch = d.getVar('SOURCE_DATE_EPOCH')
-    if source_date_epoch:
-        args = " -fstime {time}".format(time=source_date_epoch)
-        d.appendVar('SQUASHFS_CREATION_ARGS', args)
-
     exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
         return
diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index a827c254..16fce25e 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,4 +14,8 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_swupdate ?= "2023.12%"
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-native ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-kbuildtarget ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt-native ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "6.1.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index 110f3343..fc8981f9 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -17,4 +17,8 @@ DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bull
 
 PREFERRED_VERSION_swupdate ?= "2023.12%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
+PREFERRED_VERSION_linux-cip-native ?= "5.10.%"
+PREFERRED_VERSION_linux-cip-kbuildtarget ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
+PREFERRED_VERSION_linux-cip-rt-native ?= "5.10.%"
+PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "5.10.%"
diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
index 4e9a4a73..e30603fd 100644
--- a/conf/distro/cip-core-buster.conf
+++ b/conf/distro/cip-core-buster.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,8 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_swupdate ?= "2021.11%"
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
+PREFERRED_VERSION_linux-cip-native ?= "4.19.%"
+PREFERRED_VERSION_linux-cip-kbuildtarget ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
+PREFERRED_VERSION_linux-cip-rt-native ?= "4.19.%"
+PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "4.19.%"
diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
index 48f26ff5..42eb311c 100644
--- a/conf/distro/cip-core-sid.conf
+++ b/conf/distro/cip-core-sid.conf
@@ -16,4 +16,8 @@ DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
 HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
 
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-native ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-kbuildtarget ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt-native ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "6.1.%"
diff --git a/kas-cip.yml b/kas-cip.yml
index 2c3c8b0b..52e53061 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
+    commit: 3d863aad5e12c7bef382cb6fb3f1f5e18b236156
     layers:
       meta:
 
@@ -42,7 +42,7 @@ local_conf_header:
     USER_root[password] = "root"
     USER_root[flags] = "clear-text-password"
   source_epoch: |
-    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
+    SOURCE_DATE_EPOCH_FALLBACK := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
 
 env:
   DISTRO_APT_PREMIRRORS: ""
diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
index bad4293d..799b890e 100644
--- a/kas/opt/4.19.yml
+++ b/kas/opt/4.19.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,4 +15,8 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "4.19.%"
+    PREFERRED_VERSION_linux-cip-native = "4.19.%"
+    PREFERRED_VERSION_linux-cip-kbuildtarget = "4.19.%"
     PREFERRED_VERSION_linux-cip-rt = "4.19.%"
+    PREFERRED_VERSION_linux-cip-rt-native = "4.19.%"
+    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "4.19.%"
diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
index c0c5c055..3b9239c1 100644
--- a/kas/opt/4.4.yml
+++ b/kas/opt/4.4.yml
@@ -2,6 +2,7 @@
 # CIP Core, generic profile
 #
 # Copyright (c) Toshiba corp., 2019
+# Copyright (c) Siemens AG, 2024
 #
 # Authors:
 #  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
@@ -15,4 +16,8 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "4.4.%"
+    PREFERRED_VERSION_linux-cip-native = "4.4.%"
+    PREFERRED_VERSION_linux-cip-kbuildtarget = "4.4.%"
     PREFERRED_VERSION_linux-cip-rt = "4.4.%"
+    PREFERRED_VERSION_linux-cip-rt-native = "4.4.%"
+    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "4.4.%"
diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
index f3a6d86b..a9cbe25b 100644
--- a/kas/opt/5.10.yml
+++ b/kas/opt/5.10.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,4 +15,8 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "5.10.%"
+    PREFERRED_VERSION_linux-cip-native = "5.10.%"
+    PREFERRED_VERSION_linux-cip-kbuildtarget = "5.10.%"
     PREFERRED_VERSION_linux-cip-rt = "5.10.%"
+    PREFERRED_VERSION_linux-cip-rt-native = "5.10.%"
+    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "5.10.%"
diff --git a/kas/opt/6.1.yml b/kas/opt/6.1.yml
index 7ac27359..f140c273 100644
--- a/kas/opt/6.1.yml
+++ b/kas/opt/6.1.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2024
 #
 # Authors:
 #  Felix Moessbauer <felix.moessbauer@siemens.com>
@@ -15,4 +15,8 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "6.1.%"
+    PREFERRED_VERSION_linux-cip-native = "6.1.%"
+    PREFERRED_VERSION_linux-cip-kbuildtarget = "6.1.%"
     PREFERRED_VERSION_linux-cip-rt = "6.1.%"
+    PREFERRED_VERSION_linux-cip-rt-native = "6.1.%"
+    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "6.1.%"
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index 2164b121..f11e93d2 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -14,6 +14,7 @@ inherit dpkg-raw
 DPKG_ARCH = "all"
 DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "secure-boot-secrets"
+DEBIAN_PROVIDES = "secure-boot-secrets"
 
 SB_KEY ??= ""
 SB_CERT ??= ""
@@ -31,6 +32,3 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
 }
 
-do_prepare_build:append() {
-    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
-}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 944c2dce..93cf255e 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -15,6 +15,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 DPKG_ARCH = "all"
 PROVIDES += "swupdate-certificates-key"
+DEBIAN_PROVIDES = "swupdate-certificates-key"
 
 SWU_SIGN_KEY ??= ""
 SWU_SIGN_SCRIPT ??= "sign-swu-cms"
@@ -35,6 +36,3 @@ do_install() {
     install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
 }
 
-do_prepare_build:append() {
-    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
-}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index dec9a836..2532de6d 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -16,6 +16,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 DPKG_ARCH = "all"
 DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "swupdate-certificates"
+DEBIAN_PROVIDES = "swupdate-certificates"
 
 SWU_SIGN_CERT ??= ""
 
@@ -30,6 +31,3 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
 }
 
-do_prepare_build:append() {
-    echo "Provides: swupdate-certificates" >> ${S}/debian/control
-}
-- 
2.35.3

