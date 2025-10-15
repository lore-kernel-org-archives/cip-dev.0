Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091B5CCD18E
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 10:09:02 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.64])
 by mx.groups.io with SMTP id smtpd.web11.12411.1760522931930264679
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 03:08:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lxmOQJ+Q;
 spf=pass (domain: siemens.com, ip: 40.107.130.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLHw+Yp1jnYPTKupa/bYGJizwL9Kv8+0rREW4GeIxHP+0glxMpQ6/UKqhryLRXJfeWdKShTtS8TyzaUur43hrajpEMTlee4XWuuAtN/2NseZnI7HqAeQs5pV65m7nF34AGf/fuGOEWsxRlSptyv6YGnHwhK0/jVMEWpzaRP0FRf/SDwhVxB0evj4FO2T7QHwmIbP6xM2Md5J1a9eVtD8ugD/M8DBO6s/FgMr4BYXbL3Z+QXNE1VlCEHpHKaQjCASNjKYtuWlQkTk7mYePDiHujIXdFw/yTahKAC7PP/r9uSfmXSYtX8pWPusliMopA7HsG7xLN6JVIfY6a6zH+ptTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4orRcOQ/qtiHZtZ/QKjFUUGtKb8K9zbO5AMbFAagw18=;
 b=qlD+WlnHTyKbmp/Fi41iXciYP1J+0OWtV0zzmzAyHjtKKtDJfUT+S3g12Q9cSxaXviKxKqI4D8udZiNmHNCztjE7DQLntSK3s8hweRMY57MpyamMVmDmIyEXO5oDbqMKV2zmMvIPGKN2G/qpl3E//MxyHg5JC6fPDtLdkAAYazaYwjKX7UsBLjDVrUSHKja05uRB8eQHTk0Wej4W7AYPVGORPg9omezwMi0/Lt7LrPHrZQN5IP5+dz1iV0+A+CDaa7W11BYiIJq5oFfZxBD4Z/LzgpVZswxqJK2wruOZiN3MIPMFxFv5XWJYKMZeCLU3alO5PV3RY7igs8SJ6szW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4orRcOQ/qtiHZtZ/QKjFUUGtKb8K9zbO5AMbFAagw18=;
 b=lxmOQJ+QbCyD5erh1p4L51/AsaJi1vBPzkZiawbr2wHOH/YqxXMcl6X67TwAsNxAtnou2HJmQ0WFaqwCaNx9Y1jOJOuyT1/BWr38gQ6C2f5vQOkYwTQABVHIiSQ+uko6P1ETyUSFQNDm6XZyscCgJ4/HVKP1dtvFhp++MyJuHgdBFo5RP5PLqcSrOAubZh3Odel4E8GgrJSa/D3TBFAVYOiPXXTK05ixtjN+Fo2EYEMZFMDFdYwFT90DZ0+/dYNql5RXIO5eQJneNXcoeVA4ZplcjFz25h1h0oie+AXEhDiyDZQ3JGMGdfDVWd5giB0dfc+ICeXfTv89l3bDILvGgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 10:08:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 10:08:47 +0000
Message-ID: <ce936062-26d5-4bee-8eb4-e2eadd1a37d0@siemens.com>
Date: Wed, 15 Oct 2025 12:08:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Adithya.Balakumar@toshiba-tsip.com, Shivanand.Kunijadar@toshiba-tsip.com,
 quirin.gylstorff@siemens.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com,
 nobuhiro.iwamatsu.x90@mail.toshiba
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 646db692-d665-40c8-2123-08de0bd2d4d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Kc+wVMBvuQ7Fk/wEvd4SjrCG5YyPQVXsJdnvVjMTQXCHAECFe3NYIbTUxvqW?=
 =?us-ascii?Q?NYsIbn0yaXHcECoh/wlkOZQVZHxHH9eNF5OFDD9QTkeE8aEq2omfASnsMaix?=
 =?us-ascii?Q?zWOnJ13S1Pq0VqvMRFfuMBliRRcXYFvfhdRGwTGzm1mwRkRA+lTFxMEnFccn?=
 =?us-ascii?Q?kBa8qY/wtVMTG/IvsTmDgFsJQUvOOiDmTgosYKo00KwgygFHjaPD+vMfM/LX?=
 =?us-ascii?Q?ZKXSlbZ7DqzfncZRqy9rOrwVdvvp2lTIdyCWeo9zmLX3rjP39sm4tZWrE7SY?=
 =?us-ascii?Q?rjguIrPDqz4sznDaPe+gvCioMMqUAq54mYBe/WP56z2vBpk93E/tj6gnwauY?=
 =?us-ascii?Q?XQXkedcHaIScAnSfVaAb2FTEkHM0TdPwfICtLDBt2f/Z1esixAekgQrY6XHM?=
 =?us-ascii?Q?EDqz+1zm/Qn+5b4PWPesNvTi3TjLzKfFU4zTvMRH+YavN1nZEWzSJRYo+UsH?=
 =?us-ascii?Q?F0y95wz2aP8TTKtJaZALqcmjxl2aEi5fczbR3l9wMQHk+Sscber9QWTZXXZL?=
 =?us-ascii?Q?5YujX0YgEEoyM5FSvrxlSRsY8z/JjW4Pd6KMuUR4y0SCLSjkfETZpYG4zYlv?=
 =?us-ascii?Q?O8YBf2i8i9a9CA7L+0vO9X+kEeUZuZ1t9rWfnnS7gf3CB66FblYooHDFxnW/?=
 =?us-ascii?Q?1lV8gTkF31tVX4NdtXiQ6aLbzi1Zawl5/UG7eUDYJ2P5Cg5jfYx+a+LfeWVi?=
 =?us-ascii?Q?Heahkj9MMs2obdIXZ+njpAxdkjf5xwt6Nq21IqFywyoiiLe/sl5VavhCtLla?=
 =?us-ascii?Q?NycnyHPQ738PIHItXYdus+vmnX/TWPFYAlQ206NLGYm7Z4K1xJqOqrk8ljBA?=
 =?us-ascii?Q?F4ALEZyfsbLjHlQJA2yorP6usNl4Nfmr7xVObrmM6Ty4KTJhDdrPPZm2K19d?=
 =?us-ascii?Q?F5PrwskgGA47dXx7LX7eUmhhow8NJk3orLxI9kHOt000NkshnocvxJkRDFTP?=
 =?us-ascii?Q?lFC5dYgTczlrGD2aqbNv2NRSvUQqDZUznw/IW4/PEAl+jUDk6kPNrSl6qHM+?=
 =?us-ascii?Q?Pa4dl/8CgLieOvvunGc2hfp+cqD3Ybv0d+byn6JXnpdiEbU72KMCJncnu+sj?=
 =?us-ascii?Q?gocueaH+BsNe5Y9MTZCtlnvadSjouKpVnRaeDKoARJq0LZASWLGQhFFUWtZ/?=
 =?us-ascii?Q?GgKckPtpwJc4Y+mDeeKR52I5v3QDoXSP5rsM6fPs8DYOK3IDHPY/eJmbGrdE?=
 =?us-ascii?Q?6o7i1lWGPF55W9Y2M+5qIV5/oJiG8SwVVYjqV4dEJOZSmuZViFKF0Koj7iE1?=
 =?us-ascii?Q?PJvbVlvK1WDF2n/4JQbjvRGa5IP3ISRSvvumnDmghr0/H0MTxdo4HXikxJVY?=
 =?us-ascii?Q?JDZARePpzATQ8hbe+cgN0dad4hwhjaDET9EXsr0zkVWGHL/yaWbTEbd0bhSy?=
 =?us-ascii?Q?MqV2mNmwprm9DSMuRE1MQdMTO6HPCMoY/BWKqByMum0oYN4ui/kbuY5jwfol?=
 =?us-ascii?Q?kMWfJCcCDevrz/Wo6pJsUx3Zdw0P5HAN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z7w7Svq8A0kgvsEgrOHV1IyevOrTKB9NaRba/hYM/V4MW2SbXtrElVEM8g38?=
 =?us-ascii?Q?WUV+xGusaOsMJ4i6k6/qdB+Frm+jWzhsUkova3E5kZYNqpWURaaLZ5y5wFC6?=
 =?us-ascii?Q?Xt+fqCAeuS7WzTiTcQ0j+ojpNlBsTNlxMFLWud4yq3RWZYDJCRiv58IIOlFi?=
 =?us-ascii?Q?281wnb1bFZynFY9I9ywDBKlk30Hn8XN2blyah2GYSguAeD2O8DlV6zzOqdoo?=
 =?us-ascii?Q?kuZPDOlKXZ2hHcTFOLgNpL/FAwOn2f5MM6GB6CXMzss6aIypXwUMfGabm0ds?=
 =?us-ascii?Q?FcByp8/jG3zXlTUhirmZ5r1HkM/H1f4C0mivyVG2f2XeqKX/rhlgVzfFJzel?=
 =?us-ascii?Q?gfSb+FyZU7EECmRI1KbSvTncPnmPceWugkx4tyHIWVFcNyQCeAwsvU8ZwNY7?=
 =?us-ascii?Q?6OdD5k+HKZV4jF7BDc0n/ADLpmaYQ9L2RNvgegRk8kU2RBfPfqRTki03guOM?=
 =?us-ascii?Q?kFgtppptRisp8hFSb3ju/MlZfOU5eoBqEi7CbzSiGdFJLgGLVDY7qe+d8gji?=
 =?us-ascii?Q?534K6qNb4egUuSsAS3YpNximqyaetut6/sl/aumseUEZ4tpu1eK3NNBcy0Dp?=
 =?us-ascii?Q?rJ9Ti8b75ExJDu+CLagA3jDmg2oN5NbL5jRyvTamN9ElRbYCpbN4c8MyvoUh?=
 =?us-ascii?Q?la16+9UNebjQnN+si44LASXx6+wlqdIpK93P5lu9rBu8BWMyc8+GSrC0QurI?=
 =?us-ascii?Q?tYeT9aEGccB2I0vtegm5tEHCfhu2vp8RU/tOJh7QjbWi/3FLsKhBlqRX695t?=
 =?us-ascii?Q?1hcAxkLM8rqwLk7XLcUb8m4++GnBOGQVXGS+T90DD3gR4j4LAoVmZY/m2bYt?=
 =?us-ascii?Q?jLxYL6TvgN+gSDyPERqGlHTgHF9KL2ih6ifIpZdpVZpBeL6jwSESmmV7icxo?=
 =?us-ascii?Q?dxDd+BJ2Wwo19ANO9hCbkn/3CGBGNY7bDVAu6Z7vSkMAUWP4/80MALNrbvM7?=
 =?us-ascii?Q?cpCjDpJD4hu9Qq44wTD2M871c0lMl2FuqfAZhKtSDlEvrQkcWA2Qb5+nPuWz?=
 =?us-ascii?Q?fHg1DY2eKaAXnojGTnQhN1MU+TZUd1CoUR3sN7JV/15FTU2bU5J7vNQq8NdL?=
 =?us-ascii?Q?7heuZtvyvoZu/D/9cnfxbY5bKCijZ3L71avVgeYfNkRGD3PVaAtUTJeLYgtk?=
 =?us-ascii?Q?ta4DFciXfhYv4kdTv4zFaxPAeL4UAD8ws0i40rFUu4/gVo9GMF0+FnZNbttZ?=
 =?us-ascii?Q?BY5ARsUyb52nppRPvQEjN/giljMnPkIHG8+5Qd2C4RyLKTUKWwPow6VFXD8M?=
 =?us-ascii?Q?mJg+uWy/S+QLQwfZSZs9vqyV42H+sBVoSi5TNvy7QG77fVSRQ9ClPlAf4mo8?=
 =?us-ascii?Q?EnuGNHQgwdk4ahovQESoshqdUL57Bgy0cx0CqM2p+gvdK2p+noNl1T+xdvw+?=
 =?us-ascii?Q?rpftgZWgBztX+gT/dKDIWs9JfS9DUsafdkITQL67DPbuHNICKhvPtJY/v8/X?=
 =?us-ascii?Q?3WTUkc4ANG/LJbfxOKS5WKkj5vzyp4/TExbX3rxQZMHiX0+j7AJFNLXrt6e8?=
 =?us-ascii?Q?sSh/ZL35ncMM6785SAHusipAV6xMdjPO6sc+fV/CTjtXm2pIFYXpH559hMk8?=
 =?us-ascii?Q?JCfSzq3e9cZfOeWuNsbKDA7t0KLScgAKkpuYodWM3t/WSq7oZGVpibIdDGoa?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646db692-d665-40c8-2123-08de0bd2d4d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:08:47.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9NLe9feUaEQai/YjHZm8ab7ukg/oFEFjeAtX9vLXfZhuIspNSKw308cHCW1GblVDPAaFv7a9xuVNrV/VcA8wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 10:09:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20178

On 15.10.25 10:53, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Sorry to jump in here.
>=20
>>We may have a kernel configuration issue here - or a real CIP kernel
>>regression. Going back a month to a passing test, we got this back then:
>=20
>>"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>=20
>>[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> jobs/11344068159#L1724 <https://gitlab.com/cip-project/cip-core/isar-
> cip-core/-/jobs/11344068159#L1724>
>=20
> What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).=C2=
=A0
> QEMU IEC test jobs have always been quicker and are even now.
>=20
>>"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>=20
> As far as I recall, I don't remember the IEC tests run this quick on the
> LAVA M-COM. Apologies if I am mistaken.
>=20

Right, I looked at the wrong log:

"The time taken to execute TC_CR1.9_1 is 304 seconds"
(https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11344068162)

Still a bit faster than it is now (448 s).

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

