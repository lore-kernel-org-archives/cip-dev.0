Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B673C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 09:41:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.8719.1639647663434531024
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 01:41:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1BG9f18L015521;
 Thu, 16 Dec 2021 18:41:01 +0900
X-Iguazu-Qid: 2wHH6YFlYNkjf7ata1
X-Iguazu-QSIG: v=2; s=0; t=1639647660; q=2wHH6YFlYNkjf7ata1;
 m=DpoGJkbCvrZbIE+e1RHnwtfEoUX2tlNGsGUBcNdh4FM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 1BG9exOW008945
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Dec 2021 18:41:00 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 7CA7E1003B6
	for <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 18:40:59 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1BG9exwW022838
	for <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 18:40:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b32IRbGZiwP4xxpDBiKIxrzSXuOKsetiMmu1OGk10pB2X75H4LzT+YLerJI89k7Yn9/yOL88QgjyBkbKanmoOxDknRBgPjMLcxKlzQxehJM1bo/ZCDE1nf+f9bsddruZ7cXQjtLBxyKw0H71NDE30isyOftiLyEXH9SPMk+Lk6N5T/3dIsTYumfkJFFX+ExmnGfKhmZ4cDdUq3/n7VFCCrDQBb3izN+st0K6kl/HbMlHp4Orbk8WTUnZsRvrpufUWUzXv7XkDP9HuKolyHFsrOFU+j60dc83JvvhNgPXDU5PCOgPDWgWRt2ks9+y13O5+sA5GpzzZ0qGKM3CqKU4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7No0chu2PaQMW6R+58yw/eYG1hgSfgYT/cBDWCTdmU=;
 b=DgxREN8yoZV13mDGF53sCUWbmDkOqBxv414+ojlakq0juEaBsUpHDQhiq+kI2iu6rMaCyxFWC00xiZloaNeJYks9W0zGAXNRt7VeJbC/rpif1QwsFLRzK5geJk7rWHi0pC6R1fBJ9scXSdkPqSOciGqn+XmSiDEvLp1vBJIcw8urQ1SMiFDOsiZexP1Gnp93or20yLeexgPGeopGqY+WhjT/pDLk5GwO4ZBs5cHVjGtWsvxviZ92jyvEPRBjruC/wy15qNChZQJEz2B4Hr91wzUbqahO+AK8pvEaB7b3/2gP6ohLYKoislS5yRRWKuXV3jJGD5eCofNDUiPzAblx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHX8lBMb0vrZLl01UqQfvCIWtMbE6w02h08
Date: Thu, 16 Dec 2021 09:40:57 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62528534A615733501A65B1D92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <af9221a1-1821-7ba1-a337-8220cf9b29d8@siemens.com>
In-Reply-To: <af9221a1-1821-7ba1-a337-8220cf9b29d8@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 5475782c-a9e5-b452-caf5-8d6976de6ccf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f836195e-3a02-46fa-6391-08d9c0782991
x-ms-traffictypediagnostic: TYAPR01MB4159:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB4159AB67725F44710B62EEB792779@TYAPR01MB4159.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ns0ld8CR4MvQIbtNQqnJbW9f7hrZXulo6ddLVYDCsxsPtABIDuPFpDX+YZanWauMPKn8yydunLxp+vn9hXmOqZ8cflkp2xQEnwciu9Cw5AJaS/2RbCY20DUbJzrJzyXuQy3AKHkcoL6GyYOznAhQQ4ycUUndnhsU2ecC5cHK7kDeJHGI+nOJ+qBcBMKoY3LM0hPuKeoPrdw14JlcLn/Y0LHip7bor66UQJFF9zX5sBHgHjDW/NqIujJlzFZUxpRWtHIMJay84HO/aqLJdSA8G2zNgWInh90OI1miPxtYsyONXBO0EDzJMl2Ms5aN/xC+1jKcjxkQAP1THfZ/rxX5bHpQIgp7L8BPhWeEZDglu5rYtGHdA/OXXU+XA85jrcboM8czMCV7cg0V/9K+AKOQSuhx/A0CXj/4pxsCjgxpB2lLZ8gWlMGxZGQS0A7NqidkwAwGC0oDrEdIbfNpf9IFmONF8uWPBde01IQyx+oSBNZzHjNsWAynDZwVk5zU0cgMpjSoDqfibVv2kAy8/Ovt6mev8nUzsICL3iN+iOhULh3jGjVvLgrt7v5jJW8R+O+CTr2OD5uVkCuCmnCw3yO05ckKIURrXaK9FWmTBzdJyR4SbNHe8K34kU38AWKzO8hxoEu4CDIoDlQdzwJcdeppbhAM0ENp0rm2gRxFSWY/Ta2Yvb8sJnsJEmhGdTVo9vHY4laT8m/d5ebADgkah/C1RjbXEQ5RtcZFZwfycIRAHfW9vxWzJi6pxQR/Kuw33dNGDFJvjtzf2PE5eA4DfAWROQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55236004)(86362001)(38070700005)(508600001)(6506007)(26005)(6916009)(76116006)(66446008)(66556008)(8936002)(122000001)(71200400001)(66946007)(55016003)(52536014)(64756008)(186003)(66476007)(38100700002)(8676002)(7696005)(9686003)(316002)(33656002)(2906002)(5660300002)(966005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TzBHMEkrVFpUc2VjWnhxeDA1TkJrVzNaSCtBY0FDdEN0d1dmYXY3Y052?=
 =?iso-2022-jp?B?OXdRd3phNHFsT0lDZzNTdTBIT2s2cEMzRFdKbFEzL3B3VUcvNVIzWVBS?=
 =?iso-2022-jp?B?UTVCSkV2R21CQllsRUF5bXJleXgxb3BLMmdwUkN6Yy96UW01cENVVlcw?=
 =?iso-2022-jp?B?czlvcUF2NWF2eTF2YUNwby9FN3BGb1lpVUtoWldDNTlLWHRNajdzNDRG?=
 =?iso-2022-jp?B?d3cwcDFwSzlpNm9ZRHhlS1JvNEZRMDVVU2lCTkwvekU0NTBsVE4wbFRK?=
 =?iso-2022-jp?B?ZW1VTytQakRRSUdPbFZTaW5zSUFaZElIMWpmdnU5UW4rMm9XZVZzS1Ni?=
 =?iso-2022-jp?B?TUJleHdrcHhVTGxHQUF5NjdiOUI1alJzNGIreFg1RkFlQjIwYUVkVTdo?=
 =?iso-2022-jp?B?cjZKRnZpZGo1RTUvaXNvblIyejJnN1RHK2NSTUV3RnVBUm52YzhIWkln?=
 =?iso-2022-jp?B?YWthcTZTVWNUK05NQVBRaEJYQVJuRG1TdExGWVlQem1xSTFaaHh5YXdr?=
 =?iso-2022-jp?B?ZDlMMnE5eXVhVWFDcEFVUmtEK0xyNHJXTTVkbFJleGY1VW04UVg5WW9B?=
 =?iso-2022-jp?B?Zkw4WGlvWGVUNlFFU0ZoWWwySVhNN0hVRmlpZmp1ZlpDZGludmNXTkpB?=
 =?iso-2022-jp?B?NTczV0VONE5PbncrNlZrSW9uZks1cVdRdjc4V1o3ekREcDJNNnNVaWxL?=
 =?iso-2022-jp?B?NDVFeTYvd3RyaVFzRXAxY29WUWQ2Nk9vREpiOFJNeXdNZFBFQkZaS2Fk?=
 =?iso-2022-jp?B?WUZWYlNpVHAxdFZTR1JEcDk4OG1lWUpGK1FkazlITVUwOFNXR0dOZHJC?=
 =?iso-2022-jp?B?NDJiUnJhZzAzMGh0UDRXQ1lBSmxmY2RpMk5vUjA0V1FyL09uVHJGT0Vh?=
 =?iso-2022-jp?B?MlJxWmplQURSVjdwR0FPZnZqUkhCVEdnUWV0dG9qZ01wenY0dlNIYTYr?=
 =?iso-2022-jp?B?aGdhdHJlQzNSNXpUREVVSmlFK1FYeFEzN04rbGpPVktZL3A3K2ZTU0ZW?=
 =?iso-2022-jp?B?WkxpbXNQUi9IL2FMK05aM3FoTUVYQi9YRVZmcXBkOUdtdHA5UHNKZjFC?=
 =?iso-2022-jp?B?TkI2R20zekZwOFFhQVFjclNxbWJaVytLd2FYQlZ0eEh5QWFrTThoNm55?=
 =?iso-2022-jp?B?d3Y1ZEhSQWtENWdwdi9yQ0k3UFNvNnhqNVlZa21WZnUrc3A1ZlJaM05E?=
 =?iso-2022-jp?B?eERsUjcvelBVWEdIN2x2bmxhbWwvRGVwK2k0ZDBuWENDalRDY3VuazQz?=
 =?iso-2022-jp?B?d29jQVRSTzhkVHJIeEtwU2dUT2hWVVpOVFRSYkJPMzNpWFhnRm1VeWtL?=
 =?iso-2022-jp?B?ZGcyZkp1SUtoeUc0TGhnb0w1VXBQNTJTK0N4a2ZVQmpZMm1xcVdTS0pj?=
 =?iso-2022-jp?B?blh1ckpvOS9VQ3VwSWk0YUtoeDNYYnA3QXhSTWZmSTg3V2h2S004Sk4v?=
 =?iso-2022-jp?B?RHJyL0ZhV0FLR0Nod1RsbjRreVZIQ2JPTFZOUHdtYkJTU3FLNG1ibEdU?=
 =?iso-2022-jp?B?UGZ6ZDZOTGxWVU1OREZ6MjB2M2poNGZXRzE0TjRPdFA5Y2w3ZXcyQkRI?=
 =?iso-2022-jp?B?anQ4TnoyVFBYMXQzamVjUnFVanN6MUczbzIwZkY4Rzh5U2poa0RYczVE?=
 =?iso-2022-jp?B?cXM0UEt2VHpycktPbkxlSHJLOU1QOVVRL1pwVnV3Qkc3S2oyR29UdTJG?=
 =?iso-2022-jp?B?WmZXN0NrQndyazg0Q2ZDaU1QOTFRTDBTWEU2cm0vUTVzNkxyRFlMSzNW?=
 =?iso-2022-jp?B?OWh0MXpVZGZXTEdGd05uQ05nTkx0M1ZkbWlGaVNvUTBqVWxUQUpwMEsy?=
 =?iso-2022-jp?B?MlZ2YlNyYUFNdUVEMThxUmw4L1ZWbFZyOElhTW5icVkrUm03YmJtNThX?=
 =?iso-2022-jp?B?VzNtRG95MmNTWFlaanB6bmE2ZU9EN2hnVmxMQUJ3bDk1Rm1XMzcvZldH?=
 =?iso-2022-jp?B?Yk9kaThLLzFMMDFNQVRnMkx6REVhR0pGTnBISzF5MUdXejIrandtNnVi?=
 =?iso-2022-jp?B?NEI4M0RrNkNUNnR6MGFIL28xdFA0MnFSeGlQdEIrb2s1U0krWngwTjRm?=
 =?iso-2022-jp?B?ZnJpRm50S0FqeFJPRVB5UlJ6L3FFVlN3L013WGJtK2hGZlBBNC9pdmhU?=
 =?iso-2022-jp?B?WnJRVVVGMjdyRzdHYTdWc00zamdSYXpOVGU2YkFqejY5T0c3Qkt2RlVG?=
 =?iso-2022-jp?B?ZjZ3Vk9qN0ZFUlNpQUlvTWFsQTkvNURpV0lRWmlBb0pvWXd1UkswMW1R?=
 =?iso-2022-jp?B?MDRYK3N2U2VvU2pTSTJ1dysyRGtYakJxbFZzUnlNRWJiN2ZEamdMNXFw?=
 =?iso-2022-jp?B?VDFPa3d5R3FwczVrMDFDcU9NOFIyZWxMMzNOdVZGUmIxSEFRS1lsNmhq?=
 =?iso-2022-jp?B?eXE4NTN4UFc0YnExSzlndEtvVU4xTGpJOGJ5eEptZzdIZE1lNXJVTVlD?=
 =?iso-2022-jp?B?RlJ2T3J1SEhTRi9ldWJQUTdrOGQxYVNSb28yNUJrcjBmdzVocE9Gd0dD?=
 =?iso-2022-jp?B?T1o1ZFp3?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f836195e-3a02-46fa-6391-08d9c0782991
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 09:40:57.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 IFYBbWToOVAwkZXw1gqUS7SQ6FO/HB7OJgscEofNZW7lr9HGHUqUDgzcs5VPZZHD46QiOSpECyau7y5ScdUs2pTsgAmYLSr8290YXcSgaHThlN2iTBq9aUh90qpNHKzO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4159
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 09:41:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7119

Hi Jan,=0A=
=0A=
I may not be able to attend today for personal reason.=0A=
So, I'll email my work this week.=0A=
=0A=
> * Kernel maintenance updates=0A=
* I released v4.19.220-cip63 and v4.4.294-cip66=0A=
* I reviewed 5.10.85.=0A=
* I reviewed patches for Renesas RZ/G2L SoC.=0A=
* I am working the systematization of patch reviews. It hasn't worked=0A=
  completely yet, but I think I can report the completion tomorrow. =0A=
=0A=
Best regards,=0A=
  Nobuhiro =0A=
=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: cip-dev@lists.cip-project.org <cip-dev@lists.cip-projec=
t.org> =1B$B$,=1B(B Jan Kiszka <jan.kiszka@siemens.com> =1B$B$NBeM}$GAw?.=
=1B(B=0A=
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B16=1B$BF|=1B(B 16:40=0A=
=1B$B08@h=1B(B: cip-dev=0A=
=1B$B7oL>=1B(B: [cip-dev] CIP IRC weekly meeting today on libera.chat=0A=
=0A=
Hi all,=0A=
=0A=
Kindly be reminded to attend the weekly meeting through IRC to discuss=0A=
technical topics with CIP kernel today. Our channel is the following:=0A=
=0A=
    irc:irc.libera.chat:6667/cip=0A=
=0A=
The IRC meeting is scheduled to UTC (GMT) 13:00:=0A=
=0A=
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D12&day=3D16&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248=0A=
=0A=
USWest    USEast    UK        DE        TW        JP=0A=
06:00     09:00     13:00     14:00     21:00     22:00=0A=
=0A=
Last meeting minutes:=0A=
=0A=
https://irclogs.baserock.org/meetings/cip/2021/12/cip.2021-12-09-13.01.log.=
html=0A=
=0A=
* Action item=0A=
  1. Combine root filesystem with kselftest binary (finishing) - alicef=0A=
  2. Propose tweet on KernelCI-CIP collaboration progress - alicef=0A=
  3. Clarify with KernelCI whether CIP maintainers can get accounts - alice=
f=0A=
* Kernel maintenance updates=0A=
* Kernel testing=0A=
* AOB=0A=
=0A=
Jan=0A=
=0A=


