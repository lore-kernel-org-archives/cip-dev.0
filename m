Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04ECC05027
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 08:57:14 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.85])
 by mx.groups.io with SMTP id smtpd.web10.10482.1675328224310372018
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 00:57:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sobra6CW;
 spf=pass (domain: siemens.com, ip: 40.107.7.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpPm4WEcYdAfjHyt3AVWR9Z3JdnCy+07ANohuqbhWiXFd0oyGukyzGG/z5hni1KKbp/6LslZQWKpPXnJmWmEuLCxhX0ddkXmiGNenFHXRNffT143MCQ6STf1A/ZUFOWezfp2iTGKounLTIV5Z8HfTtML5PXPspsm3tVyitpTcbCBcNKMeU96U7FBcN5BZbJoXSXep5fgJ1Hp4Y3MHZZ9gSJhjAwoypYD6DO30smGqq6romwS0vWjxtih6IX6c0E1/mgoKvVrd6oRgl1IWr4w2YnmZToMo7TlamU9IUGFRUCKku8TFSjWB8KpyrPtXVY82MKOQRNwkMlLcQQXUDIsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/fQZBkgeI2NlAiBoOlHHHObP109NEV4Tm4y+L0drC4=;
 b=kuHI7r+ppVXbcXRYeSqV0gxRfEjarrJbOE1EMF+H3i6t5MHwBCOsE6aYwv2PuQbJBNB07z09gSyaugp4BEx/qR3/zKyWBkir/32raKOrWa3GttbQBMwGRg5uKkJkrjS00S7aIwpnxPjnQqNnP5rol2OZ2YKBpvzAeYrGFiw+T6GK6xwb17ebd9TZ9yr6REqzNLTJ0BmY/FTL4q2iRgSnJXcSFSiscD/9VnXOD729K2r0Pte0rbrpYjuQ2SuvLaJvdZoSSg87Fk/9xwMG/eCa01lrzJsN9Dp5b78gZBW0D/fZmu08GAutQq9DPQHFIxZHK/qwJrmLIMaTCX+HGhB4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/fQZBkgeI2NlAiBoOlHHHObP109NEV4Tm4y+L0drC4=;
 b=sobra6CWJ+/Cw9RlKpHYBJVxHkLCn80SzwIbrwdRgy4e86lKzLRwoTEKaq2ejgspl6mVs6PIwd+G3P8OR6VJMWwtPhhmElHyywE5mYCIi3Op++HtiZs7qZzMvWMv8o16yZo5V4tBxONFJGwgFwRgNLWVi7XnKZsqftC2f+0bIuyT80IHflftkU9lqUtEXrOFeSjWYGCE1+ILzxgOvjLvg1yh9Nf5c7bWKSN/tGUjuWBJSil0LyIPAHPfd9rTOMwJ+nX/6owHba7xFtKBArbLkhWuYKiL2m+hzewAcWBWgqyk1KSdj6S6fJtGLxM+xxJ/e2km7MJQZGA3Trtndy1uzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 08:57:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Thu, 2 Feb 2023
 08:57:00 +0000
Message-ID: <c9c2cbef-4d93-e93e-75d7-644142c781f6@siemens.com>
Date: Thu, 2 Feb 2023 09:56:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: RE: [cip-dev] How to overwrite IMAGE_FSTYPES variable in
 loacal.conf using placement of kas file wic-targz-img.yml
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <OSYPR01MB5542AD9EF2424FAEB3FE588AA4D09@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <a45a8fa0-af8e-4f3c-ab11-c6e5bb771cc1@siemens.com>
 <OSYPR01MB55424BC4715306ECD35D5396A4D19@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB55424BC4715306ECD35D5396A4D19@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3167:EE_
X-MS-Office365-Filtering-Correlation-Id: 24eed178-552e-47ea-0e85-08db04fb724c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YTfJU1DSoXop0pE9aWG+h/pNvRIFiXISHXrg++Ia5BUsa3kK7WV7UVr0IY/nP5OIBkqjwT4dgvHrUoiDByMBbPykhRehneENuOk9n8nbQqi7Cw82mHAYRuRdHpVgdUBacdpFHyBqMStedRVHEwtuNQoT71ifN1y+ZWcwUNvcqut8UoK90tKC4kuIMtv7RV94mEI/H+dC7Zb6HmaXoWoMPWp96MliAn+Pd8mj3PvFiyGEDslor8ftGal36EyAAQEuEqi3+HYi2Wucmu0PW82LunBQZh+d0+C7LOIFEzjCScH0FV8eEQxJBXjnHctNZV3CviFzoUdjTFIyhtNpVw4MNJEDAok30r04wfuZ3cCI5bbgnSrkRQ/M3oXAkMkNxS9tDlV4h33J4vdUPXf0ax2UFxC0/iFbe8IyEbel+BYRPr2xUmW9gOHU/jMJxpZ6y1om5YgsZZMsst8tYmoLgOmI3o4SZOQ2susSYbsMFQmfz+ChGYVtplCscaPliHo81LIuLScG441qdaFSmLedWieYMwe7TSOGcp6MmFiz8+SokPjn06PzWZlD5ClkPWo+W/uSL0xH+KQ2eFqdKSlF59d621/u6iCSSHTuZJOFTR0S77p5FXZzkAcAWrDMUhRa5UKWLzoYleAVmMUZR5RKh8zbUF4ZGSAwq1RM9amkOZoklOsi4xj4aayPvCqJF8j9AFI+9gwQt9Cm3TqggzM4sKn88CErvzFjhUlR+JzKP8tUfmk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199018)(6666004)(44832011)(41300700001)(26005)(186003)(6512007)(31686004)(53546011)(2616005)(6506007)(36756003)(38100700002)(82960400001)(8936002)(316002)(2906002)(66556008)(66946007)(83380400001)(66476007)(86362001)(5660300002)(8676002)(6486002)(31696002)(4326008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6hWonlwMw16YyHL7Sqm3OMYoKay3bYKe7RIhtPzVYviGTqPqTIIAWVNb13ea?=
 =?us-ascii?Q?YLNQxiWnYk2ijeEDtAoJs28PaYcPepWyfG9YtQp7dWtTn0VABcR1JJArMkCt?=
 =?us-ascii?Q?N8Jm1ij3aAWgFALk0SyCBvrz6sJy1LQMyhioSX1T/nMsIuZy3OPJqDiaB0V7?=
 =?us-ascii?Q?SmrpZwq9fE0bIAXRmdxQkvdwPJuRVU43hvVzwjyxAQHKVV8F7hQl6CSScXM4?=
 =?us-ascii?Q?AqIUnQiYQ6aM6ZG+i0YS8cu34408Ez6gGy0JvA62JJl6YFheNMBXqgA1nDy8?=
 =?us-ascii?Q?HKlrIKAEhVb13kPM+4wotHo8F1jpSCZ6X21dAPdVpHQgXL9G3TRNh40CqyOX?=
 =?us-ascii?Q?owGJ+aR8GZ5v9pHdInCCneSIMR5ZdmZPDhBeCintrSeJjVextKxKctCeqGMe?=
 =?us-ascii?Q?kyamiPv4hQHgkx/ZrNTO8aoZiW+aIoyxmHH4JSGeaQ0Jq602XHIfbIxvpyeB?=
 =?us-ascii?Q?pIkhvYhHBAgVap6xbnsiem5cBICxmK2esQczSWem2/7h3qi0IDsYJPZJC566?=
 =?us-ascii?Q?fFOz33inw5RvxaEYJZWjTf+ZS7sJ02z4RfXdLLzugAvgWStdX81gA0P3pHxN?=
 =?us-ascii?Q?sei4d3vC3Msqmd2XoBQMdXc0lxWCnxrl3+LPJX/lWAcdQG1/pw5VPXRRHW5B?=
 =?us-ascii?Q?L4fYSE1TrTfKqNE3CeEzve0i6nkyeevnmPKow8X/pMxQC4LD4054u7F5WyoF?=
 =?us-ascii?Q?xw6JdNgxqPM3MVwQ2WlOXbAnJMKwN17OBl195QIKW4RHjL1+4XAWX9cztyga?=
 =?us-ascii?Q?D+5xZ9OqCFs1W/vsNqJlPt0Cui6j90wBlwHF6/POE/JncFZp10OKWF0YLPeZ?=
 =?us-ascii?Q?Jpsnb2DsvbCthXLrAXZbM607dUCu77XDXBf+h5FeAizhiAVoX3eku7HY+hkT?=
 =?us-ascii?Q?+qVAC5yfPW6L6AG/Kmk/x1Qa3P7UnZ4ah2nvGgY7lNDTrSyBrolXTpF6iFVe?=
 =?us-ascii?Q?zFSyGvxHXNw6hLCWizdvCcqeI/jns0ZVDRFaAv65Y5o9dsy/pfaoH28zAePP?=
 =?us-ascii?Q?0gy5vaGI3lq+6Tp29doBJClGU03qqGp2JRcCxigot2xUg8Qhjbmg8qWdcyHA?=
 =?us-ascii?Q?eoRHgi8LPPdApT48cRPFWAcTpjRQ9MRnWF5jU/zY5EgFwfsXcSWw5ccI0Jfw?=
 =?us-ascii?Q?dFzgJLLvDT5/uiCYQpIhGivgVW/hkJ6g0XPrji08n3ayi2Vz+RdJxIKyKf6p?=
 =?us-ascii?Q?DMCK3yMBHN7uBUn48q/NwMQfaVA4jqkh93yQdG+LYRQ3AEIJNo9zHLeN7iJ6?=
 =?us-ascii?Q?bM2K3eNZRLOxrBE1ja8uAZwnKpWSbNQjJ/5gWC74N8mD60cA1ZfZGHhvdHSr?=
 =?us-ascii?Q?IhGXni6eGVVdyEJjm9EKv74eyWuEpNMy2yEXtqnqPZ2TF/db9l8GvZEu05tJ?=
 =?us-ascii?Q?May3aj/qvUoSa3GFTpxwZ0xYY+x7rsWKCBgbkgqlsx4p56Bqa5ZzO4n2RbQR?=
 =?us-ascii?Q?gUjXYQV+5k4L6Y+1p81hQu3GyNhgGTxkkm1cO4AMn+L0pmD6yK8D9G+VaFcX?=
 =?us-ascii?Q?IgiP618AByj0HLLWnhJujHDYlpyz7eT05vQuStxy/i/12IKwkafT7LPWCFZO?=
 =?us-ascii?Q?iLp+A3mWMVWATTk5OHnQwFKjRgf8Mv1LuqSt5KMzofIti/afeUTv/5MHKqSq?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24eed178-552e-47ea-0e85-08db04fb724c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 08:57:00.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peONlunR5pV2TbA5Wk4BEvv4uyOAcnG+/0UYeYvHASnmHGuSpZs2P4Q1At/mGCSRCrkQ6ARcRTrZoWeXSY0R6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3167
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 08:57:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10566

On 01.02.23 12:39, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf
>> Of Jan Kiszka
>> Sent: 01 February 2023 13:06
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=
=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] How to overwrite IMAGE_FSTYPES variable in loacal=
.conf
>> using placement of kas file wic-targz-img.yml
>>
>> On 31.01.23 17:55, Venkata.Pyla@toshiba-tsip.com wrote:
>>> Hi,
>>>
>>> I am trying to overwrite the IMAGE_FSTYPES variable with the values in =
wic-
>> targz-img.yml by keeping at the end in kas file definition as shown in b=
elow
>> command, but it is not overwriting.
>>>
>>> $ kas-container build
>>> kas-cip.yml:kas/opt/ebg-swu.yml:kas/opt/wic-targz-img.yml
>>>
>>> kas/opt/ebg-swu.yml include local_conf_header as below
>>> -----------------------------------------
>>> local_conf_header:
>>>    ...
>>>     wic-swu: |
>>>          ...
>>>           IMAGE_FSTYPES =3D "wic"
>>>          ...
>>> -----------------------------------------
>>>
>>>
>>> kas/opt/wic-targz-img.yml include local_conf_header as below
>>> -----------------------------------------
>>> local_conf_header:
>>>    ...
>>>     image-type: |
>>>          ...
>>>           IMAGE_FSTYPES =3D "wic tar.gz"
>>>          ...
>>> -----------------------------------------
>>>
>>> Final conf/local.conf generate as below
>>> -----------------------------------------
>>> # image-type
>>> IMAGE_FSTYPES =3D "wic tar.gz"
>>>
>>> ...
>>>
>>> # wic-swu
>>> IMAGE_FSTYPES =3D "wic"
>>> -----------------------------------------
>>>
>>>
>>> Expecting conf/local.conf
>>> -----------------------------------------
>>> # wic-swu
>>> IMAGE_FSTYPES =3D "wic"
>>>
>>> ...
>>>
>>> # image-type
>>> IMAGE_FSTYPES =3D "wic tar.gz"
>>> -----------------------------------------
>>>
>>> The above is possible when I use name with higher in alphabetical
>>> order like 'zimage-type:' in the wic-targz-img.yml
>>> kas/opt/wic-targz-img.yml with
>>> -----------------------------------------
>>> local_conf_header:
>>>    ...
>>>     zimage-type: |
>>>          ...
>>>           IMAGE_FSTYPES =3D "wic tar.gz"
>>>          ...
>>> -----------------------------------------
>>>
>>> Is this the only solution to set the order of the variable assignment i=
n
>> local_conf_header?
>>>
>>
>> local.conf nodes are alphabetically sorted as you already found out - we=
 should
>> probably document that in kas. Generally spoken, you can make use of tha=
t to
>> achieve append behaviour, or you overwrite the original node you are
>> competing with.
>>
>> In case of isar-cip-core, we can rearrange or kas option files so that y=
our use
>> case becomes possible (though I'm unsure if it makes any sense:
>> the content of the tar.gz will be only a subset of the wic swupdate imag=
e).
>=20
> Thanks for confirming,
> I want to create swupdate image that should generate both tar.gz and wic =
image and use tar.gz for reproducibility checks.
>=20
> I probably have to modify this file kas/opt/swupdate.yml to include both =
in IMAGE_FSTYPES =3D "wic tar.gz".
>=20

To clarify again: What I meant is either aligning the node names in the
kas files or converting wic-targz-img.yml to targz-img.yml with
IMAGE_FSTYPES_append.

But I don't get yet why reproducibility checking is limited to tar.gz
outputs. Can't it be run against the common input, given that it works
only for the rootfs so far?

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


