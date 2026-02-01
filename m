Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE11E7C71C
	for <webhook@archiver.kernel.org>; Sun,  1 Feb 2026 13:06:35 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28957.1769951181658533806
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Feb 2026 05:06:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OTXFY11r;
 spf=pass (domain: siemens.com, ip: 40.107.162.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swk15b+TaJwp0ZvORgyGEcgE2rWWtBgw9aImEOUAV0LnGMHvlylLMr1+WfHq7EIvCWBIHsW9WJg+k/h2J/9E6HzvlfRxLZOyoJWs37EfYouidhJP5VnsSBOk0OxDcxXF4XaiHsQcZjyOo5h/RRbg5AUR8KQv507sDxQLkCsEVqMkuJKPAkR92tPtcnR2iY8UxOTIfIix2nO5qEY86ynh300gEcqNfGy9OA7DKDKMRLI5M2QZGfnmlYnuG+aYuBf76kXoHwlBTWySn7xtiH8Ve4tlWE+9wl5AjhiwXWVhagl4S+pSfkLfGo/GMXs3S8RBgbPIJRJCX+6J6j4OlGMFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PggqJBbu+gb95am4cB/Dj2xjZ1WfktdaYGpSWAJyFPM=;
 b=PrnY8W/HsmiEaJxBBEuW6FMqUEXxNNIQkCqUMIFspJsFVSul3x4aQRLakHmZ6w+CxRvGZI7Peojzutv7T0Y4G/Aq88YEfuMH0+vVGX9iAdM0NUvBCD/G03lQl2130yjQCC94KNTGCvudxT+eSWyERy5fVq+AFc1izWHXew84tnUIHdQn/gI6woe05hrtoBly4ZWkgraIjFF+eBwj7Gmmzi6LFZ7MGOdAH0+UGwctmx75RUqN1QWCTqH79DKx+8EzCmYDpewl4bn9Dg0bvUitCKCMdQc2dAPUQSIFox5jzz7qwKbJvBw6s42nRvU0ou2B13hzchQR4XyiMfqcrZGGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PggqJBbu+gb95am4cB/Dj2xjZ1WfktdaYGpSWAJyFPM=;
 b=OTXFY11rgpOdlMqPK0xhAOtUckCSO0nELvqzJJTgIvcdCMGlqtP0grPFtBKq4hDAc/J9cGwqY964xkXzWUsqzUK0VfiMRHB8AhVoJM7WSL1bygYWeX9p8GqDOOblUlgWdQR0+FJa9YM7nxtLNtMuf9gnbT2B1a9l0dOYQ3r8/1aCQJXnQ0A46XOeO7jUy/0QyV2T4If1N9yoxqIyOslToSUpCFOr/Y7U7nErT6dbtASnIpW8+TNA3mmmkWouOnHxEkfWHQoIUMP98DUx6drm4Yfvxvkzzakx28uyoWPHQaJFazodqKhIquBvNi3xuW0yS5Rn65Sv8O5oZEs85BCqiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6797.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Sun, 1 Feb
 2026 13:06:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 13:06:18 +0000
Message-ID: <82a2bdd1-3fca-4223-abdf-a067b1ed665e@siemens.com>
Date: Sun, 1 Feb 2026 14:06:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] IEC_template.yml: Update IEC layer tests
 revision
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20260130123306.638831-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260130123306.638831-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 760def7b-dd4d-419c-54ca-08de6192b003
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUx5TXpQaFdwaFc1Tm1pNWFDVS9pbUIvWHZGMXV2ZjNhY2JMdGNSUkI4czlQ?=
 =?utf-8?B?UHhZU1ppWjNnSEN3TDREZC9kazdFMW4xdHhGVHRMNTRheFRaVXU1b2pRYmRh?=
 =?utf-8?B?QkFiazFHSVk0QVp4ZytHYnlhU0JGZ3FURHdMcEJZL0NKaXpkQTBSQUNsZmpE?=
 =?utf-8?B?VEw5amxNM29VemJPd3BiYTdiNjRnejRXQUdxR0hlTTRhVk8vdzVLRGFaTjJ4?=
 =?utf-8?B?UE9aUlh5dVJKcVkwQ0E3OXZOY1B1YlBOZHpPNU40R2ErZHVIa1cyNTh3VVdw?=
 =?utf-8?B?NTE5cnVLcDBWT0FmTnZNT29MWkpmMEhrUXlCWjZKWi9zSnZrckpVdUxjTkpJ?=
 =?utf-8?B?aVhyL0ZMOVJTV3BadHVUdGt6bGpxNCtjYy9RSTd2TmtaY1ZxRW5IcHdodlhJ?=
 =?utf-8?B?L0ZDQXRTQytmbU5Hc1V2RC8vWkYwbFArMnQ2TFVwYjF2ZGg1ZnpRWlAvQ2lj?=
 =?utf-8?B?Q01IRHJpQmpLYWJLeEtVZVU5cTBHdjJLbC8zS2dFcmJWOW1ZTFlpbWM1VWxT?=
 =?utf-8?B?WFRjMi9nZElTSUowZjVJL2IrT3JJVWZNYXhKRmhTWkRKSWsyaWVMMXduU1ZT?=
 =?utf-8?B?OW1GTDUwazhmdWpSeXlNbEh4RWxtaVpiU0o1K0FtcmhQRUF6VEhhMERkZlN3?=
 =?utf-8?B?YUhlRWxpL3E0ZWJ4U2NDTHpkNjUvWmlyUUN3TDdSYXJMTUgzWHB0K3pTamVT?=
 =?utf-8?B?Uzdrb3l0Nmk2ZFZCdlpYMWRnT3Z1dTZaOG4veFRSUERyZlIxY0YwMkJiSTJZ?=
 =?utf-8?B?UlZxN3lNK1NQM3RNQmhXZHpUMGJZRmN6L0pDRGdsOHpLWVFKNzZmOWZlcE1K?=
 =?utf-8?B?QkZZQ3gwSFpzRmNxQzVKODZUU3VqRDNOaVRJREZadFRseTF2bGwybndtNXJH?=
 =?utf-8?B?Z0E3ZVFXY29jWWl0ODVFRnZWYklxcXB5S1BHUmxoaUdXbmtBRk1MZElsdk40?=
 =?utf-8?B?UnpUakR0ZTNQVElnWVpKM2YxUHRnSGVtOWlqQVRISklFaS83SWZnTDV2dTJD?=
 =?utf-8?B?UW5Uckh6clQrWXlXTkJ4WjRGVUF4Z3VSY2VaVFRSRGJKMENZSld2aHluZUJY?=
 =?utf-8?B?WEE2WFVsRjl0b0lhbkZpS2dvSS8wdzkxeXNNcGoyZHJTc1phYVZPcVJETGJv?=
 =?utf-8?B?TVhkcHlKbzBsNVN5N0ZJbWVXUnZlVitvWGQzMWpUM0JTbjRBZXdQZE80L21t?=
 =?utf-8?B?dEFqVytHaGZXblJneGlQN0xGZEZnVFF4WVFHaEVWYUhLM0lNTGpEaHh5ZXhF?=
 =?utf-8?B?NkhMajJKa0k1WlcwaFF0UHJWaWtxTTZvZDhMN3pxdFhwa1hzbG1ZVEc4cFRK?=
 =?utf-8?B?R0RIdVV3QW11RHBLbld0eFdoQWMrb3ZZNDBLZTdqaW9BUVBtcVlXMU1MVmpi?=
 =?utf-8?B?eWxxVjlCdklBQXNuSk84T2IyV3BsRkRDazF3SmlmVytUQTZpVFp6SGlwSVh1?=
 =?utf-8?B?NlZibkxxVjV4Vmc1S0VVZWVMRG5vSGhZRUxEektjaVhFWFhjc0Vnek1NVkl0?=
 =?utf-8?B?dXlZL1ZGWVp0cUhFdngxMlJSMTZkSExoTWg4ck92Sld6ZU5vakM3N2pCSU1T?=
 =?utf-8?B?aVd2MkhOaU84SjV6dXc2OTlGNFRzNTBwajZoa0Z3OW5zYnpkWjZ3aVZxaEZZ?=
 =?utf-8?B?MVlVamxNWXQ3ZnFDR01aTk9mUlpLNVBQaGIwSUlldTFnU29qV3Fzd0RDd3cz?=
 =?utf-8?B?MmhqZ0ZIRjRzTldyM3JXYzg3cFZQdWs0emNjT2FucCtuZWtZUzB4N3pJM0NN?=
 =?utf-8?B?ZU8zYkxGTXNYMmpPZE5rWUhOYURkSmNpRisxNnFrVmdZYTNQbTFnQXJrWmtC?=
 =?utf-8?B?Z05XOEg5aWN5RCtNTkd6UWhVcjBNQ3VJQm5ndDJDVDE3cXlVazUxeFk1YXYy?=
 =?utf-8?B?bVl4SW1JY0ZWK0VxVWE3bnJmUHVvQmZJejJwa0xnMEJJZE1qSlArOG1ybmpJ?=
 =?utf-8?B?ZEZwT0wzYUV5OG15ZWd5TzRKT1Z0T0xNblFrMjVZVGNJSlVSaHBlN2VITy9i?=
 =?utf-8?B?ZVJONUVTOGVpclFPVDkwWVZqbVcrRGZFU3N3elRhVytKaTh3b0E3U1FzcElu?=
 =?utf-8?B?S2NxajNPNkI0c2ZlMDludWpIR0xOa1c5anRJZm1ObUxpVURLOWVYTGlwY2Nw?=
 =?utf-8?Q?RYLo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnVKMVBvdTFkeTh5ZG51V0w2dThKK014NzJiVXphMTcwdHBmVjB4cm9SZEcr?=
 =?utf-8?B?aWlTRHlwbkx4L0kwZE1CWlA0YWVDS1Y1UlZFZldxV09CNTE3aTMwY3VBaHJQ?=
 =?utf-8?B?cHkzdUhncVh0N0FOYlRJc3ZGSlgyY1p2cG50SGVLa3BybXFPY3VMS0d0UjFN?=
 =?utf-8?B?QndYZUpVZzZHVEc3ZmpGSE9qL2hWeU5qOG5FWndNMlJ4NjU3YzV6NGtrd3ht?=
 =?utf-8?B?WGFiS0hwRndJZW5kSnlQUkRmWmRnMFM3Qy81SFFHTXpZMmpBdU5ESUsyMW5i?=
 =?utf-8?B?OTV0UHlvdDRqS1lYeXVHT1RPTnNLblYrRXBNandTNmp3SmRDYkJuR1NhQ0pL?=
 =?utf-8?B?eHVBZmNXWGJyM1lpNTduRDdRKzNGbjNoaWFUNWNMS1VwZXpZSHMxOHJkZWJW?=
 =?utf-8?B?TGpTQStNYUFXL0svY01maUI1dG1HT1RVR3I2cGtURmRaOGp0ZXpVNFBSQk9a?=
 =?utf-8?B?TkQ3ZVJKYkphVk1wZWFKNTJFV3BTdEZUYmFPRStCbkltcVdnUjFsSGtiTTVP?=
 =?utf-8?B?SFFNY2poN2Q1WGJ4ZFJvVEtOTzNTbGdQNnloclk5YS9zMzlwTGU2cVRYaGRj?=
 =?utf-8?B?YmhsZzQvTzRDR2RSOFkrOERKWHRiYTFYeDJ2NTRHdzh5V0JoRmp4dVVxS1g3?=
 =?utf-8?B?WGRXMUlLNHk4Y2kycXBmbmkrZ1BXdWpvOHorY1BGVzIwZlRVNDlPZlF3UzBZ?=
 =?utf-8?B?Q1NTMWxTTEJQamF5VHhreTFMb2g2MnZMSW1qdkxaZlJETjN2VEY5ZjlTa2k5?=
 =?utf-8?B?VDI0eHBjWE5CODlIV1ppQ1FPOFc2TkFlMVZMVlE0L0RxNnZ5aDZXZjdBbEhw?=
 =?utf-8?B?czRxSjM0M01qckRzWUZVY2x0bkFjRSs3cnhiL0dzNml2VVNyaXc0NllGc1pj?=
 =?utf-8?B?dVlQU2ZFNG5lNC9lKzRYa282MlpHY1Y5QUNvN2xyQXpjL3BneVhTeTd3Ykgr?=
 =?utf-8?B?Qlhac2E2R1U3Y28ydWIwM0FlRG1yREdkOFhVRm9JMTdXaElGT1gxTG5rWnhM?=
 =?utf-8?B?ek1lR2VJMm5DU1Q3QVBHb1A3Nzc5UU42TW41NmRYSU1ML3VIa0tIWGNnOFRX?=
 =?utf-8?B?YmR6MkdwRzZJaEs5akRKbnZlUytEU3I5VGNoclF4RjdnSzh5TERuanUraENi?=
 =?utf-8?B?WFdxUEVvRUFPdjVOS0p5RDkwZzN1N0ZmV2YzMTJ0VjB2N0xoTysrUk9BQmdj?=
 =?utf-8?B?N24wa2FoMTBMUW5SOVRMTWp4a2RVb05haHY2ODVPSHJocTlVQ09SSTNWc2hL?=
 =?utf-8?B?QjgzdWZYQ0RtWkFHeStsUjB5SE5vYXVvNHpueXlnTnNycWRUdDNKRUtTczZh?=
 =?utf-8?B?VUk1OFdaUHp3ZlhuWUZBZTZ0dFduTjNWeXA0VkVCZEVuaXJJYTBvclpiTVIr?=
 =?utf-8?B?MkMzOWdZbnh5cFZvNG1wSkI0bVZmL1BCYmNXQk0xeG1HTGdHend5eVlMZGFj?=
 =?utf-8?B?QWlDRGVtZndia2ZVT29QbGoxdEZMQU1vV3Bia3VYWXlTS2pqUDZoOTNRWTV6?=
 =?utf-8?B?V2JLcFAva3oyV0JoTU1TOG5JN1dZSUtNZDMrQVI4RDRBaUs1eFJrTkdFUlNC?=
 =?utf-8?B?c1pycWVwalFFY1NXdEJ3MC9CaUREZTRKWkRsT3hUTWdXNHpjM0NKSTV1ZkMy?=
 =?utf-8?B?V3lqUS9xY2krU0tvckpCcVkrZWQ1elYvOFVybEhkWUFkOTlyYk1tMnY2eUhi?=
 =?utf-8?B?VUxpSXd0RjhWZEJ1SnNvbmpXZUY3Q1hkRHB0em5EcWZxRlZlaGZRVjBYcnUx?=
 =?utf-8?B?TTgvTjNwam0wR3FoVGZVMGNCOUY4ZUluaWhrUEgyRWlYYmJoeld0VlBRSWdD?=
 =?utf-8?B?QVVJSERGK2NNVElXWGFUMXdIZjF0ZTZMVWYvVE1JWEdMNGJPQS9icHJLNWpa?=
 =?utf-8?B?YWphR3IwYnBCMXM5WUZNYmZBQVZPcWlKVXhSaENqRlpsVHdDNDAwQWpuTU1v?=
 =?utf-8?B?WldHelFVMVBWT1BmbTFsSWQ5YVU0S0IrclpFVmd0QzdveUlqaTdjZnh4WktI?=
 =?utf-8?B?VlZtL3B6NHFzYkJITHFzaFRWcVI3enY1R1BySjZPYTBiaHR3STBxS3ZrVjRq?=
 =?utf-8?B?ZEh4dFVNVFRwdGlJOWtmTDBmVjFkajF3SUhCakFjOUg2R1NLd2s3dXdMVEpI?=
 =?utf-8?B?SXVRaHBiNWFRS2JZL1h0azJESjd6L1dicjFnbUU5eU9YV1IveUo2eXlrS1ZE?=
 =?utf-8?B?bmdvQjc0OHcyYUJBbTAyNDVIaVZ0Zk80NCs1OStQZE4wcjdwVWdNQnQ1WE40?=
 =?utf-8?B?d2t2OFpXTTlzQk8yenBBNmQ0akZyb2RSL1VLTy9JYk5RU1FIVW90TXBhQzBX?=
 =?utf-8?B?WWt3Ym0yd3dldEhXWkp0M1lwSUFpRjNORE1CNjhtMktGRU1WQzBVNUpMVEJn?=
 =?utf-8?Q?UDSFrp6rBrKkNtfMDt2kkymYAnUcfz1G5dJ6WtE7AnsBC?=
X-MS-Exchange-AntiSpam-MessageData-1: OZ9Leud4LwgNUQ==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760def7b-dd4d-419c-54ca-08de6192b003
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 13:06:18.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X4du7nwloj453El5L0oDF6izYCZKXjYBVlndvk0/7jd+Zt+KUrEHQ5YfCqjyHYgbp0lRe8C5DoObTKEKedoqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6797
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 01 Feb 2026 13:06:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21791

On 30.01.26 13:33, Shivanand Kunijadar wrote:
> This revision include below improvements for IEC tests,
> 
> TC_CR4.1_2: Refactor LUKS partition check to handle /var and / partitions
> TC_CR2.12.1 TC_CR2.8_1 TC_CR2.9_1: improve ausearch date parsing reliability
> TC_CR1.9_5: ensure correct permissions for SSH principal file
> TC_CR6.1-RE1_1: prevent auditd restart failure from blocking remaining test cases
> TC_CR1.9_6: support both pubkeyacceptedkeytypes and pubkeyacceptedalgorithms
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  tests/templates/IEC_template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index fba7544..f8558cd 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -64,7 +64,7 @@ actions:
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git
> -       revision: deec0428624e827a9d762eccc99b55ee05b440fd
> +       revision: 88134a939f06c456d4978db9c050f9afc74c5d3b
>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>         name: Security-Testcases
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

