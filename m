Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F2C4707A
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 15:41:14 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.131])
 by mx.groups.io with SMTP id smtpd.web11.4545.1649321485462667088
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Apr 2022 01:51:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Ig2oX3Ms;
 spf=pass (domain: renesas.com, ip: 40.107.114.131,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4RPHESfTIX2jJUBNkSL31kzG+wt5yw7xqXCbk0AW82/p8ZOZYA5jQNn9jcsfXktq3jNiG44xWRZ2uKCm3b2utj/yUln4bpQWUchQqd1RTAjlSMwHfoaeQt0L9ofWwDlzXyQTuQ5VjCFCOw9d+jH1c/+SGsSQ4MldbDSpmqZpz23Y3kapsoSgjeRVLAEj8CaHVJiVCv6rVxHP6n81BJKM2wwqJsaQ1WWr1BxY3Jkh/aKLyxH1FePp1VGkdedksNqeT2N+l5tNb7oO0YJ4rfj6U1AbgqTyXvgnyJk36hDjX3f4Ytn+LWazApXgbOZvcpihIvaB0Ph0AJQiZjpjWGjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnOrhAJaosB+tAllxpk5uGmfkCfgy1A4/p2Yu0kcEAs=;
 b=mCNNyTEHDY5fYPsyaTb8lUuBCswy5LRL+fjxZGsDlFNdNZp3WABYoHvEOue5YI7+lT57mq2QPUr9mv6IoT8YYmxtmtuqvE+Id/OdPjoJMxjAzU2EuPY2MYYNTKC5015Oxw51IP2GFMGc037aJ3lNjX2xtrS33BwB0cYHjjMqmg2JivDt7c+QZ26mRQzlTF2Ki/VhVXUEzgaAS09SEMZaCyl7f9C/99/IzUekYwNZRCiBA/jLCvZ6yLpSWjdB8kyTQiliib6+5sakx37x3KAMtJn4emqR3Hgv/JcJp6tPVauTliL7Tp5SXYGfB8ZSWVIVI7TVHEKuJDSKm4KQUe2XqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnOrhAJaosB+tAllxpk5uGmfkCfgy1A4/p2Yu0kcEAs=;
 b=Ig2oX3Ms9iiXxu6N6L+TSAg2YlJbKXmRN7mMckUEVD84NQ2xYOMxbhyo6w80KCCIpgh21PL8wB38A+atuGjXNaG6Cd5TkGkArGfXFvPqkYpPCYhPuxOT7kskASo2JNWuRqTcOB2FuRtsfYoBDKEkGhpanAtmBzIN5rFlS+0i2Qo=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by TYCPR01MB6671.jpnprd01.prod.outlook.com (2603:1096:400:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 08:51:21 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::440e:cec6:b2f2:be1e]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::440e:cec6:b2f2:be1e%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 08:51:21 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: 5.10.110-rc2 mirroring/testing
Thread-Topic: 5.10.110-rc2 mirroring/testing
Thread-Index: AQHYSgKL1Kwgzb8SWkS6QXkHofo8c6zkAZGAgAATeWA=
Date: Thu, 7 Apr 2022 08:51:21 +0000
Message-ID: 
 <OSZPR01MB687707F1F7114CA3DEC73FF8B7E69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220406220612.GB4213@duo.ucw.cz>
 <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
In-Reply-To: <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b30bc5a-909c-447d-04c6-08da1873ca2f
x-ms-traffictypediagnostic: TYCPR01MB6671:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB667130459E68C565658E5382B7E69@TYCPR01MB6671.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ne/Bvh8+j9/+/iXiO9aUYgUDAKKjxhGVIklmkO1yNYec/HRzlV+I3w4wlnZuS/9qE1+ijoMNrR+vnm37TDlruKpL5kW0l73EF1RH++mpahYjw+CF+PNtpnOxJoIJbeq5+CZX4XNmj/hRwuhvo782zJa8MHuCSURHQffxMKYWcw7dUqNrm2XT5YOQchJtwNryhXRYgjd2wDB3vdRocDknWv/WTm2e1StiWgdu2iFBU7nTXxVlNvg8A8M40gK6XpRmd/VkicPzc7TALZkODEDhCE6BqIeF/IrcYGY7ZefJ3qROxDBVRQn1brEBpla+CC+61wnDCSSPxC3sd/TYY3T5Wy8QPHxiMq2O0xldKEBEY2FYc/DTS+fw1b3fyM8eVli2Kd0Jp60bMXOFRUprHGuqqTAQZ7ddVfsdzK1huoZ8TC05zYSdBC06WDIbdmaa3MJFGXcwwAZaMvfsghqHVapdfkFjJZz0U5CFsyVjqfx7ihULe96tXe7FZuYcFtZfCQvNdinCm5bic/02ju5fZ0p+S1R3SKPKvr81rTiVS+okG537FGC2GUM9DWK484N3kutLvn1v6O4Z5GDsCPIfo+CDndHkdnRkEpVreHSGJuqavFSxK4ZxORDx5Cpk0ZwOdqwICy2hCAukFnWcG1xi/C1g0ZcQ0XX53hGXS9H+q1lj+SMZqBrp4xDCxruE1kdDz+suy6RjX2LBLiLT02f1T8KmT1IzoXWU1mx9Rl4Qp5LoATCazckUX3Pes9UcNBwsP7B9BLZ0mpFGEXdRCl34A0TDuKKvbaLkJfAwo9kXtTxjKIM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(45080400002)(508600001)(8676002)(76116006)(8936002)(7696005)(64756008)(122000001)(6506007)(52536014)(966005)(38100700002)(66946007)(66476007)(66556008)(66446008)(38070700005)(55016003)(71200400001)(26005)(9686003)(86362001)(110136005)(53546011)(316002)(186003)(5660300002)(83380400001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?OYLWEDNqEkJqRhIa72fsniktV//l7lmgrRwnZsqdTcN8nqvZfSuJvBcg?=
 =?Windows-1252?Q?18HCqAdo/ZH2Zdgn4Ana/B7vD+Wz8DvG1Y7C8aSMjLYGzxavIOHMkaxu?=
 =?Windows-1252?Q?mIj9uqIlPMuJy672q+fC/ynHCLhCz9md7fdTnPbDMyL8gCHeS2f6N3hC?=
 =?Windows-1252?Q?8H7aa26UqC8hFebGALzbFYPDScKq6JseNk7i4KFAqIGPgMBvO0rd+QzO?=
 =?Windows-1252?Q?FsOz7YFvXMyzhXvj6hO3mbQjJCObnchxkoe4tVt6mZt0mQJu5w5Pt57Q?=
 =?Windows-1252?Q?qfVz/+D3T6qmtBxRxb0QkPgDZHEi3o/EDWoRvgrjzlTH8GWXe1rjcY6d?=
 =?Windows-1252?Q?Xf2wLn+soJ37vsPK7DM/S8Xr2X6y2DYdDgbJ8nN9c1AhwjlVC/gg8dpu?=
 =?Windows-1252?Q?CHiJJ2wljBQzqbLXSVJ9Kv/lvz1n8vuerzkXIvXtDBBQVnN9nmVHG52t?=
 =?Windows-1252?Q?wq4lAMuWDhx7gX6g25wz0GLpUhOhp2Vs7tQptlWzEf4XIe2q5AiCB05M?=
 =?Windows-1252?Q?1RZvk4EQjuPZz+V5Q04/CZjVzqEwpPxqUsD/WE0VvujlL0bHJ+gqqVrg?=
 =?Windows-1252?Q?imX5SS/paCc1+pAjJVz0QKGTFS6vOijjUv3Psj+6UwDzTPQCW4efW+5W?=
 =?Windows-1252?Q?IhywRLOsNvThjDb792mO3WEi2lBopgV/1Wd32apsNsQcFqC9JFl31V4y?=
 =?Windows-1252?Q?fW7tgo284CB7KpgVKhH81YY0GJBVRwMlQ6ApIxrFSVO4lzA3IVoBltXk?=
 =?Windows-1252?Q?7WCOzgEx8unAopk8FlSxZx9bOOwR6s6rzOweDtpO8Ym9SCjudTsq/KF3?=
 =?Windows-1252?Q?mS5CowUcw/G5G8XvUL4V7AHH7Q8/Mp1HMNv5439cOmXzsQO88uGWCm4Z?=
 =?Windows-1252?Q?JXgIaQov0EddnVhPglizL8H1iHs6jND+aPRmY0xXmZTgK+q6R67ZApFn?=
 =?Windows-1252?Q?1j5kxH0ea5QgeyH0aSwQa1EeOMiiX+yq/DYj13UmKmSr3/28HrkUUbjY?=
 =?Windows-1252?Q?I8AFwFVtI68UrWshvHSlpkaObE7RmCfRUeCRqZRSHxnM73FELvHnnvnF?=
 =?Windows-1252?Q?OhlDxggna67YgwhG5cLz3vN5KaKREtvMVUcUakA2H1HA3BbWGiU0GqnZ?=
 =?Windows-1252?Q?aGUqktOWV9yWYmiZM3IHD7AVDSP/jhRhTeEB7IbhP8uR4MPtQ/zQerTF?=
 =?Windows-1252?Q?ijRFJq1sU/iaghVFvfc+oDOucLj+rzx0L3uHEieAV5TknnPfIXj0sR4I?=
 =?Windows-1252?Q?PMiwNM3G/d+plH5z/liuEe7c6AeGuIpMB0nrgKn9dexnJAZM2tkQChcw?=
 =?Windows-1252?Q?4Hf+KC9tbFckVu3pAur9dSfkj9ElLj3LgOJkRay47egdoKP3oTOMQHma?=
 =?Windows-1252?Q?OJczP4C7EHoECzdSbeinm6nHMj8RaZ7WT0G91Ae3YfR/ckVZUvdjRoAi?=
 =?Windows-1252?Q?iTTFfjQOZIt6oHc4yd898Gd5KQzvqS/YVp7hZD0zPNICowbZAYK7MsMr?=
 =?Windows-1252?Q?PpA1crIhEY6og3OPo4xWL3VW9Xu/vmHiolAiDVxWU35wIM18m+6beR2Z?=
 =?Windows-1252?Q?QE2wfYNLBceQ/I0ZiQimNf5hd7739XoXgvfOSlVrVnbUuidvPm9cMCAE?=
 =?Windows-1252?Q?F53V/ZzP+NZtoYtWmA5xVX4+MJkAEEz83fTgmq+zOvRF/FUdqhpoUwH4?=
 =?Windows-1252?Q?iBIUYdl+JO+U7iktfCp8nmc5ILh1qeK7uXcqMWqGDOEmALsa4PmaQecU?=
 =?Windows-1252?Q?NUnCT//r0OMo+p9vZxUgkXFW75IPumoENZ8+wMFJlYVngkq4PZDwQXKU?=
 =?Windows-1252?Q?hX88FJAHNhvGJ8FxCY5mmPNngwTDfwkqG3e8yUWKe2Mro5hIel4ak76d?=
 =?Windows-1252?Q?7QI5pVF6mG0e2G56zPjPm4lvsR5umzArfnU=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6b30bc5a-909c-447d-04c6-08da1873ca2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 08:51:21.8106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ALWbuPuovfveaLxhfbMIt6dkrssVhLWlJjp6acU40ENhso9CAPCTRX3PjRuy6QRq+V9be0AA0ttoa6+RJXrfjKUOdCKCL7w7d8/DREiDdoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Apr 2022 15:41:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8019

Hello Pavel,

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 07 April 2022 07:44
>=20
> On 07.04.22 00:06, Pavel Machek wrote:
> > Hi!
> >
> > 5.10.110-rc2 is out, and it would be good to test it, but somehow we
> > are still at -rc1...?
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Ftree%2Flinux-
> 5.10.y&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.com%7Ccda7f53
> 12d69483e751208da1861f34f%7C53d82571da1947e49cb4625a166a4a2a%7C0
> %7C0%7C637849106225416510%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3Dp0tXQDyIDY1SqRyIOHrtFzygGDqTbRphnrVzn34XVy0%3D&amp;r
> eserved=3D0
> >
> > Does mirroring need to be kicked again?

As Jan hinted, the mirroring has stopped because the linux-stable-rc reposi=
tory has now gone over the 10GB size limit.

I guess we could  remove all the branches/tags we don't care about, then pr=
otect the branches we do care about (LTS) and configure GitLab to only mirr=
or protected branches?
Hopefully that'll reduce the size a lot and mirroring will work again.

Chris

> >
>=20
> Maybe the problem is rather this:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fgroups%2Fcip-project%2F-%2Fusage_quotas%23storage-quota-
> tab&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.com%7Ccda7f5312d
> 69483e751208da1861f34f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C
> 0%7C637849106225416510%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;
> sdata=3Dpzhx2y7WhVSd97cJak6p%2BTfM41%2BoYbRLe1gQwoX%2BxuI%3D&a
> mp;reserved=3D0
>=20
> Already linux-stable-rc uses 11G by now.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

