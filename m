Return-Path: <SRS0=2y1I=HO=lists.cip-project.org=bounce+64572+6173+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BFFC433DB
	for <cip-dev@archiver.kernel.org>; Fri, 12 Feb 2021 08:00:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1426564E6C
	for <cip-dev@archiver.kernel.org>; Fri, 12 Feb 2021 08:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1426564E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6173+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0bhAYY4521723x3SRiWj0NGL; Fri, 12 Feb 2021 00:00:05 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.137])
 by mx.groups.io with SMTP id smtpd.web10.1019.1613116804634717562
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Feb 2021 00:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxqUu4VnlzNaiFGHgyoUvhjqXRcoLtiXbqLE66TVMzce6v8nIrawRPIgsZUwD3BRPa9IZKkniS+mxKkJjH5EaF6aS3X8QawRNeqfsYMaxdS+lsJCZnOQISck7Pt9Jqp678oinrTp68OFZD4+UPlHVoEXX++mz8221QkxvPUGQtA3V+c2t4P9T1effgxIH17CzDlbwecsSKYGM6R84mXubnXiLa14PGzqlqm6mzeHjDP1ux4c7KHkGsl4BkQcbPLBPTVVKYXdphDarTZDpbyXgOjuPw04r1aWw+zz6r1DzBYQ8UfKK28v2ET7AWWoOdAizbLYMupPrkxL2C2hC3pPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+MD//+Z4QXtybXqYIJ2/i13Zy7vaPxD3cWbgw7MYR4=;
 b=LD56shodlifEBIGcPV5m5r+Bejg6H6rmEOlhEYrmLlspmD2/+1uSH3s6+fkdulU69tqwpjLGJdZV/PrLv3yv2yvEXyNLuAVbIdiOVvqkY84MKaYrTvdUneNKN/0HdgRGFLQ8znCMxOcmLifFNqVCpdRICCSHPXHSPe6oTNffr2gJlpu+lCIMvwix6euJ+gIDLJ8nkEEKP8mv7fSDl5DI4H0K5iZiR1ItYp0wnYUUAoIOgY4je6Eng8fsd7nsb4eRnCFHUeRcnYCYeQvXMjF/mT8wWrMrIAirGkGi7dvElZMNtu3uGQWbexp2zzjZbhSN0Ia5TbTazG9iN4psVYeNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OS3PR01MB6088.jpnprd01.prod.outlook.com (2603:1096:604:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 08:00:00 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e%7]) with mapi id 15.20.3846.029; Fri, 12 Feb 2021
 08:00:00 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
Subject: Re: [cip-dev] 5.10.16 testing failing
Thread-Topic: [cip-dev] 5.10.16 testing failing
Thread-Index: AQHXAMpDMg1lZ64G2U+bjY4j5pGFF6pUJgUg
Date: Fri, 12 Feb 2021 08:00:00 +0000
Message-ID: 
 <OSAPR01MB2385ECE08D45EB01A14D0C84B78B9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210211230418.GA14799@amd>
In-Reply-To: <20210211230418.GA14799@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dbb2724-d1a5-4774-3b81-08d8cf2c327a
x-ms-traffictypediagnostic: OS3PR01MB6088:
x-microsoft-antispam-prvs: 
 <OS3PR01MB6088B7BBC5A55CF66EB67BF0B78B9@OS3PR01MB6088.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 nsaFKM/VliT5s7j+VtMz6GSBmeLdhEvASjtDC5hecvD9z1NuEXWjkBiMnyKMgIZLARoJOaM1jOKKqLfxKwYHSx+jc7MRp+kGdg55hO5n1fE696WRL7K9K4aLEQuRuf6FThjlDV6JZb0sNyeaxKZFvm2mtD9SLkPrRGrDiMZrgvvXIyyQeqLZcYLiTREl3xvb7XHKwswPNaVfiFb+5Pa6tMwkgGt0gcuUPAi9qLR7KJzKj3dU3ITx6a+2rmJDUxINLDbTquzMhFVtWtxe/Kiu8z/hZIpU1wqj4iiYTh6XgHMxS/AmaYr+s3aL6aIdTvdlj/sISuNnJDfWtfkSO6spg5WL8hh7zc/knGOE6jpxYzMJNV606HX37J4mccaf2z7ck6KGy90gYsz0HcUg/wv92SQsg2YdnhLm+YuWvowH93DcDDO2VgiFEQMUph0k9KZ06OKwV1n/XBwnGbLfKU1U5J00J+8DRdgQLbUqqd5aUT3fLXbHBJlSv9bwC8TYtCax/5rvZF9o3fwpE3jlzNt4yMFXSdDsGavLJobgTRcgR/t6uDOsVbD4bz0CT6OAd+pG36C563WXBw652UQ+Pjlm4JJskEf48dMdvwmXT7AJkRQ=
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?FYFXZtX4Ur/SddgJVkOqb7UldrApGS6+/rQ8hI6972Srh+liwEj6ViNb?=
 =?Windows-1252?Q?2jd6mWeNb/lfiZczvcN/zMBu8kUiBL3Va5YITU3b3lHuOPba38gsUgSw?=
 =?Windows-1252?Q?lhKszRzS3BnrOZTf5rK8xbPUH04CqAPU3lsXW61FzOGiCCsSS2OWsM3Z?=
 =?Windows-1252?Q?qLhgUknOkz8BfZBjWDR/pX2aFVOd6xpwd6bWcjzOdmSiMM1jAv/Dc6g+?=
 =?Windows-1252?Q?4QUSpLg0XnRaoaOcCKG0fmQrTsW7pKqCiypnePeDSvpQfUiorQEnI0HQ?=
 =?Windows-1252?Q?PPHwcQS+3ny3Y6WgeQVxp9dHmGlRhXnIXOc7o9/pEw3jCJxb0OEem+qu?=
 =?Windows-1252?Q?AixHtIjSQFtOF/kGSX9f1bdegL5lckWIp1jThT4guN/LO39Ex2IbAgSU?=
 =?Windows-1252?Q?UvJp9suytFu+C5+l+nZXL6P/PN6IwjpLLmnpJdjSD5A+OTOhxGRYd/kL?=
 =?Windows-1252?Q?XmGCklfQoBonI4aKRQ0qepYnr5AuUntgjes/Z309vEX6lDTkc0KlJqPR?=
 =?Windows-1252?Q?KZU3+EehLP/3n7H17yEAasgs9bwhJZK5e2kKO7cJGddayOLWj6LYaHoG?=
 =?Windows-1252?Q?vfc/hur2aEG01G1M5cGk4jeMkR6QRPZOag0/nWkdxLrikCAUnU3H0caT?=
 =?Windows-1252?Q?O/6+VicJ/8vydecX4lfqkYSsWdUlPhUQJ9Y9CVhqDXPWwWLv0ScCZB6G?=
 =?Windows-1252?Q?5vnRbu9REVNhmdO6Huj+Q3lu9zPD9Q+Fn+J9pokHREvKYEjbJAuXLXpl?=
 =?Windows-1252?Q?cChh8SG7foCIeHnvNLsOs2vg/aFeC5MBh4NAr8iLaFlxR7roZEc+Ev8i?=
 =?Windows-1252?Q?uFEIYjHQcFWRQMw2cetTDw8NyZNgUdmeoxDOPHq7kQxSlcWkNen1Ov4s?=
 =?Windows-1252?Q?9ojJb0TArJS/zRKA/oGlG8Mv67A7Cw5jiuL9DU2wH54jVqSKqkzRaRuD?=
 =?Windows-1252?Q?eFo6HoBlpH0lDxWNeYJ2X0XRFR9VZmaYB77NU/TbY+1YDTRdRyuLN51M?=
 =?Windows-1252?Q?J93a5OUjRd0ducb1sqmlqNvjxXBZb/kdIr+jCeEbHFj5mUq5DL5ExjeD?=
 =?Windows-1252?Q?l5/vOTGJx8hfB5RhW8Lf2AYwshGdrPpF9j8CuvGFczy54mf66IaGQdgs?=
 =?Windows-1252?Q?kOL5j2xTF1ygqhilr0K8tboUEKcH1hB3Fcs8VW0xhE2TWhQC6ffJapAY?=
 =?Windows-1252?Q?lISGUMcFGDdWsAzu1UmizpXhYRlrInEh4C0SVh01KrI/GbJ0Qk4he1EP?=
 =?Windows-1252?Q?k2WZyUDLT95GQkA7XO4ppPSuaahBRrljdpIUCb5u1WgT7Hz9ahxh76k7?=
 =?Windows-1252?Q?FvmKKA3CzXhi/8UPWWKOUVm39nGH5bXgt1NNtKhfXNMFyr/M+VSP9kCq?=
 =?Windows-1252?Q?JfkUWzj45qfvc29tchMiaIPiimcBngV+9L7vwEDkVpVecX0b0iWNP24J?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbb2724-d1a5-4774-3b81-08d8cf2c327a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 08:00:00.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8LWSVsufhp0PECRbG3foQeUNNALVWzvJlt8BzMJ2q+XEV7lXfZT8mHwjK3ZtuzzbdnW//nDxVE+CrD+dgxmjgwOdif7Rr54UljSFoifuto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6088
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lmKlNFYILlgt0cpyRCNTMt5Mx4520388AA=
Content-Type: multipart/mixed; boundary="HZpGdWTHwGiNI3q5XaIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613116805;
 bh=NBlv6VWAcgxd6NaZ6bQcyTBCbzxWL4dLx+LoENRyK+I=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=AKGPrO3mT4J/PwUXbHXbGcGT0x4aAm/8Ix8+d1LORK4wg7Iy0Iv2QJkDQz9hSU6dSc7
 NZw9qTb8C0D7JJt8vXGPUndyHKG+Mt3SuEfPDw66M2+dslNZLEKYBRHso6jBmd6+cdds6
 vy5dpiVPu2Z+2n/y28JGwslQjfZs53RU/BU=

--HZpGdWTHwGiNI3q5XaIJ
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 11 February 2021 23:04
>
> Hi!
>
> Latest -stable-rc tests are failing, both for 4.19 and for 5.10.16. I
> resubmitted tests and some succeeded on second try, but most did not.
>
> It does not seem to be real failures, it seems more like network problems=
.

Apologies, but the Renesas lab is offline at the moment. There is a network=
 issue that's out of my hands.
I'm chasing IT...

>
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Fpipelines%2F254936494&amp;data=3D04%7C01%7Cchris.paterson2%40ren
> esas.com%7C6e5fb4cae673408be15108d8cee1641b%7C53d82571da1947e49c
> b4625a166a4a2a%7C0%7C0%7C637486814739404030%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C1000&amp;sdata=3D5ELxhFIWQdxtQjwmQjp%2BNHVvhfHEN3S
> DcC96ZuRyeNw%3D&amp;reserved=3D0
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava.=
c
> iplatform.org%2Fscheduler%2Fjob%2F162225&amp;data=3D04%7C01%7Cchris.
> paterson2%40renesas.com%7C6e5fb4cae673408be15108d8cee1641b%7C53d
> 82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637486814739404030%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DlmNF1w5qyVwr%2FK%2Fi
> D%2BUPj%2FloODljBaf3ohSSSZvquZA%3D&amp;reserved=3D0
> extra keys not allowed @
> data['actions[2]']['test']['definition']['definitions'][0]['repository'][=
'metadata']
> ['version']
> progress=A0 65% (59MB)
> http-download timed out after 895 seconds
> end: 1.3.1 http-download (duration 00:14:55) [common]
> tftp-deploy timed out after 1715 seconds
> end: 1.3 download-retry (duration 00:13:35) [common]

[apologies for the silly safelinks conversions]

Yes it looks like a network issue.
I've resubmitted the job, it seems to have gone through okay now.

>
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava.=
c
> iplatform.org%2Fscheduler%2Fjob%2F162215&amp;data=3D04%7C01%7Cchris.
> paterson2%40renesas.com%7C6e5fb4cae673408be15108d8cee1641b%7C53d
> 82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637486814739404030%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DDb0PbTgsCE%2BpDfFgdffl
> OV8eN%2FKtpxhnPLmbekFf8GM%3D&amp;reserved=3D0
> (does not load logs at all?)

Log doesn't load because the job hasn't been run yet. (Due to the Renesas l=
ab being offline)

Kind regards, Chris

>
> etc...
>
> Best regards,
>=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 =A0=A0=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 =A0=A0 =A0=A0=A0=A0=A0 =A0 =A0=
=A0=A0=A0=A0=A0=A0 =A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HZpGdWTHwGiNI3q5XaIJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6173): https://lists.cip-project.org/g/cip-dev/message=
/6173
Mute This Topic: https://lists.cip-project.org/mt/80571344/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HZpGdWTHwGiNI3q5XaIJ--
