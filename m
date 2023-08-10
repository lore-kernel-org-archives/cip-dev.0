Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0232C001DB
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 10:32:05 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.63])
 by mx.groups.io with SMTP id smtpd.web10.14145.1691663517517116685
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 03:31:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RbGLXALy;
 spf=pass (domain: siemens.com, ip: 40.107.6.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfO6vsrGRBkdMHEkXIQ3ypLBuR1zUMu+/zGlDW1elZk/BCQFGloISBQEUUA+SDrScz1W/27TrtBqAJoR0pcIkIwpWbSIn4t4gdfb8r79AqvXEUU3lPUQH43tNgzYb5e+CU544E3XSBKnezOlrjY/6x9ZFs252MVccvizTkoXdiZoECxLBQw+TkyxmxbjoTVPzK3O6sWW96G28sN54qbgoID7MhGsjykee9O7DhtFJvLz2QTt8Hz9bUuNVQBcF7573qnahuGDnz8Y/V1YIflRJwPQZfWMLtcnUQw+faOcyhM85crGD1QDxw29AJZfY3FEBlKgjNjr8lJrg/9LNGVKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kECJfWlBTor/1R1Yx7ugUiJvLZ7QuOW1X8qdLaFy9Sg=;
 b=kC6KNGY1uLIDw3DJMveXjyKgWtKfObvfFsqXzVuIzR+3FseN9l7gQ9hJRSos72X5CkoNOFN9ocY9qpYZiXzJIvrmYD65+m9ZPrBh+1FcYEvM/Lq9gW1X9lLQNQd60m0p9h7EQXmG1ZitYrpYF6INI32h/2imv2WQOLKD+NCglpfrUCdRv/bskm+wCqSDpt8jLo6JaC4XYRoPNt4Nuk3ZNqB+66KdkV0tk1icvVkaBi+mUUjBM3Zt4jW46wp7M9nVJD5w2eiEHMOkemfCXOkMqrvIb4t4Z5nbmgpFUSiniyvwsSlRU54HkO4lBKaMlO7Tb7J53cQ5iUmyDjf3NxqL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kECJfWlBTor/1R1Yx7ugUiJvLZ7QuOW1X8qdLaFy9Sg=;
 b=RbGLXALyUwqEc3HfmWF291sEoH2oSaTMfF1WO5q4oPguw1WKU4vgmoqOY2EieiBFNcisLvt2MBTbSbPdJCKZKvbLQDnenvxSHPNY3SWFEji6LuyctUNoWY2RUL+XuqK/GWPYbz6dAGPN05YQLzINCdWEPUM8nAKDDlfGo2BQJsRkERlIgFGTKmwkn0I7rFf3Xub3glrC7WHvceG9ax6sQnj4pSCDwjfSlQRs0oK280AyXLa5NnkosgwyQgBPR9sOQZifRS7ChqpQy2yOmFbtLhAVWpV+rcVpmwg4qbETUJ/JX/gK6ZFTbFma+z+HFsL1UzsN35TXM/Hb8KhXIMgM/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:31:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:31:55 +0000
Message-ID: <7e6f35f5-d719-4fa8-9e8b-d549be9c6c87@siemens.com>
Date: Thu, 10 Aug 2023 12:31:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] security.yml: Add additional features to security
 image
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
 <5b400f7b-4039-2fc8-5f84-2fe647ff8a3d@siemens.com>
 <fd3970a0-2375-6838-2d7d-182c6d392826@siemens.com>
 <OSAPR01MB494502FCB30FAE2544D7E5FBC208A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSAPR01MB494502FCB30FAE2544D7E5FBC208A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6179dd85-eaaf-4e0a-a331-08db998d04a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Wdi42+AJi936kpqDcOOZUK+dbnnvpnMSw7H8psmfRdeMvx7CLSt3Lwoxdkf4+RNEhJQBHl/Qn0nPMnDzFc/6GiHrp1XT/VOgoYLRPq3yrQLwI6jLnAlY7g3FJeYzajcm1kGgcadJgAAH0E5IWk09JTpXS9g+zi8UEMFjAp8F4p/xmZMDxM6l5jC6ScnIK/d6I7vRksKrFjxDdj5Terycgces7cUJwXRaCQYNL1gBBkEk6OndY4prt7lLbWiDQSmWi0ekvz4o1eHfLFCsJkX1X3YyeZ8jECQy8Adj2YJvVjRRHsNPj39GcCpQZNZjEt5dyQhcjGGK64h7vChDT437kXd0W1fVJF2/w2YVdjX/ddoam1ksDXJwNqEzuM5vKuZfxaM9xxO6TNMllGG8YS9fBPP6eVgYaC4b21d7rWzRoSkDi+GxTMREu6th0ODSwHcWUJhSihUgXey3bGA/bSh2fgvNPaOx4/zaTRgpYJFbbjOiQkFFKfswlSP8vITfRHQYDV73rqrKclZmfdnmkPs5WDDB9AMZKLEwwAG+Jh8MnZHV4s+o7u/R5oekHOqU7ZozJtBZ/BsFf1syyYDNrS9eCo/eDLepdTYsdLAE1Gtsh/ocxmo2vcwwGejpnswuxdkdfZfjyELxtulh8PP6cqsp8w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(1800799006)(186006)(316002)(8936002)(8676002)(41300700001)(53546011)(26005)(6506007)(82960400001)(478600001)(36756003)(966005)(4326008)(6512007)(66946007)(66476007)(38100700002)(6486002)(15650500001)(2906002)(44832011)(2616005)(31696002)(66556008)(31686004)(86362001)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?c9T+B05uJ7qyFbm7VxFGz3HZWjbhjvaKjXflh8LVaTP028W0WfJ+gRV0Y8FO?=
 =?us-ascii?Q?97ACuPM8WFdhJDPUaW/wKln1/PpYRHshJCKxFaM+To3yR10ANSGYQ9xm35M0?=
 =?us-ascii?Q?F5HUdIGkJ/Lates3/6Zb0e/9hPVSfsxvaZPTBOQqD4mW7w2yNDVMUo+Qe/1c?=
 =?us-ascii?Q?Si+qLQrJEPOg2zNQyrlUxvgnSmKJTj3bj+SphskIltdQfMFhQVfeuqicDIws?=
 =?us-ascii?Q?2KIiufPAHAghBlHPzfoIivY7Rifz9S0PglG2rcM7L/5rDFU/xdRUDgCQfzTH?=
 =?us-ascii?Q?1dfHuIKjp6uKN3joWVM1HmkNLtWAF5k3ii1QIr2hZXh3zCaSt2jNMY9fgHF9?=
 =?us-ascii?Q?OqCfLm6QCq7Xk8oVoMHrvS1ZOrKbyX8s4Wn8GN4HvAgVE6CGHXSltrRY4yj0?=
 =?us-ascii?Q?Z/Tyias0C+5kQv44QL+8tUMbs8McKk8TUajd2uIwwPaoNxw85aaOU3zsBPbn?=
 =?us-ascii?Q?9nqs2YuzappLik7/eA5Z1g4CAhJG+U1Dquaubo/XKWOsDA5PYsByYSpWz96X?=
 =?us-ascii?Q?ztgt8V5Vb1Nl4m4KM72LsSOoFF4+buAGxg/+CZ6P77H1yA1N9G2mCVMIcWvZ?=
 =?us-ascii?Q?y/mdFt8KMz9Ej1P99IdEZ9eksEmFM43ibcDElzyNeK8oSmMLIrNBZhbEfnQ6?=
 =?us-ascii?Q?t7ExmW1lnpAfy51NAu+xQiG+LTQ2dtRhljy8fToqf8ND6pJkqm8jy686As47?=
 =?us-ascii?Q?GIhczrASqE1QFuFEQivl6qmctGgKAKZlWY0ate+89gzliHngtYXnW+jmdl5Z?=
 =?us-ascii?Q?0BJP4oJMycdv491dX5viETHjat3tECwHEMJ9e4WQoneSj9eZ4PBc+QGM0zoT?=
 =?us-ascii?Q?m7D4I7CnmDTi2m/VcZFWK/N6eL5X/N/3pzhe5ABjhEbATsaRCgO3F+0t+lCL?=
 =?us-ascii?Q?U5A7D8vBkP31navz4O6ARQeGoP+TGx3S9bot1/QMYVg7cq7bR7v63nAWJqEl?=
 =?us-ascii?Q?IPl0uVRqstUirBR4V3Fgn3hCHg+8lRdcJEMlFdfjRgnwp5wVpTtyiInitdEQ?=
 =?us-ascii?Q?XcLXP+cz+An4fvk4HMBQq/PLc6rIAaDyz9CrdQNHcJLl8Ly6xaSYYbDocS5C?=
 =?us-ascii?Q?KEmwKumcl2DEr6qyxsKuoJD+RPunx1J5SJ6IT1YqEe9BYMciYRKAlff3tv3T?=
 =?us-ascii?Q?7EPiRlmgkP8jtDZr1ctB/EOEYE8vVi/jFTxSy0MQ5HCNNW2meq7ugO88ky6N?=
 =?us-ascii?Q?eCEpvPnE5FqFcrIwmf+Py/RsNtF6NCH6FH0RxptU0sbPq/jzkuDNkN7GlwKH?=
 =?us-ascii?Q?k3U6Fe5j+U4lMtvuhRLwjek2erRRbzBbdnGuK4ZQDS3y1zVabEwje5upa/3u?=
 =?us-ascii?Q?5YNXIADTZ4OzwrtHF1zf2t8zg+DQaAz/ID0ElZB/R3LMpAYTMnIz/mnwqFPJ?=
 =?us-ascii?Q?sOWdcOZ/BwtHMek+ZP/B9Prwat3aMI0s+c/ZBKxAGy3w6jMvpL55F3cP5Q+4?=
 =?us-ascii?Q?jHCISHa7UeUKh9XjFsT9EvolGpmsd74scR5JJoQ80RIcv82GgrbvyOAA8uHE?=
 =?us-ascii?Q?BfVfJ/y1fhVxn3gxjd+ZPfcnNFC+/RG46mU6nm+RzAwXUR/yw6dGxgOiprzZ?=
 =?us-ascii?Q?80HPqjyU0NFb7iaGSOaJEknmYfV9affBNaBsvdeywBn4wYhUA5/BFI3LxZrw?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6179dd85-eaaf-4e0a-a331-08db998d04a1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:31:55.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWiABh0vq9zFqq1Mzaceew+k6EKqv8L/0qd9O2iheSc4qOz5jJcUTaB62EHlXtYSk5RRCpbJRC1gfSEkvGoZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 10:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12589

On 03.08.23 06:19, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Since the artifact upload is failing in CI with initrd image name mismatc=
h if we include the additional feature related .yml files in security.yml, =
can we consider switching back to this patch https://lists.cip-project.org/=
g/cip-dev/message/12304 or do you expect any other changes ?
>=20

Just fix things and *also* adjust Kconfig as written below.

Jan

> Thanks and regards,
> Sai Ashrith
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Friday, July 14, 2023 11:40 AM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core] security.yml: Add additional features to sec=
urity image
>=20
> On 13.07.23 19:32, Jan Kiszka wrote:
>> On 12.07.23 13:31, Sai.Sathujoda@toshiba-tsip.com wrote:
>>> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>>
>>> From IEC certification perspective, a security image is needed which ha=
s the below features along with security customizations.
>>> 1. Data encryption (CR4.1)
>>> 2. Secure boot (EDR 3.14)
>>> 3. SWupdate (NDR 3.10)
>>>
>>> The config.yaml will not have the extra enabled features as true.=20
>>> Hence they should be passed in the image run command.
>>>
>>> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>> ---
>>>  doc/README.security-testing.md | 2 +-
>>>  kas/opt/security.yml           | 3 +++
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/doc/README.security-testing.md=20
>>> b/doc/README.security-testing.md index c9540be..97000da 100644
>>> --- a/doc/README.security-testing.md
>>> +++ b/doc/README.security-testing.md
>>> @@ -33,7 +33,7 @@ Save & Build
>>>  ```
>>>  # Boot the Linux image
>>>  ```
>>> -host$ ./start-qemu.sh x86
>>> +host$ SECURE_BOOT=3D"true" TPM2_ENCRYPTION=3D"true" ./start-qemu.sh x8=
6
>>>  ```
>>> =20
>>>  # Copy security tests in to the Linux image diff --git=20
>>> a/kas/opt/security.yml b/kas/opt/security.yml index 1f3745b..b21f330=20
>>> 100644
>>> --- a/kas/opt/security.yml
>>> +++ b/kas/opt/security.yml
>>> @@ -10,6 +10,9 @@
>>>  #
>>>  header:
>>>    version: 12
>>> +  includes:
>>> +    - kas/opt/encrypt-partitions.yml
>>> +    - kas/opt/ebg-secure-boot-snakeoil.yml
>>> =20
>>>  target: cip-core-image-security
>>> =20
>>
>> Thanks, still applied for the release.
>>
>=20
> Artifact upload was broken by this. And the should still adjust Kconfig t=
o reflect the implicit selection of security.yml.
>=20
> I'm dropping this for now, it's more complicated, likely too much for thi=
s release.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

--=20
Siemens AG, Technology
Linux Expert Center


