Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB1C27C4F
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 15:14:50 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.45])
 by mx.groups.io with SMTP id smtpd.web10.8010.1719674081701595164
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 Jun 2024 08:14:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x7sBwuq7;
 spf=pass (domain: siemens.com, ip: 40.107.20.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMfs4H1IbBVlQa9+BUc2TVoJA5zpNQZE6Vxl+0Zi8gDeY9gaYyE/cs0O5arxx+KtIj1CH6DfcPWD0/aZ6+d00QYHhQ3Bh2EceoqxI++1nqQVQCijbkYXctp7y5f1wgFmHhD+1QgbF8/HzFQTa6jBBDcpTqEnduLMqalhdlIuLj9GlgLB75XjvrLUyj3QbF6019WPs6tsjPoOgppkjbZWe3yrLfL7bL8I4Qs2FMB56xerqpcRKWFiU5ocSZIcypVGaYpv0sEWp2IGqUHh6s3sMFk9XOURelUFJYG1Br9VT+Dqrzr18zF/K1/vhBfuOciEh64MfQ/aVraLGiwWFsQlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eN5pGTMyLd7lYiFXT7xA3iSvTxKvWYisnEcQvZa/Yc=;
 b=M47MjmE9VhA2iuRDaxjD3wZK8WKQmeJmHxFU+b7wG8k2iBvWq6DQNrKyTkjEr9MwtWFxvCcWrj0mknQ+3b5ROIDAfr5cBeQcqy2hGAOr8SKCHP+kLKeYUAcYwf73hIWFDHg5Yym0EctYZxewZi2Gq+Ovem1+pfjmh2cuGYkMPpLxNaX5Pb4jnebECfASlWtcGmL4xqQBXmaK07fX1gvB5rB9/sssHgVoaI8squtIUl5nMOTSUmYdigtxXHL4x15naqQ+GxgHJDBMs+0rygKivc64sYKjEobq90tJvy/Tfgs3ULkHOccHNGwNgNTwPLgMPoBDU4N5pdo+b8xoqJNZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eN5pGTMyLd7lYiFXT7xA3iSvTxKvWYisnEcQvZa/Yc=;
 b=x7sBwuq7/RlTJtQjOUoDVyCYZn1Irx4QfCDe+/D48Mg53cMdRqwvo9wLIUjxfsnmik6+nWrCvnFY/NGdJG1HXol6Qy4rU8kxUgItqaE1e8xwk+HwRod+dcJBZArP/XOePRVgIdqnDRaADSYEEjkFPvr3Qssz+JXSsVGqqY2IQzyEPYg8Pj01Kjc96thKC+7Fo6CN+nU8i5wI+FywwrDDaELaVpCYtbhTl6r3jj6ML0L6DEZ+bBNJEGcN76eD46r9fsnig2fJRQpCbuwLJV+uKCXhIU1Lxc+GgEn9Bgu9NsIsw1akJddkzNi+RwzH1ly0ukaEXdJhKSQuICOuvni5+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sat, 29 Jun
 2024 15:14:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Sat, 29 Jun 2024
 15:14:38 +0000
Message-ID: <34fe48eb-2b6d-4e96-b7fd-041ce43b98c7@siemens.com>
Date: Sat, 29 Jun 2024 17:14:36 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v2 4/4] ci: submit_lava: Reduce validate_jobs
 to handle only a single one
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
References: <cover.1719642474.git.jan.kiszka@siemens.com>
 <306d108ad904f0c8c4afa31fa0f34fa80a51e3a8.1719642474.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <306d108ad904f0c8c4afa31fa0f34fa80a51e3a8.1719642474.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3170:EE_
X-MS-Office365-Filtering-Correlation-Id: e91723d5-dbf7-4301-e38c-08dc984e3190
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S1kwTlZKSlNvR1dmbHFQSDEveEF6N2hKSUJYRGZlWW8rVWlGQmt0Z3JuaGRQ?=
 =?utf-8?B?TU54dnFVTTVSVnZqd3VXeTl4WE4rWFR3UzlNUkpxam9hWEVZejhvdWlYVFNC?=
 =?utf-8?B?TUhtTStPcW1YbkZhc0JsV1dpdVlpaU9lSXFsM2hWVTM0ZXduczdPcktBZWM1?=
 =?utf-8?B?Unl4cWwwMWdGSlJpaVNwS2ZvdzBDMzJKNHkwTmVNcTl4Y1g5VXdEL3ZpWGhE?=
 =?utf-8?B?TTJaWXJvRC9iN2NmVVl5R0syMHBGS0srZXR0VTllVXZvcjI5c3NnYXpISE0x?=
 =?utf-8?B?YzcyVVZ3N2lJRmRPU0IzVjVKQUNJSUFObzZWTEtoc2xHdm9wYUl2ZFZNaXBx?=
 =?utf-8?B?TUFXNklGL25KY0dLRGVCSWYwZEZscStoaFVQYjVjeXVnVzRLVHF6ZzA2Y3lp?=
 =?utf-8?B?cjdmclBzVlRHc2kxUFRwcWZnVnZNd1F5Z01sWlphR01DYStURll0ZVZxV3BB?=
 =?utf-8?B?ejArQVJJMnQ0dlcrNkttdUQ4TFc5Tk1rem05M2xBMnFxbnFNU0NWS1JISk5r?=
 =?utf-8?B?NDMxU3JxOUpSd0RqMzVkQmVja29HWUx1ank0aGtkeEVtT2VuU0puRm0vL2FJ?=
 =?utf-8?B?dUUzVjIzVlVGdEI4NmJ2Y0I4bmExbko4emRoc3c2NVlqeVVyOERLbXhmbVJS?=
 =?utf-8?B?UXBScERhdjltK0xHMzI3Z0k5SzUrbktXMWN2cHMzUmpYVUxuSHExbEhmUDZC?=
 =?utf-8?B?bWEzYzhPWlNXYlh2V1Rob2pWVzZMcmhzd2Y2eDBrSDV5Y1ZNdzNRVndOQzVQ?=
 =?utf-8?B?L1paNDFUNUxDdHJxbWNZMGlneDBUOWE2a1Vjd2hxWmZDWCtrQXJwRzRwcStS?=
 =?utf-8?B?ZEcwQTMySE1qL0RzVDkza3V5M05pcjJmRFo3dlgyY08zbW1NMmt0NURRYy9D?=
 =?utf-8?B?ZThDOTd2Zk1rcFRpY3BSY1BYRUphdjFsS2dMT0o0a3liOTY4dEc4OVNZQjYy?=
 =?utf-8?B?dW02bUFPZFl2aWtGdEF1aTd5UE5jbnVBL1RROWMveXdCVnVaR3NCcG41MlF0?=
 =?utf-8?B?U2pSSE81bzlWRmkvT2lhMlVlSmRlS0Y2VW9rVGpDQ2llWGZCbVd6MlJIVUg1?=
 =?utf-8?B?VktENXBWMFFDOHN4cXVIR2UwTWI4TlljemN4MTBndmMzaDFoYUdNQkJhNVN0?=
 =?utf-8?B?clRvK1pmVlY3NFoxT0haOGhCdExNaXlWMk5qV3lJVC9teDdmM2c0Zlk1ODlq?=
 =?utf-8?B?eFpQY1REeENKVmFUenJFUHFkZnowaDV0eGg2MjZ6M2cxTEtaZG1kSHg5Nzlk?=
 =?utf-8?B?cGlYODRtVERQa0IvUy8rSTZYdWszRnlkdklra2sxNGllTDN4VmJPU3dlb0pG?=
 =?utf-8?B?cU1tNWtvd3V1QXR1SFRvdnFHRVFLKzhkd0VhK3BOSmRZTFRlWnBzM3QrSWda?=
 =?utf-8?B?ZW1KMGhhbVQzMUJqdEhxVTJTbytNVVZQc3VnVzZGZ0k4bnlMTVBlQjV4RGls?=
 =?utf-8?B?cXh5RnE0Y2NkelMyNEthUzQyY1d6TmVZM1ZUTnBaZFVEbm5jN2E2Q3dXancy?=
 =?utf-8?B?UDk5YWx0d2YwSHd1dXZQRFFPYklKVndBbUVsdy8xeHdjbjJxZWNNSnhOYkR3?=
 =?utf-8?B?QUc4bERWb1FRMUhsV3FSK09jN24zZ3o2RDZIMlk4aEs2UzZneURZR3BFTWgx?=
 =?utf-8?B?NFFVeFFidXJJNERWcXgwcUxLcTl6WlBha1NJa3Mzd3l2clMzMng4Y1p4MnI5?=
 =?utf-8?B?UGY0MVd2WHF5RU95ZHdGcmMyWHJmRU0vcjYzbnd0RmxpTzR6M3dPWERUU2xD?=
 =?utf-8?Q?Vgkm8htlKpZiLK/bHU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWdhNjZUWTBuZlRoVURHSHRTZHE5NUxhK2hLaE13Q0hZSHlQdmlZWUVqWXJt?=
 =?utf-8?B?MHdUQjZ0RzFTdlYraEJGbXAyaUtvcUlGbVJJTFE3YkovOTUxTTMvRXFjKzM4?=
 =?utf-8?B?WVVNYUJ1eU53bVFtZ0RkMS9ndUthMEV3TVNoWlNxNitrMENSTmlqWnlRcGs0?=
 =?utf-8?B?amlYZlNoTFBpN250NWQ5ZHA5dTA3d3orRlQ0b1ZVaWtGMFpTanBOS3RRTlQ5?=
 =?utf-8?B?ZjN0S0xWMit6TVlBK0xWMkFpY0lDa2h2QmZjZW1BZktrcCt5dHNid2NROW5y?=
 =?utf-8?B?VmlxT3V5VENwa1c5U0hpSGZCVVJWMklSZVUxb1czRkNqdzNJUG5MdHdNalJS?=
 =?utf-8?B?bkdVVDMzYUg5L2NrekFSNkl3M2UrL2pSR2xJWTVhanV1alBzYlJ5MkJuWjBp?=
 =?utf-8?B?bXl2V1lVQ0doOEFCZER5c0s4a24xb3gyeHlFeWFDaWZ1bnNRWEpHKzVMcGFw?=
 =?utf-8?B?eUlIQnBwUGZrNFNoMFkzSDVRYktyMm5ZSTZFUVEyNXVIMU4zdWRaVFM4aFFM?=
 =?utf-8?B?bUYrT2s4Tm1zMDV2emNBbWZPYUNWWEh5M21jQW5QYlNReU9Yd3RZQTNlT0ds?=
 =?utf-8?B?d0pER00xT3JDTG5lZmhZVkNHaHQrYVJTK0YyQ05mUFJXVFdpMGFkV2dTc0cz?=
 =?utf-8?B?K0Q1N3VFMW9NVmV6dEE2TExIb3dwQ0cxenJNaU1NdlRkdUVES0RWQmlHVnQ2?=
 =?utf-8?B?NHN6c3ZCcDR2MHJteStQR0tHeUJweXM1VHQxV25ZNVlmMmVFVWlENEkzZklz?=
 =?utf-8?B?aGd1U0VmM1psMXJSbDZqRTBKYWtJSmJBT1JscjJQWS9YSTdBRzBheUx5ZHJo?=
 =?utf-8?B?SFh4SE5Ob1ZlVG81OW9qVVBZVjN4eW0vS0RDc29rV1pvb3ZubVpJa3paK3hR?=
 =?utf-8?B?V0dJY1hGSmtjcGNzUTkxZGJYdHdEZDRGSmJtQnowK2RjOHd5TDFVdWhtTERw?=
 =?utf-8?B?NVoxTk5uNnVGM2FKN0RqNEF1UHU3TmkxbkdPQjNJQzlPR2pvZ3M5YWY0YmNa?=
 =?utf-8?B?cDRqZnBka3lpTzd1Y0MvWGMwWFhUeWRkdmdNL3I0Sk5oNTBVOFlsNU9UTmQz?=
 =?utf-8?B?WkQvYUFQc1BLa3pjMzVPYTZldXdicTJjcGg1UmxhcThVNUp3TGl5UklMZkVp?=
 =?utf-8?B?SzVPOU1iSk1USWhCak55NTZGRC96R1AvVUkrU0FvZmtEUFhRK1A0V3FHNmgr?=
 =?utf-8?B?S2JIS0dOM2ZUbXMxNm5kVTVLQXcvQ0hxNDFoSlVBYkk1K0VxWFVqYVZtTThm?=
 =?utf-8?B?QTFvb1lYYjNsRWdaNGhOVldkNjV2SXIrcDhsc0tZR080bHdxZzVUY056Z01v?=
 =?utf-8?B?Q2lGa1BzdnNKc2NNdFR6amk2VUg0ajl6cGJKZnJTaU1FaFZoN0VUSWQrd2Jv?=
 =?utf-8?B?V0VOdXpxUXQvOHJ5ZTVOU1NtaTNYTUFlTnB0Y1J5dkR3a0V0QUxNTWs0UlU4?=
 =?utf-8?B?NDlLcmc3Q1lRV3VYSG94YU9neWJkRjFKOXpaR3FmbFVzM3orNWgweEh2LzQw?=
 =?utf-8?B?anpHSG45VE1nUVhtMWVIM2xOZkNmRmpwNy9ybWcrK3h4c2JOT1IvUW56L2hZ?=
 =?utf-8?B?aFB0dVE3Y3k2M2ZJYW9NOW15ZGdGK1hGd1FtNHBLY1B3ZVZ3WnA0dmFBdTM1?=
 =?utf-8?B?bzduRmZpbUxwaTh4YTNqa0ptaVJrMzMzR3lJWFc4azZDdjVnZkZFSEN5WG9t?=
 =?utf-8?B?K3ZDSWtRVUFzdlJGZ1NtV3UrbEpSdm5WWkVLTUZsRE1EcitVcXR5TndaT1g2?=
 =?utf-8?B?ZXYrVFZHM3p1dkhrejR1RDFDS1ZMV2N3c2hReUhuQlhIR2F5R0M2K3BxdEEx?=
 =?utf-8?B?N2pwL0kyVForalhNNjBVMWRiRHFFMUs2MjV5cE03cWZpd2cvNzZOOVQrY2VR?=
 =?utf-8?B?dVJRd2Z6R1NhNzRaZ3VQbkkrVmVRSk8yL1pIRzFVVEE0MUNqcHBQTXRFZ2dn?=
 =?utf-8?B?dU5lSG94bzRiNVJKVnRsb2FlTW00Ny92RmIvV0pZRUV0aTNFbzZ4bldHODlh?=
 =?utf-8?B?eE56ZGY5OVBGZDJaQlJOaFExQ0MzTXBMaitJcUlCV2JXQ0ptR0UrMFg3cHIr?=
 =?utf-8?B?cmVNSnBkcUs4aTJ6ekYyYU5McWJDMDI3ZVRmRkNFcm1sVWJRMTRFdGRXNUhv?=
 =?utf-8?Q?WbNvPap4CvQwgu4a3b6TWBknj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91723d5-dbf7-4301-e38c-08dc984e3190
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 15:14:38.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7zSNIWDvCUKTCsFnyiSSEa6kKYkBav3f6QN0X94+pTPniJIUqyP5Fh0RaMSxRDQM1D8oIvS9LEGGtW8YIYjQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 29 Jun 2024 15:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16350

From: Jan Kiszka <jan.kiszka@siemens.com>

We switched to one job per invocation already in 6bc117569001.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This one now actually passed, except for the preexisting failures of IEC tests:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines

 scripts/submit_lava.sh | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 6bf844bf..7f151697 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -196,25 +196,21 @@ is_device_online () {
 	return 1
 }
 
-# This method is added with the intention to check if all the jobs are valid before submit
-# If even a single definition is found to be invalid, then no job shall be submitted until
-# it is fixed by the maintainer
-validate_jobs () {
-	local ret=0
-	for JOB in "${job_dir}"/*.yml; do
-		# shellcheck disable=2086
-		if lavacli $LAVACLI_ARGS jobs validate "$JOB"; then
-			echo "$JOB is a valid definition"
-			if ! submit_job $JOB; then
-				clean_up
-				exit 1
-			fi
-		else
-			echo "$JOB is not a valid definition"
-			ret=1
+# This method checks if the job is valid before submitting it later on.
+validate_job () {
+	# shellcheck disable=2086
+	local job=$(find "${job_dir}"/*.yml)
+	if lavacli $LAVACLI_ARGS jobs validate "${job}"; then
+		echo "$job is a valid definition"
+		if ! submit_job $job; then
+			clean_up
+			exit 1
 		fi
-	done
-	return $ret
+	else
+		echo "$job is not a valid definition"
+		return 1
+	fi
+	return 0
 }
 
 get_first_xml_attr_value() {
@@ -237,9 +233,10 @@ get_junit_test_results () {
 }
 
 set_up
+
 create_job "$TEST" "$TARGET"
 
-if ! validate_jobs; then
+if ! validate_job; then
 	clean_up
 	exit 1
 fi
-- 
2.43.0

