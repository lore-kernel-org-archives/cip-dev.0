Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA79DC4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 10:59:31 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.123])
 by mx.groups.io with SMTP id smtpd.web12.17983.1667473169932571523
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 03:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=K9ZWJ4CH;
 spf=pass (domain: renesas.com, ip: 40.107.113.123, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdZ31iIbuZpqeuvrZfyBIVPLA9oDZQFH6ynyUC0rBSJ1x8yYQnOCCeQWkhjQj4nz79atyq+YaVkobF66LOnslx+QIYeix/OorDBYktYJwwA/E0ldWbOl5hUcg7EUbQ5R+ZNr34cNA9TxGL2YAJM/+ye5owAFHR1kbEYqzfdOp5g6CjIuMmWTfzxCjD0qmI2YtNRnbECD+hzjpetXyF56oHyeCMMmcQGQ94yg2ckBrL4O7R7L4DnAIXdaJ+XTndA61d1IYRFJJ7ynTAycmYplRj5H0t35GIogp4hHGvLk1WqEJ3DmkhKSD0K3ajx5BJe6TH7oYtpn2ls+gYErPU0Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb3wllVsKaVCdhUJR/2kDY+Z1NUykfoJKexXvT02fH8=;
 b=iJEwvRtuprtPTKkNEmFiEmZvyN1gtoYuds4/MBbmuGnvEN/uHjZcQzLVYuDHMObCcdHFdERInLoMFkWd47mvSSyW2qgCVuDrViWMOwvsJsZ3DZo6pphJF2kPtggi4iTPNvlN/s+8aOj+zHt2k9pPkoGmzZDdinf/CzzSHBLdYjMY4gphE5x0BatLdXa1ZRDccR/S2iHFefQ2sLpIcAJFc4Je5MdjcRk3yVOivF5M894U0nzhTo3H0AuOcu+qI0kSiKGhq0GSgnmbRvZhyr57+PipBlhgXEXlWJHhDd6Wpw7Ln6uVyLWwccCnDzy5f7Rw3OXX4v/RFjD/5GdJ8rnEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb3wllVsKaVCdhUJR/2kDY+Z1NUykfoJKexXvT02fH8=;
 b=K9ZWJ4CHnseIQ9gUFGi7Nbg4XzOR9WTZUtB/SgjDN3TNEKmmXHYZeE7HAG4xDtWUWYc2UA971mRia/czLAgo6oEVS5sJq/QXgnHgZU1eBOvuQxgAgAc0IGZOUb/VE1qnBKuiiMtkq3ozXmPCbQmZEP6uQ+59lnDy8+UPSv4yvMc=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYCPR01MB9537.jpnprd01.prod.outlook.com (2603:1096:400:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 10:59:26 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::4672:bd0c:596:1a45%6]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 10:59:26 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHY71GuIW4vyXsNC0Ke52SABOPWVa4tB9Xg
Date: Thu, 3 Nov 2022 10:59:25 +0000
Message-ID: 
 <TYCPR01MB10588E61A97690300EFC5E435B7389@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <6acccc21-df28-0aa0-f6fa-34d63021b0c0@siemens.com>
In-Reply-To: <6acccc21-df28-0aa0-f6fa-34d63021b0c0@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYCPR01MB9537:EE_
x-ms-office365-filtering-correlation-id: 99c672b5-90b1-42c5-2d51-08dabd8a7933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rpBPmbZaokp9LUv8oz25EFBEoI3G7o+lbLqgUjCXujgKloTP9hmg7JE5+rQJMX5uofgIpHUKlyzIrLBXitN7zXWtGtZ8FPAOR7LQpP3AeD9ys4SxJQ1u0x7Qj2D/K0YGKRLLULwPQl6DjUD2dz2s9HBC4LincXllnMWdFVdV3Oa5zW4YK8/h9uZ//YzcWZlEm19IouZaf1WJF8EYUTwq92KCSiAxI1jWPG2XDSSqdSfh6GDrxv0MiEfupTg3uuXsIByC/Ss6DWu5V0xD4QstITzlDrNcB8J+ETjCmiseFqNR7jbS0QxxJSDvPH3QGQ/IY5Pt9oLo/ad8a1q8DVPJHoXC0QnSIkryKk/i6clhIFMfSvApWB6VL59gEmOMSmNoa2Fsv9bAJIdvmUdDRxmz6hZZ80sWp8PbsEUAog6EKWljJdTeTktGPYT6XDlZLCOLDKGtbrzh0Tx6Hv1sWTukthoE21CGP+Evt+YRId9V37iMNGFbXnH4sOe07xAQpSgixfC8xgaNw/P2cpPefVZgPD16j6216MoD5KG69ySg/f/rAZWLOcXmju1r2LTYGQ0n0UGYj8QBFBbvJZ27FwuwtX7KyXCd0UcgbKCRmtS2VomPvDx/SmLTlVDlvZB5e/F4FWdd3FmjAgEAE8+YAP582nslpv+HQdbfjz4ttUK2b2GvmXuCXvFmqX/ieKET5P8lG0qC3qzcTFMT6F6Fh77h/mRa//cgw2W76lS140HF+NZR1kOcHeIhZ2RThEiB1z9VQVYZdy2mnw9B2Mgte0r1gKtFvmcC139TyKkuPGDB2e6AXEKvIhpz1MRSsa3F0+xqxE+77YRf+B1/kY55CM6uXA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(2906002)(66556008)(66476007)(76116006)(8676002)(38070700005)(66446008)(966005)(45080400002)(7696005)(66946007)(86362001)(6506007)(478600001)(53546011)(71200400001)(26005)(64756008)(6916009)(33656002)(55016003)(316002)(9686003)(83380400001)(52536014)(38100700002)(122000001)(5660300002)(186003)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?7NnzZRYJofRJMxylVcW1s7n6X/+BfoFOoYW98symvA6c+xc5EazAFz1y?=
 =?Windows-1252?Q?QC6FrLq4Em5w6iqYbhWL17I0W4D2G0z5nCS8i5Cw0NUgoTXgt0ajybGg?=
 =?Windows-1252?Q?cumKDEhE4V2HgTxPkTp7OkZeyf/urF3zl08YJn9DiifDjvwG9Nqf7VJq?=
 =?Windows-1252?Q?DofW54UeAnZX1jkFK2TIEYF8uLaxmhA+u7RTgCXwkP2n3poaiTuoswgW?=
 =?Windows-1252?Q?2mDTe/JnuFwchsfp7byMpoz8rlpupFs0kdCaEvcy1As2uugYnoMcOpuI?=
 =?Windows-1252?Q?EaJmqIycpTo/VSclan+7/whhyYUZ3UEYpzerdbjWoqE2VM1hRHKXH9Z7?=
 =?Windows-1252?Q?cDEk5rWDJ/7sHQ5IuOcrCoClULc3kFqNa/kJRAh9gU/DM8mBpMUAl1Fh?=
 =?Windows-1252?Q?G8i551MHjY1nPmExjFRTVTUjMpz7ipXBVQYFAYDhyRz2eFTHVTxi8KzC?=
 =?Windows-1252?Q?H2SGbnZycXb+W7mAro7XOPoKMMGjHQC6o0BSslKzyW4BjbcvcvaM7X6V?=
 =?Windows-1252?Q?oFbnaD0PkJLQUX7eM91nVnqUuOY9HoC08RaDbo2d3xzZeOypCPnJmpLH?=
 =?Windows-1252?Q?4VWRiuMcoNyL9Pp0lMV2nJNGNK6GmwFF+QuY4Aeu5vCJdePTjRYHV84x?=
 =?Windows-1252?Q?Sw6aDYeEH5OtkfnuA04BO5AZTedoIMMC3NgiAAk1Fk2ZsEakmOy/deKU?=
 =?Windows-1252?Q?vfdav+T5pzFw4Nqn51Sqq9LDecE66D0ns1npsNU4iZGxU7GDdB4mLl9G?=
 =?Windows-1252?Q?K2VYNDeLFG2xpLW1kL5T5+cZMH/yGE7B4YH2yV85C8afTWC+3zwX424U?=
 =?Windows-1252?Q?ixzCm+jfI8w7jUL6cE9nCrHVt8Eq6E0AOOpas3MQpcRg1l7KgRwmDVO+?=
 =?Windows-1252?Q?IRngXm6gU3VDFJPWGtmWztF3YHAw6ghU0uS4ADSZ1Iw6v2zelVW750e2?=
 =?Windows-1252?Q?vd6P0rWcm7Hvn/bn2n+eDlClFGX1EQwwFl6vXRAaWjESWPmFWFrmaTG+?=
 =?Windows-1252?Q?dZmqiUAq9qM8cWWP1wHEe+uuvZt6//k4k0fQ+NZ2Dd/KWUgc1IELrL0e?=
 =?Windows-1252?Q?o6O3GQRimIgulNLENWe98IgGTVTOQHPwsvyQmxMoIvLrWfrAxM7rKiJb?=
 =?Windows-1252?Q?+3V128V48zIBYW86uKMwoAhcKaWs6IbUlIECE2jKgdxsN6jwsegTh0pp?=
 =?Windows-1252?Q?jkbJ74wlrtgRjcaFKJFGZQp4dgS7JnFVFRdjniKKQX04ljZE+cJLaYsz?=
 =?Windows-1252?Q?rpdMsMKefwiC34/Br/lDdmwtPvblhNZUByzVfK8rudsr1pncIc9ygyKc?=
 =?Windows-1252?Q?3h6kLQPcDwcgQhtuYha+z5coo8zQnr6S7/j4Y1hr4EuIxbon9JO5CL4B?=
 =?Windows-1252?Q?oAu/QBrdk6qSTwQqvJkNgIgYHhrHu+08SamGor2HOLzpHEP2Ex4lui3/?=
 =?Windows-1252?Q?BinSRb5Xn2oXFLJwbRbkfPrF9AHMjgaHfpRKv4Ze1gthptcv3CIbaIrb?=
 =?Windows-1252?Q?oM/SdAFVrRx/Tt7J4So28QC/ZDKZJ4eMX21kwO9OgH5MZu4V+RoRC6/t?=
 =?Windows-1252?Q?VO2d7zf6uHntv4p1IMWRvNA8VVSf2hCV3KgYQsOuDaJUKxsOFRR/TCgY?=
 =?Windows-1252?Q?VXWWjj5WB0s+vh9mE1TCDlocODzJGhleWXXvE2YTgUtAUy4O9B4GNMWw?=
 =?Windows-1252?Q?zRiJWKkdOvAO9Qe2AqXk+g3/3dwO71suVDQHpuQpw6Etkcn+EgBRYQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c672b5-90b1-42c5-2d51-08dabd8a7933
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 10:59:25.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VACKaDim24z7pkf3yWFDWXPcJQAnLNONfaiA9AQnXba4MOR43bz6nLwSMU7k+3D3WpItxdzOm/D8AQbw0odkOrncJAyrPitNOGjKnRU5Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9537
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 10:59:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9911

Hi Jan, all,

I cannot make the meeting today, apologies.

Kind regards, Chris

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 03 November 2022 06:58
> To: cip-dev <cip-dev@lists.cip-project.org>
> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .timeanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2022%
> 26month%3D11%26day%3D3%26hour%3D12%26min%3D0%26sec%3D0%26p
> 1%3D224%26p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D
> 248&amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C3cd8e8fda
> e28417bacf708dabd68cfdb%7C53d82571da1947e49cb4625a166a4a2a%7C0%7
> C0%7C638030555103810270%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&amp;sdata=3DAgD2rkpBxbRHjk4BoQA5Lx%2BB6RMsVKrH45P%2Fcm
> CBUJw%3D&amp;reserved=3D0
>=20
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     12:00     13:00     20:00     21:00
>=20
> *** NOTE: the DST-related shifting for Europe! ***
>=20
> Last meeting minutes:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fircbo=
t
> .wl.linuxfoundation.org%2Fmeetings%2Fcip%2F2022%2F10%2Fcip.2022-10-
> 27-
> 12.02.log.html&amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C
> 3cd8e8fdae28417bacf708dabd68cfdb%7C53d82571da1947e49cb4625a166a4a
> 2a%7C0%7C0%7C638030555103810270%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3DHRjF6KQ%2FhJty1hQ4beFg5FjuqIZVuG%2F
> O6dLNAU4XpBg%3D&amp;reserved=3D0
>=20
> * Action items
>   1. Add qemu-riscv to cip-kernel-config - patersonc
> * Kernel maintenance updates
> * Kernel testing
> * AOB
>=20
> Jan

