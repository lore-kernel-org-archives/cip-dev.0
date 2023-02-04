Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84EC636D3
	for <webhook@archiver.kernel.org>; Sat,  4 Feb 2023 06:38:59 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.81])
 by mx.groups.io with SMTP id smtpd.web11.1659.1675492735181406904
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 22:38:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jsWMcmb/;
 spf=pass (domain: siemens.com, ip: 40.107.13.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJRRtSLJrQ+daF6FArAJrKfVwYyiR8R8w3wLQ5mxJFiZkIXVKOsISzEkJiYC/LnjNuYrb/jx3g98QLGPtRfVvZ5t5PEXdDV6lKonaRnkvdbCWLJIPYTzpMkECoBM66fYeDNX0B7wpkphd42I6+iK09wqr2x3GSEqQmzIbc7CGZHdAr6xj0VsDe3AiKMheRjOh/bKCrba3SG1hurxaVitsyBYpgLKsUWgWSjVEQ7/A1fHy2MVo4GBTB2eU5NGUn+Y3i0o1fsyW8GyvG9UyCFg5RIe96DLaHjvq2z+flP4/diamsURaHBnBSE3WyCV3TDhxTVN2Oq1Lnue/y8uhFWU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrk8/x5M6NHtjEG6FUo/D/QONJ/8MXdbzxlgPM2gnRE=;
 b=Hcq7p4Wzaej3kkzJ7fNLZgzDrmgpJy0Jm2KUhgozuTf8go4ON5sEgIRj6//A/yKt35YzqxZgqlpdEK6eqHYkpAs2v4fxljHnoDUaT1uqJdSBdZ6ALAg3gjj19mCjL64FScHCeL55luVFhmLeM/NCwvlTDXxnqQl+cGnudtD+0QiqiLXCofbKSBjcZ4UxaI59NUD1UQEF2zomNP70Ro7o9HgAZ0/4/O49lMhy1EsrfA0qI1bXs1scUlriC/a4LEKBynnG5GowphtxsEvEfqLA2de7dCWvp1dN+AbZE23W/r+l6Tr7xLpb0Sy1QYbaX4V2s5nlPb/n451XTUaBL+akWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrk8/x5M6NHtjEG6FUo/D/QONJ/8MXdbzxlgPM2gnRE=;
 b=jsWMcmb/LNdDIkFzKMaWlYMQ7p/qLc1tI7LW6PkCKgR3Xw81rd9SndoeaDfYkrwCJM8bHZHBSMfskS/gm/qTuFesnmX/zZfERnEoRA3hTjxZRjbkJgPSpPVLz2kc8y5uGOp0DIm6NSK1veP4Q85Coj1YWaK0Q4fGm2W5wa9gzdqKwibiN8bx9lwf2tDjJPaY1j5jNYOR5nvvNYt/6bfK0Gh80TvvrfU1iZhBxAouYTYoOz1Y/YNE27X2jRsag6iW4xVteQTqvrcjq4oFT78EeCNaXINS/4DFjuAGtxy/gIOZVTodJb6DL49OY7hYXicHL24wqImqBG8S2rkBnqHIvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3925.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Sat, 4 Feb
 2023 06:38:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Sat, 4 Feb 2023
 06:38:48 +0000
Message-ID: <5363f417-717d-df5f-c47f-1ac64ec90be0@siemens.com>
Date: Sat, 4 Feb 2023 07:38:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 2/2] conf/distro: Delete
 debian-sid.list
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230203105142.367778-1-Quirin.Gylstorff@siemens.com>
 <20230203105142.367778-3-Quirin.Gylstorff@siemens.com>
 <cf0d1b16-fb3d-454b-5fd6-fa6f33a7ddeb@siemens.com>
 <bfd92d92-fda0-dd5c-45a7-804aee40b0c8@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <bfd92d92-fda0-dd5c-45a7-804aee40b0c8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3925:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc38d1f-79d3-48b4-c3e8-08db067a78dd
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BnRM7/SrZ+R6w6xLhjc1SNSzwA0cIvy7nFGfED0i9Hj7HweiqRZ5kXT/BPB4Wkmcg+vwnIqaYDi5Km1QRxOJJ/IfHysbG/8BMeBD/8a0dcY/V1wPMAfQIetAIN+U5CVJHBPwY2EETW4o+oFTIbt53NAMqtRJd6sNpzAdNdSAZV1WeerUJdWwOYE/Lr0YcMxQX5Yqoy1FuIH1oKumQQaRhtNBusvS8/YVoSHrWnBRiqytkC21uJxAOeEc7fzCDpVgw4mEIyoK0uyWw8nlmmOwqi1Wqq/vrm4dcqeHMLqfy4dp9ZLjOOxtmo8tAEUAn5gQG2yLwMZDuPpm9lX28YHmmd1noGuMaCbz1qdhCy36N5ircfGXQ9YXMeeB+fXUkTmXSKyxqvfDcpLfjWTNmP2CpGgSMNbV7id55VwCVqZBQwjya6gN+w1rvZboZhso4nMM8idmbppIbO0KF9u1QMt8vJtKM7bgXwOgQH8pIyJl3tgnKx5uECEi3A3g3ybOg4i4FOQpfAfIoU6ZG3KO498QdWlTWzbgbOHXzXckmkimrZ5PqZJUtgJUasa8VLGgo6Rvb/KSI26lDdrHH9gQObM6t2PKjQ7LWHcu+4VCdraIlTxDkW9qExN9QxDFG/MLSQDKdUGEPOdWPRatLsHNikGpHfZ+N4wP1DiyxY6yXvL/F3II+IKKrSk0yoL/WSs4rB6NpR77RnvGf/d4nzr7rwEDGOYtv6zMxotvsNYt7CEv2Uc048ndKIa6EjKJ6G2y7cRg4utapMOaZTqkaAFZ4zknZrkyWFfkniIOMCtwM/yFaeiU2gwLLkJaDzqpYiRG5Vqi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(31686004)(36756003)(82960400001)(5660300002)(316002)(83380400001)(2616005)(31696002)(86362001)(2906002)(6512007)(186003)(26005)(478600001)(38100700002)(6486002)(966005)(66476007)(66946007)(66556008)(6506007)(8676002)(44832011)(8936002)(53546011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?08gq73JV+VAN/VL208iyPkFyuCrtnDBqt8C3IXFSNzH1clWtKnwWKY/0hN00?=
 =?us-ascii?Q?1TeB5lA+6sqJic/a1Te3y3Js/fShxfu4y9igc1/jQGyZtgN0CKYDeN08BQ56?=
 =?us-ascii?Q?Kz5OaEigDDiZGNYOzsy9ifCwj690r6m5MgXXM5QVpXD07dU5taN8Vn3DPDqH?=
 =?us-ascii?Q?rNsN/IZna5Fref+Vk0mwxFCivFk5qz8c+Nk2nJscbxhQvGtBLkonyvdIiRWw?=
 =?us-ascii?Q?erdAH255PX55s23mRGZU/t1fVq/SgFADGcDdg7JsOLSltqbinEb5sMWxkwYy?=
 =?us-ascii?Q?NNDeEJxnmJVaDCp30ZVOAGaGzCKB7U89061GkIDUMy8IFwLggRpt2NpI6tLr?=
 =?us-ascii?Q?lMzczyfTCLPuP0KSCkQBAd5D5dtn705PV2wBMdsCWZG48QB1cjhlgWrsg6dp?=
 =?us-ascii?Q?VHbFqUy0DnmFj4aF9r2hKox2n4RIMXLYsmKe0AgXHTz+ytOdNXnG5PQA3p05?=
 =?us-ascii?Q?50+d8Fc1Df+zGQ8dzCOSExqJ+AXU+1rS097+HuWgqsKIb/h7VcH1z+in8zI8?=
 =?us-ascii?Q?+8a/9RqS6Qhf2W29IVTzMrox6pefEDC3Q5JLXKoRP2zNXsvku0vARMlYz6Jh?=
 =?us-ascii?Q?zlNSSehzAxCEWpOUG6EcctZkrgU6PytN3rPysX2OJdEWG1Ta6N9piKmT7Oep?=
 =?us-ascii?Q?Ab54JbdaW3d3a+I6wdV6MLXvEEmmRia1N/TIPOtkWbb+QuqtCS1oVqSDnN4t?=
 =?us-ascii?Q?4uzvA+Q7Rcaxtrk95CMI4qal89PLvAbxbfKQFZrXQcDG0TNWKvvVRvCMAQDu?=
 =?us-ascii?Q?3YuRvvco3mQFcV7cBJJPq9EW+XMGiukYBGqhz3Pn++KEBJy3zanyGg89CWMc?=
 =?us-ascii?Q?KT+zvT2IedgRJrP8id3NtS2o/Ca/0zEAuiGdvz8r7mhJltQnk7O8tqc87Ceh?=
 =?us-ascii?Q?Pdwme34g4gSTg3D9tN0H6C5jyBGWHGlFm2s/JBeb5U0ASTOWBLNPbo6FBdcE?=
 =?us-ascii?Q?P7uul3ajufzPTtftMqPImBr6JkUZRlR4IOU9sMuK6OvFsraiOj9m3AHvSWhD?=
 =?us-ascii?Q?lL4M5gLcABDJ0FUfyUKjiLvPqSNp8hjUDaM70aAsQXPltAxA6XxvvPTOaVW9?=
 =?us-ascii?Q?xmTa3g/9mLqkjktez6oemmSfHpdMIgfp7XNXCYt+VdpQMppq5sJBWfFJXR7r?=
 =?us-ascii?Q?UlPq+zNRlDFDYJxpN5MG0NknkK+BeAs22mL0gv/h5AXnjQq9ah8V3hvjEdbU?=
 =?us-ascii?Q?auzBy8v+jrxEQQtQrddiEmbRSAaRWSPh/VO3B0U0MwJXuOXVto0NtG8OglHd?=
 =?us-ascii?Q?FxoM21dq8yxcmw240DcEjhkjvxYfOOxF6OAvnS+k7EHqBF24YljimhMPhqUU?=
 =?us-ascii?Q?N1F8gjxFPA0DoslVDfP1HtmhEi1ookUF7JgRXSvREtF0pw9Df4oppnjcAmPb?=
 =?us-ascii?Q?9+YSmTwQiUJCms2sQcSxnwHeLmhd82sUsk2YHn3JBG4iYWTl94p3zEr6fsJI?=
 =?us-ascii?Q?B3NNila7JbkeDISGrePSkfOuLxIEdGgsn95Y133GJ0E+GE0ks+IHDQhGUrfU?=
 =?us-ascii?Q?79BCHbfb8w6Lv029O1pk5tnuzrVuI+4bljaL8STiik9UUI6TFjDkRudKldX0?=
 =?us-ascii?Q?+KddHX0xDipLOivguUzPVin8l/a1/mqpqtK/aAJqBK8+RZ2aY4JIdJesoyvs?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc38d1f-79d3-48b4-c3e8-08db067a78dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 06:38:48.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3JUbffQeFIHKWOQ5iLn8wj9/wPpf+0YyVrm0qL7V5ndeqqPUXMa6yuGpYoJaaRiBWR6uqLqBhzww3w6m02bHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3925
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 04 Feb 2023 06:38:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10590

On 03.02.23 19:53, Gylstorff Quirin wrote:
>=20
>=20
> On 2/3/23 12:05, Jan Kiszka wrote:
>> On 03.02.23 11:51, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> As the file is not used delete.
>>>
>>> This is done to avoid infecting other layers with the snapshot version.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 conf/distro/debian-sid.list | 2 --
>>> =C2=A0 1 file changed, 2 deletions(-)
>>> =C2=A0 delete mode 100644 conf/distro/debian-sid.list
>>>
>>> diff --git a/conf/distro/debian-sid.list b/conf/distro/debian-sid.list
>>> deleted file mode 100644
>>> index 46d34d7..0000000
>>> --- a/conf/distro/debian-sid.list
>>> +++ /dev/null
>>> @@ -1,2 +0,0 @@
>>> -deb=C2=A0=C2=A0=C2=A0 [check-valid-until=3Dno]
>>> https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
>>> -deb-src=C2=A0=C2=A0=C2=A0 [check-valid-until=3Dno]
>>> https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
>>
>> This is wrong. v2 renamed it but forgot to adjust the user of it. That
>> was what my question should have suggested.
>>
>=20
> Was this every used and what is the usecase?

HOST_DISTRO_APT_SOURCES

Jan

>=20
> Even ISAR has no offical sid distro meta/conf/distro/debian-common.conf
> sets DISTRO_APT_SOURCE with default assignment:
> ```DISTRO_APT_SOURCES ?=3D
> "conf/distro/${BASE_DISTRO}-${BASE_DISTRO_CODENAME}.list"
>=20
> ``` [1]
> Which is overriden by meta/conf/distro/debian-sid-ports.conf with
> ```
> DISTRO_APT_SOURCES =3D
> "conf/distro/debian-${BASE_DISTRO_CODENAME}-ports.list"
>=20
> ```[2]
>=20
> [1]:
> https://github.com/ilbers/isar/blob/73f0cc16ca50f1102084851b1bc0f2d59925c=
9ad/meta/conf/distro/debian-common.conf#L11
>=20
> [2]:https://github.com/ilbers/isar/blob/73f0cc16ca50f1102084851b1bc0f2d59=
925c9ad/meta/conf/distro/debian-sid-ports.conf#L16
>=20
> Quirin
>=20
>=20
>> Jan
>>

--=20
Siemens AG, Technology
Competence Center Embedded Linux


