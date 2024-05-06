Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077A2C10F16
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 10:58:34 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.40])
 by mx.groups.io with SMTP id smtpd.web11.17667.1714993109202895637
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 03:58:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i5ccBocu;
 spf=pass (domain: siemens.com, ip: 40.107.8.40, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtM/1/FfLEA0koMyUzrYvKA3f3JbTeOOn7OfzPG3kU/J8CdoX4hgw/SlJE8PkeOyxCmoOlgkv5uGOO4ptkK8kWUpVOF+S8Wx7kbViUB75eZvnN+P7RKbXlb7MrgWqIXBSezOZemJ3mzi2zblYllZOg/kXtrSRCsf9iBKpjEYnGEAJvWJoQdVBI9/CECj5rTcmWtLJTg4lQU17lkyeaiLIKDvfCYJfbSf+8pi66LyDApT19NH5aDUL/jkuvmtGXhnGPzvrlHzYCHOzdoelJBaJNh5g6sUbUt0UI3B5Q82teQEoQ6+G17DXd9GqFO3RrGdj7mt0k3Cjj+2hQOhJLyD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W58C/qQ5q+UMcJr+Kh6RvBDTrgvb8hEYe334iMu9xwk=;
 b=hg/01e49z/TVNNXAfhySECYN16p8dPFZKhqy9R/LryVIBeN6AbWiIKBxpwjQ0uWBk7hQ7I/IBvDT+PVcH5RT8MZZIubkYpyrirXjem8I/ntXTobBDcNitcvDUHtK8HDgA8DFky1JdYRQKTNhgzOD+aHY/bwKWSaG80hj43ggfWU+v9utQ2VHpgCcp6EFDIhxt0WNd4ay+FTSoCxQ3PoadcQKR6ImDjNP4thzZUAAiM4nBjunhFoWVW0NNK+7+cvzWa5qTi737OzSDunNcaoM4/1iDrz3CvcGalqiE2oanNALQ59FWMjFi9P2k6s90/e+MO90xH+39ez3mhjXIvQcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W58C/qQ5q+UMcJr+Kh6RvBDTrgvb8hEYe334iMu9xwk=;
 b=i5ccBocuUc0GhgiTjx6CoJ78MaoOkdPC/UHGdeOMzY2ueLqwM5nwB39KP2S8FipQKEStq28E0aMFUbAyvWsRgpHwAxdh1g+Yq7rW5+UPKDu9tvOdvXlUjj1XCEeVWfYIDVviRvwcEFh892iJoCd5Ch7QZ8WGl9mxyRN4jJiSqgxf702q1C8N++IPhmdtE/YN/VjCYpj2ahoNvNGzZfS6mVujRBMX6eM7YnK9ZsZaFBXxvWKErni5fZSejq/hdn5xrAO2OQO6HE+/SxYDISqq5e+phVCz0iTyP9k944HqfC0C7tL9+H7NwEzvu2SkkWSrJwoyLT0wxOgjIuPANSUn/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PRAPR10MB5251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 10:58:24 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7544.036; Mon, 6 May 2024
 10:58:24 +0000
Message-ID: <ccc423e1-1fc6-4f58-a3c6-f1547fb6ebdb@siemens.com>
Date: Mon, 6 May 2024 12:58:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] wic/plugins/efibootguard*:
 Take --size and --fixed-size into account
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20240503145416.663757-1-Quirin.Gylstorff@siemens.com>
 <045cdff0-0e76-4795-951b-ebdfdf9d50f1@siemens.com>
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
In-Reply-To: <045cdff0-0e76-4795-951b-ebdfdf9d50f1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PRAPR10MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3f0eca-679c-431d-ad0c-08dc6dbb7374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUZGN0NVOG0vcmRXcVROMHVnN1lxWnViVFVCellxZ3ZGL3JaRDBNdlF5NDdh?=
 =?utf-8?B?dkZmUGo1K2p1TVRrMHpVSVJBYk9oN2R3clVzTUFmYll1dWd1VWxrYkcyRENS?=
 =?utf-8?B?NzRMT3FaQTYwdFIzVFZvTFJsdnZMNFZLK0YzcUUvbnpyNDBQQmFwSUpzWXcw?=
 =?utf-8?B?YWhVbTd2ZXRYQlp0ckd4YW13M1pzNC8yUExEK2lhRHhkNFNGYk5PcVlNcGw5?=
 =?utf-8?B?RmNmZm53elNsaStqZVhBbU9ncHlIRTE0K2lqQkNUS3lnTjV4UjFQdEFtVnNp?=
 =?utf-8?B?VXNvdUdvV2wrNFdGOEQ4d1F3SXZmWVg3Q0RqNmwvVnVVMEN3RFJGV05Pajh0?=
 =?utf-8?B?dFB0WFl0akJUbllXWjAvMjJjZEtaMDVWZ25zK0t5MFE2MEdqWnZZbHlRL3pE?=
 =?utf-8?B?Z2NrRS9OZHhCdFVxaWM5bjZGUjBad2hmTVRWTmhnTWl0L21tcUlnc2FVUjA5?=
 =?utf-8?B?K1l0REdqZ0pmSWc1cEE1Rnd1L2g1WXZWK3lxbS9UenhlWjhyNk54aTdueW9y?=
 =?utf-8?B?enBDWTBmMGR3alZMYmx5S2NRMlVsOVh5ZEJGRFNUOUJaN2U0eUJDZDh5cTJH?=
 =?utf-8?B?NzR2OFNKUWZrdlFVRGczemd2ck43SW9KeTNtUlY4MlRKdVhaSVFXaTZ0bk1a?=
 =?utf-8?B?aVZKQWtSQlJmb3p4UTgxdkt0N0tubDlYK3c2dC9lWXhwY0VteXNtNVRrS2Yr?=
 =?utf-8?B?dkQ3SmJQY3U5VVpXUThEZXY5Q1VnZmtYWXRnOEtrNkRQVlVhRDczWi9GTXVL?=
 =?utf-8?B?SmM3c2FYWUhva0pMaHhCQ1ZTZ2JDWjhjWFR1WG9IZnVORWdVbDRUMVp5eFNm?=
 =?utf-8?B?dHJBbmJZdXJoMHQyWFFyNDVLVHlVZy9SNDRoRVpvRTFhbmNXRG1jQ2kzend5?=
 =?utf-8?B?dDVyMUFiYmd5S1hxMGVxc1QvZWdaY2hLSVhsdm8zRnlJTTFiSHRxQ29ldTJG?=
 =?utf-8?B?Q3YwRzFhUEozRkdkejFNYXVnenJQdFBIenVSczVCUXprUnhsem82V1FiOHVF?=
 =?utf-8?B?eEhZMFdOVFhWSTVRYkk4UExpZzJoV2ZWYnJKVWZnYnhaZFdCU05IYXgxQlY4?=
 =?utf-8?B?UTVrdzJWY21ncW5vRWhQTGdYYkhLaEhyL0c5amhJSktSZkJEaUh6ZUVFZGNs?=
 =?utf-8?B?SExPODRGdjFJbk9RVWZCZXQyNyszeHQ2cUw0b1RZczAwcVAxNVU4dmdvNnJp?=
 =?utf-8?B?czBBVlpPWEx0dDlTUXBwN3Y2YUdYVkoxSmV3VnhsOW9QR1p4OTMrMzJBRExR?=
 =?utf-8?B?TWpkU2ljZllQdURqdS9nUGZubnRSYW9XdmJDMmZBdlNrQU4yaTVzeXliYkky?=
 =?utf-8?B?VUxwbmRqekdDLzhkWE54M3lrMDBrRENnOUVCdyswR2luckdTNlJIVm9HNUhn?=
 =?utf-8?B?UmJqOGxXbURLY0x4THo3alNyODlQenpESUhQRFZORllHM24yU2tPUTNmV1l3?=
 =?utf-8?B?aFdPQWZGWUl0c3lFN3ZZV2FjYXMyM3c0MGk2R25FMDJ2djR6Q1BhZUVjYng3?=
 =?utf-8?B?Q1pMMmZaMGZsRXlBS01MWFR0OVdjSjkyR3ZsWDhJS1grM1gvRE5haFVmY2dy?=
 =?utf-8?B?Ly96ZFJsVnpDVTYxRFczMUZVVHhvY0RmVktteVk5ZStlYVo4TUxrVElyY21t?=
 =?utf-8?B?Z3NPM2dPSGVLZ2tTZXFJTk95eW9kNXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1M3Tmdyc3BuMFlTZ0I4RGZDVWxDd1VHRjZlSHFqa2xzaWRmMExNaXFNdWhJ?=
 =?utf-8?B?ZlVRNkh4RE1FVlFSdjU0RFhna2FtQUZJbWFWTkdlS2JMZ0U0RktNbmlzUTYw?=
 =?utf-8?B?Tm1jTUtCOVlNbDJZQWJXOW9QTmVJaGVGWGtzM01XMUx2bzdZSjkrUkdKWURo?=
 =?utf-8?B?dmZKNFd2VUZZcXBNSXRnZEh3ZHRGS3N6enlpSWRaelJoQjY1b3cyWU9rYVpj?=
 =?utf-8?B?UEpNL0pMT0FjTHRtMDhzK0wzMGpzNW15UjBObVg5ZzQyREVWRkNKbytiYVY0?=
 =?utf-8?B?SE1jZ3o2QTNlM2M0KytQK0xtZGptY05HMHJDZHA3Nkd5MG90SVcrcjM3ZkpR?=
 =?utf-8?B?VEV4Nkd6ajVobUNONDVIdmVvc1NkcXloT0kxTnNTOStESWk2cDB1QTd1SlA1?=
 =?utf-8?B?K0Z3T0JKUDBlN3BLTkIwdlA4SlFsTC9TUlZTaFRkald3RGhzRnBlcTNhVEJJ?=
 =?utf-8?B?V1RrNlgrQ1BvOWVRMUVQOXhTMU5FZThieTlTdkw3S2I0ZWsyVUpsRno0Zkpl?=
 =?utf-8?B?OEZOK2dnT1cxcE1RRms4Wm5nQWdtZHdQNCtBVTN1OUt6Y2UyNUxrclBhY1g2?=
 =?utf-8?B?ZnFqNmd1cHQzdHNUdit6UEp5UmdqWWk0bVR3d01LTGNlTVVmUlNZOFU3ZTg3?=
 =?utf-8?B?aXp4bmRQQy9vR1JmdWRLSkx2TWhlN09pYjFiM2lQNUFYTktnbEUrckRIaURq?=
 =?utf-8?B?ak1iQUNHS0VCMEJQVUlRRWZQT1FSL2JDR29PQ0RCZllBQlZ3ZHRJZmZNVDRo?=
 =?utf-8?B?NHV5bFA5K1hKNXVLajk1SXo4VkVydWNHTnVSVDg3YVFQT0hsNVdjc0pBaXRu?=
 =?utf-8?B?RUlxNGZuTzFGd0FCU09WVENMaWdpTmIzenEySG5iYzNzd0t5NUhqeXRLK244?=
 =?utf-8?B?ZFRsK29VNTVMMGwrbDNBcUp6QVV5LzJhZk1rQlZDdGNsZEh4cEhYK3d5eUZN?=
 =?utf-8?B?b0JndkI2MlQvd0VjendkdFdFK1VCeHpyOEMrZGpFbW02K1gyVjRuYXAvNExP?=
 =?utf-8?B?QmNQRjVNZDAweHFnMTNqQWtSS01ISVh3SmlaKzcyVFJzSzlwNkFUa25Ubk5v?=
 =?utf-8?B?TkkvNkg4Z212akNFREt1R2ZuYVhkMEpYOGRtK2YrVHovNEI2UnpIR3ViY3pL?=
 =?utf-8?B?eHpwV1A5TmYvdlR0eW51U0FCRXhncHh6QklRdW5TQmZOV3dZM1ArbVVEam5Q?=
 =?utf-8?B?ajR5Qy9EKzVDcjFESVR1d0loSEc2ZzVCRU1JcVIrTE5ZWW5Pa2RQTW9zTVhJ?=
 =?utf-8?B?NWdiWnU1SHBoWmRGSjcrcnlBVU5OVzllUFllSEdwMmVoV2Q0N0Rna0hLdHcx?=
 =?utf-8?B?bXlvQnpQelYwblkyeWtHaVIxVnZHTHR1WHhWVnFlRG02c3laOHBZSFFPVUQ1?=
 =?utf-8?B?RkJxSi93WDQyM05tbGtqc3BFV0lsNGk4RDFscE55TjFxZkhTbS9kOC8xMnNX?=
 =?utf-8?B?OTlBdEZxODkzWGl2b2FSb3pwWW1aL1AyTW5ZWG81Y0tnMGViR1VreDBzK0s5?=
 =?utf-8?B?ZC8wNWhGejlRUVI1U0p2RzlZZHFQOU01T1gvM1N2Sm5rODg0WXA3ZkxoQ3J4?=
 =?utf-8?B?Um5MdU83QTNjRDEyZDI4SEJiN1pkenpuQ05KbEVSZWVQZnd6NUUyU3gydGd2?=
 =?utf-8?B?bTlHcHZ4WVdjVUVvWHh4ODBRVzcxcjVwd1A5eG1nc20xc2ZmR2VFZXZjOVQ5?=
 =?utf-8?B?RHQ4K1VVRmx3YWgzelVZLzlJTkFoWHZKbk5PeDBLYURBNEIyRTUxanBqNjF5?=
 =?utf-8?B?aDJ0dmthU0tRNFhGbUc0cHZtakFXR2F2UmdQTENTeHMzMzhTVUdCWW5ORGp4?=
 =?utf-8?B?VzJRa2VDL2pjS0JHZ0xnUGJwN0VEbDJpcVU1V003WVJCV1B1a2J3cFFFTkxB?=
 =?utf-8?B?bEI0UVh6cGZ1Tm84SzRvNGx4cmdYQU1oZGpvdXRIZU8yeG5ZR2F6b2d3VXps?=
 =?utf-8?B?Qjhmc3BOcHR3TStVeFBvb3FGa1I2cWZrVmtKaGpFV3VpVFpqTlRLSEZPQU84?=
 =?utf-8?B?NHM4Q0RxQmJiZEtuTHNScFA4bEgvcisrUFVkeW5WT1RoMnRPcktwMVltVkpY?=
 =?utf-8?B?VCt2bWVoQkd4S3VhcFR1a2FBT0NueDZrQTVpVStLRWt6QW9VeWFzZ3RpT0JW?=
 =?utf-8?B?L2VtbzlEd3VwNEZnMmFuUHAwbTRGRVk4VHpBVDhqSTJ4dk5randHUTlzUDhE?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3f0eca-679c-431d-ad0c-08dc6dbb7374
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:58:24.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MevZoSqMhpZIcikzoEta4+xrJIYf3Tdf5OZZVMSeK8rIoX30q2SDPD/uhdqN3RfhpMg/3OqV3kZTKU6+FTyv565GydZe3qgE443CvezTFQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 10:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15828



On 5/3/24 6:54 PM, Jan Kiszka wrote:
> On 03.05.24 16:53, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes the issue that wic arguments --size and --fixed-size
>> are not correctly interpreted.
>>
>> This fixes issue #104.
>>
>> [1]: https://github.com/ilbers/isar/blob/26e9653eb5e096e8b367ebd73054b2fd2310e9bc/scripts/lib/wic/partition.py#L104
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> I tested it with qemu-amd64 and qemu-arm64
>> Changes v2:
>>   - replace size calculation with part.prepare_rootfs_msdos
>>
>>   .../wic/plugins/source/efibootguard-boot.py   | 37 +++++--------------
>>   .../wic/plugins/source/efibootguard-efi.py    | 30 +--------------
>>   2 files changed, 11 insertions(+), 56 deletions(-)
>>
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index 4e3aefb..1101f38 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -136,40 +136,21 @@ class EfibootguardBootPlugin(SourcePlugin):
>>                   msger.error("file %s not found in directory %s",
>>                               boot_file, kernel_dir)
>>                   exit(1)
>> -        cls._create_img(part_rootfs_dir, part, cr_workdir)
>> +        cls._create_img(part_rootfs_dir, part, cr_workdir,
>> +                        native_sysroot, oe_builddir)
>>   
>>       @classmethod
>> -    def _create_img(cls, part_rootfs_dir, part, cr_workdir):
>> -            # Write label as utf-16le to EFILABEL file
>> +    def _create_img(cls, part_rootfs_dir, part, cr_workdir,
>> +                    native_sysroot, oe_builddir):
>> +        # Write label as utf-16le to EFILABEL file
>>           with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
>>               filedescriptor.write(part.label.upper().encode("utf-16le"))
>>   
>> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>> -        blocks = int(exec_cmd(du_cmd).split()[0])
>> -
>> -        extra_blocks = part.get_extra_block_count(blocks)
>> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
>> -            extra_blocks = BOOTDD_EXTRA_SPACE
>> -
>> -        blocks += extra_blocks
>> -        blocks = blocks + (16 - (blocks % 16))
>> -
>> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
>> -                    extra_blocks, part.mountpoint, blocks)
>> -
>> -        # dosfs image, created by mkdosfs
>>           bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>> -
>> -        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
>> -            (part.label.upper(), bootimg, blocks, part.fsuuid)
>> -        exec_cmd(dosfs_cmd)
>> -
>> -        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
>> -        exec_cmd(mcopy_cmd, True)
>> -
>> -        chmod_cmd = "chmod 644 %s" % bootimg
>> -        exec_cmd(chmod_cmd)
>> -
>> +        # create a fat16 partition with a sector size of 512
>> +        part.mkfs_extraopts += '-S 512 -F 16'

I think we need to add a check if the extra option '-S * and -F *' are set.
Quirin

>> +        part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
>> +                                  part_rootfs_dir, native_sysroot, None)
>>           du_cmd = "du -Lbks %s" % bootimg
>>           bootimg_size = int(exec_cmd(du_cmd).split()[0])
>>   
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> index e82e990..48f7523 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> @@ -100,35 +100,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>                                                  name)
>>           exec_cmd(cp_to_deploy_cmd, True)
>>   
>> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>> -        blocks = int(exec_cmd(du_cmd).split()[0])
>> -
>> -        extra_blocks = part.get_extra_block_count(blocks)
>> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
>> -            extra_blocks = BOOTDD_EXTRA_SPACE
>> -        blocks += extra_blocks
>> -        blocks = blocks + (16 - (blocks % 16))
>> -
>> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
>> -                    extra_blocks, part.mountpoint, blocks)
>> -
>> -        # dosfs image, created by mkdosfs
>>           efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>> -
>> -        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
>> -            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
>> -        exec_cmd(dosfs_cmd)
>> -
>> -        # mtools for buster have problems with resursive mcopy.
>> -        # Therefore, create the target dir via mmd first.
>> -        mmd_cmd = "mmd -i %s ::/EFI ::/EFI/BOOT" % (efi_part_image)
>> -        exec_cmd(mmd_cmd, True)
>> -        mcopy_cmd = "mcopy -v -i %s -s %s/EFI/BOOT/* ::/EFI/BOOT" % \
>> -            (efi_part_image, part_rootfs_dir)
>> -        exec_cmd(mcopy_cmd, True)
>> -
>> -        chmod_cmd = "chmod 644 %s" % efi_part_image
>> -        exec_cmd(chmod_cmd)
>> +        part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
>> +                                  part_rootfs_dir, native_sysroot, None)
>>   
>>           du_cmd = "du -Lbks %s" % efi_part_image
>>           efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
> 
> Nice consolidation! I'll wait a bit for feedback on the original issue,
> then merge it.
> 
> Jan
> 

