Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F304C27C54
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 15:35:23 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.66])
 by mx.groups.io with SMTP id smtpd.web11.17806.1717688116837841605
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 08:35:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BcFLfLw9;
 spf=pass (domain: siemens.com, ip: 40.107.6.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5CRxrXn4d9P2W09CiDxKlwMZKlKZkCYY0g/qRy8oO8J7Q06ppWK1TPahYFKY+VzniBdEQKn0hXVFdHxwhBBIO7esplq2QNKpVqhw2xebOFb/HpGWWxF0H7mD7myUhUId18r3wPGnjyiRNHTcm8sjwM50VZczZscPh2vt2NmeO1t64szqmXiJO9jN2TzEEXZNGEFthVTFE7nMVmYn+prLmJtTJ/vtsegGMGHabXqlif13HbSv7Gy08pAeHVbY29lkwu6FtgmSmSXBUigX13nEsV9WeMt9P3syd3p+qPHsKU4sjbzT0DCNYd1Tbdt1NBse+laX8B2rDz56RR/BWjn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlpbVj5dDG739bID5/Jz/8b+OKkxSgJlAe1vCteE8Vk=;
 b=lvppDmmDj3+W9fK2bZaMnS6CrG5P/WvjSk0OkjDNPj8QsnM5bNounOsx3NbwcfHxR91SCW0q4r+3teGQNE+Plmp/+OTPRZMsptIApY/Gj7MDYtwuS75WQ+Rw0ZSRw3qYeEJHRoVBZOH6HT2F89qBTboRJJxH+tOaF7pvm7MqVnfraHNmosa6U7Yo0cZ9egeO8OPe1cqg1YP59Ttl0O6fEHAp0AOVS8EIn7/V8/nSN9KXUBq2QqQqKlWDn0sHm0zWHctDmO0CMGhlsfFU+S0k+mRteDdde76LrYOEUKRQo6r8zCX3/DfLq+MnkhpcV0E0bEWSrr2B/E6gVuIACws22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlpbVj5dDG739bID5/Jz/8b+OKkxSgJlAe1vCteE8Vk=;
 b=BcFLfLw9Zi+r291HS33kX3e3YZBVzs8DWm5HltBHYUgx5Slm8Ziu+MEk1GK2IVRHMCZDyzWxH6zGlIWGrW/Mfq6xLHIMFe2lzFvNn0y7fecBgRc45UHH5kWAf9mcBWVqT9PU+oG8baAIbybL4muOWfm70g58MQiVhUGNCekaUiLn9M15D8btzdlk+nFW4eSBhnmH9Q37awDfLSyM2sVGIax7U+o5wWhGVObtO3vqg5gGu+oC5hTsJ/Uu5H1QN0Kbbgl64FSo9ATOYZ23gSSVfnKYUqdw8sFEWLQpH5t3RoO6BCIZ9tJvI9ygKieS8SU36rBZq4Cb6BGdrvVVvgteNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 15:35:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 15:35:13 +0000
Message-ID: <9a6ba75c-e8d6-4f31-bc9a-7e3f458e6165@siemens.com>
Date: Thu, 6 Jun 2024 17:35:10 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to 4.19.315-cip110,
 5.10.218-cip49[-rt20] and 6.1.92-cip22[-rt12]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3749:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e6a173-4a29-437c-f5c2-08dc863e41cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TlpFcTdYLzFJU1lqdXZwbkJBSTRWZFdwY25DWkQ3RVM3OHhCeXNwNHl1REVi?=
 =?utf-8?B?RkUrR1VMd0hpalVtOTRaY2RzcHNGK1V0UFBIVVNkWlU0VUlvK05RM0czUzhm?=
 =?utf-8?B?SlR1eFJUQkxkbnB1MU9XSWNpMDZkNEN1LzgxWlhtRVJ5SnFUWXJGZnNudFR3?=
 =?utf-8?B?UHc0VUhTb0NHRVN4ek1CK1l4R2dscUhYVWZiNnk3UkhhcVRCYkRJNXhoMU53?=
 =?utf-8?B?VHVrclBxUWVibzJPNEtCUXBRclRqaVRGZFlrajFKRUUzZmNENFVZZzdYQlQ1?=
 =?utf-8?B?ekhidnlsYXlFamlKeU9aSlNvWFV3Um0yT1VyekpjOURPNjdMOW5oMFJzZkJL?=
 =?utf-8?B?dk5oUFdDeWpQeTV0WmpnUVQ1UnArbUxlTHIwazZodm11WnhXVDZ4QkJwdkkz?=
 =?utf-8?B?eWRtY2hPUm5HRExiQUZFTVhZbjV1VDlkUTBUUUpQdU5GcDkreU9zWlNLUFlT?=
 =?utf-8?B?MGNNcFZCTXNjazluL0FpSUN3OTlKYXEvaHhIZnlBSDRacS9idzg5WnJLZWRj?=
 =?utf-8?B?RSs5WnZuVHFKZDJKdHEvamZ3djZ0Q0hTNXBxZ3hGR0xLQkkxb3lwWFNqclQw?=
 =?utf-8?B?YnBkVnMxc0xhWitVSENGaFBTT0hQa0Q5VFlpMXUrSmwrUzNIMkdGNjB5N0VR?=
 =?utf-8?B?cGg5QmUrbXJPN1lIWVI4QmRmTTRDQ2ZSRG9xdHVHdWdnTkVscFNJNmY1eldE?=
 =?utf-8?B?V3dKV2FSOFJuVmp1bXRRdG1KbDJSVktFK2Z3TDRCbWo5dThzWjh4dmFwVHRo?=
 =?utf-8?B?elhNd0FFU3EycWVVaU1rVWdFZ2dpUXZ0aW8vM21adCtXWjJaNTNJUUZoZGtk?=
 =?utf-8?B?NUcwN2NySGcreHhXVVgzSVFOTGZhTVdGa29yRnhWa1J1VkdMRVhqbGdpcWo2?=
 =?utf-8?B?UitwREJ0dTVNNHhVWG9INWpjcVJsYWFXeXAvVDFmeFhwNkRqZEY2QWN0cld5?=
 =?utf-8?B?bXF2V3B3L014Ui9JTlllYlpoZEp3NVFEbVM2YWZnVHVxS1Y4SS9ib1NLWEhw?=
 =?utf-8?B?L2Y0djUrNVZyNzNCd1RTQVppcGJtWU9hQkZQSHRVS0JER0FGMHAzdjVGZEl0?=
 =?utf-8?B?MkgxTENRcTNqSHgvVjRZcTlYTjk3M2NJa3VKL1FxQXlnUDdXaWk3ZnhOTHFQ?=
 =?utf-8?B?dXBMUG8vc09QdEVhVlFUQWFwZ1dhZXcwR0lRM1RRZzg3SEM1dExJS1VUMlE5?=
 =?utf-8?B?QTgwYUNwNXZtVWs3bVAxUlFpQVNKclNnM2Nvb3J5YTh2RWhzM2wzK3c1cWp5?=
 =?utf-8?B?YndsQ3NEekVrajh5RSsrNURQcTdkSnloTS9TSUNjOUZCTUw1UUJYbjBzZVFY?=
 =?utf-8?B?UlkyNTJkTTBDRDdwZkNMREo3RWI2a2o1Z3ZXTnc4OE9CMDRSUWVkZmxGcU9x?=
 =?utf-8?B?MGtsSnBCMVpIazR3aXgrZUZyUWtlL2NRVkJFK2FXRDl3SGhjaWJ4N3ltcWZo?=
 =?utf-8?B?MEJ0dWs5N3V2SENjRVdPVW1Ma1YwbW83Y05ZbFJHaUtJNHUraFJIU21YM3Vu?=
 =?utf-8?B?WWhnbGZmRWRCQXlJRlF4Z3krTTNObW0yNkY2YzBERVlSZXQ1R04vd252WERv?=
 =?utf-8?B?QWJIUnVWMUJTVjRURnJEazRPZ3ZJMkVXa2hBQWZNV25ueVlnc1FDaEN0elZS?=
 =?utf-8?B?Y3BYUVY3eG9iWVpsMWlCTGlkbmJIN3VrMWpGVlJNOWV6bU1TUkVqWkZWTEFE?=
 =?utf-8?B?eUduWEU0Z1BqdFRJZmR6bWtvK3cyenNlSVBJT1M3RnFYcVBTQjRsN3V0TzVw?=
 =?utf-8?Q?7crZUV57i+zO3aOsGfLW9Okuhx79+ik9EDV78IN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUFuVWJFd1NScTlsYkhZTjI5RHd2SVFTRldwQWhwYzFPOFBzR1ZONjR3bWNG?=
 =?utf-8?B?U1NsRFZJWTZtemlpaXc3bWhvQWxNUFpka09YOGs2RCs4WlNDTUNRanRkRTRL?=
 =?utf-8?B?RWR5NVJROWwzbVFwelE3WnN5RGRNNG5uRHFlT2hSUUFmWUFFOXZKYmNlUzJm?=
 =?utf-8?B?bWJ0ZmhnWlozUHN5WUM3cVVsVDdtZXRTNGtDdWZiVXFJZFc3emV1WUk3WXdH?=
 =?utf-8?B?TVZ1eWhubVBBRTBUbTdqakF4M215aGl2MnFTK2gvb3R2UkQ0NW9tTWxQQzcz?=
 =?utf-8?B?R0EzdFEzVGdjVWhFSGdoWnJJRy85T2YwVk83SHEwblE3QUd1T1dpZFBZd3p2?=
 =?utf-8?B?Zk9sZncrbm1zcWhCZ1U1bWMyR3BQaVZkeUZlTi93RmdaTXhBdnROWGtaQmdo?=
 =?utf-8?B?QU9oTlU2ZmY3dHVqUUk2Y2tZZ3pWRjdyTUpSb054N2JJamN5ekZHT2Ywb2JK?=
 =?utf-8?B?WXhQZW4za2c2ejRTNGpFSXNFWUltT0MzQ3NtOE1xdVhvR25wMDYxUmlCOXlV?=
 =?utf-8?B?ZTk1d2pGZ3NUY0hvQUJmMXdaTDI4UjIwd0ZBR2E0MHM0SXJENWNqRHBUM2dU?=
 =?utf-8?B?V2VRdEpkdjE1aExpNmRuMG1oa04wclZJb0tvUEp1VEdQWTNMMVQxenJ4NWRD?=
 =?utf-8?B?N0JhRTRhZnhWZGIzMEVwanZLWXJ2L2xzTEFWNjBJWDNuakxFdGRUZTlQL0w3?=
 =?utf-8?B?TXJaTFNQaGRaOTFlT3V6cHdqSTBGNmJaZmV4TXF2RG9LamR4MDRDc0VIanZp?=
 =?utf-8?B?SVd3ZVVyTGVRWlFxYVNVaFhmcEZoc2ZER1dhWVRmNVROTm5ocmpYdm9TNldR?=
 =?utf-8?B?bCtGQkZGaFpBUXJQb3JGcTNNdG1oeXRFcDdNaFVtQ1hDYlRkYk1qZWQ2Njc4?=
 =?utf-8?B?WmRGdDVzSlcrTHVRVkE5R3M4SXZOWE4yYWFETER6R2trbXZsWUVTRy84d2x5?=
 =?utf-8?B?dE9QMVhIZGJqRUpSMjQ2aTlPVWJjZ25iNDB1dmZDeWZDdTFUczBJeGM3VmZS?=
 =?utf-8?B?MU5DeFpPWjJzMVIxNk95Z3prOUdLOVRjRE9FTmxTL29WaVNkSHJQWE1ibGh6?=
 =?utf-8?B?MXdsUDFub3ozZmgzb2JnNmxtT3pKUExWLzhLYTRpbDRZZTNUZlRLL3dkMjVo?=
 =?utf-8?B?TDUremE2ZnNMczNNbmp6RmdPMnpUbGNQTWpJK3lpUVVMeURDRVhjald1L1lT?=
 =?utf-8?B?OGtscm1LQ29wdTEvU3hTck4rQXpqa0Ira0hPdmVZcGhTUmZTMnROOTlCSmVU?=
 =?utf-8?B?NkRyeHlselJDZktXSFNzU3ZMOEt2Qk5BTWMvVFRtMDlxMXd6RFg2TkEvemdM?=
 =?utf-8?B?ZFArOExmYlNPM2M4RWVNSmVsK0xxM1FhZmsxMDZhMDFWNThWUG1SYnJtM2sw?=
 =?utf-8?B?NzVuQVkyZWFhN3ROSUxmVXI1REJuU3J1V2hWdUtzNTN1aC85aW5ZbnJKZTBs?=
 =?utf-8?B?ek84QlV1SEQzV1hoSHRsbjhEQmtLcE9hMFJHd01RekFpM2F2ejJLd1A1Q2hL?=
 =?utf-8?B?NjBKbnpNSGIzWEx2UkJ5N1JxQVNWb25BWjdMUEtVUW0yS2pMQlBYTmx4Y3Yz?=
 =?utf-8?B?NXYzbWRkZVBxRFN4WHRtbkVxMGo3dDRMWnNuRUh2ZkZVU1pZR2xMVmpSaWxD?=
 =?utf-8?B?cGlHaUtaaFlaMnVEUHM1YUgzUno3Tm9TVXBlOTlNdWdjTTFOejhUa05ZLzF5?=
 =?utf-8?B?T1g4K0lLcE5nUWl0S1pWdzcyKzlOcEZJSmlmWUJKblUxTklVb0F5ZHAyVHVl?=
 =?utf-8?B?K3o0OVltbHVvdWw5c3dQWGpHSFZCTm9nSlg2R0FBSHpsS1hUODZwQWFPT3Vr?=
 =?utf-8?B?K0VxSkdtYTNRMW1zd2VCTloxd3N3bjZFdWp4eXM5OXZoMEt5L2VKQm52NnJZ?=
 =?utf-8?B?MjEzY3VTQStWbkJqclRuYmZDYVhSUXpoQlJRYThOVnNkejRMNXpFL3MrODE2?=
 =?utf-8?B?SW9GSHdGYU9venpBUlBucWhKYmFmblQ0QmppTnVQbjcxeXY3Mnk1RWJaYkdn?=
 =?utf-8?B?K2F4L2JmcWpwcHFveHN4QWtyUnJoV1NEQXRwTStTYnR4aGYxWEtmbFFNUVhT?=
 =?utf-8?B?dTB5SmFKVWNPTklsTFJ4bnQrMDM1UlNKZUxKVWhORys2N3ZJdm5qUm1idS9X?=
 =?utf-8?B?dWhYVDdVaUZqcmtrT0JHYzlob3l6Z3puZnhnTXc5QUQ1dzUwSUJFOW5kdU1x?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e6a173-4a29-437c-f5c2-08dc863e41cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:35:13.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0ejDBCbCM+ttafG/i7bWE4NJGIL80eCrZpjwB4WwNKYwc+WjkgePPAPyKZnPMR0FY3q+jEb8weQBts7wP99fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3749
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 15:35:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16129

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.214-cip46-rt19.bb => linux-cip-rt_5.10.218-cip49-rt20.bb} | 2 +-
 ...ux-cip_6.1.91-cip21.bb => linux-cip-rt_6.1.92-cip22-rt12.bb} | 2 +-
 ...inux-cip_4.19.312-cip109.bb => linux-cip_4.19.315-cip110.bb} | 2 +-
 ...{linux-cip_5.10.216-cip47.bb => linux-cip_5.10.218-cip49.bb} | 2 +-
 ...ux-cip-rt_6.1.90-cip20-rt11.bb => linux-cip_6.1.92-cip22.bb} | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.214-cip46-rt19.bb => linux-cip-rt_5.10.218-cip49-rt20.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.91-cip21.bb => linux-cip-rt_6.1.92-cip22-rt12.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.312-cip109.bb => linux-cip_4.19.315-cip110.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.216-cip47.bb => linux-cip_5.10.218-cip49.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.90-cip20-rt11.bb => linux-cip_6.1.92-cip22.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.214-cip46-rt19.bb b/recipes-kernel/linux/linux-cip-rt_5.10.218-cip49-rt20.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.214-cip46-rt19.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.218-cip49-rt20.bb
index c1e29d61..7a8c3f1b 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.214-cip46-rt19.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.218-cip49-rt20.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "2126bec23051ca89a33dee6a2521d0cf07404d5ae7a56b48a4e4421655601175"
+SRC_URI[sha256sum] = "ef97669e8f2a06299fe4e25890229548b2da83cafad887f202fb63947fb41723"
diff --git a/recipes-kernel/linux/linux-cip_6.1.91-cip21.bb b/recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.91-cip21.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
index a0095dbe..86f18e12 100644
--- a/recipes-kernel/linux/linux-cip_6.1.91-cip21.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "fb1ddf33bdadf8a03a72824e3ed9a6e0f74247b8ed00ff41611d08ed3b31ee2a"
+SRC_URI[sha256sum] = "bf7750b483488f7e272043a64c0075121f355c44d23ba7a35190e25fa7a6000d"
diff --git a/recipes-kernel/linux/linux-cip_4.19.312-cip109.bb b/recipes-kernel/linux/linux-cip_4.19.315-cip110.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.312-cip109.bb
rename to recipes-kernel/linux/linux-cip_4.19.315-cip110.bb
index 34cf1e0f..98c9711e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.312-cip109.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.315-cip110.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "e0883a7fc1fb6137203aacb504c65d126d256c1ca6fbde8b3103375c6264f397"
+SRC_URI[sha256sum] = "12b2ff61f305151f324b6d502ae1f52ddffeb961a7bac5d60eb250928c666383"
diff --git a/recipes-kernel/linux/linux-cip_5.10.216-cip47.bb b/recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.216-cip47.bb
rename to recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
index 9d769a87..b532d408 100644
--- a/recipes-kernel/linux/linux-cip_5.10.216-cip47.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "aaffc76f59d327387e04c5bcd04e99bcfa8d0c692cb6190a30463eec2e6401b2"
+SRC_URI[sha256sum] = "b9ea6a4f6f7f18d3d1abad24be311e3dcbf4b1ce3d08e600eb100a46b069b0c4"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb b/recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb
rename to recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
index 3a8f5720..556a259a 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "f26ae423970fc99cb4c4bc5f69052b39a7255212ae4790450eee935446f229b1"
+SRC_URI[sha256sum] = "b0fed0f35225f0d80d6ae7781ca37d5bc88910b84d44d17518bf0d7aa111baa7"
-- 
2.43.0

