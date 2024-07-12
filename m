Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4199AC3DA4B
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 12:45:02 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web10.3817.1720776170942842161
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:22:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Go/eL3/W;
 spf=pass (domain: siemens.com, ip: 40.107.241.85, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/p0ui94f8mFM1xfzMSXPFbEJxODAqVowY8GYOyahA9cJpzPsfjwC5F63H53GKsu8nbXS33fQLwVgAhFbhpwKzAinpQMigxpiR9/wEwN4vGduvkHY57plwB5N+c/e+ZTElw9hA25KKpqldn0UjaGX1LpMf0SepAa/wqtKl276ATG5Yt5ouFoGgre9bBBmkv9fSSyzNgFFf16FSrXF1GYrOEE3pP1wV2t1WzJEXcLrMhkCUlbZznLHN5+PgTrf6rn48heiBIkk6njOluBwFQdDtn33n6jFisaT9Cgr392HwpJnCHJDt5VyD05aHL/k5gIdeD9ASJiaaUmcSBMjZ9URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaXrmm/cnabhn9xMOkOckq9UbwfATb4tAbOvhS/QfUc=;
 b=xiLQm/9B/0nW1Rx1mY9H/wY6FPTWj6roz5+tiExgqpZF+VgBP1F8g4ixFbqZB9pm+EiMnDI6EZwt33kCaMonEm8BHzmmAD7ojaRG9RRsgeH5mwlFBQth1BUpQCFxsMIQHb/T+5f0EfwAl/eNnKa1fPTQWXzSXxgl3uv8CRp9U6G8cEzt0gXsJOB3fdq1kr9Pv6qAqYv/CQkSBKn5SyDL6OyPDUaxLJDSLxRenKTKhZcwhVSOuNQQBegVijCA2eWQR87uKT4MEOLkcd3h2EaS/Wd4rX1hCDrAamDHpEAzkEAZDjWzAD+4NZSwdTMV/tWT1b2kVCdQiOsfsdLs5DYYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaXrmm/cnabhn9xMOkOckq9UbwfATb4tAbOvhS/QfUc=;
 b=Go/eL3/WhJX7lesRAtHkhmZMnjrDviLXC9DUq33glUsDOBGJIH+YBCPG4TXFUUn4Na0v2Wvj5FLyne96xX1LtstOJHlNhtxRPsIDGIaXgSxuSiwm9zHT+B660MbkH1d5f7O8VyC5tYcjsUltudW76AD2OviCBOSOaQFUR3plcnquF1mIHscE8/EbTHIChvbDFgvoyAelQOp4gJy7yh4rlGkxXUg2ToaGhnLNBhmgoPZ/9REEs6xhcScRkFIf+6Yn5fljIy6MuiDTrOnGzA15y8/VWyZFDA7vn5joLxI6/mr8q11vrNcbqwWykvVp0Du73tufuwJpxjOmI4+kXHe4hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::5)
 by PA2PR10MB8772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:22:47 +0000
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306]) by AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306%6]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 09:22:47 +0000
Message-ID: <d8c4c2dc-d7a7-48b5-ae0a-5bf17ab9ce02@siemens.com>
Date: Fri, 12 Jul 2024 11:22:45 +0200
User-Agent: Mozilla Thunderbird
From: Christoph Steiger <christoph.steiger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC] Kernel CVE Triage Tool
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:61c::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7136:EE_|PA2PR10MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f5b611-35a5-4b77-9408-08dca254319f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YmVQbjM0TzJVeWVMUnNqUTVnbUNKN3hhd25PYnh5MFg4a3YzWmt4czc0WlY1?=
 =?utf-8?B?Zy9NMzJLbFZHU08yZWhyWjdMQ0JBSTlvUmpaN0hVSWxFWE5JdVVFMXljUW0y?=
 =?utf-8?B?S2dURFQ1WXd0ZXp3WjNOMWR2ZU9ZejhGdkFFSkMwb2gvaFA0bmdKb3BxTTAx?=
 =?utf-8?B?N3lyblBzSjVpTFBjN0RyUi96QnZNd2xsSXhzRnJKaFZIQzBkTkJFMzZXMkRi?=
 =?utf-8?B?MmtxMk4yNm8xb3liZ2JoN1R0dzlpZWd6Zk5EamNyclVnWFRKVjhnblczOHgy?=
 =?utf-8?B?QXBSTzZ5Sm1qYnJDT0FUSS9WZSswM2dWQ3FFcWI5M0R3c29FV2lLUStJcysz?=
 =?utf-8?B?dDZPNHFlaFMvd2lZQWN0d1BTa092TjUxSGppYWxDMXJ2OXhKR0dXZ0xaeDVS?=
 =?utf-8?B?b1Awd01JWU1PUUVzMmNZZnA5bzRMRitGdHNUc25ETUJQNlY3WW1tRFB4OWJD?=
 =?utf-8?B?ZFFwaXRvTUkwVG9hcWNZMmxSOEtkMno5WkticjI2eUNudFFISzcvVG04MHBa?=
 =?utf-8?B?Y0YwZ2ZuRW42NVh6VUhZU3hLSFk2WkY5V3hxbUYxV2dKeWV2aHpLWTlBOEY0?=
 =?utf-8?B?Z0ljNDdwOGc2V2NSbEU1Rk9iUkYzbi9xNW9sL3M4c3JQSXBXWk9zbjUzZDdY?=
 =?utf-8?B?ckE4TzI3N2NINm9pWTZvK0M0NFdveXBRM0E1cGJJVjhBSDhTbHIzMVRXOCsy?=
 =?utf-8?B?TXJNeXlrcUp2aGxUWWxsbnMvVXFKemNmamNPZFhUOHloZ0ZEVForNUZ5RGpy?=
 =?utf-8?B?UFE2Wis2Y2RkVGJqUUJ1UFVKV3c0MS9RU2VkMU1POXdIbVdnVW0wamVnbHF0?=
 =?utf-8?B?VXBURjZMeU44QkRKRFZIRHkyOGlFTXBqeXNCY1dUcExlMWUxUGZlSkRDeU9r?=
 =?utf-8?B?RVVhRGpBdk5pTVFvZFlQK0tjVTRRRTFDemV1dS9qK0tnakd5YzV4Vk5hR0FJ?=
 =?utf-8?B?NTFBdkR3QVgwWEVEN3B0cWZ6eXora2JxcVZsL045MDBYL1c4K2ZlRjkxVnBF?=
 =?utf-8?B?a0kzMWM1dTZYTnZJUnBQSzJyZjlBWEZadUU4bGIyUi92Y3hYS3phNXpmdWxp?=
 =?utf-8?B?UXJLTzNMZmJYOUl0bmpOVytSeHJtazZkNVhWWHRaRHg5dEpoRWZvR3pqalM2?=
 =?utf-8?B?NWFuMGtwZERaZExuSU5WSzdQYXl2enIvTUFZQ1RIRnlEMVhrcUxLVnNaak1D?=
 =?utf-8?B?M2JBMTRIYXFCSmZsWFNLVHpRUURlZFZudE9VLzdGTWVpMDY4T01LeEJvMkhs?=
 =?utf-8?B?UllRYmxVb21KK1JMZFpvb1NIdE9lU1NtY0ZML1BIV0lvUmxEd050ZkJKSDhy?=
 =?utf-8?B?N0pJcXlHQ004SHZBNmRrRTFCRDdPK2cwRFNDMG1pOGVLekQzYmg4V3hsY3Mx?=
 =?utf-8?B?c1phWW16THZ2WDU0VWtURXJWeVEwaHVReXBDQVhDVDFNYkVqRlFFZWF4RkNy?=
 =?utf-8?B?U0VmUWIvUFZHRzNPYzFUNTgyNnFIQjJzengrdUpadDRyVzc2RnpraTRralVU?=
 =?utf-8?B?bUx0TEFRdEZ0ZytFMWwzNXhYdWZUWTQ0MloyYWhwa0hYOTNhKzJsR1ZWcjFZ?=
 =?utf-8?B?Rm1HTWdjd1Y0TGQ2K1N1cmVIWHFSZFdSK3VZL0Eyd2NjV0Z3aXVGeWd1eXBS?=
 =?utf-8?B?S1FRYnM2Nm0zTG1DOU1RSkpEbmFiRElsNExRWGMxcjYwRjZ0RzdaMVM3U1VU?=
 =?utf-8?B?ZXRiK1Bzb3JMZkwrWC80RGt3czV5ZGlmUGIwM2Y1S2dpNlYveGhFeHg2cTNw?=
 =?utf-8?Q?7IOCFP7Des3YVcdMcUuM0oZXuT88c4Jfq6otdOo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGRMaWo3YTlHZFp0REtnTFFxYU5aOFg4VTBuRW5QOUZtZmhoYTZISHJWUWpK?=
 =?utf-8?B?SmlOQXJzNnQzOVhDb2Zia3F2ZGdwUExlY1F3UjErbEhKbEhNcUQxcHF2eXpD?=
 =?utf-8?B?YXQ4RkFiQ1Vwa09vb0lrY0ZrdWJVbUNYeVBvNE94RlE3OVh0VDJ0RDNHaWpz?=
 =?utf-8?B?SEVEQnlqeFBjYi9Ic2VJQjZJNlVCaEpxamVhaW9xeSsvVElNVkdtVldPdjVX?=
 =?utf-8?B?ODl2OWFjSmM5OHd4TWZpQ0RJbE9NZkphMXRtMEx5WkdCeVpib0JURjhMUVBD?=
 =?utf-8?B?dTZxV3ZGKzJKN1dmaW4yUDd2YlhEdjQ1UVQ4K2ZyeFk2Si9SVHkvbVVXMnd5?=
 =?utf-8?B?N1Exc053L2YzbHBXRVQ4QjhiTE9iUFlBN2hWUHp4SXNSNHV0ckVpZVQwYVFO?=
 =?utf-8?B?QVVPTE1oYlNKZFZOSlMvbG85Q29WYmFtNE9CTjl6VmQ2RnlWWFkxT1J2K0VR?=
 =?utf-8?B?OUdocW9DSXF5aVlMM2NzRDBTc3dOK1orUUlLQzdQNlh5cjNwWSs1Uk8wRDc1?=
 =?utf-8?B?V1VRN1RaYzJtbmJBbEFxeWdkbThsbUk3KzhpbGljVTdmalZ3VGZYb3RUS01O?=
 =?utf-8?B?UU1WOUI3Q2ZPcWtySGdzR2k0RXdreEI4a1lnRXVxcngwUmQydzlTL0VZOUp2?=
 =?utf-8?B?cGhBd3lyQnlkSWJCd3p1THU0Qy9oYVk1NFM1b3BPUXNTODlNZ2NFQ3owSm5G?=
 =?utf-8?B?SWRYem5GNFdFWVhISDhxLzd1eHRsUnJzTmliZ3FqZnFHc2NVRHAxR0wwbTNE?=
 =?utf-8?B?QzhRRzFqUVZNT0Q2akYyaFNlN0FuSkdwSzhZck13N1QxKyt4enA3RlZ1azJZ?=
 =?utf-8?B?bWkwSDkvVFZ2cW8vbjhuWS9BRFcvM29Ia243YzZyRzZoY1dhS3MxTXpGbTVu?=
 =?utf-8?B?SHM5TEd5VVdLMnNROFIvQi9hZk5BcVJsdHkxZmNGNyt4cSt6ZzBacHdMbDlV?=
 =?utf-8?B?aGZQTFlWeTBNUE5ha29KYzdNa1RrdUh4dG9wWDJZV2R5YkdOUTh0am04Q1BR?=
 =?utf-8?B?S2RUY21rOS9xVkxFcUZmVDB3aEVvSEtHbGVSdEJEcll0eTNUcDg5bGxTNlpm?=
 =?utf-8?B?MlFrSk5hem5yK2tjazdVcThGT0c0UTJpMzN3YWpSVVlreTBBTDhDdDhxazhr?=
 =?utf-8?B?NmdWVlRHS0MzUWkwNnprL05jZmdYWnhoTTNTNlNNc2xYY3d5Y1d0YjF3TVJu?=
 =?utf-8?B?N3JWTko5TmFlL1Q2clo1L3I1K240RGl2eE83cTRKMDlPWkxlZFAxU3UrSzdM?=
 =?utf-8?B?Sm5CU3ZOb1AwM0lDQlBkdWhiOC9zbDVKS3BLbnlBQnRkQW9ZOHFCN1owUW5D?=
 =?utf-8?B?ZzNpQzNLdkplVzlaQWRweVN0Qm1XSzhSajhqQk9maHRkUklHd01iOFROSHVh?=
 =?utf-8?B?S2l2MlVidVpVVENwYWxVdXRmYUlOSW9XYTRvN05CN1BNYjNQL1hYczBxZEEr?=
 =?utf-8?B?WHNOOHJmRzRLaEliZHdwajhDOSs4Z0NPNWN6dWw5WkNoRmN2SkJvZXlUS1JK?=
 =?utf-8?B?MU1rUUFZR1lSZThvMGZ4RTV0R1cvSWZoOWNOSWtlN3lzZkV4VFk1bXppd0JR?=
 =?utf-8?B?aGtzMW4rS09jblF1dkkyRWN5R1BvS1A1NmV3L0xyMFJEYTJjNm55Zmd5SnVL?=
 =?utf-8?B?R2xaQjdvLythR3lsS290b2dKMzVML0EzOE9jVTBkVklseVQzQ1Vtd0lsZnB1?=
 =?utf-8?B?U0FMZG9QM0ZlZzRGRWw2VEZNNGxSdTcyc2h4N0ZmQ2xDTG1pUmpPQmJNdGdL?=
 =?utf-8?B?WU40STRLdW5FUlNBYklpeGxHcWhyNEdacDV6S0pYVUkranh2QVo4TU5sTEtr?=
 =?utf-8?B?VWROZmJvc3kzdnlMOXZzRHZxQU5SYnF0VFVxa3dtazlzOXNESkZZNy9HbEZz?=
 =?utf-8?B?OGJBM2drbFlCTDJkbUhGQzZLeGFLTVRnM3crZ0JzY1ZOT0hBUE9UWEZWNDRm?=
 =?utf-8?B?bzROQTdOaG1DbkxJSUplQzR3a3FLWkpzbmxoK0JDeHJhbGhtU0h0aEVVMHpv?=
 =?utf-8?B?V3Ryekp3T0JmQUJYWFFLYnB1TVRoWnN2cVJLNGNCTXlMNnVPMHFMdmlFQXFB?=
 =?utf-8?B?ZmZrMUgzYTBIVTVUbXBCWGpRL01YcWs5cjQvQ1gvamd5U3NwOU4xSWl1LzV0?=
 =?utf-8?B?enFDVXFEd0RIeWlIQ29Xa0pyTTNVVHhQTEZNSE1ZUTdVMlFOQ251UmJUczNP?=
 =?utf-8?B?V1IvRkgxRk1iNWl3VjZXTnlmRmJSS2J1Kzk3ZEhIUTMvWk5XSUViRnVvdC9Z?=
 =?utf-8?B?MzNiajlERURXTTEyV1ZWT1E0VlZ3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f5b611-35a5-4b77-9408-08dca254319f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:22:47.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjqMR1pGLflNWBDPOFmzU2aVPG8bU1SN3u9S2+GkEaZWD8eqq/uAiLquODDBMF/0HxEs+7z+pgp8Hzz3S4WiQIOkVj4xP/frfK5v6NkJUHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8772
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 12:45:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16478

Hi all,

as announced yesterday by Jan here is a proof of concept for a kernel 
CVE triage tool. You can find the sources, installation guide and usage 
guide here: https://gitlab.com/cip-playground/kernel-cve-triage
Please give it a spin and tell me what you think.

The general idea is to take a kernel source tree, a config and a list of 
CVEs and see which CVEs are relevant for manual review. To achieve this 
we run a number of checks for each CVE. A rough overview what is 
currently done:
     1. check CVE description if the CVE should be ignored or not
     2. check if breaking commit is in git history
     3. check if fixing commit is in git history
     4. check if files touched by breaking commit are built
     5. check if lines touched by breaking commit are built
The analysis of what is built or not is done with the kmax tool suite. 
You can find out more about it here: https://github.com/paulgazz/kmax

Running the tool for the v5.10.218 CIP kernel for all CVEs reported in 
2024 for the siemens_server_defconfig filtered almost 89% of CVEs. 
Running the same example with siemens_ipc123e_defconfig leads to a 
similiar result of almost 90% filtered.

We are not quite sure where or if such a tool would be useful for 
maintainers here. A use case might be to have it run in the 
cip-kernel-sec repository as a CI job to enrich the CVE reports, but we 
are very open to any ideas or suggestions here.

Kind regards
   Christoph Steiger
-- 
Christoph Steiger
Siemens AG, Technology
Linux Expert Center

