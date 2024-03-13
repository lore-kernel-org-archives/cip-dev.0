Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6B3C54E66
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 17:16:07 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.55])
 by mx.groups.io with SMTP id smtpd.web10.1586.1710350156553541414
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 10:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=B7Oiaxtg;
 spf=pass (domain: siemens.com, ip: 40.107.104.55, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDbe+5l7BP1CMaWGRRxByyrMpB5busTVRlo6oB0m8rjPe7o8VFZXnX/vS+d7vRH2k/Bl6Ua4UtQGg/9FDujPwlWQnERo+sfyLpuFJK5rDRm7Q0N8xY8cNynmPiRx2j59vjt4L/TFGnOFebaY8Zl15n1QEocjrOPrj6YBT4MlNu4i0G2STbCeYbbzHBF5nGbmm4Bz9+scfsp0Zz43uh8ChrEHp7x0kew00OqsE4cXC5Iipb5KQdkRnUhTUHzSJzhTLgD4mL0TTc+BArylOo6Bd+WRdbtpkXGantgGfbgZSiTGF5umK13/IXDmTRyDghGMJXVv7MxdNZISNFVIwkz+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIuK4Amh27TVRUUZAo/tBMQTSH8WUI8LnKMYdATMkaQ=;
 b=BLjk1RtV4dkqBikAkFMiabcsYi3RS2Tew3zqtGDx6bO2P+tiDTIKDFw8x7x32cpwdlXIjO3TyxtopLz/Vp5yeFPGdwZzJj6TzP1vw43AJgLeoUZNxsRDOHjNxqz6O+scim2boI1YMAm1f7/IMCoMC7zqGDljmcbjjyDwqm3UsR90CAx4l7dU17m5PR7TeM09Rw++XbRP9XAUu3VOTONhUGulTrYpKyBGlOwI5roGhnliOReVuzq8RWuhIcS3Q1qXQGNqRf6msyvnV3cuLVPgp3RKhtQJCvM3mdN+K4WRyZASsGZ4PklLn/yTVe0azQjcFFGnVEA01T9dO0/RGbXgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIuK4Amh27TVRUUZAo/tBMQTSH8WUI8LnKMYdATMkaQ=;
 b=B7OiaxtgRqOVGOWKRL0TWMfjoe6vWPg4QB09YM87Fv9/sjW6VpnZ9xuLlKspT0jnLBd7gQJJZGG2L4YFI3XxRohbh8go17pPyWiA2utfSM5MPAu+M6eIRHhG2vUiFmYQDGLCln9qNeFa1LW/ytVi5MpzoIZqmRgvtMnB0A2yGTF9zQjSGGGLH1w5+ttlDq8bKnCXO7lOi10nZk5JKXOa1mmWjFwAtxQiJDxykxNd/AurcCwRuiDtyT7OIvJM9m5W+++CFUulKnIAxW2sW1Xao0sm0YnXPQtCc7tnY9BCOMxH9G3o88tOomAtcQs/4slusSJkrEXWHBRgyx03g3y+7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB4PR10MB6070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 17:15:53 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 17:15:53 +0000
Message-ID: <d9b9a979-41b3-4348-8171-14727d79d7c7@siemens.com>
Date: Wed, 13 Mar 2024 18:15:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate
 swu for delta updates
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 jan.kiszka@siemens.com
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-6-Adithya.Balakumar@toshiba-tsip.com>
 <4fb765ea54765e58a93b6aa0d19f0054a0e680f1.camel@siemens.com>
 <TYCPR01MB96694682086B4F651CE7C8FDC42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TYCPR01MB96694682086B4F651CE7C8FDC42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:610:4c::23) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB4PR10MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fd3bcb-76d5-45be-c592-08dc43813d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1zWzCMHuZzroyCd85OXgFdsC6jEJNd9RYBOfvIzQyvGZDD/gSVG2I+s8NjtPCBJUB5dW6mzm5sVDoILgS1EOwsYE0aIJIjVz/FyI24c2whQ9Way0fTCZNjNR1io+TT7fiTRngn8lCzNE7/8MtH8fYpFVkrA/99x/j9DfCFEaGOshfvweAGPcYXKVtcs6TC6yqwQbq63NYny3Fef4zlN01RE+lFXRsHpnpgY3qY6kmd3Rh5Aq2ombr/4ZxQx5Mnqont9AH9NN31NhC9+RotFGBUMJ2URaU4bavlNagWlFzFZigzJruwGjW/f1A9jk2y3aFsgJkSgwNWsRR1eYClpqwZafwvojL46eKiaHbwj3FKgO+f7LHU4AMgQYepPSAV/wXFNOVoIqsGrr4P4PcMoLkYwFhSum/jqg85kZ7K0eNt21pywULI01RSITZQXnooMlmiuD5RuolqZc5t6Ctfg82gyyuFrqfQFymMC3lQppTp4Mbcp7LIWg3JtfSFT4ITO2b1EdPplJlc8d4KC7Yuq9U6b4YEjNSPa2D0pIgh2jxsQsrgUK2T2kAQHo4q9uIasdCSxeIGQwfFQjzQjgFegWwreVftbWF3PwKKMDCCt4fMU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+B+QeHeh6YUAzC0UkSZ3UTIs4Mv55d1iMEfrMdrNlLHcDq7DhY1Me2Ufo1EB?=
 =?us-ascii?Q?iI/5yfXBVt9OOt9E2gJ25XtSwbhVSuAhbbeVICYjppSVT+lNBQNWNzoz1xyw?=
 =?us-ascii?Q?NrBF/6KoGidb2uf2E66Y9mm7H1dbBhKNe9xF9nx/jNBQZEBBI2LzhS24Wf13?=
 =?us-ascii?Q?6dRGwUPggUvBdpiKw+f1ou+13BH+UCcFhEJAYiyWB3sg9lDOUcL1SuSRjFGg?=
 =?us-ascii?Q?h7gvLJiBpzU24EPFo17mr74R3YghYg8tERlmA5KVH2ImYRqmQia8BXrNry1C?=
 =?us-ascii?Q?4ij4RkHNDA7u9zWBOkjOcwCFzDlc4siBakCyhVst0JqDYv0uXCH58NjkoJ9N?=
 =?us-ascii?Q?ysXIEvYgK2Zl7rFctLujasbQnSZNMgDsTwS65BXr/LjKwg0NCE/mjU9a5xdt?=
 =?us-ascii?Q?3y+4Q2CzHIiRTxYEzfhmqNmFpABWIarrZw+55HDWM3DRyrAgciYWXuRla1bC?=
 =?us-ascii?Q?pMKRVlrmBA7cebL6PfUegT26kyeyhsK0dk1DYT9yalyxivdogPc/w7d8ieY0?=
 =?us-ascii?Q?WRgOPemRUSXStIpate0hPFTbFGX/K3+5zvgq/MIKxQV5kvcStWHJVZHDHkmW?=
 =?us-ascii?Q?IE5H3NPlBriK0I51j0n9NQ++Av+QSJ3wJJC2lau1Jt/+h/P1AE+iCFN1CSFk?=
 =?us-ascii?Q?eH6tWT+4+OP9IhbBbKJ3Nx7mBo+uIYz0y6tKZ0M9fJFqZAovmeCUmc4sb2gU?=
 =?us-ascii?Q?letfAmo0/SD/ayR/ltsHmwcv1XIb8JDcPc6rmOpVQnwCwY7FlBVvupk0mq6I?=
 =?us-ascii?Q?NrTyCxVWjrBiLFep5eeDOJq8UapfT+qekErGbIY37Evm5/Yh15uzsEHIyxgk?=
 =?us-ascii?Q?9oB2b4xCgHJmL4PY7MjLXI/E3pwC84gYWdeRqI3osqgAoojSv+B4MbEIG0zs?=
 =?us-ascii?Q?wHAbf4y/tr0OZLaiDfNTSsCUsW22DuKNqHYn77/rfQFCkcxbU8uQCB1SAKHm?=
 =?us-ascii?Q?UkHqnKswAa8vjWsycJBKtTJprNF80DWDnozo/eH02uUpwlC/dvQmjgjcmhsk?=
 =?us-ascii?Q?XEf9uKkjD774d5d21YseaIE/uCI76bKk+Kp8dsSaILDRJVwZ4S0rBwlJP8jC?=
 =?us-ascii?Q?tBxJETyftiyj84mySEuGt/iDLnvGihIN5iggrIM1+lZ+zRup4zVAbyNQDFkk?=
 =?us-ascii?Q?7NO3bJC4F7KUrQubAmEBUZEDTHCD/OX7b8d1R50ZfjIc6uoz9iwvhHzo4jii?=
 =?us-ascii?Q?pcpkNwChFBMlZlk4hqbKeahbqM6fxYfj6MMwRs8w11h+zlX1lDNbrix70axK?=
 =?us-ascii?Q?eU4B8KN3LE9+IRXnF2jEV6NvH8fNPBmIELBL+1NSf6Dz5+z47B+n0qtxhXe0?=
 =?us-ascii?Q?K61FDQLpsJxUAhfWWtKFwUKvn3yYOlSUDSvPLbxIsYx7BkX1AQkRVUhNhvDw?=
 =?us-ascii?Q?AjHRHVSj4SJ97R8K5lq+UAuoq6s7xIKM3H3dD0R6tVlc2+ROHxGlCsTfypAi?=
 =?us-ascii?Q?lxnXE9l+zQfe0bbdbRcTppnlGu/ACPcpOK+/2eloYJ6Q/GD9LysXpMriRY0W?=
 =?us-ascii?Q?R7GWCTgJuve+XBu8Lh56TBr3+F5e8qRGhUhwfwlaBeuHkdA5EbNmKucp9fsr?=
 =?us-ascii?Q?SZdoVTxqgMaoGS5ba9wn6/lXlEdsoygcf0euHJGmVg5cBr0eJcCp+I0BJyvT?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fd3bcb-76d5-45be-c592-08dc43813d07
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:15:53.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfV6syDYsy8EDaBz9GvrZSbUiaTM8r9bev4nZ/zQGd7b/IRjQqeBBFZDpk+PcEpazcLblzWVJIfMOR9ATlvNUNKwyUrpxWsDAMCGzPiKtw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6070
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 17:16:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15292



On 3/13/24 8:03 AM, Adithya Balakumar via lists.cip-project.org wrote:
> -----Original Message-----
> From: MOESSBAUER, Felix <felix.moessbauer@siemens.com>
> Sent: Friday, March 8, 2024 4:27 PM
> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR) <Adithya.Balakumar@toshiba-tsip.com>; Kiszka, Jan =
<jan.kiszka@siemens.com>
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate swu f=
or delta updates
>=20
> On Thu, 2024-03-07 at 13:16 +0530, Adithya Balakumar wrote:
>> This allows the creation of a swu file for delta update. The swu file
>> for delta update is only created when delta-update.yml file is
>> included at build time.
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>  =C2=A0classes/swupdate.bbclass | 35 +++++++++++++++++++++++++++++++++--
>>  =C2=A01 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass index
>> 2c69892..2964024 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -26,10 +26,13 @@ SWU_EBG_UPDATE ?=3D ""
>>  =C2=A0SWU_EFI_BOOT_DEVICE ?=3D "/dev/disk/by-uuid/4321-DCBA"
>>  =C2=A0SWU_BOOTLOADER ??=3D "ebg"
>>  =C2=A0SWU_DESCRIPITION_FILE_BOOTLOADER ??=3D "${SWU_DESCRIPTION_FILE}-
>> ${SWU_BOOTLOADER}"
>> +SWU_DESCRIPITION_FILE_DELTA_UPDATE ??=3D
>=20
> Hi, do we really need a dedicated file / variable for that?
>=20
> [Adithya Balakumar]
> Hi Felix,
>=20
> The sw-description file for a delta update is slightly different in terms=
 of the image artifact inlcuded in the swu file and some additional delta u=
pdate
> specific properties included in the sw-description file. Hence I chose to=
 create a seperate sw-description file for delta update.
>=20
> Would like to understand if there is a better approach.

A seperate sw-description file is not ideal, we should take the same=20
abroach as with scripts and other optional or malible fields by writing
the content to variable and use the template mechanism of ISAR. The=20
sw-description can look like this:

```
      images: ({
-            filename =3D "${SWU_ROOTFS_PARTITION_NAME}";
+            filename =3D "${SWU_IMAGE_ARTIFACT}";
              device =3D=20
"C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_P=
ART_UUID_B}";
              type =3D "roundrobin";
              ${SWU_COMPRESSION_NODE}
-            properties: {
-                        subtype =3D "image";
-                        configfilecheck =3D=20
"/etc/os-release@not_match@IMAGE_UUID=3D${TARGET_IMAGE_UUID}";
-            };
+            ${SWU_IMAGE_PROPERTIES}
              sha256 =3D "${SWU_ROOTFS_PARTITION_NAME}-sha256";
      });
```

an alternative would be generate the whole swu with the Variable[flag]=20
syntax, e.g.=20
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/feat/generate-=
sw-description/classes/sw-description-generator.bbclass?ref_type=3Dheads

Quirin

>=20
>> "${SWU_DESCRIPTION_FILE}-delta"
>> +SWU_DELTA_UPDATE_ARTIFACT =3D
>> "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
>> +SWU_DELTA_UPDATE_ARTIFACT_TYPE =3D
>> "delta_update${@get_swu_compression_type(d)}"
>>  =20
>>  =C2=A0SWU_IMAGE_FILE ?=3D "${IMAGE_FULLNAME}"
>>  =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>> -SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
>> +SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}
>> ${SWU_DELTA_UPDATE_ARTIFACT}"
>=20
> Does this mean the delta artifact is always added here?
> [Adithya Balakumar]  Apologies, I should have appended ${SWU_DELTA_UPDATE=
_ARTIFACT} conditionally if delta update is enabled.
>=20
>>  =C2=A0SWU_SIGNED ??=3D ""
>>  =C2=A0SWU_SIGNATURE_EXT ?=3D "sig"
>>  =C2=A0SWU_SIGNATURE_TYPE ?=3D "cms"
>> @@ -37,6 +40,7 @@ SWU_SIGNATURE_TYPE ?=3D "cms"
>>  =C2=A0SWU_BUILDCHROOT_IMAGE_FILE ?=3D
>> "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>  =20
>>  =C2=A0IMAGE_TYPEDEP:swu =3D
>> "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>> +IMAGE_TYPEDEP:swu +=3D "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if
>> d.getVar('DELTA_UPDATE_TYPE') else ''}"
>>  =C2=A0IMAGER_BUILD_DEPS:swu +=3D "${@'swupdate-certificates-key' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>  =C2=A0IMAGER_INSTALL:swu +=3D "cpio ${@'openssl swupdate-certificates-k=
ey'
>> if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>  =C2=A0IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> @@ -46,6 +50,7 @@ IMAGE_SRC_URI:swu =3D
>> "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>  =C2=A0IMAGE_SRC_URI:swu +=3D
>> "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>>  =C2=A0IMAGE_TEMPLATE_FILES:swu =3D "${SWU_DESCRIPTION_FILE}.tmpl"
>>  =C2=A0IMAGE_TEMPLATE_FILES:swu +=3D
>> "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>> +IMAGE_TEMPLATE_FILES:delta_update +=3D
>> "${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>>  =C2=A0IMAGE_TEMPLATE_VARS:swu =3D " \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_ROOTFS_PARTITION_NAME \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 TARGET_IMAGE_UUID \
>> @@ -58,6 +63,8 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_FILE_NODES \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_BOOTLOADER_FILE_NODE \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_SCRIPTS_NODE \
>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ARTIFACT \
>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 "
>>  =20
>>  =C2=A0# TARGET_IMAGE_UUID needs to be generated before completing the
>> template @@ -136,6 +143,22 @@ python add_scripts(){
>>  =C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_no=
de)
>>  =C2=A0}
>>  =20
>> +SWU_EXTEND_SW_DESCRIPTION +=3D "add_swu_delta_update_properties"
>> +python add_swu_delta_update_properties() {
>> +=C2=A0=C2=A0=C2=A0 delta_type =3D d.getVar('DELTA_UPDATE_TYPE')
>> +=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =3D ""
>> +=C2=A0=C2=A0=C2=A0 if delta_type =3D=3D "rdiff":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =
=3D=C2=A0 'chainhandler =3D
>> "rdiff_image";'
>> +=C2=A0=C2=A0=C2=A0 elif delta_type =3D=3D "zchunk":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zck_url =3D d.getVar('DELTA_=
ZCK_URL')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =
=3D f"""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chain=
handler =3D "delta";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url =
=3D "{zck_url}";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zcklo=
glevel =3D "error";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 d.setVar('SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES',
>> swu_delta_update_properties)
>> +}
>> +
>>  =C2=A0# convert between swupdate compressor name and imagetype extensio=
n
>>  =C2=A0def get_swu_compression_type(d):
>>  =C2=A0=C2=A0=C2=A0=C2=A0 swu_ct =3D d.getVar('SWU_COMPRESSION_TYPE') @@=
 -154,13 +177,21 @@
>> FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-
>> core}/recipes-core/images/swu"
>>  =20
>>  =C2=A0do_image_swu[depends] +=3D "${PN}:do_transform_template"
>>  =C2=A0do_image_swu[stamp-extra-info] =3D "${DISTRO}-${MACHINE}"
>> -do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>> ${SWU_BOOTLOADER}"
>> +do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>> ${SWU_BOOTLOADER} ${WORKDIR}/swu-delta"
>>  =C2=A0IMAGE_CMD:swu() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*=
.swu
>> +=C2=A0=C2=A0=C2=A0 if [ -z "${DELTA_UPDATE_TYPE}" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -rf ${WORKDIR}/swu-delta
>=20
> Why is this required if we already clear the ${WORKDIR}/swu-delta in clea=
ndirs?
>=20
> Felix
>=20
> [Adithya Balakumar] Apologies. I should add swu-delta to do_image_swu[cle=
andirs] only if a delta update is enabled.
> But even with the above change, in a case where we build with delta updat=
e enabled and without cleaning the build directory if we build again withou=
t enabling delta update, the swu-delta directory is retained in the WORKDIR=
.
>=20
> Thanks and Regards,
> Adithya
>=20
>>
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>>  =C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}'
>> '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_BO=
OTLOADER}' ]; then
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_D=
ESCRIPITION_FILE_BOOTLOADER}'
>> '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
>>  =C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_UP=
DATE}' ];
>> then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRIP=
ITION_FILE_DELTA_UPDATE}'
>> '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0 for swu_file in "${WORKDIR}"/swu*; do
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_file_base=3D$(base=
name $swu_file)
>=20
> --
>> Siemens AG, Technology
>> Linux Expert Center
>=20
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15284): https://lists.cip-project.org/g/cip-dev/messa=
ge/15284
> Mute This Topic: https://lists.cip-project.org/mt/104783341/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

