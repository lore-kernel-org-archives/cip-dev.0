Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C42C41513
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 05:28:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.83])
 by mx.groups.io with SMTP id smtpd.web11.4633.1718342883398014864
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 22:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Kga7VHFZ;
 spf=pass (domain: siemens.com, ip: 40.107.20.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRP4LUj1iXrfgabWYKNgIG5LeXaiWEe4/wls4nRS5suHVuB3z0ZX9ZGHrcRXmdxAX0tUXANGpoq8qQ9UbTuMaxvBuU9uz09iJCgBVHkZI4FMfkMkq+GpKMT8/n3eSH6h/CvOeRKJKpdAixRxIjSpwqjNL+iW+j0WUf2ouEXpA2VslCPy4OI7VNortHfKLJprwvGhxJYEo7gQI6ZV8Xer14EDqa1iLdDY3h5+J68CVoEikO/eYYtmnO7AwNulW4CSofP08TLUvf9HXXe2y5Wd4lDPVv5kH/UbR2a+spU9ovun78ivTDgbeC1XnWg5dmEiepzTYclpu6Dgf3lR3I0Zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Df604Kf3LipH9wTj9NrbtY/Wqst8e+3iMFq2AS9R1g=;
 b=d2tYuE7hWCdWXwXBzBv5yg79vGboO26biZO258Qs7K3b7pioluVbi15A+e6MrM6xlQduXXa0h389eUnNe/ayRC9+bFhp30Q2gUZrLMoBG3R9TeWLsuZJBOFglvL4IEqW7fGBdS0CnIJPgNcmDnrc/x5ZvdVcu48BE9Ec7h5F2AErN5LCpUNXz5/3U119cFzyLipWOQ/1d79AcqnhZDQJMDZFuiV93OctdY/Avx70h9axO3IMFlmNlP1mI/2G4cUevgKiELu8L9ZWaz65PyUXhutPlWzbYRXqKXdCQCAVOERdkotEAwXETbhT7mrKbCllHG4U8szth9qloKL20zlKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Df604Kf3LipH9wTj9NrbtY/Wqst8e+3iMFq2AS9R1g=;
 b=Kga7VHFZV5wEwmhYiaHMUqwG3FoS5A5/CyMWxLXkuXJ86rq4uFlDorawMPqp1WYt+eRGoYYpWBdmrFEaEF5etwbWqz9XuwSySxF/KrQmJIOwy1BFAsawcVN1iLYPtuow+paZ7CBSoStR2FLHU/hP8c66XtKCdYPvx6WWkhNNX/R0bVsouMq2Cfh2hQ5GDFCBHvkhvEldeEoPhQHfRuTgMNYPOzUr6yHCues5+7Bhp7ofcRsDkni0V7orzH+XxdFxls4hkX/WW1maVKGw6TUI8ppO+Fh1qkWnvfJHs5szlspkRB7lyKwPfg0bkm/bpHfoOJbrnlHSmMzFGkgHymi3JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 05:28:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:28:01 +0000
Message-ID: <e0cde917-7b95-46eb-9686-36e953d0b7c9@siemens.com>
Date: Fri, 14 Jun 2024 07:28:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 2/4] submit_lava.sh: Add script to submit the
 jobs prepared from templates
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240607095229.490871-3-Sai.Sathujoda@toshiba-tsip.com>
 <5327056e-3280-4961-a562-3311605c254b@siemens.com>
 <OS3PR01MB61034416598CF3645BB3143CC2C02@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB61034416598CF3645BB3143CC2C02@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a4b7e8-a165-4660-94d6-08dc8c32c272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?65c5v2cJYH+UEqZbdo3tB2yobxs6RuAjju2iLP3km93tqQXRAQIcQxLvaYjz?=
 =?us-ascii?Q?HgDeWD0yCsbznbv6eugpASuH22VC0LRoH81OaFhOuPUxn97jjop5AgUL4jdF?=
 =?us-ascii?Q?HmAbdNb+R2Nn/R0kiQw8MAU7zo/VwUQ2z+OzszeZNfD7uk7Rrr7uCa9ZRAvt?=
 =?us-ascii?Q?vbnbnvsUG8gYEdk1dIjp5W68SsUsCWCXbaCr0Ze4HK1K97dGn6/BtznyqASC?=
 =?us-ascii?Q?Dtb856owCVvdT41m0qirZJNwAVo7itqdf3bj+4OG12J+R2orzn/uy14byzD4?=
 =?us-ascii?Q?zP40cblXcZ20nbdeyxO6u8JGaiIFOg1xILTQslP9M8O0QygRSwtzO9VtmHGP?=
 =?us-ascii?Q?w2+jXJdRWwcPl2bHoj+tLCsDadT84HaeUOo6ZQ4iRtw4yTfTNjyDL8FSrxOV?=
 =?us-ascii?Q?1D4WioprPXDyR+wWN9V63J4S1OI8KgLj8+Kz79XPt1IYa49mPwqRpH8GQsVC?=
 =?us-ascii?Q?QSKSYser9BbNVyz/UwaKH/5A/7ENeMnEXcbVOmrB0/admCigsYprOGXrPNfV?=
 =?us-ascii?Q?/GJA885Mpw1t3mdGEJH7BMCyIBvVjYd3eOuw4G2sYgbHvGU5GPrv685HoFBs?=
 =?us-ascii?Q?Vv1PL1Nd736US8wbCnFPzTgTqbZV8i86NdO14qmMQFjCdbsfukJuIhzoT8ip?=
 =?us-ascii?Q?JZVeCzi1A3INJI2QuonkeSm3El20cxGFZ1WCm4nD3kfZJHCIkibv9RZ0n87s?=
 =?us-ascii?Q?NFkS4BBjsoJ/prkxxYuLmmjPfPmZahL5gLSgdgJ+FC+eMapRiKnLr9Id92HY?=
 =?us-ascii?Q?GkKJvysUrnOAIovJHa8Ed3Y9xzN6T6wZfcZj6DtgYCySWMtj1NDAOv0Uu8Lt?=
 =?us-ascii?Q?QLVwAs6MinWRxnrB0GH8FoSqILzGqhlUoqFhOkBlFesuQ4Mw6PKjhuD8pKpM?=
 =?us-ascii?Q?PYX2ryhHREjMAiFoXsflIC8Utvsl5TFVRSPTwXTaWLszA97v806qMTTiIaJN?=
 =?us-ascii?Q?kP4cfNPGoonbDozQQ6uBllMLtZZKHem4DjBQipYo2Pp32RDLnsCUKqM90DF1?=
 =?us-ascii?Q?vLveZK8JjTVKu+U3SVe2sGaBQtHq6wSGObfi74fdrKxQXxM9hR+daA/hkrzZ?=
 =?us-ascii?Q?pQshWXJHkC4uAubZOitkJymhda4CfInUF1AKWMPJ9EXEdFiildynir63VkIr?=
 =?us-ascii?Q?W2j7A2aR9fYKCLMeKh8i45Bjku4A1r72v2paSAaIVsWs0RPi93RWXiIYa2kE?=
 =?us-ascii?Q?tCw5QzCdfkve73WmFf8AkEGcSVEGxQ2CJPKLo+frg40UZ3ecmznvXqbfK3Yd?=
 =?us-ascii?Q?XcnPXUXXRH2vF+KdIp3f?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?64+3H64MrVFAmIG6zXB8nZos9+WEKZD51vTLN+PsRxKrRhbjgVsjKUc2QTOQ?=
 =?us-ascii?Q?91LJafrB2z3sjMB1XnjEIL61WXbfvBvXvDAriYNWPtibeGeDSsD5NAs8gILy?=
 =?us-ascii?Q?Gr3sKEHIZ4bt95AGxl7LA26uUBl7hlEqpxrX1IFHPySquEE09jgbBhG3gcuH?=
 =?us-ascii?Q?VkwM2Z6tXzOgwVkaRKwvC3T92i53Ui2gqG+cZyAGUwU/E4LRmjYF3rNry4UI?=
 =?us-ascii?Q?OJv947faaUeyXlHlbIsiRBY6lPWxco6IsKxGnfAVFK6C1/OCFUe+YgjHqfTk?=
 =?us-ascii?Q?JgKWhTd+xW3XUSAIPdRCxShJDf598SQk1MXDdlWQk9Pqk/95zWd80jEZDWMq?=
 =?us-ascii?Q?JkWVqCaDU/3dc7ME7zItY1YKFtB4PCfIwlxsONNcTZswIP6I6MxIJ/W+FGgN?=
 =?us-ascii?Q?0a7LDPOnNhK9WY468+XoniZ1MZZ35YKojWo0nmflZ5PzEmSsvrNiKD4hJkU1?=
 =?us-ascii?Q?tORl2bHOC6KXm3Hv98oweBuxpQoqBMFyH/KZPKkE++IlCdvJZVC2HE5dVbcF?=
 =?us-ascii?Q?54E8v17aKy/k075WUhrjvC+c30zq/JBVldmLZkV30WSBvgO27ZpYQnQMenB0?=
 =?us-ascii?Q?UFbao1GWl/84Vyfrcm+VHEkSMcRhzpxuDlukBjnGlPelCGVtl3/cVcwQllRl?=
 =?us-ascii?Q?SbqICAgBhcYUTr6Txh/yN699Sj/Rp83OHuotP1KxVrq9hZF89GmVEPm4Ukdq?=
 =?us-ascii?Q?2BIOqtxz2QpUjM+yTjFtk/1+mQyJZSaTqFiXWX+30tcb43nfcrxLMvAbFQry?=
 =?us-ascii?Q?P8Id6bgxfnh5NlsXp8XsctE0eoT6LUwjbWXShMqSFfH/pdKOhjszlGyPMTIb?=
 =?us-ascii?Q?kuoMwz4/8OPzuiGn1f1xm4+x2DvC1sJlRCqZ+qbgCSWE6Q7Df5iHZcEYG/9i?=
 =?us-ascii?Q?PkRGpd/8hdmaaw586Fhty2Z71AR/RWYRw6I3+ijS1cHlOiAj/e+XFGqUBp4k?=
 =?us-ascii?Q?hG1LqCZcuueZGeN8JJY9WI5+Z4mrjn1AoPo3G6pcFoHu0VuZs/SWAwYsFTxR?=
 =?us-ascii?Q?6ZG9peEav6mv+l2j9GGTHDgDE+KrSLTNhxSDkB2cxzXjfs8jV7pHbV1Ys941?=
 =?us-ascii?Q?Xt8qf5+eprusEXfvGZbLrkltpdE2mCRG3b//lwgQ02WC/Giohjcv1wwzCKmc?=
 =?us-ascii?Q?wWTwzySCKuQAiu/ZGsiBtiQtQEMYRCwJrO6YjTezbY0i3RfumnjlSjfCGlO5?=
 =?us-ascii?Q?Y1HC/6jPj69A31BQUSuU2MF1xD2u1dZHHnIXxFfWi1McglmOuU0ZNMxAZ4y1?=
 =?us-ascii?Q?B3kOZrkJ/pt9ewh1JzwLZCL7pxENopsClG8nN5aAS+9e3dHc/ZIqWvP0me95?=
 =?us-ascii?Q?wICUmd4/ryRwIfp+AZ0RUxDu8MU2AjGVf0R4WRjDjDE2+HIVgGD693Hgf82U?=
 =?us-ascii?Q?/yS6ds9Wlc+8R3oezVF0A9bf4lzm5R5EWEmtU3BfUr5AG17hSlqnbvzZGpv3?=
 =?us-ascii?Q?drEXULAy8oO5pCVo7cxN0gmizg/UpmNnOI+z2fu/FchYX2gmlpfQqLkXJyfO?=
 =?us-ascii?Q?hdyGRp6ZdrMaYUvCke84kClpdv7Elw6QmmVmFLdv6x3V0xMHhSZidyDPvArQ?=
 =?us-ascii?Q?UjeQxrRDbsQRHFmJuWB/DLWt/AYE6UWvnoKM7oe3Cz5fg8ICc2bFhXiGGgVy?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a4b7e8-a165-4660-94d6-08dc8c32c272
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 05:28:01.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tsy594utK2db24CUXn+0VPwpnzdosVPUbRQiV5fgdGrmmahUwQh1xPHV7dPyhtpQval75JZvK7XlY50tTDlwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7043
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 05:28:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16228

On 12.06.24 12:48, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> We did not have specific reason for the split up. Instead of having 11 te=
st jobs, we thought it would be better to have jobs specific for each funct=
ionality we are testing. But if you think it is better to have separate Git=
lab jobs for each LAVA jobs then I will send a patch for that. Please confi=
rm.
>=20

In the light of failing LAVA devices (or labs) like you just reported,
it might be better to split so that retries can be limited to the
affected jobs.

Jan

> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Friday, June 7, 2024 8:58 PM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core v3 2/4] submit_lava.sh: Add script to submit =
the jobs prepared from templates
>=20
> On 07.06.24 11:52, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> This script creates job definitions from the template files included=20
>> in the test directory and shall submit these jobs to CIP LAVA=20
>> platform. This script will wait until all the results of all the submitt=
ed jobs are obtained.
>>
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>  scripts/submit_lava.sh | 464=20
>> +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 464 insertions(+)
>>  create mode 100755 scripts/submit_lava.sh
>>
>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh new file=20
>> mode 100755 index 0000000..a22fba7
>> --- /dev/null
>> +++ b/scripts/submit_lava.sh
>> @@ -0,0 +1,464 @@
>> +#!/bin/bash
>> +# Copyright (C) 2024, Renesas Electronics Europe GmbH # Chris=20
>> +Paterson <chris.paterson2@renesas.com> # Sai Ashrith=20
>> +<sai.sathujoda@toshiba-tsip.com>=20
>> +#####################################################################
>> +###########
>> +
>> +set -e
>> +
>> +#####################################################################
>> +###########
>> +LAVA_TEMPLATES=3D"tests/templates"
>> +LAVA_JOBS_URL=3D"https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/sc=
heduler/job"
>> +LAVA_API_URL=3D"https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/api=
/v0.2"
>> +LAVACLI_ARGS=3D"--uri https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${=
CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/RPC2"
>> +SQUAD_GROUP=3D"cip-core"
>> +SQUAD_WATCH_JOBS_URL=3D"${CIP_SQUAD_URL}/api/watchjob"
>> +SQUAD_LAVA_BACKEND=3D"${CIP_SQUAD_LAVA_BACKEND:-cip}"
>> +PROJECT_URL=3D"https://s3.eu-central-1.amazonaws.com/download2.cip-proj=
ect.org/cip-core"
>> +
>> +WORK_DIR=3D$(pwd)
>> +RESULTS_DIR=3D"$WORK_DIR/results"
>> +ERROR=3Dfalse
>> +TEST=3D$1
>> +COMMIT_REF=3D$2
>> +RELEASE=3D$3
>> +COMMIT_BRANCH=3D$4
>> +
>> +if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=3Dfalse; fi
>> +
>> +# Create a dictionary to handle image arguments based on architecture=20
>> +declare -A image_args image_args[amd64]=3D"-cpu qemu64 -machine=20
>> +q35,accel=3Dtcg  -global ICH9-LPC.noreboot=3Doff -device ide-hd,drive=
=3Ddisk -drive if=3Dpflash,format=3Draw,unit=3D0,readonly=3Don,file=3D/usr/=
share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=3Dnet -dri=
ve if=3Dpflash,format=3Draw,readonly=3Don,file=3D/usr/share/OVMF/OVMF_VARS_=
4M.snakeoil.fd  -global ICH9-LPC.disable_s3=3D1 -global isa-fdc.driveA=3D -=
device tpm-tis,tpmdev=3Dtpm0"
>> +image_args[arm64]=3D"-cpu cortex-a57 -machine virt -device virtio-seria=
l-device -device virtconsole,chardev=3Dcon -chardev vc,id=3Dcon -device vir=
tio-blk-device,drive=3Ddisk -device virtio-net-device,netdev=3Dnet -device =
tpm-tis-device,tpmdev=3Dtpm0"
>> +image_args[arm]=3D"-cpu cortex-a15 -machine virt -device virtio-serial-=
device -device virtconsole,chardev=3Dcon -chardev vc,id=3Dcon -device virti=
o-blk-device,drive=3Ddisk -device virtio-net-device,netdev=3Dnet -device tp=
m-tis-device,tpmdev=3Dtpm0"
>> +
>> +set_up (){
>> +	echo "Installing dependencies to run this script..."
>> +	sudo apt update && sudo apt install -y --no-install-recommends lavacli=
 curl
>> +	job_dir=3D"$(mktemp -d)"
>> +}
>> +
>> +clean_up () {
>> +	rm -rf "$job_dir"
>> +}
>> +
>> +# This method is called only for arm64 and arm targets while building=20
>> +job definitions add_firmware_artifacts () {
>> +	sed -i "s@#Firmware#@firmware:@g" "$2"
>> +	sed -i "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" "$2"
>> +	sed -i "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/qemu-${1=
}/firmware.bin@g" "$2"
>> +}
>> +
>> +# This method creates LAVA job definitions for QEMU amd64, arm64 and=20
>> +armhf # The created job definitions test SWUpdate, Secureboot and IEC=20
>> +layer create_jobs () {
>> +	if [ "$1" =3D "IEC_Layer_test" ]; then
>> +		for arch in amd64 arm64 arm
>> +		do
>> +			cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}"/IEC_${arch}.yml
>> +
>> +			if [ $arch !=3D amd64 ]; then
>> +				add_firmware_artifacts $arch "${job_dir}"/IEC_${arch}.yml
>> +			fi
>> +		done
>> +
>> +	elif [ "$1" =3D "software_update_test" ]; then
>> +		if [ -z "$2" ]; then
>> +			for arch in amd64 arm64 arm
>> +			do
>> +				cp $LAVA_TEMPLATES/swupdate_template.yml=20
>> +"${job_dir}"/swupdate_${arch}.yml
>> +
>> +				if [ $arch !=3D amd64 ]; then
>> +					add_firmware_artifacts $arch "${job_dir}"/swupdate_${arch}.yml
>> +				fi
>> +			done
>> +		else
>> +			cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/"${2}"_amd64.y=
ml
>> +			sed -i "s@software update testing@${2}@g" "${job_dir}"/"${2}"_amd64.=
yml
>> +			sed -i "s@) =3D 2@) =3D 0@g" "${job_dir}"/"${2}"_amd64.yml
>> +			if [ "$2" =3D "kernel_panic" ]; then
>> +				sed -i "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sys=
rq triggered crash@g" "${job_dir}"/"${2}"_amd64.yml
>> +			else
>> +				sed -i "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - cont=
inuing will lead to a broken trust chain!@g" "${job_dir}"/"${2}"_amd64.yml
>> +				sed -i "s@echo software update is successful!!@dd if=3D/dev/urandom=
 of=3D/dev/sda5 bs=3D512 count=3D1@g" "${job_dir}"/"${2}"_amd64.yml
>> +			fi
>> +		fi
>> +	else
>> +		for arch in amd64 arm64 arm
>> +		do
>> +			cp $LAVA_TEMPLATES/secureboot_template.yml=20
>> +"${job_dir}"/secureboot_${arch}.yml
>> +
>> +			if [ $arch !=3D amd64 ]; then
>> +				add_firmware_artifacts $arch "${job_dir}"/secureboot_${arch}.yml
>> +			fi
>> +		done
>> +	fi
>> +
>> +	if [ "$2" =3D "kernel_panic" ]; then
>> +		sed -i "s@#branch#@maintain-lava-artifact@g" "${job_dir}"/"${2}"_amd6=
4.yml
>> +	elif [ "$2" =3D "kernel_panic" ]; then
>> +		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/"${2}"_amd64.yml
>> +	else
>> +		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/*.yml
>> +	fi
>> +	sed -i "s@#distribution#@${release}@g" "${job_dir}"/*.yml
>> +	sed -i "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
>> +
>> +	for arch in amd64 arm64 arm
>> +	do
>> +		sed -i "s@#architecture#@${arch}@g" "${job_dir}"/*${arch}.yml
>> +		sed -i "s@#imageargs#@${image_args[$arch]}@g" "${job_dir}"/*${arch}.y=
ml
>> +	done
>> +}
>> +
>> +create_cip_core_jobs () {
>> +	if [ "$TEST" =3D "IEC" ]; then
>> +		create_jobs IEC_Layer_test
>> +	elif [ "$TEST" =3D "swupdate" ]; then
>> +		create_jobs software_update_test
>> +		create_jobs software_update_test kernel_panic
>> +		create_jobs software_update_test initramfs_crash
>> +	else
>> +		create_jobs secure_boot_test
>> +	fi
>> +}
>> +
>> +# This method attaches SQUAD watch job to the submitted LAVA job #=20
>> +$1: LAVA Job ID submit_squad_watch_job(){ # SQUAD watch job=20
>> +submission
>> +	local ret
>> +	if [ -z ${CIP_SQUAD_LAB_TOKEN+x} ]; then
>> +		echo "SQUAD_LAB_TOKEN not found, omitting SQUAD results reporting!"
>> +		return 0
>> +	fi
>> +
>> +	if [ "$TEST" =3D "swupdate" ]; then
>> +		squad_project=3D"swupdate-testing"
>> +	elif [ "$TEST" =3D "secure-boot" ]; then
>> +		squad_project=3D"secure-boot-testing"
>> +	else
>> +		squad_project=3D"iec-layer-testing"
>> +	fi
>> +
>> +	local DEVICE=3D$2
>> +	local ENV=3D"${DEVICE}_${squad_project}"
>> +	local squad_url=3D"$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${squad_projec=
t}/${COMMIT_REF}/${ENV}"
>> +	ret=3D$(curl -s \
>> +		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
>> +		--form backend=3D"$SQUAD_LAVA_BACKEND" \
>> +		--form testjob_id=3D"$1" \
>> +		--form metadata=3D'{"device": "'${DEVICE}'", "CI pipeline": "'${CI_PI=
PELINE_URL}'", "CI job": "'${CI_JOB_URL}'"}' \
>> +		"$squad_url")
>> +
>> +	if [[ $ret !=3D [0-9]* ]]
>> +	then
>> +		echo "Something went wrong with SQUAD watch job submission. SQUAD ret=
urned:"
>> +		echo "${ret}"
>> +		echo "SQUAD URL: ${squad_url}"
>> +		echo "SQUAD Backend: ${SQUAD_LAVA_BACKEND}"
>> +		echo "LAVA Job Id: $1"
>> +	else
>> +		echo "SQUAD watch job submitted successfully as #${ret}."
>> +	fi
>> +}
>> +
>> +# $1: Job definition file
>> +submit_job() {
>> +        # Make sure yaml file exists
>> +	if [ -f "$1" ]; then
>> +		echo "Submitting $1 to LAVA master..."
>> +		# Catch error that occurs if invalid yaml file is submitted
>> +		local ret=3D$(lavacli $LAVACLI_ARGS jobs submit "$1") || error=3Dtrue
>> +
>> +		if [[ $ret !=3D [0-9]* ]]
>> +		then
>> +			echo "Something went wrong with job submission. LAVA returned:"
>> +			echo "${ret}"
>> +		else
>> +			echo "Job submitted successfully as #${ret}."
>> +
>> +			local lavacli_output=3D${job_dir}/lavacli_output
>> +			lavacli $LAVACLI_ARGS jobs show "${ret}" \
>> +				> "$lavacli_output"
>> +
>> +			local status=3D$(cat "$lavacli_output" \
>> +				| grep "state" \
>> +				| cut -d ":" -f 2 \
>> +				| awk '{$1=3D$1};1')
>> +			STATUS[${ret}]=3D$status
>> +
>> +			local health=3D$(cat "$lavacli_output" \
>> +				| grep "Health" \
>> +				| cut -d ":" -f 2 \
>> +				| awk '{$1=3D$1};1')
>> +			HEALTH[${ret}]=3D$health
>> +
>> +			local device_type=3D$(cat "$lavacli_output" \
>> +				| grep "device-type" \
>> +				| cut -d ":" -f 2 \
>> +				| awk '{$1=3D$1};1')
>> +			DEVICE_TYPE[${ret}]=3D$device_type
>> +
>> +			local device=3D$(cat "$lavacli_output" \
>> +				| grep "device      :" \
>> +				| cut -d ":" -f 2 \
>> +				| awk '{$1=3D$1};1')
>> +			DEVICE[${ret}]=3D$device
>> +
>> +			local test=3D$(cat "$lavacli_output" \
>> +				| grep "description" \
>> +				| rev | cut -d "_" -f 1 | rev)
>> +			TEST[${ret}]=3D$test
>> +
>> +			submit_squad_watch_job "${ret}" "${device}"
>> +
>> +			JOBS+=3D("${ret}")
>> +
>> +		fi
>> +	fi
>> +}
>> +
>> +# $1: Device-type to search for
>> +is_device_online () {
>> +	local lavacli_output=3D${job_dir}/lavacli_output
>> +
>> +	# Get list of all devices
>> +	lavacli $LAVACLI_ARGS devices list > "$lavacli_output"
>> +
>> +	# Count the number of online devices
>> +	local count=3D$(grep "(${1})" "$lavacli_output" | grep -c "Good")
>> +	echo "There are currently $count \"${1}\" devices online."
>> +
>> +	if [ "$count" -gt 0 ]; then
>> +		return 0
>> +	fi
>> +	return 1
>> +}
>> +
>> +submit_jobs () {
>> +	local ret=3D0
>> +	for JOB in "${job_dir}"/*.yml; do
>> +		local device=3D$(grep device_type "$JOB" | cut -d ":" -f 2 | awk '{$1=
=3D$1};1')
>> +		if is_device_online "$device"; then
>> +			submit_job "$JOB"
>> +		else
>> +			echo "Refusing to submit test job as there are no suitable devices a=
vailable."
>> +			ret=3D1
>> +		fi
>> +	done
>> +	return $ret
>> +}
>> +
>> +# This method is added with the intention to check if all the jobs=20
>> +are valid before submit # If even a single definition is found to be=20
>> +invalid, then no job shall be submitted until # it is fixed by the=20
>> +maintainer validate_jobs () {
>> +	local ret=3D0
>> +	for JOB in "${job_dir}"/*.yml; do
>> +		if lavacli $LAVACLI_ARGS jobs validate "$JOB"; then
>> +			echo "$JOB is a valid definition"
>> +		else
>> +			echo "$JOB is not a valid definition"
>> +			ret=3D1
>> +		fi
>> +	done
>> +	return $ret
>> +}
>> +
>> +check_if_all_finished () {
>> +	for i in "${JOBS[@]}"; do
>> +		if [ "${STATUS[$i]}" !=3D "Finished" ]; then
>> +			return 1
>> +		fi
>> +	done
>> +	return 0
>> +}
>> +
>> +check_for_test_error () {
>> +	for i in "${JOBS[@]}"; do
>> +		if [ "${HEALTH[$i]}" !=3D "Complete" ]; then
>> +			return 0
>> +		fi
>> +	done
>> +	return 1
>> +}
>> +
>> +# $1: LAVA job ID to show results for get_test_result () {
>> +	if [ -n "${1}" ]; then
>> +		lavacli "$LAVACLI_ARGS" results "${1}"
>> +	fi
>> +}
>> +
>> +get_junit_test_results () {
>> +	mkdir -p "${RESULTS_DIR}"
>> +	for i in "${JOBS[@]}"; do
>> +		curl -s -o "${RESULTS_DIR}"/results_"$i".xml "${LAVA_API_URL}"/jobs/"=
$i"/junit/
>> +	done
>> +}
>> +
>> +# $1: Test to print before job summaries # $2: Set to true to print=20
>> +results for each job print_status () {
>> +	if [ -z "${1}" ]; then
>> +	# Set default text
>> +		local message=3D"Current job status:"
>> +	else
>> +		local message=3D"${1}"
>> +	fi
>> +
>> +	echo "------------------------------"
>> +	echo "${message}"
>> +	echo "------------------------------"
>> +	for i in "${JOBS[@]}"; do
>> +		echo "Job #$i: ${STATUS[$i]}"
>> +		echo "Health: ${HEALTH[$i]}"
>> +		echo "Device Type: ${DEVICE_TYPE[$i]}"
>> +		echo "Device: ${DEVICE[$i]}"
>> +		echo "Test: ${TEST[$i]}"
>> +		echo "URL: ${LAVA_JOBS_URL}/$i"
>> +		if [ -n "${2}" ]; then
>> +			get_test_result "$i"
>> +		fi
>> +		echo " "
>> +	done
>> +}
>> +
>> +print_summary () {
>> +	echo "------------------------------"
>> +	echo "Job Summary"
>> +	echo "------------------------------"
>> +	for i in "${JOBS[@]}"
>> +	do
>> +		echo "Job #${i} ${STATUS[$i]}. Job health: ${HEALTH[$i]}. URL: ${LAVA=
_JOBS_URL}/${i}"
>> +	done
>> +}
>> +
>> +check_status () {
>> +	if [ -n "$TEST_TIMEOUT" ]; then
>> +		# Current time + timeout time
>> +		local end_time=3D$(date +%s -d "+ $TEST_TIMEOUT min")
>> +	fi
>> +
>> +	local error=3Dfalse
>> +
>> +	if [ ${#JOBS[@]} -ne 0 ]
>> +	then
>> +
>> +		print_status "Current job status:"
>> +		while true
>> +		do
>> +			# Get latest status
>> +			for i in "${JOBS[@]}"
>> +			do
>> +				if [ "${STATUS[$i]}" !=3D "Finished" ]
>> +				then
>> +					local lavacli_output=3D${job_dir}/lavacli_output
>> +					lavacli $LAVACLI_ARGS jobs show "$i" \
>> +						> "$lavacli_output"
>> +
>> +					local status=3D$(cat "$lavacli_output" \
>> +						| grep "state" \
>> +						| cut -d ":" -f 2 \
>> +						| awk '{$1=3D$1};1')
>> +
>> +					local health=3D$(cat "$lavacli_output" \
>> +						| grep "Health" \
>> +						| cut -d ":" -f 2 \
>> +						| awk '{$1=3D$1};1')
>> +					HEALTH[$i]=3D$health
>> +
>> +					local device_type=3D$(cat "$lavacli_output" \
>> +						| grep "device-type" \
>> +						| cut -d ":" -f 2 \
>> +						| awk '{$1=3D$1};1')
>> +					DEVICE_TYPE[$i]=3D$device_type
>> +
>> +					local device=3D$(cat "$lavacli_output" \
>> +						| grep "device      :" \
>> +						| cut -d ":" -f 2 \
>> +						| awk '{$1=3D$1};1')
>> +					DEVICE[$i]=3D$device
>> +
>> +					if [ "${STATUS[$i]}" !=3D "$status" ]; then
>> +						STATUS[$i]=3D$status
>> +
>> +						# Something has changed
>> +						print_status "Current job status:"
>> +					else
>> +						STATUS[$i]=3D$status
>> +					fi
>> +				fi
>> +			done
>> +
>> +			if check_if_all_finished; then
>> +				break
>> +			fi
>> +
>> +			if [ -n "$TEST_TIMEOUT" ]; then
>> +				# Check timeout
>> +				local now=3D$(date +%s)
>> +				if [ "$now" -ge "$end_time" ]; then
>> +					echo "Timed out waiting for test jobs to complete"
>> +					error=3Dtrue
>> +					break
>> +				fi
>> +			fi
>> +
>> +			# Wait to avoid spamming the server too hard
>> +			sleep 60
>> +		done
>> +
>> +		if check_if_all_finished; then
>> +			# Print job outcome
>> +			print_status "Final job status:" true
>> +
>> +			if check_for_test_error; then
>> +				error=3Dtrue
>> +			fi
>> +		fi
>> +	fi
>> +
>> +	if $error; then
>> +		echo "---------------------"
>> +		echo "Errors during testing"
>> +		echo "---------------------"
>> +		print_summary
>> +		clean_up
>> +		return 1
>> +	fi
>> +
>> +	echo "-----------------------------------"
>> +	echo "All submitted tests were successful"
>> +	echo "-----------------------------------"
>> +	print_summary
>> +	return 0
>> +}
>> +
>> +set_up
>> +create_cip_core_jobs
>> +
>> +if ! validate_jobs; then
>> +	clean_up
>> +	exit 1
>> +fi
>> +
>> +if ! submit_jobs; then
>> +        clean_up
>> +        exit 1
>> +fi
>> +
>> +if ! $SUBMIT_ONLY; then
>> +	if ! check_status; then
>> +		ERROR=3Dtrue
>> +	fi
>> +
>> +	get_junit_test_results
>> +fi
>> +
>> +clean_up
>> +
>> +if $ERROR; then
>> +	exit 1
>> +fi
>=20
> Besides the shellcheck issues I already mentioned (plenty :) ):
>=20
> This schedules multiple LAVA jobs from the same gitlab job, but also not =
all of them in a single gitlab job. What is the reason for this specific sp=
lit-up?
>=20
> In xenomai-images, we run one LAVA job synchronously in one gitlab job, a=
nd we dump live the LAVA console output. Makes it more integrated, and you =
don't need to follow links outside of the gitlab UI. Downside: More runners=
 need to stay in stand-by while waiting for the workers and devices to fini=
sh.
>=20
> I'm not strongly pro or against a specific way, but I would like to under=
stand and validate the motivation for the given one - and possibly adjust i=
t further.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center

--=20
Siemens AG, Technology
Linux Expert Center


