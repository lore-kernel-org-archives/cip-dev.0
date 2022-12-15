Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A67C4332F
	for <webhook@archiver.kernel.org>; Thu, 15 Dec 2022 23:33:20 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.92])
 by mx.groups.io with SMTP id smtpd.web11.476.1671147189885760310
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Dec 2022 15:33:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=o/T97aWW;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.92, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeQXT/vD4nKPcuHyWUEuUgOXE6pyP9kDF3uaLTSVgacWKGWeEYMU+c+Bv7BctGHIAqV4Ewp7ExfN/738wYqzjbf0WSaNV+O4K6d6dSwlJfgmDvKtvD6k3RBKfRD/z/8xHdyRlTEilB5lEfG3FD67pW4zAt+s+EYfiaAxNp3WQpOGStLw6CU5x8HgHaWKieKi8vNJ+g+z0nCVCCwZy99CX5u7SYF53T8P/KpPO5O4yxAw8qAvtBrHsllSzDh7oDFBiK+LH/d7VM+hOw1G69k0E5c+C1ZOIjoz0nJrx8Lo9eLD2RSXlgq14p80qy5kZysVBL90UWRf2HmWA1URvJ/pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4kpinesgqTDvFQ+jzfyrHgtVCGpQms5NLh6gRvN0yA=;
 b=Q59lfi3Ktff+KXcGEs2dgln8B97j6n6MfWtn6Bd1XIArDgJY4Dhm+b2UWcv88p9T4RqGhIVK+9zJ0S7U9O73vL2vYJujN4UoYL/mjMFVgVefOhbXs1shy2ZlS1uVhps6ydArq0GNe0StYgCEHtBg/c/iRqTkZB/pIq2fxOcKMLlmpziWIuxvh/e81dXj09v0ekxO+N2FoWAEWexSoFdcNekNB9JM8zUDNweMP44qOR5O0UirxfWeROI6mWywGLINZAlYrM0fDI6+AKT7qIUYVerFdRtS1440G+R/pk0p+mPxFO9qG0WNZgDt9Hs5i33mDMmAqnHU8feWmzVDF/zYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4kpinesgqTDvFQ+jzfyrHgtVCGpQms5NLh6gRvN0yA=;
 b=o/T97aWWGSCodZ61Fc37LWFkOq6wV3hjjJTG282jcUwrZXGO5CgvTGFr5ptMS5AwFaxVGAJNSusEI3YLGuXYZd54sOKLVZGWFjopKChV9IDZgG9FHo3TEqG016yakLSa/0pgMQrH4hF1LEsoWiRc0U7BvXCr46/U8778TwXWFJM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB9601.jpnprd01.prod.outlook.com (2603:1096:400:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 23:33:05 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 23:33:05 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [QUERY]: Avoiding tree wide changes
Thread-Topic: [QUERY]: Avoiding tree wide changes
Thread-Index: AdkQ3ZNAHjEi1KSETs6AtIVh9KGqjg==
Date: Thu, 15 Dec 2022 23:33:04 +0000
Message-ID: 
 <OSZPR01MB70195709C33AE5168BFDEFE1AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB9601:EE_
x-ms-office365-filtering-correlation-id: 7a59b62a-c2e7-4bfd-78ac-08dadef4b70a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tie8S6lGmegiCrcoH8wDFXAEZG/daupJ+q7k1Dul3Ts0RQmRHfsJWF/SE2k8wdyROB6BK79NuZuYwLSmWsKUje4mof/lxVl8EE54e6t2xTBpyZP9JwiGY/ksRl7XgFXXonUKR4AflHvUJ0/TO+3fkAonWgC0fCy0/GyF9efqRUOuPcVGBdi4DZs6f8ww0cHZsgR080rJhYIbS+KJQGlmlYwweN/x+I+bxgY3xlkZ6pzFEylJ+O/0fff2/WntkwHB+4+Eelmg2ApgMsvNdyMUKRaQE5Gew85OmoF+L7Mos87v7HlP5hQ1cmcYY8WwN8SLwNHnjbDnu7OScgdEb5Iur6CX2f1M4vv1dxEA8Gr8MGv+SOzwnw7DFwEoCChrLU9eURxgVyINF/wgJsMnmZnS7IpnA9EoXeebbxw+NrE4mb5VW9Z8dqIICjiUjogGG9+7O0vU/BBi9uNcKTN+r2XOHG4BYrYSVmZEKnB6MV7NnCxNBcs8GQMjbDzf6KfK3mR/hjcDwjr4Mjdr6ub/+OOw4sR/HOHSMeThguwEA10yF+D/OCKzsPsQQJAwqbs9v0CKUXlEIp7uJcZcXcNUfRVh+GY2ooX0TFDvZOGj35BJ8+7YG5wXNfRdPXdv4Nn8SpevW2rZ1lK50egRo/pXK5+WUMVMQLaHVE+PmL1I7XOjcyyI7KzFbeRh9A3B1kQr+AoXd1QJBzQZmOf72jCvWD0r8U8yaaRtZ+PahlqT0B1rby+ZQDaoI0efCn2tEtux5vpfz9ybEpxaFNm49qMaE6eFFA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(8676002)(33656002)(71200400001)(55016003)(966005)(41300700001)(66476007)(2906002)(66446008)(52536014)(186003)(26005)(66946007)(9686003)(64756008)(478600001)(86362001)(4326008)(66556008)(6506007)(316002)(110136005)(122000001)(38070700005)(38100700002)(5660300002)(8936002)(4744005)(7696005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?avfUhTjHaK31mmRfxFvMq8Xao+JPcaUV1GpSO3EMnv7L+KGipbqW54148V47?=
 =?us-ascii?Q?aRzUsPwdx2/dP12gwOEyWgS7t1zjpBkfv/toQbRkiNMIwsEJ2mZTO6EYBECE?=
 =?us-ascii?Q?/WXtR6DljRBRfbLKGdathrFU6MkGjeXxLYyoXT18LExUXFGiaS0ygWL3Dq6u?=
 =?us-ascii?Q?zG65/DI+Oop21HAAapczp3mwC/v0jf0q1ELKtba8rop9om7n0iKuZeOVwteG?=
 =?us-ascii?Q?JNC9Ih+4SQ3muAnNSraxaNIkjStCtFLQb99XToy/D+aJqJ+aTGTThFbE6FMa?=
 =?us-ascii?Q?HP4kzfxj7zQOg1jT0OEsWo4hXeDS+1w6caa+0IsBlJ2QR7bjknmEmmn70n8e?=
 =?us-ascii?Q?JiOqQSdqSeSHK5DLEWmfbwl7FoW96LGghYf4q6yqVzJjQQxw5AjTc8dqexZ2?=
 =?us-ascii?Q?tvFWG4g2A/GJospN1SJsleOW9pQ6hdjw+UeoznSi/uUJzdCbvqWHBWdL2qCx?=
 =?us-ascii?Q?RbVgeauAnASyvtyvQqpjKkuyOcGiFKplERTaW9ddws6kGexS4xi573ZT6tde?=
 =?us-ascii?Q?1pF1TMqOV4BD4AuylV+p1adEDnwkgGXUpCT0s+i/8jAGCFBQA9n3HGlxUm8I?=
 =?us-ascii?Q?ScTtB3LPuJptkODuWLlMzOcveQAg/nrVcJWn5V9F9I/pghNuz3+3leTkamF0?=
 =?us-ascii?Q?rKv8KQ4pJSE0KEA/PSiiLvaV5TZorJVgHINfH8JNRR5ERXvhqqjATW2SWttT?=
 =?us-ascii?Q?qFHd+guVlmCPHJlFiMN7KAnubLs9vw4nAEirAMf3XGc+ObqYuooMzcUG5x6M?=
 =?us-ascii?Q?1HyCxD56tbUPVO8Ksb129iQx7PKzADAxVLWjvNoJs7UUEeT5OX2fgQSeyOUx?=
 =?us-ascii?Q?XAR4v5pNFuDrG8lsyhZh3uZ0psLl5PwXd1xKDJE8oKorvLZ0TALjxpREypyX?=
 =?us-ascii?Q?9/On7/K6dPUuyqXWaR7d8coqY01WvU+Df6fkw786iqKiEuABmsk83tuADYAj?=
 =?us-ascii?Q?AA0dtiJ/qq6ByarMHSCGWH8suYQB4itLI8ntQOECc+q4ZE4PtZg878XVSycT?=
 =?us-ascii?Q?pjnCwMJcfYZzo314cLcU4a2dH0a1u8Fqig+aGOAs7PWruKBE7hD7kvlDOPpO?=
 =?us-ascii?Q?qP/bZZiZqV/MLEHbhBn9CNDBlbhx6sDk7vbmqI6kJwB57fcQmDUfY38WL30l?=
 =?us-ascii?Q?HEz8uzrDvC7vAypjbXjj06hnzIyxhW3jmCJBvd8VKSMEe/S/m9wJynvVfVpx?=
 =?us-ascii?Q?2atiK68B89L3/tBal8DsuDN0+kbnikU7P9uR7hUl+tGoKfYreTduyhmglWQQ?=
 =?us-ascii?Q?SavS1KLpP4KYRKJ8Arkkh3RUh5tav0xvzhZnuipsXTGFpRrWdMwK5CLMrNgO?=
 =?us-ascii?Q?vSseTWdID3gWiaJBy6Tro2+5s7HO2zyeAnf105UtBGXZW6y6BzhzwGvrnsj5?=
 =?us-ascii?Q?yN4gYpG9TDD8GgGPDuOGkmqK8UFnKDFcOndA/0crQJN6Id15ObNwcg/a/QRy?=
 =?us-ascii?Q?ktGMImy5EAGCaaKYwvUnoxerfh7gF0th2ZGE5NQImN0W6i4/nyawJLSQIQXt?=
 =?us-ascii?Q?WghTQf8iKCN1lDl+hYGMfBzrrY0TAClMfQu7Z8Xv27wokmNykkLSkwPzXfUC?=
 =?us-ascii?Q?21j1yF+UoHJy0ZUL8lblddJbrBkR0k7Und1202FLquqtCZyd5DDL6xy3bmR3?=
 =?us-ascii?Q?/wcfH5m79vIQtU+iYpM4e6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a59b62a-c2e7-4bfd-78ac-08dadef4b70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 23:33:05.0027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRIU9aS24SShJEwWIqKRYx/44m1MiWZv9c2p1ZjIaM02TD54vcmohn6sDXO88ThquZQygH8mE4DidjFzvcAh+X8TdI2AxsY+TsFh9I7mETNHi6SFBU8NbjVBsvALWsln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9601
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Dec 2022 23:33:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10235

Hi Pavel/Nobuhiro,

We intend to backport IRQC driver [0] to 5.10-cip but for doing this we nee=
d the patch [1] ("of/platform: Drop static setup of IRQ resource from DT co=
re"). The problem with applying patch [1] means we will have to do tree wid=
e changes to replace platform_get_resource() -> platform_get_irq().

What are your thoughts on how we can get the IRQC driver to 5.10-cip?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20221215&id=3D3fed09559cd8be79568d368ce02bf7f2d56259b6
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20221215&id=3Da1a2b7125e1079cfcc13a116aa3af3df2f9e002b

Cheers,
Prabhakar

