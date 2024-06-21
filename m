Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C3C2BA1A
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 06:31:07 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.66])
 by mx.groups.io with SMTP id smtpd.web11.66827.1718951450351214667
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 23:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VNHuS8Ru;
 spf=pass (domain: siemens.com, ip: 40.107.241.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7cTpXU8X/EihCz22EdctRVCghqvhoQZqL0zKMeRyDLBcnl7mg23S6gPw9ffAWf3bRri0NDT/exOKPZ0HD9qNiLuCcm6A2yl0igSj8NVsuuPF03JDEaGc6doDUlAJ3xZtOfO6+8mzjpN430HpLUJySLuLwCnTijvhyXaLXhiVZeY6h27ropn/ycK65zEYhtx+2USANXjye8KLpfU0XtCwrtCn7ZbMjXbulf9PgIFhRfjPms1wapI++9PFRDZ1L68Ka+N7p8Cd5iyzGZN/TAzjx1Na+PhGeW9wYuf/Skb1hT/h+YaCdvVxmBQwMCCdD1XP9/obPL7JEZJOgND5GHv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhhei3ynLDI60kMK/EK6E1k04nfXzhOt5a4EFrSQrmI=;
 b=fffTLgjlzqtBsOGLUEVUnIRktv7cBgIJVsxZ3/wJqmlAxVocbPqWqxDR9IlRKyMnGoMrahfxYhv53AUAaajFVoyvJFLvX2C9TrRyNGyzu9CNQvMbZ6sbet2Mi2UiHCHPvzo6i7JvpuK6mj/Vjr5FVOWJ8w65vxa1IwDNm6Q7QWfx0GV6KWkpPXysvWj6qo8oewNdaZcdsK2GexJVCL1PXIQhMQrdaduU0NZ+OP7MXN4InLN0wm5jAAmVWduwwct6gMzjKOJNvXQjTVjh9KmnurRg8fxw1SZHuCJnZiFcorfjwmPMpPxAqdOJoefiIReHTx0eAiLesWlUWu0AI6SWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhhei3ynLDI60kMK/EK6E1k04nfXzhOt5a4EFrSQrmI=;
 b=VNHuS8RuICmjKe+pj1MNGDJzTb30vbfmsEubrKDYeMN+k03jfYNIIss9D1liHS6oLnQ83h3vJ6QUxgOr/q3tLVRUGat1Bfug/Qf2ILCYJPnSYibsnpkL/AOXCKGaNJj1FEpiHxY0/U2L/KBo+M49+npF/Wt+mputiwSptrPsuks8xbHr5so9ayGeq7AQfXosaNJoYpvUxJ/BsFd1XqInWRP4/uD4xcq2zrnoLNYx+tTg/g41MluBhn1du7KeObICpJ+6Ynuy8BoFzwjPL/nlfdh6pKMZtLYtr+ye4V4fKoMNjy/diXVU5F77fwgigEbirsEATsumUmDg7SYGYjnbug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:246::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 06:30:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:30:47 +0000
Message-ID: <bd3905d0-0e40-4215-a127-7bd791725ca8@siemens.com>
Date: Fri, 21 Jun 2024 08:30:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.94-cip23
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c98b75b-1b03-45e5-6842-08dc91bbaf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NER2Ny92ZUlmZFV0MzgvMXFWUjZIWEIrdFJUQmE0eFIxa1Q4Q2htTlNJempT?=
 =?utf-8?B?SGtmVUxSelhpb2hOK2xMVmtkRHQ0UldqWWgremRIMVArUUg4R3AwbUQ1aW1i?=
 =?utf-8?B?NjkrUnFOL0xmTityeDNRVS9kTXVBaGRQWkdQMmpHRHF0QkFzVmF5VWlPVkFZ?=
 =?utf-8?B?aWJMOVFWVExNaklLUVF2TnQ3bFR4c2pBaEFzTGdDUUZwZlJqZVNpNnl4TDdt?=
 =?utf-8?B?UHkzTHRYSHIyQ1owUHpudzYwL2VWWW5YeHlvSjhUMGowWkdTV2dYNjQvMFM1?=
 =?utf-8?B?aDZ4V1JnZ1NuOXQzUU4wOHI5YlNERUpLN3NTdFhqNVBlb05tTEFKTm1XcnhV?=
 =?utf-8?B?UThPeVNzakVJUjk2YWRNMGN4K3FmSnlHRkt1Tk5iYzdFTUM3bTYzVlVmbk8z?=
 =?utf-8?B?YUNDUHdObGxaSzd0WXlVaE16L1hQWFV0b0FUWERNUmNaczVHNTBENnl4MVFT?=
 =?utf-8?B?a25NbFMyb2tJa0NyS004a3dwRUtLcGhvb3VxbE9IMVZHQ2liSm5oOHNPTzFL?=
 =?utf-8?B?ZEp3Kzc4RFJWY1dOamFsM3dzWVExVTk1Y3NiZUxwZVN0dnI3SWdOQ1ZaVk9M?=
 =?utf-8?B?K3IyWllKTUZxS3ZNZHR3MERUWHlNeFZCcE5rYUMrVTdvaWZBemhkS1RKRllh?=
 =?utf-8?B?Z3A3elk4OXhJdE16bFdWWXVHQjNwT3lESkFjcEJOTFNRc1NvWTdkNEtMYWlx?=
 =?utf-8?B?d3IrRkRsQ1A5Qk03amZJb0ZiNVBKRmJEKzVjUklVUzhyYUxoYmFDSVdIbXN2?=
 =?utf-8?B?dTJEc0VqTlVWejdRcHlLWEpjbmZzMFR4SGVkd0F0OWE3YkVFd1FLeFU1aExj?=
 =?utf-8?B?SXFSWFBydWxucVlxVkRkSUkvZnZBNXJRU3Y0c2p6WUVaWmEyL2Zzc1lwS2hw?=
 =?utf-8?B?dUxIU29SQVVNRFVJc1lRZUVPcTRZdk8zdForOHNZTGlQQ0drckJrbmFkZDBj?=
 =?utf-8?B?bE1wSEhXSXNHQ0p3c1MzSWdCTjJ4dUNZeDhVaGR0R0ErL053R0JRV1ZXR05N?=
 =?utf-8?B?Tkd2WTV2NWRTQ1dvSHNzbHpPY2J1WTBDRkVSOUlBRXBBZFhFUXJDZ1lmSks3?=
 =?utf-8?B?dldpa1dETGlhdk5JVXVIczJzU3FSenoydGswU3hKWU5TYjg1eW9icmVvZVdT?=
 =?utf-8?B?OGN1THkwUmVEVThRS3dPMGpSVlBaSkVURTkzcHIzZ3d5bHRocFk4bmJRMk1a?=
 =?utf-8?B?OG15NmYxVldUZWVUcHVvS0hHZi9IKzNCb2FVWjB4ZDhGQ1ZaSXhsU1V3K1kw?=
 =?utf-8?B?VkN3SzJqMTJKQWxyK3BnMjluOG1zYmc3Z0o4TzRlNEpJbnlQRkV1c0t2c2Jh?=
 =?utf-8?B?TkhyL3pBNzhrOVNVWFd5bG80REZhS3ozUmVCSVdTQ2h2ZC9UbE5IcGxXV3Ro?=
 =?utf-8?B?ZGV2RGZTSFJSSTUvenFoUloxRmdHUUp4N2h4WTV0WFBXUlFvL0MrNC9raSs4?=
 =?utf-8?B?WXpUdXlMc3krZXBLTVVDT0ZHQk0wSEFuN3RaZjhIZklPL1lpaWRieDl3K08w?=
 =?utf-8?B?YVZmVG1hcjVYK05EeUJObUhBUXJLektWVE1UdHN0YS94ZnhmQUFaTHFsNHlT?=
 =?utf-8?B?aHZBckp6VDhzWkM1ZXpobDlGN1czVndBTDYrbWs5aXdxdEpVemtKekRFOWsr?=
 =?utf-8?B?VHpiMExNY1dFVE1ibWNuTjlmWDF6aExKRVpwemVDTzVlSU9FazdsMU1nMUgy?=
 =?utf-8?B?bkNZak1zSmp6ZmNxWmhCYWI2Y2Q3LzFRNlNiYmVSM0tmQzBlZ0VaS1VKUUMy?=
 =?utf-8?Q?1FnSBXz9b+D+u4VGHEPAk6Nxz/+rCLVPPU6AS6a?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bU80aTdDUUF1M1BOa3VKM0RhOVc2bkQwSy8rTlprVjdKK21KVDBHbXU5NW51?=
 =?utf-8?B?YkR1VjVjSjJFbFdHbm9JZjhtYStuRjBDYkVrM096ZkJlK016aXVxaTQrN2ZD?=
 =?utf-8?B?Tkg4cUNDZ1VUT2VNK3RVbGp5ajZBRXZvbStCb3Q0VjcvdXVNMUlHdnNyQWRB?=
 =?utf-8?B?R0xPU1BNTzZ1UTlrRjQ2ZnJNTW5TQ1FOWU5hM0tzTWp6TS9EaHdoWjkvOTNj?=
 =?utf-8?B?QmxXRHJrUkltUGtBMEhJWFQ2UWNIQ0h4REt5WE5tbzNIbnhndHp1M2tLZHN6?=
 =?utf-8?B?TWxqZFFnc0sxRjhXdk9oNy9VSG1MTFZMdHBnMDA4TUcvN3pVVDg1RDB0UU4z?=
 =?utf-8?B?Z1EzTHI3TW44eEZDNU5oS1RVczJuMGdNak9uWlVPNWdrY3VBbDFjdEorVXFy?=
 =?utf-8?B?NlBGUnlaM25XRlNCd0xJb1BHMWtyQStwVjl6em1iNkNnS3k3SVM3SStrYmFz?=
 =?utf-8?B?QURpTEVzR2FBNGpKWHRyWVdVbWt0YVBmRkxhWC9RQURuYllyNVBaTmpKL1VI?=
 =?utf-8?B?NDJ1Y203bEUwN05HYWdKQTVIaW1pWVNQQXNjbkxXU1VlNzljVnVWV1RWODlQ?=
 =?utf-8?B?QmdXemc4aHBUazk2Z1Y1OTJPeEtPZVFDNjgrSyt5TVBldW9tSi96cmtXeDBC?=
 =?utf-8?B?OXlBam1ycTg5TUFxQWk4TXFKOG1ZaTYzdHdjUGVrUm5FekwxeGhZclJSVlFo?=
 =?utf-8?B?aWlkSDljOXVkdmF6K3MxQVMzWFhrU0RpRFdwQVlTRS9XK1FBZUpySlMrcE9u?=
 =?utf-8?B?M2JNaktrN3dLanpDcnVuaGtKRFdyQzVybGxyZUJLTHd0cnU5dDlPOUREdHhJ?=
 =?utf-8?B?TVo5SjNZazAvVXlXNWlvV2dqaGttUVVnbFlOcGk3RHlpaGgzU1p1SzdNVXVS?=
 =?utf-8?B?NGtLRjc0dnpEa2tlOGFVMldjeVFiZ3NnYmtNZWQvVERIK2E2NjhlQTYxbmRF?=
 =?utf-8?B?YVpYeHNIQWJIZDUwd1lpRDNzbEVJMEtwdjJtcnJVdEduR3hheDh5TmsveGFt?=
 =?utf-8?B?bTZLWUtWN1ROVkNoVDhTWHAvT1B0UEw0cllTOEZ0cGNjOTZkSm11WkhmMmdI?=
 =?utf-8?B?aGtTWGoxUlNyZFd0Nk4rRSs3akRYQ2w2QklYTUVCUE5zNDEwVkxHcW5jSXM3?=
 =?utf-8?B?OWpaeGRGZW8xMEFQUXpheVhWdllVMGRiWExrWnRnK3pYVk8zNEtjSWFVbjcy?=
 =?utf-8?B?bkFKUFdZdDQ4VTZOa255cWdhRnR2RjJKWTB2MEt3UXZHbmJLeG9QQ1cwRFBL?=
 =?utf-8?B?a05XUzgwOEUzOUF3dFZJL1VjbS9FS3p3aENvNzRsem1rMFFMVThxYjFRb0pj?=
 =?utf-8?B?bThCMGJGRmhOd01PSEs1Y3dBY1FzZmNuRnB6Vm1IMUNzVER1MEZGbENWZzc1?=
 =?utf-8?B?UFpqQU5VcEU4blk0eXIzR0VPNW1qZEJhYktsNDVEVXNKYnF3M2gxNkhIU3lY?=
 =?utf-8?B?T0dOaTVycGI4ZEVzU3V3Tnc5N1VQZldiaktlS3ZyNUpkeUpBTUVqeHpVS1lw?=
 =?utf-8?B?UENEYWFxbWRnVEdDVWxUbUhMelFuUzRQK09aSEs5Mnl4SnFWNHA2NVF4UHU1?=
 =?utf-8?B?dmRkZEdqZVFqYjc2N3JSUCt5S2J6RUxsOW1aWGx2K0ZVcFJpd2tiaXdqbGhQ?=
 =?utf-8?B?TDdKUFBrVjF5cnlsNkhLUEQwNzVQSHNBaVNxZTBjRldtQ2JJVTFOaUY5K3Fo?=
 =?utf-8?B?SWpGbFFKQjZXUUMvZmc0UjA1eEwxZ3k4eUdvUUMxR2Y4bFdqa1FPb29RS2l4?=
 =?utf-8?B?K2pVOGl0VWdMUWJVSDkzWTNrR0RGR21OTEFjODJ1UTduSWQ3QlMyZ1JkbS84?=
 =?utf-8?B?Z245MU5aZWNVcklYaGFiKzkxNVlIekYxaW5tajU5MzBFV2R3eFlmTy8xMWQ2?=
 =?utf-8?B?MVFUdm9oYlh6VG5TS2RWWEoySFhYdVRxVmxFbnV2c0NEVnpIUjBGOWJQaVR0?=
 =?utf-8?B?eW9nRm4rMkRoUFBtZHFoK3VsWUFKLzFZNGNHaHZoQjdSRlJZUmUrNE9LaExm?=
 =?utf-8?B?ZUExSWt1MXFKbEZIVU5OTnJmdU5wOGl1LzZoVDhteFcyVUNOWGhiMmJyN2RU?=
 =?utf-8?B?dkVILzFmVjdEZ0haU1p6WkNSeTVsRnlGM0dFVC9IV0x5dkpoUnIyR2ZhV3pX?=
 =?utf-8?B?clhUdFhLSGl2aXNrVHpoaHhneWVFUjQ3TjFnTFExU29zL3NwVEg2bjdOaTFt?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c98b75b-1b03-45e5-6842-08dc91bbaf82
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 06:30:47.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaWZ3eiNkmdt9iB9MjKEWnf1MVQlWhiOcgpWqnjF4uIT84vAYpAvxbNY0oIBXrmMvzeFlGxDMdycJbr+b43Ijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5640
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 06:31:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16309

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_6.1.92-cip22.bb => linux-cip_6.1.94-cip23.bb}    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_6.1.92-cip22.bb => linux-cip_6.1.94-cip23.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip_6.1.92-cip22.bb b/recipes-kernel/linux/linux-cip_6.1.94-cip23.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
rename to recipes-kernel/linux/linux-cip_6.1.94-cip23.bb
index 556a259a..70e13005 100644
--- a/recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.94-cip23.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "b0fed0f35225f0d80d6ae7781ca37d5bc88910b84d44d17518bf0d7aa111baa7"
+SRC_URI[sha256sum] = "38c6f43cea9b703e979100c68169dd703f0fa04af7635ca01ffd1cd4efddcdc2"
-- 
2.43.0

