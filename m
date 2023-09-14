Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63EAEDE983
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 05:53:18 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.63])
 by mx.groups.io with SMTP id smtpd.web11.5551.1694670788172756966
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 22:53:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=p2yAqD2o;
 spf=pass (domain: siemens.com, ip: 40.107.247.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkfBnj+Aa39iDyCXjdcA7Mup+P8BIYtQbHk52xSsd0hVzVu58qdzyn0nR/u1vwQ7SfuTyyV3Lw8x2oaqTXlHxvd25pdo22F2bDiTAm+tgcyme7e8f0U/WiwDCUFRfkj/TUNlmQJmB4uRIESKYJMTKw01ClsqDYLC6G/qkkzW2bIlE3mlD3EHxFiQL+CWaP4L23Hq17UE4BbTGoJoqJ/hgPxrFOXF8Op0TKD0bIVOsbIjhkNzpx9IDCQ7xvt1DHuEloF3eC5va7omULwnT74JbxwiOMEq4ubb4jsjGtqKjs5Cxl7QF8hNwo+LM0g/qLeCqWl+vF96fIatSiGDA/y96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xruRPgvT1sdKk7WH0XQxaZLvzifxAT6Q0bYVbvOTuGI=;
 b=QoLg4U/SScPPyu8LsHr/5lgKEDCRM+LSeun7cTZBjkm7HX9pnlTd4uJP3Nso2di6lY1wMRbTwWqtyfhF61RkGntYPyEVmlW4h03idQHvdwaORFMTrcbwiJdWrA8PHuZZ8usk9x2SEvOMc0ontpOnyhsXMXfZ9Yse1JQUvBFCo4hS9QoxPqJbLfmfAMSeAEX1GHmsNyZuCTHPvlUCDh84zFSz5i/0NSZIHc3h58sx0R4XAkMA6i23ZRaFpQmYZl+IId4fsXQESjmLDgaoOFbNIU497OwgHF9F08SB/TEiOqqkKzShXc2/Lt2ppnPUMxJ4dopN09uI0AjowDXKooeiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xruRPgvT1sdKk7WH0XQxaZLvzifxAT6Q0bYVbvOTuGI=;
 b=p2yAqD2obLaqkSiZhVIdjdogBmSFOw1cEzg4KwymmiwUqwOpFGEvHuLin4QB/nBc1Mbm4qAx/ssO2QU4yLfDjss1SadWXvBDCPjZWv3bWkrpg4u6S9yV0QF7B4Px6zRmJpumTDYEz9TgCifKLtemazbB6/yONiAFCOP9N/9jG4khzqhF+BAMzfpXGk+vx64QQUd6Nlq8LvZ2kkKqJM2aM+MbjES2NZ01s288lEYIh8XJzbVEPzD17nPZcu9lHPvA8S8aBcHkBrbhSekzk6dLqPK8ArhqMP4qINDrv4xqgn+tBVTZcEswe/VyERfVxuYH8bFEqFEC+HMQYsi99cmxIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 05:53:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 05:53:05 +0000
Message-ID: <4062dd3b-77c3-4ff5-a7ff-a195f35b9e12@siemens.com>
Date: Thu, 14 Sep 2023 11:22:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
 <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
 <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
 <OSYPR01MB55422F888CB0CFC373E89496A4F1A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <1729ac64-b891-4dae-b723-1e009c92d66f@siemens.com>
 <OSYPR01MB5542F9FA4966AA0F34736826A4F0A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542F9FA4966AA0F34736826A4F0A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: e498a829-03fe-4a2d-642c-08dbb4e6dd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IgO9wGDFjAJQwEZM1DUWT2v97l3jO19kaN9qec8d9Zgfz5VzyFG1R8Od0KKMdfC5NrNxi5EE2z2iv1kCOYgbadNe/piByoKWw5Ct8duxAr576JCJvcoj1wnCERkBggt5rjnMmkvuBFdJ2mdtfpCHhAteAWZjV89g78cMfwzTMDAFN/aG7f+RvcqjLCj8aTqFgkpG+S97U5eNkA9bjCg92nsmtvwESXXgZ3EY6bS/EVjxtkiCC/c18sNFdBvx91pJxrl5nFJj2yzDWbQp65P8ZnPZRGn9EFkOkn0rB6+kXYIAb839Q/+I/lzV2vjN3uz8OJmLWBIzrFfaApvR+Ubb+4szfb6amkx2g49YNTiF5lZewG0jx1gh7F/mc7NsEMJxOnptYOU22CBHQEAFsKDonbsn3AMK1BHtaTou3xNCPetS8XBLnPo3kRFaIF0cA2nKfXIXaqzy4IPviN2sHf5BMhFfs8LCTeq8qrfEPlwtkcqeD/XfC9xRdXB/93POegM2aUqkI4Zbt91jeGUtK0X4lyuYKYS0KBShqu02qd6//odYU1eKnVc6oX1u9jxOTo2w/qmpu54hqJycfA3p9AUYkkhO30uNvQdC6D1+Q74lYmMCuxlF+TmDjl+GqZyGULNSsaemvhjN0nVJ3bMrSVnoeA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(82960400001)(2906002)(83380400001)(6512007)(6666004)(53546011)(2616005)(26005)(86362001)(6506007)(6486002)(38100700002)(36756003)(31696002)(478600001)(5660300002)(31686004)(4326008)(8936002)(8676002)(44832011)(66476007)(316002)(66946007)(41300700001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zeG3DDupIH/PCVTdSOJp8saBh/MnIvhsnyZBP4g0xKXFzLMQY4lNpqUAeyzT?=
 =?us-ascii?Q?QFPn+bbn54SyWS6jssETpkrI19erhHWtUvab19ebbv07YnZDukMFMrReca2q?=
 =?us-ascii?Q?K2m3nQvPMMSOyZahhK/0aMnbl5JIOHHrlDm1dWeaUaTP8DW1ynxOOqENMWpT?=
 =?us-ascii?Q?5bGrzjOyxY7iX+Ug0GssxECRAFFT4uRLtd+WBmM+daWvHmu4xU4uNmx1ZiY5?=
 =?us-ascii?Q?3IHwAW/EY9xDms5N5tkA291SJQCOd1byRwoekmG5ZEJwVBihW+dCfCD4d7q8?=
 =?us-ascii?Q?VkGIBQiuYLctbLaF4XYieUY6vh+NUpNQbOZBs7M1SyMFKp/5E/nQlEjIJtIz?=
 =?us-ascii?Q?8YmMNARBTPnq1rrQYn+Na3qQQ1SK512hFPUZLDX2/jikGUinwaquMtvq04u7?=
 =?us-ascii?Q?H43RNmf33THDLBoea1cbKuWauGvgzOOiAlpr3uwqQrfmp5evOfLJeKF81rgs?=
 =?us-ascii?Q?vZAVl4HfSGJw25xsVOiYjyhBYim/HEyb2+QO37cBSFwdMQgy8yJq/a5WPWkS?=
 =?us-ascii?Q?6+YwsoVfjLxZuTMyjNeyf/lc9v/ltoc4PbSy+d47gvp5P8/Se5EQCXt/gfAJ?=
 =?us-ascii?Q?5NwHi+E7IEL8X40rkGyi+SaJOwpVBYVGAwBp/cRaXYIFQ50Tn26SLmD5NqYO?=
 =?us-ascii?Q?9lTL14fcp6DNDV5KuRCa+IaWgT9VGFKNGfJqm4x9+cI70mg5Xx2KTx6wDQe7?=
 =?us-ascii?Q?TZXjhWaauTQDE58Fx6juP0PSu7e868xwE6C+R6PromuRU8MuVJNtYOeksGat?=
 =?us-ascii?Q?Aj6Zs0G2FXCmHZCAoRmuJO8n3qXvAxcYUITEyzfP3HKLWFEolmrVUyJbTjTw?=
 =?us-ascii?Q?oLS3syrW2RSdAYoKzgbpMnC20BiPI9bwGtaDDcZLFJ46IiYlcCCE4JLIiTaK?=
 =?us-ascii?Q?Fd5skPFuPb52mU9qePb8kFtQLAV0QRLp7zRtp4T0kv11uz9iJ+RV2qGpLfGC?=
 =?us-ascii?Q?YiuwxYRm7iGx7rFmOhCtkVZtWZCzh3vCZClDRGKsYmXXfMPHy+sH+ydsWymW?=
 =?us-ascii?Q?GaAvV0izjc84IHlJLu++FjlhXKoPeRHHdFj++5qPzUrqBEFWyAjOaRDsgHCu?=
 =?us-ascii?Q?L7DuywNC5Z/UiLzjYqaA6prB9/1ugaKq4z38Eo7p/0SH3gfP49CfATEy3Zcz?=
 =?us-ascii?Q?GvwX6I2dy/J3cO4lkXy7fTPDLLG/TuggCJYCJHXWCGodKipz9vheMpKKQexa?=
 =?us-ascii?Q?BQs2P/GcvaPyLydAWo7Dpocd6UW4dhnTlBmrnLk0IMRlVjhgL8vDDEY2AvmC?=
 =?us-ascii?Q?jaj9dfDAi4x/zuq7nh0O/IkQHcXOAXgyBc2SsFNWuW0Zdetqe/LaY05SbTBi?=
 =?us-ascii?Q?id9WOUQ769UdEdD5mQAAmT/Jwb4PvfYp+GxTlCL+PxWFk8uQVqbeSI+SOgFt?=
 =?us-ascii?Q?HGCyCt9nvy+63A8djE1VnyAY8WxbPxQyGLZYcuD6BkYdUr3oIC+8E76Afso1?=
 =?us-ascii?Q?aaF+89ciGE68N/pIK/dRwQl26T0aQV1l8803Z3SN+yKTh4WjtIYKrXv03zUO?=
 =?us-ascii?Q?4VD5KjN7idbzAh10SCSNoU1j9toDPzdYrCe+aFrH2pQGahmRno49W1rNRrAi?=
 =?us-ascii?Q?2HaakGYZW3cyxLF5yoHOkOItkWXnGCOMp2LsMqAAUGDEC5f+erbr4Mad0lMR?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e498a829-03fe-4a2d-642c-08dbb4e6dd14
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 05:53:05.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1ldAbsIfkpmxkQgCT7IVxdT5Nl6Uch2FUMQwJb4zg7dIhECV+J1CRBYAbP+x6S1Ln2SgbRQNU4UhNyKwfbKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7468
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 05:53:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13127

On 13.09.23 09:37, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, September 12, 2023 1:20 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB tar=
get
>>
>> On 12.09.23 12:22, Venkata.Pyla@toshiba-tsip.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Tuesday, September 12, 2023 8:39 AM
>>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <Venkata.Pyla@toshiba-
>>>> tsip.com>; cip-dev@lists.cip-project.org
>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-
>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>>> Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB
>>>> target
>>>>
>>>> On 11.09.23 19:01, venkata.pyla@toshiba-tsip.com wrote:
>>>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>>
>>>>
>>>> Which additional aspects of reproducibility does this target test?
>>>
>>> It will try to verify additionally beagle bone specific files like MLO,=
 u-boot and
>> dtb files.
>>>
>>
>> OK, so this includes firmware generation, understood. Does it also inclu=
de
>> something that is now checked twice by other targets? I.e. can this supe=
rsede
>> some other target?
>=20
> No, the kernel is different because it uses different configs, rootfs con=
tents also different as it installs additional packages like u-boot-script =
and u-boot-tools.
> So the bbb target image contents are not verified in previous targets.

So far, we are not looking for testing each artifact we could produce
for reproducibility, just like we do not check each configuration
combination a user can select. Instead, we are testing representative
combinations. So my question would be if the BBB can be sufficiently
representative for qemu-arm specifically.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


