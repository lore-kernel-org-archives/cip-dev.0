Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB03DCD8C9D
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 15:56:11 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.58055.1780934166401071265
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 08:56:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lVfK/gmE;
 spf=pass (domain: siemens.com, ip: 52.101.70.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADzCEk7/L6MlE9tgF2/1+GK28dT1wr5YSRFpRwKI8g9pxxBwa7rqxIq0e/wAKJvB3nBwUOcsAxkMhiISYohsy7RWzubFJJ4V3AAHr0L5x1JOoiZs04Nn0sXTrGzIhYB8nJOx/E1y4+9mTgtqdOg4B5eXOSRQZ4V5WnG/dutRhrPaxyZ0tHTf9Iyl4ZRUQ1qOmJG9dQN+Kkc5pot6+wO8sxHwjQLSZ1rgifo093yFbMFOHndaN/tO1BGOplFsTJq1ZhtUzZN1DGGi+xfcd901lX7OwrMw87tAW1iZeFmo/PpCPSse9zFmyNu94mbCUSTBqt/R1QDOISSn8Vk14AGv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swhv3Z+Hw6yUyTFFF/h242fKigXPHm7JJ6+6xWV5lvg=;
 b=zWBKetagVd8GEnWdbnkADPu7pF8UtvKYHuekKQU0yjFidKqe+PMrQSL6GI8W9zIMRZaDWx8W4p2YwfVNDZfoiZDVJSVU7XdDPl2+PRWoYegyZcjwOfJKs/cSyu/MCzaiTNQxzi0UBNZxvJTulUDXYIsbc7AD34itFyAr0MUXAgKOMUyLtDKKX0AxpnhUilp6rbBqqVFcu9aPEV7NSGznCr4a0cO3VqWtL3NYuDw4RbWiwhDNqNPh8rXzNhaQfVLzoxvFqkx7ZNWfa0IXOEMg/qpPcvjfYKx1quBn44K0wSkO2LGa5aRqiiuoB1mrFK4ofQPkZi81zw/5JeR/GApxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swhv3Z+Hw6yUyTFFF/h242fKigXPHm7JJ6+6xWV5lvg=;
 b=lVfK/gmE8M3YH3PACSpNDAkDPxqxiO57cljqLZgl7fJ6kcDNrJH9diizMNV4kLVPXGsmv3sO7oOilAwmwmfMPswnscImYeUbQq7f0miHNOD0YEM9Za+s6sD9sDGCVX9x6lZ/AC1Dfb/DnlMs6KmUQC3OzGIJcUCQCXkrX2vB1zvdd6Ue2BGqFdHaOYt6b5lJ47ldrP51yazqF8PQMeSH+I8363yQTnMQPRohcejlDtaN0RIKUqObXj56Q5HLNw92UkCeyAX4nXGMI6GxCnRJQ4qYUtmKFiCQQoEh4r5nserSuOqFrLnyIfR5gOTlb9wINwXm7dhQo0wVV+z6FMv0ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 15:56:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:56:02 +0000
Message-ID: <4e4adae6-5b0e-4550-acc9-d5d6a2fa787c@siemens.com>
Date: Mon, 8 Jun 2026 17:56:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] doc/README.factory-reset.md:
 Minor updates related to use cases and relevance to IEC 62443-4-2
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260602060009.50354-1-Adithya.Balakumar@toshiba-tsip.com>
 <8942785c-f7de-4c3d-9dbe-b8cf290d591e@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8942785c-f7de-4c3d-9dbe-b8cf290d591e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DB3PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:8::48)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0090b2-aa32-49ac-9bf0-08dec57670ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|55112099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	O9YWm+6lRWwgHF/xNq59kgOOC69rTVXe8yEvw185pQGcXgtUV01ikFLIC5knU5B5LC1Tb3EcwQw6dqaC+ypsbsMvGg2sZIxk/8Qcx3oBrjg42SqAq1xaG6Dv/4YlR6PHKSGx7jvWSerqo/96c5p9ur4IdJhNVkzJQE3rfD5SEY1F7euyJ5iBpa2bI99COqTO/8z1yzMwzMlp/c26RGAX72JNveBlhUnzaGw1nAzelP1vmfnbm+mQzdHppDqb9DiSXJdX2WebQm7Ec93DDIktSsLaGtMaqsMKDyKjsyYCcoj0SgI+E2KSbuO/6whv2gSKasE9cREZdE8sBzNfcooC/M9ft7BTGDWjLC4BYoHtDFVak7eDmZAW0XpyABA8pB0vRpkDjJtQR15L2lez8XKQRv1chpQJfk9LTep+QOscYneo2oAmh9Z9yZU6DO79ZVNoJdfDQIOM9bZNiW29gZxLZhUERVbp9N7otcFhg0CKOxumGwda7wdIr2+Wxjly4vN7fNymXQ16dXHOzMSsLuaoJIkczcXZfLfAzDeex47BdBhF+7mxxPbgBMOMmAwpqspjwG59W4AAXemcRCUHZI1puxWH6/s+/S1yDAtxa3bWcGJDAKB2YbKOrWHKnwCibRd7lz1RsxmX2627dQhd/DPUxw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(55112099003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rh/UmiwsNifnFshcmGsnI6XGW6HwPlPbsDvdvV/jMdMoUYSTY+aeij/mz4Ib?=
 =?us-ascii?Q?PCXSQe14eyXXXsjMgizll8cW3xoHt8RSNf+82Z1ZhmceAKwk1ssWYsGwSxnH?=
 =?us-ascii?Q?99/66Z2duZmyO1u0tSs+zx47BZaDJOjXPp5o5Myb+58QBzJFOeninUWrT5hC?=
 =?us-ascii?Q?iW7eCC6fh5rkeL4ze9hkvHHDM/ZINrIyvNRbEyx6Io34VVtGddwiGdEhFRg6?=
 =?us-ascii?Q?Qx0xK55JPOTuWYCbKzYuUZDOme/kNOSpg+xINPr6kn4bnQjWpDp8oRYgJK79?=
 =?us-ascii?Q?4T0A8a8KpdWydxzAv9upArxzLvMIgxhdzPY9wls2TpElVBOf+rCtMS96sags?=
 =?us-ascii?Q?eP8laS+vX7g4yigg6KO8A8Ls0llyQFn/zuUzmekdZrlmYAhKHzdVKN53Ql08?=
 =?us-ascii?Q?ukryrmld3ufOPjBLWW6a9DeBHQKBOm+zwzkK8zVjpTm3rvngrJjr7baQZqRN?=
 =?us-ascii?Q?6CGJ+yBx9yOfGcVH4fGRJOf6f+rVHSi97UeMv08xfr9YsXZwB6756qqYM807?=
 =?us-ascii?Q?KwOl519cPjlz1ghfNh+pMjHxIwIjsvldyzT7Rm29X3RWqO6982spunAOCckl?=
 =?us-ascii?Q?xM70N58ddRRS4TPtm9P05tBW25mPV5byQjJYWekxhZm4sc/x5n4BwYQXToYK?=
 =?us-ascii?Q?wGX3p/C+Ih4EpMaW0dSc+2V8Lu4JqRBiZ0zhAR/P6avXcij923PI641BlCPq?=
 =?us-ascii?Q?aHWpxbs9XEirQ7mvbqk2Axq7VL7OcE7HK+65xkAHSOx7bu4GCR5oP3Gmy+uC?=
 =?us-ascii?Q?2KcXVwvH5YgO8xpoo6p3y5+Odn8QsDDtbpAURm6Ctc8/DFUaB5Ezlp8UfszE?=
 =?us-ascii?Q?ODzsbhfNL8WPkQXkKWTmy99lugD6EV0RjZTGCbNJRLq82Yhb18h/+A/f2R0s?=
 =?us-ascii?Q?iJxsXMsBpIzOIdf+covVGPOO/3Az5t9M70XIG5DsQ+FtsDZMkfJnnkzQTRVg?=
 =?us-ascii?Q?P9vTZmn6weOrcRopklD0k1SuXwza6+m3RFZ3qPAdJn+0snihvZKw+zf6wQPF?=
 =?us-ascii?Q?z8B8YFEuD2W46W+G0xKhGLD2kdsvLLviUpU78HQD9C4Jce3T3tFskvChRxKU?=
 =?us-ascii?Q?PetFDRqJVIy6T12TvAokHt/ODCrI6ylY6wXrd4khBHCkQXRvJmTqnZ6fskkr?=
 =?us-ascii?Q?dfr6N9cG0gOkM4zSvNwSyaPSz5bkru4L+tQHP753nhOoDqY5DD/B4RtF3tKB?=
 =?us-ascii?Q?r54w+8Wf9VVdlWBWu4lmWoGPQBHUrPG12XZkipLXI2TLgzeztL0HWdwu4Q3N?=
 =?us-ascii?Q?xuQiCdyXNBBa3p+CMx4z+BBHTDvGDhHoZEstOMbck9q6hdz4Bxzi3/nDtAKI?=
 =?us-ascii?Q?77zkFM+01TCUUoZP+NkWRkqmi14h7NYFerirR0Ne2xmIWBxH2GAK/1agKULR?=
 =?us-ascii?Q?dPU99UsLQfyo81nvMc3Q4SpjiHQB2Ly1Tq/nJej3XSJ2XQQzxnt39/2ZLkC7?=
 =?us-ascii?Q?0u8fnxckuIfsElIJwEr1Qpl7RpslKzI8xt963zKQp51Y9nkrn6RbYOU2lc5S?=
 =?us-ascii?Q?rgk+1oWOntscr42qLEZVmdzwOJFaImnuEP/rwlskFadi2aJojArbs5ifsXaI?=
 =?us-ascii?Q?mUsdyq+NQOJSW77yCN1dIkYQxz3D7aMo8NUSMvDnumoRhDbvy+eOF35StNWq?=
 =?us-ascii?Q?Yb0Xt9IUatWYtirQP/aObr/NBEw8Yaum4vdDrzMvMGBbroKmBEJNQxY26plc?=
 =?us-ascii?Q?Kr0xdFH2gfOpze4uBA5guPYjLu1M3zbmnNLo/n8hA8yi9OKPNLOAovigdfJu?=
 =?us-ascii?Q?nZOHa7ilw0H77h3Oiv79QMKw/6la3VY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0090b2-aa32-49ac-9bf0-08dec57670ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 15:56:02.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+Vc6g5w3fyZTN4M7gtvfvOKDZ3yWLm8MXWDKsR47r+EGLDh5WCpSQhSShK9uJtOt+HhwIrFiSo04S9qWof1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7353
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jun 2026 15:56:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23050

On 08.06.26 10:36, Quirin Gylstorff wrote:
> Hi,
>=20
> On 6/2/26 7:42 AM, Adithya Balakumar wrote:
>> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>> =C2=A0 doc/README.factory-reset.md | 9 +++++++++
>> =C2=A0 1 file changed, 9 insertions(+)
>>
>> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
>> index aa8dd1c..419e32b 100644
>> --- a/doc/README.factory-reset.md
>> +++ b/doc/README.factory-reset.md
>> @@ -51,3 +51,12 @@ root@demo:~# reboot
>> =C2=A0 ```
>> =C2=A0 root@demo:~# find /var -name "to-be-deleted"
>> =C2=A0 ```
>> +
>> +## Use cases
>> +
>> +- The primary use case is resetting data partitions (e.g. `/home` and
>> `/var`). This also resets any configuration changes made under `/etc`,
>> since the read-write overlay for /etc is currently backed by /var.
>> +- If the `/etc` RW overlay is backed by a dedicated partition
>> (separate from `/home` or `/var`), that partition can be formatted
>> independently to restore default configurations (included at build time)=
.
>> +
>> +## Relevance to IEC 62443-4-2
>> +
>> +- Factory reset feature helps meet requirements under CR 4.2
>> Information Persistance. Refer [here](https://gitlab.com/cip-project/
>> cip-documents/-/blob/master/iec-62443-assessment/iec-62443-4-2/
>> iec-62443-4-2-fr-4-fr-5.rst?ref_type=3Dheads#id12) for more details on
>> how the requirement is met.
>=20
> Should it not be Persistence?
>=20

Indeed. Fixed up while merging.

Thanks,
Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

