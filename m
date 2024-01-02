Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F5EC46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 13:28:57 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web10.28674.1704202128577622362
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 05:28:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A+RLTJbd;
 spf=pass (domain: siemens.com, ip: 40.107.20.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTKwvPa5I+FhsbmPG4hKlu2CYE+QqZ4gcpjoHkrKhrh9WNmZCyocgCZEDzI/LTjS/Le4ED4YxLjNMgqJA5KpHuW6LLc9Wfz7FnJZ10W12qdYbdW56JN6uHcPJb0DOrhV1Lgj7OZRtpdIIXS+L3L7KNni2vVapD/R5IdKUmzgTdq4cB9lVD2+R71rrCbodnmXwYiCDSNHwrOWkxs+je3eTvSaNZxMo9XBZdsgEyxIkqr1wVGhiWd4WpJCdoKJ8UO0UCtNaogTDEx6B1a+nQKxGQ/RKfc1900dKoIbuFhNv3zhrE7XB4B+e+caZtYljnCvxzpUDkcWO+JuWa1+xLcWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePiz8lMVrYG3cdcOkVEoHUdZa/kvi87Agc0ow23GOb8=;
 b=FUo/DHzpMDLbod78YwIgpr6rPYZWVl+RGuXqIiiAYi9O/refiMOPovKTQm4Z3GXSHCJPHGZUxKCi5WzlWvrsrYhWvxfjOLzOJtEtJem/m1VNYliKP/N9YHohq/JmVIAF5z6AVMhf0xJ5UqeMWNjM9NH8a21SAJzefJTVSUiYYzBCVnnHtsuOJ4sYsDyZCXaKDdnSgarRVV6vrVjULKFmrDw0JwzYB9mN+WeL1aOIQQUiBDQ5tPnyppZazi5ulJxvuN4YYEHIrYBokiM2iYX0i3Afh2Vx0FQMnG9EIJtoTtw42pWI7L/8XyjLO4NbbzJ1rJgvRU8JSeKLsl5mpNOidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePiz8lMVrYG3cdcOkVEoHUdZa/kvi87Agc0ow23GOb8=;
 b=A+RLTJbdZ3d1eTHOfiwiDA4OjlW7xUwsgeUVSw9g2dOxZQ3yo5ZHgWFwRoMSG3/6a3v/RlVYzgigGsRBItFAXxt5QLhZnhpYAttpvu79kPkQXZGktylCVtsS44kpnI8+OViMSpjQRFg/kXGuATaTt2sOu7C0nZAWXxDrN2aGt6wPo3QumJk2KZwOXPSggYSfb9aXlnj/pWhbxc89M0l5RjBN+R0u0okY3ajmebtJVQFmjPKC95NagsSvaxMkAPIGPsWEndVOU9QugCToWOzJ2ip3cRb4Nk69ehtH54C9aftdbRPRAUndC6BJC6rU9jBE50+e+AI438uJkaFjhqG9Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM9PR10MB4038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 13:28:45 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 13:28:45 +0000
Message-ID: <88e73f15-c341-4201-87b6-43da20511b5e@siemens.com>
Date: Tue, 2 Jan 2024 14:28:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v3 5/5] images/swupdate.inc: Add
 variables to generate the sw-description
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
 <20231229123111.400555-6-Quirin.Gylstorff@siemens.com>
 <9884aab9-22d5-436e-9606-9b8fbc550471@siemens.com>
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
In-Reply-To: <9884aab9-22d5-436e-9606-9b8fbc550471@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM9PR10MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: c797ff89-b25d-47be-ee35-08dc0b96beaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GvlJeJpbWT1K29wUHUEQPvLUsBY03Bst+ZDTI7R72WOKWXaFpWzfgV/lKW2x0PhiolcwHhDwPRGx507wmXcpMvD2soFx7hx81uC/Q96SHCYLwFCeeNT7NNbUZ20uwxjT0mcKIRMeppb2jEGJ5xcu7iBpFZD24Mb5OE23tIyO5vZlJOPyPXeMdmCnaOHIUeocKFimP1P+GcgsXEhNTDedpyvDwwlYouclkBkrdGYoFnwls6q0TrSGSVHt6VB28nUtpOsQprr3K13aPpUnyMezcMqTeLYTSqwpl0P6OlYKxXKHhKmRWQ3X2982GlYSNeEczqxwLN7Ektm0FRNJ5AlcegxI2Vc6BRkPtIS/1Jtpa5bniEQz8EGX6r71RBXHy1CCKFZu38L5JWndjC16Q10ux8XThu1QWbHNaQde3TtMSC9hqTmLNAOK23Irl2h5eVczp65Rs6jD5UXnc1to5Oi2HqCDk2IBtiKhyJBkJoL+ApC3qnLpbNlwfUOwt8W3SsD2Rmj1rJdKYOQIM3OyIFIaiBM0MqwAjOpMLZYKWr+RV5/zb2Vgf1Kt1GqIn9hAxsjfyXyFxsuiN0wFHxUoXD5m/1Fzc+i9b09r4PbTOlkeBPk/b2MrTdceHNJ5kAI47QI0NHh84CpJRik4Gewm/w38+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(316002)(6486002)(8936002)(8676002)(66476007)(66556008)(66946007)(83380400001)(53546011)(6666004)(6506007)(6512007)(2616005)(26005)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnE2SDR3Y204dmI4UVV1RmMrREJKemptNFdkTjhIV2tlaEJ0dG8xd0VDTkZX?=
 =?utf-8?B?UXY1TjZIaUdoZ0FEeWJHaGsvUDFBVktKMTlHSHpxbWdQdi9tc1BDaWtmdXN5?=
 =?utf-8?B?VEh0MEw4aFl4dzBRMGgxdU12c1JKOTJSK0NybllLbU5YdHFVYUg2MUNPcHNM?=
 =?utf-8?B?S093WS9Md3UxZmJmUStDOTJ6emtRZDhYamR0cmljc3V5Z1ovV0ZWUit5UDVJ?=
 =?utf-8?B?cVpiemdQNnJKYzdoUHZSVmFTcTl1OEdhYXRrZFRZUUo4ZllWcC9JTzc1UzRx?=
 =?utf-8?B?UmZ0eG14Wkl0UVk4ZXF2OGt1ajNzbkRiMzJvVlkvL01KVFdjUUg0ZmhUM2xG?=
 =?utf-8?B?empYY01wV3l6ZW5TOHBodjJHZ1c4TllmNTYzNUJTQlFHNHFXRmdZdFA3T3Vs?=
 =?utf-8?B?UGl5WVFuam4wUHBrTWp6ZVBJWVlsakcwMk1CcTRIQlV5WlJXaFV2VmgwY2dS?=
 =?utf-8?B?K3FZSjFmbHpKZGhQZC9kVE5EQkhQbi8vTHg3dWZvam15aWM3TnJzVW5uOWFz?=
 =?utf-8?B?YVN2ZU5WWnFRYnlNNkdVcUVkVUZzWjFST0hCQmxCWkREek1kZWlIRVIxVTBG?=
 =?utf-8?B?SUM5ekZibXF5WXNPL1pqL2VlUkMyNi8zNDVxYjNUblhtbFMwYXk2blh1alpN?=
 =?utf-8?B?anJ0dE1ycGx5T0pGaG1wa0xpWmthRE1jOGZ3ZXgyYmU5M2FPUjY5eTZHZno5?=
 =?utf-8?B?TzZacFpQY1M4Rnh0c0kxRlcyNzIxT3QrL044KzltNUgvZ2tmRmFvZHIzZ3dl?=
 =?utf-8?B?UjlDRnVsRUNOVSs1dUt6NkVnRjJkNFI4aUdyMnVBK2NiYlFUTS9laDNlMzA4?=
 =?utf-8?B?dEhNd1dSOXgzOW1NcXBEMHl6aGZFb2dmRy96eFNtR0w4RmdSUEFYVDJQUXNZ?=
 =?utf-8?B?OVMxNFI3VWlRcjlsaE1UOFl2Y05Cc29VYXc1dXY3QVorbUNhWDFtbStJUFJa?=
 =?utf-8?B?a0VwZVdTenYrU1B3b04zSnBDWWl5NmkvbWRmL1FoUUhsdHZLbkJ0ME1pVmhY?=
 =?utf-8?B?eEJqNUxnZXBzZjQzUmlMU1AxVjBLeWxyUlVjYlkvREkxbTJwUVRyeFI2Wm1k?=
 =?utf-8?B?UUVZZ0lMSWwxYUE2NzBIdW1IcFdOc3p5UUlYbUN3NmdtNVlLcFZoVGxDSThI?=
 =?utf-8?B?RnVMaVF4TzlzMjR4K1JHTTFGdW0yRTFYUE43cVM4ZHdsZ2J2U2RkekJjcW42?=
 =?utf-8?B?OStwczlUZ0hUMW9Yd1VWeVBBalExZ2hsUUIxKzJjSm0zMEpGVDgvUkh2aHUv?=
 =?utf-8?B?TXVuWTdUSSt6UVh1UUI3SmdHUHIzM0lPT0pMcEduaTA5LytQSGpuQ2VSWlF5?=
 =?utf-8?B?Ylk4dUVFUWhVTWhWUVVib1FvaWFkaDM5azBrZ0h6eGlBNDFVc2VubWlPOFZ2?=
 =?utf-8?B?KzNDU3EvZmM2bUtITjBxNmg2YkhKS0FYOTZoUE81UG1kbDA3MklVTElrZncz?=
 =?utf-8?B?TWl0Q2E1RW9HOFdpUjRIZjhYa2IzMzdwMmtydGx6TldNTURMRTM0R3NBOFVv?=
 =?utf-8?B?WmZuUFg2VVJnNjRSeGJhV0o2SUlHNUhpMzg2c3JCd0xlK2ZoejBDMEpqRVhn?=
 =?utf-8?B?Y3ZibWpUa0s1M3ZEYUtua1NxNktOQUZ3NWdubnFKVVBzbURjeHNpMzBGTlVO?=
 =?utf-8?B?WkcwbWRTOHVNdnJjMlJXcWpuVER0d0RtOFlBMzNJTUJ6VlVaUjVhbk8zYjk5?=
 =?utf-8?B?dVRlU2Frd2l3NWhkWXlJcUUxRDVoSDBack5yVXdrWmlvbFJCamgrQU5kUUxO?=
 =?utf-8?B?WUVtM3lTYTFEL0trekMwN2VDTVJVaERJdjJhYThoNm80cW1FU0FmNUx4Rll1?=
 =?utf-8?B?Rm5ZT2VNbVcyQkdUZ1pMbUpPV0ZJVnRkM1JxV2NlaDVJaXlXYXJXNHJiU1Jj?=
 =?utf-8?B?ZTR1QkhUaTA4YlBGZm11M2MwMXNDWU14aTVkeUxJb2N0WC9MQ3hlQ1R2R01k?=
 =?utf-8?B?M2JScDRkZVZreXExRVJYcUZJRU9LcllBY1ZKWGdGYWNxanR4KzdBL0o5SWl4?=
 =?utf-8?B?YnYyRVhNSWkrSitqSjRCRjF1YisrM2pzZzdZUTlnNk1xM3R2aUJ5VjZKMVkz?=
 =?utf-8?B?SEI0YVdzbUZ2UTBXSlFLekN6aWorQjNnWWJqTmlTc1ZvVnYyaFNFUzlTb0RF?=
 =?utf-8?B?N204MDF6ZDkyb0YzWjd2QlRPWEdaU3k2Qlk4WDhsWi96NzJBT3ppOThxYVRi?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c797ff89-b25d-47be-ee35-08dc0b96beaf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 13:28:45.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17OisEW/i/OtRs1rtO0T357p4Xrr5OXMPfykYaWU1EJvXLGvhGfqnpHrbm0xsqy2kmI0DGxb+lm4XA59CNn5RdjosLkOrI61kfHm0I/VCD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4038
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 13:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14229



On 1/2/24 13:40, Jan Kiszka wrote:
> On 29.12.23 13:30, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This done for all distributions except Debian buster.
> 
> Why not buster?

For buster we need to build python3-libconf as it is only available for 
bullseye and later.

Will add something to the commit message of v4.

> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-core/images/swupdate.inc | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 4983f7c..388faad 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -11,6 +11,33 @@
>>   
>>   inherit image_uuid
>>   inherit read-only-rootfs
>> +inherit ${@'' if d.getVar('BASE_DISTRO_CODENAME') == 'buster' else 'sw-description-generator'}
>> +
>> +SWU_IMAGES += "rootfs"
>> +SWU_IMAGE_rootfs[filename] = "${SWU_ROOTFS_PARTITION_NAME}"
>> +SWU_IMAGE_rootfs[device] = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}"
>> +SWU_IMAGE_rootfs[type] = "roundrobin"
>> +SWU_IMAGE_rootfs[compressed] = "zlib"
>> +SWU_IMAGE_rootfs[properties] += "subtype:image"
>> +SWU_IMAGE_rootfs[properties] += "configfilecheck:/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}"
>> +
>> +SWU_FILES += "kernel"
>> +SWU_FILE_kernel[filename] = "linux.efi"
>> +SWU_FILE_kernel[path] = "linux.efi"
>> +SWU_FILE_kernel[type] = "roundrobin"
>> +SWU_FILE_kernel[device] = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1"
>> +SWU_FILE_kernel[filesystem] = "vfat"
>> +SWU_FILE_kernel[properties] = "subtype:kernel"
>> +
>> +EFI_BOOTLOADER_NAME = "${@efi_bootloader_name(d)}"
>> +SWU_ADDITIONAL_FILES += "${@d.getVar('EFI_BOOTLOADER_NAME') if bb.utils.to_boolean(d.getVar('SWU_EBG_UPDATE')) else ''}"
>> +
>> +SWU_FILES += "${@'ebg' if bb.utils.to_boolean(d.getVar('SWU_EBG_UPDATE')) else ''}"
>> +SWU_FILE_ebg[filename] = "${EFI_BOOTLOADER_NAME}"
>> +SWU_FILE_ebg[path] = "EFI/BOOT/${EFI_BOOTLOADER_NAME}"
>> +SWU_FILE_ebg[device] = "${SWU_EFI_BOOT_DEVICE}"
>> +SWU_FILE_ebg[filesystem] = "vfat"
>> +SWU_FILE_kernel[properties] = "atomic-install:true"
>>   
>>   SWU_SIGNED ?= "1"
>>   
> 
> Not yet clear to me what we gain by this approach.

The benefits are:
- we can add easily additional files/images/scripts in downstream projects.
- Also this allows for example to build an update containing only the 
bootloader without addining a seperate template file.
- it simplifies the adding of new 'flags'
- I think it should be is easier to use for downstream as the correct 
syntax of the sw-description is generate.
> 
> Jan
> 
Quirin

