Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE1C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 16:16:18 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.59])
 by mx.groups.io with SMTP id smtpd.web11.1137.1715184971474851770
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 09:16:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vhv+D993;
 spf=pass (domain: siemens.com, ip: 40.107.13.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBISNrRwo9LIMRdR0zvg22XnUN/TWd4JI6UrfgURiRHtadHmkGMRH7ouGBeZf/pQ9ASEeSCnWZB22+lHfoEEWDI7erR/2oFcHb2tqG83JJnfDfSuQTxjOzSlVPwUdgCN1JF8bYsYer/tBqBg4nYVCLUbaaOnxVGp0XMFb5gP0dMUoyiffxxKVE5dc8I5qrq34JF1AzI3gQPusymi4Dz0W+g6a0+gvZsuFES1g6jQCfBBqrWe5K7dXPC8/+kYmdM628dYQlXtzdr5fqb6Ya47riEXGajbBC+NAhpcCr09KzZdH3ZK9rKPIIWpxTGtJNZojVihHWu6Jivu31UBeWNlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcVpaqbE0ru9ajBBlw00/ZAJ2i+RmnQaHeA1W1E2bmU=;
 b=S2M/Sy7qqcph/yiMyXCinhkJQdN+U3KT0KHOQXWMlIkIfyDZxzinjZkPgJidw6JmjEEGg7KrWGR5oxhAMQOsdBL2aDtUqUdrVxa7IBqurfwn+9fqLpv/4lRmelHfJ4y4Nh9zp3YUiqVdYrwfMBrVT1fPVKRfthimJrfKFNmZPJA8zZdZG7J6/jCD0/osOFywCTtik/5vNRPflG08uayWYS45vy63DEKWcI1xT/inqCOLgvdaIe4IIDnCJcQgvwMezNXuXyZM9xNBrnhxjhlJwD5DfhPDekGrUkU78Igmwp8ok25cACELDh87lDYcrpRjx6POygDCr63a6mP7csYRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcVpaqbE0ru9ajBBlw00/ZAJ2i+RmnQaHeA1W1E2bmU=;
 b=Vhv+D993BijRva2555Xify8cicN7ltvPMjebTJ7MbHHE+avFDfhynXLZNC6YYlWTeoAD7TO3u87Q04L8R7jtw1OByhe99B2kBOnGW6WwHArOIEi64xk/ADBzXD926DGWqz088MUnuIFp0erEkexj7mI9+Stlh06cBMgwWhqazzKlFF8iQ0cz1Ucl6QT7pN851E9HOqNdnPh3qfcdDmFd9TO5ZG/Ch5p5UijA5fuZ++kiiRDEXmLX32ue8/ESA28On8llVF9MDcDyRXd08YFZkGBSPZrpiqWKZ848iiDeZWnKGv/8/NbVRTjTIng6W5dSQu6VLzxqF495L01IiTjyZg==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 16:16:04 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 16:16:04 +0000
From: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>, "Schilling, Benjamin"
	<schilling.benjamin@siemens.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Generic x86 kernel configration
Thread-Topic: [cip-dev] Generic x86 kernel configration
Thread-Index: AQHanXK4pws4r9KaPEqITSq/7lrqy7GNhsKAgAAA6wCAAALsrg==
Date: Wed, 8 May 2024 16:16:04 +0000
Message-ID: 
 <AM9PR10MB4085D362B7DC095E040E755F81E52@AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM>
References: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
 <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <078e13fd-59cc-4955-be45-9ad5906eaf29@siemens.com>
In-Reply-To: <078e13fd-59cc-4955-be45-9ad5906eaf29@siemens.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-05-08T16:14:04.7350782Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4085:EE_|DB8PR10MB3660:EE_
x-ms-office365-filtering-correlation-id: 692c2c85-5c7b-4373-0d63-08dc6f7a28f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?J6UHor154tvp33jxDxRpQHXukBfg0ewBauscnRwHMM5NAChuuk5OYI8W8flF?=
 =?us-ascii?Q?SJcAev2IVgzfe1/8gLuaZDMvo4JN1MZIPe9hxBvXWgpBQCfc9x/+JrHDY4f2?=
 =?us-ascii?Q?rpHYNltQNQrXBxeYwnytjLdJmOzLgJCJ+tIoEK7pVJUFuYmMpE/qSgrMEoAj?=
 =?us-ascii?Q?xtse3Sjp/KYw97IxgQ3gv1kQa+pGspqK7TFrCE551DwIgw/cKt6052nflEIk?=
 =?us-ascii?Q?XSVsjj9G087jybKzxtxBMuxqVjTScbboY7kYpjkN7hAeY3p61kPXaGa+XrGd?=
 =?us-ascii?Q?bAzyzxIkagMnvsrhwOpoAI7LBaT2hjOmKC/n3KoaUA7DLSaQKY+eqB4S10RT?=
 =?us-ascii?Q?imtJo6+9ii3JzX2FtG2cpzcxFPsN8ySWSRHE3k+nOHywfKpKX+fHDvq35mKp?=
 =?us-ascii?Q?ay6jfE6obiTXunfcI9StwCzg43zXvDvDgKwus7eJXuEmjrZLdB9O6uvguOVA?=
 =?us-ascii?Q?uC7UPL1fC3JGXR8jFwIO3OKvoieFC/xViX0m3y0C0TwEoqZcWBbzNKe6L5ZY?=
 =?us-ascii?Q?78pk8XdNQNB3sAtWSXn5eB05kyOVdyhKeBh91gknAKH1su0/wyUaZE0Hc1Am?=
 =?us-ascii?Q?68pC9Q8ZiIjIYK9A6AZ5xRlcIpLyrsq2QfPRtpMxXZGWV0FtYcuYwXIeIMqI?=
 =?us-ascii?Q?VLJJ2jIjhJAaFsLVqOX9o9bSWhCMllrZAccHJJHZ0wL6pw5NGp/Yp5aALRqB?=
 =?us-ascii?Q?pBOqYc2auvUFeFZyjkE9RjYhaVfmt8o0QsiGJ51tVXqAkSTZxxAfEJZoVgg+?=
 =?us-ascii?Q?FIIzYSh7CJdqJoo7gRHmeOxjVs9mo3Mx4U1suoxxJfkkej0xwXPb/Lreibak?=
 =?us-ascii?Q?TXNKKoXudzeDpT+UOpMXjBy9iXuv85kT853hSnmZOy2UTO2uP+1F5/4+fY4H?=
 =?us-ascii?Q?l0pM2W9Rd7RNj/e2MsyTqsqsWUAQhArLi98Ih1BZ2FQxqWurY71fYHJLja8P?=
 =?us-ascii?Q?F4KHFfsnNMhKR1WGLcYPX4ABs/+Blrvd3xmjTtI2rdCg9wHjYs4NkKdkjdRw?=
 =?us-ascii?Q?PrWNG8s2jr5J2NqdqnAY1SwFGwn08nzus9BxWIkhAGWiHMbOmFxW7Hc3P4H0?=
 =?us-ascii?Q?kTFV2S7Cf8PtxHbwr7zZoNFxyUqzYWB9mJUFmo+OaPA2UnQThM2PKLgmi9Go?=
 =?us-ascii?Q?5P0nbVyVVwmcWAW3TSDbrnsNR00vuMuw5TySMPhCClU7XtqglZGOlzwUn/PE?=
 =?us-ascii?Q?HXd41wBvOd2aLehVIil6HE/yIZugm4PHtmPaJYZWtMLDhbqqMRK6nWpcakQF?=
 =?us-ascii?Q?93c0t0g7CtM9L4tVey1nS++u93g0ongj2Z1Da0JlsA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?8G/7YHrwkxjeVVsvGsH9eQVl8qtd/282Gnz/DJWDOb4tbTfXU3nzX8jb0e0B?=
 =?us-ascii?Q?07r7cQ49akftrV4q9HDTBrLxKSJC2t6xxwQuw4brCoPR7k/o8OOEWsND/sjt?=
 =?us-ascii?Q?B9CrVI9xtwp5cFPk5OoyMyYk1YXJDeoOxcIVdF59par0dTKPFFCaIUVgMS5X?=
 =?us-ascii?Q?JBlaUuXc6Y3SIV1gZkxMXrgFyEn0w4gc3fdeV516+9gPJKwN7idPg6ZxIinj?=
 =?us-ascii?Q?ywV+87m9Q4cL3wRw53BVAVMvykKF4t3ZwpLTQRVYHp2Y5v2XlV6U9yJl3hpb?=
 =?us-ascii?Q?RoK+9awQzDfFxmN9e0rPsLDLnNN67RMJwfXAeLUncPx0s9tHuuIEzMJYgVnv?=
 =?us-ascii?Q?NSso5t1vRHDS61Xv9dvJ+J3rDVTJDxMqdyRB4gWKyhiH5pT2sv6BMm5BOvJG?=
 =?us-ascii?Q?0WFyuZmUgxMl89X3cRVxH5NLuoEDWVMmTcSyqp8JFXQSd8VlZKDPHL675V5L?=
 =?us-ascii?Q?060w4vJPyS5fEgokFCCaIgVOD06ZJ8W6QVqrR778bcai7CTElyADbuGkNvND?=
 =?us-ascii?Q?XSRLj95N2y0z02lkQ62UrcDGPumJp6JOrrV/3uOG7MaQk2RNmm7X19a0XVcp?=
 =?us-ascii?Q?JQT2KIzfxdLq9lUA4x6YrsDKLywIXncnEPk8w4+wAScNAFWjnO47Mac8tY/9?=
 =?us-ascii?Q?VbTkKUhoa5kn+eVHA6iKduv+ifyJGriUzrLyzUDSgwHmaIabOf8XDiC/9EV4?=
 =?us-ascii?Q?YmXeBiM7v9OfvmBmAqsv6srVTVaTsusT6L0UI3dgiaAurTIr7Jbt+4VRJAvh?=
 =?us-ascii?Q?ml7F8Up6pcROZhTmYWQxmbAoYaoTJLeRU5MyRkwVvuYx8zwtoVWBpP1faOg+?=
 =?us-ascii?Q?WOfI4e3cyUk+h1oOvCCZhImDMrKK9VEWPJiWtAjx5K6ASA+TWz0LJ8PsRLS7?=
 =?us-ascii?Q?gfSpJvcENLtbKu8xace6VkQrrkeQAh9dsodxItOTPgZcbW2HG2m4pd5a9lWD?=
 =?us-ascii?Q?33YXPQSAMPP46IAuUdeaNCqNMflpMdwAt33qPpMCWIMPyZM0quAyDG/7EtwU?=
 =?us-ascii?Q?IqP4B4QZUKk/OcCCgv5SJciJ9sGPZrmoDs/XRxPVWmEGW2BoBo+uzWdHB+e4?=
 =?us-ascii?Q?H/+booxMtuiUROEa1dYqFh7ZDElUjCnv1YDrlTHwmp8PWSJV686VHTsd3qQX?=
 =?us-ascii?Q?/I14tN4rWUI2v7HmTwWFaWVT3ltdi2tVn+e5p3d2ugZKpepXRkyT3VeiC7Nb?=
 =?us-ascii?Q?VtCy1upmhVRcuWrlHTpxhm19ITgEjVIcOHQpVJSh9nbJ1hLHGINwI8QiwX5N?=
 =?us-ascii?Q?ZyLzfdL8wAn9vl4e/cuPaT8IUvc10Oh0s57bVlC+1xzBoZjI28rPyrzYA+fN?=
 =?us-ascii?Q?lYssaQ5MkE/mmldfrHUL8eQSYb3US8CijoM2MyLa2GExDOY0BdnEdtMDuw7S?=
 =?us-ascii?Q?12d8Gc1oHenrjv9pPW/1UJWjpjZ+XdealqYekaps4k3BDe93hNeZ2Mr0hCws?=
 =?us-ascii?Q?PRYN1pFeNyKzVGWs/IT8e/d+wvvoRmY8VHe/uJv3MQQfwlnfUYnaVs7YdiF7?=
 =?us-ascii?Q?a4LBGYC3Gz4GzQZ+Nbu7f7Et++quca2JIu3GndGbdRwAhjf8tufkin+FJ7L6?=
 =?us-ascii?Q?iZDeRog5GgQYfo6uNbs5kQH2fgMjJTk4P4balZ3/rygcx+U8TnzqnqfxTH1q?=
 =?us-ascii?Q?v60cE8ceTc5A8r2Gsp2+4lBJ16qFVlznvtu/C3SUlhbvV+xZ9WlHmIVhYLgb?=
 =?us-ascii?Q?+B78Se6rRveAqNqWv1E9Tt9DsdU=3D?=
Content-Type: multipart/alternative;
	boundary="_000_AM9PR10MB4085D362B7DC095E040E755F81E52AM9PR10MB4085EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 692c2c85-5c7b-4373-0d63-08dc6f7a28f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 16:16:04.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohSCD9zqHD9E9k8hkX4zsKyAAd7kkjjGWAfxmOujuqnEzDCg2I/BTESF8SA6yjKphRHTvWY2krXap5or4HpLdurYkPocMTXK3IZ9T1Aewlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3660
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 16:16:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15864

--_000_AM9PR10MB4085D362B7DC095E040E755F81E52AM9PR10MB4085EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I will investigate it.  I think this be one of the cases were automate merg=
ing will fail.
Quirin
________________________________
Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
Gesendet: Wednesday, May 8, 2024 6:03:38 PM
An: Chris Paterson <Chris.Paterson2@renesas.com>; Gylstorff, Quirin (T CED =
OES-DE) <quirin.gylstorff@siemens.com>; Schilling, Benjamin (SMO RI R&D F S=
EC) <schilling.benjamin@siemens.com>; dinesh.kumar@toshiba-tsip.com <dinesh=
.kumar@toshiba-tsip.com>; Nobuhiro Iwamatsu <iwamatsu@nigauri.org>; cip-dev=
@lists.cip-project.org <cip-dev@lists.cip-project.org>
Betreff: Re: [cip-dev] Generic x86 kernel configration

On 08.05.24 18:00, Chris Paterson wrote:
> Hello Quirin,
>
> Thank you for your work on this.
>
>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
>> Sent: Friday, May 3, 2024 4:58 PM
>>
>> Dear all,
>>
>> I have used a forked version of [1], which you can find here[2] to
>> merge the following x86 kernel configs together:
>>
>> cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'
>> cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'
>>
>>
>> I have tested the v5.10.214-cip46 version of the config with qemu-amd64.
>> The next step would be to check it in the cip lab on the real hardware.
>>
>> The script takes the Kconfig entries of the specific kernel version into
>> account. It also adds all dependencies to the config. You can find to
>> log of the merge at [3] and the diffs to each configuration at [4].
>>
>> An first integration into cip-core can be found at [5].
>>
>> Any comments from your side?
>
> I had a go at building/boot testing the linux-cip 6.1 kernel in our GitLa=
b CI setup using your merged config:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/128347680=
1
>
> It built and booted okay on the ipc227e.
> However, it didn't boot on the qemu setup in our LAVA lab:
> https://lava.ciplatform.org/scheduler/job/1129968
> "This kernel requires the following features not present on the CPU: movb=
e"
>
> I don't know if that's an issue with our qemu setup or with the kernel co=
nfig.

The CPU type the kernel supports/expects is a choice. I suspect that
merging multiple configs shifted us from "works with generic x86"
towards "only works on Intel-whatsoever". Combine that with a
restrictive CPU type selected for qemu/kvm, and you get that kind of error.

We should likely tune the common config for generic x86.

Jan

--
Siemens AG, Technology
Linux Expert Center


--_000_AM9PR10MB4085D362B7DC095E040E755F81E52AM9PR10MB4085EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr">
<div dir=3D"ltr">I will investigate it. &nbsp;I think this be one of the ca=
ses were automate merging will fail.</div>
<div dir=3D"ltr">Quirin</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">
<div></div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> Kiszka, Jan (T CED) &l=
t;jan.kiszka@siemens.com&gt;<br>
<b>Gesendet:</b> Wednesday, May 8, 2024 6:03:38 PM<br>
<b>An:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;; Gylstorff, Q=
uirin (T CED OES-DE) &lt;quirin.gylstorff@siemens.com&gt;; Schilling, Benja=
min (SMO RI R&amp;D F SEC) &lt;schilling.benjamin@siemens.com&gt;; dinesh.k=
umar@toshiba-tsip.com &lt;dinesh.kumar@toshiba-tsip.com&gt;;
 Nobuhiro Iwamatsu &lt;iwamatsu@nigauri.org&gt;; cip-dev@lists.cip-project.=
org &lt;cip-dev@lists.cip-project.org&gt;<br>
<b>Betreff:</b> Re: [cip-dev] Generic x86 kernel configration</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 08.05.24 18:00, Chris Paterson wrote:<br>
&gt; Hello Quirin,<br>
&gt; <br>
&gt; Thank you for your work on this.<br>
&gt; <br>
&gt;&gt; From: Gylstorff Quirin &lt;quirin.gylstorff@siemens.com&gt;<br>
&gt;&gt; Sent: Friday, May 3, 2024 4:58 PM<br>
&gt;&gt;<br>
&gt;&gt; Dear all,<br>
&gt;&gt;<br>
&gt;&gt; I have used a forked version of [1], which you can find here[2] to=
<br>
&gt;&gt; merge the following x86 kernel configs together:<br>
&gt;&gt;<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconf=
ig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'<br>
&gt;&gt; cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'<=
br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I have tested the v5.10.214-cip46 version of the config with qemu-=
amd64.<br>
&gt;&gt; The next step would be to check it in the cip lab on the real hard=
ware.<br>
&gt;&gt;<br>
&gt;&gt; The script takes the Kconfig entries of the specific kernel versio=
n into<br>
&gt;&gt; account. It also adds all dependencies to the config. You can find=
 to<br>
&gt;&gt; log of the merge at [3] and the diffs to each configuration at [4]=
.<br>
&gt;&gt;<br>
&gt;&gt; An first integration into cip-core can be found at [5].<br>
&gt;&gt;<br>
&gt;&gt; Any comments from your side?<br>
&gt; <br>
&gt; I had a go at building/boot testing the linux-cip 6.1 kernel in our Gi=
tLab CI setup using your merged config:<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipel=
ines/1283476801">
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1283476801<=
/a><br>
&gt; <br>
&gt; It built and booted okay on the ipc227e.<br>
&gt; However, it didn't boot on the qemu setup in our LAVA lab:<br>
&gt; <a href=3D"https://lava.ciplatform.org/scheduler/job/1129968">https://=
lava.ciplatform.org/scheduler/job/1129968</a><br>
&gt; &quot;This kernel requires the following features not present on the C=
PU: movbe&quot;<br>
&gt; <br>
&gt; I don't know if that's an issue with our qemu setup or with the kernel=
 config.<br>
<br>
The CPU type the kernel supports/expects is a choice. I suspect that<br>
merging multiple configs shifted us from &quot;works with generic x86&quot;=
<br>
towards &quot;only works on Intel-whatsoever&quot;. Combine that with a<br>
restrictive CPU type selected for qemu/kvm, and you get that kind of error.=
<br>
<br>
We should likely tune the common config for generic x86.<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Technology<br>
Linux Expert Center<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM9PR10MB4085D362B7DC095E040E755F81E52AM9PR10MB4085EURP_--

