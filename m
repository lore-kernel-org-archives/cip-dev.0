Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA5BC77B61
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 11:55:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.52])
 by mx.groups.io with SMTP id smtpd.web11.48634.1682337335904210849
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 04:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tXSBBLhy;
 spf=pass (domain: siemens.com, ip: 40.107.20.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyQinsmc+wTPFxN1WRDmQNpFHyVrXltERG19+u4XJOix7aFAj9XOE5J3zBBn80VDhJDJqpmYBv4uD/u4C8nSfJ2+nTmpBRGtRqOUgOmhvAPRQB0KOa7wWbOT+1D1Rxn9zO7Tx6sCe81XKh0jIAiqyvJFULc0qA6zfSeLRItwkeMfZCLsZ+ullsvhOu5uYPz7XmftBQW7va1wAbdwn69po6KTdIE8N78MMPWfZrdBFrIQl/Uuo6qW2E+GvmkIGVvYcAzy8M1ZiiXmeX5XOfFWqLw+N/Dd3MdEzJDpmM9Zw24LzzsSRGfyfXNjC5zjt4GFRXor66Z8HEjQbSizeJuJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9RjygJKxxHAOo7KxMLIjvQux+cJnMm3gPOwVqPlwO0=;
 b=Xx5BsdMWtjSURvDnXJl/6H69LsEzE/r/RHPyvgOWMNmlKGS2H7SkMD90XG+Zo0+SaqoqnSSOf/OjRvsM86JDeuRdgnEsiYh5n7+/NnsazXnuNMNvvsu8I1MWKo5vx/Be2QxJ5bj83MmmYb93kfZQMw+oenkM1tpvgtZjyHqUX9mOii0Jd4/ef24zA1H391MANyuZUJrToAxpbMG/w6XPIHdVGKdO6Tcol2hT5bmokh6H+BX3rHko3kEeqV8p06YzoJRPq4JANrbti57+yp1hJ7M1cyU18NlwoQhsq9M0rTkq4Tkhm+iT8SiCBrA38A/fp6avxHK3SPGpO7jlWApmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9RjygJKxxHAOo7KxMLIjvQux+cJnMm3gPOwVqPlwO0=;
 b=tXSBBLhyOCKLVzIKsMUb28vGvWrSbKegDJLkY0ZPWP2CsGZfEwXJVx1SeAz5WAI4+ukDh5Rsg35pqwtR5YPFlQrncPRMEgnKjodh5mM5sRUQlRDmyzCuXos+HrxWBY3aK2Pf3Ok6xIhxerPORX4ODCBgpqecRMHwhXXZoIAk5aA/KsUA+v4Yq+jPrkw3IlVCJ9NflAaS/sTS3wV3HxSt9RKjQ2vqo+GDplJvFfuh5dfzkTiU9coq4h3z2DBuO4XNDw1ey0fD72cRh+nirMGk3faWk5R6xtdu0BnumU8BaVh7bkozJ8/cVcnwjuIOqxhX+u637THQ6H+AGVHeRTv2Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Mon, 24 Apr
 2023 11:55:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.019; Mon, 24 Apr 2023
 11:55:32 +0000
Message-ID: <f953661c-d50e-dc2e-e0e2-a619d9517154@siemens.com>
Date: Mon, 24 Apr 2023 13:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] efibootguard: use debian
 folder from salsa
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230421141330.3905234-1-Quirin.Gylstorff@siemens.com>
 <f4ec927f-5d19-48e3-84ec-b8dea9b5c13e@siemens.com>
 <cb6b51f2-be45-d758-e718-c18fdd37c4de@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <cb6b51f2-be45-d758-e718-c18fdd37c4de@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM3PR07CA0134.eurprd07.prod.outlook.com
 (2603:10a6:207:8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3999:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f31d45-942c-474f-0872-08db44bacec9
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IQhRZH08xXwHcyo5Q9r4+JpGGHOEoBluNiekw1TILOLWMJHzBtlpYbLseFkiPFc+0/ATEZeK7tkcZE90ZGRsy44c1BVMjqzBu5H5zOVQOhob3gJi9+d7TxOOezQYTQCEBRUZ/Re6U59kqzsh2Lidn54B+8h5SPsxvnKbOWGKAyegzSAWhyr4bA0+RyPLRP2YCILwqZzpMKGeXbR+J96nnpcn7OsEi9fou/9pBsGtsQfYxqVUTrBY0y86btCAvQ6AntQmOb8ZuAE6+GS9neEAXIGbPkK4gw8vNZFFgGqIbiW7z8DcZ/VtstnzGf8Oo6Aquz/TMfnD9/xnHK2ABb/rstdFeHHYO1DofQ6KEtzv8lP9zpc89yFXUXqdwsVext/GABtvMWhY2quQzuTgKB1iCVqNHj7pylWJRdVeXeG1oqC/ZxaMWH6ROoISOBGzB4KhWo9UeAtt+TW7Qb3o/yN5n7FAI0IUQhmDjWNJO9qD1mePNck5tJUPrltyvvlom//1HUNqq/eXUikHX4b3jVC3wG7t5KYZDUfR0L+1Z/NyOIY/t6BXg7MLODWO+eQi+FKEW2u/9+iHghW9oapAXyTF83wqYUxp1U550SYIcJFmMyIqx8y9w/Z2eiZksrZM8kZj2Rnvo8p+ekFTuGb55jp0YA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(82960400001)(44832011)(966005)(6486002)(66556008)(66476007)(66946007)(2906002)(6666004)(6506007)(53546011)(8936002)(186003)(8676002)(2616005)(41300700001)(26005)(6512007)(5660300002)(316002)(31696002)(86362001)(31686004)(36756003)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dyadeNXXz1gfja9oIjNPH+wpeiRjkIQDdZdkzwodvgbL6uJHxPuLI51Q31cv?=
 =?us-ascii?Q?ARW2kkbzZ5llV/1a7IiKOm6SNZEagfH6PBgMX/Unr6os2n9mc1f3hQ/dWm83?=
 =?us-ascii?Q?crhVEUenNi5Thie9VC2LQrRmaCylOK1NY4isllRLlIhd+LSKxW6+IQctlf7e?=
 =?us-ascii?Q?G7U1ZftdOzJZ0IkxL/TdHsVrdI4J8Ta4ws2Eh+oAjByXTthFVqWTq5kOUsBX?=
 =?us-ascii?Q?RHcrhrxcQ5y66kd6ycB4um7gMf7vEiup8RRLeZjJn4DPc7KTK73nULpe1yGR?=
 =?us-ascii?Q?tD284BA2HDq27JroeIIQX9fSi/oJyp4TNxG3U38ARTfedVdsObYFhp19knao?=
 =?us-ascii?Q?ua8dup71Wxhh1/ztMK+lpeRGfLvqjYq0E2VdI/A6SVZcFmIqUuJL9QU4jvfT?=
 =?us-ascii?Q?22Z7kdjAktUktdFNhx64FdxNkZReYtGwSZDbsPmi5tIbmwXOmtT1i+oVupKP?=
 =?us-ascii?Q?i1MmK9tZBW1ScJ3S5AVJ71bmDkKwUwrq1a+DlHszgDHrYZe5wPjdKru5Rje2?=
 =?us-ascii?Q?aKWkd+NlmaWju7z5lxUa35MhFDmzE6fbMTrRPF+jjSFnY9om8RzbF6cyX22s?=
 =?us-ascii?Q?BoIgh7sTNxAe2MXG8/oVj4pUCb8NY99H+VYRRDLas/l0d7DIxxM45qh1vE70?=
 =?us-ascii?Q?Dxed6xWhJ/b7dFkxbI/9OD7pB9tDQWvtrzrmRIwTqjjBkdIRTiqUkOO8lFAh?=
 =?us-ascii?Q?4R/hzfTSU2CM7YYgwPkot+nbzM97mKc6fHNddZK+cdRic0Vw7nFdUqqyzMPJ?=
 =?us-ascii?Q?kbIKltTdeLW4EcGoJsds18QJPmDmD9eSuaiKday90cMUclezmY2vz3dRxO1N?=
 =?us-ascii?Q?YStxlgo0t0t+pGkfxNUL32tQpUCMfoj0h7qFYHlQF+7NDaxdxEbNXOrZtZO6?=
 =?us-ascii?Q?8PwlURN+3oTocVD/LXzlZOvO3oTtWMtxwItnDf2BYy9ZDaVZsZwCsOJ+IqXj?=
 =?us-ascii?Q?7CCHY0JKhrxp/oxo7BskCeDRGgmOJGm40tlh8r6zvUPAorMRuzpCwTmHHGvy?=
 =?us-ascii?Q?gPxKajSGzpBVrBIA1+6gouh9sDP0HPIBUIz83d3B1pvDArXF2dq6IsyQFf0Y?=
 =?us-ascii?Q?NQxPIO60pBabT/PTdCjuwRHQ0UOhwqSS/by+MeIuLZc1VKEpHssosnfMrVJl?=
 =?us-ascii?Q?zRWmRYXubcwxRzf+ZlfPnW5w9JpCffEnbMVF0ye9BaBSx42C2aD44nBqfdff?=
 =?us-ascii?Q?69sxhFi4JeT30K1ZDKxsXzrUuntNApvOZArF8itiLEXqSdEonQKVVcQZ0/ul?=
 =?us-ascii?Q?4fotlXTwMDIMCRB81fheX7muUCFVXmS421uYcf/N/1U6uIFa8w7CUShr7f51?=
 =?us-ascii?Q?XixDoTpbgViaFPasvYcjtRTm8XTRjdPlJa3p8uB5y8m2REHvOOxr30829uAE?=
 =?us-ascii?Q?/0/Z2xwVlAV3FVgtVDKFNHPEFGbpM95UgXodhpnKDVF5STklFmyZdZ9TQnjp?=
 =?us-ascii?Q?SpuwkDnlaY1pXidJG5nKx3+ibzXTcG+3hQc7oYycxn4HPnKviI9DhDbUCBAD?=
 =?us-ascii?Q?uHQsbMSvn+cjmGfkv4LLHQdTdxKiLYqej379XMo8m+t7yacLyKFM+Moq9RFg?=
 =?us-ascii?Q?VAjvAKbsqOPC0Y78c/1bBl+gXcXV1M8dsohu2SIy?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f31d45-942c-474f-0872-08db44bacec9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 11:55:32.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHJ+DWv4b5lEHds6muOobCANsINJVck8mozXuMJdfXvkw/FHEUjGoRqVRK6tp7UkNR6kzd7FqDCs/WOvSAcpCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3999
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Apr 2023 11:55:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11332

On 24.04.23 10:31, Gylstorff Quirin wrote:
>=20
>=20
> On 4/21/23 19:56, Jan Kiszka wrote:
>> On 21.04.23 16:13, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> To avoid package name conflicts between cip-core and Debian upstream
>>> use the debian folder from upstream to build efibootguard.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> Changes v4:
>>> =C2=A0 - readd patch 0002-d-control-remove-native-from-python3-shtab.pa=
tch to
>>> =C2=A0=C2=A0=C2=A0 allow build for qemu-arm64 and qemu-arm. see
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/84458=
0247
>>
>> Is that patch also upstream relevant? Or is that only needed for older
>=20
> This looks like a conflict with crossbuilding the package in ISAR. The
> error does not occur on upstream as upstream builds the package native.
> I need to test if the patch is necessary for bookworm.

Debian does not build own packages cross, but Debian does carry control
files that could be cross-built. I've fixed systemd e.g. to support
crossbuilding, and that was merged.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


