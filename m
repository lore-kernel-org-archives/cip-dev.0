Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7A2CE7A81
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 05:35:38 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.84])
 by mx.groups.io with SMTP id smtpd.web10.54952.1695620134029009378
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Sep 2023 22:35:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=a0ySfSK6;
 spf=pass (domain: siemens.com, ip: 40.107.20.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBDwGi+HuPZfrumxp7EWBKMuGzVckqQcsJEytXvcyVwQfU7ArX5PZw/doNFQ+KBCSE51gEwHC6JFtL1JZ/wZP0y/Bn0bx4ap39svvwk+cZPkXnTHxd4GDO0IuB4WSGy/TY8mVFp2YZ9J/ATERO/PxUENHf7e/5OxagVYul095V8inmEBgbmKrdZ/D3pjUP4GRPPrsRbxzychCXCTzo494hYk14p/DyOKxRSDgI0BLpPlQbLcCdUAx2oHQFtm19hm6c2YtsXfJycQzcDxRm9RgY+KlgpbRY3IBAM8qO9yWcl+WWoWYVfXKoUhNhLaqRQvMaFNbqBE1RImxA3rzbT9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ9BfAS4AUM4c1G4NRlwtgk3yPI4594mheCA0mHUVcQ=;
 b=CGS+0nspVsqOIjU7ALkGwXTWKybDXfs/pWjw2YnHqWmwTz7UFZQrr5OP/g3XKYLGgz9RQGDeGybul1O6zeeHnje0FUMgp5jf0YmH9J4X4h6mxdh62B8ZoKaPMzCMLhTDkDZJzVXZ2mxhBWW4nQbAekkh/1rEJOgzDcLAVvps9rO4u6rH3/Wgut6stSh5wsSJi4DtzbBR+a4Lr/gFuS1yOPlPTtowmpJC2GyNFG2/7ipJukloCncjMlBlxZV0YcVJvSwtbCjWjtqV98IQA8ANOF95qO1AzySxKcnmWCQ8hkwmKS0uOKhQyOGdZkFJIZbX+SJ4MxvGUK/UBEQ9BUtgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ9BfAS4AUM4c1G4NRlwtgk3yPI4594mheCA0mHUVcQ=;
 b=a0ySfSK62/sQSrM5rvkqBsz8JgO0Dfwv147hdBN0Mtt92frF6GaE77S3BpV1MKx+xSbrSoxYglTQvY43gXheFVu6BYj0hdP618BR8wR+JlEkO7ff1yDLxf1d2UkSU0xOSpTU8EAr+mSME+vit2tutRl68Cg6npaRWkGakTBbCy6TiH3q/jj8I6jzc0tMVynR0qHykeWmRXHr4+NYT6x4dyLPK30HMg2fHOZhdEakxck/4Thsw1jewQwg2IEuck3KTrVFxfi3/6bXhC926TTsiLMLd+jasX37/dIqAQ+TgyhumIl6ZjNmvVfjkUrk6h0edOHXhNhDpO1UdpDFB+agPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 05:35:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:35:31 +0000
Message-ID: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
Date: Mon, 25 Sep 2023 07:35:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] dosfstools: Add recipe to build it locally
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230922101245.3219-1-venkata.pyla@toshiba-tsip.com>
 <5a7868c2-edd4-488f-81c2-3bd94944c7ab@siemens.com>
 <OSYPR01MB55429CB5CEC8D326A392DCCCA4FDA@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB55429CB5CEC8D326A392DCCCA4FDA@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2b8523-d020-4a26-957b-08dbbd893b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5f/YonZfmtqQPwBb3ehoZDI6zpOwKpr1mohHN2vX0UPJt9LtGu67Qo8bmdZJ3b064SYOrLngWoMTIjZ2ckwGrQ3w0FUPwAFo3roLeTHVdvKu1enpppm5i51G6JPOzZASsetYbkclAEzWxVfYs0KrNwTl+Onw3YkDs4AADRXRM43TNPO0+7MIM24lQcCJ2ULl2sASmNIdpw7ZCLekNbq9ruTP7Yr6tSIrI8fHl3lx0ObrBGdWjd8YYIUq/+XccFCwF2kZVpNG8agRmB16Iq+Qf8k1XnGbtpytYExsYy8ocgAsiNdsVaCk8JNUJStt1utTlgWcZPTwSWjyuBGf8btuB2yddvByIMWboNNPL3vRidS1PNZ2Q5i28KdqHRVYT8e1EmMmETQgwGs8Cycm//fTWHDk1teuiBOuuMFzK8eIsiSJXMMvMWyPGZVl2Rj8Z4D7bT5jUFvImbEvejLAon3tLacpWt1VgcnuwDeYeve0M7N91ldTgXk4Z+pWl4xgx0ZVJBHaeoR7sqKVDIvtqEjLrQz93xBccPN9fy7pPcmUkYXT+KeQF5D71M3pKVq7Ailu/S04MMU6caatd0sQvIulPgiBeofxGEezeO0MIKc0CMsG/0AhVuDwYEH39OqApPP+ct4JUys4lO1tUpBAZal2p9EWwkCv9ub3URVizEdijgk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(31686004)(6486002)(6506007)(53546011)(6666004)(6512007)(83380400001)(86362001)(2616005)(36756003)(31696002)(38100700002)(82960400001)(5660300002)(4326008)(66946007)(478600001)(8936002)(966005)(26005)(2906002)(44832011)(41300700001)(316002)(66476007)(8676002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aFEIAD7XxdXmGS1N/BLvzNvBYiL+w3xjWpzZ6Z4F7MhZhIm+zz3q3kdO5uQs?=
 =?us-ascii?Q?gMglH8K6QwHrhzamHGq7j0WsWtAyLgGkLLBQrru/G+vH39QiToArLxPhY90q?=
 =?us-ascii?Q?STrzZhX3NNbhHoktrUge3AqrWlnBhPKKfO5PoZ+NehBwGdBS2AXfCsAHxgjy?=
 =?us-ascii?Q?rsLJt8chxc9sm0wq6rs+3xRSesddLXNtgUxKvJag8tTdhMSIbtHJGMVG+9FJ?=
 =?us-ascii?Q?O626Fqc4giy+GyUoRYYzLB/9UINKWBtPolajsWr2C9RKyAF0KUQxmA3Ud1pS?=
 =?us-ascii?Q?IAx9pbvEQ3BvcTH5ifwJQgFHZ+/lDl3qG3h0bsTbkulKhEgKvJQbwIMVryU4?=
 =?us-ascii?Q?gG9IKYFeOirBY8jJQtzXz3NwoaB37fXuwI2aEEuMPl5NzH/T1B1sEIX6Ap82?=
 =?us-ascii?Q?ccetJX5GZfrOi7gyxk7wcWHHfpA9Do2RD61pXi378E4+a/Rnsc8lO8nRLlFZ?=
 =?us-ascii?Q?bDVMSZBnxsKTaLbUmCqdLuVUC9pZ/t568KAWs82DbZRNqxdlFqEkmRpZUwo5?=
 =?us-ascii?Q?7jQows1IAMcXJEaf+yNba5bxoaQqEvxgxR4KS8oS5bKnD0LLWxh5jUKnDimo?=
 =?us-ascii?Q?rJ2QI0xvpePqOeSTOTgYwTv4b1lyikFEsmW/znwRH8AdDPo+KOW/9ympVYy8?=
 =?us-ascii?Q?gW41CiL0om3XoxSyip0cVCzCkSiwbaeANtTXgSNykbzvyAsOlEIQiQuatURZ?=
 =?us-ascii?Q?SMBhHEUJdfEQXQz5Gc64IX79LoXgENHof/x8QYPrh5DqXzg3idOz/oGhYlRQ?=
 =?us-ascii?Q?CAnPLWm3jpnTrJGj/A9J10jnkrPhOVRNiSsEH1E9ObNdpL1sTOyfpfuT+mpF?=
 =?us-ascii?Q?4v0ocQNo1hufHYieoqMAFkcus8uGrJLsFnYPVV19UCp0Z2IW3D4SkoY8CMLe?=
 =?us-ascii?Q?p9RMoYy+4Etz6OkRH7jFzSkAUEgpVO5vhBPfKoCjts9W9kOcpzR5lX9YyoAM?=
 =?us-ascii?Q?tSkBogWaQ2Ym3qPCORnAy3B33NYtJfL9l5n/OSIp0XChWemwnF1inBHcGxi/?=
 =?us-ascii?Q?6xsQ7eOXtvbkBgYjx1HC/7npzF8G+FAUiOB9I8Ok31NHgzyIWLTsafH4Mnbn?=
 =?us-ascii?Q?kBl9ltgulf/L5nzaODfDYP6Ad+ZG1QabQEf7N/O2lXe2sPDi1DTbWKxOGRYu?=
 =?us-ascii?Q?p/fINoql7USenr7G7n/e2BtUmZ3bt+m46ZvZI5e1oxRwNeJjTrEFI5rLYOPK?=
 =?us-ascii?Q?XpqSpJ6WF95QiXPAY5xgMg8+lmr/IZ9Cl4JpZDbkSS25/MUi7ml13NxxBQCW?=
 =?us-ascii?Q?4NZqN3G3EdbbJmDivxZ/e+ioaKWJTQ9sn0DgH21PrQ9861ElStDXzHgRSv08?=
 =?us-ascii?Q?EDTfFvo9gzORKQxNwCD+iMqi+6iZs6VVn+DgODg5h8IFk25b+r6XCjTgyXjs?=
 =?us-ascii?Q?k520rD/kC2yv1BBfvpItPULTBtHh0VQsRvq/p0BMjTbKcpa7k93j9iQgQBRU?=
 =?us-ascii?Q?p7VK4dsZ7gcmxVh7JF1Zf1kLDFIX//HsnL9Pd7QIGtvjcsgT+2PgnuJqshEg?=
 =?us-ascii?Q?FPVFBaokTQTTNgGWDB5VTN4nANGsu1PWGJfzrddvrfc4Nlcia5jDjNm1PKis?=
 =?us-ascii?Q?ZBq5eu5flggiQ2qOh87FCcK9AK01fg5JtBE9+6Q0V7/8r8qJ81pmM1rjV/JL?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b8523-d020-4a26-957b-08dbbd893b4b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 05:35:31.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMSykDLLhaSsHoJZTmARK2irtbDHKGQnEo3ux+qaXLjyKWVQv8Uqsdf6by7STBiI2chaMbJDSNCmG8lXdWyZNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3347
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Sep 2023 05:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13217

On 24.09.23 17:28, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Friday, September 22, 2023 7:56 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core] dosfstools: Add recipe to build it locally
>>
>> On 22.09.23 12:12, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> mkdosfs doesn't generate fat file-systems reproducibly, due to the
>>> reason that the utility mkfs.fat is not honoring the variable
>>> SOURCE_DATE_EPOCH and including build time stamps in the file system
>>> headers, this issue has been fixed in upstream master branch but not
>>> release yet, so building it locally with the patch.
>>>
>>> This local build can be dropped when this patch[1] is available in
>>> Debian releases, this ticket [2] monitors for creating release with
>>> this patch.
>>>
>>> [1]
>>>
>> https://github.com/dosfstools/dosfstools/commit/8da7bc93315cb0c32ad868
>>> f17808468b81fa76ec [2]
>>> https://github.com/dosfstools/dosfstools/issues/179
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>  kas/opt/reproducible.yml                      |   1 +
>>>  .../dosfstools/dosfstools_4.2-1.bb            |  17 ++
>>>  ...ream-fix-for-honoring-SOURCE_DATE_EP.patch | 189
>>> ++++++++++++++++++
>>>  3 files changed, 207 insertions(+)
>>>  create mode 100644 recipes-devtools/dosfstools/dosfstools_4.2-1.bb
>>>  create mode 100644
>>> recipes-devtools/dosfstools/files/0001-patches-Add-upstream-fix-for-ho
>>> noring-SOURCE_DATE_EP.patch
>>>
>>> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml index
>>> 9b56b28..fada232 100644
>>> --- a/kas/opt/reproducible.yml
>>> +++ b/kas/opt/reproducible.yml
>>> @@ -15,3 +15,4 @@ local_conf_header:
>>>    reproducible-builds: |
>>>      SOURCE_DATE_EPOCH :=3D "${@bb.process.run("git -C ${LAYERDIR_cip-
>> core} log -1 --pretty=3D%ct | tr -d '\n'")[0]}"
>>>      WIC_DEPLOY_PARTITIONS =3D "1"
>>> +    IMAGER_BUILD_DEPS +=3D "dosfstools"
>>
>> This will lead to funny effects when also the image requests dosfstools =
and
>> HOST_ARCH, thus PACKAGE_ARCH =3D=3D DISTRO_ARCH: If the package is built
>> early enough, the target image will get our custom version. If it is bui=
lt "too
>> late", the distro version is used. All that would be non-reproducible.
>>
>> I would recommend to declare dosfstools also as dependency of our images
>> (DEPENDS, not IMAGE_INSTALL).
> Does it not same, adding it to IMAGER_BUILD_DEPS +=3D "dosfstools" which =
will eventually add it to the DEPENDS +=3D "${IMAGER_BUILD_DEPS}" in image.=
bbclass thus the package dosfstools will build prior to the installing it t=
o the imag?
>=20
> Correct me if I am wrong.
>=20
> [1] https://github.com/ilbers/isar/blob/05710647db6227be04bd6db95fa4e4000=
b508412/meta/classes/image-tools-extension.bbclass#L12

Indeed - not intuitive, but it happens to work like this already.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


