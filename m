Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4623FCAC5B0
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 12:59:00 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.10])
 by mx.groups.io with SMTP id smtpd.web10.10818.1758805138615075249
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 05:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HdcUnMYi;
 spf=pass (domain: siemens.com, ip: 52.101.66.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIO4AZnoXuzwSdqjUd8/AtOx0f8FGJ55NT7ZjAirFWBAH4T8VEhmQ71G10qYErApPiovCH/uSGnYa/WJ8lnen//L4a7R7A1iWLadpfvuq3inQWMcohj9koGayth/i6PAkGeP/0lxu+aWcyXAEVzuFlvKUaf2yWW3pJBhjAwKuVBPWFTTtwotf5WSwxZDy1SzyFMfT3vz9udYweLZxv8Zj7lxoQDmN3TDUwJx5jogg+wCWvTyRVac1YOTKvmmto0abxKrGsnNtig2DOXYNNU0mRCcVAsI7HNiaa06JEIA7wtnmRuag6iCNOz6sQlpEFnHiGDWNcHIkpkFlPb0bZ1/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFTZImvveHdUi8CaYUBJ/3CS78zw9rNgHLXDGZ+8/eQ=;
 b=CRtv5/ZOSHgr1poZOWIijmO9sPo+dYa8KK6WAXbnuaPRRuU9oEtZ87MJXA776LeP6D4fVsIGyRyEHhB04lVj3dZ6QpQNH2echZftHPtt5DVN3tbQfohFdOsXMvLKlP8oC4hVAK5076SESD8luGuMwrkloFlIDHEK+3D7QMr1jiOayuX3Ln4GzZcLVoE+teqQuuUY2vaOKl5RBmTkH6yahCcGcsvD/dEoQCYZrceWHt/tkuS9ycZ1l69GWUNYkCBZv8mIE4Zjx2EK+Cy7Ialua5rmdn7m0sjlSZRjpvUJxQfATbFH1wdyxyOrjEWh7FgqMcfv3Pt89/xZSfZUZNxglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFTZImvveHdUi8CaYUBJ/3CS78zw9rNgHLXDGZ+8/eQ=;
 b=HdcUnMYiX8K6jS/P4O7LoS0tTP0zdw9vWNXUxLG3Fz+RFFwlYcD4DzoJhlWLXjq3TY/srrmi7RTBobHR/DIE+MwUfQWaItDc/N9IfIW9lEz4DpWOQUDXwvcYjXJPyU2vLuM/wOOmxqdpQMC7oWp16AQIZIKbFJrjBX417v5GkD/2I1ZYfBCmGnpv78badMOYCx4ra1LJGHRcXVGIKuW+hE2JQlHKA+67qXP+lFv0cifWdLmgTrSHsV1M2j10z1FYWzlhD1ILBZ2KHR26/sx4KN7NC0bSM5gi659m1D4wiod4CbdTELMEQ5jthGx3GZAIC5zu/uwSRccbOIMA22qpPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 12:58:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:58:56 +0000
Message-ID: <97b2f868-d3de-40df-8e4b-31a3ec66b10f@siemens.com>
Date: Thu, 25 Sep 2025 14:58:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] tests: Raise boot timeout for M-COM target
Content-Language: en-US
Cc: "shivanand.kunijadar@toshiba-tsip.com"
 <Shivanand.Kunijadar@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:610:77::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcce0b9-9f95-4638-28c2-08ddfc334987
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UFBUNHdDeUIrTStlb2dHWGFSNEwwWGZRRXI4UmFKVTN3SklGMjgyNmRyclA4?=
 =?utf-8?B?MjVsS0R2cW4yUXRmc1VCWGFwZWhhaUxsVG4xU3VtUnVuU1VYbGNtZkxXY2V4?=
 =?utf-8?B?MjVPZi9ESGd4bWpBdFFKUmVXRWJCTzdEUkRXRDIxYStXRWNiRGpJd25NMnNP?=
 =?utf-8?B?dVZOY29mNFRydVZZa00wbG5XVnBJZmRiYks1MHFQbVQ5QWN4QVdhNWNsWkM0?=
 =?utf-8?B?dytjTUJvMlRia1ZkQjlMTEZhRlJyM29RamNqTWxMd01seHdsM3czdStMMWJT?=
 =?utf-8?B?Sm5aNCs5ZzdCeVk4VjE1MDNGaHB1dXdvcHVjMVdEdkZSYytKYUNFZHNBUFpp?=
 =?utf-8?B?RXgvbmZMWXlWRzkvbzJJQTc1Q2doZWZnYklFQkNXd0p4N2QzdEpKbk1jVlJy?=
 =?utf-8?B?NG9TamlNQ0RLUjI0a2R5M0l4TWtPbEhMM3FBUTVMM2hWeWNnMkswSGsxMnEr?=
 =?utf-8?B?YzExMUdmb1pxdTBxTGtTczJJdlVMZUQzMHZFSUx3UDQ2Y2UxeTk5Zlg0WmhV?=
 =?utf-8?B?VGpOeHBwK3prMHpGbEZyemVtZUowdnpIQnBIeG5IT3Z6SlRzRTAvZ05WZmtI?=
 =?utf-8?B?T2I2cFEwbXEzRXRMRGpiMXZkVWs4THl0Nzk3TzRYeU9JYU9DTGJaNGkrVEl1?=
 =?utf-8?B?VEpjSCsyelFOa0NMbXdteER5VXJaak1NWFNueWpWVmFOc1VtTFI3K1dxd013?=
 =?utf-8?B?SGNmUlFZY2UyV3NJK3NBU2lPRU9heVQwSy9jbXAzUEhyWERJaE1Za2VxTGdR?=
 =?utf-8?B?bkJJL3FpTi9mUWVEZ2NSblNyanRwcmRzRklPWmtjejRPcnl5Sy80ZDZYRlM2?=
 =?utf-8?B?QlE0MUY1WnIxL2xJRFBXMUE1SjQ2WTBhd0F0SGhqSVRoUG5meDdQMUR5K2I0?=
 =?utf-8?B?SHZWamk4MDZjdE5mVG8yMnhCakNONkhNVnh2cEhENmZRUGQxWXVqaVkwUFNQ?=
 =?utf-8?B?TDM2MHV1SmF1NU0zN2w1N3ZCaStPa2ZQeHhOaDU2aHMxZGJGWi9IWE1xT3I2?=
 =?utf-8?B?ZFlRUTFkZW9xK0tWRCs0bnppdHBGVEtoaHlvTEptYkhVQXFMZEtuNE8zQXFv?=
 =?utf-8?B?SkxzajQyYlRTaUh1YzZmbGJpNEF0V3BQNlEyNjg1WWtIU1VQZDZSdWZzWm83?=
 =?utf-8?B?S3ZHZm9NR0RPZVVOVFp4d214OHNOSFcwM0tQb0tNdEdoVGtLNEQwTDRaM09V?=
 =?utf-8?B?UHljOWhjKzBvTkhtSGc3ZjBoZ2NkZmhIb0poaHZvMkJjR01ObWpWZWIxR3Zl?=
 =?utf-8?B?OHJrQ2tMZ2c0dWt4eVBvdk9ZY2pjMWlvODY3SzFYR1FOa3M5ZW4yeDUxNENV?=
 =?utf-8?B?ZmFUQTFqeXd4M0FMM1VrcW5sb2ZPWFlicU5YUGJ5aDJzZmtJWnZhNy9KbHNN?=
 =?utf-8?B?bVNJR2xkQ0JEKzRTZFZZbzJqR01HTlNDTDQzNTFHajlRZHNUSHhKNXpncy9C?=
 =?utf-8?B?SUpabU9PVTJOVWFPYXJXYktNQnQ4dy85R0NaeG9ta1MrWEVoQng3c0h2b1d5?=
 =?utf-8?B?cGx0RWcyUUZpUzRNM0ZJQXdITEs3OG9kakM1aEdBclJ1OThGWFJYZEszN01a?=
 =?utf-8?B?QStseWR2SGdFNlM3YkhrWHllZkJvd3haVm04NTZoMGw4bmRoRlBtbVVMY3BW?=
 =?utf-8?B?VUhxL1JCZDBXNUl1ZnJJS3lqOW9FK3hJTi8rYVBmSkVKWThDMGo3MUhzeUdJ?=
 =?utf-8?B?WVlJR1Qxa3VMdjZPVHhDTjQ4cjBHME9nQ0JHajBiU3RUa0VRRnRjR3hCYTJv?=
 =?utf-8?B?cndMVzN4V0lyVVYzM3ZUNTFPaHo1czJ4cmZMMktGbHkxSUwxelp6VDVpNjJ1?=
 =?utf-8?B?bU0rU3NCc2xQTFlTdTBNM2trOHdkbktOSEJ3ZURDWkNBVW41UGYvcGU0ODBI?=
 =?utf-8?B?STFNTGd6dnVNQld6NnFtYUY4aWh6Y3ljN1VVYjZIbk9GSWppcU91R2htMDND?=
 =?utf-8?Q?5iYi1Bi6GWE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tmc0Q3F1MDhmaFNERmJMamY3TFZHN2JXV3R3SHJMWXFKSVZ6OHRpRURoTE81?=
 =?utf-8?B?c2VGditFRHZ3QWsvOTN5SlBndnRONGxiZklEeExKRFJpcElIeG9lOG12UjBW?=
 =?utf-8?B?aGhSVDBYZzBFaHdOYTJMbVBFMERIMVkwanZ1Q2haYlp0eHRDWExYQjNseEsv?=
 =?utf-8?B?NVVZbFluTllEZUZHZ3g3VGx4cUZkTEFpQ0k4VElSTWRNNE5LaXYzZVFJTFdS?=
 =?utf-8?B?MENtNXMwYnNJYTBkblBIVjdmYUczcFFZN0g5MUVmMkFZbFp0QzZoWDU0Vmph?=
 =?utf-8?B?QTNUK1lOZUxhTE9oQmNyekNDOUtHR3hoY1JGSmFXbDJxOEhQSFFuMTYwVWhS?=
 =?utf-8?B?bFRuOUdqL0xOWUtyY2I5SlBxTGtFejQ0dy80VzA1YUJKa0REa1BGVG5McDJs?=
 =?utf-8?B?VlB6a2ozNlhubm8xMzluei95Q3V4ODIxaVhyRXNOWEhwZ1grdmxndzlRTDUr?=
 =?utf-8?B?RG1icFdkMnNaOC9YVGlNOVlwQkdwa3ZwRDFXd3F6Wm5VUzBtTmhMazhiSjJR?=
 =?utf-8?B?UFZPVW9sSnpVcWgrWmJrUjBFR3phQXlQTFE5WC9NL21xU29TelNXRDZLMEJT?=
 =?utf-8?B?aGhBVGUya1hLVGlubHBzY2owUjJlUk1lYTJQSVZTSGxLTzJjNGsrc0lBM1Vq?=
 =?utf-8?B?eTBXNFJhTjNuM1NhSEx4SU9jZThNNVNmRFo2WmJ1Si94ZElDWG9kd1QrQ1Zn?=
 =?utf-8?B?OW1sS2IxVG5SeHl0UVNTSFVTS2dCRVRzTzNrM3RtOHA2MFRpMGVMMStKVFlk?=
 =?utf-8?B?K1ZXckFQdittK1JJSnRuUG14VkxUdzZ6QWRTWkJ2aS9vVUNVYUpiTXdZellt?=
 =?utf-8?B?L01YMUhFUEZ4UWlsV0ZUdFNLZ1ZwQ215QTBwYkdUOEgxR1pJRW1pUE53YnZx?=
 =?utf-8?B?RGtBeUg1cEhRWHhreVdBcWdWRkI2UHlEcWFKWG1nV2JsZmNZNjZuRU9DVFdV?=
 =?utf-8?B?dEZOOVVlRVJqeEk1cmlWdGR0Snd3T2FvWHRtcTE5d3JXN1ZicHVEOFVNaXJY?=
 =?utf-8?B?bFZMUFREd2IzOEVncVB0T0huMGRaMEMvRWNReUJiUCtVMjhMMEtDTU9oNzJ0?=
 =?utf-8?B?anVsMzdGekd0VkROSndTRC92WHN2MUovMnN3TnNXTUVHQ1dldDNtMnpnbHdT?=
 =?utf-8?B?U3Rab2dTUnBmNmw1Wk1Oc29pbjViNHV5SlBGc0p2KzVCTkw3RG42My9DZUZY?=
 =?utf-8?B?ZFFUdW4xczl5NjdFc2IwU3dpaXJHWVR1dm1MUXZaUWpYZWRyUnJvOGdlOWFH?=
 =?utf-8?B?SHlVdmxmZDdXSHBteUNmTlROb2hQQWM1V0toSS94UlNOaVZlNVVpbVc3RFZH?=
 =?utf-8?B?ZVN0ZjdOZjZ6VE1Yc2VySDYyM2EyYXVBUHBkY05ORnFCK2R4YlFySU8reHZy?=
 =?utf-8?B?ZTc4MjZ3eGk5ZUQveGF3K05UMlJCR08vVlFBV3RRS0JkOThLMVZsakZsMWpo?=
 =?utf-8?B?M1lIZ2huMGUvQzl5YytzY1liL0dCeXhLcTBXSVkzLzVleUErZTNJMWk4S0Vm?=
 =?utf-8?B?VDh3cmFYNXZBSUZKbUpyVnVUczNCSENzOTVBSVdxQjdkbGFZTnF3VG0yZDha?=
 =?utf-8?B?bW5nVjdJY0syd05XOUxGNzFpSyswRUlTV2oxUWdwR2ptNjYwSTR5Q0pSOGNs?=
 =?utf-8?B?WEJpRzROVVhUVjZUWERET1N5Z3ZyNGZHVDh0R0xVYU5uU21UejE3SkhZSXRn?=
 =?utf-8?B?a1VXNm11YjhVaFF5TkpURkwxWXdvK2ZEMUtFYkVNVE1ZU3FZNzJmdmxEWm9I?=
 =?utf-8?B?bFR6WWlmQ2gvak12ZEtycjFBSzB3WVY4c1dnWG5VZ3JHaXlKVXlBaE1YQnFJ?=
 =?utf-8?B?cGRNZU5lT0hXcmlPbHZwbUQ1NVdUT0g3TmljeUxqQlBtSGFPQVYzRzRpMzh0?=
 =?utf-8?B?TnJycjBoWlMxbUNteDZsOVRDZFYydkJkR25aZ3Vzb1d4NkdCUU5vZmNBd1Ja?=
 =?utf-8?B?cVBDcnZLZFUwYnNPNFBzc3VDUklBWWdrci9PUlJvNmJVUnFWck1WNGY0RUtj?=
 =?utf-8?B?TUNvTSs1YXdtNVBQZ3ZMdUZ2Nk40VlNreWdEcFpwN3doMUFpeUpwVWNITjhw?=
 =?utf-8?B?eThDRnBIM1ZXQnZhS0F3a24yS21paVRnNFl3T1BPbkU4cE1SV2JoQ2l3TnYz?=
 =?utf-8?B?Y3REUEZrb29Yc2pjRGIxenNMK0cyRVZJbmM3bEZCQS9VZlB5eUhlQjdtM1R6?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcce0b9-9f95-4638-28c2-08ddfc334987
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:58:56.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ixd2E9Dc/lFu4uH6/TNUCvKM7bTAeaqe4DEkg4r43A8MzHPrEOdRtkEh8OI9PNH3hCLP+bdwM3Qj+02jcyfwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7696
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 12:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20139

From: Jan Kiszka <jan.kiszka@siemens.com>

30 min turned out to be too short for the initial encryption of the disk
on the slow, emulated USB drive.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/templates/M-COM-x86.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
index 47162252..466a5d0a 100644
--- a/tests/templates/M-COM-x86.yml
+++ b/tests/templates/M-COM-x86.yml
@@ -37,7 +37,7 @@ actions:
 - boot:
     method: minimal
     timeout:
-      minutes: 30
+      minutes: 45
     reset: true
     failure_retry: 1
     prompts: ["root@demo:~#"]
-- 
2.51.0

