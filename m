Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C4DC4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 11:46:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web11.33859.1702467951528950014
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Dec 2023 03:45:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Bis1939s;
 spf=pass (domain: siemens.com, ip: 40.107.22.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eF10rBACq20brFTvUMcC652bDJPY3e4JSVeyLKAqpNbmp3QoOfY1Gzjn9F+V8qaAvpoDrGGZ+teHv9MZ8HI/zYj6UjblY9GYJywsHlXxJAcZorMkxfd22/fYrWRfAhkCverlYPp/SGcgzLmZjj2C8kOHQL2mcojpW0i/MeoPiuKmC1uwPrHpgP7fRN0Poa1ypKKNzgN16eefpiiGpKMNz8hQdBhVRTtg+JksYTU+ftZB37QzcGo8MR5JhYhTfAlMDw987KWE0Tn0AMwc+d4BvutsC/SZToJvtL2+vOrgNL71wXsLsxPHNQ942tCA2Sekfi6r6wBtp0uaYCiRCQF/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/V9nK/NrjPz8HjcK94fk9W/sExyyLZlQW2mhO6+GQk=;
 b=J3mo16puknTztyxeaCJippkwZHUPJhr+61+TRjPDj8ZgoLwKEIfNsRsuzNISZD5KizY0ZQ52H7x9xIEtS93rMhdY4oFrv3uJFdLxRCFrCq6vnfqzir808yaEeS99zGkd27zIpIxWfER74IVOvv68J+KDVvA9VAmYMJMbFLxaKa5kMCQ3mhen3GLHjrs36uCYcDdUJ37cOZzUdH1QK/pKUqSKAys9kYEfmAS+Cvq7fXveaqFb5vqRLd93YDk0FZhGobJu8kDt3q8LjprufN2eLpFb7ziAyBbHrYL6XYsnJBqR1KY16+xaJ/ebqGIHx1wzcUq3ht79bW1ghixJydG9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/V9nK/NrjPz8HjcK94fk9W/sExyyLZlQW2mhO6+GQk=;
 b=Bis1939soRfwGmfHOtPKxR+UJ8kq7p3+v79q+qfqC0e4kn2QmuJ6wwD3l0rrwC/hGJiO3wb97X5Rh6oiSGi9t29islbJr6uue3F2gpFbtxyofcLBYMwmvguBwsf2SoQjZZaXveT89jPVoG+R9A5ERdHcH4zvZpMBicbmtRhTEEJfK1XHnaNSr435mHg4BlrDrcd2SaTN0yz08CDCNb3aP3ksnhTZpvgRBrJvOefIsKVCi+hVcakIV62gTkDdoMDG/xPIABWii4LTH0SAQU/WDS4LQW8sMm4IRMnFpJwLnPezHcfbBetj1WMuwBMEdKRbmBvQn9vmZk+lDSJ30cU6BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB7932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 11:45:48 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 11:45:48 +0000
Message-ID: <1bd6fc08-38cc-4bdf-83d8-96f56cfdbce7@siemens.com>
Date: Wed, 13 Dec 2023 12:45:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-certificates*.inc: Add
 missing FILESEXTRAPATHS
Content-Language: en-US, de-DE
To: Moessbauer Felix <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
References: <20231212141556.1616031-1-Quirin.Gylstorff@siemens.com>
 <9b8314f6059fca9fb270921b8ce53e2149ec40f6.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <9b8314f6059fca9fb270921b8ce53e2149ec40f6.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 188e3816-a7bf-4632-95be-08dbfbd10c6b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4CsP0jrfQdnAbNhPvOEYHtSvOewHuehgBpxQMieYZsCs4RaBkC2zanPIwSiF+ZDaR3PaupzdRjun8ohs8+IYCwYApcHJqGWN9xdFXtQzoVlVUzcM99QHSoSVkEcmMkkhZRenfVMV4w86GB7DaH9EcerkV/Bab0UY2jNzPk649CSjsJvz6MRoiJlfMvzXLxtf+8mJE2KGDRrLuMVbt7rvTwtCyIuvYBUp3MwZy57+PFvY9QbaxGYBYFtTYSswroN4TKjh0KrdqhUworxrGvoUgB6RPoDzX0405qZk5LrnZFleBHmVeggmRSh0D5UvytY1aGkkPNJlyu8Sg6iljYvFMmBD/cTQaR3hrWca+53h1nQswGDhd11Ke/pN+3WzOSr3+TU2KM1bOoLhU/BK4ofOfS2cpcsBvh3DUWjBYfg8hS1kgMGjknIYUIsXL10VLd5mOiJLaqf7KoN63oAAeV5clesdtHsgc+jdl4BGxMHLEwniwyNGEXxQ8zLYWcheHIJ9gUnHvO/MCDE5Abc8lr8ZSVQyFWJHtXV4P7fFowrAoIMmckyhPAkucwF8pc86VqVAOCEJkc8RPQSw9OJazkEf1AypZS+9AfG5i2ZfyXFoyDC11sPjyqMnXmecDy5DIoXxE6Gc104tQGdU5Sk4TKBDQQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(38100700002)(26005)(5660300002)(8936002)(316002)(6636002)(8676002)(2906002)(4001150100001)(478600001)(66476007)(53546011)(41300700001)(6512007)(6666004)(6506007)(6486002)(66556008)(66946007)(2616005)(82960400001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9KJ15hWQ1ggHEKMw/PoX1SHP4ukjcYUaP29lRxGyTK3G5IEBPPIcaArSzVwE?=
 =?us-ascii?Q?qNSvRZAg18Lp3LCwzFWcVcQsZrc8e3nUKtFaJDdXcVPP7A+gKqcIsO65Y/0c?=
 =?us-ascii?Q?rhRLAOncMkYoOsu9viTI9Zx7a6W7032SGnBz0VfcMfQkQrf7NS5rTc47Aym0?=
 =?us-ascii?Q?u3Atl4rQMbP1eqH2kcBFw3s8uahth5Kuw+YwfsZpUWHWQN28PLtbVlPiZBiM?=
 =?us-ascii?Q?ZfpEH+k9vAkQvBE9ReSzHDV3fNc82vE1K9D3ewJv+OL0ObAlLlYvWXP1E90n?=
 =?us-ascii?Q?cFqa9D6JWTEbRD1RrXBfa/cgQ6NvP8PZFgLxJAvDZEhNPWNf0fgh1nNfsYaR?=
 =?us-ascii?Q?7AzNW3EbEczxPhYMyZriOXV3YQ+UYiznJoayQhRYY4GtRz0DAmnd83M4opj3?=
 =?us-ascii?Q?NI8ki3iTd1rZDAWAk/6HikffmFdHiAZnlRQtqCjWGmB87efjVZLHtuD2aukl?=
 =?us-ascii?Q?CNgCl9iKd0Rwy5YgI2HHB5aC4OcK5sOIMW2pN1OEvmmvS63AdAuQlfGhsqKV?=
 =?us-ascii?Q?VobMseVNuhtloi885n5P5Zt6bjfsQq+VE8n5rWRbn1qgTm/PqoyqHNkCPG/d?=
 =?us-ascii?Q?B/KdlnpAgzVoNYtS7vT6vBs7V6z10q38hAusjKpjV+Vjw7ayTp6oGAu+Xx8z?=
 =?us-ascii?Q?Rm76Xtkt1W3QLoTwsa2GqxKO9GyhoNWizT8Ei5l0i1KlweyHNyKugpVxW2DZ?=
 =?us-ascii?Q?hCLrO4NEjqctxynjW5BMODNU5kwd0qKKpPtaCqZnvrRlRhc6KbaJtTmHrJ5c?=
 =?us-ascii?Q?Wf+LwPTbjij5/fYNeb6Ay2nt14ltuM/hlbrImB/pvg69J34Caqc/hcI/yL/B?=
 =?us-ascii?Q?nvlMDagMWrOxt7kB90mW6gOep8Z4eBU1dVviwL/FbFovZBldjX7IO0h3GefH?=
 =?us-ascii?Q?WxeCnRDioVSXU1k5XF9020udsdpitI9qheiIzC8m8p9xbXIFMu1HKrbGTOUP?=
 =?us-ascii?Q?up2EkeAQVbSM4KFnRyhTGv1lDBOTqEpGUy8vsjXWHowQY4tHm8NnxIS/0A7j?=
 =?us-ascii?Q?y+qexxDGzaKtO1JFaQkwVzRi56J7zb/8dczdsliZ9Ij9cBVuveXBZG02Ctxb?=
 =?us-ascii?Q?U8AaO4gNwukmuCyzbbg+pJtg1fW3FoneCf5b1BKWVt/zNNUEXVDm6PQXw5Ci?=
 =?us-ascii?Q?aeOzHd+kEcJvcesRAGlMoui0H9opYhXyDCXLW7WDzAx+He64EymgM/sigl05?=
 =?us-ascii?Q?WwVzy6GSCc1MplDtTaib8B5Y2NkPoq5FgqAeRCxS//D9yorA5q3EtRtMydSq?=
 =?us-ascii?Q?aGExBzaTED/TjTrYSgwM+oKOCUeBpLwSPPRsMpCh+LbjLyzWi8DoMlUT1e0Z?=
 =?us-ascii?Q?OUyQCSKU70e9D0PaEaVN+hR1SrruHD316zsMROdJAVegHeJ5xFrFepodobFR?=
 =?us-ascii?Q?4lG4S/0+tjEysw5kVjURO1Qk6wsJUG064zqHGelIKR+sOFc7humPhQscpndZ?=
 =?us-ascii?Q?4uXV5JG7Q6vK66lke/nrYkCuDuOaJV0B7sKhLcQeQugl6YhR1Llh3h9Belor?=
 =?us-ascii?Q?XiISA+uPi5ChDSpA/NyEjXC480mn+kElVLHNwUgQJlLB8kg1/zJ0aGlPo/5x?=
 =?us-ascii?Q?Pyq5IGNShQfrAc+oMEJkB8bJY/AaBuPrt3vMNnebumZ94S6dK1oDXsDCLw6c?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188e3816-a7bf-4632-95be-08dbfbd10c6b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:45:48.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gePy1I/vJ5Y0qvm7EUVwtMAPLtDpTyMHzlNF7DN1E8/W11gBDm84fkrmPkGc/3zmS9JDPtPZm01UoYkhL/foSdhQuQ1qNRg0QlUO8inN+jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 11:46:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14067



On 12/13/23 04:27, Moessbauer Felix wrote:
> On Tue, 2023-12-12 at 15:12 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to include the files in downstream layers.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0.../swupdate-certificates/swupdate-certificates-key.inc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
>> ++
>>  =C2=A0.../swupdate-certificates/swupdate-certificates.inc=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
>> ++
>>  =C2=A02 files changed, 4 insertions(+)
>>
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-
>> certificates-key.inc b/recipes-devtools/swupdate-
>> certificates/swupdate-certificates-key.inc
>> index d3d2e16..2c67e89 100644
>> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-
>> key.inc
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-
>> key.inc
>> @@ -11,6 +11,8 @@
>>  =20
>>  =C2=A0inherit dpkg-raw
>>  =20
>> +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"
>> +
>>  =C2=A0PROVIDES +=3D "swupdate-certificates-key"
>>  =20
>>  =C2=A0SWU_SIGN_KEY ??=3D ""
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-
>> certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-
>> certificates.inc
>> index 6673383..564dda4 100644
>> --- a/recipes-devtools/swupdate-certificates/swupdate-
>> certificates.inc
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-
>> certificates.inc
>> @@ -11,6 +11,8 @@
>>  =20
>>  =C2=A0inherit dpkg-raw
>>  =20
>> +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"
>=20
> Hi, did you check if this is compatible with sstate caching? We must
> avoid adding absolute paths to the signatures, as otherwise this breaks
> caching on the gitlab-cloud-ci runners.

This should not be the case as it is added=20
recipes-devtools/swupdate-certificates/files/swu-sign-cms scripts.

I checked it with sstate-lint and it didn;t find any problems in=20
isar-cip-core.

Best regards,
Quirin

>=20
> You can check that with the isar-sstate lint script.
>=20
> Best regards,
> Felix
>=20
>> +
>>  =C2=A0PROVIDES +=3D "swupdate-certificates"
>>  =20
>>  =C2=A0SWU_SIGN_CERT ??=3D ""
>=20

