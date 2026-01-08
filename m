Return-Path: <tobias.schaffner@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC8CF6A86
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 08:54:09 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2550.1767862441127419062
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 00:54:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FQ8ekTVg;
 spf=pass (domain: siemens.com, ip: 52.101.72.5, mailfrom: tobias.schaffner@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKH1iWILvP2Ts3fxUULV2SXubVy+QePCPHp+HMbRSQsJGYaFdwsVByffoslqQawl5Ky1/TmUfrRjNnepyZYxAvXE1zlUnh/lweac0JjwtgGVpF0GXsporJtDkJNN3ErEzrr1DcgRQYD3C6rvfgGBvGc7Gc7/G6cyABScdYhoXxYwcoj7Wr10hXjkjSLZFbJGU5XY9zoxj9vfS+rn8kbdospvSLnjD7obCUJZKj5GwMwuhLKUh9QyUZ0GBmoyBEdNNnQP+EjU5hn0AdKOCFpRbgsws/gZf32ePoITkziCy9ewdZBsqcxqRNRlb06/BmP7L/2dCFmxUwd4bgw6r/5vjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eicJN3IbA3C4EusNa+sJ5c2m7IbNLd0DY1PH1f5gB78=;
 b=LGTpS26q2uLfJKALlubMhNSFSmuHZKH9yfWZtclEdHjMDyWNa0HCuvxx0nEvZw/UNXDujfLxj8t8fPq1zzrKuUOFF/T2wbr9F9JV+aenyMG/jtKpOof3IHIkOvIo7U+T2V8YIjlrgfjNUB/nvsSaBVBYppqznetn3ocxe7cGIIwAgHE0PFmHQ5ipFvkEDPiFrPZEa6tL7wACYS/tlO1qD2hjIM5F8g+z/tM01CnttqLcU3rkE9GGIy11U1TDNh+GLxJA16CEaMUY1ERLCN2Xsiuv5eR7A/4gA7a90KvfOXqIlHn5KExevC8ZIMBCvGiYfvkmLzBRarPcH6HRNXOTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eicJN3IbA3C4EusNa+sJ5c2m7IbNLd0DY1PH1f5gB78=;
 b=FQ8ekTVgzAANcs57k58fMQoWbHkZMUsMH9sSBEpXdlcuTz8TwZBMAGfRsEvOtdZ0CLSFrOMrRamzwgQjq+x4w/DDgbbJsRdHgSuHOs7uVunVccTxxt6XqWMt5/K0xPMrMDpr9BdeiZGiWbST+pg8s+k/MdiGc2meSsrU1p27tDKPU3yjzPa/4VMMFoLGt19yVGLczrGDkFnm8I7F+vb4VkYL3PU3jgOHVr6swb0Icc51uA0U3LcoVJaG7Uil5kzwpJXa++IqYkdHVfhS2FIAl8DksxaA5Nau0UOSJuFpag14IoOwC+awSIO3e5T9JJWBf8p0wmuteux7YTwWOoperw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 08:53:57 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 08:53:57 +0000
Message-ID: <36dd7fca-98e9-49ab-8dca-14a3997d0c5f@siemens.com>
Date: Thu, 8 Jan 2026 09:53:56 +0100
User-Agent: Mozilla Thunderbird
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
To: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Jan Altenberg <jan.altenberg@osadl.org>
Subject: preempt_rt on BeagleV-Fire
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0297.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3733:EE_
X-MS-Office365-Filtering-Correlation-Id: 9201efba-fb37-49f7-3c61-08de4e93756c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?dlR1bXBqcUoydjlva295Q2VqQjZyVHI0WG8xVWJoRk1TbCtNK0NNRUFMZmRa?=
 =?utf-8?B?MVFMUW9Wdi9mdmo4Wk9ud1pFWWdMQ0kxLzM1TmVIdGZtMzRod3hOTFZZdU5S?=
 =?utf-8?B?UTZHeHZuektPVlA3WHVWVGZWYTlMbDJhSXN5cFA1Wm1MRVpmWGJhUWJkbVRF?=
 =?utf-8?B?dlJ6Wng0TkduUWVOY2xqWDcxRUt2ODFabW95NWRwSjhtTFB3UExNVkV0cUxI?=
 =?utf-8?B?NU5vSUtheXIrWXp1MXFydUlaRWRGZmJVUHQ5YStqbWpBbVdYTFB3SWxxa1lr?=
 =?utf-8?B?ODZWUjVyNXJQS3dPK3dSRW5uU1pTekhacE0zVmpOV3JRTkRmN0FWTEVsYkdT?=
 =?utf-8?B?NUxzOWNWVFdVL3V6VmczMWJyODBsNkd1cUFJUDIwbFhnRStoam5ianBXUnA5?=
 =?utf-8?B?bmxUV3J3L0pMeks5OVA2U3U0K2FBenFHWDZIdnBTQkFLYURJNkFGekRrNlRS?=
 =?utf-8?B?VlIwbk9GdVRyVDlXZEx4VDBRQmVmUWVFbjg3RmhMdTNwSkpKMjljdTAya2Zr?=
 =?utf-8?B?Rk1iRi84SGx5aHJLaERpc0RDSHNaMDJZai9xZ1dBQndGMWYxMkJaSlJOakVj?=
 =?utf-8?B?dldMNWNuUldOSGRSaDBwUDRQYVVPMmU2WHFlczc0NGV2R2MyK3JMMEZ3TE5D?=
 =?utf-8?B?b1dWbGtRWjlxMEVYNFBHMytmY3NVcmQ1UjhxNUxnM3pndDVwbE5mc3dWaThQ?=
 =?utf-8?B?MlRQWU43Mi9LeU4yanBhQlI2R09QYzlLOWJyRUdjTFJGSWVtTmVZeVpoenlL?=
 =?utf-8?B?TjFJdmUzMDI4TWZHQVhpdS9uYm1XZ3B0Qkg1ODA5WWtHamVSenNRdURMSXk0?=
 =?utf-8?B?dENmbVZpaXRpbHVidlRHd0c1MkFteUJpRllNYS9EVkRWQlUzdU9vSE5CcHlR?=
 =?utf-8?B?SEt6MWVNeGNMR1ptUTJMVld0eCtubTYySWdZR0s0amFLeGM2c2V5QTBTa0pI?=
 =?utf-8?B?VFJFM3ljL1Z0eUVaeHZ3aGJ3ZzVxVDdNTENySG41WllrNWI3cjViSGowZFpu?=
 =?utf-8?B?WS9xcVQrMWtzaTc4RUNsMUNHdEkvVXZEZDRzM3l0dmM0OURya3VvUldxVjRU?=
 =?utf-8?B?cFN0YkF1eGFobjRQclR1aUFhMjdoLzNpcVFJL3N4eStDTmR6QStWMS81Yk1m?=
 =?utf-8?B?TTI1eUNQemdWczI3UjQwMVFwTHIybFl6NFhMV1U5ZlVxSE9JVHF4d0RsL1Uy?=
 =?utf-8?B?dlZSVHlhMldWVXlVY3hHanRtYlh3SktZdjI0TmhpajB4Z2RVSlREMzJkRWtn?=
 =?utf-8?B?YStKYkRlZytPbTU3MDZLU3o3U2ZEYlRsaFpCdHJaNTk4Z3hoOVdoWTVTazBZ?=
 =?utf-8?B?UFF3TWMxdytjMXdJandPVVZtTHBKek5EaWJJK0R3b1F3SzZWK2hPVmZNZHRY?=
 =?utf-8?B?eTI2VDlmVG9tSEh4bE5SRmVOZ1BRaGZHWlkyWEFKUU54ZytqK0JnMzgxREt5?=
 =?utf-8?B?V091REh2c3VmWHJCOVBDMEIzclFHeW1oWXdRdnNybEpFMjhNa2VxMENCZEMx?=
 =?utf-8?B?eW9nNnRyZmNiRUpjazZ4SktNeER6cU83SlJUOC80SjRsbm9DV3FyeHZjZ1FS?=
 =?utf-8?B?VVN6bWRDdUx2czhjbFZYK3lndzd0TG95YWdkalBNV2FGRHZDNHlRQk94NU9T?=
 =?utf-8?B?SHIvcWR6VjM4bmFSRkJURjZlcXdjVkdRZnAwVW54OWNTYjJNaklXUG5hM0N5?=
 =?utf-8?B?VHYxRjlJczR4cUwreUFnQ2M1bjRZam1hWG00cnEzK05ZVnhDUlBDU3BITTBI?=
 =?utf-8?B?SXBpdFZFM0NPTGwyQU9WSk9FZzk0WC81YkZsL0U3Wm5lMXhobkRaUnVnOGRn?=
 =?utf-8?B?ME9xQ2NPeEdiS2ZTYXRQT3ozc0ZWd1UxTm1tQWcrZWgxcDcvMytwdGJDNUpU?=
 =?utf-8?B?aFBRZ0tmYzg4ZlFCU0RJQ3RRK1ZDOXFoeGozWW5LZFZybVE9PQ==?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?ZzAvT0tJL2lxZzU3TTNGcU8xMS9YZFN2djlBUTA5VmwxVmthVllqUEdCc09B?=
 =?utf-8?B?aHRnOTl2R01VL21mYnJRdDhqUUpoNVFmT0h5ekNvOXJYWERWeFVTdVdabkIr?=
 =?utf-8?B?djhHVllURlF4NHgzb1pseC9XOEN6cm13YUlFeXo5MVZudmoveUQ4MDZ3ZnpP?=
 =?utf-8?B?MGhZSDFxd3lKdE1ic1ExN0kwZm9VUTVxdktFQ0kvelJ3L0VHVW9wK2g5dTRT?=
 =?utf-8?B?cHpIS3oxMStOa1lhWFU0RVpZaHNoTUdmN1laelZlOXgyMXFiQlB5OEdpN20r?=
 =?utf-8?B?bGRmS2kwV2ZIanF3M1dXZFZkUkJoSm1WWkd0bnI2ZUlObDRndzlzTnFTWVN4?=
 =?utf-8?B?elpNUWdoOVA5L1lhMUFzcHo5blYwNnp6ZE0wUDJ3VzJnNjVzcmhESmFZZFMv?=
 =?utf-8?B?RHFYVGZ4dG84NXJDL29Zc1d2SFFsdG1nOTRiVGFNQVgrU3NNU1J1STBJZTQw?=
 =?utf-8?B?MVZncUJQUEZRaklTMXVlL1d0QytTQ2N3Q2ZRdkh0MHE0cWRvVUJ6OFBqSXVt?=
 =?utf-8?B?OVB5NVp2bDhYbXZ0QTRyUVlNYml0UFprWUUyenVjV1RKOEJuM01ub2Rud2x2?=
 =?utf-8?B?emgwb1IwMTFUNHliemNncWtnQWZ6c1NBM1ZqZ1N6UGpZQzRpU0p3NFlXU3Zk?=
 =?utf-8?B?RTdkRzQ3NzdNN3FBYk45cldMdDl4NXd1cDIwaTVBcHZlMzBPMWZ3ZWJ6Q241?=
 =?utf-8?B?MzNKdGRUdHRWS1F5ZHJTVEVUVUJEeC9hYjJjYi91SUJHKzdWUUx2SkpCYlhB?=
 =?utf-8?B?ZXJwU2pNUFR4ZHpQcytFSkF0dk0ydGJWUlVvT0I1NkR2ZU5CUFMrSU9Yd2ZE?=
 =?utf-8?B?amlEZnZzN0RidTNPMEl1bk9GeHhocU9YdVp4OTRxdWRrc3QyQ0lJR3I4WFlS?=
 =?utf-8?B?Wmd2Uk5wQ1dsTFd0YVBaV2JTa1JlLzE4UGF6U0wzcms4bnkwWFd6b1VMSWtG?=
 =?utf-8?B?Z2pPOUlRa1Q2RHAzR2xIS3ZmZnpSNTFJYzNSN1FId0tUa28yUitITG44Tkdv?=
 =?utf-8?B?Z1h1K3I3NkJzelFvdmdOV2s5YTFpUXh3WU5ZNngvcVk5TFMzZzRRZHd0cHI2?=
 =?utf-8?B?dlpTdmxRdXZYdCtibU8vZHBZd2tyTmg1cElKYjZaZWFkWG9oZGJXTEVlWTlC?=
 =?utf-8?B?R21kcTRKMTNQWm9uenBPYkRTcmoyMnBLb2JEQUZYUjZkdWNkWTFKd2dLMTRh?=
 =?utf-8?B?M2ZUWFk2VDlwcHZOMjh2cUc4NEhYMlYrTmdmUjNUVXk0NXBiRkJUL0hIM0hX?=
 =?utf-8?B?R3N5VlljU21ZOW5nejlHRmo2L3daNFpCRkFRdU1jejJGTFlNWTFnYmdTUGwz?=
 =?utf-8?B?M2k0SURPaWtveU9kQnNxQmNVdEZhQkY2L1JleGxJTTY2a1laRUtoMWJFbHFU?=
 =?utf-8?B?RXRqN2Zlc1hkeUx0dGFEVmY3cFYrNTVSVWFTS0xSRkhxTXU0eEtVSndLZ1kw?=
 =?utf-8?B?SXExVldOY2pBTzNpN090MmsvTlFLWDViQnVkOWxQenpyb3FCYmxzejdTNUFl?=
 =?utf-8?B?SGlVdkFrK2JEcXJtaUMzUTlwZFBReHBNZ2M4OFB0MnZvSkt6bzhkZjN5QXFz?=
 =?utf-8?B?OVdlOFBHVUEzWWdwUEVKV2pYUUJ0S2ZhSi9PS2FlNS8vZ3Q4S2Vjd1J6dzNw?=
 =?utf-8?B?eTF5TklGL1ZiU09idWpDZVJhV0NnUVVrWUtYUFFadGF5NmRrNDQ0L0lqMlM0?=
 =?utf-8?B?amNFb1VsanZ3QndROGlKTlRacks3bzBUdThGVis2T3N4T29uM0dMeFVvMTFJ?=
 =?utf-8?B?MDNjTFVhaVcwL21Nc0FhNXBITDB5Qms0QytpWm4zaUVDQXNZVFFNVGFNMmpk?=
 =?utf-8?B?V0NScUZYWFFHT3RRQ09aVmd3clRGSWdYSDVwcW13eVRrbHo1Y1RQUGlGV0Vv?=
 =?utf-8?B?R0d1UXFyNmUzb3h0OFBpRk1YdHdNU1IyeEFZUWlFRGtsZGxEY3krNWhPSWtk?=
 =?utf-8?B?VnI4OENMVkU4aGNvNGxCNDVvNjV1Z0JJc2IzSW9VMENpd1FObHY5cmFvNzRK?=
 =?utf-8?B?VjFBT1VYRzBXcFBLOHY1TlJRT2t0RGFiY2hKVEZzbzZhalV1NlhldzVHb29t?=
 =?utf-8?B?Q0lHdCszMm1RS0NmSUtDdG05TjlyRHcxQmhqNS9jNHN5MlVtVXFJeDhuRFBC?=
 =?utf-8?B?RVc5YjEwL3l1dFZ1SWRveGNpQ0N3Wm1KYWswMEh1MXdiVGpWdTkrTVZINGJ5?=
 =?utf-8?B?aDhrUUg3aDIxdlU5Rk1wK3gxTkNHbjkza04rbVQ4QXN2TXN6VkRHR1lRU0M0?=
 =?utf-8?B?YkQvMXhWQ3pzdDlneFg0Y0F4cnFUbHpaT1dmem12STlIMW00d2NDOGsrdzl4?=
 =?utf-8?B?QUlrQVFNTUMyT3J2YzUvZWZZOVlOeVZGSWRwMEh3V0JkSkl2OU4vL3l0TWo2?=
 =?utf-8?Q?os/gbyar0aXW5k9o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9201efba-fb37-49f7-3c61-08de4e93756c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:53:57.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxEPUpHqUfyF6zqHQeip7BkibYjtBJMdnXUZoW6ACpAusjQCf/IUE6PaTllY82eMBJd91CzhNTxF37nVpxl1uSz/GI8GTrpliEUPeaoOz3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3733
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 08:54:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21435

Hi all,

has anyone already tested preempt_rt on the BeagleV-Fire?

OSADL has evaluated preempt_rt on both the PolarFire Icicle Kit
(MPFS250T) and the PolarFire Discovery Kit (MPFS095T) and has reported
rather problematic latency results so far[1].

Since the BeagleV-Fire is also based on a PolarFire SoC (MPFS025T), I
suspect we might run into similar issues. Any experiences, measurements,
or insights would be greatly appreciated.

Best,
Tobias

[1] https://www.osadl.org/Latency-plot-of-system-in-rack-7-slot.qa-latencyplot-r7s2.0.html?shadow=1

