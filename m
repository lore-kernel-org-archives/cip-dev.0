Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15303.1795517910574560966
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 02:58:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eyO8uOt/;
 spf=pass (domain: siemens.com, ip: 52.101.84.43, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9v0RcMehXWJ+Jj5NovI6znV4vZhsz5uqP2Ms8N1/VEpc0vKZDs8LWUWC9xKB0WKaRZebGu/MkAk7ylCYPQzgbSxdLvH482CyobsE6V3tHTLl3Pss65/eynkCjDJfXwtpbw2GO1jAgyWYOXa/26gsz1Iw9OIAOu5QGcQ5yWBUe8tpKC7PJUIL8nPYYoL5DSVHQzZjlqog4Jyg8J1g9jF0vepm4WzZuZEJ6KY7b/R2B6YMtnYp8MxxWyf69nmIXmX0BBF6PVflsCscTX2iXk4xvPZuqrMDfe1PM5E80jmGZqQr9fXoqiN7YGzKTxHig+M0odQoCVXysomJ6JMa8IRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY6w1BEIq713u8+HouAoLg9xyZQkEn+h2RR/8UuzxuQ=;
 b=n9crpP/eXWeKpqxO/DAoNR4IU6gntEbKEi13a2UaoGzJDrnvhrcDLTPL0XUkgajxO5BdAtbeb69p2mA3YeKKY+49qd8XWey+P/Xy0jwixGmfbgfjg7MSmLRHVIGdBIn1tlkRY4JoTrgcxeBqUmKj9zt2fUop3VphUJGlQUAoWTpOM3XqNCHNbcfwQYYly6MMcIVovWs3H9TeKMwmi/XQ/CZuHE5E72J0uPtUTNKtAvxGsQ+WMhdehpsCOlVE/G5muWpv1KtpVnkNhL27jQVDEzMTMWkDu4/4xi0LMZTuyAvEx2WhFiWwQTmiO7NJmo5oyfTsUiVhxrugWolWcje3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY6w1BEIq713u8+HouAoLg9xyZQkEn+h2RR/8UuzxuQ=;
 b=eyO8uOt/OhdePR1JZ3040MnmltXUyxzCxBo7YXq3IA+h3gXax53bmNSIgPYr12R9BtZRcRqccsJ1uPNrA5MbO+ASUhC8W94XQ2NCAvFTpiODOO4scexHGp2GDMNMufTNXq1q099nKWOJUvgApy5rYOxxZzuNKoLeeUXMGwSsiuTXNrDCi9mNdZaFceN0YMYaL68nHfd6pnmlFWV2bCnXmcOJnrzCYNfvM2kwcdgjG5RCdQtrUy04QcLv6/Rz5w0En66n8ckQsaI/av7JKXNbHpvqJtFRIixIwDiwZ8IU2xESZ34r7TWgB84MGzYwqg2Bh2eGdmjFPE+VtdoYelyIig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9)
 by DU4PR10MB8445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 10:58:24 +0000
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7]) by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7%6]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 10:58:24 +0000
Message-ID: <b62df3a5-fc1a-4fbd-a81b-0ffe38d8d854@siemens.com>
Date: Tue, 24 Nov 2026 11:58:24 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cip-dev@lists.cip-project.org
From: Christoph Steiger <christoph.steiger@siemens.com>
Subject: Kernel Vulnerability Triaging and SBOMs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cf::9)
Return-Path: christoph.steiger@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR10MB9423:EE_|DU4PR10MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 80aca15c-51e8-4d42-cb1a-08df4a19dca9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003|261026121527099003|261026140227099003|11063799006|56012099006|10067099003|18002099003|6133799003|55112099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Rv8YbgTvPUHQtVGHvOj5I/YSxorMR8I0oeB4ReJhuY7tVw7AUwdZ3+NXkoAvq4gJV13BUSWdJS2tY5wK8XhILufDbfW50Qw7+w3y+r0B8DXTrsm2ZIqWfC/MqTmF93sWKBh6ubeHSRviGt6Ss0VyRQ4kX/lSzMi84QpUv3ic92MXUBozF9p8GzN2/kh60lDi41Rs+VNLQMuoVe0ncle/wZoCsFppejS10oBMTZ5PuzgpRb6aSaayJxYJr6nGCQ+fBGZP0dZyoM2mGqGGiqBTf+4Rjg05N/2OJltldOD0cNGQ2Kuxv2mt8CF3uZb7iZ86AUquftd9cKWtM5elJ3h1K30pXLcrw+UzGE+oDvN3sbLtQlF4oetcCpAiDvKD10+8ohSAgjNlHf7vmZPi95S/HDCtASGIN7a72TG9DtQCC+aRP21AnkeWerOaQ7+QxYzvDGGBbv2aGItJjdMaK8rkOEjlFjhcGNz4isnVJqKAMihP9tjOWJdhrVMpQlqqvDkAL+HpdShSGFq3kM2JNjE/opp+PJP+i74/NreCE2LluOjaTjT5RPJatsHgQJw3s+LR4wzdcybn0AdztiSvdP2SN5Aj2mWDRHtLti63F/rA/KI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026121527099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003)(55112099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJjZzhqdVNkZnVNNFVtZzhWenNXY0tFcjA2bXp1V1M2NHBiMk5NdVo5bHFD?=
 =?utf-8?B?VDN3NU1pZ2pIa2VsY2lBSkhuMHF6WnNYODhqZ0I1Rms0SHM4eGwyUHhqcHVH?=
 =?utf-8?B?SitOY1RkaEhLNzN6akQ2VDJyV3FxUVJKQXJzWkZIRmcvU0VPZXhlNXovZlJt?=
 =?utf-8?B?SHNKV3ZYcnlFUXEvZ09GUUVOdURkVU9EcVptRUFjL1k5bXh4UWxxdzdxKzhy?=
 =?utf-8?B?bFJJUHJUeUh4QTRFMFVjU0kwRURwa0FLT2ZhbEFkSW8yeU9ZY0o3cjN4YmNR?=
 =?utf-8?B?bnlnQkQ2Yy9WU04zVEdzMkVDbGV0QUlnSWNDbDdaUXQ0YTByOFhWaDdTc21F?=
 =?utf-8?B?S0x6bkFpVDRZUFdIUUtOUk5CNkw3VUpkM05zYVFMNjUrL2JEbnJXc2VNbENV?=
 =?utf-8?B?cDBkZ3JhUXAxWHhEU2JaK0pMNnYxTFdkVVRCa25Ic09ZRHYvSUN2VGR2bEU4?=
 =?utf-8?B?WExTOTdpMnNHWmozNWdNWmpHTS83Um9mdGtsNnhyTzRyMlZ6RzBHSy9lMDY4?=
 =?utf-8?B?ekhUUGJSN2dGM3l3bzVBcnU1d2pSYWRwcVBEdU5oaU9UNkhPeE1BRGhIZlRP?=
 =?utf-8?B?Nk1pWlQrZHYyTXhxV1h3TEQwYmZXaG4wR2s1YVNjdU1qaFpZS1U1ZjVIeDEr?=
 =?utf-8?B?VTl2TXArbXhydjV3SXVHVVVvQU9qWUd3SzRZNUlGVndXTU5XcWhVeG9xMy9K?=
 =?utf-8?B?SlNFNEcxUnlFSFl4RmJQb2llaHBrTVV2MzFUVUhrNTJEWG1YYzlobFdXKy84?=
 =?utf-8?B?TE9XVzlMV090UGNIN3BpOCt4dVJQS1ZSbHNEM0FicmZxbkdjd2hDeUFQK3JG?=
 =?utf-8?B?S2NTYjl2OUF0REhsTUVzMEx4R0xDUEFQMGVXRU5jaitVblZwN0FGb2tHbEdN?=
 =?utf-8?B?Rmh1NmJCOXlJa09tUE82aHBDR21DMDR6YjdPRWpET1VTK0V4UUVoWDRFRWQv?=
 =?utf-8?B?OWplcjkxSTNoakxGSVNJQmxnbDhWeTZFQkZXM2ZUVHJPci9PWCtRc1RQMEti?=
 =?utf-8?B?M083Y0dNaGdxa1JITlBqalhUVkx0M0xBYU5yUktEb1B4N0NjblNEUlFQazZM?=
 =?utf-8?B?SUdOSThPakE4SUtVVFYzcW9IUXRlZTNreTN4SFFqWXlLZTlzVGZsTjBINWo0?=
 =?utf-8?B?WDF1NlhyM0cxNHZTRUFORERxRWIzQ2phOHF0SldjSHJya0NyU29wclU1UXlL?=
 =?utf-8?B?d1hibUF4WHozdXNNVkJqQkFDZVNyZXNsR21YMG5hcVBLamRxRUlFUWk1SVpz?=
 =?utf-8?B?bzJlZ3AwTTNabEV0OUtxc1RnTUJtQjV2MXVSRVFiYk9pTmFDSisxRnBrU2JJ?=
 =?utf-8?B?eURsZS8xZUV2NFZjYmNuWmNPMm5xN1dYTVhzLzJ4VWlFN0ZOSnZ3WWR4RThu?=
 =?utf-8?B?Vkxybng0RG5vSEttMjZ1aFFUaG5PcUdxZkRZdmxwUkFDQ0xQMUZZNVozR3F6?=
 =?utf-8?B?S28zTFMySWxEWjhvQytqbXdqbUNuc0pPZ09yMXBJUHpyQTdxS0VXSHZ1aXR2?=
 =?utf-8?B?Mk1vQUVmaDJoeFoxQ3VvaEdlNFpkbWwwSXB2MUF2NmtIelJ1TjN0S0hGY01K?=
 =?utf-8?B?QkcxWk9EVVlsTUxZcUMvQXdweWNKVDVWdGxpYXphSHNENHlTVHRoY3FIUlhx?=
 =?utf-8?B?WlFPZklXc01IVnNZcHVyOTFNR1pGQ1lVWktXMWdNVTNVR3VPMUxQY05JV2xm?=
 =?utf-8?B?MWRnVm1oR3dHN3VqemJPWk1uM3hReEVqZ3hMeWFiSHVodHlmOG0rNlpiYUda?=
 =?utf-8?B?dlFNQWZ2bzEvMUwwWXBESU1lSGh2dWJPL2F3NUprVFJuVDVwMGc5TnFnTzBT?=
 =?utf-8?B?cklPZkY3Q3BvM2p0dHZRdzJHVjBEdHU5bEpGR2xJYTdjOFl4alVYK29QWlgx?=
 =?utf-8?B?cFRPOEVNdVBzUVFRSk9WQjZEMldHZXJ3NXlSb1dTTWc3K09XZ1dzZGltLzNh?=
 =?utf-8?B?bW0zbmhhalUyT1AxeEN3cVZ4M2dOOWhkQ1FIdjdHQ3FpdGNrVU52WVhUZUZ5?=
 =?utf-8?B?OG5QWjlwd2x0elFVeUMycDBDd1lpTGZna3pxVEM4UTdHUXVsSE54a0VqR21N?=
 =?utf-8?B?WmllZmdoSGgrLzlHRUhtWldRSVJrNFlMM0RHVjVZM3c5Y2hsT2VyMTYvakxw?=
 =?utf-8?B?cmNkZ1hNVmw2eDNQSnBGNzlCR041QmtwbEVVYUtsK01QSzR2MFJEdHNoblg5?=
 =?utf-8?B?c3JCNHg4anppUUFGTElPdm1BSVJMUGVPb3hOM2ZTa3JYYUthWUk0aFJmNDNo?=
 =?utf-8?B?cktXamxaVmRXLzFJSTludm1MVWM5ZzBDMnhhNGRqQVVPbmt6ODVQVkxCdC9K?=
 =?utf-8?B?RFdKK1A2aHIzNUdXQ1dWKzQyUTg2UGo5dkd1bU5hckdPc2JORjNwWXFIOGVI?=
 =?utf-8?Q?W4i4y+dgXvSObANs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aca15c-51e8-4d42-cb1a-08df4a19dca9
X-MS-Exchange-CrossTenant-AuthSource: AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 10:58:24.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8pxWFQV16ImSatgEMIzoXTPq0whLeqQ4dIU/Ju+gZhy3iCSL3XKqVMRIMOhrkUZiBuVilZ99PnY4aQTKwEte8UuXKcG2oXhqQnTtS1lSro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8445
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 10:58:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25057

Hi all,

as we all know too well kernel security has become a huge topic in the 
last years. Triaging vulnerabilities has also become a necessity for 
every user, and CIP already provides a central place for vulnerability 
reports [1] and tooling to triage vulnerabilities [2].

Other ecosystems have also developed solutions, famously yocto provides 
kernel SBOMs and tooling now that help deal with the huge number of CVEs 
[3]. Recently the kernel team has also introduced native SBOM support 
[4], available since v7.2.

The general ecosystem seems to move in the direction of kernel SBOMs, 
both for compliance reasons and for easy triaging. Kernel SBOMs, as 
provided by both yocto and the kernel itself now, together with 
vulnerabilities from vulns.git (with the affected file information) make 
it very easy to triage your CVEs, without requiring much additional 
tooling on the user side. I expect that we will see further focus on 
this SBOM centric approach. This is also pushed by the kernel security team.

I think it would be a good idea for CIP to also follow this approach. 
This would give us kernel SBOMs, easy triaging and access to all tools 
developed for yocto and the mainline kernel.

For this, the following things need to be done:
1. Backport the SBOM series into our SLTS kernels
    This should be pretty easy except for the v4.19 version, as some 
prerequisites are missing there. The series consists of around 15 
patches, but is solely confined to the scripts/sbom directory.
2. Generate kernel SBOMs with isar-cip-core
    This requires some changes in isar itself, as the CIP kernels are 
built with isar infrastructure.
3. Integrate affected file information into cip-kernel-sec
    Currently the vulnerability reporting done in cip-kernel-sec does 
not include the affected file information provided by the CVEs in 
vulns.git. I think this would be a generally good thing to have.

I already have a basic PoC where I backported the SBOM series to the 
v6.12.111-cip32 kernel and did some quick-and-dirty integration into 
isar and isar-cip-core. With that you can build a linux-sboms package 
that contains the kernel SBOMs. Let me know if you would be interested 
to have a look at it, and I will clean it up a little and post it here.

Please let me know what you think of the ideas I outlined here.

[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec
[2] https://gitlab.com/cip-project/cip-kernel/kernel-cve-triage
[3] 
https://docs.yoctoproject.org/security-manual/vulnerabilities.html#linux-kernel-vulnerabilities
[4] https://docs.kernel.org/tools/sbom/sbom.html

Best regards,
Christoph
-- 
Siemens AG, Foundational Technologies
Linux Expert Center

