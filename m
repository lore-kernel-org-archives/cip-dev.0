Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747DEC47258
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 09:26:57 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.63])
 by mx.groups.io with SMTP id smtpd.web11.8237.1706002007014434220
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jan 2024 01:26:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TCXoCMiT;
 spf=pass (domain: siemens.com, ip: 40.107.103.63, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRm9YxmMfTstYk0qcw9u4z8yf2za28SSxlxQj45g4xnQ76aJC4krZqdnXEo9cp+ypjOZq/nPRyd2qWTJz7/oBwLGmN5kVUvQFMCXYV+RpTERniwhjfy79vcvKm5hN5XZX34jC9uM+dvKiu3okrgXuiHG42cKiJCv/hxYXNRQxZhSnLzoR3H54kyFuhEqhQe1bt/jzKG/cJfwCul5g+kxINXFKAlvQ0GCXvrhZ4fbLqO7FNFnTSQ0TNffZjIIyBuHHpChvoN1rNgEvesCNCdE0F5my6265T7ZFPltS+mHzKV93Rtw8yDdBtcwWWfQGJHCoS56EkgjVvPb2M74/WORzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag9EU0Oct0e1lMz5JRtn4/yQk4jRLcFnfjcRXtqkyH8=;
 b=kG+QkOtMfoZTKfUOA2ZZ+tQe35Q7nFKqhJXGL2g51nVuMMoMXYoSB3fe9qqMmqpSclSslHjqqtu2LEKs1AMlfjVpy2dnsMC1HsuxG1qVa43bLSonWHw9zONmEXVXeScgzkaBwCK3GEEG559K8tax38r20rWSOYpEUSRvAtx8uuQdBHRVFWNVL457tuHzztwD1xk0k7DvL5D8xA+NgOo1DFJ/nKMbOEeXyF3qMacCtZrGdTskuU3NrS76aziqNq645RqbYIhbh0BgYLIavt9f2rfnTiskgDMGqqRWd0iTm5ZZ83DOPvrvhBM7BzECeZuJKIa+DAYqVCMeqnmzEGEMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag9EU0Oct0e1lMz5JRtn4/yQk4jRLcFnfjcRXtqkyH8=;
 b=TCXoCMiTaH65fUoMyM4OY6kvd6j4N6sy2/Sw6Qtzk7IyftIfF2hgEPSjicZ9YNhGeJysPb+CzEpkcK7LrHX5mz7ZmcvV264ewEHgjXJAZVoFZ0TvivN+49sfrpJrgHyLQXJbcntcyC3fPk6iPZaeN2Ref6XEQU/ywzMBZtq+iQIBNS5YU6+tougPDe5/AnuPPIzkXB8e6UCJhMn4YYJmckvC55J6oZjNZa1waBvFisnfMYTUisBz34l1lgJQma7rcl6jRliB0GrU2Yblig3MfNoLnr6FJyMJqn9ZoK+Li3+I5Zp2ZsTm2QJfkC+EfyM7gDO0oWE2GQDb9K8jMDGi/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAVPR10MB7057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:302::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 09:26:43 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:26:43 +0000
Message-ID: <9c94546d-58ef-4fde-9aa0-3d162e750e4c@siemens.com>
Date: Tue, 23 Jan 2024 10:26:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 4/4] swupdate: Add patch to copy the
 server_wfx.lua to /usr/share
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
 <20240122123751.83696-5-Quirin.Gylstorff@siemens.com>
 <41ad218f6a47d143c90e5a657f2c611fb1704df2.camel@siemens.com>
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
In-Reply-To: <41ad218f6a47d143c90e5a657f2c611fb1704df2.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAVPR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: f75e8e92-e653-4922-14de-08dc1bf56992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e5CM8nQbMkZ81ljI9l2viJkkftdaYQG3JBnPG7ntCRhIn52oMGjeuJalJ2y7YWrlTFYpfxU7he5cp0aGGz9Jiuo6mMmt++cPHr/dNZ14s3B5OccMbAbt459hYG/KezfHt3cv+1ovxZUzdeD5MwVZbMhV19P6xTlxyUEtkvXRgGdeLg3ok51waClp/PaCXSjgogIG5Y8hI3m4BCmP51RiKkJ+k1j/wrrVVHkKZRc2JxbKD4FUNruoez09GpeK7oQbxZdPXIWG1PhwvRnavHNYGg9dmQVmJQediY4LMV6OQeelicTc04wu2U62soOradZKAC1NiJc0Bn4y8011fS27Yvq8p7Gbc4ruNvSDKDIlzc6Xx3vUHXXs2TdGiHEq9zb6YJn/THTZl7VGLZbY6Y4K/7PkqIgy2LfUc9zJz0l0WwzBXH5VehFgJR9VG08yGyXpbP6FHZBB4kq27feT94iOtuhNXVNuAMB171WTFgQ3UcHbW4a2tnMqIPScJZHm7ARLcxHRvYYPioRvCFP3W7bVdhvVHYyDHZ6aajzA1WEkwxprCvDdm6XhAPlUOl9lZ1Z2Bzu7wyQPb0IPsnDX4moNFUa0Hm5ZNZMxrZhJv3SfBDueXUph4+5ZjjSz6NMHuy8e
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(2616005)(53546011)(36756003)(6512007)(15974865002)(6486002)(966005)(478600001)(6506007)(41300700001)(66476007)(110136005)(66946007)(66556008)(316002)(31686004)(86362001)(38100700002)(83380400001)(31696002)(6636002)(82960400001)(8936002)(8676002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fuhYmgl+czs6lV28jM9X3164HgHDZOA/p5hnD7SjHVZwZxiYZCAtA5WnPgQ/?=
 =?us-ascii?Q?9qJNnp8OWJN0dPiAwJLTJlrh6UrPqKojrZiToBfnBOOTFVCBqUUj15vM/8Oo?=
 =?us-ascii?Q?M76zHn+dCeLLDnjP4MarEwArkLkWxEX8Y9fmog9dkl9K6sMnYLRfdj0ib2+s?=
 =?us-ascii?Q?A2hv3KQBBTyMqt8fiCP/79gRw2zIbXWyRfkW0EV21SxzAG2UoGt1XZwSMA2I?=
 =?us-ascii?Q?kizxYAN5MMZkb/vNiQooVCu+h9700Grcn1mZz6L4dVkSDEPVDeYkSEoCTqyl?=
 =?us-ascii?Q?yDxG18+MTkHlipWpKrQMOOA5Yj/3rxh5641q9bwuOQpEc6pLyoG65+5Z92Rc?=
 =?us-ascii?Q?MDdGgB9ocA9OFtx+faKeoEPxDObeIprwLKkbnYnEPpo11+7kAkMnwNYTVf+J?=
 =?us-ascii?Q?OyPJ7eI7Pt3aLER9lv2QcqgJ9vkWvmvgU0LpXYcRfpeDNYvQVlGASR0bBUF9?=
 =?us-ascii?Q?+Gz89DrZisob2C3+ont1FWH+j27b0lHjjiQnn9LZspf94eJj1Tssu8SkhJf9?=
 =?us-ascii?Q?fhTPPFYtK04pwERnKTR8WpZY41+C3RF1UA/zOrTpot5aazucAN0zroTL5VxV?=
 =?us-ascii?Q?3fsIL+p21QmTt1MQkO9JxJ8ruC7KcxkI63ErNhSv1RtrKgDrwQG70YAX3d5b?=
 =?us-ascii?Q?1I/X6JIMQ1Ni15tclrAyIFxV5y1AlCCeakKOOnoSzM10Fj4np6I1qmRORs/e?=
 =?us-ascii?Q?DhseLC8PNw7n3gCG3WmqWizy5vzxmOXwLGX4uu9AHV8q04ZlTyJJJ5VQ6Jvm?=
 =?us-ascii?Q?rJV1QhGMSubZJYyWCpER4LZC9/TPLvO6GbuDb907qF6aIgyNV7hwvbwyF5+z?=
 =?us-ascii?Q?lB79yy/ZT75gEH3cQLi350qCkCEz4DfhRFPTNQGv/gtwnIR4W/zMvSgzVlx/?=
 =?us-ascii?Q?djTHo1tISBHoojM+72hL0v2Kh6bJ3gWwQRE7Br3YhMS/5Vktnm39PA0V1F1k?=
 =?us-ascii?Q?PTbH0wCx4KhPwZ2oyZZcqLrVP5pYfa8bhyPJ5WqYEnV1u88Fjdx7qdYJDtoo?=
 =?us-ascii?Q?NR7oxjKU8EGPJ/+vmcXUcDdVFMMxBzn2xjSOWTazNuqKcyMFyHDsggS1KMAW?=
 =?us-ascii?Q?wXvxnZlV7mvU4nRqa3hWZvDm6WXhhYIkiEsgxUHEWpfHfLZP5W7Of7mB7sSD?=
 =?us-ascii?Q?1d3EqqAnNuVWAirK4qrzFl7LWyQwFJ/aPUgF895xWw8aY1V7Z95DoKf5txw+?=
 =?us-ascii?Q?IWQUSnSYS6Hwh4DC5pvt9f/URChn9yhlteL2PdxCzgXhshQicAT974A5jUMC?=
 =?us-ascii?Q?r/R9QDwHcAwiJnYiwBow200fU4S95iZUn64BV/nFHwv7dUz/W05WdPje3yiN?=
 =?us-ascii?Q?Dof+a0Y880SJj7HgCOQwVG+GaV3igLgUmiOe6nxfqVVic9Jg6dLCd6IbQml1?=
 =?us-ascii?Q?D1Zzj15O/bwAMRzncvlisJ9xD+1tQ3eB7mZx8E1mkW9q9WoRNKTUXqDrQ+Rb?=
 =?us-ascii?Q?JVO+0liF/B4jk50wWgRnNwkQuYpHNwvKb7E/S4Egg8vtzbsVnE5JTmmSaBf5?=
 =?us-ascii?Q?PayV7d16CifwGKqbIlHT1tdgMeumjV8p3sSf0Bc2bnu0WwTs9WeThC0sPoRs?=
 =?us-ascii?Q?qRn4iF28YDbK8vQJeLC750ybZV3UzaD6A6+yIIqSFVIL/rYBEv0Xq1A7BEMb?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75e8e92-e653-4922-14de-08dc1bf56992
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:26:43.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dnhHRLZeFIPEeX+mdZTiFGkTS56KPcy1iTyzVrYZnLRUauPGPFaz9jP4zgWlqwRThrLFauFGgPHklMkjuNgqBvCVIW/ASQOCYFrOv43yvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7057
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jan 2024 09:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14444



On 1/23/24 10:22, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-01-22 at 13:37 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to use wfx together with swupdate with out embedding
>> server_wfx.lua.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0...rate-build_profile-option-for-delta-.patch |=C2=A0 8 ++--
>>  =C2=A0...tch-to-add-the-build-version-to-swup.patch |=C2=A0 6 +--
>>  =C2=A0...s-Add-option-to-enable-suricatta_wfx.patch |=C2=A0 6 +--
>>  =C2=A0...install-Fix-path-for-debian-bullseye.patch |=C2=A0 6 +--
>>  =C2=A0...tall-server_wfx.lua-to-usr-share-lua.patch | 44
>> +++++++++++++++++++
>>  =C2=A0recipes-core/swupdate/swupdate_2023.05.bb=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 8 +---
>>  =C2=A06 files changed, 58 insertions(+), 20 deletions(-)
>>  =C2=A0create mode 100644 recipes-core/swupdate/files/2023.05/0005-d-rul=
es-
>> install-server_wfx.lua-to-usr-share-lua.patch
>>
>> diff --git a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-
>> seperate-build_profile-option-for-delta-.patch b/recipes-
>> core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-
>> option-for-delta-.patch
>> index 0d0fc0a..4a63dfd 100644
>> --- a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-
>> build_profile-option-for-delta-.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-
>> build_profile-option-for-delta-.patch
>> @@ -1,7 +1,7 @@
>> -From 03d455be74d439c7e2eb849e5acdfb494afb3d7c Mon Sep 17 00:00:00
>> 2001
>> +From ce4e66c37fd6f2cb147fd0e75cfcabebdef3abd5 Mon Sep 17 00:00:00
>> 2001
>>  =C2=A0From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  =C2=A0Date: Thu, 15 Jun 2023 18:48:25 +0200
>> -Subject: [PATCH 1/4] d/rules: Add seperate build_profile option for
>> delta
>> +Subject: [PATCH 1/6] d/rules: Add seperate build_profile option for
>> delta
>>  =C2=A0 update
>>  =20
>>  =C2=A0Delta update need zchunk 1.3 to work on memory restricted
>> @@ -15,7 +15,7 @@ Signed-off-by: Quirin Gylstorff
>> <quirin.gylstorff@siemens.com>
>>  =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>  =20
>>  =C2=A0diff --git a/debian/control b/debian/control
>> -index a389b2a9..2f0c0053 100644
>> +index acbecd47..a0d4edcc 100644
>>  =C2=A0--- a/debian/control
>>  =C2=A0+++ b/debian/control
>>  =C2=A0@@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (=3D 13),
>> @@ -41,5 +41,5 @@ index 3b1cc0f6..2c91677c 100755
>>  =C2=A0 endif
>>  =C2=A0 ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf
>> riscv64 ia64))
>>  =C2=A0--
>> -2.42.0
>> +2.43.0
>>  =20
>> diff --git a/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-
>> patch-to-add-the-build-version-to-swup.patch b/recipes-
>> core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-
>> build-version-to-swup.patch
>> index 8056818..65c3cb6 100644
>> --- a/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-
>> to-add-the-build-version-to-swup.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-
>> to-add-the-build-version-to-swup.patch
>> @@ -1,7 +1,7 @@
>> -From ad714bc12b03c148aadb3523f87cc14d42a477b0 Mon Sep 17 00:00:00
>> 2001
>> +From 384613cc6d0b87e58cf8ca9636f65730b0790061 Mon Sep 17 00:00:00
>> 2001
>>  =C2=A0From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  =C2=A0Date: Fri, 16 Jun 2023 19:43:38 +0200
>> -Subject: [PATCH 2/4] d/patches: Add patch to add the build version
>> to swupdate
>> +Subject: [PATCH 2/6] d/patches: Add patch to add the build version
>> to swupdate
>>  =20
>>  =C2=A0The build version is only set if build in a git repository
>>  =C2=A0this patch allows to use the version information stored in
>> @@ -90,5 +90,5 @@ index 2c91677c..5d72987c 100755
>>  =C2=A0 ifeq (linux,$(DEB_HOST_ARCH_OS))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BU_SWU +=3D -VBuilt-Usi=
ng=3D"$(shell dpkg-query -f
>> '$${source:Package} (=3D $${source:Version}), ' -W libmtd-dev libubi-
>> dev)"
>>  =C2=A0--
>> -2.42.0
>> +2.43.0
>>  =20
>> diff --git a/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-
>> option-to-enable-suricatta_wfx.patch b/recipes-
>> core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-
>> suricatta_wfx.patch
>> index 87c60d7..e320665 100644
>> --- a/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-
>> enable-suricatta_wfx.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-
>> enable-suricatta_wfx.patch
>> @@ -1,7 +1,7 @@
>> -From fae97f0e23f945c1ab6e767451cda1d2798aa348 Mon Sep 17 00:00:00
>> 2001
>> +From 2be6e19412eb44c55b648bb8f34acf4e87bb0d3a Mon Sep 17 00:00:00
>> 2001
>>  =C2=A0From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  =C2=A0Date: Fri, 16 Jun 2023 20:32:38 +0200
>> -Subject: [PATCH 3/4] d/rules: Add option to enable suricatta_wfx
>> +Subject: [PATCH 3/6] d/rules: Add option to enable suricatta_wfx
>>  =20
>>  =C2=A0Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build wi=
th
>>  =C2=A0suricattawfx lua module.
>> @@ -26,5 +26,5 @@ index 5d72987c..d7ff5510 100755
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo CONFIG_LUAPKG=3D\"=
lua$(LUA_VERSION)\" >>
>> configs/debian_defconfig
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo CONFIG_LUASCRIPTHA=
NDLER=3Dy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>
>> configs/debian_defconfig
>>  =C2=A0--
>> -2.42.0
>> +2.43.0
>>  =20
>> diff --git a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-
>> www.install-Fix-path-for-debian-bullseye.patch b/recipes-
>> core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-
>> debian-bullseye.patch
>> index b2d831d..a1e8bc7 100644
>> --- a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-
>> www.install-Fix-path-for-debian-bullseye.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0004-d-swupdate-
>> www.install-Fix-path-for-debian-bullseye.patch
>> @@ -1,7 +1,7 @@
>> -From f2184e7573e705bad408cf1422599b967773d48e Mon Sep 17 00:00:00
>> 2001
>> +From 4ee463885ce2532b5bdf8beb6106e357670a737a Mon Sep 17 00:00:00
>> 2001
>>  =C2=A0From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  =C2=A0Date: Thu, 16 Nov 2023 16:40:19 +0100
>> -Subject: [PATCH 4/4] d/swupdate-www.install: Fix path for debian-
>> bullseye
>> +Subject: [PATCH 4/6] d/swupdate-www.install: Fix path for debian-
>> bullseye
>>  =20
>>  =C2=A0Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  =C2=A0---
>> @@ -20,5 +20,5 @@ index 7e3d95c6..9c6113cc 100644
>>  =C2=A0 web-app/js=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /usr/share/swupdate/www
>>  =C2=A0 web-app/node_modules /usr/share/swupdate/www
>>  =C2=A0--
>> -2.42.0
>> +2.43.0
>>  =20
>> diff --git a/recipes-core/swupdate/files/2023.05/0005-d-rules-
>> install-server_wfx.lua-to-usr-share-lua.patch b/recipes-
>> core/swupdate/files/2023.05/0005-d-rules-install-server_wfx.lua-to-
>> usr-share-lua.patch
>> new file mode 100644
>> index 0000000..a4c960a
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2023.05/0005-d-rules-install-
>> server_wfx.lua-to-usr-share-lua.patch
>> @@ -0,0 +1,44 @@
>> +From c34282446c928d7a1603b7dd825de7e1ddede829 Mon Sep 17 00:00:00
>> 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Mon, 15 Jan 2024 13:28:42 +0100
>> +Subject: [PATCH 5/6] d/rules: install server_wfx.lua to
>> /usr/share/lua
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/lua-swupdate.install | 1 +
>> + debian/rules=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++++
>> + 2 files changed, 6 insertions(+)
>> +
>> +diff --git a/debian/lua-swupdate.install b/debian/lua-
>> swupdate.install
>> +index afde2a68..6cd5436c 100644
>> +--- a/debian/lua-swupdate.install
>> ++++ b/debian/lua-swupdate.install
>> +@@ -1 +1,2 @@
>> ++examples/suricatta/swupdate_suricatta.lua usr/share/lua/5.3/
>> + usr/lib/*/lua/*/lua_swupdate*.so*
>> +diff --git a/debian/rules b/debian/rules
>> +index d7ff5510..8be9221f 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -71,6 +71,10 @@ endif
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo CONFIG_EXTRA_LDFLAGS=3D\=
"$(LDFLAGS)\"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=
>
>> configs/debian_defconfig
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo CONFIG_EXTRA_LDLIBS=3D\"=
$(LDLIBS)\"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 >>
>> configs/debian_defconfig
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(MAKE) debian_defconfig
>> ++ifneq (,$(LUA_VERSION))
>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mv suricatta/server_wfx.lua surica=
tta/swupdate_suricatta.lua
>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo "suricatta/swupdate_suricatta=
.lua
>> /usr/share/lua/$(LUA_VERSION)" >> debian/swupdate.install
>> ++endif
>> +
>> + override_dh_auto_build:
>> + ifeq (,$(filter nodoc,$(DEB_BUILD_OPTIONS) $(DEB_BUILD_PROFILES)))
> ----------------------------------^
> ------------------------------------------------------^
>=20
> The nodoc option / profile MUST be added to both variables anyways,
> according to Build Profile Spec [1]. Just evaluate the
> DEB_BUILD_PROFILES variable.
>=20
> [1] https://wiki.debian.org/BuildProfileSpec#Registered_profile_names

I will propose that change upstream but it is not include in this patch.

Quirin
>=20
> Felix
>=20
>> +@@ -97,6 +101,7 @@ endif
>> + endif
>> +
>> + override_dh_auto_install:
>> ++
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dh_auto_install -- V=3D1
>> +
>> + override_dh_installsystemd:
>> +--
>> +2.43.0
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-
>> core/swupdate/swupdate_2023.05.bb
>> index d1fe1fa..7533bfa 100644
>> --- a/recipes-core/swupdate/swupdate_2023.05.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>> @@ -28,15 +28,9 @@ SRCREV_upstream =3D
>> "c8ca55684c375937dbcdefb0563071a35137f4ba"
>>  =C2=A0# patches
>>  =C2=A0SRC_URI +=3D
>> "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.pat
>> ch=C2=A0\
>>             =20
>> file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>>  =C2=A0\
>> -
>> file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>> +
>> file://0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch"
>>  =C2=A0SRC_URI:append:bullseye =3D "
>> file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
>> "
>>  =20
>> -# suricatta wfx requires suricatta lua and the dependency
>> -# is not set automatically
>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattalua"
>> -# add suricatta wfx
>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattawfx"
>> -
>>  =C2=A0# Disable cross for arm and arm64 on bullseye
>>  =C2=A0# with cross compile we have a unsat-dependency to dh-nodejs on
>> arm/arm64
>>  =C2=A0ISAR_CROSS_COMPILE:bullseye =3D "0"
>=20

