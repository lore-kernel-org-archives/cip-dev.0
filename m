Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014DFC7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 12:50:20 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.69])
 by mx.groups.io with SMTP id smtpd.web11.18821.1750683012773105153
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 05:50:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BZxBvzRv;
 spf=pass (domain: siemens.com, ip: 40.107.159.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcgIHlN6W1JGJA2dCFNkiL490CyzlMYlrAnGny6QVfBmSxRSoRTgpO72v+OhjQRb0MuTqxrbMfiBRbK9K30cB99X0bBKyP2vmlpcKOEO9/MoDj1/J44uMPKXrnUN5JFgAyZyh81DNC+LTwEKqhfVnoxC1asAf6VH9OtJIpvGI0cs42Bm3GJPITYTlz7LUzvD0FFAinsKW36dTn7MwsiLpVRFcegXVxNqQ4r7Y1EsN60pIWz/C/K6zNcYeFOgD+IoGedcNyrdGt+GI/vOL4+efsvlIE1sjdySFzhOgiC1RKY2TKhhHg6D/ZU0wUxWsAiy3OBIwPB/5Bt7IWxozEeQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbmZ+vfos0e5BS+4EWSto6BhaiZAzbgFWLP1wjTUM+I=;
 b=QI8Q4qqxSEfg78qobrJY1E5LjsHNgnA/8ajC0vQXe0ta2eqwY3TGjiElz8jolqcRMfZunuznh5Xnx1fBRYRViBR41CkyA8W94Rg+7dSNL/7TpD817BbF5Z+EmJ6mrnjsq9pwn0DKW30wwLC2EjB4BQCKy66pvwoy+VOyY/Ekm4RyZCfFA0TG+VpxHsnMmuusJRsiRIDldRMaEDNZHSM8KGNPhbujbAk0ao8iub4Xaro6RCa0tlY34t064MWtQ7Juc8WYYYE3H17wW6alwZVU4Nmr/6T+sQh6TWcgv2eNh9m2qlBfjaarCnRJI+uG58P2pO0H4yYXqgHTDmGw3jebzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbmZ+vfos0e5BS+4EWSto6BhaiZAzbgFWLP1wjTUM+I=;
 b=BZxBvzRvleT9gZ/isuc9eXKw5B7TWirS60KALLlMjEChnE1Hgi0tSpF7iWqPexoKT2sQH+J1CMoWpNOdPJSNL+JR6sYY0DRP/5zM3N8EH9pz+1nGZLphjOIuj1C/TGUn4QrzZKcZMPAtruOm3r/jl2XaNYhvEoHJyr5mzXsOs4lrArf+zaR8s/g7KC6Ey1I0vLozKGNLTMjgYsh/pWL+n7LWB/WJ+/slezE/QP0cjUwVbxOvdazmdKutlrreGKowhzpBNTkm7C932jo4q5yRijSO7wCiSqyy/dIm6npNM0I3qhxXOGWAe5puP5vVv/DdsTBgJwm8BX3nRXwb8hTpzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:415::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 12:50:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:50:08 +0000
Message-ID: <b7e641b6-f14b-4e2a-932f-f123a549d39c@siemens.com>
Date: Mon, 23 Jun 2025 14:50:07 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Siemens LAVA lab down
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: e36adb2d-ee89-4cbb-1668-08ddb2547be1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y2FrOVRZMnNSTWV4eHVwRU5RdFJNVDBVZTRXVElUUXBNcUdTeFBUMHdLdmkx?=
 =?utf-8?B?WHhOSmN1ZG5WM1JJVDdldEMrNGkyWi9JMC9EMHVmWURXQ3pENnkyREpOU2hD?=
 =?utf-8?B?bDZEeVJOSGR3c2szbjRzd1NKbERKZDZpdTloYVhyY2RLRmxTZlBCSkhCa29n?=
 =?utf-8?B?c09GcHZKU0RoMERvcW92SEFIaVp3Q0xrU2RNN3UzUWErNXRDUjVDblNLY2lC?=
 =?utf-8?B?aWpvdVVEVVhlR0s5bFpVK3hTYkFYbk9TMDB3SWd2cDYwTGtLdGhlUU8wNGRm?=
 =?utf-8?B?U1ZQMFVVYi9YV3pYRVI4ZjFQSjB2UnI2T29MTkRoY2svMU5tcHkyQ1JIb2po?=
 =?utf-8?B?YWhOTVlHQWJPdEovMnlJa2ZVSzJBZW14ZnBGeGprWjZxRFBvUC93WisrSTh1?=
 =?utf-8?B?cXFIcm1JRW1mY1Z2K0x5OGRDR3ordXUxVXFVZW9mSE9sNlp4L2NVSkEwK0ZS?=
 =?utf-8?B?ZW9NWkRzTzRWMHozSi9xaVFpanQ2OHJkUDJOV05sVVRoUCtxdU8rVGNkRExu?=
 =?utf-8?B?QTVDcDJtNjlVbU5xNmhNazdtNTJVMnFiUXY0WDdOQktoNG5zWnd0SnFIZWpu?=
 =?utf-8?B?TFlGSjRzaWorVVpDZGU3UzlubXJFR0pSNDl5cGJ4L2FHano1bWE3enRRZ2lH?=
 =?utf-8?B?UzhOZ2pWZm9iZklPVUowcXQybDBFSzhtV2NzWVlUcEZ6d1VqOUh1ZzZtUHBI?=
 =?utf-8?B?YnFXQkVWcWE5TGxpdVlBdXVnUFBRLzM3SzZjU1lzd2d5R01jaHFDRVNVQ0tt?=
 =?utf-8?B?cmR1Nld3TVBiUFFmS2FjbkZQYkpxSXFtN2pKS2QwVFZ0MHhMVXJHM3pxNzRM?=
 =?utf-8?B?VkJsbElDd1pBd0g3cytsM3RCUHVSbm1OcytWNlBJc0VneUM2aFE4TS9kNnJn?=
 =?utf-8?B?aUxEK3ZYR0dLMm8yQXVzV3RvUlRoTk43TkJoSmcvQXNqS0V1VHVvTHpUY0Jl?=
 =?utf-8?B?dnBVTDF3Y2dUWWNyNm5INmJvNnN3UmcrSU0ycnphZnBHQ1NmajljZXFiRlRw?=
 =?utf-8?B?QjJob2dlV3BEa2Z6UGFpUzFpVGNDZDJHeFhGS0FhM1hZbms1T3o3NHE3S0Zn?=
 =?utf-8?B?Si9NQzVYWGNnTFdtSmRBNG1WM3hsUjlsQ2xIT2p4dm5QRC9TYXFyWWxrL3hV?=
 =?utf-8?B?UVhGemhnNk5qdTE2L3lUVWdyMnB1Z2lrY0FRWWdDUXdpOGVWZndLYkF3RUYx?=
 =?utf-8?B?ZWRCbWVrRGFlbGZ4bDJFenVsZ1VuRU8rNFo1Wmw3QlREQWViZVVEZVBiZVdW?=
 =?utf-8?B?ZWN6MzZuQW1DK2tRVXFFZzF3bWM2ZGE2RCtOOXIzeVZVZ3psMkhmUnFncnpL?=
 =?utf-8?B?UFNsRDFyazd0cHFQRHBRN1MzZlE1Q0d4RDExMmJKTktHSmpzNERrUldJK0R1?=
 =?utf-8?B?R1VYRXRqdlYyV0JKYXMrd3lWektieWU1NzA4U3ZERlgrMmY2ajY3Z1Axc0hv?=
 =?utf-8?B?Z0k0WCtuaTY1cFVONUJ5VHNCS2Y5bzRBM2V0Z0I3SDB4M0F0Qzd2c0FWTFNI?=
 =?utf-8?B?Z09hbjl3ODE5eG1NU1ErTlJmdnhNYXVySCtTNC96SHVPQlhNLzVOaEluT1Yx?=
 =?utf-8?B?b0ZlVGoyR2szN0EwVWlXRytORXBZSDVmdTM3blhrL010M3lRQjQ3Skh4MWpa?=
 =?utf-8?B?MDY0UTYrcnJXeGtqeUQrSEFHV3ZyVXQxZlpnS3hGVTdlNFFRSW5JYXg4emdz?=
 =?utf-8?B?bnN0QWQvdUZuT2YxMXhLc3plRk03d2lrMkRFZHZINmRxWkJaNFNyOU82aGtD?=
 =?utf-8?B?MjQrSitUbG43clc4eThUV1c0M3NQeGw4bXhFUGJoc0dyMXRDUk5ZSDRjNFFU?=
 =?utf-8?B?eFpjcWF1ODdiK2dFZ0tFYnYzWlN5d1pFOUVTeFJpaXYxcTEyVktoVDhkTlp5?=
 =?utf-8?B?QjdDY05KWi9UcGlLemQrT2ZPbGRGa2ozQnFrOE8zR0lkUGJsWGJMc1cybGhZ?=
 =?utf-8?Q?RjVH7fBfeVE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTFnZVIrMjZVL2dtbmFFQ0t0d3J0VFEvdllEcUkyVWJ5YzIyNG9tNDU0QU93?=
 =?utf-8?B?ckc0QUJxdzRWVUpuYVk2aWRnL3cxdUVUV3VWU3BENW1IT1Jzd0k5ZkhMeTA1?=
 =?utf-8?B?eGlwaHBlQWlVeExCMW5vaVhlckVhOXlTQ0ZaNmU4d1E1bmNRVG94UXR4Qmtl?=
 =?utf-8?B?VjMwT0VVSTM4N3VWTlliRzlkelFEeGpZbkdHQXo4VHp3Wi8rSkxPelN1M2tN?=
 =?utf-8?B?WHNLK0RmR25YQnRaYWdYVFlienhaRW9EMUJsNW8rSk1CVFdkdWhYeVBQcWVx?=
 =?utf-8?B?YzJlMng2NkxQajc0ZDA5UysrcmVjR0hUL1ZhTVpia0JnTlBGVFFZYjNueFhB?=
 =?utf-8?B?eDJYUTNtTXBza0Y5cTcvak1zdzNrTjhiVnRuay9GZS9Cc0k4S0R6NTZ0MDI3?=
 =?utf-8?B?SysvTVA3VkRZM3ZxaXQ1NDRQTUpuTGFLbGt3alRBL1pCb1hGbmFqczc1NEhF?=
 =?utf-8?B?YTEyRDhuS1lxeTRId0NLZUNWVUpPdUEwWUQ0YWk0TUYvVjFLMWF2M0svTWM4?=
 =?utf-8?B?N0lzRjFtMkhzWUlDcUNxUkNtbWxFaUpoMzNpY1ZkYTFqUlFya2dMOU5NSmRR?=
 =?utf-8?B?MzFFTU1kQ0VhNlkzaHhxWlZpY2g0SU55SE54ZzVFOTYvZ3BtNW10RytzdFg4?=
 =?utf-8?B?U3poSmkzZTBCVU1rMk14dmNXUWtwQ21TRkZPYjZqb3VFZE4wbUs4dEdxT29K?=
 =?utf-8?B?dDRBYVlmVks2eEFQbFd4ZE93Q041UUdZUlNWVjI1emo4RDNqclhJd2NPTG8x?=
 =?utf-8?B?dFAvMDRyaHJRVWdJcU5ucHc1VEd6RnVpODFMaFc0S2ZFb0hua3paTVdQL3Fa?=
 =?utf-8?B?ZEtnZDUwazNIdXBUc3lCbUpLbVJaZ243c3JpcU9zREdNMGFGVy9GaVh2YWtB?=
 =?utf-8?B?blR0K0FTWlhFSlBqMURtSWV3VXZxQWVWdy96QlpOU2dhYThMTmRoZXZXL0pi?=
 =?utf-8?B?N05iWENEQThGb3JmdENhbTJqb3V6MlMyVVR5VUM4VWVSQ2lzY21KRFdIRFBY?=
 =?utf-8?B?dkFvbUt2Unh1SVB5UUFUY1FkSlJWSGJhQU9xNkJVdG5UYktqSlBkVFRSR3E3?=
 =?utf-8?B?UWJWdEtXWFVVUGlGYUVkbThTcVdnbC80MWh3Qzk4ZTBybzVBR3ZoaWg2MGJu?=
 =?utf-8?B?bjhiMC9hSldWZm9MTmdTOTZMSHZFZXNIck84cXBXUUp1QjhzaUNXWSt3OEVj?=
 =?utf-8?B?eTVHL2x0VHBpTlZURmxFTDZ4VldzRGVXS1g1NEpJWDVWa2cyeDQweVNxVWE0?=
 =?utf-8?B?R0d4dnF2bFRITXhLVTRJbTBGRmNyTTZLZVRrK1Z6OFFsanJ1Wit2VURieUR0?=
 =?utf-8?B?STV2Q3FidWltSTNqRGE3dmxQeWRvRHIxa0g1TDFqVzFyU2c4cWE5bUU0NlNn?=
 =?utf-8?B?dzZCMVNQUW0rZ1BnbmlMejZDNjJidmhJU2taV1FvR3lLSTV2Tnowa1B4Risx?=
 =?utf-8?B?YmxDT0NEZXpSbDhzUzhrWVJTN0RERVBwQ0FWOFpjbWpMWnV4a3prdGpMMnlV?=
 =?utf-8?B?K0hZZTBCQ2FyOUFyNEZSa2lvZjlhSkhVVXVsdFYxZUlybjFUd2xjVkorZWMr?=
 =?utf-8?B?RDh3YTdDRkhRYWpOOXVBckZlbmhGZkMxc0JLdDJYSDJDZTJOdGdQWFJ0TmRM?=
 =?utf-8?B?RmlEazVtT0xPenA4cDJNcnQ1NzNUK3p6aTlSMjVRM1hKRm5LbHhqVmVVK0N6?=
 =?utf-8?B?THI0RENrWWFIa2xFQWthenkweGJTa2RzMGNlTHFDVythZXdWblJTV09wbmcz?=
 =?utf-8?B?MXdHRWxISVhUS0VTckJZZDFOUXZDUlJ6d2FlV2VjY1lZUktWSkpBRUxHQ2RJ?=
 =?utf-8?B?UnYzU1JoUmtBQlY3RkpYM2V4U1FIeXRvNnc4MnZKaFV0QXQ3NDFPeUJsRzAw?=
 =?utf-8?B?dFdUTXQvRmtCNGptOGpEaGwrVjZzeitJbjFTR2tWZzRaYVZwaVFrQnh1VG43?=
 =?utf-8?B?MlNxcGhjS3dtTlNvM01jUUFBdHUrNjFiK3RTK3RlelZzSUwyYXFwQzJwSmVq?=
 =?utf-8?B?UCt4N21uU3JEaFMxTm5WdU5QaklTRjlRb3RUWDlrSWV1alp3QVdjMlpkR1M1?=
 =?utf-8?B?R3A5QklWTXlhdDZpSzlhd3Z2KzN3NkZhUlFxemVMbkhPY2JyZ0ZoRkl1bmw0?=
 =?utf-8?B?MDVKbHRpQUhUYlNLNFhyend5L0VMWDVjVHcxK3NOOHlORGtpQ3NkSlFWMk5o?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36adb2d-ee89-4cbb-1668-08ddb2547be1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:50:08.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K6nbvECEcSWnVt/+/vyGSz/n0bdQfHw8VshSvIDuESUOGz2h4viCm8CP/FGWZTFQ3DxqGdEGxFSuK3i2dCsTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6977
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 12:50:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19184

Hi all,

FYI: Our LAVA lab is currently down (including the only MCOM MTDA
device), and our team is on retreat - perfect timing :(. We will look
into this ASAP but likely only later this week.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


