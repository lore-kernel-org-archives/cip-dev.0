Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB0C433FE
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 06:58:05 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web10.7263.1666335484059728073
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Oct 2022 23:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=EtgLIK/S;
 spf=pass (domain: siemens.com, ip: 40.107.20.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDHMR2WqOwwhV1Q9pBp+6ClHJoyQYpuHeuGLQW6Vicj0e2XkNq7kLwHOsupCwUnLqqTTRMmUgLd5Spa8jBgOe9sCSJtZE+04YRkEVuJzUH8G5Zq4s0nTg9+NA1CywqP3r79q1VKTZfRcxPo8x7gLd92aPHR8oLUpYhjY9v/zYUsgCVcVJdECH3sD23EzHD9NZ1J58+j3hPl8rs+o/PDFBP/Xx5Y0JLHJW5phMglhBKxzckd7hK7kTe/eE7DHdwm8eWy5D8Mt/00MQRVQeE/hm1JrTAL7XK3LHaIddBj2bUoMvfRB3pbg505g3FXAMYAQYd665UgccyoMA6/9B0k2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt8p4XB4ByWMVLe5rwkpyHGYUFinFu0GL46AEk563sE=;
 b=YxkYVUILKD/QaDGy2nQmVhdI12Ai+yV+sSFyzE/gc9SngPPJOHp3dTmWEfE+0APFMIf+mGGi1T2uiL/AbfOoaHYAH7QAfWSiXWTbGbwf3uMg/01JYSgbDX+A7eHjzQ+6Ybf/oFQSeFaUTNUOQSoxyjYN8TlmpQEegwaAGqJIzngBlA/XXxlQ9YUmV4CdsMnZvO/3sm4ukQWlF+A2jLPT0uSxAi2f13HkgkXudl/yD1MZWp0JaXCxw9A7mLPKI8upZt5pn22LL2XCWjZ+BTvY7rQBpTaF2ScSqKuWhPxKn3xr+TKOg1WxYjF1HPY6FSl28TfO1re/Yb1hh5AuxLlw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt8p4XB4ByWMVLe5rwkpyHGYUFinFu0GL46AEk563sE=;
 b=EtgLIK/SGDkJng+tM+5B4r4H6TYQG7pcWmZITyRweg3rmmoU31JQaIJiQsP+WGP6bmTuavR4lTPz8Za14PGRqLsM7s1/gLBFBm9ZRGm9j3kIDHwcUpDaDlnP+3uI+iP8Cm7R0TBqyfpcs7caL9+0JF5xDvVRMhC07N6RncwL+Ei2d0/Kk72Yf3af87JPJMjAxhEw5HzaJCiUSXvMkSymQ5NaMtyUX1g+/I8xB99OtU7rkLRsM4H4Zc9jLULk4j7IiLmv2BKJpQlH/hVr/kXyTf6nvZTO2QWwTFhNaIMGcfGRvOHer3PKRPqnIfWyufKpUe8C4VVlY9b2xCB1Pz2SNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 06:58:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10b2:2818:6ac:68c5%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 06:58:01 +0000
Message-ID: <fb7716f5-d54b-f382-5729-4bd49b82210d@siemens.com>
Date: Fri, 21 Oct 2022 08:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: AW: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Content-Language: en-US
To: "Schultschik, Sven" <sven.schultschik@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <20221019092117.5291-2-sven.schultschik@siemens.com>
 <760608c4-0d6c-43f2-00c8-bc93de8cdeb4@siemens.com>
 <PAXPR10MB50373CBB18305FA0DB7AF6B4902A9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB50373CBB18305FA0DB7AF6B4902A9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 777e5f12-0681-467e-1cec-08dab33197fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	K9sHGJfNTyc6AsRXbzguTmDAnovv9oCKV4wnEy2B6tn/PtNta6+zvGhfwt3QIoIFIAlUR+qnbeCL/uw+NqjyqZ8dWbE65RxaiI6of80gy3XAL4l9XsU+vCqzBJpDEF3HTQFJdxVhGgJXYDD/70KaiiVLvVXOWN0+J6tO2s7Ryq8RHFgomX65RKff/h6H8qrOMlGaafnROh9kj48nxD7lPajvsY/WesBPa/2R3Et6qSYAR1LduVq+yX4Ynnlb21tqSoGPqDS78UZEmgVrl7Z3gB39WvFqQCug568cbTd+SR0I/MEFMn3oCuHSsa/TP4KW+Av/zkzJdvaoNF3xe611MpKkJBKG+RHJnHsE4eYICoeVteJQVTpeAqCq3jDdRb8n5rPRmzZTle7fiYvuuxHKiib4PfHclnyremk6D6lePji2ycSaFmQWfrt0021D605b1MEcP4pbqczMqgiZ+KdEeYR226+1f6Ag74rF8sCJ+/tE0WUqGVgd9xvwO6lSf5Bm4znNSfhwmcUqz9MjQmcJBDqreXqP8VAnGReQQl4ZP71r8WK1mlVAHnAmYIRiUd8fMgy4ogFqB4dHOYeoR9y8xN+F4zxDlmLUODGlEnZrKUFCEZonTxKmMpd5duFZQlrD7CBTEw29latjeeAnsxV9n0ulYR4rcuF9zBWN/4ha0Sg8RSnSvjUG8nsqsJlyDPf5Jwjxx2U4sZelDI+rkkOMU5fx3vRsQMd+19Fl7iG9bELFzHf5A5tblP3AbtqRvgvf59/r2168QGCF+/cnwXCfNQ5VH3QH0/Fdbw110OVyClo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(82960400001)(31686004)(5660300002)(44832011)(2906002)(8936002)(38100700002)(41300700001)(66476007)(8676002)(66556008)(66946007)(36756003)(110136005)(31696002)(86362001)(186003)(2616005)(53546011)(6512007)(26005)(6506007)(478600001)(316002)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YeL57OwdJ3o1ZY7dmDaXqsXaPaB09uGh8kUP6kl+v68lZROVs6QjZYCR+OI2?=
 =?us-ascii?Q?wFliTCc1yCn5RaT3Da0E+2SsrVmFbcJu7LTr1EGKYCjwO2S3+6PmH9+ZSsCo?=
 =?us-ascii?Q?bd+Vo2/2/xXT3ruq8nHtfRAp3KWxRD0w/gNgpCYKJ+KVcwTffYJTNU5z3z+c?=
 =?us-ascii?Q?sfQZwFtGhPTZxG2Z4OjOoSVGC4/vs9Oi8YcDkP4NLH08rVpAMsHMA5clwSXe?=
 =?us-ascii?Q?M9G+qqJJtd7HZUQPUKC6rrMlxVIqn7x/aUu81gwLGBuYh6JGdVliYXkjzHbE?=
 =?us-ascii?Q?6LFOvNjU332Tu+YPqLaCaxiXlk75m6wYlGsUFyEEet15hIyZsYI63xG1Xz8p?=
 =?us-ascii?Q?2OeugodpOPiUQgazwYeDRu8C/2iB3qzP7WOnh9s+vMdfQ68gunPetFVIOiPX?=
 =?us-ascii?Q?+PQ3ctoHQ/Q8hwMtmPv1a0jAlJTLqBQLLPHxzLXvofYWQ1XgcomVCIVshMgi?=
 =?us-ascii?Q?OT5Er9sgAzyhc+6qXwvTY8djiZPBdmftdieQbLU/aWkdB8dFUeEDadniuLej?=
 =?us-ascii?Q?8KEvOIMmgMJhurxlHfS2dOLRV404I365BzUXPTjaTDY92rmFghM0LzeTfd6Q?=
 =?us-ascii?Q?ZQtAQXl3YsP+09RZzjx1K9wjRF0gDKERChSPDSAgvs2Z+niGoN7LJLQ7DwtF?=
 =?us-ascii?Q?pekKdONEOPb3jGhC1a87BSR0ZAttC1gKlco7obVu0CTjt83udP3H7NYtx7pd?=
 =?us-ascii?Q?C7dIdtNsFWe35GuVO5kK9XWNOztraoX9rfBluZlOpPQLLLsSTVQa1gcnct4A?=
 =?us-ascii?Q?0RRaT0iCCYi2DflILt0z4rL1B0e1/DHzZzTaEgNIZAxC1hAYXhBLC9FXjdLW?=
 =?us-ascii?Q?ymXdzm4ktOmOtOSd8R0AaTQyPpqKFtLErssVSjIWyRNpvcw/4idirXjoyQ0y?=
 =?us-ascii?Q?/5tTcDFY8XRNiGbrZf3wAT2TmYMZDw5HpOv/V047NjZLlKdjoDkv4btQme8R?=
 =?us-ascii?Q?b61XsAsVovJB1HmlmNW+asSGL0UB1XJJvT3wHH4qSiDQgLNg5GP+wtCGiq96?=
 =?us-ascii?Q?TS5bzblvjAvZZvtRqGT2BKqgFDa6ISwECqZqWMROB1nhgI0UaSumfDVZnE8v?=
 =?us-ascii?Q?/tXWdR49c2H0Zz9D0vzmM9+t3Ep17Brctoj+eKiU1PfjVIX6NtGGXULcF6hv?=
 =?us-ascii?Q?HvSRUswr6zWFLRaqR77TeX4j+pOC4tg3RAvU0LoAsmCrAf2TSvALPj/Tprw2?=
 =?us-ascii?Q?I6pRvOWD42gLUN4mFel6X4doxPw1XLW7Y7qeembeKwzrsc9R4t3WZCExMwm7?=
 =?us-ascii?Q?fD3/ervxoi83GKEJg799BKmU/+1i56H5hJp1+iZKoQ9bUtaB7PXYVM+7dXsG?=
 =?us-ascii?Q?Rf3qCH0AMOsTkKpTDNbTagC1X27UpxQ9G/9OSe7v3+25h0E+16otOO+5INWW?=
 =?us-ascii?Q?mfJR1cS8azu4eKav2VbPWQaJuEkm8MHuz0zE42REKuhWQlnFccUxcV+oGmEE?=
 =?us-ascii?Q?KeOgO7dxsC7bP38Uki7cnPVW7MS/Twe1eE6WVfadYu5OT8C1U7q0kigs2pRs?=
 =?us-ascii?Q?tpYBrdQffdEg9lsW6NbS5JBmJuZ9lDj9f0BlP5OvAW10tt6Tt/GMD2Ly4Lk1?=
 =?us-ascii?Q?XrHRcckh+xCc/R2xHbu7FtfyTj6vwLh3EMkIZJk8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777e5f12-0681-467e-1cec-08dab33197fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 06:58:01.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVBdCRqelJRsIVDk+SGXLjKb+4J7KvSTtW47SCo3avvNs5TslbvGoaWXooqURK8xhw0WwkZ919nNZ00FiygFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7349
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Oct 2022 06:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9800

On 20.10.22 18:24, Schultschik, Sven wrote:
>=20
>=20
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Gesendet: Mittwoch, 19. Oktober 2022 12:58
>> An: Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>; =
cip-
>> dev@lists.cip-project.org
>> Betreff: Re: [isar-cip-core][PATCH 2/7] add recipe for for edk2
>>
>> On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
>>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>>
>>> +MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
>>> +LICENSE =3D "BSD-2-Clause-Patent"
>>> +
>>> +inherit dpkg
>>> +
>>> +SRC_URI =3D
>> "gitsm://github.com/tianocore/edk2.git;branch=3Dmaster;protocol=3Dhttps;=
destsuff
>> ix=3Dgit/edk2;rev=3Dedk2-stable${PV} \
>>> +
>>> +git://github.com/tianocore/edk2-platforms.git;protocol=3Dhttps;destsuf=
f
>>> +ix=3Dgit/edk2-platforms;rev=3D3b896d1a325686de3942723c42f286090453e37a=
 \
>>
>> - gitsm (see patch 1/7)
>> - please factor out revisions into separate variables
>>
>> Or can we also address the revisions via release tags? The recipe carrie=
s a
>> release version number in the end...
>=20
> I checked and edk2-platforms does not have any tags. In theory you could =
use always the latest. But then you can't reproduce the builds.
> The version of the recipe is the tag for the edk2 repository, which is al=
ready in use
>=20

Indeed, seems revisions are managed via the tags in edk2 and the
submodule shas there. Or via edk2-edkrepo-manifest (sigh...).

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


