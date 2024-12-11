Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BACE77182
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 14:08:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web10.11729.1733926113956075505
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 06:08:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GefHa9pn;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAJaBZ1zzb/Drl+S01aoQU8JYWEWsLDVCaJS2yOs7tzFRh8e/mv0EYbfHbqlCyBXL4Gn3M8ruafZgRmLeRJz9/59Wuk2HuYeJ1UXTm7DAuWHeszJ1/dWYtVWujSbDLb6epJqBsYs0vO+qYqoOICyy5dsu7FzcP/+DQRK4/kMBs4ovd6vBBggYPSuHV9iP5Jpg10hcFZ+DecX6844hzqfKUASwU3Zy9FCJZoqFnRmM2DJ/7XaHguAddYCAd5G2UB3f5HGkhsi4ikYrzQKjirYM1za6CqPWeL3k/CPA32hBKGpWbbrDVu8gEdwleWgcMO+vSpxT/zb86fZRaXaK2dbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5jAt4/TmmW1Zsk3IGNnMVlETJcT2hsGaxHp5YqDgBc=;
 b=bHLF6IeSmjobJIIV/YvSWKOKok0p9xuVtzNxRb5Rb6WQPxpxCk/PFMu+P9BXXNM8+rtR7kB5717TYrYtJOTtZe50Ol2X6slJjijV+OmblKX1EqDcksg+v4cbVR+bamMCBxvocpdECqXyMERXHKdoLrO20yvf7VB6wij4CZsFrGohFad4pL+QPU6l+H+W4O55bfgsroYPrUJoKkU1vtx8iNlBNBIKhUgZ4RYRJF/dsbnTqD6FQmiy+/sU6n2WfjF78Y2sdp+VIzzN/Su6cn2cDAAp5f7KLra9EB19K1pmhfrR9EWoL7e0fPQdleSEHtLF5YGZXIn6+QxLbuqy1c2hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5jAt4/TmmW1Zsk3IGNnMVlETJcT2hsGaxHp5YqDgBc=;
 b=GefHa9pnhbKTyt7aDhRwKF4latiP6zitN4Slf8b/IM8BUpwC6eLCGr9gD+4fH3Dnt9nuvfaD8DrGUd7wRAG/2jDf6PVA2XKIc6vs7t740Ia//0RJ6sb5omhhdhWe3fV5lmok21ztUMVeemYfAkDF5CycvwKi/+x46E9I2zVc6/BPSNgToNbyOC4sS2+CdxFzqmA13KfMw+Qysrn5J5n+iP+R8UH+uFMq8uSBE0vcDPVwjSmkX7V9QJFgWLiLdk0+iRcq3NLJvesO2nueQ+rVkzJevwgshym/Gw3ZukjSHUdSqqnlryOEOrwMxi4WmAzRzIE0Z8jEjIRu1kyzpaH+BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 14:08:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 14:08:30 +0000
Message-ID: <e919bfdf-6d50-43f1-ae12-363d27b7e0b3@siemens.com>
Date: Wed, 11 Dec 2024 15:08:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] squashfs: ensure path glob is not
 expanded by calling shell
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241211112839.2743741-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241211112839.2743741-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 013e04c9-6372-44e8-2a19-08dd19ed4a9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RTRTR1k1RDBRRUlsMTBRdUFNZnZaYVdpeEJQWlo1cU91V1NGUEJYalRhN2dC?=
 =?utf-8?B?MGNSaHM2c1ZnMEpwMnRDcER6Q1pVbTlMOExmMmxTRmQ5aURleDFqb1p5bEZC?=
 =?utf-8?B?S0w5OUVWTW9nRFB1KzEzWjUzdXpCai9DNkVQTmQrdlpSYzMwajVTL1Q5Wk03?=
 =?utf-8?B?d3lCR1ZpUGQ4UlEvVGE1T2NVdmd0WWI5eWdSWDVJVHMrUnh3VFRzSXdoeXBQ?=
 =?utf-8?B?d2xaVVB2SHdsdHowb0lsTVM1LzF1YnRqTlR1UmZqZkNvVWdYeXB0S3Q0R2l4?=
 =?utf-8?B?Rk01RTU4VDlZbnl3aGZLMHk4WmJsNGYyaHRFeFEzNFB4Q0Z2UGxHYzgwRGJZ?=
 =?utf-8?B?eXZGTE9vbTRQcGJKNVhEUWVSbFQ0RGZ3cTk1M3VpOTkzWmpnZzczUzZrVmQr?=
 =?utf-8?B?TnNpUy9MejFJVTYrUFpqYUZIMFlyM2hCMVNYZ05KR1B1NHhIbVBDQ2NwSEJv?=
 =?utf-8?B?Q2JQZFdhdk5QcU1tR20zLzdSTzVhR2lEOVpEaE9Fdy9SbjRqTHZlcnp3UTNB?=
 =?utf-8?B?bFoxamJiUU1aZURyUEV3LzB2a0doTElVWDdkVHVYMlFWdFJYc21MQjd3NEw4?=
 =?utf-8?B?NElyS2xxaGRPeStCd21hZEN6c1BhT01RcHU3RWRBdUZWSSszM0FiN2ROSzBx?=
 =?utf-8?B?eWFEbFdRcVdnWncxYXdvNXR2bk9jTlVWc0VONThxNndObnZYT044Mml0NDBx?=
 =?utf-8?B?a3RUU21jOXUvTS9vdDZ0WHVBeS9CM2l1Z2RNU0pnbzZGTVF6bHZONU9mNkZ5?=
 =?utf-8?B?VWVOb3JIUUJlNDdqMFl1MW9LZkRqWU1XdzBaVGgvM2lpM2JnK1Vsb0N4eFJD?=
 =?utf-8?B?cHkxMUV6a1NveFB5Y0Q4YTFSNG1xclo0bmgzZjBhRXRUNkVXa0pZaDlHazV2?=
 =?utf-8?B?NDJiSHBaTEY0OVVqU2lwSDJLU2VOSm8vWDdSVEp5SWFWS3BMcERSaUxGRWRH?=
 =?utf-8?B?T2RvdUt1UDhDSkZtai80aytYczQ0T3RHdW94MjJuN0QwQjlidUx1dDFoR2dh?=
 =?utf-8?B?RXFWNmFrRkJoT0h6M1N6OUdXTjJYY3JEcmlmSHVBaGFKalRlSlZQeUpCNzdt?=
 =?utf-8?B?WnhiS1pUOUFReHpndUNWWGJRREUvZ04zdW1GbkRGSXloc1BKbzZsdXErVVFH?=
 =?utf-8?B?T2czUzNYK0ViVDd6V2ttTUtXM0QvL2N6dWFXcDFaOFdSZmZVZlcybUpMNlZo?=
 =?utf-8?B?ZXlnOXJiUzM0UmxZN2RZeVVrYVV3WURaZGxhOHFUVXZHU3kxeXBkSDViK2pW?=
 =?utf-8?B?QWRodkM0eGtwcC9kNDYxL0FxT2dHeGpJUisxZ1JOeUd6Uzg0c0hMWkxSQmxX?=
 =?utf-8?B?UTM2Smp2MFpEbzBvZlhqSnV3aVZSQjJkaGRQb1FocUVqcnJrWEd3UjliMEYr?=
 =?utf-8?B?N1ZkYm5sOEJ5VjVQbm1rbWpIdGdtQWEzK2kyWmxmcnE3N1dXa2QrdXk2aVp0?=
 =?utf-8?B?SUNWVUlmaEZUTEVDL2pCRDFSSXNPcVlHVDJZcjRCdGkxTFBrMnNkUGFFMkNU?=
 =?utf-8?B?anlMcFJvTWk5dURhZ1Y0RWdJbWs3aVB5aVRTM2QxQ1FMSUNtSmZSTVVtV3Ir?=
 =?utf-8?B?UVlBL1g4OWtINmpCK1FENHgzN0xTdFZHVG80UkZjV0Y4Qk14bmhNbmV4c0pI?=
 =?utf-8?B?OS8rQXB5eGZ2YU5WanVyOW05bnlhMjV2cWlkSUFKQ3A3cHJvZ3prc29sZzND?=
 =?utf-8?B?TXNCNUY1VTh6SG1HZWlZM3BkTDNaZWZpOFFTTGl4T1hHSXo5dzk0MENJRXN6?=
 =?utf-8?B?WndLT3VBUHBJMWdCZDVlVkdRREhBOGxSd2lxNHUzUlB3czR0bHJuTkdSMDFM?=
 =?utf-8?B?bUpTWXI4aWsxMDQzd3Axdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzBtbHdvVHJaMklOajYxWnR5Nk9saEJTN0liVWZyVUl1cmtBd2xmVVJKUHRi?=
 =?utf-8?B?dzgrdzdEcUEvMWxna0N0YlVvMkhMZS9EcmVvQnR0ditDcEVCQjJsVldLcGN4?=
 =?utf-8?B?cmN5KzNvOHpQL2wwOWRXeWQvdTgwME4wUkFhRGJzSmpuM012NUdhb1dYUE54?=
 =?utf-8?B?SnJBM3VIWWQ0V2UxTFpQMFFlUDYvV0hWOHVGUzY5YUthSTgyWWl4QkNKZWFr?=
 =?utf-8?B?ajhFSURwd0o4VzhyL2txME51U1U3V251cTBVYlZlYW9iejRrSXlhVmc1VU9n?=
 =?utf-8?B?MjZQbnBVSG1yV3pnMGJtRVRaVFFDd216M3hzZHR1dnFpaUtQUlg3YjZkYnRi?=
 =?utf-8?B?a2dMdXpGVmE5ZDB4S0FJQnE5a0pabVRKZUtzeTNiSGdPM0tXcWE5UnZDQjVV?=
 =?utf-8?B?bm9vQWJzMHkwaVIvNyswQ2ZxaVZyZnV1L1JGZStGcGtxdXVOZEczSm0yMG1m?=
 =?utf-8?B?VHZDakNocHFiMU1WSTlXSzM1Tmg3Mnc3ZU9teUx6Umw4eWdLVHh0L3RqTEV2?=
 =?utf-8?B?ejd1ZTMvNkhlSnZaWVZJUmFvcmJSSmR1a2Y2Q25LN2J4UC9jN1lUbVE0bG5P?=
 =?utf-8?B?Nis0SkRxdy9va1BYMldUZnNqVmZlK0JxeGxIdTR3NHZUTmlxY0FaZlU3QnJz?=
 =?utf-8?B?dGM0dUxlUmdUaGIyazdLUjNRcGRIN0pGam5qbllGT01lOVJTc0xkT3FhbFBB?=
 =?utf-8?B?Qk1BR3pNS09OZnZ3OXMwQmE1OEc0ZE50UjlabXBLOVNDR3VSSDlxa3F1c241?=
 =?utf-8?B?T0FYUTJuZG13aG9DL3BBZERJU1AyUitWcDJ3VUVodGFKK3BhRzNESnRiY3ox?=
 =?utf-8?B?TlRUVG4xZWdoUXlQTXA3bHJxMkxRU1lwbitpbUEwRkdqRHg0K1ZRMlF4M2lx?=
 =?utf-8?B?cHRsa25GSlJieTMyS0ZYc3lTL0w0Y3AvK3Y3aWJ2bmtBMlVLVDNtb0gxdTJ0?=
 =?utf-8?B?cFZtUHp3U0NUUDJiaStXZ2l4YlJUeXg2S0R6aW5Ba05hUGdrOUt0Mnp3NTRZ?=
 =?utf-8?B?TjN4ejhFMFV5aVIyUHVlcGF2Z05Mdk9OOHI4L2Y4T3dBbFVWaDhlNVVEdno4?=
 =?utf-8?B?bCtqWkZDS1pLTXV2TDVsNG9KMGkvdkt5NitPbzcrcTNkcTV6QjNSMm56ZUFu?=
 =?utf-8?B?aXpSamxoTkhVVHlVK1RlTmxycG9qNGZZZjF4eExrYldTWnMrRTk4RzNpbW5L?=
 =?utf-8?B?ZFlnRXV4LzR6MmI0SGJBMlFKYzFuM25YVHdvQmdxQ2dlVjFJN0Z6M0RIVlNo?=
 =?utf-8?B?RGZaSndGb25hT2laYkZ2Sk05b3g4M3VaQ2hoSzMwaVNReDVlWGI2R2ZZcGti?=
 =?utf-8?B?SlFnbGpWN29PNHN4UDBSYkFSYmN1VmFrRnk0eURBSTR5b2JPcTZXQTVsOGZs?=
 =?utf-8?B?OS8yODl4N3dNQkpYdytnL3dzYjJZdzc4M2ROY3BWNlZ0OEw2b3NWWUlyMlJQ?=
 =?utf-8?B?cEpTWkUrWUliNnEvM05hZ2U1dDVmMGp3RTVFY1lYY1J2QXJUSUNhR2Z2NFNo?=
 =?utf-8?B?a1hYRFdzUDNXcktzMnZoZytyM3R1V1NkVzNUbDE5Vm4xODNTQ1dmU1ZnWFBU?=
 =?utf-8?B?NEJnQlBHOXRiUy9tQk92WUxJci9majJQd25iWm1jWDFlc3VxZjJMRVhueTll?=
 =?utf-8?B?Q01XQTE3OVZGckc0blcvQndwdGQ3d1MvWm1TNFJIYU1pOHp0eEZ2SUdzbVN6?=
 =?utf-8?B?R2Z0V1J3VlgrSG9FUGc5TWdITmxoamFMRWthT0g2UE9PZ3VTVW4rVGpMK3Rz?=
 =?utf-8?B?d3AxclZqZ3F2bStKSCs3WUpWUlJaVHdrclh4S1RheU9xZlB3dVgrYTZWdW5l?=
 =?utf-8?B?Wmd5WkxOZ2s2NkpvSnVtNURsSmRjaW9oRmR0ajAzTndkbHJvZHNsb3h4UnIz?=
 =?utf-8?B?M0pJM2R6Z1dDUXZ1eWcvMUdjcVhoS0dUMDdZcEIydWM3d1NBdXJqekhxREVa?=
 =?utf-8?B?SDFVOUcveFZMSjJuM3UrUU9VajB6ajlWVi9ja0liTm1JMjRWVFIwdUhmbFVE?=
 =?utf-8?B?dGdYN0tEcDk1aSt5WURjdGRhc0p5UVhDWmEyUzNnZUgrb1VseXJOQy9vSnBl?=
 =?utf-8?B?Vk9iTysvZ2JkNUUzYldrdDJFZ2p0YklhOEJ4aXFydDN6L0ZJcW8yb1Q0cGVr?=
 =?utf-8?B?YkQ0S2ZTeFFoSjdMMW5VcWNocWtNRlo4UFEwTmF5YmdQNzZ3eXlMMDFranVt?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013e04c9-6372-44e8-2a19-08dd19ed4a9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:08:30.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjlEzfdf9MAHfm0ZuW4F8Gqp6W/taBLCabf8pnuT9lwSAYpNJdlQ0tIPDJQ7FNolq3Oxy+EvTb1SVyIASWXDjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8617
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 14:08:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17404

On 11.12.24 12:28, Felix Moessbauer wrote:
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/squashfs.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
> index cebda70..751da20 100644
> --- a/classes/squashfs.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -38,7 +38,7 @@ python __anonymous() {
>      # This allows to use the directory as a mount point.
>      args = " -wildcards"
>      for dir in exclude_directories:
> -        args += " -e {dir}/* ".format(dir=dir)
> +        args += " -e '{dir}/*' ".format(dir=dir)
>      d.appendVar('SQUASHFS_CREATION_ARGS', args)
>  }
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

