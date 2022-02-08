Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD87C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Feb 2022 09:44:04 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.117])
 by mx.groups.io with SMTP id smtpd.web08.9221.1644313441767878112
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Feb 2022 01:44:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Ru4hz2mo;
 spf=pass (domain: renesas.com, ip: 40.107.113.117,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaIWD5dFRFpubp/ldGR4l3BAAjOeluxdvZXrSJ3MsQzrQcXdRdVf0XahnHdww8Xww0HTWQxJgiUV3ud56039nukEdiCZVWvwlqih8Mrij4/A1e/r7vcxrOblnuwxgtbPVnirgrB2+fkDIvSRheKRRn7867EedNhRG858RyS1bXVs26SmQt0DbW09Fpze7QGIcKRY7PqgKfMp4KUTmbctNtG0dQXEpqy1Wqw5UqtwV5iGRe9qaxM3fdVCRcWcP345+Hff78ve4NjNI8Dau0d2CXeEdyOuw6XF7pMZcHvCyuWekV9StFgsvvZTrfVnVie+aJfWx6BzaaRcXEpaBLd7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VsPk89GG0q+ROzgfTsy+aKNgbqX73M0hTm5pl25cbk=;
 b=hg4jIlGpsZo45Z9ACFhJ96kfKt+f8pLS571Ly98UqSdI5acOo323Ui4S51V0nE84whrlY8lR0VZzqjo9MxK+I0yI/G8cop6UyRyjRnZrbyegkwy41eEuvh6+C4/1k6ddnEvyxzqfJdrv7Xr7ehYFlSSKV0GbdWWd1Hlm112clvYBKKcRlx2YcsixXhyepUD9TlSXML1yHXDXDuRAwj/9iksPpuV62/CgduVBbrEZfIsrVvmLfnhFLj8zCPFsDCzJr617XCcXz/nSeLznFexqwKu0SCQZM1egpNs2dJyqW+hL4nMDbUfXZWk089lK+Y6y2sLIvSX2xtmyOWMoeB1GyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VsPk89GG0q+ROzgfTsy+aKNgbqX73M0hTm5pl25cbk=;
 b=Ru4hz2mokFhpkU1z42+0g7SMh365gzK41qFwXSz+w2udvidQxHDqaxNkK4OZ9wzui1KZf2vwlB9/wZEZNJwU6hhqAwujZJewnzjdrEnI2SfrZEKoZhTmUNUIUmP9vEVEPjq57atTT9DCukbZtLYGjy4/S+3NUJSw4AG26wQipcI=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by TY2PR01MB4602.jpnprd01.prod.outlook.com (2603:1096:404:10b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 09:43:58 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::1995:fadc:db7d:f055]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::1995:fadc:db7d:f055%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 09:43:57 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel
 Machek <pavel@denx.de>
Subject: RE: [cip-dev] 4.4.302 is going to be last 4.4 release
Thread-Topic: [cip-dev] 4.4.302 is going to be last 4.4 release
Thread-Index: AQHYF7NMn/0vR/EI3UWFAkZB11LM4KyBa6uAgAV4+QCAAnUfEA==
Date: Tue, 8 Feb 2022 09:43:57 +0000
Message-ID: 
 <OSZPR01MB68774ED2525BD5F8B8AE8414B72D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220201213254.GA3001@duo.ucw.cz>
 <TYAPR01MB625279122E073EFF486368C392289@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <1ac8ef07-4bba-71ef-83da-524c1a717be0@siemens.com>
In-Reply-To: <1ac8ef07-4bba-71ef-83da-524c1a717be0@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 832e5dca-63aa-48e1-fdfb-08d9eae78764
x-ms-traffictypediagnostic: TY2PR01MB4602:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB46020353BC6DF39455913434B72D9@TY2PR01MB4602.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 N00f3VOl/XxXIjTIRUtj7z2h+MIOmRglyxDwB11q2tMC8YNGuPWJmWuRo2ApXrtkoonhkkWftHVOuhIvbXE9DeGShQEcBdTNi+YJT+agJABwRW3uCcl/x+mpL4nO/83B5EgJi+7e9livivmhs8zg3zeP0a1XPmD6FmwtJXwulKRZktkSGIimHIZzZPIAxVKRtFj7ATMcb0pg5DUAGurSMYAbQ3bP1855Y11gQTRz3howgLrrTITD3HrJFhsLLm6A2oQ1uQIfGQBUyR9V/xj1ZGjbUPlBuY47o92zcvWTaoFYePcVfARlrJ5xm0FqDRYpYN9kqrPr6RIQowZcBtqVHUdsPjLQnEySki/SW1Zj4OObt47V4ZYwcgJ6TD0xltkgcZBmIUDG7ddUj5wBHJHY/UYwvQrTZqQAcHTk2VBsWhAJzSxaSyG45a7Sn5LdNioJiAZedDESy1QxlwFBJaijhsAlfqOM8TrYjt6q3D3AOZjm2loZL+cE3lVkQvg2/N4wrgOC8aH6DsaN7q39z2baHUX1uUzEhfODNoKOztvf+FN21tDjKPopVDbvaw6aQQFtttT2U+7n/vMt3BY3v1YtLsrlwJsy5fIqtvj7OweiFUktYkpNsrH6Yg3m4oxpNcDECG3Yj00xD+MqZTLBJVymLMjT1RVwueYPrd06lxTq6X1SyyVuISirH2NPs4tCkW0mZap1gQCucyQOMuLU2EPm7w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(26005)(186003)(9686003)(122000001)(508600001)(86362001)(66556008)(66446008)(66476007)(76116006)(66946007)(8676002)(8936002)(64756008)(55016003)(38070700005)(2906002)(52536014)(4744005)(71200400001)(38100700002)(110136005)(5660300002)(316002)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?t+5vA1X8/qTcHtn4itCo58WDghmFlzFWfA/N9Dn4FJM8swsUEHfaepYO?=
 =?Windows-1252?Q?EnVulgYfS8l5p8vr/9PcGsfBvzNa6PPvZF9ZTIWVV+g6rrZUlwXafeEO?=
 =?Windows-1252?Q?tBZp9oW5huU26da6Mgcvc9WkTzeUpuP/uSuGltANTUa9DwLzR+2BX7Eg?=
 =?Windows-1252?Q?O8BWxrR6eMQZ8jpsYjk1I72juXPU+GGoFPz+BcSbcbffYhoXeRrxU0au?=
 =?Windows-1252?Q?kjTj8UMfNLV8C7ayv1Gsr1D8rgh7UeAVrP45d2VmUdwoKnhjdQsxv/Zb?=
 =?Windows-1252?Q?BMEVQeI8luI/OTtsJdbP4Pq3YHyIn8yBb2lfg2YoRzr86lD6XbYCsf5+?=
 =?Windows-1252?Q?MUn5s6qAUfXTaFr7ogu+hj0UK3LY1mBEbsu3dDk/NWjyxaH/G5VSUfZr?=
 =?Windows-1252?Q?T38KC2fKuGZrg+KQlgBokZw4uuHxZSBa+fSsqIaVlihPI5V6FtCSXoHH?=
 =?Windows-1252?Q?9MwFiJhHjc52gx4rGufEafzQNqDvyL3l6HWC7UUHkr43ILQVg2Gz0Pwc?=
 =?Windows-1252?Q?sdv0FkCBcgfRREBbXORYXDV5VxQm/ld2R+kt5TILEI9qKGxS953PzKER?=
 =?Windows-1252?Q?mFE0Q9s11xOT4xXNkOw4eSUOMDZvi6Tnme5bC36bFvjnbYNCIE36DOiw?=
 =?Windows-1252?Q?Y6XXrhA1l4tl+LdzRp86NvMKK7fGYAjfPXLdy5abm9S8D9kiQiT/0aM6?=
 =?Windows-1252?Q?qZeA0Yb+C1Qv2h1/wd4oSoJxZelEag4BUxQ4fl5aALegUSoUipMAM7j6?=
 =?Windows-1252?Q?akyBohN9CkhhRTb9FR7NtwEbSrXglbLDLOCKK7nTog/UKlX1/yGlTqcP?=
 =?Windows-1252?Q?UqkIrZmXj50DJOt7xKVVzFFP18mJjWdMYkxlECgO4m81dMXeJsPs5w3H?=
 =?Windows-1252?Q?M3HVj/4Ac8lYUUMXWYcI7MSL5LFTyrD3y1RWmKm7zKwn3PWvD3lHdaht?=
 =?Windows-1252?Q?fMfVSH47CYlnDDEEw8DMAaAAIZ/MQOqPYHJ9KoB/KYnwArsJ9f6sCLUt?=
 =?Windows-1252?Q?W5vOUQfga+j1XSyttfPeFFHuEyEy5CLpnBns92gia93AR2kVQ71c8cR3?=
 =?Windows-1252?Q?SfXzqz82W8TAnXjdkDnX93yzPPZoVZviD9Pwr5stOYdt8fPeQRf+niI5?=
 =?Windows-1252?Q?VII1jfmMjFqdhwHtXz534GhLHfN0WxP97UA1ZPqf6fQtBos5VqEUhm3p?=
 =?Windows-1252?Q?Xj2Bl08xgvcMqEJ9vt/PWotqxg1a+o1tLhRXUx2LLhmt8kTNyU7k0WU2?=
 =?Windows-1252?Q?V1THR61o8jZMfEX7xLL3bE2LAz4scK4DEBmADMr/C2q0sg8DFhN/mBJW?=
 =?Windows-1252?Q?CBhzgaOLFZNxK5C0B8dkMSx2S557r5rB1C4kqOHCO2dYyNt/sq4TfZJY?=
 =?Windows-1252?Q?d7A71b4r3rvcjSnAZsfBpqsAdFIQsRtNJB2C65B8y6tYX7I/scrPn7vt?=
 =?Windows-1252?Q?dusmVutNq8jHKqbvUxG6sT2CI0tBgv15hAYWfPxyUYKXBY9A4rhyYOjY?=
 =?Windows-1252?Q?zcFTKNUmGDMSzPltsq4bFM0Uv4zMNrLsOAPKKbYDvNunGGxSdZw2348f?=
 =?Windows-1252?Q?Gvy10msSLoC9vXejznK4vUjci5Fi+1+45SUS464AaP7kMnPR4tTc+7tf?=
 =?Windows-1252?Q?Oab/ntTeKaiq0e/ooseE9EbCPLS9Xlv21f27Gd245w/M5uYlTdf7Syv2?=
 =?Windows-1252?Q?SQ6l3S0q32fHl8KdTCHa9lMkPwHZPkFjSSCZ+vb4gLkCoX6JHliUnbPe?=
 =?Windows-1252?Q?cRvlOjHI+3gufWaViEwwzYPkSQUu/mUoVHeJZZSZGOMKdh6Xag9vn3LJ?=
 =?Windows-1252?Q?i5PZtQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 832e5dca-63aa-48e1-fdfb-08d9eae78764
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 09:43:57.9054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 6B86vJgkUcYbQenjKPv+41M0SVIR7ywhBFWxH2VnTa5FDWv6zJ9jHBtewRh3au0BxuvenPAt15dKuc/JO4svpQTiBZPYUpwUNqwM+TVCNMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4602
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Feb 2022 09:44:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7580

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 06 February 2022 18:48
>=20

[...]

>=20
> > BTW, do you have any future information about the RT kernel team?
> > We may also need to check the RT patch.
> > If you don't have the information, I'll ask the RT team about this.
> >
>=20
> Why should 4.4-rt continue if its former upstream retired?

Didn't CIP commit to maintaining a real-time version of each SLTS for the 1=
0 years?

Kind regards, Chris



