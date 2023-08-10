Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D53C001E0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 16:38:37 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.79])
 by mx.groups.io with SMTP id smtpd.web11.22312.1691685510411036524
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 09:38:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pSAngexO;
 spf=pass (domain: siemens.com, ip: 40.107.105.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eelVDirMO6dRdbtuKmUDUl+4kbFwy5w+YsHT3ahIKF0TXJ3riO2IeJedC0Qo7PkdZfpXnwnabgqqyrlGFX0LT2dCbjaZM8MYh2m5ZhwywQiljyzlfAokkXHOxrslqvWERXPen9FlzZvYYeteanEbAO0Q9uGvVlK33HLBocJ1r20G3UD0eoFxI1+NXHLNmu68SyXxvq1DF6EcQl06QDhXxXNnQ5XOpQL6FlRSxINWcvv6DAgdMOgyASE9XuRJChwqVTKKfBPe4UTk0i2U7T8Asbq/ztl/DkTPxbZxVigFDq+QRRCJQASo8vGISYVD/7kZe4v5sISZQJnu0KCvQxWq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI929nS3eagY1v6B00qmJz5JMjOIp9WBxhSwzumW80g=;
 b=EIG96/U4tKvGn5gP2fPPoe+gqoozLYm8sl4n5vGMLhb6rX3qRzn1bgcnd6yCIns1C3p4FKxIYiTVsVJOAT/aXwAohYSERvKPT9BwibH5txsShZY9chMB7F074dz/vGkarVhz7ZW+pJ2808dH0cHR0jZ0rEYdPXvCdC4wkv2Fsfen0NS50iukiTdyQa5VJwC8dP20Goi1H9J3PfwPy06CxBko/JmYOwSN4Ef2yKxPooHvamvsoY3OLSyMvi+VPwZ6fLnEV070sXhMoTgXOgiddQG83m1J7V4MSBekjD+mjVmnLHfC4ARKlkLSopc0s/FaLdGVjVv55JsYwXJi4KdPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI929nS3eagY1v6B00qmJz5JMjOIp9WBxhSwzumW80g=;
 b=pSAngexOomPkVyHA4RjZ5ALPpv7bZgCHSw12RfVjuOlXgFbe8MS04DI0p2+wrCZCyRJ24E0cu4SxpNqBZbJ1wHQ0n9xf4F+IYZwHend6VwkO8U3tESBfaIYAMS4fuIbL4L1orziC9C/opIRaV5tpOU2Wv0Kj8DJVCCV72IuH8gE8jya6bF7em7IGpGM0pDqziO+ZhopVN7bSrcIODcv3l6fP/D43q6SddOONGNtzjmylZRVorMvKeDq3PofduTZss9/Znmb/Pos1semOws98Fy/sHkId5K9IzrntVYYzQLUoYQozYj+MmIN1PT3WmJQJXFtfuV1tm85jVifvtUEsBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 16:38:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 16:38:26 +0000
Message-ID: <f75e9b6a-f89d-46b3-9f38-2847396e35d3@siemens.com>
Date: Thu, 10 Aug 2023 18:38:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed
 updates
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
 <ed132a4b-7c2c-44f2-b1c6-8a7c8fdfcdda@siemens.com>
 <45e6785d-6d78-8d40-bce1-2606661730e2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <45e6785d-6d78-8d40-bce1-2606661730e2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7397595d-efb8-40c4-2e07-08db99c0380b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1mdJlfX/LIuyL8WhMSQXt6ULykkE00joB9UlMKWqyutmWIGtYT3fpYaE6WF5okaZ1wJVfVwtWuCbcASuGxmM7SiPKrv7e8u2oAdssx3gOdUIgwqVfa+ls/wmMPGqmRDNOnzfVTcN9qb+fw6riLdP4L0xAdDlGRvBoBFcdS6AfDe1dGiYP6TJM9f8V8zhgB7x/qTKomD8OnD+MEaw/gXAhKqy0Xy/6fbNC2YokyHhOsGilN6Mn7RGCVo2M0pK9gXSGgJWUS2PBEwUao+4eeTpgzonV/bjkyIryvxFP0dhbNjPaEXOF71ky9xEMaRl5iFC3VtHw3pFa/nEZpCPMaPSEB2aCB/hmFcPPxzDYPA2bv6IDgJTkm1Yz+bLl91v4g7GaBLRcUdWfTGa30IYBxT7rCU3fZl0zfFn4zZy4/OxRYno91N/Jl3fZC8qwVlOdRSFg/U9fTNs89sR4tQo3tyPRW6+9cfiIFMplAGiWgx9ei7Rar3MMJM2XdOebXbrnl5H+h50LfWQzNKAWGLaSQTSYT/tEO4i0SH9CxYonY/ycQAZ8xYZkptKjNiNUxRXIBsdFJxZCpRTbAun7vlL5IfJaZbZAqE7wzdRRAFsMvwuAPfXybmsroXYhFWnlAOWuRHOiNVY6kvFiQVitAB0RAcGqg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(186006)(1800799006)(451199021)(66946007)(66556008)(66476007)(31686004)(6512007)(478600001)(41300700001)(36756003)(6506007)(316002)(53546011)(26005)(44832011)(8936002)(8676002)(5660300002)(86362001)(6486002)(38100700002)(6666004)(15650500001)(83380400001)(31696002)(82960400001)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XJkENlBE9V/wkrejxOam9801JzJhNQQtkZgtOyfFELXX5djzvcAGXl8T1AhB?=
 =?us-ascii?Q?vv2fuuNDeZfGCneFKDnaLyKO71Nh2vNIIkQInlRlplVIkKI5Wh2qBZf5nd8n?=
 =?us-ascii?Q?F3D0cR6xLw8DC9gvN20oreVm/zMNfwSlVlUDuGMLnmIq10KNQdBkTE2H+9Go?=
 =?us-ascii?Q?8AYOrIoyQNxu7QBEFS6ScDD80pSK65hV23edRnd5QYxclT8OvT94vEIbAeE1?=
 =?us-ascii?Q?GNMPCTLFypvT1Y6D33XKfBZY9bFsldGv9ge6Zo6xmHBF4N53Ekx45929nPbG?=
 =?us-ascii?Q?+D40AhdVn8AotFdZ7ltAceeaqw9gUJSZ7l27kr3w6sRog+oIR5hZtzVaLJdk?=
 =?us-ascii?Q?vat12aSSRqzYg8xYmoTUPa9Dl1Vxmg35KPFzbBTiB5nwxc12j3VkIHhxi1Np?=
 =?us-ascii?Q?asnKKCVRLwyJQLBM7yvLrmSW3urnl8ZJSxrOOpYlhW4EWmqkbw4Ul1ry4A7T?=
 =?us-ascii?Q?2CaPj55ArkuoMr0023mw8rjZC35JBXxjymA6objfV6efLdFabXIipYsechAw?=
 =?us-ascii?Q?d1u76LxNPkIaJJ85TzuEZNpzwQs3lxi/yav14obyGatCmWfHTrUMOs1zuiO8?=
 =?us-ascii?Q?kCGJQnkL4cmccdP/QhXxNg93tJ00WGfnurDZzpGUH0sHEro1kKp9FpBLvR4E?=
 =?us-ascii?Q?fh+8RFd8UO6FAOnNqhl3SWKowgFlHS51M+cBTfiC2Kc4Yu/MC9vjdxy9u40m?=
 =?us-ascii?Q?DV+ayrHGkCwCkQ0r9om7twhSMos7zabI2/s2aojcJa6cItZD+xiRiHxIq99e?=
 =?us-ascii?Q?OFHlMqgp1x1HeZvrfbXnI0+/pDpgmyr5GGeDYwSECT2TqkJHnuT33Z7YjY1H?=
 =?us-ascii?Q?W73z+eLND1kHKltGHjnVfXYcaaYsXwEe+AjPm3qquHg0aN5/25dH+MUCsIIw?=
 =?us-ascii?Q?1sfnGLlf9iXkgTFGyl2B8EQZz0KcEc7pukFwGiT570kR2FCBXxli/P5kqM5s?=
 =?us-ascii?Q?6S5gloctgMHvzP8cHmtPRBKNqcJXtNvqhPp0zbqNGkDIdM75QyGwaI1kyaq6?=
 =?us-ascii?Q?0B5GMajL2lQBnvEiRgR+pjdRIz5x+ayP29MbvKCJrIYTq9/ExUkGE0z9DYUm?=
 =?us-ascii?Q?tkjJimy5LFdKJvAMA+PTkyuRNUhld4tcaSz3Ca3lXvXHKgSINiEUIFV2XbI1?=
 =?us-ascii?Q?xkt/GlkRx1RFvNY4JGCArqO8mDZY05iRkzDiRS8pf4BB89DyqtaidLojyl55?=
 =?us-ascii?Q?aZUm92MmjXcOb3Q61CHKRoUFqImZdD5GcVM7ptOa1UiQzz5lcR/YXRE2Gpxy?=
 =?us-ascii?Q?FhL9/dbM+SsynIKRsq6bcLau1Iy4AANJq0n3UFrMGYTDhZSevspjrMqObYYT?=
 =?us-ascii?Q?eCQtxI+217Y97wJSHvvVJcL7tY9o00WSa0zbPYw69UdnlVEzRLYBie1RQuRu?=
 =?us-ascii?Q?cXzAshtcvaFhv88bZXQfsT+Kzsh82HDy33XlDueQCjUTinurY3xF6Ey74AEp?=
 =?us-ascii?Q?7otMqyWpLs//1iiv8S5IwDDhYBKKdPF0ly61O6D+0CO+s3YiScDRi8pV9oud?=
 =?us-ascii?Q?89AqVYt1Fwg5COOMVledGm6mC3OdLvvLoAGgqYQ7DPtgX5zcZkOSZ1njIAvl?=
 =?us-ascii?Q?EC812jrDGyKeww2/vxEytrT2bCbbIuapbfITcTbXk1gX5PS9tg5DN3an4ViI?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7397595d-efb8-40c4-2e07-08db99c0380b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 16:38:25.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2S+E2S+kXtw9ZVDO6ca758AaBzGtarcupG4rfsCNyGvtp4Eu4AlTUbhH8NpW9ziFplD/v/4csl35xMtIHLyOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7364
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 16:38:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12607

On 10.08.23 17:58, Gylstorff Quirin wrote:
>=20
>=20
> On 8/10/23 16:47, Jan Kiszka wrote:
>> On 17.07.23 12:54, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> With this change SWUpdate requires signed binaries to update
>>> the system. An update without the correct signature will lead to the
>>> following error message:
>>> ```
>>> Error: SWUpdate is built for signed images, provide a public key file.
>>> ```
>>>
>>
>> I ran a build with SWU_SIGNED unset, and the result rather gives
>>
>> [TRACE] : SWUPDATE running :=C2=A0 [network_initializer] : Software upda=
te
>> started
>> [WARN ] : SWUPDATE running :=C2=A0 [scan_mtd_devices] : MTD is not prese=
nt
>> on the target
>> [WARN ] : SWUPDATE running :=C2=A0 [mtd_init] : MTD is not present in th=
e
>> system
>> [WARN ] : SWUPDATE running :=C2=A0 [mtd_init] : cannot open libmtd
>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] : Found file
>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] :=C2=A0=C2=A0 f=
ilename
>> sw-description
>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] :=C2=A0=C2=A0 s=
ize 1219
>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] : description f=
ile
>> name not the first of the list: linux.efi instead of sw-description.sig
>> ...
>> [ERROR] : SWUPDATE failed [1] Image invalid or corrupted. Not
>> installing ...
>>
> I will look into it a send v3 if necessary.
>=20

Otherwise, things seem to work fine. I would just like to understand if
that is also an expected outcome.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


