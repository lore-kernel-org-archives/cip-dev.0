Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F31C2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 16:37:55 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.20])
 by mx.groups.io with SMTP id smtpd.web10.17259.1747327072794764786
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 09:37:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=isCF2xHd;
 spf=pass (domain: siemens.com, ip: 40.107.159.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t93+8xHU+kwgD9godlHdhPY8mYk6Y18JqFRx63APtI4GAKCTQuy4sScW88RO7k4PykRHyfd5TbviguldOHkE4UnxgkMkTAdZ27wLmFV6fyjiOhs0qMeEKQbVMx+hes4USiwPp19itLq2qU1v2ClUDmcNvehigND5p6V8EqHOVRpheQXlruJfDI6JDPIdm/IZSpi+7ul7EXgv6uAshra4vi4/UEQVrgahx/vv2+1Sg2NLf2TcVfwHawmdBGMzluOaKYDz2qhV/FnHK3fcivXPFH8w8Uu3ZCNzy0yb++LzmzVASE3cWIvT9cOs8CpsjZK6wTIL79/Rvh57k7eFONDoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJdwmGe3+ARDhE/qkZMYJk1vYP2pWMbB6AUsDfRYGLs=;
 b=poJaQd/FYO6ZgKZSqj9Cg2A/puGwGeCjDC3quN/shXn3J/vkZHbL/SFBhlZhMkix51KVy5hhDZOGWDI6kAR8L+B3G20sEhl/sIn6CcNJIE0+QgbnAIyl96LpVrHkeG5bh+VtkD8YTJ/W5bgS/fxy+b7+V2s6ugq/iM6kFvO59/ed1BhZ2X5kkt19iwVkzTG7MOrA5iob/xO1J5C2OkFMBIMkpP0xqSzojBKlrdsCS30m21O24kxPmVUpWgrBK0zsOHHvHVzwGYYlOQqkfyyK7DABD64GXbsQOXeJwiDjDnpG8bIYq3wMKQJETEGuPgMRFhm+Otn7mwwyN095tlKJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJdwmGe3+ARDhE/qkZMYJk1vYP2pWMbB6AUsDfRYGLs=;
 b=isCF2xHdzQURgUIITgAfJ8dVpDrw8YT9nxEpuXwxGgRecPX0OcBDdDw8gmolH9IWUSSXyHPQ5ioaU9llN5bFZW1+5HOxV3thvTKGM7CMKx+qr5T/++CekP5off0x9Il0hNxKmwVL38oRKojMkxVZ8nmAuGzADOnfM3ZVG8BBUv+ghLsdZB688fGuF/Tf0Rc9HD8wuSVWf/dUYrDglr6NJfcLX/lvm2req03Qt8PXpWo5QGKp5J37tceskJHbAi4oV4MTZuk8PbOI4BRz30N0eH+/IaxV221Hgpowh3BVpzJyQilIMBWvc9VlpuOOf0Ri3EPI2E8CfY2vUd1mE6eKsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 16:37:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 16:37:48 +0000
Message-ID: <5a5eccf4-33b6-484b-9edd-c1f890edcb68@siemens.com>
Date: Thu, 15 May 2025 18:37:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/6] Add factory-reset
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, Gokhan Cetin <gokhan.cetin@siemens.com>
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
 <71648737-4e33-44bc-8aa0-c67f443a42ae@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <71648737-4e33-44bc-8aa0-c67f443a42ae@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3869:EE_
X-MS-Office365-Filtering-Correlation-Id: d194aac3-c7da-474d-7598-08dd93ced40d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?u08FGMQamnieUoCh19fycwgmKXHaqPa19Qx6s0plAwDMf0wOQgiOixIOjP4u?=
 =?us-ascii?Q?DS3NrmtCzKnsSyPpuhcBVRGRj1Jv7BLy4j3RAI0yC07Iin2N89IhGnd/bkCj?=
 =?us-ascii?Q?IgWN0rFpkQETJTBzY3DI+czyHQMnl+3RiWYDyw9WxjrGUbLlndISyZ7txS3Q?=
 =?us-ascii?Q?PN3Qsn25Kv5FcegAY/BkbUI1se8tEytJFYmFAZpuNLKWeyWmXFdaCcqLo9X1?=
 =?us-ascii?Q?qzxtRjENqvn8kVcAqJCDTln4uUrEr6BtHG7teA0HZDOK38khJqQp5mqaU3iJ?=
 =?us-ascii?Q?hv1+CVri4vB42plTaNwV2I4QLENp85QVdr7apTLhYCA9o5aTeZk46BAKtc0i?=
 =?us-ascii?Q?e+keYuBpLoqcH79Dhlo+c1VjEhcvoiqQp9m6E5Acf/btEqe4uSIgcOMzIlr8?=
 =?us-ascii?Q?aaqOtYnLplcSYSmqBU1y58MWi8TQa8DF6YXijg75ZtIf0BRZRSqymLhhQFgj?=
 =?us-ascii?Q?jZObnZdmuI+oSZZGV3F56PUICP9iKTIEJUw8/AVMxWjsqCXVX/9iMhoZBedz?=
 =?us-ascii?Q?P70DjDbvcy0CHXGYqeWM85qRyz+kvJSsGUPV9K4Aa49V6rSx2WYkmakvhYLa?=
 =?us-ascii?Q?8enQzTP+thW+gBQc7QZUtaz4SIcn613rx7iyyIH+8odWaxcp+cNd5IlJ7ZNA?=
 =?us-ascii?Q?PJWx3DYADsWKldpOVwWVcXnZLGlEl7LeKv2O308jFaLWE6IZ5XlNNseNLBvH?=
 =?us-ascii?Q?ucnancXHN+qKQCgqI8SuvG4ug02AU9A3Cxp1Lfu1jTTP0G1wDU3FWUA7CUQT?=
 =?us-ascii?Q?d5uouhQJAMpyoeemXjK/QbEn4D9/grU98y92ynjZBpWqPBboQL/hUE+b+6q9?=
 =?us-ascii?Q?5OBD3kaILnQKKWPGIiYD3lT2DbRrvfN9Oi2u1ApyQWbJh4iJH2np4NMykn5j?=
 =?us-ascii?Q?SY1/MxfbmqYJ8peyYN/QO/1QCj35yyfFKa+jr98U8VZ8cmk0rMfEGeKx/FoR?=
 =?us-ascii?Q?J2/leTiU4DQthNO+FHkzOX4ahHUszDr4uELtuC4uDB12NRe1EfrBy2qqDb2r?=
 =?us-ascii?Q?9KKQ1QWKMb1JgZsSbFbANSvp/HEdyyx+ag+DpRs4bheWfioUXBeLX4lZvB0a?=
 =?us-ascii?Q?D/ONB/O66iPuu/5Dac1LAPTU99tRyWUuGa3SGQO3ocNSklVrVy3aWCWgAquy?=
 =?us-ascii?Q?hnt8Wrc8TA1w1pVjMpa4/hUHiRnnQQWjeauD37yumyCeT7Fhv5MaI7XcU4hq?=
 =?us-ascii?Q?vZNhl2vrBHbaS+1zni+JFdSMHpkNxKGw8Ksa41HCKi+JlEPUfx8+GZrY1aWk?=
 =?us-ascii?Q?gUGW2RDPPi1uzo1699qERONAFh06Fk7e3+6v6W0D/taoPzOhj+MpcJ4SYL9e?=
 =?us-ascii?Q?txZ8I0qiAytJHbCLt7jpoltRqKN4L4lVWIBe0+ZISV3UsYSdwHXhFZ91pbmD?=
 =?us-ascii?Q?GUcecsXbfBZYXgitt7UODh7zjnBASCbNmqq/b67wAK16zHbA8eKPEXRJsVGh?=
 =?us-ascii?Q?+Skx+JV6xFw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7+d+cBTY8oZynAMVNcz/Z6s8PDUehutu5n0jNGXA/7yXgrPmv6GthtHj6Ld1?=
 =?us-ascii?Q?hnf9SHWiN4fKBQvTUFfFQLXvax5a26Sf5+pIDqwGR6GzoWJ0hvnB0Oozzl9S?=
 =?us-ascii?Q?HRunxlSege7NwMClOPdDl5bqXCZyxSveJhQz0aNLGIsAoKkze6v0LsiwkpUD?=
 =?us-ascii?Q?poq5wuMT4nLb1Jj3j07bS+EZVikBFb0BlwBQIqgMKmMR5rLWRq3HOooxP/SE?=
 =?us-ascii?Q?PycW2zzM7gk+dqNK7LbmsLbMDT/hJxrPJZpQ8fcM0hJxNT8lqYV++WvA0Zun?=
 =?us-ascii?Q?wU+h25QEyeM7ICOo1AsUNfGZw58fp76RCtUsHrwh6zNYMPmK8F4BEKSaDmZl?=
 =?us-ascii?Q?IQ/N3xgP7xuipJkdDmq99TBlMF11RglIiQi3ZbdHVImM15b1eIEeE0nqBVVF?=
 =?us-ascii?Q?bw3nkPDhQ0lo+ihACK+iurR0sj0mlv2gGHuIBCh5j8OuAE5a5fnMU2WqFfY3?=
 =?us-ascii?Q?UO81dDus9QH8ky3uLUZ0TonBv51TWGvsB27fKlLXdL4P5fYeS+duOrdR2ELY?=
 =?us-ascii?Q?5xLoIIgqUsY84XX5ySjjyLNWx6O7HqeurmjXr0z3GmrYN7AWT+0MpNLzT7xe?=
 =?us-ascii?Q?MbyRq717+JTpj3X6DDuPPMf62ZJBpiutgH6G6CrLkpGBxymOtzXxSktv6a7r?=
 =?us-ascii?Q?AL412RH3zB1ZrKc+DeihQ53gXvhK2qTch2eVyZ2DLX1UFs0aplCBs2fPjZ+a?=
 =?us-ascii?Q?IOYs5Fsj6GxSfazYDnT7dzn6+Z6oaNiCYHB71cTlFV7BOqZtN3ZOIARDvcxw?=
 =?us-ascii?Q?BEz0aMfrCayopjO25Qk77vMicyednM//HIB5NfpVVUxa2915dzSW9C2zwgSi?=
 =?us-ascii?Q?acFyPzc+ZAU5ebNxyytVjjo9Dd/JV5/sO2Mve7jTI4mGVyBpSW/6UbWVutqD?=
 =?us-ascii?Q?CVtHGD6mjzpMQwUq/hp1jmA9eudWER2PEuZNEg8iIzJDE0kjvMr/N+mzxg5X?=
 =?us-ascii?Q?nvK8KKJQAuP8ec/kS06TuSQod0HsBSePwPi4McDjz/e9FahsT+YPy8QrLQzc?=
 =?us-ascii?Q?wqJFFBVOcOuIY1Y8wPcISPF/YtHeIDr0NOuuKkdSZqpYcTzJVImr3x8P4NmI?=
 =?us-ascii?Q?0tr/jvIUXrznvpVfuBC/LElFnili0mNj0uAaCEz+QxML6YzLlK48L0+/9BkI?=
 =?us-ascii?Q?D4RDMsBJtCOf/LJvRfJ3Zw1PdJVhq0CnGSUGC1YRBmlDXiKIS4OPjcpBbD4J?=
 =?us-ascii?Q?2UdgBr71OElK7R5/lPj7cJfJjPDill0pjWhKlNVn1TVGHvnIggMRzubz36Xx?=
 =?us-ascii?Q?h3PobP6W8IqbXvWs+LbFf5U9QfAGSHFQreASUy+X2BGdvtzjNDa94UZUVnVp?=
 =?us-ascii?Q?CbZ2vrnSzV10RggNHauJ2ikM/nCl2QnrTEgAjlxOA66XFaS4H8qbdLU8RNId?=
 =?us-ascii?Q?zo3vwdvqSAj/htdHYzsPwcu1gk0TTzGMPscTDUbgtZVeZIrIDE3UtLMG0Wlz?=
 =?us-ascii?Q?7vjTnWUAcqc9jlQOWdZmbNGc/Oxce6TpNMAHtJjWfoo6J4qDN4rlHDaFo7YK?=
 =?us-ascii?Q?b9+x8xNC63DVxjaOtCwBaN9qBIJgqAsiZxwprYqiD63HOKfihtRyvuR7M40L?=
 =?us-ascii?Q?bfY4yP99Fda9nhJacxsMAkHVqPzkOucdCg/ibZwD4DEMk2Bo2W64UQZmgros?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d194aac3-c7da-474d-7598-08dd93ced40d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:37:48.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivy9NY1E7aJVFEYO6+qfS7YNGKtJpZCuHctCXsX2AigMunS94uo9EY/PQ46kxDG0lM2649pFTJfs3Yi9yHkxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3869
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 16:37:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18918

On 15.05.25 15:12, Quirin Gylstorff wrote:
>=20
>=20
> On 5/6/25 14:07, Quirin Gylstorff via lists.cip-project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>>
>> This adds an new hooks for factory-reset to the
>> initramfs. This hook will
>>
>> - format the disk.
>> - In case of a encrypted disk factory reset the TPM is cleared(all keys
>> =C2=A0=C2=A0 are deleted)
>>
>> In case of an encrypted file system the marker hook needs to be stored
>> in a readable location, e.g. one of the boot partitions or the efi
>> partition.
>=20
> I am currently working on v3, where I replace the file based marker with
> =C2=A0an efi-variable. There are some issues with this approach as u-boot
> would need to support that. Also gohkan mentioned issues with preempt-rt
> with that approach during an internal discussion.

Ah, yeah, the famous CONFIG_EFI_DISABLE_RUNTIME=3Dy issue...

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

