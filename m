Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76432CF8551
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 07:40:14 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29606.1763624406707835177
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 23:40:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XcdNTcP+;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 40.107.159.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYZxsVJJO7HVSXk9msUwBFrGZOgQrL01L/laNaTAuGWsnIpIp5awIsLjPoCR4GBVViTVMHinDKNwz5bFyXYz4K4fr9NUMIqwZFWWeq17aOrHF72EW9jaYqR96LsvgzWQdVILlaC7IJKBh0AdUqAPLH89ynVBAoimv5QzHHfT9aNeLoZJ0wn60pb8XgSq1xTtO9EpnhZwdSnP4wRAS/wyO5xtHw5E1Bym/a9qPnldTAszCQsf17uPnpTo5bs1IZlwtap3BDhBmTBQqiejT21I97p1LwY98NzYq5JL/8+VskCEGmUVoAIhTDxKztGbZehK/bEX3rQo17NC6ZUby+33+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31mhBZ28lSg397Z4CsB/hsKz87YemT1/gLm+IwGB/ZM=;
 b=vsHkgL5W4RJEia2GF8q8IlCVfYOlj4Br1nXIFHeYCAVVhJPKSlQDgnbmZ4G6OAoPCaKscx9MxIsvC3u5C02aBL/oWDRaJZJ1TrPQcRiawQJK7Mdv48wXpn/f8/FAZTDKpv6huQ+Bn1hfbtUFppYsPjSw+n3NhY1yvUNxW5nsnD09BolgtikO7oytidkGINcJHY0OLbGjoNT74UU1RM+aQiG5co4g+uUu0g6CIOjpKrCslWg0pcTlPgqDw5urnSq9XAbF7zS843dcLRr8y8sHs/wkvI7LN8Z7ZRvYw2hlNDUIjkZbLynTHQ/E5J70rogsqzVo7hYQIU9/rA1gVPHcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31mhBZ28lSg397Z4CsB/hsKz87YemT1/gLm+IwGB/ZM=;
 b=XcdNTcP+fbfm6fK6TUcPDnf5fSEDsEOr0pyPenyJxMSqWaUkeAZDA1Gm4KUCvqkfF3LfeuMg7wHF2tJs5jSSPw4wfxJxK99GqAAEjpR/4gLZXGMBTIvNcVGcwrJ/x/upf3GVuK768Lh6AidIq8bWuVZijoGg+ayVrNxPSAAXxcrO40ktl+Mf11aAUZqn9OUmyotlyvaYy8o7Mtxhoe9bC02O/DCySlHvRVAwRE5JH/3HEmI3GDJTi7ziRZLjJ0CI6xJeF9epVCoxa2QNhEmT9LtoHQjZInXjjvmkh7J5ZnZNM0ivtGMdcgKqc5EnXVY7Y9FXqca0MUTsl3lqLngMPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:40:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:40:03 +0000
Message-ID: <2805866e-0cb0-49fc-85d9-ca5e40793b65@siemens.com>
Date: Thu, 20 Nov 2025 08:40:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] IEC_template.yml: Update IEC
 layer tests revision
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
CC: Shivanand.Kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <18799DC70535032E.1423420@lists.cip-project.org>
 <TYCPR01MB9669D111DB514FEE01D4698BC4D4A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB9669D111DB514FEE01D4698BC4D4A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebf1b4d-f2fb-4bdb-d3b0-08de2808043c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/dd4EzyOOp6Ji8u+csuvYV9mXM0HRDA7fsbiTreZ6ADOBBz4wbA+qw1SH0o8?=
 =?us-ascii?Q?xeZ8I5jvmDjwUYdiwqOqsxTguYoxajgIEjU9bx66c8s3PXNyicOPnKb19nmw?=
 =?us-ascii?Q?ZgAke8IkeBHMvuCp3jvfwFPsAWljzrX66Jfco3reSY8IN9xJ+OG6mgqFNxbC?=
 =?us-ascii?Q?aDdiEAw/hUqcDwNFXnwyGcV/XhQuZMWyHfMxU1ar1rFeQ9R1ZT3CLUHdjhDo?=
 =?us-ascii?Q?vZ/DUkj4F9vQTrfN7mAYrTpNLRuCInzlsGZyNDQ0l5GwkmzkmAUVXaChycdw?=
 =?us-ascii?Q?+y/hiNPBb+BffnxNveCaUvqfQqOZmOF7ZspGFmmGKazNAXy7ra/RkJBBJOD9?=
 =?us-ascii?Q?+lxy/2eHgo6YUzgt/5qWGVReClylUpZbwrq+msDk5WMW0Y52GkQsrdqnE2RO?=
 =?us-ascii?Q?czlJ08Jhz7V/jbVZWUTVYMseWP7sfTsHBPrqgkad/k0MLwXkfbhcAM8Yb63O?=
 =?us-ascii?Q?JRbceqO2FZnWeAUUm6ZKPUz6LJW4VcAvkeP/vqD3+pv0AEAn0RtT31pwqL7x?=
 =?us-ascii?Q?hBzg2pRn9jrKOjrP7gz5gMcbLq4EVJK/9hAESvtyWmH6tGNRIEL/RB9N72A0?=
 =?us-ascii?Q?hQbhSXXX8gbgIAkvBj6slPdu8bPXjTNh7JwfRI2aaCe2GoPqGscQ/zr0D/fN?=
 =?us-ascii?Q?TgZToBxUF5LIPA/zjrlJZ/1uCn8at1wHZYVcth4H0ekQeGyvBE83adtcispI?=
 =?us-ascii?Q?eC9Gqd5q7AIP95AJ5Q3nGXxi3YUEh/eHx54MOZNAhTJwebbAIPAfSER7Xjmr?=
 =?us-ascii?Q?hm0uFIBiD7DuBU4cPjhTxTQIl6mtpCn3Yz2eisRZhwPkNOvIxAR7xLJ+y9x3?=
 =?us-ascii?Q?+MM1NBDbILPLRRi752FbqhyP8vutLlWShElfcujmj0xOtlH/M81WtwuVcclC?=
 =?us-ascii?Q?66LXXyl8Z2/k50qowUW2sLydGglokUSeMQOgy4fhbYbEhD3z36LDoMINQm9d?=
 =?us-ascii?Q?CkSjXhGIvC9R/rfWkVH46PWb9+ny57UDgmGl8FJ0WW5THZprvwyFjoppZ/qA?=
 =?us-ascii?Q?sK25Ch7XUZtPDbbdueF3cSFfLqSpKWlT6imJKJOrGIFTVd5f1teVpVD3bVuU?=
 =?us-ascii?Q?PelRzCA3sgA8ZnDIZ1rEdaWxdKtzeh+NlmrRbFg5imGJy9522YV9UEOU0ajh?=
 =?us-ascii?Q?rBMZlqhFa9v2r2kGN9yaTplWBrdUa+jf8jD7cqcmq/1J2ogZTr1DOVc7th/2?=
 =?us-ascii?Q?d66OdqC2/R1JMZun54n8goA4bCjse7juNWXa30A2tQhTC8fFH0n+mpOLZkk6?=
 =?us-ascii?Q?p9BwVSc4Xjbz7EnpMx30uYL+dOPpnxabWukxilNHgK9oYjLQxc21C9x2IGTp?=
 =?us-ascii?Q?UTwst3GaiNzFTSx0h1Ngn2Rv2bE/taXfsabKb5hijJL0BwVqvkgieiSrMeFO?=
 =?us-ascii?Q?9bXWOaZzhCFREKtZATY2WvhMm5fZh4esOY7RZ7LUU08kXdn71GirChI2rVq1?=
 =?us-ascii?Q?CkG9Ng0/DR2KDCdM6lGG1tFOLCcqJ+YeyR+MBe/t7q6H7eme0whIfg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fapmqO9cM5J39qd+JaDHhlF85QbJ0O1zsOciGtrverECGN5tw897koyg8Sqg?=
 =?us-ascii?Q?12K6NHbQpLbvjG7J0zxIYZluXahbnNbJ1HS425jCUMArhZTCoNf6OOIu++hc?=
 =?us-ascii?Q?MoTOnUbFv3UqhufFqc7CiP0S1KSFgHkjOoXORC+DHnfWtkZm2lqQ/TE2Qg9q?=
 =?us-ascii?Q?rRJgas0op+n6FgSUpwA/IQhi8HT2R8XR7xfv2Gdrm88ZygR2/7eacV+PKEGr?=
 =?us-ascii?Q?1qqz0sJwQb/yPgbnLE/iyjjGDpqOnx21pLdZjDzsTwXin7h+Q4ZqUzwU5XjT?=
 =?us-ascii?Q?Mljyq76wmTePZYZRuUtcSi0tEZoFkpb9QsngEjHzAQWqxy5XZsB2pUnaupbl?=
 =?us-ascii?Q?gdSu/kRmpa5ca8TSrQtMYKRKtZxBsepBvJEmpCMo8urnONmtkWe0KWY1aEse?=
 =?us-ascii?Q?5G+/jFrVKxEmY7HHKQpcgCOJPr1gIxUpNK6gCS2OC0C4oCBkBTwNivBqBsyw?=
 =?us-ascii?Q?/PaJsdiARsEkPylNiAYNCBc7e+pxMKPnb7K95pVtmDHo0RnrHXSttNtJrlhB?=
 =?us-ascii?Q?ldhdvyU3kZi+1wmYdfBKzV4VATxs++lq/IfeYxm7UOPecWneHyQS8TajLERq?=
 =?us-ascii?Q?w9L5xcgVxQUbMM8DEzHLkm+vmT92fn6FjdRKmJXuuSE4mcgtDeoVbMDmHUA7?=
 =?us-ascii?Q?6lbQiBRjC7khC+5d0GGYcnVaqH60zSLUzlMxaqspCMHkUP3mBwtfeuDvIR1z?=
 =?us-ascii?Q?KZrvaiv6PUa2MwzykFyM1Rlf+vZ3BY6n+uYut3k3ZE0xdt5Nj4ioJG3WBmWp?=
 =?us-ascii?Q?0cqqMwsSukcrjhdcFAKb2HqS3CEQaLXQvfVbfBLLAvn36L0oyve+raLkV8W1?=
 =?us-ascii?Q?Fp9b4ZZxS3zn5rvQv1ZD7OHNuVHuP9nWJlLJ5EhAwbM6sSl2Phpyr0OjmCo/?=
 =?us-ascii?Q?x8oAyTmJ3wPQmdDu3bc9v+fZX9Ad7NaepbCfCrDfB/J0rZlldrA28fuL3mKt?=
 =?us-ascii?Q?6vkU7UwfAY3TYoOh3wXOiiK85K2wufatEKSKMtTWjh1/YN1EBXERyAPoGlL0?=
 =?us-ascii?Q?5aJ5KKKYmo902W/9Hvjje5qXRflXek35ewLHH2ftf5EYBPsce6+YBFGZOMir?=
 =?us-ascii?Q?0lAr1wd9xVXuDooHXBglaS3UJBRyl1RAte8Q1uEWSIuZJcCu7vt/XjuXlkCt?=
 =?us-ascii?Q?rmGWJLu9wbcTQu9H94mEG7WE+3YSaTdfNtlY68tg+u6tmC94sFxPQG5MduX5?=
 =?us-ascii?Q?DcdM+LRrzSL1ImH7A3T6NAIdosnQOjsgs75q17apgmq9zASZ+ed7iAlWH9EN?=
 =?us-ascii?Q?/BeqKsRGPACIUWNgA/Vj1SdlNoSKPxVNce9BgroJx0H0rhLDChqpw97SR/pj?=
 =?us-ascii?Q?J1zHBSVoYscYiv7ektr+7ZuBpsw48DK7SOZl4x6MN0dMF4vRQPJVQTX1wcW6?=
 =?us-ascii?Q?9WHlu1bQrIZEg47HzeqrcFJaNWzAsnEID4BmKT5tnp75HXAtoO6Gck1mEz7R?=
 =?us-ascii?Q?3F9i4tYY6fVaZBTTpwfVoKS05++3z2aMUc+LNcZ3R+D9NdhAa5ZQz74Y+SrH?=
 =?us-ascii?Q?rwNY7vGicMxPd2MZpmUUJMls7l/FXGUAxgXnsv+C8AEvXffdGsXXlkOCT8cI?=
 =?us-ascii?Q?W1Thn1vtob5PG+xpJ3DbNJUJqQ+NKxqrzEYmS1PQevYp3ZswDMbKwGXooIfy?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebf1b4d-f2fb-4bdb-d3b0-08de2808043c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:40:03.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OFs7z6YMv8mVX1yO0Ayy0CLBex7bxMtpjGbSsnVO14tkXnEBz3U/VQNw/vJNrQodr9ZIoIVVTLNWHwbt41IVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5604
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 07:40:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20632

On 20.11.25 05:57, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Here's the test pipeline [1] with this patch applied.=C2=A0 Although I do=
 not
> see issues with the IEC test that this patch fixes, but I do see that
> the qemu-arm-IEC test [2] repeatedly fails (no luck with retries).
>=20
> I did have a look at the failing tests and it turns out that the 4
> failing tests are all related to the Audit feature. Let me create an
> issue in isar-cip-core for this to discuss further.

Thanks for debugging so far. Quirin, could you check why we possibly
lose some config option here?

Jan

>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> pipelines/2167381921 <https://gitlab.com/cip-project/cip-core/isar-cip-
> core/-/pipelines/2167381921>
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> jobs/12152142382 <https://gitlab.com/cip-project/cip-core/isar-cip-
> core/-/jobs/12152142382>
>=20
> Regards,
> Adithya Balakumar
> ------------------------------------------------------------------------
> *From:*=C2=A0cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org=
> on
> behalf of Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> *Sent:*=C2=A0Thursday, November 20, 2025 10:20 AM
> *To:*=C2=A0cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;
> jan.kiszka@siemens.com <jan.kiszka@siemens.com>
> *Cc:*=C2=A0balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 =EF=BC=
=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=EF=BC=BF=EF=BC=A4=EF=BC=A9=EF=BC=B4-=EF=BC=
=AF=EF=BC=B3=EF=BC=B4)
> <Adithya.Balakumar@toshiba-tsip.com>; kunijadar shivanand(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0
> DITC_DIT-OST) <Shivanand.Kunijadar@toshiba-tsip.com>;
> sai.sathujoda@toshiba-tsip.com <sai.sathujoda@toshiba-tsip.com>; dinesh
> kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@to=
shiba-tsip.com>; hayashi
> kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=
=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.hayashi.f74@mai=
l.toshiba>
> *Subject:*=C2=A0[cip-dev] [isar-cip-core][PATCH v1] IEC_template.yml: Upd=
ate
> IEC layer tests revision
>=20
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>=20
> This revision update fixes the inconsistency with the IEC CR 7.1 test.
>=20
> Currently the rate limit using nftables is set to 3 requests/second and
> the ping flood transmits a packet every 0.3 seconds i.e 3.3 packets / sec=
ond
>=20
> Although this is theoretically over the rate limit and should drop packet=
s,
> but the rate limit set and the ping requests interval is too close and so=
me
> iterations can lead to no packets being dropped and thereby the test
> failing.
>=20
> The fix increase the frequency in the ping flood attack which would lead =
to
> more packets being dropped by the kernel.
>=20
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
> =C2=A0tests/templates/IEC_template.yml | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/
> IEC_template.yml
> index fe4132d..fba7544 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -64,7 +64,7 @@ actions:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 definitions:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - repository: https://gitlab.com/cip-proje=
ct/cip-testing/cip-
> security-tests.git <https://gitlab.com/cip-project/cip-testing/cip-
> security-tests.git>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: git
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 revision: dee76c8b6612439ac648fd187=
09088ec8fea7e40
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 revision: deec0428624e827a9d762eccc=
99b55ee05b440fd
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: iec-security-tests/Singl=
enode-TestDefinition.yaml
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: Security-Testcases
> =C2=A0
> --
> 2.39.5
>=20
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

