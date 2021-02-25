Return-Path: <SRS0=JAy3=H3=lists.cip-project.org=bounce+64572+6196+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F0EC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 02:24:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DF764ECE
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 02:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DF764ECE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6196+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9ALpYY4521723xBq17PRkATL; Wed, 24 Feb 2021 18:23:58 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.107])
 by mx.groups.io with SMTP id smtpd.web12.6219.1614219837742674495
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 18:23:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7GH806Ty49Nv5sS2yA2+175CSjdEA6ShjAYrlBYMwWDDHSGKlbhjnVZZHd8ujCcLUrRoQkeTEIuIX9BhRXussR7ZCHuCuqTt14HBqIwuXQhXv37ErCV/2PJFnVs4yNfiib6i376zFcmVOm7gg5A/NgMxl+0dFFBcTiFBEQPPiZi7Rw3IukJHibpPn3zMxV2lWwc8pDZf8zbNdD9aiuKu2eKsxZOy6Wd4LJ4QADotqWK0yrOFfRL4ovyszTVVtjXO429A0OtLRFHMvu29s0qXmAjvmVJl0GESajCrjHWuBszDNgM8FPK/A0JEiAIQ361P/ZipBS5cAZeNBTA3pBBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEeZqNYCB8ZH8m5V13e4ZaFkUSy2iQvtMi+dk/H1aXU=;
 b=MW26XEEqeX7ZOTiwd9NG3knXzZnH0mJHNjX++Si8WHbrOnXXey3/X274ANBAeORb4qA6mHpClJBjvjAMjkJPaNMQ0WwPVCIcMVMtQNTiv846CcyzOXt08rjyiPgxKhkcv6g0bwcl4Wqlw+2vh2QPJxr60/W/y6vKraE9PJ7cu5skYxiNa7zDnYr5TdjfrcWW31zR7gioOrjAtNBFiK8g5CS1X07XZm5bI3BpbqYJwF0/A/eYswiegFPQj1oHqX4jhn6zHjLXfWt7KD/6mj8eh+TKi70rSpIwyNG5qcJjxLluPOPouTUpk7T7Emj8O8m8D/hln/Om7RgmW5zEyMJM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com (2603:1096:604:84::10)
 by OS0PR01MB5825.jpnprd01.prod.outlook.com (2603:1096:604:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Thu, 25 Feb
 2021 02:23:54 +0000
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::d89f:2760:aba3:1583]) by OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::d89f:2760:aba3:1583%3]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 02:23:53 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcLFetqVKbnosikRteUKID630xDUgABxpTg
Date: Thu, 25 Feb 2021 02:23:53 +0000
Message-ID: 
 <OSYPR01MB536688D3A06A5B37DB596F72DF9E9@OSYPR01MB5366.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49725D694551F1D47C1807BEA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB49725D694551F1D47C1807BEA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.50.44.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9c7b07f-20d6-499a-f8b8-08d8d93465a4
x-ms-traffictypediagnostic: OS0PR01MB5825:
x-ms-exchange-minimumurldomainage: www.timea#0
x-microsoft-antispam-prvs: 
 <OS0PR01MB582565E941FE4A4E1A0E191BDF9E9@OS0PR01MB5825.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 dmqzjIu4evX8fZH9aNMRimLUD6+uykFbg+Fk4n3JQdiO84M4pPoC2QNSLBuf87s8kCJxG/J3qQ/I5apHPoBZD/dR1rc810qhyG6PvFBevsRxIEm2HYJ5Tv7LXNLMAXerw/OOCHvSRxriaf0dm9gAGYtESQGsFbif8QThyAxBfj/yLyrSAY8Mr24TXeKkISdLOW5QmXo5RrajSy6uCLEXAPtdQ23lDZFAC3q/e5Z4aJbxjFY1mhD8hHVWADrtedkXGqZz4NmGyrBiqHfgBL8s6V9zlqimEuP3rlLucbSUNVZikbPWwEH3MLwWwz4hpQEu+XlRl0jfR5bcmCobk4N4boMyoH5s3o62IoYZdCiNtjzWRf4BE1giLOGhB+tmKher2fkX8Ah0SKe+NioEOAWDC8/nhfrffXABljx01SpgQ9WLcbAeJ3oihm7lxgwcc/tVncgtMIFHwZF9rXeEWXIvSFflKRyn1e40iPpPyt/dXsxmE73U+K06TfjDfQ0JYF3t0PFkioWWeTnRcWRBNVsrRZrTc8dvRo6DgM7W4IkbiQV+/yis4DGb/e8Q4jXxs4hF+uryx9L1NnqZ9PDhFo1MY3mcgrupZ6x1t6zdEcgsktM=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?JG8lRSVWu1JfJnjX2oX+4TtCpkoqt9KwIQuVb7o9cFI0HtrpiWfIMVOdbc5N?=
 =?us-ascii?Q?/+gjLwEoq97Vp8Qm3ctIlH8ccqciSSLtB7RDGaAVaoQSeqD+yWInQTEyqqhk?=
 =?us-ascii?Q?VdGJEBDRP59hoXBEr+ehCDlxee11cB6MHDKeNrO2nOtAEgUOe/pRAKT55XRh?=
 =?us-ascii?Q?FMEftrz2s9Cx0wCLyNmheYBO/N9YyNrK0mW7GW6drsmArJY3Q09E52o8rHdT?=
 =?us-ascii?Q?35CAqqwPICTgkPL4+3S/cyEZo/oAjz3wU1oKQKI7Staf+afU6nZH4GUvakeQ?=
 =?us-ascii?Q?KHdPV+LP203djTmjPEi9aJdTP3fFT57HMgryLVPQbTzxC/nvNPk+qInNp0Kn?=
 =?us-ascii?Q?dEY88Gzw/qYoY3b+wDJXA94gZ1tmufJDAHo9/MfwfIMBwgwkqMBHpyIbdFFI?=
 =?us-ascii?Q?lLrMOXZPHUCQ4e03mtPgqFzThjM/tCfFcrvzNkAVwaqa70F41aGTcAmzuFEG?=
 =?us-ascii?Q?iJlz5OLZFNQeCWhDoH9lQgUca7/c+7WYVdWeyK+sqNDd2C8e9N30sIjTfa88?=
 =?us-ascii?Q?8U2ZiEQufROm1yKUQwTZPwA7HwDXyVq0cd+XbvwmZG23INKhyrt8J7sF9Qcu?=
 =?us-ascii?Q?KX+BVwYhxRwKYFwPvr5zbhPKBigMP6XhGmrgfDPekjB79Fsko5Q5cYPP0QFE?=
 =?us-ascii?Q?xeDoVLgEtCMfSPHm4B8rDWDPgFxVdHzCtYvMdaWgG2tKxOgVnI8gbjGYQ5Ms?=
 =?us-ascii?Q?6R2CqgHLvyPJsdfbDIg4btD4SkBYmjMfyH2YpwpfDPWEiQeL6fMYsGJVr4cZ?=
 =?us-ascii?Q?KKo3OVGy8j26WEeuGgDrvwXaiUBxsbn4nbPMHqJG9O/YtSGxY0hTVZan9Dn8?=
 =?us-ascii?Q?fjeXbVJtq51YGF/3RHR+zA2BhgR25DBuVsCagoydvDNRYa23q6FTKuhXMTVl?=
 =?us-ascii?Q?7NtxQLUPM+766C0r94A3nCUehHn4YCw1vbeT5WR+dMH5yyE8gm+idQpy+ML0?=
 =?us-ascii?Q?wgf81F/m7oDiggErCTEW5tn6aQcEa6/vc0NgAloqoaj08c3PGTyXvJb1Qxis?=
 =?us-ascii?Q?NampSy+q1Wa6fLxJd7cx9gOxfBL/fR1hBZgLDPW8TAXSwdbaPNavOnIrPXxQ?=
 =?us-ascii?Q?ZWR27T2raDAntbW8tjHi0+s02MSOfGLH5oLiMZVw/y2UKM3VWrlt9gZcwnss?=
 =?us-ascii?Q?G2W4gFT5ABUFD1/f6aV1T77Gmzqxe6JqAN8h/NDCJm6EOeQviG/u8j69r0lU?=
 =?us-ascii?Q?r/Ki8DrLZbPcALnbu49Xj11OhHphZsQ+ziwB+PnmkrL9CZRmC3yugUEE21j/?=
 =?us-ascii?Q?ro7qkCUUM8pPt6hXYy4rPufYJFdOgI1H7ox0mhb3VgPECRnvlWLkuQINFhFH?=
 =?us-ascii?Q?K/k=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5366.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c7b07f-20d6-499a-f8b8-08d8d93465a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 02:23:53.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uZ1EwUydjJuiReYY8d+BqogdviDsoc1IeAVYc7LLSTHcTViVaGW+XZW6bkmEuADY1v9pKue5IC61R8yCiZgMf0oYQjARHNiHB7tJ4OoO8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5825
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xY7TKHcXzDr19YunFlHFVdH6x4520388AA=
Content-Type: multipart/mixed; boundary="cLPCRboOsj2zjCuc3qeS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614219838;
 bh=2/hIVB3EUvbmM5q/VF9ZOX9URIDaWsaJ0GiZrBC5eOs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lbHznpcTyY+qPDYUpFY01qhladYUI6WRqiU0ZYWQu12olKb7aoSyAH4FA0PZ4tJqmGV
 /K82/tOvHrL7o0KyuS0vB0MwNvpbhHSrMNEpm2J7buaXNmtmsyYlg4FLT1teHPDx+mfCh
 OFanBGOKtIH3+QHbNh9UVPXb14np5Y7lwgY=

--cLPCRboOsj2zjCuc3qeS
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Kudo-san,

I cannot attend IRC weekly meeting today due to schedule conflict. Sorry fo=
r my absence and there is no major update from SWG.

Best regards,
Kent

>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>masashi.kudo@cybertrust.co.jp via lists.cip-project.org
>Sent: Thursday, February 25, 2021 10:37 AM
>To: cip-dev@lists.cip-project.org
>Subject: [cip-dev] CIP IRC weekly meeting today
>
>Hi all,
>
>Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical
>topics with CIP kernel today.
>
>*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing
>from the first week of Apr. according to TSC meeting*
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.ti=
mea
>nddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2021%26month%
>3D2%26day%3D25%26hour%3D9%26min%3D0%26sec%3D0%26p1%3D224%26
>p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D248&amp;dat
>a=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7Cc26ab53fd2294eaf71ca08d
>8d92de5f1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6374981
>38442607268%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D%2Blww0ze7b
>KigXlsm%2Beioh%2Bj22yUQnKNuHqT74nYDiLw%3D&amp;reserved=3D0
>
>USWest	USEast	UK	DE	TW	JP
>01:00	04:00	9:00	10:00	17:00	18:00
>
>Channel:
>* irc:chat.freenode.net:6667/cip
>
>Last meeting minutes:
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Firclog=
s.base
>rock.org%2Fmeetings%2Fcip%2F2021%2F02%2Fcip.2021-02-18-09.00.log.html&
>amp;data=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7Cc26ab53fd2294eaf
>71ca08d8d92de5f1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
>637498138442607268%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6aK
>FrdRkBmbsSnaBOi2IMj6FZuWUx1764p1dmW9IOpA%3D&amp;reserved=3D0
>
>* Action item
>  1. Combine root filesystem with kselftest binary - iwamatsu
>  2. Do some experiment to lower burdens on CI - patersonc
>  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] -
>Hitachi-team
>
>* Kernel maintenance updates
>* Kernel testing
>* CIP Security
>* AOB
>
>The meeting will take 30 min, although it can be extended to an hour if it=
 makes
>sense and those involved in the topics can stay. Otherwise, the topic will=
 be taken
>offline or in the next meeting.
>
>Best regards,
>--
>M. Kudo
>Cybertrust Japan Co., Ltd.

--cLPCRboOsj2zjCuc3qeS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6196): https://lists.cip-project.org/g/cip-dev/message=
/6196
Mute This Topic: https://lists.cip-project.org/mt/80893035/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--cLPCRboOsj2zjCuc3qeS--
