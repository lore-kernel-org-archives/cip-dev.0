Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71C3C38150
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 15:36:58 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.82])
 by mx.groups.io with SMTP id smtpd.web10.19605.1720193814512531162
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 08:36:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I4sFBs9s;
 spf=pass (domain: siemens.com, ip: 40.107.22.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwayctRCsm44aPf08ixvPCmF6TPENeEd8uC1wncgquWgdUdmS34uSbI2jBZdg60wtyBTxQQ9USI9yHS0G18rzADRcvEgKrVgXy4bruz/G7PV57twQL6CmJWwukdhf46x2qvyzb6ZHd2EmnZIvoG+VmsDSvFXFX/oRVOsDnLEM7Bm6Twc6vH9R+7LzLISRZFZktNJzD6f4PxAmhzpnnC69+dNgagfzxYaDUAHMJP/rKNZL9ZoZI68WJ5ZmC7TqyK3qda16sDNAL5bTRaaw171QC1D0DvemP58dX+Ba7XehfizO/00VwlwUL7NyQ8VAZ+i+FQ72wKR7RPPvOWqCt/fzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNxNY03P9ln2lh4ZdRkbT/whDKcjrZBhmv6nYXfriy0=;
 b=FPIVlwDxzuiu4QPxnedmEcEl6GaNz0HOPdB+zs8wnGXB4eQhTqxmUR5QSr3sLJdatm63eqm2ZNlk6IaBOhJn8CYho9qvMBKYZ+YL8v3r5+KAEU8U6OhkoY60f3ijc4hLz5161EMbQbc8XPUeCrT1QOO7p51BrYMy168FFrbUjkRInFsc3JTAgqBrA955bRJP1jLEY8vJaKrKa9klHCv+edI6ld/0l7lNMS8ow22ul2YhzFA2Rj2enucE1WoPVyzLLKNKzJO10trUYwHC95f97XIGe+icMMbOEoD9Rbg1QB1KxQEu/LJ+5hmMFoYgYxHprkwgZlFpM4F+92u8NGxfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNxNY03P9ln2lh4ZdRkbT/whDKcjrZBhmv6nYXfriy0=;
 b=I4sFBs9s7xVNgrsC+/+HzWahp3q2tqAdjv7Uh6YtJzVTCp3NkV78p+OB4kutlQxkgCGlf7Rnx2ILcj9YkhmbnyeqHgf4KF+prtD/PsVAzAzmBo76nLfkCG40xOSglTMZazMmJPxNHAYjLdWJKD6OgI0fn2hph+C16lpeH8kEGvZ91CaDkNkeY+pB8e6B7Ae25KxU+rTMF7Hy3qOfYMGOq7EcvmZCrS51RVZs+sP9z6LogeWbHjr58WZMF1fvcuxGnVt9ZQ6TqAhmfA0Q8tIctHEiN3eXYa4Gq0Bxj/schGUxCTnzG/2dzbrwN05yTQ0vuD4DoX0TWjVnlDDaVTGR9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 15:36:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:36:51 +0000
Message-ID: <88ef7317-8ae1-4a8d-b7d3-150e66a5d5a9@siemens.com>
Date: Fri, 5 Jul 2024 17:36:48 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH 2/3] tests: Pin revision of cip-security-tests
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
References: <0f90dc2b-227a-42fd-964e-4086d00e9694@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0f90dc2b-227a-42fd-964e-4086d00e9694@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce75882-4750-46e8-4afd-08dc9d084a7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RXhvSUk3YzZzU1JhS2ZvV2hRekhYdndFRktWWUlDT09NSmJ2cW9pUnpzNGhP?=
 =?utf-8?B?ajBKNVRBQ1NFUnZWSUVWUkZxemR0c1czWTFOdEJYQVhHMkxyWHM3dnU3WGdP?=
 =?utf-8?B?RG51bEJ1QXpLQVRybkFHY09xQnd5MmwvakRGemJCUTFsNXhuL0UzWVRDcnRn?=
 =?utf-8?B?aXRyTjJ4c3pOV2lQV1F3RmNDSVZmQlU2d0REY0ljTGpxTm5iMlMrc092ZWJG?=
 =?utf-8?B?eGM3YWlNajRqelBoZklxM2p4d2h4OU9xU3BMbFB0R0pYd2VpVE1ObVNjaFpp?=
 =?utf-8?B?WWowQ1BMM0I5ZWVLM0ZteXNVNUxVcytqekhvRXV2WS9LdDZCRms0dlFSYlVE?=
 =?utf-8?B?RFRtdVR5Y2JKQkdLTFFtT3RIQ0wwN2oweHoxclk5eFVtOGtXTlFVTFFzVUJG?=
 =?utf-8?B?aHZJVHVZQktKSGI1SkZvbFp2bzNabWVKV1RVUG03YnNQQ0doSEpTRTUrOXJ3?=
 =?utf-8?B?V1dxcUZrdDZkMDQzaGRpbytLcm1rSmJrNzduQmJSRlMvODZVbUY1cUdqY3lq?=
 =?utf-8?B?SnBPb3JnRXlYZDc4cSsxcWRobWR2MklCUVBWY0FWbXN0RFlCZEFjeU1qbm9P?=
 =?utf-8?B?MnhXZjdtVzRNKzF6YXhnUTZWeVh0RkFZVmdjTTVqS3lhNjcxbnlsbUU2dlhi?=
 =?utf-8?B?WkxjS3JzY0ZHbDZpOHdTZWdaaHdTV2JLUVJ2SERpNE5uN0pBK2I3OGRlMjAy?=
 =?utf-8?B?UjhKclBDK29mb00wK0NHZjNXQlU2MXhLb01KWTdOVHZVaytIK09xMi9rbVVE?=
 =?utf-8?B?ZlJUUmFYY0lzbVorY3VVWmg4VEQwSmt5OVpOeGZiVWVnNlNxVTZ6bDJKeGNz?=
 =?utf-8?B?VmhOdWVMVis3ZVpBcU1qelhrS1BOUWJGelp0bHdxbE02cEErUGtRY2NUVHBB?=
 =?utf-8?B?eGxRK1hOeHBRYnlUeGVCd3o1L1AzTU5pdHB1ZnBrWlVRaWZDa0JyVThBU0Ja?=
 =?utf-8?B?TEtydzN2TzU1VzVNc1NHWFZQSFAyc1pNRUZ5OFpjT1Z3M1ZKeHVKeUUwSm9O?=
 =?utf-8?B?RW9teDV5YUJhbjliM1ZIUUVrTzdpa1pjV2pNMk51d0pqdFNmdFNIdkhISkg5?=
 =?utf-8?B?OFVJTlJmelJDZ3Y5bGpHZW9INndPcG5ZUmRUaVpXajNtWVV1WHVhdHFWK0pQ?=
 =?utf-8?B?Um9KMnE2STdXbEZkZTZpVDNyaVBNNUkxTm5LWUx1a2pjVVZEVmFnc3F2V2I5?=
 =?utf-8?B?QklBaXgvazJhTGRNdzNzR3pSd0RFUDJkZGhyY3lBZlVteFB0YVNnTWlvT0pE?=
 =?utf-8?B?MmRHelFnRXZ5TERMOUFKbjZMc1NDT0o4eC9vTlF3Rm1BK3RxNklkNjRpMXZl?=
 =?utf-8?B?ZlZJZmY3aExhMlIwMUxjYW5vL3RkMFU1dVVNVnh5Q29uOHA5REFiZjEwaUtt?=
 =?utf-8?B?S3dCL0wyamwxcmQrcTZZS1FWV0U1ODFzVHk2VWxvbTdLVGIxVUI1eFl2WS9G?=
 =?utf-8?B?NXBmWCtiMEFGRUFDbS9CblZHc2lLVW1QaG04b2RtL0EyR2t0aEVZaWhRaTdp?=
 =?utf-8?B?ZDZmSVBuSC9BaFFPbGEvRVUrcXRyNVZnVFRERFJIaHhlYVNvVjBMK1RWa3dG?=
 =?utf-8?B?U0oyWkcyNjU5NDFyU1hlQStFK2JjNWNVa2hEeWt6bXIvZGRuU05YNGJHaElx?=
 =?utf-8?B?d1Irek1NRjZLTTVSVjBCNHJYY1BsQUFuUWVUcU9WMDFpbkVCSWhnUEVxMFRV?=
 =?utf-8?B?RWtQUEVLeHhuRzVTdW9BZ2pOYWNyTnd4a2JWUURVZXRYMG5ab1FoVi9KbU9C?=
 =?utf-8?Q?x7lh9wBGS8pUpts63c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dDYrd2NiOERva3VBWUNiNUhUbjMrNW5vdHA2bGw5QXpQc0ptTGJxOFB0Z0NU?=
 =?utf-8?B?QWtUOG9haDVpNW02V0k3Z1ZTMlpLemVpUUlRYmhIcTkwSUsrTXZ5azdWd3lK?=
 =?utf-8?B?QzVuN2FBWWU4azZkSUlSQWNUN1d4YUhlM3NITnhDbEZXQkFmZ091dzhCdHZK?=
 =?utf-8?B?ek1ySzhIUUxIRTVMMU9KMFdRWEFUN2NFLzdnNERUWno1Nnl1NmQvbENRcEFN?=
 =?utf-8?B?V3M5dFhIV0hpOU03U1NIWHZ0eCtJajF6Y0J1S0VMSHd3bTJ6TVNSb2hRK04v?=
 =?utf-8?B?TGdnY1dyTkYwV0hBeVhNNkxlcGR0Uk9CSzhnTjZONkhUZUFaSmtFNEVYelFR?=
 =?utf-8?B?Rk5OTmZkVkd0cDlaa3ZZTDhVUXlaNkNLSnRsZWR2VTBpQTFHdzdlbkg3ZVQy?=
 =?utf-8?B?MS9EREhGRllNYVJJTTF0N0pwMUxRVWlydHdRTWUxUVgycmJ1SzBNR2g5RWZr?=
 =?utf-8?B?WktocnZQSFhoRXg4VXlGMVBqWTZHZGxwdUo3S3pDalpSS1diVE12TFFxY1do?=
 =?utf-8?B?bk5QMjZhTnRUZWRmTDRXaXM5eFBZaWZKT3YzNUo3VWhHTFNrMnFIZFJCdGZu?=
 =?utf-8?B?RzFPajA4S1pxbndHMTFISnZqV0toQ2JQakhvYTVjOVNqY2xRMGl2MGRURWJP?=
 =?utf-8?B?TmpLYW5yc0Jmc2ZvQ2JKeURpRXhid0JNTTJGdXRLZUFoNUZTTnhMdEZFUjJD?=
 =?utf-8?B?SXBCS0FlUWV4cWJMN0x6YnVhSHJpR0d4bFVzQkRlU3Fod25pTDd1WmRPRGlm?=
 =?utf-8?B?VWVENHc4QlFnK0xGUUJPdGxWT3NodGxsQ0pLNldOcStHWkltZnFiSkRIT0ZB?=
 =?utf-8?B?OXVTRUtsSGMwZW1UZGJTTXhRc1lneDZYSndkV3dyakJIcDBDNUx3Qk8xS3k3?=
 =?utf-8?B?RDVtWE1UVkhpTG9QaUdsZlVidHlhUVJPKzhzU2JuZGRzbXVOQ3pOQUNsUnNr?=
 =?utf-8?B?dXA2MVZIR2ZqUnVYS3AyNHROK0tYeG1jdkQ3R2UyV1IwVEtaL3lCcFp1ekRw?=
 =?utf-8?B?bjFNYzlaV0tlcXh2dnFtWm9yY240dWlqLzBHTWdqUEZDRnUzQjJTWDVOeCto?=
 =?utf-8?B?ZnREQmMyWGVUSjFPdWV2bllUZUJCcm9lbkxQSDAydm00NXRrTE1jZC80Q3Bo?=
 =?utf-8?B?OEFZZk9ubFlrYW5LellCUjIrQXJwZWp3cnhvRThUQXZuV2p6YU0zTUhwaEhy?=
 =?utf-8?B?cmtsZ000SzMwWTBKdkN4RUNWbGtXMmZJUitVMzNPT01xbkkzcVJWb010R2tT?=
 =?utf-8?B?dzErOGNkdVZRYjFYTEtzQ3dVZFc4NDRCTDFJQ055UzhmQkg1aXVWZmlnOFh6?=
 =?utf-8?B?cDFvSFpZTnM0dWh1VDZrQ0FTQkxQcVdMbE9uM2k0N0ZnOTJnZDQvbW9ZU2hq?=
 =?utf-8?B?NTI2VjAyZ0hDSFFtQkFGUWFNT29seE1jak9pcmNkOFpJK2doV1R5T21SNGdD?=
 =?utf-8?B?QnlETksxZkZldUN0Wm5FK3BjcEIyYklMZVFVTUtUNUFDVHlUbXVJVWd3T25E?=
 =?utf-8?B?anN0M2FyQVUwWnZPWjVOazd2RXN0bnJzSGdBMlZXV1ozV2laY1hmb0NhZ092?=
 =?utf-8?B?QVdIRmlVY2pvUGtBam8wUkg3VCtqMFVqTHZtWk1ScDJFMkl2N0dZZTJBZGlB?=
 =?utf-8?B?NXlpTWVXUFV4eTNyeW8wVjFsdVpCVVRva2x3dUNTQURxY21rOUhKODNjMVYv?=
 =?utf-8?B?c0xUampOL282ZkdRbTRHM0VSUG9IWElJTnNtQlZXcUVpZUtxODVkNmtSeVpT?=
 =?utf-8?B?ZDh6M3BiTHI0OTNXMDBMeHNhZ08waWkyaTA0dHV0U2VaakZOTkFWNFpLaWdx?=
 =?utf-8?B?Wkowc3JCNE5MU3gvbUxSTHNraVhiMTdZZ2RTM2dVeEovbG5qMEJ3L2ZCUWpF?=
 =?utf-8?B?ZGJ5NkYzejVId1c0QlhFU0QydXVYR2lvQzVvZ3RRMEhHbHFkNk9VVTRQVDBM?=
 =?utf-8?B?M054YVlKVEdhVU5KTmxJNDRabmJqTFFNWnRmRHYxZkYvN0ZHWjRrK2s1bWty?=
 =?utf-8?B?MGs3WFp2anQxc2I2a1MrU05Ueklpc1Yxbm1hRm9EZHNBTVZZM0E3Wkg3NUtR?=
 =?utf-8?B?QmJRSkxkUnRpZHV5VmlSRjlsZm1oK1dhMjVxSG4ybTZkdHJIWFpjRVZiMnV5?=
 =?utf-8?B?R1d4RmgrZmprN1FISDJVeHlIcGc5bWtOYWVuNEpCYXZtRkQzbWlJNlV2UjVi?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce75882-4750-46e8-4afd-08dc9d084a7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:36:51.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXY7g/3w9Q0rA3cTPgmiaaVYOT6UoGWJH+op1kD4+RQKkJFai3qZ7Hr29aPHw8UxZOTPRTOtlb138iVCc7IMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 15:36:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16420

From: Jan Kiszka <jan.kiszka@siemens.com>

This avoids surprised on the isar-cip-core side when the test cases
change and suddenly fail for some reason.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index 092af455..1d467913 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-       branch: master
+       revision: 07021c3b7455ed354a00f4de0f1a7267788c414a
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases
 
-- 
2.43.0

