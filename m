Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79055C77B7C
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 08:42:01 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.40])
 by mx.groups.io with SMTP id smtpd.web11.26932.1683621713730264299
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 May 2023 01:41:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uFfYrtB4;
 spf=pass (domain: siemens.com, ip: 40.107.241.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob0cabLz8v+FgN0Ywe2xYVX4fl7MxbSnSCYmVBW8vvpjZfGaKd7aGiChijqXdBqiWTXegbTKdQLME9uW5GbyPtPKCbSJcYU8gbAySHbfjB029oRL+PHaJaew/SLRIhSlfjSU9fCB6O6I22a2CN57HaMMjCeeF8HZr+HLrn0KEQIATrxIkZ1y0KvwFxtqpLF+iozu9hvu81yune6CSK5YZ99we1/YeqWBS1/OXm7gKywFcH1pSR7Mj8ENgnsr7gam/YjFU0+NMk2/BVjE4KyRS/9wCN31S7HA5tF7/khg4cfTNH+A9YPCDwHD/5+zoOcD/Y+oycaTucE/9Wu5PzBYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpKXMmOONu+9jjPlmrUyt/G5ZVKhi7ZCFsrfW+HfGo8=;
 b=V4eoCNEuYPmGRhdjV3bOkbBZRMheuQoTTLAWE4D8eE/SOd5mgauT2/GN9AujhA13/pE8+2XAdzNYcfb0r1zzZ07+0auDlX8RKIBh0DWnb9Pl9ICZLPfXZbWsRa0jr+Vv3PHJQK7AiOmgoZA5khZ9FwdG2gRc01IF+C2hVbuwYI6T0saJqEt44tEuKRfgmOaaIIF/KPrg5RApn2WsDiS6SvxJGY3er9po9R2GlmxfE70wLR8JMxW+bHMF4XN7kiQAB3jJvHDWuhc22bcD+DbgZU44ETUFCGjsC4MnYVPQFwtM+Ge1OdX8671hJ1+wIY4iSAbPdUz7UEpuvMayZC8DSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpKXMmOONu+9jjPlmrUyt/G5ZVKhi7ZCFsrfW+HfGo8=;
 b=uFfYrtB48qJNaWb+58ozkL7Du7DWDX4pl99VjpCtlI14QXP/NqOmKVJWJ2qe5L8cO1o982YiKEqfeb7W7VRhwVEOz50rnhKoM+umAfOAKjsiEGnyr5PDsqAgEPwSc/bnD0O6wYP/fUwQFY5Lx70yeQMJWwFU9gnnXHcjlFy34mssCeDDqvds/8dZjSY9FY2cXfkYaBvUPlD+zCEecsbQfCbwLWPMS0NQtD2zqvu2WnXFM3CdtcFxVohYWy2vVRr3R6zxWGmIuZiK1JXmTvLYjgraiN6H/xIjlOpXPnjtRmzAmem3QUSPmKjbAVS0oasa1OWKPhn6EwpePv81e/r7xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 08:41:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 08:41:50 +0000
Message-ID: <0ff814b1-4238-17d3-6c86-fbcdf9378f81@siemens.com>
Date: Tue, 9 May 2023 10:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core] image_uuid.bbclass: create /etc/osrelease file
 before do_rootfs_finalize
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230508154031.26473-1-venkata.pyla@toshiba-tsip.com>
 <a030f206-30b6-b2b1-5e66-9dfd796e5d5f@siemens.com>
 <39bea4c9-53fc-4ba3-851b-37ff4798f21e@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <39bea4c9-53fc-4ba3-851b-37ff4798f21e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 274755ec-80c5-43c0-ea43-08db50693b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6AvkryS6PE+UZn0eiIIsl8ckv4sTZ8oy4N1hHMjFErc34bwCRuNBthFpjdkuYSZ7xeCDbWW+TB8aBTW4UjyOsV4+BOcGzJRzetDde4mmGFtRixAmqIsLVvRr5CI+mosBoUadM6C43qNYvL6b3X2B0+DwiIhXKJnCj4ewteuh7q+rUXMJsEXXck8zni4oZi+3W1Re1YoQL3KgZeR4bfCvhiuGG9XLwmTWZfVY2/dDeB859LqR5baFuelPtz4GPKN9pShzJayjCObxcpSbveVeU/YxvY1CC9FrjLB6vUTekCDT/5S9kdTXQD0Rkk++OnRUsbe+Fm5diEUUem++6bYIR7Cjzm+0inEd5/Djt7FrKod3snhst3xGjMSGGUDP007os7T7mEsutG1h0r4l+ZVThAOG7PrpIj91Th8gPkE4ZTpmXPmpzyXblVjQ7UwFwagekLlSgxFqY4UsF1rr93MVsUxNlwG3ANHJX87M0nwQB+tK/AJBt8JwLdrjfAoJAcKEWy2S8Mkmflaf3c6d92Xw5SPebt6RFKm4kNfF8AUs/NfzWOvQsfa4BeCrr2dafZOy2EpJSymqypGQP+FIoLJ4CUOv3NQ+JqUGKF07vyxkDAelyFYXYbBiOujwP9/QMFVl0AuP8AxCi7ycWhepOaijKjtDtEdAuEpX9dfH5//VaoSwjYESCqywNfWNfXJrjE+E
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(83380400001)(4326008)(6486002)(478600001)(6666004)(2616005)(6506007)(53546011)(186003)(6512007)(26005)(8676002)(44832011)(2906002)(36756003)(38100700002)(66556008)(66476007)(66946007)(82960400001)(8936002)(41300700001)(5660300002)(316002)(86362001)(31696002)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kRs1MfSZ+UzpwGz8rTQ37lRGL2C+ewqH1KyJaHYU8cbrJHyTtrjLgJZA16df?=
 =?us-ascii?Q?0V+wO1Xw1EMiZ1bcOVnv50OzDfSkx7eXczO0MWEM3+Kfsu/K9/MtvRVK4h6r?=
 =?us-ascii?Q?zVGj56iz2JQkK1EFm3I1TUNJ3MqMSzmtsFxrKos0PL+PgwRlEYZDiX6DpIDW?=
 =?us-ascii?Q?kUgTcxnok+6ESr1HE7H3U/P3i5JbzHGSt7WxkeG2IwSJef63Ut7G6ixqRlgw?=
 =?us-ascii?Q?fPHEcis8VGmjTaYKfYzCUjuUQY0L+4jbBatwyN8OnBNxp9aX6TIikqdFEfBW?=
 =?us-ascii?Q?LCOLPbTevAYLNJu+YCaqHax/X5wpI3LcJYcaq4ojI7+FrAK7QlnGW6MNwvz9?=
 =?us-ascii?Q?xFrMYNKajpC1u9uR4SsQ4ChtfBvo+vwe3LndaXwBnyJaj4NnyUPraMN7/UcI?=
 =?us-ascii?Q?I5RbzdcaZIDOBj2e/Am2nTl6Sd5UFKN7QsjjHe/Nw8UDD9ez9ZtOrKVTi8oZ?=
 =?us-ascii?Q?bCSldQpeKB8QYKPz/9IPto+cnZGRoD29LszMb8g2cpu+HEG9i44GL2DAJwAf?=
 =?us-ascii?Q?Rs1elLyuPlQ6VGXrHJxiF0JMMj8M4kGDJ/uAs1PU20mNqDgP031ilFxywWyk?=
 =?us-ascii?Q?M6QLzddvyAtgs3W/L2oDcTMrwJCUKNOBa3Ioqvunj/uYHDDdmWQiG6icuIaR?=
 =?us-ascii?Q?ubWLLOPZwo1Y/KbiaJhy4CUmA95jcO/cOC9Gz6p5SO6uAF+YXx6LOkGb7vVz?=
 =?us-ascii?Q?KpgZ71K+FEu1IFe+/e+W7h70jCcrS+i5ZLEIPQGI8CbWGEDFo+YDDSTkY7M3?=
 =?us-ascii?Q?KjmbQCwQSbwy5Zg1+MdwBFH4zGM+QH/MBt5EwPPRTy8V6vISaHfeq2b5mZeO?=
 =?us-ascii?Q?zcE5Pj/ltZi/+l16yw3NpoCjVLxP1LZ3ayqAGEXr0fNbzV7g3xiof88iBGMS?=
 =?us-ascii?Q?rQqitRKFfULrITW1MVvb6L31DEMtwJ5ai/NzKFUxAbfcTR4hkgcqX/C5+Egi?=
 =?us-ascii?Q?T8kqykoEi4FJHitfOTrwPE9Hr9XTdRVSwUu53fB25clAX1zdL7jL0Gt5U8Z6?=
 =?us-ascii?Q?mwaDfzGQ0rz2YEulTQI1hLBT0Rd9n7sqQn7eOeH1zAbDS9tjrX3OAj4OoxXT?=
 =?us-ascii?Q?rJQEHrqSzFXZAay0d9qnWYA7BHEddsjDczYu/NX8Vlz8Hp3ZvFXMUCPfACli?=
 =?us-ascii?Q?krYd79IzQutIR4PnSRCHgBSFch0s6Lze05NTqHSYeOlb6ZPJ7M3JWZt9Zq4n?=
 =?us-ascii?Q?jsIvwcRwPnzX2UGJyY+F3gIhQS7Pkxl6TzoN5ghehYJFSG/bw0JsPOlHE0jQ?=
 =?us-ascii?Q?MoC+b/wX45TVwCLG+tTrbk0aRkMCkqZobVfKve0dqWss78Z8oTjkSWsPY3Sp?=
 =?us-ascii?Q?N0xozfBUPBER2IdB+hI9v2K2mKEmEk1pW5cLgqTWTD9cZQ6+h1PH8tIzWWIY?=
 =?us-ascii?Q?iqD95rvA73DZsAFjqgv7OlRsxIYkkZ5czuCR15YhYp5LuYQh3QWUnMOLWA7E?=
 =?us-ascii?Q?a+jsJzwBnnY9r4/iR8V73rK41gpAl02a3Nt1S2k+yJc7/dY9cwpFcEmzdo/m?=
 =?us-ascii?Q?gfIcxm6ZThfKmDZ0vxZO+4Nr6hD7LIVw5BCPs+3/Ns3/39vpsqS2GQHtW0ng?=
 =?us-ascii?Q?ddzAG4W+/ru+Cw/yberA4Xz1cztRNtgxh/EBsOLPmOr95gJiWRbWLLtftRjV?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274755ec-80c5-43c0-ea43-08db50693b39
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 08:41:49.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iMQRspxifM3Mi9JsLPGHdQ+XZOJfAeUpE7dMaEo7l8rNi9tcU3SXkKaKLYWyt9F5wss/nWIJXkIdI3NZq3hSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 08:42:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11424

On 09.05.23 09:22, Gylstorff Quirin wrote:
>=20
>=20
> On 5/9/23 08:21, Jan Kiszka wrote:
>> On 08.05.23 17:40, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> reproducible build with swupdate target is getting failed due to the
>>> `/etc/osrelease` file timestamp is not constant across builds, it is du=
e
>>
>> os-release
>>
>>> to the file is generated after `do_rootfs_finalize` task and the
>>> timestamps of the files are made constant in this task and so move the
>>> task `do_generate_image_uuid` prior to `do_rootfs_finalize`.
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>> =C2=A0 classes/image_uuid.bbclass | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
>>> index 2bd530f..9ffe14d 100644
>>> --- a/classes/image_uuid.bbclass
>>> +++ b/classes/image_uuid.bbclass
>>> @@ -54,4 +54,4 @@ do_generate_image_uuid() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "TARGET_IMAGE_UUID=3D\"${IMAGE_UUID=
}\"" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > "${DEPLOY_DIR_=
IMAGE}/${IMAGE_FULLNAME}.uuid.env"
>>> =C2=A0 }
>>> -addtask generate_image_uuid before do_image after do_rootfs
>>> +addtask generate_image_uuid before do_rootfs_finalize after
>>> do_rootfs_postprocess
>>
>> Looks good to me - Quirin, any concerns?
>=20
> No concerns looks good to me.
>=20

Thanks, patch applied to next.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


