Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3202C433EF
	for <webhook@archiver.kernel.org>; Tue, 22 Feb 2022 11:51:29 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.131])
 by mx.groups.io with SMTP id smtpd.web09.11860.1645530678628898085
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Feb 2022 03:51:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=FXvphw33;
 spf=pass (domain: renesas.com, ip: 40.107.114.131,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKsNhsSbqkgK5jhtXEjCRpS5Vq7nZiUvkhY4Ym4Pn4zfwf/t4S2dqdbtvPGs3rKP6lncn2qiR9L9N8vMsPgiuEVrT0NpYsCdeb1w07D3uBT+sojMpneMXf+SHvsAdLPMLxWyGrV3dX8ZxabjAWngfbm6IG0lVjRPcoIkDPItO185ocjtfVNGhk+tYWBIlqt1QqMGKfKGyHe4Pn5R1e/6QOUBniRsTFOhCq11Fr54/JKcssSFkHoGEC7Kr5xQapWMmcyvvGT3KLIYTw/lbafCoqKePdNJ24ReoVG7VrTzUmmH5StpfLeC4Lg7H3DMKd5h1iiuU7jIhdHFR7j+DA7plw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al/t5pgyh+R5+hPZ3eKs7OF/ssJo5CmIA7viV74XV9E=;
 b=SkgDu7UFcrchN6Ki9h9coTqcaAKXLRn6JEudToY4choj0aiNSkBcm1aD24bz6wSXomDOY4dZzS7xpV5In/th1q0UtEsmwGiD830Kddz5XV5lg0I5kVP1vMKje6L50Kfp2cO83OcLFzStFy/4gzC8H7EafK6K6h+8O286lLL+vsAiNhlnfdxHe/+K7RZirrY0ZKZj1IJk9W27QicwSKfRg0dmtJYMIQWQY9hlc1GxCPQHgALkcIJ8QRgXFst0+2M7XBI5+KCgZI3A9mg33Zasm0fIM4GPf2AzPXKTyYvm/vANDkTwsMMCicPNLn4DaRoJhHTcU6z8W0+X4xHCY1bFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al/t5pgyh+R5+hPZ3eKs7OF/ssJo5CmIA7viV74XV9E=;
 b=FXvphw33kzdwKiibjAQjApoz/jbUXuNGwY5e+LUUywnamtOhGDs6PJdQMyXWt/KahOnXF7iqoDra76cc9LILEja+IdQvCzUqAuw4G5aDhRyHVNiLQxHZ6rswdK456oI3oXNC1N5iQQ4/qiJx3zhlCB1sRqFYIOJ2T6hi5EiUlIw=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by OSBPR01MB3573.jpnprd01.prod.outlook.com (2603:1096:604:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 22 Feb
 2022 11:51:14 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002%7]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 11:51:14 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
Subject: RE: [cip-dev] kernelci results for my test branch
Thread-Topic: [cip-dev] kernelci results for my test branch
Thread-Index: AQHYIx/hPNjPQ4fOBk+dHdB2tB2f36yWC/6wgAlyf/A=
Date: Tue, 22 Feb 2022 11:51:14 +0000
Message-ID: 
 <OSZPR01MB68776D6335D91FA42B1F39C4B73B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220216102758.GA313@amd>
 <16D4412F23B43F90.9986@lists.cip-project.org>
In-Reply-To: <16D4412F23B43F90.9986@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38ed2292-046e-49ff-ace5-08d9f5f9a0f8
x-ms-traffictypediagnostic: OSBPR01MB3573:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB357357982152A9E773FB0B88B73B9@OSBPR01MB3573.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5Wrgsu1LqYrY671JYz/iBfH+vBz3q3LnbNJmyCh4NgCwPz8PA0UHacElRC49xCF7AeyIHA+xT0DUDO8U4ieklqPeQEQr9Rd18qbx9koqh2AT97UXVma18WDtYdYWLzIC3wuwu5qqOJmlHbEdWuP4xs2hiflgQa0ESB24d9em6V8PAjKT9TlYk8LyDVvBYIMgWZIrVSpRAQnSzzJoNzkRmSAem5t10D96+XUcQK/YZrKL9Sk6bZO5UdbZftjqy+bXETLucvtuiHL+xCIBw2sE3/5/IhzqMAbNAI+UFiF+BRUjwOImfGZgGzwcNnu4gNUavasrzwAW27cIKet0Y6/X5YNCUIRyllhL5gV5p+aQ6RYhLPDIXqVgin3FZ/thdkwrQz6lJmrdl4cSiBTFD/l5MZTTeZMCvjiUwVZXIFdhHscO5VWibvJplUdU4CMuYW0TBBgIrsxviPjLV8omtacJELNjBTsaPsgY8f8dHnFLczQ4aOX0RpOyR4QeXHYFITMCmYwOOhGWN7vg9bmbeCU5dWMf+EyoTir0KS4iNr9xJ6BNCIlJIr+TI69MsuPFjNdI+TOlBNmjZwJdumGE8FJr4iuAjF7ZxkLdbBbIY3K7hN8JxORjzrKLgmA2YVleh2V73cxS8C74Fjw24KBvU0+vgHoC3HdICezvOSFUGwEx7HE0latlg3xXXWS6QC8QTFyDCWaapSMGESLkJM6gNrPJV76ztFvlvWsFaRXEzEuml/OWVHE8z2j3G5u7CPJhznHBJDnLqrzBwF0zZ7BTllhk9+5ko7K3SG8csj+HA49pNN7p55hc2Gl513pLSb3YIEEwWdhWXzUmYezSECh4dha3mA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(2906002)(38100700002)(86362001)(38070700005)(122000001)(6506007)(110136005)(186003)(7696005)(66476007)(66446008)(508600001)(966005)(45080400002)(9686003)(76116006)(64756008)(66556008)(5660300002)(33656002)(8676002)(26005)(52536014)(8936002)(316002)(83380400001)(66946007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?11xLIrFFtJzCLtuHjYLnCFYeriAE8rbHszG60tOuxrc5WBv8Wd+y8QhG?=
 =?Windows-1252?Q?TzO1/JEjxU0K1r2vhevdFW/8maPhQWr08vnn5y4K1I8LLLHquyzBI+fk?=
 =?Windows-1252?Q?jEa/92R9SnNvyACY3+q59m1/xiLjwfQkGoaf8rjwsDFMveTJxehQSkFH?=
 =?Windows-1252?Q?W7O7T+LXAKjWb1pcHV/2fggzIgsh6yizOjtVdtkD8Y7JqG1nPL8UfMhE?=
 =?Windows-1252?Q?vtBLW6IMnenlfkp4a49kqEFSYk56y31TQgXVbnaNIu5LFRYa0JQJ8JkE?=
 =?Windows-1252?Q?6x9K80QrZkSLKQ0IfusKfZ5JStj7CyXA0hkj8/mY6GN8h3OugAtnU2b/?=
 =?Windows-1252?Q?Hr8RIIGnggX4i1aVpykQMvgLbTp7vRrQc8pqryzVZiMNxEiUJgG2lMdp?=
 =?Windows-1252?Q?UBHOZeUVdndUqLNKA5+66F88V0BXOmC8wK+H4VS+cUNq+hzRab6YHOhs?=
 =?Windows-1252?Q?N3fehz0Tml/MWoe7FRNIZzZDrA5MLVDkVZ74EVu0dLiXU4ViYyAdMo9C?=
 =?Windows-1252?Q?6MB5Z3f2awyk9vD4ksvxupvC77Hq537QTCCfgtjLfYAJegR7VwUQHx2p?=
 =?Windows-1252?Q?rSiaOFZHFVbdNxldYi+qWMbs8HkSRa3r266JEFb7J8FZ3UKHX+OE7FHh?=
 =?Windows-1252?Q?mz1rtCRbHZEiA8H/HNdaV8m6V0c1HWwKzzwbeJ8e4nyABm7uHh0S7fO+?=
 =?Windows-1252?Q?1M6m9JlvkDLxdgsGGaMJo5laCdLwO66SXai2Dsb8ilTqTsDKVvZ2OYU9?=
 =?Windows-1252?Q?W14oPu6Rjl9XXoqI8gSDTTpjdcZZ0QkIkFAtrCCs0XnNPqOeKzhVgcZd?=
 =?Windows-1252?Q?6ZLaAROHk3lw3gPpY7dDjngTCj57gnVDSCYdL6mKo4oGYT13f5Z8AiE5?=
 =?Windows-1252?Q?nN+QuDoPjizKWAFz0YlblgHPmq1yK1j83WlgbwHwMGlBdPDHAscecZ8S?=
 =?Windows-1252?Q?mz6gvJDijGCnnFUJK7xF0xqdN8fJoc5TZj+7fsitBl1tzZG9Y/XuB683?=
 =?Windows-1252?Q?Y5qQac1U9CLtC8Opb35baMJNH/1FzLMWBBSh4+9n5a+V9+ImwWL6EMbS?=
 =?Windows-1252?Q?/5aMsUDRYEfq8fs/PdP81xbL4QsBqGR9/BfkC//J46+wl7VwJni/R85I?=
 =?Windows-1252?Q?n7SjBYoIOFo364WCsrjENBdg7EjAme65W7+Ho0Le86iYAe1ym82EziCu?=
 =?Windows-1252?Q?JRjRSYk4opcni87vCo3O6udRfYPUeHospBZrleTr5Blg5/plYGxPMA1J?=
 =?Windows-1252?Q?TftzEsv1ch/7Po9gLtVH+IlVmS8fc6MMv4BwZOGxScfOFP9n5vRSxjDB?=
 =?Windows-1252?Q?7xmbfqNmCu4yrRPUWczQGOzEtc8FNbOeKAf2/ETPpDVzVqJTDXDaT7iM?=
 =?Windows-1252?Q?zHLuszok84ggHVTh7n69EhH/f1v60+PDL7tTODiYnA8J1Kq44vHVVpi2?=
 =?Windows-1252?Q?8DeyErpNBOH3RO/rzSFHrbQ3N+jTu/8l397dXrjejBVNzT59QSqYWtNg?=
 =?Windows-1252?Q?zJIPUTxW1euuh/70L7P4E+8DkYs+uiBm1GmY1S/qG3NCxsjq1D9Ttmxd?=
 =?Windows-1252?Q?SdwGSPZuKTQpXQNFIQejtFryMMeHoEkAkx7cbT9qml0lurhlsvvy7G86?=
 =?Windows-1252?Q?LK8ZLpRGQ+5gl+AsaFT6QEj8VLSHLP3I+LM7RF1QkBItjfdwy9W0fXB+?=
 =?Windows-1252?Q?CykCOIYaA1YWqQGwaWc7w/3/ItCxi5aSsPJJ6zFI5B7/z89D8XY1o37j?=
 =?Windows-1252?Q?sDYuD0isT7t+RFdOoS6Edc4OONEODZIlsVu/bGWbwuVPY1fFACA52u76?=
 =?Windows-1252?Q?5ppnow=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 38ed2292-046e-49ff-ace5-08d9f5f9a0f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 11:51:14.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 fQkVXPV30JsN7Di4isRPBi6N1KClFsojwDrb5BNbVn2DnycvT2iyGw+d8/4n9kNTr1pzbwEkkOTzWgiZnzD3T3ktTcg3IQkaKFn7+365LlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3573
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Feb 2022 11:51:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7634

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 16 February 2022 11:37
>=20
> Hello Pavel,
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 16 February 2022 10:28
> >
> > Hi!
> >
> > I pushed a test commit to ci/pavel/linux-test. This is not first
> > commit in the 14 days. Where can I get the results? I don't see them
> > at
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flinux=
.
> kernelci.org%2Ftest%2F&amp;data=3D04%7C01%7Cchris.paterson2%40renesas
> .com%7C29f25fd8350e44b7985208d9f140b579%7C53d82571da1947e49cb4625
> a166a4a2a%7C0%7C0%7C637806082492358598%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3DA0tBhHHB5bJYDkK4SY4PPdvnm2En8yVTANVPFXY
> U8Mo%3D&amp;reserved=3D0  .

You can now see KernelCI test results from our RC branches etc. here:
https://linux.kernelci.org/job/cip-gitlab/

Kind regards, Chris


>=20
> FYI the best place to check out results from CIP trees is
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fkerne
> lci.ciplatform.org%2F&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.co
> m%7C29f25fd8350e44b7985208d9f140b579%7C53d82571da1947e49cb4625a1
> 66a4a2a%7C0%7C0%7C637806082492358598%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000&amp;sdata=3DLkX3e%2B9BVTIOIzqvUwhx3RNwXJ3YDW1D3JnMKZ
> KNjTs%3D&amp;reserved=3D0.
> (which redirects to CIP specific results from kernelci.org)
>=20
> >
> > pavel@amd:~/cip/4$ ./testhash
> > 2fe7e363b1b121239e91f0d69511cf354db03386
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-kernel%2Flinux-
> cip%2Ftree%2Fci%2Fpavel%2Flinux-
> test&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C29f25fd835
> 0e44b7985208d9f140b579%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C
> 0%7C637806082492358598%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;
> sdata=3DmImLWmq1FhsVe1mxcqsDnCAWNGMUAnZtT%2FyjU6fPYVg%3D&am
> p;reserved=3D0
> > Counting objects: 112, done.
> > Delta compression using up to 2 threads.
> > Compressing objects: 100% (104/104), done.
> > Writing objects: 100% (112/112), 17.44 KiB | 0 bytes/s, done.
> > Total 112 (delta 95), reused 8 (delta 8)
> > remote: Resolving deltas: 100% (95/95), completed with 48 local
> > objects.
> > To gitlab.com:cip-project/cip-kernel/linux-cip.git
>=20
> KernelCI is currently monitoring branches on
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
e
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fcip%2Flinux-
> cip.git%2F&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C29f2
> 5fd8350e44b7985208d9f140b579%7C53d82571da1947e49cb4625a166a4a2a%7
> C0%7C0%7C637806082492358598%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0&amp;sdata=3Dhu9tmDvy%2FtyyugEhWm46oQZl%2B9C2%2Frg5ycqqEAQEc64
> %3D&amp;reserved=3D0.
> Do you want me to add support to monitor the GitLab mirror as well/instea=
d
> for your/the RC branches?
>=20
> Kind regards, Chris
>=20
> >  + 94973269ae47d...2fe7e363b1b12
> >  2fe7e363b1b121239e91f0d69511cf354db03386 -> ci/pavel/linux-test
> >  (forced update)
> >  pavel@amd:~/cip/4$
> >
> > Best regards,
> > 								Pavel
> >
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

