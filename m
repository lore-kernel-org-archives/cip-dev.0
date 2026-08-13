Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46074C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 14:10:23 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20138.1786630214149950992
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 07:10:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p6LdLoUr;
 spf=pass (domain: siemens.com, ip: 40.107.159.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5L2+tawBrQcWT7Lf3w/bJkTKJOhKFEPhcfVg4sVSH8vrEJm5xml6S6E1C0Dnm1469MfKuSMnty2Hfy332X/W7IcEScM2tLkpTnJ7mR8DjAstn5JX01g7nVfLTSJwC6bw3tEW6TzynanosTK7WGLLg/lbeYz9dFW00oaOH2iALMYmDxItVAjBEi//QGuMOuRycYhMXdZkjYFA1LiEl3SifeAvjRdWxv3d0Rp1HJQV0rc49DUf6A4VwnfSPDAVgHcld+a/HzAhrXTowcfUfEszwMesiG4kNBleMnTJc6DUZTuRSD1Ac33WzpR5LVWtNR4e9bG6EoqxKUi1boPBVnKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8T/3VxgG+jSChbTPMPUecFs8ny3r3OQ7yPUV+onIjQ=;
 b=a/5lZ7C8pq40DK9j23RSH0QGkCKRtmpUg5hh4Wti4N+uip30ueSvmJU8v0iQhy9oppd1oxC7/NjKXc+5vJ2q9NF0wNU+5KRFRJpLTus0e40ctBWKhd8+m0iOG/HLmlJFDPBECcrdHUziXYoMoGC+66leg2iALftPPYYf+Ks5XcJKeY2WTRi7KmPNegFNuK/SPwnAOVY8tk/WBkv0gvJbHpDDVw7rPBBRcFwMBIgiKs3wq8y1+xlBCoZkdAgumjFWp4AI/lsPlNq8sGaWEwsWVbjU6ZtpCQslOMBGUblujo4ePnBWstUZDqpHHevZ7gbPt57ten68Rq+6l/KNguL6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8T/3VxgG+jSChbTPMPUecFs8ny3r3OQ7yPUV+onIjQ=;
 b=p6LdLoUrVtdhGKwmGdpRryZfeciPYewsXU51/XrXmZf9DcH7g7gQkOBFrJuJQ+C7BP2KFSS6YjHjMuYJ6Jc+kA7roufKzwFhGYdVDtL9RZizMqYvAk7zON2A1vY19VVxt3Ru3GtPW7T422Twj2AuiEi4DgCrBqTftqkvSQS5/FBF5HSDPw+L2ZKhARc+xxPDE69GX+U8fn6PvyGhnCdwpdQ2t3GMCkyDMozorCTMzR1aN+xvz+qrLAjEwHZ00bbWsY8K2nEUUxKmDFzpcX8kpajlzUsryFtkUXSjDb6a4+q4IQnPYvT+/GUSlLcrRC/4q1DDQNd1SBcENzPEkysECQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 14:10:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 14:10:09 +0000
Message-ID: <ff66fca2-4e47-42c1-b88c-7e736fd68114@siemens.com>
Date: Thu, 13 Aug 2026 16:10:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/5] switch to rootless build
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 Michael Adler <michael.adler@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <592f75fa-e569-4d21-abd6-0bdca1cfb5fc@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <592f75fa-e569-4d21-abd6-0bdca1cfb5fc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddae3d6-a1d9-476f-2060-08def9449508
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|4143699003|56012099006|22082099003|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	Jn9GkogdVSJZ7GjekeyNzTO18CW7WUz1RQXTM0A9127qWdQz2hKZZJN6xSmIq79+tjBJYUPMe1y4uW5YkMnxIsiQIa7YolLbnt2jWQDQLE2YIYW9SSOigU0PMzBf3GoeJleFMfD2qb0mlSouHPJXxk+sZ852lKi7kEdcsM0+FmHzRi9o6R7+THJn8oPhcbaEjHiI0uJuEvRLBoBm3wH7BnZUP++EuaHqLuELqto/aYZBrVwxdD5vSmY1oghUg57YUF3Owvfvpk/ntbE7mYnEmt7Io/M3JoNtOnUdM/Kvsc2D//wwuy9o+6TcU0Xm9vB07L6BBHGO3Rww4mO3MP3iHzSXzIzLjknbSbeIjWYCsljovVUXNFAni1WI00o4fEF3TsuEznyEFldt36r/Waizh4D9fj/G0fpueZLG6gJQgGvBIkDbJzlgVxsdBGdXgviZaCRynYZM1G3kPPdOXk5ppE0YawNcv1MrO0SYV2qQalG1jRIpTQP+f1tMNDaCQ/8v1ItXPST8HPPzRrrY5jjZKOf3yiFIDa1fScJlYB+E2xU0/Rr0zixKxzFlXNThpugHtrEm4K0OMOH26NLDNFIc9nTRzfj8hG+EmVOcQeZPaao//HtNvSWQpYfTZ4Zk3kvFzUBnHDdCyao/UdAC5TfK7qadaUWO5HRzEgpeDTPFuCk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elRtOVpCMzJ6Q05zdVFscXMweTA5RlFNUnlWODBzY0dTcXZBMG9STkJ0Umw0?=
 =?utf-8?B?a3RuSzhmMDl4RDU5WlpOOXJkVUVtQ1hSNkxxUVNVa1ZDSkFiZVJMNTRhVlRp?=
 =?utf-8?B?VUZ1MU9ZTEFPMjR0bFZEa1lFcHdhWm5sdnQ5cll3aitoaWJDTnVCdVQxTWhi?=
 =?utf-8?B?RGZPWXdTMUlsT1hyYkZoUWVKK202bThicTExd1Jvdlc0ci9TMjQwaFJJTnhN?=
 =?utf-8?B?UnRZRXM5RVRGZGhodVVQQVhKQTlzU28vWkZaSnFzSEhkbTZUZkI0NFAxNERO?=
 =?utf-8?B?UjZ6NS9WdzNEeml6STFLUkxsSElPTXlyTEpnNkx6Q0cyaXNXZkNpYjBCWTFD?=
 =?utf-8?B?UERtTmsyaW1zRDBjWVFOTUVxaDV2bUc4NFN3Z0RLM1RScWk0TEdwdmNEc2sw?=
 =?utf-8?B?Y3kvQUhuRzY2VnNlUjR1bGJ6b3d4eWFWUmRDQlNaZHJMc1ozU2FLaTFXMUx0?=
 =?utf-8?B?UUxsVU5saDZ6YWkySE1CL1lEWmQwQXlYTlVkdnhVOGJtczdlTHpwYWFlb2Ri?=
 =?utf-8?B?d3lwbVFRQkQ4UnFqdk50bE4vOW0wMWxSbUo4a1I5SmhMQmFSam9BN0pReE1I?=
 =?utf-8?B?RlNia3Nyc2hqMFdqZzhnU2hRM0dON3A5cG0zaDMwYmt4eWhqRVNPdjhwZUJm?=
 =?utf-8?B?VkZMU0NVRmY0YStnQkFOV0lFMU9NekR1d2grUHVmeWcvWi9COU5ONHdNWTZR?=
 =?utf-8?B?OVJTMzhZcE5GQThzSUpoTHhKME44bHdrSFVPSFI2ZjNITmJJMU0xOURkSnJW?=
 =?utf-8?B?Q05MYUNWSUxzUXVIdGxZRGU0UVNwVit3REdHSGo3VGw1dUhhN1NYTHVRZzk0?=
 =?utf-8?B?NGFTeGVsSm51djU0VldpMGNtRUk1aGtOM1g2THRIbXVaWlIrTk5VZWxodGEy?=
 =?utf-8?B?QjlHU1YzYURSTTgvNlVNeTVybWdlVzRFdDQ1VHdXUnFGa3ZtQWNTWi8vVGJW?=
 =?utf-8?B?NVRvak8yWFJOeExMNnNTaVlQQm9TWkRHRmR0NmNvcnd3cTNmZUkzVGgwSEQw?=
 =?utf-8?B?bHltOEp4bjJxeUZ1MVRNOTNITHVhVkN1VEk1TU92aXlMZmo1a2EzbFBMaDA3?=
 =?utf-8?B?T3lnbWlHYTN4REdWU3pBY2kzdDd2djBXZmRQZy9tUWZaaVBOSnRLTEdlaGg1?=
 =?utf-8?B?ekhLNkNtVWhxTytyQXF5QnN5SlhzemMzOUdkYlRKdE1taVRoVk8yN1k0WWZk?=
 =?utf-8?B?TmZQejdOSExKT0RHaWh4TGdwbERqb3lUQ3puSVVhanQvWjFqcWVubzZ2SUFC?=
 =?utf-8?B?TENkbW9EMnFEZ1llTWwzQmxEVVNWQzNyZUJydVhEQmdGbmxIQitSMGp4T1Iy?=
 =?utf-8?B?UWlhMXE1UEF0V1FhaTJGQndNUmdCQjVzYjc4aEVsOUw5eDJUTWtXbjgrUUt4?=
 =?utf-8?B?eXd2bExKSHoxYzN6dVdPd1NtQ2crSUJBVk5nUVFVUXY0N3MvWE1HWE45d0tO?=
 =?utf-8?B?VGRCQnpST1RmcUs2VmlGYVBmc2Qra01PcS9xTlMrdldIdE45Yloxb3MyZnVv?=
 =?utf-8?B?WWRqQ3Y2YUY0eHNZS3BBMTJVaXZlQ0dqVjdpenZlNVBxNlIvdzE1TG1vQXYz?=
 =?utf-8?B?RWUrZHExQlZRWEgvWFdxYko1VnNtUVJjbzREZFlGaGphQi9nUFEyRHdkNnFr?=
 =?utf-8?B?aWI2Wno1WDZEUGlNZ0ZZNVVha1V2ZUhvaUZHUzhWSXZ6Rk0wR1VabzNFSXU0?=
 =?utf-8?B?YUM3RThzazVEUUk2bFQ3VTIyVlJHcmVoeEpLSkpVbmJiRzMzVTBEWVpydVk4?=
 =?utf-8?B?WWVJNkxwZ0lYUm0wWTQ2ZVhWR1EvMGxyQ29sbGRJUWFEc2ZXanYxSFZvY3FH?=
 =?utf-8?B?SGpMN2NOU2t6Zjg3MTNrdjRSZEFWdlJ3WGJpSWI5ZTZ2QWFGUjBBOGNGRm1N?=
 =?utf-8?B?YWNNdzhBSnNsSEJqRk1NbUNLaFNxMWpHd2F6eHVzVlI1SXpYcjFYSjFCM29L?=
 =?utf-8?B?Zm1VUHJlSjZjdDRJaW5CcHNwR3ZYR1VkVWs0RUNvZkVGWkw3OHNyNldSL3p5?=
 =?utf-8?B?YVB4eU1vbm83Q0ZLSXJGTmJSK0xkTWVFeFlxRi82QUlpZjlqTFpLbThpVmxk?=
 =?utf-8?B?WkRSRlRMU0RWaWplcUdFdXhtY2hlMFhrRXZsbmlOWEpORGljNjJUSmtyU1Bi?=
 =?utf-8?B?eWEyK1pNUHp1eEhxM0U4U1ZBYW1ZZ05IOWdFdmJPQmR0QWplZHA1dFJFRHNK?=
 =?utf-8?B?eWdOemNxVEMyYWxRcnRzVGhpUzhhZytuQ3NKeUVPZnZXMUZ5cWFxUnlTczFt?=
 =?utf-8?B?dEVnamU4bVd5QTZJeXh0bWZrRnlGdkpscW9pS1IzTmdhVi90RFRubFhscVN1?=
 =?utf-8?B?b2tHZnF1UG90WHdiRk5RNHcvNWpQMWRCTi9qOXQ5Z2pkTHI1dGVwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddae3d6-a1d9-476f-2060-08def9449508
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:10:08.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stDDZuopV50LBFFgZqbTWRrHTmhlOCi+P5xH9mVyMaWmSEm3cs76eGQHtXc0WRaLhZvLIKQA35L5+80VRKeV7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5919
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 14:10:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23929

On 28.07.26 18:55, Jan Kiszka wrote:
> On 28.07.26 15:12, Quirin Gylstorff wrote:
>> This patchset contains the necessary changes to switch
>> isar-cip-core to the new rootless build.
>>
>> Changes v2:
>>  - add Debian release requirement for rootless builds
>>  - use kas purge in .reproducible-check-ci.yml
>>  - use correct kas-container
>>
>> Quirin Gylstorff (5):
>>   update to kas 5.4
>>   update Isar to contain rootless changes
>>   use run_priviledged instead of sudo
>>   switch to isar-rootless
>>   update README.md for rootless build
>>
>>  .gitlab-ci.yml                          |   2 +-
>>  .reproducible-check-ci.yml              |   3 +-
>>  Kconfig                                 |   2 +-
>>  README.md                               |   8 +-
>>  classes-recipe/image_uuid.bbclass       |   4 +-
>>  classes-recipe/read-only-rootfs.bbclass |   8 +-
>>  kas-cip.yml                             |   4 +-
>>  kas-container                           | 300 +++++++++++++-----------
>>  8 files changed, 176 insertions(+), 155 deletions(-)
>>
> 
> Thanks, merged with the mentioned changes.
> 

Michael AI identified remaining issues in kas that currently prevent us
from moving forward with rootless in CI - local single builds are fine.
I will move certain patches from next to a wip/rootless branch for now
until we have a new kas release with those issues fixed. Some backward
compatible patches may stay in next, though, still need to check.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

