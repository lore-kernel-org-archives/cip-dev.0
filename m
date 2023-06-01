Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7067BC77B7A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 10:58:59 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.42])
 by mx.groups.io with SMTP id smtpd.web11.28060.1685617131292855392
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 03:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Cg3vXS5U;
 spf=pass (domain: siemens.com, ip: 40.107.15.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZeifTNAleZHfso3mYoYch9+Gvm8Q9c3HxCLzFtvGzDCy/w52Q6rYbuOhqhZRTS10sFDWQcLCS3Et/X0NMIa+GJXZvx6LtTKxbIk1xBXLyJpouhtERq+H5j8PLeDKBBkv/JxfOCS8nt47rXR4Sd+96iTr9ud/viykj6VMY8yJ3B/jrNFxEXFjsEq4cF5JOP6UhhbqefLXqwigcF+Y1v9vgObl1mn72d9UO9Bl7udwwA5JTsxD36hd0PK63Gke8+NHu1vHI4hMW9giS1K9SnjhnMt28F4Y1t6PdaAger5gXSwcJiQqeiE8LKZMwR+r7cs+7lg6ap/HcKb7wdqleURmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cztPpu2j9BHRlAaL69cm5oZYYJoKWnvjfRHoUfu2ZSo=;
 b=GxqNbby8iSSU8DanR33mc6SKd4u535QfG0aBID6U3TzteaQ1vY2WI0icWO7u27eHmSVkoCB8XtYjSQx1iWvma08+5kuHYyTYCBIWa6uf4t2plNCG9bs4ayvPxETnEIcgBs6ZQ66Pc7S6J+2L3dS/hSnsqLd0zVwHA5+ZChnbRzOacNQT6m20TSBKEdqirVs0hFO1LBBDNytX0agGWLFhWeqs/hMUZfw0QC8RcW+qJi23R0Pe/SaTZDZ+643/0x27fA7yYCuOfbB382VECmmaL8KoDZ9mP8bn5ZQt1tkdAOMRjw0iJH0ViVyQZXNtcepdbrEeD+IjrmT3eUmCgftQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cztPpu2j9BHRlAaL69cm5oZYYJoKWnvjfRHoUfu2ZSo=;
 b=Cg3vXS5U+RI9WCxCne4XAofHI5GBaaGzukJUL3zZQJDZX367LqLw/4goNuXzEnTo87z/yyVqHSLFwjdxFTHKqEaou+rRu6c7bCtgN+cYkOQoTfefX421R809G3pWN0/mUcbvyXRP/meKscCylgkuTtHl7Z7ckEO2Cv4O3o9d5n+8lyrLlOtaYSl/AEbaYF+LIgUL1Kcp0Kqhgp/8YtZmkj/tSnW/nJQP4bay8o8ztBTuQGv3gtrcCPVv1uGvwN1EuOUAK2jS1pd+PmYQMi+Qblfg1iIGlRAoaNTxPMhK7ITWzIJcsgEyLglnGYn16sRGIrgAXEDIotxB0TRWgVlp+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6844.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 10:58:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 10:58:48 +0000
Message-ID: <2b4b63e7-1e6e-beba-3dd3-bfaaff1f801e@siemens.com>
Date: Thu, 1 Jun 2023 12:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reproducible
 checks
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
 <54ccb6ba-4a00-38b2-bc65-65a7baf86957@siemens.com>
 <OSYPR01MB5542A26EB39703EE7F2421E1A4499@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542A26EB39703EE7F2421E1A4499@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7344b55a-7de2-4039-6852-08db628f2d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Si/MY6AD0HemfPLqI6oeluiOxYyhdCcUdrXgyv7Imad4esxHnto7nd4FPW/PQ2CtPvBlv2apOgkojcdmuDqISvG75CXoSsKYVmhgJycCY1insMqDF7Z6iQcDMvAv5tubBWZtJ4sMd2YQHLbmp/0ry/8PljO2ChQNoIkGpc58may+b6x0X6DngPA6WCfLFy0+hqYHvTSymbNPBU67SmKGy72PyPAJL6PCMY1d/408k6x8JyvnTv2a2cgp9yXQicF3RbVE4G4rBptu2SNV/wUByBYwKgCD3sDiwk33EjsMPlVoHbm98BwofLnb+Ga31m3BU3P52SzoILIGEL0WIXxPMzmclKwxClWEnw/wu+b4cRRGOoNT2YYE12QODTpwRJvJqnA6wkDPml/o6WhSynKVVE16RKsPPqo+g/3o7Y62wbWdJ6hAAA4qtT/5O08WvJV5I1JgBA0VYjLuasJqZ678FLM4TobuHUNKR3tntWU85dESXERTgUIwLyzU6rCQsj0u/DW+ZFLUwgpj1l9OV4eW47bqJoK9VSSdQNMTXPKzz2DVUCAHlHEnuGmDL4ddLAyrAaThSEuv3XdE7XUm8Uo3rtc0AhTNW6195MQd55IkgW8FGViB+d6Jbukejr22uaXl6UfPrDFqqkbVXwiFdSvTOg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(82960400001)(36756003)(38100700002)(86362001)(31696002)(31686004)(8676002)(41300700001)(26005)(44832011)(6506007)(6512007)(53546011)(5660300002)(8936002)(2906002)(186003)(6666004)(83380400001)(2616005)(66556008)(478600001)(316002)(66946007)(6486002)(66476007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Dqd5tToUnaPf1mEjUA6b4COZBRG0MbHGHfRcmHkxYKk67uhz0Pwj7vWX5nlP?=
 =?us-ascii?Q?ZNp8bE+p778pGVF2HrAz/mt7ACP69ze05TEkoPUvxohwTtgl7K2UL/szB7df?=
 =?us-ascii?Q?qx3yK3Cjh6kogA7D7KG2ZCYolqT4yHWDK1upie96kWMYTLqe1FAVEEy7Q6PF?=
 =?us-ascii?Q?cCQk+6pRJhu/rH/whjDg2lGTno9gzJc4beWa4D22s8f4pv+FTtqzAcH/HYfp?=
 =?us-ascii?Q?Gwjhdk7a0Ne7dGya3e+0IpdC8lnynoi/cs1dX3WUTNKqp+zld/1oZ5+3MjQk?=
 =?us-ascii?Q?1wdfTPGUlYpaQF/XkCGlroP8MQfYnUacW/wUa8RgCYHRR5uGlG6OU3jsN/4d?=
 =?us-ascii?Q?xq2VY8DrTNUlda9nPZhoHBHbOTAGcqMTViqtgZcR2XWGXL8el08fovBHTU7y?=
 =?us-ascii?Q?J8gM+BdOkjqPxaCo42rGgEi1+PXAzVgv3FtFOERX7XflPEIxIjUQ0rY2oL8Q?=
 =?us-ascii?Q?45gOMNGL13s/SezBSatQRdCIhtmSPQlf0MgUsG6VNPyRIzaLkmt7oVTeTmcs?=
 =?us-ascii?Q?JiDRD5Pb3iP+XCiLp+Y4hIbeXWygSVUzr+5bkLu/0mMO1bI634CWRId5NFAb?=
 =?us-ascii?Q?z+uAAe/ARFZO21zuyCVp2JohG9rHzHMuNzn2r2S5tbfITfkzmmj11xPqPZVR?=
 =?us-ascii?Q?SkLrzrXbUihlleQjsjA9aDnLgJKqlQnC6uuqKjTRgRkxIA33Ek777geRAiHt?=
 =?us-ascii?Q?o1eAXgF7clJCzgFuO8nFoiRimm0OOmHXDZH2cMiyj0HyYVVNLS8JY1AXJ+/c?=
 =?us-ascii?Q?GF74OdHzA5aRWcU4XNUjoLtuu7QlxVLW9Y9igCdy4wjsu5BkkU0CbFKc/YfS?=
 =?us-ascii?Q?XHJ/RFKrCOtY36/QWctWF6DlUH+INTcaCTfH903u0PZzFLij8OIKGrNLg/Q+?=
 =?us-ascii?Q?ijJ6Zjq/fNcquutgjPh/k3JtshOOwg3UZRU3H3e81ZyowhQwOcExxHnLLvkQ?=
 =?us-ascii?Q?IVYvIrkqdUN4iNOLcU3i+QYOJSv0B0eDf9m0AXb+Id67a95l4pB7tbbSCOxn?=
 =?us-ascii?Q?uvuc4Vn9rpepS6WsyPIg0gctr7qCPFkJ4BaKT4RUzoRfWSPJ+U1nGzFZHA7+?=
 =?us-ascii?Q?nPzWxKbHXaHkU34kZTgvI++hOFHod/lGwy5OpC4ZDYsMpntxE+td2AOupJTH?=
 =?us-ascii?Q?kva8j9bSS2yPm2lZqVM2anuHSoLjPskJFR6bvHYPQY2BWO02uxrKuh5eajVm?=
 =?us-ascii?Q?xsgznwRDSIN9UCWCtwcPnQgqep3u5pfJ0Z1owRM2cdLlS1BIZX5tCEe5FFCW?=
 =?us-ascii?Q?7a0OfoqYpqltck16abMkKUTFFdP+lgUiMNA+CdnUq5O6excYtwB4khgRUKr5?=
 =?us-ascii?Q?e4c5PxaC/yq2P0X1EPW4n5Njr97VLbEopMrNmyvLVd7F+h/DMZeXKEiSx/mr?=
 =?us-ascii?Q?hS5dz2+w8U6hsI2hr1l4vz7TDTiNlA8wWhKaPm7LVQ0muxp/mqM1Yehe26zg?=
 =?us-ascii?Q?DZDU5UBTEkLMilQxckqwUdHVVJc1NAdEVY9MktXVfb+PvFJZYmuOePf2lz2Q?=
 =?us-ascii?Q?BliS1YEMhh5Di60Up33pK7JOtSyWu9OfG3eDwIJu6MD3nJC9jeFpKQfFVv5t?=
 =?us-ascii?Q?8YgMCUP3IdAezNu0JxtYB/UG+RGATblsrJakp65k7JOWffTx0369dJfYFcxA?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7344b55a-7de2-4039-6852-08db628f2d9c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 10:58:48.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaqE7Mw2LxWiyvvKJ50upLay4SjapYIiw5K1IRp40WfiHA05Z8/VZyByzsWo6HpDivpajFQsy7NP6Jw+Il3cVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6844
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 10:58:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11725

On 01.06.23 12:43, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of
>> Jan Kiszka via lists.cip-project.org
>> Sent: Thursday, June 1, 2023 4:05 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reproduc=
ible checks
>>
>> On 01.06.23 09:34, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> Hi,
>>>
>>> This patch series enable ext4 file system images in reproducible check
>>> CI, which is next step after tarball images are being reproducible,
>>> let's see new issues in CI after integrating this patch and continue
>>> to fix them.
>>
>> Can't we address that directly via wic? That's a way more common use of
>> ext4 in Isar layers.
>=20
> wic images include partition tables in it and currently diffoscope is not=
 comparing the partition tables in the images=20
> so, I am using individual file system images (ext4) instead.

But I'm still not convinced that, in order to find a few tunables for
mkfs.ext4, it is worth to set up a complete separate test pipeline. What
would be next? xfs? btrfs?

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


