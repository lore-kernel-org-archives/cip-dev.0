Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA3BC48BEB
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 06:51:55 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.85])
 by mx.groups.io with SMTP id smtpd.web11.8941.1707979904681000724
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 22:51:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ssagWqTI;
 spf=pass (domain: siemens.com, ip: 40.107.14.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH4NdJ2zv4y4cd4M9Bvh6UP8mMubhCiaIzBjdu698fzVtN+BAc6lZvVQ7tG9h6i/OygkAta4MAcznNLECz5+XKYsDVu4+xmQNGBj6fl1rLA3v65eeXsIinuTAz07CJM7tFw1pbCbjHqNo9sCEKIJbEQnSBG3FBzgOIca+5RsTUbviqgxEmTrj6JTZJXWviBV1QXR94NihftI1tpqPmbRQ8xSSvbFePFpOwZ4MGs3P9yRXzEohyXBvRtMHTdUQIqsRyj1udtP3BahKr6jPyAfIS+p/0+1/K99ymjDfgYqskLoANxrIIfZqtmmrgP9xkMSHtmb2EntQzLMzhVHZms9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTjfk+ukmdoVcxPamRWdru+JuHhg15gX5WyKs506oME=;
 b=ahYu3gfwRc67ZNAy9LFIeChsLCQq3TTYI37rgoqfSJvjJzrNq+3WTr5dQwixir8DqhTVeV8rTZulLoosdKi222QkbRO0mG/ppQ1Be7buQMoPfHdOZ+JzV1EI6IUGh790D2e3AaP3dsbwqMiWaln2jvbt4UvpLkobgzIksuOuBGUde+27JEfsVYXTTTg3rLaEecW+9hfJyssU/2zd1iLgysg3rieF4ZVRadHQ6XVQcZtfwFdZGuCg9wll340P+ricF+pJnBG/AhzrbLe+UyYDQsQOmoCbC8uyY4lQ4BMXjxTs5EaC03nxMjrC+7945AcmMEZm7iuf/4wRZxzJiKrp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTjfk+ukmdoVcxPamRWdru+JuHhg15gX5WyKs506oME=;
 b=ssagWqTId/XkzGMGtc50TAGVlJVcTRFZdVzWM9evjMmhwIxGURN7XN//A+LcKMYmOJtEMOkYaZqGUoZ/PWu3R1TxKNIF3fatrT2ryMq0tPVT82EupqjshMEbk5h+17+CVQZrKQEoqP839G58tEBIkkIKXspt1T4Ex7vxKBn2+6sesSv8H+jvC0a/N8aoEtzkCqF3jGZ6wNEHShGWPPBUi/v735PiDhdARoCAl34nNq35wwNPGaCAAS23NizIDei8F0t5tn9IkDt9WPpdCOz3OBkXMzumZ0rd0iUgzpaawVZuZNRbUZqmAaCGu1PFp+avVlw9gETUBdagJMKUpEOOLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB3986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Thu, 15 Feb
 2024 06:51:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 06:51:41 +0000
Message-ID: <87c49bbe-ba08-4418-9309-57003dcbe417@siemens.com>
Date: Thu, 15 Feb 2024 07:51:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 2/2] .gitlab-ci.yml: Add condition check in
 .build_base to build v2 image
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240214154820.3544080-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214154820.3544080-3-Sai.Sathujoda@toshiba-tsip.com>
 <6a4bfb1e-7240-4714-8794-ac30fd1900a3@siemens.com>
 <OS3PR01MB6103B068B261D65EA7F23733C24D2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS3PR01MB6103B068B261D65EA7F23733C24D2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB3986:EE_
X-MS-Office365-Filtering-Correlation-Id: 5765cf35-be27-4bab-b3bc-08dc2df29095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y5MTWHBZsZ0g/m9nR6eFV7nV4gZ0uC3pD5UnURAAlz2T3XyUMqlWcVxH90DwZwFj9zE0P7wFymeirbYNkY+Czlhu71x88gcqscgDlmTNPjOmH+y5qyCuJcxK67CPwVJY7n8l9tzCYBGaVGeESyQQ9xv259fu/ubtUUK5uHIjnVvDc/grHfgRlsHWqjPfhBjGdcVr7++OqySb5H4K2VNVmtbFDgMiPMbKJZ62n4RbgdRTjaFem/sukd1WhR085uLS1e4jqZZ5TUVMjH7/U7RbbeaNEOw7InpOYO5JPdhZHjA6/iylDHM1L8o+sjRGDLlwBjn7hZPR864USLsNWtehLE+3dpQ7/FVxFD+nYgBH+GDBJ2O9atIKCK5P8RUOGx33JUrrrsXbuobxdyi3HrFP1GQRnNUPqsnjmv8weeInRAZzmqTSAKOj8VU7ZGu55+CCzW60FDn3yKQj+StNV122CehqSPE8XLrU137TLJnuegjIULnabcCdqHaGOMtXAl5uQVSsniTOJESyYTNS3P/UzNhpEdkMcP3zDE3+a++WjP7/sGJp8AuJxnOGq3Ybjp87
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8676002)(66946007)(66476007)(66556008)(44832011)(83380400001)(2906002)(4326008)(86362001)(36756003)(478600001)(82960400001)(38100700002)(316002)(53546011)(6506007)(6666004)(6486002)(6512007)(26005)(5660300002)(31686004)(8936002)(2616005)(41300700001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YlArWNe79nqAURbK+kZEyb+uk+XcqJPEKMb1UIUY7bhjDRzui1eQqTWBz/+7?=
 =?us-ascii?Q?+elufraczcOquB3QU2+oNEqyYwacECxtcD2ZL0nhfGOPJwU2zSLbv6H2vcOo?=
 =?us-ascii?Q?qF9A+MtLchfos2yZQpqPawK7zptrm8v4IAF10j2bAUEQV/VBzKwrwDU+E8Ds?=
 =?us-ascii?Q?ECWut66pX8bhQYTsLjLMBjWH8ZJgenO8Gq/B5pAa3KMy4Ba7G1AbkPbwuIIm?=
 =?us-ascii?Q?ykv1SDCPJkUi1e7Tt9Tbmv5H2V5bBVhiDdy8BVrioZPA7BTMhZiu6Qkve8UU?=
 =?us-ascii?Q?wA1anaR0Pn9P1OoinDk1E3jSXdmZPCL0eiHaLo9n67NbWjGfMJo3cvmy2Clq?=
 =?us-ascii?Q?00T4NYzOVTKF3RE5lyNwKTuuQQ5F0PlAaALbaBMaa3hhEpdTqZnRiOXtzD+E?=
 =?us-ascii?Q?QzLw7n+qXVQjFmTcBSmHHkBMpnoA6idq7BW470/CkZANaXA2Ys277CyM5BsK?=
 =?us-ascii?Q?yqQThsA7eXd061Z/sCRdN5R423lDdgx19WZiIaesUA3Sg8AkZ28v9HGC6ACs?=
 =?us-ascii?Q?aPmqhCPWfo8tGG8VcRUFl68UIgegV1dD1RgNVXX0K30+KliW/Xwe2hBxooMj?=
 =?us-ascii?Q?lvP/fEEJcNiEFHvnKOW4bKqJOqZNb9tLMBsG2wFM9mgJwII56FpMfObx+lWB?=
 =?us-ascii?Q?EtKLW2I2nnVnKBH1YeftrCwCC/HbWu9Rx5yknDa8Os5hd+IvP0+OyiBqIzGN?=
 =?us-ascii?Q?IVoWvsAb30iJtJqDGUgrba8+L9scn4auNEYzDJXmq2g5y8LkNQzFITHg1fX0?=
 =?us-ascii?Q?1j1rdmEFHdzqnWT4Fc/jwYxZTEtbiLlJqO33zSr8tCWazKxnjREqpKu+rxmD?=
 =?us-ascii?Q?tBZ8Et1+K6RWdNn2KwY71GM/VOoHjPFGENe8Qc46MxiZdNcVgD7IbOTRhuGA?=
 =?us-ascii?Q?6I6rYw4kETtcACPFeKaBICRqirtr7TNIGbOUT46j0lAQm2TbnXNbu1EeXW1y?=
 =?us-ascii?Q?RECY8vUm+qGec8EnsXIx7QiEO1KX0MYN4tzlC7sdYHEoU04bpTGgUiNBD66L?=
 =?us-ascii?Q?lIBYouRRI3fzmlbYfzktTjeyWQlb0ufMpXWyN6vB6+HdLoU4h+mP9/nRaFSb?=
 =?us-ascii?Q?ez8laoLH4JBOlpDJmH3pUnywcy1uUK/20nWMLsDK5py0TZutaHme04c3XigV?=
 =?us-ascii?Q?4emLvhH4auPPtWBKyt16BZYImltxNP/fXtXMho28BBP+Ha1pU+YtRTf6KeM9?=
 =?us-ascii?Q?cSoWArUehEFdAHoiF21OBFos3nH2D7PnwmPHVWb1TdGHQqiOLdr/im5uRdI5?=
 =?us-ascii?Q?SItlzVYB5tbP0EM+OlyNjXoaI4Kuy8aVOTZ1mQxKQuDerXzSEIjtw0wZPdLY?=
 =?us-ascii?Q?ToRYBpiwpHtZchAx0LTut95oNbl/qIkHSGXNNiUEDedxKI2VC2lQn4jVMHjx?=
 =?us-ascii?Q?Lgw/Ltkl1LQw4zLxa1AUjYtkZGP3s+yWA6Z8dLPz48T/RAtCvtaMOigQ3vu5?=
 =?us-ascii?Q?xbOjbSSx8uxbFQIuQWsLGrnrQAcCUV6zWRGlB2+y5ZEXzTKkZfd6Ox5XyXWv?=
 =?us-ascii?Q?etuXdec11Kka2yeEVqPRUIPUL7QFDv99nFpAp15cIZ3AjVSWWBgFDfTAl8is?=
 =?us-ascii?Q?LLNp5VizOVztZ+drnOQWA4eJ0pcNVEUQNU98Zwik7QpSMgeyzWzTkyQhcXSe?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5765cf35-be27-4bab-b3bc-08dc2df29095
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:51:41.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3CFA+SH92YzFRaIQY9zulAWK4EcNL1qHpWqSQNCx5IdF9u5DFt/8kNVF6IS3t5rTVPvRFd8hZ6hJPYjelzcog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 06:51:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14986

On 15.02.24 07:01, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Thank you for your comments.
>=20
> Using 'build_swu_v2' switch to decide whether we need to build the second=
 image for it's .swu while extending .build_base is more relevant. We ll ma=
ke the change for that.=20
>=20
> Another thing is we want to completely occupy $6 parameter in both the pl=
aces the deploy-cip-core.sh shall be called from now so that we can avoid c=
onflict if some one wants to introduce 6th positional parameter in the firs=
t call to deploy script. For that we want to declare a new variable name 'd=
eploy_file' with it's default as wic. We shall use 'deploy_file: swu' when =
we build the v2 image. We can also hardcode "wic" and "swu" as $6 parameter=
s in deploy script calls instead of using a separate 'deploy_file' variable=
.

Actually, I'm not fully happy with the interface yet, even when using
"deploy_file: swu" because that mode still seems to deploy more than
just the swu. Maybe you can make sure that in this mode really only the
swu is pushed. That would allow in the future to push image, firmware,
you-name-it in one step and add the swu right after that without
uploading bits twice.

>=20
> I also wanted to confirm that I added   - > under the script section is t=
o run multiple commands as a yaml multi-line block.

Sure, but you are only adding a single shell command (the if-block
counts as one).

Jan

>=20
> Please provide your opinion on this, Jan. We ll send v4 series once you c=
onfirm this approach.
>=20
> Thanks and Regards,
> Sai Ashrith Sathujoda
>=20
>=20
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Wednesday, February 14, 2024 10:55 PM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core v3 2/2] .gitlab-ci.yml: Add condition check i=
n .build_base to build v2 image
>=20
> On 14.02.24 16:48, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
>>
>> To re-use the built artifacts of v1 image, the consecutive build must=20
>> happen in the project directory of the job. So if use_swu is enabled,=20
>> then a consecutive build with a minor recipe change is done to get an=20
>> .swu artifact for swupdate testing in LAVA.
>>
>> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
>> ---
>>  .gitlab-ci.yml | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index 4f87ec3..bbd534e=20
>> 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -25,6 +25,7 @@ variables:
>>    dtb: none
>>    deploy: enable
>>    deploy_kernelci: disable
>> +  use_swu: disable
>=20
> Also here: naming. This is rather "build_swu_v2", and deploy it, of cours=
e.
>=20
>> =20
>>  stages:
>>    - build
>> @@ -66,6 +67,12 @@ default:
>>      - echo "Building ${base_yaml}"
>>      - kas build ${base_yaml}
>>      - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh=
=20
>> ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>> +    - >
>=20
> Just wondering: Is there a technical reason to use "- >" here, rather the=
n starting directly with the command?
>=20
>> +      if [ "${use_swu}" =3D "enable" ]; then
>> +          echo "PV =3D \"2.0\"" >> recipes-core/images/cip-core-image-s=
ecurity.bb
>> +          kas build ${base_yaml}
>> +          scripts/deploy-cip-core.sh ${release} ${target} ${extension} =
${dtb} ${CI_COMMIT_REF_SLUG} ${use_swu}
>> +      fi
>>      - if [ "${deploy_kernelci}" =3D "enable" ]; then=20
>> scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb};=20
>> fi
>> =20
>>  # base image
>> @@ -105,6 +112,7 @@ build:qemu-amd64-base:
>>      use_rt: disable
>>      wic_targz: disable
>>      targz: enable
>> +    use_swu: enable
>> =20
>>  build:qemu-amd64-base-kernelci:
>>    extends:
>> @@ -127,6 +135,7 @@ build:qemu-arm64-base:
>>      use_rt: disable
>>      wic_targz: disable
>>      targz: enable
>> +    use_swu: enable
>> =20
>>  build:qemu-arm64-base-kernelci:
>>    extends:
>> @@ -149,6 +158,7 @@ build:qemu-arm-base:
>>      use_rt: disable
>>      wic_targz: disable
>>      targz: enable
>> +    use_swu: enable
>> =20
>>  build:qemu-arm-base-kernelci:
>>    extends:
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center

--=20
Siemens AG, Technology
Linux Expert Center


