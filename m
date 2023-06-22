Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6917EB64DA
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 14:36:37 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.74])
 by mx.groups.io with SMTP id smtpd.web10.13001.1687444592644361800
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jun 2023 07:36:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uOPhMPkT;
 spf=pass (domain: siemens.com, ip: 40.107.6.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWJVTJavNnczpcBgbIyw6n0oINCstP+c3ujRpZbxSdztpeZZ78J/lkHQfO5O3N7bcJYxuKJHsT/GjQae8nqv5DUcVrkfxH16g3X/zEIlsT/RErYZSEmWmAwbOUtjkLRkjAIYdRmk80cwBTNM6h4kmsPrv/gyTe2SmvuNzbKbpUJtbfnpJc5/ueUNWJmCnpixMP3kEO7Syup73VmwHRi+ZKDIsy+hDVQcM6pQcH0O4+csXyuXu8MaDpda96m5Czz/6meMmww9ceLiwY24WsvlN8wTOBb2nFDPKiUGh/ui4sBygic7zbN0qXCp1FWi2ce4TG/HlpLyJCxwVR8FupO/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAaG1HaPKPYQ6OJB/df3PeLggvj67dfbO3ORAdktCeY=;
 b=mEtwnEi1ayYTfEcTcNqpkTSrn2ou393JXfTjRGUnx2S+iSigddkqbe6+SdkTpC7Q8RyztBObGkSMTRlRh7kkuZ/j4AC+SEDjAQSVMYto+e04AAKlszfwoWB/j3PfIUAhDvx9vPka0S9usNk22sG5qhy+gwi6BKstCK6VG4CDaDjbFbDuju/km7tnGE+vAw/3zVZF7ECgAir1dsOutuLD1CaN9RAt4TKGt+QosQS/nVLddJjyz9ScOS+cvQ7oyCy5wp0d4y8ZpuVo8H7Yem0QiQHMQSfZRDLQgHXeH0xeQDnAbzvfYoNx0CuZdSGPYv0rxDpefO6hf/QXA46JYW2IHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAaG1HaPKPYQ6OJB/df3PeLggvj67dfbO3ORAdktCeY=;
 b=uOPhMPkTaQgj+P6QvjVnf7/eEjqG8W2n85XnHHYvn7cgwU4MCWZ/QlRTxVIUu7Wb2GTvAb49UxhKRCtxQtyb5RkIvk/ZBbYg5u6rvB3d10atHzlhgIqvkwhkH1gf7kMtXmZlhE5NmPiF/Bq8mufPWDMkiIYWngIirv927SdxJv8zdLJKA2TlppKrLyf2MJGmwpBe6+6YCj18idtUZpYx7BC69H1MHDqJgzBiY6om3E+mRBv9FbJtr+VLkUpFlz4YWZz9Q7AujZUqze1ddcfQfYtrWAHilz6DhFnKaAnY2usgPxznxtbQ1C7G3D6lyGoiVd1N0CxPNUIRUwWRBF7zmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3253.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:36:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 14:36:30 +0000
Message-ID: <7f1a1f46-a4aa-21a9-9419-89fd820712e2@siemens.com>
Date: Thu, 22 Jun 2023 16:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core] kas-cip.yml: Update isar reference
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230620135657.4585-1-venkata.pyla@toshiba-tsip.com>
 <ab761cf3-2792-b05d-635a-fd5ff5a7991c@siemens.com>
 <OSYPR01MB5542073E3F04E9344EBD420EA45DA@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542073E3F04E9344EBD420EA45DA@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3253:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db0103e-0d6a-492c-373c-08db732e1165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MbCXTMAPH2um1+K5StRi6RTokZSDc0ZvAZeMsPcCtSNfwodEHMNI7jXMm+6PUTCP4Fy3hDksLqKHlfDLIDUJmBD9gjPAuSBKgp1LWeMvbNiDAeZPO6R3JDy1IvIjpqGRtgk+F4HU0v7JoCWqcUu4ICTJE5+aO32ZFyxdJKaDwa9J3y4M4VznburkVBqOJ4CybCrWSwYd97Pj/DFkfvTI7Kcj3sJM132PZv1VJMD89cN3/5bjNDXpP9ok9JRKLhsWLVLCWndjL+E+3xK9HvK3QOhdrCkJpGiDbDGh3y4lbC1zF0td3u4AGMZANiXUvmT7blnfrmmKjbzeOJ+FwmdBNKew/Xm9BfNg5BEC2LHd02Rtz6aDsL5aBdWGcQteGDFBFeJqk1BM2bAJ2aJsXhe5ia46T4y+RTC3U9Yxk68QvU587DYK+KeuWW+KtCP3eUA9PA6S3orw0K/REgpyA+/qVxeuaByDBKF4wDilYtxKMMf6KNifYtg+ZTAe+LCXHFSBgrAgljNY+DSgUpTH7/P8ZYSzrPL9nnnPWAwdG481kfc911SvSLZDCNdscGTC1FGdHOLyClPHPDLFqGkoNWl1PpsErq6UT+5n4LbmuYHQmluggMKhQLOZTodtY/7cpPUkVZkiVpfqu2tHlzO43pg6Kg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(4326008)(6666004)(966005)(82960400001)(26005)(186003)(36756003)(2906002)(31686004)(31696002)(86362001)(2616005)(316002)(44832011)(8936002)(66946007)(66476007)(66556008)(5660300002)(478600001)(6486002)(6506007)(53546011)(15650500001)(83380400001)(41300700001)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7Gw9kDGelTOOEFwXr13+U1rsUU98Ux3OlQXi0vqopeYDaLxPLOKWWij0ZOND?=
 =?us-ascii?Q?g/HCLUaIdWAA/FKIC4woOMKZfXUJ5nNIzohYKH6KHsgpfM4qBNr9+TYi85Bq?=
 =?us-ascii?Q?hcDkBUbQal1Nb9lHJ70rGEi1nOS0tfZqLn9yKE0FqJ2fY13srPvlzB9kSHO8?=
 =?us-ascii?Q?mqlP412bqwvhpSZW9fm2s6g6U3FY3w7VspyY0DD+H7h0ARVvdcZ0NkJnHBGb?=
 =?us-ascii?Q?JC6xCke75CIecK/cg1n3d38QbVROc9N9/SUgn4zHogwk7rkXrY1JQJA0h06D?=
 =?us-ascii?Q?jLuuMW6uIQ4SmuBVJTbanTjZG7pKCDn9mTEmVz79Epa/n4v3J3XpMsQ1l4NN?=
 =?us-ascii?Q?PGVJ+Gnvwu+L9laZBNuL0oQsaVkWdITionn/ztmOB2ekI144KeJrlGT+SsTf?=
 =?us-ascii?Q?mqegIj/JBKjuGF3BZIQ9pVX76eMA21y5NoRi+r4VTloR/DlpNN8SXFdrUBA5?=
 =?us-ascii?Q?3OKNyIjRxZA2umf7SYpcex8HJbAHmq6oL4AgacSMpYuQ94Q7CaICYuC3a6Sg?=
 =?us-ascii?Q?f07dtaW1jDEoXmlu0agkcR+heCqXgSVl8vz+8+QK0z6jb05xfREeSr6IBWCG?=
 =?us-ascii?Q?dYVfrQOyV5z9kU9UoOllnxIZEAwZY1h3W8rE64unfGuhINrI5nd48B7kjPov?=
 =?us-ascii?Q?1hWQl53DcwGvodunwx84jTe3bSZzdU1ozb2Uyeoadg5EV764a+HV8s6V67Xj?=
 =?us-ascii?Q?thpa6L1YOhADy8MW2ylbB9hslUa63HRBBZZIBOhRjsaQdLpsc8OFPcDZn0Mc?=
 =?us-ascii?Q?2NGm8Su9rOpr69AehESOLutMewiG72NSWrRfQk7fU1dZBTqxVul0Kgo1pQ+z?=
 =?us-ascii?Q?QNV6pttIu8syKCF/b5a4IyBw5Sw/RS6zznfilkRWXSoMUHyDHTd2TJKTdktD?=
 =?us-ascii?Q?a+85rjt5KQAQNMEFLQYeH3cOSVuCUq0afG+7eg3hX32aTnBjCucGjFdQgT1O?=
 =?us-ascii?Q?gF/6YDUr/uU/am39HQXuI9rRUycSoxrnFngIDiujs3nP/2zk0iGYMLri2GHQ?=
 =?us-ascii?Q?mMNMPiUKiObr7MFw23SeCmtx0RpodIGEPPU8AadCcaP3GHmFjLZyND22Df8t?=
 =?us-ascii?Q?wo6+N35cibrkUqjoZvPCHG1fwMPDfPZrbTFWvjOnxYxGBAdxrwEK/JngFUYa?=
 =?us-ascii?Q?ZgykAsSxTgnPzEOCTsS115TPg6wm0RzB/a6PJsxrp+SK5+YFbEdcjlOHBnLt?=
 =?us-ascii?Q?Zoo1qy+exMc4CEo107UIowSiqwUUWpIs9dFKPYFJ+IBW0ktRZevXMFWQMQE2?=
 =?us-ascii?Q?qg8EYmo4Rapzw/7sDvQbQhEDX41Q+MKGhyLOqsvAl0vHuCasNu+wC3nEAgxf?=
 =?us-ascii?Q?mFbrvvS9Fm9+k/82Ah3t4tt29HbrCw/Qy5uP8DnlQMMJSGUfqUtazymBRVK/?=
 =?us-ascii?Q?KKO7gycIIsd6VG7ZSqDOdaxGGcje3n64wrIpCxg86zKXZX7yLYWPbHIdJmeh?=
 =?us-ascii?Q?K+YVuj8vrQxHDnvOs1froTZlhSas9zwO/IdJLv+8AYVRMJAahxGhxs3n4BoA?=
 =?us-ascii?Q?waY+bfpMgXneM6oWAPwyPB3rJQvw+I9nkv5adJXCMTomZHCBNgKDCz6Z997+?=
 =?us-ascii?Q?6xcGwcTlDaMCWha3eZkMZ8cSJLHjby9zyu5mpjt7x16KOUkH9BShz00oe/9l?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db0103e-0d6a-492c-373c-08db732e1165
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:36:30.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjUPd1Et/oIE7+lOH1ymoWH0imR3ud8wM/4LlLFd6+k3+MBLxsTidfvQS/WU17M30XOL3VSRJcY5zLKgi3zOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3253
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 14:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12132

On 21.06.23 06:38, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, June 20, 2023 10:34 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core] kas-cip.yml: Update isar reference
>>
>> On 20.06.23 15:56, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> To bring the reproducible build issue fixes from the upstream
>>>  e.g.: vmlinux files are not reproducible in case of arm architectures
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>  kas-cip.yml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kas-cip.yml b/kas-cip.yml index b6a3ded..454fe04 100644
>>> --- a/kas-cip.yml
>>> +++ b/kas-cip.yml
>>> @@ -22,7 +22,7 @@ repos:
>>>
>>>    isar:
>>>      url: https://github.com/ilbers/isar.git
>>> -    refspec: f95f69d3b83cc28976ef81eeefb5ec5dd17e544f
>>> +    refspec: d2b961746be788f0f35f8297ed3a8d2292704a4c
>>>      layers:
>>>        meta:
>>>
>>
>> Is this urgent to move on? Or should we wait for the Isar fix [1] to mov=
e to
>> master or even beyond (there are some changes coming for OP-TEE & Co.)?
> Not urgent, we can wait for it.
>=20
> You can ignore the patch from me, thanks for the information.
>=20

FYI: [1] is merged now. OP-TEE patches are circling on the list, but I
would expect them to be there a bit longer (1-2 weeks) for testing
purposes. So, feel free to propose an update earlier.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


