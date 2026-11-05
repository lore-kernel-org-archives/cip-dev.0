Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28771.1793860958039965269
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 22:42:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W95y2NdP;
 spf=pass (domain: siemens.com, ip: 52.101.69.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVxC512a45+bIZ+FLuCN1JmiSza53k0cJET280dkJhPSM31TEdNYhkqfbqD2V8hYZ8BxTepJr8IHGB+X9HK46VxNANUU0yIzx4lTcqPzE9jT8EMuxv9YVCBoqejKm7xawN1YDFkyAmND8wKCScHRpkj2O4ZUo7Q2cgb1ICNI3/VJJVIlnlEyQXOcYt/mA0CM9Q5G2RdmOIv/RuhN8SrUrjUmy3Gs4hvZOx2cOqx33YtZUekLBCethjQxoYtOOpkH7cVb6M8gbifH2djpn4y+dznYLqLwec22GY1zSPcc7lrqB/NYcxaeMb54uMOylawDSiwYLv/CT9sLrhoJGlmGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSsWXzusC6doFXGAQ6kgWgT/c1uQXL4Gg6y/cKdvgyg=;
 b=CnWUwvN5ihLOepUO7FwNavgGa3JvOZY47561it5bc11qHiJZXsyQJb00ueuNVMLdA0VPLThU1Vx8qnojOWnAWG8m3NxQyBgzghgN58XsIEt+dddRhUPrTAejrkLsb0HaF1SHVqXEqJCHzhejNkIyL39vk44Fu39cKgwNIWRjPeT2uWo/RDJh9vsfRgnVuFdCyvNfRcf5oJpwudMp9RHHqyE5tX7g+/SkSjdXcObpEJnP+Pqr5c+tBpOw7zd4+FT/7bvMbDZIzAchnbIBQz7A6tstTfF1+8PxhvKVLm00kS96IsGPQSjH/+mZxDDpkI+e343jmfzoVUQBEN9McEWYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSsWXzusC6doFXGAQ6kgWgT/c1uQXL4Gg6y/cKdvgyg=;
 b=W95y2NdPxaNSOS3eqW6Y2qBaKvmNmFYhrB48trNZKej7NJTIV87xvP6bdzJ0UqDlwhgkef8xX/z3gTWo1qkKUJQF/bBm8S/3xw0hYkeJdNf5snlQJhdVtFUVFyXZn8rDi7ikxIxwxVhNmMdqwq6cqgsfT7WACJyXbuYb5zoZLFDGEJrBPtU8nwWOePVy5eTbL48yqTnCYtOeqZXtk3TU1+IQkJ4wYSYsHrlSNBHFTEnkBCz8u5acwqhBloLyryvuSbPMCiBo3ZSPWRoH447jOLJMZUqUAkyItRgxgLx9d3ANnofewQ2gQSaaEs42Kf34qxZvgv1c2mE1becSQfyJjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1d9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 06:42:33 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 06:42:33 +0000
Message-ID: <268a4a70-6cfd-4a84-920f-801b20c350b2@siemens.com>
Date: Thu, 5 Nov 2026 07:42:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix forky tests adduser is not
 installed automatically
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20261103121347.278803-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261103121347.278803-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4010cf0b-e04a-431f-2668-08df3b07f8aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|55112099003|22082099003|18002099003|261102123227099003|261022075727099003|261021123027099003|56012099006|261021121427099003|261009223027099003|11063799006|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: vJ3snNwA/zrQYUC43g5cCLikuelgbMM5MzdbyPmy59ydfKQPs7iB8rSkym7R0CAJH2CUUrGTmbfb4JRZWXBCXmYrMKCD1+49i7xtxV+w6dp5p5vK0XCgMpi+HCdogjR0TPNh2pRvOeblZ2FJDLNtLgR9LjLabAPFCEETwaIPVEX6Msc5rFSORgdY6qBp6yskCZd/ZmnlWfDiDrv0UC32YnF6nTLRWkGViPeLdtNcaavCABqGecicR2stA5PxjCOKZinf0zF2NKltq89XN+kuRmD0HSgaerb1PKZv0o4R01cyDrDkR/XvDN/2cli+F5RvMmnB+OZZKKtnmYf0KZ+pIErxQtls8DO9G5vU9fvEUXZwdbWMt476F4jLawE4sR68Sh4vyP4WX8VgfEciSjaMdIxGujYPONRKYeI894VkFRSabvD9mERixqGFSyGASJYQQSFsvYSraCTLacRhNOmKMpN2SS68DCDbBq1/0MnsU8x5j46gKHNqshzvlr0pSO1G2+zzRRXdEQuIVF/q0YSgeuqVqtvdMIlPi3zHTQIrpSTDMfvsPZ+xOWVrenTEUs7Fwu5FYQgp9S+aDaZVwFGvpVqDoIV3DgYemUAdLSYhOcBvnQ8znXoJelc5hBirXzBU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(55112099003)(22082099003)(18002099003)(261102123227099003)(261022075727099003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003)(11063799006)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllZeXZRT1VROHlZejdGZGZFSWlzZmZybzJqV0xsdXRIT2NEWTRmbzE2b1U3?=
 =?utf-8?B?MzJBdDZPeFlsSytIYUgwT2dGWElRcmFkVGtwUXRUcHJoOUEwRm1zdTQvNEIy?=
 =?utf-8?B?TXkzU0xrbEhYbUhHeUxhd0ZGYUdSK1V6bk43akRQZ1RENmVUSXFVdVMzNlpx?=
 =?utf-8?B?T0lOMlYwMmxEODlRcW1kQ2VNRmJlaGdZMjRjd2RIL3o3TDVlaWhNN0o3cTkz?=
 =?utf-8?B?WnJhU1pRREFMZGRweWZ1T3dNYkcrV1VML2ljRHlmY0lsZzQyakZ0a0h0M0di?=
 =?utf-8?B?ZGFDOWtGbFpEK0ExT0F6ZUs3ZEp0VHNPVjJ2U0J3NVZSRGtzWTF1cHBBVmk4?=
 =?utf-8?B?MWZ5NGNxRkdEWTRDTjZZZ2lYL2VuSE5hRTV1NkhSOUEzS1dGeDQ0Y2FMR2NN?=
 =?utf-8?B?bWpYWUdCZElhYWdmbHZGWjc3aHB6b3JDeWJkNncybjBsZWFZdVZqMXdtVWRH?=
 =?utf-8?B?enVnY0s5REF6Mlc4V0wwMDZmY2hHR21aOG15Qm0zM3pNTWJzUTBDSllrOXov?=
 =?utf-8?B?aEpqNkkvNnR6R3dTZ1NIbXJjam9ZenlnRGFEYzh1YU5obHF3WEVoUkRocXNV?=
 =?utf-8?B?SVlkNWNKUVRlSzlGcHhqOTBvVWd3bjg5K2FjTDdsUllyK0RtYTlmeTNSZlVU?=
 =?utf-8?B?L1lXb1ZxUkhwYzBzSW5GU0hGa1pmOHEram1tb2VnT3pvakFmZWpnR0haejdp?=
 =?utf-8?B?Z1JnN3kyMXUyVXp4WUFqUFhjYkh1MnR4cXlNV3R4akdQVzhvRFJXWUJGYjdG?=
 =?utf-8?B?ajNrZE9OTVdoN2huZWRQQURaMmFkZkdnMURqUVNpZ3FFRjIvdzVhRi9BL3hx?=
 =?utf-8?B?R2szV0xyTlY3S2R3VVVGNlZ3RkpzdHR2UHgxRGhpczRBWHRTV2VETFRLY0Uw?=
 =?utf-8?B?QkpOMFl1SjByemcyRVlFNkJ6blY0enRRRmYrcU8wd3Y1ZjV6WFhaREQzbGxo?=
 =?utf-8?B?UGNlV09lTGJZOURQcm1MQWVETlRjVmZBaTlLZVIwQnMxbFpNWXBGYk1BUDQ0?=
 =?utf-8?B?Q0QrcUNMbE9XRDlJWGFiQnd6dlppZERrbHZJVTV5aTBmc0pUM1hLY2ZEbUdG?=
 =?utf-8?B?RWVBOEJJYjc4ajJIa0VzalIweHMzSEo3UnNnK3FXNDVrLzJVbVlOemEyUlhR?=
 =?utf-8?B?c1RTbTFGY3l3cGhWOGZwd1NsZ0ZlUVRGVjM4eHNTR2E5V213SVBxRWxKM3R0?=
 =?utf-8?B?b1ltRG5NaWZzd0pMS2pVTk5TRHZvdHF3Tm52QlRFQWlxVFgxSm5yUXROaTBs?=
 =?utf-8?B?MVpYOWRDbGV3NjJtZXdCUC9ZeEtHWFZ0QjFoSHpBb3Fwck82dCtvZldtNnIr?=
 =?utf-8?B?ZjY5V2RWN3VlU0J6UVY3RGJHdWFaRUJJcEF0dUFGWHZkelNGMWdmQ2t1YTA0?=
 =?utf-8?B?ZVNqR2tTVG1zWEYvb3ZJUG9rYmRFZ2RpWkgwZHFpMk1WTjZlNUROY2xuaHhR?=
 =?utf-8?B?WVNJbll2VXpRcnREcVlmWk9mMFgxaENmS2U1RldzUmJPSFNIaGxHamMrNEpY?=
 =?utf-8?B?Q09wcGg4Y1h4QjVKWjZOYXdrTVAzNzUzUkNPNzUwSm43SXk4MDN3ZURlMmdJ?=
 =?utf-8?B?Mk81c2pTMk84RklCWG5ka0xsNDEzQTc0ckFUTURkbG55K0dBcXJ5UVp4T3Bj?=
 =?utf-8?B?QWczbVdKd01BNlZUV29SVlRpTjU0Nko2WDMyK05ucE1zcFJiT1FodUt6ajh1?=
 =?utf-8?B?ZVJxK1hua2tBaExxSFFJV2VWQXFNYWY1TmVjOFMvUGQwWUNlQUFrRDNHY1pm?=
 =?utf-8?B?QkIwSmFWaXhnRmVrNGpmYjQxdXFoQ2J0VVRBL1lPT055clJ3Sk1tNmlBdHFh?=
 =?utf-8?B?SmNVNU1oVkNhSFh1OEJTb3hua1J1ZGhEaTIwbklMc1dDajB3cVpJSk11eU82?=
 =?utf-8?B?WGVkUm4zTk1mOUxhRmhFOWZkM0NaeFlFdU9WNFVpaENXYTFBTG5WY1E5emFH?=
 =?utf-8?B?SVJQamVNM0s1Umk1UEl1R0tOckJQajduNy9rRlpUM3ZiaEtXbi9yeFpKdUxF?=
 =?utf-8?B?K0tmMnhxeitDTGpndXlCSkl6K2RGWDJaM3NLbWRvREV2aDZEa3d2Q1EwbzFl?=
 =?utf-8?B?aFRadHpabllrRlhRWndNSldLNVQ3QkNzL3BXRzNablg1VFR2blJ2OXZ6SjVS?=
 =?utf-8?B?TCtrRUU0bHlESDNvYUluUnZHeHQzVU90VUJvaVpjekJGaFhCMFdia1ZxcjJ5?=
 =?utf-8?B?d1N0OFl3WWhjb2d2Yjc3VEtLQmd6WEpTTld5T3NNa2ZxTXRSNjZNcDVqK2hm?=
 =?utf-8?B?RUpMVFo4NTA1bzRuVXpzKzlLNnBOTzViR3l0UGUzSkpRNnMrOHVPTEZhWjdj?=
 =?utf-8?B?bWZGUUF1NDArYVE1Q2hNR1l2VmNZZ1pMVE1TR1ZuVHdUdUM4NVRBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4010cf0b-e04a-431f-2668-08df3b07f8aa
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:42:33.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAxhqdxDGEj66/NYpONa11E2LowjldeYrffpa/EExfObhWdjgcFMuEoTsmuw8TgwRBRwBgu1nc5ti9DwsE9EcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8207
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 06:42:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24638

On 03.11.26 13:13, Quirin Gylstorff wrote:
> This adds the pacakge adduser to common to run the forky tests[1]:
> 
> ```
> <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=TC_CR1.1-RE1_1 RESULT=pass>
> TC_CR1.10
> preTest: TC_CR1.10 Authenticator feedback
> INFO: openssh-server Package  is installed!
> INFO: openssh-client Package  is installed!
> INFO: check_user: 'user1' exist
> INFO: Deleting user 'user1'
> ../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
> ERROR: del_user: Could not delete 'user1'
> postTest: TC_CR1.10 Authenticator feedback
> INFO: check_user: 'user1' exist
> INFO: Deleting user 'user1'
> ../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
> ```
> [1](https://lava.ciplatform.org/scheduler/job/1538035#L1072)
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/customizations/common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index 0fd3d4f8..7f0e8a0c 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -31,7 +31,7 @@ TEMPLATE_VARS += "CUSTOM_HOSTNAME"
>  DEPENDS += "sshd-regen-keys change-root-homedir"
>  
>  DEBIAN_DEPENDS = " \
> -    ifupdown, dhcpcd-base | dhcpcd5, net-tools, iputils-ping, ssh, sshd-regen-keys, \
> +    adduser, ifupdown, dhcpcd-base | dhcpcd5, net-tools, iputils-ping, ssh, sshd-regen-keys, \
>      change-root-homedir \
>      ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>  	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"

This needs to go into security-customizations.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
