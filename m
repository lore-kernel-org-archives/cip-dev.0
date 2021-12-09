Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29538C433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 08:11:39 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.122])
 by mx.groups.io with SMTP id smtpd.web11.8941.1639037497132553938
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Dec 2021 00:11:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=nMPuknCa;
 spf=pass (domain: renesas.com, ip: 40.107.113.122,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODcoadqrP33N0ivHEPZWdSlQYz3GfYwLC+rsctzBjRteoAq8MAo22tTF4xRE+9Uq8uRO0DlwKhWASvwHUU2EIZnV/hPSUea+CrS9s+25raWK8pV5VlKYOmCJ+8JiagS8BweT+Z63QVGkxHE2WDc8SvOQ/nVhjLLYx1ChovcKmcuMaSxqJoRqtslEu18RR2L+j8tHScTNYRE22sCWRtEQWflXmw3fXjAq7c7cNHNsGsac2RGxbE+wMcT2E0k5bFq5ZszIrYsTbHZ4CzIuJrckqysgteWrpYRsHpJhJ0JGnoe51ffE3/ca1CQ/PyGv7sxlDAiUIH4w8n4gkMWCNKBGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxDIKlUYFmpK+Ixm+Ug/lzWyZ0EJ9A3djGNFYaENK94=;
 b=OV6QGHVui/EvTJvqfmLSrUOOHKj8zAj+bwHTQZT2rlzmJrgwhE9dao6FTYee3bV4s2pCqWocNcUOrKJV6OvnA1zfvEiPUG4OXvG7hMwKaMIpvP8dGpcRIhSPQ+XFfNbp3MDQe8Lv2vmzYg5bN0BO6Z8tYMFQkbfjX8awPdzmfhUIdwuTpaOM3CLwc8GCeMrY9XZo4m0l0sF/bZDlyz4yyCfhIcXQrJR4lt0HWUJLdmu1GchnJYdQJrgOynElHo9cgBD+kxWvq6QxkJxGeXdRa8meZN0HY5LFokz8RevRnmM0BePz+FTiSRUxjXPzPbZuTWJVYMDilJ9Hclnz3RZFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxDIKlUYFmpK+Ixm+Ug/lzWyZ0EJ9A3djGNFYaENK94=;
 b=nMPuknCarWK9TXUEP4GbwnsrX7Xb2KRrkaltOLKN1NxZgRZINKMdwkAYyZWS2RxtDTR/Sl3VqO60xUMQX+2AFjdvntRnz4CecZ5tCQjFY1rI/sY40VZKY6xGFuiZ0q/1GWqTBnNuNImFkYkxW1FZPR8cCbf1vkr2Bf7NSnRDGIQ=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB5110.jpnprd01.prod.outlook.com (2603:1096:604:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:11:32 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 08:11:32 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHX7NDVelrmNDA6bka7JHO4J+oeNqwpzv4A
Date: Thu, 9 Dec 2021 08:11:32 +0000
Message-ID: 
 <OSZPR01MB687710649235F3E39A43D49FB7709@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <1f7940f2-fe0b-d165-5150-1eca0d1dbdca@siemens.com>
In-Reply-To: <1f7940f2-fe0b-d165-5150-1eca0d1dbdca@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b99a67-f8e4-4df1-e8b5-08d9baeb82a7
x-ms-traffictypediagnostic: OSBPR01MB5110:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB511007FCA43F3931C324BDC9B7709@OSBPR01MB5110.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eAMekfFPG7XxSgjO64oDCyWMNDG1pIRpDEW/AYQmpezrLYZJ5ZJhLFRi0WcaWzYRWfdUW4/METT3prRkGBL9uIqH+V4X5hChGhzU9fXaKUVROY1AGnqNeP/BcqG6I8lOWFMQpFF054HoNI10IoMhYJCua4AweFuSdksdzBeTdhAV7q10rgsVRbAQa2B7XoGIpXRdhGw15pjkJmitWA80TIO3spa7izgGtK0KpT6fmuDliMr9TPbg8ZycYKwloezAsn53LKmAKXiKrpM0PsMlf5Mi3OcBrXTpynAkZWMPdUdcfkjmciYlVczaN6mfhW/K7K36m4kxwJabsZwvoek/+733ihd1gn5p8yCtGHeJEq2vSOENWUXOCfleeweKmTrlfJuCyixuFH3Amb0GTLXLwslkZ0uTs/uE9VrDMuhsrAogmTg3HMgMT+dqmKa9f19nVbS++txkHBHkb1rKZ6XfKCi0t87IoKKHgHVxpVH1znrSq/XGA9p5kI51FjOWtA6EOQsrLLLI82PeGysvNvKQIcJpU3RF2vjQgG9eoRL8VVOsoJUZ7no8aXHBeFD19pu8MyUjK7iv5zAJWliZVB2AW0zd7L+4sJ1OFnmwPjmbDsgBjw02TjTtAbjz1YF8sJdEo26bAIZCQ6NIp+b+hbBGQwPTNFFke847mzSPJMCNCLBDqGiaI0zMFEsXzf3qOd1h+XkijTpN2O+9UkYLMR+K4z69eQbOkYE1EzbMOLtIXqGHEUz9Xk/qO/May0vEmrIyN+zJODBjpJ1Kyh53jbFTIawxO//T3f4BEbAsutkDLyb1mnyqZbp7YNYqxCxHsaQnyjX6rWBaDnY7hA0KEc8xVg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(2906002)(83380400001)(38100700002)(122000001)(966005)(45080400002)(86362001)(38070700005)(6916009)(498600001)(7696005)(55016003)(64756008)(53546011)(26005)(66446008)(6506007)(71200400001)(8936002)(66556008)(5660300002)(8676002)(9686003)(66946007)(76116006)(33656002)(186003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?gmj+ey+2hj6/ermNIgyiTnUgT1kz6akVUpvVidwsOpGK8BdyqVtR7str?=
 =?Windows-1252?Q?LIn7OSmJzO5nUSshFJO7rBg89OGH9z8lN+HEs4Hn7x61JXy1IHuP7LyV?=
 =?Windows-1252?Q?a1FoxT23nJgrXMmero3CNDr0Mf9T/Z48aaAVyVLR9jLHP+I4eWpEqEhg?=
 =?Windows-1252?Q?ctNpddmd2PjfxiJLYUIWyu2HPf7b1R0FpPlA2VaGTENf2vGgcMxwYtLF?=
 =?Windows-1252?Q?uKvDYz4KvqUBlSzH1dU2TUu2ch0/od6uYLl6O/+VTs09gCnRWw5lEHNI?=
 =?Windows-1252?Q?zC0nQFLUGyjF1DtKAcD3D+FTvxoXQ1gsvgjEY5fljZb/YlYqkumF9pvO?=
 =?Windows-1252?Q?84xS/ZbSzOz7nVPTuToqaTHtaWgpjDckgBrC0e2r6S+ErhSlkPy/H/n4?=
 =?Windows-1252?Q?h93LoGbgqCHVh3yAy0xDswxpUdL52up8pi4bSmtRWQK2ieMAs33KODxY?=
 =?Windows-1252?Q?8p7QVVVrU8WpscCGJE18DrfAfD0Ke/vtmOkkJ9LVWg4kc6KuXYbGeI/Q?=
 =?Windows-1252?Q?GYHmpHB4l+FGBGk7rsi5JzQJq4Jd0iVB0GZSlRJvtu+O9R7K8GYYQHo1?=
 =?Windows-1252?Q?yBUE1bk54qujIso4ra+RR6xYxXCxwNkbrfKTp2ndlXbcbbrWrpfC2Zez?=
 =?Windows-1252?Q?pU8hPFizDuJPSPSrkSVGMAOohaoIeAwfv+mk7yRUi1ZVEWosKQnuNjwF?=
 =?Windows-1252?Q?HuVKhXP7723vXBzc6r5Fp3RGqux6F2MlHDyCmXsLAiO8z6gmXb4loWYS?=
 =?Windows-1252?Q?JW40n8jlFeMsQI1hhs7iQlPjV9wUouvHODbyLzUROsn5y8A6U4JCrWC7?=
 =?Windows-1252?Q?W+QZ5+uOYBebUiS4lEY8Y1sEaGN7NbWMCA8QzsTvvp3UNkK3x8hfPY2W?=
 =?Windows-1252?Q?ZsBQNDJBxTWwAXA575b/ux3baWqw+qEJUzS+kGwgLTi7CjY5koVPpOYU?=
 =?Windows-1252?Q?bS/myb9djL33Gf2USVdeCb09hLF1j0SlxIrXvXQr9crxa2EcTnh1hO5c?=
 =?Windows-1252?Q?JUHz/AXIRLpK4fjkzg2hgQRjT9478m35EPZDybYHgFbZ1Sn0J/hqbfuZ?=
 =?Windows-1252?Q?VoC/yfPSL+FNqHFoFNXYB0MbWKs0p16f/mpt6AhnNYxfbiQqQpPQbEjC?=
 =?Windows-1252?Q?92DtRa+wHQQ3hvoQa2eRKjdeFUkdZ1woHDNcbf38IeMUqJ5eOtzgOgji?=
 =?Windows-1252?Q?nnET1uNDfKBzHy+fDj6c2TZMDqMw3YsoFZtubvgBKSz3HGvB/TSlwA9z?=
 =?Windows-1252?Q?mdpfNvnKF2VawGwzuPx/tbiILNsjUXDdG9Pdl6kCY3MmLUvUwSwWInWt?=
 =?Windows-1252?Q?Wz0E5mMOSobcolR1/1J1BnY+VmX8SkzLGtwTwndeVe2O+qATvlouX2aX?=
 =?Windows-1252?Q?Y+EywjJ62KmmAjEmG5riGO3DS4/EUrtPY+kfpMVTGL0SBoKgXgBe5Up9?=
 =?Windows-1252?Q?YiFhC8nuHVEfyAe8Zt2ZN+3/xgrOtudxPG+Lgyvy5/QC052PsNZMbM5A?=
 =?Windows-1252?Q?d/9j61i6ZKslkP7DJ9vqYNgI0ugT0DpTr0741mxQlJPRlqMcWFFw1Lkf?=
 =?Windows-1252?Q?RchHk0rV07KJiWmWBu4b4d60dVTkmbS1lQ1BoLKNAynpj+aAACGoWGod?=
 =?Windows-1252?Q?53thaoleNorBc05ymDlvLdrqmJHTdx9ME3tmMrlWA7mVzat5tqNlXaHC?=
 =?Windows-1252?Q?A3Qi4kyj9QfK4Ivhb/bCdT5bOBm0GIZs5kxM+zc+nwYuIHRPI4PVwThV?=
 =?Windows-1252?Q?32G25RnpDzOc16/QqMKwwx2qrm5BPAqD6PRzoRPuQGFgYkxe+WW6iBlq?=
 =?Windows-1252?Q?5pQsPQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 46b99a67-f8e4-4df1-e8b5-08d9baeb82a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 08:11:32.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 +mhFAXGaPTDJipZs8GSxYwdAXIcTIFdHxSHdtwvffjKdVDKyOrq8VVRxcBuNJlea1ThiAL181iXOLIW9JVp/8kkikJPoTRiO8ssXyjhnb7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Dec 2021 08:11:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7078

Hello Jan,

Please accept my apologies for today, I have a meeting clash.

Kind regards, Chris

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 09 December 2021 07:46
> To: cip-dev <cip-dev@lists.cip-project.org>
> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
>=20
> Please note that we moved from Freenode to libera.chat. Our channel is
> the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> Furthermore note that the IRC meeting is now scheduled to UTC (GMT)
> 13:00:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .timeanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2021%
> 26month%3D12%26day%3D9%26hour%3D13%26min%3D0%26sec%3D0%26p
> 1%3D224%26p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D
> 248&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C6b90d8827f
> 0f43901f6c08d9bae7f7b4%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0
> %7C637746327717652724%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s
> data=3DKL4ev1%2BUkJ99WpuNcl5Z3kPkT7t%2B8BUY0T%2BnAw4ChYU%3D&a
> mp;reserved=3D0
>=20
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00
>=20
> Last meeting minutes:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Firclo=
g
> s.baserock.org%2Fmeetings%2Fcip%2F2021%2F12%2Fcip.2021-12-02-
> 13.01.log.html&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C
> 6b90d8827f0f43901f6c08d9bae7f7b4%7C53d82571da1947e49cb4625a166a4a2
> a%7C0%7C0%7C637746327717652724%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&amp;sdata=3Dkbhp5P3IqLwkESXPlrei4xKt6tKE0eH7US%2BnOu1Obrw%3D
> &amp;reserved=3D0
>=20
> * Action item
>   1. Combine root filesystem with kselftest binary (finishing) - alicef
>   2. Perform initial comparison of KernelCI results 5.10 LTS vs. CIP - iw=
amatsu
> & alicef
>   3. Propose tweet on KernelCI-CIP collaboration progress - alicef
> * Kernel maintenance updates
> * Kernel testing
> * AOB
>=20
> Jan

