Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909DEB64D7
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 05:19:04 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.56])
 by mx.groups.io with SMTP id smtpd.web10.3815.1687238341970035866
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 22:19:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p3M8St6r;
 spf=pass (domain: siemens.com, ip: 40.107.6.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsObVSQIw6leCUY3iz2ol6Iu/Cl5KgaL+IVUkjfSuPsrqFTdQFsjRNJuF5qTMeQB9jzxvPHDRL+b599s0sxu4KPxbboK1QgeK27mc9mhgw6enluA7KmTEHz2tuV9JxV43NqOWEN1DKehMunf5GZUVDfyYxvus1hNl8UXiuz+iE21jYDCjheCW6MI3m3dACltwl4kH+3hyNTPpKDJbZL2Obj2wyrv6+dePZgZ9yZRmhOe1aHwv7m4vC+S4TR2UM6KJ90JdQslBqGkFMuxopnQj4sJHXPwh+5MnZozqdiFmz+rw5XUOmP1ISG7OqXuYeIrS7QmMhAIuy/ihmMh6z1TRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRXcHVLzMUuquOIbFhminpInVIj5DbTxMiiHa4y31Vg=;
 b=Wo1FPAgTtd82yL8fWPsR4cnv6y4Cpha2iblQH20jaFVBG1sBuP/LOB0MVkJ7ngKec++qlyQCW9ps3UK/uFRLpIl77GhNRj12G6eoY107kZWfSMDM5nz9nMN4I7yeY9uln5lDygbOiwXUdqQUqsE5CDy/wZEdOJ2h3n+SDuRR/nGtfqPzXQ7mc2LcdvOKd9+aA1xqEX2c2nRUFLeUZ6WU0svnRhiuKR3xe40b9CKL+FHiXxcwC8fZyWeKs/dR1s2xN6j0FRcprG/UpbboolmTUbE5sa0eTha73TGcTbEtTc4JKkEYiMb5WrglwTJxkjMSx3bYu4zFnzYRRiqu5rSEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRXcHVLzMUuquOIbFhminpInVIj5DbTxMiiHa4y31Vg=;
 b=p3M8St6rbzmuiDWgJrToa4AQv0SRSALPE/OVA64xuWtQP86rRE/MW3rJU9kDhrugY/6ESZpm593npPsqw32HQne60YS9XqXSJs/7jSpMObD2knFZySqqYQbqmplDHqtaTZQQEt3pT2u7p9li8GwY1DlMLpPPqfQJ9XQyiIOFDkTnorcyZPzMzCurbnZ75jv21+Xp2SNYGIgxt6Bh76nasGljVxQf8vTOK8t31Vgxud0WYQTcy83hquoYgiGltQWkAriupYRs0PAilw0kn/KOrwmmFnIWnxOOJA38SzLjuruf0QRw86WF99u7MJSWiYbULyn+NVp1hqNdrSNG3DBrZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 05:18:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:18:59 +0000
Message-ID: <532bb77b-9985-ce6e-9591-2c32b2d966d7@siemens.com>
Date: Tue, 20 Jun 2023 07:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] start-qemu: Pick up architecture from
 .config.yaml if left out
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2b18f0-ff7d-49e1-95d9-08db714dda25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CQA2Fz2WcyVb8OuIP/GxB5YkxKoNe9TKV06g7wft0KV4fCitx4iOyJDKn7rUHEcEy11xXVOyIrwcdV2TC7LeGXRz6Dy3j9/mgBxEu+ahJYxwKZahCTe3+2djOD/zYQB/aDrgbcbAVWYfEcTA5v3I8VI+DqZLc+mqkcU+l88YHrnZk0OQXgVFSuAsvE6nvT7eX/mtMCqFYnyZzY5LnJUB/3SSVXmDrRYocG5d1rOwefjiww+IeqbVVSNkGEMSZAlHmB0WxZP8biKkkbBKAIofQ6ClsQSS31xVhUVAxnSQCMGev7B6E+4dsNWPXNppnwWnHfU0piqmG4droSfBTp+NtCtaXCR+X2TAOIGKf9qbGP8DgFsvHnF2S9YLESm9+I+FmUHRIxhetGngDsDEBkhhSpeVSx1InwoqT+AOBDakNRXueJc8cmldtiV23HY2j9YNk9o/4qE850rIrV/bQl2kfSVkrG9sOVfzuoMmxhVd3A7C/dVhBwwKJIGmi902nlCg+MaKCiLxRxHAI5zGwqpVvAcHTPldFdOARe74PRmVUUXiWHiAjH30Jy0a2vs0EHA2ROOGUeGYpMpnxvGTwT0Wg4m76u0HtgjL7So27uJBUcDpci9UkjXjbIbsYmrZ56tCsrDKV68mOBGFv+G412kFRHWo8NcMm6yk0uqs0IgN6wM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(83380400001)(31696002)(31686004)(6486002)(6666004)(38100700002)(316002)(8676002)(8936002)(36756003)(6512007)(2616005)(26005)(86362001)(6506007)(186003)(41300700001)(5660300002)(6916009)(66946007)(44832011)(66476007)(66556008)(82960400001)(478600001)(2906002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVZaaFNaa1N6dVJoVkpuSkJidFBXL1Nja3pZcGZWaXZoRkxaVllCVlg5cFh2?=
 =?utf-8?B?eTkrOTNPc1FGOUJRd0MwZXo0WkNHM2UvVTNkMDdscVdVcWZybGRmYWYwMGor?=
 =?utf-8?B?Z3hRNGhNOThzL3Y5Y0FMM0lxdHlhaEw0YkJtYU5QMm5VSE9oL1RPTWs5Zkw5?=
 =?utf-8?B?NzR1aktkUWYxOTE1MzJNdFVmT3p0LzNDdkl0eWRxY0Z2d2VxdDJOa0xrRTJq?=
 =?utf-8?B?QVF5WXM4N05qLzVtRW9uSUk2VWVHbFN6TGIxYlpkbmpBZ0tKcGZUZ2NzdVBI?=
 =?utf-8?B?cjc5bEgxeEhjVDNYdDExRDg4Mlh2ODg5bmtXZUp1RmJWSkNuN0xsTWdZdkth?=
 =?utf-8?B?bHFzZC9HNzdzcVRTQUM0SnE5d0d1REpHTVdQdXV4UEhpY0RMZlJSOUt4ZHUr?=
 =?utf-8?B?MFhIcDNFc0s2Y01aMEJWZ0ZNUjN6TXJNSTNKdnBteGE1QWdHMGc5QnF1eitQ?=
 =?utf-8?B?RHRpWnVpRVlBeDZOenFHcU1tV2t3bEFzc3JORVdacWJ4QkFPVkF0Y2UwTnFM?=
 =?utf-8?B?T0NzekJNUWFlaUpCdmNBdlpsTnlRNllVL2FTaEE3Mm85UFUvUFRxMDBPTG1P?=
 =?utf-8?B?MnlXNk9FR1VweW42V1NxNHBHc1FqdlIxbDEyUklDeEovRU42akM0UmMreVVJ?=
 =?utf-8?B?WDQ3ZGVXR0hrME95Q1dzV2hHRlR4bHFNQ3ZWMmFMUzh2Y1hmNzlwRHlpYTBm?=
 =?utf-8?B?VXVNTzMxaTVkZHQ0OXBXMUlFTFlkczU1NkxEaFg3YUxqTnRhSFlPcTJsQysw?=
 =?utf-8?B?aDNXc3llS09mZTVJT003NWdmZnZ3NUczeGZMdWE4Sjh3d1JIOW1Ra3ZaZXlm?=
 =?utf-8?B?dnlYTmNNTDJ0MHprcEltT2FENHZYVVZMeUs4Z1ZOdW1nbjZGeHRNOUxwTVd1?=
 =?utf-8?B?enA1QXdzKzZkOEtxMVM2a29yM0VLRjZMTUxuQnZiWk8xL3poV0NyeDRrWFlK?=
 =?utf-8?B?RURZR05qeGN2clhFNVh6blhWN29RblhEOExGMDZpQUU4c2lZdDQwdlNJV3oz?=
 =?utf-8?B?SDdLa1BPTGd4MTMrcjJ3OEo2WUVLOVJYTVBkbjN6alFIN09zdjNiamFvQVRZ?=
 =?utf-8?B?dDRhbXlKb0RpS3d6aDV4ZzNtREFCUUNvUm1DZ1dIY1kwV3dHTXhWeGtvVTNu?=
 =?utf-8?B?ZUpPZVI5SEl6dG00Z0c5VzhkOGRFTUxORzBpeDRIWE81ZWYwdnpLMVpNUG0y?=
 =?utf-8?B?ZUR1R3Zza1FoTkZsUEMxTGx6UjhYcVdGa2tiZk50RitQVDNYdkJRZmVobTJK?=
 =?utf-8?B?ak5HMWFRU0hqcDJwYzVDVzhPUVBFTTFYVExmYjZiUkdoYkU4bTF0OE9Sbmxp?=
 =?utf-8?B?bkJ6V3RkVjVYOFF4QmhTVTdjSG1CWXBwYTBxZlpzL3VtYjBSR2xRT1pSVGFN?=
 =?utf-8?B?am02ZGRVdGRZR0VCcHI0dWJ4bnN3QUxxRHBxZW91dkxBNk51dUZVRVNLUkZT?=
 =?utf-8?B?WkFnS2J4K1QveTFqYlh3akJxMWdGOGRobk11VTBtVXZhcm5UZTNJMlZvS0FF?=
 =?utf-8?B?TXJSM0xieDBBRFFLT05Bc2wrVVFhRXBFbDY1QS9FQ1lTZW4vMFVlYitrb2NK?=
 =?utf-8?B?T1phWXYzNEJsQkxzZTNZWHhKN1ROYUNSVmZ2S1lPVHB5cE9wUkJON1ZLSHRT?=
 =?utf-8?B?YkZQc2lvc3BQelA1alFpcmVWdVY5UUhRcVQ4T0ZSNkNTY2RLcDRpV0IxVmFx?=
 =?utf-8?B?dmdxNEROZExNQ3U2d2xQZmpMdFVHTXJLNFBiaTMveTIrMTVkeWdIYmIwcUt6?=
 =?utf-8?B?WEZBT0ttVTRvMmNHZDFXT1o1eTh4WUFCdXV0cTF1Wnh0U1h5bU5ObmhnSWly?=
 =?utf-8?B?Nko0SlZnbGtwMXV5SEhJZWJHb1NCK1NDT0k1VWw5R1BoeHBZYzQ4VTlQV0h5?=
 =?utf-8?B?Rzh5NkZLemlHTi9aNHU3QVRaZVZQK2hqSkswdm1qcmVKQkdWRHdCZzUva1c3?=
 =?utf-8?B?ZnRoUmY3TDdmT3VFYld3d1llMFcraHZ2dkp0YndMWUgyZE5KZUtmUzdOZzhm?=
 =?utf-8?B?OEFoN1YvVWY1UVRsOGJCdkNqbDJGVTVWMUlKRmVxZTc3b1AyZDRKMm5XSEpU?=
 =?utf-8?B?TXg1c2syUFBtSWdFb3ZTWWFEZmpid3ZZZWpyWllvb0QrR0MrM1NaU3dDT0Zl?=
 =?utf-8?B?RzAwUkpmMk1FZU1OTHc3c2prMjBaRWMzMnZCc25ZMG9zcExTb0E1UGlJbFpx?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2b18f0-ff7d-49e1-95d9-08db714dda25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 05:18:59.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmvcxjSf0toprVa/ugNoQ9O/Rigx9BkqKgv3dR7XFR20qpvaPm2J8yK7rSKI1b2lZM8Y0Gg1ULfDwB80smQbAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7563
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jun 2023 05:19:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12083

From: Jan Kiszka <jan.kiszka@siemens.com>

We already derive most other parameters from that file, and this allows
to simply call "./start-qemu.sh" after a menu-based build.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 5d48e0dc..b6f9d012 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -12,9 +12,12 @@
 
 usage()
 {
-	echo "Usage: $0 ARCHITECTURE [QEMU_OPTIONS]"
+	echo "Usage: $0 [ARCHITECTURE [QEMU_OPTIONS]]"
 	echo
-	echo "Environment variables (default to settings in .config.yml):"
+	echo "The architecture defaults to the setting in .config.yaml and can be left out"
+	echo "if the built was done via \"kas-container menu\"."
+	echo
+	echo "Environment variables (default to settings in .config.yaml):"
 	echo "  QEMU_PATH         use a locally built QEMU version"
 	echo "  SWUPDATE_BOOT     boot swupdate image"
 	echo "  SECURE_BOOT       start a secure boot environment"
@@ -59,8 +62,20 @@ if grep -s -q "IMAGE_TESTING: true" .config.yaml; then
 	TEST_IMAGE="-test"
 fi
 
-arch="$1"
-shift 1
+if [ -n "$1" ]; then
+	arch="$1"
+	shift 1
+else
+	if grep -s -q "TARGET_QEMU_AMD64: true" .config.yaml; then
+		arch=amd64
+	elif grep -s -q "TARGET_QEMU_ARM64: true" .config.yaml; then
+		arch=arm64
+	elif grep -s -q "TARGET_QEMU_ARM: true" .config.yaml; then
+		arch=arm
+	elif grep -s -q "TARGET_QEMU_RISCV64: true" .config.yaml; then
+		arch=riscv64
+	fi
+fi
 
 case "${arch}" in
 	x86|x86_64|amd64)
-- 
2.35.3

