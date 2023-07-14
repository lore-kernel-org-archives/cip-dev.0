Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05876EB64DA
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 07:26:52 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.46])
 by mx.groups.io with SMTP id smtpd.web11.13556.1689319606080425609
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jul 2023 00:26:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KZNhxn52;
 spf=pass (domain: siemens.com, ip: 40.107.22.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4DG4GCYxGFubYb2klslOVwHlsSvGpyngYijlTeLq5+H9feAHanRKxsjGE5ENCPqXahphqektj0SZYxhqX3/nkLOTC8hHI3Km9vzKVWJkX/rLOpu6xWGD257HNx7wnW7jDFKMLBBlBRHqLQxL81Uco0oQUxGB5uNtcTAgBmB+TDqq4m8F9WRcNGwnl3aFFQ/Ym3hxdh3pA195cEsOzs2TlbivoU3qWlx+4U6WHbC7p/aQEle/xYovZF+8PAMboNg5aE2yh6v/k3FtrhU13H+jYmbQLkQjJlwvvH5qkLearc5D/3fkww3P3rszzBMbTiwFnEsI2NROSAasOAftm4sdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI56lqFyA6nYbqWzYVgrGzgsXgcs9oEYtGTp52c/Zio=;
 b=Vs4/bI8tD6Ge9vlzrmHsJk2RAFz7XY/ZljR20DWMsXlocYOO46gyhaq+d79WXfb5JsVxYlswghmZKVwhCLk0Xur/hTiMMRpL9XdU8phf8+er96+c1fQmbYiyH251uLYTocF0SDB0J2VTiurwfeZ5wl0R0DT3CslKjWCyW88V8DBsnXlxVoIc37uO/zcBxfjEeewosGpyV0LHUljpiH2qgQf57amaNX33xV4Ml69ZU7G/1lQT0H0xWSy5rvhZI377DQgcBIbFj1S5lOKJW8yfogtdDAZm7IJb9KauHIYiAUHGrGEKHfCc9c1dJFGidGJ1c/KW6X1tnYbiNvlv8/rKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI56lqFyA6nYbqWzYVgrGzgsXgcs9oEYtGTp52c/Zio=;
 b=KZNhxn52+TJ6lj+mYXAsTKB0UpiChNhZMBfTKAg+YvTNUfUWEzdNhbDBm4lCckmiCMYEDgeTtqv7Wx68Knu0oxuxpfeMCXabFCro/fIEMrVSKqW3OZghncNzTyoB1p3ncuKVw8oNOvEcPSjT3lm3P38nnDamDRhCEMh3eYLc0/SWGIflB8zhaW2cAGzFcFKG/ENqw1m4fd3D5VtoVkWI5e48Ob/2jx0oYerJi8wxzTnA/H/2zA8iwUnz/0BtT2wrFczyYgXjh8F1d7D5QDwCOFi4hcB9fLfMpo/8GDhTL6p+Da7lEsXhNskLiCL4JuLj4rxo2/H6URcayXYwjx6LgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6805.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:335::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 07:26:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 07:26:42 +0000
Message-ID: <c18cc7b3-0f80-7b0f-97a2-87453c4a3ffa@siemens.com>
Date: Fri, 14 Jul 2023 09:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [cip-dev][isar-cip-core][RFC 1/3] recipe-devtools: Add recipe to
 sign SWUpdate update binaries
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
 <20230713164055.2786350-2-Quirin.Gylstorff@siemens.com>
 <02bb2692-307c-b19f-8d47-69fbd59acbb8@siemens.com>
 <52c24fed-92e0-a24c-515f-028b57202948@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <52c24fed-92e0-a24c-515f-028b57202948@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: ebaa48c7-7255-44eb-e691-08db843babdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	30IB7hzQglu6HQUX1O6/NsNVs225gKT12qzDTTARAV4nuQCDos3FZnZ9PWztbEtVASaMr1pb7LiTk5P/bi74ZXJErF9GW9cLHRjr2foNsaptT3mbm9V7ad8UVpDTUxRyxqW6EqMndmMQx+0ynN8+VvAjiNkd3Pw2vvJFf62XjShdyxJe6oRkNEPPOljnqDwk5XhM89+lupRrg7l7xHc7blxxOWnKApuQjgB6FJBbKC0q4hdoSXy3k4rmrp1wvEZwnNLi7+y8NxBWF5/K4T2C11HfIsLrmL0X/fWnLUf+CouOr8VRWYAftB8aBhlj5udRKyPI8MV6bHhaQJx4y1D/CfXSsl7OEuLBkwDSkg7Hn8E8yDxmgP9XKUwyqDY9rNxoo7IeBG6/2LyNeMm6v2fNwE4jF9gXpSdr7RKQFtodER5JPZpVF7ElJO8FAo1tqmjCVPu8+RZ1A9B7l4OuEuePqBSMTVQaLY1wnsOq75eJHyUvYXxxNaxONNwF/gZrswM2op5EeyU9f6WoegMKEflIjsMplDEWnmBXNbK7DSZ97z2U0y6MOBHrUSGa4NYoLhrOHH+cfQ7Q/brRP2k3TGS9Ft5HnYF8ic06gM+Uw/YLWzAHAZsHTsJ4VqQocKk8PDwr8wHQ3RPSK0luzVArflYQGQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(15650500001)(41300700001)(44832011)(66476007)(66946007)(66556008)(478600001)(31686004)(5660300002)(2906002)(8936002)(8676002)(316002)(6666004)(6486002)(966005)(6512007)(82960400001)(26005)(6506007)(53546011)(86362001)(31696002)(186003)(83380400001)(36756003)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G8+4Toby6zHMMMT94Bew0j70NuDers2T+LCHOXkx+zpRA2LqMTyeKE5sB65a?=
 =?us-ascii?Q?qMu9HUQQT71G4E+XfaUoQRkUZ/nGa2XvI82FEmkNW4xOcsJIQ5wJ7iwuJklM?=
 =?us-ascii?Q?WHOufP35pHvT431g2WFnwoNyro8uqQv61qPOPnPXNkb/rZhdQMik6cxBpqqe?=
 =?us-ascii?Q?AZgwUKEK337ZMxDAXX+Dw2ySFCQ4PTTcv+svCExQ1k9QQxZRh4kZYzSZR/4r?=
 =?us-ascii?Q?BnIhIXd+JRaCASpVzpzJ/YJ7+34tfK0jIVPCVG9YlrPC2Hspr6qZL0+7Ihwi?=
 =?us-ascii?Q?JkMznHBC7bPmddYCToxE/wvqkeOq5A6BCoDs0zrGMLzRFHRyEkMINvFhGgs7?=
 =?us-ascii?Q?1dFUe5IAolAQm4s95jKsbC0mC1peQBFJPrGx3WRtf5qSHj80dgyu2F9J3P9G?=
 =?us-ascii?Q?3KXw3TP82A1IqTPJ592VeOKz/atC+aeZs7NsZj308ryrvGh5lWgcPkPLn9jo?=
 =?us-ascii?Q?YisvORvbS23Okt4NVbaquf1Sy8WhtCh0zKP2rap1+WuY7PFVAhiUboaUPuff?=
 =?us-ascii?Q?LSh2JtJEhWVCByFtHUYog9Xysw8rWRe6bil5KmBIPWJwtpnlq5CgS4jr16mI?=
 =?us-ascii?Q?6o7meffmt9qJmbkJ+8d1TNujUBzjTCAI81LZ4QsiJlVIhr6fwyC7hiWwt8pQ?=
 =?us-ascii?Q?UIBzQ+Dm34GYdBE+ismNYrjqjBakzgaxKhYHyoTj8kYHizLgb9XFuEsdubK0?=
 =?us-ascii?Q?wssRZt5cAGk1zrfBpVpbgRlqkG15GSxaPXn4eQh/upCQWv4PPT51oJXtBt4z?=
 =?us-ascii?Q?JA8SSDSA9qlkkEulKSfDktYN7xwUqlMYrIAPDiEw4AnGIEeDAlo/F+hlfwcV?=
 =?us-ascii?Q?dFeW2xgtzF9VDQOyAWCObu3vejdssO6lG/soBmcH15N9r6zpswe5vAV1KozV?=
 =?us-ascii?Q?xFTfySV5aWUgstutS0S8YM0eu87+OIYq3BvjvTdoAdP04kFWksc5Nph1/Ok2?=
 =?us-ascii?Q?N6HRxTU2oaEfJays4cj0Hl4EmF1kWyLYNntN705U6GNNmvW11pFjLU7axrLK?=
 =?us-ascii?Q?XzSlOGjM2RJJcWF0Z0kw4VTcw46UJGlNJiKszS68HM8ChUjzyRCoHy1djn1k?=
 =?us-ascii?Q?Tm2HJaVFGbnvpWeRjQ3UKlW0n7k/lvXl+cyDTZhgLiDVUfZ32QJNnh0cTDlT?=
 =?us-ascii?Q?y6Wd4Xlvf/KT7YTzHZpUpH9qZ9dSS98AvZwrRKWvxaR/L+G/4VFvbyMLvhu7?=
 =?us-ascii?Q?BrMxtbyq8eQTRJ+F/jNWegg+wDjatwzdby+Nw0FRB0a59BKFT5GBn20LhRw8?=
 =?us-ascii?Q?Rrl1mCkesIk2l4Pw3uYed/b+88NqHM0cXdzopXcQ83Acx5g1GjAiURNvBCFx?=
 =?us-ascii?Q?L3MDogWmBPVk1jWYuHd7tP9gGDJ8BVUWVuZdSSrypMl0I/HA655vtpou25cw?=
 =?us-ascii?Q?dFTA6SY5QNfB6ReMCGdc17LAofkJt06m9ZtsXNU9iMjocq087O6EFp5pRDKe?=
 =?us-ascii?Q?nWH0skIUEEHii5KvcWmPma+wyBVhA133VuHmOtxYdpi2L3M1KDDH0KWD5Nb3?=
 =?us-ascii?Q?niK9hy8VPXiiTJyzEgUlvGT6OxTH6yoKmLGSYqAP/KrEJw3yfq7QrRowch1/?=
 =?us-ascii?Q?8jvssmCz4yoPS5mQhZxuOBuvmtluQyGTUEiwg241IVUF04b73nE/dG/AHnw5?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaa48c7-7255-44eb-e691-08db843babdc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 07:26:42.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DriHe9dwhQ7z1240mv8qXkHmAPb4iHa3X2+afo0udaWZDkyfdS07idGz3zVlvrncK7tx42cHQf6YEbw/AU16+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6805
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 07:26:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12344

On 14.07.23 09:14, Gylstorff Quirin wrote:
>=20
>=20
> On 7/13/23 19:03, Jan Kiszka wrote:
>> On 13.07.23 18:40, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This adds the necessary recipes to provide a snakeoil for testing
>>> sign updates and a recipe to for offical certificates.
>>
>> Several typos / wrong words here.
>>
> Will fix.
>=20
>>>
>>> The certificates creation can be found at [1].
>>>
>>> [1]:
>>> https://sbabic.github.io/swupdate/signed_images.html?highlight=3Dsignin=
g#usage-with-certificates-and-cms
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../files/cip-swupdate-snakeoil.cert.pem=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 30 +++++++++++
>>> =C2=A0 .../files/cip-swupdate-snakeoil.key.pem=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 52 +++++++++++++++++++
>>
>> Are these different from the Debian snakeoil keys? I suspose they are
>> for the reasons you mentioned offlist. Please document them in the
>> commit message.
>=20
> I tested it with the Debian snakeoil keys modified by isar-cip-core and
> it works. The question was more should we copy the keys into this recipe
> or do we make a dependency chain to secure-boot secrets.
>=20

First of all, you can set links, rather than creating copies. And then I
just noticed again that those secrets are Debian release specific.
Please check that again.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


