Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64000C4332F
	for <webhook@archiver.kernel.org>; Thu, 15 Dec 2022 10:57:11 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.139])
 by mx.groups.io with SMTP id smtpd.web11.130963.1671101821138132556
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Dec 2022 02:57:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=eLG4HHWb;
 spf=pass (domain: renesas.com, ip: 40.107.113.139, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0jrn7+syeFjsE8Z59NbKGsMeGIBfEca+7dHc/J9sCNHE6T6jVmTNLkQ2otgMQ75Bf7pdARjd+gQClmlVVhKXqJg4dvljg+SZNnMdJhghpfiRC2uSIasr04Np/YdvPzSZJFr+Vt7iUsWcpVakXqXu++4gO9JgWBCqclW63WG/ocJyc5DZCufy3mleFQNQFgOkOQZS4bkh8R6oj8OBblfzIkLcwPq4eAY8JT4FW/bY/XExAiTJvNb1iQP6R8V4WZiEJ3mpArnQw30fjPheNxlusmsk/irD1rAP9g9mmbuqaVNJQzLE6RzeOKblZVH39Furr63bQZtqAL1/RpxamwSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/No8PbUmceRED4JGLuCOLYr7wZcEfWcfeLJEKxuwUl8=;
 b=ceoJYfGrr9Mq9txC8od7x3EtlgOsORlU91u6aEcokRLdoSK5GZQ4zqU5vaVYL2po8V+ZYnBKrKr+bftusnryyuyf92OaCOY7L2BWEvAIR0CKjn1I3Wtlmhgd0IUtGl4k7KIsbv6GFVBR+oV02HR5gcZcJr2irPVo18pZ3514M+KgVmKb4OiN+o6DJXix/mu/lnST+l94nJuvKnDz6aadzFx/T2YgS1qn59vmPvJnkg3/TsAVWQtxLnW54cMRRZ+2d0dnAtFOPTM5Boxt62mtSssgwbmy9R7Oe7hqir6BpdkSZWtapxwgPXDh4mOwAR0Fe6KEYW1BLqq/WdYqzArT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/No8PbUmceRED4JGLuCOLYr7wZcEfWcfeLJEKxuwUl8=;
 b=eLG4HHWbBU6R81lr09/jWym6/Gk86amGvw9ywrtDPJNjoY032QFiYmRkwxHfZDjLDBZjb0dYkDAwHT2jZxiTTKFlVjj3oK9Xe00j/yCDF3hY1nWSr9aS75K6tC7pUOlHnhQJNHDjW/76+6RVP9lhbm5VD9jgDnU4Q6apMtOYdhM=
Received: from TYYPR01MB10594.jpnprd01.prod.outlook.com (2603:1096:400:30c::8)
 by TYWPR01MB8888.jpnprd01.prod.outlook.com (2603:1096:400:16f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 10:56:57 +0000
Received: from TYYPR01MB10594.jpnprd01.prod.outlook.com
 ([fe80::35c9:5107:f124:36ba]) by TYYPR01MB10594.jpnprd01.prod.outlook.com
 ([fe80::35c9:5107:f124:36ba%9]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 10:56:55 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHZEE0sALebmSxgyEuhVRH40fsLYa5uxaIA
Date: Thu, 15 Dec 2022 10:56:55 +0000
Message-ID: 
 <TYYPR01MB105941B092F1CB63993F3245BB7E19@TYYPR01MB10594.jpnprd01.prod.outlook.com>
References: <5fbc358e-32a4-f64c-4af8-842a1344cb8d@siemens.com>
In-Reply-To: <5fbc358e-32a4-f64c-4af8-842a1344cb8d@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10594:EE_|TYWPR01MB8888:EE_
x-ms-office365-filtering-correlation-id: bfd004dc-c562-42a6-2af9-08dade8b14d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nuBilQdzkweT6YjBQSWzw7fkOQbGLPKrT5J+yHtY97F6R5aPo8WJSjKLaHB6oJkdGjjdsBCgV0BsCRMPw0zW2i2pIRnN/tnYhyg52VJxAkWbkpy2FZ812SX1RY/8Cscn7h7ebNfjC3nu2Xg56MTWgcZGjIGUqLkqRmwAihM8c89cHY7F1hpPLOPWlzg1qb+7PuDkgjn4q887s5IIiMnOO21qbJPGsghdiucQ/Z82v8R+5YbtFR21TfbDHAWwYWYm7tKaWQbCjMWYw6MZQesVmiqDDCglus3FOqlCFnG5FTcshF9FrhOX+ZKQDcCne8hJE7haw8NOB9ENXuZy4s3kHu5knue1T4Ao9d2TGpW9Fqo3mnxyfo3/XTOtBYHAp/VcbNIWgRvO6RaGDI7TXtYFVaqsxiJk2A3x/zqSrh0SepyixcxGAvKuL6+6AohYQKB7+EG1sfwUvV6kw4O3UVsCulpOhYLWEhi7zcyYFcFAE9mlGjuDovVicBovls7ORqIIK/hMPPd5/bO58r1OahP4WSKN6eyzyu89LszyYtAwegddQSHX7hB1OdqLMiGpfqQFvXWZsVKw2MaCgnWf5/ZuC3DSaEmRkTxaLDP9DijL91rMy34aZs48jJwEWzw4toPpFnYKZXPHSKR87rxYs/Dc36YDAebshlzZ4YlofRclQMZM6I94zAjqIJKObjymkE1TZKwDdemQSwyqmtdWNFFEvZPgzvCCn8mywhRfxLj02g0NmuicB6ySqCG/4ubOiGrW0G1uMxmsjmE0yyTUf3HnRA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10594.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(316002)(83380400001)(6916009)(38100700002)(66946007)(122000001)(52536014)(8936002)(41300700001)(5660300002)(64756008)(66446008)(66556008)(66476007)(76116006)(8676002)(966005)(478600001)(9686003)(45080400002)(55016003)(33656002)(86362001)(186003)(71200400001)(6506007)(7696005)(26005)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?3HIV+ylsPvtQejKj+yWBOntgRWwuhT+ZozEPFWKBQrsxUYMrHIT2n2nO?=
 =?Windows-1252?Q?9RvGCIQCrp+UTXcr7DsG402PCcaGdpMm3zvIBwaDHUy131WqBXUVsJLy?=
 =?Windows-1252?Q?LruROEiGKujRb0wLebZdh0NmCsSrb0D7OX3KTOjWLqJH8bAqsVuJ5RJO?=
 =?Windows-1252?Q?ZaSI/reEpIN8z7xxid4Zvp35yWqla9stqj/oKtm3iPXwXRJkMON/WTZk?=
 =?Windows-1252?Q?t8NV60pA4/DVtZAekjw26bJjbmcIAF16VI2RSJjLgWIw/jaarEHmgSvV?=
 =?Windows-1252?Q?OqKaT5sCn0ecf8OAf0Q9ePFj5qz+/Qx6C0xLsAuw82qLDO0re8TzWyW9?=
 =?Windows-1252?Q?IE2l1+PX/udAdq7sCHW++MJkRr0A01Mhf9IxvAtb+eLlGan+Cq6+T6v1?=
 =?Windows-1252?Q?MpaXU7ZAcpq98SA5d79/UBSzYUn13bE1/OmV196HanuJUcBg5OMXQnPv?=
 =?Windows-1252?Q?VoC+QIuvGSeSyCUTv32aJhHsJF0oXqRE3b7VVS7mAgJzv9XfhhTUKuub?=
 =?Windows-1252?Q?Gr6BVgiIbb2O7MzLVL0jZ2+ghVyiZa+r63/e7jn4cISbhfzNiBRe4Ema?=
 =?Windows-1252?Q?WFA8epssvp2Wa+uxjcM2fgZ2DkyZ+Tg0MKoUWO0X9PfNNE6jjaYgAqcn?=
 =?Windows-1252?Q?pFOR9jSUZwc/UeDkyffG20IB6vCAT+iztCvcfdkO697RYy/lHmNpBvS+?=
 =?Windows-1252?Q?IFhZKsWjZNXVrG9T1w3jNtEKwKTUYNpVTU9KPa6t7kgDcDlEmKqvtoEu?=
 =?Windows-1252?Q?bJq2OjR7cMdCeo+Z4NXLw9UKRLZFg1A0QGvJ8xybV4s3mLnD1zTTs2xg?=
 =?Windows-1252?Q?VHhqXMpKd4iPEKmCGb94csnOFXe3VlI5TEh/ZX0HhJHnkYhZCpQQfKfr?=
 =?Windows-1252?Q?KcgMijwOdhemx2Ztxz1t19uIcRr+P4aXHhRGgDaWGmAjHQhzU9ufHsGA?=
 =?Windows-1252?Q?afilTGengg78zZ7HRS6G5IOUbpvf1aYTG7Yk96wktFhQQnrw6W8c34Cc?=
 =?Windows-1252?Q?9dm4+PKixyKJCoVyas6RBO5HiQ7udIpUEW/n/+8BS2i7N4H+vKlnLMZv?=
 =?Windows-1252?Q?JkxDOPBjj0y74piEWrzu/ck3xv6SRcZaghZA9o91fhQoneY35Al+crVO?=
 =?Windows-1252?Q?CuubuIZtHFYDw420yn2FsjxFMxaZguxB4FUFxqWLgy33g5k4bdxCTeCP?=
 =?Windows-1252?Q?meCuIRNUz1ZQmSxoO/9rn5ANB4r+cLva2+RprshlmCWHldykIkRWbnJI?=
 =?Windows-1252?Q?beXBu3MauM/hBtnSYqZPA2lxoKBvINDp/f9arJKu3EeMqmovf7zplehS?=
 =?Windows-1252?Q?9WEPw9XEiyyEgbhvAJ1PIvrE5l+LwW2wVkSRR+BBGCe6nCZHR3CauWIx?=
 =?Windows-1252?Q?ZD9MZKrzS/EyDJNZjPVmB+UJ9KOm0RJH00VtvOge86F8vfW6UZ4vNdvB?=
 =?Windows-1252?Q?kZHsGTXH47TRcTzCoGcTffvuq/qQ7PVGg57OrNB/Dp3zRQ4SpAm75mro?=
 =?Windows-1252?Q?WVa7Thg/jdxfHyR+n9FtKY1XavYM0hM+YcSmiY9Tf29RRO9jPpjc3S16?=
 =?Windows-1252?Q?dRUN+wVpJnNDgbuTEu7sb93RhyRf1k1QKx/zGaEvgp9W/84hsKSwdW12?=
 =?Windows-1252?Q?IW6UAxProlcztQ1Hk8TNkV+PUnPINmBqTnG6gl3683U3waDRXQtc5LyH?=
 =?Windows-1252?Q?gyCAPjGw0sUKRtn6w5ebyYHi8UzlTHxETVJ9PVkIxdwPqKolFgbl0A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10594.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd004dc-c562-42a6-2af9-08dade8b14d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 10:56:55.6884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImbNczsVfEULGQy/zAHQwrg4GulScQg4+OH5l79xX0veqM/NBnSRbaLBhERMMAmcIyzC2hweRWANsWYW8X+MojOEphwsJNPiJs1Nw/zXqBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8888
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Dec 2022 10:57:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10232

Hello Jan, all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 15 December 2022 06:19
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 12:00:

I'm afraid I won't be able to attend the meeting this week.
I have an ongoing clash at this timeslot since the clocks changed.
Could we explore delaying the meeting an hour in future?

>   1. Add qemu-riscv to cip-kernel-config - patersonc
No updates from me.

> * Kernel testing
I created an MR to add the 4.4-st trees to kernelci:
https://github.com/kernelci/kernelci-core/pull/1544

Question for Pavel - currently there isn't a linux-4.4.y-st-rt branch, shou=
ld there be?
Please check the comments on the MR.

Kind regards, Chris


>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .timeanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2022%
> 26month%3D12%26day%3D15%26hour%3D12%26min%3D0%26sec%3D0%26
> p1%3D224%26p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3
> D248&data=3D05%7C01%7Cchris.paterson2%40renesas.com%7Caeff1477a6b84
> 1c56f1308dade644da1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%
> 7C638066819628395948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=3DWkQydBKcN6zIjl0zdY4rqWVXKePm4b4Q3c2ceZxD1X0%3D&reserv
> ed=3D0
>=20
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     12:00     13:00     20:00     21:00
>=20
> Last meeting minutes:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fircbo=
t
> .wl.linuxfoundation.org%2Fmeetings%2Fcip%2F2022%2F12%2Fcip.2022-12-
> 08-
> 12.02.log.html&data=3D05%7C01%7Cchris.paterson2%40renesas.com%7Caeff1
> 477a6b841c56f1308dade644da1%7C53d82571da1947e49cb4625a166a4a2a%7C
> 0%7C0%7C638066819628395948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&sdata=3DjTafFngTUo2gkfjWhl%2BWwo0egMeTVK37hLIchCFGTN
> A%3D&reserved=3D0
>=20
> * Action items
>   1. Add qemu-riscv to cip-kernel-config - patersonc
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
> * Kernel testing
> * AOB
>   - upcoming holiday season
>=20
> Jan

