Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C541D358D0
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 07:07:45 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10118.1769670462446104845
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 23:07:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BM0iBKUG;
 spf=pass (domain: siemens.com, ip: 52.101.66.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEUXGdnwE0rpm2OO4wYLw8RZb16htgW0ISVJxKvVnKProDUreYGW/BWUtZYsUb+GrM2PgGi8zW0OH5VixqYrj30aFzVkz/hgmY/4cl/AN3K+t2bvuqlt0Auuj5iq0X0UO3YUCxWiP1kQS9ZU9kC4vrpMtTZo7IhHgm/hSpN8Cj9XzLjPnIhW9rGTFHLdRypPsmg/0XRMhQRjT+txfSMnqUvK3M/GN4uIcnAtVauqJFkeh0RDQnDdNEQ+qYtI4wl7ONdlHODXX2JvDkRRUsl5RwC1RC3mzYTjoURiAn/1OVeDX9NiENa8rtYl+d8KfUBVfZyugImGAXRJk3wkj+DhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djzCEmJML3pwNwaB1YnXjZkpOBJCzGmmwMI24Yx9yfg=;
 b=v+bJP/PpBkZ3RRGiVkgMi6xUNpuawKmQQU/ob4dabeCjSMyJCy7b5ae9UmZRdQ6FrCMF6/sNGp3cX6SMjf4bYH4VIC4nuaWzWRj7z1wA9wCzbFBwhgoDm+Ccud0thTCg7Az3216IEAa3LIAdqddWpRniICxO2IXdTx4XBXE2m+jilaVwP079PZAWN7uXRCnKo4oBFWdiyJXpwHvgSdAI0N5D87+ePKgcsObFQS32f5z0LEQQUmXCzegPNEb6eQG9tHlZAIrh3LyWKGo8sD2gm5Jp6GYD+ih4+xKTK7SI1WLjvLsOdCPIHXCwrX8j4zm8suJ/mUgeEW8rxlB8rbzhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djzCEmJML3pwNwaB1YnXjZkpOBJCzGmmwMI24Yx9yfg=;
 b=BM0iBKUGz8iMcZPAWwqSzfIQHacJCsJy3iWbQQ99YfkLOtT+Cv/dZy2Z5nnawTNMiEs2qEWwz45SigvBAAKIdrJ1fM0f2hms4x3p4O0zudJ0H3fU6OLKa9DHRfa2Z5oyeaJz2omDdaow2fjc4vaxs8gW8AcmDgbVLoWw/nPyl1Go4rFrk8gjlF/yfEiySyov2P0kzTTq3X52qI7swBRxu0weQ7yh8PyPzzrkdZjy4l5aoG1iSOQRMBLiYhLGPxeZsaa5dZvurH4/+b8GY32GUFfuFs3FCakB5TbczceR8kditP7JdjokF5K87NAJmySXLCXuw2nqo6ZkaJY03MGBeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8741.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 07:07:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 07:07:38 +0000
Message-ID: <1fc868af-c174-4dc5-9a3f-91ba64685f3e@siemens.com>
Date: Thu, 29 Jan 2026 08:07:37 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::39) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 947c3412-bbb2-430c-1533-08de5f05163d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L1RNckJuSWsycWRxZXZtS2IyZVZnb2FiUVhzYlFkdFJ1RC9aU3g5K2JBeDds?=
 =?utf-8?B?eDd6VDdCSlBaTnhvS1NJZlVYV0Fid3hHb3NDOW1xcWxaMlpiN20rdlZYSEVC?=
 =?utf-8?B?V3BJK0JzWWtmdVQ5M1FhRW5yQWk4MzNoSFdTWGVsTllEWmZUUmJPRmpGSlhC?=
 =?utf-8?B?NjBWZ0dnV0pON3NnUmRjTXBaeEt0WXRoZnpsNHl0WVR1S2t3K0pRNnhnak1r?=
 =?utf-8?B?djJJdGNCcmJyL0xQQjd1cEhIckNvNFY4bXBxR1YyTlJZR0Iyb3BtOEtFZGZk?=
 =?utf-8?B?TW5RTmpndG9RYUQ5U2V5WXptRUxqVkU5dDRJbkcraWZDbVZBUVlrVCs3SDJG?=
 =?utf-8?B?SW4rQ3psQlprM3lHK2lnem92NTY3RE9vbUREYVF3UXJsV3Q1d0c0U09WWm9z?=
 =?utf-8?B?U2JxR0YrZUl0dEltSGVLMXBYOFJXeVIwRU1aVkVwS2FaT3V5K0VXd1NJWEFq?=
 =?utf-8?B?SHBOSjR1S2FWN1d2Rlg0cE8vb29TdW0yODlTVDlZVHltZW1qakFFcWsxSm9u?=
 =?utf-8?B?OUNEQWxpcmVkYS9uUS9uSXhuNG9LcXBpTlRzbnE3dEVsSlJBdUhxVVYzUkRH?=
 =?utf-8?B?V2YwSkYreklNRm5kTnVSVXBrdkJNWEVWTGk5SFFhMHFKbXA5bEhVZUp0MGdt?=
 =?utf-8?B?Z1puZnlGSVU2dDM5Sm1nQ0lZZkVDTFlCMkMxWHhCb09QbXJMZlJzaUhLbG5m?=
 =?utf-8?B?RGpOMy9mTWhZbjVGTkNIQWZRM3lBR2dZWGFlYnhIbkxzQ2pVcUF0UWxGamtl?=
 =?utf-8?B?RnFmeDhJTjIwUVRSMFZPeU00Q01aV0hSNkJZZlVRa25WS0MyR1NSSWN4T1h3?=
 =?utf-8?B?NkcyVWRnZlMyWHRTekRibXRSRlY5T0g5am5ZNmtRaHEyTGlaSVhmR0MrQXBB?=
 =?utf-8?B?T3lPei9FWjhwOFpsaGZQV3lOa3NPcThzSDluUlNUVFkzekRrWGV6dlZoaFF1?=
 =?utf-8?B?NFM2SngwbE9wOUNmSmxWWUNVVFFHdmVLTFExM0czN0VjZDZEN1FZRHJoTmZn?=
 =?utf-8?B?SGgzMWNEOGVBMHc0OEZkMjFsKy95WGhqNThhTHltcFhJa2RiVFNiR2tIcnds?=
 =?utf-8?B?RTZFY1BtS01mY2ZFYXhFL0h4WjZ0VlZqaGRidFpEZ1pQbFd4NUVwbGIyMW9T?=
 =?utf-8?B?THp1U0czTGp4aExkMUVBU2ZUeUd0bnU1NnNGZUdBdDd4SkUxak9sQ1BveUEz?=
 =?utf-8?B?TmVxb29NWW9xOTdER1J4YlBOaEY0cEtqZXFPTXl0RlM3cjdEUjgxd0lXV3pK?=
 =?utf-8?B?RFhlQ2lIVnRYT0llN1FaUHpLdjBjWGI4eW9XOU04Y2oxaGRUd0Rta0FaVUlQ?=
 =?utf-8?B?SU5BZjVhL09LTXFTV3Yyd3Z2Vm9GRnFsVEw3T0ZHOHV5eUZIbWFzWDFSYnAy?=
 =?utf-8?B?cHcvSEpUR09TYWI2VUlHWnh4djNvbW9DdXErMDRzVDBsL2xjYXZ5WENyZnpS?=
 =?utf-8?B?MlFmRldIZVRTR0pEY2JjVlBpRXlCWWRUQmxXa0FhZjNRdXhhNENtTmNvUzly?=
 =?utf-8?B?RGdYUjFHV29WeE5hcnI0STlYeHo1Q2l1SUZXbERBUjBjNm1lUTE0UW8xY2tG?=
 =?utf-8?B?WmFHdVB1akZuRTNWZ1Znd3lPVU1kVXFqUkQxUktGK2FRR0g3a3BoZ04yOVF1?=
 =?utf-8?B?L0k4dTRoS0twMXFKSm41ZjY2Z1oveTQ0SDQwS0RiNkczb3J6WWhUNUdtaWo2?=
 =?utf-8?B?cm15TkdZYUQ2ZnFhLy81aFo2NmptU2d5Vnc3UzFJNTM3YzFyNEF6Q3J1cksy?=
 =?utf-8?B?ZU96cEVLT1FXNGk3Z1R1L0VFcUI5RTJvaGYzVUdaa1M1aDR1ZjF1SlRZQXJH?=
 =?utf-8?B?Qi9VbXhEc010eUsrVzZNZThHVGFOekdsdE1mYkgzS3N2MGJhOC9qdDJ2alRh?=
 =?utf-8?B?aVcxT0t2KzJ4ZU5YQzh0cVhoWWxOK3VXZlRtM3FMT1RETFpFQ3BFQTRYNHJk?=
 =?utf-8?B?cXRrUC9CVXJhQVpqNk9BVFYzSW92MDBIOHh4ZlcrbGhFaWZ0VkM2Qkp4RTlC?=
 =?utf-8?B?Vkd2VFpOU0VYemZXN1ZYZUY0V2JyWTRtYnZOcG1FaTgwdWFadGR3V0tzNDFK?=
 =?utf-8?Q?K/00mE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djMzTEFvTmh4TmgrRjlIaUhYQ1BGd0JsZi9aSDFhM3FWSGl3UlV4UjZ3THFW?=
 =?utf-8?B?V2Z0UHdZODdEbFdOdWpJd2d6amJGMHlKOTgrckxKMlJKSVl5UjR4WkdqbEVK?=
 =?utf-8?B?Q2EwcXpvVnVkQ1NQcXlFN0hmM015Z0Jia2hjSXF0NVRVYklJSmhVNHpMbU5r?=
 =?utf-8?B?WVZQWGQ0T090SGx6ckl4bE1Oa1NuVlhmS3d4NDV0RE5DdWU1YU15QWVOaTkv?=
 =?utf-8?B?RXFJOHZUK1Q4R2pGOTY4UUNNMStTc3JhZHNQcXpJYXltRkxqQ1hBbnRoTWl6?=
 =?utf-8?B?eUwzdFdoQ1l6c3M3L3FUbjFYc1dLQVVmVHN3aTNiVlVxVVJVQU0wamc0b2ZC?=
 =?utf-8?B?ZDZlVWNhS05BNTg2cklOcFVwODR6SGxpcVNzNVBvSVR0eHJEMzM1TXIxZnVy?=
 =?utf-8?B?akNwb1RmSUxhbFdGSWRPRy92VmhmbW5xckpVM3RScUFxdGE2MjREc2JuKzUz?=
 =?utf-8?B?UW80UUZRM1ZFRXZNZW1pZ015RUl6U0s1UlJUckJ5c3M1SklPZ2xEZUtwbU1m?=
 =?utf-8?B?R0N0Mm1sWmlyenAwamp6UjFadUFqQVRJU3krTHFBMWFkbFdhYjZ2cjRrREpR?=
 =?utf-8?B?RVZJNmsrNFN5OStpQkJIcGd4eld1YmVOcFpsNXpXTFFZWnhiODVDeDlSMGpX?=
 =?utf-8?B?bER0OTB5dUx5YzBicDNVTFIxUldJV0c0RldUUHJKdy9ESHczNlZnZm4reU4z?=
 =?utf-8?B?dWcxdDFIQ3Z2K1MxeExtcnZtRTI0SGg4MjB4M0Y2MGd4MFZCbGZUbHBXbDA1?=
 =?utf-8?B?RlEwMld3bmppeUQ1MG1vVmJFMEozZnlCOWQzbXZoYzRmc0ZKZUtwRXpjZFRL?=
 =?utf-8?B?M2VYeHErUCtsemhPemVNdTBaWERrbGZrMHBZQXN6S05HcnQ0ZTFoNkNjcjFG?=
 =?utf-8?B?TzhicjF6clYxbHlTZ1ZmcEpvZkVJMHMxcExPYzBybkZoUXZ5YjhIUEZzOVZt?=
 =?utf-8?B?WC9zeEFNclhhTjNhTGp5WHlsZ0ZOUFBReXpZQTNzeVBObWo4SDF2bUtnYkhC?=
 =?utf-8?B?VjU1UVFVU050SG5QRHJITlJLSGZUMUhjWVljSjdrbGtwODhyZ0l2WnNzSUV2?=
 =?utf-8?B?aEVDYTg0K2t2RmdvbjE0alk5MWNoblErR2Y0eFozcG1YamI5RFR0ZWJ0RjhZ?=
 =?utf-8?B?Vy83VGpiVEFjb2VQY0VNSk1UQ1R0aDBMaVd6RTlDelBTVjhVRDJYWWVVdnlX?=
 =?utf-8?B?ZnlYemRFOUpYdVE5T3dIK0ZIN2x1M29MS2RnRENFQTBuMTAzMEpwUVVkdE1W?=
 =?utf-8?B?VktVYkMxT3hWMTl0dDVRTC9HNVdCR2RUTVNuK1Y3Z3ExaWxVTmFOeVo2TDBJ?=
 =?utf-8?B?MTFaZ1M5QStmQkF2dHZ4WUVVZEhCYktHSFNpY3k2UVBqKy9FeG96Rld5QXRV?=
 =?utf-8?B?UmVGeXh6VDQyd3FsQzIxeC9PdmdYZEpleTBNbEVUM3dpYlVQVEJGUENjb002?=
 =?utf-8?B?WmdFamk2NlhBWEdPZWx1bnpHTGNNOHplSUpUVFNHVTRiTEh3aTJpM3Jkck9a?=
 =?utf-8?B?NjdKS014K21VUzBHbTB5RjU1Q1RhRWNDR3BIL3NEc1Q1TFJZM01nOFFaRmJW?=
 =?utf-8?B?ZTZibzMxTmxPdFZWR2VxQ09UQlY4UytTZDZTS3BDdyt6eDF5bHBQUk8zZ1Ex?=
 =?utf-8?B?RHNLandLSmtEMWppM2Z5TzUxTHliTldPVG5RVlNxTnFCeDdML0pTL3RoREVY?=
 =?utf-8?B?dE9tbC9kc0V2NFZUeDRzSW1PaTRpRE1pMTkxQWxaSjN3M2xBMXY0MVpWVHVy?=
 =?utf-8?B?Vk5XWnlLSi81UWROYWpkQm9TVW5sRnZDZUtMU01rV1F1dDZmMFRQQWRPamY2?=
 =?utf-8?B?Q2pJMFYxdC9nbitZcFlIamYyRmgxeHJFNVNZdmRwOEpVZlRFT1hPVTFVR2pH?=
 =?utf-8?B?WE5JRHdpNnRCOE9HeWhaR0t4TTJDVmRreUpsYkJ6L1UzSnlpL1MyaGh6RVNw?=
 =?utf-8?B?RWFnZDJtOEF6YVZlakg5eEJXRXluWDYzMHd2OWtjWlFtQWpFR1EzdDNaZ2Qx?=
 =?utf-8?B?RVlOUndGOURUUjViSWFZMFIrSXA2QjNNV0ZZeTN2SU1kUTludGxKcHRETEhT?=
 =?utf-8?B?TkhkQnNYQytzVk1XZGJaRG5kQ1JIRjZyeGFZcDlTeXJ3S0hDQkRTNFBYN3pM?=
 =?utf-8?B?b2JEQUdaNTRxNFpoRjBGc1dpSnltdkxyb3BJZi93RUlqTTJWN3NzZ0NzdHgx?=
 =?utf-8?B?TFBTVTRYTGRxVHdRUjFERFhuR2UvUytNS2FrTjdCeEthSmNNb1UvR284aVVP?=
 =?utf-8?B?RXFyRStBNVo0OWNOSUhNTlp2VWRQWWllOGdPWEFicFhFQk9PL0pFeWR0Q2g5?=
 =?utf-8?B?R2hIRk5PQkpicHBjL3RHaXhVZ0wzSmRyY0tEamp5NTlHZG5QaERQQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947c3412-bbb2-430c-1533-08de5f05163d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 07:07:38.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+5fubxw4ri7nF+NThnBPbZDmdTxSsGr6S+Xeq7h9HoQs4Mo/Bd2aJE2tLWgNvP/fG+GNGjybNgqnsK8NSHhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8741
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 07:07:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21784

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=1&day=29&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/01/cip.2026-01-22-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jan 29 07:06:06 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jan  8 02:18:47 AM UTC 2026
  limit date: Sat Feb  7 02:18:47 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jan  7 03:16:59 AM UTC 2026
  limit date: Fri Feb  6 03:16:59 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 18 11:41:27 AM UTC 2025
  limit date: Mon Feb 16 11:41:27 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Jan  9 05:02:19 AM UTC 2026
  limit date: Sun Feb  8 05:02:19 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Jan 10 07:38:46 PM UTC 2026
  limit date: Wed Mar 11 07:38:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Jan  9 02:26:25 AM UTC 2026
  limit date: Sun Feb  8 02:26:25 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Jan 23 06:50:44 AM UTC 2026
  limit date: Sat Feb  7 06:50:44 AM UTC 2026
  Status: On track

