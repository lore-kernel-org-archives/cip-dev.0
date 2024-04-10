Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D04CD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 13:24:38 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.120])
 by mx.groups.io with SMTP id smtpd.web10.165847.1712755468215187171
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 06:24:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cp6qAdDd;
 spf=pass (domain: siemens.com, ip: 40.107.8.120, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY6oo+RGtsTFnkrlqzayMwEOX2DdZzE0YO3hCDDEW0+m3q+JDNGzwQZZkaRfnU0sgUgskqHUbJyTESvPs6bU1i79dzcu355E36cQhjc1dGF4unGP1IOf5x4gPO3tRkYbgmN46d6wwaOLRfc23Oe/t7LS5coFkIQrOeY0GihJrgJpbBxdoYBsysSjfN+e99NB2lNSkMCOuT+LON3JkpOErU77pQJAJzfwq2jfQOfILXw/aJMGI1Yw3HNCyfEE6ha7FXT2rWtGeW1e+gcbsFWtmZuL7mhid31UWUelnBwi51MG01CkJPtDkMZz4+Viz/xD8Ha9xNMQcRTVaUo/HbkjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlfGL8go0m8YdIar1q7aguz8n7q38EBr+PBC0Yqmvaw=;
 b=iKRaO/7B+mWzYs8hLFgRLZHlgGFfk/5MhvsVNOK9LDH70cL5gCxrtr3DnDfnuW4fD25veTT3zhWRe4K4ZI6P44UGCtg7YcB0I/1PbrL0JGB+aLwfmuJzVR8Vt+l6K65Z9SruPtIIBS2/f3fYIhZqePE1BK6W0YBAq0Cr93Yk3uF9sNyKU5qYTo9dxgaRjpc5J91rFpR0ATxvvvnjXgqc/pEM5F827gC1pGak8xCQbVA9bxocRbIQZWcA9Nb8jqwoUzsTntAYlUHVVu6exrjcI6SKwO7kRDBa9ozltN0mkpBG1rrBe9jp1dUb1fDdJMvyqIH6ibnPS3NFCVNQ8qc7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlfGL8go0m8YdIar1q7aguz8n7q38EBr+PBC0Yqmvaw=;
 b=cp6qAdDdRFSZiPEGQDWE5yaZlL1LY5STR9fwa9WwDa7mvYCOQwrXX5Sl3tFWsDzOlKRdQjD0K8rZLxX7lwAwSvd4fqSScTGD1u3/NX2rOugRPC9KEy9XOcDSY5U74XoLENxqWljdI0r3sO53DVvWFnSJxbLzSAjmVlOvzW0GFiAgSjg+oeLUho7Wm0U7fhWO4zW1l/NIPPyGMKwePq2Ez4VrRRwrCzIHAK1LV/94QxOaT1bU7xn2rNFvcsdXcrYRg0R6TsCBOl59ADrXVspJzHU8G/1wYCkuBXY53Bsk9BLUVGz4+BsD4SFDVhrGuwnlwBe17WtHq5UoSR2u+LktTQ==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 13:24:24 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 13:24:24 +0000
Message-ID: <d9c1d3ff-06d3-435a-a998-27fba042d35a@siemens.com>
Date: Wed, 10 Apr 2024 15:24:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update support
 with rdiff_image and delta handler
To: Jan Kiszka <jan.kiszka@siemens.com>, Adithya.Balakumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-3-Adithya.Balakumar@toshiba-tsip.com>
 <ed0c8463-e04a-4a70-9954-54640fdac205@siemens.com>
 <TYCPR01MB966987E730E8F8D621DF564AC4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <6306b141-580e-42e6-9e44-19a2de20c856@siemens.com>
 <TYCPR01MB9669E5691C80A28F3BD65BC5C4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <417f3a0f-8d13-4156-b2ee-89b258bf585d@siemens.com>
Content-Language: en-US, de-DE
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
In-Reply-To: <417f3a0f-8d13-4156-b2ee-89b258bf585d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7591:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	swqZPz12xyn/uOghHZzGTnRPWFPzMi/2bKyDLKfHYR44bhl1qDLS0YkU32km4b2dJFGyU1j/taHjq88TD7u945mSFfs0G+rFxe0wE41PPTT/lWHdeukeSa93V9/nSflxXUtl8uiv6b5EIgY9EIvw6Im6yXBBfA7uYyJAiXQMx5fGGUJKRqm/AN30G0Cc7yyMeD084C+e7XSpkEaJ/USw4byzzw+E0Hb8atXhUD5j08uW3bnBXYB/DQXw7Mxc9XQguZXJDai3c1H5DtTVEdxV+nd4U0boH3YBL2BBhVH27+JgrWnGdLyJbUzAU06Pscxcwem7bLJIUp9hSn187vWXb5xx9arLnh32Bluls8DWJY3gLEffNzc+k6AT0RBNPDdxJs0MgHcH81ErzNGUkFR2mGyI2O9A+g1dQdJFflt6bByjtnq8vYVelaHCZojMwhc5x0yCUHoZP7AqSTvx+SifFiplR6NygUhRY6gnnDB3DYxasIJFkqrj3Yl1dd3mrlSccRsF9BMM+8iSAvGNtHNfEo5dx/yoTpLimqsms9Z2aTMAQzI7WMge85Pgnp+hevSU80ooXbfrd2VnK3hUa0f+YGEr2aLWvu8p/0qtLYWERuOag22a2zPF6fdUoAGpktTBEnjND6N7wXvEOeqBG629YSZTiSqkyAHN56VEOuPauo8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I68O7YI2EX4kHfCX6BXOp3kKahCGcQcU8bzxZn1YZ4KPPPfz3FgaXTrqWyse?=
 =?us-ascii?Q?hr00M7wLhSy+ORcQ9Rx8o/JDRVp9Tq3rKX/H71e3nLwfLiUmV0tvmf0vkz7f?=
 =?us-ascii?Q?//bsvCU6LJc4EiJsbK180H7fGCarHm37FAvCNV4fWt8O32fytLsNuNah7THI?=
 =?us-ascii?Q?PXz8rlMNrLwppyKe0Jit2tVVipGNgzlV2noFP4qd0NUrv6d7+pVjMc1l6Zak?=
 =?us-ascii?Q?m8V8sJj3717Nv08jLvDw8VDmROt5+psjefECzn0YQU+I7SkUMXQE1dsOOqhh?=
 =?us-ascii?Q?1jiNjjRlEtIfIg9mrGAox1dx+pfbKd7L3mniXy8cf5azg/Zxwiohss/0uI6/?=
 =?us-ascii?Q?TLzyrWR3pSwGt0cJVlVX2BTybMHHZIpo7PHbSENAhSR91SGws4kHI5wwVYzc?=
 =?us-ascii?Q?D0mwczyqh8Cw0ZQxbVoBuepZ0zBUn3aUrF56cQjEj1HJB557/cflaBFX1PKN?=
 =?us-ascii?Q?omh8JriBSSsOT8suFHjKbp21Bu6wx5kHm0JBWcHDhCvZNvJg52MDHUkeZqSs?=
 =?us-ascii?Q?RxtYKs6rfGhPWInI0qnmLIUQP5sDCYttpGFwEKl3sRnp73M2YLfdxnLCdIUh?=
 =?us-ascii?Q?57GKk6sVm6hlaTDLup/D3+lcdHdO73IJgDriBr488GnGd+WjrqWEwXq5LlaJ?=
 =?us-ascii?Q?FKbPIu+Lrjqz6QF37AgnhrmlXGA3lRVIokpc+YLwQrBQVOEVgq/WAR1kQ9np?=
 =?us-ascii?Q?fPbLrsqa3VvmnvDs9k8EXUE+7/SdE2+cP0VFDIkgqx+EaNxkUr8X0TV7awyg?=
 =?us-ascii?Q?s6ikCdTkTgJZWTKFzBN/nabNCAN+W8oJw8gAwgTf+rGp3Lrsdq443KOMWCLU?=
 =?us-ascii?Q?pjIsU1kyRIEixHRNTDZnyYo/YgIcUbp14jFZsk45t0YjmdoSRksgUNOUSRfF?=
 =?us-ascii?Q?CgStAKFPXNFa2PLmk+cEJruMIDJFI6SLEVnUCxjxbBHv5YrzyWUL4VnIwxgl?=
 =?us-ascii?Q?c+mk9OqhqIX5iG9z2Bjd4hTnyl2Cg3lK7rUIJSeTbF5K2AVI1BTbNdbOuN7J?=
 =?us-ascii?Q?xpppx62DpTNUa1T2bhoY3VmCU5lK46E5ok2exrJSnUCkhgk5GKURgso76qi1?=
 =?us-ascii?Q?umFWUrf5pjy3jGMNT/R4rV9nG+O3vXJNLHSbX/aCoNrelCTpYiN3ceCEz7h2?=
 =?us-ascii?Q?8kexJdnSazHMEapiRCn1rf2bTqSoKeZXx9o3bazrp+iJS3W5YExNsRVGbJyU?=
 =?us-ascii?Q?1F6H0csjNERV0pp48spZk017BdDERarWE56gOVz8zfpdf4EGDodwIdrEHQNV?=
 =?us-ascii?Q?fKw4cIgyyVmKIopcGwXBvbmCF+2WOlAj/gEASOS/IkkoWigd1i7kI71mWNI7?=
 =?us-ascii?Q?/cVV1yhhx86M9DTEE4ksNOzGs99zo99GIzIS3fNpWe23vxg2EvkvZ+T1eOyv?=
 =?us-ascii?Q?Yp7CEH4uJ2fkw/j4ZBCyWJBJ6z4wK5LMkeMX5NLPOqbtp2Q/N5AvtDin7mGa?=
 =?us-ascii?Q?Pk1/PW9Jt3aFa+as9zUOblGd0IIeDqpwqG9ypyB9Etedx0//12vg05IQwBlg?=
 =?us-ascii?Q?VXCpavLgYmPtyHdAsJ9IogcFWfy6E7DevL1HOz/x2K3Rj/aLk0d662p7xWuU?=
 =?us-ascii?Q?g0uJeKlpCzEQRI5hHxMfgfn0uwJpgs6qUFFq2/sFhVvmhcOYzBvt6wnRCTlW?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aab82c6-d9df-4680-3014-08dc59618a34
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 13:24:24.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfiEq2gd5ciZJ55V86ios8AzJZqt2R1tG08ItDlWkktaXpS3s1R5mtl9h+Zu8RHf80Zlx6cqkTsRaAtI8GhF4IT5ZJzgYhtr1uoH0Z5RR+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 13:24:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15534



On 4/10/24 12:40 PM, Jan Kiszka wrote:
> On 10.04.24 11:23, Adithya.Balakumar@toshiba-tsip.com wrote:
>>
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Wednesday, April 10, 2024 2:14 PM
>> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithy=
a.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; quirin.gylsto=
rff@siemens.com
>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG P=
orting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
>> Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update supp=
ort with rdiff_image and delta handler
>>
>> On 10.04.24 10:27, Adithya.Balakumar@toshiba-tsip.com wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>>> Behalf Of Quirin Gylstorff via lists.cip-project.org
>>> Sent: Monday, April 8, 2024 6:25 PM
>>> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
>>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG =
Porting)
>>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)
>>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG Porting)
>>> <dinesh.kumar@toshiba-tsip.com>; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR)
>>> <Adithya.Balakumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=
=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5
>>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=
=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>>> Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update
>>> support with rdiff_image and delta handler
>>>
>>>
>>>
>>> On 3/20/24 11:32 AM, Adithya Balakumar via lists.cip-project.org wrote:
>>>> swupdate supports delta updates with rdiff_image and delta(zchunk)
>>>> handler. This change adds support to use either of the handler for
>>>> creating delta update artifacts. zchunk based updates are supported
>>>> only for sid.
>>>>
>>>> DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables
>>>> can be modified based on the update type in the swupdate.yml file.
>>>>
>>>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>>> ---
>>>>    classes/delta-update.bbclass | 107 ++++++++++++++++++++++++++++++++=
+++
>>>>    conf/layer.conf              |   2 +-
>>>>    kas/opt/swupdate.yml         |   5 ++
>>>>    3 files changed, 113 insertions(+), 1 deletion(-)
>>>>    create mode 100644 classes/delta-update.bbclass
>>>>
>>>> diff --git a/classes/delta-update.bbclass
>>>> b/classes/delta-update.bbclass new file mode 100644 index
>>>> 0000000..8443f35
>>>> --- /dev/null
>>>> +++ b/classes/delta-update.bbclass
>>>> @@ -0,0 +1,107 @@
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Toshiba Corporation 2024 # # Authors:
>>>> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +IMAGER_INSTALL:delta_update .=3D "fdisk zchunk rdiff"
>>>> +
>>>> +FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}"
>>>> +do_image_delta_update[cleandirs] +=3D "${WORKDIR}/delta_interim_artif=
acts"
>>>> +
>>>> +DELTA_UPDATE_TYPE ??=3D "rdiff"
>>>> +DELTA_RDIFF_REF_IMAGE ??=3D "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_=
TYPE}"
>>>> +DELTA_ZCK_URL ??=3D ""
>>>> +
>>>> +def disable_delta_update_tasks(d):
>>>> +    d.appendVarFlag("do_image_delta_update", "noexec", "1")
>>>> +    d.appendVarFlag("do_delta_rdiff_ref_image_fetch", "noexec", "1")
>>>> +    d.setVar("DELTA_UPDATE_TYPE", "")
>>>> +
>>>> +python () {
>>>> +    import os
>>>> +    path =3D d.getVar("LAYERDIR_cip-core") + "/" +
>>>> +d.getVar("DELTA_RDIFF_REF_IMAGE")
>>> I would suggest to remove LAYERDIR_cip-core or replace it with a variab=
le as it makes it unusable in downstream layers. This class should not cont=
ain any cip-core specific elements.
>>>
>>> [Adithya Balakumar]
>>> Hi Quirin,
>>>
>>> I understand the issue you are pointing at. Could we reference  "LAYERD=
IR_cip-core" through a variable defined in this recipe. As in maybe have a =
variable (lets say DELTA_REF_ARTIFACT_PATH) with a weak default assignment =
with the value of "LAYERDIR_cip-core" so that any downstream layer could ov=
erride the variable with a different value.
>>>
>>
>> Why do we need to reference a layer at all? Can't we just define a gener=
ic location, maybe somewhere under DEPLOY_DIR_IMAGE?
>>
>> [Adithya Balakumar]
>> Hi Jan,
>>
>> Do you mean to store the previous image build artifact (.squash / .verit=
y) in different folder in DEPLOY_DIR_IMAGE itself and pick up previous imag=
e artifact (if available) for the next build to generate the delta update?
>>
>=20
> I didn't think this through in details yet, but the basic idea would be
> to look in some build folder (rather than in layer sources) for the last
> version. I would not simply use DEPLOY_DIR_IMAGE itself, rather request
> the user to move the old image explicitly under a path that signals
> "build delta update as well".

You can use ${TOPDIR}/<some directory>, e.g. `${TOPDIR}/delta-image/`,=20
to search for updates.

TOPDIR is the current work directory, normally `./build`

Quirin

>=20
> Jan
>=20

