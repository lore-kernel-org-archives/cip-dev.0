Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D5C388F3
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.131])
 by mx.groups.io with SMTP id smtpd.web12.5646.1650611017972641375
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 00:03:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=QN45aVu5;
 spf=pass (domain: renesas.com, ip: 40.107.113.131,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6sfKc/EeqBVoOqjy96B9DfyepCeJTv8xa+hq6U8ON+Oy5ZG5Vajp+rv6vj4UiOE67VUzUgrNq/lqTmWrl9xDHg77l8bD/97d0HX9rbC7FOf/ylRcqkZfFsBI6XAf+MJmKtQAPrSORqKJNI0HW7VszBuKEuZzFFYxmFz+3/rQlX7vM2z+wegzGtHu4wlR9/NTC1dIr3CVqqlPcR9iEDDTYzxe+U/iOFJl0Tc/G8VgEq8pw3lidztRa7KNFXrZX0J1Q73Y/AfvPIeKbXf64UNPBUti7pltUzLe1gWxckJGU6B85rMJ/namr9Do3Ny9bBrXyzFxhOOhhJf7LMrHWvgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKYv44mdRo5MklW9BE+Trh9B+xGv/Z/Jo/NDvw2tBXg=;
 b=A/xpedtqyJQLWElEEVPBkhkJSBmaRBv+NpslaRL2sje0x+m/1i3N3Gg5kNDK4oq9IOv9di7UYLrdGRWMcEfLtiF5KpfLJPDx0ywQvdV1rWLWj9Kcnyz7BrGq7lNiYqdOveJMqXMppGd5gENpioTGNlIKSyZBvw3Y22PaYk6N8m5x8bWbDCbRBlVjKlZhj9MLKzTwKetYp7dF4vSUhwE67/dkb42vqsiu/p9oilE9Y1b3JoShgAhbdbfDU6QTxawoTqjhiTfGxFE+99fodHO+sAH4lasq3dcB5wtb9G3hDMASbQR8ilgEP1OvR4+TEQR5cA82N3WCxxYJ93F+zL9zmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKYv44mdRo5MklW9BE+Trh9B+xGv/Z/Jo/NDvw2tBXg=;
 b=QN45aVu589QIU/u6NTgv35TbfXw7yzxoBzoCqYLHUKAlkkwqtNV8W78ipCZSg/UUKPh/zoZCzQXs3jlt1aN9Xh2PqoKud5Ea80PuS4fpgas5v8DqkLNiHI29CWanh6w9TSw/xqDqazXX0WLHN/qa3nXhImK7H6etw7vxa66N1Mc=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by OSBPR01MB3013.jpnprd01.prod.outlook.com (2603:1096:604:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:03:32 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::cc79:534f:2195:e5e8]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::cc79:534f:2195:e5e8%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:03:32 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: gitlab quotas and linux-stable-rc
Thread-Topic: gitlab quotas and linux-stable-rc
Thread-Index: AQHYVgyL/OhSLn7ag0uW1WUx9AvXeaz7gZ6A
Date: Fri, 22 Apr 2022 07:03:32 +0000
Message-ID: 
 <OSZPR01MB812492601D8BE4113AF1EE8FB7F79@OSZPR01MB8124.jpnprd01.prod.outlook.com>
References: <962465f6-8d5f-93d6-1a51-51658c80e167@siemens.com>
In-Reply-To: <962465f6-8d5f-93d6-1a51-51658c80e167@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 012dc169-0426-47d9-4632-08da242e3683
x-ms-traffictypediagnostic: OSBPR01MB3013:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB3013F606F8F0D4AD3251ABF9B7F79@OSBPR01MB3013.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rQTSnEyM/0KPwindcdq89s0YWw22mX/uArJE5wKIVl0iSmV/c5zV7KNrK/FRsOlQIUutLpB5sIozYJMElvvGK5mmt4UEd3/9r2NkPOSpEXP1SpQfEe65nYayazkscpDXIOcMR9BnjB5E0ndOsxFooTUB2RzssGvyi7X3Tz/xkUhbITDAaArS6YPoodluhpMt+geroTCc7H7MntM4iAPq1RToXQsoF39lS3jljgsK77JtmHUiXpNo3qEotyWKrelEw9SJhTuqosJv07SQZbvkuqqm7fpakiHVuSvy8AMDSqeWUe2oNtk7rPcHQZ7y+fcduIRWtIhXTq5f+Wo1geKNRrPI1WgmYky1paF+rGLR4kIHU6qjLigbp34BCx9EZqW2QLa3Q+v/3mv68J9xZTycw6YPeAkqqY5S0EYJVybUfFu9CJara6H80mzSiAtMKMmSN+TcgFwb1ZMgly0NqVOG3dgw19GEqxeP0FW1804JVmU5EWU4Pro4oCaPOik8k5sj6adYjqxSSC7hOoff7TSvLqM7YcG4PGdeXW1mcIjkf8XASKPpB7PR9pT5hfbk3YiZrCpoBM/let0UlhG130KhdPuCBfHE+73qGHKhgW0F8tMYpnvcOa4SeNhEOAaDloHkPjI5J7p4BNXXklh1OfeI2WG9WuFOLn1cpb7Fp5EEaVxNkai/OFbV4HLwdOOBTlvbxqCkBQeCN+0EjFkkztqV93V0sQ146IsZ2aXqqRJNUnVFYLm/P1+4x/Gm4ggWrIKh0TJVEL3kAEi5Qgqj3JqRt8gA+2/7WEMZxDLCkEdOt0Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(55016003)(186003)(64756008)(66476007)(66946007)(9686003)(26005)(83380400001)(6506007)(7696005)(122000001)(66446008)(66556008)(4326008)(8676002)(6916009)(33656002)(38100700002)(38070700005)(86362001)(2906002)(52536014)(15650500001)(71200400001)(316002)(45080400002)(4744005)(8936002)(5660300002)(508600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?dJAMN8FqzApRhRsA2PEEC0Hff6awFR8Jx7b4tqHl81wY+lmrJHNg/FEn?=
 =?Windows-1252?Q?nIoZSyANFLYuHYmumQDJ54RMcsJp+24CRh76RaH7vHw8Jbz0HIaw3tgb?=
 =?Windows-1252?Q?v6DfnJwS74wV7YLjkPkZfONpob6gcs8ZIGFjy8zTCVVvKN92yTIYK6XT?=
 =?Windows-1252?Q?llTqs/kjVWi3irrf7g5ctwGODClrjsTj5GZ5VAg3Y6nCTsJgan6TgtXh?=
 =?Windows-1252?Q?4pNLQFTZU9wY2nR+ek43l426Gw29uYjUwzi/PkuGt0v9ZHYZuxVGWFZE?=
 =?Windows-1252?Q?wlVzVCJCGwd8aEwR2tYNHjA5rSSXf5V/kWCUkxG+/A9qbVHN3ejipQVy?=
 =?Windows-1252?Q?Xm1MPtiAh85xM4Ho8DQqsjQzyvBIqbizF/NCv/kUmWUgL2A5uVlF3zx6?=
 =?Windows-1252?Q?DGWLXTdVoVFw2usDBC4LFIy+yRqSqHAjoGibndmmWij+/WGk/2aCNbvX?=
 =?Windows-1252?Q?/LvDKqqx/OEfUkrZVA/vxgHiMQ1jm5D9ybBdGpTfNQ137zp2/8DqeczR?=
 =?Windows-1252?Q?Itjh+zXgOlQ8GdgiSAXtgHtgGafzc6XAaxL690TeJwL9Vue9P8gAy0PP?=
 =?Windows-1252?Q?xjlr/AeuSVL/d+x6gpOtHXf7kdvwaoQFA+42J7vuU5T8jrM+rmYk3jj+?=
 =?Windows-1252?Q?izjkCN/gIK0IRWzoj1mbKiaKuC89qIPrJuXAKI8unAo7tUtZHyW3qKSl?=
 =?Windows-1252?Q?VbFqzk8GMxbku1sBg2DNNR5Ol3z5Pld3tb7WAJR/3mfhW7gL0ozDdsGh?=
 =?Windows-1252?Q?iAsH3jmPmKNhYJmDyvUV6ig/A5aJYdJlqXIkHHXOZqo/9n43jt7iSd+H?=
 =?Windows-1252?Q?c1DmzDtMMg8qmHqPCa5OTqXvzwrqztSgYEcGMNrrztoMgeHe2p6K2kz6?=
 =?Windows-1252?Q?1BNCpgG9Tr2rOqiLbUSfci89l/CJrpBoBV63lMMs3hiv6GOXZlu/Nwar?=
 =?Windows-1252?Q?lzymK3v+gKfN+z2ByO2w4y03QKWiCMHU51CpgIkmHLLq1t4onm2DHhAN?=
 =?Windows-1252?Q?KK6dgDZJBk7E0pQV4jrTzv3u/VUN72H2gJpMcmlv7Z7AgK1pmqKUG4Kb?=
 =?Windows-1252?Q?walrtr6zm+Cj7JoqOYVuESYSzR3sys8LuJoXjx6hSYO97JGpEF+7CVJc?=
 =?Windows-1252?Q?XlbQWc5G1nteiDGzIBKIi0Mxd1P9DgS0pO3+3F9Y+f7kbqNMgzl7tef6?=
 =?Windows-1252?Q?btqRiZs6WVJC+NbidEbHG1n775VKmB4jpI5byPf3bRyh/0bZmWxAjrdq?=
 =?Windows-1252?Q?XRVMP+f79REJMt18lGrcf6GBg8zoH3M1SrdC9RHXWLn6HkM3Q3iljUZp?=
 =?Windows-1252?Q?WsFTe2OjMY8J12lxfvEINNLukWAj58o5rehtYRVQz8NcWyUHkEBp2wpo?=
 =?Windows-1252?Q?8iWCEmV4Ex2WLDx4VCTFDVtON23BvGiA9rQuB0JbMqsOZaNFdpu5k0Y7?=
 =?Windows-1252?Q?ImXZDLqfK7+v/i0AlI/XrtN4RR+r7joX5k+WZnMuF4499juG7FPGPAiL?=
 =?Windows-1252?Q?ig4BQie4W/xn352ykUBOHjZ47h6EdsHr6RX6qoFgoaZqaIBLA0ht3Nlm?=
 =?Windows-1252?Q?JD89xsSw7zKP+LcOr73zWgPk89x721B2qWYSNfwLxqP/UsolBUCNRsJ1?=
 =?Windows-1252?Q?oecM089pMTTal2RyN+XTmVdXHuLq+H+waS02P+Mi6Q6x8r5wiCyx1oZ9?=
 =?Windows-1252?Q?0NWuyd3IndT4QR7idQ6LQnf+kH4/7jNlw1qS3gWopzhJCee4zfCwrQ/M?=
 =?Windows-1252?Q?gtfn1x6BpS3YYd1sthcoqGLvpgH821NLejucG7vpKte1CbkHiAv7+Knj?=
 =?Windows-1252?Q?/tG199TcvTPiv2swCUUa38OIZcuuTYp/tdhVaKPAt+SMuOIgWD6uYr6e?=
 =?Windows-1252?Q?klNN5O3qikeIW8pgxxFWDNSALfmjWkrO1Xk=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 012dc169-0426-47d9-4632-08da242e3683
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 07:03:32.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 E25p42GSbyJKZSmKhVDGvGGNn0CWzr1gxpuBfBfj9Nfc/VpOg7NMvwOnqv6UXjXCUlVDog13vavVG25OJ2jF1eXrMn2NN5k1J8L65k4Zm6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3013
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8174

Hello Jan,

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 22 April 2022 06:48
>=20
> Hi Chris,
>=20
> seems gitlab still tracks linux-stable-rc:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fgroups%2Fcip-project%2F-%2Fusage_quotas%23storage-quota-
> tab&amp;data=3D05%7C01%7CChris.Paterson2%40renesas.com%7Cd08c7667fb
> c54e6fcb5808da2423acad%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C
> 0%7C637862032882240086%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&amp;sdata=3DhAUL8ukZD1FaklEH7oIwfX2IONMZQANmfcrDObU%2Br
> ww%3D&amp;reserved=3D0
>=20
> Should we simply delete this project, not just the repo? What is left in
> that project? I don't see anything.

To be honest I thought I had already deleted the project.
I've tried again today and it seems to have gone.

Hopefully GitLab's storage calculations will catch up soon.

Thank you for reporting.

Chris

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

