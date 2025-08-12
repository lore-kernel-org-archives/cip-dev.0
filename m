Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B27CA0EDB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 20:20:26 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.34])
 by mx.groups.io with SMTP id smtpd.web11.84621.1755030020437201594
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Aug 2025 13:20:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KJyg1+jG;
 spf=pass (domain: siemens.com, ip: 52.101.83.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRkLn998vs+XPS61Awn/QqNJW48Ph9kHbsS6SBc+GHGGVWdnty8PTsrOKarcQI20WaPzECOW0DdibIUzClrJv3wBQ+YAiSuAa88YIPdM6vmHtROn+EQRm3ZNGtOOsg1BuiYpTXpeWuZMYmBlzYAlbucNqmLsl36oyUNexWgZNYWm5VfX2rxzzBxejD+HqBKYyjdeiZB+pEdepQTQ3nsvNZpObwSNE0fuekb3BBhFTwZPGlrl/PeuDH+55cUSagBHWrZtVgyScf+qr8TmKKG4sGFb8XKqJnNwZ5elOCDV/hPxj5tEN2NOZUfR/rc/no6cUSrEAClfgO2hyRdzL2zRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGjo0t8EU2GNZ40kj+CqxQSHTz2EvIDCxsRGYV4wcxg=;
 b=DWw7ZFmUM5C5WFTukRm7aMz42F66rfxKuMOweVR4mtMALdbUVf6L0q1aznrzWUmKwDklkml5ACHAc6fsL19w15JgM/y2lLF5xgoQ6i/jEfpdPdRFaLJISZLq2xWXIKU7yDjJY5GtRdD8KRp4no+wonrvr+2RuXILgADv72pgtK6sNsDWVZrRo7V37M4b9UKnOhTHeiv3+Ac73E8ZLORXeJ83HR5ZkqQlfOZvO6ZHY5J8D3HUwilmXsCZHA40aqM5X7etIpMxSLE1bqvSx7T+aUWPC7zTTudu0w5+NaGIdHmyUNxW/ap/iutAGkZfzxoEv9s+J691tucJqGSUloa03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGjo0t8EU2GNZ40kj+CqxQSHTz2EvIDCxsRGYV4wcxg=;
 b=KJyg1+jGm9d5TG6LIoQZeRWI/pP/AssLVcPI9ZK0cMHgCcKk8ViC1coBQt4HZqd2s2euBhjKryDWETeUH3gNOcO4cqdUx3NFoWxgTKbblXdbb+YcXCxRglwK0JpmDHvviJHrliEZl51KO7kajqeXK3CtolMo0sGvksn4Q8lBYwaFWmYBl2ETTBhHqy+VN7sKlqXmpbIbRp07T1d5JJxqEpjwlmI4a8tcPYGgKpNF/b17zXCYYgdF8hFc+saQJ7d+WAfvx7LdgOje50k7m2k/mUGc2L9tCab4rfY86CrmgGcuHPaBM6DR5bYSoHQqaI/gLeOHbq9eWiW2zu26puKhdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 20:20:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 20:20:16 +0000
Message-ID: <ec5c9daa-5dbc-4073-a0ff-228ab91444d5@siemens.com>
Date: Tue, 12 Aug 2025 22:20:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision for rdiff_file handler support
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250812092815.1282546-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250812092815.1282546-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f5db36-40c6-4a57-e5bf-08ddd9dda6aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cEJjamJubk1rSkRuV0Y5cHErUzhLS0N6aFZaTDd4eVBUNEtRRE1xMVcva0lX?=
 =?utf-8?B?WG5iRFdjckpPcnluQ0tIUXdxNXpycGpyR3lwaEVVK2dibTZNWEdXLzRvUWFy?=
 =?utf-8?B?YlRhNWwrTks1NjRmUXFmb3VTNklCQkNkQURBS0ErTUJkQXZEeGl6NUptUXRi?=
 =?utf-8?B?QnJJeHVrV0EvY3ZHbUdvM0xWdHRreGNEckhRNUVvRFd5NXdhTGpudHBZTEdK?=
 =?utf-8?B?RllsYTJhOC9hS3ZoVCtURGxtOWphVjVsVlFGb1dqRzc4cmtUQTdWd0V4U3N4?=
 =?utf-8?B?eGE4TmZ2dUJKRDFsLzJ0Q2xCcXpPSkowb0VpTitsQ0RYL0p0RmpTc3UvSmZT?=
 =?utf-8?B?aENsYUVSNjZJNmdJRTBWeEFKTFJhejYxUDJvNnRhUEVJSEdwNjFQcGlaKzl3?=
 =?utf-8?B?U3BWZnRxUWNSNGMwY1FwdWxHbVpxNm5WbmNYTXBZM2g2aVhZdzl2dkJnU3pE?=
 =?utf-8?B?N2RnMkFwaXZ3NDVEWHdVcTI0QmZ4Y0p4ZGFwOFJqRzRURFZQRk1relhzYnNZ?=
 =?utf-8?B?TStuTXFQT0RHSk54Qnd6V3FnNUcxbzJLdUtLaVR1eHNueUZ3cTBPNFpndmdJ?=
 =?utf-8?B?VWFFWEhPRTcvVUtxWUh2bmJGdXExYy9jaDlkak96aHBuZHVlTkdZaFVmdlRy?=
 =?utf-8?B?V2VsT20vdExjbnhtMUZFTjUwa2trYjBLN1BLK0ptTkg2emlodzRtRHczbjBy?=
 =?utf-8?B?eEhWcUw1czRvb21jODEyUXZCRGlaakNHSW1VY1RsSkViZUdYUC82WWNvdFNh?=
 =?utf-8?B?TDhiN0duRmpQWktOWjFVZlVBYnlVbVdrdWVzcU82cklGd0F6bmZNamNUc1dm?=
 =?utf-8?B?K0VIWU8zWUlrTzEydExrSkU4K2c4V1BvSXdjYjFlZFhOMXhHYUQ5U3lGSGxQ?=
 =?utf-8?B?Rkp4emJ0eWxxYVlQaHMwSjRPcEpWdzgrTW9oeG1RTDlIcVhKeTVtdzBlRFNO?=
 =?utf-8?B?bTRzQWlpdHZGa2h1T3pqbUhxdXVGS2hPckhGV2R1WERoVUdaTTVhcThxMGZ3?=
 =?utf-8?B?OTBQOVJ6NFJMSzg2YVlJdmthRk02S1lnalBhUURMZFFqOExpS1BlSFF3b1h4?=
 =?utf-8?B?SGhHcnNrclFpa2VtbDREdmFFN0dqTDNZdTNIeXJiQkFNcFBCZzhOSU5CK1lQ?=
 =?utf-8?B?S003bmtTa1J3UlNYMExoRm5xRmVicGdoN2o5TEFjenJYTU9sSUoyS01aSW9p?=
 =?utf-8?B?NzZINkFqamRQSytvT1pDNlgxVXZSQlFKdjMva0FnZ2EySmkxQk1wMVJqd0cx?=
 =?utf-8?B?VFZzUmc0WHcrMy9RdXhHRFRVQ1k4Rm1FU0F3SUdwUDVBUng4UE9FSHhIblVQ?=
 =?utf-8?B?V0YyYmxPblJmaGl4azJCWlNra1pBZStZZ3FKd09ZdlJuNEpzSXh4SGkxbTQ4?=
 =?utf-8?B?elB2NHdqOFhJOVJKRmZLODRVVFUxZmJrYVRzNm42L2RxQXlnSnF1MGVPNnd5?=
 =?utf-8?B?bUNqbldLc0VZcEo3SmxjT2gvSHBsUU9PWGNOaE8zaDdlaVAxQllDSTY5UkRm?=
 =?utf-8?B?RUNXUTg0Z3ZRUFE1d1RDOHdobDcvVW9aNWJBWXRHVStmMXpRbUNpUUtYNER3?=
 =?utf-8?B?SkhVcGVnMmZGK3B1TC9QZ2lLRFhuTHQrTlVoai9wUkRENGlMV09GRjlqN3Yr?=
 =?utf-8?B?N2dSSzVXMjlBRWFMdDdLRGFXemhHK2lqNDFmZDlmUi94d2lXS3NLV05KMHcw?=
 =?utf-8?B?NDJUZ05BYVJ3bUZSVmR2Nk1UTExwN09Sb3VITGVxb1hqcElxdUhHc09kRkxt?=
 =?utf-8?B?c3l5ZzhLWEtlVk5iMy9YM1NIcWw5eXdBZFF2bTQ4OXZ1TUlLUWJRbVk5V1Fn?=
 =?utf-8?B?d2RCdXR2MkhSUlUrRmoxUGF2KzBSS0NodTFRQy9BdkJaT3VMUnk3U3dGMUU5?=
 =?utf-8?B?ekZtMFZYUWM2M1Z0bXAyWVRFNHQ1VHFaK2JCSGZVWi8wb2htWHhmUERVL2t5?=
 =?utf-8?Q?fjL4Lcl5qNw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVV2aGJHcUxPV3pjSVQxM0ZSSFVXczdJNUYxeVM0WTU1NjZ3Vm9JS1RYUnRi?=
 =?utf-8?B?U3hmU2pENzY4ZXBZYS84bGRQNEh2RlFUaVVpQUFSb3NnZDVyMXdVLy9PUUx4?=
 =?utf-8?B?NzhQM3h5Ri9yV0ZhWVVtaVU4N1V4SW1PUTJUcXJTM1c1emVEcHppSzY5SENI?=
 =?utf-8?B?U3ZqQlErRHdDazJwTWsxdnNrdHZiYXpJd3lFeUt0ajBIaWNib1lwV054NGpL?=
 =?utf-8?B?NTFQQjBKbjI2bjMxZTJOK2JHSFdYMjZGZTVlL2ZkL1Q3NUo5dVNuWmo1ME43?=
 =?utf-8?B?bk5RTnNSZkFIQlhvNVRtbnhlQk9CTis3bkNDRWhNcStWSVRhYThXSExhaUtv?=
 =?utf-8?B?VWJ3MTZZUEVkQ2xhcWNqZzNrTVJwOHRPeTl6Z2JEQlZXYW01TjhlZEZEcEtP?=
 =?utf-8?B?VHlkVW1QZ3F1MnErcVhOME13V3hVTlpod0FSWFpIYXg1QitZczZHbnJTdWRJ?=
 =?utf-8?B?ekNEVjhwQ2lXZmJvdTZoMkluNU9GVUlDZUZjOG5VTm9RWmc5d3h5dTdPS1N3?=
 =?utf-8?B?ZFNpVm51SjFFMjZhSEI2ajUrUnU3SVpiaEhjcGl3MkJoYzNMWEh4UnpzQlE4?=
 =?utf-8?B?ZnNZbkluYlZTN2w4ZFd4NDkxblFtM2tzWkRNZXp3TXFTVVZYM05oQ1BQUG9X?=
 =?utf-8?B?UGlHZklvZWw1ZUtVZkhrcXhZZVFIYmNSVnJRbmhKaWMveittbHFzcDU4UFFS?=
 =?utf-8?B?YkxWVmZzZzRDYVJIMXJwWUtMQUpaNGdFNHVBK0pYTTVFWFpoUzQ3QXhFWWtW?=
 =?utf-8?B?OWgwQ2NsNkJrY1NHRXE3MUtVSWozQTFEU2Z4Mi82dkVMMTg5Tmo4Q1dEM0RC?=
 =?utf-8?B?MkhnRk5nSDR0T240QVFPNnRORFlheVFxbGpJSDFTMEl1Q0pUamRMaUoxbDRM?=
 =?utf-8?B?Mmh4L09JaFM5STAvL1h1aWR4ZlNwSTl1SGlLbkRrM3lMWEhGTXhQdjZUZ1cy?=
 =?utf-8?B?MFg3b3JzRkxKSytQRTd5WFoxUktIcjVzUUlGVnU3TkNndXNkcWdKVG1sMTla?=
 =?utf-8?B?ODVEWVFpNjNnRmovQmlKWjMySjJyR2xGUkxVVDEreENCQVBGYkNQeU5nRG1E?=
 =?utf-8?B?empiTG53WGJua3Fwc25KUVNZbkZXUnZJVks2WG5NTnFlZnFmemhFSVFYUCta?=
 =?utf-8?B?S2ZxKzFMa0pQN2JxaFRNVDNSODM2NXBkTDYxaXdIYkRWN1NidXVkaUMvWXNs?=
 =?utf-8?B?aFlvcFRvR21DWnVRRnNJejN2ZnNrYk02eEJMem5YZGx2dUs5NEw1NXF2bXdJ?=
 =?utf-8?B?ckcyckxmZ2hkS2V2SGYwZjh1N2s2aTlxeER5dUxNZHoySkxCR1NMV0FzNmM2?=
 =?utf-8?B?aU9uNVlrKzBVMGx5YWF2NjEzZVhPdXgwL1hSR2tUWkRZSS9BOUpqVjFGM1JX?=
 =?utf-8?B?N0tDQW9PUkQ1RkdzKzdoMjVlbkQwY3hMVERmdzlhZzNIcWVBU2VYbXAyOHJM?=
 =?utf-8?B?ei9jaGRhZWhKNElnOTR4VFJ6WVYxbXFFa216aXZvcmFsRGFxRWZ1dmhwdzdU?=
 =?utf-8?B?enpWNFZzOGFaekhSOFhsUW9OYnllUXFiYVBTWkVkVFlWMXRpZmsvSlNka3A5?=
 =?utf-8?B?ekYxNDUvaE5yUVRSNG83dTdtaHhmbFNOZktOOGJyM2ZmZFlXNHpnd2FjSXA0?=
 =?utf-8?B?NUFkdUI0TnJhLy9IUVRyKzBkcHNkQnhqSUxWMklvenFzc2N6QzA1L05nN3NF?=
 =?utf-8?B?dzlKUVY2VXdPZEsvWGpUT3VpeUVjUkpKVmtYeWtweGQzY1ZZUnljSmR4MmhV?=
 =?utf-8?B?SHpCMTlqMW5uVmNYVnlsVlpNWVpmVzVkQUNyNExXUlJHRExESHVJQ1BCbU00?=
 =?utf-8?B?bGR2RVVWUlQ2OElZQU9XbGZTYTkzWTVmQTF6cThKd1VBTzhGeGhCMklCWW4r?=
 =?utf-8?B?cmdVK28rcVU0T2IweVFVMGJYMTFpU2lhcyswVUZibnhRSTNSeVZaSko3YW5p?=
 =?utf-8?B?c21yK0p2Y0VSaW5CM01jSmNUODNWODdaeWxYaU15K0ZDK3BVOVBUZFQ2Slll?=
 =?utf-8?B?cDFWTGlWTlpySUQrSHBmbHp1S3VXVVByR2ZXaXpoN09aWFdwbzZOOG5IN0o4?=
 =?utf-8?B?ZTV4NU50OUYzM0RNNnIyczBlOURFY1crN3BqYkkvaS9uaEg3S2MxMzVjVWFs?=
 =?utf-8?Q?It0yhug00ti94LGUk3Vv39Jbc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f5db36-40c6-4a57-e5bf-08ddd9dda6aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 20:20:16.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psBpV+cZyHzOIekcrBtvIrK+GhF1ux1eCU1Wqk1A5NTazIvg0A8mfn/efjzK6qV6zFnllDwCnCSnpMvw1N2tjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Aug 2025 20:20:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19719

On 12.08.25 11:28, Shivanand Kunijadar wrote:
> This revision includes the support of rdiff_file handler which is
> helpful to update the single files using rdiff.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index a185f25..d2edbbd 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -13,7 +13,7 @@ inherit dpkg-raw
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> -SRCREV_swupdate-handler-roundrobin ?= "e6936b8c29a20cb6a6893faae57e12499ebbc342"
> +SRCREV_swupdate-handler-roundrobin ?= "5deb75df5469c5a66cdd727eb72af83ce0784054"
>  
>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>  

I would have expected this together with changes needed to do delta
updates with UKI images. Or that already all what we need for that??

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

