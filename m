Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58478C43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 09:03:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.24623.1654851824858426130
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jun 2022 02:03:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 25A93FoS031501;
 Fri, 10 Jun 2022 18:03:15 +0900
X-Iguazu-Qid: 2wHHu6IppCcEnn08pN
X-Iguazu-QSIG: v=2; s=0; t=1654851795; q=2wHHu6IppCcEnn08pN;
 m=AhzgiGdShzTMkoOc2r8+X7MSXCZ796f/VVn+rK8ixJY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 25A93Cm5031444
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 Jun 2022 18:03:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiJ5GV3yujIwoYYoMAobRhCg85PpstEF8VHMm8VZg/Xouqwh7qPc3oTkBNpzpthgxfKglCBE3ejAxIN5Q/HLWG0Tc2oV4lms57YQE/7nKr8PXcrHzOrfxnAjBSsdKGxUGKNviyF+yMG8amdZg6i/TjkTc7X5eJrVERe9K5MsbgNYJm25CJ2wMDWEGM4S5em+JFIma67+x1xSOqEYv2rNDNPhCqAIEkX2a73qAD6wifdG7zVtnQIKuQTzePaxjzf5KOIQYyQd2pAg0e93HQZGVJJiTSLap2w/Z6t3xoKARQw1g7ZLElhnuKnsN4XYrGdGfiLObsRuyduBWhMdBIHUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RdgFkbi19F11At0jG9QGgeRIZRSzxVAyeMMVTFeVFY=;
 b=LMs9KeXuUon+KKVzwg2acHclg0QUb2g2vId7hPrF6kYCB6XFDaOIyqLPUhrK8jP/yjRjn7MeTZBmRm+lM0n7sQ2VaewZU6sLwpafpg102QlDCA2395Y5ZQC8AtGzRjD56j/v+PmXn+lNMpJWpq+OjbTWPDIXCHMR0ae8cqqh1dyIE4q0YXSKHmaWGjTn5B7sgwRdB5hacSPxgCEl7JzbQLTCSvMILePtjrOY9O9+9lk+meUw4Y1YAjlPPG7VW5doognpD4ZpHo76QJ4+hXqWSrpXRINFyvHLCl0cgzKIxnXczhCcreyEOxJ7ooXk0B0ZhQ4WKj4CuUpExCopbG8Q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.246-cip75 and v5.10.121-cip9
Thread-Topic: [ANNOUNCE] Release v4.19.246-cip75 and v5.10.121-cip9
Thread-Index: Adh8qD6R+qprr+Y8SO2/Do+Cob7Nzg==
Date: Fri, 10 Jun 2022 09:03:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420FCB78666232E4720106592A69@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff3e3e7c-9d31-4752-e721-08da4ac00ace
x-ms-traffictypediagnostic: TYCPR01MB10310:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB103105CA559A42B9E7230141C92A69@TYCPR01MB10310.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 W+XnkhnyaJnneX1DHBiazoEgTdyiXotRNk8eBjjrn7Yk50HFR2iTl+TEuLNzG5qfcCa4W/5F6OstGi8aFaOdJPsUf0NhBkvkQvMof8yLkieJe76kJ5XbJ5kxYG+DlT5Y6WoEE81JQK5mG8yiHHYbvAW3HQDTrhD+872+rU0+cqJkOZ4xXjp/bq+QeEc/q9CLDiO50Vm8Va6GmktqWMPgqq3ATNfdqKASCuBAA0uHBm8FCtBkxGDMrWHjBrxbogjlEs12C5ppAS7G1gs1qPe/OnMplUYf5heGaG7y7ThC0TdoCwPvR5eNfRgrDQE7Lg4irl+iCHgaP8T3N0Qe78WwVDP7Poj5u5IYdOkOGa0QgPzjm3atbl6KOrOLcB8cGcQgxCJAgV3/iKqMF7TauaQhB4cs2bUCFUqwDv2DGSmE0bB9mO188ojaVDwqFmhXFcrI7am/g1pZVcmSEHCoK4KKUzC7UE1b7gx81b9fVb826tXqf7aMwCIGdn/wJcMRkFOwD7i0MfI4cMY1gJLzvbrrxyboqKJFYIt6xS7+I9fv6ulD4RLvDdCdXQKnJ0Yl/IZOvowAr6qdyH6Mu9/V51ENwnUkIdmGfgdJhM5+6PwAVSW9oV2NCt1wQ63V/wL+2FguZCSFDjYPBAmH0XqmI/iBTdX0iaoPQ44tcV9OwmX0rlhqvESvgDJca0dUDm8oteuykCGsnN+CfxWa+K+5bEdTbrOANSR0N2yC+1mb8xCtu84gKhD6yqCLJrvVPB6CldEUgWdqibAzAUsmaCoVuG4hAiy5ZSZvcpK1gbkDVWLrszA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(4326008)(52536014)(26005)(508600001)(5660300002)(38070700005)(8936002)(9686003)(33656002)(7696005)(71200400001)(38100700002)(966005)(6506007)(55016003)(55236004)(316002)(186003)(83380400001)(6916009)(76116006)(86362001)(122000001)(2906002)(66446008)(8676002)(66556008)(64756008)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OGFhY01QVHE2c0EzbkZTMFpMZVhhTUVROUd4N2krVk4vaXFsTWcwM1No?=
 =?iso-2022-jp?B?YXZuVTgwSTdZT3BIaFlKZmtpSU9vMXlpaFhCSGthSHdvaXJjMVVGbWYr?=
 =?iso-2022-jp?B?MEJUNVNrTXNNczkrY0w5RXZZdldtMFpDYVE0aVlKZmROeGswVy9TWEJ6?=
 =?iso-2022-jp?B?Wk9yVW1oTFNTeWY0RkRQZ3pNd2FWeEJmZVlGelNnS3lxRTNEdVZBSjBG?=
 =?iso-2022-jp?B?aVd3QiswMWppMUJuTjBhQlFrMkVhS0FsaVNWRXlOZWRLOEtITHcwQlpX?=
 =?iso-2022-jp?B?OTNjczh4cWlybllySVNsWXYvTk9jNnhJRWxLU3JNSFJKYTk1YkhKMHRL?=
 =?iso-2022-jp?B?QWNTRmY4VTFEUmdqMitFajZnL2dYQ1VPRVc0MFpWOW9ic2NRSGtKK2VL?=
 =?iso-2022-jp?B?anNrdkxqYmR4UjVlNXpYUmpTcTBnSlJ0TFB5NW5KQk8wbHRQUjFjK0kr?=
 =?iso-2022-jp?B?bE50YnZWUjk1UC90cVMzVW1jMHJTZjlObjVwMlpqMGFBalVpR0V3Y3FI?=
 =?iso-2022-jp?B?VTFHYzdnNlRZYlhUdE16SU9LU3YyL2tnOUFUWmtLTTJ6ai9RVGpGSUVM?=
 =?iso-2022-jp?B?Vnp1UkEzTXpUQ2Q2d2FVaUYvZEFWR1p5UkNMSC9ZaTZKaFdMUEVCYWRs?=
 =?iso-2022-jp?B?VmovZ2FtOVVmTzg3TEhheXE5QkhHRkd4LzVrVHdjTk91N3BxZlU5ZW5S?=
 =?iso-2022-jp?B?TDJiVWRpUWZUbElkalFxT2FYakxMb0Z5UVRwalA1RDNvZHpESFA2bm15?=
 =?iso-2022-jp?B?RmhWU2JJVHhQb0ZDajNNOVlTTG9QcitNM3J0YjkwNXR3SUhzNjN1UmFr?=
 =?iso-2022-jp?B?WFNPVjEzVTVmOEorMks2WDlKK2RxRlNwU1FVaUkweDhmSUtPUmF5TnBV?=
 =?iso-2022-jp?B?TXBnb29pelRMb3RabFgyMUV2czVTbk8wSHZIYk11Rmh0UmVkOElsQzJS?=
 =?iso-2022-jp?B?TjkyaVhzdVN2MW53RjBUWTM1UTJUTmZ3Y2UxMmNiMFg2YTRjdjc5UVBl?=
 =?iso-2022-jp?B?aHh4dmxuZFVlSXBDRWRXQlVHYy9rc2hTWkZRSis3LzVzbXFVRDV1bS84?=
 =?iso-2022-jp?B?QllFSytwVE9ObHVKQWFYUGVVMmNGYmlWUldCL2ZmZlFVbnhOTUhGbDBN?=
 =?iso-2022-jp?B?VGdPUWppYXZxbmtnTzhVQnhIOVd1U2dTZWo4OGZiUERhQzFpQkQxRlhO?=
 =?iso-2022-jp?B?c0xXNUhoNyttem5FM0FFRkc5eFlFVWt3bGh1Mk85aFFjZ1dpYmFwdGEy?=
 =?iso-2022-jp?B?a0NoVVJ2d0dVL0c1WW4wMFAzL2ZnK2hCK3pIUUY2RkR5MEtEdnplT283?=
 =?iso-2022-jp?B?RlJieHJCTjF2OU5DZUFuTU14WWdlMzBIY3JuNVVQRE5MeXZGREYyeURX?=
 =?iso-2022-jp?B?dklkWjR4eEh4RVkxNTRCWDJ0R1NLM2RtUGxFNTJnZDN2bk9tM1daekNs?=
 =?iso-2022-jp?B?MUdKeWgwdG94M0Z2V3FPRGxybGNldXE2SU1DbFc4dFZMUmxQVThZeStP?=
 =?iso-2022-jp?B?bGVraHJ2aldZNGg3Y2ZXRDAvOUVqQ1JCa2lzZWhCOVdlS3ZZVEYxTWlL?=
 =?iso-2022-jp?B?Y0Z4ekh3cjNEL2ZkZ0Uzb1JqVlhRdFhCYUxFNTFIUVNaUnNwWnVtbkZY?=
 =?iso-2022-jp?B?RUNqb01DRURsdWVKUG1Jd2cyRFJqbDY4M3prWGtCc3N3bms4ay9JZWFW?=
 =?iso-2022-jp?B?QzQyTVprZWFXa0o2d05jS2Zrb2FQTGhRZmlTSFRMSlFJV3hTcVVlZkpq?=
 =?iso-2022-jp?B?QWRSeFM5ZUNPQzA0b0tRVlpKb1d6SjR3K0Exd0JDVmlkY3UvVnJMbFIx?=
 =?iso-2022-jp?B?YUlHaU5LTDZORFg2b0kvdTlqUmdiWWRtOTNPbmhmUjF5QktJclo1dG0y?=
 =?iso-2022-jp?B?b3gvQ3c0UVZ6S0tNSE92THJRRHh2KzVIMTFpYlR2VHM5R2RjM09SckFo?=
 =?iso-2022-jp?B?dTZjYXhaSnV4V0kzcjRadnoxdm4zY3VqOVViWWFySGlkeENEZnlNY0xp?=
 =?iso-2022-jp?B?eUtPYkJmaGZLL250UlVBQjdnVHRFclR3ZWhQNUIxb0huUHcxMTVKREpR?=
 =?iso-2022-jp?B?SkNTS1RGcHpJQk41WUN4RVlNZDdzNjRQMWZtdm5VUDF6cDlSMExzMW5Q?=
 =?iso-2022-jp?B?YnZKa3htTG1lb0NlWUVGRkdiWHJYaUtCSUNSeUJKaE1kYnhBLzk4ZGJ3?=
 =?iso-2022-jp?B?SGxGVm9mbVJoc0tqOEcxb09sYVRGcmNaOTd5TUp3bE0zbWsvaTB4dnl2?=
 =?iso-2022-jp?B?RU5UOFdCbjJTOFhyZGpuNWp3bXhTcmt6aVhEWjZtQm9FZWJ6UTRsT25v?=
 =?iso-2022-jp?B?YU1OU3JnRXlZbnJ3MnRZblBlc041N0RrbUd0RSs0VTVLMmt3eUp3ajNX?=
 =?iso-2022-jp?B?bjdIYy8zQ2x2a0VjditEK0cxV3A4amN3VTRoK3VDRFV4ZitqbWZSaDgz?=
 =?iso-2022-jp?B?ZUc2aVZBV2JDb1ErY1ozWElQcXFtVTN0YVpGTlBhS0E0dFhVSWZ6TnJo?=
 =?iso-2022-jp?B?ZWpmeVhySDMwOUtzbEdmalBHZ3dORzVwWTNxNjQzd0ZJdC8rUnc1SkVE?=
 =?iso-2022-jp?B?Y2xOTmJKbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ff3e3e7c-9d31-4752-e721-08da4ac00ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:03:10.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 int1TEHuNwcAbPI/AXehRRCaj048o97gvTjnIbRIibAp/qLg+fpCyEkX3fQUntUBT8y2ES1eKCnpKtwtm9MjZJKTajB6lnUFTsyNYmn2iYgirDQB4VVxeYARTLECOfpS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10310
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 09:03:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8527

Hi,

CIP kernel team has released Linux kernel v4.19.246-cip75 and v5.10.121-cip=
9.
The linux-4.19.y-cip tree has been updated base version from v4.19.245 to v=
4.19.246, and the linux-5.10.y-cip tree has been updated base version from
v5.10.118 to v5.10.121.

You can get this release via the git tree at:

  v4.19.246-cip75:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      38ce181ac6ca9f3decdd389cbfd0a38fecdb28c7
    Fixed CVEs:
    - CVE-2022-0494: block-map: add __GFP_ZERO flag for alloc_page in funct=
ion bio_copy_kern
    - CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port of=
fset calculation
    added commits:
      CIP: Bump version suffix to -cip75 after merge from stable

  v5.10.121-cip9:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      bd24696dd7ad23517733728da675a00cd3073916
    Fixed CVEs:
    - CVE-2022-1789: KVM: x86/mmu: fix NULL pointer dereference on guest IN=
VPCID
    - CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port of=
fset calculation
    - CVE-2022-1852: KVM: x86: avoid calling x86 emulator without a decoded=
 instruction
    - CVE-2022-1972: netfilter: nf_tables: sanitize nft_set_desc_concat_par=
se()
    - CVE-2022-1966: netfilter: nf_tables: disallow non-stateful expression=
 in sets earlier
    added commits:
      CIP: Bump version suffix to -cip9 after merge from stable

Best regards,
  Nobuhiro


