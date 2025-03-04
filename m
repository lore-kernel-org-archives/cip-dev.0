Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBCC282D0
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 07:02:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.51])
 by mx.groups.io with SMTP id smtpd.web10.16772.1741071717611247264
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 23:01:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Lz+RMWs+;
 spf=pass (domain: siemens.com, ip: 40.107.22.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPwMeDkMTMC1DT/3jSVjy7KfYjkVbnGhZwd3N+DGeWVrSYNesNmMhoI+/2i0lRuzelPzt5Rqwedq+fTLzpl9Y1PP0smeyBGDr1P2bKrrYldoQ7Ok7p6Msj3GjF04HXE7WrnoZF/FputMFpMgGbSNwfE8RGMjif+vDrUeEiRXim8c2vHAJT5hTOWLaSthRq5Og44sD9ezjpumDAQV7Np/brGF58biS/9p29Jg79OoWpYl8HaU6xv3N9Ovk9U2E97QuzUlEYW6URFe+Ew9fGvAIhOMjvGLDJXpo5zbpvGjq9XFPiftaEngaFcsgHJM7SMBxl5win2ntO6XPqMMxiPJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGXSYT70QV9Rw0CCRrlpM/W/SK6tzDSQr3ARU+q3iG8=;
 b=F5bbmufN3JK5Tg5vmGRBV2i4rV3IgBZZ3QkHNeyzRj4fbt+kCf9ByGYBgjvhVffJrd621otGnOAfVzd1PPBHCb5KPD/gh2g4FeYeoSsWEStam67dZ+aSNB77F44KFvsVJLgBiKUQmHO7lX34t//ST/h92nF3HqWKzu/7krGd/XCFFehOpOkXakN8TcL64aS8TJ3Dwevtbw2Y48W/NLVOIAkkmJtwU4KMHJrEU5vp23lMFoEYKMPJQ27m5sjTZyjeMnYBWulZH3PC8gXVBMxyRaBdaeQ+c5KeOKyPFtL4kzIqusP8wr9DfLHDIbUTs7l6N3a64PjgQg+5nU5cr2hvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGXSYT70QV9Rw0CCRrlpM/W/SK6tzDSQr3ARU+q3iG8=;
 b=Lz+RMWs+8MwwY0rYFWLnafQeYSCNWkTIYZzG/F4qoqqPxesFkC+VZJQq7V4dgtqiXSk1U/6/nlNRosj4gEx55NIitY98a/Xlf3CA0XXOoaRlCv8slJBzNiYHpwoVJdXSD7r31RtKLpm5Ptzv7Gw8B6RZEMrgH8k1of05PWXfxRv4pAxUuHOI6s/iYAdRKkwb+1BBwv13OrCVCsASwYia/FDYbf2/gzLQXMHEax81by5s3uEg4B0VlvhLLlMXK30ov/UTiOtu+5s4bBtSw7iKbVgWDJkMK7XFIsQ/U22bTHNzz3CTaP+vIYjnUVbKlPuzL3YuywpNgWEvr4SXByHSbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 07:01:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 07:01:53 +0000
Message-ID: <d2616a2a-aca6-408a-986d-48281e56e9da@siemens.com>
Date: Tue, 4 Mar 2025 08:01:52 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core] Heading for 1.7-rc1
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0c9521-5fff-4e88-0d73-08dd5aea71c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N1JMNkpRcC93SmV5R29janRReC83M0tVc0JzQmd6UEYyV09FMmV0YnNONURZ?=
 =?utf-8?B?MDRXZmZhcTU0TG54V3JJL1Z5dkFLWWM4OVl1OStVMU9xRnlNRzd6TDFoTUc4?=
 =?utf-8?B?eld0ZjF6d2YzOTRqU1JiZEY5WG82bkZyU294emJkSDRJM2VJR25nT1RCQlVN?=
 =?utf-8?B?RElhdk1wVmwvTTM4dzFHN1NDcHI2ZGNrYS92V1k0cnY1Z0xXdHBWUXUyRVZs?=
 =?utf-8?B?bTRhWk9sVXRjQUlaamozSDgrS2RERGdQSnZhMHMrYUVFVkk2N2N3d1pKRWxr?=
 =?utf-8?B?cU8vMGl6VmlhV09sUWlGRXNKdXk3V2FuT0hxdXFSR0RJcWdZVXo5TkhCbUlk?=
 =?utf-8?B?YnJnUTJlalp0V1VaS3JFUWRYd3hWdjZjRjk4Uk9sWkJGS0p2Y1crK0RHVm9x?=
 =?utf-8?B?VHlDRmRXYjNkaG1JVC85ZjlnaXp1WmUvT1doY2dNWGIxS1czMDJOaEtHZDBa?=
 =?utf-8?B?U2pQTldFUUZxZTBxc2ppZUJnT0VTTGVsRWFKc0Z1Uk1SNkJVZ0Nsd2hjdXdV?=
 =?utf-8?B?SVpEL0VtWEIwRTFldTJnZ3d2VTZrMDJKOHRxSEx3ZmJTZEQ5eXpOU1M0SDBl?=
 =?utf-8?B?YWJoWjRJcWY0S2NEVWs3bGtidTZOSDBBTm9WVmxDZW9MZU9iT0ZhaEcvcC9o?=
 =?utf-8?B?a2duQ3RRUW9TaHNiNU54dHZYblg4SmZlOUlsVmgyWjNPMkQwcnFiODNMT2kx?=
 =?utf-8?B?OWxCT2Z6WEprbXYxdWtMWDhwejVheHBvQTVoN0hrUmJUL1kvVTYzNmhGTnpw?=
 =?utf-8?B?clV5QUpVWlh1NzNWQ3ZGNEk1MUVqUXFFU3RtbnZLMFVVRVRydDU3UGx0a1ht?=
 =?utf-8?B?YnBpNDV6Nm41VXNxRld2UlMxTytpV1RBcXAwS3IrY1FhVkhWUHJNcHMxb3Iz?=
 =?utf-8?B?WDhYcWFoQk5BMXIvVy9LQ3hLVHg0UUZaeGc0MG9aclBaVndvRmpUQkM2QkZo?=
 =?utf-8?B?QzhJYThpQ0kyUkJodHVUSkpiUXIxUmt0YS9kUXBoU05Jb0NXVUErR2FBWWdE?=
 =?utf-8?B?aFUveExrVDM2Lzc3Y0ZxOW5mekNaUWxmTW9veng2UklXR1JGcndBeEZFU2pa?=
 =?utf-8?B?UXRRVEhla1hMNmF1Zy82U240amtiYlhNWndBSlAzZkhOaUZ0R1dlN0s2ZDc3?=
 =?utf-8?B?a0QvTFlyN1UvbzNFNTBEUFMzYmFvVUdhNVBVc2hXNVlIbnpBNHk2SzZ2NW92?=
 =?utf-8?B?VUFseCtVNGJtYjQ1bmFLM0dhZ21kdGNlcXM1QTZvVEZYVDlWT05nZUxjNGJQ?=
 =?utf-8?B?OVdNVkNCQ0xWRWZLYTU2aWljS0JRZjFjanpDVXJSS0N2WDdNR0dDWXQ3Y3BZ?=
 =?utf-8?B?STV2MHZtN1dZbUUyYUt2QzhrOXdZZHFyOXNzWGxuaGJBajZ2U24vbkdDbFJj?=
 =?utf-8?B?eCtNMjBNOU9OS3B5WDRmdVNYNmxGcGtqa2ZGRWd3ZG1YQzNsdGRYQWVVSGh5?=
 =?utf-8?B?T0ZkMS9mMUJTaDB0K1NBdUUvWE1qeUhNUmNxZ0ZaMGorbjhiRTRNZzZ1bWo1?=
 =?utf-8?B?YVB5cC8vQnBqR09LS09QcU5IT2ZrWkZOeFVXUGpDdnZjSFFXc05lNXVzWDJH?=
 =?utf-8?B?UVRVZ3Y2eGkreUdVMnVLaTJDMWF5NjZ5ZHEzczZGN1ZRci9yejJTVjRIZVh2?=
 =?utf-8?B?aWNFRzU3RGljNGhoaXRsVW82TTdsTmRoTXJYa0Q5dkNpcDByTGd4UEJ4eEl3?=
 =?utf-8?B?TzJmbGpFRkNXYkRuaEJFWnBRV0FpV2J3ZWNidGhBVjFkYTUzcVZSQkR4Sk9u?=
 =?utf-8?B?Wmc2Q0xmb3o0WGcxSVZjcnpLNzZ3a0E0ZkI2b1MrVkxUcC9iZHRrNXZpWURl?=
 =?utf-8?B?b0pOcGhyYldkK2w5N04vWVl6VmdydlRkUEJ0MVRTQmlmVWNhN1BoVVl6WWJw?=
 =?utf-8?Q?dt+1OyWUGCT1g?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejY4WnVaR1UrT1FKYjlJMXV1bTJUNVZTeXo2TTYxeHpkakh2a0w2bjZQZmVZ?=
 =?utf-8?B?VWJPcjlKWFk3WkZTUitqVEpFUmFDRWFnaE1lTkt2QmpBQkZYdzVuWEoxSjYz?=
 =?utf-8?B?RnJSMjltUFM5UXV3ME5aS01va1VOMmw5a1o0UkgramNXakhpRDArUHJFMk5m?=
 =?utf-8?B?ekFieFZHbGJVVmp3bGZNeUswMi9mZ3BLWDN1citQSzlZQ0ZhWDF2RmpxdDlJ?=
 =?utf-8?B?eXZHZkxCcm9NakpZTlJmVW45QVpWUWRnYjgxZ1h1MDVOeXlJelNvSlJyUHFJ?=
 =?utf-8?B?MmlkckVFVkt5V2xCbUtqdkFXd3V1aEpIV3daNStSL0NEYlIyRDVnRDkvVkhy?=
 =?utf-8?B?RTltcklzcGs0bWFSN0FBUUU4U2taR0phaVpMVlAxdXNhc1FlMGc3d1pFdVdX?=
 =?utf-8?B?OFVxNlBDZ1JmeW82OHdCMExtQUl3c0ZlK2luMWdCZlY3UzBHOWlzQjRVZTZG?=
 =?utf-8?B?b1lTRUY3ZnJDYjZEZ21EdGFwRlZDclpSaDZwM2JwTlgrS0d4TGkwUXV2ZUND?=
 =?utf-8?B?eUJkZWNYV0VUblBzaTNvSWplV2JHV2RoQVRuRmV6WWwxeEwrbkx4SmdZSFZF?=
 =?utf-8?B?bTJUZUNHdVd2NE9vRHAyYW9raVBsZjE1T1cxdkNrS1FNZmlzVVg4eEMzZ1h3?=
 =?utf-8?B?dlhTQ0pWMmFVTU5oeXFMenIrU1JlYjNsc09aZ0JTL0tuUGpVTktkaXArVHVD?=
 =?utf-8?B?VUhtVmNvazlISFNScnhEUkVvYkxMeGxzdm5valZEZHhZMllETjBjWDFmVVV6?=
 =?utf-8?B?WWpPOUtHQVk4bUhQb2hoTFBobWlKbzFJdkFjZ210RDQ2cjJKV0lUTVNFUzRu?=
 =?utf-8?B?V3R3YklkdkM2bU9Ra012aHRMTUQ3RUtqeHU1b2oxR1JCazR2RWFjZzBMNW02?=
 =?utf-8?B?SFpFT3VKNU00YkttUHpxR2NxeXJ5RzVJaHQ0YzFOZTgvVVVVaFVDaXRKaDJU?=
 =?utf-8?B?YmZlS0xkTUJXcVdUNXZkYjNsMWRNc29lYkw4S3AwRmIxNWU3RWN1Q1VMN3Yw?=
 =?utf-8?B?RS9uMXAwVFdsMmdOWDl0SEJTdlFsd3U0QWdScTh0MHlYbmVabnlWY1FHQlE1?=
 =?utf-8?B?KzhjRTFOSEtockN0a2xpaVhzSEdrY2MyTnIrYkdXLzFVY041UW93d25ZNDFE?=
 =?utf-8?B?QTNmcXpKZmNzWG1vMk4zNEZBb3JQZFJ3V1dJKzM2Uzlwc3htV1paNmNtQTY1?=
 =?utf-8?B?RTdVVUU1bFNLRllWREFOeGVHTTRUcXdobDRaUDUrTkZqeFBSd29DRXJXV2d4?=
 =?utf-8?B?aWlRN1RXM0tpcHA4cEEyT3dOMjZRbkN4a0Joald0ZW14UU01UEdjL3grNEE5?=
 =?utf-8?B?UHVqV2J6ODhiVnNHbXFjbThtNFhzZnNaNEhHWUR0eTVHMGhCTjJyY0oyVmU3?=
 =?utf-8?B?TDZEYS92clNVaSs0aFJvTG9ERU56NUxFWWhRYmNPdklKVklzazFiSXE5OGpi?=
 =?utf-8?B?c1FrOXZSRVd6MVI5TDFFUTRSNERVK3ZTbk1ZbVdJalRPL0FJRFI4c0RQRktS?=
 =?utf-8?B?dzkwMXVuMk1HcVhxdXRoM2NrZVpYVCtFeG1maWR2NGtxY2hldEhyNTAwSWdN?=
 =?utf-8?B?Tk9DQWoyNU1XSEIrcXgxOGc4b091d3lYMHF2cTRNMzJERjc3aksvdmxyNDZQ?=
 =?utf-8?B?cUNHWnYxakNkVjZRelFPdlpzbitweWZ2bTNnMVNpblM0U2JYWHgvTTdCQmMv?=
 =?utf-8?B?RXdweDZQY2pwWEpvVENPSm5qTlQrcG5zL3VwRUhGZTBIYUozNnJGYTFVamtG?=
 =?utf-8?B?dGFFc1dLVW8wQmJYeURackxidEswU1hiTUtBRTlDR2h5elUvanBDb0NJVlNV?=
 =?utf-8?B?OFdkUkRjNVkweFRtV3ZqZ1ZBczQ1WGdtSXhSMHZTcCtvdlBWdlRRQUZMN2FT?=
 =?utf-8?B?WFNoVGJpcU1RaXRQS3JoSWR5cm5vSmdBNzhqci9ib0VnZEhTVDYyeUEyUmtM?=
 =?utf-8?B?b2JEV0dWSTFRMEpYWTljbHQ3eVhrQ2krc3V6Q1FRWmlRQmpNejFQeXNtbEpr?=
 =?utf-8?B?cXFFMjc5bXpkaXhLb2gxbkREbFVMekppZElnNUVyZlZFeEkzT2NnYS93MDJY?=
 =?utf-8?B?UDNmQ1hHWXZBTnJlOHo1QjRZVEJ2ZFFrM2xBUHBTVkpTRk1PSHI1eHJvNjNE?=
 =?utf-8?B?QTQvc3lpRkczTXVDYVVYTmFzOVQzeTEvNmZuRVVpNDVxbzdhTnRlUmFiMXIv?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0c9521-5fff-4e88-0d73-08dd5aea71c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:01:53.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99GJeH022LmhAkNQXzT11dsalJZUnML7HglDssYELc9Yc8MEc4LYcMv0BUomdaiUn2Sw96m1/BHui5TCLaEcCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7923
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 07:02:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18010

Hi all,

if all goes well, I would like to have a 1.7 release of isar-cip-core in
about 2 weeks. Therefore, I would stop the feature development cycle by
by the end of this week with tagging 1.7-rc1. Make sure that any patches
you would like to see in that release were sent early enough to consider
them.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


