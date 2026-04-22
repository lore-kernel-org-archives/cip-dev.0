Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D20BF94CC7
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 05:43:10 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70376.1776836581560587841
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 22:43:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x4nShEyq;
 spf=pass (domain: siemens.com, ip: 52.101.65.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVdSMmoJM+C0Lut17ol/tShuYFNtrA6FukAtuVWLs8jUCM4pYk9jUBCmNRGUNO6HVIb8piw/bA5B3laHO+3fDJ5Y60VQw++fis4ikMNONKtZk5nE6LgH22Tr2JUY3IklwKc3ZoS3JHuI9OEgWgq5X2PdrK+NC6jfyYOpAlYl3oQoNDNptgaz4V0mrzi+lZT28TEr6px5NDydMFFNmfowtwz8O1GJfldjvykqanIk0mTxqrGVKYtIq2wLXOWFblCckXnTF2BuzvVg71CZ7yhFnpoKk4BjykF3xOQtd13qo4a3EReE7stxsXgOFasonbNycFjBCI/oggzxfpaUODw/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHp5HOX7caWe59Q5ZLaDzoJq6SbkHFrb+WJC4JPFvHw=;
 b=hPLr3qLtRYABgsV5fDANQh6vfiJr+HeT0mnjGPQOnYPdIEURVGb5j08nWo7S9iUPL7nOEKfSSBbTDHPsVlCFOdif3dx+wVBSutBPXnsuRWG9GxLI62y8MNq7BEeNJZAt3kFRFUL6W50w8Gj46fv/GvHGHmhbPrEGYVvsMSK/DBHIDge57gt8zGR0dJzv/pxeZMeRZk1X+C0Ictvm+2N29u6DDC95gqDHs4aj/ZoG7jAcpMMIriE692Cy8/FtrkfGhJc1SJYquwHtXMMbVPvhFnK0mxXqETVF92qCdbt3JlhbB0IlsQPhj9ALizyiB4/oGN9zAguyjJQ07M57abdhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHp5HOX7caWe59Q5ZLaDzoJq6SbkHFrb+WJC4JPFvHw=;
 b=x4nShEyqjYCUdQ0tFrOloVmEU4fYRbfKo8GRQahTe6L6RRhwtKQP8d6oaI8Ykxz5qOMGKvJgLZLBSUIFheusW0oxbduROhp23Euc3BEfH/bEFHlEE5Z5X11/WjH/Dkv+bmRBcQ9dm9rOYY0Ikn3jDrqIDtJmHPa0aDfkFWcWCdGiCH4zPOjUSBJNh5r6CG1gx+8A9s+71dnRm34LAJXLF3ahy+HSNwMAW6Hzgvy9BtSxPoRUqXF6dEaPikODxJ5cHaLJq1ESixB2wPdRkijhMAXAI5QHk8EpV295nzALCwMBlcVa2XvmBzblFI8zTixFp49km7UsweFr05gNY/nWWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 05:42:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 05:42:57 +0000
Message-ID: <ab716af5-6dfb-487e-9ba9-b2d1a7783afa@siemens.com>
Date: Wed, 22 Apr 2026 07:42:56 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v2 2/2] tests: remount /var with exec after
 login for LAVA test jobs
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260417113651.3923307-1-gouravsingh@siemens.com>
 <20260417113651.3923307-2-gouravsingh@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417113651.3923307-2-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6370e858-1aba-4e47-5c54-08dea03201da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	oL2YarEkliQx7XYBrlBAmi6Kqs3B9x5j0VEp+bU7p0i8jT1D3gvKpuijcv5y3KAbnFsmGz/UJCGbKRhhmAMZuZSA91ochH1rgQFygJZe8YuwKF45OFL5mmm2WxnqB2wj2IU4yu65DyOcY5bjMEnttIf35NTKeT6SPkxXv2xXEAill0y0v4xELvkchEBKLthubzRc7GmspYV3R3OeTlRMt0Si3r0nksb1SswMtMH9WJpPK6K+nI/FmVetoRe1sBjWORQBMDL+ub7hJjtym2Q4RmylrSOeQytIOKXAR2sW6Hj/2rHtAgWgNBAvUkF5BDpGHjSMgN/AKmmwTeVU1JUIAaSKUZw+w1p7zXqpQHpIDEUS/N0XDoWXIvHtTSgfgXChU5aRz8d/RXHBVeTc1ftYXyvPsz/T8GPdX6ZCbs9/z3xLqmz2S4avkziK/cT1drawP/ee1sP0qh0QzEIuRWTgtfA9//mG0aujDJHoxcBz3PM/yjekioJso6DRvwVYbegKwApETd3+wfvzAdhfl+dE/rOpwnoomOY60lL/+Z2QletS4QYqcr5RAALfCcFHtosC+RcR+MXWRp52qZASd2QlFMmytIr+bvVY1Wxhf9PkL8b9obGgBxiui26q8xBjJ1PBoaNc/3JyeP55fVmqk3OXrLwdjtjViPakCc1odWiyJHSlWV0Fsp8iXEA8cZLsW/fuCUzJ7QiLdtmmF16/qPT5UiR6QbDjpzendRRaogRKFq8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnVvdjNObUtZcVZ2SjRrUGdkU0RHOXV5cDdTRDRNTXlRSUs2M09uQVJQcnZ1?=
 =?utf-8?B?SG0xN3N1eWd1OVlENzJhaEFFc0Q2Ukp4a3NvQk5xN3lPblJaZ09zUUt2Q2lv?=
 =?utf-8?B?TVA4ckZYeU9jMkdzdkViajBZOFQxVU1LRWwxVndCS09FaXl0ZGlwTlNtU1N6?=
 =?utf-8?B?dG9SRlQ5YUJYcE51cG9RN2hIa010QTlTZ0VDaG85UGVYd2M0eWtLM1R1TGNP?=
 =?utf-8?B?QTBlbjdLaWJqWHQxZ204QlJTcjlZbitwSlhBZUFCamtqVlNIUUNrclZMUzlD?=
 =?utf-8?B?MHYwUVMvYW5oRXkyMGIvdk1ObHNGY0pndkF5QTNlNDlUb1Q3MWMzTnM0MGd1?=
 =?utf-8?B?R0ZhMExRMzdYQXB2dEJXZlNBZEgxbFVXR3BIaTVvd3VZTE9PdmN0V0pGS2Fa?=
 =?utf-8?B?VTZyVWl5UUpSR1RBZXFlV1BhQzJMOHBkZXd4cFlWUHlpbFcvNjNUZkJNV3pC?=
 =?utf-8?B?ZjluZjFEMnVFYU0vWnB2L2thU1JtZlp3MStvK084RXdtUEU2VnFqekxzamUz?=
 =?utf-8?B?WmFNc3R4YVo4WjhDZ21aYVY1Z1ZMVEFMbFE4WDRwOWFhaG5jU2FqOVZlN0l0?=
 =?utf-8?B?dG5WMzdRNmRJSHlEOGxoWjY3UG5EeHZjTXc0TjUrOXBXVkRpMWtGY3luNkF5?=
 =?utf-8?B?WFVGM3gvUFJDbzNHblZiZUhYMDdQeWVTOVU0TzFwTmRFNVNnRnV6Zk1CRndY?=
 =?utf-8?B?MFJld2lCanVsbnNPWlg2OGJoR1NjZmVZU3JaODkySndtNFpQc1hQNTNaTFVC?=
 =?utf-8?B?YzVDeWdTVVZUS1ZFWjR0MEVMcXpVdkFZUFM2alM2bGIvRysrcURlUDVxdHI3?=
 =?utf-8?B?WE01MUdOTGZTbW9nalJYUzVRenZmMkIrRklZWHRpL1VuVGFNbjdaTi95S0tG?=
 =?utf-8?B?Q3BEK2I4dlYvKzNnR0FCZWFHS2NBaGdKYkFxTjM0bUo4eWxIZVhxNEIwV1hh?=
 =?utf-8?B?eXcreWUwblljek11Z3RQbkxjWGlNRGFOL1RGckpQRU5lWC8vM0R2RW1NQTdv?=
 =?utf-8?B?YldvUDl6Y2xGZHpISi9vS1FNNnN6MTlmRERBWTk0YXozekRqTmpJWDU0MENF?=
 =?utf-8?B?TXBvV3cwd0RRUjR6NnBlMkUvVWE5eEhib2Y4aDg1b0M5NXV1UUd4ei9BdmtB?=
 =?utf-8?B?Z0xIZitsb1h5MDNrK3oxbWFTYkYwcUZHaUlnWFVGbVdmYXRCeFpxV0g2M3lD?=
 =?utf-8?B?bGtMc0RGMEF6ZG92bEVRQldHZzNvb1ZyVkNyaEEvZlB3T0t5R0dOWmlHaXQx?=
 =?utf-8?B?RE8wMUpIQ0FJd25RQWtDZWljMGc1Y1lmdFd2cnZzUjNTZzBYM1diRll6ZW9B?=
 =?utf-8?B?akM2WWhQd1ZERWZaMEVFMWhKUll4SDRpK0pnR2xaZHd4REpoMy9oL2tFWmNO?=
 =?utf-8?B?a1hkSjd3b2tQNCtCck9GSldJYUtZZ05wQVFPZm5VMGd3bnhGSzNwSUdoN1cz?=
 =?utf-8?B?eXI5RG9DTmtIQ0ltV2x5VHo3YVlZWjA0S0psOTJ6Y1B4bVFUM1ZhQStiTnpK?=
 =?utf-8?B?dU1hZzYyd0VYNlBpYUFmdjVwM0M5Yi83M0U2dE14RnJwRE9zZHRzSnRKSUFl?=
 =?utf-8?B?eDltRGZGQmV1Ny9IYzRuc3BnamI3K3VlQ1RjdlBBZ0YvSnI5citMeU1DSzRq?=
 =?utf-8?B?Q3VkU0xjSkZ2Wno0ZUZsUHJLdkZQbllLSEl2RmROZzB3cUQ3bzhMNGUvbE1l?=
 =?utf-8?B?ODdCd0tNNE03czVmdVZWbFpiaUZpdmozcHVxazQ1Y0Fta3FFVTZIUzh5OUVR?=
 =?utf-8?B?QStPVzI2MjU1dktsazFZaitySzF2MFkxdlEwaXdZR2pRM20zWnI3M2RvNU5G?=
 =?utf-8?B?clZSSzhBY3Fqbk1ENXBGL0cxa0ZPR21zelZrTHFveEh1SVQ5SXhMRzBiaW80?=
 =?utf-8?B?YmMvTnlHMjZ4OURlWWpBNjlYbGxTdmoyRFNrakRuUm9GT3RaVzUvL3lNd0JY?=
 =?utf-8?B?Rnp6Y29OY3gwUDE5dmR6THUxblZpN1FZcXdWTGtIL0QzemZ6cUluc1Z4SzFr?=
 =?utf-8?B?VC9KRzNjbmRBa2NKUWZKUHBqdWZENUhPeVVGN1I1K3pNUEZQclZvZGoxVmg0?=
 =?utf-8?B?bmhEL25iUDFOcm93WStaZTRXdkwrUmd4RGNIZ2VkT3NHZGdaYVFYVmVaelRR?=
 =?utf-8?B?M3A2Ym5tajcvYktZUSt0YnNVUFhMOGhOMEF2YVpXQzFQNzg1K2QrWFRtS0JJ?=
 =?utf-8?B?ODY5RTY4aTV5MG9QWHNOK3lKRmwxY29ISGVxbHZLRzREQWJZNW8zbWRrZGRN?=
 =?utf-8?B?aUZjcFZCZXA1ODBRNitFQVRpbFg0YXFyOUZVYWFSN0ZGc1BHU0tPNlp0UEF5?=
 =?utf-8?B?QnFITEZwTGdFeEg3cVZFSFhoL3p5T2xIQUI2MUl6MGlXZTJQNGkxZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370e858-1aba-4e47-5c54-08dea03201da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:42:57.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBjq2EICPLyxLYP3CW0z96CeH8Jc7PnD0Twn1ktC6zhDfiOjyw94TNQabu33HEskSWr1in64Z3JHHA4d6f2qAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9184
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 05:43:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22780

From: Gourav Singh <gouravsingh@siemens.com>

The crypt hook now mounts /var with noexec by default for security
reasons. LAVA places and runs its test binaries under /home, which is
a symlink to /var/home, so any binary execution by lava binaries
fails with "Permission denied" due to the noexec flag on /var.

Add a login_commands step to all affected LAVA job templates to
remount /var with exec after login. This remount is temporary and
only applies to the running test session, it does not persist across
reboots and does not relax the default mount security options at the
image level.

Affected templates:
- IEC_template.yml
- M-COM-x86.yml
- secureboot_template.yml
- swupdate_negative_test.yml
- swupdate_reboot_without_confirm.yml
- swupdate_template.yml

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
[Jan: account for separate home partition, account for "templating" via script]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

OK, I feel like I have to resubmit this version which is now hopefully 
passing because it highlights "nicely" that we urgently need to rework 
our barely maintainable test definitions. I still wonder how I was able 
to find the second trap without having had much coffee this morning...

 scripts/submit_lava.sh                              | 2 +-
 tests/templates/IEC_template.yml                    | 2 ++
 tests/templates/M-COM-x86.yml                       | 2 ++
 tests/templates/secureboot_template.yml             | 2 ++
 tests/templates/swupdate_negative_test.yml          | 2 ++
 tests/templates/swupdate_reboot_without_confirm.yml | 2 ++
 tests/templates/swupdate_template.yml               | 4 ++++
 7 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index a4d20ec2..96454559 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -224,7 +224,7 @@ create_job_mcom () {
 
 		# swupdate test action on M-COM is different from the test block used in QEMU
 		cat $LAVA_TEMPLATES/swupdate-test-action-M-COM.yml | tee -a "${job_dir}/${1}_${2}.yml" > /dev/null
-		grep -A 12 "# BOOT BLOCK" "$LAVA_TEMPLATES/M-COM-x86.yml" >> "${job_dir}/${1}_${2}.yml"
+		grep -A 14 "# BOOT BLOCK" "$LAVA_TEMPLATES/M-COM-x86.yml" >> "${job_dir}/${1}_${2}.yml"
 		grep -A 16 "# TEST BLOCK 2" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
 		sed -i -e "s@#updatestate#@2@g" -e "s@overlay-1.1.1.4@overlay-2.1.1.4@g" "${job_dir}/${1}_${2}.yml"
 	fi
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index 148f07ee..dd02bb75 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -59,6 +59,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi
 
 # TEST_BLOCK
 - test:
diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
index 7cb6cc2d..107243d0 100644
--- a/tests/templates/M-COM-x86.yml
+++ b/tests/templates/M-COM-x86.yml
@@ -46,6 +46,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi
     transfer_overlay:
       transfer_method: http
       download_command: "curl -H 'Connection: close' -v --trace-time --output overlay-1.1.1.4.tar.gz"
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
index 0a075e2e..723adb34 100644
--- a/tests/templates/secureboot_template.yml
+++ b/tests/templates/secureboot_template.yml
@@ -59,6 +59,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi
     parameters:
       kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."
 
diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
index 250eaa89..70d4d770 100644
--- a/tests/templates/swupdate_negative_test.yml
+++ b/tests/templates/swupdate_negative_test.yml
@@ -67,6 +67,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi
 
 # TEST_BLOCK
 # Fail the job if software update application error is not as expected
diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
index 074eb1a6..d63e8833 100644
--- a/tests/templates/swupdate_reboot_without_confirm.yml
+++ b/tests/templates/swupdate_reboot_without_confirm.yml
@@ -25,6 +25,8 @@
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi
     parameters:
        kernel-start-message: "kernel: C:BOOT0:linux.efi"
 
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index d62d3121..63b3b10c 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -59,6 +59,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi
 
 # TEST_BLOCK 1
 # Fail the job if software update application failed
@@ -102,6 +104,8 @@ actions:
       username: "root"
       password_prompt: "Password:"
       password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi
     parameters:
        kernel-start-message: "kernel: C:BOOT1:linux.efi"
 
-- 
2.47.3


