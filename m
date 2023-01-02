Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952E2C3DA7A
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 10:42:43 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.42])
 by mx.groups.io with SMTP id smtpd.web11.32723.1672656154762061343
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jan 2023 02:42:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=P4j5nzb2;
 spf=pass (domain: siemens.com, ip: 40.107.22.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hURSJbVvWaEH3q6KC/GL7iR76jqeJ+4XPciOAc+WkIZyGxKjZ7Xsdv/AnQGC+j+3Hu9ED5FRr6N+CWzswjarKhoHVQ467zGibOlK2rZ/hkNJf/eUpxkfQe/0nmm2jBg8vfKH+DW5NkY+hBsdhv7FlFgoBnnzcK96dvZXhTVQXy2PC02P/bOcv2jWIyDLfrZEvwRwbesQP6UUtRPPRr0HMQB9wooe12B+yIqrsmJlo7N8xBzdivXPQSVp34T82Ju9WfAfXcosyIfzD3+VC8uXFQyCXhGGB4Vjbkuum/4P7j8LZ5GoaImCqOKF2FqkQO/WXboXJqxdTf8TiWlT+q/x0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwa+j1TNv06mKM2oAysgQwEMM/UBl0LYgp3+sSy90ck=;
 b=kN+sflqEVscCS+JxNe48t5DubBnvmsjtpLvA2VqkaJ5M6u2jZB2YaF36XRDbq+Vtg8CXsgeMi6FnI6bxaNreqwzgx8VnDzcXPqPHD1J+pVmw5EZ9oJIspYIV85RXzZxGmIg2y+ioM1iu26oZ3aGc7ApsQ2aKEeoBmG0rvsET31yHBciyjRjRKr6/+DH1OxAdQF5uSNIDX1R+U1GEM9bxI+2dhPi/1yZK+pSNZ6pY39RsYx9e0qeCgkNJAheDH1FB3RPtY6jC55J6JESZ24d7MIBCCiO7swkE8KbWhEU0X0fJ6SZr9rLYPFZR23rVTRhhbsRwkB7R2DyVDTNYLtabRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xwa+j1TNv06mKM2oAysgQwEMM/UBl0LYgp3+sSy90ck=;
 b=P4j5nzb2vyusgFtbp3wTASJIizSa2oL8Q2Zq+fvMB6GLA4Ru/htir6lTn5gC6/5yOfoqPQGl8Ov0LzlO4F5zmuYf7p5y7am/vgYCmAJtgOdjGa2XfomHpiwoiBK49cNQh9oZQ69u1INXHYOPLRItPUKUsw6ubZ4JPL79Rqjw7sAYF9oHFjVHJDCjJGgKn+Z9K0MfJgAmwicBd0gWqC0th2j1pKn+2Tvl5oN7eFM2de0tGksQ0L3VQxplNwwuBkGnOKLESJ7SUk/JaZPmpuo9fF7a0OrqB0hq4P7om6zfscvVJSjbzg1DkdYu45RYBkXSmRpvKFY6pzrRi8W5XurWFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Mon, 2 Jan
 2023 10:42:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 10:42:32 +0000
Message-ID: <bee9645b-15e1-0f93-d0b5-df8974711459@siemens.com>
Date: Mon, 2 Jan 2023 11:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/6] improve root home moving for
 layers
Content-Language: en-US
To: cip-dev@lists.cip-project.org, Henning Schild <henning.schild@siemens.com>
CC: Wang Jing <wangjing@siemens.com>,
 Gylstorff Quirin <quirin.gylstorff@siemens.com>
References: <20221129122451.32155-1-henning.schild@siemens.com>
 <8a8848a0-a801-78bf-e4db-162c19aa3f31@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <8a8848a0-a801-78bf-e4db-162c19aa3f31@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 1021e1f7-9ec4-41c4-e528-08daecae0d3d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	upwW5P+PQZxu8QoZwNRLAlO7CSdT/6BG5RPRRv5gDP6bEmfQI3yMdxX5blksOZSuEhJ+kVGVb1G6Arzl2l1RpTpZ8sxXY555V2S5e2ArYExczmEChVFetPFTS+ZREaE3SR1sa0IaontqhW/8TOd4N/5ielospBUrR2o2tkTdXMCDdH6R+VSS8Bq9yBblb5mjlnjDkFGZKaV1si9B77+dtY0caipJiXaHkLHz+gkeg5TGGQFp8uGLOU2+TAIleet4oRF+t6+1VCytDSgnHkiagdcDueN8lsF2Ob7M9XiKRBenxBB3HwTF+yNABrw4B9Trk14iU2wQ3iDSKasTNTVxWHfSsIB/DyotBIq16WCx2ibXW1RxqocV816QSrcUIDrneZJV8Vk7olEOqHLKXJKTR8FzuK+8BDqBAzi+1F5DdqWc5u3Ib/x5tZjD7yqOXUz0Hl1NPN4Ix3aUdPIOIs11kDbKnWY4DhcmozIUokCk4jV6BzZVvK+7EVG0nzQv2OM1MpqNkExibC1lUCEHol853BJP7f5TCQhXg5Z87AdZIhp/jwehZLFh6JK+/WQymXQSX5iOWGUDAHQGApZiygzH75InU5kFPltfxM+SeT+igpb3HGL46UIPab/iVMeP7CkbmUsFC5gMDt48QyYJZTQlhYGH539NCZn1HOpjjZBe5//cC34Mi+thgZfs0AXbwT2sj6e5/YosK5tbyJABAbJiabA8j1BzlWGt/vvA9uGJM883M5p/zd5xZr7uZFX35/I9gmIXC1p7sJI7njcuoJg9Hg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(5660300002)(66946007)(66556008)(31686004)(8936002)(6512007)(186003)(44832011)(26005)(6862004)(41300700001)(4326008)(66476007)(8676002)(83380400001)(36756003)(6636002)(2906002)(54906003)(6486002)(37006003)(478600001)(316002)(6666004)(107886003)(6506007)(31696002)(86362001)(53546011)(2616005)(82960400001)(38100700002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zEt8JFWbb/OqicjXchh/igHFC53X0immP8wGkro2/mTogaLzM9YzB1QzHYUb?=
 =?us-ascii?Q?Uee/hSUDnNleHu31a36C9sKz4d7G2OA75uweto7rm7VTKn8Qqw136poiULsW?=
 =?us-ascii?Q?C/gUNx720jYIlRAp4JqV5CShqLV9q0IQRm01oNONhU4cIfUGtoAwdfLCl7Kq?=
 =?us-ascii?Q?WnBhe6Rr2KdZh7iykleb0fVT9j409xN6R1LUyjazDCghGeH7IEKnpEepr3+Z?=
 =?us-ascii?Q?e3iiSD2RRvytr09lCvO0PcvCnBBGB0hYhlOEPLJTIpxfrZ2mPMIgstZ6Dy/N?=
 =?us-ascii?Q?kA5GGhD8Ate42Fp2Cb03TTFXejlN+e/lcyhaoxF7PqqyKQWJJHz/jCoCzWNL?=
 =?us-ascii?Q?i0PuTYYuoPr5EoDDxDQKmzbKtuuLPskAyYmKylWITBweRO8+cdqcvE65KVaY?=
 =?us-ascii?Q?2f6tJLbPZ5yYn3CXsFqTQK5491MC/GbsPnn+IPE2o7TRqbGx6BpFmYcSkbQT?=
 =?us-ascii?Q?eNjRZG3/6df0/u/REIix4I2BWwXzteJP8S46ig9iEOv36iAiFAVrfqOnSyPj?=
 =?us-ascii?Q?uf6X6l07RygBNiEH+MMYkTFpdud8wKTSRLkc+ugWDmRQLgYWXPasA6KN1R4m?=
 =?us-ascii?Q?v57SXIOC9Kb2EQQkauODQHjkqWurN+Bqip7igld3WYstvG50ReYhohzQ5AYX?=
 =?us-ascii?Q?cczxleXvzlzLhTvGiZbtC1YYnTqz6u2+z/tO1GMj7zgn6/IJ7+o7Mc1CIGYn?=
 =?us-ascii?Q?2/k3OLiUQh3W9xUcxGfEU+8esz7g93xGB/Hx/6GOx+oi7ftE2a5cj6NfiM5E?=
 =?us-ascii?Q?90Ye3Rjztgw9Ba8AEo3IpZyZHLr+pYTlaW5NacmC60zuRB+3QDSg49kLzktT?=
 =?us-ascii?Q?RBgkqzRu1Nu29tLu4DS14Ze/vxN81qIaLiYFvLkdv7MAwqzILA6l4cOEXl88?=
 =?us-ascii?Q?xX23iimZRw5/RXP5UjpNOyKS5ozdM42IA3T4hSmzsk0933I1xkW+MWTKYRB4?=
 =?us-ascii?Q?ZcK3KIMLNxArm0BSMRIWp2Z4fZsubLTKhjfssDRSI9iqjOvEIbI5MvG4MrST?=
 =?us-ascii?Q?H6D2qCqB+gQGMar8//uoYaoUtGD+NbyGghtO161e788VLVyn1yXWDxLHdANt?=
 =?us-ascii?Q?0dxSIFomWjiXZLG59ga8VtT4Jukwr4IQEAwMhaEraYQ4OWRObznWryZcfd9i?=
 =?us-ascii?Q?Z/Ua4yRR/pYI5fAq4alsQNHJb3Prmb1ssp5yv65Yv/qOhufMrarSHSLwJznT?=
 =?us-ascii?Q?uYbAgzCxIqZpQmahec3pUzi2wE9f2AOaI9m4j4iuHKdEDeuJ5rnlek70eqUe?=
 =?us-ascii?Q?vPoRgkUbYUN8QdYDMepE+iZSzW3TH5hgsaADGUBZouIdFea/iIakQRv22T1e?=
 =?us-ascii?Q?3EoSXLkPFHWGNn3Hbwf5F/zUnYNW0EXvaoCbpY5yN6uGTnzlbwEJy/k1LgM9?=
 =?us-ascii?Q?V0CdBzGPQai9uWU1C7XE2UGmOkeG/3yBCoSIUg5iYlsNse2HgvAjV5huwGOq?=
 =?us-ascii?Q?idfqgGtNBSf60k1a2amfduEoTbwuszTevZKy7FrnciGBvvyw2HEkzxDdti0l?=
 =?us-ascii?Q?MbZwY+uavu6PQmTsgNjAy6sdrL8TuFpA0bd4X9cZmC1W7bqXR37qnD7aQNcA?=
 =?us-ascii?Q?QOpSCxEczO9mHfcFSwu3IUPayD4ENwn173yvhxAf+bs/d3KxvylB3Bggtd63?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1021e1f7-9ec4-41c4-e528-08daecae0d3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 10:42:31.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Zlt7oVa1G5LxOrWK7jKyBo2XI51/i4FwxsnmtUKpi8g/I/h0CT3vMQv0Zvf8LxuegaIL166Vx7YfdMM6VAmAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jan 2023 10:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10273

On 21.12.22 14:01, Gylstorff Quirin wrote:
>=20
>=20
> On 11/29/22 13:24, Henning Schild via lists.cip-project.org wrote:
>> The original idea was to make the rootfs home dir move and symlink
>> reusable in another layer, while also playing back some findings from
>> that other layer.
>>
>> That is p1...p4
>>
>> p5 and p6 are drive by findings, feel free to pick in any order i do not
>> care about them too much
>>
>> Henning Schild (6):
>> =C2=A0=C2=A0 customizations: make postinst idempotent
>> =C2=A0=C2=A0 customizations: make postinst script report all potential e=
rrors
>> =C2=A0=C2=A0 customizations: comment why we can not actually change home=
 easily
>> =C2=A0=C2=A0 change-root-homedir: split root home move into own package
>> =C2=A0=C2=A0 kas: set clear text root password
>> =C2=A0=C2=A0 CONTRIBUTING: fix note on patch prefixes
>>
>> =C2=A0 CONTRIBUTING.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 kas-cip.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 4 ++--
>> =C2=A0 .../change-root-homedir.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 5 +++++
>> =C2=A0 .../change-root-homedir/files/postinst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 21 +++++++++++++++++++
>> =C2=A0 recipes-core/customizations/common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
>> =C2=A0 recipes-core/customizations/files/postinst=C2=A0=C2=A0=C2=A0 | 10=
 ++++-----
>> =C2=A0 6 files changed, 37 insertions(+), 10 deletions(-)
>> =C2=A0 create mode 100644
>> recipes-core/change-root-homedir/change-root-homedir.bb
>> =C2=A0 create mode 100644 recipes-core/change-root-homedir/files/postins=
t
>>
>>
>>
>=20
> Looks good to me. Tested with qemu-amd64.
>=20
> Acked-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20

Didn't hit the list and also patchwork. Please check for the reason and
resubmit.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


