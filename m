Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E50C25B47
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 15:24:07 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.75])
 by mx.groups.io with SMTP id smtpd.web11.9652.1698420239008246840
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Oct 2023 08:23:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=My0C6KwK;
 spf=pass (domain: siemens.com, ip: 40.107.15.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4pOgc9ofxRsIPMR4eIiWHrjGwxsPQ4AFnV3XGEXhMSMJPufLaeoAHfO85Q5AZH/9JYo9SPOfCNI80ZaEb8E7u0qw+yepY/XDk1BucWLVJvrDMCXAaDT63XRx/ml5Eqt8S0fMrbYZ7+fQMmWWEaL39YoCRpyLEZDfuz2ieeo0JotvRNf8svonBelWZYSmJv3r2Z875E1UAs7iPXSxXCUxetXYn6GNJ6+Jc15DwvK8Y8h8xlf2+j7F38uV7/qW6yJ4BiyEfLyBzDEYb+PWR4w0nyKUVkaHa3JbmYpDAWF4nLbXvMgwYOgBImsGKpSBlSt347cHBtg3eB9le3tpq/uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y3D+6VY8icS+0L9bXaS1lF6iuOV0ccNwHh8d5BujQY=;
 b=kl7DFTnYeNx+fV0k6EipMBt2+Yb/uE/eHLy3sg3Mj0KODfK6wKYdH+3QPZLv+uT9T3nD5t9vKwHI8lf/Gve0zDxdRhmPJSKVLfEXe/W5HpA2i6bfs//i5aL4YNWI8hvm492XLOdrFEGGQ+Yq9aumqnAK5nOjX1Fjwse4NnEybbssappU/hmrsAWyU2cvF1PokgD8fwnI7bPW/Kqhsoan5317Pa/Yy9f1NQMgS39/llxTO7zK7Z8By6yBAsmRAX1Nre9vGjIzExQ0Vg3GVlX5XWcqH152nb6ts3W7tHsU5e2sVdXEbLBvCjwmDShPs89HIZjpiTIajS0LNh5LTJSKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y3D+6VY8icS+0L9bXaS1lF6iuOV0ccNwHh8d5BujQY=;
 b=My0C6KwK1gqxNUCUP9nX6OLZ0yVZ/HmtVlScvN+iWRIvmNv4VbKdK+JPYUw9oT3dm7UxnSLILimTZlwTVx3wgS3xbsVKcvY/q5aUJMk/Zfxsehd4vwI2tYwO7eY515KUUNgxG3Qu61fYENDDvUsK4zhaxBeMIfkmv+rMGPLFr/jH/X6SH0hoI5n36i7BR1oA1R/M07hQjDk1tkozMnwL8HVPWRDTK1/zmNWlr6GWPFbzPNt+FUQcli6sNfyroI8QmOyqH4CQ6eV3H09oYkk12wllM0zM9OCvg7PX0/L2TcaAY3tEyxQ5WK+II8EGSz8pJjcP2Ov10X/XZbfpawYi7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 15:23:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 15:23:55 +0000
Message-ID: <279e5d0a-5cf0-442f-82f3-db84db63564f@siemens.com>
Date: Fri, 27 Oct 2023 17:23:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/3] Enable swu file in repro tests
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
 <20231026082959.16939-1-venkata.pyla@toshiba-tsip.com>
 <e522085f-7a17-49d3-b4d5-61a01c847ebf@siemens.com>
 <b19ff39b-91a9-4497-b467-0c2cb4044d54@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b19ff39b-91a9-4497-b467-0c2cb4044d54@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:610:55::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 894fdf25-4939-4db6-7587-08dbd700bbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JCYsa8x3F2FpKS9e+QISrf5yPjFBmimuUBfJWnxT9gtcMr05e4rbUELaFWLga3G3/+pGpiSuLGLiS8hwnkpuJrE+j7pxV3JIMdMefAeA5ndWqfukd4im0mKK8ZnkUgn5JF+Hwb6iYGJrk/RFgrzTFEpCgFqNDoYkSuPSzYA5kHNY+SJf5tSVftCMQ1cxpCVOFClB2bM1DzV9o3RI3L59xKluxQs3sh/0/jBA26SZUsBnZFEYONlwtrQZOhGdFEA8qkG0c2xiJ8QAPwbws5WK99LWmklHzmPD1/FViWTL9DKl8D44kIjclhQamQTsZrzSs8e8QIaeQuL9YDd0Xa4TxHJeFI9FbKc2pADo5pzehKBOdRcJYxG6UMsVGxpsNtmcL/TvEU4Sk9d7lbJ/FrCQrRzNROANwJU7qifS+uMiMdQof8u2GsUQcDJjchV9kZd4pW0xlgwj5WchIcCszw/0KL0NGqZjwp8pDEn8Z3RBBhTR2p1pvg5utHPyRzRg6DIizU+g5hAldE6ISW3KtyLFVw+9td4v+3Wl85e3LPLCHlxIpBmYJXHw2RguwS4mMnpt9it3RhKBUnDENYR0eG/ZeDAyhdDIqXF7s0egcp9LUfB6rnAPv/QG/iqQBQUStUU4/C9XvhntwFACRT3eVpliBQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(38100700002)(6666004)(26005)(5660300002)(83380400001)(6486002)(4326008)(66476007)(41300700001)(66946007)(44832011)(53546011)(6512007)(2616005)(8676002)(66556008)(6506007)(478600001)(8936002)(316002)(82960400001)(31696002)(2906002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i88CF011S9bWDDlBs85mgCT4feuh1+XtclAmJe0Gfi6DmEQGo/NSQcztWwNL?=
 =?us-ascii?Q?RG+rqaEa4BMfNA1MQ3M+LWIYv9Kl8FpNeIutIQI+P9auqKDHM2ctUXuEuFVV?=
 =?us-ascii?Q?JGymW/86VznRNLpJBaZ5/oanJPWEsu55lO+2Lkyj7DSRKuDvO6JB1iiskwdU?=
 =?us-ascii?Q?BuhjCZjcjBIiIbETKJUt1D7dyOgq0p5nbIbnmK8h83XCT7V5E/6qr+8ZFjki?=
 =?us-ascii?Q?kG0VNymLmXdeyL/4NViTzv0Cv5IBAGmux1w6TyzbD0pikH5WT0kJHEUEZZbY?=
 =?us-ascii?Q?qS9VFQn/jvYSHb8iFref1CmQBGIePs4wp7IadmG3a1ysZZ2O0E1JQkrLB7xR?=
 =?us-ascii?Q?N9aobIloS7Zt10m5FrI4K90cSyx7zafO49Ah8J2FT0oJxbRabZsovsUEbNow?=
 =?us-ascii?Q?8Il7/iGC9KhFFD5crPTmTfES/0N8SnT+YBH8RMH1neotZVMmLht3WMMBAZk8?=
 =?us-ascii?Q?ROEkCTdREkcTubu6ZiSMp2u9XrIB6rNyxRETlm/qa9nhQMy9KW/m4W4SjZpX?=
 =?us-ascii?Q?g12q7sMEthKysRst5+ip46GVhQn1ggvkveV+kpgptQSQ+SBHMuJ2AL+or+6b?=
 =?us-ascii?Q?A1JTyV8tJScaKNn+mz493j9VuxoA7jVE+ULeVqEaNXLqR3euWOmuxUJjynlW?=
 =?us-ascii?Q?VVBB69AydqGThprcDzQhsZYjPkXAvKcWrCBXEJfT5MbOwf3On2pcotfvbrPa?=
 =?us-ascii?Q?CRZUpB7jlc2qK/Q1cQBUjmDHUxa/09XUGbZVp/48CQuyH5zpOlbLEpKMdXn1?=
 =?us-ascii?Q?8GdSL+nZhJJ6rmr0bU2Grar6hBm7/uV00CRJ4+8Upd5NhwE3uwOY+acLLcoI?=
 =?us-ascii?Q?B9VvsYRaYfCWj7+jLkBHpmmCoexY4TuvYDNm7mQZnwhk54VSyRXIf72bnIDW?=
 =?us-ascii?Q?6/BvJ+7b4Km2PF3KHLJqngu5whSR+60kYbIelbU1YR2QZ3EGwx/8uifv3NUm?=
 =?us-ascii?Q?uf3A9mAJVpBrbsCW5PXAM/+PQ5X7xjUuGluvyBQdsVbi7sL/AscKej4mdB53?=
 =?us-ascii?Q?5ETWryMLW7OnDjkyJmejXP93WhQw2eGaQ/d5E383ZL25IpPSA5qhTzCTD8cb?=
 =?us-ascii?Q?i2gSkW7Bsvkurfbkwyo/XlwVXnzeh7tbKRgZztW6WLXpKxhnTFtvo3T2eQfN?=
 =?us-ascii?Q?Xg//pV1AP444f1RLcXrLGFf40nhsmYEfBj1SPvlp7HkkEhdr94KYyWZriKgQ?=
 =?us-ascii?Q?4GHBfGKrXmCBV3kzlk+osCQ23GPfjHS3+OskM9gnbrqjTlaIH/xHRUoaoTUy?=
 =?us-ascii?Q?wowV49cEtNtGVIH421T6KnrALAMPUEovnYLM97GG5e3hyIxJ2beJx8AwxMfd?=
 =?us-ascii?Q?Ml4to9lLiiIKM5hwTPG7Z/4HGvWExreblGN1H+la8IgsDKz+bfZF+mxGdPLg?=
 =?us-ascii?Q?DRmuPytVNZu3usOw6sEwOa4VcHOSNGKDw9PoarMqXovl5ewhboRQNu5f4/Et?=
 =?us-ascii?Q?MYzYW9uiAqEBC7csI7+X6ckG1KT5m2pJas1EWjQVTxrN9GH5WqSWZSZkjDRc?=
 =?us-ascii?Q?fnJpUGAXx4PRYQaNI0Z3/O2r6fgWZJCWrSgne81RfcbqzLaZffHJiHAJIsP9?=
 =?us-ascii?Q?EY/3U1TZ88t6mYowgL84bxPYwqrZG7xgLZSwpYO9cckaO5Oo/1yNsYKra+th?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894fdf25-4939-4db6-7587-08dbd700bbfa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:23:55.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o7PQOP2eABtzPRiMqyJ0Gp3OqePyiT2V4wn74zVvSnMSO/rFeqjASP0bLlSoUXP1foMVgwdc3RlO4OdK2W0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 15:24:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13485

On 27.10.23 17:19, Gylstorff Quirin wrote:
>=20
>=20
> On 10/27/23 15:43, Jan Kiszka wrote:
>> On 26.10.23 10:29, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> Hi,
>>>
>>> The following path series enables SWU file in repro tests and fixes
>>> repro problems in swu file.
>>>
>>> repro problems in swu file:
>>> =C2=A0 - signatures in swu file is not reproducible #80
>>> =C2=A0 - linux.efi file in swu file is not reproducible due to file
>>> timestamps
>>> =C2=A0=C2=A0=C2=A0 are not matching.
>>>
>>> venkata pyla (3):
>>> =C2=A0=C2=A0 reproducible-check-ci: Include swu files in reproducible t=
ests
>>> =C2=A0=C2=A0 swupdate.bbclass: make signed swupdate file reproducible
>>> =C2=A0=C2=A0 swupdate.bbclass: Use root privileges when creating swu fi=
le
>>>
>>> =C2=A0 .reproducible-check-ci.yml | 1 +
>>> =C2=A0 classes/swupdate.bbclass=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 scripts/repro-tests.sh=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 3 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>
>> Looks consistent to me. Quirin?
>=20
> Looks good to me.
> Quirin

Thanks, applied to next.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


