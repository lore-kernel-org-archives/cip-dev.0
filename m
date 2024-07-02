Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49010C30658
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 20:01:21 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.76])
 by mx.groups.io with SMTP id smtpd.web11.34607.1719950472978495081
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 13:01:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QTqFiybG;
 spf=pass (domain: siemens.com, ip: 40.107.241.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVchfeTQkDsgnXCermstK6yehi+/PIqJoq3IHoMlGuUGu8dy+ADHXAzNk/0ott3vGJoe1eJ+vm+kdtuefBIs8gaa4tXbObLm0mCe9GcLr57U/AGg4a2czqb0Jrqo7KHyyYcNktRacg5/UUS3VxLz5k5yeHB/RPdqWQg2kVG9+W9wBD1EFC2RA5VTF7dJJ8DlX+LWC5IA72dsPTLd69SQ0oVj5GsZ8VlDBgo+fuvgiwknYKE1p+VzOm5aTzbl9WF6SqmMyQCWhCytRxXqaQnVv+w0RCdXUYJOWqbByZHOzy1bFuGbstpVUcYpEqGT9dM5zYJ2avKgqQrQjzzvRxmV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ciM0mSWLBLny/fJn39Q+l9CCdG1C9j9dIcbSskf+Cs=;
 b=KuyhKOgk2dR5daIALpAGwYcCpP1lBzxRJd5KeRhQPK3lS6c5bEZ5zOIQuQwyP0MLRDOmHDK3/dXEVuPYnSmHDp7XWsiRXCvJZncwQKVhCNtrGUxnmiCDYER5rgNFBPWeE3KjEIDOPA0OcwPKbcLrJwMa68NsYOXP4PM+2hqOdedmOQ5ByfCsFyMvsSnzn09lfBT9rYdmE7ljuT27ChwoYpuFdd2+FqiXIp/FLH/GUGDm2bf08aQNwMemY/usaU7zA5sQOswmZtDdYQ2m80K0YDgiv60InX7CNYuZz7vqZLISyStvwSdylRxG7BmNhi6aoy8nWhN5cFH6YiqdbyvCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ciM0mSWLBLny/fJn39Q+l9CCdG1C9j9dIcbSskf+Cs=;
 b=QTqFiybGX+INRDVBmh/a11UjNsUFpaxvuEWBPMfg6kw+HKYtP/+HF0z3o9dt+T08HsulWL137rYaioLFv8sHnXgKPzv/6ux/idSe4ozjLcDOCVyVJkPE7DeqiXGSENPSzt4fISc3oL5dIi4F5EZFk0RY9H3asCEQHPLrY1DQpbukLq+RbC6efR8h5Pn65e54WzL4cJzRYvfGjfesuRx4FS7+bMPRFqljtvxYrSF574YdYfFOjS5GJL+9khcmqakLDBMSuFsJQN/hmE7/AbC7iz99dhSrqXfl0FaW/uU/i9/R09MmP/APVb5fMmtOkCrfvwjDTKwYG4HMd8w7k0mlhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7171.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 20:01:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 20:01:09 +0000
Message-ID: <81129d86-01f4-400d-bf31-006df41be524@siemens.com>
Date: Tue, 2 Jul 2024 22:01:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ci: Only allow IEC tests to
 still fail
To: Sai.Sathujoda@toshiba-tsip.com,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
CC: kazuhiro3.hayashi@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
References: <063a4e8a-4daa-48f4-9dba-2df7961f5b95@siemens.com>
 <e9bb1b92-ad36-4a12-9a40-2ab6c523ab34@siemens.com>
 <OS3PR01MB6103277C6D5226300C60A890C2DC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB6103277C6D5226300C60A890C2DC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: e23e8f85-bbad-4483-0f4c-08dc9ad1b702
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iuTOsbHAHQWRkqBdkHXxyQocy3M3C+r4R13+W+yDf7yo6ZfVoQoQ6oMWss7l?=
 =?us-ascii?Q?VMOZDcnrhovpDEUplZco01/p9zf4l4WDe8RwBZGsXZTicCu99HgMGBusNkL4?=
 =?us-ascii?Q?bNfyQFIhMRucX042cajvGZs2WE9iChI9ng6qp542uLz7DLvjrymEMcEFgITp?=
 =?us-ascii?Q?W9tJT2U8zsuOeINxTO5zUFjhadoMrlbTiCS+z2u5R9OgdTz0HogF4mpB+lNb?=
 =?us-ascii?Q?qTh6f7bE1BAQ3lvpwPzhw5ODjcrhzYHwxMl8b4vjGiArzKvqQbSSM8wjzlpV?=
 =?us-ascii?Q?3e0Nvz9g8klL4MsO6su7hzzNpXo+yXtdwdKhh1YdOi/5xj9avd0XthvkAtSl?=
 =?us-ascii?Q?DwKnKT+t3ww++42jgTL0ShhVd8F8on8Mln1oU/4PSwQfWw3loOLV7nx379td?=
 =?us-ascii?Q?y451WOPz7J7Gl3zVBFn+iJ909qTvxd/0R1H7OEbayFAOm6WkbpaXzM0ZJt6F?=
 =?us-ascii?Q?YZGMkD9i0pqNV7ZOGi8g7+raGH5TrCEzDh1atffasLnoLDoKq89ZOEilS8IC?=
 =?us-ascii?Q?HkeybVGFC6Cs6n4olnxpxef4ro57XPChIK95eEM7PvDUFIJ3HcXy1ZHEY/+3?=
 =?us-ascii?Q?XUztdRXFmPlXThH6usCwJ9AXqKRV1P47exs/RW1dXFzivaQhaHnmUnse8EnE?=
 =?us-ascii?Q?H3Dn568agNDnFAk2fWlC9mTCoLFiQ4aBBCozNdugIUocv3SQtkfvxnLp6eDb?=
 =?us-ascii?Q?6Qm+6/RjZbtQXdxuueQvXyHFY9rMGzciGDPJ5F3wJ+Hfr+ILezmj0q4yWh6V?=
 =?us-ascii?Q?u8XQ8QV/AEBPAcxqECRxX2E7pgqP/GlBiBS6s6lplvdIi4L+X5WYzsk7vEP4?=
 =?us-ascii?Q?8Us0/mP/2VbmpUsYY6JthQ3RCC7/MGmM8ebiDZim6eA7x6G5NIOXsV1CgE0c?=
 =?us-ascii?Q?vBjG4JlyBNbnmSVt3a71ZVwHtPrvsaXCPX0RzmwOVcuzRlBdQJM150/8lvWJ?=
 =?us-ascii?Q?r4ay3YJYyt+Q9LSOaEArgCACzDPYBJ2i4/ZCwlOJp8E4dPRo3voT+/phwcxB?=
 =?us-ascii?Q?URoT52mBCe1Db2ZIJu3N+a6HUQZqfIVzBZLyikcOXJw0KEe8rtRrs77w1wcK?=
 =?us-ascii?Q?TZZeUI/0YdLYuRgJqcUwHM2Ue62FaO+AzyOdj4Ny2GTeAoY96ow8PRLJ9znC?=
 =?us-ascii?Q?7E116/k/bw9J7bfWupVtqtKPoSUDu7PQrWytdYs4ixgZfMpZmgdDirkO8Snz?=
 =?us-ascii?Q?WRlc+Qseavx/JD4yyQzNxx81iMOI1eTlFYoQSzC1gP5D0AVLlKKfkBxTl5oD?=
 =?us-ascii?Q?gaOwQTuvwsXIGMWNp13vHgSxaOMG8PiMo037GJJuEznoNKYc8iRyFY+mn7Sv?=
 =?us-ascii?Q?pekKkTSZHBI43B2lISAfhY/W?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P23igAzsAJ5EkeGqbRZI1Unc2GBAU6Iz2+TYPmbjYk/syuz/uP6ve3q7/FHl?=
 =?us-ascii?Q?wAGw5Klcd4z4KTNuOBYyTkXeGElx8+L6wbEGYki2PU5gpm/g9Rs6OREU4AE0?=
 =?us-ascii?Q?DeXSZIhBJbKJgLocZOaSWI7NzuFBzaGHvfOKvIrTgLlRY9j9Nfa4+44LnGI2?=
 =?us-ascii?Q?J0J6aR0jrEfMcM6VWevHL/RWA7noBrAvR+EcWOx8BNJmxyLo+V53LJW4cAhQ?=
 =?us-ascii?Q?Ytwv1XwsaZM5p2Bp9IjIpkjOAwSwPFkuu0iUsV1gpW103BTyxWsYhXZuxvnt?=
 =?us-ascii?Q?jbLySFCXAZt3ccMjgR49E54htrEnqRKJyHvew5fweuN//ttWwHlvavSPzoF4?=
 =?us-ascii?Q?i8bLZw7LN5l0QjQb7j+gRhyEZMfL0kD44cg4PVq31IzxmKSvBuvgoREP+UCj?=
 =?us-ascii?Q?Hu+We+J82DImSAh2OyjzUVMqI/rES4KR6K/RfFZARQ/6FO+v/vkrDgN1vnJp?=
 =?us-ascii?Q?fvBQLZCj8222gKqgPosEIvUQulJIlUr+W1/Z0OgrJRoBfEuiA2HTiqNOlcrH?=
 =?us-ascii?Q?95vd7CRS8qwqrdpSuN1k4XltGUxLjJ3gsgZUEAU0p8C2Grs3twHr/JlYVZbz?=
 =?us-ascii?Q?wDB3FMVhLs3WZGwyGlefnE5gyTcdwv4FL/ISnDDn734wUhnNa0KgNIKA/1Br?=
 =?us-ascii?Q?NZs6Mq6uLyabf4AO6MDPNDa4W7ympV5Zn8NBU+NENn1Pz6/0wDCvLwnpNyC0?=
 =?us-ascii?Q?16jaXAcepOcdSvUp3D5/qEmPM2+NYjY0D+GaS/cQgq4g64Ws/ljqCO3HEdCQ?=
 =?us-ascii?Q?qbei7ufz6GasTyeTYpkZ8eW3l/CmPwRRaJAHzkYsejWRwus+PNoDF7j44PtD?=
 =?us-ascii?Q?SIdNKNoLdQImET0jlZ06jjNcAkqFskX7pKBCAtVnZ/X7QDtixnpHqfO+7U8C?=
 =?us-ascii?Q?Fi/2I8Zgf4nRxaJPDvwfAP6YiHhrre6kWAQq1sKvGbKfm7uLNIWDn47kJdlH?=
 =?us-ascii?Q?nZQq4pUZpIjw6XXrbrK3gosanuOj6JRN9S34KYt+K35Cz4WUTDviLuEh8yDM?=
 =?us-ascii?Q?sViehvy5IV9YCpxMbWfK4QphN7cSEJxvBVSaPygHsDzjPeBmsxfPnh6P0zmr?=
 =?us-ascii?Q?BEQRmkhWSJgh/lOMgK49JpAD7XuoKef+EWp371jDGXn4oh+PntsoOGvA3mzt?=
 =?us-ascii?Q?meJSBkHnBYolbg9p5GDHDbgLWM10D9vAs9NzD49nZkIDszSPSRuoJvd8o2Dd?=
 =?us-ascii?Q?PHcva81g4mV7c/qqZwciwQIwshJd4jJSOWeUoPsL9J/L2NJsqJ9roEeiXhBJ?=
 =?us-ascii?Q?Juu6viOT98onSmHMrEXY2j+gC7w01oogzTrUJWwJYcb4jgSSOBwRtu25MHrJ?=
 =?us-ascii?Q?5ZK2fLjLkFzoBeXqBdcf2U0GQjKelA+rjzCZOcdL4mXdr4HY7gS9Ue2Xl7Dm?=
 =?us-ascii?Q?yCGLZR5kLjxnMIbGW80eEhJjJQT25rUKPBq1ZCbVBK9Gwo/hAjxaOWwOgdNk?=
 =?us-ascii?Q?M3T2RA87/52pt+V1mXiFrPzD4n1IS7/iA5h3pQgJIS+CFO1oOUQ73QLOr6JE?=
 =?us-ascii?Q?6oD3GSb3/XwAjRcV9RVT9mMZvhCYnqQA22F3++m8IshM79e7lMQAZ4EnvrN/?=
 =?us-ascii?Q?v9CCwIvLQSDNkMgZGMwHs5bTWsvkALkS9BM1XPVmsW02dV8ew5p+8pgu6eCo?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23e8f85-bbad-4483-0f4c-08dc9ad1b702
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 20:01:09.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8kfuleQGLaBNFxqivsOU+GkYCcCWA/RRfSMF8hes3tQMOgtJXuYFLJOtcwqBpO32I4O5nnrNoLttaMYEYQXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7171
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 20:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16365

On 02.07.24 18:58, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> The reason for these failures is because the swtpm package is not present=
 in "lab-cip-siemens-muc". swtpm_start.sh, swtpm_finish.sh etc. are maintai=
ned here -> https://gitlab.com/cip-project/cip-testing/lava-docker
>=20
> The maintainer of "lab-cip-siemens-muc" should update to get the below me=
ntioned changes.
>=20
> https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/3=
5
> https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/3=
8
> https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/3=
9
>=20
> We added a tag named "swtpm-jobs" to specific QEMU devices which has the =
necessary changes in their device template which allow them to run some use=
r-defined commands before booting the CIP security image on its host.
>=20
> I guess today someone might have added the "swtpm-jobs" tag to qemu-cip-s=
iemens-muc but as the lab is not updated, jobs assigned to mentioned device=
 were unable to start. So either the swtpm-jobs tag can be removed or the r=
espective lab should be updated.
>=20

Ok, thanks for the explanation. Quirin, any idea why that tag could
already be assigned to our lab? But more important is likely to update
the container.

> Regarding IEC layer tests maintained in separate  repository https://gitl=
ab.com/cip-project/cip-testing/cip-security-tests, I will send a patch to i=
nclude config revision (commit id) to use in IEC job definitions. We can pa=
ss the commit reference to the 'test action' in the job definitions through=
 submit_lava.sh. I am waiting for Stefan's review on one of our merge reque=
sts which fix most of the failed test cases. Once it is merged, I will send=
 a patch to include config revision of cip-security-tests in isar-cip-core.
>=20

Perfect, thanks in advance!

Jan

> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: Tuesday, July 2, 2024 9:34 PM
> To: cip-dev <cip-dev@lists.cip-project.org>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [cip-dev] [isar-cip-core][PATCH] ci: Only allow IEC tests to=
 still fail
>=20
> On 01.07.24 07:08, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Secure boot and SWUpdate tests are passing now and are supposed to=20
>> keep that on future changes as well.
>>
>=20
> And... it fails:
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7246397870
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7246397883
>=20
> I tried to find where that swtpm_start.sh is defined but I also failed.
> Can someone explain to me where we maintain these - as it looks like - la=
va user-commands?
>=20
> As I said during our cip-core WG meeting today, I would like to ensure th=
at all those definitions are pinned via isar-cip-core when its pipeline run=
s so that this top-level controls when a test change is imported. Any sugge=
stions how to achieve that?
>=20
> Thanks,
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center
>=20

--=20
Siemens AG, Technology
Linux Expert Center


