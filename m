Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E66C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:47:31 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.111])
 by mx.groups.io with SMTP id smtpd.web10.366.1686059242330925027
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:47:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=wvqqGeit;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.111, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSkIgqO/nf3Nnqsk6paOv6Hurc+7cYNV5GX/HoYCfKY1LA189rWL7XReXZa2MMz/jepRJ7CkcbnG9udcTl4PNRuGyStNjir9lKE5Oal++5WYFZvVzHsGYiQPZKuStd2tC0Fi+eehIdaNBF3J/xd9/DDgDRyUoxbBbsAae2HKZzjVpbybtpLTY+X4cz3md6oWlQ3XSvlz/uXzMI+vl2CDo24kUwITR8YF20lc4wXiJVztHztDP3MlIFwfXCJpI/t2hZziG+aK5VhuY/6QXiIt156XlhIgVYEzNB/iTSUQB1hFPaLF5wNAlhSKFgmAnxUxjgWyobGJBKW2w4rGnEMErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDc+cZTVAphb7HI7wf5dRjcprARsJJvK+ZgBm7Pa3Cc=;
 b=c1Yz2amHILrhzkHRNIR1lFdj6INTwYNhxju40YVVgHKFCr4EC+39Iognlm8rRReGGXyvw37Uv6e21kjytFdoPvqcMgQOK1+7W/ASfHVkMPRKvTzqbZVwK/p3+C2pbmVv8/DsHq7Mj5tjwtk64AIoPWdfYMcboDJrc1UrJp4oxqIMbE3U7bYGRb0UGdDaaoWQp/txuqVwelGsN4x+uxV1LnOxxgSomz0zJQVA4eFXm0XLx2z9E7/kwdje8Zmz3fkpxcT4c6E3R5LTDeMmXPYPbPoZwUMWP7dOdjN95cyOL11IhVk05qmotA5bEI6KrmnHyjIaxh6a178kyw6beBXDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDc+cZTVAphb7HI7wf5dRjcprARsJJvK+ZgBm7Pa3Cc=;
 b=wvqqGeitDhuB8yL7JpboB3cHe49jt6I+PTV30+JiqlkelbZVE1IOQV/6IQbBNVfA9GYuARbhRV79m7BgkZkloHI441XuXCoYLNj7L12OwjwIRu8HiBnvNCcbA8s+v9H/BMqiKq/8nIxtbdjs1f+dgCAdlvqw3XfqjkrmYcw6Dtk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB11830.jpnprd01.prod.outlook.com (2603:1096:400:3ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 13:47:18 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 13:47:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Additional configs for supporting RZ/V2M and RZ/G2UL
Thread-Topic: Additional configs for supporting RZ/V2M and RZ/G2UL
Thread-Index: AQHZmH1ob9IJ+rBV0ku+aHk2MMD2ug==
Date: Tue, 6 Jun 2023 13:47:17 +0000
Message-ID: 
 <OS0PR01MB59227A222C00760C832B9B9D8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
 <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
 <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZH8RSUqIcbd35Dmx@duo.ucw.cz> <17660D31D9770B92.16722@lists.cip-project.org>
In-Reply-To: <17660D31D9770B92.16722@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB11830:EE_
x-ms-office365-filtering-correlation-id: 2fed4e64-7ffd-4857-a37b-08db66948b3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 a9PQpRhIiQJBF1ywYbX5Xrz2GTLE4YMUac/pB6dCeoNfz/lf6jYk30ZEz7tPt7NTR5Nv8d5ZZ9hKYdS6lx2cPWaaTNPcWm+VWJtVukASd1z8YGU1NIfGLJZt3uKbVDcDvEYu5td88Si/jYhr4oPpi2kXV7wyBG0QrRx2M4NLVCrb5AMrS8rx09C2CLr/KjW3EAMP2Upx28SdirkaCg4eFtOmeV6chgX1a/Dh4ZxHFzqnEGnttZyLbTUkuactrK58zJv2Mvlb1ob+H519kqFF9MQyWIaSG1GXkhNDZYQBpraxZbw+ArIcy0m2VVfMnl28n1NKEYOJRaqhdLDgJaXY0r21nIhRle/q9Yi3eyu+SQfCAoguHApqSGYnClGOX6yjDNyH8SRuYWlQAOiNvbOk7gFlxUSZriAk999wFyG+yY+aY1ZPjAfoYEYc13Si9ZmXxXY1Qn3n4VH20T0qoGT0zRizwrGrbjRnhaMjeiihOk0jN/YuvqAZRCfhuUudh+ZvW+IyKhfB6kSbb4WYQeAoHM1QZDHAewwAp+sjyN5/U2bvfigUAIADl0PKQk0U83ro8+Eb/uF5iKpal4sku2tgZtAYIIFoGwvF+5h2R0/ghuE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(9686003)(6506007)(26005)(966005)(107886003)(83380400001)(122000001)(33656002)(86362001)(38070700005)(558084003)(38100700002)(186003)(55016003)(41300700001)(5660300002)(110136005)(66446008)(478600001)(8936002)(66946007)(76116006)(2906002)(4326008)(64756008)(8676002)(316002)(52536014)(71200400001)(7696005)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Sr43VHn7m+yIHxfc0bH/6HwG72sSlJI6dXN+8kF3DDet2FMavOOVOufAuBRS?=
 =?us-ascii?Q?9ZQ0TvBWSVPKfcA307G86H/u5a8hTz+TE7DmZ76PnI+gHRauvNDE/HtOfppB?=
 =?us-ascii?Q?4BQGHfyQAIhhH7MO47kXi4KUSvGDYOoqYcL+WAE4PJHFFaZDuQgKq6GDIt3/?=
 =?us-ascii?Q?u4PfLYp3xlXouISjZLmLtTXSPiZxccPJHyfEr4aAnCgZe8+t8/9bp+4e0kze?=
 =?us-ascii?Q?K/ywqpHOqZAUnVJu5din1RyesGFUmJ7XeZP/YmnytDCjY5jVOQGWFras6jy1?=
 =?us-ascii?Q?xls60hyDPW2YMJpP0wCXJSrmCB8lql0D/lP8yu5ZoDA6olmMNYi15ZiNbvUq?=
 =?us-ascii?Q?zQl6SBYkFvNsAtYa1juaoH3CfsnaF2O7mfBDBBLq9EuIydyegX+rlfPbs77f?=
 =?us-ascii?Q?3EeLs2CSZzu3k5WYfg6U9aYC8JhjmfGcQphjP+pURMWVFP3LbZG4f1B3I6wU?=
 =?us-ascii?Q?3znBKDYNIZKFhpwVHPKPHd4z1MCg0gSzV0O/lV2c9Yco6tTo0vq9mPgaC4f+?=
 =?us-ascii?Q?Ov5y69BrZ3Uaa4owFj/OWwI4aIoXjp3zDMYq818XlHUV7kAHgx3P6FG+1pQm?=
 =?us-ascii?Q?WNbJheEHDqSEDo5ckubq6kzQOg51zFYCLwFTgOrvulsVa3RrS6UMYOCG9M4f?=
 =?us-ascii?Q?S4TK1bRyaeOTpMAniAVCoVsYNQupeKIaQhR7Fz927wLG0e576u+bmTYVv7b1?=
 =?us-ascii?Q?3IxA1ZEINwNBy7IJKqUtRUONqFyPEN1UnO1uiUYskrpOGwGSAyBk+5obZtZ5?=
 =?us-ascii?Q?XiqhED/fmdfP5kVrjBfICJOBkZEd0kGrHB832VYJ8WA+/DgR5OW6B2B8INXJ?=
 =?us-ascii?Q?mZM/pUGmpGZQlcf1WQgU33pFEjaBNoCByamiQwrU5a0yHw5PvGdDpgslZnJ1?=
 =?us-ascii?Q?4Na3yEXTCpYyCcUoNmXI1LKWbCXbAVmkOG2JQs66JdWou18K7ECxGHak/4uL?=
 =?us-ascii?Q?hcIriWD8+WgR7ouQ/RPYR61+F83XuTS5DL/k9qNF3RH74z1Hu7Lo+z3crAa2?=
 =?us-ascii?Q?DububH1rL1eE3eM5WpCf8udJIo0d3cJm+/UbJN1pS0aiO1rMgxML51PSk/vy?=
 =?us-ascii?Q?7XqMuZ2Xbdjk5jI58o+y4Ht+23JUWOZ0DV0XxJvxiABcxAZd+2k7I5SocnBC?=
 =?us-ascii?Q?dX/D6vAYyntJ4gX4APLCduIqHuCM99JwaWovfurq85VmBGtkiXFn+A1vRyk9?=
 =?us-ascii?Q?90yEz24j27npCDqkZly5yP7aTMrNDsjoN7QHzI5PanGprkergHAn+/2XQ5AF?=
 =?us-ascii?Q?Rw119JELxQPuxxnExPcwcbrVhpWfgtOKhaennQ8gpSSpgoTbMcqOEeTar/RS?=
 =?us-ascii?Q?nmXEhBahdlXiJbIkKuycK2KOYoaG+RJ0Q2UZ0tHe4W3fX6PtzRrvILH0jxHa?=
 =?us-ascii?Q?X17SHq31gKU2aKrVDCl8lGRhYlbonhG3fP776TpEUNjv1SKrLGXQkLtaKXU9?=
 =?us-ascii?Q?zKqzwwgZzXmhGZRLTRPssoU531WDIuFtGTxzXRfdsQbR80Uz5HvpuFRVOpz2?=
 =?us-ascii?Q?H4sjmwhexINF1FS1R9UptgJHkne3HanBXPBAJQdd1F+R6vvlGq0jqB/Rqime?=
 =?us-ascii?Q?1BnIIKHu0tonZ1tz7ma8ch+Suuj1AlfMUqp759tKcvJL4MmoJU2pxQBn1zZN?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fed4e64-7ffd-4857-a37b-08db66948b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 13:47:18.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tE6A8+hNa2I24FT95cC1kLK/XPhvIc5wdDaJ4G5Dw8BpRxSOMzYxKd9F2PyaiXJlCSlXkQZ0TtcssUkhkemxDWZ6NegztOpZZv2x8m4BRhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11830
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:47:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11891

Hi Pavel and Nobuhiro,

I have created an MR for adding support for RZ/V2M and RZ/G2UL SoC for
{5.10,6.1}.y-cip*

https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_request=
s/81/commits

Cheers,
Biju

