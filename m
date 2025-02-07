Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A20C02196
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 10:08:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.57])
 by mx.groups.io with SMTP id smtpd.web10.66117.1738922882571422301
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 02:08:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=L9dzLE3N;
 spf=pass (domain: siemens.com, ip: 40.107.22.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPCjK5A6EG3FzOGUW5cX6/UAxsHWVhV7TtVMbxQLlYkvz1hPW3NdC5AarRZbq09mpWu8QNCzfGHXvalq0vozxjHaU3vuK1iTETMV4NF5rRc/MpUW4u+b6rAlMG5lHdxdswI1Z9cQRUvH1Y7qJm8iHFAryeWRK55oTYANQZ679uDsolii/9Ez6xv4ZWxI7CegIs9bgprxLmxndFrsL24Dko+cQ4q1vnerQiXuqaM25+RCcFoTV8Fx2JLMM5dodizaCfwUtAShqlUpd+827Q43ZfkimnGTc7uObXPyW7IW3UAX3eBQKoEJsXJH4YMz078/dBvyhXjMh2TO5KwsEsOzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+ROO2ZVDO1ZxjvvsXsy+BJAnkPzyhkUyIfgWIT6I8M=;
 b=Tcdovf++KKcHGjyfFcRVeXzp+RMVTN2cz7LJyN9R3fnK/h7FtWiq2j/igHloydw/BvzPUa1C3kVttoR4/5EYSkFBZmbMjT0hQsEtnEf1tPcMNb6668YQvat1ZYzo7qebVBJkrhed7CGXouPYh1CbgDspl2myScJvhbYZoYM8tD+ugExKSG94VuisU0m8KgWq2EEFZwLmZ6hLqsQlxACHKQWEaSqP/4a12LBI6fOrUJWoRWKmktPk2r5HdY4dlYoolAiJTBbt+d3PlK6O9aE++2gMpY/eS47EkxGqaKOG0kv8R7TXWmsMFp8F9PH4vJAVMw6wVPiXKJR2J3LWwconww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+ROO2ZVDO1ZxjvvsXsy+BJAnkPzyhkUyIfgWIT6I8M=;
 b=L9dzLE3N4MHyuxIVBN2UW8UcztTZiepuOIOKYSwHFVA5FZL4KbpSr9jOx/dv3aMC6vydXRalJPxSRkg7+TZ5vay8Y4/loWRUVk/t5K8YCtQuLErc7Z6GiKH79/jB6HXNX0UwVNXv9MgBGXnCbHHXDCtTJsMGWj7dAxCsjjPwDsHUNB97olGaRXgi7ViwVW9XOvsDu//5Ktc+fkFcw88r+X65VdYsFvUmRLmCExrRr3SzPsYO7hh8catjTiV9qvE0uP8cZr9yL7CS7D91VUBs3nVWW6j/MwZR5jhc6ANQOHGrFWC+XLp7n/cdwgtfHYvGxTeTQhYNta1xDcWXY6rIDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.7; Fri, 7 Feb
 2025 10:07:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 10:07:58 +0000
Message-ID: <00d82dde-4ec6-4a1c-88fa-b91019250c8e@siemens.com>
Date: Fri, 7 Feb 2025 11:07:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file as
 template to make installation path configurable
To: Sai.Sathujoda@toshiba-tsip.com
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 cip-dev@lists.cip-project.org
References: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250203115321.3589084-3-Sai.Sathujoda@toshiba-tsip.com>
 <578c7f2c-ef52-492f-9dc8-054d6bed958b@siemens.com>
 <OS0PR01MB6100B7D4C183871F0E47D056C2F72@OS0PR01MB6100.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS0PR01MB6100B7D4C183871F0E47D056C2F72@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 0368d08e-80c8-413e-bd41-08dd475f4c47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qlkSoJ2Beu0QNUlDlhYTpwRCSxd4wct2/2s90ETzoYWBB2xae2INkLOHOl8o?=
 =?us-ascii?Q?AgiAlwuW5NiOrOzBceFO6+e2ez1Et2RXBH6R0JD967/LgtzvpHGMbqSTwQPw?=
 =?us-ascii?Q?h5414JaeA+F2J+ASlF5yELlxQ0NiSN/hu7moQMppPkcIKV1kkrtkQ1F6mmNC?=
 =?us-ascii?Q?t7sg/oehPvySLNO1zeN3ecLW7OY7ovISk5S4sbfPSb4GgySIeOdgNUVRoI64?=
 =?us-ascii?Q?mhOeRWEHJ2CkVVLW2oGl1viIVHB4X14TszAbX3CC3u8og44CWioYyaB2inVK?=
 =?us-ascii?Q?CNLkmmFNN1Aa4x9lPY0G/MmTcvF2x+b1iaTCPCXgsSktKf4geYGNCCdXdfD6?=
 =?us-ascii?Q?9qF8pZLY9E8NVVFL3HvqCHxOGlgtk02URScTvM9MzlZQPRwckVkH4MER8N4E?=
 =?us-ascii?Q?LoIzhFTYp3PauTQZ+3eirA7jragK5QIcgJHtVmSjU3Um7re60SOC8xZWu0IN?=
 =?us-ascii?Q?dJDD5pDHvthXBHBaVx9LfOScKvj89x0jVVHEoDQFXRvDZADF7CcrRx++eK4T?=
 =?us-ascii?Q?rmBgeY9Hg1tunCOWnXPJHt995j7y9wAhuR35HZTNPx8JEnZRBNPwCPxRNIBo?=
 =?us-ascii?Q?kXHlG2KPBraSXHn0bEm5VnRguQX1HGGDuJ48eCo2n+mizFVECXMnGMAKmaK0?=
 =?us-ascii?Q?z2203EVdNscfk/rCPEb1ECNgqPnPSmUDbzbIPJgH0GXJprkB9l3MYfipaAdS?=
 =?us-ascii?Q?YDbNiVpIv58mgDHRszKoxYUP3ZOdz5WCVpkopX+P/KjZQumfJdUVjnSeA9q3?=
 =?us-ascii?Q?6ZzOUPntPVhSiYH1S2cgqDx4Yaa2rdniPvAGGDH6wBu9HPUykrCUC8YBX9Hp?=
 =?us-ascii?Q?cu8vr0sjKl+EL5vyPdmDgGeRIfZflaZ9RgQnDiwZTuLcRaFvSJBVCJANsPKu?=
 =?us-ascii?Q?5PKO1DoLRqrVb4abMQ5t8+tnik4bM5nmPhjgn29629B0ywcSzawFyQ4bHMWB?=
 =?us-ascii?Q?1NKVHFzd3lT54pkNbzaNQ0v8fntqW8bSFnYxOt4mQKWhXfUjQSkwcXMLkuGG?=
 =?us-ascii?Q?SLjVlU+qplO0nJxBX9i8qbt/HgL9E1Tcnuqt58Ia1Dl1JH5Cn6jM4gy3/+KN?=
 =?us-ascii?Q?uWnuqUuLMhwgLW1xye51NyUYBBiTdNk87MwD+f4NInyKJL06cThbA0EeJ7nk?=
 =?us-ascii?Q?2lIbA25EZ6juAriLlJHr2YKDlFnk/g0r45H7PlR3kgNAxR4HHjDoC9SEHtk0?=
 =?us-ascii?Q?98Dy190Px/bVHz9oVV9W/eT7/eND9KM7vc3PqXv/5BfHs87kv1KykHjri/SC?=
 =?us-ascii?Q?xESpO7okFQSiANFdv7KbUazJGhV2aaBK6x4Chny/8QDm8vCj2eezJm4YfE4G?=
 =?us-ascii?Q?ncw3a5M0pTSY6zDHVt6g/zRse33wlTizD2FfHKXrhDkOIyhDGQtE6oE6Bf5r?=
 =?us-ascii?Q?cZhhTNtAmhxozY1mms0ethiWRQ/G?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2+Z8eHX9r00G2jSiIzD4pPUlY5GmG4twO777oWQf6E8fJu7U3wJ59GHuI0UQ?=
 =?us-ascii?Q?WPKU1kECPDSFcB+V8NbNH0dhnH0HCmEqWSD2y8j7oMgFSYqJ4/axpgY++H43?=
 =?us-ascii?Q?kuoH5XKQpu5iVzBJvnh/Gc35lNLNEblTq1fOVvkjNCLPS9xMBKREa8GttkMe?=
 =?us-ascii?Q?y5yhKqPvW++3KoFXe/Y2UQbARwsKYcs4j8s8ynJpSBy/IvZOVOVC7pjmO8bU?=
 =?us-ascii?Q?cyRzyh0lZMF2z+nRVS+zNQkUBWRDcl6kJxNHo1EVsC3iKR3BppVDs279zc5w?=
 =?us-ascii?Q?K5VN4v8yY7uLtLkA434AkgDsld2Qq8w9ngqxKvWgzrkVRNyCIt4qKv2d+cdH?=
 =?us-ascii?Q?OO/2KLOBsPafJd6DSayXDaX/NK+OaF1fCJfhzB0ihubZqTFuPsiXRzzYUzDd?=
 =?us-ascii?Q?7Q6GtXGzWYo4LYEPNXj9SqyD6uCtOSuJUfLan3IRESSaXN+sFTld2p7OtA9p?=
 =?us-ascii?Q?wyjUzH6pKg5ChwneA8XsdULpowwoRE+stS7Ag2lRkh8e21FkXIhSJwoskZ1Q?=
 =?us-ascii?Q?kCZTgi8HnVJgweLz4W10CDrqdSJCeva77FHBscQGKs0gL/6mHcfyCYh76XTS?=
 =?us-ascii?Q?Arta/4NIFXp/QZrGq9aAtyfB5qPpHGduFC4ZKUNXBvkNyzwGh28HfBsoqhxq?=
 =?us-ascii?Q?raq+gqhvodSkOV2kaZ8bpI3pS7Yzv2TeFaadVKzbkxfox1Gadis+8dB+iJo2?=
 =?us-ascii?Q?SRkJB8cvQIwWUpgVkaQFVU7WAwtIpy/OLcF0qddQwDLCxgtjK5qcKc3eTfj8?=
 =?us-ascii?Q?IPnBEMhpeqMsfv3PP5TRdW8UzsaJ1EG+cUHcFywat1h5vYrEhKuzALEKqxRE?=
 =?us-ascii?Q?RIUivH2Cb+0n9zqEVzRYPg6dZuLuiu74jV0oZkq5iROCrb/D+iLRVY6k2bln?=
 =?us-ascii?Q?6CgNN+Dar6yctu8ItLZL54UolVA7dacI8coCjoAPBOdjXXB8LA5nRlB9rOcE?=
 =?us-ascii?Q?NLC3H1xx9FtZzyJwYQEaOepdzYOtw/O5PWYArF0HVHCIxbhLGwDTcbnaSnui?=
 =?us-ascii?Q?6KeFCOfAkBoUBJZEKI5+xmKs9hjd7ciabDtylbGuE69EEyfvZb11r5M+bxPw?=
 =?us-ascii?Q?x2utrc3pMwg6Pq2u0ds/yM7t/dfNHdd1i9450twlzTt/9B3XRlCrmUAGkDPr?=
 =?us-ascii?Q?KBbcib7ojSBHvehpiTe3bpB/LAFp5Mj/dra1sQp59bZawqFzZOoMJohSOLK1?=
 =?us-ascii?Q?AgJ/uCqs4lF7dMhXMjRr33/84BnZcuAlZa1HR3UfjQXherN/WZw7uEohlG9S?=
 =?us-ascii?Q?LXOmiqv8MMxfpC+jXTzk5l30CFwi0tOT3KMu43vj2OnE4JUvLWgLRU9Y1EO1?=
 =?us-ascii?Q?FT/u88hQecYxDKZDkERo6oPUgn7ElQ4Ie7RJwLUTLs37iWDIb1EyaoFSm1Zg?=
 =?us-ascii?Q?tAnPUoeogL41V13lbCZLEBJ8z8RBj3eIj9lQoZjHtQJGqL64yUxuPBCjPlua?=
 =?us-ascii?Q?vba4zzltXVDf41GxRcAwo5iqBe+5nLEgh/07KD4/bg0dFKGm/NuTxvQbY51D?=
 =?us-ascii?Q?7KlgvnrP6smnkE9A1Iujj1dfuGzhDRMDurLG6sTtK/ZzeO6wVvmCwywSJ+oF?=
 =?us-ascii?Q?lDhEysNni/82j5oI4OM/HJz+vN/Uf7STlw48hM0cfO6VQzvz5eihaqWIUAb+?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0368d08e-80c8-413e-bd41-08dd475f4c47
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:07:58.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnkbFeR/6N03uoFWOD9EtCua+vqU1dyVmuKLSpsyOaJ0zMRM8ua/iVbSm4HwmqzK/SVA+YsEtP+RFkxr1czh6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4062
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 10:08:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17769

On 05.02.25 14:22, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> We did not want to touch the install path being*=C2=A0/opt/ltp *in all ou=
r
> test images except the case where the security image comes in to picture.
>=20
> To answer your question about fixing ltp to separate installation from
> workdir,=C2=A0 I believe the LTPROOT variable is basically the install pa=
th
> in runltp <https://github.com/linux-test-project/ltp/blob/master/
> runltp>=C2=A0script and in many areas, it works from the install path to
> access test scripts and create results there. So, I think configuring
> the install path in our recipes during build time can help us handle our
> read-only rootfs case.
> Since the workdir is basically the install path, ltp installed on tmpfs
> is cleared out after boot.=C2=A0

It looks to me like you can customize the output folders via various
command line options when calling ltp (-g, -l, -C, -T, ...). If that
becomes too unhandy or if the script is not consistent in this regard,
we could package LTPROOT/output and LTPROOT/result as link to a writable
folders.

Jan

>=20
> Please correct me if I am wrong. After your confirmation I will re-order
> the v1 patches and send v2.
>=20
> Thanks and regards,
> Sai Ashrith
>=20
>=20
> ------------------------------------------------------------------------
> *From:* Jan Kiszka <jan.kiszka@siemens.com>
> *Sent:* Tuesday, February 4, 2025 6:51 PM
> *To:* ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@to=
shiba-tsip.com>; cip-
> dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> *Cc:* dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting=
) <dinesh.kumar@toshiba-
> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
> <kazuhiro3.hayashi@toshiba.co.jp>
> *Subject:* Re: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file as
> template to make installation path configurable
> =C2=A0
> On 03.02.25 12:53, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>=20
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>=C2=A0 recipes-core/ltp/files/debian/{rules =3D> rules.tmpl} | 2 +-
>>=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>=C2=A0 rename recipes-core/ltp/files/debian/{rules =3D> rules.tmpl} (80%)
>>=20
>> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/file=
s/debian/rules.tmpl
>> similarity index 80%
>> rename from recipes-core/ltp/files/debian/rules
>> rename to recipes-core/ltp/files/debian/rules.tmpl
>> index 06b9070..918b443 100755
>> --- a/recipes-core/ltp/files/debian/rules
>> +++ b/recipes-core/ltp/files/debian/rules.tmpl
>> @@ -1,7 +1,7 @@
>>=C2=A0 #!/usr/bin/make -f
>>=C2=A0 export DEB_CFLAGS_MAINT_APPEND=C2=A0 =3D -Wall=C2=A0 -Wno-format-s=
ecurity
>>=C2=A0=20
>> -LTP_CONFIGURE_FLAGS =3D --prefix=3D/opt/ltp
>> +LTP_CONFIGURE_FLAGS =3D --prefix=3D${LTP_INSTALL_PATH}
>>=C2=A0=20
>=20
> Missing default value for LTP_INSTALL_PATH - comes with patch 3. The
> whole series is in inverse order, in fact.
>=20
> But making this a build-time configuration will mean that there might be
> two binary packages called "ltp-full" that are actually not the same
> anymore. Can't we select a path that is writable for all our images? Or,
> even better, can't we fix ltp to separate installation from workdir?
> BTW, does it matter where this workdir is located, on persistent storage
> or on tmpfs?
>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

