Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9DAC27C44
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 06:34:43 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.80])
 by mx.groups.io with SMTP id smtpd.web10.5515.1717137264542859603
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 May 2024 23:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rtJASs8w;
 spf=pass (domain: siemens.com, ip: 40.107.8.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1T7EUDIbuBiRNv922ZjOplcVc3sUKQiA0V8AXrJ7f2saEv9WWug93tQN3L/Urngur6hnNFFBvCKPBro7lcVsyYRnUOC05vYGhUem4qjYJawScoXwSPeiOWzt0ninwTnGiEKdPPKbVpaYDkjB0uI1jGBrkdtmKUPrw4jInkGQN8tgypHJsPeGizExIUiCDIIdz2Cz6aDEH9ZQ8tkXnQwEtzTalLVt5zRP5dTLyEB/GiuKlTqxLrR/mpv9w9b4Q96d+Y8vTyIekvv3+/h+kwwEzf6/u4Y/Vinod6n5fGLcbtY5F/gLv75+smVcIaZYl6ghvTyt6iTAkZPq3d+Y13kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8bEfxu83dPXExxQ5up+uCBjybkH/6crPStS9mS4KRM=;
 b=dREDAI5JWk1wTpc93UzAYbiGd6C5nqOgDVxzji3qnW7Ur6hb1qXcaXG9Yq85BUniFfcVsr+HfUdw4iHBnWM0LebLg6ZPtRdgX+4WisERp3HO3zfEn/Z/xMK1Ya/et5LsLHNFAsgSUV1J2izYGqHN8HcroZYq/QEvHpVPaNhPHupaZMBlbzuuxd0GgDe98+aJC3eXpP7ypHJh4fFUZ1Fh/zM7pHJ6ReNMfl3N/m60ZwkbdD2n8wBiTEdI6LCMi28nijZiL71Ykp8vQFlXB3cEl+SEVcAgIOR28a/LhPlsKfu8jpMCVTmxqmTv/EBnND6Jsivfn1rXyFeoN4i8F9Vwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8bEfxu83dPXExxQ5up+uCBjybkH/6crPStS9mS4KRM=;
 b=rtJASs8wGJEN4HrvDrd6XqOO9x2Q2YYt81S4HE0HTFgCb4pvGQu2Fd4rr5hN0bsZrXCppYXLnUA/YD5VDNaXl194ulsDBbbw5PbgspXFAMjC9AlblrNci3oOh2zYNf22PdtjPCER1u7raatS3W0l45/b39OCc48XYKKjIuc3iHR5BEVJ5CK0eIcVLefOoleYMo9c4sXzohLhwNecA0O9Y2RCOwlAZKZAErkJPNUO/RiqarQxgYoc73T7dDUNttidFNdImwRN3Y4Pk/bZnNGvJyIhTDjoYPoQ3fdYtcUUaOlPyx6loESl4zbVwSPxelHufxvRlP054wRBpWqHN1rurw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 06:34:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:34:21 +0000
Message-ID: <5cf0d782-c1a1-4662-9a51-3223fac62296@siemens.com>
Date: Fri, 31 May 2024 08:34:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/3] Clean up security config
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
 "Schroeder, Stefan" <stefan.ss.schroeder@siemens.com>
Cc: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
 <3d582c71-7d7d-4d42-a95d-706dcd8d9ba5@siemens.com>
Content-Language: en-US
In-Reply-To: <3d582c71-7d7d-4d42-a95d-706dcd8d9ba5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3867:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf3dd39-f566-454a-1513-08dc813bb459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YkY4TmtxRzlGZFM2cFdQc05LcFpsSEttTENmWUlQMGVsWm1hVGl3Ymc0U0ZR?=
 =?utf-8?B?ZjltNzVwZURUUmd3eFhFWXJwMlU1ZkE1L2RBZmxPOWliNkdQUTkwNEZKUmlL?=
 =?utf-8?B?dFMrLzRKQ0JqRVIzUEdxWDNTVEFxbU1OZ3lrQnp5bldlanNzNUlUZWx2cW1J?=
 =?utf-8?B?U2NFMkdkWWo4Ymp6ODZOWmMxTWVSdFZVZGhRVmdndERNeGdEb1Q5Znk3bFIw?=
 =?utf-8?B?R2hsN1J5UFVINkI1OXNaNjRLTEszeWhhaTdkTkNTUkRTdTBRU3dQNWFsSDd4?=
 =?utf-8?B?dVVKaVVqbVdFTStBb21yem9WZHBkdk5LOWFObk1meE5PSEpjN0xJTFFuVXVR?=
 =?utf-8?B?V1ZVUUNpWjc3SkpOanlrZnpWNkQvc3FPNDFzUGhsV3EwM1pZdEJ1K1kzdkt3?=
 =?utf-8?B?SnVvdnMzd0ZaTXYxV2hPZHVBNUVtZ3dZSFFubXNlbXpRaWRRMUorQ0Y4UVVB?=
 =?utf-8?B?bFg1Q0RhbjhhbHdIYXlaQkNxcDIwM2NEVStKOHhsQ083dzZ5VTQvVk9FTkZ2?=
 =?utf-8?B?U0tjOWNsd0tueDF5MkZnKzFoQmFiaGZENldMN3Z5NTh1QngrbmJGTUNTRDVQ?=
 =?utf-8?B?NVczWHFKN3F2bFhla3JJYy8yU2w3blY4Q29qc2diSWZ1R3A5U0J3bHpwWkxJ?=
 =?utf-8?B?SGpBMUxtL01SdUdUTnRkTkZKWmJPZkJuUFJrQkd1Nm9CdGlCMjNVYVdrYmZG?=
 =?utf-8?B?YWs2OUd2TzFvUmkzUC9GSHpnbFhLeU43TE1RK09pQlBkY2tRdTNRcDBpS2hW?=
 =?utf-8?B?bmJacDUxQUp3RVJibk9LRWVFM2JNRDlCdHpFUTJUR2wyNno1Vk16UndMVTdC?=
 =?utf-8?B?YmJaeFpqU2FBZlJ3dUxjUTlyTW1VTzBwem1lMi9jK3ZFTlRsOGp6Y0cxMThF?=
 =?utf-8?B?K2F3K3NwNXY3a2dzUk0vREIyenFCczVCQWxLeVIrUEhnQUpzSVN2OUIvTDJ2?=
 =?utf-8?B?MU9JREdJNDBCRHRETXdDSFJTaWsyb2Q4MzRDRllMSUdTRzE4RU1PbDRJdHB2?=
 =?utf-8?B?Ky9weU0zTFpOWm5LUFk3a2hrQ0YvQTVIOWRlTGlLcEdJWDNrREh4aU42QThQ?=
 =?utf-8?B?aVdXdmhiejVBN3dDeFhzdHpxMWlWTHptVGVJNmhCKzNiSmtTUGJPd2pJMDgy?=
 =?utf-8?B?RTJoTE9hdm1qa1FyZnR3azdRa0ppRnlqc0tjVmN3SWtkUWhTVXVjV3dZMVU5?=
 =?utf-8?B?MFE3NTJKSFpOYWlzSlNNc2R5RHkyRDNCRVd6REFDVlNaeWQ2QXFBWXJDMU0r?=
 =?utf-8?B?MzhvclBtNmdqQVl2b2U3ajdQSjFxWGVXU2xuTDFNNGMxZXRXTjVHa0d3dDBr?=
 =?utf-8?B?ODJUOHlIdEUveWRtTC9HN1RqZFZtMGxKS2RKM3ZIUnVuTExXU2RCTDBrN3VY?=
 =?utf-8?B?M1JjRzRsWktrVUUzYTVOSk9LWDVOOWdLdVZPVmJqdlpYVkduaGRJRk1YUjZn?=
 =?utf-8?B?cTN4bElZWmFSdlc2N0twMU5JSW5SbUFhTERXdjRadGgvZzYxVnhQc1Y4UGpu?=
 =?utf-8?B?L3lwN0xjcWZjeWpnQ2orZE1IZjc1UUxyajhJUFhUeTk0ZHhUbWU2K25pVU5M?=
 =?utf-8?B?YmRySSsvVDFpaDE0dXNnblpJZ3UrTzY2MmRrY3RSMTNlMjYzT2xIVFZpQXo2?=
 =?utf-8?B?bmFOTTBXa2FsVVRoRlNDa0RqODVYM1pSTnhUNHh1a3FWeFRtaU1BRHhDWjNT?=
 =?utf-8?B?RkN6cmRvc0ZZYlZvVk1PdjdVYTlwc3hQNndORjVUa2hWb25xUWE2aGh3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0dQU2FmZlY0blBmK3lXQjBrdWlNNUx1amhGSlJibWlJQXNQWnFPQm9Ucm1v?=
 =?utf-8?B?bXhLTXJ3NUN2UEphNDZZQjZaOGJvRFR2RHd6clNXMmVOVHZYMGkyQ05RZG54?=
 =?utf-8?B?VWgzbzgydWR2NzBxcGE2ZFhvLzczNVp0ZWdsaHYvT2REOTNNMU5FVEFCbWN0?=
 =?utf-8?B?TWZ4KzZZRm4zRmdjWE1nRXhrMmRGUDZrYms2UGJUam1aMTRBUzkyY3AzMjFE?=
 =?utf-8?B?WEswRlY2MStMWFg3NjZZaEU2djNsaDVhR09sUFlCenc0UEZGTXA1cXJMdUxp?=
 =?utf-8?B?d1d5RnFMNTlGNmhTNWRDdUt4WG1hNEpNdE13WFAyQ09KVTFyWlpqNlZKSy91?=
 =?utf-8?B?MThEOVY3dElJWVRKVGRrY05GK1JqQWVLRGhXdXFGbzlzYUE5L0JXTTVvZWdU?=
 =?utf-8?B?ay9mWUZXVXBYeTJITlN6aUk3TnRhUlNacytpTVd0Q2RZaUJMSEFncGF2VnJq?=
 =?utf-8?B?c1NJN2tVcC9jRFJqSGJuaXZaU0pPZXhRMllNYTFlbXVWWTMxUHVhNlo5Qmww?=
 =?utf-8?B?bHhkTitLQnE4QjNXZGZ0TXZUdjk3aVZNMjR4L2N1YW95dkNuc1BKd1BzMnVR?=
 =?utf-8?B?SURLYnJ5YlV1cjF4UllTZmxzcFF6WWd1OXZrVXJ5MGNFVkhGVVdYWC9WUldR?=
 =?utf-8?B?Z3cvQUlKZmZ5Uit4UEJHeWNMa2xTcXBUQzZObU9XU25UNTdrQzMvS1ZQSWpK?=
 =?utf-8?B?dk9FQ2N2Skxyc01JdXFhU1dSdGI4elhNTmVQTGJRNXFLODRrWWN3aXRpTkMv?=
 =?utf-8?B?MnYwbXBLVGNqM0ZRcWpQdS9yNVFZajEwNGNudWJHRnhubDBFUk5QRnhRNDUx?=
 =?utf-8?B?clgzcXZ3ekhMTUEvVDlqeTdySS9JamxraEpYK0wybEhMVHA2VEgrUSt5SkNF?=
 =?utf-8?B?aDRjODd3MDFtaDl2N3ZlR1ZQZ1ZJVWxTNU42c3lWRk04USsveHNDWk43UzRE?=
 =?utf-8?B?T0J3VUEzRk0rdWZhOTFtenNmRWNCM1JrUkg3Y1ZlMzlJQzMyZmlIR1R0OUhx?=
 =?utf-8?B?RHozWXU4dzRaYXA1MVV2YkhBdSs4bWZTZ25WQ0VXMHppanJTT3ZoK05MSFFy?=
 =?utf-8?B?UytOWGdkMjE1RFh3L2RYR001VjluSURXTDNXTGZXblVqV1cyVkpTK0xJT2hH?=
 =?utf-8?B?cy9OZDhTMHMwMzBiVG9xMjdQUEZnUVFTek4zd3NPRXpBdzZZS2Z2OCsrakFE?=
 =?utf-8?B?aXVEWHZReStKbElUM2ZCeXBNN3pLM083V3d6cjhCck1mTDJCbXJqakc1U0c2?=
 =?utf-8?B?UzRVMUVtdmVGcnVWS3FmZVlGSm56V0gya2ZiWkoxS011NWZNN045Qmdqdncv?=
 =?utf-8?B?WkkzZWh4RHZPd2xVZ1M4eTgvYUwxNi84MlBNUTdmQmNGdmJqejVyRXQ0Q1Yr?=
 =?utf-8?B?amwrRGYySkRrNldUcW5ZZ1dORlhGWWtZYkxIUjhrTjNxQjNqL1Y0SWpvYXFh?=
 =?utf-8?B?ZWxDZDM4d085T09OSjk3ek5pYml0amdUM0tpeWlVd1R1aEd4QktYR3pQb2xI?=
 =?utf-8?B?SEtUSWMwSjVuem9CQ1J4KzZXbjNqZU1KekRrMzZ4LzB1QUxQTDR2cDZCUm96?=
 =?utf-8?B?eUhkSkIxdWh5QkhHL29pcVVsdTdTaS9oSVYwcjdHcTIzcUh0MWFJTzJNV003?=
 =?utf-8?B?WjRvZWlvZDZRQlVRRXFkZkFzbkJ0bTlCdVRoVHAvbU1xSzlsMkgyZXpiVUJT?=
 =?utf-8?B?RFkybmw1ZittMjJJTnZSRU43YUxoUStIU0kyQlRDNHgrZ3Z0VHhDVDhJNDls?=
 =?utf-8?B?SzVlZDBYd0piV2lLbVA4UzJCTlFMMGgyU0R3MGZjSGZoVHYxZGxpUHZCL3k0?=
 =?utf-8?B?bjNaZnMyeEFjMElRblY2bEpETnhBSE5aejUvVVU3bFFDb2RYV2huVnVic1JE?=
 =?utf-8?B?T0Z0Vm1hWnNvMlo3bkU0RmRYM1JRZTRPRzhsb1l4UVlqc0RTTUk4VHY1SjE2?=
 =?utf-8?B?N3JYR2FablZKRkszNEtlNnh3ZGh5T3BMdFpZZWZWanIxV3plZmtFQUFtK3g0?=
 =?utf-8?B?ajJCd2FjVDEzZndXS2ltK2hLMWM0SERycnZNRmpKK0N0Ykk5N3hGUzROTGV5?=
 =?utf-8?B?VmY1cTBMVUhTbXcrMElRcGxCNCtLc0dFa3pDRFlZbGlib3VUVnhtUlZSUEhI?=
 =?utf-8?Q?cYakwDarqPO0X4EHK/N0bLBNJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf3dd39-f566-454a-1513-08dc813bb459
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:34:20.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeqzXp/i8I55+M8VS+GcaJc+5cACQjpuQFKdaR57U/VNPafD4BdLhrOSC+hJMsNbcMOJEGwCe/lszTe/aR92Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3867
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 May 2024 06:34:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16077

On 28.05.24 17:27, Jan Kiszka wrote:
> On 28.05.24 16:42, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Move security related recipes to the folder recipes-security.
>> Use systemd as the fail2ban backend.
>> Remove the tpm2-abrmd
>>
>> Quirin Gylstorff (3):
>>   Move security-customizations to recipes-security
>>   Add fail2ban-config
>>   Remove tpm2-abrmd
>>
>>  .../images/cip-core-image-security.bb         |  4 +---
>>  .../fail2ban-config/fail2ban-config.bb        | 23 +++++++++++++++++++
>>  .../files/systemd-defaults.conf               | 11 +++++++++
>>  .../security-customizations/files/postinst    |  0
>>  .../files/ssh-pam-remote.conf                 |  0
>>  .../files/ssh-remote-session-term.conf        |  0
>>  .../security-customizations.bb                |  0
>>  7 files changed, 35 insertions(+), 3 deletions(-)
>>  create mode 100644 recipes-security/fail2ban-config/fail2ban-config.bb
>>  create mode 100644 recipes-security/fail2ban-config/files/systemd-defaults.conf
>>  rename {recipes-core => recipes-security}/security-customizations/files/postinst (100%)
>>  rename {recipes-core => recipes-security}/security-customizations/files/ssh-pam-remote.conf (100%)
>>  rename {recipes-core => recipes-security}/security-customizations/files/ssh-remote-session-term.conf (100%)
>>  rename {recipes-core => recipes-security}/security-customizations/security-customizations.bb (100%)
>>
> 
> Please have a look from the security WG perspective. Patch 2 and 3
> apparently address the open issues, regressions compared to 1.3 but also
> longer pending problems. Would be great to have them in upcoming 1.4
> release. Further discussions and cleanups can be done later, without a
> hurry.
> 

I heard no complaints, I went forward and merge patch 2 and 3.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


