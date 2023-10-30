Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC879C4332F
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 08:08:00 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.73])
 by mx.groups.io with SMTP id smtpd.web10.143977.1698653272294235395
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Oct 2023 01:07:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qL942B39;
 spf=pass (domain: siemens.com, ip: 40.107.20.73, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIKix+B1UWFtdgRbib473JXvRCRn+mAqe9E6mTPD/g52IE5KDvGgMePlGb9nvAAy7z0UM2MoqKqqhhabMQT1kYbECd0HaRtFHJykEYjFgnafMFkIdwoim28O9eTgiD1pMpHnGmtkj4H+bzf1WBk+Cgb7ZnfSiTsiiLjExH/DJGFpo9hzHuIBeVyh+jo/avxN1IzdSc9XWZMvweyFNSO4g+kkDIZp3KnyiDvF/u8mfuvLyY618x3MO8nBwVY7Cts2KQvEiHO5snQPjtKp5hiziQGSqWdvyB2fbbotV0l50pvJ9rx3inVZHb00ETvwMGApUPCfohD5eBznNk9eeQJWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFCmbOCGY+RlT0Ct3V/WaRwYgx0cUYG9BD6T+NZ6AV4=;
 b=iJosmxXgJqAFGRN3y7ia2Wkh/1v4DoqAVaZGh8MYnJBIEaEOrggfNVQ6ZlPiUYoiOEeW7zhysEGnfQYNdcdIbsqE1fnEZxfrvPk3uUeU3+m0iANzWJ+6txEBbARqEYGfkcQe7n6eYG4r4bVVTRxtohgTfUw/xCWqIGNhEvmuBHmf1CHe+TiZFT1xxn3caE7XbmQQ1PGKRMSSh6bqLT7+3Dhe9kjw4NcL3QS8V77pY0IRiRd8g2ws+BwZJzfvg/a1HqB0kZbqU0sJKFkYTWXstRvhj5vK0BJSGkRf/pDQVkUZrqIpIOLPEhLxBcughY37kh4OnxTq57MrLCERuy3Gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFCmbOCGY+RlT0Ct3V/WaRwYgx0cUYG9BD6T+NZ6AV4=;
 b=qL942B39Q5Jx3zXnY/czy6wHuixr2wr66nYx3G3CE4PSU+8NI3aHp9I7KETZlMCLRLD0uo0bTJhnEwqMQsFxDj4QkR6l3v4/+lbT865RYdEGVx0AWlSmFWhiEP0ky2n8q/xtaNk0rVHNJDV7AUhPYS1BASwZjwJoyF0HOmkUjsFE7QjCxEeqCw94wlcKslK2Fvd+XoaSLhMXioDtgFYzjxVdFN4I5mt2Q2PGMkU7i1iaHBVkiNNWtnLgogOviQ4Shy32gggM7Wqi/XBh8hwUwEcaxAw4NE2X0KPlkRwAKMpuBhXFZs/0ZIERzXA/yfPH9qj72V8gpZxxaM9u2+9uFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB6361.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:537::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 08:07:48 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 08:07:48 +0000
Message-ID: <14d150b4-1faf-4691-a051-4eed1ae6ea85@siemens.com>
Date: Mon, 30 Oct 2023 09:07:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: Move
 packages to security-customization
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
 <20231023150243.3990309-8-Quirin.Gylstorff@siemens.com>
 <OS3PR01MB68561590E077CB11799AA56FA4DDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
 <97ee33c6-7bcc-4a76-ae24-40dcda09cdab@siemens.com>
 <OS3PR01MB68567E027D32D81D48281B86A4A3A@OS3PR01MB6856.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <OS3PR01MB68567E027D32D81D48281B86A4A3A@OS3PR01MB6856.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccf2fe4-d760-4175-4b04-08dbd91f4e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TH8Uko6LZweOG+MwFA76ISelT+AMkC1rLZvUG/SmF64nUN0bAtQAuaV1j88R0PRo7S74UcSnwpk9FdWZIOazffD4IcaYc8RgMJtb2FFMWxUC1OyyK0Wzc/WMqcCFXoolf2tUx3l+meizBQMSwT6pQ8BsICgHHX0Q9Ca+X+OJ0xPfUo7xKyWMW4SXpAfMt8V/E98bCYqUkhAUG6AjzYB0cyKOGfbkwFG3VXWSUKHu9YhjyOzMWyWYBiob2b41idYDe64XHlPWuVjPcuZapgAhmuSZ+VqhiTU9/X4B+Xxko8uiQQhPNK1O0QMT6eM0FBUm555iE7sEPboSyDTYYlo+PDJzJtLQvnaaBzjBfLmpPuzGhL3WYcqCod9e1zir3UQ4I31E10OIIJVFsVRkfSGzGUQwF9rf/KrijahQou6HkGnWG6fSiw9lfreWvMkXUU/Lm9BNVcNO5YxoBP4hecVlJND2PQsmr3VKu3TDte1NzUiXjd1kYQut8qY30579PFpibihwf7puVAiavEc2Xv7UGk1nAdeNIoPWszRcofj5TTSW7KrrqAmDVdEIkbFlLSp+D7L15PjdrGCY+f9bbi6jpabq9Wll6zDfTQ2JuAznEezSujRhW6A3NP7EmdAAHFQMmZZvPLFL64F9tropG7jGmw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(66899024)(2906002)(15650500001)(5660300002)(41300700001)(8936002)(8676002)(36756003)(31696002)(86362001)(38100700002)(316002)(66476007)(82960400001)(66556008)(66946007)(83380400001)(2616005)(53546011)(26005)(6506007)(6512007)(966005)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XsIiehYiBN+lrfDiJXtadJISDkVL8BeZcSDkOwZOXJOpJPHyj+Xpc4Sgcl4p?=
 =?us-ascii?Q?GXI+Upw1bszpf2ux/tna5EhpRDWVmC7vIwr1UxxF/FTpcpxKRcHh71LxmoFk?=
 =?us-ascii?Q?yr3BR/WjXfxIAwmOAN3zNzWwpVqU+vHeWLEi5DIbARxkHFUp+w0BmVnS9djK?=
 =?us-ascii?Q?da2tHtKE38rj9UjM577a0oRFSq6MBq0KSXkg8cc9o3o54CL00Fv5/qrdt5SS?=
 =?us-ascii?Q?dvePBF7bBVKnXdTgZxO33czshHgO+0pnCy3O8G9VyX8iywsdI9a/rehXn8J+?=
 =?us-ascii?Q?mdMtrwxjZumAiRNJpLXFb3BS1d705ll4gYcvrT2gjAXN32JV0c+luQdfcaF1?=
 =?us-ascii?Q?jXOLT9HneFq/2bJz2Ml1KMb2XRGI5qupUpxCVv9ICcdTHiyQuhNgGXria+ea?=
 =?us-ascii?Q?qLPjx+SLXDcriXCk+2k+UO8XdPvACB3IzRvKLe/i2DPz7/FerfWs1PHjWoPY?=
 =?us-ascii?Q?AeCBGsI+qitMlFNZpoHCmqb5JneRDMZBtUWReH+FogE+y6A8bncdUlTMQJIo?=
 =?us-ascii?Q?dPYk3lkE0uUGAsL+CrHTQJtMEq8d46YNmcsn5c5y9g6Mf2G2/JBX8yiLpgNO?=
 =?us-ascii?Q?qPwE9FsUKixAB6jMc0MQVH0QeqOA4sq9XXriMwfjiCZ+V7F8bWL1oP9C+GzP?=
 =?us-ascii?Q?G+9cX2i+NVQoD5acNh1QNOq/1uBlA/SwZ07pr+yf6+7by2ENzSgt/9VbT2Vb?=
 =?us-ascii?Q?R0VAq1uW10Q7Dla42Fh0LeRQdm0idxNfKgLKiHBj7eTTaI8/4mpgZ0h3xY0a?=
 =?us-ascii?Q?Bo1HdoVvZsg0Y+yi6t8nVCmp6MmNRkN2icdUGsigCY99B9Q+UxhmryaTTFtn?=
 =?us-ascii?Q?58bqSHKhYrj2IHgAaxYfA/ASHJ5U6Rq1xENsJNerBRTurhkG4D7Y0h06l8ln?=
 =?us-ascii?Q?IZX2Z3/Rw923Jgkpta4KmgA+XvDFIB8/+Z6ULV0AWGd/of5ioB4q79Egi6D3?=
 =?us-ascii?Q?jtk+xBLbIDW34BtcFdOHRov0bvq/tgonP4+XWiqiEYY10HQzU9tzioNZh8RF?=
 =?us-ascii?Q?X9+LAFhIEWIssd/i6tM6iB2ou13px2dF3nSuWM4RmGO/kCZ2stSyHW/b68QI?=
 =?us-ascii?Q?8UjCSs1Rfhc6lqoUkZwe7nWJTRoxzORO9npL8BDspGZN1hv2iXb6UVoFFwPe?=
 =?us-ascii?Q?DJyW1kspMeJDxoenLUyJq2lawH8q+wKUf3MIoleK9bcQYhIUgT6pLgk0iSEW?=
 =?us-ascii?Q?8bvE1a362U8lZR/62/+SqTT/zfXLFWC3vWjdU18K1mQCSZHv0njReUxNuoEk?=
 =?us-ascii?Q?ac5vWWDvNL25hN+v24h0FPbJ0gePRklvJP3SUyqRqwjEHcAJopaNW29j/QQK?=
 =?us-ascii?Q?UGZGs+x8LmpYeLGagc1Irt7wwTiA9aAPV7Rr8sl02F2+GmQ0WNWy96kGA+WZ?=
 =?us-ascii?Q?Sf+XGP8jPtDer4GUH5XjBrEFqb/qKgoJi9TBEIzS3hYyWRooXCmmyTTqJPaa?=
 =?us-ascii?Q?xtFx2wXO9UQImK1yDlgLFEG82gncsKuZxIZEMSYL6qwLID8hIvOvyqh9OOjN?=
 =?us-ascii?Q?GVXFSDeiYr+FZTeIi+z0+qLIEUsDvdkKhTt2JOSN0ucySSGwEWChSNwvZvFD?=
 =?us-ascii?Q?ejTM7UFGpa1QXOez8iM1VfLiBhPnyAF1z9Uge5UT5+RVv/AV+8J9L7HJxvnE?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccf2fe4-d760-4175-4b04-08dbd91f4e65
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:07:48.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmqB3XgYvuzI23slECz9KXXU0DqQLUh0VyDq62q5MiC3vjNrMWcK4rd8gg/qn7OcSHmv8DI8gOJt6tSD0iMglu7nzvC5tpiGD/kgHYJNa38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6361
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Oct 2023 08:08:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13495



On 10/28/23 11:04, Venkata Pyla via lists.cip-project.org wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of
>> Quirin Gylstorff via lists.cip-project.org
>> Sent: Friday, October 27, 2023 8:22 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; jan.kiszka@siemens.com; cip-dev@lists.cip-project.org; dinesh
>> kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.ku=
mar@toshiba-tsip.com>;
>> hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=
=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=
=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: =
Move
>> packages to security-customization
>>
>>
>>
>> On 10/26/23 06:33, Venkata.Pyla@toshiba-tsip.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
>>>> Sent: Monday, October 23, 2023 8:30 PM
>>>> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org; pyla
>>>> venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <Venka=
ta.Pyla@toshiba-tsip.com>;
>>>> dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <=
dinesh.kumar@toshiba-
>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>>> Subject: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security:
>>>> Move packages to security-customization
>>>>
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> To ensure that the package security-customizations is installable
>>>> move packages from cip-core-image-security as dependencies to security=
-
>> paackges.
>> Ah typo in the commit message.
>>>
>>> Thanks for improving this, earlier the security packages are installed =
at one
>> place to make sure all security packages are installed, later when the s=
ecurity
>> configurations are added, the dependencies are not added.
>>>   > With this patch the dependencies are well created, the security
>> customizations for which the packages are required are added to
>> DEBIAN_DEPENDS.
>>> but few packages (libtss2*) which don't have any security customization=
 are
>> also added to security-customizations dependencies, do you want to keep =
this in
>> security-customizations itself ?
>>
>> The move of libtss2* was due to copy-paste.
>>
>>
>> I can move it back. But the questions then is why do we install unused
>> library?
>=20
> We didn't provided the implementation for many IEC requirements (because =
of the reason CIP is a platform) but provided the packages that can be used=
 in the final product development by CIP users.

If the user requires this lib, he should depend on these packages e.g.=20
tpm2-tools.

I would remove them.

Libraries should only be installed if there are consumers.

Quirin

>=20
>>
>>>
>>> This is to have understanding that all the security packages that have
>> customizations are added with DEBIAN_DEPENDS in security-customizations.=
bb,
>> and all other security packages with no customizations are added with
>> IMAGE_PREINSTALL in cip-core-image-security.bb,
>>
>> Yes all package which are modified by security-customizations should be
>> added to DEBIAN_DEPENDS to ensure the installation order.
>=20
> I agree with you.
>=20
>>
>>
>> Best regards,
>> Quirin
>>
>>>
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>    recipes-core/images/cip-core-image-security.bb     | 12 +----------=
-
>>>>    .../security-customizations.bb                     | 14 +++++++++++=
---
>>>>    2 files changed, 12 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-
>>>> core/images/cip-core-image-security.bb
>>>> index 3421ce5..525a346 100644
>>>> --- a/recipes-core/images/cip-core-image-security.bb
>>>> +++ b/recipes-core/images/cip-core-image-security.bb
>>>> @@ -28,24 +28,14 @@ IMAGE_PREINSTALL +=3D " \
>>>>    	tpm2-tools \
>>>>    	tpm2-abrmd \
>>>>    	acl \
>>>> -	audispd-plugins auditd \
>>>> +	audispd-plugins \
>>>>    	uuid-runtime \
>>>>    	sudo \
>>>>    	aide-common \
>>>> -	libpam-google-authenticator \
>>>>    	passwd \
>>>>    	login \
>>>> -	libpam-runtime \
>>>>    	util-linux \
>>>>    "
>>>>
>>>> -# Package names based on the distro version -
>>>> IMAGE_PREINSTALL:append:buster =3D " libtss2-esys0 \
>>>> -                                   libpam-cracklib"
>>>> -IMAGE_PREINSTALL:append:bullseye =3D " libtss2-esys-3.0.2-0 \
>>>> -                                     libpam-cracklib"
>>>> -IMAGE_PREINSTALL:append:bookworm =3D " libtss2-esys-3.0.2-0 \
>>>> -                                     libpam-passwdqc"
>>>> -
>>>>    CIP_IMAGE_OPTIONS ?=3D ""
>>>>    require ${CIP_IMAGE_OPTIONS}
>>>> diff --git a/recipes-core/security-customizations/security-customizati=
ons.bb
>>>> b/recipes-core/security-customizations/security-customizations.bb
>>>> index d3cede8..162d2f6 100644
>>>> --- a/recipes-core/security-customizations/security-customizations.bb
>>>> +++ b/recipes-core/security-customizations/security-customizations.bb
>>>> @@ -11,14 +11,22 @@
>>>>
>>>>    inherit dpkg-raw
>>>>
>>>> -DESCRIPTION =3D "CIP Security image for IEC62443-4-2 evaluation"
>>>> +DESCRIPTION =3D "CIP Security configuration for IEC62443-4-2 evaluati=
on"
>>>>
>>>>    SRC_URI =3D "file://postinst \
>>>>               file://ssh-remote-session-term.conf \
>>>>               file://ssh-pam-remote.conf"
>>>>
>>>> -DEPENDS =3D "customizations, sshd-regen-keys"
>>>> -DEBIAN_DEPENDS =3D "customizations , sshd-regen-keys, libpam-google-
>>>> authenticator"
>>>> +DEPENDS =3D "customizations sshd-regen-keys"
>>>> +DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, libpam-google-
>>>> authenticator, libpam-modules, libpam-runtime, auditd"
>>>> +
>>>> +# Package names based on the distro version
>>>> +DEBIAN_DEPENDS:append:buster =3D ", libtss2-esys0, \
>>>> +                                   libpam-cracklib"
>>>> +DEBIAN_DEPENDS:append:bullseye =3D ", libtss2-esys-3.0.2-0, \
>>>> +                                     libpam-cracklib"
>>>> +DEBIAN_DEPENDS:append:bookworm =3D ", libtss2-esys-3.0.2-0, \
>>>> +libpam-passwdqc"
>>>>
>>>>    do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>>>>    do_install () {
>>>> --
>>>> 2.42.0
>>>
>>>
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#13486): https://lists.cip-project.org/g/cip-dev/mes=
sage/13486
>>> Mute This Topic: https://lists.cip-project.org/mt/102137081/1753640
>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753=
640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>

