Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24216C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 15:04:23 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.78])
 by mx.groups.io with SMTP id smtpd.web11.23546.1713539055559194055
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 08:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aGRE2BgQ;
 spf=pass (domain: siemens.com, ip: 40.107.104.78, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKYoTkZjwD9VlSkmhmes2+fe/8hGyXNfK4+6bzduM6mL4gLmNBtfdHPAOAtnyVtrRfp9ESDVMmLvMVvRkGXJLtQUAw9GY19x+7+sJ90+pJ/Q6Y34/lcuzi4qlxTWQc9yHwasLuqdzH9RuoTqpsBH9UieDVU/sDk2L2xzTh6rvLOnHC5FREpG1GlAdzLswWzkDU74WU3Sk4WrH1EdO80htzsBb0CbUrza8y0CM/u5wpn9w+xSNcLTmj/hUjrLCDAP+rYtsJ5OAV1RaBFEf37S+bASBZ1tQdRrhJD2ZAscYDoq71RmY03gNJS+PnLPmA+Zc5CBQPsy3xEDz39jeSrdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5pCqWPXILpJeggsHXCkGZrmFWCCJkFAcI0VGKgKwxo=;
 b=INzqA60bXuc8ahguwHRk+w8L5wMEJEaQErAlN0gfCYSc2AYgN/u85QTTx/Gf3gAo5n3OR/+6i9a1sWHs2UjU9/T13PvFIhUKcuyp6Wn2P5Pkop5BE8MR2VvXlD8T70XUT0dsem7Tra7H3Q3+cvRti6VhKxw3jzEWtgfzfz0kQ9CCw4fVRWdDr8qWw1T6tzleL4ka2dlm3aI3F5Yn5qGvHp4J9YsLxqbJNsrBYmZBN3gS3t2ARCDioK/LKXkoEHIXEaxkRW8Q68aOLf9M8v2T3DpjNBTYDqYqpLNDpSeF84tnNCh9UhkmQTLt66Dz5V7uJfI80Md66RG4XoNfCxgFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5pCqWPXILpJeggsHXCkGZrmFWCCJkFAcI0VGKgKwxo=;
 b=aGRE2BgQ3cBwyAphiVDTb+9VqlGXcw4m1Bx11K262DfRhdeOf1giPthYxzQkare9lM/4+qLqVtaNePBmHuKi6QBqwUbtRoj6R7Fp/3rxZyYVoPOOnnRKnFjAyC+5r7PaEtpNoXHT0ywps9Pd0iFM8+hSZ26CclqcC0jiXNC7RdktV6oNP8hpUQ8GqIrLM4nVKwby/skENFiSZ2LPQpGWJ2ouM8Mzn5B/AJKygHYrA20Nj4l4YSvC0nT0erHcWLUp6bnTaAgCLhphjYK/oDMUXOEgg+kqzU4R6sE9nixb+DJJD7HPQwzvAutbjHO5E1014zmbdQT4iYl57jl4qpOd2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB8197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 15:04:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Fri, 19 Apr 2024
 15:04:12 +0000
Message-ID: <dd7d3538-ba7b-4a40-a717-8057021514c6@siemens.com>
Date: Fri, 19 Apr 2024 17:04:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 1/1]
 recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in
 debian/control
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>
References: <20240419035001.594631-1-kumar.rakesh@siemens.com>
 <20240419035001.594631-2-kumar.rakesh@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 xsDNBGE5tqgBDACpa0M7NVvWkE84XaWEmmQT0REu4Ad8DGRzxlQdLHn4PwakShu46Kl9Rrwm
 KZsIoQaLMM+e39xkl70bNFAKOodEgnkwzywjRkOXzf46AkBs3xThp/SMuZXIgdXDXhJupN1G
 1Zu0GbIx316GZaXf9lXuiAwwqJXKWsjRuFSNopQUMs4R4v7CRuwx/y2CPkAbq9rhph6njcaO
 4JTkkd8s0IA8Ec4otQ+YcUpRvrqHQAx3jFP3hDO93s1Ja8iLkDHxveD/5dnCoJ7wBxWQw1D+
 Qy/YsKzT9eBCo41aiP2sh6Xae7YAF/bZGXm5Nh/tIN6tM9O2ujsvICJMgaQ6KvLl7uLE12Ey
 3Tiatxuse0cRCVLU6dL/ljm7jY30gBpgP6UpMYANNKbjH1QHOkyM0725Wodh3s2kb+nMSgCr
 bx8kbD03tFAOFdmMANUmTI2XUcUUuEPHGWMViZlKi8GEIElXMXJi3WJSJBFaEYj/ns6lGKNk
 zE053GrLzJHh1wcZmPWHsZMAEQEAAc0vR3lsc3RvcmZmIFF1aXJpbiA8cXVpcmluLmd5bHN0
 b3JmZkBzaWVtZW5zLmNvbT7CwQkEEwEIADMWIQTY7GSkZ04ObjDZR5UG7p+HXEQunQUCZNTY
 OgIbAwULCQgHAgYVCAkKCwIFFgIDAQAACgkQBu6fh1xELp2ViQwAkSIZKvKai3o1yAsYQGYZ
 Pa9oIzM1+rqGPdBTqJ8LCIUM3kDz7kNo3nll2mnhtZOAeA/DpEc/pQGpIUUm2XQJEOCCv4Ze
 fO2tFuhACpU6Yz3XwQhr1SHy/KPsxUmiTgZUzfvlDxFzOuvKt4kg7/lC4/qm4i4ZRbohjggS
 XwLAawfULBSzoiTaMi6GtPm8e8oLoBwdo7UIwHHlN5s5UoEruntnc/Tx6+wWquHX/3/zVGUu
 OBqixq3uClkTNCY4itIix9yuMsUgWUgarN2BjcDxeNFIxlozGgcMmWyRobDOPfL7I0YHXm3/
 uB3wg4ei5dBCB12uYKr4CH/S3CRtYXUaIdyFoxYlvpEoUfuHthB2wcqQllVg3IEhGhkuvfTX
 snzeMFhg7wU7HlX/MDK5EnAGK9fHvZMnbb+H78bMNtoisBPY7XwuOAyUOtwMq0SR8G+9ZLnC
 ABeS6tyPB8UePy8MWdcTQRboXubmUkDAIwBuNI2xALMYZxyUZWEzD+M0euWLzsDNBGE5tqkB
 DAC6s08UAYSENgz33zbBZ+XWlo5A7muxzYjwN77DMgC5EcuqQJA2YnMO15mkB2YcTbP2Zf97
 ZhjTneRwe62xurjO2SOwPi0Sw3JN+VBQ1hpxMHJ2KjeAjJeQ4kINYgFFF5vNfgfGi7eI9qrL
 hViCf0Osulj7IGD7vDkib1WoO++SRO+9DShVD4sFIi0Gv9YSTalazpT9bgcAtnaDb/viLvaU
 qtK7S5rvFVPiuUD60yvmr3Pfd5iPKSxIQS/5/uKWGjeCntNu4ujoIg3C5rnDRIp4wcKIYXOu
 Nq0uGT52B4jtakb7jomXGX1/MZAHSRzUNUrup0UbwWCJEuvUEizq3G3Kg/Itvns5JzZAyGHk
 Jn0Sa9sTZCN+lNspvl1/t4F9ogBQbGOWPaslScjUQ5VDul8oLGMK1Zi+mj+SYFpQCXd7fwhP
 fl+yQlOdzGOGKHk9jqcaRHizuXtabQVIGrO8I52p26QJWaVqmMvJRWRqykxzk0Sw17/YDOBQ
 iEE0QOivBwkAEQEAAcLA9gQYAQgAIBYhBNjsZKRnTg5uMNlHlQbun4dcRC6dBQJk1Ng6AhsM
 AAoJEAbun4dcRC6dnnML/jLf8oN9BMkd/UaOtBh04YQQLR8TFwahbIZQZUakRteSaWILgGT6
 vuu19bbSaU3WAFHiB+ftuLYxCh9LB2YjEjoaDeFY+qOpYHsWKrE1g/rr5iEPyb+V3FZvd8a2
 fbSo7Hdw9n0jzAr6Yb6dMnU2FN6iRrIYoreEkEB5WbrFfmEyQGdxF45FGnu7mkLMGs4P8hiC
 Jpn73cdGB7Mj5+XWAcoYKDqXiKm6FL9Bfle7RO6FaI0m5JqQjGmsTLAIDaY6ZYSQmBzY8WzY
 5e4YlveowP9E+boqYhyPLGdDFVGhWwHMb/VkeFXAwsNtsfQfmpb/VmWs0urz8WkvYpiF6pZw
 Xe/DyZ2leVdCQVbhsUb4z1b1nAYAxVB+4yIqi5uc1cQYFzb1LPeMcQ0YVv9UAjqaYzP4vh6e
 2zRoeyL3H2PAQbodkBam6WiNHFG0HezOnSTxOHcpqx8s8bzgrJHGj6eUbQjxG27SGvTcy6Gs
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240419035001.594631-2-kumar.rakesh@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c7b40f-ed0a-4405-d9ee-08dc6081f8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Nc6dNbs3nMRZ2rrm249r0tPshg+C6uuMIb6hYY5TFCHzS6U4WDXyogMnz67Bl5mUCXaTdInPcBYJIy4+xjVjMKxnXKqOT3a15uBW4qaYRJWow+sXp70WJ08/8yjWQsxWOINFl/n3Kws1V9y1MMd9M4sCaQ5OyT3/WUf2l82EFwAQiAWUDbu8iJFrokm7iTKiiR+mJrCiWggxhLeZ/fOYtEvdUsvSn5okVpe/XdanuaLjbp65ds74szmu8nXMJy+MX5egeFe8o3ONx2ZRkM8dlHyAKJIMjyi39JxVL0u4fjNHmf88iWnqFoPtlaH7UQPOD6J0r7LfLVFNOgUw0pRKPk+EGKLpm7P2zvJUEow9Shn42KUvVTs+UP2s4xM8bhkR6157kjsuQOgTOAIDRerLS/cdmNF9EALeU3JnKa/AKbHO26YJrW/+N5DUJQ8msGoYDYoeABaqbz7n7dRAUI6OmRGTirtDaIyRGXZ0r1+wyN6+DbnsGOag9cUrkMOMqbXM8+X6YhFF689qQ/PPInKYxq2itMiuUYoBe1J7KJOjCJvxw1qNVe0CjqVHzu/qF5q4+cHi/qnDt4tKpOMOF43WIzGbNO1f6wmkBi5CaxWk0Ig=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnVNY2V0dkU4L25pcWpsRWZkR0x1NnMrQ2pGbWo1M0ZQbHk1bjMyWWFtNUJS?=
 =?utf-8?B?TlM4UTYramU0SlB1MEhkbzJrMVNpQ1Q1UDN6N1hlVHpjZ3o0ZnpOODc5NzFz?=
 =?utf-8?B?dU1lNXBwMzlYY3oxL3ZyeVFSMUw3czFqNk45YndEeHMvRzVyVjJkdUhDOFQ2?=
 =?utf-8?B?OW4xeDJQMm5XSmMwQTIwR2d6NFllaFVyUzZNSDRNaTdoeDdwMk5vcWM3Mjhr?=
 =?utf-8?B?TDM5RnBrV3g4cnh6eWhTMysvTjNuZjkxR2RiaGZFNkxWS25NWE9ycW40aENL?=
 =?utf-8?B?ZE1zTytnSVQ1WEprcW9zRmw4YVBOTDdqNXFzY2I3Skdwd3BjNUxoNG5vQktT?=
 =?utf-8?B?WmVwb3h5RGJvdmVNMEJtd0tJaGdIYVgvTGFqTVpiem14VmFtdmxFQkozdzE1?=
 =?utf-8?B?OVBMOXpYc2lidHdOc1dWRDI4bHQ5cDJLWWFPVWlQOUp6bmdFSDlDQXRJMytN?=
 =?utf-8?B?cmlqNTdxcGxqZVZwa2Z5VUZiaFJXQlY1RmxQWUJnWm5ndGlQRFVMSFZNRVhP?=
 =?utf-8?B?QzZoaVI3ZkxvTk9VVFd2dXI0WHQ3U3NKUmRrRGZxR3RHQnVFdDY5MTcxZXFF?=
 =?utf-8?B?dmN1STBPM0s4ZkYwV0pqTlZpQzM0U0V1ZDdiTmIrV3M0RXJGNkJIdUlsem5E?=
 =?utf-8?B?V2VOTkhVUDYvOTh4TjFTNG1QT2t4S01xUDV2TEFYL3Q4Z2lFWS81a2pjdVl2?=
 =?utf-8?B?bDBXMEhHQ2VzUS9kYjBJdFFjZjg1NU9yalRiQVRjdGlRNEZiMERQYzFaU0tB?=
 =?utf-8?B?L203ZmhYdVluaHVQaTZCLzU0NmNieG5lRHBiUEo5d1JqT2ZJb3NmNzUvK0VF?=
 =?utf-8?B?LzBuVW8wazdjTENRR3NoLzJZSkZPeVE4S1YwVktoZmtzNU5ibFZ6U1FkZUFw?=
 =?utf-8?B?VC9ZRCtGZXRsOW9RelVDV2tHdVNtZU82K1NiVmZpbEdsVUcrNzRScTRucjFK?=
 =?utf-8?B?OWtFRmxJaUNnT2c1MExYaTNQZzBFalR3Y0xGSHYyT0w0TWJicnVwU0taNnd3?=
 =?utf-8?B?ZjQzZlhFclZtajA2YXBhQTI4aEl1WmIvYkZUa1Z4ODNpckN0YVlhNjVteGtN?=
 =?utf-8?B?UmZXTVdvU3laRlMvNEdQWWZwQk5Jc2VBMVdYTEFxMzJyY2xxYjlQSmt5VlVX?=
 =?utf-8?B?TE5XeFVjRTZZVEFLbFJweGltNDlPdmtRaHpDOCtnVUNDdmxDSTFUcDl2Tyta?=
 =?utf-8?B?TGdkWTlBWUpBNHI0NWRpWXRwYlYvbnFxbExVa2NmUjlKNGRza2VzMklPelp4?=
 =?utf-8?B?UHhlNmhsQlJxRnpWY0FmM2tJSW02QlFaVzVXRFRZOHo1YXMybEJobUJkbG4w?=
 =?utf-8?B?WVRzSXJVOGtVaGdPU0dwWFNPL3Nyc09KMnArV1VHMzF1ZEVTQ1U3L253WFVW?=
 =?utf-8?B?ckJwMzNqRWRCcWdEMnF4RFdhcTdBMjA4OEF5Y1p3SVMyZzArOHhHT25lQnox?=
 =?utf-8?B?VGVsZGMwL2pBK0xab0R5MDRFVzQxb2tsNzErT2o0aTJjUVZ6RER1SmtaTzBp?=
 =?utf-8?B?SDBybjFrc1FzR3NuVDhoOWkwVkhrWWhwZnE4Q2ljcWVnVWo1WGVUR000b2R4?=
 =?utf-8?B?dUF4WGoxNHVMdUltcDFYYW1VYzEvQzd4NEE5RVc4allneTZEZk8rV3I5c0Zn?=
 =?utf-8?B?b2dGQjRGVXpuS2lWWGVpN0FIc1BLZDJwWDY2OE9oMjdidHgyUHlNcTN3WFl3?=
 =?utf-8?B?SHZTMTlzQ21uMlYvUm1oTk5mc3UxT3FsS3dmT0RkNkpwRnpvdllzNUNpRUU3?=
 =?utf-8?B?TTNvQ0J5Zm9IUXlEQjFaamlZa1htRmVoczNRcUY0ZmtpUllyeko3RjgrUHJE?=
 =?utf-8?B?QTlyN3dYNGwvNXRvK1UycTJleGpvVitrY0J2Q1VzWk83WHFnd0Ewd1NYYTBJ?=
 =?utf-8?B?ZHI3WWk2VWFTcG42UEUvOGJZbXRqLy9SRzBtNEpZcnRjVTJpR3N2aDBhNlhu?=
 =?utf-8?B?d20yNDZEZkFDcW4vcWpJdUthTk1LMUpuTnlsMFhTbllqN1NEd2lLR2R1YnpD?=
 =?utf-8?B?NGVRS3RqRzJUM3hod1JORlZSdzZPT01XdDNpWno4TWhlVFU0aStOWmtFQ1Vm?=
 =?utf-8?B?c0hQSlJ4d3d4SXczaVB6UXpleVdMVS9reE1sQmpBME1tMkRFNU9aN0EvK2Vm?=
 =?utf-8?B?SVVnUzk1aXcvZU5oQXRLNnlhTHdueXM3eWxraWJ6UDBGS1dLaTdhdUVyWGkv?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c7b40f-ed0a-4405-d9ee-08dc6081f8a6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:04:12.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jC4HFM5l1V1qufFYiY6GbayJv6VMVxkmxw6I1pzg8HEq1lfun5PRyVwduOzpiWarlXB7s8h7O6Zki2Ql93xyY8a+c1Y9ztHjxoFoOzZJ3xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8197
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 15:04:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15699



On 4/19/24 5:50 AM, Rakesh Kumar via lists.cip-project.org wrote:
> Previously, the debian/control file contained a duplicate Provides line,
>      which caused a build failure ad below
>      | DEBUG: Executing shell function do_dpkg_source
>      | dpkg-source: error: syntax error in secure-boot-custmpk-0.1/debian/control at line 16:
>      | duplicate field Provides found
> 
> Use DEBIAN_PROVIDES to resolve the duplicate Provides problem to ensure
> that the build process completes successfully.
> 
> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
> ---
>   recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index 2164b12..00b2a38 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -14,6 +14,7 @@ inherit dpkg-raw
>   DPKG_ARCH = "all"
>   DEBIAN_MULTI_ARCH = "foreign"
>   PROVIDES += "secure-boot-secrets"
> +DEBIAN_PROVIDES = "${PROVIDES}"
>   
>   SB_KEY ??= ""
>   SB_CERT ??= ""
> @@ -31,6 +32,3 @@ do_install() {
>       install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
>   }
>   
> -do_prepare_build:append() {
> -    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
> -}
> 
> 

cip-core is using 0.10. DEBIAN PROVIDES was introduced with 
4d0955547453e4303f1f274354a0fb6558a74fa9 which is after 0.10.

Update ISAR first.

Quirin
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15698): https://lists.cip-project.org/g/cip-dev/message/15698
> Mute This Topic: https://lists.cip-project.org/mt/105616566/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

