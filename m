Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CF7CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 12:31:57 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17384.1764246715770827309
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 04:31:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I+PE0Z6x;
 spf=pass (domain: siemens.com, ip: 40.107.159.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afE3aKUuT6AKxclyaex9Av7M2SMVks8ooUuO22V5j50mpXS4ksNZ4n+gZIZ/YENNOdTnei2iaRKoZlQH1Nv2QrYHF2Fkl8HYmxHz9VQG9h0c0IVsEIPYmuz14g2AF0AJqhZcfmoJ0ry1I5zo6lI0aacbHRqFttBmRC6ulM0xEMtuDXliAhKlx7obTQeM7bcCh2jX4ARiqW39PY7P6sin+dd1iXtURMk0NfYItFChyksqbUFqbTbhXl+fOarJ0rv0aW/1ZSVOZDNttfc4CUazteCIpT6NxUW3ns/3Kkw7dWu/9gpi6TRujeTPpLe5s/m3A2ebLAf66gpfKrEBfUDG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy1qZ1gvAyblczODZ+0emrN8bpyrMEpRlrvifoFZXLI=;
 b=ifDsR6gDOFe8BixMfRFykd8i+OoE0fdHSSYuxNPgPuvViCWxz6oHGIpSOdazyQ4FK5JRGdDjikxWTuz9ILxR/OJP+hyIywX/qfOf89gUJznfWc/VrbSvmyfeeczSCN0E6OlXNQ20yVSbOsErupI2bXie4DGpzNWqjAE+hiyBp9+yiBmmaDhn2C0L1tkSaIV+Et1naMTlQEJNkiqx6LRNDabXyzqtYdKpvKUuM65fDZElhGsxjfg2kIytvkSPDL7aeWWYAnEclApyMp75ndTcR+khCq+t7liGbBONu7kxFKWMdxqh/W6lNW+Hz91lAM0e4b95t/5AQxdLSrU1TW2LKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy1qZ1gvAyblczODZ+0emrN8bpyrMEpRlrvifoFZXLI=;
 b=I+PE0Z6xG0gzLP4yQwckdxQl6fUQy4GL/XBTywhM2k8PM7JSIpLhycNxHO2vKRy3QgQV/26b4F6+iBG5IyhhNPys9GlvObIYcbWm1L/x98urESgQ+MzEdzkFO9cUdwQhnXJwPiPa+/LPere4Qe8iDfy0ITxRtPitgxRQwzaJCNUuLJJcFWqK4EHijKPPveIhnNUEfMrHsf+4xewx5hhOkO/aIddsPf3e8YmQ+afMh5iJCjLhb73OOkePO8+1d58apbnUTl9XUN8BGD7ZC30v9ZBuC8rtB86XhHGbEVZv69hOn6USwT3jSLLCv0lTm5uZeDn4ljtVHp38BHMIywkZSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 12:31:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:31:52 +0000
Message-ID: <961f92e5-473e-4271-94da-b94575a93d38@siemens.com>
Date: Thu, 27 Nov 2025 13:31:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] recipes-core: ltp: Update to 20250930
To: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: felix.moessbauer@siemens.com, cedric.hombourger@siemens.com,
 hemanth.koturappa@siemens.com
References: <20251126044710.230439-1-arulpandiyan.vadivel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251126044710.230439-1-arulpandiyan.vadivel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: c37c54a1-9156-459d-7386-08de2db0f147
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UnJlZDJ0dU5ad2VNcy83Z2laT21yMm1LTFR4YkJVRS94SjVDWjRncG9CYjJw?=
 =?utf-8?B?c1c0NkxtTXZnNjYzdUE2dmg3aWhBSy9SbGFmUmZhTEJSelY5WktaS0Y0M1pm?=
 =?utf-8?B?Z3djNDEzdFQweDJFQnV4dkJ1TlgvNTVMNGhIYytmY1pNWkZIcWtIN1JaWm1S?=
 =?utf-8?B?NzZ3dlkxWnNPY2dYZE1uZlJHVlY3cDhaa2FhYjN3bUErdGt1eDd4eHViSG4r?=
 =?utf-8?B?NVBIREFidUl2ZlhDWTMwcC9JSVZXMWNHWTJtRElnREZKUm5wbDdMZzFsTXBr?=
 =?utf-8?B?MzVZeUtHZmg5Q2gvbDN2WFZIL3B1cGVpMGtjUkJla2FCbDlKZFdTWlk4d0JO?=
 =?utf-8?B?V0xrd0ZNNGpwaUp2MnhjejVpQWdzd29YNjNDSUhLUHlKNVZ5cjBnK08vTWpW?=
 =?utf-8?B?a0hrVXExUURsZFI3NGphOC9IV0Zta2kzUVZDSmpuQUhPZXY4eFhNQ0pBYkc3?=
 =?utf-8?B?V3dNVmQ1L01TMzd2TkxpZFg0Vno2cEswRktRYXMwQk8zelduMlUxSGdJbG1C?=
 =?utf-8?B?YXlNWlF0YmFpSEhLVS9Ja0pPdEZ4MjYzMHlmY1ZrVWFqQVc1Z1czZDZlb29y?=
 =?utf-8?B?Z0NHVDRWdkYwSko1dzREeVhyc3hXM0hqU0VWV2xjaGxtRUl2ZkVIc0R5Skoy?=
 =?utf-8?B?ZWxyK0h3UngwdzFFenpBd1B6M1U1QndUM2FJenZ2V0pwbElvT1p5ZmJpdnlI?=
 =?utf-8?B?TEphWW9ObGtxMDk3cEswakZFSWRnekhMM2pNQk1sTmhNR01ISjU3dEFDc0dm?=
 =?utf-8?B?WTNoeEpZUGE3WGIyNnh1UTgrOGRHU2k1TEVkZW1EZW9WTGpUSE5wWlE1dko0?=
 =?utf-8?B?VFVjSlF5VXJQZ1pzY3g4WFFvS2daU1NEUFMxSnA5UEtmYUwzM3E1Rm1YcVBG?=
 =?utf-8?B?bHo4Sm15dkJ5eDd4WXM3WjM0b04yMGNXRVpWOFpaQXl6bVBwVEtmMzdjYmp6?=
 =?utf-8?B?aDlXSFFMSGxyRmEzeSszRWRMbFY4SDZZUUFZa1dSWWp4RjN0T2xUaUxZYmdq?=
 =?utf-8?B?THB0eG1vYVU0cjZUL2dOYlFlYlZuMEw5Mm9PeFZPS1AwM2lKMzVscVRaWS9D?=
 =?utf-8?B?U0krVElqbGN5UElRbklaQ1ArRisvdUxCTTNMV3U1enM2VkJSZUFVM0xyQ1lV?=
 =?utf-8?B?MzZIVnRRRGZrNStGZE9Db0dOU29aUmQzeE1zbGdJYjNBZ3FjNDBWbjhYMEJh?=
 =?utf-8?B?TGRJazJ5dTgxWlQ0V0Y0K0t2R3hzdnRDWDM3MzBVVm54MS9DT2tNQWIzVm4r?=
 =?utf-8?B?RjZUaUcrTTAwK2x5N3o4UjNBcGE5ZGJhdlBoNmVBK0ZIbVM0ZTR4eHhNVzZ5?=
 =?utf-8?B?dmNBRUt5RlpZM1YyYU5tK3B1S2pFVmVucDFIV3lIZnprK1pHd1ZTOFZzaVNL?=
 =?utf-8?B?M2FTWW0zREZ1YVl4ZlhUd2RXaWpWZTF6R0RwcEpaeDdCK29SM1MrMGJEcjVV?=
 =?utf-8?B?WUk0N2xhYkZqbzY5anpGWk5GcUdCNmFwRXZUaU5WSFllSDlsRThiQnFqeDVm?=
 =?utf-8?B?QWVIZ2NTazU3WXNZSU1ZbnZBQWJDMkFMc2phUDV5TmdXbm4vaGdFVE8xbWhO?=
 =?utf-8?B?aDZqZnkvaEovSlV2S3FlVkRQRVZSM1ZWZ1NuUEhzcCtTQkNKMis2UmZLRkkx?=
 =?utf-8?B?SUZpMTJqNW1xb29vS011UHVma0g1c2t2YmpONFhJYUpvaGE2enNZRU1Nc3BU?=
 =?utf-8?B?bjZQeHVCNlJjVUhFSHByT0RXM2Z6R0NQSVNibkZ4MHJEVkV5WXJ5M3NUK1dR?=
 =?utf-8?B?UUlmY1hRRDlQaEN0YmZrSHJEUlFsN2M3MThZZjMzaEpTMEQyTC94cnZtcXdD?=
 =?utf-8?B?Mk9uMDN1V2tVVVdQYkJxRVllQUFDQTBmWnJLTk1DOW45c3VFR09DM284YmUy?=
 =?utf-8?B?dG9EbDZuR0JuRHF6eTBjR2JrQWx5YVlrazE1ZW10WTBDNzMyc3F4RVF1WTRD?=
 =?utf-8?Q?efheDHRAX1JVDktj9TRzaK4ZypsoRRii?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1JEUVM3cnBsVis2eGxDQ3djWEEzK05NWnJ3WE94NUxXWFNRRklqWDhaZ2N5?=
 =?utf-8?B?WU9TU1F4eHlRdzlkbU90eGs3N3RVRlY4alpPNFc3ZFR6N2RZNmp5UjRsT2hp?=
 =?utf-8?B?OGNhMXI1UjVVRmExdWxUc3ZFZUtBOFpUKzNEN1pQZlFXZHdmd2ZKdnRqUmdF?=
 =?utf-8?B?emFhaTFsd2VEOHhCZ1dGUmMxcjM0Z0FpcjJBdmJCbVhUMU1EWG5sV1B6Ukcz?=
 =?utf-8?B?b3NEVmlaVXQvWjVCeENzcGdxWVkxN2dGNHJMNXBvOHZ4bzRFaHFMZENkYXZq?=
 =?utf-8?B?QlczNE1XSmVSNU1GRUZSdjBSNHdqOGFObmd6TUtYUXlzOXllblBTNFR1RHZh?=
 =?utf-8?B?K3lFcDZYanNUcXJDTERwVVV0TlFUbTZmOU5RbHN2YStpTExHTjZLdzFHUzFa?=
 =?utf-8?B?UU5GQVJ6d0o1a0tYcFhjY3ZaM1RKZG9FcVFaS2hIM1QwdzJDaE1YVHBVbFdL?=
 =?utf-8?B?OUtzWkxTQlg4aGJoMzkweUJnamVyUGQ4bW1QNzhxSi9PakhUckJ1SFNXcWNS?=
 =?utf-8?B?OTU1bmhydHRSMndnRmNROFIweXNjYmZVdWpFcHlobmhnWCtCTVB0eGxGRGFv?=
 =?utf-8?B?cG94eVVtUlRDb3UwM05Xa3prM3hkT3YyTDdCbEYyZ3FoV1ZxUHdXQ1VaSGhJ?=
 =?utf-8?B?SjZsZlVPbS9Xc3c4Wk42QTc1Y3pxbFNpUXNrR2h4SEtFMnR1T0pNTHNLcjNw?=
 =?utf-8?B?MmwyMXptcGJ0emtZbkh6L2MrZXgrNzZqNEMyTEx0aktaajcxNjM5TVVpbFQ2?=
 =?utf-8?B?MlA2M0RjaXRpUkZGR0NsaVFXS2F2SGhkaHFoN1kxbTBROGx4b0dKSHVaOGlm?=
 =?utf-8?B?NFFnVVAvQTNhdHByS203eklrTGZ3SmdDTkx2dmN0UGJpMXpBZ3NOT2kzUFNp?=
 =?utf-8?B?VG82V0x6b3Z3a1l5SHZGNExSSDlEUkF3NmRQdWRvcmM1b2hpRHo4NzFOSklK?=
 =?utf-8?B?UFZIYWF3TWZOWXJLdVlJbVozb0FiWVlTcUlqV1ZZWitJa2NGdENpZkRnU0tB?=
 =?utf-8?B?UVdmOExHTjZheVp0NTdKZHZ4UFE2clh3b0Nta1NQbithYnVvb2JIRUZjSllT?=
 =?utf-8?B?Rkd2L1p0M2M3bVR5bzJzNEZiZXl5NXlEbEVtV0l4cytqRDExeEFFZVFEN3px?=
 =?utf-8?B?U2VYSmFpY2h4c1BTM0Y3ck93eEZWalA3ZHVvYXozdW9xNWxubVI3Z01kL1F0?=
 =?utf-8?B?NFc4ZnY0K0RFS2ZES0ljU09kN2t5d0RNaFpnNlZZNGM0T0VlYVRRUCtWejQ3?=
 =?utf-8?B?WXh2cTRxR0YyeW1PSWpFTXhHZTNLZ0xuYWVXR1dBdnhhVzhOU0VwTzVqMStm?=
 =?utf-8?B?QURkeWtyOTJjUmZZOG9jekVNY0dBMjFjQVlhRDFKZkVnS1BXa1RIK0lkSzNW?=
 =?utf-8?B?Vi93bVhucTZBMmYwYkZ1aDYyWlBaTVlUblozYkd0cWxRTFRuNU5rb2xXeTJJ?=
 =?utf-8?B?VTg3YlVMZExDcTBDdVJNVjZPTFE2UVhZS0FwTTFtWStyQWZmR3pBWDNqTDBY?=
 =?utf-8?B?WFVGRnhEYUdYTTF4dGZ4YkNSb3A4ck5hdFowSDg1aVBlVlBreVFqZTVkOEsw?=
 =?utf-8?B?RFQyWFh2Y0NNanZLOHhWU0QrREZDUGVON0NpZzVVSzFjZmlrU2d4Qllwemxx?=
 =?utf-8?B?ZjVnTzladEtSU1YvTnFWSmlXK3FEeGRtZUtZWmZhVzFQNVBIa3lUWWJvWUtO?=
 =?utf-8?B?Um5qcmVLQThOMnh5emtGWnMxb3NQbUZWRXdmbWMwY1ZlS2pYSEpMdGRPazlQ?=
 =?utf-8?B?RmZoQlEyZjcrWUhNV0pML2tHMU5PMnVWTlN4WGRXTDA4c3JJZVQ3dDJQaDJm?=
 =?utf-8?B?cUN3aCswUGZ0Y2tzWDNiZVc0MFBhM0VtZWJNQlVXZjdNRjU5NTZGWVNrOWto?=
 =?utf-8?B?dGZPYW01WUR1U3ArVThMR2VXMXlMK05Bemo5bWVTSm1ZOW5DTlFHOTNZclZM?=
 =?utf-8?B?S3hIcmRycjJtL1pIdW1QWnlyWGt3NDNzc28yZTZRVXRnM0hHVnMwSm54Snc3?=
 =?utf-8?B?Ukc2OWFabUNQTWFYTlhlam0wQjR6R2lWa0VHRVVOdEFLdkJHaC9Qc3dUekd5?=
 =?utf-8?B?REFDcGxtTUUvSUFxajd5SG5EcUVHazVnVzhVeFN2WUlYL3puQjhsaGVqRkVX?=
 =?utf-8?B?Y0xpd1JvVGV2WUZBTXUzcDBVTTdCNHRWWk9EbGgrMGFHajJyOEV6bkgrM3ZJ?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37c54a1-9156-459d-7386-08de2db0f147
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:31:52.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/cBUmyXu5DKKx7ePd86hiTGKJQvnofytrOwrKGJFcEJ4RYsH3MBmxqJ8gaB8ypmMIP10MV6oUyvZXrAe/5WKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8429
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 12:31:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20755

On 26.11.25 05:47, Arulpandiyan Vadivel wrote:
> Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
> ---
>  recipes-core/ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb} (69%)
> 
> diff --git a/recipes-core/ltp/ltp-full_20250530.bb b/recipes-core/ltp/ltp-full_20250930.bb
> similarity index 69%
> rename from recipes-core/ltp/ltp-full_20250530.bb
> rename to recipes-core/ltp/ltp-full_20250930.bb
> index 553b58d..279ddac 100644
> --- a/recipes-core/ltp/ltp-full_20250530.bb
> +++ b/recipes-core/ltp/ltp-full_20250930.bb
> @@ -11,4 +11,4 @@
>  
>  require recipes-core/ltp/ltp.inc
>  
> -SRC_URI[sha256sum] = "27586ba78eac1e40cd422add2842f1ad70f09fea55da3bd6a25e10feb786d4f2"
> +SRC_URI[sha256sum] = "048fa4d69ddbe8a94aa15da9bdc85713ab07a0abbc3de2b8bdd9757644aef1e4"

Thanks, this change was already in next, though.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

