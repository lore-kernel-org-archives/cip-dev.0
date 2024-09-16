Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A197C3ABA2
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 08:47:53 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web10.4230.1726476469418544742
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 01:47:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=f+snETwb;
 spf=pass (domain: siemens.com, ip: 40.107.22.61, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHEM7vas9+1hhmHh/cYsAmM3XuDj2miOIX5RgIbfbW8iacnmK8J8rAJo1bm+imdfBXHMXpftLq8fq8t4Z6rzADeEbb9YTuG2a/kvlQ+Whlo5UFYfteA+DUwffe/yABYHUxzY6WMbamBbMpvS8obYu8hdydjrP+Pmu6rQ1dKHchQ2Ir5Xx5bnuSXLLikda2BM4H1xFLGpvU41UocCU78KDYUdBKYFyZ6sIQ/PLjMrFO8ZWxKmjFk/d2VYWGQymRRQSMIRUlQAwbUaUeQiGqXOJhGj3x/gyc9Yz/a0K5kbRfO7lM1gVZnJgb3UxPw94cEowsJbm4XcshgWXkmQPCwu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+lYXcjQS9lcPYUiBAUBFCqhBi18pOL17tV/Rrb1A0U=;
 b=BuL9YzzHcQFftjEOr2ceZBewdfl+Qcs2kG1T4tNmDZclTJhcelFgGyixbT7+WipFC1eEIu+0clhaWLrGWrI7+dMJYeJshJM1MSZsUboPJhs2p3Y3VOBjwQJHh1AEZdmdTzcj4tr3nkAPdJEDdGHxexkI0bsW3hUDMYI7w9MJqqpUqSGykCyj9U247TE/kpzCqyvTa14fJ927G2umL8I0gIZfY0ah/CkgqsBDEh/3E6PjKUogKShfBv5ehKRZGfmvSFL9oBQyNwLVhRde2kUBT8gObcoMXpeejhF73MUnP6DGttp2BaioFYHPHm2Y8UZE/UEwjxe5GdnAvIXwWFAwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+lYXcjQS9lcPYUiBAUBFCqhBi18pOL17tV/Rrb1A0U=;
 b=f+snETwbNkxkjRP6ocqYbdNsOPD52C5oZZwuXkizccOMSQrImYW/keoZUDt22bOtCKQAwU/t6DJJpBBgp7uBxKhjmA0P1TSGGRxBS0YpWGJ6fSozsezZ1SXT7P0iiH9SrOlrgWtU2CMGdQvM32InurUujTGXGLpf8y+GjI0o04yp2IsImJAA+lfMwFVI+Ukwn0DUpx2DzzGElYdP6DFhjlbvmC736coO7NctzHQUiMxhRhJIdGBFMxSMqD9eFPsCgkGg3GDz58MQkyN3sufuqpLPeCbrvmGF8d9RuFoT5IsgL1HPIZ1ezUJAVuEtIZkK2R3PNyWx7Dva2NuHaLa+Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM7PR10MB3975.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:47:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.7962.016; Mon, 16 Sep 2024
 08:47:46 +0000
Message-ID: <15dca75b-8f34-403b-a3c7-ac11521589e6@siemens.com>
Date: Mon, 16 Sep 2024 10:47:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] Update README for swupdate
 signing
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
 <20240912100710.3183806-4-Quirin.Gylstorff@siemens.com>
 <536b5af253b015771a620fccec26def972331e5d.camel@siemens.com>
 <731e67f7-d18b-4e97-9f87-509fdbbde06d@siemens.com>
 <d6d03dc6-832f-4441-81dd-eae58c6d1eb5@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <d6d03dc6-832f-4441-81dd-eae58c6d1eb5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM7PR10MB3975:EE_
X-MS-Office365-Filtering-Correlation-Id: ae147ce9-2f78-466f-7c40-08dcd62c3c86
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?I+ZIlSAslwkPIiLg1Mqusm5Pi0FCZe7zykYpkIzgFk/rOBzYBRIt6XjORj1c?=
 =?us-ascii?Q?ZhZd17eVMJSB4lKP95Z/6aJ+hB4Dx+2lggg5X8tt/n8k61uyHuL/xGeUgvp2?=
 =?us-ascii?Q?bwFWW0RWNw2bV95aVqFsRLoYjAduKZ/NMdl9KHUIeeEesAZIOcWaUffOjF7r?=
 =?us-ascii?Q?NcNgceuqiIeZ4GBX520S7ATqztxtsr0K0j9eWeuOMEVg4QATbtVhf1O5DTED?=
 =?us-ascii?Q?5Xn78+myCtoFsVBBgdbTsXWKl5/iveLvf1sMmiQTba7VxcQRp0ka1IPdyN8i?=
 =?us-ascii?Q?XJB5es7xBWMqv6j1iGCSCkePg2hfrPofWuNsUrKabbvCaPE+AeK3qVkmz01Y?=
 =?us-ascii?Q?EYK//9N0oVFyVvZJcQ80nFL6aAWJJaqsy0HwmgjGHAp4/fbyjGo3UOmeSXlr?=
 =?us-ascii?Q?V3zdaxqwQ1AW0JCLd9gM4O32TLDnGTWd1OML8UzxJYUSk/MrqragqLqi2hFS?=
 =?us-ascii?Q?jaPX4M/JJdHmRU7c0ZRxlw+HEkvn25Bw3Z1/mxVNvtl0iv3Vgk2ozsA9KhGH?=
 =?us-ascii?Q?KYzisdcmp9aAt5W03jx0YkiJJzphPjwN0ethDPzgfNen2lLBrtmyAEbFENfy?=
 =?us-ascii?Q?Jc5qlIe6E1/Xjuq8JQQG51jb5oScVbl+vcAIVmpvsrakO5GDUgmSTKhx12kh?=
 =?us-ascii?Q?/U2MaX+4fJXXbqn5g2/QZGLKRAbAsbAw2KqBFcQrWgihKwnj+Y7+0nIp7ljC?=
 =?us-ascii?Q?8g3YxhwOv4ofGInIbcFeua/rqQjsq6YSwTEdbmw9NJ+7RHsFzGeB3z3WKFQP?=
 =?us-ascii?Q?d3l1JNJa4aXXoyjUcehCCEI/UEQdAl/hAjA8QU04rKLM4YyeWtxLWVGOXF5r?=
 =?us-ascii?Q?9qKXv3MCpr01r/tI24xhUPs4HUtfwobqW7Kk/XFIEODFN8uPNbdXSxUwugAD?=
 =?us-ascii?Q?GtZF6AguLdjl/OFVXUfKWpNAFDqA7FYE1+5MVvJj5yzL5n8AslTBPzcV00YP?=
 =?us-ascii?Q?kllJjmG4VD6mDjXgsBgDGwkAj/gucuEmT+woT3lJJiAMXgLdSSlnxpMg8+yD?=
 =?us-ascii?Q?8NO2Tti86v4Xyp4wQ9DkadFb0HQctrnWwZK3OOnQZsiH2Eo8gneIzuxtKc8U?=
 =?us-ascii?Q?OZDLg5zKFONqvCrrpL/lf2uhQ3eE6XNJw38ZFPhjtSzPqyRkkP3FkD7n+eDu?=
 =?us-ascii?Q?9vxFe1uDoTsUFOJ0pxqFO/iw02yb1sXDYQClbCEZxHPYZgeuMg4ZlDJPUg+r?=
 =?us-ascii?Q?IJ+QSBUfZkqWdA6stNWK5hioZx2NKeD50KdBQizV9kvLHMD5HtMPvtNsx9Ln?=
 =?us-ascii?Q?ffjo4nfwuCBugFFcq+Kcg7w2vRT49b26Znb1H8zh5wh49Yr8tNhLGMSWEVB+?=
 =?us-ascii?Q?MTwT8l3UN49WcRCCWlMab0NogAiuMYYlJ65uU2ekQMAS3w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PMWHkzLRG/1LD+idygbub6wCPXBgE3lcUwG1Op4ZzwqqeG9dNptWXoBWYI0W?=
 =?us-ascii?Q?2BTr76GbVbCtpPh2MsphjBehJ2tGPkkHVPnH+ysesvjVbwLucBKycA5RufZ9?=
 =?us-ascii?Q?R8khBIz76GMOnFnWCiA7Tuz/roc5a/A8U5g+kyJVuEITictKQaNIKPwFKVQo?=
 =?us-ascii?Q?pzikxjtjSIOCqrmQxANlJqUfhJe1C3hDmMTMAlE0iw6VxyFg6baceU+hL3fs?=
 =?us-ascii?Q?D7RRGWufJTQH5HQ/gGZtULw9x960SLuafUrafQu4Oyn54xX0spoA7z7OUMGq?=
 =?us-ascii?Q?EpIsCSGuwbpJc118nptz5qVKRCqwryfI2fvsK4s2s1Dfu5xb63200FFytS1Z?=
 =?us-ascii?Q?sn8Zk2Km/ACIE+JiXZEOUBoN/sZwIz5YkG6QncRDA9weU6CyJQvy3T3QpTAC?=
 =?us-ascii?Q?5KfOtnUmQuD/fT2BtSq8TnC9Agf/f9Mi0w7+g07/ZkXFuhVSACGldJLdgJra?=
 =?us-ascii?Q?q1d20qRLZ7pt3f19oQZ7ETvsC3XXfA1OPl4KLWORQQP7p3iP+AfjYBEJqJhE?=
 =?us-ascii?Q?46KNCYLs4zCkk+AGzhwqe84R0DoDpQUJ8cun5ZdsdMJexM3vocRkjKXh/vEP?=
 =?us-ascii?Q?vnGT0iLzS0P+mF0UjgUWubKCbYKWIHH8JBIQdJqdJvrGTUkF7FHbuDIXLBkt?=
 =?us-ascii?Q?RiC5JX0hN1PcjToeWmaxitUMLz9ulvm/GM09kJXFJE5THnnK78PSHYfrPNsJ?=
 =?us-ascii?Q?S3owoUYReqn66SGqYyuHePt423CpRlW4D1wtqAq1sfIK4qn9372mLaObJByT?=
 =?us-ascii?Q?5MfVdshO5mL7KO1xYxChXhHJa9GFRm0QLr4UdaRJstuOEC5xIkhx1wvmFWhG?=
 =?us-ascii?Q?ITxqf2KwM76krZdEAPQUf5DD2UFRslebyaMmS85yOsC+LEC9Y60/iWAPqHbk?=
 =?us-ascii?Q?cSYIWzLUTTewR2QL3O26m+/nHm+OG16QtBk+ZEFuqRHJ03GpJymWKuGn6ABl?=
 =?us-ascii?Q?q5IDfZh69LpeNfUKBI39W6AWGwlcT7vTF/j9/S0PWvh02RqgAo1v5rW0cEZR?=
 =?us-ascii?Q?8IjDQYe2lGoyjQZMD7uDuJYtCcKxjUBgOFqL24bapCA5z2KFaTlxup8QLg7d?=
 =?us-ascii?Q?frIArdYYmxBl+ij2dz3renGoiznh5LDyXS8AH06VUBLXdTrA0ZLmMSTw1a0s?=
 =?us-ascii?Q?FXvCpqQKIKAJoRu8Kp95coFywaS7K9CKiQOw7Krj/SaBrcNjn62I1QQXfwbv?=
 =?us-ascii?Q?VviUo6g0GrMJJaJA0FCHKLtq8Pk2g4lXtjdbIIjE7sGs9QnPGiUru3U886C+?=
 =?us-ascii?Q?vpmdUO1IVrS2wReXAplyalY2RiikaGQnmTMdGbsfJn7ocgmhyP9/+MPfHGat?=
 =?us-ascii?Q?0eJli6HFAyeagoGcZtUS/UpCwhcSpL7LcmrSIWxRCZhZ2LNvqW9LZ9MEsQIl?=
 =?us-ascii?Q?jEqpa1laZKTlVpWljsmoLbiPDBD6Zl848xsMXjuiWowLIuib4ZUpXWBvUMzR?=
 =?us-ascii?Q?W/4LARDuXmiN+9S24jDqlSV0urQdo6T/W9b4fW/s9RZVYVxXuOWpo/n/wx5+?=
 =?us-ascii?Q?qcJDYLJAkXtqL7Xo3L/gYkq8jHbFPaDQ1NH/kP9/D9AZoSluQDKsTcsodiA/?=
 =?us-ascii?Q?nt3rgyomgovOzMIxSKSD8vlQP8fLyFXJ9W5Cv+OsgXq6e0BSSpqtumCn+i0N?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae147ce9-2f78-466f-7c40-08dcd62c3c86
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:47:46.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib7UR3iyMgT3dHrLqWTFdhZori8GWKnbCyqB7Qu5SrdpKyo6HNDrP407D35KiK7yvwcpwWeIKK0m6FkhEIPLCh+axdfnH1xBSnun2iOoWG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3975
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Sep 2024 08:47:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16901



On 9/16/24 10:42 AM, Jan Kiszka wrote:
> On 13.09.24 09:55, Gylstorff Quirin wrote:
>>
>>
>> On 9/12/24 4:08 PM, Moessbauer, Felix (T CED OES-DE) wrote:
>>> On Thu, 2024-09-12 at 12:06 +0200, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>  =C2=A0=C2=A0doc/README.swupdate.md | 13 ++++++++++---
>>>>  =C2=A0=C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>>>> index a5fbab9..d4d0851 100644
>>>> --- a/doc/README.swupdate.md
>>>> +++ b/doc/README.swupdate.md
>>>> @@ -136,8 +136,8 @@ To use other key and certificate the following
>>>> variables must be set:
>>>>  =C2=A0=C2=A0```
>>>>  =C2=A0=C2=A0PREFERRED_PROVIDER_swupdate-certificates-key =3D "swupdat=
e-
>>>> certificates-key"
>>>>  =C2=A0=C2=A0PREFERRED_PROVIDER_swupdate-certificates =3D "swupdate-ce=
rtificates"
>>>> -SWU_SIGN_CERT =3D "<sigining certificate file name>"
>>>>  =C2=A0=C2=A0SWU_SIGN_KEY=C2=A0 =3D "<siging key file name>"
>>>> +IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>>  =C2=A0=C2=A0```
>>>>  =C2=A0 =C2=A0=C2=A0The files `<sigining certificate file name>` and `=
<siging key file
>>>> name>` need to be stored
>>>> @@ -145,8 +145,15 @@ in `recipes-devtools/swupdate-
>>>> certificates/files/` or in a path defined by an bb
>>>>  =C2=A0 =C2=A0=C2=A0### signing script
>>>>  =C2=A0 -The provided [cms signing script](./recipes-devtools/swupdate=
-
>>>> certificates/files/sign-swu-cms)
>>>> -can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
>>>> +The package [swupdate-signer-snakeoil](recipes-devtools/swupdate-
>>>> signer/) provides a [cms signing script](./recipes-devtools/swupdate-
>>>> certificates/files/sign-swu-cms).
>>>> +When signing requires a project specific signing script,
>>>> +e.g. for using a hardware security module(HSM), an own package can
>>>> be added.
>>>> +The package can replace the default package by adding the following
>>>> line:
>>>> +```
>>>> +PREFERRED_PROVIDER_swupdate-signer =3D "<own signing package>"
>>>
>>> If you just specify this, bitbake complains about not providing the
>>> keys package:
>>>
>>> Consider defining a PREFERRED_PROVIDER entry to match swupdate-
>>> certificates-key
>> In the section above this own
>> PREFERRED_PROVIDER_swupdate-certificates-key is already set.
>>
>> This should only happen if you set PREFERRED_PROVIDER_swupdate-signer =
=3D
>> "swupdate-signer-snakeoil". I can add a code section where all the
>> variables are collected for a snakeoil signing.
>>
>=20
> So, there will be v3 coming?

I will prepare a v3 with:


+```
+PREFERRED_PROVIDER_swupdate-signer =3D "<own signing package>"
+PREFERRED_PROVIDER_swupdate-certificates-key =3D "<own key package>"
+PREFERRED_PROVIDER_swupdate-certificates =3D "<own certificate package>"
+```


Quirin

>=20
> Jan
>=20


