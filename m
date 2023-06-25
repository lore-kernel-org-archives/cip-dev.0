Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3C3EB64DC
	for <webhook@archiver.kernel.org>; Sun, 25 Jun 2023 08:30:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.61])
 by mx.groups.io with SMTP id smtpd.web11.8037.1687681812933696723
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Jun 2023 01:30:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HncpVp3Z;
 spf=pass (domain: siemens.com, ip: 40.107.21.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXUeLZHtyjY35nU2hPAB86c+VosEqdA2DbB473EIKiDU9FkTdakjPxpuVmcl/0atbEUPQeK2m5x+7NpbgcQIx1DVoswy5Dx+P8WhdoLDA/55BIXcWNn/QDqj7qj9Iabj5fYHyL9HjrICKYmPf2XyjC432FNh8UmrV7XaVuD+V25s/VkssLlu6GLk2ymwCTlr22C0E8mhRcc2Dd7zN1npwsEAHbgFfjnb661p04Koxoh6b7TDD+S7hrKRp2u+pqVH5n3k03JxNNIwZfSjkKm55qlur+mJ1kM57CiXj3B/mKlQTehJJe3hRh8BfRi0L3+OH9AinEBeJpdRoNPuqwCaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqL6L8QYr8SDxH12dlq3AJWSrWTlRsGW545jhibR2i0=;
 b=mjBov8kSUd1L5y2ZThCupVCSEC1fu68KWZDIsTLScDYB8WP4fLTeUsKXsZCKriPYHhAXFJs39lDuEb77A8Tyne2JfuDgjaOJoommpd2LPvCUXdyVkOHbYv7KGCffRyHk6Nrwv7w33LPsb2ZD3X6E97DSHkG6ToyKV7qrrSMdR2hIz/5albp29Ro/HP2NGrlWod8VS94Dtyi+hSMww3zLcfhQ0Pykb/syfbaMPYZqAY4l69s9ii6hHTrPAjL5iEri1a/2FMJYIhXP0hINJHTZpYe+9xLT4RCKc9tItAguqfnnvujOibbhBq7kbzfK+uicTu4cBHXXaK0p30c6KEZoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqL6L8QYr8SDxH12dlq3AJWSrWTlRsGW545jhibR2i0=;
 b=HncpVp3Z6n4E4wR2tWs0hJ3SCK89R+Sm7fYPqzFcLAhdx782G4tv6eIkYZRFRVJl8O8+0NtdoFLGUwuJYgmuqga+BSC1nd5qIckRNHkz4AKiDng0ueck5GpzX4IJUxWkT2bDACPsxDkAl8JmJuub/Ahm1zemyZGyMlTrlTnnPbfzfXXqZyu9pVb31jGQSjRubFz4BkljBd4rYBdKuJ1uvqucRM2lPobQr1ux2+Gz2jLH2DxKGcWtWVN4azSeGm7BIlH53XWkfLy1gVceL2IAM3qSwSYn4nHzqNnZEyqeciF6oY8QmtoOkn1IKsjJG9TCEwLKMzrAfhuhtpOBvFrXRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Sun, 25 Jun
 2023 08:30:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 08:30:09 +0000
Message-ID: <1f9a51a1-1ae4-8170-65e4-bb841df9ec66@siemens.com>
Date: Sun, 25 Jun 2023 10:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: RE: [cip-dev] [isar-cip-core 0/3] Enable swupdate targets in
 reproducible check
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
 <920059e0-642a-f83a-de35-937dcd4f4e06@siemens.com>
 <OSYPR01MB55426E11837823C188D6DC1AA423A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB55426E11837823C188D6DC1AA423A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d28189-a74b-41a7-8abf-08db7556629d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x+xctEHi4Q45pZ0O+zEQ7khJ08vmxaL88nP21Dzf6bj/uEfzyHm/iP9ruIoztSRSJi+KPffSZEjdiu/BLe9fFxEpoIjdZxBZTzJ6jhx6nvyIA475mO1YB9GHBtxbI4hjlPfPwAQziukI2qdaPrIOrmjWxc9x2goIy6yF0FEYa4uSu0IbjTjqGI0PzPeNci0wg1kKYaVXdPsMWbj7kBbevLBTO8aFYOXx5aFztVAn5hVXPLvdZYa4AaVn4BCC4hZqFLQSaxlPtkbnwkg++Da1Wpcl+aMwlmc9Ylpf6EBS9QhyysHcCyA1ixzVW+fS56683Pg9O+cMpnpIo+UBjEztCno6ELgQ/XrdXfYyyjypqYaqPlZCt0CHaLPPot5SD2Y+mkWyL2RuslXyHm3A3T9TlUVmKd4n0GrwJOVV3l0f+7tMBZ0Ap+nnGrzRD9s3CSRZq3YHFd9QcHNx8jxYM/FxIr+4b0ck57gC4dWJGQ/giUyk9OCP7RqQ/uXqXHcAUm1Li83vo5hsJ9ILOXhaNKa+p94t6snH2Q6xk+jrt0l67KX5PZZlHzketsIshuweRBSKNsaVtGrfzOKEvVYMToV3bghacf3grIq1c+UDjQ6SzsKykjPoqS8erCPbzUDeoM4GZWQJVLh/aFG4yTkegCfh6A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(2906002)(6486002)(6666004)(38100700002)(82960400001)(2616005)(83380400001)(66574015)(6512007)(6506007)(26005)(186003)(53546011)(966005)(41300700001)(31696002)(86362001)(478600001)(316002)(66946007)(66556008)(66476007)(36756003)(4326008)(8936002)(31686004)(44832011)(8676002)(5660300002)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3QaLj7NehQFLrIW1RTOGyc97084vvMzhD0YogArOQ4JrmYllUW4OhgjIZmHC?=
 =?us-ascii?Q?OCkavuvFhjC8kXC4OkKYpn8WigQCVwy81LWIxli3McWDQQe3PRVpXO8hLv57?=
 =?us-ascii?Q?OJhbwzY3/crT2QDQMzFd1SWWyI73sA2Piht1/rOjI7BfDThmtsJrTJ0IQKCO?=
 =?us-ascii?Q?ZAUCQwgfXaS7PTTPsdSl2qYL9rjTMOPtJ7iIVgCE453oXSavtKu7poUSfbfz?=
 =?us-ascii?Q?7yzANS+ZDqUdIrp4Vi6NUJvHcTMkd4r+b3i12GzNnEkoNJEGHvbYjDlSmVAp?=
 =?us-ascii?Q?UEZ+J/moBiUaYv7Uec8ku6KO3sLO7RI6lEk9nbc3RtQnt4VVdYqqXsYphfne?=
 =?us-ascii?Q?o8rVPC0NWsWu+TFBaTOkLuuqAS2CrsiFW09IOmYw7wXaUmEbTfZcv7tOngyv?=
 =?us-ascii?Q?u5xorYCRbPE439T24ZXO8pIQOrcW4H8/AKsyD2U1ZWxdhJb/bwn2p/P9HFZ0?=
 =?us-ascii?Q?iEdSNIO1d5nG4YShJbXnE0GOQVGpcwlBp0imz/P6k5XjWiTRHlCaJi9zjglX?=
 =?us-ascii?Q?wxzVUsdej7as2we3UKz/QLB7HE/cQnWH1uAOmwbOzEdmRUFDAbnW5DMfX61i?=
 =?us-ascii?Q?LOqboXjSFhTs+lvVstZO9maS2A0bSW25/Wac3BsQLm7zReD5QiJIrmnSjFDV?=
 =?us-ascii?Q?4/QK6WHJuKIrJn2iHKuOvq5pRapeBhuaizUicwxoHsOh/PNlkcN1qfSYHhHf?=
 =?us-ascii?Q?6ctOnqr6J34QlIT4XnLGx9sxOsS8ZGspLQJmxyffYE87VExN0tu8qRtMBkrF?=
 =?us-ascii?Q?UHAF/ZoSyY/eWAnD88Er1VrnUaJKp6v6ZEYhAHrFag2FVCf3TrhbI/k7Shc6?=
 =?us-ascii?Q?sfe8NODuMfTQwgutbACaRti17anqWAJvInGwzw+aVhCFgfbgfdPgZihK6lyI?=
 =?us-ascii?Q?33+kdjpQk8x8u5tGDnTgxOJRKZd3CAjYbuEdmuJRunodd8vPblIhg6e9NQLq?=
 =?us-ascii?Q?U8ZoCqcTzAI2lIHo6RJcO0O1fCZAEZnHcHSNQi3pxu4icQWcBT7bCA6ssRLN?=
 =?us-ascii?Q?BaRINwmhsRu3ZoAnPEjtC2CqpSELrRy2EYVYp+aecEniMsMqyM4Rl6m+ultK?=
 =?us-ascii?Q?pZNFhEL9XK6ThxH7rsIBfny8shCv9FtTisNoW02oGwABNip8u+D239tCRxxT?=
 =?us-ascii?Q?o1iVt8emyV8tFDg8KEvZxJ1gLouXy/8sYQZf8+4VdXIWdjSpwJZPsA+6c/6F?=
 =?us-ascii?Q?4mTGc1cqCBNF+yS38S/aAkNXTbquussaHL/YYGKkzMjuhBygZfPLoBj6W5nj?=
 =?us-ascii?Q?4TWNjMF7UVz57+fZAlVEacVo+wd18IkkrZ+sc8S/opIyLS19fPzdle0Mtjyg?=
 =?us-ascii?Q?AevC+qtAHd3ifyYq9vJdEqra9htj7B2tOnChJWvuzFHFUgEGsgwhHLuLbtjs?=
 =?us-ascii?Q?uCenpmEisfZB4QiFl7pXksjnXqqJNET1j3cOwwutv2YVpwsdDXaUO23QvdHv?=
 =?us-ascii?Q?O92ap4Pxj5lMQbH1U77k1MYnTN7S2jZjjsA7zZh0upGSjVTkxxBcTGgDHrNc?=
 =?us-ascii?Q?nQn13hEoJZUIYzqRR9HY4E3mantNppgCUbXe64zN7c4d5nOefmqtg0+34SB4?=
 =?us-ascii?Q?YNXNa34bwbiWT49384qIXKES7USGWP76Mdhwturq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d28189-a74b-41a7-8abf-08db7556629d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 08:30:08.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJL5OMPNx2PmHzvfADkK4L2uMqTDmQvTzp1LEqfT5n/DcB3ogPGwjHHb73UFc4Ato0onTQkIx+oGjAWPJ50sLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8266
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 25 Jun 2023 08:30:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12150

On 23.06.23 18:27, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of
>> Jan Kiszka via lists.cip-project.org
>> Sent: Friday, June 23, 2023 8:11 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core 0/3] Enable swupdate targets in re=
producible
>> check
>>
>> On 23.06.23 16:05, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> Hi,
>>>
>>> This following patch series enables the swupdate targets in
>>> reproducible check and enable html output in diffoscope to view the
>>> non-reproducible contents in the browser.
>>
>> Are we reproducible now?? Or is this to resolve the remaining issues so =
that also
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/24 is fix=
ed?
>=20
> SWUpdate targets are not reproducible yet, these patches include swupdate=
 targets in the reproducible check CI,
>=20
> Currently the following files are non-reproducible in swupdate targets:
> Squashfs file (https://cip-project.gitlab.io/-/cip-core/isar-cip-core/-/j=
obs/4529073178/artifacts/cip-core-image-cip-core-bookworm-qemu-amd64.squash=
fs.diffoscope_output.html)
> SWU file (https://cip-project.gitlab.io/-/cip-core/isar-cip-core/-/jobs/4=
529073178/artifacts/cip-core-image-cip-core-bookworm-qemu-amd64.swu.diffosc=
ope_output.html)=20
>=20
> I am working on the above issues.
>=20

Seems like only timestamp problems - sounds doable. Looking forward!

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


