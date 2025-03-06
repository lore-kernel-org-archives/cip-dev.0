Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB9FC19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 03:48:46 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.62])
 by mx.groups.io with SMTP id smtpd.web10.13616.1741268817241104060
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 05:46:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x5i3OURy;
 spf=pass (domain: siemens.com, ip: 52.101.65.62, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4El6Es/HItYOu87WiDdOgpOJXr6xR4ph7IaSefuLLtD7Gol06LIb3nFi+86VoqyuBJ3qJC11avZwQqvJgvQep5+aEui91w38AzU85M667XZVJvSWz31AVCrXVhhUqT5P7CR0zwvi0dzgfbNYzfRvQlQ/tPdxNo3I+l3bxfUa4ev/NMysqpGFJx/K5VS85A4kz3JrQq7cUMyQMLzfNQArcHvzQQp9T0Z8mf/ErYkBf4wF9B7GSbIfXJ/me9vx+40hkS98I9SaoGQvvbpZE0wx7Kg2EcSVpBhlNoXZU68POCJd6gwNdmN32EsMbGJILNKoyOD0i4gPX3C5gSdQAXaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTHNqFiPhpMi4CJ7SEAwid/7wsuPAG+J68JK1Jpq8hc=;
 b=jFM76to84YTiGH3PIeV8eD7+V5/G9gKHEwI0WdB6hwe99pS6LqK3OonJU076CypJHKx+j6DI5Q3eD33MMjKauP8Xao1FXUatNbAERxwvKb9rxVMui4s8yPIiJMYdUGa9pwuVGUUmFObJLVYen86/SE6TlhCh3RBFQk29mcJwM4VF6ND4RNBgiF2XRRiWJAq+AiLc66rTUuO5beRDrmqd4LmJiR7zeHkBx6sEWQ/DUwwQo221X4XvEFgyq6YCjPNPMz2jGUiheUxW3ZIpMHAxzLys/nRkr5D3eWzJ3O3DRsR8BYlUBj8UGoOo5+Zrm12ZLyA38bWAQcZKvAk8hShwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTHNqFiPhpMi4CJ7SEAwid/7wsuPAG+J68JK1Jpq8hc=;
 b=x5i3OURywsLndwPccQe8KRU1TP0dJlZ7C2zVhqtYv+amqKEsY87E2fZtPc5bDrV+MPPjxz+2Ppe53aTeck6HVPO4YKqlkOizsa7rDVBA1mYmMOHgKVVH40byo7NDOd35byx7NXVuUl13q0vnwzAHKxsBIOBS5x67hxXI4B+Cktlqx1TuDR23xgaW2Eu1w47WcVeKEs6Ou3fPZOZNtPDrtWScK6eLQSJgtnkAWDan6XMhZ9vExR1YWNYJWxOJFsmpKFiHBatlqyzGUbOrzLaXg1e2FtPBZsWUyc2VHkfl6RrU7eKNinLDcYENpVHB1E/reN9CEMqbTQ9B2fr7rUCq2Q==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by DU4PR10MB8513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:561::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 13:46:54 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 13:46:54 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer provider that hooks sign-secure-image
Thread-Topic: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
Thread-Index: AQHbjns5YmpFem/SVkKzaVXtmh0o6LNl/UcAgAAA94CAABsI8A==
Date: Thu, 6 Mar 2025 13:46:54 +0000
Message-ID: 
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
In-Reply-To: <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=63d00a2a-ec41-453c-9427-e516070484c5;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-06T13:24:42Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|DU4PR10MB8513:EE_
x-ms-office365-filtering-correlation-id: 15842fa3-72a5-42ee-d268-08dd5cb55b3b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?xOi8bQsixnwb32Vu3h5AM4afDa6MyzuzIO/XEPcg1iGCdo7QWmjZ34WfaT?=
 =?iso-8859-1?Q?qjf4sqCBAEU6iCz5YCMlGO/VNtK3/4eCnxDLyLwxb3EovFWVxiF4TmJj4M?=
 =?iso-8859-1?Q?sQ8TtN2i1dP97h5KQeTjRsetgyyOCmIJuhrxv4p+735u6qZbcnFj0zKiQ8?=
 =?iso-8859-1?Q?kjWmjAK5eq29vJ4n9lqhb4Dit7CvBqj4u7df+/oNXCXdDR0CLgeg2ezS9x?=
 =?iso-8859-1?Q?r0gujTpTApxYjf2byz7jFBrZ2Z3swSdX2zYNKvocyISUH23C7F6YherQef?=
 =?iso-8859-1?Q?JBBeHESRncQLZq6M2VENolNXlHSh+53dy/GSyW/QdnsSb4DyXh6Hs2nG60?=
 =?iso-8859-1?Q?a92KCx7oDceN9c0U+l94RGteXjfz9Y9QZNEkaRcMSp2TVXsl7Nlwutfjpj?=
 =?iso-8859-1?Q?1uN3prN5o28ymGEDwZw1WK1VZRVVR/dwll43+xrzROOLKgH8HF+8xMyM0z?=
 =?iso-8859-1?Q?OUzY5GF+kiC139gCCl1Lf62NIzQy7J+rCDg/PMj679JOMAridS+HT7Lovm?=
 =?iso-8859-1?Q?izXLEzRMxgxwQI8ZdokVm8wlNN+xRn6yTz6GAtcQ3cq9JeMF1bBr4Wu3PR?=
 =?iso-8859-1?Q?Uds4vC2bZv/w1wlWew8pQamkFeJzub3mAsE+dv7ZRH0iX3mzqK5ywvKb65?=
 =?iso-8859-1?Q?1sCx4QukCJS1NCE0+VEfVIVLuz7FArWLes3LnhwifLONp1luUrCSCNemOt?=
 =?iso-8859-1?Q?Ck1a0h8HsDDMJmC96HRq6CT6BxoAsIMPeFWogH9haHKTP/Eadw4j8VDMJm?=
 =?iso-8859-1?Q?+xDUiptWf/M1Y1OA9ZrlO6mXlbd00pOiHbAkfGcwIiXjU4sBDG5npYU4hh?=
 =?iso-8859-1?Q?1n07aAGtBIux1ds0FGFj0++Em2i4aicRiIvDR4ocztSIFj+epyFsElTQc5?=
 =?iso-8859-1?Q?OFYEMzh5YEiHzwRfzhlNZiB2HSKfZWchQ3Kas3XxVo6i6zY8rpqWs/NdLY?=
 =?iso-8859-1?Q?IcpDYHBLrW/5kGRtfJjJDwHIT2ZYotIDZpfUHWGzhckYW+pVwSMH09zZyV?=
 =?iso-8859-1?Q?vmdFzcIHj2atdOmR642z09NV7ys4drDPwYqbZPHBEa3kpnarnwiZYoVFZO?=
 =?iso-8859-1?Q?oyeNLqovN/em5bNNv5eBjDrCvQjnYy1uNBrpTndwBWTZOgN+nx4qF/Ooxz?=
 =?iso-8859-1?Q?ACPT+pDuxAcLgzqOY1cwCHy0LkJ0Udlt5oHSQpTZfZfqNqwSPlFwWRwLaf?=
 =?iso-8859-1?Q?gGyHX8t4rrfVBexuHMfsxznS3/gElnLvQVqrzwtlONjN6GnJKFeZhFJqv/?=
 =?iso-8859-1?Q?qkFfsMUnbTjooE16M18CwO0ebVutZ/7tRwqJYpBUD46uliDdafDH2d7Pwb?=
 =?iso-8859-1?Q?C+UeOfUGeiT2njf5XaafLd/0dqFSCnA7cyK2P46nYUMV+53CBZVMvbAJp4?=
 =?iso-8859-1?Q?yFvXqxGbDQOS66nJWyNh+6bmtqxj4Ky1WNWbd5mg1m2Vm1vhwmYvm41kIa?=
 =?iso-8859-1?Q?usid91eF4qDwEIyrvUjKO61YlAYa/dyHNac/2RCw8SNwz3dRH/MTWjcJ78?=
 =?iso-8859-1?Q?58xqeqgFTdjQJhI1lzSzLI?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?5XvDu7yELqgypxqNwwAlhKaTR6aeZp2OtWHHsG8JCbtO+MUX49uqfVN7x2?=
 =?iso-8859-1?Q?HAnI1MYeWgwk1A/XLwEfGmu0OLnsywURFz0jPbZPNiJltQm6asfjMZ8lsy?=
 =?iso-8859-1?Q?UrT8t5hO1wo7LRMf0y4PTVYpyk65lB7fSZaXnAtBHq8HSwbyWYI1GeRM4p?=
 =?iso-8859-1?Q?X9fZqledjr1/vbcUDYl3OmfKjf9tKsbfp8kd3uJMK5oYh9k8y6/PObSodF?=
 =?iso-8859-1?Q?kycF7H5wvYUPZrKU0nZEf26qHWt4I093RWerZ9jMLEJ08BoaTtRHgX1yr1?=
 =?iso-8859-1?Q?PfeYu8l1ElDFkMWSbR3MWtkWGACNRCDX9Gv701upBFShGKzaLeXaQY6jBI?=
 =?iso-8859-1?Q?la3EYMbcdoZVcRigvOmcQN4JFtL4kDiLY/2Dv5/o3FdlNNXNwjBVMCrwGS?=
 =?iso-8859-1?Q?VI/txg0O6p1UwOL24FLtUW1OTT62UzLAk+JoUW3YSMHkx5kowjK0+RpCUu?=
 =?iso-8859-1?Q?V1GwRDBE2p/NemkeyR+txVFYdxl8ss6sCTZYSRxKBtAw1KsHSPdJ+4DLh6?=
 =?iso-8859-1?Q?Ag5608gTNe//JzTqhOA4Lp9HXBpBOdyfBM7S31G3Eeo/kW51j6QQlGwsTD?=
 =?iso-8859-1?Q?Y2H42U77f8XOlUkqHVEfZKEhb9mcFUZX+/HwaYwNhojuuRMn3FDArkj1P8?=
 =?iso-8859-1?Q?884IuhRYuYkj3McYITAN5PgEgdxuLV+f84a1qBLzwq2qW2XaiQOwe1sSLO?=
 =?iso-8859-1?Q?Jj4VOXREebsJlWxhXEDO67qwu07nDVpFkzdPzJ8+CuJI8IYatSQWu7WVoE?=
 =?iso-8859-1?Q?xWZ+35uJLMl4D/PESMtMoCfk1iVub4WHuthk+2mXLHyGuc900uCzaIM/wx?=
 =?iso-8859-1?Q?IahKe4lmCa+E/FTZ421CSmNBJMveFfiRQTsCaPhIHLpr6GEEKS1NDq984T?=
 =?iso-8859-1?Q?J8UrtgW8375XUseMoXcewbyGITHnVHC5Rd1QTcYqovsXIZuaCsvCbDbSEm?=
 =?iso-8859-1?Q?bJ0MwmYc6VHG4gwonY7AosEw23ohHyH1dgICkqrKKy0ISk9JpjIm6ITBqI?=
 =?iso-8859-1?Q?K/uTSJcbdZTNDDKPWiMqNJrCQdohYxKiyGCeDLPqvEYcO+w0YeyHXmzLN6?=
 =?iso-8859-1?Q?k1fNNtiaYC4lgKZJSkMAvxiksQu46hts/TCDSUFvCVVYMmeyqUttFAtuwk?=
 =?iso-8859-1?Q?pbLYPeifBDfRqMPkZtR5t1dEEdR4x0kHQc3ub2/N1QD6Y6Gkl3BIOR3Hwi?=
 =?iso-8859-1?Q?6pIagD3CHWiB8LNdo0s8BfIP9Hjr5gJlfVtPDIvu7RI+qklTn3PR/whCOc?=
 =?iso-8859-1?Q?HWedAc22mQcgXg1C1Ry0NrmkidoVtVYyCblk6OJL4//GJthK5C9hJrA4gh?=
 =?iso-8859-1?Q?VqYnsBdBPQ5gblaKqhFOzM+aCzD+D83opgk5xPvLc8ERDnEbPFRICiOnQU?=
 =?iso-8859-1?Q?GforR2iauKJ1vmnWb7o8DznuIEVoD91e8XSF2vmi9qGpHHs6oJlDuQJb2W?=
 =?iso-8859-1?Q?yCD5orROmXAN0eeBcHb3z2xt61IAby/RfYjRgY91+XXiTIymNAYBabBP4P?=
 =?iso-8859-1?Q?/6LsxWemR7MiqiX83Y3PG8OcF7wKedMLnrYuDAYl2rmWt1FypeKgJ0w7WY?=
 =?iso-8859-1?Q?ROTth8Al1KBvx96FYiQB/VOQZxwh3nfoql2n+x9cSdx4fuB2zpOj3tOkqR?=
 =?iso-8859-1?Q?PtFeucSKk02sNWi8dLN22VEUwAzl4+cj+K?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 15842fa3-72a5-42ee-d268-08dd5cb55b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 13:46:54.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HljLA3RtFGhZqcqLtjG0svYciwmzPMagpAUNtFT8oURg/MOzm+Kk2UTECK+91tNTCA7d91xgC1coLuDVGfCJdUfEj15a0aXl3PecUA+4Tg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8513
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 03:48:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18064

Hi Jan,

I haven't had a chance to try it directly, but past complaints about using =
OpenSSL provider/engine together with sbsign's OpenSSL3 support have held u=
s back from maintaining/implementing an custom OpenSSL provider for server =
side signing.

In this scenario, pesign is used only for import/export of attributes/signa=
ture and this feature makes integration with other tools much easier.

Since I observed similar signing patterns and toolsets being repeated in di=
fferent projects, I thought we could upstream it. It is still possible hook=
 different signer recipes/scripts in downstream layers by configuring it on=
 partition's source parameters or installing a different signer recipe so t=
his is not blocker for us and could stay in downstream.

Thanks,
Gokhan

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>=20
Sent: Thursday, March 6, 2025 14:48
To: Gylstorff, Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; =
=C7etin, G=F6khan (FT D EU TR C&E) <gokhan.cetin@siemens.com>; cip-dev@list=
s.cip-project.org
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to sign=
er provider that hooks sign-secure-image

On 06.03.25 12:44, Quirin Gylstorff wrote:
>=20
>=20
> On 3/6/25 10:35, Gokhan Cetin wrote:
>> These changes split the signing process into two stages.
>> In the first stage, the `sign-secure-image` script called by the=20
>> efibootguard wic plugin now uses a hook to create a detached=20
>> signature.
>>
>> This allows downstream layers to provide their own signer scripts in=20
>> a similar manner for the second stage, without having to overwrite=20
>> signer script or partition's source parameter.
>>
>=20
> This patch does two steps at once:
> - switch to pesign
> - split the signing process
>=20
> Please separate this steps into two patchsets. Also you need justify=20
> the switch to pesign.

We went for sbsign for very strong reasons like its broad usage in distros =
and the support for OpenSSL which enables e.g. HSM-backed signing.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

