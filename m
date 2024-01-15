Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81468C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:10:24 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web10.72847.1705306218930373826
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 00:10:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ngDr1wm4;
 spf=pass (domain: siemens.com, ip: 40.107.21.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8+9pkzem4JJ2eYtFo+YsGuEnHZEmWAfrjcmcYH8t7kr9uo/wtRqubBQowlEOABtJX8U1nurfNk18YwFVEogUrn58723QfXvPZdNcOVT08lfXY+QXXAYyAgo9FMgaXuhEuimP2+l54VHebtKBDS3AwFhEQ+LzrFZZ/MVLoC0IbdMwFXqq6o/SEfy/5kwWEfhA1hUMhVFEgjyznO5SOw2HRYYtSKmH8z3uCaxSW3EOom2v27GPNasjr2B6JSY1pITfD/gowFijiKi8v3PGzZSBxPYVaEYgEQIK5Y+1Rl9sybvEaewfxWV8LEoZUMVJsFU6jaKy3XjXJwuB8LjQeragg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z7V9dMUOA0YuzhjPVYJUZ5b3Inpq5YZWhHNxr9IYNA=;
 b=dXcDowJt2uC1zi8AkRPoAPvzKyBpzMX5Rb1w+Dj4qEAXQ8ZPGIS7uKa7dVkcCYy1vBMq2gtWbJxG0QdjSawLsP+cMGCZP713v5DKrlJspOuxTIk9eCD0dlrqlkyqVdndQPNuqQApH1nWotOt/T1KUNYSpTMopQcJP4OxNeGD7UmKzlJoG2rpianusQEtXeTHUKIQhkcS/xHjo1syzP/5NbwpXHVXFX9M2kTt4XzQyaSQ+dacsrwz5FcaaYGafN0a9aN3358XsZLzAY0r3rWu1YB8CsSYorMd3bEs8nTeo5tSsIEzRz3ZfCXDhSSyMFUhD18FxMRqTAV64pLomE+hTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z7V9dMUOA0YuzhjPVYJUZ5b3Inpq5YZWhHNxr9IYNA=;
 b=ngDr1wm4OFJUvnWlD8cXNPBI5ivh2NiutIxjgtViumi62j3XXqxUSDx0iS+RItZ8M+jbcRjFl2ghPvLo5FD+PVS3vpPRDYSZrIMEnWx2KL7n6dtPxxBb719bJmpml5K7SACPKx9cXV3wqMU5slb3NCtQ2jijr0L9BqhbYYILy+85uebdK30h8+YJB/9CQpFRzmmVoEpQDgziJq+coWPCd1CyCFEb4Aj7AE9vGFSvyRKu+w/4DSr1y6R/j6w2pzaX+hcdVELlxye3EB7nb9RXs+gsjeyqq68sLux3k01YjFp1b9h5EFvOmMJGmY/JbzYzDAIdCPcp2SbwVOEaz9CxEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 08:10:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 08:10:16 +0000
Message-ID: <a2e1b8cd-7fc2-4984-afdd-4e6623a3651f@siemens.com>
Date: Mon, 15 Jan 2024 09:10:14 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.304-cip106 and
 6.1.72-cip13
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3529:EE_
X-MS-Office365-Filtering-Correlation-Id: a204252d-8c86-40c8-3d7a-08dc15a16808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MVf4qb8WdNLQsRIo6uZ4UXCDqsoubl1/2FXgXI/9Xr05avNe7zdhEAf8nLMPRtp1wGkpj9VsSGoMb8PLyLWt0CElyQghLZW7tisZlcIoN82LnwzcfLe64Gchon4lZfLemkKa8csMHzTVAqReAGETmeElG9KgJWdq9/didNfdOcHkV6oup8k3aD+1orTLvYFksY0v0Q8su5dfvEMGYWmFH4nMJvKpUqwngC4O23hK0EKDLFE66KIbQ7e6r+xKcycuS2Q4pP+j4G7NNd169dqwXFOEYVHTG01ZEWqHoXElGinQ5mAuVi7+emq8hlHYrr1xz6Ju0QPkY0jPNZ15eaIvJi7dVnZVxR0ITxD8Omhi+SiwH8ia/01ihHSgVPHaEmE7dUVYjCmnhxWnkeJ/pZol0qOcLWRoBnDi2n/K4G3A5mcJTWvqzd8yWSpQ301IxOXACr++ZpJFdIuBZx56keSjo/+pOlvTPzgMDfwUNbwUvlSdO9zVAYCKoVLjcA4ftWc27eJmJf059DtM/QzhtgBZokMrNiwH9iHyOpeD0MrWpZEPc9vcQYUZH+jaeMSqE/56tYqTqRva83SkXX3tsYJT+C9y26odY/NRIyBMzcdOkax9/fxuzDhQoZe585BAePH9CfVw7lfkuiICFontSbSPyA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2616005)(26005)(6512007)(478600001)(38100700002)(36756003)(31696002)(82960400001)(86362001)(5660300002)(2906002)(41300700001)(6506007)(83380400001)(66556008)(66946007)(316002)(66476007)(44832011)(6486002)(8936002)(8676002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2xjb01RRXJjOVlvVWk0V0k3OTNreHNxdGRjR21zQ0srWWV5S2lBTXQyYkY0?=
 =?utf-8?B?YjBHYitDckZkbnVSWDhMb0pPYVczOVlhRFByWG1Vb2tFU1Y1Ky9vOHFkWStx?=
 =?utf-8?B?V2g1RnpkWGtQa0JOOWY2b0Q5V1dTZW4waU9RWFpSRkR2R2p6OG11azRNNjQ5?=
 =?utf-8?B?d3dYTHRYMWVRUTU1RXF4SS9ST3FHVFdPRjZadlNmQUp1N0svS0l2OEFwTzk5?=
 =?utf-8?B?bjNQeUoxaXdyeGZBRm1RQ1Z6b05aNlo2dzlDTTdmTTErRkFzTnR6MDBWOEpG?=
 =?utf-8?B?aTVkT2NteFE4NG9zL0J1Wjl4QkE5M0ZDbmR1RXdpdDRsL0lLaWtmZ0swdFFH?=
 =?utf-8?B?RUxRRmNYTXlNOTB6QnI0b2tqdmJJRlhDb251cUlWVVVqTkZ2UWFSd3VYZ1dY?=
 =?utf-8?B?d0ZyVVdvcDB4dUF4RkxqU1h4bkU0V2pLZDlXa0pXZjE1ZWRGNjBxS1cyOWlW?=
 =?utf-8?B?em9jc1poZmNMUjBNZjdpaUdZWFhVNUQ0amFpOFFxNVpVT3d3VnBsOGptdkFr?=
 =?utf-8?B?b29VenF2WVM1Q0V4SklEbHdwM2xnMlh5bWhFQlUvL3BueWYyOVBPK0k5eWJW?=
 =?utf-8?B?dUxuV3c1bHlORXVIMDFBd0tjOFVMQnZBd2xIRUJHQTFUS0tTcDR2L244S0cx?=
 =?utf-8?B?ZWdVMGVTUkZJcTQwazl4b2dIME5QL0RhbmUwNjZ4a0h2aW5Ec0lzbTI1TXFG?=
 =?utf-8?B?c3JoMjd6YXNxK25QMDcwMnE3cngwSW12QjBlZ1REVTRVWFpHMUdKa01mc2Jr?=
 =?utf-8?B?K1JGRXJTT3ZSZjF6Y3J5ZENQUEhvRzdsb2o0VzhnQVNiVGJ3dDdVVm9lT3Zr?=
 =?utf-8?B?em9OYmk4dXo1aE9GSHlwVi9zYlQxRlNxVTY5NTRMUm5WMUF0STBjejllVE5E?=
 =?utf-8?B?UEVLeCsvZnlxUDZhaWVZaHptYWtWaldOWHRmV3FtcjFDWEk3cVRzZi84Qmo3?=
 =?utf-8?B?bEFUY20yVElkT05nMlQyWVNWLytxQUt6QmtJRHpYcW1mY2F2N0RZMWR2dGRQ?=
 =?utf-8?B?akhSM3lBNGVFZDU0VzV3WW01NTBMNUFQZ3NFNS9BbWNVNG1lcTlxTFREZVY1?=
 =?utf-8?B?dnBpUGpLR1kweEpVNkFQY01uY09WRDNuRkVTZVlkWkJ6VTRmUHdsdGZvaCtr?=
 =?utf-8?B?cWZZQ1ZBYTBkWjRoQWRPN21MSWlpandGSVl0Y2ZXbDFuZmsxR1FSWmNNRG0v?=
 =?utf-8?B?Qkt5bm5PZmszZWMvbjRGZXBPY3VjeStmTGd4UlN6OE5HNEJmclJLbSswSWlD?=
 =?utf-8?B?RndWTjQwVHlONEtKM0ZaamtYSjRLc21aOTVmMHlocWdFQWs4U2UyRFp4VmYw?=
 =?utf-8?B?V0dXTC9SRUlJQW1CNkNFU25tYUdwdmtMaHVaUGxxMWtRaUZsMXNLbDhmTFNw?=
 =?utf-8?B?bEN6S1JPOExzQ3Z3NmFrbWpPdWw1STJVbEN0VWduaHQrdHN4WEl0cFV5aFl6?=
 =?utf-8?B?REM4UnJDOFFDWDN0VWZQVU43Y2wzNnhJOFVJdElOdUZZWU5rTFdCTFg2MjNE?=
 =?utf-8?B?VWRVN2V0TnZhU29IaHh1dU9pMEVvd1Z0RG9HbDJhVi9Yd0F1YjA5RDFpczls?=
 =?utf-8?B?R2hKN2xlc1B6MU5KL2E1bTlNVDllR1lnbHUwRWhoTGlSZzJyNTcrOU9qYkxF?=
 =?utf-8?B?WUxhRnRJK2hqOE1aVmJWajVtK3lGVDhXMVFBbTE3VmFKTzRlaE0rZXpzMzd0?=
 =?utf-8?B?STZhUGNjMnJxbURVT3VOZVc0dlhGVlI4WlE0OHhPUURpcTl0WDgva3pzaGg1?=
 =?utf-8?B?KzVhUVhzdHNBSGxOR0I0bzg3SDlQcDVBTy8xV0VTV2xyOHNsYW5wU3pNdU13?=
 =?utf-8?B?bXVrNmUvZlJ6THNOUk42MW1RTyt3ZEZpZUpqWTBLckloUVhSVGQ1d2E3S2JQ?=
 =?utf-8?B?SGJIZ3BkL1hWTjI1T1p2cEtTL1JQcEF3TVBML0dvOW9pczExZ0hSQzJCR3Jy?=
 =?utf-8?B?cUI3VE9jbnRzcGV1RXhtT0UrRFg0VFpJR29WU1NaaTdUZmFDdnBuZUQwMVkv?=
 =?utf-8?B?UHdwQ2tWeDFFVWFHT1hKRWZvblJ6c3cwWTVFMmdwczJGRFRkRnlLV25NWlF6?=
 =?utf-8?B?VmhvMTlHVUJqUlVxQlBSQ0lXZ1FScWN2TTFyREZscEF6a3dGOUtsdmRUNDhx?=
 =?utf-8?B?MDc2UGxjdUFQdHlqK3JpcCtpQmlvUmN0V3V3dDNBSEpCaHV6b1k4MXF1YWpv?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a204252d-8c86-40c8-3d7a-08dc15a16808
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 08:10:15.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4oa+1XzGuSnHFpJNC6XnW4+fhq3yrJmUdtxLAavwh4c3G+BHrfl+hsEDyk59wAy9eFdDwk5woQfagr/NdG4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3529
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 08:10:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14377

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...inux-cip_4.19.299-cip105.bb => linux-cip_4.19.304-cip106.bb} | 2 +-
 .../{linux-cip_6.1.67-cip12.bb => linux-cip_6.1.72-cip13.bb}    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.299-cip105.bb => linux-cip_4.19.304-cip106.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.67-cip12.bb => linux-cip_6.1.72-cip13.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.299-cip105.bb b/recipes-kernel/linux/linux-cip_4.19.304-cip106.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.299-cip105.bb
rename to recipes-kernel/linux/linux-cip_4.19.304-cip106.bb
index cf22c131..055006eb 100644
--- a/recipes-kernel/linux/linux-cip_4.19.299-cip105.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.304-cip106.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "60e1d7426821c47a84ee4de53e9be3d23e09cd493390fa29b3d2f38e5d0639dd"
+SRC_URI[sha256sum] = "3c920d95bf991d4242bbfd5f89e623aff5037863a9a7b0e8b2ea3a374105a635"
diff --git a/recipes-kernel/linux/linux-cip_6.1.67-cip12.bb b/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.67-cip12.bb
rename to recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
index daaa7703..55e55786 100644
--- a/recipes-kernel/linux/linux-cip_6.1.67-cip12.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5d72be655a9c31ae298ae79184750d5c76f82bacf568a3b8dfea2aa717c496de"
+SRC_URI[sha256sum] = "31baac22fe43d65797704c70b9bf91554f098f93b7731dd5ccbfe0ca7f0005c0"
-- 
2.35.3

