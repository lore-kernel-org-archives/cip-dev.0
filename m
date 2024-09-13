Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ADDFA3728
	for <webhook@archiver.kernel.org>; Fri, 13 Sep 2024 07:55:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.87])
 by mx.groups.io with SMTP id smtpd.web11.68494.1726214142629185275
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Sep 2024 00:55:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=oKyRSmbY;
 spf=pass (domain: siemens.com, ip: 40.107.21.87, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ainjH+gpwAEQZ5o3BEZdtMVl2NcXJSzBwFVyhn1HxGXZNpjoL6oKzzMuCr42CU13bQkjc60w4kBAprVKGEVqEcsEKJnJhcWmU1AFzf7Ziu14+iwY4BoTWcnLXTJZ+c/M7E+fWhiIadB8SOW7pD8mBEbTQYpjbkOmOS5/JRyd0rp97r9ij5vhV64yR7VXSCgzP7X4DoNMYHsNYf+lTGkhD+cjXx5yTD2HQ9i88+rMXokiO9jGRNVX+yjI2+helsir7cuYpoGHiyaM/c+6pdcLDaGsRfysS+m/OQGm7vS5paa6omFqe8MhC4qaft8tSnIA2HPz1hzfe92P9Eg2LyraQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbRFt5r988HbwTWr58d2jQhRkYTtvlq59dL+FHTJoM0=;
 b=Tdb9b9UK/TOADG8vqNx4LmqJD9JkXXVrBCSaojH5AtW7qNyu8ubrkBwGGA+6xm/JaO4ROPnHxUjoU8bRpwB4/fRNxOPI6uk21FXpjJAoOUKE66MXiSXXhfoeA9ZlDYl1oC+yp1kQFUt/M3U5QZqCwFskfCJW5T/+iA3l0CXg5Lz3SPQt5hafhqJyEdC41mkYhQ/WMQ9fswkBah+fBIuE/QdTKoXC3Yn5iZb8kORHf4hHDN+CKCrEgbGWhO6/dIdSXIJH6Vhjm0pvzuxl1ATMWPJbpRBNdTrf6TZCywnkkeqntvLthPQIalPQH0v8CyWSjWR1rzUiwW01L7Npz25LnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbRFt5r988HbwTWr58d2jQhRkYTtvlq59dL+FHTJoM0=;
 b=oKyRSmbYjtHZRyQ1LJyXo1gjt9/ZzPfIs3WZp8lACcAYIse8X9pQ1iOIEWX/nB7ialKbKeevAR6u/VUBj7n7Hj8y7EpUmFkqkToufAN8cw/9gstgQ2+UFlFMrmo9ZbA6Kqb2paF3uIjMuM8334lathcmEuPte1/FkI560wlJAYzV7HJbFzB6A/83gxWi9yo/5YXOD9/s9nbrHupguGcHq4iaZ6kZhF4xLlHWByiDto4XHBz7hcxbDMhvWa7cNmk5Te0ykxnD8rPUDVpV4ZPHAlN1XpnoWmm2HQFn03df+CgkG1kDmsGtM/tLZNNPxbG+Oz2OIksXP8/AAP08BzJnZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB7268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 13 Sep
 2024 07:55:38 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 07:55:38 +0000
Message-ID: <731e67f7-d18b-4e97-9f87-509fdbbde06d@siemens.com>
Date: Fri, 13 Sep 2024 09:55:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] Update README for swupdate
 signing
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
 <20240912100710.3183806-4-Quirin.Gylstorff@siemens.com>
 <536b5af253b015771a620fccec26def972331e5d.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <536b5af253b015771a620fccec26def972331e5d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e2f67a-9ebf-4e59-0b1c-08dcd3c974e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XekV1TOrsPZE+/DuUSzgya5OAf+Qviuojm+1eZecB4p3CtUyZ/UaUkcA9Yy4?=
 =?us-ascii?Q?DjePC6bTzLj65jx7SJ2ZEE1YdcwgKbTj7YVNObMzMUjD6w9ADcp3Zai2VPxg?=
 =?us-ascii?Q?mBKagM3XJcrcRgby8BJAcbe3FeW6VQk7tjGOBxi5UsAfYqKBFuQrCnDQn6R5?=
 =?us-ascii?Q?gY6w/lXBfoubKNXAAZJ4pQlxzZtLdHryp5kvn6LDdavLoZgYAUkPqeu2Lras?=
 =?us-ascii?Q?I//2qYVDkiNuqtJ3k6oacWv8eME6fUgEtmqYYwFsL74hbLzVBCrPc2q9R+/N?=
 =?us-ascii?Q?j+u2zcQ+H75I0UQ4CHjvrxItiX0nk5GVHyCHGeJs4ypuoNNNdbmj5r43i6UU?=
 =?us-ascii?Q?4p691qMp/E6t1g9O9WS4k946rOqACsadvmj/GyrpqBSP4rHNDXXkSLyoL4Q1?=
 =?us-ascii?Q?7ULjYtTiF6CXhRLPgAQJBARwD9xOXs8t7PXZuMbbSHl1B9SUjV7uDYe1Ngc8?=
 =?us-ascii?Q?yRv959HWInSxL5BFh32mwPAEcAKfgLvnhM1E7USsLG9I+NOEPaVjRRIoAQFe?=
 =?us-ascii?Q?icF9cHKoywuFdxmwV0BqIXO50t03ttX/UPah+deREAgYvHEcDn/WQZcNpTup?=
 =?us-ascii?Q?sdXxJLkP7ohQT+CA0A/IlHQsO5B51bCd1hoR+GFMcZqTv/Nu0yaPhGqOITMR?=
 =?us-ascii?Q?NmEH0YwNeiDs57MkSFZUsYKBvacAUafwi3lkszbF1anKGzcrwusd6gKBpPTp?=
 =?us-ascii?Q?5ZuT4d0dpz3Y67lDkoMe1odglaGEan6I1IIm+2lLcRcqRar/rUXpOarFFSDr?=
 =?us-ascii?Q?S6YTCANpBU5cXJXL8xQBOjqV0hjPb2szdrI922ndNzzUU20uts05vUZyhjex?=
 =?us-ascii?Q?WQNMu/LoJDfD1M+veHf4cRvUMl8/OiY28+LYPUXqD3h4hoA/4YecdCYTijby?=
 =?us-ascii?Q?8pVfWK+pakkMbfMOni9psCZGkd8hTDX4XfHIvod8RI3vm89gcbFe7nGKpbin?=
 =?us-ascii?Q?bf3jBrnycfZRwK9TSSXF0AA166tAJf/Ne0kAAXL7KkJ+TQjm+mk8Db212+7T?=
 =?us-ascii?Q?nAhijd2MtNLOS1RA11EmdCPC7MnkAYr6NA8aX+bu+SKEw9e/byR0TQzo3g9C?=
 =?us-ascii?Q?len4JjOUmxehasD0WT9Eliz1cDexZ/TGGyhlZHFd1Z+fClpW3bfxZJn1yuy8?=
 =?us-ascii?Q?cM05Eroq/yXyySTZ4XDw51l2RTKvH4DP8EwO/AKuJYo1FrdQFFk9KlNOlw2G?=
 =?us-ascii?Q?KgD9HurFgrXa8FwqKhU15tzgxP+o/9V2eRnMSBJGqWptnCOUupFQDU+lTpBg?=
 =?us-ascii?Q?nEuOUqZjnShYsasqIntbVFElCrDohgDCj0G3A5y5fGIjCcarr/zKIGyg5WwV?=
 =?us-ascii?Q?DRngKbgqdakiP2M+Vog0s0tRKiR3wXBQLGhqsaHKzTkWuQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6w36I/gpNM7wJnNL7PrDth8s2EQYu+GtZxFlGFG9LO5TmqVW9L9xl9XsTAGc?=
 =?us-ascii?Q?/zr3uD6xB6vRrWmkTzLlt1F2nh2tOBwigRf8zR4l+remuCkII6ce3hnDkpXQ?=
 =?us-ascii?Q?mrdu7UQVq5cf3BjKEPdXd3XpExQdqewPOt3RMD8cjgLWwqa7jNdY/sTL1OQN?=
 =?us-ascii?Q?nyDUYPP0Mx0ruWvAsVYzj+Hb0+1Am6daCuLeDy0qfXRh3gUoXhHd7E+YJm+y?=
 =?us-ascii?Q?pGQm2YeOV/so5st1GqNz47Ih6gYd2U6Jyh/YUfnKQqrwVHtGjFyUK1xGnwVF?=
 =?us-ascii?Q?+pwiBeuWw1pp7/5feuTsrqLQ9FhzQBkJtQ+Np/4D45qclRfukhFo5JLJ0J0a?=
 =?us-ascii?Q?UlgQXbRvoUvAXQ9dIKwpp4NMMEuWyyMb5KNJB9CmdQnIgmMBbwJxRwmUVb2l?=
 =?us-ascii?Q?Ka3d3aFsTppP7CGw9djc7/S18gS8AgT611Vnq502gJqhrdBtjQ4QQ2giPXGG?=
 =?us-ascii?Q?Vq141ifhpoBLNRzKsyqHCz6NBG94QdKwGubgqF4OTUD4Ms7uALYb33aft8DD?=
 =?us-ascii?Q?9OhlBpzM2eB2cLaWa1f6Kcqc9efGvAMqegyP9fbJ3jsfH+2cpLLrl/gg5N+B?=
 =?us-ascii?Q?dEuu7GFjm4qQJj68JXiYFnedRksbvGrJUJdZblVzP6m1lsZC7D7oGrZ/3waC?=
 =?us-ascii?Q?kEWfr4mub2dVrgIK/IzP+/Jy6PMioDM42O+YHdwfXFkVSbTLzittkXDyf2S6?=
 =?us-ascii?Q?OIWsz82j/uOaECp9ASsoSEutZzRy5vgqqmK2vIhCHh9t0h/cntLx34IQYPgM?=
 =?us-ascii?Q?O1TXJAXf/0YtdKceqGZs4wZttogQQzglZ0qq/hjFMgWRTa1LQFY9sU9vkJUU?=
 =?us-ascii?Q?Zl3Kv0O051A9tdSfC/i/rRBeACfWZimUHvGfHG15x34ibOUfQd4gUBCS4YcL?=
 =?us-ascii?Q?GFN0W3WUEf0zJj6WAALdUzCW8RTIq1+UcQ4WxVc8P7AREYagMPy/EgjrucM/?=
 =?us-ascii?Q?SZ+4juTGk5y7MIxVWlQnmcLdaGX7bIHNvmdinKTTe3CRLZRfCdm+xE8ET8jS?=
 =?us-ascii?Q?1PADp2TYozdAARIBsHnQeMN3LW/xOwvPdBeb+pYPr8cWahmlpZxq+a7k8S5B?=
 =?us-ascii?Q?UaHxAYpPbRYyv7ohg7KBny+N/7UMYcDI6+V7yePGyjYiYQHaklPKn343WkjF?=
 =?us-ascii?Q?FALw0cF9Kf40Qb6vyaTX82joTmP9wz66GEzwDMwMhUV4dibIYHDg1tUyWC+l?=
 =?us-ascii?Q?3+DwmJyYFkO9Hqc1X9xoKjlXM+bFgx1PdUbbQJ9wFPI7oQ96uJhhBX+LPFdv?=
 =?us-ascii?Q?NXsmypWwdFTw9+yU1CmkKaRAtCFZffsFzERxdxxuEUPYahv24GCaiuUEvxDj?=
 =?us-ascii?Q?I5haEu1XWp3YMM7nZ4xcQVXAmlQijDb5xQDOhz+9RM6s1DyttH582P6IKJua?=
 =?us-ascii?Q?/6d60egdpf/1VepCKaAEKPPtfGN/ElLowgQzValNGDSe6oQ0Xh4hidVk/8Tn?=
 =?us-ascii?Q?Zc8NfwGcKF9P+ebtnAmsoGKU89DoGGti4lOES9ZirSzpY/W7mLD6K2CZstfF?=
 =?us-ascii?Q?Lk1jZpWJNh9sjKh4qclWtiIxIdgJ9VATOSgTgN3IZH4k/JuD2TWIJC+l7pQC?=
 =?us-ascii?Q?uohZwzMGZ65gVMtrCMYGX21Rt5bGh2DZ97jTi6Put8fEIMXzLBXsrKcWcv1D?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e2f67a-9ebf-4e59-0b1c-08dcd3c974e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:55:38.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COOhq/XU2ajdZi6t2JVjaT6Jwvjj/m7DtcdFqbX0sXt99fWGJuZrgZNHHra9bvLRfTs3D9eI70Z0CZYueCzIi61/T+TT4NHot1K8yfib4zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7268
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Sep 2024 07:55:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16897



On 9/12/24 4:08 PM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Thu, 2024-09-12 at 12:06 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0doc/README.swupdate.md | 13 ++++++++++---
>>  =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>> index a5fbab9..d4d0851 100644
>> --- a/doc/README.swupdate.md
>> +++ b/doc/README.swupdate.md
>> @@ -136,8 +136,8 @@ To use other key and certificate the following
>> variables must be set:
>>  =C2=A0```
>>  =C2=A0PREFERRED_PROVIDER_swupdate-certificates-key =3D "swupdate-
>> certificates-key"
>>  =C2=A0PREFERRED_PROVIDER_swupdate-certificates =3D "swupdate-certificat=
es"
>> -SWU_SIGN_CERT =3D "<sigining certificate file name>"
>>  =C2=A0SWU_SIGN_KEY=C2=A0 =3D "<siging key file name>"
>> +IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>  =C2=A0```
>>  =20
>>  =C2=A0The files `<sigining certificate file name>` and `<siging key fil=
e
>> name>` need to be stored
>> @@ -145,8 +145,15 @@ in `recipes-devtools/swupdate-
>> certificates/files/` or in a path defined by an bb
>>  =20
>>  =C2=A0### signing script
>>  =20
>> -The provided [cms signing script](./recipes-devtools/swupdate-
>> certificates/files/sign-swu-cms)
>> -can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
>> +The package [swupdate-signer-snakeoil](recipes-devtools/swupdate-
>> signer/) provides a [cms signing script](./recipes-devtools/swupdate-
>> certificates/files/sign-swu-cms).
>> +When signing requires a project specific signing script,
>> +e.g. for using a hardware security module(HSM), an own package can
>> be added.
>> +The package can replace the default package by adding the following
>> line:
>> +```
>> +PREFERRED_PROVIDER_swupdate-signer =3D "<own signing package>"
>=20
> If you just specify this, bitbake complains about not providing the
> keys package:
>=20
> Consider defining a PREFERRED_PROVIDER entry to match swupdate-
> certificates-key
In the section above this own=20
PREFERRED_PROVIDER_swupdate-certificates-key is already set.

This should only happen if you set PREFERRED_PROVIDER_swupdate-signer =3D=20
"swupdate-signer-snakeoil". I can add a code section where all the=20
variables are collected for a snakeoil signing.

Quirin

>=20
> This keys package is not available in the HSM case for obvious reasons.
>=20
> Felix
>=20
>> +```
>> +
>> +The package `<own signing package>` needs to install a executable to
>> `/usr/bin/sign-swu`.
>>  =20
>>  =C2=A0## SWUpdate Hardware compatibility
>>  =20
>=20

