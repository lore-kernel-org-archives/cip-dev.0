Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22411C43217
	for <webhook@archiver.kernel.org>; Tue, 24 May 2022 16:04:18 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.43])
 by mx.groups.io with SMTP id smtpd.web12.11369.1653408251311497294
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 May 2022 09:04:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=CxwYzl9x;
 spf=pass (domain: siemens.com, ip: 40.107.0.43,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGqbp5K2qRFa1hahbAZmOL+9l9aH8akLTzN2eI6RgS1g6e9d+Ry5tJD8S5mRzRkDEjEq9b9C5XDoWea7vHUb51CBrI0NkAxL0n81LALw8tVl5nThWpAKmYSp47lhnE8jPidniw1vknjpOF5HIysRwL8tkPyfyno+h4qThpDgKC4KEsgXn1XO/3YnXxjI9ikbsRDIdmGBLEQFkHIh1kbP30Uew56xXbYGaVL/8H5RIQGSID8YEAcBN4MjVd7HBfmqFfQfYgTkkD4WiDA3x+ci1m+qw3R5e8nnd6oI+VUUcIZpN/2H1leKBW1dfu/DL0h3ASHxOkTgHhIbqrfOGq7p1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/74cvH67063b7p6UID+2L5nYyveCEoFcf5vUVT7RQv0=;
 b=kJENp5bBafSsDX1Z9QqfrRJsUwhumd/udTibEoZpBmZGBnfUlyKqHN07GVIcLHaYTaTRMIOLflpEF6ry5qppwDRzIwHOpxHj3nBgZuKX+iW3fyh06XjVdzAplIU6seRZgx6Pc8mT+swn2gHpvP3hym3LwIlP936zmR4zqxI9a7yr5HXe9i1L5/kpmfVHAsWYa4iodzaNaLdkFqZFGhNFhsnKUtg+OX2QIXo+JWZzQdEyiCJcamXErvg+hNdEpOylIn7/2sbsb8wNDslkhMOUv0X6ykQbFbyPk2km8DNPjXOgEqCnFm/lAklR/axj1EeTfDgBZFlC7z07idmxbCXOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/74cvH67063b7p6UID+2L5nYyveCEoFcf5vUVT7RQv0=;
 b=CxwYzl9xsbJb2B/+pFuNhGsTOpm70bPy0s6nvrJ/eRUOQtGca/Cswvos6mNzzoHmh124FGW5E+Uv0xzkbxtYuCxW/w+30D5DlTxrlNsiZSrXq/4u/TlD8iOJqKGFdd2E0/BvwDwerWY4CvynbgjWh8VVXJ/3zrWnFa0aYm7/X7Ul6Guf1mMCz6CSJ2VToUehrKbY3rPFPV81JK/a6CbH1QGT3MuZ7hGDB8LnBgWgIzJMqNx+VAmmgObanj+NHr+TVaizFZXLT00sRb5rZF4a2VyPywyFTN8luLKjDEhLfXimCB189a3m64lUpghRlOw+OslsZZz1dWCsyguLoOhe7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM0PR10MB3170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 16:04:08 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 16:04:08 +0000
Message-ID: <b696c777-be38-12db-8647-02927169c26a@siemens.com>
Date: Tue, 24 May 2022 18:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard-efi: Use correct
 search path for the efibinary
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
 <8827c44a-366e-59b3-8062-d2d4b1dd47af@siemens.com>
 <17b20d92-af97-5598-8733-f9c625414394@siemens.com>
 <9cadf05d-a3ad-687c-9fd8-b3715173f2d7@siemens.com>
 <17b1a6c1-d06d-90ac-231a-e9226b28d143@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <17b1a6c1-d06d-90ac-231a-e9226b28d143@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P195CA0060.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::37) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6575fcd1-ba03-43be-9bbd-08da3d9f08b6
X-MS-TrafficTypeDiagnostic: AM0PR10MB3170:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB3170C742374A38C68AE0ED4981D79@AM0PR10MB3170.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cUwKqbE1P5PDbcSzYeVoH49oiFLPRj2qEzB855tcSrQ5XyScsP3mCZ3OiF+/z0xbkhqbn77uu5ganhj+Cwu09m4AUhixTfpAE0SA76uEtvmT7Pqwi+Ngc/f1juqNjy3L3AJb+A0nb5VBMePGpA6EcjHXp5S/8cN8QQwZ+zrWx/WrKvaCOOUQm4gGjH8pUGxqgpT/7UPbqvx4M1ctasuYUow0zNnuOhddgL7uuYu0UrVtaoeGnlQyP8Pzud7JMiKRHfGEbAMwkKDY+QiCDRj4O14O+rQTfSMLXzlX17gz7ApAudShTDUGHLd0eLVeK3Lk3kRFY1wM6dFbeUMvbcJEAB1rp6ODhSLclQFbK4XOguKedxucRAIz3QsWnhc2jszxIlaZ4d9KVYSBI7EjVeKFOoH1kWx+KsS9YLrI6Jtx21nPOWI5yJPfXBAZTI+hweZu7NMyZlFXHyrVeEJ6l35hD/M0tnMNpuXgC2YfQ38RPsiwyTe+MA3vJ5lEQDIHmBVULjg/Jn7ctgPlGFj1VthHsQ9nToa3TGaxge63nXrrAWOYCt2hxNr6Seo4stqoSpOsxvEJ2oc92v5FoStiGk79/QDaqWyyi4taVv9zzqpYqHy18XgjroUqu/GXmUdzaYR4FnDT/lpxj0BJp+zVXcZKu5bOauDHpJe5H+NYT0ryuY5cAsqCwBNMdDaqAlPlvJspX1kGeh3FIxul8+ITcYFRI4RiBmhG110az9T3oz7rTN5U9gJrj2hYTNfx1IltgStL9txjDb7USHjL1f4BVLhxqVuIh9pKoqVkBWfuzI47kCVPt7bEJpfwnePapNQBnGtOUV5h0RO6rt7kjW0WZXp+uCiy+JYd9GFJl5FPJVsJKuc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(8676002)(2906002)(53546011)(6506007)(8936002)(31686004)(38100700002)(31696002)(186003)(6512007)(6666004)(36756003)(83380400001)(2616005)(66946007)(66476007)(66556008)(6486002)(316002)(86362001)(36916002)(5660300002)(82960400001)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a9PhgWonWCGPnjhnEUx7vdPUoXbEWqgpzuuiBDKXWxmR34zrKGD4hgVQiSj3?=
 =?us-ascii?Q?lwzrBiZIxwTld5DDSAyw09Xwghk/9+LJVR/kfmdZ+7xMl3tQE3e4iB6rTOwA?=
 =?us-ascii?Q?i0Cb3fl35Hgeyg1kOM8/u8U9Yc8Qa0DjcQ3GFg89+JYHk/vgCNZxICh3tjZE?=
 =?us-ascii?Q?Y0fpEt8R8GmH9/ccGxQheVWZY/RpfDotmmore16YQ2fTtVe6QFRj4WtWNHrd?=
 =?us-ascii?Q?2wqcsIX3+yUaA/3qFCtbu0lFsY3Ya7VJ2djg01TDlF/PAoSOsATrn3qyfcjF?=
 =?us-ascii?Q?xImyzC8J1UliTQAZ0kOpC1bp92ASkPgfI4Cp/RExVWfUG8nOXJ0hDHD+q3sN?=
 =?us-ascii?Q?E6JTpVQsGhbMBhCyskNn/C9L220iqFm3DIlm5ew12SDWHMOBL/ocXVzoPn4M?=
 =?us-ascii?Q?OWnAaEMZjZVD/mpIy/qO1I7L5kX0/HufaigVPkMAlKd/0/3BhzNcIJCmjQ0W?=
 =?us-ascii?Q?sLUx1TRkJpU2XMxix72qA99eCUoTs9ELvC3C6/ojflC3WlnTBdCcPE1SDDIr?=
 =?us-ascii?Q?Yhh3KysKjIXtNh1lnybR9u4WX3BGViA/loP6rqFDYIG2Tog0whJy1AJzBzqq?=
 =?us-ascii?Q?l+gI7JN1PiFFA44d6kG6E7D+L244Aaa8F06yBXRZ2JCLv+I5i30dft60pXHQ?=
 =?us-ascii?Q?HbDsG7MDCK8hAxRIBSziG8m8C+8H48Yu+/TQ+5x7h9U1DUL+LTIoSH0YPrWG?=
 =?us-ascii?Q?MZUK4JZ9q0WRxdTkWlGWdB/bJLkhhwZ7xgAUh/VO7hC+gwGgK0Rl3ouZ8gTt?=
 =?us-ascii?Q?NjKzImIN/iDCMF3BIY6jDL4ph0YWA/8xfeTQNru3dfLvEk9b+NRMcYCxdRk9?=
 =?us-ascii?Q?Wx9JAw5yHMwwYeYraLTDfpo6Rn7tLOnJumGAgXe9tCfanWpFW/jHmbbArvZ4?=
 =?us-ascii?Q?KOmnmTypNkvFrTwvNYDbPx+8FsXQuxlVjAJAUJEDC58HY3NN1UKPIrvXOD4N?=
 =?us-ascii?Q?kyeXo77w8h3b6/5Avk3q+M3UvIxzVuvozdgTCQkb9hr7JtaCN4bucv+6tcal?=
 =?us-ascii?Q?XxO+dsWfzMh3G3Jb2qAR+nZAyYnMS1K4uBaCXwDYmBAxpCof62Mj1O+UaA9d?=
 =?us-ascii?Q?bwJ1FKmiyuS/T7g2TgZJHI/6TpbCg/uhGVB/8OcCskXMgaH+h1lEdbd+yVQm?=
 =?us-ascii?Q?9OzmAniNe8OQmXW6fmoUe6dMyJ/OWLcUF6YTIIlAH3yYHNC8qGStzUhu45Dx?=
 =?us-ascii?Q?ZgTRhUIAIn8Zg/i49FzBRlDHWgRZLnUk9xT3oaQ12PzkT2PrD2CJhgU56MqU?=
 =?us-ascii?Q?WUTublbA3A8bo2YtgF6UNPp4+rt6HcFtxogfrxO071vAo1eE1P/NCEB2w/E7?=
 =?us-ascii?Q?LfKM4KHrcfhiwwcU4YtkDrvhPa/86eJrl6IVEvM9XY8f9aB3ageWJYVDfnyC?=
 =?us-ascii?Q?ByQir1ypVCzq5oDtwevgKbb9N9Zi+NfPZIRJ64oqfLdyBGmt4BdnvuF4fqmz?=
 =?us-ascii?Q?UoQU3HrqtHMpLWpcNh0+vJ6KENMsLWvCeWSP/NToUKq03x9TuLEXgu4LKf6z?=
 =?us-ascii?Q?itVozBTGCuf/1W3RvjLTc62RExgwo6cWiV9gNRUkTIf7LoET2PK8BsuyJPD2?=
 =?us-ascii?Q?o37sHvIu5+nQCwiv6MKZWw6YtTpqxp+h69EDG+Gf1sNV09LVBwe9H28UlCyn?=
 =?us-ascii?Q?+WBkTMEMmbEQTSubdkfdJcjjBqkZlozjCw5tCY/4SuhZe0MTq/pmoCgnr9v5?=
 =?us-ascii?Q?3jzWCipxcg7cVTv27MHU6pExN7+O1cegUPOqJfjGWz5VKbVfOiHNywD2pMfd?=
 =?us-ascii?Q?bJIubhm41gSFslACC3jWaMsVSlkxAW5FimMIUMDIbJnbHWRS0xfCqrSAFplg?=
X-MS-Exchange-AntiSpam-MessageData-1: WxwDofPi01Sgo4Tqzbj6YVY+zmv7vw5eAxw=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6575fcd1-ba03-43be-9bbd-08da3d9f08b6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 16:04:08.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 PUCtakduuDzZ6SlA0O6rUJxEZNBFVj6TmcC5UYTk7plsl7Cp+DCUb1kG37V/VXR3L1YI38jR2MpjLOsjIUpSk/XmAzsKoFFzFVWXoh0foS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 May 2022 16:04:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8434



On 5/24/22 17:50, Jan Kiszka wrote:
> On 24.05.22 17:38, Gylstorff Quirin wrote:
>>
>>
>> On 5/24/22 17:23, Quirin Gylstorff via lists.cip-project.org wrote:
>>>
>>>
>>> On 5/24/22 17:07, Jan Kiszka wrote:
>>>> On 24.05.22 16:57, Quirin Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> This fixes the build error:
>>>>> ```
>>>>> ERROR: _exec_cmd: cp /usr/share/efibootguard/efibootguardx64.efi
>>>>> /tmp/tmp.1Y4utA1zC2/sentron-product-sentron-sentron.wic/tmp.wic.ampna=
wp6/bootx64.efi
>>>>> returned '1' instead of 0
>>>>> output: cp: cannot stat
>>>>> '/usr/share/efibootguard/efibootguardx64.efi': No such file or
>>>>> directory
>>>>> ```
>>>>>
>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> ---
>>>>>  =C2=A0 scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 ++++--
>>>>>  =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>> index e1411cb..a01e484 100644
>>>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>> @@ -59,8 +59,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_arch =
=3D get_bitbake_var("DISTRO_ARCH")
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>>>> "/usr/share/efibootguard/efibootguard{}.efi".format(
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
istro_to_efi_arch[distro_arch])
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootfs_path =3D rootfs_di=
r.get('ROOTFS_DIR')
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>>>> "{rootfs_path}/usr/share/efibootguard/efibootguard{efiarch}.efi".form=
at(
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
ootfs_path=3Drootfs_path,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
fiarch=3Ddistro_to_efi_arch[distro_arch])
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_rootfs_d=
ir =3D "%s/disk/%s.%s" % (cr_workdir,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.label,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.lineno)
>>>>
>>>> Makes sense in first sight - but why did it work so far? Or did I miss
>>>> to test one of the two cases (signed/unsigned)? Did you test both?
>>>>
>>>> Jan
>>>>
>>> I am still try to find the reason why it work in isar-cip-core. The
>>> error occured in a downstream project.
>>
>> In isar-cip-core the error never occured as we install `efibootguard`
>> as a dependency for wic[1].
>>
>> efibootguard-boot uses the same logic[2] to access the kernel stub.
>>
>>
>> We should decide which is the correct way. I would prefer that we take
>> both stubs from the buildchroot.
>>
>=20
> Yes, the preferred source for bootloader artifacts should be the
> buildchroot and NOT that target image. We are currently installing more
> on the target as practically needed. If that should ever change, things
> shouldn't break here at plugin level.
>=20
> Jan
>=20
>> [1]:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/kas/=
opt/efibootguard.yml#L24
>>
>> [2]:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scri=
pts/lib/wic/plugins/source/efibootguard-boot.py#L190
>>
>> Quirin
>=20


Should we move or reuse the files from salsa[3]? There the binaries are=20
part of the dev package[4].

[3]: https://salsa.debian.org/debian/efibootguard/
[4]:=20
https://salsa.debian.org/debian/efibootguard/-/blob/master/debian/libebgenv=
-dev.install

Quirin

