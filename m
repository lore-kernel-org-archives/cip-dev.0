Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3AC5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 11:23:25 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27414.1786361004328439995
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 04:23:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jXQmeQ7N;
 spf=pass (domain: siemens.com, ip: 40.107.130.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEXPnutbuBgzJis8f5hIXPUQn0z3Vb3xoyJL+1L1RT7p0YmhaGY2GCwB5bIbjWxVzTPKYItCVa4KbzFe1nLqASqQ/yJN+wgX01Nt5MqjFJbmfRsjgMT+dodDxX/lYdYEcz5x8gVy4+8Ez8SaKr5hZMVWsaWllzK1vdVCBOvYqUzKe6eh4n9aG6b7q4M4O1ikYrwabo90BjvhtpJVzW0bzGEYy2NZnnPz87+aEMACJgYSMKw8ZKcqxaDlbtNz6xt+LJGv29p3Tx1ZsCD5/thH2An78wIoTOUHhhUwzGwg8orOzVUwee7YCkCyupz3KABhilp0z2qnbks47ExXkfN0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOCrXd12yivCgQrPa6ZtZa2RlsCwnx1c2e/QnEvANHE=;
 b=DZUEusH8qgShQ6dxsFBr7hBdoUIKGRFMD7mpGZWCKitlrP/cv9rrANuD434R08O6KYsHn0Ll2aFR0b1qoYsZucRtOPr0unOdOF3iZzKIaQNtQ2ETPFwr+IlCaQZRhInzQpHsVcfWXqtK/MjG/C9Uy3v3YwacrrvcOChHTJwMcNT8worGa7AwpkG0ih8c8ytMQkTUSyKNk7kptBPq1TKRk4K7gKy22kAEQCyCGK//s66ixhQ4b4IceIQm1fzM4rvOnlNkkH7zG+GsJRAhShUJ0sHC04xaQpkQLW4CxdYyI8I6UAsQrTbpv27UxCg84FL6L03Ri/kpoGrAVHEeds5tAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOCrXd12yivCgQrPa6ZtZa2RlsCwnx1c2e/QnEvANHE=;
 b=jXQmeQ7NcmFt5Y/dAsHdWBnSmkOlph2xNRh0Iu0Q5ne+XnzyIwrVaRZ6ZApTQW0BnWiYidowoHq4LyMTg5YYp/if0FQifJoQYmd7IhqGADIKHsdJ0cKgc1vgWOmyAv/DyMidkK934yE0MdNKD1pWoDFdPfo64m+QRN8+5ZvIOVGazWYLhjL9b7LkUEVSZTHDsAfwAH9ZppnR8duTbXJCR1tSdq2y/41V6z65Ak8dqkQx2Gb6bO+avhdhMD/lv8+ryOsvWPlg/n7FyglW5BMBMr4JUloO5A+gFIKWnUpocQsr5nZCYCBtTzcqbUCFtxYzdZaKoIgp/kdjSC1aKVzFRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:23:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 11:23:19 +0000
Message-ID: <5d9fc6b2-b2fe-47ea-90c1-25d9d6863e95@siemens.com>
Date: Mon, 10 Aug 2026 13:23:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v3] update README.md for rootless build
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: ea12c402-323a-416a-99a1-08def6d1c7e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|20052099010|55112099003;
X-Microsoft-Antispam-Message-Info: 
	tt1oqJSCUSagDEYpETMH+hWdQD1GmhegKiYa0gGckD0lREFxBMt9ArjEmkJNOVxqgUwByh7rwrSh+FparehXfVtES3LpTrAJOEunoGb4LZ1J1d6LkExjjUuDK+8TlJM5fvTXv118Rqzmmo6BA2+Y3/QIGScc6855ja8tKM/QfvY2VZ4dDURu9TFtRFQnX3sx9wRKNsS+rw5YWhvylBOylVXmw2t2d23SmuCiz5RmXz27G/BnyYRY98U1VK5+mypLCwAw485wT+swfo2DPZrIk6navXVXcBdIklDXvkElp0Rn6ee2Pe9mV5a8YffhTYi7Ku0MdRtIQeY2o01590oDMABneeIJMik2+/DxOshFcBQG0z2V7+2Rxe8CBGkHaFbFL7Q1rF6x+bJvP7g4s6KlJD43lFR0DRYTUqfxHg6brTnT7hAbeykvmEPoYeY1cHgzlIPNlz26Eawhls/m1piA64NWmFgQtgADjaoOtFLdvJ1lnIZzaRrZA5iu3vVLQPEe9O/YRCvl6QH5665J744DlbyzeaaK1iE68ExLULCeZDKWKNfIuXBuhOouonlQnLLoaWRoCxfHkMYYrnKTG6ktWTDo4AmbKki7fWLJr4UaKyGogWs9/f412cqgHhLJtmOvUf4cRUMIs6n/gOwiKSOfi8cea30rIzHDfVVtyJqRE34=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(20052099010)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTNkdm1KeE5HUWZ4bkR4NFpUbk54TFFIeHV2NFFHcGlIRUFuQXZiNXZqMWhw?=
 =?utf-8?B?MHlLZE9qT1c3RzhVWGJBbnBNdHRFblZOMGdLdnJQKys2Y3NRYk1XYnhocEN6?=
 =?utf-8?B?K09FNTNOSFhHVFhDYVFkOHBTQkdndTEyRzhNUENuMlV3UEdDNmcyQ3JTaVpI?=
 =?utf-8?B?dHdqQmkrK2puc1VDNXVLN3RnbTBMYkVWUnBqSkhJdVV2blBGbURhSGxlR1Iy?=
 =?utf-8?B?ZUU3aGRzSVBnL1FVU3NRWGFyK29CNmVpMlVTdjJkcU8wWlNCUEt2dE1QTm5M?=
 =?utf-8?B?SC9IYll0TVdRZ1A0VmRhaGhRcHVoN20xcTBlWGd0NHhFUDRlYVIzTWViUXo4?=
 =?utf-8?B?TXlna1ZFdHVKVFY0TlB2dGg0SUpBM29NeklPU2RKSFQ3VllCVWkreTQ3eXZt?=
 =?utf-8?B?UnpTZy9LejhSak1vS2FCSTcvVmtmRWNzMWtGdjFhNEYxbVBuS3FieWEzVDZN?=
 =?utf-8?B?REF3TmV4ZTZXRE8vTWVINWJ5VnJWcm5pQlNxSDUzUHlNbHI3TzhIZWg3MCti?=
 =?utf-8?B?SXdhOWpnK0F6cEZmQlVCcUpCM3pSUE5jTTAySVBOa20yZVh6aHJFUWQzbEps?=
 =?utf-8?B?ZEJFMkpraHpnRXlOdUxtTG9oejgyK3dTYTBNOVpadGE0SWdQUHkwWGJsTzM0?=
 =?utf-8?B?NTF4KzdJOTZCSUlFdndXYmJvWmpoTTZtKzdISzlyVW5Lc0FnN1cyOU9EbHRO?=
 =?utf-8?B?SE5OL284d3lxWHhYMVRrRjN0Qzg5Zm5DcXBhVFRsMzNuQ0J3elFpZHEwQXBw?=
 =?utf-8?B?Mit6R0RlbkwyNzM1RHhyc1dMNTFUUklIY2xLTWVVS2tTeCtJUllZQW53Vk1h?=
 =?utf-8?B?VnMzK1JvM0lpZXd6YmF5ZnJab2FCRW5ET0FxVkhhTWxmSEkvblpiZ09BMk1k?=
 =?utf-8?B?SHlBUHpqQ2lONDd6bGIyeHZuZ0hYRDdxVFhtOENqMnRUMEI4ZlQ1cytrUmhr?=
 =?utf-8?B?MFlZQ01tRk4wclB5UzRhNm1PSzBneVlldHV4dVBEaEhxa3FsRlpVZU9JZ3c0?=
 =?utf-8?B?VmhxVDRPQ2l3dDcvWEtiVGJBMVMxWTlpQ2xpSWQ4QUlxa0tYMmxDUDRZWXp6?=
 =?utf-8?B?OG5EWG4vSVJTZFRsMVBRU2lQcHRmU1R6S1ArdHZpQUd2RWlGZHI2VWdIUXZH?=
 =?utf-8?B?V0ZWeDFKY3FhczNmbDVCL1lTY3YwL2d2K2ZzOE80WDhlTkovdGlUeFo3dW1L?=
 =?utf-8?B?SzdjWGVSTTdSNVZJZU1wTU8wdk5MLzdxOStESU43OVl6T1hkelcrY3Myd01l?=
 =?utf-8?B?SFR0WEU3QnZNbUN3OVZTcGo5UTByamE3bXJLWnBWVTJreXlNMUtJeUZObXVh?=
 =?utf-8?B?ejZiMnVTR2tnTWpuL1luNEpTK1B4cytoWDVjWnNIL0YycitkSGNIckVmQmxm?=
 =?utf-8?B?TlF5Y2hVZURJSjF6Y2drTGxkNFJvc1hGSkNtVlZlR0xhSUJpRTBMdHA1akNu?=
 =?utf-8?B?N2VrNTBQMmR5US9KNzNGL1VvRkxNY0YrMUl6RHlSekJXYSszOWhLMWM4RFQ0?=
 =?utf-8?B?dkVxRHozRVZzaXc0eW5ySGpQNlIzMEdyTUI2eUwya25LeW1oVEIvc1o1VFpG?=
 =?utf-8?B?anZxWVFPZHBTVjNlRjVSYWtLSmgrZU1saE44cFExRGxCeTNvdjNWM1A1N1B1?=
 =?utf-8?B?SDhHWXFsZmMyRC9sZjRlSlVFVzNYV1NaNXZPZGVtS01NQXZ0WEF2cHdkK0NJ?=
 =?utf-8?B?aVV5NzJXdEZBZ0NPOWVFdmdTRmJIMkdIWDVPdTF2SWh2cWFScGlLUFdOcVg5?=
 =?utf-8?B?MS92UkFsTkd1ZHlYZGJ4N29CQXlRUDFFODh1d0Zpckl4TTJBamF0OHJrdUZR?=
 =?utf-8?B?UkcvNW9Ib0hHak5EVjA0NDRGUlFaUHRWQ0c2dU03YlpwWWVHaGxUbWdHZzhI?=
 =?utf-8?B?dWE4YWw5bHNNSG9tS05KUVJGNFlGb2E3N3ZNKzZIMjM2WUZqUUo3ZUhBQmVy?=
 =?utf-8?B?YTY5R1VORFN1UFEwQnQ4YUI4aU9iMzRyY243VzZGSHhjUG8wM0RCSTQ2ckMv?=
 =?utf-8?B?cGo4VENkcWtYR1N2c09nY054YzJQWnBUK3plNVIrVHpDQjkxWXBIY1hpUWtx?=
 =?utf-8?B?Z1g3d2diL2llMUdEZFlodnFmQjNtV1ZFNmE3ZUIxSXkzYzFFL0dzc2g0V045?=
 =?utf-8?B?VGs4bHRXQ2ozYkJWci9kV3VWUkpiZUlGUktmekFPOTMzaEdVa2pPQXc0SVR5?=
 =?utf-8?B?a3pIRVc0SnhCQk1aTE52RnZGaEYwdlpFWEh6K2M4TVZOaUw1TXM5OGoraTBn?=
 =?utf-8?B?MGY0Nmppb0xKc2hQd04vcXBUM3hLakk1ZCtMS2VlWExCclhCdVJvNTlIOXd5?=
 =?utf-8?B?UTI5dW1Nb24yMWIyTkd2L2QzU1JxOFNyUTBzdnFqZHZ2Mkx5Rngrdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea12c402-323a-416a-99a1-08def6d1c7e7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:23:19.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +e4/eY9R3TnUd4TfPl2vNuLhcH30rj09y9Cb1xT52KPcgleTtDZsqCX7fRsWa4MV7cBvprDy6c2sWkVn1hsZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5221
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 11:23:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23882

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
[Jan: adjust wording, reference kas docs]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index 435d0370..0c797f33 100644
--- a/README.md
+++ b/README.md
@@ -10,10 +10,9 @@ from scratch.
 
 ## Building Target Images
 
-Install docker or podman and make sure you have required permissions to start
-privileged containers. For docker, you need to be part of respective docker
-group (`sudo usermod -aG docker <USER>`). Privileged podman requires sudo
-rights for the caller (`<USER> ALL=(root) SETENV: /usr/bin/podman` in sudoers).
+Install docker or podman. For true unprivileged builds, podman is recommended.
+See [kas documentation](https://kas.readthedocs.io/en/latest/userguide/kas-container.html)
+for more details.
 
 Open up the image configuration menu and select the desired target and its
 options:
-- 
2.47.3

