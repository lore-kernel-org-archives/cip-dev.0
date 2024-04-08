Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D823C67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 07:02:40 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.125])
 by mx.groups.io with SMTP id smtpd.web10.100444.1712559749928433781
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 00:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jbf6K0WY;
 spf=pass (domain: siemens.com, ip: 40.107.6.125, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8IYjdPtfLT3Dun8NRUEawF7zTBXD0ErR3kFP8s/TiGU/+IjCihOlFdkqfbc1607AeaiE0v3EW1iTe8ruAyfzlnczb5WbSWhkSy/DCX+ilbZbxXe5eAd+5Rd8Kized0G3hnxm9mG8+SCkN1JHTfyuG5ufsykcFmWeV0M5VWiW6IxI37OmmRpqZnCRsflESBvVnLmEmDDLQ8iKsW1LU/54DIkOj9adKKwF1dlNAUCLxt1AcYBC0E412SNcIDlx65OuG4DDj4QQSTDfcYCG9duLq4FdUvm/Mqgwl2IxCIQ377OKKDd1iYAXagpfQuTyFNKjS8Mer8EMx65w7DUCiRhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G8OzCcCSnz8Gd2TSjWmdvIZiGK+zuYGtVSCWbPWefs=;
 b=BY5BholcCGeXfrhw3Wuz8z796Eg34zkQ/VuyQ+zzWKDzR9u/1NVpyQqbpFkYue8NlXJIkTd/GSv9xZ/CqeXsnmJmg7D1Xw9M89N5q6P2J83j0JDe0FHqGr5qE3JYkizi0c/Tctlslin6K3p/CSUu1hTHkkcVp/Y4kqu+DS1UGyUl6foMW4MAUSzLjyH3oUMUZFy9JNyMyVyoAWu6yEHvc72QAjMTWwE7APBkm6ynFkmXkRxlUmunuCN0Y2/WvWnitqwmpLHR6HPj0/cTtWFJ3QEHvnffNTQiA8bu2lsEcLEK+b1Y/cG3merMkYbg9bg2BDPFagNY+Aksmy8xsNaGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G8OzCcCSnz8Gd2TSjWmdvIZiGK+zuYGtVSCWbPWefs=;
 b=jbf6K0WYmYiTosjANxqiNohtjKBdZPUxo8JFBK31Xrz737wYkUXaakQ+zHah9lOmVMNryb6rRUiky26TVc6ncrhYMY9XUB0sQl77CRjUZA/BvzAQvSoP1OgLsjX1xLkuccw4IQgvE63hi2snvOUc3lIp7kiHUrQ2zvwVY8uRDG1FRs4f0Y+5QaOb8dZBzqU7HZuWsGcaCtj+1Yx3aH9u2JTdgkJkeFR5Y9wAHoYIdXFBjTUkb6jxhN9ObRZdnDgc4otcIewqOjyfg6gxm7BFEMurwoUGaB3O+tO+L9V5Rzh9tzwudmb1clL8AV1Z3k+Dpqn8mQovmQX9odrEr+JYAw==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB4PR10MB7040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 07:02:26 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:02:26 +0000
Message-ID: <c98dffde-715e-4542-8277-8313ffff7dd8@siemens.com>
Date: Mon, 8 Apr 2024 09:02:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] Revert "kas/opt/reproducible.yml: Move
 SOURCE_DATE_EPOCH to layer.conf"
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, venkata.pyla@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20240405064757.378647-1-felix.moessbauer@siemens.com>
 <9125cc93-e91e-4b98-ac76-dd5364dbf275@siemens.com>
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
In-Reply-To: <9125cc93-e91e-4b98-ac76-dd5364dbf275@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB4PR10MB7040:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	57ygtOs/8azepevWxDBJ182DZaGHNvVn2YQe/QIygg+AzTQWslaki2CV7lIfckVaGa/jfrwCAFlnj+j2AeP5m1NUR7QO9Sxov1hloDVq/volkCszBY8+ZgX9fUgi8HWM0tYdjSwWWo9bWguwyf9GV4iQrf2cEQTWNZChe86c0KFJx+HKMT5lzS6ZlR2vocPisOUT8m0dYaGK0SskvLzdklnp/3GbPaP7qy9a++9AuV58OfaXxT9I9Zzo/2W2j1O1TVjZiva6Px4Mac0xHhYsqUic2iU9erg3QZkl6y+5nlrHbWdYzqo36MX6JaffwBXuxySYa2arKidPyA7+eFeY2LDT3D9EXZaqsx9vU8eADTI7Yop44NtoN47Aj5hFpUWh9rojW2GBCfSwfvS1MYSRx5cL6NTQBDoxBfd+U55WsCgph4CbTocqmTLfv/9fICwPlLHpnnQAH/nu23auNGNAZd69kDgGTqowXntT879DAUoDsjaqZG77eyYrKOXu+HaRPUz74B8s9ZFwDEtCZorDnYQE8m8f5E9apm/SIkNpkIqSOJlmsq6seVupsGuifsFczF9P81F4kjwq5ssOd3MsAXKncAivKR0TsTvxb0aWXvDmh4p2rMb6OE6w+juC4pnqpbzKvobh3bQwqBwksrVW635jB5KaUyXItJEhsQVWLTA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWpodzJna1ZNRmpLZDFTeEpmRVZyVmRiU29RQWthYm9ld01BYmFFa2VzR3JV?=
 =?utf-8?B?aEdueTl6S0o4MkF5cnRtV3BCYUIrYVhCWDdMK091UmcyQ0VETWladlRZRWFV?=
 =?utf-8?B?MjlOSVpJaGkwM2J1NWpRdVVWNHhIaUJscTIvUjZzUTRrL0VCMWUwSHlwN2dX?=
 =?utf-8?B?c244MDFQUFN6bFNGd0ZoT01kN1VZeHhncEZPL1dtQk9sQnRLV3FndmlBbWt5?=
 =?utf-8?B?MUF4Y2s5NWE4cmdXcEg0YU1uVk44YS91Z2JPM2pQL2c4ZmxIQ3VUL21LcWhr?=
 =?utf-8?B?emZ3VzVjejM1dU1xZVd0VEpTZjlTb2h4Z0xlaEM5WWl4dU42RzJXNmpXWTdj?=
 =?utf-8?B?Zy85SmZETThrSGd3ZzZnQVBxMVRtYmwwNk5kYzRtR3dzVkVKUE5oK0ZFNWxv?=
 =?utf-8?B?V3NxanZaYmkwb2NWVWV6cUtEQWxpZDc2dGV1YUFyTm1QOTZoSmZUQnNTR2Y4?=
 =?utf-8?B?dStRWUxJN2ZHOEFJM2RWdWtDeWNDbWp4QXpKZVRZNXN6VENCdkNIb24zK3ZO?=
 =?utf-8?B?VUlCZDFjY2Z5Ri8rQkpZUFQvM2QvSlJzcWFDUmhTZTZWUVpxUi9kTzdPRzhU?=
 =?utf-8?B?RWxxYzd3WTR6VmNCZzlCR09lUlg0RHo1eHlpdFV5SVF4WUhlMXcvT09oNENa?=
 =?utf-8?B?dnZkcE9tUHFaVlZ5V0k5YjFQOXpnMmNtZlhlNGdPaUhmMGFUYUpxQXhmK1lt?=
 =?utf-8?B?Uk83WmduTE5vZDBXK2F3RXlQOVNIa0lCZkhsVXBWRXJYSmxFa1Y2WFVGNU5y?=
 =?utf-8?B?V2Rsbk1yLy92TDhHajRhYzg3VUZadHFvYVBneUVISmM4UklueHJuQ2RZOW5Z?=
 =?utf-8?B?M043ZXBWRzRrQmk5MW5lblVUUEJNQktjZ29hRDJXdUxlUkVDOFY2M3lzbXBY?=
 =?utf-8?B?SzhKWjlVMWhvcSs3ak5EY0FvdllWVVA4WFZKM3hyb0FYMEp3KytXSE9FNGNy?=
 =?utf-8?B?YjV1QlRHYk5sY2pzOXZQYXo3bjJNTGlINkdGbVFTRUg5UkIrZGg4N2dQL0JI?=
 =?utf-8?B?VE5kd3BaS0ZRRjI0ZXVKVFVmOWQ2UXVHYno0RjlxQWVENUpUQXdTeWMxWDhv?=
 =?utf-8?B?ZGFENTdVQ3grNWg3NStDQ2hrRWpvVDVuNlJTa1ZvUUpIY1ZUNHpxOUNKQ3Z1?=
 =?utf-8?B?eUtzOWRDdGlQTmxpRnoyWjNiYWllTWtKd0piWkhqQlBBZW1wQ1pveWEveEtj?=
 =?utf-8?B?QWFNcXJiam9KakNVZko0RW02T0wxSUIvRTFCOWxLSktVSWhCNHVrWEp4dUcz?=
 =?utf-8?B?SkFsK1cwcXFyT25KTjlJRm9kdnZFUUVXa2dPazV3MUcwZXF2NGpEOVVxT2Iw?=
 =?utf-8?B?cW4wSkpxQWVKc3Q2bDJRK0tKUXVoS0puZWFNNE52N01FTzhaQ0xxUjBGbXdJ?=
 =?utf-8?B?NWxLd2xwWHB4M21neFNSWVRybHNFdm5yK1RicmlhWUlFV25qdSs2VzNRckpp?=
 =?utf-8?B?M1V2V0NuSU5meG8rZkZZMFExZUdjWm44U3Z4OE42N2pGMll4NGNmR0FvZVhD?=
 =?utf-8?B?QjJrWEc0THVkYnh1Ykp2UEJtdkZVV25rTGkzMkFYY0dSSnVBNUQ0L2VxY2tX?=
 =?utf-8?B?ckg2R0NUbFRzc2VaWGZqYlpLZGVibkl4ZTVJQXhvbUp5cHFTelhoMHQxOFc3?=
 =?utf-8?B?L2J4UVQ1cmdpTzhHTTIxSHZwY0Zqa01xaEduNnJZcFhtMEVwTWpsV1NPalNo?=
 =?utf-8?B?a20xK3Nla0JXTkpvM05NS1l1UWVyUEw4ZllKQ1RqQyt1blNFbDBLa0xYREVO?=
 =?utf-8?B?TkVJWXJVRCs1MUpOR0NQdDdrM1htYTNXUVFtM2wzR0JzNmxvY1FOSjJ0ckpO?=
 =?utf-8?B?VENES3BzWnVNcUdEQmorUTJ2TU4xN2o4Y1FxSVA0TlZsSy9YMlBTeU5MeGYz?=
 =?utf-8?B?a1lBYlYvRjlwUTN1OHBZSUlJdHlSV3hYWm1MMThTbnVnbVNWNG9IWkdJazdC?=
 =?utf-8?B?cmlVR2hXSDR1Zzk5NnVUNC9ib2s5eG94YTZHdWRxZEFaRi9ibUNDNEFnUmxh?=
 =?utf-8?B?T3NaWjdaT00vT3pxUnR0T01ZNmRnYnNOYytldG5qSWR2ZzlydWJleVNKcnJK?=
 =?utf-8?B?cEZ3dEdBWmxHRk8rN053aGVrbzNYZFl5UVh3ZHNoU0VBMVZkSUFUd0NSSDZI?=
 =?utf-8?B?WVJpaFFTczZBWUc3M2NjZ0JQU3lyK3d4VlNjWUNQUEFHM29Scm02TWJ1TGJj?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f15349-fc20-45d7-ff8d-08dc5799d914
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:02:26.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2MyS/QWgYtQinAlWbqo8pQ2e9GwLz9Duud6If14Ig3d4dcoO3oi88YPFWWUjjPtC3JWdZ0YKFt+8C2eqKbKtyYjJgSQ2T3aSmLVktim9Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7040
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 07:02:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15496



On 4/5/24 7:48 PM, Jan Kiszka wrote:
> On 05.04.24 08:47, Felix Moessbauer wrote:
>> This change is too invasive. The layer.conf is read after the local
>> conf. By that, there is no way for a downstream user to set it to a
>> different value.
>>
>> This reverts commit fcdbec9d2ab1daebd19e021c2b90ed30d0eeae00.
>>
>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> ---
>>   conf/layer.conf          | 2 --
>>   kas/opt/reproducible.yml | 1 +
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/conf/layer.conf b/conf/layer.conf
>> index 82b4084..2c888b2 100644
>> --- a/conf/layer.conf
>> +++ b/conf/layer.conf
>> @@ -24,5 +24,3 @@ LAYERDIR_cip-core = "${LAYERDIR}"
>>   LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>>   
>>   IMAGE_CLASSES += "squashfs verity swupdate"
>> -
>> -SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
>> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
>> index bc71f28..5d6a896 100644
>> --- a/kas/opt/reproducible.yml
>> +++ b/kas/opt/reproducible.yml
>> @@ -13,4 +13,5 @@ header:
>>   
>>   local_conf_header:
>>     reproducible-builds: |
>> +    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
>>       WIC_DEPLOY_PARTITIONS = "1"
> 
> Let's fix the issue, rather than rolling back to conditional
> reproducibility. You could move the SOURCE_DATE_EPOCH assignment to
> kas-cip.yml, e.g.


Also since we had multiple issues with variables in layer.conf we should 
maybe we should not let layer conf set any build related variables.
E.g. IMAGE_CLASSES

Quirin
> 
> Jan
> 

