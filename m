Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC0DEA3F16
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 08:18:33 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15645.1770711504377870172
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Feb 2026 00:18:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dA57AeOo;
 spf=pass (domain: siemens.com, ip: 40.107.130.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS9friKV/AtWMmAupEpOGYWbDfjZun3PJh+dnzQeQwVeDBpCJ0Q+l43cQe9ypWUrsDrZUZ6XUikDPt46kH4JgY5Ix2vhMUSE3n8QIdU2HIvnR1OatODq0qMcPlw1jNIge6ad5MVmHzme+xX5hb6YOHzJJ495OuFzHr1anM/F1GLHvqeHYwaItCaMHCxFZdiy92F+adqZnYGOqfld9CaGBOn7XDA907eLU0dBmDEkQXAmm0tjG45+In/6/7isR7GyCctTOIh2SG6fe+4QV+Izs8n80TS6KrTcar1L/AF9g1PsDkEP5AWgl8sK1F7qnM5gaH2OabbMXuv08Z2y+daenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYvFtjWGp8p1mKyKk8FJ9uRmXkPfKjurUe5T3Wzn4rw=;
 b=RZgSgcFAMbal3+HMuXBP5yWgfErXYyz6P9o9iZO6fABhkpbfd8y/NO7r5BuJryWFmVrqLW373xnfBBH1xrqRQ63fEz6AOAmuEcy3fwxZblXqxDzdjvNKImGyXbsW7rarxtXDlSi/65OLtO65Jb5uzOdfgwSAePxmZ8F/Pwd7fysdVd+z7trUcg+3Hkzc4tglEGZSyodX7bhFDsK66xFKrmEVl4hJfUcbBx9Gr0EknujmYqSFRIbSzswMNiT/cumuBow1ckVlIanIhurqbt/HG5sbhKC4Zp0biI4NJ+pYTdSxRdYL/VGEQQHLyMqa9+Q+xoNJY/I36X9nK35911cv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYvFtjWGp8p1mKyKk8FJ9uRmXkPfKjurUe5T3Wzn4rw=;
 b=dA57AeOoDlniH714jd4xq49MPDsPoo4GwKYsC5iuxHXnf9uxN6rBphMcYTjEN9I3PyGCRg3tV41c0rDvWwRw4anXdLbFBJ78JIawJQeziVmYgPDZH2JWSG3YKzjt0HKwsEVkpTyhMeR/FKNZ53mjPAwthLtpCJhWhmUd4QzQ1kgeBpNmSR8r1bo80bwwvxF2SgUAKs9zJpO1dP/pUP/wvfthFh1/A/xRB31EWSAJN1KwUIvMSSVwdN0R1ZWh1BirIUAma6EAWuB1Z/qoc2UTrmripABeWpZn0rl5mEZDK1eWjHTtLbwdLeV1+kocBrpZAjhJscp9PGWIfBjyM94omg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM0PR10MB3298.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 08:18:20 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Tue, 10 Feb 2026
 08:18:20 +0000
Message-ID: <4db81fef-2a03-4880-8c04-1de20c00da7b@siemens.com>
Date: Tue, 10 Feb 2026 09:18:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/9] Add support for BeagleV-Fire
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: s-adivi@ti.com
References: <cover.1770037068.git.jan.kiszka@siemens.com>
 <TY7PR01MB14818C90B18581467313DC36DCD62A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB14818C90B18581467313DC36DCD62A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM0PR10MB3298:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ebe93e-2d44-484e-2edb-08de687cf39f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QXpDYWFVNkNvcGtZTitmQm1RaURaVTMrbUxkTE1ya2RmeEdxTzQzUkVURm5y?=
 =?utf-8?B?eDY1RjUrOUdxbEFSUTlHYVNhamtoSXh6dnV5QWgxOWFaRWVuTWNteDhIczEx?=
 =?utf-8?B?N1pRTG9IaGZXQUJEWmszK0N1V3hKZ0hBRWZaRUswR3pZUWZFeVcrL2dPOFA1?=
 =?utf-8?B?R1BFY0dnZERqMUh0WTEzWkxFazZPR04rVlQ2dlZGT2JGczVyU2Z5TjRFemw1?=
 =?utf-8?B?UUU2eERUcnd6YkxzV0tPSWFIQjAxc1o4bnNTR29WZ256OU1YczFjUXArUTFP?=
 =?utf-8?B?M0RRbU9TbmY2clhLelVXMzF0d2dNajh5N1dwSnhLY25hTVJZMDY4TG5ibzQy?=
 =?utf-8?B?SlhuSDdJWDlmbC9TOTdyajF6QTd6OHIremNIV05rRFE0VUo5TE1GM0lQUVdt?=
 =?utf-8?B?b1JMUForRklJZk8vSjJqSjFYT1krcWlTcWpCZlBadWsxbnIvZlVuZzJicUNy?=
 =?utf-8?B?dWFnQzJoaHZ4RU9qSG50aHRGbjNGSVNJb0thSXhuTU1lV1R0cnQ2ZlBzQlFt?=
 =?utf-8?B?WHh1YmxQcWxtZ3MvZ1QwMmZOeVg1d01ZMExJOXNTRzRqZ3U1R1JyUFg0TkdZ?=
 =?utf-8?B?YmNnRTI0dUZLSjgxUFg0Njc3Q2xCZ1NOU3NkNzczSmpCcTVxOGdCc01QakUv?=
 =?utf-8?B?eXY1SUVIMzJJSGM1ZnR6MWZRMkg2TDIxdlEwUnBIRHdrNWhRaVRIQnBEeUw3?=
 =?utf-8?B?UlFCQWtpL0RzRGVjMzFTRlNNK1FBZkdwREswT21rN2xDN28zQ2lEQStnVStw?=
 =?utf-8?B?dkJzRHNpMTN2TnJkTDlkbDhJRHlsakMwWml0R2JJNmp3YnZyWjVqeEJPMVhy?=
 =?utf-8?B?bGtFU2RaZjNaWkc5UDZ2UE5JMkJYdEJwcjJ1YkE2cldDdnVuWEw4OWNUTDhx?=
 =?utf-8?B?VG9MQk12dDN4dXFVT0haRVlPWUtKOU5RMzFZT01Ca1JxL3B4UFlTbENNV2tX?=
 =?utf-8?B?VjhYN1k3bWkwMWlxVlBCbmVvQnR0aEJubk82dU5lN2tRdEtRRXZQNEZpQ21D?=
 =?utf-8?B?TTBhblVvY2VHKy96Y0RlN01oNXFDWXdXSVNvdTVNUE1IMmtSTEdEcmdCcHNk?=
 =?utf-8?B?RWVhLys3OGtlTU9iZjRHdzlQUmVhL1FGbVZiSnlSOGYyNDJEL0twY3hwVWg3?=
 =?utf-8?B?dnBQUDNUUkZiMGV3K05NVGo2eUwyWnJiWkU1MkFzQmd2QlRXVDhHbDZkNWlh?=
 =?utf-8?B?aExUT3dWMUJxMS84TU5nazZNWGtia1d5amZCZlBpNVJmL2o1VHB1NXV6RFBK?=
 =?utf-8?B?cUJac1R1Q1RiVmZKM0FSa1d5VjZnY2JLekJ3bEF6RnJsZHZYQjlsU3VNNXVT?=
 =?utf-8?B?dld2bVVYWXZ4OEhFZytWOHE4US9jU3BxaXVIQlBJNFBVUUw0em0vNmdXVHNy?=
 =?utf-8?B?VkVFMUJBNzYvdGkrdG9rZ3hQemcrNW9XMVNDV1NBV2p0bjRzN3l1K2hjM1FD?=
 =?utf-8?B?TUNaVkprbUdxNmc4dTV6cHQyQ0NreUtmc2dFREN5bHRYT2g0WVRTakNwY0hz?=
 =?utf-8?B?cURHUkZram1iOUd6b1o3bUtYVlUwZUlXTXAyYkpyZlpwNkh3M1cvazdDUUdx?=
 =?utf-8?B?MXRkS0RaVklWcndYS0J5Um5vTWdXU00rQW5iSFp1THZ2dFRQVlFiVEpwc3NC?=
 =?utf-8?B?SmVoLzRaTldhNEVVUGE4Rjh2d1ArR01oRjNzUy9LMlBzdHpvYmJwZnVHcmYr?=
 =?utf-8?B?RXY5UjE3blkrWnNzeTUraUFQZ0RpcWoweDFBa25ad0YyU0tpV2dpOUgrcnRj?=
 =?utf-8?B?WHgzRkUvSC80SmZKTWtBdGFCUWJxZ2RmczlEemhKLzFrV0FRaEp5WndkbEZV?=
 =?utf-8?B?ZnErb29LMnlLQmNZbTU4bDZqWVNtU29oUlFuRjJrdVBnQ2JsbmNOVlQxU3pU?=
 =?utf-8?B?OFk3QkNHdzR0QnpZdU1SM25ONUJ0NEJaT3BFbXRYdkU2WlF4dWR2NzZrLytK?=
 =?utf-8?B?UzRLeTkrRjU5REs3WWxNbVEvcnJXMmVuckRjV1BCRnFPbVRqL1N5cGdMTnV2?=
 =?utf-8?B?R0c0aHFNQnFuYTRBZFJab3Y2YUI3OWdNaHp0WUlEaHExZ3RBMkswY2gzMFl3?=
 =?utf-8?B?R3hWbHZ2Vm9VZzIwdDlIdzFWRlNMWXhrYW9kWXJ0KytvSHM4MWRibHZMQ2h2?=
 =?utf-8?Q?1Ij4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ty9PTmtUZjRPSE9FQ3A1YkxrL25KajE0Wm45NzJEWW5ZaUxka3lkb1kzMUZn?=
 =?utf-8?B?Zll0a2JkSCtqeENBV3VUZDh3dDdRZmJHUDMrcERJck5Oa3JPMU51TXZPTWRJ?=
 =?utf-8?B?a1NTS24wTXJPbTlGbTJRV0NRemtZZk5jOEQxRG5ONERQRzFGUnFlSlNCUXRC?=
 =?utf-8?B?dHYweTVZc2dxd2IrRi9aK2tWN2UwQjJYWFhtNVRXVXVQWm5PTVNwbWhuS1BV?=
 =?utf-8?B?UmpZVUZJbFcvQWFabTNEcjVFYlpsN2Q5TGh6STZnQjJvbVZwMnFjNzdMVkN2?=
 =?utf-8?B?N2pwazBUQzhiYU5TekZLSlNzeUlCSmdBQmZsUkRJTHZpWndOT3J1OEEvN2Qw?=
 =?utf-8?B?VUUrOTU3MkJROE0waVFKbWY1MklhVmZPeEEvUFUvNTNPaDV2RXFqY0ljd2xl?=
 =?utf-8?B?UGFGK1NuU2Y4Z0lTelNrNE8yY2plKzVIWDU4RkVIVitXa3F1bjQ2cFNzdTZP?=
 =?utf-8?B?WEtYVUN3SlNiYWtjaklSSHJGbC96a1pSU2o5WDlzTlRXb2UrN2kzc2Z0SkQx?=
 =?utf-8?B?YkViUnFTbDVTUm5nUXh0N3ZlWnM0YTB1Y1VNNG1UWndzUnVZN0FnWkl0MFBi?=
 =?utf-8?B?eWRPb29SRU1mM3BuQ3hzVEp3TWZIK2pkbW1lMDFES09LMHBscDRMcHlnbWU2?=
 =?utf-8?B?Q25GYnlmbURjWkgrTjFzaTUvRjlzZkRUOStXMWVFQWV0cXpHckIyOFJ3VUxi?=
 =?utf-8?B?cDYzQjBlMFN1aFh5SXlESktsUG4ycjJPRmVEVjlpcVRKY1g4ZjlPWEVjSEx3?=
 =?utf-8?B?MDhYcm40R09IczNQM1FsNHg2UWRzTkwzUW9nTEx5cDNHYU9xaDZRLysvbmpS?=
 =?utf-8?B?Q3cyUzU5bmpqWDlZcHh5dzVyei9BSEoxZWFsemdtMmhUYzBRbXdnSEVQUWIv?=
 =?utf-8?B?UjRPZERtVEhHVXh6K0I5Wm9jZ09LR0VXd1puOXNkK21wZFNiVFlPK1JRQnpQ?=
 =?utf-8?B?eUJqRTFTc1pDa3JKTm1Gb1doNU1mdUk3aEY2blJJUk5ocHVYYy9ySXVKZWFK?=
 =?utf-8?B?eWdQMitDMmxJK1ZQR1VnN2NLaEpaVGttK1NqVVMyVkg0NUlIcDhja3ArMExs?=
 =?utf-8?B?WEN3cURyQmFObDJMTC91NHVMSW4yeFpINUNnVnYyRjBvZ0pNV1g1ZXgyVWZP?=
 =?utf-8?B?c3pkQnNNYnNuMlpqYlQyVG1naEFDaUFoVzI4UlRSS1F3STg0Qjg2YUNqOFVJ?=
 =?utf-8?B?OUFiOVU5Z2xjeE5QZkwzWGx6dTNKSWpZdFlacVMzeGtLaVM1SXFpMythK2lx?=
 =?utf-8?B?anRuclJmaUhhU2prRHNuaSs1R2dMZUJKNHZmcGxWZXQ4cjQ3U2xNK3psRlhP?=
 =?utf-8?B?RWhhUmlGd3BaamY5djJDbkorK0FUdUlHOW9XaUVrNXV6S3FRbE1yaWU1WmZZ?=
 =?utf-8?B?dDEyUG5raWI0MkExbkdDZ2ZPbkk4MWVpVFhleU4xcjNETEU1TTB1cnhwTkdQ?=
 =?utf-8?B?TW11Tk41TDdiUS9JYi9WR0k2Snc3NTBrME0ySVduTEZKM0tWOU1mYzRnMXdG?=
 =?utf-8?B?OGdPWXNiRnBvc1ZIMDgrbnFJV2tpMTVvUzhXVGVNMk1sL1lTQmhSbjdlQ2hW?=
 =?utf-8?B?NGpHN2IydzFmd09YVnVuUTFtTzd4UGIwcHpqWVo4NUpkVm9KZys4S3lUWXRw?=
 =?utf-8?B?L2J4dUorQ1ZvT1lPV1h2cVdDMG5PblhMT2QzdlB4azZjSFJyeGN1MU9VenVQ?=
 =?utf-8?B?dHVvd0pBdnBNWkliYmUzVE1paW1yZVpDWi9pcGRJV0VXa0ZoMCtYb1oxckU0?=
 =?utf-8?B?WFRQZ2NGRGtOZjN1N1J5OU1KbmJSSkZaSkZLcDJkSlcweUhGUVFWZG9ReXhR?=
 =?utf-8?B?WTUxQUdYNTJEcHkxUXZCL1NQODVnaXdYeXoxNERGNis2clUyV0JucnFjb3Ay?=
 =?utf-8?B?eTNHNk9HVUtKVWNwZVhxZDRxcEtFa3F6SHcvSkFLdUtubkd0bTRXNHd4VkM2?=
 =?utf-8?B?WVFpYlBxL28yemNWQ1lHSUJyY1U2dzFjVUw3ejFxZHhnTExiaENvTHBJTWY1?=
 =?utf-8?B?N2JBc3JjRWdYMmsrQm44WWRINER5RFZFSDdyRzVDZEJ2blJWRmp0VzRXL09s?=
 =?utf-8?B?Kys5UkhkeUxnZ0czWWJYbUhzTnJGZVV6VlpYM3dTSnRLSi9QaTFXank3Zk1v?=
 =?utf-8?B?MEZwZmNtTkFGMkVWYk5URXpkY2RNRHhIOVJ6R2tORndlQmJVcFVyOVN3M2Ni?=
 =?utf-8?B?a2dGWDN0dzh6V3IySHlFRmoxYkZ1a1E2MG5ld3ZqdGVjcUpOSnd4NStQY0l3?=
 =?utf-8?B?TWVtWVZVc3E2NHBjZEorTnNZbkRoNDFkQURnNHk1WTF6c1pOdnFWdFFyTHhI?=
 =?utf-8?B?VUQ1TzM3UERncXo1N1J6aWhYN29WSXdQenBxZExwTTVlS2Q4YUMwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ebe93e-2d44-484e-2edb-08de687cf39f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 08:18:20.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHBSev6dPRjl5XfrHAR5X10DRQ5xBJYaXpBLmw9ZseMti3a+RaD1vuCpcfCg6DYYbmIKD1rwhtSzfg5VJOwOjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3298
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Feb 2026 08:18:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21850

On 10.02.26 06:04, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi,
> 
> Thanks for your patch.
> I tested this patch series on 049ea8ff8370a10d88214b2d488ef6f7c1d28a4e (master)
> My board fails to boot. I pasted the boot log below.
> 
> Best regards,
>   Nobuhiro
> 
> ```
> HSS: decompressing from eNVM to L2 Scratch ... Passed
> DDR training ... Passed ( 5401 ms)
> 
> ---------------------------------
> --        BeagleV-Fire         --
> ---------------------------------
> 
> [5.464693] PolarFire(R) SoC Hart Software Services (HSS) - version 0.99.36-BVF-0.3.0
> MPFS HAL version 2.2.104 / DDR Driver version 0.4.023 / Mi-V IHC version 0.1.1 / BOARD=bvf
> (c) Copyright 2017-2022 Microchip FPGA Embedded Systems Solutions.
> 
> incorporating OpenSBI - version 1.2
> (c) Copyright 2019-2022 Western Digital Corporation.
> 
> [5.495680] Build ID: 3f0ed536ff6a0aaef3c9b81896adaee39ec4d8c1
> [5.502538] Built with the following tools:
>  - riscv64-unknown-elf-gcc (xPack GNU RISC-V Embedded GCC (Microsemi SoftConsole build), 64-bit) 8.3.0
>  - GNU ld (xPack GNU RISC-V Embedded GCC (Microsemi SoftConsole build), 64-bit) 2.32
> 
> [5.524411] NOTICE: Running from L2 Scratchpad
> 
> [5.530053] Serial Number:
> 9d5ab5e2c5711676ace9e5cd4b2b1dd000000000000000000000000000000000000000000000000000000000000000000000
> [5.542726] Segment Configuration:
>         Cached: SEG0_0: offset 0x0080000000, physical DDR 0x00000000
>         Cached: SEG0_1: offset 0x1000000000, physical DDR 0x00000000
>     Non-cached: SEG1_2: offset 0x00c0000000, physical DDR 0x00000000
>     Non-cached: SEG1_3: offset 0x1400000000, physical DDR 0x00000000
> Non-cached WCB: SEG1_4: offset 0x00d0000000, physical DDR 0x00000000
> Non-cached WCB: SEG1_5: offset 0x1800000000, physical DDR 0x00000000
> [5.583609] L2 Cache Configuration:
>     L2-Scratchpad:  4 ways (512 KiB)
>          L2-Cache:  8 ways (1024 KiB)
>            L2-LIM:  4 ways (512 KiB)
> [5.598104] DDR-Lo size is   32 MiB
> [5.602358] DDR-Hi size is 1888 MiB
> [5.626176] Design Info:
>     Design Name: CI_DEFAULT_FD28A2CA1789CDC1137
>     Design Version: 02.00.2
> [5.636592] Attempting to select eMMC ... Passed
> [5.891124] User button NOT pressed
> Press a key to enter CLI, ESC to skip
> Timeout in 1 second
> ..
> [6.900764] CLI boot interrupt timeout
> [6.905278] Initializing Mi-V IHC
> [6.909357] Initializing IPI Queues (3304 bytes @ a02e660)...
> [6.915867] Initializing PMPs
> [6.919600] Initializing Boot Image ...
> [6.924200] Trying to boot via MMC ...
> [6.928714] Attempting to select eMMC ... Passed
> [7.183124] Preparing to copy from MMC to DDR ...
> [7.188654] Validated GPT Header ...
> [7.204547] Validated GPT Partition Entries ...
> [7.209842] Boot Partition found at index 0
> [7.214789] Attempting to read image header (1632 bytes) ...
> [7.221221] Copying 601712 bytes to 0x103fc00000
> [7.230057] MMC: Boot Image registered ...
> [7.234918] Boot image passed CRC
> [7.239258] Boot image set name: "PolarFire-SoC-HSS::U-Boot"
> 
> 
> U-Boot 2026.01 (Jan 01 1970 - 01:00:00 +0000)
> 
> alloc space exhausted ptr 2010 limit 2000
> CPU:   sifive,u54-mc
> Model: BeagleBoard BeagleV-Fire
> DRAM:  1 GiB
> Core:  68 devices, 14 uclasses, devicetree: separate
> MMC:   mmc@20008000: 0
> Loading Environment from nowhere... OK
> In:    serial@20000000
> Out:   serial@20000000
> Err:   serial@20000000
> Net:
> Error: ethernet@20110000 No valid MAC address found.
> No ethernet found.
> 
> Hit any key to stop autoboot: 0
> switch to partitions #0, OK
> mmc0(part 0) is current device
> Scanning mmc 0:2...
> Failed to load '/'
> Failed to load EFI variables
> 
> Error: ethernet@20110000 No valid MAC address found.
> 
> Error: ethernet@20110000 No valid MAC address found.
> 
> Error: ethernet@20110000 No valid MAC address found.
> 
> Error: ethernet@20110000 No valid MAC address found.
> Booting: Label: mmc 0 Device path: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-)
> EFI stub: Booting Linux Kernel...
> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> 
> Error: ethernet@20110000 No valid MAC address found.
> 
> Error: ethernet@20110000 No valid MAC address found.
> [    0.000000] Linux version 6.12.63-cip15 (isar-users@googlegroups.com) (riscv64-linux-gnu-gcc (Debian 14.2.0-19) 140
> [    0.000000] Machine model: BeagleBoard BeagleV-Fire
> [    0.000000] SBI specification v1.0 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x10002
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI SRST extension detected
> [    0.000000] efi: EFI v2.11 by Das U-Boot
> [    0.000000] efi: RTPROP=0xbe335040 SMBIOS 3.0=0xbf387000 INITRD=0xbe2ed040 MEMRESERVE=0xbe2ec040
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'non-cached-low-buffer': size 64 MiB
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'non-cached-high-buffer': size 256 MiB
> [    0.000000] OF: reserved mem: 0x00000000d8000000..0x00000000d9ffffff (32768 KiB) nomap non-reusable buffer@d8000000
> [    0.000000] OF: reserved mem: 0x00000000c8000000..0x00000000c9ffffff (32768 KiB) nomap non-reusable buffer@c8000000
> [    0.000000] OF: reserved mem: 0x0000000088000000..0x0000000089ffffff (32768 KiB) nomap non-reusable buffer@88000000
> [    0.000000] Reserved memory: created DMA memory pool at 0x000000103fc00000, size 4 MiB
> [    0.000000] OF: reserved mem: initialized node hss-buffer@103fc00000, compatible id shared-dma-pool
> [    0.000000] OF: reserved mem: 0x000000103fc00000..0x000000103fffffff (4096 KiB) nomap non-reusable hss-buffer@103f0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000103fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x0000000087ffffff]
> [    0.000000]   node   0: [mem 0x0000000088000000-0x0000000089ffffff]
> [    0.000000]   node   0: [mem 0x000000008a000000-0x00000000bdffffff]
> [    0.000000]   node   0: [mem 0x00000000be000000-0x00000000be000fff]
> [    0.000000]   node   0: [mem 0x00000000be001000-0x00000000be334fff]
> [    0.000000]   node   0: [mem 0x00000000be335000-0x00000000be335fff]
> [    0.000000]   node   0: [mem 0x00000000be336000-0x00000000be336fff]
> [    0.000000]   node   0: [mem 0x00000000be337000-0x00000000be358fff]
> [    0.000000]   node   0: [mem 0x00000000be359000-0x00000000bf386fff]
> [    0.000000]   node   0: [mem 0x00000000bf387000-0x00000000bf387fff]
> [    0.000000]   node   0: [mem 0x00000000bf388000-0x00000000bfb6bfff]
> [    0.000000]   node   0: [mem 0x00000000bfb6c000-0x00000000bfb6dfff]
> [    0.000000]   node   0: [mem 0x00000000bfb6e000-0x00000000bfffffff]
> [    0.000000]   node   0: [mem 0x00000000c8000000-0x00000000c9ffffff]
> [    0.000000]   node   0: [mem 0x00000000d8000000-0x00000000d9ffffff]
> [    0.000000]   node   0: [mem 0x000000103fc00000-0x000000103fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000103fffffff]
> [    0.000000] On node 0, zone DMA32: 24576 pages in unavailable ranges
> [    0.000000] On node 0, zone Normal: 56320 pages in unavailable ranges
> [    0.000000] SBI HSM extension detected
> [    0.000000] Falling back to deprecated "riscv,isa"
> [    0.000000] riscv: base ISA extensions acdfim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 22 pages/cpu s50024 r8192 d31896 u90112
> [    0.000000] Kernel command line: initrd=\initrd.img-6.12.63-cip15 LABEL=Boot root=PARTUUID=bac9149c-8332-4f2b-a225w
> [    0.000000] Unknown kernel command line parameters "LABEL=Boot", will be passed to user space.
> [    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 279552
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.000000] software IO TLB: area num 4.
> [    0.000000] software IO TLB: mapped [mem 0x00000000b4e00000-0x00000000b8e00000] (64MB)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0xffffffc4fea00000 - 0xffffffc4ff000000   (6144 kB)
> [    0.000000]       pci io : 0xffffffc4ff000000 - 0xffffffc500000000   (  16 MB)
> [    0.000000]      vmemmap : 0xffffffc500000000 - 0xffffffc600000000   (4096 MB)
> [    0.000000]      vmalloc : 0xffffffc600000000 - 0xffffffd600000000   (  64 GB)
> [    0.000000]      modules : 0xffffffff01794000 - 0xffffffff80000000   (2024 MB)
> [    0.000000]       lowmem : 0xffffffd600000000 - 0xffffffe5c0000000   (  63 GB)
> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (2047 MB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] riscv: providing IPIs using SBI IPI extension
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 3526361s
> [    0.000003] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every 2199023255500ns
> [    0.000628] Console: colour dummy device 80x25
> [    0.000658] printk: legacy console [tty0] enabled
> [    0.002546] Calibrating delay loop (skipped), value calculated using timer frequency.. 2.00 BogoMIPS (lpj=4000)
> [    0.002624] pid_max: default: 32768 minimum: 301
> [    0.002845] LSM: initializing lsm=capability
> [    0.003339] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
> [    0.003484] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
> [    0.007294] CPU node for /cpus/cpu@0 exist but the possible cpu range is :0-3
> [    0.012353] riscv: ELF compat mode unsupported
> [    0.012383] ASID allocator disabled (0 bits)
> [    0.012907] rcu: Hierarchical SRCU implementation.
> [    0.012954] rcu:     Max phase no-delay instances is 1000.
> [    0.013953] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
> [    0.014734] Remapping and enabling EFI services.
> [    0.016088] smp: Bringing up secondary CPUs ...
> [    0.022908] smp: Brought up 1 node, 4 CPUs
> [    0.025064] Memory: 869308K/1118208K available (11596K kernel code, 4965K rwdata, 4096K rodata, 2273K init, 517K b)
> [    0.027073] devtmpfs: initialized
> [    0.038369] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.038491] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.039485] pinctrl core: initialized pinctrl subsystem
> [    0.041172] SMBIOS 3.7.0 present.
> [    0.041262] DMI: beagle BeagleBoard BeagleV-Fire/BeagleBoard BeagleV-Fire, BIOS 2026.01 01/01/2026
> [    0.041357] DMI: Memory slots populated: 0/0
> [    0.043197] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.044109] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
> [    0.044230] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.044519] audit: initializing netlink subsys (disabled)
> [    0.045141] audit: type=2000 audit(0.044:1): state=initialized audit_enabled=0 res=1
> [    0.046076] thermal_sys: Registered thermal governor 'step_wise'
> [    0.046213] cpuidle: using governor menu
> [    0.072606] cpu1: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
> [    0.072606] cpu3: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
> [    0.072633] cpu2: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
> [    0.096718] cpu0: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
> [    0.097122] CCACHE: 4 banks, 16 ways, sets/bank=512, bytes/block=64
> [    0.097181] CCACHE: Index of the largest way enabled: 11
> [    0.120441] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependency cycle(s) with /fabric-pcie-bus@3000000000
> [    0.121236] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependency cycle(s) with /fabric-pcie-bus@3000000000
> [    0.121476] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependency cycle(s) with /fabric-pcie-bus@300000000r
> [    0.125897] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.125966] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.128097] ACPI: Interpreter disabled.
> [    0.128795] iommu: Default domain type: Translated
> [    0.128843] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.131990] SCSI subsystem initialized
> [    0.133154] usbcore: registered new interface driver usbfs
> [    0.133294] usbcore: registered new interface driver hub
> [    0.133432] usbcore: registered new device driver usb
> [    0.134931] efivars: Registered efivars operations
> [    0.136181] Advanced Linux Sound Architecture Driver Initialized.
> [    0.138550] vgaarb: loaded
> [    0.139556] clocksource: Switched to clocksource riscv_clocksource
> [    0.141508] pnp: PnP ACPI: disabled
> [    0.167966] NET: Registered PF_INET protocol family
> [    0.169012] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.174128] tcp_listen_portaddr_hash hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    0.174331] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.174427] TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    0.175045] TCP bind hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.178666] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.179690] UDP hash table entries: 512 (order: 4, 49152 bytes, linear)
> [    0.180092] UDP-Lite hash table entries: 512 (order: 4, 49152 bytes, linear)
> [    0.180915] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.182745] RPC: Registered named UNIX socket transport module.
> [    0.182811] RPC: Registered udp transport module.
> [    0.182846] RPC: Registered tcp transport module.
> [    0.182879] RPC: Registered tcp-with-tls transport module.
> [    0.182913] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.182970] PCI: CLS 0 bytes, default 64
> [    0.184816] Unpacking initramfs...
> [    0.186040] workingset: timestamp_bits=46 max_order=18 bucket_order=0
> [    0.187088] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.188252] NFS: Registering the id_resolver key type
> [    0.188379] Key type id_resolver registered
> [    0.188418] Key type id_legacy registered
> [    0.188526] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [    0.188575] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
> [    0.189155] 9p: Installing v9fs 9p2000 file system support
> [    0.192783] NET: Registered PF_ALG protocol family
> [    0.193047] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
> [    0.193680] io scheduler mq-deadline registered
> [    0.193733] io scheduler kyber registered
> [    0.193884] io scheduler bfq registered
> [    0.196727] riscv-plic: interrupt-controller@c000000: mapped 186 interrupts with 4 handlers for 9 contexts.
> [    0.200586] SBI CPPC extension NOT detected!!
> [    0.369675] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.376972] 20000000.serial: ttyS0 at MMIO 0x20000000 (irq = 12, base_baud = 9375000) is a 16550A
> [    0.377122] printk: legacy console [ttyS0] enabled
> [    1.457413] 20100000.serial: ttyS1 at MMIO 0x20100000 (irq = 13, base_baud = 9375000) is a 16550A
> [    1.469786] 20102000.serial: ttyS2 at MMIO 0x20102000 (irq = 14, base_baud = 9375000) is a 16550A
> [    1.482290] 20106000.serial: ttyS3 at MMIO 0x20106000 (irq = 15, base_baud = 9375000) is a 16550A
> [    1.493011] SuperH (H)SCI(F) driver initialized
> [    1.498885] [drm] radeon kernel modesetting enabled.
> [    1.525663] loop: module loaded
> [    1.536543] ------------[ cut here ]------------
> [    1.541291] macb 20110000.ethernet: device non-coherent but no non-coherent operations supported
> [    1.541323] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/dma-noncoherent.c:139 arch_setup_dma_ops+0x6e/0xac
> [    1.541380] Modules linked in:
> [    1.541402] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.63-cip15 #1

Ouch. I just checked my image again, and it used -cip14. Hope we do not
have a regression. I will try to rebuild and retry later.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

