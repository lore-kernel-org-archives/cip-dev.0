Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EF7C47077
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:19:07 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.53])
 by mx.groups.io with SMTP id smtpd.web11.2860.1705004341716242845
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:19:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xmvfdCzz;
 spf=pass (domain: siemens.com, ip: 40.107.21.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpR4pzvVx6wpDpTCj5aqU5byCK+QooO66YHlgL9yBFBMKWgJBjYK9Cd+PJilx59/rmwXEc/FyKvONq/taFYOKrLPfV1PKoKaYBvs3NLgEdptLqeHqCrs5eOl1vYmkri2ci88DXTE8ZjMZh0HcT7UMjrBxQ80B94tyFgaYreZ5qq++oniipAAjjC3TaKtfrX6d8hSrOOKsDRMaypVeQFkQIUodoaSXO7z0IWHjpo5+lUfeEK0R+t9EoBqFTGoy9cJfe2KqH8NpWK0DjvkWv0sMw1qmvD4gcMyLsrZPVfOtd8uQGGYyPB/GVOhMRX5b2TmjA4Ay6GcT4tw4qJSPPxObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n42klrcZ+Tk6uzGhRy4W0nUzUsLwwquyAtPeWW5U+k=;
 b=aYyfDyFR5QXA2aNR8oHJ4yap8k2NC1k/MSUq2aXCJrChqqwZUzOBnIqFkOLITjsSXmQvKqmUJ+z8SD0gpgoQeHd+lSGTJzut+6pcdzYBtQR2slajNFYem3uk7iI2g93IRLN34jy4kBUo+ekGBS9i1rVObnDIrAVqLWYirLY3LtDR2TDvYWALE/zn+wOExBjEZDYQFPIP0MENwFmwsJxOYxnWbuRPjYMN49DclAMoH0/DWVl26cm+wUoo+K5OUYq4Vz5PtLYSky3H/0BEzgJ0FGDya+giDdiKhvyQ8zZN1Tb+Gs3Gxyj/ijILCMe+QehPZatv30mq9GAajLsaSkvcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n42klrcZ+Tk6uzGhRy4W0nUzUsLwwquyAtPeWW5U+k=;
 b=xmvfdCzz7vqL8KObdxKYe3mHpRciL22UYxKD95t6ITl9gbhArHtfVwy28JyIlwwI7G881qGhpIi8Fo7yY4Bkf0dEaUVAHsLi7u4jq9ISIilvgs/4dgraOiU6BF08ttBJau3zDKZTvFfU86ZFLag9h2bhP9ucVNRVKj+kJLnrEADBkZkSYHRx2ndEg1N6LCzj1AdQJX7vheRELeb3/9LZTuedC8CZ3uORCD5CR+yMsfN10FfGGNWsdmkM8D4Mma1OhV5vdBiAf+d4tAeLOYdMSp4k7SMUcQTnOhKW64naab4IYrx7bcHB9boIFkB+r5gjj2o300xaMamyLtgNdMAczA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:514::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 20:18:57 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 20:18:57 +0000
Message-ID: <4df64abc-9dda-48ea-8d03-1b797fa62863@siemens.com>
Date: Thu, 11 Jan 2024 21:18:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Migrate RISC-V support to Debian sid
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <1cd81bc4-a52e-4dcb-9ff6-48b163bd6edd@siemens.com>
 <6cee5609-9b96-416a-b477-e54f29d13287@siemens.com>
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
In-Reply-To: <6cee5609-9b96-416a-b477-e54f29d13287@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: fedb5d75-8b2e-480a-2e10-08dc12e28a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xTwX3y/r1oKbKss1WGd+gIVZEw+5UilCz6g7jGZvygqdYg2rk77ROIZbZQGmqOh/F4BQRoJ5u/1XA9VVe2N/Sg2FgahbvsASc73NSLbfK+DVTyDW9YMN5whUWIQIbQAPHF74Duug+m3/jTFVlhstQPzVJMsDyWXBwF1arHExKfBDzwYy8cK1iVAiuMoY5acuXrF4MyjjLThUL/Csxij5It9CdgRUy/3isjgPn0IvqoKDf/Xs8/wyvUtBb726l7mRUd6JwDpTItAMMZ5ye9CBCJLt7PgM+MQKQsOJNgiQQhBg0EHDLjsEjkLvL2tQ4Mg+NHR1mKfyCuN4epNAZwvp0W6C3rkPHlchcjV0wTlYdlBu7XDhayJW8XZhL+yYytNDuOcpageBxea77YN/QPYav0+HYT7POUTJZbRV8Cv/paVj2aeHKqIvz/U7Y3Ggh8ZrjcTbjgjq7Rj7mg60HQ7BhhQ7RKRQAlNuJRmV+a4mL2MYGbQdSeBPGIAaz6J41XCeoIpy5OerTzRJvHzBXXbW/koV82KzwUjuX4s//qSF+lMbsITZ4FhjT5aJc21lh8zKnENEQ0j1IUzbJk0ZrY2u8E3ZUVFc3oRY8/Oz2dcuSW0y1/cc4MEdH3bAGTKhy0m+X7Y2pi8nbvGhx66W/9aQUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(53546011)(36756003)(5660300002)(38100700002)(8936002)(4326008)(8676002)(41300700001)(2906002)(478600001)(86362001)(107886003)(82960400001)(83380400001)(26005)(2616005)(6506007)(6486002)(966005)(6512007)(110136005)(66556008)(31696002)(316002)(66946007)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkJYVUdCMEtvV2x1dG8yU01Ua0E1OEdUYmFib0JTYVpoanNVU2lOWDVCeXhr?=
 =?utf-8?B?c1NZaWdQclVDR0QrMWFHWDRibHlOa3JXWWxDS2V2MWdLZVNnMHdJUmlJaFJ4?=
 =?utf-8?B?bGRFUWxMcEd5OHBYdmNFd3dLQVU0eklkb3FrQjV0SjRRTjQwVXZDN0ZmbWhk?=
 =?utf-8?B?Tm5OKzRCekR6amppNUd5QVhkVGNkL0JIVmxuR2hJZlpsVS9kTzZURUhhanpy?=
 =?utf-8?B?d3RmdUtBNXFTZVZKc0F0NnJtZmMyUnZkTi9PU2NuWHJlVVl3YjQ5c1BuTWpI?=
 =?utf-8?B?SmFzSFhsRVkzcXNsR1pJZWFnSVpHc0R5RFFtTklYQ2FMNWpVcFdJWXVCNGJV?=
 =?utf-8?B?TGwwTVlFNSt3d2xNb1huUHN6NDNzZTYyMFFKNWZ3aFk1U0dPWnJLWHRqVjFi?=
 =?utf-8?B?YkRldFdzeUtXWUV1c2RlL2lFSUZoSGQ5RnBiRE5uOGNrcnhZSlFLQStOZ1Yw?=
 =?utf-8?B?aHRWdUc2bDBGL04wZEt5MmdRNXh3VWRwY3RZTm9CWGFUOHduZnNMWUpkZ0s0?=
 =?utf-8?B?aXovVjk1UndBNEZ3OWZJLzdwSEc1eXUvRGtCT21lU09RZTdNUE5PdUZiajhQ?=
 =?utf-8?B?ZHV6bXN6NUs5NTJRU25LM2dnN2ZXUXBjSnNpZkcxRGpqZ1NDdUs4MHZYOFZa?=
 =?utf-8?B?Y04zTG42SHkvNjVXMjJpa0ZnaTJJbi9WR010OHVPdFJDRm5Pc2NUeHZQUjFt?=
 =?utf-8?B?Q01Hdk9QN21iQkhrQnZid2t2NkFXdmFXWWduMTRnZlVsQU9ZaE1CVVk3SjlW?=
 =?utf-8?B?c3JtUnJYcWk5ZUlQUXB0cEVlWTdMK0UrS2NlcnI4TzV0Q2gwTFlCOElNOWlI?=
 =?utf-8?B?bmFVemlBNis1cVBVK1oyeTRwUEROb1UxdHQzL01BejJqeVJ1dGx4WkxCZlp5?=
 =?utf-8?B?YzF6ZzhZcDJsU2NxU2dUUVRPd1BUZjBEazcrV0tsbVI1UXdESlhROEhuMmk1?=
 =?utf-8?B?MmM0S1gzb2lLenZ4bVFtUHlweFpTL0YraFVBNjZtU2w4UnIzRGtzdGZ3ck9R?=
 =?utf-8?B?MXJESjhnd1AzYTJoMlhIb3N3amNzQmpRZk85SGVLQTNPLzh2eTY5bWdaOGQ0?=
 =?utf-8?B?TUlTVTNiazRKMVVVM0c3UUt4Y0dhZ0VoR3BIV0ErNWk1UWt1aFVYMEh2alJl?=
 =?utf-8?B?Z0JYUW8ySkNjZC9pRmxqVTRwNE5iY2I5QVVrK3gwN2FVb1ZNdTN5M3htTWpE?=
 =?utf-8?B?TTIveFNsai83WWVIbmZOZFdnQ1BSeXo1U0VEa0NOUzdRZjdwRmRodEN3QjdJ?=
 =?utf-8?B?dWQ5bHZvV3VOWmw5NWVPWlZ4R2FGSW54WGRlNkpPaElmbVNZNGtseDR1ZjN5?=
 =?utf-8?B?WTVmVU0ydjBUNlNDejZEeXVWRmIzRFRsS1czSHJGU3ltei92d0E4cHB6SDMv?=
 =?utf-8?B?b2RtMU1DclJwVTJaWTMzb05DeUx3SjA0aDJCTERGSEU3QjIwMDBnRE56YWpa?=
 =?utf-8?B?ejc4dXE2OU1sTHBpazk5eGhucUszcXcwaGZoMXI2a3hiQUVGVFNLeDF5R3h2?=
 =?utf-8?B?NDRHMHNqN0xSMHNuWUE3b3J6TkdkOFFaMWpCSGxkV3lwODlHL2UvS2ZYSFhW?=
 =?utf-8?B?Q1pnTUVGbFlZaTFyVGg2K2NJRXVrcEpQMDZkSlgxUkc1UGt1L3NFNE5mUTU2?=
 =?utf-8?B?WFRiOU11WnhHLzl1UDRWUnRyOTdSSHZDdG0yVHJ6bGJnRndPV1dUYVBjZVcy?=
 =?utf-8?B?aE1sWmRsWDZuTkkvR0JveE9oZFAwMG5MTDZ3bU1kREZ1MFFQbkZVd09TOGNW?=
 =?utf-8?B?SmJLcFYvRktsVk9YakFUcXg5dSt4WEE0MWNrbEZpQ1ZGNnJvbVlNZHp3ZmNo?=
 =?utf-8?B?Z2liY2dyQmpZdy85c29KZGtEcVpsUFc2NTAySXppRXVFNDM0aEIxRzVPNTNL?=
 =?utf-8?B?YWJZRERGN25LMW1SWUdYa3BoQWE3YVV2VUtWcldHWDM3cmp2S0N6eHY0clRN?=
 =?utf-8?B?RmZBQ2h3WmdmZnZ1bklnRjhPWnM2NjRqVWZDZnBzT0dKU0ZsTjZGRGV6MHNj?=
 =?utf-8?B?WWZUK3hFWnBHUUs4ZnZHbk5sZEZFR1g1eUtlUDM3UnE5QU1YSFBPb1BQMGw0?=
 =?utf-8?B?cnJmRThFYTI1NXpMQ2N0K203eHdiU1NhYXl3S2ZqY1pMU0FXRThjU0lJcHpR?=
 =?utf-8?B?Ymt1cHZzYWdVcjFnNXk2dE1ETVdEL1BWQnFhbmZXU3gyeEFrK3NJaDI3TVNF?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb5d75-8b2e-480a-2e10-08dc12e28a82
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 20:18:57.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnTooVGoMjYYwgc1sgnorpRABIBp+eUH8gYln35pkpD2HtiS22cC/CP9CJohr304zvSsA8vzKJO8LBXL3J/s0YAAJwh8bj0gkZxJo8ndDwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5869
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 20:19:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14346



On 1/11/24 15:47, Jan Kiszka wrote:
> On 11.01.24 14:51, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> With the promotion of riscv64 to an official port, building from
>> sid+sid-ports became broken long ago. Then cross-building from sid was
>> broken, but this has been fixed recently, and the release team is also
>> trying to keep it working. So it's time for us to migrate our
>> qemu-riscv64 to this new configuration.
>>
>> We keep the "allow_failure" in CI as we are still building against
>> unstable, though. That may change once things move on into trixie.
>>
> 
> To set expectations: SWUpdate does not build for sid right now, thus the
> related image variante does not work again. That likely also means that
> even the Debian version of SWUpdate in sid will likely not install due
> to version mismatches. Would that version otherwise work, Quirin?

I am not sure but sid use SWUpdate 2023.12 already I can check it the 
patch on my integration branch.

Quirin

> 
> Jan
> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   .gitlab-ci.yml                                |  8 ++++----
>>   Kconfig                                       |  8 ++++----
>>   conf/distro/cip-core-sid-ports.conf           | 20 -------------------
>>   conf/distro/cip-core-sid.conf                 | 17 ++++++++++++++++
>>   .../distro/cip-debian-sid-ports-snapshot.list |  2 --
>>   conf/distro/cip-debian-sid-snapshot.list      |  2 --
>>   kas/opt/{sid-ports.yml => sid.yml}            |  4 ++--
>>   .../secure-boot-secrets/files/sid-ports       |  1 -
>>   .../swupdate-certificates/files/sid-ports     |  1 -
>>   start-qemu.sh                                 |  6 +++---
>>   10 files changed, 30 insertions(+), 39 deletions(-)
>>   delete mode 100644 conf/distro/cip-core-sid-ports.conf
>>   create mode 100644 conf/distro/cip-core-sid.conf
>>   delete mode 100644 conf/distro/cip-debian-sid-ports-snapshot.list
>>   delete mode 100644 conf/distro/cip-debian-sid-snapshot.list
>>   rename kas/opt/{sid-ports.yml => sid.yml} (70%)
>>   delete mode 120000 recipes-devtools/secure-boot-secrets/files/sid-ports
>>   delete mode 120000 recipes-devtools/swupdate-certificates/files/sid-ports
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 1de6570b..81a31c5e 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2019-2023
>> +# Copyright (c) Siemens AG, 2019-2024
>>   # Copyright (c) Toshiba Corporation, 2020
>>   #
>>   # Authors:
>> @@ -56,7 +56,7 @@ default:
>>       - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>>       - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>>       - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>> -    - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
>> +    - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
>>       - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
>>       - echo "Building ${base_yaml}"
>>       - kas build ${base_yaml}
>> @@ -329,13 +329,13 @@ build:qemu-amd64-secure-boot-buster:
>>       deploy: disable
>>       encrypt: enable
>>   
>> -# riscv64 (sid-ports)
>> +# riscv64 (sid)
>>   build:qemu-riscv64:
>>     extends:
>>       - .build_base
>>     variables:
>>       target: qemu-riscv64
>> -    release: sid-ports
>> +    release: sid
>>       use_rt: disable
>>       wic_targz: disable
>>       deploy: disable
>> diff --git a/Kconfig b/Kconfig
>> index f5ea5aff..d0dc13b1 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2021-2022
>> +# Copyright (c) Siemens AG, 2021-2024
>>   #
>>   # Authors:
>>   #  Jan Kiszka <jan.kiszka@siemens.com>
>> @@ -136,8 +136,8 @@ config DEBIAN_BOOKWORM
>>   	bool "bookworm (12)"
>>   	depends on !ARCH_RISCV64
>>   
>> -config DEBIAN_SID_PORTS
>> -	bool "sid (unstable) with unofficial ports"
>> +config DEBIAN_SID
>> +	bool "sid (unstable)"
>>   	depends on ARCH_RISCV64
>>   
>>   endchoice
>> @@ -147,7 +147,7 @@ config KAS_INCLUDE_DEBIAN
>>   	default "kas/opt/buster.yml" if DEBIAN_BUSTER
>>   	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
>>   	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>> -	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
>> +	default "kas/opt/sid.yml" if DEBIAN_SID
>>   
>>   comment "Image features"
>>   
>> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
>> deleted file mode 100644
>> index 2e74af73..00000000
>> --- a/conf/distro/cip-core-sid-ports.conf
>> +++ /dev/null
>> @@ -1,20 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2022-2023
>> -#
>> -# Authors:
>> -#  Jan Kiszka <jan.kiszka@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -#
>> -
>> -require conf/distro/debian-sid-ports.conf
>> -require cip-core-common.inc
>> -
>> -PREFERRED_VERSION_linux-cip ?= "5.10.%"
>> -PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> -PREFERRED_VERSION_swupdate ?= "2023.05%"
>> -
>> -DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
>> -HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list ${DISTRO_APT_SOURCES}"
>> diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
>> new file mode 100644
>> index 00000000..028b6c00
>> --- /dev/null
>> +++ b/conf/distro/cip-core-sid.conf
>> @@ -0,0 +1,17 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2022-2024
>> +#
>> +# Authors:
>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require conf/distro/debian-sid.conf
>> +require cip-core-common.inc
>> +
>> +PREFERRED_VERSION_swupdate ?= "2023.05%"
>> +PREFERRED_VERSION_linux-cip ?= "6.1.%"
>> +PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
>> diff --git a/conf/distro/cip-debian-sid-ports-snapshot.list b/conf/distro/cip-debian-sid-ports-snapshot.list
>> deleted file mode 100644
>> index bd08a742..00000000
>> --- a/conf/distro/cip-debian-sid-ports-snapshot.list
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian-ports/20230430T091331Z sid main
>> -deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
>> diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
>> deleted file mode 100644
>> index 87e0b95b..00000000
>> --- a/conf/distro/cip-debian-sid-snapshot.list
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
>> -deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
>> diff --git a/kas/opt/sid-ports.yml b/kas/opt/sid.yml
>> similarity index 70%
>> rename from kas/opt/sid-ports.yml
>> rename to kas/opt/sid.yml
>> index b11a1c2b..be2eeb47 100644
>> --- a/kas/opt/sid-ports.yml
>> +++ b/kas/opt/sid.yml
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2022
>> +# Copyright (c) Siemens AG, 2022-2024
>>   #
>>   # Authors:
>>   #  Jan Kiszka <jan.kiszka@siemens.com>
>> @@ -12,4 +12,4 @@
>>   header:
>>     version: 14
>>   
>> -distro: cip-core-sid-ports
>> +distro: cip-core-sid
>> diff --git a/recipes-devtools/secure-boot-secrets/files/sid-ports b/recipes-devtools/secure-boot-secrets/files/sid-ports
>> deleted file mode 120000
>> index 91bf492f..00000000
>> --- a/recipes-devtools/secure-boot-secrets/files/sid-ports
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -bullseye
>> \ No newline at end of file
>> diff --git a/recipes-devtools/swupdate-certificates/files/sid-ports b/recipes-devtools/swupdate-certificates/files/sid-ports
>> deleted file mode 120000
>> index 7d00e075..00000000
>> --- a/recipes-devtools/swupdate-certificates/files/sid-ports
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -../../secure-boot-secrets/files/sid-ports
>> \ No newline at end of file
>> diff --git a/start-qemu.sh b/start-qemu.sh
>> index b6f9d012..080f939c 100755
>> --- a/start-qemu.sh
>> +++ b/start-qemu.sh
>> @@ -2,7 +2,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2019
>> +# Copyright (c) Siemens AG, 2019-2024
>>   #
>>   # Authors:
>>   #  Jan Kiszka <jan.kiszka@siemens.com>
>> @@ -40,8 +40,8 @@ if [ -n "${QEMU_PATH}" ]; then
>>   fi
>>   
>>   if [ -z "${DISTRO_RELEASE}" ]; then
>> -	if grep -s -q "DEBIAN_SID_PORTS: true" .config.yaml; then
>> -		DISTRO_RELEASE="sid-ports"
>> +	if grep -s -q "DEBIAN_SID: true" .config.yaml; then
>> +		DISTRO_RELEASE="sid"
>>   	elif grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
>>   		DISTRO_RELEASE="buster"
>>   	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then
> 

