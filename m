Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B61AC47BF4
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 14:05:10 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90458.1767708301229686217
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 06:05:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KYKvjT6A;
 spf=pass (domain: siemens.com, ip: 52.101.84.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIniVwpzwGXfbQllkfwz3fwyCN2lg05Sm+JJQS6tHJCOSALVqmAFaybvKEoYmPk4mFaXHa+VuG/PwkoWXpXzo8VBoen6SGzjhn6iRPhyPLbvscann7t9DT+lp9SFHo2ZFjdKkEwIYmajFHM/lMh9FK7jjgY+8zoGmeOZMeAb7WOiG+rCqjKht5Lbi7n2rjw85GCZSl/CpYwbHWX9k4gFclxEjOhIu+cdy2kZWK0mI3Z2jZbvBuSQT/VtpOP7/FhGpEjP/FRoJCztZGclUI7RZj98rMwDgYtYQypZsLsdB1/5Is1K6Su9xR+QzQ3X/eyF0Aybsg9LajNgtpZQ26oPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZFUJg3csfy5v5eZi9toZMAClJV67WROPtyUCh8ENYc=;
 b=bWIkNf3haMSJI0NAwVNKHr4wKpLnjrVzWwfcJSMMKkbQZiAJ171kvDxWmqAu9ooCKDoRjmwdKcyRMwbnLntdWOBCtOP88+1BubDFgN6s9TSoilGP5r5qYVvLB/SqjKbj/uR8r15W4jJw2GyAo6O3IZMTEif9oKY9poR4JRNIa0bt8v7D9xytTHh4GqmKMIIxZ7K+P/R2GbptB47baVfq438OWfUa/Q8PRAqPLlC9P2eI/E6h04OmlZcUG3bGdrI1sttAtEN+ycDH3LCicAZ5LGqdlqaPmPAQCYPgvyT3YvBscxCB4az1C5Y8CWCSVWCMyIfP2llA2DD6JCTtMXDTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZFUJg3csfy5v5eZi9toZMAClJV67WROPtyUCh8ENYc=;
 b=KYKvjT6AWYAxWd6v7xEuQOKx+SKLXkQi7f88p8bPWe1J3rfwef6fWJDYkr3bVkBJ+P95hjoe8chlWfauRLqV/vBnuLyLBjis7a4/vvRIvdUjjvM3GBS99EG0cj9fOahaba+z3WVlVxyagqtPwr/5GmGfbmtNOlY7qEhIBtwWiFgy2mOHPjEEHOpc2ANYuhIO/QvQ68QHnUxrJNOsNhEDL7on8dI0uvVL51EOaT8OPhjXJjEePMObLeICFpzJp8MuFnWxr2uOnOl0tSq56XAaYalR5rZI9wO6saUHw7xe70Iif7vrjwKgBQIZFjJy70prUm8hrHofO5odGG4n6ErdxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 14:04:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 14:04:57 +0000
Message-ID: <9e497853-0c20-4606-8575-1231afc1247f@siemens.com>
Date: Tue, 6 Jan 2026 15:04:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] fix(security): install
 systemd-cryptsetup for LUKS userspace support on Trixie
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Gourav Singh <gourav.singh.ext@siemens.com>, cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com
References: <20260106124712.930274-1-gourav.singh.ext@siemens.com>
 <5964ea5e-8878-4412-879c-6a791409e1eb@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5964ea5e-8878-4412-879c-6a791409e1eb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ed5602-b1c7-4f63-5732-08de4d2c9318
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Zxz+yFYyXJpSiZVefoZEeh8ObJrpX1Ec1Pw9/IaHiKY7hMmTD9wZQUqrZFv6?=
 =?us-ascii?Q?baTsmUmQ8xtWou4u1ZC3DHcZbfcZwIfTDYkaCCyyDkZ6wa7NsoEgKsyyMsVw?=
 =?us-ascii?Q?kxb+3uHQCi6pG6W8ZiHMIQTOJFBAJurH8HJdQhSs0lFSveCZdV4vvy/ofgDg?=
 =?us-ascii?Q?IAiAgHb1sq4ZnRTdndweU6x+w9sLqn8Pa2ZzoROahUiZNeqUO6VL07bLcEWI?=
 =?us-ascii?Q?RdAVXERZTNJCDE6jBZG1ShM7HGMJHRObiw9VP5O0bl5B51NrTEu/5d1ANZGE?=
 =?us-ascii?Q?P0YxWGX/wAvqENg/ZznaDI6NEPBgGo8M+Sd3PHS9/rIDis2wWk7SNTnXdSWC?=
 =?us-ascii?Q?O86t7z+smC4U0EQkK8+nIFoF9E4sHvigS1V+RWAMmfOVt2Rr3nOC0sC7gS2W?=
 =?us-ascii?Q?KR1d6OwHuUgi1kWg8NsxAQaV2A3Kb8z1/q+nKOJ+r2JXRbhGvFRkn8FQ100C?=
 =?us-ascii?Q?B6CNzuQJ0bv2qfB7qmw8eY+8sEbFOlnTBDXj6qYz/bZ501FqSFidFsDV1pFl?=
 =?us-ascii?Q?6ktVgjHV9QoUY30gTuxeIkB1tPiRNAEJLXK6EFJxD+npSSL//rAMzZUxSPbD?=
 =?us-ascii?Q?gBWGkIbPoF/Gijkwq6/5yu+pomc4kJ5DDoWLairbw1xgfmkiiGTyBtqsvQuO?=
 =?us-ascii?Q?htQm4R9E8Wcuon9Sonph0txCRHvikCNb1a6yfhOXWw6c0Q321GRm15izE6pG?=
 =?us-ascii?Q?uH8PAS3A1V8sKG0DeNuVsXDZsp7QKyOQKI5PkFcSJgZvTodk0ldAGrpjl5OW?=
 =?us-ascii?Q?uvkFMj4WlXTA0gxY3P9uRTSwjmpp5O9bMInSpiY01hkHywCkwajr/u9HaSiO?=
 =?us-ascii?Q?nx+teSww5p14z6mvbgKev3Q6S1UKguzh7znLROGkqw41dBsYbBoWLUlZp1py?=
 =?us-ascii?Q?3XIV7ocZ8hn3Y2ObgJidkZ9phQhPEdnXtUQ0jgJ7avND7N8U29XqR24+siTn?=
 =?us-ascii?Q?yXAnPNdeXXYSQfFCDkxWSsVVZEGwAqtQBk83jJIcyDmAw3VITECOdo+RpEHN?=
 =?us-ascii?Q?+PAXZ0RVuerfhlI4oOXMnJdDu3S6XAXTEsX5MU1tBPSjJpZdffXc+WDiA509?=
 =?us-ascii?Q?qPM9c2iDk4fVEnBL4YBZETJVIVYccviXJFRqd2roUXmQHGew3y55c3OUhSeU?=
 =?us-ascii?Q?UeRvxING6J6307Z0rix6as05PQ12lLI83MldyWsE2rk9pSblofGgZPuXvpdf?=
 =?us-ascii?Q?d4/eYoVT+S0i44/24bD5o8Mv9aDvd8L1/OjWF3S2GH1A+qFExFleov9YQwMw?=
 =?us-ascii?Q?z13HdG8YxdO9YUxP7cNV8SQcbRXLxzmOdFMfLtiSdfBNP0hSu/kWTIZagoLa?=
 =?us-ascii?Q?JhdAOi4ZteiEge8yzMrFSbDHoEEG4MTexwJ+5KBDbZSkQ+6hACdQZxkQWkqN?=
 =?us-ascii?Q?iXbTqnvTW7rJANFPBCoth/KY/wrAjPPnqUv7U46K/gSkKZCaw3JeWmXJfOwK?=
 =?us-ascii?Q?VfcIzyrwVL0JtPZxvzD4+l4+WPNvULFw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1HRyLMYd/AXixTmF8sYA6QPA/xgr0Arl0Hw9GuJQ0ZhEDUN4JA9lW7UoFbHT?=
 =?us-ascii?Q?lYq+AkX8vhSJ41oSKfeEGPQh/01IJOhcXZAcFOYGrXRY91Gc9Sq7Zo/Rtlar?=
 =?us-ascii?Q?4qbfWbCvxegvjzJLXfZ2CAXb83p8G3XucLL3uZTfDp/WdDDlI3/sFP5jBWsL?=
 =?us-ascii?Q?YYu01AVMOwqeYWLnzmWWRMKZPIfCjMLVXO+U74HvVXYsQ/+sEAvx1f8169YF?=
 =?us-ascii?Q?4uqEe8OU67kGcMLCFnGNn2RdHNpA5Ip+L1XIeP/dfHJD0TpeWxjOYwWEB3rd?=
 =?us-ascii?Q?U72vN+N97ii254QRPr7DVk55nDOq8lx30ijOrqMZHEkEf0NHPRpYLclTOE1U?=
 =?us-ascii?Q?NpDi16HKQ6o7k6CGe2utqFbrSJfq/ZIcRIQg3daQ+H4JrcVru0dbuwe1TP7+?=
 =?us-ascii?Q?OrHferPMf08fVeehE16tMx/ucMSguuNPVHeOgArrld5ox1A+cK4QOQMSy0IA?=
 =?us-ascii?Q?ZW1Q3xhaU1vPiSj6DNMcPZxaS8JdlbDc1rpxWxsIwLBxT0HGmuscFoCmJMKz?=
 =?us-ascii?Q?k0G7uO1yMBwxeDsC1BBv3YKZX9sSx7FbxKfyeegjqmIleQgtmkIKuodh+fd4?=
 =?us-ascii?Q?caJpO0AmqAPyB0f7B3jfUYXl35XL2NG5GpY6gzSIimvFocra/W9n2GA0j5P0?=
 =?us-ascii?Q?6VppgD7KJxD2Q3u7uzW1dY65Evsaz/X9TtIn998QN81GklV5ONrUzfZlv4le?=
 =?us-ascii?Q?m6RPHwOPQuGtLSTgaU2GJHQL+JQKr/vTNsH8DTU2hri0SKQfA4P+DhaM6/3p?=
 =?us-ascii?Q?e7h8ZTUPCvACVy22uPTBwLLu0Q38LaDIPg8XtpgL8WSJUn+9QJg4NhbEgPW+?=
 =?us-ascii?Q?pwMGcya2sFvlxovm9pL4pr5gVNmkuAT3W6w32W8TpLehSy+VqD8kXS84fUCA?=
 =?us-ascii?Q?9+H22cQXUuRWlKYS7s3hS0rO0OCxfI38cajk8VUceMcPyCOOA3tOiE9AnGFD?=
 =?us-ascii?Q?YSa9XKl0FqnUOzcjZhlGQtPOvn8W1HSWZlPpxZs78Bcc3jFELxgJuKIVTzng?=
 =?us-ascii?Q?js+TuabCdrLCMgYeiOFlsHXOGaSP2Hvs0hS2w44XGUOol30inTQ7Vib5qxvD?=
 =?us-ascii?Q?ggxB2W31jhmxQbINYGX3dswsDYfK8a6ynxaT7J6rywu7RIsR8idE3wfjdepa?=
 =?us-ascii?Q?DVYqQDOXF7ceXlNrnB6W/r2SNqDIUefw56vIlWZJ0zV07VIEUUmTH7udm2Z9?=
 =?us-ascii?Q?p7WXVdGGQJtRtTOsruBCFqWN+drdbuPHsqsacms81lX69Cbd0Lm8BQj2UlVV?=
 =?us-ascii?Q?JV0l84XLwY0j6TVl42LUDir28KJk9M+0NcfB4kMnm7eyhs13Ew5Lvoku1Bjf?=
 =?us-ascii?Q?5Aa66xsNB/h4EA+e/Vaj2kfk3ahlbAj8LFDQlHVueHTt1E4KUPg3fm0iGtgC?=
 =?us-ascii?Q?fiKJCeU9hSUxofRvTaQYgMSJyIm11ZUA6be2+GZ04QsD7NWhYYwz8wEJaBDO?=
 =?us-ascii?Q?frA83gxrjj67+NCmwG/A2n3Va4BtaQBrZiXq1DWjz/Dlx4B2LN4531JlsHCg?=
 =?us-ascii?Q?hgyWuRZr068jmKpLIiMEJEuc1FrOn/vXYP22bz0vx8P0pfCA3px7QwpgsZ1g?=
 =?us-ascii?Q?mmvV4ftfu+lApSz7gAZIVRRDcZlI8QW8KjB7t7rSM3S/5Zdy72B7UG54nlo5?=
 =?us-ascii?Q?ke7zNW8IKqKW2dLNWEC0z4ZA96xlKXIPpqAsMZaJKpAOQsu24FiUDvPaDTPk?=
 =?us-ascii?Q?NnAqiEK/Nfuf5QXWOkD66BkW5IzJo8VBrmmUkO5zhLdSiNHuX82fugeylUf1?=
 =?us-ascii?Q?PJe6GyEgDg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ed5602-b1c7-4f63-5732-08de4d2c9318
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 14:04:57.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwp29RFPLA+fCr5DKKOfHPkz2uswOd00xx4fnV3qJI0wd7Y40YV+t73zBes88V5VLpvimcBZxaqpIMSfXGY+6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8468
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 14:05:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21383

On 06.01.26 14:05, Jan Kiszka wrote:
> On 06.01.26 13:47, Gourav Singh wrote:
>> systemd (>=3D 256-2) split cryptsetup tools into a separate systemd-cryp=
tsetup
>> package which is only Recommends. On minimal Debian Trixie images this
>> causes LUKS devices to be unlocked in kernel space but not exposed in
>> userspace (/dev/mapper).
>> Ref: https://salsa.debian.org/systemd-team/systemd/-/commit/65e0731d3a03=
60fe9816a24be459fc2d2b8becb3
>>
>> Installing systemd-cryptsetup will restore expected LUKS behavior.
>>
>> Related to issue: https://gitlab.com/cip-project/cip-testing/cip-securit=
y-tests/-/issues/8
>>
>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>> ---
>>  recipes-core/images/cip-core-image-security.bb | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-co=
re/images/cip-core-image-security.bb
>> index 8a8c695..d14f749 100644
>> --- a/recipes-core/images/cip-core-image-security.bb
>> +++ b/recipes-core/images/cip-core-image-security.bb
>> @@ -33,7 +33,12 @@ IMAGE_PREINSTALL +=3D " \
>>  	passwd \
>>  	login \
>>  	util-linux \
>> +    systemd-cryptsetup \
>=20
> Inconsistent indention. With that fixed:
>=20
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
>=20

Oh, I actually believed I was reviewing an isar upstream patch - applied
to next with indention fixed and...

>>  "
>> +# Remove systemd-cryptsetup from older versions as it=E2=80=99s only av=
ailable in Trixie and later.
                                                        ^^^
...this character normalized ('). No need for a v3.

Jan

>> +IMAGE_PREINSTALL:remove:bullseye =3D " systemd-cryptsetup"
>> +IMAGE_PREINSTALL:remove:buster =3D " systemd-cryptsetup"
>> +IMAGE_PREINSTALL:remove:bookworm =3D " systemd-cryptsetup"
>>
>>  CIP_IMAGE_OPTIONS ?=3D ""
>>  require ${CIP_IMAGE_OPTIONS}
>> --
>> 2.39.5
>>
>=20
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

