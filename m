Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FE1E7E630
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 12:57:32 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.70])
 by mx.groups.io with SMTP id smtpd.web11.18043.1695733049803168862
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 05:57:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gA2BXU1y;
 spf=pass (domain: siemens.com, ip: 40.107.14.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3rFSTv7REykbX+pNNogUfjFg62B5GaXsNeQaIT6vVAXoId83iBQvEblKb+HBjTVBESBI+D2VkjJNNc741W6mNe78N1C9+VJdT+74xon4TT8o0XZNPpRNLTYrANf+JespwK1dT+BmZr4pcsOBjYe8YhUXyw/bgypgN3FaUOz4SBHW9oD0kPhtJ+Ls1+DxqumygiOb6xzgrNApUJeg3nKjdrwHLzjZz3NXN8rUNM+ab5fY5XHmG5jEAS23x+KzUVFe4MNJHzrRqMlozjDh3QPrX8Wx1IQ5mTvNKkwwzOE5xz4HobCCCDqslrOUVq2hAChSMp4p+A2oHi0BvicxtvQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YP5FpmlBreYs85Hqr+P7sVPR4+Jo6LgN2wKY5fAWJ8=;
 b=RJvfWAHI7DBKO1zJPd3FlecLHo3RZxRUpwFJ6/wl7LyEKjQXtv9b+ksz7UFlHSa0NwVZsD3XUyWPaLAMUKXcsx6N5nlMUXYVrx0NDX5o1BXDPX/Uk70fVksmlKjNLZVYmqlpEz3obP/UGvQnPQGM4MhMtASL1YeSAMwtymmguTJA8/j5/dJWohhnVlBvAsr3e5kk216p00r7J3HEUHnrSfe+q/HkfOL/2/xykONE7PumfDkfGDSqX44Z4xtTGFt9SwGJlR7+DQ7T5vdrr0e8q32pzebpOk6qERDQ1b10Igw1mG1sBlbDgK5TNc8caqgjlnqeKAZbsKW/R8MhRbBJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YP5FpmlBreYs85Hqr+P7sVPR4+Jo6LgN2wKY5fAWJ8=;
 b=gA2BXU1ynEJUypdscaCfmDEs9hOUHMgERC9ZhHREblkTuFrldZSCeMhz8spwftlwRi1DN28Ocf2I2QIBIEMdZ5mccXJGWjtyInzuWOlgWIkQHduJ7l7bQDB3sFrRo/PtDC8o5SzpyfN62eN5oca2I7W4nq/t9hPb88XkUeFRpOL4qu378r2JmaYg0w1eGq37E3H127+ajHW0L6E3pa1pG1XpNMrVWBVVUv5HfsttX6IxfjBJTFUMH9BJeTVWgWWF6UStcC02w6VaRSin8Uef7bufvTLuuCtsGhtfWC6SxQlJDV/p4L32lavZs1gEgwLBBofXNnRBcKOZcBdnVJcSkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 12:57:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 12:57:26 +0000
Message-ID: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
Date: Tue, 26 Sep 2023 14:57:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
 <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
 <ce684bce-a09d-4313-b231-132737797f21@siemens.com>
 <OSYPR01MB55424C7B8414E7DC51BA0B72A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <ccb993fd-4053-4d6c-96e2-1d182a9b765b@siemens.com>
 <OSYPR01MB5542F6668A8E93B4E2A1E290A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <e59db07f-58e9-40d9-bc8c-1d9d5c530749@siemens.com>
 <OSYPR01MB5542E955DB8A07738DE87DD8A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542E955DB8A07738DE87DD8A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3484:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0e6067-e88c-4a3e-2208-08dbbe90222d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lCbUOKCRnWoWlDwIGXIXmLZ9HSvJf/6vOezKciJztIZgkNArTeh9KpjmKmSg89E5Lt/4qKBU+ZoaAwSvaAKISBBsqucrGH138HRoU6770zMyzxCu/kZcYpkQMsVAdQ1DKUDL2rHdEHuHHsdpTfEPmYCCQsaVjiYRyZJhpH49Y7CMPSFyIOqwwTneObXLZCIb8jIM3S+JFdD8CF3tZNeFHbxTHo4X8mykqGp0D4gKx2iha91qsXAcxKKLPZT+gE0/b/dMhp1zveAiDFcj7OWYyH4U95X7UgtExcWRkwPnj6S4WFTuBkPwL5UxpDINTUjwik909JJtY/Qhg+6zbyPesPL1PloxZDKa3JkVXHJ7yD8FrWBsfaQRKiSc/jSEg9zCUZAx8N2l/Af6VVIY0rmSXxsyTPxeSiJoBzvbbnDM8rs9T2BrCR8p2wfJYH91j0s6xisI3e8iGug6wzzO+UinUrdH/MvPqIEZQ0eS1rHIS0MNslumYnOzVulfnLnnYpqFou4qizP3HON8x5pGpca+mOkrtV7iAPLdI+y/g+75Dv5/BI6UwYkSOCTlMizl1DyHvSNxSneu/5qq4G5VPj68q29p5zJfG4G0TtsnHXy6oiMOTzjHpLOF0asUv4/ExXw8kEbYazpnL1bzFR4P8HBd0g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(53546011)(478600001)(6512007)(41300700001)(38100700002)(316002)(2616005)(26005)(44832011)(83380400001)(5660300002)(66476007)(66556008)(6506007)(6486002)(966005)(31686004)(8936002)(66946007)(8676002)(4326008)(2906002)(86362001)(31696002)(36756003)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P+7vIG61UDpjQitkgAduXtYl9AeyL1E55xijDJLXe2NQPX8QPocZPpMzrzRE?=
 =?us-ascii?Q?suXSOTYDXc5hqTG77Tl33rfhE/N67ni0LhdkhD5v6w5Z6hwlBv4VglcLMUyQ?=
 =?us-ascii?Q?W5nw9JRu05y1SgdzYNaIAV1relpww6a3tA8dxDEA6fRQuoN3AufqpPMoTwk9?=
 =?us-ascii?Q?lEFc3b0jIT450F/qaeJY7lztWiZUkSmJQ5EIFtqy1oPIqpYjOnPASNgKWI0H?=
 =?us-ascii?Q?3WAAIhGKz7GAfeIoVMlFv9RRJ394tk8ZOxplOAJkSz4iUYl9dz8GxVBmCNah?=
 =?us-ascii?Q?R98v5cuXMcyZY09jUIU6P91+KnaAYbNZa0KtDoq85RsmV/EErUZ37937FePc?=
 =?us-ascii?Q?4rAYIAGKwwNwHX79pv8GYHMdtUDdt6RQc75QK0EeYm4WWXupUMCPJNDMnN5+?=
 =?us-ascii?Q?uU+4vd1Z8IVmVfaPG0dxZG0c9GBo7gCbGiONGQRWj7fOvkLPufpVm9J0FiQx?=
 =?us-ascii?Q?pG4GEinE7cpYXGVNQ4uyUPKPgLJBeNXqQJxobPfrDk2M7prVDauUK/xQ1s+K?=
 =?us-ascii?Q?YXfvUOTmh9HuKrrF3UAjoJcUTV4AxtlPVECaph/C2hwaAuCQl8CFtX1w3Tm2?=
 =?us-ascii?Q?1k8UIad13deoLZtRFnI1aA3IRq8QsPz/Gc61qYP1/M8bICyszNmqJ4J3G6xR?=
 =?us-ascii?Q?BGevtbHZzD+9IQgQ8j4mOn0dC6r5tyLTKSBteMGXtiwcZj3tHn72mUSZIrHm?=
 =?us-ascii?Q?1Db6vVhwRqq5f1sZVWd68UPc45DwV/AMv1GA6hj8R5FaQWMCBQhYsEQ/6gCg?=
 =?us-ascii?Q?FXz1MVtB3mSBgWLW8ppAvlJIWA/sFM6rstK2P9tJ2jSmXHrKPbbfyjujX0wa?=
 =?us-ascii?Q?EqfMcaNbe+wXBAXjPmki95ZX+3PsL8OA/SPsjLn/W7gq0fImn3xSqjE0kvis?=
 =?us-ascii?Q?pR6Ox09nk7Z+ggGCLASkNiXfyUjdhXZ0ge3K957E8EnRodBRfUgkvjlLnuAL?=
 =?us-ascii?Q?ywGfjaU8n93lqVJ6cH+dtR8DFMEzZkQecsa67WMvWa3mrB0IFNPF+zGg+oGe?=
 =?us-ascii?Q?/UNOHousoI6JZdzRo3iVt+udMCA1zTegT/NfYOLcAytrvNJqlz0lLYeIifMA?=
 =?us-ascii?Q?Bp7DoVSjntBiEm2Wp+CzphKS+2xJh+TGyPaPTYxCThLcAGdDHCj00JsHdA2/?=
 =?us-ascii?Q?3f2dOOrDX0023cY0nzefe8gVqxnwqZ8fFYwlDRJjT14DqR9rKBE7jAsgUVlr?=
 =?us-ascii?Q?wbncJN7S+bK/lnbtM9p3hq9jf45UHv5A1PyU+eb5QcdBbYC36rxwwcYGItU2?=
 =?us-ascii?Q?px1o6Q9pTjmbUjnt2IE8z+z1F2pAsLrblvh8H6GD43DB+AdLTdgxAMBVfVMe?=
 =?us-ascii?Q?8AtzYKg4cZ4RtPxjpT1xUxsOPJls0FEsmY4MiB2NVvFS4f+BJA5wzYHXCmvf?=
 =?us-ascii?Q?xBhB5t92Dto90zkuP6kFRusR6/UEATPjfA9F2XUAPdMy061mrVwOvrA1CIjf?=
 =?us-ascii?Q?Sz1BYRjuDmN36HwDTMKzPMtQ4TogzmQWbDNDunGgVoD03VeoY78Ge+Uu72Er?=
 =?us-ascii?Q?cAS5NBR3GxGm3BKabuWuo2mwiNgOfU0fz0JbndRh6HmfGvJiFcWCX0ESQMVs?=
 =?us-ascii?Q?gsIiNq6bkGpp1e6i2dP/WsmxkFR3N4RfaPRSpwg/EQdeQ9du4tV9MfEewCId?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0e6067-e88c-4a3e-2208-08dbbe90222d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 12:57:26.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8sMWGQoW4cTJOMzhh2UckW1Ls5pnOOyBDDCO5nKrtz7lOfCAedmS5szsDYTpFmIWzOOiWyViVEV4dSaKG/C+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3484
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 12:57:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13228

On 26.09.23 13:51, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, September 26, 2023 2:49 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
>> DEPENDENCY to all images
>>
>> On 26.09.23 09:41, Venkata.Pyla@toshiba-tsip.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Tuesday, September 26, 2023 12:41 PM
>>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <Venkata.Pyla@toshiba-
>>>> tsip.com>; cip-dev@lists.cip-project.org
>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-
>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>>> Subject: Re: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools
>>>> as DEPENDENCY to all images
>>>>
>>>> On 26.09.23 03:39, Venkata.Pyla@toshiba-tsip.com wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>>>> On Behalf Of Jan Kiszka via lists.cip-project.org
>>>>>> Sent: Monday, September 25, 2023 10:43 PM
>>>>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Port=
ing) <Venkata.Pyla@toshiba-
>>>>>> tsip.com>; cip-dev@lists.cip-project.org
>>>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Port=
ing)
>> <dinesh.kumar@toshiba-
>>>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=
=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=
=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>>>>> Subject: Re: [cip-dev] [isar-cip-core v2 2/2] images: Add
>>>>>> dosfstools as DEPENDENCY to all images
>>>>>>
>>>>>> On 25.09.23 18:58, venkata.pyla@toshiba-tsip.com wrote:
>>>>>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>>>>
>>>>>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>>>> ---
>>>>>>>  recipes-core/images/cip-core-image-kernelci.bb |  1 +
>>>>>>> recipes-core/images/cip-core-image-security.bb |  1 +
>>>>>>>  recipes-core/images/cip-core-image.bb          |  1 +
>>>>>>>  recipes-core/images/common-image.inc           | 13 +++++++++++++
>>>>>>>  4 files changed, 16 insertions(+)  create mode 100644
>>>>>>> recipes-core/images/common-image.inc
>>>>>>>
>>>>>>> diff --git a/recipes-core/images/cip-core-image-kernelci.bb
>>>>>>> b/recipes-core/images/cip-core-image-kernelci.bb
>>>>>>> index 479c14c..8a58e7b 100644
>>>>>>> --- a/recipes-core/images/cip-core-image-kernelci.bb
>>>>>>> +++ b/recipes-core/images/cip-core-image-kernelci.bb
>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>  #
>>>>>>>
>>>>>>>  inherit image
>>>>>>> +require common-image.inc
>>>>>>>
>>>>>>>  DESCRIPTION =3D "CIP Core image for KernelCI"
>>>>>>>
>>>>>>> diff --git a/recipes-core/images/cip-core-image-security.bb
>>>>>>> b/recipes-core/images/cip-core-image-security.bb
>>>>>>> index 3421ce5..f114974 100644
>>>>>>> --- a/recipes-core/images/cip-core-image-security.bb
>>>>>>> +++ b/recipes-core/images/cip-core-image-security.bb
>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>  #
>>>>>>>
>>>>>>>  inherit image
>>>>>>> +require common-image.inc
>>>>>>>
>>>>>>>  DESCRIPTION =3D "CIP Core image including security packages"
>>>>>>>
>>>>>>> diff --git a/recipes-core/images/cip-core-image.bb
>>>>>>> b/recipes-core/images/cip-core-image.bb
>>>>>>> index 0ec7220..711d3d3 100644
>>>>>>> --- a/recipes-core/images/cip-core-image.bb
>>>>>>> +++ b/recipes-core/images/cip-core-image.bb
>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>  #
>>>>>>>
>>>>>>>  inherit image
>>>>>>> +require common-image.inc
>>>>>>>
>>>>>>>  ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags
>>>>>>> --dirty --
>>>>>> always --match 'v[0-9].[0-9]*'"
>>>>>>>  DESCRIPTION =3D "CIP Core image"
>>>>>>> diff --git a/recipes-core/images/common-image.inc
>>>>>>> b/recipes-core/images/common-image.inc
>>>>>>> new file mode 100644
>>>>>>> index 0000000..863f817
>>>>>>> --- /dev/null
>>>>>>> +++ b/recipes-core/images/common-image.inc
>>>>>>> @@ -0,0 +1,13 @@
>>>>>>> +#
>>>>>>> +# CIP Core, generic profile
>>>>>>> +#
>>>>>>> +# Copyright (c) Toshiba Corporation 2023 # # Authors:
>>>>>>> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com> # #
>>>>>>> +SPDX-License-Identifier: MIT #
>>>>>>> +
>>>>>>> +# Install in build system for creating reproducible DOS
>>>>>>> +filesystems DEPENDS +=3D "dosfstools"
>>>>>>
>>>>>> Why this now? Patch 1 is adding it as IMAGES_BUILD_DEPS, and that
>>>>>> should be enough as you correctly analyzed. Do we want that change
>>>>>> rather in conf/distro/cip-core-common.inc?
>>>>>
>>>>> It is not required; I was confused then with your comment I thought
>>>>> you are
>>>> expecting this change for some reason.
>>>>>
>>>>> If you agree you can discard the Patch 2.
>>>>
>>>> OK, but the question remains on patch 1 if we only want to include
>>>> the tool in the reproducible mode or unconditionally. In the latter
>>>> case, my suggestion above would come into play.
>>>
>>> I didn=E2=80=99t understand your question properly then, I am pasting y=
our comment
>> again as below.
>>
>> Your patch one currently only adds the self-built dosfstools when the us=
er
>> explicitly selects reproducible building. In other cases - simpler ones,=
 granted -
>> we apply reproducibility fixes unconditionally. Should we do that for
>> dosfstools as well? That is my only question.
>=20
> I understand now, we can enable dosfstools unconditionally also, maybe we=
 can do that in distro configuration,=20
> here https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/=
conf/distro/cip-core-common.inc?
>=20

Yes, that was my idea as well.

> I will send v3 patch with this modification.
>=20

Thanks in advance,
Jan

--=20
Siemens AG, Technology
Linux Expert Center


