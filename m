Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675FCCD195
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 13:18:40 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.44])
 by mx.groups.io with SMTP id smtpd.web10.16004.1760447904246380416
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Oct 2025 06:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=vgM90env;
 spf=pass (domain: siemens.com, ip: 52.101.69.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybiOqmoH2Inovr1lXLivGP2I9IBwwm/CV+90Xq1LCciQjm6RMq+BmFUbBVgxRfCZ17UHVR1F/v9bS+FrYlf1ROOa/nkIw+ax952eKHOr/hPObOIhhJ5JrGMLCTddiqmVQ9qzgRNPrxz1B/5uhaQMo+dTERKh0/il08QT+hAgWNdOyLyfRqt5i331tvSitfgtI1L5MTJGvCKSixw8m0vwb92L3ldWziJq7vh4BnVn0mT5Lc1lV2Ra/VKhRg3DmCKNhTtK4yobCz5+iNFx5RZNPzS+UsF1CplYIB4Agb1dKnFuQ65dWL0UzmeBPK4HHEbVC6im7NI84Rel65mOlWmKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEUuY/n8j2z+8bOZD5vZixcd2yhPVrdom6lcMFPWdgo=;
 b=mIKm1InGt5ElDFla1ifuP+tghMo134CLF83nQQMR454c4WPZ2zL1OaoX3jRxOL1aHmfLRd7gnW8K+3b0ZDyC9IkqOPjgJ3X3zHd/B8whEfEPx9ubzgsnU4y68777SKhoutqFh5y/ExJq/awQ8QDEXEeldrrCL+P/26ZaqX0eUSIGxDL3uYfiudo5PgkLPoo8Sh66gCUxaEonL8JSLvLVf0G9SYvS0bqWC7X/Q660FhQpCdDfEiKOljMGOFaZKmCSMnPxc1c3QeCWZ0Zw4PeFhE5XfUFclDRP2Mnd/FyOpvruYQ34nnwwWTSVRDWZZfkSx186OsgHeAg2bpGi4cIKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEUuY/n8j2z+8bOZD5vZixcd2yhPVrdom6lcMFPWdgo=;
 b=vgM90envDfA5KxvitGREtvq6QAjLo4atbc+RNTAQoICVG0eRoklKSvyguf6mw+CX+d3e4czza/rCPbKHp4m9xLebK9M9J4kehRhnmty5MoEA6X0DLNeJ/JYfxex/6lq5zbljDvhh7E/RLbySkFEsw9uFH1ho+RlaIVR/kgNjdikmpGsJUc0miB3xlcrcH+IUZds34Y1s6KxfgzUC7xiJaHpVy4iBm5wcBxw8zPAUMIu90Fk3niOnvQAPHfylzBMxoJlcBrc2ZzlcY4Dlgf/dc1pihRz6fV54oW1qF1xkM6qYTH9WcIkfCtGYortKRxXG0BI+4TxY6axfCNe/WdQtwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 13:18:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 13:18:17 +0000
Message-ID: <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
Date: Tue, 14 Oct 2025 15:18:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Shivanand.Kunijadar@toshiba-tsip.com, quirin.gylstorff@siemens.com,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3697:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b443f9-6c9a-4571-107d-08de0b242352
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Z7e7RTZoe2DxlKdDhlm3MVnhCGniwgyBJn/CY5R5SVuT+wJtqumnEZt2g5+O?=
 =?us-ascii?Q?NedFYwx0nVJ3R3wzR7OmV+BuNB5RgaUNNmzOkw8+nPZYVXMeviNvUwtYl5ab?=
 =?us-ascii?Q?w3siPPKIvjAgTJ0CJdfT7pARYA52X3HmAxuiOAvWG3WeVifQ3WPhD1SaB9rj?=
 =?us-ascii?Q?nR0ns7EQVo0OFe5zIeJ9dEHoqyovNZT9s3ySl58uAgLPqi+VbbqbE/niXCnF?=
 =?us-ascii?Q?k6WTGsqYJ4zfMHrq/lmN4n/UKdJ/UmaIyvxbkFCOnelzbe3IdqVb6KcXNP2/?=
 =?us-ascii?Q?WQ0hWHGfQj1iEFfIPdpeOK81jimOParmX3YdMkAr4yGzmXHYUDKraKHG+gcr?=
 =?us-ascii?Q?YdQ+PrSkBZzb9MKeEuRLiSJTmO8K88I4JPHD4MxQEOkpKsrxdBJyL5rdmc1r?=
 =?us-ascii?Q?YWGeaVU9405Mv0lHL4I4kVsp/xsNoLWbi3SXF5ErbeeZIN+yLlYl+AU06ODd?=
 =?us-ascii?Q?Lb8zKgsfRBgsceFbAEm1gaLYg8MZq0zZO3w8FqZ+DVZZfdA/+L9JaekTrecH?=
 =?us-ascii?Q?OjcIkpbCyKJrfybXnzAK1XRM+k3CvY/mWYXMJ0st0Aiuc0ATlWLHDEJEXFtJ?=
 =?us-ascii?Q?3PUa1tle/b5Hya2gh8YIA3fjZyJLTZEMANpaorjHev+6eBP8Fpg0g+vmD1/A?=
 =?us-ascii?Q?CniDwAWUdTQzkJO8+HhqnOQRIsCYZncTvV3iDYpvBQIBeCp0PBdOwEVZE5WN?=
 =?us-ascii?Q?06tFYlrC3x2sRXbSx0YOr9BqI4Da7c7r6KshQCN0kbZ1lpwmeVaz8SgfRAVw?=
 =?us-ascii?Q?Ff+ar/T0XBQ4yTOuOBnTAhF8/4JlTgyUknu2Ru8aESnpIGDmCaoy3A+I93mx?=
 =?us-ascii?Q?r5qIeJSIOWpp6419mD/PBWPNagmnGAksYXbsglDQRvg2R6kNZh67oj48pZY9?=
 =?us-ascii?Q?+hpDQEmNXuF+MAoA5MZxz1AoWHfdgdWI0We+evYB+UzB5TqmUeNXZo+SoHq5?=
 =?us-ascii?Q?8hYZVbvRg2F5IGiYj5vIRFmXTFqqcqOvkP+dDDgqleQto4puxboygppjFbwo?=
 =?us-ascii?Q?QdM6NtFXk+f7dQa7NNuWs0s1Jsa0eRIGMjHSVExZG5AL8kyeQzLMxkDIPyMq?=
 =?us-ascii?Q?ZHYdJnxzTifF5QsWY1EzfAYTJJrchyGf3u8l2YNcfRQjRBwklrVLVe2jygOZ?=
 =?us-ascii?Q?f9bXsCdSXNwp3aCWYDrqsfxAPL9fO9ScYG6FFhPJuYCB8fEFZ3banRPWyeNC?=
 =?us-ascii?Q?3i/cWe6uj5MSEbibvM7M7WksCS1cMqrwW59UqvWDWgjhKeKNvyNu4bN2+aEX?=
 =?us-ascii?Q?FRSFrYJTbNsgKyEAfInh46chVumxL3p8lirrxNQyc9M6OgjmJwkV0ge9oDno?=
 =?us-ascii?Q?0/Klp36FRt+8NE3aMOaIlqG1jDXuEiiEly7MKIPKEVneCGWDQyJOc5rWsf4L?=
 =?us-ascii?Q?wRaDx3/AL070fCRhjC4fGM0dP3K/bVotsoTH8sNP8xpKQfVJRQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dbrYEjgjvlEDaxU88q65ZbHUTR/uQ7KiFj/VP7ZIEF+CBGWXzRwTO2VULQrF?=
 =?us-ascii?Q?EgjHMRAYyovVekFHzS5i8feaaJztWSuqR2B/lPOfrnIRhTc00lWWPRbhojrh?=
 =?us-ascii?Q?O2u5CzH4eZUzSotl+wH5SBc0+y2czj0TeO9sN8C0IFdqieC0jRt1gyHkop6W?=
 =?us-ascii?Q?N0j/ZPH0BqhEs9BTKaOsbBUbpWYof4gy8wTxVwt/OkornCMY3HiII7Xa8AMq?=
 =?us-ascii?Q?Zozc7Iyi0snUISu1Oqucf8PWxZtPKjRjZicUimoolx6HaPzS2YfkGDmP0RT3?=
 =?us-ascii?Q?b0gMuu6IKCIb6g1+XAxu7iipzqJL8U1By2yIa5nStwaGhN7hkhqM4NXB9kgR?=
 =?us-ascii?Q?bP9ar95FIxuC/m0jAO97ZZo14VRGJ2zWnAkOdKpatI/jsmeTAOk5yuKB6+d4?=
 =?us-ascii?Q?CXL3dJtLfPXGsNm4eHss4AtV19tu6h01Y9E3gKF/N3rOMPtvwaenJ65Xck9K?=
 =?us-ascii?Q?F3Y46t5tTeyekD1gv2MhwARqXVJ84yUkiotbp4JYBtHUXSdbx4gNBmaQXLch?=
 =?us-ascii?Q?zRLSU4i5/Cnw5kxM7wqL1+/7VqwpT+gE87VtjbjoqHWSkA6ayzyucKq0DtHk?=
 =?us-ascii?Q?Zf/6lsCnHI7qrCn34xm8KJa4dioYws7TsxTphMCrQyJhlLZrcJfv8MonVfic?=
 =?us-ascii?Q?svmwLnJ6/wbpPI7KtqIQCUaNs2aW+gVrV0CeOPTket1fPl7YCd6kjbv+URas?=
 =?us-ascii?Q?7ld04s7WYuiGAfbXiYel3X4NPbBIojHfyvybUT8YNvpwGtPxuNmxQR/53xlA?=
 =?us-ascii?Q?xJaVeTBeotHKwKwZxGe5nR5+8y5/t/o/HEk4HD/HmDvjUNxMloNjtrib/UcN?=
 =?us-ascii?Q?fs5N7DgWuJ3xiZNxZB7G5x99v9yk0WKnEqxn2oX6mb8AIcs5tY4sxM0YuSuD?=
 =?us-ascii?Q?NGt9nxfXfuCTm9n29zDm2YyN1OOGOoraTiipsZW3ZSVXRGkhdJ3ubjC2g77X?=
 =?us-ascii?Q?i7LYjSglEFAIvQWEm6Ohk3tj38MLaqXxHc0SCj2ELM1ugW4bptIrEnD844U4?=
 =?us-ascii?Q?n+qF4WU+Kmx1Fk0VgFYQqfg9XnMzLoDIyZwbKylAMyi74k53T8kdP73xm+iT?=
 =?us-ascii?Q?cKy9tRB25F2vGcyspNjjgzN+A/px189VsYewz79GsIGkOgdmlYO+nDlYIcrH?=
 =?us-ascii?Q?1KwUTAgLISW7RLyzpk6oaf25Whm6SX7577tpocFgno/VghjLAV+qU2KAbWph?=
 =?us-ascii?Q?bhR9FLuI64z+901/vhjUx+OaaPv/xv5F30QSPyYYv+PVj3u6/fV7KZX6oJ5p?=
 =?us-ascii?Q?CnBDrqTqXH1D3IbA5ZgJzXZA8dEW3EpaM1Bl5D4I1rjE1ZLHPyzoND585gSc?=
 =?us-ascii?Q?0OivE41s/ia5NRWRj8l4KWSEs/SW1m54jZ6rfmx5d7hworVa0S6BWpxlCXmK?=
 =?us-ascii?Q?VF3Ulu+pBJrF7/TxA2XyKnVcUUuIWUZrLhjwfEXcAlag8xTleEF3Nd/dpRWO?=
 =?us-ascii?Q?623/B3AT14EzjooSq+bwoQ7F848ilkkj/KehJDVp1qVzWx4th3L9grah/cpi?=
 =?us-ascii?Q?8Yk1UVina7OE5PGkGp+uOxtd98DFcsTepp49UwxoGJQNeYdv/8h32Jk0d0y4?=
 =?us-ascii?Q?jCRroHmKtxa9XIJDW7TSh/4rDSA6uxEUKnwdG6VK?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b443f9-6c9a-4571-107d-08de0b242352
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:18:17.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njAwO+me5MAH0XiJoT81cnaVPI94BOLS4dn5S6UBqCkBN6cbRfEcjF3WcvSnBmTUIoAtMzboO9n7ydCMWyPTGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3697
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Oct 2025 13:18:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20173

On 14.10.25 12:45, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Quirin & Jan,=20
>=20
>> So, this is apparently no longer an infrastructure topic, it's a test ca=
se thing. Next question would be if anything related changed recently, poss=
ibly in the shadow of our general lava issues?
>=20
> We checked the LAVA lab for M-COM IEC test execution details. Last time, =
the test case completed (without timeout issue) successfully on Sept 22nd [=
1] after that all IEC tests which are submitted on M-COM are incomplete (ti=
meout issue). =20
> There is no test code change after May 27th[2] so I am wondering what is =
the cause of the issue.=20
>=20

We updated the kernel afterwards e.g. Also some Debian package update
could have brought a relevant change.

> Additionally, today we tried running IEC tests on local M-COM device (boo=
ted from eMMC) and found that all the IEC tests are pass, taking around 79 =
mins and 99 mins to complete (for 2 iterations).=20

Ok, but that was the eMMC, not the USB-attached emulated disk.

> As pointed out by Quirin, we checked the CR1.9 tests and observed that th=
e CR1.9 related tests are taking more time compared to other tests,=20
>=20
> TC_CR1.9_1+pass+758
> TC_CR1.9_2+pass+554
> TC_CR1.9_3+pass+391
> TC_CR1.9_4+pass+642
> TC_CR1.9_5+pass+712
> TC_CR1.9_6+pass+1
>=20
> +758 --> This is the time taken to execute the test in seconds. If we com=
bine these values the CR1.9 itself taking around 50mins.=20

So, the other tests, which are slower because of the emulated disk, plus
the very slow CR1.9 tests kick us over the edge.

>  On the other hand, QEMU amd64 completes the same tests in less than 2min=
s,=20
>=20
> TC_CR1.9_1+pass+19
> TC_CR1.9_2+pass+31
> TC_CR1.9_3+pass+17
> TC_CR1.9_4+pass+9
> TC_CR1.9_5+pass+24
> TC_CR1.9_6+pass+1
>=20
> The CR1.9 is requirement to verify "Strength of public key-based authenti=
cation". As part of these tests it generates the CA keys, User keys and cer=
tificates using ssh-keygen command. we think that this command might be tak=
ing more time on M-COM, need to check more details on this part. =20

This is indeed strange. We should be running the same kernel, so should
have access to the very same set of accelerator drivers - if they play a
role here.

But maybe you could try out if a stock Debian kernel performs better
here when using the otherwise identical image.

Jan
>   =20
> [1] https://lava.ciplatform.org/scheduler/job/1309843=20
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/8786c9=
4d64bbc576a8205f54b92aea1cc4c4d9cf=20
>=20
> Thanks & Regards
> Shivanand K
>=20
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: 13 October 2025 16:27
> To: Quirin Gylstorff <quirin.gylstorff@siemens.com>; kunijadar shivanand(=
=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <Shivanand.Kunijadar@tos=
hiba-tsip.com>; cip-dev@lists.cip-project.org; Chris.Paterson2@renesas.com;=
 dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.ku=
mar@toshiba-tsip.com>
> Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
>=20
> On 13.10.25 10:51, Quirin Gylstorff wrote:
>>
>>
>> On 9/29/25 15:56, Jan Kiszka wrote:
>>> On 29.09.25 13:36, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>>> Hi Jan,
>>>>
>>>>> We have a problem with the on-device IEC test now. Retry didn't=20
>>>>> help, and it rather seems we are handing during the TC_CR2.6_1 test:
>>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>>>> jobs/11513053235#L2101
>>>>
>>>> In the above test job, the test TC_CR2.6_1 started at 16:44:34 and=20
>>>> failed at 17:39:25 because of timeout.
>>>> It is almost 1hr time, there are no prints from the device side=20
>>>> during this time, so don't know what's happening during this time in=20
>>>> the device side.
>>>>
>>>> Another job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>>> jobs/11509181697#L2062 here timeout happened during the test=20
>>>> execution of TC_CR1.9_5.
>>>> The job started at 13:59:34 and timeout occurred at 14:56:53 so here=20
>>>> also it is almost 1hr time. And same no prints from the device side=20
>>>> during this time.
>>>>
>>>> In the job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>>> jobs/11513053235#L2101, the test TC_CR1.9_5 is completed and it has=20
>>>> taken 519 seconds.
>>
>> I look into last logs and it is mostly 1.9_5 which breaks the test=20
>> execution. If I execute the test suite again the test will also fail.
>>
>> https://lava.ciplatform.org/scheduler/job/1313908#L1854
>> https://lava.ciplatform.org/scheduler/job/1314503#L1847
>>
>> Also from the inspection of the tests logs on the device 1.9_5 is=20
>> never finished.
>>
>=20
> So, this is apparently no longer an infrastructure topic, it's a test cas=
e thing. Next question would be if anything related changed recently, possi=
bly in the shadow of our general lava issues?
>=20
> Reminder: This remains a release blocker for isar-cip-core until someone =
can explain what is going on here.
>=20
> Thanks,
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
--=20
Siemens AG, Foundational Technologies
Linux Expert Center

