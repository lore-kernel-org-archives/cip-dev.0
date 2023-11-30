Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCAEC4167B
	for <webhook@archiver.kernel.org>; Thu, 30 Nov 2023 13:15:03 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.44])
 by mx.groups.io with SMTP id smtpd.web11.71765.1701350102290178118
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Nov 2023 05:15:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FN8WKceL;
 spf=pass (domain: siemens.com, ip: 40.107.104.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iudh+wHIr1Y1iL9mMp6+6MPXe6WXwwAKyToTH5CeGahHRFkTNpPwX+QeUhBBt6bHeyxATLs/WyU2iAA8SKu1xpkHaqIClE78KAUUDwxN6CEJVsbmklpHdiKIzWz1bQ4Y9rzJfzKqpVUcpskPY2iVdh8ztkVYbTx/dLfW8WHLOX/ohQy0TsHbeKuBlNGT9Oxlulnp3jroPfAhaIIn9W4r/wBBuIObw7GWhY8im90UEG5dq3vLQQTAlPG+CAFIHJOIhe5aEoIg8ibh6yguXxw5pxWHseda2YkjOEuuPWQr/7u0CFTWGHJot8RjTmM7ey9QhBjm9oumwitGJGwX9ztzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMTNPjBKc4opPsGT9QkYxAyhzgkdL1Xj105sQ0Vwd/g=;
 b=b3ifEneep9j1X+79CUwCMEBojTf1MdjLXE0ySfYZG63IhohTRIHWR61K4KrESuRJxbla7byFf3W7j/EkA3JziOX6euUtmQc413YtgIMFHb3YfJHtp1jROW/zE+24Z6WibHcWWqb09UkoBpGe1GjF8sJZQsFmRFyp0w60WVEAxu1JGbzULpOHu2TQWjWvKuFEH/nWvjy1w9S1s95vXWbW07r3OIvhMxM0yPqyBVhScifnkIig362MkTmwNJzr7T+wgWSYMZIPlgf1xoDM6adhxGTmrZyCTJmy05BcTN9nmg7DUXUWbuWJbIlxAiQFGUHJ/hTyRn2zpkvkVwm+8f8V5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMTNPjBKc4opPsGT9QkYxAyhzgkdL1Xj105sQ0Vwd/g=;
 b=FN8WKceLsHz+/9xTJKcLd08bS5BkZYemhivPINgxhzz+rGydhuZsyFPYDG6B8sEk1jP1InlBoW/UlFE8zsQFkWNsQ3xD3W8pz8HKatD+L9uwrHcrSoW+WAWafKGulK0Xx2Xs9FPIlvKaeLNE02gnuP+LBlYy+svUlRoRlFdrKX+Q1QANbW0l1GqbEVMl4hADSnem9xGM4kBeA0EZNn8TofatI4hzutd3mWs1Sis638HRaqyZm/z2nntTypPnYrG4vO8dXdpDKBxzP12kZmXvP8w/QOpBMlPQFr908dsEcn7kHIvS8IbwSk5CR32JNOOPX4r/4wjfXAg+Sfieh0hgCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 13:14:58 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 13:14:58 +0000
Message-ID: <40fe1187-9bfb-48fd-9091-18c86d8519c1@siemens.com>
Date: Thu, 30 Nov 2023 14:14:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate: Move signing to seperate
 script
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 wei.hao@siemens.com, cip-dev@lists.cip-project.org
References: <20231124141326.2661397-1-Quirin.Gylstorff@siemens.com>
 <634fead5-305c-4d67-a09d-8a2e1a228cc7@siemens.com>
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
In-Reply-To: <634fead5-305c-4d67-a09d-8a2e1a228cc7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ead57ff-bfc5-452a-4fb1-08dbf1a65a68
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oneghrj6iReoN61M+nH73OrY3IQioLKXr4hlkBM6JbVRrVjd4+1GFWO149pIfjSWzazTFudbOSs0FyXnuy67EwK4FTcXbZAbx9tb0iVnjo2gDo2wd3KHVIaplNRHZYc6iQfL74NFFKgoR5VA41yYMj+Seyj3izVXmqbuV+8j5EnruqyNWZ4gn/VhGblli7H2i9+iwTHL/2U3egobnew4yUFxUcwvfzMbEeSHzd00ShnXVJVpINbUTUeG4GR8NF92z6cQctnHkqqjg74uQlYrEmsR5EWkoWbdHwkDbxD2SBv6O4IGk0f0FGRiCmUJQBTcpsmtKG30AnHR0F72/z2SedoYImjtKpPSMDWwclgpRT6+K1xEK2vx0t2atRdCiQ4RIqT5Qc1NxP3upsMxQGWlT29gI0gfqF4/R4sPSGiyT7f2qMl/SN7XrQ2nnS1Zy5/orCZXswVKBwgkreIcASkyfZdnGBqOo5Drp7nb1aViReLntnftQ7H2Y5+s4yjiahUr2G0dXPaRXrPR9eW1y1fiI/301ziO+Q4SupccB3JbRiZAuqLxodvQGgrKgiVVrPZkzjELs5Sh0peVPfxlzrH1EvrBIqZH0vcDc+8zvJBOq+FwBGSr7fc7LxrEGkTHT7iW7dNDTTNgMUl8atMum6i+1w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(478600001)(6486002)(26005)(53546011)(6512007)(6506007)(2616005)(82960400001)(38100700002)(36756003)(31696002)(86362001)(41300700001)(66556008)(5660300002)(66946007)(66476007)(2906002)(83380400001)(316002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YnhDUGxIc2NsVm9NS0lsV1ZNQnptWS93Z0FTVWVhK0Uwci9UUTBNSExMM29Q?=
 =?utf-8?B?cjVmcU1BaUM5NzNkbVRoMUs0akkxSk1waXgwQkl6OGcxZHErb2paOTh1WHRJ?=
 =?utf-8?B?aHQ5SUJ5K1oxa2JhdmVKWlk4K215RTJpSlF3R0xqeVRQanFKM25EbEVEaDV3?=
 =?utf-8?B?U0JFekp4UzUzbWw0bCt5VU1qdTJBREZJR3dqQnBIRG5nY2J1SXl2NWlhVmMr?=
 =?utf-8?B?eVd3VnkyYjR2UlZKQkUwLzRvekZzT0ZLRHgzZjJnNVVFdENpUC9veFBHeHgy?=
 =?utf-8?B?bjZuUlprd015YzZHS1NHQzFZRzA1QlpxeWJIeXJCSHNBdHVJZlhpQmtiNVRI?=
 =?utf-8?B?ZGtjZEEwZGVFOHJJcUtVNS9ZWUZHcWJQWDlTeHpHTWI5MTNkVklnUUdub0ZO?=
 =?utf-8?B?ZS8rZEVmb3pTQUx4cTV6QmFSL2VQb0h4VXBpbHBjNkhoYTRWby9sbXFiVHF0?=
 =?utf-8?B?aENmSWlDOGl2QnlDK3JCQ2tSYTh2NFFTdmZMS1VtaVJvZmdlS0ZLN01SNlli?=
 =?utf-8?B?UGt6Y1phQUZhdUVNRTF2MEpvZXIybWdDUHBvY0I0VEhRa1RSQkFNak5NcXJ6?=
 =?utf-8?B?Wnp6Q0p6djJnVnRTUVM1a2NOUjdCL3kreFdjRzcrM0h1YzE2VjA4RGRYeHZz?=
 =?utf-8?B?TnB5RnZzNHI0TGhZc01lUEVsc0E1S0xBQ2tEWTc3TGlBWmF4QkprVWRCczBH?=
 =?utf-8?B?TVU1T0RXcHNxQS81MkVLeFNIMVBVcHo3czdUYmxJZU44d2NVRU9EeCt1eE02?=
 =?utf-8?B?djE0Mis2eDNrUVJPK2gzQXBJaSsxMGVHOElkeVhEbThHL0U0aE5QMTdaaE1C?=
 =?utf-8?B?cHpYWWVVeVFsSE0xZ0w3MEY3cHdDa0o2dnZuZDYrTHZQeEdSS3dVNTlxZHlk?=
 =?utf-8?B?bVZNMS9EWUVQOFdDM2tUa2EwbUNpVTJUN3B6NkNPYURTQWpKRVM5cy9MTE1y?=
 =?utf-8?B?aEJOeHFDTFZUZXV4QTI2ZklVUkFGWUptUnZsT2w2WUxndXBncGx4M1BDMGhk?=
 =?utf-8?B?YlY1MkdHQTlLV2lXQlZYRTdQYW1lMTVBbHlNYXE1WCsreXpIRVdmL3VqSzEw?=
 =?utf-8?B?WGJzNTBrdVRIZllWajVqUmprNE5mV0FZSTJkTWRYejhZK211eGRsNW5QWjBw?=
 =?utf-8?B?eHZ3R213NWFVMWZJUXpzSmMrSU1pRlNEeHllRlRGbzlYY3kvc1VUdEN0RXJj?=
 =?utf-8?B?NXZiNkVsd1FXaEgwTkp1eVNXa3ZQaHNmdkhENWlvZWZraE14LzFLMlgvN0xO?=
 =?utf-8?B?UGJCTFkrRVo4U2NXd3d6NkdaQlpWVXJqdm1yNjZCcVBWMS9lQjRqRW9mZXdl?=
 =?utf-8?B?VkhKRERYRnhBcW9vdDBXdHFhZFJzMEZXaWZYMUpZb0FqV1ErY1hTNGlpcDMy?=
 =?utf-8?B?M3h0L29EV2lsaGxldDVZZml4MEQ4Vmg0ZlpuU3NObVhQcHNObzZ6bmtrVGxE?=
 =?utf-8?B?a3pWSEFSUDc2UkpuOWk1QzgvdExrZ1liVmtWVVVMVlQ2TFZkOHpHTnFxazl3?=
 =?utf-8?B?UDdNYWlQalhLSkxZNlltTDUvUytSWlZER0NBZ3Y2SFAyQlMraFZCTVJVY1N4?=
 =?utf-8?B?akM5Z2ZqNWpFdDFtL0FCeXpMUVgrVHhJcXo3TzFRYjRsMExsWnJMWEtnMXNz?=
 =?utf-8?B?KzlsUGpSazZhUU1uM3NQenNXODVLZ3kwb1dId1lzTWdkcVdCNXU3ek1Dbkox?=
 =?utf-8?B?OHNKNWgzWUhjdUlnUUtJMXhEaE9HU293c2c1VUlnLzdaODNyeGlxSXJiUE1h?=
 =?utf-8?B?RDRtM3c2a0g3Wmh5ajNWUzIrK28zdFR5TEJjdW9oaFo1RlVnVTNYc2pOeVJF?=
 =?utf-8?B?YWJUQTJJVGNjUEVsVStuRlhvL211NnJWbEZEbUE2MW91bVZabEhsZFpuKzlj?=
 =?utf-8?B?MmtFWE01bmpISDN3bURVRytzdVVhMy9pd3k5QitCVG5MeEdGRFhxa0p3S1FS?=
 =?utf-8?B?bEVUKzZoSU9qbS9ROTdlSE1BdmdreTBYOXQ0T2xRVktjaGxnUjJWc2VQSHFi?=
 =?utf-8?B?RE8rdDlwNzFVRzhPYzZDUTBIdVJ0akxSZmJMYVZqTExSRGwvcE9xb05EOW9k?=
 =?utf-8?B?aGovd2kxZmUvQys2SWc3cVRGWlRTbzhtcjVqOU5RQXR2blpvNXBoT1FwdWxT?=
 =?utf-8?B?QllVWjAwRFZKNm1CMlhXbnF3ZUxzY0xiNlM2UGRrK0xYRVhLT2NpNS9KRHRQ?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ead57ff-bfc5-452a-4fb1-08dbf1a65a68
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 13:14:58.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVqhJUXc5d3QedLn7PLNXaa4aKXTHB6fxiix+j+M8fPocOWHwVezbu4MAIyuKvduXsTgP+AEmmYJEMScQHKEcoqQ4gJt8kQETD5wwr1fFXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5370
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Nov 2023 13:15:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13765



On 11/27/23 02:49, Jan Kiszka wrote:
> On 24.11.23 22:12, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to use third party service to sign the swupate packages
>> during build.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/swupdate.bbclass                            | 13 +------------
>>   .../swupdate-certificates/files/sign-swu-cms        |  9 +++++++++
>>   .../swupdate-certificates/files/sign-swu-rsa        |  6 ++++++
>>   .../swupdate-certificates-key.inc                   | 12 +++++++++---
>>   4 files changed, 25 insertions(+), 15 deletions(-)
>>   create mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-cms
>>   create mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-rsa
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 38c2e0a..117f9fe 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -120,18 +120,7 @@ IMAGE_CMD:swu() {
>>               fi
>>               echo "$file"
>>               if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
>> -                if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
>> -                    openssl dgst \
>> -                        -sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$file" \
>> -                        > "$file.${SWU_SIGNATURE_EXT}"
>> -                elif [ "${SWU_SIGNATURE_TYPE}" = "cms" ]; then
>> -                    openssl cms \
>> -                        -sign -in "$file" \
>> -                        -out "$file"."${SWU_SIGNATURE_EXT}" \
>> -                        -signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
>> -                        -inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
>> -                        -outform DER -noattr -binary
>> -                fi
>> +                sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
>>                   # Set file timestamps for reproducible builds
>>                   if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>>                       touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
>> diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-cms b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
>> new file mode 100644
>> index 0000000..7bd04ef
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
>> @@ -0,0 +1,9 @@
>> +#!/bin/sh
>> +in_file=$1
>> +out_file=$2
>> +openssl cms \
>> +	-sign -in "$in_file" \
>> +	-out "$out_file" \
>> +	-signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
>> +	-inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
>> +	-outform DER -noattr -binary
>> diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-rsa b/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
>> new file mode 100644
>> index 0000000..fad3004
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
>> @@ -0,0 +1,6 @@
>> +#!/bin/sh
>> +in_file=$1
>> +out_file=$2
>> +openssl dgst \
>> +	-sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$in_file" \
>> +	> "$out_file"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> index 1b6b6dd..0b3e045 100644
>> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> @@ -14,16 +14,22 @@ inherit dpkg-raw
>>   PROVIDES += "swupdate-certificates-key"
>>   
>>   SWU_SIGN_KEY ??= ""
>> -
>> +SWU_SIGN_SCRIPT ??= "sign-swu-cms"
>>   SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
>> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SIGN_SCRIPT') else '' }"
>>   
>> +do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
>> +                         ${D}/usr/bin/"
>>   do_install() {
>> +    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ] ]; then
>> +        bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
>> +    fi
>> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
>>       if [ -z ${SWU_SIGN_KEY} ] ]; then
>>           bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>>       fi
>>       TARGET=${D}/usr/share/swupdate-signing/
>> -    install -d -m 0700 ${TARGET}
> 
> We no longer need to set the permissions of that folder restrictively?
> Practically, the key is still protected, just wondering why that was
> done so far.

This package should only be installed during the swu image generation.

> 
>> -    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
>> +    install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
>>   }
>>   
>>   do_prepare_build:append() {
> 
> Looks good to me.
> 
> Jan
> 
Quirin

